import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/auth_cubit.dart';
import 'package:liburan/cubit/log_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/widgets/customtextbutton.dart';

class AddLogPage extends StatefulWidget{
  const AddLogPage({Key? key}) : super(key: key);

  @override
  State<AddLogPage> createState() => _AddLogState();
}

class _AddLogState extends State<AddLogPage>{
  final TextEditingController valController = TextEditingController(text: '');
  final TextEditingController notesController = TextEditingController(text: '');

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
            child: Text('Add Log', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget inputVal() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: valController,
          obscureText: false,
          cursorColor: black,
          decoration: InputDecoration(
              hintText: 'Nilai pengeluaran',
              hintStyle: defaultTextTheme,
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15))
              )
          ),
        )
    );
  }

  String _selectedKet = 'Makanan';
  void dropdownCallback(String? selectedValue){
    if (selectedValue is String){
      setState(() {
        _selectedKet = selectedValue;
      });
    }
  }
  Widget keteranganCatalog(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: gray,
              width: 1
          )
      ),
      child: DropdownButton(
          isExpanded: true,
          value: _selectedKet,
          items: const [
            DropdownMenuItem(child: Text('   Makanan'), value: 'Makanan',),
            DropdownMenuItem(child: Text('   Transport'), value: 'Transport',),
            DropdownMenuItem(child: Text('   Housekeeping'), value: 'Housekeeping',),
            DropdownMenuItem(child: Text('   Internet'), value: 'Internet',),
            DropdownMenuItem(child: Text('   Bulanan'), value: 'Bulanan',),
            DropdownMenuItem(child: Text('   Lain-lain'), value: 'Lain-lain',),
            DropdownMenuItem(child: Text('   Pendapatan'), value: 'Pendapatan',),
          ],
          onChanged: dropdownCallback),
    );
  }

  Widget addNotes() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: TextFormField(
          controller: notesController,
          obscureText: false,
          cursorColor: black,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              hintText: 'Notes (optional)',
              hintStyle: defaultTextTheme,
              border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15))
              )
          ),
        )
    );
  }

  Widget submitLogButton(){
    return BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state){
          if (state is AuthSuccess){
            return submitLogButtonPrep(state.user.uid);
          }
          else{
            return nullWidget;
          }
        },
        listener: (context, state){}
    );
  }

  Widget submitLogButtonPrep(String uid){
    return BlocConsumer<LogCubit, LogState>(
        builder: (context, state){
          if (state is LogLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is LogInitial){
            return CustomTextButton(
              widthVal: 300,
              heightVal: 50,
              buttonColor: Colors.transparent,
              text: 'Save',
              textSize: 12,
              textColor: black,
              onPressed: (){
                context.read<LogCubit>().addLog(
                  uid: uid,
                  nilaiRaw: valController.text,
                  waktu: DateTime.now(),
                  keterangan: _selectedKet,
                  notes: notesController.text,
                );
              },
            );
          }
          else{
            return CustomTextButton(
              widthVal: 300,
              heightVal: 50,
              buttonColor: Colors.transparent,
              text: 'Save',
              textSize: 12,
              textColor: black,
              onPressed: (){
                print("Please wait...");
              },
            );
          }
        },
        listener: (context, state){
          if (state is LogSuccess){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Log added successfully"),
              backgroundColor: green,
            ));
          } else if (state is LogFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
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
              SizedBox(height: 30,),
              inputVal(),
              SizedBox(height: 30,),
              keteranganCatalog(),
              SizedBox(height: 30,),
              addNotes(),
              SizedBox(height: 30,),
              submitLogButton(),
            ],
          ),
        )
    );
  }
}
