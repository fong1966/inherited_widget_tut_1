import 'package:flutter/material.dart';

class User {
  String? firstName;
  String? lastName;
  String? email;

  User([this.firstName, this.lastName, this.email]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          firstName == other.firstName;

  @override
  int get hashCode => firstName.hashCode;
}

class InheritedStateContainer extends InheritedWidget {
  // Data is your entire state. In our case just 'User'
  final StateContainerState data;

  // You must pass through a child and your state.
  const InheritedStateContainer({
    super.key,
    required this.data,
    required Widget child,
  }) : super(child: child);

  // This is a built in method which you can use to check if
  // any state has changed. If not, no reason to rebuild all the widgets
  // that rely on your state.
  @override
  bool updateShouldNotify(InheritedStateContainer oldWidget) => true;
}

class StateContainer extends StatefulWidget {
  // You must pass through a child.
  final Widget child;
  final User? user;

  const StateContainer({
    super.key,
    required this.child,
    this.user,
  });

  // This is the secret sauce. Write your own 'of' method that will behave
  // Exactly like MediaQuery.of and Theme.of
  // It basically says 'get the data from the widget of this type.
  static StateContainerState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedStateContainer>()!
        .data;
  }

  @override
  State<StateContainer> createState() => StateContainerState();
}

class StateContainerState extends State<StateContainer> {
  // Whichever properties you wanna pass around your app as state
  User? user;

  // You can (and probably will) have methods on your StateContainer
  // These methods are then used through our your app to
  // change state.
  // Using setState() here tells Flutter to repaint all the
  // Widgets in the app that rely on the state you've changed.
  void updateUserInfo({firstName, lastName, email}) {
    user = User(firstName, lastName, email);
    setState(() {
      user = user;
    });

    setState(() {
      user!.firstName = firstName ?? user!.firstName;
      user!.lastName = lastName ?? user!.lastName;
      user!.email = email ?? user!.email;
    });
  }

  // Simple build method that just passes this state through
  // your InheritedWidget
  @override
  Widget build(BuildContext context) {
    return InheritedStateContainer(data: this, child: widget.child);
  }
}
