Return-Path: <linux-acpi+bounces-6390-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC886907D42
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB6C2863D8
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4040E13B797;
	Thu, 13 Jun 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Vfc8BmPA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40929137931;
	Thu, 13 Jun 2024 20:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309740; cv=none; b=H7XmAAPJQ81yAOIXvxm274nBDvdZ414tVfDKRg0q6blu/ea1g3MXhMHmNbleg60roEqB0I2/kaf6zq6qk0YUMCugkL3Hqd1cBnIryidkYuWWvyVK4Bz1dp6A/ZAImTjJjeQRj3JJIf9HB/ysO8xlISl/JvNTo/HWkIdba/3hHcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309740; c=relaxed/simple;
	bh=Wibaem2muyMRSUGsOkiWV4LRhlCo/E5mStSJIoYEpqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3JDRc3S6o1BlXM+BJlRE5RiaLC1BIHUlyaGOxd/+GJ6OOs9LKkiMnWGSYrncbEiM8sFxL3+a7t81xNx+FiSWw8vRyO/kcpvKsimRQjWK/Zmhz/d0Bl2RoYvePtkLehLgNvMRf/9M1tZW4kGTbN+Z+I4ZH07lgAI3fsIVgxyohM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Vfc8BmPA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=Wibaem2muyMRSUGsOkiWV4LRhlCo/E5mStSJIoYEpqc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Vfc8BmPARWzf7qfetgooexXKzNr0QqQ3BFDOmWH4ATs3OaPwyQW2wToBC7e7ymR5N
	 oErhuLVLmLAdJw3Dj8yKnC8nWZbr8pYwcu8HDfj9gF2AGyBDRb+izoLSfnF+8RLLik
	 qmzB2TaxKkja1NzyV+ZXzin6nzKnbsWtFTV6Bdd4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 22:15:35 +0200
Subject: [PATCH 4/5] ACPI: sysfs: manage sysfs attributes through device
 core
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-acpi-sysfs-groups-v1-4-665e0deb052a@weissschuh.net>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=2575;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Wibaem2muyMRSUGsOkiWV4LRhlCo/E5mStSJIoYEpqc=;
 b=qUJNj/gSuC+i8EkW98Yb9mxUeGPU+gnjv0yh5/B7Z/ZCUFurxsAdGIvU9Ba4qwuHSPxmeHKNs
 31wgZiuKiw9DyNCn8gW/H2Vzg3mdTZpWy1RoVyN4Gi+106WkFAO3I7r
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
index a673488066b3..f1e8928254c2 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -576,6 +576,11 @@ static const struct attribute_group acpi_group = {
 	.is_visible = acpi_attr_is_visible,
 };
 
+const struct attribute_group *acpi_groups[] = {
+	&acpi_group,
+	NULL
+};
+
 static const char *devm_acpi_device_str(struct acpi_device *dev)
 {
 	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
@@ -619,8 +624,6 @@ int acpi_device_setup_files(struct acpi_device *dev)
 	int result = 0;
 
 	dev->pnp.str = devm_acpi_device_str(dev);
-	result = device_add_group(&dev->dev, &acpi_group);
-
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
 
 	return result;
@@ -633,5 +636,4 @@ int acpi_device_setup_files(struct acpi_device *dev)
 void acpi_device_remove_files(struct acpi_device *dev)
 {
 	acpi_hide_nondev_subnodes(&dev->data);
-	device_remove_group(&dev->dev, &acpi_group);
 }
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 2a0e9fc7b74c..63dd78d80508 100644
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


