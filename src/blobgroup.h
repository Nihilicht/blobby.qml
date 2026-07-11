#pragma once

#include <qcolor.h>
#include <qlist.h>
#include <qobject.h>
#include <qqmlengine.h>

class BlobShape;
class BlobInvertedRect;

class BlobGroup : public QObject {
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(qreal smoothing READ smoothing WRITE setSmoothing NOTIFY smoothingChanged)
    Q_PROPERTY(QColor color READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(qreal borderCompression READ borderCompression WRITE setBorderCompression NOTIFY borderCompressionChanged)
    Q_PROPERTY(qreal minFlattenRadius READ minFlattenRadius WRITE setMinFlattenRadius NOTIFY minFlattenRadiusChanged)

public:
    // Original upstream defaults from caelestia-shell
    static constexpr qreal DefaultSmoothing = 32.0;
    static constexpr qreal DefaultBorderCompression = 3.0;
    static constexpr qreal DefaultMinFlattenRadius = 2.0;

    explicit BlobGroup(QObject* parent = nullptr);
    ~BlobGroup() override;

    qreal smoothing() const { return m_smoothing; }

    void setSmoothing(qreal s);

    QColor color() const { return m_color; }

    void setColor(const QColor& c);

    qreal borderCompression() const { return m_borderCompression; }

    void setBorderCompression(qreal v);

    qreal minFlattenRadius() const { return m_minFlattenRadius; }

    void setMinFlattenRadius(qreal v);

    void addShape(BlobShape* shape);
    void removeShape(BlobShape* shape);

    void setInvertedRect(BlobInvertedRect* rect);
    void clearInvertedRect(BlobInvertedRect* rect);

    const QList<BlobShape*>& shapes() const { return m_shapes; }

    BlobInvertedRect* invertedRect() const { return m_invertedRect; }

    void markDirty();
    void markShapeDirty(BlobShape* source);
    void ensurePhysicsUpdated();

signals:
    void smoothingChanged();
    void colorChanged();
    void borderCompressionChanged();
    void minFlattenRadiusChanged();

private:
    qreal m_smoothing = DefaultSmoothing;
    QColor m_color{ 0x44, 0x88, 0xff };
    qreal m_borderCompression = DefaultBorderCompression;
    qreal m_minFlattenRadius = DefaultMinFlattenRadius;
    QList<BlobShape*> m_shapes;
    BlobInvertedRect* m_invertedRect = nullptr;
    bool m_physicsUpdated = false;
};
