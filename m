Return-Path: <linux-acpi+bounces-6830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC592C4AE
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72DA0284215
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA0318563C;
	Tue,  9 Jul 2024 20:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="C6iWCBvL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096417B04F;
	Tue,  9 Jul 2024 20:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557504; cv=none; b=tjl3R1dQSoH0y8dy1YPa3FsrLplSnVaKRJ2geybY0wZTRvg+2UshvFgtX0Sjvifi0YKSj8lZz6gNNryGlDwC1wS29e3X49TUElHv99ywCzEFcjRYbjUDL9cWWM1VufJqiAbrKJ0G3XmX/yTsSi789P/HA4OaYcWSygG2l9IxRV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557504; c=relaxed/simple;
	bh=UKdBAWRdJurn3EAUsp76SpgIaDEnD12ErHFCnETITyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dBJFkqa1+hkkxrWt8k77uYtOo+r+SSetC45VhNUB6oKWNpkp1fklVo2LTsxPbvirgZbaLZ+j9ABzBRT+sEOFzwJrfLKOdznd3PVbcBXcKRh15Mlq/bDEKrqi82oKF9Xac5+GrAEy+7bRYHBcsW6svls8B4h2c26A95pUXGcuRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=C6iWCBvL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557499;
	bh=UKdBAWRdJurn3EAUsp76SpgIaDEnD12ErHFCnETITyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C6iWCBvL2B9UpP94EfRbGsY/0hoUDM/ojOGBTvFA0Q75auCVq2LinWgtaF9kfAXyB
	 oPXFplKKaiou9o2vMp7TJyM1FtrtAM/v0CT0Fdx/aBhGypdQheIw9n/QAXX/XBuwt7
	 lnG7TA5LhkebGzV1uE9u+YYSjrsmJsHzluGSdnqQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 09 Jul 2024 22:37:27 +0200
Subject: [PATCH v2 4/5] ACPI: sysfs: manage sysfs attributes through device
 core
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240709-acpi-sysfs-groups-v2-4-058ab0667fa8@weissschuh.net>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=2513;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UKdBAWRdJurn3EAUsp76SpgIaDEnD12ErHFCnETITyU=;
 b=AAIJkN+pFjK5krlVuFD+yFRS+7724cbJsJFZ0i3GH52IA12jh/g1JVtPAcLPqV5r2BNbLZlTq
 UZDGdUBeH5HDA1AM2BMr9ZQRwcY4FZscVYMO7RUrrhewKZuvwQ7vygd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the acpi sysfs attributes are organized around an
attribute_group the device core can manage them.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 8 +++++---
 drivers/acpi/internal.h     | 1 +
 drivers/acpi/scan.c         | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 4afc773383ad..0bff4a1654ed 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -596,6 +596,11 @@ static const struct attribute_group acpi_group = {
 	.is_visible = acpi_attr_is_visible,
 };
 
+const struct attribute_group *acpi_groups[] = {
+	&acpi_group,
+	NULL
+};
+
 /**
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
@@ -604,8 +609,6 @@ int acpi_device_setup_files(struct acpi_device *dev)
 {
 	int result = 0;
 
-	result = device_add_group(&dev->dev, &acpi_group);
-
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 
 	return result;
@@ -618,5 +621,4 @@ int acpi_device_setup_files(struct acpi_device *dev)
 void acpi_device_remove_files(struct acpi_device *dev)
 {
 	acpi_hide_nondev_subnodes(&dev->data);
-	device_remove_group(&dev->dev, &acpi_group);
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 601b670356e5..8e1c21e45d0e 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -120,6 +120,7 @@ int acpi_tie_acpi_dev(struct acpi_device *adev);
 int acpi_device_add(struct acpi_device *device);
 int acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
+extern const struct attribute_group *acpi_groups[];
 void acpi_device_add_finalize(struct acpi_device *device);
 void acpi_free_pnp_ids(struct acpi_device_pnp *pnp);
 bool acpi_device_is_enabled(const struct acpi_device *adev);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 503773707e01..c15fffefca0a 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1813,6 +1813,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 	device->dev.parent = parent ? &parent->dev : NULL;
 	device->dev.release = release;
 	device->dev.bus = &acpi_bus_type;
+	device->dev.groups = acpi_groups;
 	fwnode_init(&device->fwnode, &acpi_device_fwnode_ops);
 	acpi_set_device_status(device, ACPI_STA_DEFAULT);
 	acpi_device_get_busid(device);

-- 
2.45.2


