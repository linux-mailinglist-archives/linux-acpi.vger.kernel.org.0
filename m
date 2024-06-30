Return-Path: <linux-acpi+bounces-6683-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DA191D403
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673C2B20DCB
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A5645C18;
	Sun, 30 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZAydGxhz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA31E433CE;
	Sun, 30 Jun 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781025; cv=none; b=LoX2AF5nbCVYv8heuaoXXcxOzuHXTw57kx3717pZjcESI6iMep10RNTHYj7cW6YHulaicj6iB1G6q00iaKxPYym5JEcdlRpnQej6Oq9RVWg2fr1g+AxGW8PMPem7aCw5/3dUaKNWxyudCSLKucnRWDd+bhz2oOI1mm8e4izwMFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781025; c=relaxed/simple;
	bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuOMK70QDV7ZZe8EO0JejQ01L7SHOSlwBuLFUpUEcld+H73xdjD5ABsPgfEjmYMrzcjjdA+vLigZxBvxmTf8Ik1Ud8iJmAJgEkprzKzTKXO2zmgaFnVXPYlw6iX6a8SqBlLI84AhW33vgh7CxM/hwog044TdeaIaW2CI3Q064bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ZAydGxhz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719781013;
	bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZAydGxhzKy2BRBPebAf7jE+fd7WxQqrzZxNBo/mukB5ZHdKF5KZFR0MufVAIF2b1N
	 GGNOORrbdWk+h7TccUCPrZj8f0FY3aBHEaMHdpMVodMdsth58+r9qfXnXMWU5/KWs3
	 ibv478/fkqXAKT/IM4ac8JVXf6OmKpEK6xWDOfnE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 30 Jun 2024 22:54:08 +0200
Subject: [PATCH v5 1/5] ACPI: battery: add devm_battery_hook_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240630-cros_ec-charge-control-v5-1-8f649d018c52@weissschuh.net>
References: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
In-Reply-To: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
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
 Kieran Levin <ktl@framework.net>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719781012; l=1828;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uw8nLh7+K+VERVHPyxd+3eO/7NhujZLZvDsfiJLrD+k=;
 b=RVHWtd+9L3ZrbCRqbpof/wsE5mrtK9K0/YEZaN/a9i6SR8hj7KrpRk8ZtiXYKXO9+44YXlQiI
 QQn4bscPzLNDyntpXJ4CsPxXedowJSEKebuEvvKhMTz6EuIMxZ1eENi
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


