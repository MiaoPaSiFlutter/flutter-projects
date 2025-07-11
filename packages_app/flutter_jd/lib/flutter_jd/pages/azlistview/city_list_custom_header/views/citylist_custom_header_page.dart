import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ocean_common_module/ocean_common_module.dart';
import 'package:lpinyin/lpinyin.dart';

import 'models.dart';
import 'utils.dart';

class CityListCustomHeaderPage extends StatefulWidget {
  const CityListCustomHeaderPage({super.key});

  @override
  _CityListCustomHeaderPageState createState() =>
      _CityListCustomHeaderPageState();
}

class _CityListCustomHeaderPageState extends State<CityListCustomHeaderPage> {
  List<CityModel> cityList = [];
  double susItemHeight = 36;
  String imgFavorite = Utils.getImgPath('ic_favorite');

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      loadData();
    });
  }

  void loadData() async {
    //加载城市列表
    rootBundle
        .loadString(NormalModuleUtils.configPackagesImage(
            packagename: 'flutter_jd',
            name: 'assets/azlistview/data/china.json'))
        .then((value) {
      cityList.clear();
      Map countyMap = json.decode(value);
      List list = countyMap['china'];
      for (var v in list) {
        cityList.add(CityModel.fromJson(v));
      }
      _handleList(cityList);
    });
  }

  void _handleList(List<CityModel> list) {
    if (list.isEmpty) return;
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name);
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp('[A-Z]').hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = '#';
      }
    }
    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(list);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(cityList);

    // add header.
    cityList.insert(
        0,
        CityModel(
            name: 'header',
            tagIndex: imgFavorite)); //index bar support local images.

    setState(() {});
  }

  Widget _buildHeader() {
    List<CityModel> hotCityList = [];
    hotCityList.addAll([
      CityModel(name: "北京市"),
      CityModel(name: "广州市"),
      CityModel(name: "成都市"),
      CityModel(name: "深圳市"),
      CityModel(name: "杭州市"),
      CityModel(name: "武汉市"),
    ]);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        spacing: 10.0,
        children: hotCityList.map((e) {
          return OutlinedButton(
            style: const ButtonStyle(
                //side: BorderSide(color: Colors.grey[300], width: .5),
                ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(e.name),
            ),
            onPressed: () {
              print("OnItemClick: $e");
              Navigator.pop(context, e);
            },
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ListTile(
            title: Text("当前城市"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.place, size: 20.0),
                Text(" 成都市"),
              ],
            )),
        const Divider(height: .0),
        Expanded(
          child: AzListView(
            data: cityList,
            itemCount: cityList.length,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) return _buildHeader();
              CityModel model = cityList[index];
              return Utils.getListItem(context, model,
                  susHeight: susItemHeight);
            },
            susItemHeight: susItemHeight,
            susItemBuilder: (BuildContext context, int index) {
              CityModel model = cityList[index];
              String tag = model.getSuspensionTag();
              if (imgFavorite == tag) {
                return Container();
              }
              return Utils.getSusItem(context, tag, susHeight: susItemHeight);
            },
            indexBarData: SuspensionUtil.getTagIndexList(cityList),
            indexBarOptions: IndexBarOptions(
              needRebuild: true,
              color: Colors.transparent,
              downColor: const Color(0xFFEEEEEE),
              localImages: [imgFavorite], //local images.
            ),
          ),
        ),
      ],
    );
  }
}
