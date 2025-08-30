import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({super.key});

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _responsibleController = TextEditingController();
  final _deadlineController = TextEditingController();
  String _selectedStatus = 'Em andamento';
  int _progress = 0;
  bool _isLoading = false;

  final List<String> _statusOptions = [
    'Em andamento',
    'Concluído',
    'Atrasado',
    'Pendente',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _responsibleController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _deadlineController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // Simular criação do projeto
    await Future.delayed(const Duration(milliseconds: 1500));

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
      
      // Mostrar mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Projeto criado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Voltar para a tela anterior
      context.go('/projects');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Criar Projeto'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do Projeto
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Projeto',
                        prefixIcon: Icon(Icons.work),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o nome do projeto';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Descrição
                    TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                        prefixIcon: Icon(Icons.description),
                      ),
                      maxLines: 3,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira uma descrição';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Responsável
                    TextFormField(
                      controller: _responsibleController,
                      decoration: const InputDecoration(
                        labelText: 'Responsável',
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira o responsável';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Status
                    DropdownButtonFormField<String>(
                      initialValue: _selectedStatus,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                        prefixIcon: Icon(Icons.flag),
                      ),
                      items: _statusOptions.map((status) {
                        return DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedStatus = value!;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Prazo
                    TextFormField(
                      controller: _deadlineController,
                      decoration: InputDecoration(
                        labelText: 'Prazo',
                        prefixIcon: const Icon(Icons.calendar_today),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.date_range),
                          onPressed: _selectDate,
                        ),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, selecione o prazo';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Progresso
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Progresso: $_progress%',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _progress.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 20,
                          activeColor: AppTheme.primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _progress = value.round();
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('0%'),
                            Text('100%'),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Botão de Envio
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text('Criar Projeto'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Navegação inferior
      bottomNavigationBar: BottomNavigation(
        currentRoute: '/create-project',
        onNavigate: (route) {
          if (route == '/create-project') return;
          context.go(route);
        },
      ),
    );
  }
}
