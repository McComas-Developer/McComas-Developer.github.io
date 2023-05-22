import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class UrlError extends StatefulWidget {
  final String url;

  const UrlError({required this.url, super.key});

  @override
  State<StatefulWidget> createState() => UrlErrorState();
}

class UrlErrorState extends State<UrlError> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 18),
                children: [
                  const TextSpan(text: "The pathway "),
                  TextSpan(
                      text: widget.url,
                      style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  const TextSpan(text: " does not exist"),
                ])
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty
                    .resolveWith((states) => Colors.red[700])
                ),
                onPressed: () => context.go("/feed"),
                child: const Text(
                    "Return to feed", style: TextStyle(color: Colors.white)
                ))
          ]),
    );
  }
}