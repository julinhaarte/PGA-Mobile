import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  Switch,
  Alert,
} from 'react-native';
import {
  Text,
  List,
  Divider,
  Button,
  useTheme,
  Card,
} from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { BottomNavigation } from '../components/BottomNavigation';

export const SettingsScreen: React.FC = () => {
  const [notifications, setNotifications] = useState(true);
  const [darkMode, setDarkMode] = useState(false);
  const [autoSync, setAutoSync] = useState(true);
  const [biometric, setBiometric] = useState(false);
  
  const theme = useTheme();

  const handleLogout = () => {
    Alert.alert(
      'Sair',
      'Tem certeza que deseja sair da aplicação?',
      [
        {
          text: 'Cancelar',
          style: 'cancel',
        },
        {
          text: 'Sair',
          style: 'destructive',
          onPress: () => {
            // Aqui você implementaria a lógica de logout
            console.log('Logout realizado');
          },
        },
      ]
    );
  };

  const handleClearCache = () => {
    Alert.alert(
      'Limpar Cache',
      'Isso irá remover todos os dados temporários. Continuar?',
      [
        {
          text: 'Cancelar',
          style: 'cancel',
        },
        {
          text: 'Limpar',
          style: 'destructive',
          onPress: () => {
            // Implementar limpeza de cache
            Alert.alert('Sucesso', 'Cache limpo com sucesso!');
          },
        },
      ]
    );
  };

  const settingsSections = [
    {
      title: 'Notificações',
      items: [
        {
          title: 'Notificações Push',
          subtitle: 'Receber notificações sobre projetos',
          icon: 'bell',
          type: 'switch',
          value: notifications,
          onValueChange: setNotifications,
        },
        {
          title: 'Lembretes',
          subtitle: 'Lembretes de deadlines',
          icon: 'clock',
          type: 'switch',
          value: notifications,
          onValueChange: setNotifications,
        },
      ],
    },
    {
      title: 'Aparência',
      items: [
        {
          title: 'Modo Escuro',
          subtitle: 'Usar tema escuro',
          icon: 'theme-light-dark',
          type: 'switch',
          value: darkMode,
          onValueChange: setDarkMode,
        },
        {
          title: 'Tamanho da Fonte',
          subtitle: 'Ajustar tamanho do texto',
          icon: 'format-size',
          type: 'navigate',
          onPress: () => Alert.alert('Tamanho da Fonte', 'Funcionalidade em desenvolvimento'),
        },
      ],
    },
    {
      title: 'Sincronização',
      items: [
        {
          title: 'Sincronização Automática',
          subtitle: 'Sincronizar dados automaticamente',
          icon: 'sync',
          type: 'switch',
          value: autoSync,
          onValueChange: setAutoSync,
        },
        {
          title: 'Sincronizar Agora',
          subtitle: 'Forçar sincronização manual',
          icon: 'sync-circle',
          type: 'action',
          onPress: () => Alert.alert('Sincronização', 'Sincronizando dados...'),
        },
      ],
    },
    {
      title: 'Segurança',
      items: [
        {
          title: 'Login Biométrico',
          subtitle: 'Usar impressão digital ou Face ID',
          icon: 'fingerprint',
          type: 'switch',
          value: biometric,
          onValueChange: setBiometric,
        },
        {
          title: 'Alterar Senha',
          subtitle: 'Modificar senha de acesso',
          icon: 'lock',
          type: 'navigate',
          onPress: () => Alert.alert('Alterar Senha', 'Funcionalidade em desenvolvimento'),
        },
      ],
    },
  ];

  const renderSettingItem = (item: any) => {
    const { title, subtitle, icon, type, value, onValueChange, onPress } = item;

    if (type === 'switch') {
      return (
        <List.Item
          key={title}
          title={title}
          description={subtitle}
          left={(props) => (
            <List.Icon {...props} icon={icon} color={theme.colors.primary} />
          )}
          right={() => (
            <Switch
              value={value}
              onValueChange={onValueChange}
              trackColor={{ false: '#e0e0e0', true: theme.colors.primary }}
              thumbColor={value ? '#ffffff' : '#f4f3f4'}
            />
          )}
          style={styles.settingItem}
        />
      );
    }

    return (
      <List.Item
        key={title}
        title={title}
        description={subtitle}
        left={(props) => (
          <List.Icon {...props} icon={icon} color={theme.colors.primary} />
        )}
        right={(props) => (
          <List.Icon {...props} icon="chevron-right" color={theme.colors.onSurfaceVariant} />
        )}
        onPress={onPress}
        style={styles.settingItem}
      />
    );
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollView}>
        {/* Header */}
        <Card style={styles.headerCard}>
          <Card.Content style={styles.headerContent}>
            <View style={styles.profileSection}>
              <View style={styles.avatar}>
                <MaterialCommunityIcons
                  name="account"
                  size={32}
                  color={theme.colors.primary}
                />
              </View>
              <View style={styles.profileInfo}>
                <Text style={styles.profileName} variant="titleLarge">
                  Usuário PGA
                </Text>
                <Text style={styles.profileEmail} variant="bodyMedium">
                  usuario@fatec.sp.gov.br
                </Text>
                <Text style={styles.profileRole} variant="bodySmall">
                  Administrador
                </Text>
              </View>
            </View>
          </Card.Content>
        </Card>

        {/* Configurações */}
        {settingsSections.map((section, sectionIndex) => (
          <View key={section.title}>
            <Text style={styles.sectionTitle} variant="titleMedium">
              {section.title}
            </Text>
            <Card style={styles.sectionCard}>
              {section.items.map((item, itemIndex) => (
                <View key={item.title}>
                  {renderSettingItem(item)}
                  {itemIndex < section.items.length - 1 && <Divider />}
                </View>
              ))}
            </Card>
            {sectionIndex < settingsSections.length - 1 && (
              <View style={styles.sectionSpacer} />
            )}
          </View>
        ))}

        {/* Ações */}
        <View style={styles.actionsSection}>
          <Button
            mode="outlined"
            onPress={handleClearCache}
            style={styles.actionButton}
            icon="delete"
          >
            Limpar Cache
          </Button>
          
          <Button
            mode="outlined"
            onPress={() => Alert.alert('Sobre', 'PGA Mobile v1.0.0\nFatec Votorantim 2025')}
            style={styles.actionButton}
            icon="information"
          >
            Sobre
          </Button>
          
          <Button
            mode="contained"
            onPress={handleLogout}
            style={[styles.actionButton, styles.logoutButton]}
            icon="logout"
            buttonColor="#f44336"
          >
            Sair
          </Button>
        </View>
      </ScrollView>

      {/* Navegação inferior */}
      <BottomNavigation
        currentRoute="Settings"
        onNavigate={(route) => {
          // Implementar navegação se necessário
          console.log('Navegar para:', route);
        }}
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  scrollView: {
    flex: 1,
  },
  headerCard: {
    margin: 16,
    borderRadius: 16,
    elevation: 2,
  },
  headerContent: {
    padding: 20,
  },
  profileSection: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  avatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: '#f0f0f0',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 16,
  },
  profileInfo: {
    flex: 1,
  },
  profileName: {
    fontWeight: 'bold',
    color: '#1c1b1f',
    marginBottom: 4,
  },
  profileEmail: {
    color: '#49454f',
    marginBottom: 2,
  },
  profileRole: {
    color: '#ae0f0a',
    fontWeight: '500',
  },
  sectionTitle: {
    fontWeight: '600',
    color: '#1c1b1f',
    marginHorizontal: 16,
    marginBottom: 8,
    marginTop: 16,
  },
  sectionCard: {
    marginHorizontal: 16,
    borderRadius: 12,
    elevation: 1,
  },
  settingItem: {
    paddingVertical: 8,
  },
  sectionSpacer: {
    height: 16,
  },
  actionsSection: {
    padding: 16,
    gap: 12,
  },
  actionButton: {
    borderRadius: 8,
  },
  logoutButton: {
    marginTop: 8,
  },
});
