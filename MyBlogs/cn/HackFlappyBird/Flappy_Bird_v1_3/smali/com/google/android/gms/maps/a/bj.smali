.class public Lcom/google/android/gms/maps/a/bj;
.super Ljava/lang/Object;


# static fields
.field private static a:Landroid/content/Context;

.field private static b:Lcom/google/android/gms/maps/a/z;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static a(Landroid/content/Context;)Lcom/google/android/gms/maps/a/z;
    .locals 2

    invoke-static {p0}, Lcom/google/android/gms/internal/do;->a(Ljava/lang/Object;)Ljava/lang/Object;

    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->b(Landroid/content/Context;)V

    sget-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    if-nez v0, :cond_0

    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->d(Landroid/content/Context;)V

    :cond_0
    sget-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    if-eqz v0, :cond_1

    sget-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    :goto_0
    return-object v0

    :cond_1
    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->e(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/Context;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    const-string v1, "com.google.android.gms.maps.internal.CreatorImpl"

    invoke-static {v0, v1}, Lcom/google/android/gms/maps/a/bj;->a(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/os/IBinder;

    invoke-static {v0}, Lcom/google/android/gms/maps/a/aa;->a(Landroid/os/IBinder;)Lcom/google/android/gms/maps/a/z;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->c(Landroid/content/Context;)V

    sget-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    goto :goto_0
.end method

.method private static a()Ljava/lang/Class;
    .locals 1

    :try_start_0
    const-string v0, "com.google.android.gms.maps.internal.CreatorImpl"

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    :goto_0
    return-object v0

    :catch_0
    move-exception v0

    const/4 v0, 0x0

    goto :goto_0
.end method

.method private static a(Ljava/lang/Class;)Ljava/lang/Object;
    .locals 3

    :try_start_0
    invoke-virtual {p0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1

    move-result-object v0

    return-object v0

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to instantiate the dynamic class "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :catch_1
    move-exception v0

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to call the default constructor of "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {p0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method private static a(Ljava/lang/ClassLoader;Ljava/lang/String;)Ljava/lang/Object;
    .locals 3

    :try_start_0
    invoke-static {p0}, Lcom/google/android/gms/internal/do;->a(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/ClassLoader;

    invoke-virtual {v0, p1}, Ljava/lang/ClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/google/android/gms/maps/a/bj;->a(Ljava/lang/Class;)Ljava/lang/Object;
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    move-result-object v0

    return-object v0

    :catch_0
    move-exception v0

    new-instance v0, Ljava/lang/IllegalStateException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Unable to find dynamic class "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public static b(Landroid/content/Context;)V
    .locals 2

    invoke-static {p0}, Lcom/google/android/gms/common/f;->a(Landroid/content/Context;)I

    move-result v0

    if-eqz v0, :cond_0

    new-instance v1, Lcom/google/android/gms/common/e;

    invoke-direct {v1, v0}, Lcom/google/android/gms/common/e;-><init>(I)V

    throw v1

    :cond_0
    return-void
.end method

.method private static c(Landroid/content/Context;)V
    .locals 3

    :try_start_0
    sget-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->e(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-static {v1}, Lcom/google/android/gms/b/h;->a(Ljava/lang/Object;)Lcom/google/android/gms/b/e;

    move-result-object v1

    const v2, 0x31d24c

    invoke-interface {v0, v1, v2}, Lcom/google/android/gms/maps/a/z;->a(Lcom/google/android/gms/b/e;I)V
    :try_end_0
    .catch Landroid/os/RemoteException; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    new-instance v1, Lcom/google/android/gms/maps/model/k;

    invoke-direct {v1, v0}, Lcom/google/android/gms/maps/model/k;-><init>(Landroid/os/RemoteException;)V

    throw v1
.end method

.method private static d(Landroid/content/Context;)V
    .locals 3

    invoke-static {}, Lcom/google/android/gms/maps/a/bj;->a()Ljava/lang/Class;

    move-result-object v0

    if-eqz v0, :cond_0

    const-class v1, Lcom/google/android/gms/maps/a/bj;

    invoke-virtual {v1}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v1

    const-string v2, "Making Creator statically"

    invoke-static {v1, v2}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    invoke-static {v0}, Lcom/google/android/gms/maps/a/bj;->a(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/google/android/gms/maps/a/z;

    sput-object v0, Lcom/google/android/gms/maps/a/bj;->b:Lcom/google/android/gms/maps/a/z;

    invoke-static {p0}, Lcom/google/android/gms/maps/a/bj;->c(Landroid/content/Context;)V

    :cond_0
    return-void
.end method

.method private static e(Landroid/content/Context;)Landroid/content/Context;
    .locals 1

    sget-object v0, Lcom/google/android/gms/maps/a/bj;->a:Landroid/content/Context;

    if-nez v0, :cond_0

    invoke-static {}, Lcom/google/android/gms/maps/a/bj;->a()Ljava/lang/Class;

    move-result-object v0

    if-eqz v0, :cond_1

    sput-object p0, Lcom/google/android/gms/maps/a/bj;->a:Landroid/content/Context;

    :cond_0
    :goto_0
    sget-object v0, Lcom/google/android/gms/maps/a/bj;->a:Landroid/content/Context;

    return-object v0

    :cond_1
    invoke-static {p0}, Lcom/google/android/gms/common/f;->b(Landroid/content/Context;)Landroid/content/Context;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/maps/a/bj;->a:Landroid/content/Context;

    goto :goto_0
.end method
