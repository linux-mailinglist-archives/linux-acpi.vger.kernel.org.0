Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DB6FAF61
	for <lists+linux-acpi@lfdr.de>; Mon,  8 May 2023 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbjEHL5F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 May 2023 07:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbjEHL41 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2023 07:56:27 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9667C4031F
        for <linux-acpi@vger.kernel.org>; Mon,  8 May 2023 04:54:56 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaebed5bd6so30377705ad.1
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2023 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546891; x=1686138891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyhfCZ5csOlZFGV4bhDymGpgdY5PFJC+Se96opk/VAw=;
        b=mZVolCAzG8wvIf6oLT4D4ZY0rlzt0iN1IwMS4s8MGydTIshmGFWZmlzbShfdzJOuBW
         px2AO5xanvA1J4MGpklcisJXnEEqeF//ddT/JS6zappzr1KbcZ1cDxjBNH/A6h3+gbA8
         Z7CohGl6S5DR78mc3xk2ypWYhJvMw01eEs7obS4aSo6CTG/pvT9MZF8oywQI8QZn89rq
         7+iiLWswwwgBc2etohzciXWK2a0h9JdMrdKMKYI+uTPQ3lzwut4nG8jzhqgfjVqMee8E
         uUVdk5gYm0y74iCLkXN6AuWLTotIsWxKoyS9SExB+rM/4pjksv/WO50M3ug19w1NVtYp
         MkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546891; x=1686138891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyhfCZ5csOlZFGV4bhDymGpgdY5PFJC+Se96opk/VAw=;
        b=RR8T/TeqNxDm6ZItUGa202IBLKmzXbYSOAkieQvZwLy40uXd/H8kCakw8uxLoHEiZJ
         UcoXGg3uz8jjGyNYr8xCvV7W02grWEMPr3vO+UctfIExaZDeWepo7Oz5RNcnl2JsVI6x
         F8o4MYHNrOJ1VbFl0yyjk4njReR1NLD3xrNLGz+TtJUMsDgxB/aE5xsN7DpALGqUweDk
         zsQaQxQoGoqOaMJCyVRe28Zq7MEHg7qgjyGk+vRWOm1iUoSp45O02JSWKOOQlCQOWyH4
         ouR+T1jizsU90gJJlh7MNc0KIj3qd2Rq1Zz6dWWvlQC1nlDX9iqjsovGbFuUJl54d86z
         aIvA==
X-Gm-Message-State: AC+VfDz8lVRcQIoTKrnWSaspL5dqXHvOf0juruhIL8iur5fbiCgShM2j
        qDpTTxk9mkhxeNHZQA+TmDnT5A==
X-Google-Smtp-Source: ACHHUZ7fIR3m0mAK+PAQajTnE1Ep8+CpD/PcOgSSG5R7OWV3PrMXc4KDXQ6LmGExgO8pEE9BvOM6Dg==
X-Received: by 2002:a17:902:d701:b0:1ab:624:38cb with SMTP id w1-20020a170902d70100b001ab062438cbmr9348824ply.14.1683546891602;
        Mon, 08 May 2023 04:54:51 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:51 -0700 (PDT)
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
Subject: [PATCH V5 14/21] RISC-V: cpu: Enable cpuinfo for ACPI systems
Date:   Mon,  8 May 2023 17:22:30 +0530
Message-Id: <20230508115237.216337-15-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230508115237.216337-1-sunilvl@ventanamicro.com>
References: <20230508115237.216337-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On ACPI based platforms, few details like ISA need to be read
from the ACPI table. Enable cpuinfo on ACPI based systems.

ACPI has nothing similar to DT compatible property for each CPU.
Hence, cpuinfo will not print "uarch".

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/kernel/cpu.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index c96aa56cf1c7..5de6fb703cc2 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -3,10 +3,12 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <asm/acpi.h>
 #include <asm/cpufeature.h>
 #include <asm/csr.h>
 #include <asm/hwcap.h>
@@ -283,23 +285,35 @@ static void c_stop(struct seq_file *m, void *v)
 static int c_show(struct seq_file *m, void *v)
 {
 	unsigned long cpu_id = (unsigned long)v - 1;
-	struct device_node *node = of_get_cpu_node(cpu_id, NULL);
 	struct riscv_cpuinfo *ci = per_cpu_ptr(&riscv_cpuinfo, cpu_id);
+	struct device_node *node;
 	const char *compat, *isa;
 
 	seq_printf(m, "processor\t: %lu\n", cpu_id);
 	seq_printf(m, "hart\t\t: %lu\n", cpuid_to_hartid_map(cpu_id));
-	if (!of_property_read_string(node, "riscv,isa", &isa))
-		print_isa(m, isa);
-	print_mmu(m);
-	if (!of_property_read_string(node, "compatible", &compat)
-	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t\t: %s\n", compat);
+
+	if (acpi_disabled) {
+		node = of_get_cpu_node(cpu_id, NULL);
+		if (!of_property_read_string(node, "riscv,isa", &isa))
+			print_isa(m, isa);
+
+		print_mmu(m);
+		if (!of_property_read_string(node, "compatible", &compat) &&
+		    strcmp(compat, "riscv"))
+			seq_printf(m, "uarch\t\t: %s\n", compat);
+
+		of_node_put(node);
+	} else {
+		if (!acpi_get_riscv_isa(NULL, cpu_id, &isa))
+			print_isa(m, isa);
+
+		print_mmu(m);
+	}
+
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 	seq_puts(m, "\n");
-	of_node_put(node);
 
 	return 0;
 }
-- 
2.34.1

