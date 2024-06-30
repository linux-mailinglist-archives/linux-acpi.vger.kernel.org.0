Return-Path: <linux-acpi+bounces-6688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAF991D40F
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 22:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA52A1F21130
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 20:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAD67F7DB;
	Sun, 30 Jun 2024 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ejWDZHRf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A06A33B;
	Sun, 30 Jun 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781029; cv=none; b=qZx/2HbqfY8zXUCQ8v5IG+p4W8bCF4mL8eXcuAd+nKDkfGNCiPILI6CXfZobouIk6boPeK3+mulLSpV0lyEX9eIB7ZMiPJ5Nr+CFGWqIHTRz038EdPNlxmzX0YKHsovTATjvsoE9NVw+v+yMYhd6YgKa1bb3zRGT7ESJOtxat+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781029; c=relaxed/simple;
	bh=FHswT/YC3w5l89/ylaLvEiW7spavPfr3VgQBUJELu3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAR2Jd+6dX6gxgsHBy64AiHKarcd1zPNGxK5D5hVD8dPx8nivYTsx2NDx9F35CI/hbzMFYXSWY/dE1EFFTy37RCbxdYnmscDpQL0s1pVjTCVVM7SIj+bkYJaBIakEolKkeW64s5VmuShNPh7cZWI/0GvSWZq8sOGq984d8LEZs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ejWDZHRf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719781014;
	bh=FHswT/YC3w5l89/ylaLvEiW7spavPfr3VgQBUJELu3s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ejWDZHRfukisKwAihu3IBKvVmRI2U3XVHjJJhiKuB2hP4u4h7a1MfWKyCfjKzpzn3
	 XYY+AyxYMPfEUXIFrks+w0A/FaPIBbB+UcwH9IH4dRLkPflPrxte+pKs7fu+sIdDew
	 gyeQCt49lMuafdri87CdHR2KJYCYg8WqN7DqfjeY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 30 Jun 2024 22:54:12 +0200
Subject: [PATCH v5 5/5] power: supply: cros_charge-control: don't load if
 Framework control is present
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240630-cros_ec-charge-control-v5-5-8f649d018c52@weissschuh.net>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719781012; l=2327;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=FHswT/YC3w5l89/ylaLvEiW7spavPfr3VgQBUJELu3s=;
 b=1QB20YP670zdAMsu+gSGB/2BNGtpNQBitzKUlDkaUW00pP/1MiQeShLkXCRsGogQyDekRu7nJ
 vjZV5uosjOECbDQD/3zZ6EaE39KCofha3E0CyEfdUPoeCn1cO0bwOFm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Framework laptops implement a custom charge control EC command.
The upstream CrOS EC command is also present and functional but can get
overridden by the custom one.

Until Framework make both commands compatible or remove their custom
one, don't load the driver on those machines.

If the user knows they are not going to use the custom command they can
use a module parameter to load cros_charge-control anyways.

Note that the UEFI setup configuration for battery control also uses
their custom command.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/power/supply/cros_charge-control.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/power/supply/cros_charge-control.c b/drivers/power/supply/cros_charge-control.c
index 521b0eb4ff3b..73d7f2dc0fa3 100644
--- a/drivers/power/supply/cros_charge-control.c
+++ b/drivers/power/supply/cros_charge-control.c
@@ -6,6 +6,7 @@
  */
 #include <acpi/battery.h>
 #include <linux/container_of.h>
+#include <linux/dmi.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_data/cros_ec_commands.h>
@@ -256,6 +257,19 @@ static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_b
 	return 0;
 }
 
+static bool probe_with_fwk_charge_control;
+module_param(probe_with_fwk_charge_control, bool, 0644);
+MODULE_PARM_DESC(probe_with_fwk_charge_control,
+		 "Probe the driver in the presence of the custom Framework EC charge control");
+
+static int cros_chctl_fwk_charge_control_versions(struct cros_ec_device *cros_ec)
+{
+	if (!dmi_match(DMI_SYS_VENDOR, "Framework"))
+		return 0;
+
+	return cros_ec_get_cmd_versions(cros_ec, 0x3E03 /* FW_EC_CMD_CHARGE_LIMIT */);
+}
+
 static int cros_chctl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -265,6 +279,14 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	size_t i;
 	int ret;
 
+	ret = cros_chctl_fwk_charge_control_versions(cros_ec);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && !probe_with_fwk_charge_control) {
+		dev_info(dev, "Framework charge control detected, preventing load\n");
+		return -ENODEV;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;

-- 
2.45.2


