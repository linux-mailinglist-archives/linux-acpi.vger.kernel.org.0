Return-Path: <linux-acpi+bounces-6293-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4DC902617
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22F3C289603
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ABF14AD3F;
	Mon, 10 Jun 2024 15:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lEXm9ND2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B722C1448E1;
	Mon, 10 Jun 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034734; cv=none; b=SHNKCeKZC1PoMrZqKOiXkui56BzoMdeqZI99OJAw5Q8hHg1DR0XtRgytFWGUZ3JaGkaOwxbJBKybuxHfnXZvk8nzFsABidRxJEJ64fV0TpFQUilwioVVf4xVe3VukSPeAv80KDorg4ZXdJ8rVR9PFDKJuYsdeyMjYhMEID6beOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034734; c=relaxed/simple;
	bh=yLPuywKxlke6NT+olphfKJbBjlPvjs/2umweIlCb7Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r4LdSs1DkHeYoc62U+z8YBl8OztuGIF6CYSaxhyphqrS0crWOx1cECYPR8xZZdudOywyz3SFMVgmHeDYF8Y5hmlZ3ItTLfCD4A4MO1h8+d4iB474ZHoITiBzW3KpK3BEfsFXAg5V9MaJAeczNsHZFeDQYiqMGmoLUtO//HDdXvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lEXm9ND2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034727;
	bh=yLPuywKxlke6NT+olphfKJbBjlPvjs/2umweIlCb7Oc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lEXm9ND2/w0HRAMcQ5ZiCAtRBk3MWTlkT5d9EupLPFpf6hZImMDXTccLMKg4dTuut
	 d0v7aTdKPpByQtbSKTIuhYLEGQU+f81/E8pOkE8QrjAlCbVUEZ3Y60u8wN5L85NfFO
	 ILf/NIGC2Y4dpY8vnYC8ndntu12W1AIkLyZZqxo4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 10 Jun 2024 17:51:10 +0200
Subject: [PATCH v3 5/5] power: supply: cros_charge-control: don't probe if
 Framework control is present
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240610-cros_ec-charge-control-v3-5-135e37252094@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=2319;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yLPuywKxlke6NT+olphfKJbBjlPvjs/2umweIlCb7Oc=;
 b=3wIbND3IYNvwmQXgsspa8RqWb8j8yyNshSXEsCKlvqFzB6+tqyIDudmsHo6iGQ9EoemomN9Mg
 6E4FnVddsYAArcpQMSS0ptxqSUcOjTFzP84Yy+KHgX733nZNaEmDUsI
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
index 056346850c6d..3688e021b4da 100644
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
@@ -259,6 +260,19 @@ static int cros_chctl_remove_battery(struct power_supply *battery, struct acpi_b
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
+	return cros_ec_cmd_versions(cros_ec, 0x3E03 /* FW_EC_CMD_CHARGE_LIMIT */);
+}
+
 static int cros_chctl_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -268,6 +282,14 @@ static int cros_chctl_probe(struct platform_device *pdev)
 	size_t i;
 	int ret;
 
+	ret = cros_chctl_fwk_charge_control_versions(cros_ec);
+	if (ret < 0)
+		return ret;
+	if (ret > 0 && !probe_with_fwk_charge_control) {
+		dev_info(dev, "Framework charge control detected, not probing\n");
+		return -ENODEV;
+	}
+
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;

-- 
2.45.2


