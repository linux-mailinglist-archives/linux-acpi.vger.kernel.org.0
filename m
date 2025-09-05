Return-Path: <linux-acpi+bounces-16385-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49734B44CB3
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 06:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04836164F4C
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 04:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04A022FE0F;
	Fri,  5 Sep 2025 04:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="NPBCCFo3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725F31E2834;
	Fri,  5 Sep 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757046496; cv=none; b=fc0Gt6LoUB9VGwZ7czA9ArW+yiQ1vTThDxK92+44cl/6G5qk7vUN8Wjzc4pcoPztsnXWjttSiqT5u+FkSZ2CX/6mHMFPbLY+fPaL2cZ2MMcJnY71pL5xMbb/3IWHU3NfccBgbQ55kFbO4FZRDmfNCVKKlpd+ZvnxHVFmhKFAHj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757046496; c=relaxed/simple;
	bh=xalTBGUaJut6FZ6AT7b/pJ5ppOEk0X/YlTA6n0kDWQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yd3XikwbyVJCmvOC6B4qGi2jdlqvriedgDg1RRdTPGLvz3KV4qhOwkBtwxYpJodlT99e2hpkoPZPHDYqopmAPAy1PpgnA95MIdCU644URWMCOCjCYWwbRHXWaZd5vmybGVzASAGaQa4SaZLNEsjns1CoS99yFFwK2hUgiTI+biw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=NPBCCFo3; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1757046493; x=1788582493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xalTBGUaJut6FZ6AT7b/pJ5ppOEk0X/YlTA6n0kDWQs=;
  b=NPBCCFo3ILw26FOq3WnfvUaIhcoXK/tARJSfL+QOya5pb6l77MnIMWr7
   VU1e6I49iJEs7Tc6oPiGnl50rnZ+0GA4XzwDknlan2ZjzSx7ZKoC1XpAK
   N9l1pVgLdeF2jH2h9LOx5QxT2zDHTR+juZ9aTMExSRY/PCq1kah1kXDsh
   Rg5Wj7CEPyhLK9x25Ah3kQAreC15PTxQ0q7ANCBHcJQGg4BarldF9OEY2
   GDDSaEyR0tPzRNlZnutJRfoIjQ054UqyzjH947CMyfiac00uW2UCRd6/R
   8JQHcl3ePdH6BKQIWkcBGJMeS7wGnLFrlnELPdAHPt5LFanYnEK8ElXNs
   A==;
X-CSE-ConnectionGUID: txFBpfDkR2KW/jIj9XHjoQ==
X-CSE-MsgGUID: 45hTOyv5QECXwmiFFLXLyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11543"; a="199787678"
X-IronPort-AV: E=Sophos;i="6.18,240,1751209200"; 
   d="scan'208";a="199787678"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([20.61.8.234])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2025 13:28:04 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 3820A185C;
	Fri,  5 Sep 2025 04:28:05 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id DF0BD1000271;
	Fri,  5 Sep 2025 04:28:04 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 139881013115;
	Fri,  5 Sep 2025 04:27:59 +0000 (UTC)
From: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH v3] ACPI: AGDI: Add interrupt signaling mode support
Date: Fri,  5 Sep 2025 13:27:45 +0900
Message-ID: <20250905042751.945616-1-fj1078ii@aa.jp.fujitsu.com>
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
Therefore, add support for interrupt signaling mode
The interrupt vector is retrieved from the AGDI table, and call panic
function when an interrupt occurs.

Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
---
I keep normal IRQ code when NMI cannot be used.
If there is any concern, please let me know.

v2->v3
 - Fix bug in the return value of agdi_probe function.
 - Remove unnecessary curly braces in the agdi_remove function.

v2: https://lore.kernel.org/all/20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com/
v1->v2
 - Remove acpica update since there is no need to update define value
   for this patch.
---
 drivers/acpi/arm64/agdi.c | 95 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index e0df3daa4abf..2313a46f01cd 100644
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
@@ -55,12 +108,15 @@ static int agdi_probe(struct platform_device *pdev)
 	if (!adata)
 		return -EINVAL;
 
-	return agdi_sdei_probe(pdev, adata);
+	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
+		return agdi_interrupt_probe(pdev, adata);
+	else
+		return agdi_sdei_probe(pdev, adata);
 }
 
-static void agdi_remove(struct platform_device *pdev)
+static void agdi_sdei_remove(struct platform_device *pdev,
+			     struct agdi_data *adata)
 {
-	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
 	int err, i;
 
 	err = sdei_event_disable(adata->sdei_event);
@@ -83,6 +139,29 @@ static void agdi_remove(struct platform_device *pdev)
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
+	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
+		agdi_interrupt_remove(pdev, adata);
+	else
+		agdi_sdei_remove(pdev, adata);
+}
+
 static struct platform_driver agdi_driver = {
 	.driver = {
 		.name = "agdi",
@@ -94,7 +173,7 @@ static struct platform_driver agdi_driver = {
 void __init acpi_agdi_init(void)
 {
 	struct acpi_table_agdi *agdi_table;
-	struct agdi_data pdata;
+	struct agdi_data pdata = {0};
 	struct platform_device *pdev;
 	acpi_status status;
 
@@ -104,11 +183,13 @@ void __init acpi_agdi_init(void)
 		return;
 
 	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
-		pr_warn("Interrupt signaling is not supported");
-		goto err_put_table;
+		pdata.gsiv = agdi_table->gsiv;
+	} else {
+		pdata.sdei_event = agdi_table->sdei_event;
 	}
 
-	pdata.sdei_event = agdi_table->sdei_event;
+	pdata.irq = -1;
+	pdata.flags = agdi_table->flags;
 
 	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
 	if (IS_ERR(pdev))
-- 
2.43.0


