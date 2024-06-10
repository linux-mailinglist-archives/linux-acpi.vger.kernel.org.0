Return-Path: <linux-acpi+bounces-6288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFADD902608
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E7E1F22F66
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Jun 2024 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA7211420D5;
	Mon, 10 Jun 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GRS4dhbB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4BD12FF86;
	Mon, 10 Jun 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034730; cv=none; b=ltOwujYqsOcO7LmtOSDPN2SMJCfBD5Y/57rebWaT7lYF9UfD+QXLavw69URT/UR3S1FTFUTc/j2gAZ0paHI5KJ2Z3sW9BOmYc/DX2C3GN9LupNIOaFP2cBC8OrCWdkZWuTej32kC2wGATplfuI5E/PkwKL2WX645XfyL8DphOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034730; c=relaxed/simple;
	bh=B+BmXZ5qZDIVGEpUA06d7j3p6sTYhDXUE+28xZo6acc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ptj7SAbiLLqdUuXG7ChKGRfeFWgBxmNDh8eQY8frYzlryX+l5KpQbGL19qOdK8LyLVGYoeiCExPvy7LDuPNpa8v5DyUDhlzYPHHuguHsrg/pM8p2GO/E+We5+QRJZW0ZdHtAeFf27zNINaWIuDAl8BMuBbJLOoNRS6mjkFx4T4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GRS4dhbB; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718034726;
	bh=B+BmXZ5qZDIVGEpUA06d7j3p6sTYhDXUE+28xZo6acc=;
	h=From:Subject:Date:To:Cc:From;
	b=GRS4dhbBEqLNbaCXaJFcsmkBczGuJCvGP7v3IveCU1/SJRojIktrXCt5yycFv94fg
	 OiFWM7UtzHgXMh/7e8dMpZ90kKhXXV5H6h08gt3nxuEgkVl3xtrZgmLwq5yh3aA3Xj
	 3Z0jFwticd2JmnBiCQtRqYx2+niR0MfpD/2/Nb08=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 0/5] ChromeOS Embedded Controller charge control driver
Date: Mon, 10 Jun 2024 17:51:05 +0200
Message-Id: <20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOkgZ2YC/3XNTQrCMBAF4KuUrI0k6U9SV95DRNp0YgKSSKZGp
 fTupsWFIF2+ebxvJoIQHSA5FBOJkBy64HModwXRtvNXoG7ImQgmKlazhuoY8AKa5jbmVgc/xnC
 jjaobLkHBoCTJ43sE414rfDrnbB2OIb7XP4kv1y/J2y0yccpo35mS1YOWba+OT3CIqO3D7j2MZ
 HGT+LGE2rREthQ3vZDAtTHVnzXP8weEOHG3DQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718034726; l=3358;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=B+BmXZ5qZDIVGEpUA06d7j3p6sTYhDXUE+28xZo6acc=;
 b=UUGIGZ3G79lRyCnFvOXud2og3s9MLEr5TuuGr6aFbAjrqWDeKHjw3ozHGucgUcU83dnqaKyV+
 eFjXzFwZRzrBxWbeDL3CtRw20Rpe+Jw+MbZDDIlmKImS2r+6tEC2Jhq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Note:
To be useful, this series depends on
commit 08dbad2c7c32 ("mfd: cros_ec: Register charge control subdevice")
from the MFD tree [0].

Add a power supply driver that supports charge thresholds and behaviour
configuration.

This is a complete rework of
"platform/chrome: cros_ec_framework_laptop: new driver" [1], which used
Framework specific EC commands.

The driver propsed in this series only uses upstream CrOS functionality.

Tested on a Framework 13 AMD, Firmware 3.05.

This driver should go through the chrome-platform tree.
Otherwise "platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_versions()"
will conflict with
commit a14a569a9918 ("platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_readmem()")
from chrome-platform/for-next.

The patch
"platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_versions()"
is also part of my series
"hwmon: (cros_ec): fan target, fan pwm control and temperature thresholds"[2].

Based on chrome-platform/for-next.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=08dbad2c7c3275e0e79190dca139bc65ce775a92
[1] https://lore.kernel.org/lkml/20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net/
[2] https://lore.kernel.org/lkml/20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net/

Changes in v3:
- Drop MFD patch that was already applied
  (therefore drop Lee from series recipients)
- Introduce and use devm_battery_hook_register()
- Note that the driver should go through the chrome-platform tree
- Introduce and use cros_ec_cmd_versions()
- Drop logging about impossible charge behaviours
- Use sysfs_attr_init()
- Disable probing on incompatible Framework devices by default
- Link to v2: https://lore.kernel.org/r/20240528-cros_ec-charge-control-v2-0-81fb27e1cff4@weissschuh.net

Changes in v2:
- Accept "0" as charge_start_threshold
- Don't include linux/kernel.h
- Only bind to the first found battery
- Import EC_CMD_CHARGE_CONTROL v3 headers
- Add support for v1 and v3 commands
- Sort mfd cell entry alphabetically
- Link to v1: https://lore.kernel.org/r/20240519-cros_ec-charge-control-v1-0-baf305dc79b8@weissschuh.net

---
Thomas Weißschuh (5):
      ACPI: battery: add devm_battery_hook_register()
      platform/chrome: Update binary interface for EC-based charge control
      platform/chrome: cros_ec_proto: Introduce cros_ec_cmd_versions()
      power: supply: add ChromeOS EC based charge control driver
      power: supply: cros_charge-control: don't probe if Framework control is present

 MAINTAINERS                                    |   6 +
 drivers/acpi/battery.c                         |  15 ++
 drivers/platform/chrome/cros_ec_proto.c        |  26 ++
 drivers/power/supply/Kconfig                   |  12 +
 drivers/power/supply/Makefile                  |   1 +
 drivers/power/supply/cros_charge-control.c     | 359 +++++++++++++++++++++++++
 include/acpi/battery.h                         |   2 +
 include/linux/platform_data/cros_ec_commands.h |  49 +++-
 include/linux/platform_data/cros_ec_proto.h    |   2 +
 9 files changed, 470 insertions(+), 2 deletions(-)
---
base-commit: c8a4bdca928debacf49524d1b09dbf27e88e1f18
change-id: 20240506-cros_ec-charge-control-685617e8ed87

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


