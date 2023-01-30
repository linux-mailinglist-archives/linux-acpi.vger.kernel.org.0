Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A126818CE
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238107AbjA3SYC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbjA3SXp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:23:45 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A40BB87
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id r8so5685654pls.2
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucIkerkqr4QmI5UkdMXW8uEBrl0PvtR2G4Rv/JZMzew=;
        b=GhrwpBT3N31+nOt/CtgKmnAGMi653hgs/75GWs74Cqht6JG/AUohZ9ARL3pkvdkfmj
         GGOZc26wqFHqO7mxkcg3Ji/bn0HnDTjs+diwm80n7Jus44aORApx5bQiKn82JGyfTCYv
         hLqZbyZnw2mPfz9cuau3/Zw6fHKe0n82KCiDP07hBTERsyddqX5tlDZsMxgaTW1bTNpo
         KxuF/f6QYreKfafdgIWZX2SL50FtFfyns379QlTz0qZo60LNmMpt4E2ApfVNvqyuC5TA
         bTk7rP8MGgWtYVewzHcJEdMTwddvaOYKbkRdF7nMfjQRFzmhTRP94xlgUWzIEO/hT95a
         UI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ucIkerkqr4QmI5UkdMXW8uEBrl0PvtR2G4Rv/JZMzew=;
        b=kavRkmIZrwJUEylf82yyUMizCCqZNDk8IC84ozZitlxFHUN9juJMtM8UUrzvgtxHci
         qq/eV5cKDzTev53WMnb/dMQSlUH9vphTje2Vgh/pavCnQ0M7l7Te+YpC0FWuXlcys0uZ
         kge28ELAVmzAIvg3bi0/pZKNRC6ADttP8UByif3ZDzx4YLPeEIpB61hR3Pfz2uKzChgo
         UM8VMMLcQ780USKBDZNSKiwoCgpPMcG+J0wBURGMC/ixVaprL1T+HWCFC3U9hf2eYJFl
         a0ZeaQgQ+9iHKyIYktZJVM+lcnb7iq8Xey8p1tFFxdm8QIFcB2P2IH47sv0peUMdqtQy
         urow==
X-Gm-Message-State: AFqh2krQh/f3mSPldxEegvvW0KZiceY36sWsbdNxQugVF4kI0PxSlrMy
        wC+vnJLlLjp8FfiKQ4512w7Gbw==
X-Google-Smtp-Source: AMrXdXuB44m0KVUm0j9aNOAU3dJJ68bswZ8ULTfSewfLquMpMN9Q/ZK2SmPbqXYnMOJ4+lGGcK7FKA==
X-Received: by 2002:a17:90b:348e:b0:229:5cab:67a8 with SMTP id kd14-20020a17090b348e00b002295cab67a8mr52332355pjb.24.1675102986650;
        Mon, 30 Jan 2023 10:23:06 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:05 -0800 (PST)
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
Subject: [PATCH 07/24] RISC-V: ACPI: Enable ACPI build infrastructure
Date:   Mon, 30 Jan 2023 23:52:08 +0530
Message-Id: <20230130182225.2471414-8-sunilvl@ventanamicro.com>
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

Enable build infrastructure to add ACPI support for
RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d153e1cd890b..f664350679bc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,9 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
@@ -598,6 +601,7 @@ config EFI_STUB
 config EFI
 	bool "UEFI runtime support"
 	depends on OF && !XIP_KERNEL
+	select ARCH_SUPPORTS_ACPI if 64BIT
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
@@ -703,3 +707,4 @@ source "drivers/cpufreq/Kconfig"
 endmenu # "CPU Power Management"
 
 source "arch/riscv/kvm/Kconfig"
+source "drivers/acpi/Kconfig"
-- 
2.38.0

