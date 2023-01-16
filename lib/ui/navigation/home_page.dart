import 'package:duit.in/common/screensize.dart';
import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:duit.in/models/log_model.dart';
import 'package:duit.in/ui/settings/settings_notifications_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';

import 'package:duit.in/theme/theme.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  Widget openingPlate(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Column(
            children: [
              Container(
                width: ScreenSize.width,
                color: blue,
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10,),
                        Text('Halo,', style: defaultTextTheme.copyWith(
                          fontSize: 24,
                          fontWeight: light,
                        )),
                        SizedBox(height: 10,),
                        Text('${state.user.name}', style: defaultTextTheme.copyWith(
                          fontSize: 32,
                          fontWeight: medium,
                        )),
                        ],
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage(logoItb)
                            )
                        ),
                      ),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (context) => NotificationsPage()
                                //TODO: Add proper notifications
                            )
                        );
                      }
                    ),
                  ],
                ),
            ),
            ],
          );
      }

      else return SizedBox();
    });
  }

  Widget limitAlert(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1
        )
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(logoItb)
                )
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Limit alert!', style: defaultTextTheme.copyWith(
                  fontSize: 12,
                  fontWeight: light,
                )),
                Text('You\'ve almost reached your monthly\nspending budgets.', style: defaultTextTheme.copyWith(
                  fontSize: 10,
                  fontWeight: light,
                )),
              ],
            ),
        ],
      ),
    );
  }

  Widget balanceBox(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total Balance', style: defaultTextTheme.copyWith(
                fontSize: 24,
                fontWeight: medium,
              )),
              Row(
                  children: [
                    Text('Rp', style: defaultTextTheme.copyWith(
                      fontSize: 24,
                      fontWeight: medium,
                    )),
                    //TODO: make responsive
                    Text('12.345.678,00', style: defaultTextTheme.copyWith(
                      fontSize: 32,
                      fontWeight: medium,
                    )),
                  ],
              ),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget topBox(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      //TODO: Add limit alert conditionals
      if (state is AuthSuccess){
        return Container(
          color: blue,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: openingPlate(),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: limitAlert(),
              ),
              Container(
                child: balanceBox(),
              ),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget monthlyLimit(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1
              )
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 1
                    ),
                    image: DecorationImage(image: AssetImage(logoItb)
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Monthly Spending Limit', style: defaultTextTheme.copyWith(
                    fontSize: 12,
                    fontWeight: medium,
                  )),
                  Row(
                    children: [
                      Text('Rp', style: defaultTextTheme.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      )),
                      //TODO: make responsive
                      Text('12.345.678,00', style: defaultTextTheme.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      )),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(logoItb)
                    )
                ),
              ),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget income(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Container(
          width: (ScreenSize.width - 85)/2,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1
              )
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 1
                    ),
                    image: DecorationImage(image: AssetImage(logoItb)
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Income', style: defaultTextTheme.copyWith(
                    fontSize: 10,
                    fontWeight: medium,
                  )),
                  Row(
                    children: [
                      Text('Rp', style: defaultTextTheme.copyWith(
                        fontSize: 10,
                        fontWeight: medium,
                      )),
                      //TODO: make responsive
                      Text('12.345.678,00', style: defaultTextTheme.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget expenses(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      if (state is AuthSuccess){
        return Container(
          width: (ScreenSize.width - 85)/2,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1
              )
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5),
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: 1
                    ),
                    image: DecorationImage(image: AssetImage(logoItb)
                    )
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Expenses', style: defaultTextTheme.copyWith(
                    fontSize: 10,
                    fontWeight: medium,
                  )),
                  Row(
                    children: [
                      Text('Rp', style: defaultTextTheme.copyWith(
                        fontSize: 10,
                        fontWeight: medium,
                      )),
                      //TODO: make responsive
                      Text('12.345.678,00', style: defaultTextTheme.copyWith(
                        fontSize: 12,
                        fontWeight: medium,
                      )),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget dataBox(){
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state){
      //TODO: Add limit alert conditionals
      if (state is AuthSuccess){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: monthlyLimit(),
              ),
              Row(
                children: [
                  income(),
                  SizedBox(width: 5,),
                  expenses(),
                ],
              )
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  Widget spendingPlate(){
    return BlocBuilder<LogReaderCubit, LogReaderState>(builder: (context, state){
      if (state is LogReaderSuccess){
        int sum = getsumOfPastDays(state.logs, 0);
        String openingText = '';
        String subtext = '';
        if (sum > 0){
          openingText = "Today you have spent:";
          subtext = currencyForm(sum.abs().toString());
        } else if (sum < 0){
          openingText = "Today you have earned:";
          subtext = currencyForm(sum.abs().toString());
        } else{
          openingText = "How are you feeling today?";
        }

        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(openingText, style: defaultTextTheme.copyWith(
                fontSize: 16,
                fontWeight: light,
              )),
              SizedBox(height: 10,),
              Text(subtext, style: defaultTextTheme.copyWith(
                fontSize: 16,
                fontWeight: medium,
              )),
            ],
          ),
        );
      }

      else return SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        topBox(),
        dataBox(),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              spendingPlate(),
            ],
          ),
        )
      ],
    );
  }
}

