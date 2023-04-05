import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cashier_app/views/components/snackbar.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SnackbarOrder extends StatefulWidget {
  final Stream<bool>? stream;
  final primaryMessage, secondaryMessage, hyperlinkText;
  Function()? onTap;
  SnackbarOrder(
      {Key? key,
      this.stream,
      this.primaryMessage,
      this.secondaryMessage,
      this.hyperlinkText,
      this.onTap})
      : super(key: key);

  @override
  _SnackbarOrderState createState() => _SnackbarOrderState();
}

class _SnackbarOrderState extends State<SnackbarOrder> with TickerProviderStateMixin {
  // final bill = Get.find<BillDetailController>();
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 400));

    widget.stream!.listen((event) {
      if (event) {
        setState(() {
          _showSnackbar();
        });
      } else {
        setState(() {
          if (_animationController.isCompleted) {
            _animationController.reverse();
          }
        });
      }
      // switch (event) {
      //   case BillCurrentTrack.PICK_UP:
      //     primaryMsg = widget.primaryMessage;
      //     secondaryMsg = widget.secondaryMessage;
      //     break;
      //   default:
      //     primaryMsg = "Kurir dalam perjalanan";
      //     secondaryMsg = "<1Km";
      //     break;
      // }
      // setState(() {
      //   _showSnackbar();
      // });
      // }
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  //* Edit ketika shipping service telah selesai dibuat
  //* Snackbar khusus untuk menginformasikan status pengiriman
  //* Tambahkan widget untuk menuju ke page pengiriman produk

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SlideTransition(
          position:
              Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(_animationController),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: SnackbarTemplate(
                primaryMsg: widget.primaryMessage,
                secondaryMsg: widget.secondaryMessage,
                hyperlinkText: widget.hyperlinkText,
                onTap: widget.onTap,
                icon: Icons.near_me),
          ),
        ),
      ),
    );
  }

  void _showSnackbar() {
    if (_animationController.isCompleted) {
      _animationController.reverse();
      Future.delayed(Duration(milliseconds: 500), () {
        _animationController.forward();
      });
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        _animationController.forward();
      });
    }
  }
}
