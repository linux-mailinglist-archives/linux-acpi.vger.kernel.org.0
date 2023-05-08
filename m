Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014DC6FAF65
	for <lists+linux-acpi@lfdr.de>; Mon,  8 May 2023 13:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjEHL5W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 May 2023 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjEHL4l (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2023 07:56:41 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768D84369E
        for <linux-acpi@vger.kernel.org>; Mon,  8 May 2023 04:55:04 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-51b661097bfso3060759a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2023 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546900; x=1686138900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSuTggFYj3JSbFizfFEsySbatkGCHwC0oNgPzvEucIg=;
        b=OwnBVNyw27EdkLus1jTOuwbndB2EL2oVzQ7k7WqNfE23/8qlo+tk8UFosj4+DGtIEM
         we9+O1U8hj7m0aWDcbRQxN5ACgyeeG2VJSTA+BGXf0Lc91Yu3v8w6YkG0P9tVDrl1Pjb
         M/Jj9HtGkwPWIa+gtgQXauU7tRECTZ4MSLSX7eV6SQDAJy5Q22e88y0ohlQ2w+9nI9vm
         4cLX6IAHT9CSG0m6PilY/qusyz8K+wT4LRCKXTzhosGOyZItkPHdE81/RAXq3F3cHu9l
         MrD0rX8pil+aPxPPGWzdKtYQEVz9zLmR7W/XzVVJNkvN4gGzVcNn/RllSUoQVTVxW2HZ
         pP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546900; x=1686138900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GSuTggFYj3JSbFizfFEsySbatkGCHwC0oNgPzvEucIg=;
        b=hzZQoLO1ORMfQUcMgKeTXFX0F+o4ktqC1GUFvsjJGdzO27ksoUZpR4ybRtTs8yGfiI
         Fc4Igu1QmaDKcggmNs/STdcc1wfEA/lScfsE50h2R6q80i890mGJHZUvCkQQtQzGVPsY
         SV6r603FXsiXrJFON+G8SaPIN7XdRgZ8+0m4plhtBhba0pCTy3FEX04q6cyBT2jFk63l
         m6yLMMVfLLUVKXOWvPxRzDt8uc+V0QwAh7vvp/7GW0XPswrgYuVGZj9OfFAYcECAyAf3
         2g0TV/zt8CkTXXyPGdUXupXAddBruv3zALnk65DFgLdUzQtSw+j6m+ow0eCHAzeZFPuB
         G5bg==
X-Gm-Message-State: AC+VfDyGMH4pUE4tpvkPvE1Jc8WCYsx5KYUvl76jwmMxCm7Rym7eXG8Y
        GieBwRzJ4QBSQw65eKMTmDZSKA==
X-Google-Smtp-Source: ACHHUZ74VlINKqqw1M1Nzm9Knvlkg1O1yI8Vgz31f0P7xgzVEMnDcYaHW6CpqAaMkpJZUju498eICg==
X-Received: by 2002:a17:902:eccc:b0:1a6:6b85:7b4a with SMTP id a12-20020a170902eccc00b001a66b857b4amr12146859plh.18.1683546899877;
        Mon, 08 May 2023 04:54:59 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:59 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH V5 15/21] irqchip/riscv-intc: Add ACPI support
Date:   Mon,  8 May 2023 17:22:31 +0530
Message-Id: <20230508115237.216337-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add support for initializing the RISC-V INTC driver on ACPI
platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/irqchip/irq-riscv-intc.c | 70 +++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index f229e3e66387..4adeee1bc391 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -6,6 +6,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-intc: " fmt
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/bits.h>
 #include <linux/cpu.h>
@@ -112,6 +113,30 @@ static struct fwnode_handle *riscv_intc_hwnode(void)
 	return intc_domain->fwnode;
 }
 
+static int __init riscv_intc_init_common(struct fwnode_handle *fn)
+{
+	int rc;
+
+	intc_domain = irq_domain_create_linear(fn, BITS_PER_LONG,
+					       &riscv_intc_domain_ops, NULL);
+	if (!intc_domain) {
+		pr_err("unable to add IRQ domain\n");
+		return -ENXIO;
+	}
+
+	rc = set_handle_irq(&riscv_intc_irq);
+	if (rc) {
+		pr_err("failed to set irq handler\n");
+		return rc;
+	}
+
+	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+
+	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+
+	return 0;
+}
+
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
@@ -133,24 +158,39 @@ static int __init riscv_intc_init(struct device_node *node,
 	if (riscv_hartid_to_cpuid(hartid) != smp_processor_id())
 		return 0;
 
-	intc_domain = irq_domain_add_linear(node, BITS_PER_LONG,
-					    &riscv_intc_domain_ops, NULL);
-	if (!intc_domain) {
-		pr_err("unable to add IRQ domain\n");
-		return -ENXIO;
-	}
+	return riscv_intc_init_common(of_node_to_fwnode(node));
+}
 
-	rc = set_handle_irq(&riscv_intc_irq);
-	if (rc) {
-		pr_err("failed to set irq handler\n");
-		return rc;
-	}
+IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
 
-	riscv_set_intc_hwnode_fn(riscv_intc_hwnode);
+#ifdef CONFIG_ACPI
 
-	pr_info("%d local interrupts mapped\n", BITS_PER_LONG);
+static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
+				       const unsigned long end)
+{
+	struct fwnode_handle *fn;
+	struct acpi_madt_rintc *rintc;
 
-	return 0;
+	rintc = (struct acpi_madt_rintc *)header;
+
+	/*
+	 * The ACPI MADT will have one INTC for each CPU (or HART)
+	 * so riscv_intc_acpi_init() function will be called once
+	 * for each INTC. We only do INTC initialization
+	 * for the INTC belonging to the boot CPU (or boot HART).
+	 */
+	if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id())
+		return 0;
+
+	fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
+	if (!fn) {
+		pr_err("unable to allocate INTC FW node\n");
+		return -ENOMEM;
+	}
+
+	return riscv_intc_init_common(fn);
 }
 
-IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
+IRQCHIP_ACPI_DECLARE(riscv_intc, ACPI_MADT_TYPE_RINTC, NULL,
+		     ACPI_MADT_RINTC_VERSION_V1, riscv_intc_acpi_init);
+#endif
-- 
2.34.1

