Return-Path: <linux-acpi+bounces-6389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B31907D3E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868911C24DA3
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBF213A884;
	Thu, 13 Jun 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iJViCu4B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA659130A4D;
	Thu, 13 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309738; cv=none; b=VbZT26GgHY/VVFJvSqrVX/Upvm3eUxeVUCd0zW329w4Lv7IlT5thmoDXflMuR6kquWD/7WocRZbqbwwjGY6aR7zSZ4+ojFi8PFfJQhTdI1c86pFUiMQP7YLTA1L09B/QIWa+LFkpp2kZjK/5Boe2bekdHsWf+cU3ygZ/xmVJ238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309738; c=relaxed/simple;
	bh=wuIQfkHjHbUZk36PrIyzZVKJCwONssrSuDQUKyE3G5M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DDQly55kfAlKE+yE+nkyw6cQh0wladrKepMzWpTVzmqfYsL6CatHODG368gQHqYBnVmEGxQ27fY5jc96J7nHFe8zG6eOmQ7PSuFLDyVgtge8Fqkas3qai/Z0X2sjQsAn6GeH36FZRYkRyc7DiRHlE9NelHg5+7bQn4ybr6C5zOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iJViCu4B; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=wuIQfkHjHbUZk36PrIyzZVKJCwONssrSuDQUKyE3G5M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iJViCu4BWydYRUpcLgnPGEsG9KdqygZVvPyoLRbwSu2rQQNpSiJakyuBd1FBDBW12
	 5ATqbmNx0D6tlp5lU3p3oizPAfxjhh2PY71xT3gdqtX1dJHYXkGhNrd/FbctnzieKs
	 LZU9UZWKQtdVT0M87U8QSvNj+S7OJcRRyb/6KsjY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 22:15:32 +0200
Subject: [PATCH 1/5] ACPI: sysfs: convert utf-16 from _STR to utf-8 only
 once
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-acpi-sysfs-groups-v1-1-665e0deb052a@weissschuh.net>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=4089;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wuIQfkHjHbUZk36PrIyzZVKJCwONssrSuDQUKyE3G5M=;
 b=R8UTwK2oub0RzCvElNIobM/59YinmrpFME0s4J3K483SIT4LkKzFZdZJbdLdN1un29b+4qh5I
 4ll3lIsCBhNDbgW+Z3CEKKA+PR2rpKadc5+jB4E1j8zo/8RVPWo42IU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The ACPI _STR method returns an UTF-16 string that is converted to utf-8
before printing it in sysfs.
Currently this conversion is performed every time the "description"
sysfs attribute is read, which is not necessary.

Only perform the conversion once and cache the result.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 63 ++++++++++++++++++++++++++++-----------------
 include/acpi/acpi_bus.h     |  2 +-
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 23373faa35ec..4bedbe8f57ed 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -439,24 +439,11 @@ static ssize_t description_show(struct device *dev,
 				char *buf)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
-	int result;
 
-	if (acpi_dev->pnp.str_obj == NULL)
+	if (acpi_dev->pnp.str == NULL)
 		return 0;
 
-	/*
-	 * The _STR object contains a Unicode identifier for a device.
-	 * We need to convert to utf-8 so it can be displayed.
-	 */
-	result = utf16s_to_utf8s(
-		(wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
-		acpi_dev->pnp.str_obj->buffer.length,
-		UTF16_LITTLE_ENDIAN, buf,
-		PAGE_SIZE - 1);
-
-	buf[result++] = '\n';
-
-	return result;
+	return sysfs_emit("%s\n", acpi_dev->pnp.str);
 }
 static DEVICE_ATTR_RO(description);
 
@@ -507,14 +494,46 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
+static const char *acpi_device_str(struct acpi_device *dev)
+{
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *str_obj;
+	acpi_status status;
+	const char *ret;
+	char buf[512];
+	int result;
+
+	if (!acpi_has_method(dev->handle, "_STR"))
+		return NULL;
+
+	status = acpi_evaluate_object(dev->handle, "_STR",
+				      NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	str_obj = buffer.pointer;
+	/*
+	 * The _STR object contains a Unicode identifier for a device.
+	 * We need to convert to utf-8 so it can be displayed.
+	 */
+	result = utf16s_to_utf8s((wchar_t *)str_obj->buffer.pointer,
+				 str_obj->buffer.length,
+				 UTF16_LITTLE_ENDIAN,
+				 buf, sizeof(buf) - 1);
+	buf[result++] = '\0';
+
+	ret = kstrdup(buf, GFP_KERNEL);
+	kfree(buffer.pointer);
+
+	return ret;
+}
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
  */
 int acpi_device_setup_files(struct acpi_device *dev)
 {
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	acpi_status status;
 	int result = 0;
 
 	/*
@@ -539,12 +558,8 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	/*
 	 * If device has _STR, 'description' file is created
 	 */
-	if (acpi_has_method(dev->handle, "_STR")) {
-		status = acpi_evaluate_object(dev->handle, "_STR",
-					NULL, &buffer);
-		if (ACPI_FAILURE(status))
-			buffer.pointer = NULL;
-		dev->pnp.str_obj = buffer.pointer;
+	dev->pnp.str = acpi_device_str(dev);
+	if (dev->pnp.str) {
 		result = device_create_file(&dev->dev, &dev_attr_description);
 		if (result)
 			goto end;
@@ -618,7 +633,7 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	 * If device has _STR, remove 'description' file
 	 */
 	if (acpi_has_method(dev->handle, "_STR")) {
-		kfree(dev->pnp.str_obj);
+		kfree(dev->pnp.str);
 		device_remove_file(&dev->dev, &dev_attr_description);
 	}
 	/*
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..32e3105c9ece 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -254,7 +254,7 @@ struct acpi_device_pnp {
 	struct list_head ids;		/* _HID and _CIDs */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
-	union acpi_object *str_obj;	/* unicode string for _STR method */
+	const char *str;		/* _STR */
 };
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)

-- 
2.45.2


