import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  KeyboardAvoidingView,
  Platform,
  Alert,
} from 'react-native';
import {
  Text,
  TextInput,
  Button,
  Card,
  useTheme,
  SegmentedButtons,
  HelperText,
} from 'react-native-paper';
import { useNavigation } from '@react-navigation/native';
import { StackNavigationProp } from '@react-navigation/stack';
import { RootStackParamList } from '../../App';
import { MaterialCommunityIcons } from '@expo/vector-icons';

type CreateProjectScreenNavigationProp = StackNavigationProp<RootStackParamList, 'CreateProject'>;

interface ProjectForm {
  name: string;
  description: string;
  responsible: string;
  deadline: string;
  priority: 'low' | 'medium' | 'high';
  category: string;
  budget: string;
}

export const CreateProjectScreen: React.FC = () => {
  const [form, setForm] = useState<ProjectForm>({
    name: '',
    description: '',
    responsible: '',
    deadline: '',
    priority: 'medium',
    category: '',
    budget: '',
  });

  const [errors, setErrors] = useState<Partial<ProjectForm>>({});
  const [loading, setLoading] = useState(false);

  const theme = useTheme();
  const navigation = useNavigation<CreateProjectScreenNavigationProp>();

  const validateForm = (): boolean => {
    const newErrors: Partial<ProjectForm> = {};

    if (!form.name.trim()) {
      newErrors.name = 'Nome do projeto é obrigatório';
    }

    if (!form.description.trim()) {
      newErrors.description = 'Descrição é obrigatória';
    }

    if (!form.responsible.trim()) {
      newErrors.responsible = 'Responsável é obrigatório';
    }

    if (!form.deadline.trim()) {
      newErrors.deadline = 'Data de entrega é obrigatória';
    }

    if (!form.category.trim()) {
      newErrors.category = 'Categoria é obrigatória';
    }

    setErrors(newErrors);
    return Object.keys(newErrors).length === 0;
  };

  const handleSubmit = async () => {
    if (!validateForm()) {
      return;
    }

    setLoading(true);

    try {
      // Simular criação do projeto
      await new Promise(resolve => setTimeout(resolve, 2000));

      Alert.alert(
        'Sucesso!',
        'Projeto criado com sucesso!',
        [
          {
            text: 'OK',
            onPress: () => navigation.goBack(),
          },
        ]
      );
    } catch (error) {
      Alert.alert('Erro', 'Erro ao criar projeto. Tente novamente.');
    } finally {
      setLoading(false);
    }
  };

  const updateForm = (field: keyof ProjectForm, value: string) => {
    setForm(prev => ({ ...prev, [field]: value }));
    if (errors[field]) {
      setErrors(prev => ({ ...prev, [field]: undefined }));
    }
  };

  const priorityOptions = [
    { value: 'low', label: 'Baixa', icon: 'arrow-down' },
    { value: 'medium', label: 'Média', icon: 'minus' },
    { value: 'high', label: 'Alta', icon: 'arrow-up' },
  ];

  const categoryOptions = [
    'Infraestrutura',
    'Desenvolvimento',
    'Design',
    'Gestão',
    'Marketing',
    'Outros',
  ];

  return (
    <KeyboardAvoidingView
      behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      style={styles.container}
    >
      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        keyboardShouldPersistTaps="handled"
      >
        <Card style={styles.formCard}>
          <Card.Content style={styles.cardContent}>
            <Text style={styles.title} variant="headlineMedium">
              Criar Novo Projeto
            </Text>
            <Text style={styles.subtitle} variant="bodyMedium">
              Preencha as informações do projeto
            </Text>

            {/* Nome do Projeto */}
            <TextInput
              label="Nome do Projeto *"
              value={form.name}
              onChangeText={(value) => updateForm('name', value)}
              mode="outlined"
              style={styles.input}
              error={!!errors.name}
              left={<TextInput.Icon icon="folder" />}
            />
            {errors.name && (
              <HelperText type="error" visible={!!errors.name}>
                {errors.name}
              </HelperText>
            )}

            {/* Descrição */}
            <TextInput
              label="Descrição *"
              value={form.description}
              onChangeText={(value) => updateForm('description', value)}
              mode="outlined"
              style={styles.input}
              multiline
              numberOfLines={3}
              error={!!errors.description}
              left={<TextInput.Icon icon="text" />}
            />
            {errors.description && (
              <HelperText type="error" visible={!!errors.description}>
                {errors.description}
              </HelperText>
            )}

            {/* Responsável */}
            <TextInput
              label="Responsável *"
              value={form.responsible}
              onChangeText={(value) => updateForm('responsible', value)}
              mode="outlined"
              style={styles.input}
              error={!!errors.responsible}
              left={<TextInput.Icon icon="account" />}
            />
            {errors.responsible && (
              <HelperText type="error" visible={!!errors.responsible}>
                {errors.responsible}
              </HelperText>
            )}

            {/* Data de Entrega */}
            <TextInput
              label="Data de Entrega *"
              value={form.deadline}
              onChangeText={(value) => updateForm('deadline', value)}
              mode="outlined"
              style={styles.input}
              placeholder="DD/MM/AAAA"
              error={!!errors.deadline}
              left={<TextInput.Icon icon="calendar" />}
            />
            {errors.deadline && (
              <HelperText type="error" visible={!!errors.deadline}>
                {errors.deadline}
              </HelperText>
            )}

            {/* Prioridade */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle} variant="titleMedium">
                Prioridade
              </Text>
              <SegmentedButtons
                value={form.priority}
                onValueChange={(value) => updateForm('priority', value as any)}
                buttons={priorityOptions.map(option => ({
                  value: option.value,
                  label: option.label,
                  icon: option.icon,
                }))}
                style={styles.segmentedButtons}
              />
            </View>

            {/* Categoria */}
            <View style={styles.section}>
              <Text style={styles.sectionTitle} variant="titleMedium">
                Categoria *
              </Text>
              <View style={styles.categoryGrid}>
                {categoryOptions.map((category) => (
                  <Button
                    key={category}
                    mode={form.category === category ? 'contained' : 'outlined'}
                    onPress={() => updateForm('category', category)}
                    style={styles.categoryButton}
                    textColor={form.category === category ? '#ffffff' : theme.colors.onSurface}
                  >
                    {category}
                  </Button>
                ))}
              </View>
              {errors.category && (
                <HelperText type="error" visible={!!errors.category}>
                  {errors.category}
                </HelperText>
              )}
            </View>

            {/* Orçamento */}
            <TextInput
              label="Orçamento (opcional)"
              value={form.budget}
              onChangeText={(value) => updateForm('budget', value)}
              mode="outlined"
              style={styles.input}
              keyboardType="numeric"
              left={<TextInput.Icon icon="currency-usd" />}
              placeholder="R$ 0,00"
            />

            {/* Botões */}
            <View style={styles.buttonContainer}>
              <Button
                mode="outlined"
                onPress={() => navigation.goBack()}
                style={styles.cancelButton}
                disabled={loading}
              >
                Cancelar
              </Button>
              <Button
                mode="contained"
                onPress={handleSubmit}
                style={styles.submitButton}
                loading={loading}
                disabled={loading}
              >
                {loading ? 'Criando...' : 'Criar Projeto'}
              </Button>
            </View>
          </Card.Content>
        </Card>
      </ScrollView>
    </KeyboardAvoidingView>
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
  scrollContent: {
    padding: 16,
    paddingBottom: 32,
  },
  formCard: {
    borderRadius: 16,
    elevation: 4,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 0.1,
    shadowRadius: 4,
  },
  cardContent: {
    padding: 24,
  },
  title: {
    fontWeight: 'bold',
    color: '#1c1b1f',
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    color: '#49454f',
    marginBottom: 24,
    textAlign: 'center',
  },
  input: {
    marginBottom: 16,
    backgroundColor: '#fafafa',
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontWeight: '600',
    color: '#1c1b1f',
    marginBottom: 12,
  },
  segmentedButtons: {
    marginBottom: 8,
  },
  categoryGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    gap: 8,
  },
  categoryButton: {
    marginBottom: 8,
  },
  buttonContainer: {
    flexDirection: 'row',
    gap: 12,
    marginTop: 8,
  },
  cancelButton: {
    flex: 1,
  },
  submitButton: {
    flex: 1,
    backgroundColor: '#ae0f0a',
  },
});
