Return-Path: <linux-acpi+bounces-1383-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E907E685C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22C51B20AC2
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427D199A3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBsWdZ++"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C5316426
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:15:00 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA330E5
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:14:59 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4083f613272so4798535e9.1
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524897; x=1700129697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRZuGgttIdjMzTtOY1KLieaDHjYgH97fC7jzr+fvVqo=;
        b=gBsWdZ++s0+LbDVr6pkTEDUcxoNovypRYVpvgDcsB2PaAFhT4bGmgI866JjQnZbZqL
         kXIdaKl1KymtebNa3pakFi5d5BDfcB0BW4wtCL8C+6wkV1VbKgNWhbhbQYaI+F2zEKoi
         FNuODtaNQ9p9sLxo1EhL/UdusZfedmzToInJ9JDcq8c87vRtd3mmilrQFB7U5Yg3ltjF
         xWF6NhOopvSjKhiVV4GzU3bMHctjkZe1xabLr6duAJUj8Ch05mz3gBT+dcL8uWJ4MK8W
         /5eHFmXq7GWJ1Q/8UtmT1HBQ4s7x6QqkfS0VQoRXjfcdtp5n7trE55apN+XJvRtPLlfm
         6Zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524897; x=1700129697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRZuGgttIdjMzTtOY1KLieaDHjYgH97fC7jzr+fvVqo=;
        b=Awu86PSYq522pngDsK0AX1zNVckVOZtwQ4Ct+CkdwPu2GGPEnhvmPPwqSYGdjJk6Pd
         bzhCEaMnxl6SLowWhlVDLOohYbRdTTntHUVNUHTUVwRpvsybDYedOkd/fqZYdmmY/r6P
         Q1ocQlrzxBja3EFMZBnsoiLu25ts74qgi8eW9PTKd4EPhnpfO5lSVQiXrD5O43Lqmwrh
         NnPQc1/qbGNDBdLJ+9UQ5f80jBzn0x/Zs48EDWM8fgLY7vOA71fuB0H3Jb9mYhaltLkS
         BhIm5JX/BF7SN4skIKkqXVOkJ4pKq7da18Hup6aDJNgG707Id2kh55qY97kIEaFv3oJy
         MybQ==
X-Gm-Message-State: AOJu0Yw6q2R0lIjFYMoo0p3gnNHjzRoZyxZBqtHi2P2c5lh6wlsRGQwU
	OxOb+EY0pnAhpHWGYLFDZRzj8g==
X-Google-Smtp-Source: AGHT+IFErHhK3dv93vXA3skdZjBc12KSv8yFV05cQNNZGn5wIgqPMa1zCHFgcuaqbLUWzLMBHHtZSA==
X-Received: by 2002:a05:600c:138b:b0:407:5b7c:2f6a with SMTP id u11-20020a05600c138b00b004075b7c2f6amr3739930wmf.0.1699524897543;
        Thu, 09 Nov 2023 02:14:57 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:57 -0800 (PST)
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
Subject: [PATCH v6 6/7] cpufreq/cppc: Set the frequency used for computing the capacity
Date: Thu,  9 Nov 2023 11:14:37 +0100
Message-Id: <20231109101438.1139696-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231109101438.1139696-1-vincent.guittot@linaro.org>
References: <20231109101438.1139696-1-vincent.guittot@linaro.org>
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
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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


