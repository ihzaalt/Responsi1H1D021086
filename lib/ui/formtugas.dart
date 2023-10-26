import 'package:flutter/material.dart';
import 'package:responsi1H1D021086/bloc/tugas_bloc.dart';
import 'package:responsi1H1D021086/model/tugas.dart';
import 'package:responsi1H1D021086/ui/halamantugas.dart';
import 'package:responsi1H1D021086/widget/warning_dialog.dart';

class TugasForm extends StatefulWidget {
  Tugas? tugas;

  TugasForm({Key? key, this.tugas}) : super(key: key);

  @override
  _TugasFormState createState() => _TugasFormState();
}

class _TugasFormState extends State<TugasForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "Tambah Tugas";
  String tombolSubmit = "Submit";

  final _titleTextboxController = TextEditingController();
  final _descriptionTextboxController = TextEditingController();
  final _deadlineTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  isUpdate() {
    if (widget.tugas != null) {
      setState(() {
        judul = "Edit Tugas";
        tombolSubmit = "Submit";
        _titleTextboxController.text = widget.tugas!.title!;
        _descriptionTextboxController.text = widget.tugas!.description!;
        _deadlineTextboxController.text = widget.tugas!.deadline!;
      });
    } else {
      judul = "TTambah Tugas";
      tombolSubmit = "Submit";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _judulTextField(),
                _descriptionTextField(),
                _deadlineTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _judulTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Judul Tugas"),
      keyboardType: TextInputType.text,
      controller: _titleTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Mohon isi judul tugas";
        }
        return null;
      },
    );
  }

  Widget _descriptionTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deskripsi Tugas"),
      keyboardType: TextInputType.text,
      controller: _descriptionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Mohon isi deskripsi tugas";
        }
        return null;
      },
    );
  }

  Widget _deadlineTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Deadline Tugas"),
      keyboardType: TextInputType.text,
      controller: _deadlineTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Mohon isi deadline tugas";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return OutlinedButton(
      child: Text(tombolSubmit),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) {
            simpan();
          }
        }
      },
    );
  }

  simpan() {
    setState(() {
      _isLoading = true;
    });

    Tugas createTugas = Tugas(id: null);
    createTugas.title = _titleTextboxController.text;
    createTugas.description = _descriptionTextboxController.text;
    createTugas.deadline = _deadlineTextboxController.text;

    TugasBloc.addTugas(tugas: createTugas).then((value) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context) => const TugasPage(),
      ));
    }, onError: (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const WarningDialog(
          description: "Simpan gagal, silahkan coba lagi",
        ),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  // ubah() {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   Tugas updateTugas = Tugas(id: null);
  //   updateTugas.id = widget.tugas!.id;
  //   updateTugas.title = _titleTextboxController.text;
  //   updateTugas.description = _descriptionTextboxController.text;
  //   updateTugas.deadline = _deadlineTextboxController.text;

  //   TugasBloc.updateTugas(tugas: updateTugas).then((value) {
  //     Navigator.of(context).push(MaterialPageRoute(
  //       builder: (BuildContext context) => const TugasPage(),
  //     ));
  //   }, onError: (error) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) => const WarningDialog(
  //         description: "Permintaan ubah data gagal, silahkan coba lagi",
  //       ),
  //     );
  //   });

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }
}
