import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import '../helper/helper_index.dart';
import '../widgets/horizontal_spacer.dart';
import '../widgets/primary_button.dart';
import '../widgets/vertical_spacer.dart';

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15.w),
              height: 102.h,
              width: 375.w,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black.withOpacity(0.1),
                    width: 1.h,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SvgPicture.asset(
                        Utils.assets('images/back_icon.svg'),
                      ),
                    ),
                  ),
                  Text(
                    "Send Money",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                    height: 24.h,
                  ),
                ],
              ),
            ),
            const VerticalSpacer(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xFFF3F4F5),
                        radius: 30.w,
                        child: Center(
                          child: Text(
                            "Y",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                        ),
                      ),
                      const HorizontalSpacer(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Yara Khalil",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF1A1A1A),
                            ),
                          ),
                          const VerticalSpacer(height: 1),
                          Text(
                            "yara_khalil@gmail.com",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF1A1A1A).withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const VerticalSpacer(height: 32),
                  Text(
                    "Payment Amount",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const VerticalSpacer(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: "Enter amount",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1A1A1A).withOpacity(0.2494),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: const Color(0xFF1A1A1A).withOpacity(0.1),
                          width: 1.sp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.sp,
                        ),
                      ),
                    ),
                  ),
                  const VerticalSpacer(height: 32),
                  Text(
                    "Payment None",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  const VerticalSpacer(height: 8),
                  TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                    minLines: 8,
                    maxLines: 8,
                    cursorColor: Theme.of(context).colorScheme.secondary,
                    decoration: InputDecoration(
                      hintText: "Add payment note",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF1A1A1A).withOpacity(0.2494),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: const Color(0xFF1A1A1A).withOpacity(0.1),
                          width: 1.sp,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.w),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary,
                          width: 1.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 81.h,
        width: 375.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.w),
            topRight: Radius.circular(20.w),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              offset: const Offset(0, -10),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: InkWell(
            onTap: () => _showConfimrationDialog(context),
            child: Container(
              height: 49.h,
              width: 345.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.w),
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 21.w,
                    height: 21.h,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: SvgPicture.asset(
                        Utils.assets('mages/send_icon.svg'),
                      ),
                    ),
                  ),
                  const HorizontalSpacer(width: 4),
                  Text(
                    "Send Payment",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showConfimrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: SizedBox(
          height: 430.h,
          width: 327.w,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
            ),
            child: Column(
              children: [
                const VerticalSpacer(height: 40),
                SizedBox(
                  width: 240.w,
                  height: 180.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: SvgPicture.asset(
                        Utils.assets('images/sent_illustration.svg')),
                  ),
                ),
                const VerticalSpacer(height: 35),
                Text(
                  "The amount has been sent successfully!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                const VerticalSpacer(height: 40),
                const PrimaryButton(text: "Ok, Thanks")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
