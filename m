Return-Path: <linux-acpi+bounces-2265-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C83E80C71B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 11:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168C52816B1
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A876E2D02A;
	Mon, 11 Dec 2023 10:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvb05Gay"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB23D0
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:04 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-33330a5617fso4541427f8f.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291743; x=1702896543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2OL2mfLvFGb56Ql/fhP2tnzudrp50Fv5hQ+16D3uLU=;
        b=fvb05GayUUVODyr7WjVu8NHw+UhnxSiU0YcTPDrt8WjTCEQWcNDuq+jWiO3uXeZflQ
         +Z8CxH1/tzPPQ/wiYuKFvfqVjaZIih8yRnYLsTmYUjcayK1EH/Xk89SmGE21jlbTERt5
         BynNZvcpAVSMDZeDR1cFweDvzj4beYLAp9IGJzRFBPgBugL1DKdrrvsiS0MBGpGrDJDD
         0pMyAtze+fmf6Z1L2bbFtcXHc4JjZf2+EsdS+9EYZr+LuWnddK3IaHYK/jEElUjI3/KG
         cR9v3jadmCPVZxoprzOHyOC7oQWgu4yDlEn2sB+LiHlq29HXd1yJ3zVC7uyFZO3A3wmE
         i1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291743; x=1702896543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2OL2mfLvFGb56Ql/fhP2tnzudrp50Fv5hQ+16D3uLU=;
        b=odOvKnC5Gd8mTz+swJmd1zdTpW9b/K+5qxLD7HBO228H6b7a+OLFAuD1OrmCFajhQZ
         GWEv9wDwVCSW+0hgTtULrRybdbha/l8js3Axh/mcA0MBr5QUeDi6oy4s0xEbhwkYz2DE
         Qa/zObO7CKPHFnXud9VGJRa0AszJ/MbOdYY+f6xDV2gxe5HDDzmcZsUVYseEJJB6pvBq
         c2dSj+SGRj5A6AHec5UEJcyEtT1TypQ27JOvAKbuBvlvri6Ik+h4T5PShD86OqihhnaH
         XrREYL99+JnrC+iUOaIW+5GPGfdiSh1yEXDHdM6kdkK8D0PXGuxuxvCJBpzDI7qcmkpb
         X2TQ==
X-Gm-Message-State: AOJu0Yx/cdP2D4TvhzsDshVO1JgyuqWt3N2I3OHb2S8t5Msq0MSIAjo8
	B+9D2waXgFxUKf502UskwtPI3g==
X-Google-Smtp-Source: AGHT+IFG62g0i8MGKgRKqwDFZc4qwAP2pdIhI1VgTkLwdCILDtRtHj7jr7ZHCbn3cvj3/NVslT5gpQ==
X-Received: by 2002:a5d:49c1:0:b0:333:2fd2:5d1b with SMTP id t1-20020a5d49c1000000b003332fd25d1bmr2313046wrs.77.1702291743253;
        Mon, 11 Dec 2023 02:49:03 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:02 -0800 (PST)
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
Subject: [PATCH v7 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date: Mon, 11 Dec 2023 11:48:50 +0100
Message-Id: <20231211104855.558096-3-vincent.guittot@linaro.org>
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
index 934d35f570b7..44db4f59c4cc 100644
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
index 1c5ca92a0555..afda5f24d3dd 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1203,6 +1203,7 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1


