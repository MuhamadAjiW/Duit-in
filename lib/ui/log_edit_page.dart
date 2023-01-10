import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/auth_cubit.dart';
import 'package:duit.in/cubit/log_cubit.dart';

import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/widgets/customtextbutton.dart';

class EditLogPage extends StatefulWidget{
  final String keterangan;
  final int nilai;
  final DateTime waktu;
  final String notes;
  const EditLogPage(
      {Key? key,
        required this.keterangan,
        required this.nilai,
        required this.waktu,
        required this.notes,
      }) : super(key: key);

  @override
  State<EditLogPage> createState() => _AddLogState();
}

class _AddLogState extends State<EditLogPage>{
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
            child: Text('Edit Log', style: defaultTextTheme.copyWith(
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
                if (notesController.text.isEmpty){
                  context.read<LogCubit>().editLog(
                    oldUid: uid,
                    nilaiRaw: valController.text,
                    oldWaktu: this.widget.waktu,
                    keterangan: _selectedKet,
                    notes: ' - ',
                  );
                }
                else{
                  context.read<LogCubit>().editLog(
                    oldUid: uid,
                    nilaiRaw: valController.text,
                    oldWaktu: this.widget.waktu,
                    keterangan: _selectedKet,
                    notes: notesController.text,
                  );
                }
                context.read<LogReaderCubit>().readLogs(uid);
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
              content: Text("Log edited successfully"),
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
  void initState(){
    _selectedKet = widget.keterangan;
    valController.text = this.widget.nilai.toString();
    notesController.text = this.widget.notes;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: openingPlate(),
            ),
            Container(
              width: double.infinity,
              child: Column(
                children: [
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
          ],
        )
    );
  }

}
