Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C57699C15
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Feb 2023 19:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBPSVo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Feb 2023 13:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjBPSVm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Feb 2023 13:21:42 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708E75775D
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:17 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id b5so2935331plz.5
        for <linux-acpi@vger.kernel.org>; Thu, 16 Feb 2023 10:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRX9Rh9lefADAfWYEbY0yIAAiynI9MZaTYH+yetjREM=;
        b=IaeR6uCOYqxkxcPO2OyZK+7eC6B5XWUpETzkV429cXcAgdslHLazNahirlmg6GJ8nt
         ZxrE9y/gCeS9R3rDQdwL6ajjbBDd26jf7ah+E/ozJpUScU2Hs+caXXwpejxxCR18bBU5
         QNKpQffB0OL67KNEN3pFW1lBC/gH9rY9bKHvtpm6/Plg4D4UklunHYOF9ee3xh/FJ8fg
         YWtE0U1o4BV11Ioa48QOdk/Y5DLLCGTR9ZcNpwCOm0D6MtRbodmOEuxChDMNlSDPHFN5
         VLFqJLp/kX3fdGCWO4vPoek08/oItOINvIreIDT7iodgxsdmmImQdjNXsthZ5FVMYJ15
         EWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IRX9Rh9lefADAfWYEbY0yIAAiynI9MZaTYH+yetjREM=;
        b=boOLrAv/iy17ZdjICcupB51MoSmyRdki2gompKO6eENIYAahcTWYpD1Y8hGYHGB9WX
         +gRSIHQ3i3DyHov7r/SZA3oKb7nBqWcvt7tcc/VauvWkOkANX8RgY7Fn1+fUz6kHu5vX
         XJ6mz7myrUxtRKphNXnmy6OwHQRp7me0NsncJaw93GHtET+28jVADrmsa+cn+CCSwBFi
         QaaTkkVPuvFIaM2J92RRSNCJYylkMHxyDz7a4nFFDYnYsAr/FKj+DJOlq6Db8qled57e
         Hb+xWS0TqEhjo9SGps8vNqhVkLhWA8TapImYgiA/hS9NsU0Sl7niaWgq4p14QKD0TZpN
         TI7g==
X-Gm-Message-State: AO0yUKViiIycgnUzrMNgE7PVGG/Qo93r2mN8umFg9U0SCPD8LFPHZwLa
        pYINbRy8vXkuUXo80WCw48BWng==
X-Google-Smtp-Source: AK7set8xLrx+1PXJVXcHl9Dg9zSUmVDJVoqpG5XSTjL+yDDVADutOhkLtType5mYRLOojwQIa6F3zw==
X-Received: by 2002:a05:6a20:3d0c:b0:bc:61d5:7bf2 with SMTP id y12-20020a056a203d0c00b000bc61d57bf2mr7783217pzi.34.1676571676972;
        Thu, 16 Feb 2023 10:21:16 -0800 (PST)
Received: from kerodi.Dlink ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id n21-20020a637215000000b004dff15fc121sm1517574pgc.36.2023.02.16.10.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 10:21:16 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH V2 05/21] ACPI: Kconfig: Enable ACPI_PROCESSOR for RISC-V
Date:   Thu, 16 Feb 2023 23:50:27 +0530
Message-Id: <20230216182043.1946553-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
References: <20230216182043.1946553-1-sunilvl@ventanamicro.com>
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

Enable the ACPI processor driver for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
2.34.1

