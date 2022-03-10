
void main() {
  BlocOverrides.runZoned(
        () async {
          WidgetsFlutterBinding.ensureInitialized();
          await Firebase.initializeApp();
          runApp( MyApp()); //isDark!




    },
    blocObserver: MyBlocObserver(),
  );

}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {



             return MaterialApp(
               debugShowCheckedModeBanner: false,
               theme: lightTheme,
               darkTheme: darkTheme ,
               themeMode: ThemeMode.light,
               home: AddInformation() ,
             );


      }

}
