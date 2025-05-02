import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomListTile extends StatelessWidget {
  final bool isCollapsed;
  final IconData icon;
  final String title;
  final IconData? doHaveMoreOptions;
  final int infoCount;



  const CustomListTile({
    super.key,
    required this.isCollapsed,
    required this.icon,
    required this.title,
    this.doHaveMoreOptions,
    required this.infoCount,
  });

  @override
  Widget build(BuildContext context) {
  TextStyle styleTitulo = GoogleFonts.ubuntu(fontSize: 24,  fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle styleSubTitulo = GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w500, color:Colors.white);
  TextStyle styleDetalle = GoogleFonts.ubuntu(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.white);

    return InkWell(
      onTap: () async {
        Uri url=Uri.parse('https://radioven.com/');
        if (title=='WhatsApp'){
           url = Uri.parse('https://wa.me/+18095502445');
        }else if(title=='Instagram'){
           url = Uri.parse('https://www.instagram.com/radiovenoficial/');
        }else if(title=='Facebook'){
           url = Uri.parse('https://www.facebook.com/radioven');
        }else if(title=='Website'){
           url = Uri.parse('https://radioven.com');
        }
        print(url);
        if (await canLaunchUrl(url)) {
           await launchUrl(url);
        } else {
            throw 'No se pudo abrir el enlace: $url';
        }

      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        width: isCollapsed ? 300 : 70,
        height: 40,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      size:25,
                      icon,
                      color: Colors.white,
                    ),
                    if (infoCount > 0)
                      Positioned(
                        right: -5,
                        top: -5,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (isCollapsed) const SizedBox(width: 10),
            if (isCollapsed)
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        title,
                        style: styleSubTitulo ,
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                    if (infoCount > 0)
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.purple[200],
                          ),
                          child: Center(
                            child: Text(
                              infoCount.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            if (isCollapsed) const Spacer(),
            if (isCollapsed)
              Expanded(
                flex: 1,
                child: doHaveMoreOptions != null
                    ? IconButton(
                        icon: Icon(
                          doHaveMoreOptions,
                          color: Colors.white,
                          size: 12,
                        ),
                        onPressed: () {print('ok');},
                      )
                    : const Center(),
              ),
          ],
        ),
      ),
    );
  }
}
