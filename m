Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9E16FAF49
	for <lists+linux-acpi@lfdr.de>; Mon,  8 May 2023 13:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbjEHL4E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 May 2023 07:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjEHLzG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 May 2023 07:55:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D4429E4
        for <linux-acpi@vger.kernel.org>; Mon,  8 May 2023 04:54:19 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ab1ce53ca6so31169195ad.0
        for <linux-acpi@vger.kernel.org>; Mon, 08 May 2023 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1683546858; x=1686138858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNB5noEZPasx/OngqcP7wy15OXtx85aYSDWecQ1qX3I=;
        b=bdUOpEXd7GBDCNnXUsvG3ckYwryUiZjYQOSav9QR4GUG/8ayaYYTDJbjXmtRT0zXHg
         +eV9YbxhRW91B0jQB9sWuZdtdciKI6upjJ8I4udwA4rx3uxaZH3/cHQQIYX/BwmUfzpq
         NsqTsFR3sE7Sw5k7La5uhu2K1GfIJvVKlyUsE9CInG6jxddpYqF2680jb/sf33vgVttu
         fcjUSpTZANBOqnqT1fW/y+mY7OP8uyDjndoX8ITOfZTo5j6GWdLzl5yLKDZo9yepSUTZ
         j7MCN0w4HtF1A7pQPYPkQoqB1NHg8jHylF85r+oebUh2luVMl3g79mLXG0a54WpOSPgX
         TqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683546858; x=1686138858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNB5noEZPasx/OngqcP7wy15OXtx85aYSDWecQ1qX3I=;
        b=Q6lwFFMQ/uPidwmU8NTySa9lTrh1Fe0Xxd7VcuOzu4FjVrFzZ7TWqnN96xxTVJK+dh
         uy9Un6V0vy30DvlVToraFMTTtZpGpeH80GlUVC2A1kGpHVWKFzqNnHjH8oKFLrxuHfDF
         5AOXXgbBAYPabKg3RrQtsU5vmMH77G+O3AYoNtwW6cfGIfojAF4rC+EwpQHUeL5F2d8r
         BEc7EzP7Uyb0CiNNpXyCSJiGwyPGoXJkXWKKtbEOjq1NDRyIjcX6BxxXSD+xaoDA7TQN
         DC2mu2iiTwy4oCEYGJo9eGUifx9hCBrLjc2KxZfnK8s/9uoZGV+VKPmVAYhWs1DRdU73
         zmVA==
X-Gm-Message-State: AC+VfDwRvCQdAKX1x4QnNulnMusvkH6RjZ+yY2UOGySEm1eENZj/G6kx
        QAsZ9I1XgqOonRhNmSR1U/F14A==
X-Google-Smtp-Source: ACHHUZ5TYA+zQ+rNZLCdLbZt13LOcV1erZfJUbyqxcsnGU9IG5qaZ/PIek5MVqznsb13nf9WEs/MHw==
X-Received: by 2002:a17:902:c40b:b0:1aa:fd48:f5e2 with SMTP id k11-20020a170902c40b00b001aafd48f5e2mr13594721plk.32.1683546858666;
        Mon, 08 May 2023 04:54:18 -0700 (PDT)
Received: from sunil-laptop.. ([106.51.189.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902904900b001aaed524541sm7015149plz.227.2023.05.08.04.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 04:54:18 -0700 (PDT)
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
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH V5 10/21] RISC-V: smpboot: Create wrapper setup_smp()
Date:   Mon,  8 May 2023 17:22:26 +0530
Message-Id: <20230508115237.216337-11-sunilvl@ventanamicro.com>
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

setup_smp() currently assumes DT-based platforms. To enable ACPI,
first make this a wrapper function and move existing code to
a separate DT-specific function.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 445a4efee267..a2e66126b733 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -70,7 +70,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 	}
 }
 
-void __init setup_smp(void)
+static void __init of_parse_and_init_cpus(void)
 {
 	struct device_node *dn;
 	unsigned long hart;
@@ -116,6 +116,11 @@ void __init setup_smp(void)
 	}
 }
 
+void __init setup_smp(void)
+{
+	of_parse_and_init_cpus();
+}
+
 static int start_secondary_cpu(int cpu, struct task_struct *tidle)
 {
 	if (cpu_ops[cpu]->cpu_start)
-- 
2.34.1

