import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect/multiselect.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:unlockway/components/text_field.dart';
import 'package:unlockway/constants.dart';
import 'package:unlockway/handlers/user.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.weight,
    required this.height,
    required this.goals,
    required this.email,
    required this.biotype,
    required this.password,
    required this.sex,
    required this.userPhoto,
  });

  final String firstname;
  final String lastname;
  final double weight;
  final double height;
  final String sex;
  final List<String> goals;
  final String email;
  final String biotype;
  final String password;
  final String? userPhoto;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  var user = userData;

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final pesoController = TextEditingController();
  final alturaController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  List<String> goals = [];
  String sex = "MALE";
  String biotype = 'ECTOMORPH';

  String selectedImagePath = '';

  @override
  void initState() {
    super.initState();
    biotype = widget.biotype;
    sex = widget.sex;
    firstnameController.text = widget.firstname;
    lastnameController.text = widget.lastname;
    emailController.text = widget.email;
    alturaController.text = widget.height.toString();
    pesoController.text = widget.weight.toString();
    goals = widget.goals;
  }

  void onBiotypeChange(String? newBiotype) {
    setState(() {
      biotype = newBiotype!;
    });
  }

  void onGoalsChange(List<String> newGoals) {
    setState(() {
      goals = newGoals;
    });
  }

  void onSexChange(String? newSex) {
    setState(() {
      sex = newSex!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(PhosphorIcons.caretLeft(PhosphorIconsStyle.regular)),
        ),
        iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.outline, size: 32.0),
        title: Text(
          "Perfil".toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              updateUserDataHandler(
                context,
                userData.id!,
                userData.token!,
                firstnameController.text,
                lastnameController.text,
                emailController.text,
                senhaController.text,
                double.parse(alturaController.text),
                double.parse(pesoController.text),
                goals,
                biotype,
                sex,
              ).then((value) {
                if (selectedImagePath.isNotEmpty) {
                  applyUserPhotoHandler(
                    context,
                    File(selectedImagePath),
                    user.id!,
                    user.token!,
                  );
                }
              });
            },
            child: Text(
              "Salvar".toUpperCase(),
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Inter",
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  userPhotoModal(
                    context,
                  );
                },
                child: selectedImagePath.isNotEmpty
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            clipBehavior: Clip.hardEdge,
                            child: Positioned(
                              child: Image.file(
                                File(selectedImagePath),
                                fit: BoxFit.cover,
                                width: 180,
                                height: 180,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color:
                                    Theme.of(context).colorScheme.onSurface,
                              ),
                              child: IconButton(
                                iconSize: 34.0,
                                onPressed: () {
                                  setState(() {
                                    selectedImagePath = '';
                                  });
                                },
                                icon: Icon(
                                  PhosphorIcons.trash(
                                    PhosphorIconsStyle.duotone,
                                  ),
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : widget.userPhoto!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            clipBehavior: Clip.hardEdge,
                            child: CachedNetworkImage(
                              imageUrl: widget.userPhoto!,
                              fit: BoxFit.cover,
                              width: 180,
                              height: 180,
                              placeholder: (context, url) => CircleAvatar(
                                backgroundColor: Color(primary),
                                child: Text(
                                  (user.firstName!.substring(0, 1) +
                                          user.lastName!.substring(0, 1))
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontFamily: "Inter",
                                    fontSize: 44.0,
                                    color: Color(dark),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 180,
                            height: 180,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(primary),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Text(
                              (user.firstName!.substring(0, 1) +
                                      user.lastName!.substring(0, 1))
                                  .toUpperCase(),
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 44.0,
                                color: Color(dark),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GenericTextField(
                      title: "Nome",
                      placeholder: "Insira seu nome aqui",
                      width: double.infinity,
                      controller: firstnameController,
                      number: false,
                    ),
                    const SizedBox(height: 16.0),
                    GenericTextField(
                      title: "Sobrenome",
                      placeholder: "Insira seu sobrenome aqui",
                      width: double.infinity,
                      controller: lastnameController,
                      number: false,
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: GenericTextField(
                            title: "Peso",
                            placeholder: "KG",
                            width: double.infinity,
                            controller: pesoController,
                            number: true,
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Expanded(
                          child: GenericTextField(
                            title: "Altura",
                            placeholder: "0,00",
                            width: double.infinity,
                            controller: alturaController,
                            number: true,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Sexo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: DropdownButton<String>(
                        dropdownColor:
                            Theme.of(context).colorScheme.onSurface,
                        borderRadius: BorderRadius.circular(6),
                        isExpanded: true,
                        value: sex,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.outline,
                          fontSize: 16,
                          fontFamily: "Inter",
                        ),
                        onChanged: onSexChange,
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'MALE',
                            child: Text('Homem'),
                          ),
                          DropdownMenuItem(
                            value: 'FEMALE',
                            child: Text('Mulher'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Meta",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: 5),
                    DropDownMultiSelect(
                      decoration: InputDecoration(
                        hintStyle: const TextStyle(
                          color: Color(0xFF616B7C),
                          fontFamily: "Inter",
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSurface,
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(darkBgdark),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(primarydark),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.onSurface,
                        focusColor: Theme.of(context).colorScheme.onSurface,
                      ),
                      enabled: true,
                      selectedValuesStyle: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      onChanged: onGoalsChange,
                      options: const [
                        'Manter saúde',
                        'Perder peso',
                        'Ganhar músculo',
                      ],
                      selectedValues: goals,
                      whenEmpty: 'Diga-nos qual seu objetivo',
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      "Biotipo",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 16,
                        fontFamily: "Inter",
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      child: DropdownButton<String>(
                          dropdownColor:
                              Theme.of(context).colorScheme.onSurface,
                          hint: const Text("EX: Endomorfo"),
                          borderRadius: BorderRadius.circular(6),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 16,
                            fontFamily: "Inter",
                          ),
                          value: biotype,
                          onChanged: onBiotypeChange,
                          underline: Container(
                            color: Colors.transparent,
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'ECTOMORPH',
                              child: Text('Ectomorfo'),
                            ),
                            DropdownMenuItem(
                              value: 'ENDOMORPH',
                              child: Text('Endomorfo'),
                            ),
                            DropdownMenuItem(
                              value: 'MESOMORPH',
                              child: Text('Mesomorfo'),
                            ),
                          ]),
                    ),
                    const SizedBox(height: 24.0),
                    GenericTextField(
                      title: "E-mail",
                      placeholder: "Insira seu E-mail aqui",
                      width: double.infinity,
                      controller: emailController,
                      number: false,
                    ),
                    const SizedBox(height: 16.0),
                    GenericTextField(
                      title: "Nova Senha",
                      placeholder: "Digite nova senha",
                      width: double.infinity,
                      controller: senhaController,
                      number: false,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      "© unlockway 2023",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  pickFromCamera() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  pickFromGallery() async {
    XFile? file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (file != null) {
      return file.path;
    } else {
      return '';
    }
  }

  Future<void> userPhotoModal(BuildContext context) async {
    return showModalBottomSheet<void>(
      enableDrag: true,
      context: context,
      useSafeArea: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: 180,
              height: 6,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () async {
                      selectedImagePath = await pickFromCamera();

                      if (selectedImagePath != '') {
                        setState(() {});
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              PhosphorIcons.camera(PhosphorIconsStyle.regular),
                              size: 60.0,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Tirar Foto",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  InkWell(
                    onTap: () async {
                      selectedImagePath = await pickFromGallery();

                      if (selectedImagePath != '') {
                        setState(() {});
                      } else {}
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      height: 95,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onSurface,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              PhosphorIcons.images(PhosphorIconsStyle.regular),
                              size: 60.0,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                          ),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              "Foto da Galeria",
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
