Return-Path: <linux-acpi+bounces-8565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846959915B9
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3934A1F22D91
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Oct 2024 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612F9146A79;
	Sat,  5 Oct 2024 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="XVKwSV9C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB954F95;
	Sat,  5 Oct 2024 10:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728122730; cv=none; b=Tscr0CvkMxWdF5gyJO4vPubWTZ+VTPMA1/k2ndxnE3OmI9QVlTZvW7XZ8aTdjqrE5VFdwaVr7WgwWtCumKsXFJGkoivIjwgsabgajvqCTDQqLrxAQ+AY49Qd8vDUBGdQRqDmn4UyZAlX9wRuGlXoMvaD5bWygTgWd5cGxVkWnd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728122730; c=relaxed/simple;
	bh=aY3x1zoEK/AerqbuxoCWJqyPGjSGQrsN4fv559DLlnc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VfWKFaYA1cc3BCK6ZkUD0dfFdo3x55/SWjWTrZZnUggbNb4bhcNsOooxQTOmpAQFz2hsLwBZuq8cU2z56s2sX5te/zZ2XxF3sdW2Fe+6pDPxHRVH22f9P9PjJHT6HlNTzNKGriT+ZsiU7r0Pw1CcYVEXp+fVb+eTeIwT8YHpu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=XVKwSV9C; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1728122726;
	bh=aY3x1zoEK/AerqbuxoCWJqyPGjSGQrsN4fv559DLlnc=;
	h=From:Subject:Date:To:Cc:From;
	b=XVKwSV9Cb3eg68g+wKRk224+KTLGOoprfOxyFZQKjnAOUDI8t2fH+6kZXeShr6F4Z
	 JVuW3SHewQ0gSh5cXhVS1VC8xUPtHo+oPjrZydjsjlgIDdQrFytRIWjFRhI+MGS/Bx
	 zZaR8HEO9dIDUvIswJJ9Dht+WhKtBPi8ArXI1ERk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/8] power: supply: core: remove
 {,devm_}power_supply_register_no_ws()
Date: Sat, 05 Oct 2024 12:05:02 +0200
Message-Id: <20241005-power-supply-no-wakeup-source-v1-0-1d62bf9bcb1d@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAE4PAWcC/x3MwQqDMAwA0F+RnBfQosPuV8YOXc1mUNqQ0Lkh/
 rtlx3d5Oxgpk8Gt2UHpw8Y5VXSXBuIc0puQp2pwretb7xxK3kjRisj6w5RxCwsVQctFI2E/xKn
 zz+sYfIB6iNKLv////jiOE39d7IlvAAAA
X-Change-ID: 20240922-power-supply-no-wakeup-source-45cd19b68a9a
To: Sebastian Reichel <sre@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, chrome-platform@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728122726; l=1840;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aY3x1zoEK/AerqbuxoCWJqyPGjSGQrsN4fv559DLlnc=;
 b=6a85BGLKptqISfDlab43RGOcxCftbSsCSnFrs47gEEzs4VONZ1vV5qMB9IXg5s4/iAKYMHd/r
 qOZAfotnmMZB4VGH/otOj534lvLNv9UwiWwpS74no/6E4JeM1rNp4zA
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The meaning of the _no_ws() suffix is not immediately clear when reading
the code. Furthermore there is already a dedicated API to configure the
details of the created power supply in "struct power_supply_config".
Migrate the functionality to "struct power_supply_config" and remove the
special functions.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (8):
      power: supply: core: add wakeup source inhibit by power_supply_config
      ACPI: battery: Register power supply with power_supply_register()
      power: supply: acer_a500_battery: register power supply with devm_power_supply_register()
      power: supply: bq27xxx_battery: register power supply with power_supply_register()
      power: supply: cros_usbpd-charger: register power supply with devm_power_supply_register()
      power: supply: lenovo_yoga_c630_battery: register power supplies with power_supply_register()
      power: supply: max77976_charger: register power supply with devm_power_supply_register()
      power: supply: core: remove {,devm_}power_supply_register_no_ws()

 drivers/acpi/battery.c                          |  3 +-
 drivers/power/supply/acer_a500_battery.c        |  7 +--
 drivers/power/supply/bq27xxx_battery.c          |  3 +-
 drivers/power/supply/cros_usbpd-charger.c       |  4 +-
 drivers/power/supply/lenovo_yoga_c630_battery.c | 14 ++---
 drivers/power/supply/max77976_charger.c         |  3 +-
 drivers/power/supply/power_supply_core.c        | 68 ++-----------------------
 include/linux/power_supply.h                    | 10 +---
 8 files changed, 26 insertions(+), 86 deletions(-)
---
base-commit: 27cc6fdf720183dce1dbd293483ec5a9cb6b595e
change-id: 20240922-power-supply-no-wakeup-source-45cd19b68a9a

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


