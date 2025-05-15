import 'package:flutter/material.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/crypto.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MetaMaskLoginPage extends StatefulWidget {
  @override
  _MetaMaskLoginPageState createState() => _MetaMaskLoginPageState();
}

class _MetaMaskLoginPageState extends State<MetaMaskLoginPage> {
  late WalletConnect connector;
  SessionStatus? _session;
  String? _signature;
  String _message = "Login with MetaMask to authenticate";

  @override
  void initState() {
    super.initState();

    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'Flutter DApp',
        description: 'DApp for authentication',
        url: 'https://yourdapp.com',
        icons: [
          'https://yourdapp.com/icon.png'
        ],
      ),
    );

    connector.on('connect', (session) {
      setState(() {
        _session = session as SessionStatus;
      });
    });

    connector.on('disconnect', (session) {
      setState(() {
        _session = null;
        _signature = null;
      });
    });
  }

  Future<void> _loginWithMetaMask() async {
    if (!connector.connected) {
      final session = await connector.createSession(
        chainId: 1,
        onDisplayUri: (uri) {
          print("WalletConnect URI: $uri");
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text("Scan with MetaMask"),
              content: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: QrImageView(
                    data: uri,
                    version: QrVersions.auto,
                    size: 180.0,
                    gapless: false,
                    errorStateBuilder: (context, error) {
                      return Text('Could not generate QR: $error');
                    },
                  ),
                ),
              ),
            ),
          );
        },
      );

      setState(() {
        _session = session;
      });
    }

    final address = _session!.accounts[0];
    final messageBytes = utf8.encode(_message);
    final msgHex = bytesToHex(messageBytes, include0x: true);

    final signature = await connector.sendCustomRequest(
      method: 'personal_sign',
      params: [msgHex, address],
    );

    setState(() {
      _signature = signature;
    });

    print("Wallet address: $address");
    print("Signature: $signature");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MetaMask Login')),
      body: Center(
        child: _session == null
            ? ElevatedButton(
          onPressed: _loginWithMetaMask,
          child: Text('Connect with MetaMask'),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Connected: ${_session!.accounts[0]}'),
            if (_signature != null)
              SelectableText('Signature: $_signature'),
            ElevatedButton(
              onPressed: () {
                connector.killSession();
              },
              child: Text('Disconnect'),
            ),
          ],
        ),
      ),
    );
  }
}