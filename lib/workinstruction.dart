import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'configuration.dart';
import 'package:flutter/foundation.dart' show compute;

class WorkInstructionList {
  final String fWorkOrder;
  final String fWorkInstruction;
  final String fWorkInstructionDesign;

  WorkInstructionList({required this.fWorkOrder, required this.fWorkInstruction, required this.fWorkInstructionDesign });

  factory WorkInstructionList.fromJson(Map<String, dynamic> json) => WorkInstructionList(
    fWorkOrder: json["f1"],
    fWorkInstruction: json["f2"],
    fWorkInstructionDesign: json["f3"],
  );

  static List<WorkInstructionList> listFromJson(list) =>
      List<WorkInstructionList>.from(list.map((x) => WorkInstructionList.fromJson(x)));

}

class WorkInstructionItem {
  final String fWorkInstructionNId;
  final String fSectionNId;
  final String fStepNId;
  final String fDataCollectionItemNId;
  final String fUIControl;
  final String fTarget;
  final String fLowLimit;
  final String fHighLimit;
  final String fCaption;
  final String fLabel;
  final List<String> lstItems;
  final String strValue;

  WorkInstructionItem({ required this.fWorkInstructionNId, required this.fSectionNId, required this.fStepNId,
                        required this.fDataCollectionItemNId, required this.fUIControl,
                        required this.fTarget, required this.fLowLimit, required this.fHighLimit,
                        required this.fCaption, required this.fLabel, required this.lstItems, required this.strValue});

}

class WorkInstructionProvider extends GetConnect {
  Future<List<WorkInstructionList>> fetchWorkInstruction(Map<String, String> _paramWorkInstruction) async {
    final response = await post(
        Configuration.strGetWorkInstruction,
        _paramWorkInstruction,
        contentType: 'application/x-www-form-urlencoded',
        headers: {"Accept": "application/json"}
    );
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return compute(WorkInstructionList.listFromJson, jsonDecode(response.bodyString!));
    }
  }
}

class WorkInstructionController extends GetxController with StateMixin<List<WorkInstructionList>> {
  final Map<String, String> paramWorkInstruction;
  WorkInstructionProvider workInstructionProvider = WorkInstructionProvider();

  WorkInstructionController({required this.paramWorkInstruction});

  @override
  void onInit() {
    super.onInit();

    workInstructionProvider.fetchWorkInstruction(paramWorkInstruction).then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null,status: RxStatus.error(err.toString()));
    });

  }
}

class WorkInstructionBinding extends Bindings {
  final Map<String, String> paramWorkInstruction;

  WorkInstructionBinding({required this.paramWorkInstruction});

  @override
  void dependencies() {
    Get.lazyPut<WorkInstructionController>(() => WorkInstructionController(paramWorkInstruction: paramWorkInstruction));
  }

}
