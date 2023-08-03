Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F6C76F130
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Aug 2023 20:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjHCSCV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Aug 2023 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHCSBx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2023 14:01:53 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AB249E3
        for <linux-acpi@vger.kernel.org>; Thu,  3 Aug 2023 11:01:03 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so914378b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Aug 2023 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1691085648; x=1691690448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwCzqc1PMCRcx2h1vYzs9FDmhl8QjorV5J8xX30vpfA=;
        b=lGptm+1FaVB2szu9+1FrX5AfEizhjltUyo0aBH0MmslTFeM8tX/ihvgQP5IVG7Tg7A
         TBFasNuPmX1HxnupljC5J7LAW031DE7hpjg43EwE0xDPU/lp/UPU+kc+wx4Dk9R1qb5t
         7jDVmYJE9VCa4riLTon3hZNN5NOLOY08WqDcPqdaOX8wu39mZPD6VF0osJ32v9gvrbfY
         XACNR92dJTW4PA3wpYNW/UJoNaiuDBuB6RIXDK48vy2YclaDlPWCQiIFi0kIXCFjOqjQ
         6Ca8u30WmNCuPrp25cbilzk20B3sOHrjBX7H62pImD4I+4KWuK1qabDwfjQuxSkrh1iP
         XS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085648; x=1691690448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwCzqc1PMCRcx2h1vYzs9FDmhl8QjorV5J8xX30vpfA=;
        b=fOuJzwY3uGvwBZavClfZIw1KBpKFvxx/YSK1Fr2Ws4YtrxOazwn9+stY5IgmilS9m1
         uyLwWzes7JYPDZHLDVEhiDU04PrT5JITqw4NTNir5c4zLxpo2DtRuXUbsN6+/s/Nq9x/
         oqG4rqBCFOkEHgN5/dHDF7tRqYhvLC32u+AUQkMRqGkxBNFkuQqWiFxajJ668JIFhNJ4
         TjgNrxRxPR5zot0C/l3+AvB5+/evmbhMsZiPY4fzz5wzWBk7DiM/rKnjI37lvQV6xLTC
         X4zEY9NhCIpcOQ98/pw4X8yRzg/KIOl6VYBZIwxSJoOj2wF1oEUxoHerboJqOFvsX+po
         mPHg==
X-Gm-Message-State: ABy/qLavQ/GlFwg1g40oPEtYD+WxdQF4jG7ZR7XvQSFnB9NtZCu2H7fy
        ZD8NfXvKWPXB/HA4mMfL4/M4VA==
X-Google-Smtp-Source: APBJJlEZPAolOiWsswMUNb/3O27FzwqkU7VHoLeXdU05Nm8+s6t/U8LeZFnf7BD1irhpUyClA9ox0w==
X-Received: by 2002:a05:6a00:14d1:b0:63d:260d:f9dd with SMTP id w17-20020a056a0014d100b0063d260df9ddmr21845288pfu.33.1691085648649;
        Thu, 03 Aug 2023 11:00:48 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.143])
        by smtp.gmail.com with ESMTPSA id s8-20020aa78d48000000b0065a1b05193asm134952pfe.185.2023.08.03.11.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:00:48 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Haibo Xu <haibo1.xu@intel.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v1 10/21] clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu
Date:   Thu,  3 Aug 2023 23:29:05 +0530
Message-Id: <20230803175916.3174453-11-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
References: <20230803175916.3174453-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The timer capability to wakeup the cpu irrespective of its
idle state is provided by the flag in RHCT. Update the timer
code to set this flag.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index da3071b387eb..50198657230e 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -212,6 +212,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
 #ifdef CONFIG_ACPI
 static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
 {
+	struct acpi_table_rhct *rhct = (struct acpi_table_rhct *)table;
+
+	riscv_timer_cannot_wake_cpu = rhct->flags & ACPI_RHCT_TIMER_CANNOT_WAKEUP_CPU;
+
 	return riscv_timer_init_common();
 }
 
-- 
2.39.2

