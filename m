Return-Path: <linux-acpi+bounces-15790-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8BB29A3C
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 08:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB87A93E3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CD21487E9;
	Mon, 18 Aug 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="D9wyBT5x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D076E27876E;
	Mon, 18 Aug 2025 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500101; cv=none; b=mL1A7ih50/76D1DibQqNTsNRB52M93LldYG+MtkpVhFYV6If4mxuYUYxKTacUGnnIyYdMSu2+Tmycm8a3pidNtym0nYbcIUJu459lbB5YkxhiSYTykBCt1z2N1bXx/IgAEnhElKayyejCwPx/kcA3PK80M4NQGtvhXP2F1S1kCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500101; c=relaxed/simple;
	bh=SYqtjbS5xj6kVXRvjoAEi4rEMpnH5VOdZ8cA9FjUtd8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lozyMcslg8gBztuIqlAs2RR+XYwytW30ghw4TYJ0lppiPQQ3iLHkxsLhb/wFxy7F+NJlwsjLqVSqTWffU6pj669/1sc5bi4CYepYAbfjG/5te6P/E7vqbnwHNs7QDnnH+ytAtDzf0jztYDSyHHJZpkp9C78z24b6E3W6o7BWA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=D9wyBT5x; arc=none smtp.client-ip=68.232.139.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1755500099; x=1787036099;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SYqtjbS5xj6kVXRvjoAEi4rEMpnH5VOdZ8cA9FjUtd8=;
  b=D9wyBT5xnouc8i3JV88+qZ/Y3iy3gJbqBeo/0k+oxz+pge6WdQHCbxdb
   GSSeRTlJtAprdnAgukl8cbEBll3G7AzpVDP+aWM+KsMu333W114ToMnIC
   x8KSC3WcD1mE4AN1lltxRN5rlufaOq+X4dt3BQCJDWn2JNMo0W1/TJz2C
   lNdeDTQvdwum+lUVGmtmRYp6REFZ3VwNXEn2TRcrW+oFyxcNoco9mW8Vh
   7Y9Vf/gUpd3PTy1l9N9bjPjaEz5r2jHDxqo42rGlDrw/VXvjXieldxJ1C
   SEyvCYx6CVESQd4X/OQR7Od4WakvKwllc5BM6CW8yJk4GWO23SNlQTQpz
   g==;
X-CSE-ConnectionGUID: 2uPg1gbcSqa6U0vsdjVMUA==
X-CSE-MsgGUID: 9p1Pm3zLS7WtHCkVUs3EdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="212937784"
X-IronPort-AV: E=Sophos;i="6.17,293,1747666800"; 
   d="scan'208";a="212937784"
Received: from unknown (HELO az2uksmgr3.o.css.fujitsu.com) ([52.151.125.19])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2025 15:54:52 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr3.o.css.fujitsu.com (Postfix) with ESMTPS id 7D88C1002B84;
	Mon, 18 Aug 2025 06:54:51 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (az2uksmom2.o.css.fujitsu.com [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id 37B991800257;
	Mon, 18 Aug 2025 06:54:51 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTP id 8F6941400126;
	Mon, 18 Aug 2025 06:54:46 +0000 (UTC)
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
Subject: [PATCH] ACPI: AGDI: Add interrupt signaling mode support
Date: Mon, 18 Aug 2025 15:54:32 +0900
Message-ID: <20250818065437.85905-1-fj1078ii@aa.jp.fujitsu.com>
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
Therefore, add support for interrupt singaling mode
The interrupt vector is retrieved from the AGDI table, and call panic
function when an interrupt occurs.
SDEI & Interrupt mode is not supported.

Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
---
 drivers/acpi/arm64/agdi.c | 114 +++++++++++++++++++++++++++++++++++---
 include/acpi/actbl2.h     |   4 +-
 2 files changed, 110 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index e0df3daa4abf0..c514bb874c5d3 100644
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
index 048f5f47f8b88..9ddbdd772f139 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -339,7 +339,9 @@ struct acpi_table_agdi {
 
 /* Mask for Flags field above */
 
-#define ACPI_AGDI_SIGNALING_MODE (1)
+#define ACPI_AGDI_SIGNALING_MODE_MASK (3)
+#define ACPI_AGDI_SIGNALING_MODE_SDEI (0)
+#define ACPI_AGDI_SIGNALING_MODE_INTERRUPT (1)
 
 /*******************************************************************************
  *
-- 
2.43.0


