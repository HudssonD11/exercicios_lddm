import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  _tentaLogin(String email, String senha) async{
    final prefs = await SharedPreferences.getInstance();
    if(email == prefs.getString('email') && senha == prefs.getString('senha')) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => boasVindas()));
    }
  }
  // telaLogin({Key? key}) : super(key: key);
  bool _esconde = false;
  bool _remember = false;
  int _currentIndex = 0;
  @override
  void initState() => _esconde = false;

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
                  onPressed: (){},
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

class cadastro extends StatefulWidget {
  const cadastro({Key? key}) : super(key: key);

  @override
  _cadastro createState() => _cadastro();
}

class _cadastro extends State<cadastro> {

  _salvarDados (String nome, String data, String email, String senha) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', nome);
    await prefs.setString('data', data);
    await prefs.setString('email', email);
    await prefs.setString('senha', senha);
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
                    _salvarDados(_nome.text, _data.text, _emailV.text, _senha.text)
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bem Vindo')),
      body: Center(
          child: Text("Bem vindo")),
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

