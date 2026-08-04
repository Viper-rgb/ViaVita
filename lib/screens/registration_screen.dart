import 'package:flutter/material.dart';
import 'package:workers_app/screens/registration_success_dialog.dart';
import 'package:workers_app/screens/sign_in_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _gender = 'Male';
  String? _selectedState;
  String? _selectedDistrict;
  String? _idProofFileName;

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _states = [
    'Kerala',
    'Tamil Nadu',
    'Karnataka',
    'Maharashtra',
    'Delhi',
  ];

  final Map<String, List<String>> _districts = {
    'Kerala': ['Trivandrum', 'Kollam', 'Ernakulam', 'Kozhikode'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Karnataka': ['Bengaluru', 'Mysuru', 'Mangaluru'],
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur'],
    'Delhi': ['Central Delhi', 'New Delhi', 'North Delhi'],
  };

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(String hintText, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      filled: true,
      fillColor: const Color(0xFFF8F8F8),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFB8C00), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.5),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(
        label,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    final isSelected = _gender == value;
    return InkWell(
      onTap: () {
        setState(() {
          _gender = value;
        });
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFFB8C00) : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 9,
                        height: 9,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFB8C00),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton({required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFD32F2F),
            Color(0xFFFB8C00),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onPressed,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Create a new account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Profile image picker
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 42,
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[400],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFFB8C00),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Image picker triggered")),
                              );
                            },
                            child: const Text(
                              "+ Add image",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Name
                    _buildFieldLabel("Name"),
                    TextFormField(
                      controller: _nameController,
                      decoration: _inputDecoration("Name"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Gender
                    _buildFieldLabel("Gender"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildRadioOption('Male'),
                        _buildRadioOption('Female'),
                        _buildRadioOption('Other'),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Age
                    _buildFieldLabel("Age"),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Age"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your age";
                        }
                        final age = int.tryParse(value.trim());
                        if (age == null || age <= 0 || age > 120) {
                          return "Please enter a valid age";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Phone Number
                    _buildFieldLabel("Phone Number"),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _inputDecoration("Phone Number"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your phone number";
                        }
                        if (value.trim().length < 10) {
                          return "Please enter a valid 10-digit phone number";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email ID
                    _buildFieldLabel("Email ID"),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _inputDecoration("Email ID"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email ID";
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // State
                    _buildFieldLabel("State"),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedState,
                      decoration: _inputDecoration("State"),
                      hint: const Text("State", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      items: _states.map((String state) {
                        return DropdownMenuItem<String>(
                          value: state,
                          child: Text(state),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedState = newValue;
                          _selectedDistrict = null;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a state";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // District
                    _buildFieldLabel("District"),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedDistrict,
                      decoration: _inputDecoration("District"),
                      hint: const Text("District", style: TextStyle(color: Colors.grey, fontSize: 14)),
                      items: (_selectedState != null && _districts.containsKey(_selectedState))
                          ? _districts[_selectedState]!.map((String district) {
                              return DropdownMenuItem<String>(
                                value: district,
                                child: Text(district),
                              );
                            }).toList()
                          : [],
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDistrict = newValue;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please select a district";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Address
                    _buildFieldLabel("Address"),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 2,
                      decoration: _inputDecoration("Address"),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ID Proof upload
                    _buildFieldLabel("ID Proof"),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _idProofFileName = "id_proof_doc.pdf";
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F8F8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _idProofFileName ?? "Choose file",
                              style: TextStyle(
                                color: _idProofFileName == null ? Colors.grey : Colors.black,
                                fontSize: 14,
                              ),
                            ),
                            const Icon(
                              Icons.file_upload_outlined,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Password
                    _buildFieldLabel("Password"),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: _inputDecoration(
                        "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password
                    _buildFieldLabel("Confirm Password"),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: _inputDecoration(
                        "Confirm Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm password";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),

                    // Sign Up Button
                    _buildGradientButton(
                      text: "Sign up",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (_idProofFileName == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please upload ID Proof")),
                            );
                            return;
                          }
                          showDialog(
                            context: context,
                            builder: (context) => const RegistrationSuccessDialog(),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    // Login TextButton
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account ? ",
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const SignInScreen()),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              color: Color(0xFFD32F2F),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
