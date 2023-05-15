Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8343D70237F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 May 2023 07:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjEOFtz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 May 2023 01:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjEOFtq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 May 2023 01:49:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FBC213A
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2023 22:49:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5208be24dcbso8783641a12.1
        for <linux-acpi@vger.kernel.org>; Sun, 14 May 2023 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1684129784; x=1686721784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfepdXJdsq6ohX2AkAAGDRO8NQz+5w0XQmMbJfl5w48=;
        b=FF8l4h5Fv5CwOz55cyPlj8vNJJWDVMCkL9k6YPzgVyjIgqTq/5qVdZ+c4hVx+DU5zG
         7FfFBlhKYQ/qpU6PI+9MV2mxM9OMWh7pkrzjZFF7VozIKpoMEFsyNAUuhUgqygzA6ppl
         F9A9otVKxhESo1/uy9WyOYILhBG3Cgt6hE555xQafhrdCOiVWGhJ7Sbidox20cyLS3Zq
         LAQ6ahssk9FCrTXi/bK2hki2RPlJbPq3hy7OLkle8O1qIfmMB+/vAzltSc0mp9ptjvTX
         GpO78EjhUJCv3I33Cvf3aQcgYKCxTBrJfbhM4ZVlLyT5MW7sa1n0NG0KW4x3q0DBBFf1
         /d7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684129784; x=1686721784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfepdXJdsq6ohX2AkAAGDRO8NQz+5w0XQmMbJfl5w48=;
        b=J1wf3QC70nMsLMENVowhwLlbDiX/jRJVugl4rtytg6M2sgCBunm21JqYvPLSNXrKKS
         nteF057i7pwXDRVXAavwwFw4AKATPs4XfGoOsjXZ3tLDYDu7CvET8BKszJ4kv/o7lTCD
         8C3upt2jUEQ5eziL08u/3ZlhB9sHoHxoqqC8wKpyXT7iDOpNWi9SUcZb0SxaIyzRyS1b
         u3f2Lww5ThfIx92nOt10k06TZdDDkCKw4WnCa2HQCfbCSIdqZEuvV0VTAxsxGWNos+7Y
         UqHI/u+SkFFWxwXf5jj8JwRVALcgSc9uZ/bMMIp2dw94u3KK8ZJXNg9vr4sbYpAJMsBK
         nAFg==
X-Gm-Message-State: AC+VfDx58wE4KFiSTfu5MEX9dU0TOuE27Zk2Z27PiZ/dUsYAwgnqUZZ8
        u6XqtOa131ILgbSd4jHCJiQU3Q==
X-Google-Smtp-Source: ACHHUZ60Bn8aXfOJxmjZ+b6wNx+tjPWbD4NXCzp9i69pk0qeKeo90gXjsK0vstRnw9C/Wioy6rg0Yw==
X-Received: by 2002:a17:903:2448:b0:1ac:63b6:f1ca with SMTP id l8-20020a170903244800b001ac63b6f1camr36172090pls.0.1684129784583;
        Sun, 14 May 2023 22:49:44 -0700 (PDT)
Received: from localhost.localdomain ([106.51.191.118])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001ab28f620d0sm12423277plt.290.2023.05.14.22.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 May 2023 22:49:44 -0700 (PDT)
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
        Sunil V L <sunilvl@ventanamicro.com>,
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
        Tom Rix <trix@redhat.com>, Jisheng Zhang <jszhang@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH V6 01/21] riscv: move sbi_init() earlier before jump_label_init()
Date:   Mon, 15 May 2023 11:19:08 +0530
Message-Id: <20230515054928.2079268-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
References: <20230515054928.2079268-1-sunilvl@ventanamicro.com>
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

From: Jisheng Zhang <jszhang@kernel.org>

We call jump_label_init() in setup_arch() is to use static key
mechanism earlier, but riscv jump label relies on the sbi functions,
If we enable static key before sbi_init(), the code path looks like:
  static_branch_enable()
    ..
      arch_jump_label_transform()
        patch_text_nosync()
          flush_icache_range()
            flush_icache_all()
              sbi_remote_fence_i() for CONFIG_RISCV_SBI case
                __sbi_rfence()

Since sbi isn't initialized, so NULL deference! Here is a typical
panic log:

[    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    0.000000] Oops [#1]
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #79
[    0.000000] Hardware name: riscv-virtio,qemu (DT)
[    0.000000] epc : 0x0
[    0.000000]  ra : sbi_remote_fence_i+0x1e/0x26
[    0.000000] epc : 0000000000000000 ra : ffffffff80005826 sp : ffffffff80c03d50
[    0.000000]  gp : ffffffff80ca6178 tp : ffffffff80c0ad80 t0 : 6200000000000000
[    0.000000]  t1 : 0000000000000000 t2 : 62203a6b746e6972 s0 : ffffffff80c03d60
[    0.000000]  s1 : ffffffff80001af6 a0 : 0000000000000000 a1 : 0000000000000000
[    0.000000]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[    0.000000]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000000080200
[    0.000000]  s2 : ffffffff808b3e48 s3 : ffffffff808bf698 s4 : ffffffff80cb2818
[    0.000000]  s5 : 0000000000000001 s6 : ffffffff80c9c345 s7 : ffffffff80895aa0
[    0.000000]  s8 : 0000000000000001 s9 : 000000000000007f s10: 0000000000000000
[    0.000000]  s11: 0000000000000000 t3 : ffffffff80824d08 t4 : 0000000000000022
[    0.000000]  t5 : 000000000000003d t6 : 0000000000000000
[    0.000000] status: 0000000000000100 badaddr: 0000000000000000 cause: 000000000000000c
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

Fix this issue by moving sbi_init() earlier before jump_label_init()

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 36b026057503..9fb839074e16 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -270,6 +270,7 @@ void __init setup_arch(char **cmdline_p)
 	*cmdline_p = boot_command_line;
 
 	early_ioremap_setup();
+	sbi_init();
 	jump_label_init();
 	parse_early_param();
 
@@ -283,7 +284,6 @@ void __init setup_arch(char **cmdline_p)
 	misc_mem_init();
 
 	init_resources();
-	sbi_init();
 
 #ifdef CONFIG_KASAN
 	kasan_init();
-- 
2.34.1

