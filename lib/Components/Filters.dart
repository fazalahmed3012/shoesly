import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shoesly/AppConstants.dart';
import 'package:shoesly/Components/BrandTile.dart';
import 'package:shoesly/Components/ColorFilterButton.dart';
import 'package:shoesly/Components/FilterSelectionButton.dart';
import 'package:shoesly/Components/TitleAppbar.dart';
import 'package:shoesly/Controllers/DiscoverPageController.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../Models/Brand.dart';
import 'PrimaryButton.dart';
import 'SecondaryButton.dart';

class Filters extends StatefulWidget {
  Filters({super.key});

  // var data;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  double minPrice = 0.0;
  double maxPrice = 1750;
  List<dynamic> sortBy = [
    "Most Recent",
    "Lowest Price",
    "Highest Reviews",
    "Gender",
    "Color"
  ];
  List<dynamic> genders = [
    "Man",
    "Woman",
    "Unisex",
  ];

  @override
  void initState() {
    // TODO: implement initState
    context.read<DiscoverPageController>().getBrandCount();
    minPrice = context.read<DiscoverPageController>().minPrice;
    maxPrice = context.read<DiscoverPageController>().maxPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverPageController>(
      builder: (context,value, child) {
        return Container(
          color: primaryNeutral0,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: primaryNeutral0,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(55.h),
                child: TitleAppbar(
                  text: Text("Filter", style: headline400(primaryNeutral500),),
                ),
              ),

              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 20.h),
                      child: Text("Brands", style: headline400(primaryNeutral500),),
                    ),
                
                    /// Brand Selector
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                            List.generate(
                                value.brands.length,
                                (index) => index != 0
                                    ? Padding(
                                  padding: EdgeInsets.only(left: index == 0? 30.w:5.w, right: 5.w),
                                  child: InkWell(
                                    onTap: (){
                                      value.setBrand(value.brands[index]);
                                    },
                                    child: BrandTile(
                                      brand: value.brands[index],
                                      count: value.brandsCount[index],
                                      isSelected: value.brands[index].name.contains(value.selectedBrand.name),
                                    ),
                                  ),
                                )
                                    : Container()
                            ),
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 30.h, bottom: 20.h),
                      child: Text("Price Range", style: headline400(primaryNeutral500),),
                    ),
                
                    /// Price range selector
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.w),
                      child: SfRangeSliderTheme(
                        data: SfRangeSliderThemeData(
                          thumbRadius: 12.sp,
                          overlayRadius: 0,
                          activeTrackColor: primaryNeutral500,
                          thumbStrokeColor: primaryNeutral500,
                          thumbStrokeWidth: 6.w,
                          thumbColor: primaryNeutral0,
                        ),
                        child: SfRangeSlider(
                          thumbShape: _CustomThumb(textScaleFactor: MediaQuery.of(context).textScaleFactor, values: SfRangeValues(minPrice,maxPrice)),
                          min: 0,
                          max: 500,
                          interval: 500,
                          showLabels: true,
                          showTicks: false,
                            values: SfRangeValues(minPrice,maxPrice),
                          onChangeEnd: (SfRangeValues rValue){
                            value.setPriceRange(rValue.start, rValue.end);
                          },
                          onChanged: (SfRangeValues rValue) {
                            setState(() {
                              minPrice = rValue.start;
                              maxPrice = rValue.end;
                            });
                          },
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 30.h, bottom: 20.h),
                      child: Text("Sort by", style: headline400(primaryNeutral500),),
                    ),
                
                    /// Sort by
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            sortBy.length,
                            (index) => Padding(
                              padding: EdgeInsets.only(left: index==0?30.w:5.w, right: 5.w),
                              child: FilterSelectionButton(
                                text: sortBy[index],
                                onTap: (){
                                  if(value.sortBy.contains(sortBy[index])){
                                    value.setSort("");
                                    value.getProducts();
                                  }
                                  else {
                                    value.setSort(sortBy[index]);
                                    value.getProducts();
                                  }
                                },
                                isSelected: value.sortBy.contains(sortBy[index]),
                              ),
                            ),
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 30.h, bottom: 20.h),
                      child: Text("Gender", style: headline400(primaryNeutral500),),
                    ),
                
                    /// Gender selector
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          genders.length,
                              (index) => Padding(
                            padding: EdgeInsets.only(left: index==0?30.w:5.w, right: 5.w),
                            child: FilterSelectionButton(
                              text: genders[index],
                              onTap: (){
                                if(value.selectedGender.contains(genders[index])){
                                  value.removeGender(genders[index]);
                                }
                                else {
                                  value.addGender(genders[index]);
                                }
                              },
                              isSelected: value.selectedGender.contains(genders[index]),
                            ),
                          ),
                        ),
                      ),
                    ),
                
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, top: 30.h, bottom: 20.h),
                      child: Text("Color", style: headline400(primaryNeutral500),),
                    ),
                
                    /// Color selector
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          value.filterColors.length,
                              (index) => Padding(
                            padding: EdgeInsets.only(left: index==0?30.w:5.w, right: 5.w),
                            child: ColorFilterButton(
                              color: value.filterColors[index],
                              onTap: (){
                                if(value.selectedColorName.contains(value.filterColors[index].name)){
                                  value.removeColor(value.filterColors[index]);
                                }
                                else{
                                  value.addColor(value.filterColors[index]);
                                }
                              },
                              isSelected: value.selectedColorName.contains(value.filterColors[index].name
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h,)
                  ],
                ),
              ),

              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: primaryNeutral0,
                  border: Border.all(
                    color: primaryNeutral100
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                height: 90.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        value.clearFilters();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.r),
                            color: primaryNeutral0,
                            border: Border.all(color: primaryNeutral200)
                        ),
                        child: Text("RESET${value.appliedFilters.isNotEmpty?" (${value.appliedFilters.length})":""}", style: headline300(primaryNeutral500),),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        value.getProducts();
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 150.w,
                        height: 50.h,
                        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.r),
                          color: primaryNeutral600,
                        ),
                        child: Text("APPLY", style: headline300(primaryNeutral0),),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class _CustomThumb extends SfThumbShape {
  _CustomThumb({required this.textScaleFactor, required this.values})
      : _textSpan = TextSpan(),
        _textPainter = TextPainter();
  final double textScaleFactor;
  final SfRangeValues values;
  TextPainter _textPainter;
  TextSpan _textSpan;
  final double verticalSpacing = 5.0;

  @override
  Size getPreferredSize(SfSliderThemeData themeData) {
    _textSpan = TextSpan(text: values.start.toInt().toString());
    _textPainter
      ..text = _textSpan
      ..textDirection = TextDirection.ltr
      ..textScaleFactor = textScaleFactor
      ..layout();
    // Considered label height along with thumb radius to avoid the
    // label get overlapping with adjacent widget.
    return Size(themeData.thumbRadius * 2,
        (themeData.thumbRadius + _textPainter.height + verticalSpacing) * 2);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
        required RenderBox? child,
        required SfSliderThemeData themeData,
        SfRangeValues? currentValues,
        dynamic currentValue,
        required Paint? paint,
        required Animation<double> enableAnimation,
        required TextDirection textDirection,
        required SfThumb? thumb}) {
    paint ??= Paint()..color = primaryNeutral0;
    final Paint paint2 = Paint()
      ..style = PaintingStyle.stroke
      ..color = primaryNeutral500
      ..strokeWidth = 6.sp;

    context.canvas.drawCircle(center, 10.sp, paint);
    context.canvas.drawCircle(center, 10.sp, paint2);
    String text = currentValues!.end.toInt().toString();
    if (thumb != null) {
      text = (thumb == SfThumb.start ? currentValues.start : currentValues.end)
          .toInt()
          .toString();
    }
    _textSpan = TextSpan(
      text: "\$$text",
      style: headline200(primaryNeutral500),
    );
    _textPainter
      ..text = _textSpan
      ..textDirection = textDirection
      ..textScaleFactor = textScaleFactor
      ..layout()
      ..paint(
        context.canvas,
        // To show the label below the thumb, we had added it with thumb radius
        // and constant vertical spacing.
        Offset(center.dx - _textPainter.width / 2,
            center.dy + verticalSpacing + themeData.thumbRadius),
      );
  }
}