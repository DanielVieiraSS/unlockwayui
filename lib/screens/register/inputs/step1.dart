import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';
import 'package:unlockway/components/text_field.dart';
import 'package:unlockway/constants.dart';

typedef GoalsCallback = void Function(List<String> goals);
typedef BiotypeCallback = void Function(String? biotype);
typedef SexCallback = void Function(String? sex);

class RegisterStep1 extends StatelessWidget {
  const RegisterStep1({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.weightController,
    required this.heightController,
    required this.biotype,
    required this.goals,
    required this.sex,
    required this.onChangeBiotype,
    required this.onChangeGoals,
    required this.onChangeSex,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController weightController;
  final TextEditingController heightController;
  final String biotype;
  final String sex;
  final List<String> goals;

  final BiotypeCallback onChangeBiotype;
  final GoalsCallback onChangeGoals;
  final SexCallback onChangeSex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GenericTextField(
          placeholder: "Insira seu nome, ex: Marcela",
          title: "Nome",
          width: double.infinity,
          number: false,
          controller: firstNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        GenericTextField(
          placeholder: "Insira seu sobrenome, ex: Fernandes",
          title: "Sobrenome",
          width: double.infinity,
          number: false,
          controller: lastNameController,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Flexible(
              child: GenericTextField(
                placeholder: "Ex: 88",
                title: "Peso",
                width: 200,
                controller: weightController,
                number: true,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Flexible(
              child: GenericTextField(
                placeholder: "Ex: 1,70",
                title: "Altura",
                width: 200,
                controller: heightController,
                number: true,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
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
            dropdownColor: Theme.of(context).colorScheme.onSurface,
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
            onChanged: onChangeSex,
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
        const SizedBox(
          height: 20,
        ),
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
          onChanged: onChangeGoals,
          options: const [
            'Manter saúde',
            'Perder peso',
            'Ganhar músculo',
          ],
          selectedValues: goals,
          whenEmpty: 'Diga-nos qual seu objetivo',
        ),
        const SizedBox(height: 20),
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
            dropdownColor: Theme.of(context).colorScheme.onSurface,
            hint: const Text("EX: Endomorfo"),
            borderRadius: BorderRadius.circular(6),
            isExpanded: true,
            value: biotype,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(
              color: Theme.of(context).colorScheme.outline,
              fontSize: 16,
              fontFamily: "Inter",
            ),
            onChanged: onChangeBiotype,
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
            ],
          ),
        ),
      ],
    );
  }
}
