import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoSaveEnabled = true;
  String _selectedLanguage = 'Português';
  double _fontSize = 16.0;

  final List<String> _languageOptions = [
    'Português',
    'English',
    'Español',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção de Notificações
            _buildSection(
              title: 'Notificações',
              icon: Icons.notifications,
              children: [
                SwitchListTile(
                  title: const Text('Ativar notificações'),
                  subtitle: const Text('Receber alertas sobre projetos'),
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Seção de Aparência
            _buildSection(
              title: 'Aparência',
              icon: Icons.palette,
              children: [
                SwitchListTile(
                  title: const Text('Modo escuro'),
                  subtitle: const Text('Usar tema escuro'),
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                ListTile(
                  title: const Text('Tamanho da fonte'),
                  subtitle: Text('${_fontSize.round()}px'),
                  trailing: SizedBox(
                    width: 200,
                    child: Slider(
                      value: _fontSize,
                      min: 12,
                      max: 24,
                      divisions: 12,
                      activeColor: AppTheme.primaryColor,
                      onChanged: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Seção de Sistema
            _buildSection(
              title: 'Sistema',
              icon: Icons.settings,
              children: [
                SwitchListTile(
                  title: const Text('Salvamento automático'),
                  subtitle: const Text('Salvar alterações automaticamente'),
                  value: _autoSaveEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoSaveEnabled = value;
                    });
                  },
                ),
                ListTile(
                  title: const Text('Idioma'),
                  subtitle: Text(_selectedLanguage),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _showLanguageDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Seção de Conta
            _buildSection(
              title: 'Conta',
              icon: Icons.account_circle,
              children: [
                ListTile(
                  title: const Text('Perfil'),
                  subtitle: const Text('Editar informações pessoais'),
                  leading: const Icon(Icons.person),
                  onTap: () {
                    // Navegar para perfil
                  },
                ),
                ListTile(
                  title: const Text('Alterar senha'),
                  subtitle: const Text('Modificar senha de acesso'),
                  leading: const Icon(Icons.lock),
                  onTap: () {
                    // Navegar para alterar senha
                  },
                ),
                ListTile(
                  title: const Text('Sair'),
                  subtitle: const Text('Fazer logout da aplicação'),
                  leading: const Icon(Icons.logout),
                  onTap: () {
                    _showLogoutDialog();
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Seção de Sobre
            _buildSection(
              title: 'Sobre',
              icon: Icons.info,
              children: [
                ListTile(
                  title: const Text('Versão'),
                  subtitle: const Text('1.0.0'),
                  leading: const Icon(Icons.info_outline),
                ),
                ListTile(
                  title: const Text('Política de Privacidade'),
                  subtitle: const Text('Ler política de privacidade'),
                  leading: const Icon(Icons.privacy_tip),
                  onTap: () {
                    // Abrir política de privacidade
                  },
                ),
                ListTile(
                  title: const Text('Termos de Uso'),
                  subtitle: const Text('Ler termos de uso'),
                  leading: const Icon(Icons.description),
                  onTap: () {
                    // Abrir termos de uso
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Informações da Instituição
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      'Fatec Votorantim',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sistema de Gestão de Projetos Acadêmicos',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '© 2025 Todos os direitos reservados',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.center,
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
        currentRoute: 'Settings',
        onNavigate: (route) {
          if (route == 'Settings') return;
          context.go('/$route');
        },
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.primaryColor),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecionar Idioma'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languageOptions.map((language) {
            return RadioListTile<String>(
              title: Text(language),
              value: language,
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair'),
        content: const Text('Tem certeza que deseja sair da aplicação?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.go('/');
            },
            child: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
