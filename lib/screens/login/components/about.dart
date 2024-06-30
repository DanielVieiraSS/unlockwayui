import 'package:flutter/material.dart';
import 'package:unlockway/components/navigation.dart';
import 'package:unlockway/screens/home/home.dart';

class AboutCover extends StatelessWidget {
  const AboutCover({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  navigationPageRightAnimation(
                    const Home(),
                  ),
                );
              },
              child: Text(
                'Pular',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/imgs/image1.png'),
              const SizedBox(height: 15),
              Text(
                textAlign: TextAlign.center,
                'Unlockway é um gerenciador\n inteligente de rotina alimentar e de\n exercícios físicos que te ajudará a \n desenvolver hábitos positivos e\n alcançar sua melhor forma.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.10,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Page2Content extends StatelessWidget {
  const Page2Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  navigationPageRightAnimation(
                    const Home(),
                  ),
                );
              },
              child: Text(
                'Pular',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/imgs/image2.png', // Altere o caminho da imagem
                width: 150, // Largura da imagem reduzida
                height: 150, // Altura da imagem reduzida
              ),
              const SizedBox(
                  height: 80), // Espaçamento vertical entre a imagem e o texto
              Text(
                textAlign: TextAlign.center,
                'Utilizamos de uma inteligência artificial\n para gerar as melhores recomendações\n alimentares para você.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.10,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Page3Content extends StatelessWidget {
  const Page3Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  navigationPageRightAnimation(
                    const Home(),
                  ),
                );
              },
              child: Text(
                'Pular',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/imgs/image3.png', // Altere o caminho da imagem
                width: 150, // Largura da imagem reduzida
                height: 150, // Altura da imagem reduzida
              ),
              const SizedBox(
                  height: 80), // Espaçamento vertical entre a imagem e o texto
              Text(
                textAlign: TextAlign.center,
                'Receba notificações em tempo real\n para se lembrar de se alimentar bem.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.10,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Page4Content extends StatelessWidget {
  const Page4Content({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  navigationPageRightAnimation(
                    const Home(),
                  ),
                );
              },
              child: Text(
                'Fechar',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/imgs/image4.png', // Altere o caminho da imagem
                width: 150, // Largura da imagem reduzida
                height: 150, // Altura da imagem reduzida
              ),
              const SizedBox(
                  height: 80), // Espaçamento vertical entre a imagem e o texto
              Text(
                textAlign: TextAlign.center,
                'Acompanha sua porcentagem de\n progresso conforme gerencia seus\n melhores hábitos.', // Altere o texto
                style: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                  height: 1.10,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int currentIndex = 0;
  final PageController pageController = PageController();
  final List<Widget> contentList = [
    const AboutCover(), // Página 0
    const Page2Content(), // Página 1
    const Page3Content(), // Página 2
    const Page4Content(), // Página 3
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0) {
            // Swiping right
            if (currentIndex > 0) {
              currentIndex--;
              pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          } else {
            // Swiping left
            if (currentIndex < contentList.length - 1) {
              currentIndex++;
              pageController.nextPage(
                duration: const Duration(milliseconds: 400),
                curve: Curves.ease,
              );
            }
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/imgs/about_bg.png', // Altere o caminho da imagem
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.90),
            ),
            PageView(
              controller: pageController,
              children: contentList,
              onPageChanged: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
            Positioned(
              bottom: 50,
              left: 50,
              right: 50,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 4; i++)
                      Container(
                        width: 19,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 0.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: currentIndex == i
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.outline,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
