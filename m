Return-Path: <linux-acpi+bounces-1379-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C927E6852
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2A280DCE
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA337199A3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xEsaEFty"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC690168B8
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:14:52 +0000 (UTC)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A372D76
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:14:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507bd64814fso913242e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524890; x=1700129690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=xEsaEFtyijZ+lrkgLWdBlKEF9XzHJAYABDemz8qJ7g6trDSydEg+717Paacds7L1RW
         ihBUmwGqLNYnnuwzrQkOYzfE6HJF7T60yL/GSUFpjTDQbtgtRMDtiL3ZxUmm0bvvoJBU
         OdpHItJ2Ab/GnrLM6yLVFTqmrbAMuI3HW+3wvr3jtTDBictXHHbN4XoJM1YoU4xlfowx
         XaUV4s2eD11I4ai+roVkUi8J3w+CdVFlXjm22oKeOKVGdA2Uu6avHXnbHr/1zfc4AvJ9
         zcMWBokvNNn11nxHlT1wSGClBTlsw6J8wfeOOlbTspqKHC1dJMsY+BIOT9V90TryMp29
         5KPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524890; x=1700129690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=q6+R4bU0zGuSzbS2l1SNK3nKIdbyrrgppN2KjxNEEExYTqY7J33tPTTUH15SGURTKJ
         DYTjIejPhAFrry3fmMgpFs0KA6cPNI7CgH9Yce52UMYbccfCe5q4+zeLoqvkaElZuQ9q
         v9u0ZJp+wJ1bPRrAAh5p3mJVAo/S34RrApK5yyYn/ojcPz/iv2wr61geHJ4BrqyvN7HY
         AfGZIOvy/8QBhBh8r2jh3L04rJfa6KjzXAOaoEDkl1NJvxTh2rrncg09R41V0tLPYtJk
         7RLhtiZLKsKV4hO1g9tY9mUaSTuyNgpftm7RtjX//EsDp+fOqi+VGHrhA6ArVCHynGaN
         MCOQ==
X-Gm-Message-State: AOJu0YzIFV4/Bi44jyZEkNvv/wJ7I3imuyrNr4f71YUvX93QmYiIHQK7
	QqrabvBzVq6CiVzNZM84RMQI7g==
X-Google-Smtp-Source: AGHT+IEqILPvUko85d9wgnJYU7Vruxwgnn1FhQ0YwiIKlK4c+JNlTI9/ER4u8xuUQ0y1qhtyeTmH+g==
X-Received: by 2002:a05:6512:70d:b0:509:47b9:63d0 with SMTP id b13-20020a056512070d00b0050947b963d0mr880323lfs.61.1699524890509;
        Thu, 09 Nov 2023 02:14:50 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:49 -0800 (PST)
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
Subject: [PATCH v6 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date: Thu,  9 Nov 2023 11:14:33 +0100
Message-Id: <20231109101438.1139696-3-vincent.guittot@linaro.org>
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
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 include/linux/cpufreq.h   | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60ed89000e82..8c4f9c2f9c44 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -454,7 +454,7 @@ void cpufreq_freq_transition_end(struct cpufreq_policy *policy,
 
 	arch_set_freq_scale(policy->related_cpus,
 			    policy->cur,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 
 	spin_lock(&policy->transition_lock);
 	policy->transition_ongoing = false;
@@ -2174,7 +2174,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 
 	policy->cur = freq;
 	arch_set_freq_scale(policy->related_cpus, freq,
-			    policy->cpuinfo.max_freq);
+			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
 	if (trace_cpu_frequency_enabled()) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 71d186d6933a..738dcddf3cfe 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1


