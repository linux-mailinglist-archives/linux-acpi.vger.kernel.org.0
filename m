Return-Path: <linux-acpi+bounces-6441-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9924909F6F
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 21:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42547B21DEB
	for <lists+linux-acpi@lfdr.de>; Sun, 16 Jun 2024 19:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5EC6A03F;
	Sun, 16 Jun 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IyQT/LST"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112B46447;
	Sun, 16 Jun 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718564621; cv=none; b=LgONucL/GxwhCcefjnDGZIxXY7hjeswrw4MwLCs8RfL4Sfj006SF78foC961pdF1A6GLqypIiY0dDUH9FtMWZF6YW4+axWXtzKhBYiHdy/Vz+Ob+9WZk1q9UlLdofm8cjcLdBHNZVdnthN9jQVQI6TgVvsiV7anZz1nVVZPZEZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718564621; c=relaxed/simple;
	bh=gXTnhlU5Io5nihYJh0y7c6dEfQuOsKvf+5cInXCGPG0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yuj4khl0uPEWwHelRubPNs518Ie5Jl+QVwxqPtMQdZYbZUsEcsjmt3HEW3gi5+udCwyKi+3fdn3Q6+ph8j+yc3r/buTLSS8ElDGqM/3CAMoGwYdTO+6ZjMnFO4Rwe3bUxyeLb4wB9jIaIaR13IOXWfxitAzs59a8fVPlIFylhnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IyQT/LST; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1718564615;
	bh=gXTnhlU5Io5nihYJh0y7c6dEfQuOsKvf+5cInXCGPG0=;
	h=From:Subject:Date:To:Cc:From;
	b=IyQT/LST8fRUGwoKBxx+XicplmeqaPg0s2CknbC264dTxLYMwdm8M72TPIUI7GnMf
	 8xB2RitTGtqhir6Ekm8ovxJL6n9n5F5JdsPnnARJzqRWKpf3emuYO4Ry+rNuYH7/Sv
	 ZjtKtlvWtNr82F/KywgiK2NlVHo4qDZgDXj0XGQ4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 0/5] ChromeOS Embedded Controller charge control driver
Date: Sun, 16 Jun 2024 21:03:28 +0200
Message-Id: <20240616-cros_ec-charge-control-v4-0-74d649a9117d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAE3b2YC/3XNWwrCMBQE0K2UfBvJo3nUL/chIm16YwPSSFKjU
 rp30yIoaD/nDnPuiCIEBxHtihEFSC463+dQbgpkuro/A3ZtzogRVhJBJDbBxxMYnNuQW+P7Ifg
 LllpIqkBDqxXK42sA6x4LfDjm3Lk4+PBc/iQ6X98krdbIRDHBTW05Ea1RVaP3d3AxRtPdum0PA
 5rdxL4splctli1NbcMUUGNt+dfiH0tSsmrxbFEugCsmGKl+rWmaXm5Z+4tZAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718564614; l=3717;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=gXTnhlU5Io5nihYJh0y7c6dEfQuOsKvf+5cInXCGPG0=;
 b=KKZQwJDP81bAATQ2cDKcnGCyYlX04gXYA04mWIRKQU1G9Tj+Z3zGQvRo5KsewLklrmGmiaBjl
 dF5ARBHmYVsDoWvNNPEATdMAGM0EEf1H9snfZxGJCebKFILaZZvAkv6
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
 drivers/power/supply/cros_charge-control.c     | 357 +++++++++++++++++++++++++
 include/acpi/battery.h                         |   2 +
 include/linux/platform_data/cros_ec_commands.h |  49 +++-
 include/linux/platform_data/cros_ec_proto.h    |   2 +
 9 files changed, 477 insertions(+), 2 deletions(-)
---
base-commit: b57cd5703a1618e87772094ac12c5ee7d6c35e2f
change-id: 20240506-cros_ec-charge-control-685617e8ed87

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


