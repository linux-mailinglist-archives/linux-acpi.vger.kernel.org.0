Return-Path: <linux-acpi+bounces-6684-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DCB91D401
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA23B1F21391
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE1F4644C;
	Sun, 30 Jun 2024 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M2HAtGf9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE45443AAE;
	Sun, 30 Jun 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719781025; cv=none; b=q3uav/JRJLhlqCHOpgIeaGrSAMl4Mt3e1MiV+WwQSHdKYJjr9P94AFB1qg3n+rv0WDNoWPrkSeGRXOh2D+rSpQfgJPoFwppqe9FNOpDatqBh6dNoFSJgXieasddBqWk9AdOMPRWYnA6NPU6V02/MRnE5ZqOU/+leuGRM9XtWJYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719781025; c=relaxed/simple;
	bh=px29FCaWkuvHZFJhAQCq+siNyxWQp3T1anaxONg/3xk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Da0BAgJVl1qfHvI727SKeqZG5wwA3bTyFIgviyEpurgzrqXfz3oELJqOWv8csghuaX4QdHSdih2rfwB6inRLXWQ81XJAb+fsA+3SCSD2HDCdbeJWXwN0pUx2YK65MCSOeVzIyLxWUKO/4DtY6tzrgPu6AwUqHp0Edjg8beAKxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M2HAtGf9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1719781013;
	bh=px29FCaWkuvHZFJhAQCq+siNyxWQp3T1anaxONg/3xk=;
	h=From:Subject:Date:To:Cc:From;
	b=M2HAtGf9EnPw4kDWn9QnkhY9scfD2kiR+30dzPhmTAQwYG9E6ez01rf9RnCtYdrHi
	 8URtzrO61N/f6EI1KsqgiegggpSX15OIZCo06ZJcpf4hiHyGXOfXs+BAmGQQ377fvd
	 qnj6oqx4HnpYZhbBpoRpyxRk6aemNY0YV3PWhtMc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 0/5] ChromeOS Embedded Controller charge control driver
Date: Sun, 30 Jun 2024 22:54:07 +0200
Message-Id: <20240630-cros_ec-charge-control-v5-0-8f649d018c52@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAO/FgWYC/3XQ3WoDIRAF4FcJXtfi+G+v8h6hlF0du0JZi25MS
 9h3rwmBBJq9PHOYb2DOpGJJWMnb7kwKtlRTnntQLzvip2H+RJpCz4QzLplimvqS6wd62tvSW5/
 npeQvqq3SYNBisIb05e+CMf1c4cN7z1OqSy6/1zsNLtMbCW6LbEAZHYcomAreuNHuT5hqrX46T
 q8zLuTiNv5gcbtp8W5ZiCM3CD5G+dQSd0sD27REt0AoFIYrztxzSz5am29rsltGBi3d4ABM+Ge
 t6/oHBUl0/qUBAAA=
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719781012; l=4481;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=px29FCaWkuvHZFJhAQCq+siNyxWQp3T1anaxONg/3xk=;
 b=BMi6BXHTnXsIQa9ThGI7GWqu8hdy4WYKpatVGpslxq86dvWAn9PyECpAqKUV+O4QNVn1JeOnG
 xwbPmtNGeUJB5XB3Gz/Bis0vg3da15sZF7ANAin3AmHXSf9P7v/O8eo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Tzung-Bi, this series now has Acks from all involved maintainers.
The only open question is on how to handle the incompatibility with the
Framework-specific commands.
But the currently implemented solution is the most safe one;
so in my opinion this series could be applied as is and then we can
always relax that restriction later.

--

Add a power supply driver that supports charge thresholds and behaviour
configuration.

This is a complete rework of
"platform/chrome: cros_ec_framework_laptop: new driver" [1], which used
Framework specific EC commands.

The driver propsed in this series only uses upstream CrOS EC functionality.

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

To be useful, this series depends on
commit 08dbad2c7c32 ("mfd: cros_ec: Register charge control subdevice")
from the MFD tree [0].

Based on chrome-platform/for-next.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=08dbad2c7c3275e0e79190dca139bc65ce775a92
[1] https://lore.kernel.org/lkml/20240505-cros_ec-framework-v1-0-402662d6276b@weissschuh.net/
[2] https://lore.kernel.org/lkml/20240608-cros_ec-hwmon-pwm-v1-0-d29dfc26fbc3@weissschuh.net/

Changes in v5:
- Pick up Ack from Sebastian
- Some tiny cosmetic changes:
  - Drop trailing comma after sentinel entry of enum CROS_CHCTL_ATTR
  - Properly terminate battery hook assignments with semicolon instead
    of comma
  - Inline #define DRV_NAME
  - Drop space from struct initializer: { } -> {}
- Link to v4: https://lore.kernel.org/r/20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net

Changes in v4:
- Rename cros_ec_cmd_versions() to cros_ec_get_cmd_versions()
- Use EC_CMD_GET_CMD_VERSIONS v0 in cros_ec_get_cmd_versions() if possible
- Drop now unnecessary EOPNOTSUPP check after initial configuration
- Collect review tags
- Link to v3: https://lore.kernel.org/r/20240610-cros_ec-charge-control-v3-0-135e37252094@weissschuh.net

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
      platform/chrome: cros_ec_proto: Introduce cros_ec_get_cmd_versions()
      power: supply: add ChromeOS EC based charge control driver
      power: supply: cros_charge-control: don't load if Framework control is present

 MAINTAINERS                                    |   6 +
 drivers/acpi/battery.c                         |  15 ++
 drivers/platform/chrome/cros_ec_proto.c        |  35 +++
 drivers/power/supply/Kconfig                   |  12 +
 drivers/power/supply/Makefile                  |   1 +
 drivers/power/supply/cros_charge-control.c     | 354 +++++++++++++++++++++++++
 include/acpi/battery.h                         |   2 +
 include/linux/platform_data/cros_ec_commands.h |  49 +++-
 include/linux/platform_data/cros_ec_proto.h    |   2 +
 9 files changed, 474 insertions(+), 2 deletions(-)
---
base-commit: 1c34ab03323fb03329cf8d9b8804b9501cd1bbf3
change-id: 20240506-cros_ec-charge-control-685617e8ed87

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


