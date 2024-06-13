Return-Path: <linux-acpi+bounces-6387-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 989BA907D3B
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E1E1C24E47
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BBA137905;
	Thu, 13 Jun 2024 20:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ANLHL5zV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A415A4D5;
	Thu, 13 Jun 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309737; cv=none; b=mKVZctwxFOl14glgGBtn8F8uyksX1i6CSoQrnAYZzIhceIjvNimp/8Ynop+p3/ZLBE0jSbcBiRuPC5oxRsqTVw2Y6cyuVaQos9XYwTNfmZVlJiUWVnbxyA/03747eLuDUHCRzl19L1NRt4+XhidgrY/GjEuoApP6KUSGQV2pIzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309737; c=relaxed/simple;
	bh=OV3NvfZWfLxpDfggoJaTx32OTDbVKKTvikYlf0Uiq74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h1VL99IKIqwuyB4xH0PHuXBS8HEZEVE3cx4Z8Hb9iDCjYmdR2kSXrtNR3zoEm36o+d9wvXDJPPZvmxfaKu9bJxnl6e8OcSR3ppxSchjF3Zlv81nIx0QEGx2EOi3YLInoItT8cLAXOQokWU/gpKlnT6DzpcxgzWpCkwVELB9eaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ANLHL5zV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=OV3NvfZWfLxpDfggoJaTx32OTDbVKKTvikYlf0Uiq74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ANLHL5zV23safuJoiH1GVUeQ+YKvME4p08n+h8lLYULGtQyJROol4ncn2fh7zENvA
	 nFJ/wO5AW+vUFmIg8dEx6+X1CHVFZb4eUtuGzjj9oUynLy0H7///p/Zh5B07/C7tiw
	 7RkDEW0XZmw2veWdF/FD54731Qf5iUMgvkrNW5ok=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 22:15:34 +0200
Subject: [PATCH 3/5] ACPI: sysfs: manage attributes as attribute_group
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-acpi-sysfs-groups-v1-3-665e0deb052a@weissschuh.net>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=6704;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=OV3NvfZWfLxpDfggoJaTx32OTDbVKKTvikYlf0Uiq74=;
 b=GwwqBwQv+scW4j2SxrdzqcUz6nzETJkcUaVKV9Whhk73xIuG97M67oDFBpZC7OcYeOdiHfvtb
 pTzcGsJEZUSCxN147YfM4DAQV+YsOHNQzQWrTHHHk4qtFL6H5JJpCKU
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current manual attribute management is inconsistent and brittle.
Not all return values of device_create_file() are checked and the
cleanup logic needs to be kept up to date manually.

Moving all attributes into an attribute_group and using the is_visible()
callback allows the management of all attributes as a single unit.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 190 ++++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 106 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index d0ca159d93e1..a673488066b3 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -494,6 +494,88 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(status);
 
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
+
+static bool acpi_show_attr(struct acpi_device *dev, const struct device_attribute *attr)
+{
+	/*
+	 * Devices gotten from FADT don't have a "path" attribute
+	 */
+	if (attr == &dev_attr_path)
+		return dev->handle;
+
+	if (attr == &dev_attr_hid || attr == &dev_attr_modalias)
+		return !list_empty(&dev->pnp.ids);
+
+	/*
+	 * If device has _STR, 'description' file is created
+	 */
+	if (attr == &dev_attr_description)
+		return dev->pnp.str;
+
+	if (attr == &dev_attr_adr)
+		return dev->pnp.type.bus_address;
+
+	if (attr == &dev_attr_uid)
+		return acpi_device_uid(dev);
+
+	if (attr == &dev_attr_sun)
+		return acpi_has_method(dev->handle, "_SUN");
+
+	if (attr == &dev_attr_hrv)
+		return acpi_has_method(dev->handle, "_HRV");
+
+	if (attr == &dev_attr_status)
+		return acpi_has_method(dev->handle, "_STA");
+
+	/*
+	 * If device has _EJ0, 'eject' file is created that is used to trigger
+	 * hot-removal function from userland.
+	 */
+	if (attr == &dev_attr_eject)
+		return acpi_has_method(dev->handle, "_EJ0");
+
+	if (attr == &dev_attr_power_state)
+		return dev->flags.power_manageable;
+
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
 static const char *devm_acpi_device_str(struct acpi_device *dev)
 {
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -536,81 +618,11 @@ int acpi_device_setup_files(struct acpi_device *dev)
 {
 	int result = 0;
 
-	/*
-	 * Devices gotten from FADT don't have a "path" attribute
-	 */
-	if (dev->handle) {
-		result = device_create_file(&dev->dev, &dev_attr_path);
-		if (result)
-			goto end;
-	}
-
-	if (!list_empty(&dev->pnp.ids)) {
-		result = device_create_file(&dev->dev, &dev_attr_hid);
-		if (result)
-			goto end;
-
-		result = device_create_file(&dev->dev, &dev_attr_modalias);
-		if (result)
-			goto end;
-	}
-
-	/*
-	 * If device has _STR, 'description' file is created
-	 */
 	dev->pnp.str = devm_acpi_device_str(dev);
-	if (dev->pnp.str) {
-		result = device_create_file(&dev->dev, &dev_attr_description);
-		if (result)
-			goto end;
-	}
-
-	if (dev->pnp.type.bus_address)
-		result = device_create_file(&dev->dev, &dev_attr_adr);
-	if (acpi_device_uid(dev))
-		result = device_create_file(&dev->dev, &dev_attr_uid);
-
-	if (acpi_has_method(dev->handle, "_SUN")) {
-		result = device_create_file(&dev->dev, &dev_attr_sun);
-		if (result)
-			goto end;
-	}
-
-	if (acpi_has_method(dev->handle, "_HRV")) {
-		result = device_create_file(&dev->dev, &dev_attr_hrv);
-		if (result)
-			goto end;
-	}
-
-	if (acpi_has_method(dev->handle, "_STA")) {
-		result = device_create_file(&dev->dev, &dev_attr_status);
-		if (result)
-			goto end;
-	}
-
-	/*
-	 * If device has _EJ0, 'eject' file is created that is used to trigger
-	 * hot-removal function from userland.
-	 */
-	if (acpi_has_method(dev->handle, "_EJ0")) {
-		result = device_create_file(&dev->dev, &dev_attr_eject);
-		if (result)
-			return result;
-	}
-
-	if (dev->flags.power_manageable) {
-		result = device_create_file(&dev->dev, &dev_attr_power_state);
-		if (result)
-			return result;
-
-		if (dev->power.flags.power_resources)
-			result = device_create_file(&dev->dev,
-						    &dev_attr_real_power_state);
-	}
+	result = device_add_group(&dev->dev, &acpi_group);
 
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 
-end:
 	return result;
 }
 
@@ -621,39 +633,5 @@ int acpi_device_setup_files(struct acpi_device *dev)
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


