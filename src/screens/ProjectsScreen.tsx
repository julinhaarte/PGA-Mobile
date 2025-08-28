import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  FlatList,
} from 'react-native';
import {
  Text,
  Searchbar,
  Chip,
  FAB,
  useTheme,
} from 'react-native-paper';
import { useNavigation } from '@react-navigation/native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../../App';
import { ProjectCard } from '../components/ProjectCard';
import { BottomNavigation } from '../components/BottomNavigation';

type ProjectsScreenNavigationProp = StackNavigationProp<RootStackParamList, 'Projects'>;

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
  {
    id: '4',
    name: 'Sistema de Biblioteca',
    progress: 90,
    status: 'Concluído',
    deadline: '15/01/2025',
    responsible: 'João Costa',
  },
  {
    id: '5',
    name: 'App Mobile Estudantes',
    progress: 30,
    status: 'Atrasado',
    deadline: '01/02/2025',
    responsible: 'Pedro Silva',
  },
];

const statusFilters = [
  { label: 'Todos', value: 'all' },
  { label: 'Em andamento', value: 'em andamento' },
  { label: 'Concluído', value: 'concluído' },
  { label: 'Atrasado', value: 'atrasado' },
];

export const ProjectsScreen: React.FC = () => {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedStatus, setSelectedStatus] = useState('all');
  const [filteredProjects, setFilteredProjects] = useState(mockProjects);
  
  const theme = useTheme();
  const navigation = useNavigation<ProjectsScreenNavigationProp>();

  const handleSearch = (query: string) => {
    setSearchQuery(query);
    filterProjects(query, selectedStatus);
  };

  const handleStatusFilter = (status: string) => {
    setSelectedStatus(status);
    filterProjects(searchQuery, status);
  };

  const filterProjects = (query: string, status: string) => {
    let filtered = mockProjects;

    // Filtrar por status
    if (status !== 'all') {
      filtered = filtered.filter(project =>
        project.status.toLowerCase() === status.toLowerCase()
      );
    }

    // Filtrar por busca
    if (query) {
      filtered = filtered.filter(project =>
        project.name.toLowerCase().includes(query.toLowerCase()) ||
        project.responsible.toLowerCase().includes(query.toLowerCase())
      );
    }

    setFilteredProjects(filtered);
  };

  const handleCreateProject = () => {
    navigation.navigate('CreateProject');
  };

  const handleProjectPress = (projectId: string) => {
    // Aqui você pode navegar para uma tela de detalhes do projeto
    console.log('Projeto selecionado:', projectId);
  };

  const renderProject = ({ item }: { item: any }) => (
    <ProjectCard
      project={item}
      onPress={() => handleProjectPress(item.id)}
    />
  );

  return (
    <View style={styles.container}>
      {/* Header com busca */}
      <View style={styles.header}>
        <Text style={styles.title} variant="headlineMedium">
          Projetos
        </Text>
        <Searchbar
          placeholder="Buscar projetos..."
          onChangeText={handleSearch}
          value={searchQuery}
          style={styles.searchbar}
        />
      </View>

      {/* Filtros de status */}
      <ScrollView
        horizontal
        showsHorizontalScrollIndicator={false}
        style={styles.filtersContainer}
        contentContainerStyle={styles.filtersContent}
      >
        {statusFilters.map((filter) => (
          <Chip
            key={filter.value}
            selected={selectedStatus === filter.value}
            onPress={() => handleStatusFilter(filter.value)}
            style={[
              styles.filterChip,
              selectedStatus === filter.value && styles.selectedFilterChip,
            ]}
            textStyle={[
              styles.filterChipText,
              selectedStatus === filter.value && styles.selectedFilterChipText,
            ]}
          >
            {filter.label}
          </Chip>
        ))}
      </ScrollView>

      {/* Lista de projetos */}
      <FlatList
        data={filteredProjects}
        renderItem={renderProject}
        keyExtractor={(item) => item.id}
        contentContainerStyle={styles.projectsList}
        showsVerticalScrollIndicator={false}
        ListEmptyComponent={
          <View style={styles.emptyState}>
            <Text style={styles.emptyStateText} variant="bodyLarge">
              Nenhum projeto encontrado
            </Text>
            <Text style={styles.emptyStateSubtext} variant="bodyMedium">
              Tente ajustar os filtros ou criar um novo projeto
            </Text>
          </View>
        }
      />

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
        currentRoute="Projects"
        onNavigate={(route) => {
          if (route === 'Projects') return;
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
  header: {
    padding: 16,
    backgroundColor: '#ffffff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  title: {
    fontWeight: 'bold',
    color: '#1c1b1f',
    marginBottom: 16,
  },
  searchbar: {
    backgroundColor: '#f5f5f5',
    borderRadius: 12,
  },
  filtersContainer: {
    backgroundColor: '#ffffff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  filtersContent: {
    paddingHorizontal: 16,
    paddingVertical: 12,
    gap: 8,
  },
  filterChip: {
    backgroundColor: '#f5f5f5',
    borderColor: '#e0e0e0',
  },
  selectedFilterChip: {
    backgroundColor: '#ae0f0a',
    borderColor: '#ae0f0a',
  },
  filterChipText: {
    color: '#49454f',
  },
  selectedFilterChipText: {
    color: '#ffffff',
  },
  projectsList: {
    padding: 16,
  },
  emptyState: {
    alignItems: 'center',
    padding: 32,
  },
  emptyStateText: {
    color: '#1c1b1f',
    marginBottom: 8,
    textAlign: 'center',
  },
  emptyStateSubtext: {
    color: '#49454f',
    textAlign: 'center',
  },
  fab: {
    position: 'absolute',
    margin: 16,
    right: 0,
    bottom: 80,
    backgroundColor: '#ae0f0a',
  },
});
