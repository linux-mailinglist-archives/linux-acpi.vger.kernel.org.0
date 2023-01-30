Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97EC36818E7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Jan 2023 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237982AbjA3SZQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Jan 2023 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238216AbjA3SYw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Jan 2023 13:24:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C14616D
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so11990324pjl.0
        for <linux-acpi@vger.kernel.org>; Mon, 30 Jan 2023 10:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cCnuU35jZVdGCs4yph98OuVncVWSdeJqbA2ZAZB9Sg=;
        b=NVtPhRYVJSJbR/Cn4eg5T9W8xFMyMV7bk4qOp93b6jBCozBeskRQIZ+EA9Z1qfBD9j
         E1Sd1jPsX8pG7hOnlx6mIsqgKxStk6YpAQcNjkgsOFtvhEZSA8JE9p8vBxv6rbLiQkV1
         Whf1k/35Fovb7D3gyWhiSxoyXLHY0vPKsJI+5P8rjVD6Dg7KTUu/cGAtD74EGAWRsWzV
         rlnZitm/zmG3r4ZBslpFcNOnpb3QnyJeq/86JXJhcLrbn9ElxHwIWy0mJDeRMLn20Toy
         Hs80lxP5/A0rw3/QNj9Xqoegzn7mciAe5fzStukCmQpvpk7Ruh0qJh+GbNRkJPovzpHF
         05Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cCnuU35jZVdGCs4yph98OuVncVWSdeJqbA2ZAZB9Sg=;
        b=4onE9aILiAP8G/tMjD7uXxTSuUQNuzwkjpoc9HlcRemaAuW2pYNjeFwGn6IUNJar6u
         +RIsQfCjRMeR2PwCI7fkp13BqXMTAsABhHMqIlaSWccAz1r+FW+N0elL0bKaseCx/IB8
         cQ3XdvEZzXsCLScp+XFGoccHpOxZApADPe2wRIJVgUgetR18W8wxG7v3rW0yWHC9IeDj
         xySr+dIJt9RPOWUa+Pr82nYkHZ0vnkt+aQ7Gb0iQFoH/FZZM+rA+HXKyInAXgkV2FDye
         BqmruydCs7/FuguAhplWzmmqK8cAqGcixtaD/7MxmDGkV5SNgOMhtiQuthixIjCOkIUS
         6ykA==
X-Gm-Message-State: AO0yUKUNd7Lbb/cTFUOe28e+Z+aBeQmwTMEH9r2/8cvEA/L+s/vkysGS
        pCdkMAAwSxnaWaxNmyn0XVegMw==
X-Google-Smtp-Source: AK7set/sHqOwf+i227vA8zak7mnLlMCBogBTamE5mkGyExKgvQi0skSSDX6wAhSKthnfxNl70LtsQw==
X-Received: by 2002:a05:6a20:4282:b0:be:a189:1475 with SMTP id o2-20020a056a20428200b000bea1891475mr3044724pzj.47.1675103026826;
        Mon, 30 Jan 2023 10:23:46 -0800 (PST)
Received: from kerodipc.Dlink ([49.206.9.96])
        by smtp.gmail.com with ESMTPSA id j193-20020a638bca000000b00478162d9923sm7000291pge.13.2023.01.30.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:23:46 -0800 (PST)
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
Subject: [PATCH 16/24] RISC-V: ACPI: clocksource/timer-riscv: Add ACPI support
Date:   Mon, 30 Jan 2023 23:52:17 +0530
Message-Id: <20230130182225.2471414-17-sunilvl@ventanamicro.com>
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

timer-riscv driver needs to get the timebase-frequency from
RISC-V Hart Capabilities Table (RHCT) on ACPI platforms. Add
support to read the information from RHCT.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 4016c065a01c..8079666753a6 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -10,6 +10,7 @@
 
 #define pr_fmt(fmt) "riscv-timer: " fmt
 
+#include <linux/acpi.h>
 #include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
@@ -198,3 +199,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 }
 
 TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
+
+#ifdef CONFIG_ACPI
+static int __init riscv_timer_acpi_init(struct acpi_table_header *table)
+{
+	return riscv_timer_init_common();
+}
+TIMER_ACPI_DECLARE(aclint_mtimer, ACPI_SIG_RHCT, riscv_timer_acpi_init);
+#endif
-- 
2.38.0

