import 'package:flutter/material.dart';
//fsadgggggggggggggggggggggggggg
class ExpandableButtons extends StatefulWidget {
  @override
  _ExpandableButtonsState createState() => _ExpandableButtonsState();
  final List<Widget> buttons;
  final AlignmentGeometry alignment;
  final bool ? isOpen;

  ExpandableButtons({required this.buttons,required this.alignment,  this.isOpen});
}

class _ExpandableButtonsState extends State<ExpandableButtons>
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Stack(
      alignment: widget.alignment,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _isExpanded ? Row(children: widget.buttons) : Container(),
              IconButton(
                icon: RotationTransition(
                  turns: _arrowAnimation,
                  child: Icon(
                    Icons.keyboard_arrow_left, 
                    color: colorScheme.onSurface,
                  ),
                ),
                onPressed: _togglePanel,
              ),
            ],
          ),
        )
      ]
    );
  }
}
