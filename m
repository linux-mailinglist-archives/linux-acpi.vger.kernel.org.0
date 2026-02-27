Return-Path: <linux-acpi+bounces-21220-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOqrIm6loWl/vQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21220-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:08:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0813C1B8655
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AA9731B9F81
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E649E1F2B88;
	Fri, 27 Feb 2026 14:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RodzvQE8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288B5413259;
	Fri, 27 Feb 2026 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200810; cv=none; b=olZdkLCno5jraciBXzcBjBhXY11Sb+x7yV60oZdhghkzgKSi0ckWzFclY0d2NDeq5EDXpq39XS0sjbfKDP7ZMAV4aMjiMs67adtiUS/yZqd13AQ0wNsy8BHYogVJ6ihu4P9OOylCtzgRomOmF7YmbME7pUvntGlnayynWiFpQN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200810; c=relaxed/simple;
	bh=opKdfdVK4CzMrQ5mOvu1aN+T6KAaaDtxxB/GB80aspg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZukXMEyyvhJ3hIS+yW1tx8nnypBRu+SStqqa7CcedP4lxMjRCEniufpPSlYHRehj2MP6xHnONWcqpKr64Vnl2yv1bvr+jdnUk4s/8dvvDslakO3Oln0ruwf7uHkVaVTz66EIZGzlY5oHGjdX3ZrsE2cgqIEneFH0HnH9f5lvtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RodzvQE8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 084B21A1B18;
	Fri, 27 Feb 2026 14:00:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CD5D85FE74;
	Fri, 27 Feb 2026 14:00:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 477F81036944D;
	Fri, 27 Feb 2026 14:59:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200803; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vTj0jmIFVnvyBrAo1BELaCko6WzI+kUICmGliPFJzCI=;
	b=RodzvQE8dy8FbMbFSh55AO4h/RFQLpNRxUE6bLJ+qsRE0NqPknmw2Ts0eGqfgP7fPvkFWD
	cUSMsD4e951ssXXwrKVsoF4zUHaaGfzz9XFNkQGKEFR6ZwlWruPpc2m/verqWOHqrSjv3Y
	/Nj8hI0nWOg4KksjNe1IYsggn2HWfFIF0MLKHj8apKg7JPY7VuPLeuymkil1U3FXhGGVam
	Urbs4samzKIW1lnZUYn+R2pzYRJ3QOrtNUKa27fkKCIejxwq9F92tsLb4O5P5p2jTXW/vD
	HXqRVcteVuPZD8wUmC6pc7fvVophxyNFnEmFpum8+5zHrjuHUIRZ/nrnCtr7Kg==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@kernel.org>,
	linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
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
Subject: [PATCH v5 18/28] of: property: Allow fw_devlink device-tree on x86
Date: Fri, 27 Feb 2026 14:54:15 +0100
Message-ID: <20260227135428.783983-19-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227135428.783983-1-herve.codina@bootlin.com>
References: <20260227135428.783983-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,bootlin.com,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com];
	TAGGED_FROM(0.00)[bounces-21220-lists,linux-acpi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herve.codina@bootlin.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_GT_50(0.00)[63];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: 0813C1B8655
X-Rspamd-Action: no action

PCI drivers can use a device-tree overlay to describe the hardware
available on the PCI board. This is the case, for instance, of the
LAN966x PCI device driver.

Adding some more nodes in the device-tree overlay adds some more
consumer/supplier relationship between devices instantiated from this
overlay.

Those fw_node consumer/supplier relationships are handled by fw_devlink
and are created based on the device-tree parsing done by the
of_fwnode_add_links() function.

Those consumer/supplier links are needed in order to ensure a correct PM
runtime management and a correct removal order between devices.

For instance, without those links a supplier can be removed before its
consumers is removed leading to all kind of issue if this consumer still
want the use the already removed supplier.

The support for the usage of an overlay from a PCI driver has been added
on x86 systems in commit 1f340724419ed ("PCI: of: Create device tree PCI
host bridge node").

In the past, support for fw_devlink on x86 had been tried but this
support has been removed in commit 4a48b66b3f52 ("of: property: Disable
fw_devlink DT support for X86"). Indeed, this support was breaking some
x86 systems such as OLPC system and the regression was reported in [0].

Instead of disabling this support for all x86 system, use a finer grain
and disable this support only for the possible problematic subset of x86
systems (at least OLPC and CE4100).

Those systems use a device-tree to describe their hardware. Identify
those systems using key properties in the device-tree.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/lkml/3c1f2473-92ad-bfc4-258e-a5a08ad73dd0@web.de/ [0]
---
 drivers/of/property.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 50d95d512bf5..80800a20d1ac 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1620,12 +1620,36 @@ static int of_fwnode_irq_get(const struct fwnode_handle *fwnode,
 	return of_irq_get(to_of_node(fwnode), index);
 }
 
+static int match_property_by_path(const char *node_path, const char *prop_name,
+				  const char *value)
+{
+	struct device_node *np __free(device_node) = of_find_node_by_path(node_path);
+
+	return of_property_match_string(np, prop_name, value);
+}
+
+static bool of_is_fwnode_add_links_supported(void)
+{
+	static int is_supported = -1;
+
+	if (!IS_ENABLED(CONFIG_X86))
+		return true;
+
+	if (is_supported != -1)
+		return !!is_supported;
+
+	is_supported = !((match_property_by_path("/soc", "compatible", "intel,ce4100-cp") >= 0) ||
+			 (match_property_by_path("/", "architecture", "OLPC") >= 0));
+
+	return !!is_supported;
+}
+
 static int of_fwnode_add_links(struct fwnode_handle *fwnode)
 {
 	const struct property *p;
 	struct device_node *con_np = to_of_node(fwnode);
 
-	if (IS_ENABLED(CONFIG_X86))
+	if (!of_is_fwnode_add_links_supported())
 		return 0;
 
 	if (!con_np)
-- 
2.53.0


