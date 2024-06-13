Return-Path: <linux-acpi+bounces-6391-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6FE907D43
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 22:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B84D0B242FF
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 20:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13B13BACB;
	Thu, 13 Jun 2024 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="s6UXzttw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB34213B2AC;
	Thu, 13 Jun 2024 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309740; cv=none; b=rYOGYx/eZHisVEN6NKRxS5IvqAcAjCvsHMiJGWDywiOnoQBiVfqeuteB/+NSwZ9t08rAaw4ONU7R8kG7Lax+8rj00h0Am6FQ/IpPlfAl2kI4EA41ozkBafHUO+qx6uk9IeOdVK1IOL01yet9IXulLJ7ARruJdHRcwNQkKSTQy28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309740; c=relaxed/simple;
	bh=uz3G8XwtTUx7pGyHKuMJTv6ZsMZ4E3FM8B10yoRcG+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lmWekFVfQAPtbjteqbk0mR777JZYCnlauPOumIDAcUOEitOjEVcAKQmT/BHqn0cWA4OoDff9g0vhlb1Ky6bdHl+MOZKyv/kBuXLmTmojOiQPbKziLuoeQodzO7FWnh8lzmJxOUKmlCnKdhgz+htNQQCzyIiLFxGvvNy45UOLOB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=s6UXzttw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718309732;
	bh=uz3G8XwtTUx7pGyHKuMJTv6ZsMZ4E3FM8B10yoRcG+E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s6UXzttwVWIX3YF/8qTQzMhi4Of/9wP5SpKKBIvpDYcC529qGm6PpxXuTg23mfzRI
	 Y+5pEBsmKJF96OJdOKY3uovY72jyXLKaC50MF/z7zfFMp8tK/P9ARNGvr9gm0W+anF
	 aAuQl2T2E0KbTB+QlPFUDpW9yhx7lIYP+DvPfpqE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 13 Jun 2024 22:15:36 +0200
Subject: [PATCH 5/5] ACPI: sysfs: remove return value of
 acpi_device_setup_files()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240613-acpi-sysfs-groups-v1-5-665e0deb052a@weissschuh.net>
References: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
In-Reply-To: <20240613-acpi-sysfs-groups-v1-0-665e0deb052a@weissschuh.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718309732; l=2134;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uz3G8XwtTUx7pGyHKuMJTv6ZsMZ4E3FM8B10yoRcG+E=;
 b=2cu/wdwm0qQfux6dwms8j3LcvJ8gZoJhkLB9ueU/8vGNsIVx3IQACCQxdNND4BTZmwPDWhzpx
 vvds8e2vZ1gD8qGfBYEn7FlQS6upf7abphkvk4/BG0HvVeFCoYzQig7
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
index f1e8928254c2..c85ec754931c 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -619,14 +619,10 @@ static const char *devm_acpi_device_str(struct acpi_device *dev)
  * acpi_device_setup_files - Create sysfs attributes of an ACPI device.
  * @dev: ACPI device object.
  */
-int acpi_device_setup_files(struct acpi_device *dev)
+void acpi_device_setup_files(struct acpi_device *dev)
 {
-	int result = 0;
-
 	dev->pnp.str = devm_acpi_device_str(dev);
 	acpi_expose_nondev_subnodes(&dev->dev.kobj, &dev->data);
-
-	return result;
 }
 
 /**
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index 63dd78d80508..e71fecbf731c 100644
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


