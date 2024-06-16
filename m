Return-Path: <linux-acpi+bounces-6440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F70909F69
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 21:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBB021C21E8A
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 19:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192EA5B1E4;
	Sun, 16 Jun 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rQSvq4WA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36C44962E;
	Sun, 16 Jun 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564621; cv=none; b=BMtRKiO/sNgCvcxZ034qrBGcpLn7M9k0n8WEDxniHUFLmeD7rhdx5CplFDX53R+6hvpByTF/E6uLNR7i9/FxnOO1l8Iz/0mNWZcKKON/obpmZzduhltlYnSJgePv4XHDCuFT3LH3OoQXvNshDemgrpN9InGI5kktBg6OkQj1mlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564621; c=relaxed/simple;
	bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q859nDWPdNV49juQXtVHLuinoDD/Dclivuiv2bqFyXsLl5sVWJiu4GLuG27iX9/44lv2wbzJpqT7Xc4RPLMjFRu+xikTJclySMRtP6ge9m0LBUWeyymcDEJymPrW7EggjDdEcjMoiUXyeddK1fY7gyEXH/3kIPwQC65BSEKmONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rQSvq4WA; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718564615;
	bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rQSvq4WAOQKBMeeTQt4Tw96nj288Fcq6HJAWMZ7s/swl/BvoHA4L/zE32l2c2JiJc
	 imUILPToMXRFNm/ingOtI4oXFVFlI5Ya+udpAK+Wu2rUA7YXURoAD3nhnz5+trZF3m
	 gh631Ss8e0PcBDOmOrjH3fcLeYvdPg8nIRs0aNbk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 16 Jun 2024 21:03:29 +0200
Subject: [PATCH v4 1/5] ACPI: battery: add devm_battery_hook_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240616-cros_ec-charge-control-v4-1-74d649a9117d@weissschuh.net>
References: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
In-Reply-To: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
To: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
 Dustin Howett <dustin@howett.net>, 
 Stephen Horvath <s.horvath@outlook.com.au>, 
 Rajas Paranjpe <paranjperajas@gmail.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, Matt Hartley <matt.hartley@gmail.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718564614; l=1828;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
 b=6jUwHQEhRN3fsEbZtDTs26qkhF6Mj6dfuOwZqbkJ/V2RbVhixZNJMKbpRx66zl0wy7RNVq6VI
 MUa4IC/bYvfDuDaG/94JGXAZ7QpwqNJ/9qO8l+XIkuWPHtS1iLvfqDt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a utility function for device-managed registration of battery hooks.
The function makes it easier to manage the lifecycle of a hook.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/acpi/battery.c | 15 +++++++++++++++
 include/acpi/battery.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b379401ff1c2..6ea979f76f84 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -756,6 +756,21 @@ void battery_hook_register(struct acpi_battery_hook *hook)
 }
 EXPORT_SYMBOL_GPL(battery_hook_register);
 
+static void devm_battery_hook_unregister(void *data)
+{
+	struct acpi_battery_hook *hook = data;
+
+	battery_hook_unregister(hook);
+}
+
+int devm_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook)
+{
+	battery_hook_register(hook);
+
+	return devm_add_action_or_reset(dev, devm_battery_hook_unregister, hook);
+}
+EXPORT_SYMBOL_GPL(devm_battery_hook_register);
+
 /*
  * This function gets called right after the battery sysfs
  * attributes have been added, so that the drivers that
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index 611a2561a014..c93f16dfb944 100644
--- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -2,6 +2,7 @@
 #ifndef __ACPI_BATTERY_H
 #define __ACPI_BATTERY_H
 
+#include <linux/device.h>
 #include <linux/power_supply.h>
 
 #define ACPI_BATTERY_CLASS "battery"
@@ -19,5 +20,6 @@ struct acpi_battery_hook {
 
 void battery_hook_register(struct acpi_battery_hook *hook);
 void battery_hook_unregister(struct acpi_battery_hook *hook);
+int devm_battery_hook_register(struct device *dev, struct acpi_battery_hook *hook);
 
 #endif

-- 
2.45.2


