TARGET = mayo
TEMPLATE = app

QT += core gui widgets

*msvc* {
    QMAKE_CXXFLAGS += /we4150 # Deletion of pointer to incomplete type 'XXXX'; no destructor called
}

CONFIG += console

HEADERS += \
    src/application.h \
    src/bnd_utils.h \
    src/button_flat.h \
    src/caf_utils.h \
    src/dialog_about.h \
    src/dialog_export_options.h \
    src/dialog_inspect_xde.h \
    src/dialog_options.h \
    src/dialog_save_image_view.h \
    src/dialog_task_manager.h \
    src/document.h \
    src/document_item.h \
    src/fougtools/occtools/occtools.h \
    src/fougtools/occtools/qt_utils.h \
    src/fougtools/qttools/core/qstring_hfunc.h \
    src/fougtools/qttools/gui/gui.h \
    src/fougtools/qttools/gui/item_view_buttons.h \
    src/fougtools/qttools/gui/item_view_utils.h \
    src/fougtools/qttools/gui/proxy_styled_item_delegate.h \
    src/fougtools/qttools/gui/qwidget_utils.h \
    src/gpx_document_item.h \
    src/gpx_mesh_item.h \
    src/gpx_xde_document_item.h \
    src/gui_application.h \
    src/gui_document.h \
    src/mainwindow.h \
    src/mesh_item.h \
    src/mesh_utils.h \
    src/occt_window.h \
    src/options.h \
    src/property.h \
    src/property_builtins.h \
    src/property_enumeration.h \
    src/qt_occ_view_controller.h \
    src/span.h \
    src/string_utils.h \
    src/widget_application_tree.h \
    src/widget_clip_planes.h \
    src/widget_document_item_props.h \
    src/widget_message_indicator.h \
    src/widget_occ_view.h \
    src/xde_document_item.h \
    src/theme.h \
    src/gpx_utils.h \
    src/math_utils.h \
    src/widget_gui_document.h \
    src/unit.h \
    src/quantity.h \
    src/unit_system.h \
    src/widget_file_system.h \
    src/document_list_model.h \
    src/application_item.h \
    src/brep_utils.h \
    src/libtree.h \
    src/application_item_selection_model.h

SOURCES += \
    src/application.cpp \
    src/bnd_utils.cpp \
    src/button_flat.cpp \
    src/caf_utils.cpp \
    src/dialog_about.cpp \
    src/dialog_export_options.cpp \
    src/dialog_inspect_xde.cpp \
    src/dialog_options.cpp \
    src/dialog_save_image_view.cpp \
    src/dialog_task_manager.cpp \
    src/document.cpp \
    src/document_item.cpp \
    src/fougtools/occtools/qt_utils.cpp \
    src/fougtools/qttools/gui/item_view_buttons.cpp \
    src/fougtools/qttools/gui/item_view_utils.cpp \
    src/fougtools/qttools/gui/proxy_styled_item_delegate.cpp \
    src/fougtools/qttools/gui/qwidget_utils.cpp \
    src/gpx_document_item.cpp \
    src/gpx_mesh_item.cpp \
    src/gpx_xde_document_item.cpp \
    src/gui_application.cpp \
    src/gui_document.cpp \
    src/main.cpp \
    src/mainwindow.cpp \
    src/mesh_item.cpp \
    src/mesh_utils.cpp \
    src/occt_window.cpp \
    src/options.cpp \
    src/property.cpp \
    src/property_enumeration.cpp \
    src/qt_occ_view_controller.cpp \
    src/string_utils.cpp \
    src/widget_application_tree.cpp \
    src/widget_clip_planes.cpp \
    src/widget_document_item_props.cpp \
    src/widget_message_indicator.cpp \
    src/widget_occ_view.cpp \
    src/xde_document_item.cpp \
    src/theme.cpp \
    src/gpx_utils.cpp \
    src/math_utils.cpp \
    src/widget_gui_document.cpp \
    src/unit.cpp \
    src/quantity.cpp \
    src/unit_system.cpp \
    src/widget_file_system.cpp \
    src/document_list_model.cpp \
    src/application_item.cpp \
    src/brep_utils.cpp \
    src/application_item_selection_model.cpp

include(src/fougtools/qttools/task/qttools_task.pri)
include(src/qt-solutions/qtpropertybrowser/src/qtpropertybrowser.pri)
INCLUDEPATH += src/qt-solutions/qtpropertybrowser/src

FORMS += \
    src/mainwindow.ui \
    src/dialog_about.ui \
    src/dialog_options.ui \
    src/dialog_task_manager.ui \
    src/dialog_save_image_view.ui \
    src/widget_application_tree.ui \
    src/widget_document_item_props.ui \
    src/dialog_export_options.ui \
    src/dialog_inspect_xde.ui \
    src/widget_clip_planes.ui

# gmio
#isEmpty(GMIO_ROOT):error(Variable GMIO_ROOT is empty)
isEmpty(GMIO_ROOT) {
    warning(gmio is disabled)
} else {
    CONFIG(debug, debug|release) {
        GMIO_BIN_SUFFIX = d
    } else {
        GMIO_BIN_SUFFIX =
    }
    INCLUDEPATH += $$GMIO_ROOT/include
    LIBS += -L$$GMIO_ROOT/lib -lgmio_static$$GMIO_BIN_SUFFIX
    SOURCES += \
        $$GMIO_ROOT/src/gmio_support/stl_occ_brep.cpp \
        $$GMIO_ROOT/src/gmio_support/stl_occ_polytri.cpp \
        $$GMIO_ROOT/src/gmio_support/stream_qt.cpp
    DEFINES += HAVE_GMIO
}

# OpenCascade
isEmpty(CASCADE_ROOT):error(Variable CASCADE_ROOT is empty)
include(occ.pri)
LIBS += -lTKernel -lTKMath -lTKTopAlgo -lTKV3d -lTKOpenGl -lTKService
LIBS += -lTKG2d
LIBS += -lTKBRep -lTKSTL
LIBS += -lTKXSBase -lTKIGES -lTKSTEP -lTKXDESTEP -lTKXDEIGES
LIBS += -lTKMeshVS -lTKXSDRAW
LIBS += -lTKLCAF -lTKXCAF -lTKCAF
LIBS += -lTKG3d
LIBS += -lTKGeomBase

OCCT_DEFINES = $$(CSF_DEFINES)
DEFINES += $$split(OCCT_DEFINES, ;)
DEFINES += OCCT_HANDLE_NOCAST
RESOURCES += mayo.qrc

RC_ICONS = images/appicon.ico
OTHER_FILES += \
    README.md \
    images/credits.txt
