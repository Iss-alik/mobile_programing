import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/colors.dart';
import 'package:flutter_application_3/constants/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';


class StandardTextContainer extends Container {
  StandardTextContainer(String text, {super.key})
      : super(
          color: Colors.green,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          child: Text(text),
        );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ru')],
      path: 'assets/translations', 
      fallbackLocale: Locale('en'),
      child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});


  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar( 
      actions: [TextButton(
                  child: Text('cahnge_lang', style: AppTextStyles.px10Accent,).tr(),
                  onPressed:() async
                  {
                    if(context.locale == Locale('ru'))
                    {
                      await context.setLocale(Locale('en'));
                    }
                    else
                    {await context.setLocale(Locale('ru'));}
                  }
                )
            ],
      title: Text('app_title', style: AppTextStyles.px12HeadBlack).tr(), 
      backgroundColor: AppColors.main,),
      
      
      body: Column(children: 
        [Container
                  ( 
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration( 
                                              color: AppColors.main,
                                              borderRadius: BorderRadius.circular(12), 
                                              boxShadow:  [BoxShadow(color: AppColors.secondary, blurRadius: 6, offset: Offset(2,2) )] 
                                            ),
                    child: Text('hello_text', style: AppTextStyles.px12HeadBlack, textAlign: TextAlign.center,).tr(),
                  ),
                const SizedBox(height: 16),
                Container
                  (
                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20) ,
                   decoration: BoxDecoration( 
                                              color: AppColors.main,
                                              borderRadius: BorderRadius.circular(8), 
                                              border: Border.all(color: AppColors.secondary, width: 2)
                                            ),
                    child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("left_text", style: AppTextStyles.px10Accent ).tr(), 
                              Text("right_text", style: AppTextStyles.px10Accent).tr() ],), 
                  ),], )
    );
  }
 
}

