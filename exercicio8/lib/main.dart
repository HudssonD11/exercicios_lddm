import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/home": (context) => boasVindas(),
      },
      home: telaLogin(),
    );
  }
}

class telaLogin extends StatefulWidget {
  @override
  _telaLogin createState() => _telaLogin();
}

class _telaLogin extends State<telaLogin> {

  _tentaLogin(String email, String senha) async{
    print(email);
    print(senha);
    final shared = await SharedPreferences.getInstance();
    String name = shared.getString('nome')!;
    if(email == shared.getString('email') && senha == shared.getString('senha')) {
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => boasVindas()));
      Navigator.pushNamed(context, '/home', arguments: [name]);
    }

  }
  // telaLogin({Key? key}) : super(key: key);
  bool _esconde = false;
  bool _remember = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _senha = TextEditingController();
  @override
  void initState() => _esconde = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.fitHeight, image: AssetImage('assets/images/w.jpeg'))),

        child: Container(

          alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: 300,
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(labelText: "E-mail", border: OutlineInputBorder()),

                  style: TextStyle(color: Colors.black, fontSize: 20, ),
                ),

              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: _senha,
                    obscureText: _esconde,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              _esconde = !_esconde;
                            });
                          },
                          icon: Icon(_esconde ? Icons.visibility_off : Icons.visibility ),

                        )
                    ),
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  )

              ),
              Container(
                width: 140,
                child: Row(
                  children: [
                    Container(
                      child: Text("Remember me"),
                    ),
                    Container(
                      child: Checkbox(
                        onChanged: (value) => {
                          setState(()=>_remember = value!)
                        },
                        value: _remember,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: (){
                    _tentaLogin(_email.text, _senha.text);
                  },
                  child: Text('Enter'),
                )
              ),
              Container(
                width: 200,
                child: Row(
                  children: [
                    Container(
                      child: Text('New here?'),
                    ),
                    Container(
                      child: TextButton(
                        onPressed: (){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => cadastro()));
                        },
                        child: Text('Create an account', style: TextStyle(color: Colors.blue),),
                      ),
                    ),

                  ],

                ),

              )

            ],
          ),
        ),
    ),
      ));
  }

}

class lista extends StatefulWidget {
  @override
  _lista createState() => _lista();
}

class _lista extends State<lista> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, indice){
          print("item ${indice}");
          return ListTile(
            title: Text(indice.toString()),
            subtitle: Text("subtitulo"),
          );
        },
      ),
    );
  }

}

class cadastro extends StatefulWidget {
  const cadastro({Key? key}) : super(key: key);

  @override
  _cadastro createState() => _cadastro();
}

class _cadastro extends State<cadastro> {

  _salvarDados (String nome, String data, String email, String senha) async{
    final shared = await SharedPreferences.getInstance();
    await shared.setString('nome', nome);
    await shared.setString('data', data);
    await shared.setString('email', email);
    await shared.setString('senha', senha);
  }


  TextEditingController _nome = TextEditingController();
  TextEditingController _data = TextEditingController();
  TextEditingController _emailV = TextEditingController();
  TextEditingController _senha = TextEditingController();
  String _genero = "";
  bool _esconde = false;
  bool _email = false;
  bool _phone = false;
  double _font = 13;
  String _label = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(
          top: 5, bottom: 50, left: 20, right: 20,
        ),
        child: ListView(
          children: [
            Container(
              child: TextField(
                controller: _nome,
                maxLength: 20,
                decoration: InputDecoration(labelText: "Nome"),
              ),
            ),
            Container(
              child: TextField(
                controller: _data,
                keyboardType: TextInputType.datetime,
                maxLength: 10,
                decoration: InputDecoration(labelText: "Data de nascimento"),
              ),
            ),
            Container(
              child: TextField(
                controller: _emailV,
                decoration: InputDecoration(labelText: "E-mail"),
              ),
            ),
            Container(
                child: TextField(
                  controller: _senha,
                  obscureText: _esconde,
                  maxLength: 20,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: (){
                          setState(() {
                            _esconde = !_esconde;
                          });
                        },
                        icon: Icon(_esconde ? Icons.visibility_off : Icons.visibility ),

                      )
                  ),
                  // style: TextStyle(color: Colors.black, fontSize: 20),
                )

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Gênero: ", style: TextStyle(fontSize: _font)),
                Text("Masculino", style: TextStyle(fontSize: _font)),
                Radio(
                    value: "m",
                    groupValue: _genero,
                    onChanged: (value)=>{
                      setState(()=>{_genero = value!})
                    }
                ),
                Text("Feminino", style: TextStyle(fontSize: _font)),
                Radio(
                    value: "f",
                    groupValue: _genero,
                    onChanged: (value)=>{
                      setState(()=>{_genero = value!})
                    }
                ),

              ]
            ),
            Container(
              alignment: Alignment.center,
              child: Text("Notificações", style: TextStyle(fontSize: _font)),
            ),
            Container(
              child: SwitchListTile(
                title: Text("E-mail", style: TextStyle(fontSize: _font),),
                onChanged: (value)=>{
                    setState(()=>{_email = value})
                    },
                value: _email,
              ),
            ),
            Container(
              child: SwitchListTile(
                title: Text("Celular", style: TextStyle(fontSize: _font),),
                onChanged: (value)=>{
                  setState(()=>{_phone = value})
                },
                value: _phone,
              ),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                  onPressed: ()=>{
                    _salvarDados(_nome.text, _data.text, _emailV.text, _senha.text),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => telaLogin()))
              },
                  child: Text("Register")
              ),
            ),
            Container(
              child: Slider(
                min: 12,
                max: 19.5,
                label: _label,
                divisions: 10,
                value: _font,
                onChanged: (value)=>{
                  setState(()=>{
                      _font = value,
                _label = "fonte: "+value.toString()
                })
                },

              ),
            )
          ],
        ),
      )
    );
  }
}


class boasVindas extends StatefulWidget {
  const boasVindas({Key? key}) : super(key: key);

  @override
  _boasVindas createState() => _boasVindas();
}

class _boasVindas extends State<boasVindas> {
  int _currentIndex = 0;

  Widget build(BuildContext context) {
    List args = ModalRoute.of(context)?.settings.arguments as List;
    String _nome = args[0] as String;
    return Scaffold(
      appBar: AppBar(title: Text('Bem Vindo(a) '+_nome)),
      // body: IndexedStack(index: _currentIndex, children: [
      //   telaLogin(), AboutPage(), lista()
      // ],),
      body: Container(
        alignment: Alignment.center,
        child: Text('Bem Vindo(a) '+_nome),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Builder(builder: (BuildContext context) {
              return ListTile(
                title: const Text('Home',
                    style: TextStyle(fontSize: 18)),
                textColor: Colors.black,
                leading: const Icon(
                  Icons.home,
                  size: 35,

                ),
                onTap: () {
              Navigator.pushNamed(context, '/home', arguments: [_nome]);
              });
            }),
            Builder(builder: (BuildContext context) {
              return ListTile(
                title: const Text('Profile',
                    style: TextStyle(fontSize: 18)),
                leading: const Icon(
                  Icons.person,
                  size: 35,
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
              );
            }),
            ListTile(
              title: const Text('Lista',
                  style: TextStyle(fontSize: 18)),
              leading: const Icon(
                Icons.list,
                size: 35,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => lista()));
              },
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                title: Text("Log Out",style:TextStyle(color: Colors.white, fontSize: 18),),
                leading: const Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.white,
                ),
                //trailing: Icon(Icons.logout),
              ),)
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _currentIndex,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home),
      //         label: 'Home'
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.account_balance),
      //         label: 'About'
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.list),
      //       label: 'Lista',
      //     ),
      //
      //   ],
      //   onTap: (index)=>{
      //     setState(()=>{
      //       _currentIndex = index
      //     })
      //   },
      // ),
    );
  }
}


class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Terceira Tela')),
      body: Center(
          child: FilledButton(
            onPressed: (){
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => telaLogin()));
            },
            child: Text('Vai para primeira tela'),)),
    );
  }
}

