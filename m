Return-Path: <linux-acpi+bounces-17761-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662B6BDCF3F
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 09:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71F4C500664
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 07:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3643B3164B0;
	Wed, 15 Oct 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GldMEpEI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7771B2FE577;
	Wed, 15 Oct 2025 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512689; cv=none; b=hVy5YDfjmTGhmLyzvzcsC7FAjvdVftixD7f0WV7/1Lfl290EggUE3/5L5YcH5FJkpMnqnKyGqyg0L9WbK+zNi8Lv0ozYRouGcBfqcc/tcH4dAuPdSe6ndp+WWbyYUrUKrwURlmOAh0ImLDwFC0ZOz4M559zSlmeAn3x3jituHpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512689; c=relaxed/simple;
	bh=Qgk9ws5aXxDeyn5NE0DxbdnlQ5k13s8sVdRxg/Kexsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtdD6yA6mxNYadrurcKkf0VCACIo65k7N1K3uZ/AmYE4kRI52ULOImijmC/679/jsemkFvIIfCEm+OqUwROgzbKGyncYvQV6gC1IG/xDCvsvqFB9GdKRdg7hxVn6WinLgs+7R8uSSEHG6/ThWzSYEQkTubJ9zwm2Y1yf+tspYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GldMEpEI; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 05ED7C09FAA;
	Wed, 15 Oct 2025 07:17:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1B856606F9;
	Wed, 15 Oct 2025 07:18:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF3C2102F22AF;
	Wed, 15 Oct 2025 09:17:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760512683; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=7ba2kvIEiYd6+4yELgjvxRr5Z7VYqHNfLM5E8wIB8PA=;
	b=GldMEpEIoYIN5a8/gbXjzN9AEkTzQqGbhyYQdqAtoOI0+cgqZqh29Qa8v9JDWgFET+Z5YI
	Fc9fh6yEliz3gHGoiXNDONsXD6xxsujNUJ1qeEgW8tCFgVm5wmDRZ0nRkCiq7icVC/ghdb
	bZbtELTbFX/uKfveXMkfCcOYcrkp/XXkRce/G59hU98nhR8uiHorjjlAl85DIy9WeMuDzv
	qKHe2E2CdvD+ejXwb+x/DkE81vxgNM7p/SIoy2PzaRqzaVe/hg0fup7rQmr86HhXL7pgBY
	BMr5JM5OhO+Aoy05EQFBW7K2O1rsTYEIDpUIdLdIBYN9oqMZrLQq1YlsZ9YOIQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Arnd Bergmann <arnd@arndb.de>,
	Herve Codina <herve.codina@bootlin.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Wolfram Sang <wsa@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 09/29] drivers: core: Use fw_devlink_set_device()
Date: Wed, 15 Oct 2025 09:13:56 +0200
Message-ID: <20251015071420.1173068-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015071420.1173068-1-herve.codina@bootlin.com>
References: <20251015071420.1173068-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The code set directly fwnode->dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 3e81b1914ce5..9da630d75d17 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3739,7 +3739,7 @@ int device_add(struct device *dev)
 	 * device and the driver sync_state callback is called for this device.
 	 */
 	if (dev->fwnode && !dev->fwnode->dev) {
-		dev->fwnode->dev = dev;
+		fw_devlink_set_device(dev->fwnode, dev);
 		fw_devlink_link_device(dev);
 	}
 
@@ -3899,7 +3899,7 @@ void device_del(struct device *dev)
 	device_unlock(dev);
 
 	if (dev->fwnode && dev->fwnode->dev == dev)
-		dev->fwnode->dev = NULL;
+		fw_devlink_set_device(dev->fwnode, NULL);
 
 	/* Notify clients of device removal.  This call must come
 	 * before dpm_sysfs_remove().
-- 
2.51.0


