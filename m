Return-Path: <linux-acpi+bounces-13786-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBCCABB157
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 20:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7117B175F64
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 18:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060451FF7C5;
	Sun, 18 May 2025 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Mi89jvIF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A65D15853B;
	Sun, 18 May 2025 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747594279; cv=none; b=OpWFKJMxqoQDOJgAuZJQQmRbaUuDEiaqy1pqZZy4/0+wMAnGtNVlkyequUHVBVB8ZlDE7bHlZEAUJjH3f0uBfDz1fOOxl29a09zRid/aSVTblCZ+9cTr1W14ocHs9G2W5dzoJ1jFBeGzIcjm5g1iOpQBYsGMlXNXrfLurLu7GHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747594279; c=relaxed/simple;
	bh=o9FNcvZI6F/VD8NOGBAJfCBKVWVp68cQCT9DWXYLtgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o+9NaEFZy0tmMI63YK6QfdN4PihFYbPnbkUkjRn1nojyh6nFfkCPT9vlDolF1kseE+M78AyRDrEa1TS4CU6Q+g5aJHayJzfmrxS6vic9/qUO5O3PLaocuqHxAD9Bl5rGzmS8YWbGv0kUFkdjnUL/kxFvBgrbNqvT8ArGloT3msY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Mi89jvIF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1747594274; x=1748199074; i=w_armin@gmx.de;
	bh=fN4mLo5c+QTNSlDwwWIubv8Ys4WXVIJzkBCc6m7+U2I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mi89jvIFpthMJUCxoFyDX+MrXosO2zMSTVqU0HVDC2x0oYEQi2SjwltJ8h6B4Dt8
	 cSa0qro3okGjRRbJ8SjZQckH9xoNi/u7xQJ5ePK6sz66kCa/74PahTRowEZKN/iQv
	 660tfWYDLP1rDiq8Y0uiruK6QlBROoNx3kdqpAZ4mUWYa3/UFoDt7bXtUF7LS0zPn
	 bUv3NHKT+odtKZ6IznqXpVzXVrVs7O4P8ZfYmVNjg6wA6OGtsMg+hKnKlYmCG0UVX
	 IQjIUdO+glBX7GqG4scMiDM4ZNSqSnmEFyP0UFtFB6s3nIk1x9vgvd5yM4P0YJjcY
	 Cg36yFfXAC18O/wTbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7b2d-1uKJ4u3byP-0069a4; Sun, 18 May 2025 20:51:14 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: j@jannau.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ACPI: platform_profile: Add support for non-ACPI platforms
Date: Sun, 18 May 2025 20:51:10 +0200
Message-Id: <20250518185111.3560-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JqBdYJjSZghZcU0dD5LdKPz1d3QV1xedi0RM3a0ngzyEgvTbM34
 fy1UJCcslXV1R1SXkXiLk/VhoqtgxWjN1+WDpjJ7KG/lBVNlLDD9WtiTK+TV8jmE7vYe5oq
 bi9mpItErAg1a1DrQ20QVFh1UiiqnLUfSuElNwlNEn795Vd4TWtiAri+171Rf3+V8dOrFs/
 dFWZb1BDR9Ow7qaWPGo8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rO7VeWJNDdc=;AC6q/9rAT0K6BnetJSX518t8Noy
 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
 RcxRMAyFrzdsgqDNlW6gbI=

Currently the platform profile subsystem assumes that all supported
(i.e. ACPI-capable) platforms always run with ACPI being enabled.
However some ARM64 notebooks do not support ACPI and are instead
using devicetree for booting.

Do not register the legacy sysfs interface on such devices as it
depends on the acpi_kobj (/sys/firmware/acpi/) being present. Users
are encouraged to use the new platform-profile class interface
instead.

Reviewed-by: Janne Grunau <j@jannau.net>
Tested-by: Janne Grunau <j@jannau.net>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/platform_profile.c | 68 ++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profi=
le.c
index ffbfd32f4cf1..c5a5da7d03f1 100644
=2D-- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -190,6 +190,20 @@ static ssize_t profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
=20
+/**
+ * profile_notify_legacy - Notify the legacy sysfs interface
+ *
+ * This wrapper takes care of only notifying the legacy sysfs interface
+ * if it was registered during module initialization.
+ */
+static void profile_notify_legacy(void)
+{
+	if (!acpi_kobj)
+		return;
+
+	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+}
+
 /**
  * profile_store - Set the profile for a class device
  * @dev: The device
@@ -215,7 +229,7 @@ static ssize_t profile_store(struct device *dev,
 			return ret;
 	}
=20
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify_legacy();
=20
 	return count;
 }
@@ -435,7 +449,7 @@ static ssize_t platform_profile_store(struct kobject *=
kobj,
 			return ret;
 	}
=20
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify_legacy();
=20
 	return count;
 }
@@ -472,6 +486,22 @@ static const struct attribute_group platform_profile_=
group =3D {
 	.is_visible =3D profile_class_is_visible,
 };
=20
+/**
+ * profile_update_legacy - Update the legacy sysfs interface
+ *
+ * This wrapper takes care of only updating the legacy sysfs interface
+ * if it was registered during module initialization.
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int profile_update_legacy(void)
+{
+	if (!acpi_kobj)
+		return 0;
+
+	return sysfs_update_group(acpi_kobj, &platform_profile_group);
+}
+
 /**
  * platform_profile_notify - Notify class device and legacy sysfs interfa=
ce
  * @dev: The class device
@@ -481,7 +511,7 @@ void platform_profile_notify(struct device *dev)
 	scoped_cond_guard(mutex_intr, return, &profile_lock) {
 		_notify_class_profile(dev, NULL);
 	}
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify_legacy();
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
=20
@@ -529,7 +559,7 @@ int platform_profile_cycle(void)
 			return err;
 	}
=20
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify_legacy();
=20
 	return 0;
 }
@@ -603,9 +633,9 @@ struct device *platform_profile_register(struct device=
 *dev, const char *name,
 		goto cleanup_ida;
 	}
=20
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
+	profile_notify_legacy();
=20
-	err =3D sysfs_update_group(acpi_kobj, &platform_profile_group);
+	err =3D profile_update_legacy();
 	if (err)
 		goto cleanup_cur;
=20
@@ -639,8 +669,8 @@ void platform_profile_remove(struct device *dev)
 	ida_free(&platform_profile_ida, pprof->minor);
 	device_unregister(&pprof->dev);
=20
-	sysfs_notify(acpi_kobj, NULL, "platform_profile");
-	sysfs_update_group(acpi_kobj, &platform_profile_group);
+	profile_notify_legacy();
+	profile_update_legacy();
 }
 EXPORT_SYMBOL_GPL(platform_profile_remove);
=20
@@ -692,16 +722,28 @@ static int __init platform_profile_init(void)
 	if (err)
 		return err;
=20
-	err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
-	if (err)
-		class_unregister(&platform_profile_class);
+	/*
+	 * The ACPI kobject can be missing if ACPI was disabled during booting.
+	 * We thus skip the initialization of the legacy sysfs interface in such
+	 * cases to allow the platform profile class to work on ARM64 notebooks
+	 * without ACPI support.
+	 */
+	if (acpi_kobj) {
+		err =3D sysfs_create_group(acpi_kobj, &platform_profile_group);
+		if (err < 0) {
+			class_unregister(&platform_profile_class);
+			return err;
+		}
+	}
=20
-	return err;
+	return 0;
 }
=20
 static void __exit platform_profile_exit(void)
 {
-	sysfs_remove_group(acpi_kobj, &platform_profile_group);
+	if (acpi_kobj)
+		sysfs_remove_group(acpi_kobj, &platform_profile_group);
+
 	class_unregister(&platform_profile_class);
 }
 module_init(platform_profile_init);
=2D-=20
2.39.5


