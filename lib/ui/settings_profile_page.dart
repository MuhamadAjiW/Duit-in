import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';
import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/ui/settings_change_name.dart';


class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 28,
              color: black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text('Profile', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget profileBlock(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(logoItb))
                  ),
                ),
                SizedBox(height: 20,),
                Text('${state.user.name}', style: defaultTextTheme.copyWith(
                  fontSize: 28,
                  fontWeight: medium,
                )),
                SizedBox(height: 10,),
                Text('${state.user.email}', style: grayTextTheme.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                )),
              ],
            ),
          ),
        );
      }
      else return SizedBox();
    });
  }

  Widget nameButton(){
          return Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: gray,
                    width: 1,
                ),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NameChangePage()));
                },
                child: Text(
                  'Change Name',
                  style: defaultTextTheme,
                ),
              ),
            ),
          );
  }

  Widget logoutButton(){
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Container(
              width: 300,
              decoration: BoxDecoration(
                  color: red,
                  borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: (){
                  context.read<AuthCubit>().signOut();
                },
                child: Text(
                  'Log Out',
                  style: defaultTextTheme.copyWith(color: white),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
          } else if (state is AuthInitial){
            Navigator.pushNamedAndRemoveUntil(
                context, '/landing-page', (route) => false);
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            children: [
              SizedBox(height: 60,),
              openingPlate(),
              SizedBox(height: 20,),
              profileBlock(),
              SizedBox(height: 40,),
              nameButton(),
              SizedBox(height: 10,),
              logoutButton(),
            ],
          ),
        )
    );
  }
}
