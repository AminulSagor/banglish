import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

/// Custom text field widget with elegant design
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final int? maxLines;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;
  final bool showCounter;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.inputFormatters,
    this.showCounter = false,
    this.contentPadding,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late FocusNode _focusNode;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isFocused = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_focusNode.hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                if (widget.enabled)
                  BoxShadow(
                    color: _isFocused
                        ? AppColors.primary.withValues(alpha: 0.1)
                        : _hasError
                        ? AppColors.error.withValues(alpha: 0.1)
                        : AppColors.grey100.withValues(alpha: 0.6),
                    blurRadius: _isFocused ? 10 : 4,
                    offset: const Offset(0, 2),
                    spreadRadius: 0,
                  ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        focusNode: _focusNode,
        textInputAction: widget.textInputAction,
        onFieldSubmitted: widget.onFieldSubmitted,
        autofocus: widget.autofocus,
        inputFormatters: widget.inputFormatters,
        validator: (value) {
          final error = widget.validator?.call(value);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _hasError != (error != null)) {
              setState(() => _hasError = error != null);
            }
          });
          return error;
        },
        onChanged: widget.onChanged,
        cursorColor: AppColors.primary,
        cursorWidth: 2,
        cursorRadius: const Radius.circular(2),
        style: TextStyle(
          color: widget.enabled ? AppColors.blueGrey800 : AppColors.blueGrey400,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        buildCounter: widget.showCounter
            ? null
            : (
                context, {
                required currentLength,
                required isFocused,
                required maxLength,
              }) => null,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 12.w),
                  child: IconTheme(
                    data: IconThemeData(
                      color: _isFocused
                          ? AppColors.primary
                          : AppColors.blueGrey400,
                      size: 22.sp,
                    ),
                    child: widget.prefixIcon!,
                  ),
                )
              : null,
          prefixIconConstraints: BoxConstraints(minWidth: 48.w),
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: IconTheme(
                    data: IconThemeData(
                      color: _isFocused
                          ? AppColors.primary
                          : AppColors.blueGrey400,
                      size: 22.sp,
                    ),
                    child: widget.suffixIcon!,
                  ),
                )
              : null,
          suffixIconConstraints: BoxConstraints(minWidth: 48.w),
          filled: true,
          fillColor: widget.enabled ? AppColors.white : AppColors.grey50,
          contentPadding:
              widget.contentPadding ??
              EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: TextStyle(
            color: _hasError ? AppColors.error : AppColors.primary,
            fontSize: 11.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
          labelStyle: TextStyle(
            color: AppColors.grey600,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: AppColors.grey400,
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
          errorStyle: TextStyle(
            color: AppColors.error,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.error, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.error, width: 1.3),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(color: AppColors.grey100, width: 1),
          ),
        ),
      ),
    );
  }
}
