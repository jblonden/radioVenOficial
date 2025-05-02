import 'package:radio_ven_105_5_fm/ui/components/drawer/custom_list_tile.dart';
import 'package:radio_ven_105_5_fm/ui/components/drawer/header.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: _isCollapsed ? 300 : 100,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.deepPurple
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: _isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon:  FontAwesomeIcons.facebook,
                title: 'Facebook',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: FontAwesomeIcons.instagram ,
                title: 'Instagram',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,// FaIcon(Icons.facebook, color: Colors.pink, size: 50),
              ),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: FontAwesomeIcons.whatsapp,
                title: 'WhatsApp',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              
              ),

                CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.web,
                title: 'Website',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
        
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: _isCollapsed,
                icon: Icons.info,
                title: 'Nosotros',
                infoCount: 0,
              ),
           const Divider(color: Colors.grey),
       


              const SizedBox(height: 10),
    
              Align(
                alignment: _isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    _isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed;
                   
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
