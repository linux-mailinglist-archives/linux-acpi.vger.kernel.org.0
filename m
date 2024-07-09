Return-Path: <linux-acpi+bounces-6829-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 209E192C4AC
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF668284380
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B7718562B;
	Tue,  9 Jul 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="qfWbczE8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0854E182A63;
	Tue,  9 Jul 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557504; cv=none; b=lrYTs0p0iIbeXLSqoZCZSy+vEbtHYrq/i7zv75E6SrToVlFekBuwzwYhEPU+R2gOuDJ5cbaF2Ycypt5aROeE1KCIAUAwZWZCqbxZu7VLl1DGQba7nqpruUilG7a1aJYsROZeQhHH+C0SC0oCUxcglcpAFxq4MX8oMcpEXgvzZ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557504; c=relaxed/simple;
	bh=q+YR3m2EXR3uKtrR6shoZSOKk/iB5ADwRrDy+seaaEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RdI9v04CL4M5pQurGOOZG0lZwVhwKtCiSpLekUTM5NOO/uSQ3MvRnUdQYz+yUysPEHcTx6KY2EadQ+kZKWbvmP5l6sJmuGtVf1x1bFfCkVsP6OeXf6DupJQzB9POERJRwIEXmeVuxwKiVvE3mddbwpZJG1jQ4VKySyINpvPkeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=qfWbczE8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557499;
	bh=q+YR3m2EXR3uKtrR6shoZSOKk/iB5ADwRrDy+seaaEQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qfWbczE8oE+WdoghqQsFcmDhxA1S+IevXgD4lSBbviTSvN5aPm7TUDTzmhHjJL8zB
	 n3cviZMHCb3yhI9D8mzR6Xw0NT+PbPCZxSc0SIufuedNs9eai2zRmWFlEi9uNxUF43
	 0UVhARZHMfMuM60/YIYKYKHh+uJ7xeBWZMZ6fqxs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 09 Jul 2024 22:37:25 +0200
Subject: [PATCH v2 2/5] ACPI: sysfs: evaluate _STR on each sysfs access
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240709-acpi-sysfs-groups-v2-2-058ab0667fa8@weissschuh.net>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=3611;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=q+YR3m2EXR3uKtrR6shoZSOKk/iB5ADwRrDy+seaaEQ=;
 b=Vjq2sGtbGSTufPTPJ/zrDOKpT1qfTVZdB3YFAJwuDNGNZB6wN+X2708Rb81QHw8LMyu2x9KY1
 jJTFd0aZrEWCLFB8SMXIT4jEIaRRMc68xDwJV9AlMw7XI24ANCKLfSW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The handling of the _STR method is inconsistent with the other method
evaluations. It is the only method which is cached.
The cached value stored in 'struct acpi_device_pnp' has a different
lifetime than the other struct members.
Commit d1efe3c324ea ("ACPI: Add new sysfs interface to export device description")
does not explain this difference.

Evaluating the method every time also removes the necessity to manage
the lifetime of the cached value, which would be a problem when managing
the sysfs attributes through the device core.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 30 +++++++++++++++---------------
 include/acpi/acpi_bus.h     |  1 -
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 95a19e3569c8..6e4858ea035f 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -439,23 +439,33 @@ static ssize_t description_show(struct device *dev,
 				char *buf)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *str_obj;
+	acpi_status status;
 	int result;
 
-	if (acpi_dev->pnp.str_obj == NULL)
-		return 0;
+	status = acpi_evaluate_object_typed(acpi_dev->handle, "_STR",
+					    NULL, &buffer,
+					    ACPI_TYPE_BUFFER);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	str_obj = buffer.pointer;
 
 	/*
 	 * The _STR object contains a Unicode identifier for a device.
 	 * We need to convert to utf-8 so it can be displayed.
 	 */
 	result = utf16s_to_utf8s(
-		(wchar_t *)acpi_dev->pnp.str_obj->buffer.pointer,
-		acpi_dev->pnp.str_obj->buffer.length,
+		(wchar_t *)str_obj->buffer.pointer,
+		str_obj->buffer.length,
 		UTF16_LITTLE_ENDIAN, buf,
 		PAGE_SIZE - 1);
 
 	buf[result++] = '\n';
 
+	kfree(str_obj);
+
 	return result;
 }
 static DEVICE_ATTR_RO(description);
@@ -513,8 +523,6 @@ static DEVICE_ATTR_RO(status);
  */
 int acpi_device_setup_files(struct acpi_device *dev)
 {
-	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
-	acpi_status status;
 	int result = 0;
 
 	/*
@@ -540,12 +548,6 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	 * If device has _STR, 'description' file is created
 	 */
 	if (acpi_has_method(dev->handle, "_STR")) {
-		status = acpi_evaluate_object_typed(dev->handle, "_STR",
-						    NULL, &buffer,
-						    ACPI_TYPE_BUFFER);
-		if (ACPI_FAILURE(status))
-			buffer.pointer = NULL;
-		dev->pnp.str_obj = buffer.pointer;
 		result = device_create_file(&dev->dev, &dev_attr_description);
 		if (result)
 			goto end;
@@ -618,10 +620,8 @@ void acpi_device_remove_files(struct acpi_device *dev)
 	/*
 	 * If device has _STR, remove 'description' file
 	 */
-	if (acpi_has_method(dev->handle, "_STR")) {
-		kfree(dev->pnp.str_obj);
+	if (acpi_has_method(dev->handle, "_STR"))
 		device_remove_file(&dev->dev, &dev_attr_description);
-	}
 	/*
 	 * If device has _EJ0, remove 'eject' file.
 	 */
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..2f202ac5f1ef 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -254,7 +254,6 @@ struct acpi_device_pnp {
 	struct list_head ids;		/* _HID and _CIDs */
 	acpi_device_name device_name;	/* Driver-determined */
 	acpi_device_class device_class;	/*        "          */
-	union acpi_object *str_obj;	/* unicode string for _STR method */
 };
 
 #define acpi_device_bid(d)	((d)->pnp.bus_id)

-- 
2.45.2


