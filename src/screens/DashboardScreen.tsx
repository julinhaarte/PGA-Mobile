import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  Dimensions,
} from 'react-native';
import {
  Text,
  Card,
  Button,
  useTheme,
  FAB,
} from 'react-native-paper';
import { LinearGradient } from 'expo-linear-gradient';
import { useNavigation } from '@react-navigation/native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../../App';
import { StatsCard } from '../components/StatsCard';
import { ProjectCard } from '../components/ProjectCard';
import { BottomNavigation } from '../components/BottomNavigation';

type DashboardScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Dashboard'>;

const { width } = Dimensions.get('window');

// Dados mockados
const mockStats = [
  { title: 'Total de Projetos', value: '12', icon: '📊', color: '#4CAF50' },
  { title: 'Em Andamento', value: '8', icon: '🚀', color: '#2196F3' },
  { title: 'Concluídos', value: '3', icon: '✅', color: '#4CAF50' },
  { title: 'Atrasados', value: '1', icon: '⚠️', color: '#FF9800' },
];

const mockProjects = [
  {
    id: '1',
    name: 'Sistema de Gestão Acadêmica',
    progress: 75,
    status: 'Em andamento',
    deadline: '15/03/2025',
    responsible: 'Ana Silva',
  },
  {
    id: '2',
    name: 'Modernização Laboratórios',
    progress: 45,
    status: 'Em andamento',
    deadline: '28/02/2025',
    responsible: 'Carlos Santos',
  },
  {
    id: '3',
    name: 'Portal de Comunicação',
    progress: 20,
    status: 'Em andamento',
    deadline: '10/02/2025',
    responsible: 'Maria Oliveira',
  },
];

export const DashboardScreen: React.FC = () => {
  const [activeTab, setActiveTab] = useState('overview');
  const theme = useTheme();
  const navigation = useNavigation<DashboardScreenNavigationProp>();

  const handleCreateProject = () => {
    navigation.navigate('CreateProject');
  };

  const renderOverview = () => (
    <View style={styles.tabContent}>
      {/* Cards de Estatísticas */}
      <View style={styles.statsGrid}>
        {mockStats.map((stat, index) => (
          <StatsCard
            key={index}
            title={stat.title}
            value={stat.value}
            icon={stat.icon}
            color={stat.color}
          />
        ))}
      </View>

      {/* Card da Instituição */}
      <Card style={styles.institutionCard}>
        <LinearGradient
          colors={[theme.colors.primary, theme.colors.secondary]}
          style={styles.gradientCard}
        >
          <Card.Content style={styles.institutionContent}>
            <Text style={styles.institutionTitle}>
              IDENTIFICAÇÃO DA UNIDADE
            </Text>
            <View style={styles.institutionInfo}>
              <View style={styles.infoItem}>
                <Text style={styles.infoLabel}>Código</Text>
                <Text style={styles.infoValue}>F301</Text>
              </View>
              <View style={styles.infoItem}>
                <Text style={styles.infoLabel}>Unidade</Text>
                <Text style={styles.infoValue}>Fatec Votorantim</Text>
              </View>
              <View style={styles.infoItem}>
                <Text style={styles.infoLabel}>Diretor(a)</Text>
                <Text style={styles.infoValue}>Prof. Dr. Mauro Tomazela</Text>
              </View>
            </View>
          </Card.Content>
        </LinearGradient>
      </Card>

      {/* Projetos em Destaque */}
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Projetos em Destaque</Text>
        {mockProjects.slice(0, 2).map((project) => (
          <ProjectCard
            key={project.id}
            project={project}
            onPress={() => navigation.navigate('Projects')}
          />
        ))}
      </View>
    </View>
  );

  const renderProjects = () => (
    <View style={styles.tabContent}>
      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Todos os Projetos</Text>
        {mockProjects.map((project) => (
          <ProjectCard
            key={project.id}
            project={project}
            onPress={() => navigation.navigate('Projects')}
          />
        ))}
      </View>
    </View>
  );

  const renderContent = () => {
    switch (activeTab) {
      case 'overview':
        return renderOverview();
      case 'projects':
        return renderProjects();
      default:
        return renderOverview();
    }
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.scrollView}>
        {/* Tabs */}
        <View style={styles.tabs}>
          <Button
            mode={activeTab === 'overview' ? 'contained' : 'outlined'}
            onPress={() => setActiveTab('overview')}
            style={[
              styles.tabButton,
              activeTab === 'overview' && styles.activeTabButton,
            ]}
          >
            Visão Geral
          </Button>
          <Button
            mode={activeTab === 'projects' ? 'contained' : 'outlined'}
            onPress={() => setActiveTab('projects')}
            style={[
              styles.tabButton,
              activeTab === 'projects' && styles.activeTabButton,
            ]}
          >
            Projetos
          </Button>
        </View>

        {/* Conteúdo */}
        {renderContent()}
      </ScrollView>

      {/* FAB para criar projeto */}
      <FAB
        color="#ffffff"
        icon="plus"
        style={styles.fab}
        onPress={handleCreateProject}
        label="Novo Projeto"
      />

      {/* Navegação inferior */}
      <BottomNavigation
        currentRoute="Dashboard"
        onNavigate={(route) => {
          if (route === 'Dashboard') return;
          navigation.navigate(route as any);
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
  tabs: {
    flexDirection: 'row',
    padding: 16,
    gap: 12,
  },
  tabButton: {
    flex: 1,
  },
  activeTabButton: {
    backgroundColor: '#ae0f0a',
  },
  tabContent: {
    padding: 16,
  },
  statsGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 12,
    marginBottom: 24,
  },
  institutionCard: {
    marginBottom: 24,
    borderRadius: 16,
    overflow: 'hidden',
  },
  gradientCard: {
    padding: 20,
  },
  institutionContent: {
    padding: 0,
  },
  institutionTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#ffffff',
    textAlign: 'center',
    marginBottom: 20,
  },
  institutionInfo: {
    gap: 16,
  },
  infoItem: {
    alignItems: 'center',
  },
  infoLabel: {
    fontSize: 14,
    color: 'rgba(255, 255, 255, 0.8)',
    marginBottom: 4,
  },
  infoValue: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#ffffff',
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#1c1b1f',
    marginBottom: 16,
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 80,
    backgroundColor: '#ae0f0a',
  },
});
