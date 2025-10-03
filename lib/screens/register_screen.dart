import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _aceitaTermos = false;
  bool _maiorIdade = false;
  final _cpfController = TextEditingController();
  final _dataController = TextEditingController();

  @override
  void dispose() {
    _cpfController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  String _formatarCPF(String value) {
    String numeros = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length > 11) numeros = numeros.substring(0, 11);
    
    if (numeros.length <= 3) return numeros;
    if (numeros.length <= 6) return '${numeros.substring(0, 3)}.${numeros.substring(3)}';
    if (numeros.length <= 9) return '${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6)}';
    return '${numeros.substring(0, 3)}.${numeros.substring(3, 6)}.${numeros.substring(6, 9)}-${numeros.substring(9)}';
  }

  String _formatarData(String value) {
    String numeros = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length > 8) numeros = numeros.substring(0, 8);
    
    if (numeros.length <= 2) return numeros;
    if (numeros.length <= 4) return '${numeros.substring(0, 2)}/${numeros.substring(2)}';
    return '${numeros.substring(0, 2)}/${numeros.substring(2, 4)}/${numeros.substring(4)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF1A1A1A),
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildTitle(),
                  const SizedBox(height: 30),
                  Expanded(child: _buildForm()),
                ],
              ),
            ),
          ),
          _buildRightPanel(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'GB',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'GAMERS BRAWL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.arrow_back_ios, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                const Text('voltar', style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Criar com e-mail',
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildField('usuario@email.com', Icons.email),
          const SizedBox(height: 16),
          _buildDateField(),
          const SizedBox(height: 16),
          _buildField('Usuário', Icons.person),
          const SizedBox(height: 16),
          _buildCpfField(),
          const SizedBox(height: 16),
          _buildField('Sua senha', Icons.lock, obscureText: true),
          const SizedBox(height: 24),
          _buildCheckbox('Concordo com os Termos de Serviço e a Política de Privacidade', _aceitaTermos, (value) => setState(() => _aceitaTermos = value)),
          const SizedBox(height: 16),
          _buildCheckbox('Eu declaro ter 18 anos ou mais', _maiorIdade, (value) => setState(() => _maiorIdade = value)),
          const SizedBox(height: 30),
          _buildCreateButton(),
        ],
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool obscureText = false}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextField(
        obscureText: obscureText,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _dataController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          String formatted = _formatarData(value);
          if (formatted != value) {
            _dataController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: 'DD/MM/AAAA',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.calendar_today, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCpfField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: TextField(
        controller: _cpfController,
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white),
        onChanged: (value) {
          String formatted = _formatarCPF(value);
          if (formatted != value) {
            _cpfController.value = TextEditingValue(
              text: formatted,
              selection: TextSelection.collapsed(offset: formatted.length),
            );
          }
        },
        decoration: InputDecoration(
          hintText: '000.000.000-00',
          hintStyle: TextStyle(color: Colors.grey[400]),
          prefixIcon: const Icon(Icons.credit_card, color: Colors.green),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }

  Widget _buildCheckbox(String text, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: value ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: value ? Colors.green : Colors.grey[400]!),
            ),
            child: value
                ? const Icon(Icons.check, color: Colors.white, size: 14)
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: Colors.grey[300], fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    bool canCreate = _aceitaTermos && _maiorIdade;
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canCreate ? () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Conta criada com sucesso!'),
              backgroundColor: Colors.green,
            ),
          );
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: canCreate ? Colors.green : Colors.grey[400],
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              color: canCreate ? Colors.white : Colors.grey[600],
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'CRIAR CONTA',
              style: TextStyle(
                color: canCreate ? Colors.white : Colors.grey[600],
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRightPanel() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.withOpacity(0.8),
              Colors.blue.withOpacity(0.6),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'the game',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'FOR GAMERS',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}