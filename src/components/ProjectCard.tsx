import React from 'react';
import { View, StyleSheet, TouchableOpacity } from 'react-native';
import { Text, Card, ProgressBar, Chip, useTheme } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';

interface Project {
  id: string;
  name: string;
  progress: number;
  status: string;
  deadline: string;
  responsible: string;
}

interface ProjectCardProps {
  project: Project;
  onPress: () => void;
}

export const ProjectCard: React.FC<ProjectCardProps> = ({
  project,
  onPress,
}) => {
  const theme = useTheme();

  const getStatusColor = (status: string) => {
    switch (status.toLowerCase()) {
      case 'em andamento':
        return '#2196F3';
      case 'concluído':
        return '#4CAF50';
      case 'atrasado':
        return '#FF9800';
      default:
        return '#9E9E9E';
    }
  };

  const getProgressColor = (progress: number) => {
    if (progress >= 80) return '#4CAF50';
    if (progress >= 50) return '#FF9800';
    return '#F44336';
  };

  return (
    <TouchableOpacity onPress={onPress} activeOpacity={0.7}>
      <Card style={styles.card}>
        <Card.Content style={styles.content}>
          {/* Header */}
          <View style={styles.header}>
            <Text style={styles.projectName} variant="titleLarge">
              {project.name}
            </Text>
            <Chip
              mode="outlined"
              textStyle={{ color: getStatusColor(project.status) }}
              style={[
                styles.statusChip,
                { borderColor: getStatusColor(project.status) },
              ]}
            >
              {project.status}
            </Chip>
          </View>

          {/* Progress */}
          <View style={styles.progressSection}>
            <View style={styles.progressHeader}>
              <Text style={styles.progressLabel}>Progresso</Text>
              <Text style={styles.progressValue}>{project.progress}%</Text>
            </View>
            <ProgressBar
              progress={project.progress / 100}
              color={getProgressColor(project.progress)}
              style={styles.progressBar}
            />
          </View>

          {/* Info */}
          <View style={styles.infoSection}>
            <View style={styles.infoItem}>
              <MaterialCommunityIcons
                name="account"
                size={16}
                color={theme.colors.onSurfaceVariant}
              />
              <Text style={styles.infoText} variant="bodyMedium">
                {project.responsible}
              </Text>
            </View>
            <View style={styles.infoItem}>
              <MaterialCommunityIcons
                name="calendar"
                size={16}
                color={theme.colors.onSurfaceVariant}
              />
              <Text style={styles.infoText} variant="bodyMedium">
                {project.deadline}
              </Text>
            </View>
          </View>
        </Card.Content>
      </Card>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  card: {
    marginBottom: 12,
    borderRadius: 16,
    elevation: 2,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 1,
    },
    shadowOpacity: 0.1,
    shadowRadius: 2,
  },
  content: {
    padding: 16,
  },
  header: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: 16,
  },
  projectName: {
    flex: 1,
    marginRight: 12,
    fontWeight: '600',
    color: '#1c1b1f',
  },
  statusChip: {
    alignSelf: 'flex-start',
  },
  progressSection: {
    marginBottom: 16,
  },
  progressHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  progressLabel: {
    color: '#49454f',
    fontSize: 14,
  },
  progressValue: {
    fontWeight: '600',
    color: '#1c1b1f',
    fontSize: 14,
  },
  progressBar: {
    height: 8,
    borderRadius: 4,
  },
  infoSection: {
    gap: 8,
  },
  infoItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  infoText: {
    color: '#49454f',
    fontSize: 14,
  },
});
