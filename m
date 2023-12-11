Return-Path: <linux-acpi+bounces-2269-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBBC80C727
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 11:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79348B20FF7
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 10:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0022534571;
	Mon, 11 Dec 2023 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y2IvZdIb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7AD7
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:10 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-33621d443a7so753240f8f.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291749; x=1702896549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+sZ8kiVgSDpOUyXf2RtOeDFCi7Cs5gC6EpwhZGADvk4=;
        b=Y2IvZdIbPiBXZkxWwgot6ShumU3ahVviMxZcQ/sLAiMQLoYl1vE/rnmINhFD2WeI+T
         fuIVQhU2jyiVqg+59Bk7OPq8IE6WBqttxv+GF2yA6xdtkJ4r5gUPKCVvob4afXR2rcjw
         pb1cIt4DDZ/rkvDxr55vxzYBLjum/74UXETMn+PxQzCWtyvQ/qN9HUDC7uMRPktCjR9r
         otf7jXoORwCfsV7F8Uvoy/EiK3eXpp/aE4jdOtARA+ovCrG1ddSX6n3wI7B8yb+Toptp
         yVh+obXn7zXXsOupyNKj2TU+YClImb4hGkHOdH6l8qEFNCuqSqXjzqLWEUmER43uziUb
         nYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291749; x=1702896549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+sZ8kiVgSDpOUyXf2RtOeDFCi7Cs5gC6EpwhZGADvk4=;
        b=N2Lz2BKXDKArDq3HZIUvo+nULSOHkurg7nYDjFZlNofdqrHbdjgcZe+50kmATYO5FZ
         pPv6AY11w2xw+PX7/nysZR4URYgVze7B1EBhRFJ/TJjxlj6upuYrhEId77A3wbqhA6Ba
         V45wyfrFRqhKGkZTXz/2uJ8r/QGNVzkx0f7LyEeJwzFpLPOK2AgTDhVpHiKieSUz4fEg
         nvBPrFmSOEmFKTNXFZWdS80ji3PQLQBA4rYfBTjobPQbBnWqyGZmpBLAgmpyn1/KF5WJ
         wSW+iNJQQQigK0mUXJ5wFho0M0wR4zXJyaQogATV1d/3G8w6cr7o5Knxx6BCCK+MeB1g
         /KsQ==
X-Gm-Message-State: AOJu0YxtxDxmMuzA93fv5/kfN1R7yJUrCcPR032yumwN4/MV0PTvZBSQ
	4MAgcULNz+1BL2ShlGTFj1dlwg==
X-Google-Smtp-Source: AGHT+IFSoCtcskpBZxIV6K9X1cjaO7KURWoJMi3lTZ9pqegf+liCRlmjJACZcZ0sjG+wrMj3VN7d2w==
X-Received: by 2002:a5d:650e:0:b0:332:ffcc:861b with SMTP id x14-20020a5d650e000000b00332ffcc861bmr2109663wru.1.1702291748938;
        Mon, 11 Dec 2023 02:49:08 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:08 -0800 (PST)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	beata.michalska@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 6/7] cpufreq/cppc: Set the frequency used for computing the capacity
Date: Mon, 11 Dec 2023 11:48:54 +0100
Message-Id: <20231211104855.558096-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211104855.558096-1-vincent.guittot@linaro.org>
References: <20231211104855.558096-1-vincent.guittot@linaro.org>
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
Tested-by: Pierre Gondois <pierre.gondois@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
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


