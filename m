Return-Path: <linux-acpi+bounces-241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6497B0C06
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 52B4D281579
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3521A589
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:33:29 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B20420B15
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 17:00:46 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F39126
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:44 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b8cebf57dso4880520eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695834043; x=1696438843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pG1tzQTVssTuSgiTai6pnkMjirZbD31EyyHGMhy1at0=;
        b=oz8YwNkXzxa/AUErObOaWGyGXiDiswFNYN7Fwl9q0a7MfldAH9jO+WT96ROcPmvn6s
         efXi40i9PnfRhzmjv3P/q53voqkGwj+o6qgCBEPIAs3eLFrfz+XqrTvsPaD+mHQ36iBz
         8LTMRVWs6xbi3s0No1yJlJPhR9ORfDZ4G9TMoiolkqMiXZeigkdZrukz+XYkuTqAjklt
         /po9aampApisNVfsIqu9r84988GEy4GFbvrHzsJDce+9SBMTn1/zV+Y5kUL8S0RW6W0H
         8iWUfhYS/8xrrAwLv3kJMQFA7vx6PgQzBn9w6NkcWZdjTBM9erO0utKDmns/pBWZMnzd
         gchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695834043; x=1696438843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG1tzQTVssTuSgiTai6pnkMjirZbD31EyyHGMhy1at0=;
        b=KagstFTIczMDgIcGxxH5mc1bhcNldDWDCjLkZ2L84p9S51oYoBngTBWRR6L0eea7Id
         GRBUdS7OiThf+F0skaH4huNNiay2tN4ztQk5ivqItXuI6uebjFncjV/7/NDExCsqSjLl
         /oIZPqlNYcH7X6KTeyB72MfGvLgp7UUpm6sjUqOEtGuXNbD+6hYnmvErlVeUpaf6omzE
         jOXXCPqNKba6WYIpp9J6shPrLSk0blGenf8RYDI0+AprUGMylxbh1Texb7uNXTHX79CG
         TMSfbUBV+vGdVpEi8sqyowmiqaFcNvdU8ALsRO/vDFJhS7K/i5aERTwFSBF33n50ob4i
         PyQw==
X-Gm-Message-State: AOJu0YxsmCJ/JIVY5/Ac7MZc8r8Kmv0e6+uFDS8FV77Es9+XlUYaFHg9
	oAtveRXRznwnn2S5pwKiN032dg==
X-Google-Smtp-Source: AGHT+IH2up4xMxljyN4RO8Rex07vnVaVsd5wurJeyXI53/ysue+JrRu8yCN5i5l+jkbhAsdY+6qfwg==
X-Received: by 2002:a05:6358:7e84:b0:135:47e8:76e2 with SMTP id o4-20020a0563587e8400b0013547e876e2mr2445601rwn.4.1695834043334;
        Wed, 27 Sep 2023 10:00:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.190.42])
        by smtp.gmail.com with ESMTPSA id u7-20020a637907000000b00584b293d157sm3279396pgc.80.2023.09.27.10.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:00:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v2 -next 4/4] clocksource/timer-riscv: ACPI: Add timer_cannot_wakeup_cpu
Date: Wed, 27 Sep 2023 22:30:15 +0530
Message-Id: <20230927170015.295232-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927170015.295232-1-sunilvl@ventanamicro.com>
References: <20230927170015.295232-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The timer capability to wakeup the cpu irrespective of its idle state is
provided by the flag in RHCT. Update the timer code to set this flag.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/clocksource/timer-riscv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 9c8f3e2decc2..06f5bad3c3e0 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -225,6 +225,10 @@ TIMER_OF_DECLARE(riscv_timer, "riscv", riscv_timer_init_dt);
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


