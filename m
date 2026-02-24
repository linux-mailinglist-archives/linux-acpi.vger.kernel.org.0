Return-Path: <linux-acpi+bounces-21107-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF/yMjs4nWn3NQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21107-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:33:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A71820E4
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 06:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551B5317B1E6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Feb 2026 05:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D512DA749;
	Tue, 24 Feb 2026 05:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGuC/hn/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733652C0F78;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771911053; cv=none; b=JKUk3SoeSWguXBtzpe9D2ivB6ooiGNHJpQWinqTd4r+cwF9hRzYMEZfyz83ZrTVxkIm+TV1wQwXBPW097UbSM304IWYgnK73aZ0J4SH5assob8j66SDt+nbqh5rV1RJolIs/tetshNiJrx6p83oFA5RzSUruG2o2PMjsDuqlnak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771911053; c=relaxed/simple;
	bh=kyfTo/8USTG3OqpqST1Bs5VOfk+TjVTQurHs0EidrHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmMjgK+ljlXDCMxpiY2r31aFUX/dJOt//BF+ZfnZiiWk0D4794qLC/Untx+tjhYhyJ9qbz+pLgUU6T88xfbPdhqmLJAQQ1SAfoCtwmnbZ8xzUMu1nI2LZyyh4aCHeMw3KWWBzsHAbWBFFZfjcQrNITGRHD4xUcWkWLCluDo3h18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGuC/hn/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C192C19425;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771911053;
	bh=kyfTo/8USTG3OqpqST1Bs5VOfk+TjVTQurHs0EidrHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HGuC/hn/JTEBWLoZDOcKMx/JPP3r7RG2HtVzCtecia0kCqqKwZtPpKGeC49UgWL+F
	 r4tWsXUsi43mob5l0JPc+6sYA5OTrfxY/BpfYVtVFg6TzNKX2txKIu+FIW0NeQQnMI
	 9EPLn18nFbN0zJfLedixnfdEtI6Ya0tEYYM/qYPwL43gLt7KskEARZ6wM8e6GoIBf8
	 y6QM96drBhVZl8vUUqkpbTcZlX56rLaqPAr+OPqUANx7IAaDU019jMl+k07wgJ2fHJ
	 qvwHsDiaorYNvB4i05ky8yKI9sZRBpuGTzRh/oKFXbyLYS3vhs53d9VjrtSfrGBALQ
	 x0xdNgmvZFufQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405AAEFB805;
	Tue, 24 Feb 2026 05:30:53 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 24 Feb 2026 11:00:55 +0530
Subject: [PATCH v5 9/9] power: sequencing: pcie-m2: Create serdev device
 for WCN7850 bluetooth
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-pci-m2-e-v5-9-dd9b9501d33c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8258;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=iMQanxh48zZesV0ri7QIXxOpLmhhR5jmc4pGrWrdKNQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpnTeJgOHTAKrA9ShrAtobh7vVQuIco5Nt9DE6W
 TP3QHBHA1CJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaZ03iQAKCRBVnxHm/pHO
 9QQJB/sHCvHF1GkYVzmexefEic1g8TrXjKgolHEmbRf9vgJz+6VvuVoozqhY3b7JVRxPWRPpErv
 wCuhlwPrZHPajZ6oQ+1v1irI0+pdc+3/YN9jjJGgWe8CmTKN0M4Mt5YR4mZZ6J1XZxa8H7Sm/0z
 a4hrsjm8nyAhdQ/ReoGf+3Keqg9vXLAU4qdHoG0X3Sku27BPoEo6Puut7cbJFQXZkulQmaX0DdN
 aUDls5p03OfGIIVRgLdkBevrWPS2XDd3qohe1uP5CWdTY398HsMix30L4BEeXs95pjG5KEvvx/q
 2F2+rrkxpek7TsNvldiVbMTAx5jwbOB9OSuzyLM6d1dcwTPm
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21107-lists,linux-acpi=lfdr.de,manivannan.sadhasivam.oss.qualcomm.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	HAS_REPLYTO(0.00)[manivannan.sadhasivam@oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,oss.qualcomm.com:mid,oss.qualcomm.com:replyto]
X-Rspamd-Queue-Id: 723A71820E4
X-Rspamd-Action: no action

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

For supporting bluetooth over the non-discoverable UART interface of
WCN7850, create the serdev device after enumerating the PCIe interface.
This is mandatory since the device ID is only known after the PCIe
enumeration and the ID is used for creating the serdev device.

Since by default there is no OF or ACPI node for the created serdev,
create a dynamic OF 'bluetooth' node with the 'compatible' property and
attach it to the serdev device. This will allow the serdev device to bind
to the existing bluetooth driver.

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com> # ThinkPad T14s gen6 (arm64)
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/Kconfig          |   3 +-
 drivers/power/sequencing/pwrseq-pcie-m2.c | 171 +++++++++++++++++++++++++++++-
 2 files changed, 170 insertions(+), 4 deletions(-)

diff --git a/drivers/power/sequencing/Kconfig b/drivers/power/sequencing/Kconfig
index f5fff84566ba..55aeef125e6f 100644
--- a/drivers/power/sequencing/Kconfig
+++ b/drivers/power/sequencing/Kconfig
@@ -37,7 +37,8 @@ config POWER_SEQUENCING_TH1520_GPU
 
 config POWER_SEQUENCING_PCIE_M2
 	tristate "PCIe M.2 connector power sequencing driver"
-	depends on OF || COMPILE_TEST
+	depends on (PCI && OF) || COMPILE_TEST
+	select OF_DYNAMIC
 	help
 	  Say Y here to enable the power sequencing driver for PCIe M.2
 	  connectors. This driver handles the power sequencing for the M.2
diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 3507cdcb1e7b..d398487202b9 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -12,9 +12,11 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/provider.h>
 #include <linux/regulator/consumer.h>
+#include <linux/serdev.h>
 #include <linux/slab.h>
 
 struct pwrseq_pcie_m2_pdata {
@@ -30,6 +32,9 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct serdev_device *serdev;
+	struct of_changeset *ocs;
+	struct device *dev;
 };
 
 static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
@@ -172,13 +177,169 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_NO_MATCH;
 }
 
-static void pwrseq_pcie_m2_free_regulators(void *data)
+static void pwrseq_pcie_m2_free_resources(void *data)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = data;
 
+	serdev_device_remove(ctx->serdev);
+	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
+	of_changeset_revert(ctx->ocs);
+	of_changeset_destroy(ctx->ocs);
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
 }
 
+static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
+					struct device_node *parent)
+{
+	struct device *dev = ctx->dev;
+	struct device_node *np;
+	int ret;
+
+	ctx->ocs = devm_kzalloc(dev, sizeof(*ctx->ocs), GFP_KERNEL);
+	if (!ctx->ocs)
+		return -ENOMEM;
+
+	of_changeset_init(ctx->ocs);
+
+	np = of_changeset_create_node(ctx->ocs, parent, "bluetooth");
+	if (!np) {
+		dev_err(dev, "Failed to create bluetooth node\n");
+		ret = -ENODEV;
+		goto err_destroy_changeset;
+	}
+
+	ret = of_changeset_add_prop_string(ctx->ocs, np, "compatible", "qcom,wcn7850-bt");
+	if (ret) {
+		dev_err(dev, "Failed to add bluetooth compatible: %d\n", ret);
+		goto err_destroy_changeset;
+	}
+
+	ret = of_changeset_apply(ctx->ocs);
+	if (ret) {
+		dev_err(dev, "Failed to apply changeset: %d\n", ret);
+		goto err_destroy_changeset;
+	}
+
+	ret = device_add_of_node(&ctx->serdev->dev, np);
+	if (ret) {
+		dev_err(dev, "Failed to add OF node: %d\n", ret);
+		goto err_revert_changeset;
+	}
+
+	return 0;
+
+err_revert_changeset:
+	of_changeset_revert(ctx->ocs);
+err_destroy_changeset:
+	of_changeset_destroy(ctx->ocs);
+
+	return ret;
+}
+
+static int pwrseq_m2_pcie_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct pwrseq_pcie_m2_ctx *ctx = container_of(nb, struct pwrseq_pcie_m2_ctx, nb);
+	struct pci_dev *pdev = to_pci_dev(data);
+	struct serdev_controller *serdev_ctrl;
+	struct device *dev = ctx->dev;
+	int ret;
+
+	/*
+	 * Check whether the PCI device is associated with this M.2 connector or
+	 * not, by comparing the OF node of the PCI device parent and the Port 0
+	 * (PCIe) remote node parent OF node.
+	 */
+	struct device_node *pci_parent __free(device_node) =
+			of_graph_get_remote_node(dev_of_node(ctx->dev), 0, 0);
+	if (!pci_parent || (pci_parent != pdev->dev.parent->of_node))
+		return NOTIFY_DONE;
+
+	switch (action) {
+	case BUS_NOTIFY_ADD_DEVICE:
+		/* Create serdev device for WCN7850 */
+		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+			struct device_node *serdev_parent __free(device_node) =
+				of_graph_get_remote_node(dev_of_node(ctx->dev), 1, 1);
+			if (!serdev_parent)
+				return NOTIFY_DONE;
+
+			serdev_ctrl = of_find_serdev_controller_by_node(serdev_parent);
+			if (!serdev_ctrl)
+				return NOTIFY_DONE;
+
+			ctx->serdev = serdev_device_alloc(serdev_ctrl);
+			if (!ctx->serdev)
+				return NOTIFY_BAD;
+
+			ret = pwrseq_m2_pcie_create_bt_node(ctx, serdev_parent);
+			if (ret) {
+				serdev_device_put(ctx->serdev);
+				return notifier_from_errno(ret);
+			}
+
+			ret = serdev_device_add(ctx->serdev);
+			if (ret) {
+				dev_err(dev, "Failed to add serdev for WCN7850: %d\n", ret);
+				of_changeset_revert(ctx->ocs);
+				of_changeset_destroy(ctx->ocs);
+				serdev_device_put(ctx->serdev);
+				return notifier_from_errno(ret);
+			}
+		}
+		break;
+	case BUS_NOTIFY_REMOVED_DEVICE:
+		/* Destroy serdev device for WCN7850 */
+		if (pdev->vendor == PCI_VENDOR_ID_QCOM && pdev->device == 0x1107) {
+			serdev_device_remove(ctx->serdev);
+			of_changeset_revert(ctx->ocs);
+			of_changeset_destroy(ctx->ocs);
+		}
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
+static bool pwrseq_pcie_m2_check_remote_node(struct device *dev, u8 port, u8 endpoint,
+					     const char *node)
+{
+	struct device_node *remote __free(device_node) =
+			of_graph_get_remote_node(dev_of_node(dev), port, endpoint);
+
+	if (remote && of_node_name_eq(remote, node))
+		return true;
+
+	return false;
+}
+
+/*
+ * If the connector exposes a non-discoverable bus like UART, the respective
+ * protocol device needs to be created manually with the help of the notifier
+ * of the discoverable bus like PCIe.
+ */
+static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
+{
+	int ret;
+
+	/*
+	 * Register a PCI notifier for Key E connector that has PCIe as Port
+	 * 0/Endpoint 0 interface and Serial as Port 3/Endpoint 0 interface.
+	 */
+	if (pwrseq_pcie_m2_check_remote_node(dev, 3, 0, "serial")) {
+		if (pwrseq_pcie_m2_check_remote_node(dev, 0, 0, "pcie")) {
+			ctx->dev = dev;
+			ctx->nb.notifier_call = pwrseq_m2_pcie_notify;
+			ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
+			if (ret)
+				return dev_err_probe(dev, ret,
+						     "Failed to register notifier for serdev\n");
+		}
+	}
+
+	return 0;
+}
+
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -218,7 +379,7 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 
 	ctx->num_vregs = ret;
 
-	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, ctx);
+	ret = devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_resources, ctx);
 	if (ret)
 		return ret;
 
@@ -233,7 +394,11 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->pwrseq),
 				     "Failed to register the power sequencer\n");
 
-	return 0;
+	/*
+	 * Register a notifier for creating protocol devices for
+	 * non-discoverable busses like UART.
+	 */
+	return pwrseq_pcie_m2_register_notifier(ctx, dev);
 }
 
 static const struct of_device_id pwrseq_pcie_m2_of_match[] = {

-- 
2.51.0



