Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182706818D1
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbjA3SYC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbjA3SXq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:23:46 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870D33FF1C
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id b10so11891067pjo.1
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPNO/SxCaad+QHrUHg1W5XYbXIP+iBGVf1xglNrkc7w=;
        b=WAt9qxmLcMCzx3x9infWfLlyTRY7lQwbLQgH+mqXQo8DaInODomPFYDru14it+/rwL
         FKOjU3kGSGvjRCJYGNq2J3I07ZEnZ2Bph7Cb19sB1kEq1iHguj5rtG6WsoXH3ZD7TYZN
         Ls5e3cWuM0m3oJ0jAOuLWK/MdCpxiTs0N/t0Izo9LfJy+vGfhYn87Vrttba7ZDWMziE/
         A08N/tccmOYsLazLRWGMy8dyvGbcOWNX9dDkplIHbZ2N65daS8oRYxkaa404MTl8Exiw
         wpa6wUWNjRjFB4qsp0OXBmuBLPbZxKyUhU+EuhlYJBnfoixeacW/CA9qkRNTfKQxDHfo
         1lpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tPNO/SxCaad+QHrUHg1W5XYbXIP+iBGVf1xglNrkc7w=;
        b=ToK0UZUpSPPeISVgKjHEu7o8wgBESfiHKxw1XsHNPPMZWfKVM4cCQ90La4BjKD1v30
         A0xF9mxbI7VtKzJHCzk9qZgjDuF51JhxaBOtlu/UDXFG1f7jCXr4GF+I/iQkjAfgURXY
         ++QxRvbdCdJVgCkhpFce0psK3Xf3ZJESbWMJmGz5H35CWIBifgUAVl/7GlPK1jRdrjE9
         EgMoXxuRN3HqRaHqE75YWxoFqDfL/cVIPQX6Vj2Bh4bq8jGuUt9WmW/MFZQimjeMMUa4
         830bmJ0lemjFcu1djLaoPUiicwlSrerDjPqzcckNr9rRL9pvRKitZXYA0cwXPpjIg8fl
         887A==
X-Gm-Message-State: AO0yUKWezYp9KBupqqcX74S8j4uf1TLdHUyq0ArhzMBYgZjAlr1hvZZ2
        Af259S/BX4RVrS71hua3zCb/7w==
X-Google-Smtp-Source: AK7set+8WSMVCSxjvJ7pcIybsaePEVFCKPT/8u2wMLIFDS/YpCiIenEFMsDbeymxOLvTs+dp4pi/rw==
X-Received: by 2002:a17:90b:20a:b0:22c:147d:137f with SMTP id fy10-20020a17090b020a00b0022c147d137fmr20585364pjb.17.1675102991516;
        Mon, 30 Jan 2023 10:23:11 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:10 -0800 (PST)
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
Subject: [PATCH 08/24] ACPI: Enable ACPI_PROCESSOR for RISC-V
Date:   Mon, 30 Jan 2023 23:52:09 +0530
Message-Id: <20230130182225.2471414-9-sunilvl@ventanamicro.com>
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

The ACPI processor driver is not currently enabled for RISC-V.
Enable it

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ccbeab9500ec..b44ac8e55b54 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -281,7 +281,7 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || IA64 || ARM64 || LOONGARCH
+	depends on X86 || IA64 || ARM64 || LOONGARCH || RISCV
 	select ACPI_PROCESSOR_IDLE
 	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
 	select THERMAL
-- 
2.38.0

