.class public Lorg/andengine/b/b/a;
.super Lorg/andengine/d/a/a/b;

# interfaces
.implements Lorg/andengine/b/b/b;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lorg/andengine/d/a/a/b;-><init>()V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 0

    invoke-direct {p0, p1}, Lorg/andengine/d/a/a/b;-><init>(I)V

    return-void
.end method


# virtual methods
.method public a(Lorg/andengine/opengl/util/e;Lorg/andengine/b/a/a;)V
    .locals 2

    invoke-virtual {p0}, Lorg/andengine/b/b/a;->size()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    move v1, v0

    :goto_0
    if-gez v1, :cond_0

    return-void

    :cond_0
    invoke-virtual {p0, v1}, Lorg/andengine/b/b/a;->get(I)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lorg/andengine/b/b/b;

    invoke-interface {v0, p1, p2}, Lorg/andengine/b/b/b;->a(Lorg/andengine/opengl/util/e;Lorg/andengine/b/a/a;)V

    add-int/lit8 v0, v1, -0x1

    move v1, v0

    goto :goto_0
.end method
