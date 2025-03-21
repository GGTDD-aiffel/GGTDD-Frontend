import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TimePickerWidget extends StatefulWidget {
  final int hours;
  final int minutes;
  final int seconds;
  final ValueChanged<Map<String, int>>? onChanged;

  const TimePickerWidget({
    super.key,
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.onChanged,
  });

  @override
  _TimePickerWidgetState createState() => _TimePickerWidgetState();
}

class _TimePickerWidgetState extends State<TimePickerWidget> {
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController(text: widget.hours.toString());
    _minutesController = TextEditingController(text: widget.minutes.toString());
    _secondsController = TextEditingController(text: widget.seconds.toString());
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  void _updateValue(String type, int delta) {
    int value;
    switch (type) {
      case 'hours':
        value = int.tryParse(_hoursController.text) ?? 0;
        value = (value + delta).clamp(0, 23);
        _hoursController.text = value.toString();
        break;
      case 'minutes':
        value = int.tryParse(_minutesController.text) ?? 0;
        value = (value + delta).clamp(0, 59);
        _minutesController.text = value.toString();
        break;
      case 'seconds':
        value = int.tryParse(_secondsController.text) ?? 0;
        value = (value + delta).clamp(0, 59);
        _secondsController.text = value.toString();
        break;
    }
    _notifyChange();
  }

  void _onTextChanged(String type, String value) {
    int? parsedValue = int.tryParse(value);
    if (parsedValue == null) return;

    switch (type) {
      case 'hours':
        parsedValue = parsedValue.clamp(0, 23);
        _hoursController.text = parsedValue.toString();
        break;
      case 'minutes':
        parsedValue = parsedValue.clamp(0, 59);
        _minutesController.text = parsedValue.toString();
        break;
      case 'seconds':
        parsedValue = parsedValue.clamp(0, 59);
        _secondsController.text = parsedValue.toString();
        break;
    }
    _notifyChange();
  }

  void _notifyChange() {
    if (widget.onChanged != null) {
      widget.onChanged!({
        'hours': int.tryParse(_hoursController.text) ?? 0,
        'minutes': int.tryParse(_minutesController.text) ?? 0,
        'seconds': int.tryParse(_secondsController.text) ?? 0,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF999999).withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTimeField('시간', _hoursController, 'hours'),
          const Gap(8),
          _buildTimeField('분', _minutesController, 'minutes'),
          const Gap(8),
          _buildTimeField('초', _secondsController, 'seconds'),
        ],
      ),
    );
  }

  Widget _buildTimeField(
      String label, TextEditingController controller, String type) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[300],
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (value) => _onTextChanged(type, value),
          ),
        ),
        const Gap(4),
        Text(label, style: const TextStyle(fontSize: 14)),
        const Gap(4),
        Column(
          children: [
            GestureDetector(
              onTap: () => _updateValue(type, 1),
              child: const Icon(Icons.arrow_drop_up, size: 16),
            ),
            GestureDetector(
              onTap: () => _updateValue(type, -1),
              child: const Icon(Icons.arrow_drop_down, size: 16),
            ),
          ],
        ),
      ],
    );
  }
}
