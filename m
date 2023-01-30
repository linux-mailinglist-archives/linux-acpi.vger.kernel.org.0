Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4996818E4
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237876AbjA3SZN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbjA3SYv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:24:51 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864B4617B
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:49 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e6so4318976plg.12
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RjjcPypQMXaOislrOYJ95mTwSGDcKCLLP/xnE1MVdDc=;
        b=AGORcmtB0RKxmmBwtZG1zMcjO7O0Ex0YmoIi7gY/J9VsriQPAifWmKEzTA9QHLjQtJ
         uuY/Btcl6/C0NO3gPY7h6UdBWNs8xGinuds7pHrAcoLcqXWDqlcY/35Gb0Y34sXr/nH6
         AUDb81pJKh5riqyRf79BFqrqOf6Z8PxMDrk2OLRBoHbCCbVeMEonFkkzJgF3iNzYIPOx
         Kj3k6OurbJzyh0ha8eQh4zGGgFbVghVnpZcUk4cq084rkO4qGd+AYNDGlrb+SAz2M45c
         nh29uBLGpX1HMNZiQGlV9kpnDEmCj8YVP8Y0+cRcs20155Dcavg9lOAIfEEKcMjuiMgJ
         jsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RjjcPypQMXaOislrOYJ95mTwSGDcKCLLP/xnE1MVdDc=;
        b=3nlFEI9a3+o+UZPnMceNAPM65IQOs9liGx45xYKZH2iEv/bDdaQsC7zetJDglRIL15
         Sm13b8GpsaPuTwseLfYnQE4rMmwEsexE5mxeg89OQJkkjW8p5fsTuoC5ujXaj7stufK3
         NXVVqCCAplzUmHeocDQ1wCFaCgBtNWG8scjC+7YkVBFP60IPEFcKuaUkYVKixHGYZa17
         4vZ5rV14TzauNROGtviLxKQjQA3hqms9cqmAfhgdqhpHc7H46nTZnH8gOIhruczZj3gR
         IwFkRPfa0TCp8RPxe0D9pJ24OK1H7VzCe1z6RRONNWKyUAx5LmltH3Q578T1XEkLdzuW
         3IzA==
X-Gm-Message-State: AO0yUKXBOT7Ygm7lW714IPB9wofWxyv2jey6IhqJIrkK2Wt304nfWfF/
        CdfnugPHqALd31SWkY63Yw2Ttg==
X-Google-Smtp-Source: AK7set/ApwUqtEFlaGh+sQPBVQI6DfYliPE4sHjMsW+qEax8tpPZ22KBh+GDARvBbGe81QGEdL8hng==
X-Received: by 2002:a05:6a20:3948:b0:be:25af:be2c with SMTP id r8-20020a056a20394800b000be25afbe2cmr3819489pzg.41.1675103022512;
        Mon, 30 Jan 2023 10:23:42 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:42 -0800 (PST)
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
Subject: [PATCH 15/24] clocksource/timer-riscv: Refactor riscv_timer_init_dt()
Date:   Mon, 30 Jan 2023 23:52:16 +0530
Message-Id: <20230130182225.2471414-16-sunilvl@ventanamicro.com>
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

Refactor the timer init function such that few things can be shared by
both DT and ACPI based platforms.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 79 +++++++++++++++----------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1b4b36df5484..4016c065a01c 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -119,61 +119,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init riscv_timer_init_dt(struct device_node *n)
+static int __init riscv_timer_init_common(void)
 {
-	int cpuid, error;
-	unsigned long hartid;
-	struct device_node *child;
-	struct irq_domain *domain;
-
-	error = riscv_of_processor_hartid(n, &hartid);
-	if (error < 0) {
-		pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
-			n, hartid);
-		return error;
-	}
-
-	cpuid = riscv_hartid_to_cpuid(hartid);
-	if (cpuid < 0) {
-		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
-		return cpuid;
-	}
-
-	if (cpuid != smp_processor_id())
-		return 0;
+	int error;
+	struct fwnode_handle *intc_fwnode = riscv_get_intc_hwnode();
+	struct irq_domain *domain = NULL;
 
-	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
-	if (child) {
-		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
-					"riscv,timer-cannot-wake-cpu");
-		of_node_put(child);
-	}
 
-	domain = NULL;
-	child = of_get_compatible_child(n, "riscv,cpu-intc");
-	if (!child) {
-		pr_err("Failed to find INTC node [%pOF]\n", n);
-		return -ENODEV;
-	}
-	domain = irq_find_host(child);
-	of_node_put(child);
+	domain = irq_find_matching_fwnode(intc_fwnode, DOMAIN_BUS_ANY);
 	if (!domain) {
-		pr_err("Failed to find IRQ domain for node [%pOF]\n", n);
+		pr_err("Failed to find INTC node [%pfwP]\n", intc_fwnode);
 		return -ENODEV;
 	}
 
 	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
 	if (!riscv_clock_event_irq) {
-		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
-		return -ENODEV;
+		pr_err("Failed to map timer interrupt for node [%pfwP]\n",
+			intc_fwnode);
 	}
 
-	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
-	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("clocksource register failed [%d]\n", error);
 		return error;
 	}
 
@@ -199,7 +166,35 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		static_branch_enable(&riscv_sstc_available);
 	}
 
+	pr_info("timer registered using %s\n",
+		(static_branch_likely(&riscv_sstc_available)) ?
+		"RISC-V Sstc" : "RISC-V SBI");
+
 	return error;
 }
 
+static int __init riscv_timer_init_dt(struct device_node *n)
+{
+	int cpuid, error;
+	unsigned long hartid;
+
+	error = riscv_of_processor_hartid(n, &hartid);
+	if (error < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
+			n, hartid);
+		return error;
+	}
+
+	cpuid = riscv_hartid_to_cpuid(hartid);
+	if (cpuid < 0) {
+		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
+		return cpuid;
+	}
+
+	if (cpuid != smp_processor_id())
+		return 0;
+
+	return riscv_timer_init_common();
+}
+
 TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
-- 
2.38.0

