import 'dart:convert';

import 'package:pluto_grid/pluto_grid.dart';

import 'workinstruction.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'configuration.dart';

class WorkInstructionWidget extends GetView<WorkInstructionController> {
  const WorkInstructionWidget({Key? key}) : super(key: key);

  String setWII(String strWIM) {
    final data = jsonDecode(strWIM) as Map;
    List<String> lstItems = [];
    int iStepCount = 0;
    int iDataCollectionItems = 0;

    int iTmp = 0;
    try {
      do { iTmp++; } while(data["WorkInstruction"]["Sections"][0]["Steps"][iTmp - 1] != Null);
    } on RangeError {
      iStepCount = iTmp-1;
    }

    iTmp = 0;
    try {
      do { iTmp++; } while(data["WorkInstruction"]["Sections"][0]["Steps"][0]["DataCollectionItems"][iTmp - 1] != Null);
    } on RangeError {
      iDataCollectionItems = iTmp-1;
    }

    Configuration.lstWII.clear();
    List<WorkInstructionItem> lstWII = [];
    for (int i = 0; i < iStepCount; i++) {
      lstWII.clear();
      for (int j = 0; j < iDataCollectionItems; j++) {
        lstItems.clear();
        iTmp = 0;
        try {
          do { iTmp++; } while(data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Items"][iTmp-1] != Null);
        } on RangeError {
            iTmp--;
        }
        for (int k=0; k<iTmp; k++) {
          lstItems.add(data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Items"][k]);
        }

        WorkInstructionItem workInstructionItem
        = WorkInstructionItem(fWorkInstructionNId: data["WorkInstruction"]["NId"],
                              fSectionNId: data["WorkInstruction"]["Sections"][0]["NId"],
                              fStepNId: data["WorkInstruction"]["Sections"][0]["Steps"][i]["NId"],
                              fDataCollectionItemNId: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["NId"],
                              fUIControl: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["UIControl"],
                              fTarget:  data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Limits"][0]["Value"],
                              fLowLimit: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Limits"][1]["Value"],
                              fHighLimit: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Limits"][2]["Value"],
                              fCaption: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Annotations"][0]["Value"],
                              fLabel: data["WorkInstruction"]["Sections"][0]["Steps"][i]["DataCollectionItems"][j]["Data"]["Annotations"][1]["Value"],
                              lstItems: lstItems,
                              strValue: "");
        lstWII.add(workInstructionItem);
      }
      Configuration.lstWII.add(lstWII);
    }




    Map<String, PlutoCell> mapPC = {};
    Iterable<PlutoRow> plutoRow;
    for (int i=0; i<iDataCollectionItems; i++)
    {
        Configuration.columns.add(PlutoColumn(title: Configuration.lstWII[0][i].fLabel,
                                field: Configuration.lstWII[0][i].fDataCollectionItemNId,
                                type: (Configuration.lstWII[0][i].lstItems.isNotEmpty)
                                        ?PlutoColumnTypeSelect(items: Configuration.lstWII[0][i].lstItems, enableColumnFilter: true)
                                        :(Configuration.lstWII[0][i].fUIControl=="Decimal")?PlutoColumnType.number(format: "#,###.##"):PlutoColumnType.text()));
    }

    for (int i=0; i<iStepCount; i++) {
      mapPC.clear();
      for (int j = 0; j < iDataCollectionItems; j++) {
        mapPC[Configuration.lstWII[i][j].fDataCollectionItemNId] = PlutoCell(value: Configuration.lstWII[i][j].strValue);
      }
      Configuration.rows.add(PlutoRow(cells: mapPC));
    }

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: controller.obx(
                (data) =>
                Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    color: Colors.transparent,
                    height: 600 * Configuration.dSizeAdjustRatio,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(setWII("${data?[0].fWorkInstructionDesign}"),
                              style: Configuration.tstMenu()),
                          Container(
                              color: Colors.transparent,
                              height: 400 * Configuration.dSizeAdjustRatio,
                              child: PlutoGrid(
                                  columns: Configuration.columns,
                                  rows: Configuration.rows,
                                  onChanged: ( PlutoGridOnChangedEvent event) {
                                                 print(event);
                                  },
                                  onLoaded: ( PlutoGridOnLoadedEvent event) {
                                                print(event);
                                  }
                                ),
                            ),
                            ]
                          ),
                         ),
                        ),
                      );
                   }
}
