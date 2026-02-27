Return-Path: <linux-acpi+bounces-21228-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHTkAGmnoWm1vQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21228-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:17:13 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AA11B8A64
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 15:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B5CA0306ED20
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 14:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CFE425CE3;
	Fri, 27 Feb 2026 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UfO44clo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84754423A77;
	Fri, 27 Feb 2026 14:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200956; cv=none; b=Z/4CdJ9eStrnVD9cjj2U5/Asdw3+FbSouriKcwdSVKtfWeJmuCepBSz6TWNFOmjRN0C6DhAz7EWzlqyYdDxN7y6g/0EMyLYaTA+vDjzKzJClXlyeini4DgtC/3zFs6fFjiVJoERXys2btmIsTSXA78RMbK/QngXURCs5eSGNSpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200956; c=relaxed/simple;
	bh=xmLqHbZKT2Cv/CWmcreGU77H12f7Xun8iJll/1MC4EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DfhqotgUGwR9TADDZnr4xGwkEsudlvXkHE1Q3XA3Dwd5QhpeWWG23mFjEMaCtxqPKmckjmYq6WFQdTb1oFZg7oqbP11GvLT/IGYiw4DqD3DtI/gIaDzNgNl41ffNM5pghSNyZTcP2+2SzdfPbZmk4g3hjzT0dZQ5MLH8gimLtYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UfO44clo; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 183F0C406A4;
	Fri, 27 Feb 2026 14:02:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 33FBE5FE46;
	Fri, 27 Feb 2026 14:02:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B74021036944D;
	Fri, 27 Feb 2026 15:02:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772200949; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=gX4rEvCiby9B2yvI++vEu3sfDTTG+/1csPgc0WEGIYs=;
	b=UfO44cloo5Kb5sjfe1DtwGp8kSrPzUcq1tqFW2iZCRa5SWccGZE7mkodmPuk95KzuEP3Dg
	bvhOR0nafZ7IR73RJqM+4PEj4U85H1qLeonwG8su9wKTLlDfyMZvIN64Pjhg8Cmr0zmg/K
	Be4lhof6Cg+BqSCQn6E/xvH6nF+hPxq6ETSlPT/SKVEccCAUM4jvlov2CYgBlIn+7ZmQZ+
	T70SHNKXkJXLgLMckwXCGTkn+0Pfx1/zXnHq04UKvlGy/rH/dtTsQ7cHBIh/yHNoVqy/u9
	7mKmP2tyCM5lPKkhKkH5kFT5fsjUBtWq9GdQc9p8sNpV+sXDIRKTHdZDQFhGAg==
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
Subject: [PATCH v5 26/28] misc: lan966x_pci: Add dtsi/dtso nodes in order to support SFPs
Date: Fri, 27 Feb 2026 14:54:23 +0100
Message-ID: <20260227135428.783983-27-herve.codina@bootlin.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,glider.be,gmail.com,linuxfoundation.org,nxp.com,pengutronix.de,baylibre.com,sang-engineering.com,axentia.se,arndb.de,bootlin.com,google.com,opensource.cirrus.com,cirrus.com,linaro.org,linux.intel.com,stgolabs.net,huawei.com,intel.com];
	TAGGED_FROM(0.00)[bounces-21228-lists,linux-acpi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A9AA11B8A64
X-Rspamd-Action: no action

Add device-tree nodes needed to support SFPs.
Those nodes are:
 - the clock controller
 - the i2c controller
 - the i2c mux
 - the SFPs themselves and their related ports in the switch

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/misc/lan966x_evb_lan9662_nic.dtso | 96 +++++++++++++++++++++++
 drivers/misc/lan966x_pci.dtsi             | 42 ++++++++++
 2 files changed, 138 insertions(+)

diff --git a/drivers/misc/lan966x_evb_lan9662_nic.dtso b/drivers/misc/lan966x_evb_lan9662_nic.dtso
index 3ad50abee72d..20e1fe4f78bf 100644
--- a/drivers/misc/lan966x_evb_lan9662_nic.dtso
+++ b/drivers/misc/lan966x_evb_lan9662_nic.dtso
@@ -4,6 +4,7 @@
  */
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mfd/atmel-flexcom.h>
 #include <dt-bindings/phy/phy-lan966x-serdes.h>
 
 /dts-v1/;
@@ -27,15 +28,94 @@ __overlay__ {
 			#size-cells = <2>;
 
 			#include "lan966x_pci.dtsi"
+
+			i2c0_emux: i2c0-emux {
+				compatible = "i2c-mux-pinctrl";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				i2c-parent = <&i2c0>;
+				pinctrl-names = "i2c102", "i2c103", "idle";
+				pinctrl-0 = <&i2cmux_0>;
+				pinctrl-1 = <&i2cmux_1>;
+				pinctrl-2 = <&i2cmux_pins>;
+
+				i2c102: i2c@0 {
+					reg = <0>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+
+				i2c103: i2c@1 {
+					reg = <1>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+				};
+			};
+
+			sfp2: sfp2 {
+				compatible = "sff,sfp";
+				i2c-bus = <&i2c102>;
+				tx-disable-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+				los-gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
+				mod-def0-gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
+				tx-fault-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+			};
+
+			sfp3: sfp3 {
+				compatible = "sff,sfp";
+				i2c-bus = <&i2c103>;
+				tx-disable-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+				los-gpios = <&gpio 26 GPIO_ACTIVE_HIGH>;
+				mod-def0-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+				tx-fault-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
+			};
 		};
 	};
 };
 
+&flx0 {
+	atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
+	status = "okay";
+};
+
+&i2c0 {
+	pinctrl-0 = <&fc0_a_pins>;
+	pinctrl-names = "default";
+	i2c-analog-filter;
+	i2c-digital-filter;
+	i2c-digital-filter-width-ns = <35>;
+	status = "okay";
+};
+
 &gpio {
 	tod_pins: tod_pins {
 		pins = "GPIO_36";
 		function = "ptpsync_1";
 	};
+
+	fc0_a_pins: fcb4-i2c-pins {
+		/* RXD, TXD */
+		pins = "GPIO_9", "GPIO_10";
+		function = "fc0_a";
+	};
+
+	i2cmux_pins: i2cmux-pins {
+		pins = "GPIO_76", "GPIO_77";
+		function = "twi_slc_gate";
+		output-low;
+	};
+
+	i2cmux_0: i2cmux-0 {
+		pins = "GPIO_76";
+		function = "twi_slc_gate";
+		output-high;
+	};
+
+	i2cmux_1: i2cmux-1 {
+		pins = "GPIO_77";
+		function = "twi_slc_gate";
+		output-high;
+	};
 };
 
 &lan966x_phy0 {
@@ -64,6 +144,22 @@ &port1 {
 	status = "okay";
 };
 
+&port2 {
+	phy-mode = "sgmii";
+	phys = <&serdes 2 SERDES6G(0)>;
+	sfp = <&sfp2>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
+&port3 {
+	phy-mode = "sgmii";
+	phys = <&serdes 3 SERDES6G(1)>;
+	sfp = <&sfp3>;
+	managed = "in-band-status";
+	status = "okay";
+};
+
 &switch {
 	pinctrl-names = "default";
 	pinctrl-0 = <&tod_pins>;
diff --git a/drivers/misc/lan966x_pci.dtsi b/drivers/misc/lan966x_pci.dtsi
index 170298084fa5..d5c2056e4e5c 100644
--- a/drivers/misc/lan966x_pci.dtsi
+++ b/drivers/misc/lan966x_pci.dtsi
@@ -3,6 +3,7 @@
  * Copyright (C) 2025 Microchip UNG
  */
 
+#include <dt-bindings/clock/microchip,lan966x.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 cpu_clk: clock-600000000 {
@@ -61,6 +62,39 @@ port1: port@1 {
 				reg = <1>;
 				status = "disabled";
 			};
+
+			port2: port@2 {
+				reg = <2>;
+				status = "disabled";
+			};
+
+			port3: port@3 {
+				reg = <3>;
+				status = "disabled";
+			};
+		};
+	};
+
+	flx0: flexcom@e0040000 {
+		compatible = "atmel,sama5d2-flexcom";
+		reg = <0xe0040000 0x100>;
+		clocks = <&clks GCK_ID_FLEXCOM0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xe0040000 0x800>;
+		status = "disabled";
+
+		i2c0: i2c@600 {
+			compatible = "microchip,sam9x60-i2c";
+			reg = <0x600 0x200>;
+			interrupt-parent = <&oic>;
+			interrupts = <48 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clks GCK_ID_FLEXCOM0>;
+			assigned-clocks = <&clks GCK_ID_FLEXCOM0>;
+			assigned-clock-rates = <20000000>;
+			status = "disabled";
 		};
 	};
 
@@ -69,6 +103,14 @@ cpu_ctrl: syscon@e00c0000 {
 		reg = <0xe00c0000 0xa8>;
 	};
 
+	clks: clock-controller@e00c00a8 {
+		compatible = "microchip,lan966x-gck";
+		#clock-cells = <1>;
+		clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
+		clock-names = "cpu", "ddr", "sys";
+		reg = <0xe00c00a8 0x38>, <0xe00c02cc 0x4>;
+	};
+
 	oic: oic@e00c0120 {
 		compatible = "microchip,lan966x-oic";
 		#interrupt-cells = <2>;
-- 
2.53.0


