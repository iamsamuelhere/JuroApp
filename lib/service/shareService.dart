 
 
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
 
 
 
  onShare(BuildContext context,String title, String url)async {
    
   await Share.share(
      url,
      subject: title     
    );
  }
