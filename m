Return-Path: <linux-acpi+bounces-21109-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aARVOfA3nWn5NQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21109-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:32:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64036182045
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77B9930A75D3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88F2ED860;
	Tue, 24 Feb 2026 05:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGOSD87k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AE22C11CD;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911053; cv=none; b=LpnouZ5oovrg3m0zbkvot1QHuOuiDBdtfVIbo9fARFiTOiwco3ZcTnzEp9u8KIRKwSCIdUsEFMEBtMq8F9NzG5R89i6B4mdclx+6svUAt3tCxoVoIDrO20H8oWK6/gOdfQL2qmqeuuFyjjLwTJUnbNEhtg7jJkXtkJ2fKZrRSEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911053; c=relaxed/simple;
	bh=QPg5ucT2J9JR6E3rS7caTqzm372tAM2YlgwRdg7/hwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VAlPnk6mqqhy77o2lPtZnahn8Jr4qnQ9SPPPPnSqysSOWp3R3EPkYDvJbWQgOB7k4TQRUEPqyi8rK+kCJIaVEoB7jZVM9nr6YIdrBvaBIDzSxG5CjmgkWG7Lm9pySwr1oIfQCujU/l2l9DxJSTU2OtLk0cUN71gE+7+5vBXH3FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGOSD87k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4018EC2BCB7;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911053;
	bh=QPg5ucT2J9JR6E3rS7caTqzm372tAM2YlgwRdg7/hwg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gGOSD87kmjgj/DMgg9IC79SFDxvfsMj6anIsTW3UTfT6yXg4NROB0yMZgrNwpB+rF
	 LTnABVeyQxHm5jEow88K8FlUoL9owmQcb9d8T8jtcXXJUUoZqyRcs+Gtb7Qi+xzduf
	 G79nrhFTJYc+h8DizDOVMx1V4u0ylTRERO0lRo3uJMxmy1A+g0r+0g8I67hnA0Itvk
	 Ai+YMZ8fx13z2IgOWQOTKus6urQfreU+NaoIpZ/s21Mqk2P0TiclqMeR6ifSuoBge/
	 XXZp8MKFMEQ5guCUbKNzkh3J2CGhwXRQqMnA2PN8fK4RXyzxrspOyTFiENHt1sFWG7
	 Lj0eJgqglsGqA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2409EEFB800;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 24 Feb 2026 11:00:54 +0530
Subject: [PATCH v5 8/9] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key E connectors
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-pci-m2-e-v5-8-dd9b9501d33c@oss.qualcomm.com>
References: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
In-Reply-To: <20260224-pci-m2-e-v5-0-dd9b9501d33c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-acpi@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6901;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=HRGptE1JIyA395dlxkM3raRO8gPG2oSfeqDUBhjL6YY=;
 b=owEBbAGT/pANAwAKAVWfEeb+kc71AcsmYgBpnTeItvqqUYlI77jr1d50XlgHPzuXBe67DzZVK
 P+f6NZxPmyJATIEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZ03iAAKCRBVnxHm/pHO
 9YDFB/iDOYQLM8wTzHJ09bYyH2+5hIcEt9ZXbw1+VABhHFVw0OhHOj4DSQEVkqudUucAEXfNOB1
 H1tyiKxRFelDbG0MUQ597KkeErAh3uzenKEUYihryAuk+V2IKdfm4M0H3+bKT7EQSHeXm+YY/Wy
 vfji1zMNgsV9ls+Ozsms8YkuF46uWOU7To1nZWvXMw6ZPRSiYeIi+JwJnhhX3Ajr7nhvNuoBuus
 zSy6iHTcgDdYjmNU1u5G1MSZwtq5Qm2qy8Gbh1lgpsjRtwGUKDTdyQXaaTiHP2ilmWoB+PonejY
 BuWWz8X2JjoBEsFXMmSo/JhIAYMiulCadZ4Oap7EAE1yRnE=
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21109-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,linux.dev,linux.intel.com,squebb.ca,gmail.com,holtmann.org,bgdev.pl];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-acpi@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto]
X-Rspamd-Queue-Id: 64036182045
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Add support for handling the power sequence of the PCIe M.2 Key E
connectors. These connectors are used to attach the Wireless Connectivity
devices to the host machine including combinations of WiFi, BT, NFC using
interfaces such as PCIe/SDIO for WiFi, USB/UART for BT and I2C for NFC.

Currently, this driver supports only the PCIe interface for WiFi and UART
interface for BT. The driver also only supports driving the 3.3v/1.8v power
supplies and W_DISABLE{1/2}# GPIOs. The optional signals of the Key E
connectors are not currently supported.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 107 ++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index d31a7dd8b35c..3507cdcb1e7b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -5,10 +5,13 @@
  */
 
 #include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/regulator/consumer.h>
@@ -25,16 +28,18 @@ struct pwrseq_pcie_m2_ctx {
 	struct regulator_bulk_data *regs;
 	size_t num_vregs;
 	struct notifier_block nb;
+	struct gpio_desc *w_disable1_gpio;
+	struct gpio_desc *w_disable2_gpio;
 };
 
-static int pwrseq_pcie_m2_m_vregs_enable(struct pwrseq_device *pwrseq)
+static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
 	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
 }
 
-static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
+static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
 
@@ -43,18 +48,84 @@ static int pwrseq_pcie_m2_m_vregs_disable(struct pwrseq_device *pwrseq)
 
 static const struct pwrseq_unit_data pwrseq_pcie_m2_vregs_unit_data = {
 	.name = "regulators-enable",
-	.enable = pwrseq_pcie_m2_m_vregs_enable,
-	.disable = pwrseq_pcie_m2_m_vregs_disable,
+	.enable = pwrseq_pcie_m2_vregs_enable,
+	.disable = pwrseq_pcie_m2_vregs_disable,
 };
 
-static const struct pwrseq_unit_data *pwrseq_pcie_m2_m_unit_deps[] = {
+static const struct pwrseq_unit_data *pwrseq_pcie_m2_unit_deps[] = {
 	&pwrseq_pcie_m2_vregs_unit_data,
 	NULL
 };
 
+static int pwrseq_pci_m2_e_uart_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 0);
+}
+
+static int pwrseq_pci_m2_e_uart_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data = {
+	.name = "uart-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_uart_enable,
+	.disable = pwrseq_pci_m2_e_uart_disable,
+};
+
+static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
+}
+
+static int pwrseq_pci_m2_e_pcie_disable(struct pwrseq_device *pwrseq)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+
+	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
+}
+
+static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data = {
+	.name = "pcie-enable",
+	.deps = pwrseq_pcie_m2_unit_deps,
+	.enable = pwrseq_pci_m2_e_pcie_enable,
+	.disable = pwrseq_pci_m2_e_pcie_disable,
+};
+
 static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data = {
 	.name = "pcie-enable",
-	.deps = pwrseq_pcie_m2_m_unit_deps,
+	.deps = pwrseq_pcie_m2_unit_deps,
+};
+
+static int pwrseq_pcie_m2_e_pwup_delay(struct pwrseq_device *pwrseq)
+{
+	/*
+	 * FIXME: This delay is only required for some Qcom WLAN/BT cards like
+	 * WCN7850 and not for all devices. But currently, there is no way to
+	 * identify the device model before enumeration.
+	 */
+	msleep(50);
+
+	return 0;
+}
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_uart_target_data = {
+	.name = "uart",
+	.unit = &pwrseq_pcie_m2_e_uart_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
+};
+
+static const struct pwrseq_target_data pwrseq_pcie_m2_e_pcie_target_data = {
+	.name = "pcie",
+	.unit = &pwrseq_pcie_m2_e_pcie_unit_data,
+	.post_enable = pwrseq_pcie_m2_e_pwup_delay,
 };
 
 static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
@@ -62,11 +133,21 @@ static const struct pwrseq_target_data pwrseq_pcie_m2_m_pcie_target_data = {
 	.unit = &pwrseq_pcie_m2_m_pcie_unit_data,
 };
 
+static const struct pwrseq_target_data *pwrseq_pcie_m2_e_targets[] = {
+	&pwrseq_pcie_m2_e_pcie_target_data,
+	&pwrseq_pcie_m2_e_uart_target_data,
+	NULL
+};
+
 static const struct pwrseq_target_data *pwrseq_pcie_m2_m_targets[] = {
 	&pwrseq_pcie_m2_m_pcie_target_data,
 	NULL
 };
 
+static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_e_of_data = {
+	.targets = pwrseq_pcie_m2_e_targets,
+};
+
 static const struct pwrseq_pcie_m2_pdata pwrseq_pcie_m2_m_of_data = {
 	.targets = pwrseq_pcie_m2_m_targets,
 };
@@ -125,6 +206,16 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret,
 				     "Failed to get all regulators\n");
 
+	ctx->w_disable1_gpio = devm_gpiod_get_optional(dev, "w-disable1", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->w_disable1_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable1_gpio),
+				     "Failed to get the W_DISABLE_1# GPIO\n");
+
+	ctx->w_disable2_gpio = devm_gpiod_get_optional(dev, "w-disable2", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->w_disable2_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->w_disable2_gpio),
+				     "Failed to get the W_DISABLE_2# GPIO\n");
+
 	ctx->num_vregs = ret;
 
 	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
@@ -150,6 +241,10 @@ static const struct of_device_id pwrseq_pcie_m2_of_match[] = {
 		.compatible = "pcie-m2-m-connector",
 		.data = &pwrseq_pcie_m2_m_of_data,
 	},
+	{
+		.compatible = "pcie-m2-e-connector",
+		.data = &pwrseq_pcie_m2_e_of_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, pwrseq_pcie_m2_of_match);

-- 
2.51.0



