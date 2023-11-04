Return-Path: <linux-acpi+bounces-1226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2CE7E0F59
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 13:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38230B2122C
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A468B1A591
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OLJZ/NAf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F43C150
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 10:59:18 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F80D4C
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 03:59:16 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c5087d19a6so38943631fa.0
        for <linux-acpi@vger.kernel.org>; Sat, 04 Nov 2023 03:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095555; x=1699700355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=OLJZ/NAf4ZEf45K0m9be9tlxklipxKiEah3Lfiw9MRb55oJkvQevIb88wp9EAb2egV
         ZlzaMnhwvzTIl/PpPCD9eNcJAv6QEb0PimPNwsV7wGNPZ+zGz6HqUj5ZaIJdcRDe4U2n
         n33vMenx3zLynMJvznF38JJXbmc90bRyw4vYBufEza0/Wafj5aMcmYn83AVXJ3QsaUgL
         D4AUVBUS39tmQZd8mHslkvW5yZNqbsEx2svupRPqvgeMbkJsMI84dp5rAtyr8FkxZDWd
         mNwb63WHrjHrSpKHSPEWQ4fm07zIGKGIn2XJvmucFkIO7AKhLIyLbYwY24f8af0Bh8RO
         wQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095555; x=1699700355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TkZaHixUrwPrJIZcMAT2UI1CVMoJazwhG5L/qYNHDpM=;
        b=DC7VcOOvr6sMqXEFevm71J6MtG3YNaDD8uPeDg1L43vQisQpy4PyxzYdX9Z6M9N2sK
         C8ROr3am/rZOH0xxlHJhIbozQIxciGIhZHTmQv/niPM+huXl/rOPqhfx/igqU5IEHDpp
         gYEhy61512lkf4rfLY9Ugsf9+Qi8LhWLRhi8tgCEjHmPKCpcemQuUFvH17Uhe3Eozs8j
         oO4Ske6/3+DxO3KeqTdLzF8F9s0AZhNMQFLca8QKGBq090YIi+qPd8ullYURpu8SxWcH
         /SpVb0JBMli3V8gXGr2o23Z2F7TzxgDaIZvobcJ5VvGAzHqoPjdkgFNNLkHENiAKNyiI
         ljMg==
X-Gm-Message-State: AOJu0YwD41YlxlyC0ByarpRD0SzRgNqklBqhVWk3I5QWw4+i9jqUw/yp
	sA0xxnEp+9g/abXRB+Gd6keacQ==
X-Google-Smtp-Source: AGHT+IGatMiVkHBmtEgXSS+pWzzTWU/5QphnZgu+ruqZQUWWzvRdCWO28Yzol+5QNvFneAB53ahKPA==
X-Received: by 2002:a2e:7a17:0:b0:2c2:a337:5ea with SMTP id v23-20020a2e7a17000000b002c2a33705eamr19234202ljc.27.1699095555017;
        Sat, 04 Nov 2023 03:59:15 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:14 -0700 (PDT)
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
Subject: [PATCH v5 2/7] cpufreq: Use the fixed and coherent frequency for scaling capacity
Date: Sat,  4 Nov 2023 11:59:02 +0100
Message-Id: <20231104105907.1365392-3-vincent.guittot@linaro.org>
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


