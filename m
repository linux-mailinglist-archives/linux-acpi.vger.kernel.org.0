Return-Path: <linux-acpi+bounces-17768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA149BDD04B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 09:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84864FFE75
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Oct 2025 07:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0C531D741;
	Wed, 15 Oct 2025 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h3R6H0/h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB03191AB
	for <linux-acpi@vger.kernel.org>; Wed, 15 Oct 2025 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512773; cv=none; b=k1xef6RmVDlmM9SaLsQwbOKN78Vxox9EshTGaAiKKX2qO2LNninPvuRMX9r24aqVjiRi/2SU6ecdipKUmrzTtGBqpSlq7UYiMgOE1AzhV8hwkPYjHMIVU6uwa44dLrNy6NBHAzhjOE4Hh1jWCS/P0QtWlalC1rXoEe+64i6vbQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512773; c=relaxed/simple;
	bh=gCSAma4Tte2egcK83g3zRKGkv6+1Id19gs9QkGE3d0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tt9J+d9ZvcYXSzssvcDGQukA/S9Wc5dPYYDdjvOI17AULdt73vMFZTJj6ZJCczaMPmooAQFLB+9nayttBzKnojOHEe1srQrjRggYZVx4PXgNrd5DRGXkshttiu2tYX/1nnhCQKsTcv9/hS6xOErhtww8b8PQ4tn1VWmCtCqTYBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h3R6H0/h; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 502AD1A13AA;
	Wed, 15 Oct 2025 07:19:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 215AF606FA;
	Wed, 15 Oct 2025 07:19:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4880E102F22BC;
	Wed, 15 Oct 2025 09:19:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760512766; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=nGT/nZHo+Ajyn0KxTB2yaVizaJRWjEOjHnpXmzyLJys=;
	b=h3R6H0/hCTY+SRdpVxPFC/fIyeyjuIjnVHoXuhUxiQgNrl6zZ9cEZ6g3MNEmcIkzQrkJUO
	RAD42jfVi8ceacAGtkzjlg3ANcVfU4ejCmGCA/v3ZTULSa3MPpmKYVydPBGAzieY+VesJR
	wdexX/RPfPTtS4CKFNdHbZ6KzZfzlebAbcaSd7BIs8bHqWKSwY5AnK71xLsnBH4rOxoBDl
	elN1Ub18LRvBipc4VvWoLeYvMIIY+onMbYvgHwEjdejuRLKA4SrHK3jAeDXfhQqiahAvRf
	tE6cP1aN7X2CdP6/GPME0VfYhZJAMqksRSVkTAfy4tMxLZYs9QjZZkEN6aMnmg==
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
Subject: [PATCH v4 16/29] i2c: core: Introduce i2c_get_adapter_physdev()
Date: Wed, 15 Oct 2025 09:14:03 +0200
Message-ID: <20251015071420.1173068-17-herve.codina@bootlin.com>
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

The physical device providing an I2C adapter is the device that calls
i2c_add_adapter() or variants and i2c_del_adapter().

Most of the time this physical device is the parent of the adapter
device.

Exceptions exist with i2c muxes. Indeed, in case of i2c muxes, the
parent of the mux adapter device points to the adapter device the mux is
connected to instead of the physical of this mux adapter.

Introduce i2c_get_adapter_physdev() and a new physdev field in the
adapter structure in order to ease the adapter physical device
retrieval.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/i2c-core-base.c | 16 ++++++++++++++++
 include/linux/i2c.h         |  3 +++
 2 files changed, 19 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ae7e9c8b65a6..f3254869f842 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1919,6 +1919,22 @@ struct i2c_adapter *i2c_get_adapter_by_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL(i2c_get_adapter_by_fwnode);
 
+/**
+ * i2c_get_adapter_physdev() - Get the physical device of an adapter
+ * @adapter: the adapter to get the physical device from
+ *
+ * Return:
+ * Look up and return the &struct device corresponding to the device supplying
+ * this @adapter.
+ *
+ * The user must call put_device() once done with the physical device returned.
+ */
+struct device *i2c_get_adapter_physdev(struct i2c_adapter *adapter)
+{
+	return get_device(adapter->physdev ?: adapter->dev.parent);
+}
+EXPORT_SYMBOL(i2c_get_adapter_physdev);
+
 static void i2c_parse_timing(struct device *dev, char *prop_name, u32 *cur_val_p,
 			    u32 def_val, bool use_def)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 20fd41b51d5c..dff04d20cafe 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -744,6 +744,7 @@ struct i2c_adapter {
 	int timeout;			/* in jiffies */
 	int retries;
 	struct device dev;		/* the adapter device */
+	struct device *physdev;		/* the physical device */
 	unsigned long locked_flags;	/* owned by the I2C core */
 #define I2C_ALF_IS_SUSPENDED		0
 #define I2C_ALF_SUSPEND_REPORTED	1
@@ -911,6 +912,8 @@ struct i2c_adapter *i2c_get_adapter(int nr);
 void i2c_put_adapter(struct i2c_adapter *adap);
 unsigned int i2c_adapter_depth(struct i2c_adapter *adapter);
 
+struct device *i2c_get_adapter_physdev(struct i2c_adapter *adap);
+
 void i2c_parse_fw_timings(struct device *dev, struct i2c_timings *t, bool use_defaults);
 
 /* Return the functionality mask */
-- 
2.51.0


