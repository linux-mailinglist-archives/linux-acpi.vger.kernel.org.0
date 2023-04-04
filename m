Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1946D6BC2
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Apr 2023 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDDSYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Apr 2023 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbjDDSYX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Apr 2023 14:24:23 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7144EEC
        for <linux-acpi@vger.kernel.org>; Tue,  4 Apr 2023 11:22:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o11so32172880ple.1
        for <linux-acpi@vger.kernel.org>; Tue, 04 Apr 2023 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1680632559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z6bEMhbWIxvIOeCxyJDoCOcsyBkr0Sn2VEh+xkIGVw=;
        b=i9p1p7aCOeReuK2nYuCYmMAebysijU3MgeGT6728ApiCQaMMaM0/zlXvo+u+QqYwLd
         oF0wTGFRhRLb51/F7kX5zZg1aQbQ3ji4+kCYA/0yzIPEPLM+lH3/1lJ3lMKPyNBj5TP/
         mIpZzPYBKumLQWXW3sgw0xw31RpS/FE6dESJi+G47nFxsh0Z6PS0zhAP4Ww1/9LskkUZ
         mhs4THjSVDZXl7KrQweORHyqB1hUcVoZNSTRxTQ+r3bGq5SXuclxkNCGGd23ORo+KDY4
         meNGpQaURkDx0+hc64xEcoo551LfJCvZVK8/Uu/iS53xISLhWGVVCLfiocnXxPbX5QL5
         GyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7z6bEMhbWIxvIOeCxyJDoCOcsyBkr0Sn2VEh+xkIGVw=;
        b=tktX/qEfkB4mJ2HzABrYg59FPkT7yCc1CQB5poEoyS8vGZ2OLAphylOnPGf6uIWMnn
         cpQiRb/lg37qa7yr0l94dFd0R651UcOepm5S8NxtXSgG9YAk6hgVZ1NFH9197sTEBPdP
         BFk+ac1CENsU1Ms/EYvXzHxboJ9kvGollqsuwx3uLH9yqyyki/srkpRiZO491HnZoEZL
         vokvnpiFFsEIZ+6Zrr/ue9OTxM6lNgRckgt89DqJUgcRbI1iqb2fPulmDuWvUWgS6PqH
         S+D06uoojcScRER/AOLfE3CbJm00vRhQKhOK13B/DBHOjoKj+3P+RB6x5D7TZX7tcc3v
         D4Qg==
X-Gm-Message-State: AAQBX9ccBIlIVbtY7tU6WVt5ZElEJMGmakd4jE2QPJS6+BhNKkzdhWZ0
        vp4TC3wEBm68H0I+6gFyIf/bDQ==
X-Google-Smtp-Source: AKy350bHJcWTVkozgtzFLUMV0YXIfQUhd4CG2ILoWUjQeWNB1LXApF7dB0vsEoJIVV5/TuvBXj7UCQ==
X-Received: by 2002:a05:6a20:8edf:b0:da:c41e:4ddb with SMTP id m31-20020a056a208edf00b000dac41e4ddbmr112958pzk.7.1680632559217;
        Tue, 04 Apr 2023 11:22:39 -0700 (PDT)
Received: from localhost.localdomain ([106.51.184.50])
        by smtp.gmail.com with ESMTPSA id o12-20020a056a001bcc00b0062dcf5c01f9sm9018524pfw.36.2023.04.04.11.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:22:38 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-crypto@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Weili Qian <qianweili@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Marc Zyngier <maz@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Sunil V L <sunilvl@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>
Subject: [PATCH V4 16/23] clocksource/timer-riscv: Refactor riscv_timer_init_dt()
Date:   Tue,  4 Apr 2023 23:50:30 +0530
Message-Id: <20230404182037.863533-17-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404182037.863533-1-sunilvl@ventanamicro.com>
References: <20230404182037.863533-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Refactor the timer init function such that few things can be
shared by both DT and ACPI based platforms.

Co-developed-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 81 +++++++++++++++----------------
 1 file changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 5f0f10c7e222..cecc4662293b 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -124,61 +124,28 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __init riscv_timer_init_dt(struct device_node *n)
+static int __init riscv_timer_init_common(void)
 {
-	int cpuid, error;
-	unsigned long hartid;
-	struct device_node *child;
+	int error;
 	struct irq_domain *domain;
+	struct fwnode_handle *intc_fwnode = riscv_get_intc_hwnode();
 
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
-
-	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
-	if (child) {
-		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
-					"riscv,timer-cannot-wake-cpu");
-		of_node_put(child);
-	}
-
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
+		pr_err("Failed to find irq_domain for INTC node [%pfwP]\n",
+		       intc_fwnode);
 		return -ENODEV;
 	}
 
 	riscv_clock_event_irq = irq_create_mapping(domain, RV_IRQ_TIMER);
 	if (!riscv_clock_event_irq) {
-		pr_err("Failed to map timer interrupt for node [%pOF]\n", n);
+		pr_err("Failed to map timer interrupt for node [%pfwP]\n", intc_fwnode);
 		return -ENODEV;
 	}
 
-	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
-	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("RISCV timer registration failed [%d]\n", error);
 		return error;
 	}
 
@@ -207,4 +174,36 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	return error;
 }
 
+static int __init riscv_timer_init_dt(struct device_node *n)
+{
+	int cpuid, error;
+	unsigned long hartid;
+	struct device_node *child;
+
+	error = riscv_of_processor_hartid(n, &hartid);
+	if (error < 0) {
+		pr_warn("Invalid hartid for node [%pOF] error = [%lu]\n",
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
+	child = of_find_compatible_node(NULL, NULL, "riscv,timer");
+	if (child) {
+		riscv_timer_cannot_wake_cpu = of_property_read_bool(child,
+					"riscv,timer-cannot-wake-cpu");
+		of_node_put(child);
+	}
+
+	return riscv_timer_init_common();
+}
+
 TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
-- 
2.34.1

