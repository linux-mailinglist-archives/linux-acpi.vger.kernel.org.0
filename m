Return-Path: <linux-acpi+bounces-6827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E70392C4AA
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85B62841E4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826EB18561E;
	Tue,  9 Jul 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iMpczcb/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8007F15216C;
	Tue,  9 Jul 2024 20:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557504; cv=none; b=jNjePHC0Db3PH00N3UyA6aY5BSKQNVefXhGgY9shSzVWvcbcXoLRxSUMPHTHSyXrNhOwGCbX/1MIg5cOSO4mxHS5Ap9UcZW62oXUvwElLOEEJcdUPTxMQaYY1KDGJRvJpd4JSXRkyh0H4GNBcU3Q8bsu5A1LgsdgDAm80i04ELQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557504; c=relaxed/simple;
	bh=wyLNNonp+7EAIRxVIHE6cr9kx2sg/BjXOWQjvwkKSCM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O3E2VXyL2P1zDJ6kM75Iz9rI4hPO8Uk1yrQ/SkyyjFBvIODfwv6AYz4kTHdtZFN/S2n/cgSIUZqkzBtxMtp+DT5u4oNY1tm6ImI0WUDzXkHE0Aaqh3DVFYl/IJ6akQApoj9sTO2oVLjIZxzmqEUtSTxIFmXYR5yh8U91T2gubsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iMpczcb/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557499;
	bh=wyLNNonp+7EAIRxVIHE6cr9kx2sg/BjXOWQjvwkKSCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iMpczcb/9M3jdlnikdvV5lUhKrdmEjceGz9oSduRI0vGQFccMLfCENkfPiDuFI1Z4
	 HoQHMT2xpUHs/RYWkP3T19NKrwlxBqoMLmCyK8nlPCNu/56EplV5bN/AHG22RSuneq
	 OAciqts4ElioDTGq3Hhpa/ZPuV9Ne/YOUbix74kI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 09 Jul 2024 22:37:26 +0200
Subject: [PATCH v2 3/5] ACPI: sysfs: manage attributes as attribute_group
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240709-acpi-sysfs-groups-v2-3-058ab0667fa8@weissschuh.net>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=6564;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wyLNNonp+7EAIRxVIHE6cr9kx2sg/BjXOWQjvwkKSCM=;
 b=FRzNK3aA6OUYBjF/kHmDwML61eKtIbMW2Ak1zSYSPnRsnbazRKNaQ+fwFMw9p08hmbOi7BV4e
 9GkfrVmIUn6ChJ/2mvbB2wurFRUbePl6/foP/kNyoURyQF2YpbPJhKw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current manual attribute management is inconsistent and brittle.
Not all return values of device_create_file() are checked and the
cleanup logic needs to be kept up to date manually.

Moving all attributes into an attribute_group and using the is_visible()
callback allows the management of all attributes as a single unit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 167 +++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 96 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 6e4858ea035f..4afc773383ad 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -517,88 +517,97 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
-/**
- * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
- * @dev: ACPI device object.
- */
-int acpi_device_setup_files(struct acpi_device *dev)
-{
-	int result = 0;
+static struct attribute *acpi_attrs[] = {
+	&dev_attr_path.attr,
+	&dev_attr_hid.attr,
+	&dev_attr_modalias.attr,
+	&dev_attr_description.attr,
+	&dev_attr_adr.attr,
+	&dev_attr_uid.attr,
+	&dev_attr_sun.attr,
+	&dev_attr_hrv.attr,
+	&dev_attr_status.attr,
+	&dev_attr_eject.attr,
+	&dev_attr_power_state.attr,
+	&dev_attr_real_power_state.attr,
+	NULL
+};
 
+static bool acpi_show_attr(struct acpi_device *dev, const struct device_attribute *attr)
+{
 	/*
 	 * Devices gotten from FADT don't have a "path" attribute
 	 */
-	if (dev->handle) {
-		result = device_create_file(&dev->dev, &dev_attr_path);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_path)
+		return dev->handle;
 
-	if (!list_empty(&dev->pnp.ids)) {
-		result = device_create_file(&dev->dev, &dev_attr_hid);
-		if (result)
-			goto end;
+	if (attr == &dev_attr_hid || attr == &dev_attr_modalias)
+		return !list_empty(&dev->pnp.ids);
 
-		result = device_create_file(&dev->dev, &dev_attr_modalias);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_description)
+		return acpi_has_method(dev->handle, "_STR");
 
-	/*
-	 * If device has _STR, 'description' file is created
-	 */
-	if (acpi_has_method(dev->handle, "_STR")) {
-		result = device_create_file(&dev->dev, &dev_attr_description);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_adr)
+		return dev->pnp.type.bus_address;
 
-	if (dev->pnp.type.bus_address)
-		result = device_create_file(&dev->dev, &dev_attr_adr);
-	if (acpi_device_uid(dev))
-		result = device_create_file(&dev->dev, &dev_attr_uid);
+	if (attr == &dev_attr_uid)
+		return acpi_device_uid(dev);
 
-	if (acpi_has_method(dev->handle, "_SUN")) {
-		result = device_create_file(&dev->dev, &dev_attr_sun);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_sun)
+		return acpi_has_method(dev->handle, "_SUN");
 
-	if (acpi_has_method(dev->handle, "_HRV")) {
-		result = device_create_file(&dev->dev, &dev_attr_hrv);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_hrv)
+		return acpi_has_method(dev->handle, "_HRV");
 
-	if (acpi_has_method(dev->handle, "_STA")) {
-		result = device_create_file(&dev->dev, &dev_attr_status);
-		if (result)
-			goto end;
-	}
+	if (attr == &dev_attr_status)
+		return acpi_has_method(dev->handle, "_STA");
 
 	/*
 	 * If device has _EJ0, 'eject' file is created that is used to trigger
 	 * hot-removal function from userland.
 	 */
-	if (acpi_has_method(dev->handle, "_EJ0")) {
-		result = device_create_file(&dev->dev, &dev_attr_eject);
-		if (result)
-			return result;
-	}
+	if (attr == &dev_attr_eject)
+		return acpi_has_method(dev->handle, "_EJ0");
 
-	if (dev->flags.power_manageable) {
-		result = device_create_file(&dev->dev, &dev_attr_power_state);
-		if (result)
-			return result;
+	if (attr == &dev_attr_power_state)
+		return dev->flags.power_manageable;
 
-		if (dev->power.flags.power_resources)
-			result = device_create_file(&dev->dev,
-						    &dev_attr_real_power_state);
-	}
+	if (attr == &dev_attr_real_power_state)
+		return dev->flags.power_manageable && dev->power.flags.power_resources;
+
+	dev_warn_once(&dev->dev, "Unexpected attribute: %s\n", attr->attr.name);
+	return false;
+}
+
+static umode_t acpi_attr_is_visible(struct kobject *kobj,
+				    struct attribute *attr,
+				    int attrno)
+{
+	struct acpi_device *dev = to_acpi_device(kobj_to_dev(kobj));
+
+	if (acpi_show_attr(dev, container_of(attr, struct device_attribute, attr)))
+		return attr->mode;
+	else
+		return 0;
+}
+
+static const struct attribute_group acpi_group = {
+	.attrs = acpi_attrs,
+	.is_visible = acpi_attr_is_visible,
+};
+
+/**
+ * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
+ * @dev: ACPI device object.
+ */
+int acpi_device_setup_files(struct acpi_device *dev)
+{
+	int result = 0;
+
+	result = device_add_group(&dev->dev, &acpi_group);
 
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 
-end:
 	return result;
 }
 
@@ -609,39 +618,5 @@ int acpi_device_setup_files(struct acpi_device *dev)
 void acpi_device_remove_files(struct acpi_device *dev)
 {
 	acpi_hide_nondev_subnodes(&dev->data);
-
-	if (dev->flags.power_manageable) {
-		device_remove_file(&dev->dev, &dev_attr_power_state);
-		if (dev->power.flags.power_resources)
-			device_remove_file(&dev->dev,
-					   &dev_attr_real_power_state);
-	}
-
-	/*
-	 * If device has _STR, remove 'description' file
-	 */
-	if (acpi_has_method(dev->handle, "_STR"))
-		device_remove_file(&dev->dev, &dev_attr_description);
-	/*
-	 * If device has _EJ0, remove 'eject' file.
-	 */
-	if (acpi_has_method(dev->handle, "_EJ0"))
-		device_remove_file(&dev->dev, &dev_attr_eject);
-
-	if (acpi_has_method(dev->handle, "_SUN"))
-		device_remove_file(&dev->dev, &dev_attr_sun);
-
-	if (acpi_has_method(dev->handle, "_HRV"))
-		device_remove_file(&dev->dev, &dev_attr_hrv);
-
-	if (acpi_device_uid(dev))
-		device_remove_file(&dev->dev, &dev_attr_uid);
-	if (dev->pnp.type.bus_address)
-		device_remove_file(&dev->dev, &dev_attr_adr);
-	device_remove_file(&dev->dev, &dev_attr_modalias);
-	device_remove_file(&dev->dev, &dev_attr_hid);
-	if (acpi_has_method(dev->handle, "_STA"))
-		device_remove_file(&dev->dev, &dev_attr_status);
-	if (dev->handle)
-		device_remove_file(&dev->dev, &dev_attr_path);
+	device_remove_group(&dev->dev, &acpi_group);
 }

-- 
2.45.2


