import 'package:flutter/material.dart';

class InfoCard extends StatefulWidget {
  final String title;
  final String value;
  final VoidCallback inc;
  final VoidCallback dec;

  const InfoCard({
    super.key,
    required this.title,
    required this.value,
    required this.inc,
    required this.dec,
  });

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1D1E33),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(w * 0.04),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white70, fontSize: w * 0.05),
          ),
          SizedBox(height: w * 0.03),

          Text(
            widget.value,
            style: TextStyle(
              color: Colors.white,
              fontSize: w * 0.12,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: w * 0.03),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,),
                onPressed: widget.dec,
                child: CircleAvatar(
                  radius: w * 0.06,
                  backgroundColor: Colors.grey.shade700,
                  child: Icon(Icons.remove, color: Colors.white, size: w * 0.06),
                ),
              ),

              SizedBox(width: w * 0.03),

              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: widget.inc,
                child: CircleAvatar(
                  radius: w * 0.06,
                  backgroundColor: Colors.grey.shade700,
                  child: Icon(Icons.add, color: Colors.white, size: w * 0.06),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
