import 'package:flutter/material.dart';

class ExpandablePanel extends StatefulWidget {
  @override
  _ExpandablePanelState createState() => _ExpandablePanelState();
  final List<Widget> buttons;
  final AlignmentGeometry alignment;
  final bool ? isOpen;

  ExpandablePanel({required this.buttons,required this.alignment,  this.isOpen});
}

class _ExpandablePanelState extends State<ExpandablePanel>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _arrowAnimation;
  late Animation<double> _panelAnimation;

  @override
  void initState() {
    super.initState();
    _isExpanded=widget.isOpen??false;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
    _panelAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _togglePanel() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
    alignment: widget.alignment,
        //  clipBehavior: Clip.hardEdge,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 3000),
         //   curve: Curves.fastOutSlowIn,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _isExpanded ? Row(children: widget.buttons) : Container(),
                IconButton(
                  icon: RotationTransition(
                    turns: _arrowAnimation,
                    child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
                  ),
                  onPressed: _togglePanel,
                ),
              ],
            ),
          )
        ]);
  }
}



// import 'package:flutter/material.dart';

// class ExpandablePanel extends StatefulWidget {
//   final List<Widget> buttons;

//   ExpandablePanel({required this.buttons});

//   @override
//   _ExpandablePanelState createState() => _ExpandablePanelState();
// }

// class _ExpandablePanelState extends State<ExpandablePanel>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//   late AnimationController _controller;
//   late Animation<double> _arrowAnimation;
//   late Animation<double> _panelAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _arrowAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
//     _panelAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//   }

//   void _togglePanel() {
//     setState(() {
//       _isExpanded = !_isExpanded;
//       if (_isExpanded) {
//         _controller.forward();
//       } else {
//         _controller.reverse();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizeTransition(
//       sizeFactor: _panelAnimation,
//       axisAlignment: -1.0,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black),
//           borderRadius: BorderRadius.circular(12.0),
//         ),
//         child: Row(
//       mainAxisSize: MainAxisSize.min,
//           children: [
//             _isExpanded
//                 ? Row(children: widget.buttons)
//                 : Container(),
//             IconButton(
//               icon: RotationTransition(
//                 turns: _arrowAnimation,
//                 child: Icon(Icons.arrow_left, color: Colors.black),
//               ),
//               onPressed: _togglePanel,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
