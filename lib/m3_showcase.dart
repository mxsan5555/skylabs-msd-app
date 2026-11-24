import 'package:flutter/material.dart';

class M3ShowcasePage extends StatefulWidget {
  const M3ShowcasePage({super.key});

  @override
  State<M3ShowcasePage> createState() => _M3ShowcasePageState();
}

class _M3ShowcasePageState extends State<M3ShowcasePage> {
  // Actions
  Set<String> _segmentedSel = <String>{'day'};

  // Navigation
  int _navBarIdx = 0;
  int _navRailIdx = 0;

  // Selection — checkboxes
  bool _cbx1 = true;
  bool _cbx2 = false;
  bool _cbxListTile = true;

  // Selection — chips
  bool _filterChip = true;
  int _choiceChipVal = 0;
  bool _inputChipVisible = true;

  // Selection — switch
  bool _switchVal = true;
  bool _switchListTile = true;

  // Selection — radio
  int _radioVal = 0;

  // Selection — sliders
  double _sliderVal = 0.5;
  RangeValues _rangeVals = const RangeValues(0.2, 0.8);

  // Selection — pickers
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();
  DateTimeRange? _dateRange;

  // Selection — dropdown
  String? _dropdownVal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.large(
            title: Text('M3 Component Showcase'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ..._actionsSection(),
              ..._communicationSection(),
              ..._containmentSection(),
              ..._navigationSection(),
              ..._selectionSection(),
              ..._textInputSection(),
              ..._inkSection(),
              const SizedBox(height: 48),
            ]),
          ),
        ],
      ),
    );
  }

  // ─── Section 1: Actions ──────────────────────────────────────────────────────

  List<Widget> _actionsSection() => [
        const _SectionHeader('Actions'),
        _Demo(
          'ElevatedButton',
          child: ElevatedButton(
              onPressed: () {}, child: const Text('Elevated Button')),
        ),
        _Demo(
          'FilledButton',
          child: FilledButton(
              onPressed: () {}, child: const Text('Filled Button')),
        ),
        _Demo(
          'FilledButton.tonal',
          child: FilledButton.tonal(
              onPressed: () {}, child: const Text('Filled Tonal Button')),
        ),
        _Demo(
          'OutlinedButton',
          child: OutlinedButton(
              onPressed: () {}, child: const Text('Outlined Button')),
        ),
        _Demo(
          'TextButton',
          child:
              TextButton(onPressed: () {}, child: const Text('Text Button')),
        ),
        _Demo(
          'IconButton — Standard / Filled / Filled Tonal / Outlined',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Labeled(
                  'Standard',
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined))),
              _Labeled(
                  'Filled',
                  IconButton.filled(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined))),
              _Labeled(
                  'Tonal',
                  IconButton.filledTonal(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined))),
              _Labeled(
                  'Outlined',
                  IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined))),
            ],
          ),
        ),
        _Demo(
          'FloatingActionButton — Small / Regular / Large / Extended',
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              FloatingActionButton.small(
                  heroTag: 'fab-sm',
                  onPressed: () {},
                  child: const Icon(Icons.add)),
              FloatingActionButton(
                  heroTag: 'fab-md',
                  onPressed: () {},
                  child: const Icon(Icons.add)),
              FloatingActionButton.large(
                  heroTag: 'fab-lg',
                  onPressed: () {},
                  child: const Icon(Icons.add)),
              FloatingActionButton.extended(
                heroTag: 'fab-ext',
                onPressed: () {},
                icon: const Icon(Icons.add),
                label: const Text('Extended'),
              ),
            ],
          ),
        ),
        _Demo(
          'SegmentedButton',
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(
                  value: 'day',
                  label: Text('Day'),
                  icon: Icon(Icons.today_outlined)),
              ButtonSegment(
                  value: 'week',
                  label: Text('Week'),
                  icon: Icon(Icons.view_week_outlined)),
              ButtonSegment(
                  value: 'month',
                  label: Text('Month'),
                  icon: Icon(Icons.calendar_month_outlined)),
            ],
            selected: _segmentedSel,
            onSelectionChanged: (val) =>
                setState(() => _segmentedSel = val),
          ),
        ),
      ];

  // ─── Section 2: Communication ────────────────────────────────────────────────

  List<Widget> _communicationSection() => [
        const _SectionHeader('Communication'),
        _Demo(
          'Badge — dot / count / large count',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _Labeled('Dot', Badge(child: Icon(Icons.email_outlined))),
              _Labeled(
                  'Count',
                  Badge(
                      label: Text('4'),
                      child: Icon(Icons.email_outlined))),
              _Labeled(
                  '99+',
                  Badge(
                      label: Text('99+'),
                      child: Icon(Icons.notifications_outlined))),
            ],
          ),
        ),
        _Demo(
          'CircularProgressIndicator — determinate & indeterminate',
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Labeled('60%', CircularProgressIndicator(value: 0.6)),
              _Labeled('Indeterminate', CircularProgressIndicator()),
            ],
          ),
        ),
        _Demo(
          'LinearProgressIndicator — determinate & indeterminate',
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Labeled('40%', LinearProgressIndicator(value: 0.4)),
              SizedBox(height: 12),
              _Labeled('Indeterminate', LinearProgressIndicator()),
            ],
          ),
        ),
        _Demo(
          'SnackBar',
          child: FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('This is a Material 3 SnackBar'),
                  action: SnackBarAction(
                      label: 'Dismiss', onPressed: () {}),
                  behavior: SnackBarBehavior.floating,
                  showCloseIcon: true,
                ),
              );
            },
            child: const Text('Show SnackBar'),
          ),
        ),
        const _Demo(
          'Tooltip',
          child: Tooltip(
            message: 'This is a Material 3 tooltip — hover or long-press',
            child: Icon(Icons.info_outline, size: 32),
          ),
        ),
      ];

  // ─── Section 3: Containment ──────────────────────────────────────────────────

  List<Widget> _containmentSection() => [
        const _SectionHeader('Containment'),
        const _Demo(
          'Card — elevated / filled / outlined',
          child: Column(
            children: [
              Card(
                  child: ListTile(
                      title: Text('Elevated Card'),
                      subtitle: Text('Default Card()'))),
              SizedBox(height: 8),
              Card.filled(
                  child: ListTile(
                      title: Text('Filled Card'),
                      subtitle: Text('Card.filled()'))),
              SizedBox(height: 8),
              Card.outlined(
                  child: ListTile(
                      title: Text('Outlined Card'),
                      subtitle: Text('Card.outlined()'))),
            ],
          ),
        ),
        _Demo(
          'AlertDialog',
          child: FilledButton(
            onPressed: () => showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Alert Dialog'),
                content: const Text(
                    'This demonstrates the M3 AlertDialog with standard action buttons.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel')),
                  FilledButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Confirm')),
                ],
              ),
            ),
            child: const Text('Open AlertDialog'),
          ),
        ),
        _Demo(
          'Dialog — full screen',
          child: FilledButton(
            onPressed: () => showDialog(
              context: context,
              builder: (ctx) => Dialog.fullscreen(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text('Full-Screen Dialog'),
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(ctx),
                          child: const Text('Save')),
                    ],
                  ),
                  body: const Center(
                      child: Text('Full-screen dialog content area')),
                ),
              ),
            ),
            child: const Text('Open Full-Screen Dialog'),
          ),
        ),
        _Demo(
          'BottomSheet — modal',
          child: FilledButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (ctx) => Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Modal Bottom Sheet',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    const Text(
                        'Drag the handle down or tap outside to dismiss.'),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancel')),
                        const SizedBox(width: 8),
                        FilledButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Accept')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            child: const Text('Open Bottom Sheet'),
          ),
        ),
        const _Demo(
          'Divider',
          child: Column(
            children: [
              ListTile(title: Text('Item above divider')),
              Divider(),
              ListTile(title: Text('Item below divider')),
            ],
          ),
        ),
        const _Demo(
          'VerticalDivider',
          child: SizedBox(
            height: 56,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Left'),
                VerticalDivider(thickness: 1, indent: 8, endIndent: 8),
                Text('Right'),
              ],
            ),
          ),
        ),
        const _Demo(
          'ListTile — one-line & two-line',
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text('One-line ListTile'),
                trailing: Icon(Icons.chevron_right),
              ),
              ListTile(
                leading: Icon(Icons.account_circle_outlined),
                title: Text('Two-line ListTile'),
                subtitle: Text('Supporting text'),
                trailing: Icon(Icons.chevron_right),
              ),
            ],
          ),
        ),
      ];

  // ─── Section 4: Navigation ───────────────────────────────────────────────────

  List<Widget> _navigationSection() => [
        const _SectionHeader('Navigation'),
        _Demo(
          'AppBar — center-aligned',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: AppBar(
              centerTitle: true,
              title: const Text('Center-Aligned AppBar'),
              leading: const Icon(Icons.menu),
              actions: const [Icon(Icons.more_vert), SizedBox(width: 8)],
            ),
          ),
        ),
        _Demo(
          'BottomAppBar',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: BottomAppBar(
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.menu_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search_outlined)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline)),
                  const Spacer(),
                  FloatingActionButton.small(
                    heroTag: 'fab-bab',
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
          ),
        ),
        _Demo(
          'NavigationBar',
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: NavigationBar(
              selectedIndex: _navBarIdx,
              onDestinationSelected: (i) =>
                  setState(() => _navBarIdx = i),
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.explore_outlined),
                  selectedIcon: Icon(Icons.explore),
                  label: 'Explore',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline),
                  selectedIcon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        _Demo(
          'NavigationDrawer — static inline demo',
          child: SizedBox(
            height: 260,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: NavigationDrawer(
                selectedIndex: 0,
                children: const [
                  Padding(
                    padding: EdgeInsets.fromLTRB(28, 16, 16, 10),
                    child: Text('Navigation Drawer'),
                  ),
                  NavigationDrawerDestination(
                    icon: Icon(Icons.message_outlined),
                    selectedIcon: Icon(Icons.message),
                    label: Text('Messages'),
                  ),
                  NavigationDrawerDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: Text('Profile'),
                  ),
                  NavigationDrawerDestination(
                    icon: Icon(Icons.settings_outlined),
                    selectedIcon: Icon(Icons.settings),
                    label: Text('Settings'),
                  ),
                ],
              ),
            ),
          ),
        ),
        _Demo(
          'NavigationRail',
          child: SizedBox(
            height: 220,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Row(
                children: [
                  NavigationRail(
                    selectedIndex: _navRailIdx,
                    onDestinationSelected: (i) =>
                        setState(() => _navRailIdx = i),
                    labelType: NavigationRailLabelType.selected,
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_outlined),
                        selectedIcon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.search_outlined),
                        selectedIcon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings_outlined),
                        selectedIcon: Icon(Icons.settings),
                        label: Text('Settings'),
                      ),
                    ],
                  ),
                  const VerticalDivider(thickness: 1, width: 1),
                  Expanded(
                    child: Center(
                        child: Text('Content for tab $_navRailIdx')),
                  ),
                ],
              ),
            ),
          ),
        ),
        _Demo(
          'SearchBar',
          child: SearchBar(
            hintText: 'Search...',
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 16)),
            leading: const Icon(Icons.search),
            trailing: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic_none_outlined)),
            ],
          ),
        ),
        _Demo(
          'SearchAnchor',
          child: SearchAnchor(
            builder: (context, controller) => SearchBar(
              controller: controller,
              hintText: 'Search with suggestions...',
              padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 16)),
              leading: const Icon(Icons.search),
              onTap: controller.openView,
              onChanged: (_) => controller.openView(),
            ),
            suggestionsBuilder: (context, controller) => <Widget>[
              ListTile(
                title: const Text('Suggestion 1'),
                onTap: () => controller.closeView('Suggestion 1'),
              ),
              ListTile(
                title: const Text('Suggestion 2'),
                onTap: () => controller.closeView('Suggestion 2'),
              ),
              ListTile(
                title: const Text('Suggestion 3'),
                onTap: () => controller.closeView('Suggestion 3'),
              ),
            ],
          ),
        ),
        const _Demo(
          'TabBar',
          child: SizedBox(
            height: 120,
            child: DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(tabs: [
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                    Tab(text: 'Tab 3'),
                  ]),
                  Expanded(
                    child: TabBarView(children: [
                      Center(child: Text('Content 1')),
                      Center(child: Text('Content 2')),
                      Center(child: Text('Content 3')),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  // ─── Section 5: Selection ────────────────────────────────────────────────────

  List<Widget> _selectionSection() => [
        const _SectionHeader('Selection'),
        _Demo(
          'Checkbox — checked / unchecked / tristate / error',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Labeled(
                  'Checked',
                  Checkbox(
                      value: _cbx1,
                      onChanged: (v) =>
                          setState(() => _cbx1 = v!))),
              _Labeled(
                  'Unchecked',
                  Checkbox(
                      value: _cbx2,
                      onChanged: (v) =>
                          setState(() => _cbx2 = v!))),
              const _Labeled(
                  'Tristate',
                  Checkbox(
                      value: null,
                      tristate: true,
                      onChanged: null)),
              _Labeled(
                  'Error',
                  Checkbox(
                      value: _cbx1,
                      isError: true,
                      onChanged: (v) =>
                          setState(() => _cbx1 = v!))),
            ],
          ),
        ),
        _Demo(
          'CheckboxListTile',
          child: CheckboxListTile(
            title: const Text('Enable notifications'),
            subtitle: const Text('Get updates about your activity'),
            value: _cbxListTile,
            onChanged: (v) => setState(() => _cbxListTile = v!),
          ),
        ),
        _Demo(
          'Chips — Action / Filter / Choice / Input',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ActionChip(
                avatar: const Icon(Icons.add),
                label: const Text('Action'),
                onPressed: () {},
              ),
              FilterChip(
                avatar: const Icon(Icons.filter_list),
                label: const Text('Filter'),
                selected: _filterChip,
                onSelected: (v) => setState(() => _filterChip = v),
              ),
              ChoiceChip(
                label: const Text('Choice A'),
                selected: _choiceChipVal == 0,
                onSelected: (_) =>
                    setState(() => _choiceChipVal = 0),
              ),
              ChoiceChip(
                label: const Text('Choice B'),
                selected: _choiceChipVal == 1,
                onSelected: (_) =>
                    setState(() => _choiceChipVal = 1),
              ),
              if (_inputChipVisible)
                InputChip(
                  avatar: const CircleAvatar(
                      child: Text('A', style: TextStyle(fontSize: 12))),
                  label: const Text('Input Chip'),
                  onDeleted: () =>
                      setState(() => _inputChipVisible = false),
                ),
              if (!_inputChipVisible)
                ActionChip(
                  label: const Text('Restore InputChip'),
                  onPressed: () =>
                      setState(() => _inputChipVisible = true),
                ),
            ],
          ),
        ),
        _Demo(
          'DatePicker (showDatePicker)',
          child: OutlinedButton.icon(
            icon: const Icon(Icons.calendar_today_outlined),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) setState(() => _date = picked);
            },
            label: Text(_date.toIso8601String().split('T').first),
          ),
        ),
        _Demo(
          'DateRangePicker (showDateRangePicker)',
          child: OutlinedButton.icon(
            icon: const Icon(Icons.date_range_outlined),
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                initialDateRange: _dateRange,
              );
              if (picked != null) setState(() => _dateRange = picked);
            },
            label: Text(_dateRange == null
                ? 'Select date range'
                : '${_dateRange!.start.toIso8601String().split('T').first}'
                    ' → '
                    '${_dateRange!.end.toIso8601String().split('T').first}'),
          ),
        ),
        _Demo(
          'InputDatePickerFormField',
          child: Form(
            child: InputDatePickerFormField(
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: _date,
              onDateSubmitted: (d) => setState(() => _date = d),
            ),
          ),
        ),
        _Demo(
          'DropdownMenu',
          child: DropdownMenu<String>(
            hintText: 'Select an option',
            initialSelection: _dropdownVal,
            onSelected: (v) => setState(() => _dropdownVal = v),
            dropdownMenuEntries: const [
              DropdownMenuEntry(value: 'option1', label: 'Option 1'),
              DropdownMenuEntry(value: 'option2', label: 'Option 2'),
              DropdownMenuEntry(value: 'option3', label: 'Option 3'),
            ],
          ),
        ),
        _Demo(
          'MenuAnchor',
          child: MenuAnchor(
            builder: (ctx, controller, _) => OutlinedButton.icon(
              icon: const Icon(Icons.more_vert),
              label: const Text('Open MenuAnchor'),
              onPressed:
                  controller.isOpen ? controller.close : controller.open,
            ),
            menuChildren: [
              MenuItemButton(
                leadingIcon: const Icon(Icons.edit_outlined),
                onPressed: () {},
                child: const Text('Edit'),
              ),
              MenuItemButton(
                leadingIcon: const Icon(Icons.share_outlined),
                onPressed: () {},
                child: const Text('Share'),
              ),
              const Divider(),
              MenuItemButton(
                leadingIcon: const Icon(Icons.delete_outline),
                onPressed: () {},
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
        _Demo(
          'MenuBar',
          child: MenuBar(
            children: [
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.add),
                      onPressed: () {},
                      child: const Text('New')),
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.folder_open_outlined),
                      onPressed: () {},
                      child: const Text('Open')),
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.save_outlined),
                      onPressed: () {},
                      child: const Text('Save')),
                ],
                child: const Text('File'),
              ),
              SubmenuButton(
                menuChildren: [
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.content_cut),
                      onPressed: () {},
                      child: const Text('Cut')),
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.content_copy_outlined),
                      onPressed: () {},
                      child: const Text('Copy')),
                  MenuItemButton(
                      leadingIcon: const Icon(Icons.content_paste_outlined),
                      onPressed: () {},
                      child: const Text('Paste')),
                ],
                child: const Text('Edit'),
              ),
            ],
          ),
        ),
        _Demo(
          'Radio (RadioListTile)',
          child: Column(
            children: List.generate(
              3,
              (i) => RadioListTile<int>(
                title: Text('Option ${i + 1}'),
                value: i,
                // ignore: deprecated_member_use
                groupValue: _radioVal,
                // ignore: deprecated_member_use
                onChanged: (v) => setState(() => _radioVal = v!),
              ),
            ),
          ),
        ),
        _Demo(
          'Slider',
          child: Column(
            children: [
              Slider(
                value: _sliderVal,
                divisions: 10,
                label: '${(_sliderVal * 100).round()}%',
                onChanged: (v) => setState(() => _sliderVal = v),
              ),
              Text(
                'Value: ${(_sliderVal * 100).round()}%',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        _Demo(
          'RangeSlider',
          child: Column(
            children: [
              RangeSlider(
                values: _rangeVals,
                divisions: 10,
                labels: RangeLabels(
                  '${(_rangeVals.start * 100).round()}%',
                  '${(_rangeVals.end * 100).round()}%',
                ),
                onChanged: (v) => setState(() => _rangeVals = v),
              ),
              Text(
                '${(_rangeVals.start * 100).round()}% – '
                '${(_rangeVals.end * 100).round()}%',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        _Demo(
          'Switch — on / off / disabled',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _Labeled(
                  'On',
                  Switch(
                      value: _switchVal,
                      onChanged: (v) =>
                          setState(() => _switchVal = v))),
              _Labeled(
                  'Off',
                  Switch(
                      value: !_switchVal,
                      onChanged: (v) =>
                          setState(() => _switchVal = !v))),
              const _Labeled(
                  'Disabled', Switch(value: true, onChanged: null)),
            ],
          ),
        ),
        _Demo(
          'SwitchListTile',
          child: SwitchListTile(
            title: const Text('Enable dark mode'),
            subtitle: const Text('Applies to this device only'),
            value: _switchListTile,
            onChanged: (v) => setState(() => _switchListTile = v),
          ),
        ),
        _Demo(
          'TimePicker (showTimePicker)',
          child: OutlinedButton.icon(
            icon: const Icon(Icons.access_time_outlined),
            onPressed: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _time,
              );
              if (picked != null) setState(() => _time = picked);
            },
            label: Text(
              '${_time.hour.toString().padLeft(2, '0')}:'
              '${_time.minute.toString().padLeft(2, '0')}',
            ),
          ),
        ),
      ];

  // ─── Section 6: Text Input ───────────────────────────────────────────────────

  List<Widget> _textInputSection() => [
        const _SectionHeader('Text Input'),
        const _Demo(
          'TextField — filled (default)',
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Label',
              hintText: 'Filled text field',
              helperText: 'Helper / supporting text',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
        ),
        const _Demo(
          'TextField — outlined',
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Label',
              hintText: 'Outlined text field',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email_outlined),
              suffixIcon: Icon(Icons.clear),
            ),
          ),
        ),
        const _Demo(
          'TextField — error state',
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              errorText: 'Password must be at least 8 characters',
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const _Demo(
          'TextField — disabled',
          child: TextField(
            enabled: false,
            decoration: InputDecoration(
              labelText: 'Disabled',
              hintText: 'This field cannot be edited',
              prefixIcon: Icon(Icons.block),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ];

  // ─── Section 7: Ink & Ripple ─────────────────────────────────────────────────

  List<Widget> _inkSection() => [
        const _SectionHeader('Ink & Ripple'),
        _Demo(
          'InkRipple',
          child: Theme(
            data: Theme.of(context)
                .copyWith(splashFactory: InkRipple.splashFactory),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Tap — InkRipple splash'),
                ),
              ),
            ),
          ),
        ),
        _Demo(
          'InkSparkle',
          child: Theme(
            data: Theme.of(context)
                .copyWith(splashFactory: InkSparkle.splashFactory),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: double.infinity,
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            Theme.of(context).colorScheme.outline),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Tap — InkSparkle splash'),
                ),
              ),
            ),
          ),
        ),
        _Demo(
          'MaterialScrollBehavior — horizontal scroll with drag on all platforms',
          child: SizedBox(
            height: 56,
            child: ScrollConfiguration(
              behavior: MaterialScrollBehavior(),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                itemCount: 10,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (_, i) =>
                    ActionChip(label: Text('Chip $i'), onPressed: () {}),
              ),
            ),
          ),
        ),
      ];
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
          ),
          const SizedBox(height: 6),
          Divider(color: cs.outlineVariant),
        ],
      ),
    );
  }
}

class _Demo extends StatelessWidget {
  final String name;
  final Widget child;
  const _Demo(this.name, {required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

/// Stacks a label below a widget — used inside demo rows.
class _Labeled extends StatelessWidget {
  final String label;
  final Widget child;
  const _Labeled(this.label, this.child);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 4),
        Text(label,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(
                    color:
                        Theme.of(context).colorScheme.onSurfaceVariant)),
      ],
    );
  }
}
