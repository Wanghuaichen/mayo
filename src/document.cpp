/****************************************************************************
** Copyright (c) 2018, Fougue Ltd. <http://www.fougue.pro>
** All rights reserved.
** See license at https://github.com/fougue/mayo/blob/master/LICENSE.txt
****************************************************************************/

#include "document.h"

#include "application.h"
#include "document_item.h"

#include <cassert>

namespace Mayo {

Document::Document(Application *app)
    : QObject(app),
      m_app(app)
{
}

Document::~Document()
{
    for (DocumentItem* item : m_rootItems)
        delete item;
}

const Application *Document::application() const
{
    return m_app;
}

Application *Document::application()
{
    return m_app;
}

const QString &Document::label() const
{
    return m_label;
}

void Document::setLabel(const QString &v)
{
    m_label = v;
}

const QString &Document::filePath() const
{
    return m_filePath;
}

void Document::setFilePath(const QString &filepath)
{
    m_filePath = filepath;
}

bool Document::eraseRootItem(DocumentItem *docItem)
{
    auto itFound = std::find(m_rootItems.cbegin(), m_rootItems.cend(), docItem);
    if (itFound != m_rootItems.cend()) {
        m_rootItems.erase(itFound);
        delete docItem;
        emit itemErased(docItem);
        return true;
    }
    return false;
}

const std::vector<DocumentItem*>& Document::rootItems() const
{
    return m_rootItems;
}

bool Document::isEmpty() const
{
    return m_rootItems.empty();
}

void Document::addRootItem(DocumentItem* item)
{
    item->setDocument(this);
    m_rootItems.push_back(item);
    emit itemAdded(item);
}

} // namespace Mayo
