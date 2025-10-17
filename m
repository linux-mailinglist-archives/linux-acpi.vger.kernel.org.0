Return-Path: <linux-acpi+bounces-17858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F8BE6F9B
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 09:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4D9D624522
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 07:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15962417D4;
	Fri, 17 Oct 2025 07:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HSmqOJ8X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D723AB98;
	Fri, 17 Oct 2025 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686860; cv=none; b=A0JpXzYJbZ8+jiRmqzRtAycZepNc+QaTFHyTWtoxtSOPXBH8LkTCkdQzWiG969BZeTWqK9utMSolIDKHGN2DTsMz5XHoHvytmnLZMc0oRIbf3wtJexgi9dIREgC6DOz8g+pVHJO/bUdxDaqE5T0fnZ/z4RnLiFaALbHhWWa78sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686860; c=relaxed/simple;
	bh=8Qd4GPH7y8X3pVNHEWQhcSh8umsdNRfLMh7EGnd9YjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qW1l2/ZHbrioo7t0oSyo7g54MBZ6lSoTZ0sBDBfSn7IBr/ZWilr/k9eFhk2vnzRRcrk5t7RMBlqgma5f0XshRs1vQcumevBdvJ8lDz2mb0U30UnwrCSRk7/GCmua7Y5oAf9sTvpcKmoAqz8G2mMobIc0ZQzfmzLUfsEZvtWUi9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HSmqOJ8X; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1760686858; x=1792222858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Qd4GPH7y8X3pVNHEWQhcSh8umsdNRfLMh7EGnd9YjU=;
  b=HSmqOJ8XFU8IhkgAJqkxoj5S/QuyiQ1Gt8GOksZc5wAS5ea9YZo7n4tF
   SOYlR3zXqw6Cu8OZBMFOpa8hBkp/jjDa5hAgUSY0vbz+g77+XqMVZIbjR
   3nvyr65kknMShbygeky7bQq3ZVV0oA+DDqN9J987bhU0Eygk4LIkd+Xrv
   BsK8MvFclz/2buGC8KTRFI1wY3uskb54qnaiwuQnPKwIyW9KeCVmfdHO5
   VUL7UXa0BUlcdLI4XbeGvZ9rtyNPwJMgczG46/JsdqN3+EMePuj+de8+x
   byo74SETlTutlzzabziRuJXhfbwZYPQQtcDF7dMa9dyVsakQ0NjBzeTnY
   w==;
X-CSE-ConnectionGUID: sARsC953Skez1LoeKprIlw==
X-CSE-MsgGUID: vZ8RIvENRe+eJpngRTaXGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="215607805"
X-IronPort-AV: E=Sophos;i="6.19,234,1754924400"; 
   d="scan'208";a="215607805"
Received: from unknown (HELO az2uksmgr4.o.css.fujitsu.com) ([52.151.125.128])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 16:39:46 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr4.o.css.fujitsu.com (Postfix) with ESMTPS id 89962C0056B;
	Fri, 17 Oct 2025 07:39:46 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 46826926757;
	Fri, 17 Oct 2025 07:39:46 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 2F795180157C;
	Fri, 17 Oct 2025 07:39:41 +0000 (UTC)
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
Subject: [PATCH v4] ACPI: AGDI: Add interrupt signaling mode support
Date: Fri, 17 Oct 2025 16:39:25 +0900
Message-ID: <20251017073935.1746365-1-fj1078ii@aa.jp.fujitsu.com>
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

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
---
Hanjun, I have addressed all your comments.
Please review them.

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
 drivers/acpi/arm64/agdi.c | 101 ++++++++++++++++++++++++++++++++++----
 1 file changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index e0df3daa4abf..feb4b2cb4618 100644
--- a/drivers/acpi/arm64/agdi.c
+++ b/drivers/acpi/arm64/agdi.c
@@ -16,7 +16,11 @@
 #include "init.h"
 
 struct agdi_data {
+	unsigned char flags; /* AGDI Signaling Mode */
 	int sdei_event;
+	unsigned int gsiv;
+	bool use_nmi;
+	int irq;
 };
 
 static int agdi_sdei_handler(u32 sdei_event, struct pt_regs *regs, void *arg)
@@ -48,6 +52,57 @@ static int agdi_sdei_probe(struct platform_device *pdev,
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
+	if (!ret) {
+		enable_nmi(irq);
+		adata->irq = irq;
+		adata->use_nmi = true;
+		return 0;
+	}
+
+	/* Then try normal interrupt */
+	ret = request_irq(irq, &agdi_interrupt_handler_irq,
+			  irq_flags, "agdi_interrupt_irq", NULL);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot register IRQ %d\n", ret);
+		acpi_unregister_gsi(adata->gsiv);
+		return ret;
+	}
+	enable_irq(irq);
+	adata->irq = irq;
+
+	return 0;
+}
+
 static int agdi_probe(struct platform_device *pdev)
 {
 	struct agdi_data *adata = dev_get_platdata(&pdev->dev);
@@ -55,12 +110,15 @@ static int agdi_probe(struct platform_device *pdev)
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
@@ -83,6 +141,30 @@ static void agdi_remove(struct platform_device *pdev)
 			adata->sdei_event, ERR_PTR(err));
 }
 
+static void agdi_interrupt_remove(struct platform_device *pdev,
+				  struct agdi_data *adata)
+{
+	if (adata->irq == -1)
+		return;
+
+	if (adata->use_nmi)
+		free_nmi(adata->irq, NULL);
+	else
+		free_irq(adata->irq, NULL);
+
+	acpi_unregister_gsi(adata->gsiv);
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
@@ -94,7 +176,7 @@ static struct platform_driver agdi_driver = {
 void __init acpi_agdi_init(void)
 {
 	struct acpi_table_agdi *agdi_table;
-	struct agdi_data pdata;
+	struct agdi_data pdata = { 0 };
 	struct platform_device *pdev;
 	acpi_status status;
 
@@ -103,12 +185,13 @@ void __init acpi_agdi_init(void)
 	if (ACPI_FAILURE(status))
 		return;
 
-	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE) {
-		pr_warn("Interrupt signaling is not supported");
-		goto err_put_table;
-	}
+	if (agdi_table->flags & ACPI_AGDI_SIGNALING_MODE)
+		pdata.gsiv = agdi_table->gsiv;
+	else
+		pdata.sdei_event = agdi_table->sdei_event;
 
-	pdata.sdei_event = agdi_table->sdei_event;
+	pdata.irq = -1;
+	pdata.flags = agdi_table->flags;
 
 	pdev = platform_device_register_data(NULL, "agdi", 0, &pdata, sizeof(pdata));
 	if (IS_ERR(pdev))
-- 
2.43.0


