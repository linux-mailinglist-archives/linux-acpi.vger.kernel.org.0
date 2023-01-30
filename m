Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06946818F7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238152AbjA3S0S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjA3SZm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:25:42 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F67F46D53
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:08 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id cq16-20020a17090af99000b0022c9791ac39so4008426pjb.4
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLT6YVjIMhggeUGxbDKRIEVD6SSgY7IRMPNBstFbaBA=;
        b=M1QDDILcAog1w3pkeRDILsJlkHNAkEovkLKmqgFMVaps8Cs6u32gIaQ4jXpF54kr3e
         /idr6inoUm4ymQXW925LUn0a+drjUAueo6ZnYTxeP51jwjtrT7UYHw0Ewrj0wRhh9278
         zJBen3mN417wHhDdSuG8+HATLZq/PCHVZq4vgxFEPai5RppQWR+MM9RJ6ZD1TT6LsDbJ
         juLg2Rm+I0D4+woO6y3c3YPydLtB1urRROE06sSTT9am5BMtM36Se7kFFl/AVmbPaO3N
         BCmm+TruD8JNnHLfSHQXgtSZmcRtMxuvikBSlSRSCep3yX3boFA5NpgbHpJt9Z1XdzGa
         wKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLT6YVjIMhggeUGxbDKRIEVD6SSgY7IRMPNBstFbaBA=;
        b=HkRby7tUMz6z+xefE7eirjswjuLzNh9j33hG1kbZlIM3jm/RK88whxPl0HSrw1s/19
         k+pUs6bxnuRE4gQ9P8jF4L7jJdEGWQ7OlSpuHx9LSjIVI7064Tg7he27TcDT48D8kVU3
         wyvYrNlgmhO+LCRyt7j1MHoNGf9i1oFeMjMDk3yIcuZTHYC1BT4WHEbpit15tPtfVTwp
         JAIRPac+BMArHUf7ZdROd3QZ3BUYfkZbcGeT7INeZ6q3UCJAjO3x6YsyQC3ppdTpTdAS
         G62NLMHezTJQ0yvuPJgaxtUr3FkLTCTDDHq8AVggMiEtqmU1ht1XxHnS7wE2LUYx0R2X
         71EA==
X-Gm-Message-State: AO0yUKW4NchH1T91BRvyZo4OR8cEPeCJ2UkVNI9/Le1gkZ7QtpyNIGIf
        0uDGsfNaebJ4+6z3JLYHC7lJiw==
X-Google-Smtp-Source: AK7set+q8NH+Tb7GA3eRxftTVuw+3Bfi6WQ7oDY9dijCptCPEskC/PHo2lUMMlO+rpQ0YAIRD29A+A==
X-Received: by 2002:a05:6a21:789a:b0:be:9fff:48d8 with SMTP id bf26-20020a056a21789a00b000be9fff48d8mr2772632pzc.49.1675103045999;
        Mon, 30 Jan 2023 10:24:05 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:24:05 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 20/24] RISC-V: ACPI: cpu: Enable cpuinfo for ACPI systems
Date:   Mon, 30 Jan 2023 23:52:21 +0530
Message-Id: <20230130182225.2471414-21-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
References: <20230130182225.2471414-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On ACPI based platforms, few details like ISA need to be read
from the ACPI table. Enable cpuinfo on ACPI based systems.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/kernel/cpu.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index 1b9a5a66e55a..bd6c0fcfe4ce 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Regents of the University of California
  */
 
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/seq_file.h>
@@ -256,26 +257,47 @@ static void c_stop(struct seq_file *m, void *v)
 {
 }
 
+#ifdef CONFIG_ACPI
+void acpi_print_hart_info(struct seq_file *m,
+			  unsigned long cpu)
+{
+	const char *isa;
+
+	if (!acpi_get_riscv_isa(NULL, get_acpi_id_for_cpu(cpu), &isa))
+		print_isa(m, isa);
+
+}
+#endif
+
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
+
+	if (acpi_disabled) {
+		node = of_get_cpu_node(cpu_id, NULL);
+		if (!of_property_read_string(node, "riscv,isa", &isa))
+			print_isa(m, isa);
+		if (!of_property_read_string(node, "compatible", &compat)
+		    && strcmp(compat, "riscv"))
+			seq_printf(m, "uarch\t\t: %s\n", compat);
+		of_node_put(node);
+	}
+#ifdef CONFIG_ACPI
+	else
+		acpi_print_hart_info(m, cpu_id);
+#endif
+
 	print_mmu(m);
-	if (!of_property_read_string(node, "compatible", &compat)
-	    && strcmp(compat, "riscv"))
-		seq_printf(m, "uarch\t\t: %s\n", compat);
 	seq_printf(m, "mvendorid\t: 0x%lx\n", ci->mvendorid);
 	seq_printf(m, "marchid\t\t: 0x%lx\n", ci->marchid);
 	seq_printf(m, "mimpid\t\t: 0x%lx\n", ci->mimpid);
 	seq_puts(m, "\n");
-	of_node_put(node);
 
 	return 0;
 }
-- 
2.38.0

