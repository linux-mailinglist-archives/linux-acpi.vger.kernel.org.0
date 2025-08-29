Return-Path: <linux-acpi+bounces-16176-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F173B3B862
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 12:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFB51CC03C5
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Aug 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324273074BC;
	Fri, 29 Aug 2025 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="IDFAPRdf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFFD283FD4;
	Fri, 29 Aug 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756462432; cv=none; b=nU2wuNW6jq6tYbhttyeFOmIjv5BnSapWSA5wyaYMHH5pK/VA6Ofp1JAUIZw0SvYE8M1+bUz8n11LjkYYrhba0jiSAt8FUXVKvNH7bmm0b5ZErNvFvpcSj2CK0F/18ioXiFPXUCG0ikTR56oUnA9dJwPCd0HrA/SEYn3VnDy/lD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756462432; c=relaxed/simple;
	bh=jIByS3sNUYW+jq9JhP57I+abVJkupGZshZJq2NOCC7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pfcVzoVNxZYh8r1w/6EEKg5NdA+cFsQMOznhpeF2L5swlhz8e/rag3pjFC+SyPBSOz7AahKSN5N00Uo5x/CZ3HcaDYGgVPL+DSQ9NuTxO2mKjdjdmvgUtE7h+LmVpd9rr97yxGCc30nO6x+yZWGlj5YCeEOnv0wAPcNHs6wt4yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com; spf=pass smtp.mailfrom=aa.jp.fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=IDFAPRdf; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aa.jp.fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aa.jp.fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1756462429; x=1787998429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jIByS3sNUYW+jq9JhP57I+abVJkupGZshZJq2NOCC7g=;
  b=IDFAPRdfegl2U2D6l3ksUTJSrAv+SX9qaVer6PTJHjdOZSU3n6EbA7Fl
   ma5+NFi+uRgJSEPGQa5JgQZ6OhtX5vRsnibjZZESlhCz/9a2ec2Y/nF1D
   +uUs0QRI68wzIomXLtTT/ongMc0bVg4zgdlsXOjU3Gmt+fn9s7yAxKu7m
   qjP20v8Xk3lYs3IxS1DIGWsykKSAGlMtLo0EQoDDh9g/5eUX9a1AiHjtU
   vu9jf22P3FhfbFpgS6M/2TZ7Yz9S++/hI7+wnALdbRwwURTaB1evofWp5
   vPv1gFfrDh378fFUCxjuQ+/sVnAwW/ktrrIuRMPYMLU0ZJaEgScil7S+J
   Q==;
X-CSE-ConnectionGUID: SFf6wxVaRiGuazZ4ZbLvGw==
X-CSE-MsgGUID: ilmAqebjRp2qfGnYf4RQVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="198972201"
X-IronPort-AV: E=Sophos;i="6.18,221,1751209200"; 
   d="scan'208";a="198972201"
Received: from unknown (HELO az2nlsmgr2.o.css.fujitsu.com) ([51.138.80.169])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 19:12:36 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id E5D4E49B;
	Fri, 29 Aug 2025 10:12:36 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (az2nlsmom3.o.css.fujitsu.com [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id A3F331000271;
	Fri, 29 Aug 2025 10:12:36 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id C355210005B9;
	Fri, 29 Aug 2025 10:12:31 +0000 (UTC)
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
Subject: [PATCH v2] ACPI: AGDI: Add interrupt signaling mode support
Date: Fri, 29 Aug 2025 19:11:47 +0900
Message-ID: <20250829101154.2377800-1-fj1078ii@aa.jp.fujitsu.com>
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

---
I keep normal IRQ code when NMI cannot be used.
If there is any concern, please let me know.

v1->v2
 - Remove acpica update since there is no need to update define value
   for this patch.

Signed-off-by: Kazuhiro Abe <fj1078ii@aa.jp.fujitsu.com>
---
 drivers/acpi/arm64/agdi.c | 98 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 91 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/arm64/agdi.c b/drivers/acpi/arm64/agdi.c
index e0df3daa4abf..e887aab6b448 100644
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
@@ -55,12 +108,17 @@ static int agdi_probe(struct platform_device *pdev)
 	if (!adata)
 		return -EINVAL;
 
-	return agdi_sdei_probe(pdev, adata);
+	if (adata->flags & ACPI_AGDI_SIGNALING_MODE)
+		agdi_interrupt_probe(pdev, adata);
+	else
+		agdi_sdei_probe(pdev, adata);
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
@@ -83,6 +141,30 @@ static void agdi_remove(struct platform_device *pdev)
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
+	if (adata->flags & ACPI_AGDI_SIGNALING_MODE) {
+		agdi_interrupt_remove(pdev, adata);
+	} else {
+		agdi_sdei_remove(pdev, adata);
+	}
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
+	struct agdi_data pdata = {0};
 	struct platform_device *pdev;
 	acpi_status status;
 
@@ -104,11 +186,13 @@ void __init acpi_agdi_init(void)
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


