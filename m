Return-Path: <linux-acpi+bounces-19746-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBEECD4D37
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 07:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E9983007268
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Dec 2025 06:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09E23EAB8;
	Mon, 22 Dec 2025 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="jvKNXPCa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C893F2222BF;
	Mon, 22 Dec 2025 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766386529; cv=none; b=t2BwDTX45KhHGyP7MH9s4a42h0IWaLBD801j2bN8/+Y80eesSfdfKcCtB9PeYL9XcaZVQ1TnIsPL/CkkPOvmE4x3CAlTrTYrevzrpz6dHaFhjMfwGK67eT7p6ouCjWMw4UVRbpwVarJTepki/an/02GbJ2y/He4iYpc4QSkRY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766386529; c=relaxed/simple;
	bh=bTaSSWqtn98z2Qj6qEHjHoQ1Z9LeLdTFS9bX5rBwXd4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZTyvIt+lh8M/GUKT221/SDdAZcixv+FGvoS//k8F0soPVbU6PfHEu2XDA1POcuLx/F1kqeZlBcjtE2bBF9mhYw/aPgfIzisyfFIsNn0O9eN/gmQLsL97fdqmHfm1DTaYYI2zTYUOOtxYlgka+794JZ7kI3Xr/VLAPji2PJJbciQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=jvKNXPCa; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1766386526; x=1797922526;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bTaSSWqtn98z2Qj6qEHjHoQ1Z9LeLdTFS9bX5rBwXd4=;
  b=jvKNXPCaRkKsC/ceW+1nNUt6HgjRPCcEvvp86v9Q1bFywqKNy23dbVXx
   OcPgL8aSyLuY1LDC7hVREJR+0fgjLg733NY6XqtCNRIOzeKpvNADqKin+
   zJbpknUXAbYYNkELNfg6rCeZI7xQafelo1UwDMmhY46FH90r2J3VOsFLp
   WsbmYOkIIw/cO3ob18jdNT4OS9Z/J+LnkOFaIV7oS7CDzVXbPneweoGW2
   PxUoAUiApNvDSp1+kYDG1yJoTYBMfoS0hqTe1M2BwyKzzc78RU7d++fBB
   LnJGYdi+1G06ZQjuF0cDym7kNnbqMES7B3YA3QsYeadkjZyBZB1YIcsda
   Q==;
X-CSE-ConnectionGUID: 1kmgMkHcTqmnoCxSIC628A==
X-CSE-MsgGUID: J54pDeJrQxeBQ8HKj7FmRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="202429930"
X-IronPort-AV: E=Sophos;i="6.21,167,1763391600"; 
   d="scan'208";a="202429930"
Received: from unknown (HELO az2uksmgr2.o.css.fujitsu.com) ([52.151.125.128])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2025 15:54:15 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 572C58200B4;
	Mon, 22 Dec 2025 06:54:16 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (az2uksmom4.o.css.fujitsu.com [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 0C4E28D65F9;
	Mon, 22 Dec 2025 06:54:16 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTP id 2D0A34046BC;
	Mon, 22 Dec 2025 06:54:10 +0000 (UTC)
From: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Will Deacon <will@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>,
	Koichi Okuno <fj2767dz@aa.jp.fujitsu.com>
Subject: [PATCH v5] ACPI: AGDI: Add interrupt signaling mode support
Date: Mon, 22 Dec 2025 15:53:34 +0900
Message-ID: <20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AGDI has two types of signaling modes: SDEI and interrupt.
Currently, the AGDI driver only supports SDEI.
Therefore, add support for interrupt signaling mode.
The interrupt vector is retrieved from the AGDI table, and call panic
function when an interrupt occurs.

Acked-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>

---
This patch (v5) has been rebased to align with the 6.19-rc1 release.
There are no functional changes since v4.
The IRQF_NO_AUTOEN flag discussed in the v4 patch review was ultimately left unchanged.
It has been tested and confirmed to work without issues.
Please let us know if you have any questions or concerns.

v4->v5
 - Rebase to 6.19-rc1.
 - Add acked-by from Hanjun Guo.

v4: https://lore.kernel.org/all/20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com/
v3->v4
 - Add a comment to the flags member.
 - Fix agdi_interrupt_probe.
 - Fix agdi_interrupt_remove.
 - Add space in struct initializsation.
 - Delete curly braces.

v3: https://lore.kernel.org/all/20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com/
v2->v3
 - Fix bug in the return value of agdi_probe function.
 - Remove unnecessary curly braces in the agdi_remove function.

v2: https://lore.kernel.org/all/20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com/
v1->v2
 - Remove acpica update since there is no need to update define value
   for this patch.
---
 drivers/acpi/arm64/agdi.c | 114 +++++++++++++++++++++++++++++++++++---
 include/acpi/actbl2.h     |   4 +-
 2 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index e0df3daa4abf..c514bb874c5d 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -16,7 +16,11 @@
 #include "init.h"
 
 struct agdi_data {
+	unsigned char flags;
 	int sdei_event;
+	unsigned int gsiv;
+	bool use_nmi;
+	int irq;
 };
 
 static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
@@ -48,6 +52,55 @@ static int agdi_sdei_probe(struct platform_device *pdev,
 	return 0;
 }
 
+static irqreturn_t agdi_interrupt_handler_nmi(int irq, void *dev_id)
+{
+	nmi_panic(NULL, "Arm Generic Diagnostic Dump and Reset NMI Interrupt event issued\n");
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t agdi_interrupt_handler_irq(int irq, void *dev_id)
+{
+	panic("Arm Generic Diagnostic Dump and Reset Interrupt event issued\n");
+	return IRQ_HANDLED;
+}
+
+static int agdi_interrupt_probe(struct platform_device *pdev,
+				struct agdi_data *adata)
+{
+	unsigned long irq_flags;
+	int ret;
+	int irq;
+
+	irq = acpi_register_gsi(NULL, adata->gsiv, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "cannot register GSI#%d (%d)\n", adata->gsiv, irq);
+		return irq;
+	}
+
+	irq_flags = IRQF_PERCPU | IRQF_NOBALANCING | IRQF_NO_AUTOEN |
+		    IRQF_NO_THREAD;
+	/* try NMI first */
+	ret = request_nmi(irq, &agdi_interrupt_handler_nmi, irq_flags,
+			  "agdi_interrupt_nmi", NULL);
+	if (ret) {
+		ret = request_irq(irq, &agdi_interrupt_handler_irq,
+				  irq_flags, "agdi_interrupt_irq", NULL);
+		if (ret) {
+			dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
+			acpi_unregister_gsi(adata->gsiv);
+			return ret;
+		}
+		enable_irq(irq);
+		adata->irq = irq;
+	} else {
+		enable_nmi(irq);
+		adata->irq = irq;
+		adata->use_nmi = true;
+	}
+
+	return 0;
+}
+
 static int agdi_probe(struct platform_device *pdev)
 {
 	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
@@ -55,12 +108,20 @@ static int agdi_probe(struct platform_device *pdev)
 	if (!adata)
 		return -EINVAL;
 
-	return agdi_sdei_probe(pdev, adata);
+	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
+	case ACPI_AGDI_SIGNALING_MODE_SDEI:
+		return agdi_sdei_probe(pdev, adata);
+
+	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
+		return agdi_interrupt_probe(pdev, adata);
+	}
+
+	return 0;
 }
 
-static void agdi_remove(struct platform_device *pdev)
+static void agdi_sdei_remove(struct platform_device *pdev,
+			     struct agdi_data *adata)
 {
-	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
 	int err, i;
 
 	err = sdei_event_disable(adata->sdei_event);
@@ -83,6 +144,34 @@ static void agdi_remove(struct platform_device *pdev)
 			adata->sdei_event, ERR_PTR(err));
 }
 
+static void agdi_interrupt_remove(struct platform_device *pdev,
+				  struct agdi_data *adata)
+{
+	if (adata->irq != -1) {
+		if (adata->use_nmi)
+			free_nmi(adata->irq, NULL);
+		else
+			free_irq(adata->irq, NULL);
+
+		acpi_unregister_gsi(adata->gsiv);
+	}
+}
+
+static void agdi_remove(struct platform_device *pdev)
+{
+	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
+
+	switch (adata->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
+	case ACPI_AGDI_SIGNALING_MODE_SDEI:
+		agdi_sdei_remove(pdev, adata);
+		break;
+
+	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
+		agdi_interrupt_remove(pdev, adata);
+		break;
+	}
+}
+
 static struct platform_driver agdi_driver = {
 	.driver = {
 		.name = "agdi",
@@ -94,7 +183,7 @@ static struct platform_driver agdi_driver = {
 void __init acpi_agdi_init(void)
 {
 	struct acpi_table_agdi *agdi_table;
-	struct agdi_data pdata;
+	struct agdi_data pdata = {0};
 	struct platform_device *pdev;
 	acpi_status status;
 
@@ -103,12 +192,23 @@ void __init acpi_agdi_init(void)
 	if (ACPI_FAILURE(status))
 		return;
 
-	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
-		pr_warn("Interrupt signaling is not supported");
+	switch (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK) {
+	case ACPI_AGDI_SIGNALING_MODE_SDEI:
+		pdata.sdei_event = agdi_table->sdei_event;
+		break;
+
+	case ACPI_AGDI_SIGNALING_MODE_INTERRUPT:
+		pdata.gsiv = agdi_table->gsiv;
+		break;
+
+	default:
+		pr_warn("Signaling mode(%d) is not supported",
+			agdi_table->flags & ACPI_AGDI_SIGNALING_MODE_MASK);
 		goto err_put_table;
 	}
 
-	pdata.sdei_event = agdi_table->sdei_event;
+	pdata.irq = -1;
+	pdata.flags = agdi_table->flags;
 
 	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
 	if (IS_ERR(pdev))
diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index f726bce3eb84..706699f3f294 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -340,7 +340,9 @@ struct acpi_table_agdi {
 
 /* Mask for Flags field above */
 
-#define ACPI_AGDI_SIGNALING_MODE (1)
+#define ACPI_AGDI_SIGNALING_MODE_MASK (3)
+#define ACPI_AGDI_SIGNALING_MODE_SDEI (0)
+#define ACPI_AGDI_SIGNALING_MODE_INTERRUPT (1)
 
 /*******************************************************************************
  *
-- 
2.43.0


