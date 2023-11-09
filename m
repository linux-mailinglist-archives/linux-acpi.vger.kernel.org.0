Return-Path: <linux-acpi+bounces-1380-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC2F7E6854
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363E51C2048F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9668B199A6
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpSbnRMV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23FB168AA
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:14:54 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FD22D7B
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:14:53 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4084e49a5e5so4710045e9.3
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524892; x=1700129692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=PpSbnRMVClcVCq7PxMg71+AnKN7hK0FrYIohngsI4P6PFOOh1MqbWWwQKkFPvt8XWi
         g2qDWb8opx5p+U7mtBOtiMHX3VWz5X9qugns5VaH+noBdExOA76oWa26tGHV7XtWa4rF
         epu7BVSF9Lew6K/jC8vFe2kZ9o/sMwwPFyq8TpFIAwob5uDkz/pk/GZ33QZ0GtSQeKO/
         /Nv9P7VWzBeyAqNuPUKfrIFtQbAiA3+k8Q4pZqES2p3nAQLrzRzMvtB6UKrAjfSkTjJ5
         zPO7pzg3wrMsO3NKMmThfuRrz8GX/u2EpHmR9V5yX08tOBFXUcFF4xBiXqhRH7hukxrS
         Rwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524892; x=1700129692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=jO1XPudLqDiP49h//bSxyrB/tZPXwP9QdxpzM4AADwZgPsoWIu3WC1o9mKEzKTcjt7
         2rDBSkBqbQ5jupurBOqn7UKGPaGb4qljMubABeMQZFbLvm6A+3er0c+lQI2XiNrIKon9
         XGBOqGrAMNGiJSLaWS856AxFUhWCSYIy4xgtUBA6TwEK+wbchehGjP7tmfo3es1F+nF2
         iyLQZ7DsT++ipMK84ZeVJQfj6eSMEiLmCEpaMUdB8T1CNZYnuv0dIRR/VtPJjw/iE63x
         PjLrZfWKCd7fO5VD8HeKWlR1JL66j5KxoJqrORUUPv+TC8noo0O351VM6vAIExnyUHdX
         GWsQ==
X-Gm-Message-State: AOJu0YzdxmCh/MCv4jWQQz1vbAvpzAfiewlk7qr7/+7/X6jXda4s9mQj
	XjxC15cMwg0jLlngW2EGcpMVcw==
X-Google-Smtp-Source: AGHT+IHnOiUcy8JXKcoEvGEFJjBuKV8KQLk7xv3UY4lyz6ACLBnBr+ZIXmzvc3YVmB2uAO7FfkCoEw==
X-Received: by 2002:a05:600c:a49:b0:409:5d7d:b26d with SMTP id c9-20020a05600c0a4900b004095d7db26dmr3556372wmq.15.1699524892326;
        Thu, 09 Nov 2023 02:14:52 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:51 -0800 (PST)
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
Subject: [PATCH v6 3/7] cpufreq/schedutil: Use a fixed reference frequency
Date: Thu,  9 Nov 2023 11:14:34 +0100
Message-Id: <20231109101438.1139696-4-vincent.guittot@linaro.org>
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

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 458d359f5991..f3a87fa16332 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * get_capacity_ref_freq - get the reference frequency that has been used to
+ * correlate frequency and compute capacity for a given cpufreq policy. We use
+ * the CPU managing it for the arch_scale_freq_ref() call in the function.
+ * @policy: the cpufreq policy of the CPU in question.
+ *
+ * Return: the reference CPU frequency to compute a capacity.
+ */
+static __always_inline
+unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
+{
+	unsigned int freq = arch_scale_freq_ref(policy->cpu);
+
+	if (freq)
+		return freq;
+
+	if (arch_scale_freq_invariant())
+		return policy->cpuinfo.max_freq;
+
+	return policy->cur;
+}
+
 /**
  * get_next_freq - Compute a new frequency for a given cpufreq policy.
  * @sg_policy: schedutil policy object to compute the new frequency for.
@@ -140,10 +162,10 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
 	util = map_util_perf(util);
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1


