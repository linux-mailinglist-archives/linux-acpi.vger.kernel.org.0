Return-Path: <linux-acpi+bounces-20044-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8DD01C94
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 10:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B79932A2761
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEC350A35;
	Thu,  8 Jan 2026 07:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="b+8+hc6y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824EF33D505;
	Thu,  8 Jan 2026 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767859106; cv=none; b=gRqdJDznGBv2JTcRXrBVKavsJPK1G89lNevc8AkPMlKUqyw9xgcLRt+yUGkme6KOyN93Oh33pdo6Yf9PlYGe7UP/InuojZKIUohEWKpTuc2hHljpn4DzO30DYPEwO4YQ4b8Sk5i8ov8UPnlmicw8wn6VByO95ezFf2/p7MyXtSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767859106; c=relaxed/simple;
	bh=ovcDdgCVYALwvAeRQ7zUXP7s4USCtO9YrLvO6pVaPDE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AuWKpnhvp5abAZVXj1SgolvUB42F/bK5gyEzm4H1EFz22WW878pqCGUMurUketob373esp0fR1bzdW8sZdvac5WTgxDVcITCwsg46U8PNjqdLw7lfRSzK2vgSIGTTUx1PmumTMrDGaymErDQ4DYhmUvvfYd5HzayU1VzlD4IspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=b+8+hc6y; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1767859093; x=1799395093;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ovcDdgCVYALwvAeRQ7zUXP7s4USCtO9YrLvO6pVaPDE=;
  b=b+8+hc6y3574mptxmijRsL9muu4y+GNp0wxZ0de08x6ONLGdDMQZ31Wq
   AcLHls/hjEtXrnSvFZ5njQLksWwfEGWkDqzjjbht3nRkL43EQDFSSvgnI
   p6vRZMh614YDLLaLcDygDuRPZyX/uF4GjdseTEkp7PBp7fRh0S47G3JVw
   l6XJJaLccPkvHjY+VCXnIN6youQpCifSSDltM3vXzK6yw/9zR2N82afb3
   hXokfGy8J/6XIsKhS6U4EuvOnHrDzlP6pF8+i6j7BLl9N4kXFP15qgd/5
   oWkgpSLUlvskrmEL8O+C7c6RoTVWXuu7DY+4cV1IBrU193d3kjfpnCKSq
   Q==;
X-CSE-ConnectionGUID: V5xG/llmRjW87TBwmufBDg==
X-CSE-MsgGUID: GPohQyPCRwyGpzShd3lyzw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="213779327"
X-IronPort-AV: E=Sophos;i="6.21,210,1763391600"; 
   d="scan'208";a="213779327"
Received: from unknown (HELO az2nlsmgr1.o.css.fujitsu.com) ([20.61.8.234])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 16:56:59 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr1.o.css.fujitsu.com (Postfix) with ESMTPS id 90CC41C00092;
	Thu,  8 Jan 2026 07:56:59 +0000 (UTC)
Received: from az2uksmom1.o.css.fujitsu.com (az2uksmom1.o.css.fujitsu.com [10.151.22.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 3BCF51C17281;
	Thu,  8 Jan 2026 07:56:59 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2uksmom1.o.css.fujitsu.com (Postfix) with ESMTP id 417EE180536A;
	Thu,  8 Jan 2026 07:56:54 +0000 (UTC)
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
Subject: [PATCH v6] ACPI: AGDI: Add interrupt signaling mode support
Date: Thu,  8 Jan 2026 16:56:09 +0900
Message-ID: <20260108075636.524722-1-fj1078ii@aa.jp.fujitsu.com>
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
This patch (v6) has been rebased to align with the 6.19-rc4 release.
There are no functional changes since v4.
It has been tested and confirmed to work without issues.
Please let us know if you have any questions or concerns.
Thank you, Will, for taking care of the mistake in v5.

v5->v6
 - Rebase to 6.19-rc4.
 - Correct the mistake in v5.

v5(withdrawn due to mistake): https://lore.kernel.org/all/20251222065359.27330-1-fj1078ii@aa.jp.fujitsu.com/
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


