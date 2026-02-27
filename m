Return-Path: <linux-acpi+bounces-21225-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wz2DIVymoWmqvQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21225-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:12:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA0D1B8826
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F2AF30CF76B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA63410D18;
	Fri, 27 Feb 2026 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bjbJZfZb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D013F0753;
	Fri, 27 Feb 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200904; cv=none; b=fC5OEoSxzwbKQJVV1IzEu8D9Df13MNcbVgN1d88zkt3Y53LmnGQQHoPgH3Nmo2br6fWMSctSxORwwzbkkB3ENegdqHAhDfxdL2Rf/zT/wnnk9wRuwr8OO2YJY8+2DMo/SA1j7zW6jPyOfyDyLK0WBRy9FfQoP1i13L/dyVW3qiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200904; c=relaxed/simple;
	bh=Y8m0zsSKVad7SFcsm/ZKBnRFSzmHm9gWwA6ylq8UG0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erZUK8UYxG/fZJeGKziwwqhsSunEDdTjE0do8G3e1y1UB4XP3Iu3yd0p7/blmw8VMlH13NwVy66koBF1dvmWR8hPF9Jp9eKvCD6UbXMqSnWFWYAaFEbFBLRJsPbonHCaUPfEgMkKjoc4MjeXkSw7q38ETosZQcIKGhSeirRknpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bjbJZfZb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8C2FEC406A4;
	Fri, 27 Feb 2026 14:01:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A510D5FE74;
	Fri, 27 Feb 2026 14:01:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DE6241036946F;
	Fri, 27 Feb 2026 15:01:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200894; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=xIgC4JqFpnspOBEpImL7CCr+SrfTGe6B79z1CKickA8=;
	b=bjbJZfZbKN3BZWuBk5p9zNyOZMGBmWhIH9WPpWzqebiOG+HdLMx+mraP6tupRW8GGjPuMr
	NVjNMer9qin2O/b5s/mzUgTqFRux8RSYdTcumc5+HhhG8UQruOwBYVEN+eKvwmhLZPMg1C
	tZzzCTMA/+D+ylWwxJRVPjFNbiOOIqmUXKIlAMeYmJ7nw2E7/0o0qxz65vKgPuPAuKQmUL
	p8rWm/nodgMg5g9hoPpd9hmkD+sllYcdIYo79MjJV9yZs1edO1jhq7LaSDJ7Jaw3HM9AcG
	+u7Y8kdBaMKaDUv2t2Y4G6nAyfWLVhVg4AiZlAinl/33GVwPpAJqZnG8V5mRJg==
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
Subject: [PATCH v5 23/28] misc: lan966x_pci: Rename lan966x_pci.dtso to lan966x_evb_lan9662_nic.dtso
Date: Fri, 27 Feb 2026 14:54:20 +0100
Message-ID: <20260227135428.783983-24-herve.codina@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,bootlin.com,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com];
	TAGGED_FROM(0.00)[bounces-21225-lists,linux-acpi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:dkim,bootlin.com:email,microchip.com:url,microchip.com:email]
X-Rspamd-Queue-Id: 0DA0D1B8826
X-Rspamd-Action: no action

The lan966x_pci.dtso describes the Microchip EVB-LAN9662-NIC board [0]

This PCI board embeds a LAN9962 PCI device chip, part of the LAN966x
family.

Rename the lan966x_pci.dtso accordingly.

Link: https://www.microchip.com/en-us/development-tool/EV53U25A [0]
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 MAINTAINERS                                               | 2 +-
 drivers/misc/Makefile                                     | 2 +-
 .../{lan966x_pci.dtso => lan966x_evb_lan9662_nic.dtso}    | 0
 drivers/misc/lan966x_pci.c                                | 8 ++++----
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/misc/{lan966x_pci.dtso => lan966x_evb_lan9662_nic.dtso} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 441fe74e7ef7..2c5537891071 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17304,9 +17304,9 @@ F:	drivers/irqchip/irq-lan966x-oic.c
 MICROCHIP LAN966X PCI DRIVER
 M:	Herve Codina <herve.codina@bootlin.com>
 S:	Maintained
+F:	drivers/misc/lan966x_evb_lan9662_nic.dtso
 F:	drivers/misc/lan966x_pci.c
 F:	drivers/misc/lan966x_pci.dtsi
-F:	drivers/misc/lan966x_pci.dtso
 
 MICROCHIP LAN969X ETHERNET DRIVER
 M:	Daniel Machon <daniel.machon@microchip.com>
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b32a2597d246..3b3a61f45ee9 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -70,7 +70,7 @@ obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
 obj-$(CONFIG_NSM)		+= nsm.o
 obj-$(CONFIG_MARVELL_CN10K_DPI)	+= mrvl_cn10k_dpi.o
 lan966x-pci-objs		:= lan966x_pci.o
-lan966x-pci-objs		+= lan966x_pci.dtbo.o
+lan966x-pci-objs		+= lan966x_evb_lan9662_nic.dtbo.o
 obj-$(CONFIG_MCHP_LAN966X_PCI)	+= lan966x-pci.o
 obj-y				+= keba/
 obj-y				+= amd-sbi/
diff --git a/drivers/misc/lan966x_pci.dtso b/drivers/misc/lan966x_evb_lan9662_nic.dtso
similarity index 100%
rename from drivers/misc/lan966x_pci.dtso
rename to drivers/misc/lan966x_evb_lan9662_nic.dtso
diff --git a/drivers/misc/lan966x_pci.c b/drivers/misc/lan966x_pci.c
index 0bb90c0943bf..bbd87c89663d 100644
--- a/drivers/misc/lan966x_pci.c
+++ b/drivers/misc/lan966x_pci.c
@@ -19,8 +19,8 @@
 #include <linux/slab.h>
 
 /* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.lib */
-extern char __dtbo_lan966x_pci_begin[];
-extern char __dtbo_lan966x_pci_end[];
+extern char __dtbo_lan966x_evb_lan9662_nic_begin[];
+extern char __dtbo_lan966x_evb_lan9662_nic_end[];
 
 struct pci_dev_intr_ctrl {
 	struct pci_dev *pci_dev;
@@ -125,8 +125,8 @@ struct lan966x_pci {
 
 static int lan966x_pci_load_overlay(struct lan966x_pci *data)
 {
-	u32 dtbo_size = __dtbo_lan966x_pci_end - __dtbo_lan966x_pci_begin;
-	void *dtbo_start = __dtbo_lan966x_pci_begin;
+	u32 dtbo_size = __dtbo_lan966x_evb_lan9662_nic_end - __dtbo_lan966x_evb_lan9662_nic_begin;
+	void *dtbo_start = __dtbo_lan966x_evb_lan9662_nic_begin;
 
 	return of_overlay_fdt_apply(dtbo_start, dtbo_size, &data->ovcs_id, dev_of_node(data->dev));
 }
-- 
2.53.0


