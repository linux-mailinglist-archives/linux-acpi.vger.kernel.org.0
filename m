Return-Path: <linux-acpi+bounces-6291-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8849D902612
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E92E287DE3
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15C145328;
	Mon, 10 Jun 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XOvkVDEJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A021013F450;
	Mon, 10 Jun 2024 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034732; cv=none; b=oWFJ0BP2TEYE9gssGalDlvz3PKCPrB3gwi77aOWdLOVAR2CZZxJkVZm77f3KxeQgap4Z2KeXUP+dc8goAjCP56R3q8+kZE7GfRBlVipMONiAtYxj9QOwp2uNCpJeCCFOQ+RncOsj63Sx82uEkdji+Ar9Inuou43q6DDxKTOqL3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034732; c=relaxed/simple;
	bh=YZm4xIk6nDiHtUnYqBTNSv20zxWLGRO9uBNg5Cg7bQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRQ7/EQXpesarCbmDkxQGmUPpSdskjtLim7SSK2kjZRqYHFufX/wHy3ibKDqvPegH5Zc2nViHaz9GAErGGbaTgQAceGGSdyPHY+ImFXNgZjDFCbbs8FDwDhDNd+4yZuyTA2qCNLXq4txXERSLPPNH9Na19j9OpNz2XnkJQm0bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XOvkVDEJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034726;
	bh=YZm4xIk6nDiHtUnYqBTNSv20zxWLGRO9uBNg5Cg7bQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XOvkVDEJHfvHFbY9wdP2Vj+VokZ7VSnZU5+EApDrSMrsNss74IZP4ZdY+GajjLkdB
	 nUWq36d5su33vDqCSc2p0sM27tW0T10G+Fs885e3InBQbndn9sOKqL6+4lQ1zU6tpV
	 BaPSHQvmnJJjIfEJCICq5OzdoaTXxJUzlRDDK+sI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 17:51:06 +0200
Subject: [PATCH v3 1/5] ACPI: battery: add devm_battery_hook_register()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-cros_ec-charge-control-v3-1-135e37252094@weissschuh.net>
References: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
In-Reply-To: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=1770;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YZm4xIk6nDiHtUnYqBTNSv20zxWLGRO9uBNg5Cg7bQQ=;
 b=2g/GG8lqFBwdVD+9PVUjWJO48YOQ51A4lhZ4oqz9aZkY/sUylc/F86XTHLl0BJhRc3qNpKH2N
 +bXFL/y/wKDA8d/xiSsmQeubz6EGMIRrC2FD09hwoLaV+HNcLEa1UI4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add a utility function for device-managed registration of battery hooks.
The function makes it easier to manage the lifecycle of a hook.

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


