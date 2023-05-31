import 'package:flutter/material.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: telaLogin(),
    );
  }
}

class telaLogin extends StatefulWidget {
  @override
  _telaLogin createState() => _telaLogin();
}

class _telaLogin extends State<telaLogin> {


  // telaLogin({Key? k
  int _currentIndex = 0;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login')),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance),
                label: 'About'
            ),

          ],
          onTap: (index)=>{
            setState(()=>{
              _currentIndex = index
            })
          },
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomePage(),
            AboutPage()
          ],
        ));
  }

}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HomePage')),
      body: Center(
          child: Text('HomePage')),
    );
  }
}


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AboutPage')),
      body: Center(
          child: Text('AboutPage')),
    );
  }
}

