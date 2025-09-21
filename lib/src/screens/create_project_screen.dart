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
  
  // Controladores para os campos do formulário
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _justificationController = TextEditingController();
  final _objectivesController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _costController = TextEditingController();
  final _resourceSourceController = TextEditingController();
  
  // Variáveis de estado
  String _selectedThematicAxis = '01 - Sustentabilidade e Meio Ambiente';
  String _selectedProjectId = 'cat 1.01 - Recursos Inumanos';
  String _selectedYear = '';
  String _selectedPriority = '';
  bool _mandatoryInclusion = false;
  bool _mandatorySustainability = false;
  bool _isLoading = false;

  // Listas para dropdowns
  final List<String> _thematicAxisOptions = [
    '01 - Sustentabilidade e Meio Ambiente',
    '02 - Inovação e Tecnologia',
    '03 - Gestão e Processos',
  ];
  
  final List<String> _projectIdOptions = [
    'cat 1.01 - Recursos Inumanos',
    'cat 1.02 - Gestão de Resíduos',
    'cat 1.03 - Energia Renovável',
  ];
  
  final List<String> _yearOptions = [
    '2024',
    '2025',
    '2026',
  ];
  
  final List<String> _priorityOptions = [
    'Alta',
    'Média',
    'Baixa',
  ];
  
  // Listas para pessoas e etapas
  List<Map<String, dynamic>> _responsiblePeople = [];
  List<Map<String, dynamic>> _collaborators = [];
  List<Map<String, dynamic>> _projectSteps = [];
  List<Map<String, dynamic>> _problemSituations = [];

  @override
  void initState() {
    super.initState();
    _costController.text = 'R\$ 0,00';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _justificationController.dispose();
    _objectivesController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _costController.dispose();
    _resourceSourceController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        controller.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
      });
    }
  }

  void _addResponsiblePerson() {
    setState(() {
      _responsiblePeople.add({
        'name': '',
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }

  void _removeResponsiblePerson(String id) {
    setState(() {
      _responsiblePeople.removeWhere((person) => person['id'] == id);
    });
  }

  void _addCollaborator() {
    setState(() {
      _collaborators.add({
        'name': '',
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }

  void _removeCollaborator(String id) {
    setState(() {
      _collaborators.removeWhere((collaborator) => collaborator['id'] == id);
    });
  }

  void _addProjectStep() {
    setState(() {
      _projectSteps.add({
        'description': '',
        'deliverable': '',
        'referenceNumber': '',
        'plannedDate': '',
        'actualDate': '',
        'verification': '',
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }

  void _removeProjectStep(String id) {
    setState(() {
      _projectSteps.removeWhere((step) => step['id'] == id);
    });
  }

  void _addProblemSituation() {
    setState(() {
      _problemSituations.add({
        'situation': '',
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
      });
    });
  }

  void _removeProblemSituation(String id) {
    setState(() {
      _problemSituations.removeWhere((situation) => situation['id'] == id);
    });
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
          content: Text('Ação/Projeto registrado com sucesso!'),
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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/projects'),
        ),
        title: const Text(
          'Criar Novo Projeto',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const CircleAvatar(
              backgroundColor: Colors.red,
              child: Text(
                'A',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Título principal
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Criar Novo Projeto',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _selectedThematicAxis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Seção 1: Identificação do Projeto
              _buildSectionCard(
                'Identificação do Projeto',
                [
                  _buildDropdownField(
                    'Eixo Temático',
                    _selectedThematicAxis,
                    _thematicAxisOptions,
                    (value) => setState(() => _selectedThematicAxis = value!),
                    enabled: true,
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'ID/Tema do Projeto (Conforme PGA)',
                    _selectedProjectId,
                    _projectIdOptions,
                    (value) => setState(() => _selectedProjectId = value!),
                    enabled: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Nome do Projeto',
                    _nameController,
                    hintText: 'Digite o nome do projeto',
                  ),
                  const SizedBox(height: 16),
                  _buildDropdownField(
                    'Ano (PGA)',
                    _selectedYear,
                    _yearOptions,
                    (value) => setState(() => _selectedYear = value!),
                    hintText: 'Selecione o ano do PGA',
                  ),
                    const SizedBox(height: 16),
                  _buildDropdownField(
                    'Prioridade/Origem da Ação',
                    _selectedPriority,
                    _priorityOptions,
                    (value) => setState(() => _selectedPriority = value!),
                    hintText: 'Selecione a Prioridade/Origem',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 2: Descrições
              _buildSectionCard(
                'Descrições',
                [
                  _buildTextField(
                    'O que será feito (Descrição da Ação/Projeto)',
                    _descriptionController,
                    maxLines: 4,
                    hintText: 'Descreva detalhadamente o que será feito',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Por que será feito (Justificativa da Ação/Projeto)',
                    _justificationController,
                    maxLines: 4,
                    hintText: 'Explique a justificativa para esta ação/projeto',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    'Objetivos Institucionais Referenciados',
                    _objectivesController,
                    maxLines: 4,
                    hintText: 'Descreva os objetivos institucionais relacionados',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 3: Inclusão, Sustentabilidade e Datas
              _buildSectionCard(
                'Inclusão, Sustentabilidade e Datas',
                [
                  Row(
                    children: [
                      Checkbox(
                        value: _mandatoryInclusion,
                        onChanged: (value) => setState(() => _mandatoryInclusion = value!),
                      ),
                      const Expanded(
                        child: Text('Marque se a ação/projeto promove inclusão.'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _mandatorySustainability,
                        onChanged: (value) => setState(() => _mandatorySustainability = value!),
                      ),
                      const Expanded(
                        child: Text('Marque se a ação/projeto promove sustentabilidade.'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          'Início Previsto',
                          _startDateController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildDateField(
                           'Final Previsto',
                          _endDateController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 4: Pessoas Envolvidas
              _buildSectionCard(
                'Pessoas Envolvidas no Projeto',
                [
                  ..._responsiblePeople.map((person) => _buildPersonField(
                    'Responsável',
                    person,
                    _removeResponsiblePerson,
                  )),
                  if (_responsiblePeople.isEmpty)
                    _buildPersonField(
                      'Responsável #1',
                      {'name': '', 'id': 'temp'},
                      _removeResponsiblePerson,
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _addResponsiblePerson,
                          icon: const Icon(Icons.person_add, size: 18),
                          label: const Text('Adicionar Responsável'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _addCollaborator,
                          icon: const Icon(Icons.group_add, size: 18),
                          label: const Text('Adicionar Colaborador'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 5: Etapas do Projeto
              _buildSectionCard(
                'Etapas do Projeto/Processo',
                [
                  ..._projectSteps.map((step) => _buildProjectStepField(step)),
                  if (_projectSteps.isEmpty)
                    _buildProjectStepField({
                      'description': '',
                      'deliverable': '',
                      'referenceNumber': '',
                      'plannedDate': '',
                      'actualDate': '',
                      'verification': '',
                      'id': 'temp',
                    }),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      onPressed: _addProjectStep,
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Adicionar Etapa'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 6: Custos
              _buildSectionCard(
                'Informações de Custos',
                [
                  _buildTextField(
                    'Custo Estimado (R\$)',
                    _costController,
                    keyboardType: TextInputType.number,
                  ),
                    const SizedBox(height: 16),
                  _buildTextField(
                    'Fonte(s) dos Recursos',
                    _resourceSourceController,
                    hintText: 'Ex: Orçamento Institucional, Projeto Específico, etc.',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Seção 7: Situações Problema
              _buildSectionCard(
                'Situação Problema / Oportunidade de Melhoria Associada',
                [
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Selecionar situação problema...',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'situacao1', child: Text('Falta de recursos humanos')),
                      DropdownMenuItem(value: 'situacao2', child: Text('Processo ineficiente')),
                      DropdownMenuItem(value: 'situacao3', child: Text('Falta de capacitação')),
                      DropdownMenuItem(value: 'situacao4', child: Text('Problemas de comunicação')),
                      DropdownMenuItem(value: 'situacao5', child: Text('Falta de infraestrutura')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        // Aqui você pode adicionar lógica para gerenciar a situação selecionada
                      });
                    },
                    isExpanded: true,
                    menuMaxHeight: 200,
                    dropdownColor: Colors.white,
                    icon: const Icon(Icons.arrow_drop_down),
                    iconEnabledColor: Colors.grey[600],
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                    hint: const Text('Selecione uma situação'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _addProblemSituation,
                          icon: const Icon(Icons.add, size: 18),
                          label: const Text('Adicionar Situação'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.remove, size: 18),
                          label: const Text('Remover'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

                    const SizedBox(height: 32),

              // Botão de Registro
                    SizedBox(
                      width: double.infinity,
                height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                      : const Text(
                          'Registrar Ação/Projeto',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                ),
              ),

              const SizedBox(height: 20),
            ],
            ),
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

  Widget _buildSectionCard(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    int maxLines = 1,
    String? hintText,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    );
  }

  Widget _buildDropdownField(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged, {
    bool enabled = true,
    String? hintText,
  }) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: enabled ? onChanged : null,
      isExpanded: true,
      menuMaxHeight: 200,
      dropdownColor: Colors.white,
      icon: const Icon(Icons.arrow_drop_down),
      iconEnabledColor: enabled ? Colors.grey[600] : Colors.grey[400],
      style: TextStyle(
        color: enabled ? Colors.black87 : Colors.grey[600],
        fontSize: 16,
      ),
    );
  }

  Widget _buildDateField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: 'dd/mm/aaaa',
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(controller),
        ),
      ),
      readOnly: true,
    );
  }

  Widget _buildPersonField(
    String label,
    Map<String, dynamic> person,
    Function(String) onRemove,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: person['name']?.isNotEmpty == true ? person['name'] : null,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              items: const [
                DropdownMenuItem(value: 'pessoa1', child: Text('João Silva')),
                DropdownMenuItem(value: 'pessoa2', child: Text('Maria Santos')),
                DropdownMenuItem(value: 'pessoa3', child: Text('Pedro Oliveira')),
                DropdownMenuItem(value: 'pessoa4', child: Text('Ana Costa')),
                DropdownMenuItem(value: 'pessoa5', child: Text('Carlos Lima')),
              ],
              onChanged: (value) {
                setState(() {
                  person['name'] = value;
                });
              },
              isExpanded: true,
              menuMaxHeight: 200,
              dropdownColor: Colors.white,
              icon: const Icon(Icons.arrow_drop_down),
              iconEnabledColor: Colors.grey[600],
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              hint: const Text('Selecione uma pessoa'),
            ),
          ),
          if (person['id'] != 'temp')
            IconButton(
              icon: const Icon(Icons.close, color: Colors.red),
              onPressed: () => onRemove(person['id']),
            ),
        ],
      ),
    );
  }

  Widget _buildProjectStepField(Map<String, dynamic> step) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Etapa #${_projectSteps.indexOf(step) + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              if (step['id'] != 'temp')
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () => _removeProjectStep(step['id']),
                ),
            ],
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Descrição da Etapa',
            TextEditingController(text: step['description']),
            maxLines: 3,
            hintText: 'Descreva a etapa do projeto',
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: step['deliverable']?.isNotEmpty == true ? step['deliverable'] : null,
            decoration: const InputDecoration(
              labelText: 'Entregável (link/SEI)',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            items: const [
              DropdownMenuItem(value: 'entregavel1', child: Text('Relatório Técnico')),
              DropdownMenuItem(value: 'entregavel2', child: Text('Apresentação PowerPoint')),
              DropdownMenuItem(value: 'entregavel3', child: Text('Documento SEI')),
              DropdownMenuItem(value: 'entregavel4', child: Text('Planilha de Dados')),
              DropdownMenuItem(value: 'entregavel5', child: Text('Manual de Procedimentos')),
            ],
            onChanged: (value) {
              setState(() {
                step['deliverable'] = value;
              });
            },
            isExpanded: true,
            menuMaxHeight: 200,
            dropdownColor: Colors.white,
            icon: const Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.grey[600],
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            hint: const Text('Selecione o entregável'),
          ),
          const SizedBox(height: 12),
          _buildTextField(
            'Número de Referência',
            TextEditingController(text: step['referenceNumber']),
          ),
          const SizedBox(height: 12),
          _buildDateField(
            'Data Verificação Prevista',
            TextEditingController(text: step['plannedDate']),
          ),
          const SizedBox(height: 12),
          _buildDateField(
            'Data Verificação Realizada',
            TextEditingController(text: step['actualDate']),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Verificação: '),
              Row(
                children: [
                  Radio<String>(
                    value: 'OK',
                    groupValue: step['verification'],
                    onChanged: (value) {
                      setState(() {
                        step['verification'] = value;
                      });
                    },
                  ),
                  const Text('OK'),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Radio<String>(
                    value: 'Requer Ação',
                    groupValue: step['verification'],
                    onChanged: (value) {
                      setState(() {
                        step['verification'] = value;
                      });
                    },
                  ),
                  const Text('Requer Ação'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
