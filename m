Return-Path: <linux-acpi+bounces-21030-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IZXKbtlmGmJHgMAu9opvQ
	(envelope-from <linux-acpi+bounces-21030-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:46:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45731168029
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 14:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BD0430E5C3C
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Feb 2026 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77159347FD9;
	Fri, 20 Feb 2026 13:43:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967AD34A3C4;
	Fri, 20 Feb 2026 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771594996; cv=none; b=FaKimW2AE3m2tx6GXrm2ytGCtB02gzHlYJusYATGdZFU853RIeFIayW+mtMCfU4U0VclVO6YWjK+x2kjL7U53w3ofyQOwOTlrfPryvZ3D4JPUM49AQc2W/jIqIs3gYtr/j7zEMINFAT6t0veT6oa0V1s+2ZkB782pHOJWKNhQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771594996; c=relaxed/simple;
	bh=q5Y+NMfzaEZFlIpt9eEfOCVoag40RqvPXOBQm2fjhXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUXoTRD6GsDqYpoz332e7hyst4HQv7FGvzCdHb4Ss6cTGrhUQGnuQSPS5sPNsNpHYRSsK//fRsBdONBfBSzxpRiOk504I1G6COxd9ZoalJLTrK3iJ0sRsr76BDlJ9pXEP179XfoipZEgLS+VaBNzfRnlgfjVOY0spgvzQR0jldk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDE5339;
	Fri, 20 Feb 2026 05:43:07 -0800 (PST)
Received: from e134710.arm.com (e134710.arm.com [10.33.10.82])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7686B3F7D8;
	Fri, 20 Feb 2026 05:43:12 -0800 (PST)
From: Ahmed Tiba <ahmed.tiba@arm.com>
Date: Fri, 20 Feb 2026 13:42:29 +0000
Subject: [PATCH v2 11/11] RAS: add DeviceTree firmware-first CPER provider
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
In-Reply-To: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
To: devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Ahmed Tiba <ahmed.tiba@arm.com>, Dmitry.Lamerov@arm.com, 
 catalin.marinas@arm.com, bp@alien8.de, robh@kernel.org, rafael@kernel.org, 
 will@kernel.org, conor@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, krzk+dt@kernel.org, Michael.Zhao2@arm.com, 
 tony.luck@intel.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771594970; l=12203;
 i=ahmed.tiba@arm.com; s=20260219; h=from:subject:message-id;
 bh=q5Y+NMfzaEZFlIpt9eEfOCVoag40RqvPXOBQm2fjhXU=;
 b=mMzJcs8z9K2XuVz8RkBwmBO7oCXKn4WKHrxrQUMNCJE1K3SfvZKcAQRyYh7l9PH4Igm1pEs1h
 sQCrknbfRivAsJzQhmXZq1xMtTP7VWIA1YwWC6SBj+MNC/S3WLiB76v
X-Developer-Key: i=ahmed.tiba@arm.com; a=ed25519;
 pk=xVOtd+Qklh/4tuM3tB+BEZD4jj5a6W59C3KCNX6v7OE=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21030-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.930];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:mid,arm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 45731168029
X-Rspamd-Action: no action

Add a DeviceTree firmware-first CPER provider that reuses the shared
GHES helpers, wire it into the RAS Kconfig/Makefile and document it in
the admin guide. Update MAINTAINERS now that the driver exists.

Signed-off-by: Ahmed Tiba <ahmed.tiba@arm.com>
---
 Documentation/admin-guide/RAS/main.rst |  18 +++
 MAINTAINERS                            |   1 +
 drivers/acpi/apei/apei-internal.h      |  10 +-
 drivers/acpi/apei/ghes_cper.c          |   2 +
 drivers/ras/Kconfig                    |  12 ++
 drivers/ras/Makefile                   |   1 +
 drivers/ras/esource-dt.c               | 264 +++++++++++++++++++++++++++++++++
 include/acpi/ghes_cper.h               |   9 ++
 8 files changed, 308 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/RAS/main.rst b/Documentation/admin-guide/RAS/main.rst
index 5a45db32c49b..4ffabaaeabb1 100644
--- a/Documentation/admin-guide/RAS/main.rst
+++ b/Documentation/admin-guide/RAS/main.rst
@@ -205,6 +205,24 @@ Architecture (MCA)\ [#f3]_.
 .. [#f3] For more details about the Machine Check Architecture (MCA),
   please read Documentation/arch/x86/x86_64/machinecheck.rst at the Kernel tree.
 
+Firmware-first CPER via DeviceTree
+----------------------------------
+
+Some systems expose Common Platform Error Record (CPER) data
+via DeviceTree instead of ACPI HEST tables.
+Enable ``CONFIG_RAS_ESOURCE_DT`` to build the ``drivers/ras/esource-dt.c``
+driver and describe the CPER error source buffer with the
+``Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml`` binding.
+The driver reuses the GHES CPER helper object in
+``drivers/acpi/apei/ghes_cper.c`` so the logging, notifier chains, and
+memory failure handling match the ACPI GHES behaviour even when
+ACPI is disabled.
+
+Once a platform describes a firmware-first provider, both ACPI GHES and the
+DeviceTree driver reuse the same code paths. This keeps the behaviour
+consistent regardless of whether the error source is described via ACPI
+tables or DeviceTree.
+
 EDAC - Error Detection And Correction
 *************************************
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 47db7877b485..fa6113b482b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22031,6 +22031,7 @@ RAS ERROR STATUS
 M:	Ahmed Tiba <ahmed.tiba@arm.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/firmware/arm,ras-ffh.yaml
+F:	drivers/ras/esource-dt.c
 
 RAS INFRASTRUCTURE
 M:	Tony Luck <tony.luck@intel.com>
diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index 77c10a7a7a9f..c16ac541f15b 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -8,6 +8,7 @@
 #define APEI_INTERNAL_H
 
 #include <linux/acpi.h>
+#include <acpi/ghes_cper.h>
 
 struct apei_exec_context;
 
@@ -120,15 +121,6 @@ int apei_exec_collect_resources(struct apei_exec_context *ctx,
 struct dentry;
 struct dentry *apei_get_debugfs_dir(void);
 
-static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
-{
-	if (estatus->raw_data_length)
-		return estatus->raw_data_offset + \
-			estatus->raw_data_length;
-	else
-		return sizeof(*estatus) + estatus->data_length;
-}
-
 int apei_osc_setup(void);
 
 int einj_get_available_error_type(u32 *type, int einj_action);
diff --git a/drivers/acpi/apei/ghes_cper.c b/drivers/acpi/apei/ghes_cper.c
index 29b790160e91..9b2d1b8cf9f4 100644
--- a/drivers/acpi/apei/ghes_cper.c
+++ b/drivers/acpi/apei/ghes_cper.c
@@ -42,7 +42,9 @@
 #include <asm/fixmap.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_ACPI_APEI
 #include "apei-internal.h"
+#endif
 
 ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
diff --git a/drivers/ras/Kconfig b/drivers/ras/Kconfig
index fc4f4bb94a4c..ea6d96713020 100644
--- a/drivers/ras/Kconfig
+++ b/drivers/ras/Kconfig
@@ -34,6 +34,18 @@ if RAS
 source "arch/x86/ras/Kconfig"
 source "drivers/ras/amd/atl/Kconfig"
 
+config RAS_ESOURCE_DT
+	bool "DeviceTree firmware-first CPER error source block provider"
+	depends on OF
+	depends on ARM64
+	select GHES_CPER_HELPERS
+	help
+	  Enable support for firmware-first Common Platform Error Record (CPER)
+	  error source block providers that are described via DeviceTree
+	  instead of ACPI HEST tables. The driver reuses the existing GHES
+	  CPER helpers so the error processing matches the ACPI code paths,
+	  but it can be built even when ACPI is disabled.
+
 config RAS_FMPM
 	tristate "FRU Memory Poison Manager"
 	default m
diff --git a/drivers/ras/Makefile b/drivers/ras/Makefile
index 11f95d59d397..53558a1707b3 100644
--- a/drivers/ras/Makefile
+++ b/drivers/ras/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_RAS)	+= ras.o
 obj-$(CONFIG_DEBUG_FS)	+= debugfs.o
 obj-$(CONFIG_RAS_CEC)	+= cec.o
+obj-$(CONFIG_RAS_ESOURCE_DT)	+= esource-dt.o
 
 obj-$(CONFIG_RAS_FMPM)	+= amd/fmpm.o
 obj-y			+= amd/atl/
diff --git a/drivers/ras/esource-dt.c b/drivers/ras/esource-dt.c
new file mode 100644
index 000000000000..b575a2258536
--- /dev/null
+++ b/drivers/ras/esource-dt.c
@@ -0,0 +1,264 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DeviceTree provider for firmware-first CPER error source block.
+ *
+ * This driver shares the GHES CPER helpers so we keep the reporting and
+ * notifier behaviour identical to ACPI GHES
+ *
+ * Copyright (C) 2025 ARM Ltd.
+ * Author: Ahmed Tiba <ahmed.tiba@arm.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/panic.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#include <acpi/ghes.h>
+#include <acpi/ghes_cper.h>
+
+static atomic_t ghes_ffh_source_ids = ATOMIC_INIT(0);
+
+struct ghes_ffh_ack {
+	void __iomem *addr;
+	u64 preserve;
+	u64 set;
+	u8 width;
+	bool present;
+};
+
+struct ghes_ffh {
+	struct device *dev;
+	void __iomem *status;
+	size_t status_len;
+
+	struct ghes_ffh_ack ack;
+
+	struct acpi_hest_generic *generic;
+	struct acpi_hest_generic_status *estatus;
+
+	bool sync;
+	int irq;
+
+	/* Serializes access to the firmware-owned buffer. */
+	spinlock_t lock;
+};
+
+static int ghes_ffh_init_pool(void)
+{
+	if (ghes_estatus_pool)
+		return 0;
+
+	return ghes_estatus_pool_init(1);
+}
+
+static int ghes_ffh_copy_status(struct ghes_ffh *ctx)
+{
+	memcpy_fromio(ctx->estatus, ctx->status, ctx->status_len);
+	return 0;
+}
+
+static void ghes_ffh_ack(struct ghes_ffh *ctx)
+{
+	u64 val;
+
+	if (!ctx->ack.present)
+		return;
+
+	if (ctx->ack.width == 64) {
+		val = readq(ctx->ack.addr);
+		val &= ctx->ack.preserve;
+		val |= ctx->ack.set;
+		writeq(val, ctx->ack.addr);
+	} else {
+		val = readl(ctx->ack.addr);
+		val &= (u32)ctx->ack.preserve;
+		val |= (u32)ctx->ack.set;
+		writel(val, ctx->ack.addr);
+	}
+}
+
+static void ghes_ffh_fatal(struct ghes_ffh *ctx)
+{
+	__ghes_print_estatus(KERN_EMERG, ctx->generic, ctx->estatus);
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
+	panic("GHES: fatal firmware-first CPER record from %s\n",
+	      dev_name(ctx->dev));
+}
+
+static void ghes_ffh_process(struct ghes_ffh *ctx)
+{
+	unsigned long flags;
+	int sev;
+
+	spin_lock_irqsave(&ctx->lock, flags);
+
+	if (ghes_ffh_copy_status(ctx))
+		goto out;
+
+	sev = ghes_severity(ctx->estatus->error_severity);
+	if (sev >= GHES_SEV_PANIC)
+		ghes_ffh_fatal(ctx);
+
+	if (!ghes_estatus_cached(ctx->estatus)) {
+		if (ghes_print_estatus(NULL, ctx->generic, ctx->estatus))
+			ghes_estatus_cache_add(ctx->generic, ctx->estatus);
+	}
+
+	ghes_cper_handle_status(ctx->dev, ctx->generic, ctx->estatus, ctx->sync);
+
+	ghes_ffh_ack(ctx);
+
+out:
+	spin_unlock_irqrestore(&ctx->lock, flags);
+}
+
+static irqreturn_t ghes_ffh_irq(int irq, void *data)
+{
+	struct ghes_ffh *ctx = data;
+
+	ghes_ffh_process(ctx);
+
+	return IRQ_HANDLED;
+}
+
+static int ghes_ffh_init_ack(struct platform_device *pdev,
+			     struct ghes_ffh *ctx)
+{
+	struct resource *res;
+	size_t size;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return 0;
+
+	ctx->ack.addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->ack.addr))
+		return PTR_ERR(ctx->ack.addr);
+
+	size = resource_size(res);
+	switch (size) {
+	case 4:
+		ctx->ack.width = 32;
+		ctx->ack.preserve = ~0U;
+		break;
+	case 8:
+		ctx->ack.width = 64;
+		ctx->ack.preserve = ~0ULL;
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported ack resource size %zu\n", size);
+		return -EINVAL;
+	}
+
+	ctx->ack.set = BIT_ULL(0);
+	ctx->ack.present = true;
+	return 0;
+}
+
+static int ghes_ffh_probe(struct platform_device *pdev)
+{
+	struct ghes_ffh *ctx;
+	struct resource *res;
+	int rc;
+
+	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	spin_lock_init(&ctx->lock);
+	ctx->dev = &pdev->dev;
+	ctx->sync = of_property_read_bool(pdev->dev.of_node, "arm,sea-notify");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "status region missing\n");
+		return -EINVAL;
+	}
+
+	ctx->status_len = resource_size(res);
+	if (!ctx->status_len) {
+		dev_err(&pdev->dev, "Status region has zero length\n");
+		return -EINVAL;
+	}
+
+	ctx->status = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(ctx->status))
+		return PTR_ERR(ctx->status);
+
+	rc = ghes_ffh_init_ack(pdev, ctx);
+	if (rc)
+		return rc;
+
+	rc = ghes_ffh_init_pool();
+	if (rc)
+		return rc;
+
+	ctx->estatus = devm_kzalloc(&pdev->dev, ctx->status_len, GFP_KERNEL);
+	if (!ctx->estatus)
+		return -ENOMEM;
+
+	ctx->generic = devm_kzalloc(&pdev->dev, sizeof(*ctx->generic), GFP_KERNEL);
+	if (!ctx->generic)
+		return -ENOMEM;
+
+	ctx->generic->header.type = ACPI_HEST_TYPE_GENERIC_ERROR;
+	ctx->generic->header.source_id =
+		atomic_inc_return(&ghes_ffh_source_ids);
+	ctx->generic->notify.type = ctx->sync ?
+		ACPI_HEST_NOTIFY_SEA : ACPI_HEST_NOTIFY_EXTERNAL;
+	ctx->generic->error_block_length = ctx->status_len;
+
+	ctx->irq = platform_get_irq_optional(pdev, 0);
+	if (ctx->irq <= 0) {
+		if (ctx->irq == -EPROBE_DEFER)
+			return ctx->irq;
+		dev_err(&pdev->dev, "interrupt is required (%d)\n", ctx->irq);
+		return -EINVAL;
+	}
+
+	rc = devm_request_threaded_irq(&pdev->dev, ctx->irq,
+				       NULL, ghes_ffh_irq,
+				       IRQF_ONESHOT,
+				       dev_name(&pdev->dev), ctx);
+	if (rc)
+		return rc;
+
+	platform_set_drvdata(pdev, ctx);
+	dev_info(&pdev->dev, "Firmware-first CPER status provider (interrupt)\n");
+	return 0;
+}
+
+static void ghes_ffh_remove(struct platform_device *pdev)
+{
+}
+
+static const struct of_device_id ghes_ffh_of_match[] = {
+	{ .compatible = "arm,ras-ffh" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ghes_ffh_of_match);
+
+static struct platform_driver ghes_ffh_driver = {
+	.driver = {
+		.name = "esource-dt",
+		.of_match_table = ghes_ffh_of_match,
+	},
+	.probe = ghes_ffh_probe,
+	.remove = ghes_ffh_remove,
+};
+
+module_platform_driver(ghes_ffh_driver);
+
+MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
+MODULE_DESCRIPTION("Firmware-first CPER provider for DeviceTree platforms");
+MODULE_LICENSE("GPL");
diff --git a/include/acpi/ghes_cper.h b/include/acpi/ghes_cper.h
index f7c9fba62585..d43185c020ee 100644
--- a/include/acpi/ghes_cper.h
+++ b/include/acpi/ghes_cper.h
@@ -75,6 +75,15 @@ static inline bool is_hest_sync_notify(struct ghes *ghes)
 	return notify_type == ACPI_HEST_NOTIFY_SEA;
 }
 
+static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
+{
+	if (estatus->raw_data_length)
+		return estatus->raw_data_offset + \
+			estatus->raw_data_length;
+	else
+		return sizeof(*estatus) + estatus->data_length;
+}
+
 struct ghes_vendor_record_entry {
 	struct work_struct work;
 	int error_severity;

-- 
2.43.0


