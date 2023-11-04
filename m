Return-Path: <linux-acpi+bounces-1231-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C1A7E0F5E
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 13:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88976B209C6
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F81A58F
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQK4V99v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8002C144
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 10:59:24 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20FED51
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 03:59:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40838915cecso21651165e9.2
        for <linux-acpi@vger.kernel.org>; Sat, 04 Nov 2023 03:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095561; x=1699700361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNdrvAHCbO2wQsDLrmhD3VbPXqYqz7H1z5WaId9LHu4=;
        b=XQK4V99vpVnaHksog6UxkAX0UY2OQ8bnb8PvTdPTgbLx85ijDB/Vued/gx1X2Xr6vH
         x8W6s03BQ8PyjDT5ziZPrsxUZI5IViMin6verx7tSLcGRpMR30ghhlFR17YoD5w39KGy
         3nSKWXQT+HV5cVFgB6eUeyghaCYnWn8MVw1lEuKUHLHZRCRx8+vLWk8tW7Y1BKGboQiX
         ggfV3gDqdCE3Ae2BZXHcf/XSLW1n6OHzDDaix6rntleeYpcAxNgHrPM9qQXLjgE3uMgt
         googG+hyU4EmqROkYsmb0uHltLdPWF7O7mNdEz1SSEWPpSKoAl5ZMF7X036ked9g9Uct
         lXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095561; x=1699700361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNdrvAHCbO2wQsDLrmhD3VbPXqYqz7H1z5WaId9LHu4=;
        b=njoULVo2tvqrkE9EMbXdB9XrkEer72trVGUAR/E6f/Wu52+mCubR3ovfdtHdb+obsQ
         YQdDg5oFmVyV5paCHsGoGI687BX73TQlc6vjivAe0uzt3aUZoRzxxgikolmK0OXahCq+
         UyctkGmipAO9TI/LHRBxz5F3DPM8tjKsmcq+oPtVpX0OENJMMZztWWpLFsI0aWj2D5zI
         oive4SR9rCoAZoUEUJvNPVYbFSm8dTfuz5xCvy7lrVDyk4sQV9jhWalGgLpGBeIxL0S/
         /FWV94Eaa16IJgAQ3H8AAv/6hTv3PL8Rkt9/s5iXFNeduUebgI095kF47p46NDTauVUF
         Wvng==
X-Gm-Message-State: AOJu0Yy0PdvRcn+TIorZU+2pr6OJZYxdfB0kUE+fYoUasrFm1X7KeQeT
	Qqnc5IZ2xoeCyXd18pm6V2s2oA==
X-Google-Smtp-Source: AGHT+IFX16YhZelR5u+tsWZEytwlfNm9bcz/1jZWey4m+2AubxcFs07r1OkJ/I/fD8ISwKzggZU9oA==
X-Received: by 2002:a05:600c:19d1:b0:405:82c0:d9d9 with SMTP id u17-20020a05600c19d100b0040582c0d9d9mr21377359wmq.41.1699095561154;
        Sat, 04 Nov 2023 03:59:21 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:20 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	sudeep.holla@arm.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	viresh.kumar@linaro.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	lukasz.luba@arm.com,
	ionela.voinescu@arm.com,
	pierre.gondois@arm.com,
	beata.michalska@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 6/7] cpufreq/cppc: Set the frequency used for computing the capacity
Date: Sat,  4 Nov 2023 11:59:06 +0100
Message-Id: <20231104105907.1365392-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104105907.1365392-1-vincent.guittot@linaro.org>
References: <20231104105907.1365392-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Save the frequency associated to the performance that has been used when
initializing the capacity of CPUs.
Also, cppc cpufreq driver can register an artificial energy model. In such
case, it needs the frequency for this compute capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/arch_topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e8d1cdf1f761..0a2e43728286 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 void topology_init_cpu_capacity_cppc(void)
 {
+	u64 capacity, capacity_scale = 0;
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
@@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
 		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
 		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
 			raw_capacity[cpu] = perf_caps.highest_perf;
+			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
+
+			per_cpu(capacity_freq_ref, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
+
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
 		goto exit;
 	}
 
-	topology_normalize_cpu_scale();
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, topology_get_cpu_scale(cpu));
+	}
+
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
-- 
2.34.1


