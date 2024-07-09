Return-Path: <linux-acpi+bounces-6832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D092C4B6
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 22:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADE628413C
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 20:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0146E18D4B2;
	Tue,  9 Jul 2024 20:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EA3+0yB2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39918C16D;
	Tue,  9 Jul 2024 20:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720557507; cv=none; b=GWEFAHMKrDDb/U4ko+HItF6Nt9Zl5iznu7Fgoe1on+ffWd7i6BMiqgpzZShM8FCqGVg+zw/CkYQhe31flFheyAhli6LEDrIQc0JoWMJzzHPO1K/TsMO0U5mU0+5lcUDTEVUhQM65LNHFUU9Q6N4GVMA2wyUIhWnTop1o77SPDEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720557507; c=relaxed/simple;
	bh=Sp5DrYzmn3EazYQ2PC86K+raUE9JkwKEQCb8FTClzrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+8YXT8+brpXlr+kD9CpA3yZDTmeoyo7n2NkQMQrckD1+CzysFEVR3zwFQ4S+JCRKoi6S65DO0hyu/SeJniW8AzhCqLUnj09uG/fhq4QcpoPmLs4snn658C9NzEpW/d7eKKdW9hNMVJ5DwFbOXaf0M78xDcXaejA5ZvoTs2lvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=EA3+0yB2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1720557500;
	bh=Sp5DrYzmn3EazYQ2PC86K+raUE9JkwKEQCb8FTClzrs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EA3+0yB2PHIBJKtW+y3CQIBw5APR8fXUtu2+dS0wz0E0csy5gCyo8wh+a+jMwogjp
	 ZthHyPewjWYNfkTtvKxFGW0ZpG7cVfdTUAyAQFSWw1x5Bbr2uAKP2j2zxDCIT2s2Hv
	 7IRMtJ0bGjU9XZmK/+8ZJf/POcSUZlYRbwS1m4qs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 09 Jul 2024 22:37:28 +0200
Subject: [PATCH v2 5/5] ACPI: sysfs: remove return value of
 acpi_device_setup_files()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240709-acpi-sysfs-groups-v2-5-058ab0667fa8@weissschuh.net>
References: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
In-Reply-To: <20240709-acpi-sysfs-groups-v2-0-058ab0667fa8@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Lance Ortiz <lance.ortiz@hp.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720557498; l=2071;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Sp5DrYzmn3EazYQ2PC86K+raUE9JkwKEQCb8FTClzrs=;
 b=7EuhOxj3EfzvjJ6IlNBC3jBTFhZv8oaD26FNHK1WVARBYCgFBEcOl4P9HVJcVh6FfMc8j+xOj
 ESnbwQWGUJ6AtnqHUsLtobZ0QUa3XboUCwZ5xRAsgYpcc0W0/JjI0qj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The function can not fail anymore, so drop its return value.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/device_sysfs.c | 6 +-----
 drivers/acpi/internal.h     | 2 +-
 drivers/acpi/scan.c         | 5 +----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 0bff4a1654ed..3961fc47152c 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -605,13 +605,9 @@ const struct attribute_group *acpi_groups[] = {
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
  */
-int acpi_device_setup_files(struct acpi_device *dev)
+void acpi_device_setup_files(struct acpi_device *dev)
 {
-	int result = 0;
-
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
-
-	return result;
 }
 
 /**
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 8e1c21e45d0e..ca712a7fde21 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -118,7 +118,7 @@ void acpi_init_device_object(struct acpi_device *device, acpi_handle handle,
 			     int type, void (*release)(struct device *));
 int acpi_tie_acpi_dev(struct acpi_device *adev);
 int acpi_device_add(struct acpi_device *device);
-int acpi_device_setup_files(struct acpi_device *dev);
+void acpi_device_setup_files(struct acpi_device *dev);
 void acpi_device_remove_files(struct acpi_device *dev);
 extern const struct attribute_group *acpi_groups[];
 void acpi_device_add_finalize(struct acpi_device *device);
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index c15fffefca0a..49a8172fe0de 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -766,10 +766,7 @@ int acpi_device_add(struct acpi_device *device)
 		goto err;
 	}
 
-	result = acpi_device_setup_files(device);
-	if (result)
-		pr_err("Error creating sysfs interface for device %s\n",
-		       dev_name(&device->dev));
+	acpi_device_setup_files(device);
 
 	return 0;
 

-- 
2.45.2


