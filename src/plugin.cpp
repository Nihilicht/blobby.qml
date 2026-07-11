#include "plugin.h"
#include <QtQml>
#include "blobgroup.h"
#include "blobrect.h"
#include "blobinvertedrect.h"

void BlobbyPlugin::registerTypes(const char *uri) {
    qmlRegisterType<BlobGroup>(uri, 1, 0, "BlobGroup");
    qmlRegisterType<BlobRect>(uri, 1, 0, "BlobRect");
    qmlRegisterType<BlobInvertedRect>(uri, 1, 0, "BlobInvertedRect");
}

