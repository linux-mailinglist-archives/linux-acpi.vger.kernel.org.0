Return-Path: <linux-acpi+bounces-1046-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D58EE7D91A7
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1207D1C20A8C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742F8156DC
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwG/4VS2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235D11734
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:04:14 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D8C1B6
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:11 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so23454691fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393849; x=1698998649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/qdhwYexgC4eelalZMREFYWDVhGmAVpyIy4h5YJd+Y=;
        b=UwG/4VS2MSxnkHtnsQpx9o/IPbZw1SxCBiaWXkPAhvhzizTMzCCoLnLGF4IHzjENat
         p41YfyeuOalrUJevD4TBvRf890ua3fFIJoTyZdQDjvv8D3qHL11Ntu/6ji8O9I0mp7zt
         anztlSB/tAGfuE/cy2m4NgHBbFDhm39MQhI8VLPBWD5W2qjTAfJNX3MP05Aj4SXC2SAS
         +dCFxr2+vbXfCASS4kYKZoZNlXyQU9TnhvA64gvJV3qmfKdLXvk+vaXI5ZjbAUWy5cMN
         DS/HtrOHsQ1DBTnsFgr4/qM8B1P5gFIn8msWC/ZrDXdhoMwFttPih9Gy5hZU7d19DQed
         Sgcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393849; x=1698998649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r/qdhwYexgC4eelalZMREFYWDVhGmAVpyIy4h5YJd+Y=;
        b=AWKFKTbaYL+jdA/7HMGYpGVu7QqO2qwzj6jcUJqbuYUezwctCYvM1VcYw+QRiDO0SO
         O0qsYTdYuXKK9Kq0SaJlEu6KxKt3ngUFOfGXIEWJU4gbiQQvlTV68khL+68qzxTkJ2Rd
         N7DGKvqMlxu6yYSIiz5lb8GeQxi9EJu3Ji+KBH7CKZNDNFuV6kszEmiXiVLe6PQ+C4zB
         w+ppZvgg8jIRpl2xLXQtjh4abjIYDwIzIr7l+DDnIItjbPsFy93LCo+EQZnlofy0DqwQ
         0shBcPq7NGh9iOdyIAr7FynZIe0mZY0zRXb1tSiyad1yA8pSVhuM2EEc1Q2zWox7Ie2y
         CcwQ==
X-Gm-Message-State: AOJu0YzkMzrxTy9gOI8olE2wQKU+rLEdM11v3+qwT1/vYiNsjat0gSVR
	USUNkrhvWd+tAeugBxWskFSorA==
X-Google-Smtp-Source: AGHT+IGXugARg3H3+vIzNim0kJhoC4UBCl4/dUe/XX18rWVm78ZhMKD3Vu64iuuup/7qbp3srdsKEQ==
X-Received: by 2002:a2e:8217:0:b0:2c5:1eb6:bd1e with SMTP id w23-20020a2e8217000000b002c51eb6bd1emr1414040ljg.43.1698393849239;
        Fri, 27 Oct 2023 01:04:09 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:08 -0700 (PDT)
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
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org
Cc: conor.dooley@microchip.com,
	suagrfillet@gmail.com,
	ajones@ventanamicro.com,
	lftan@kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 2/7] cpufreq: use the fixed and coherent frequency for scaling capacity
Date: Fri, 27 Oct 2023 10:03:55 +0200
Message-Id: <20231027080400.56703-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027080400.56703-1-vincent.guittot@linaro.org>
References: <20231027080400.56703-1-vincent.guittot@linaro.org>
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
 include/linux/cpufreq.h   | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

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
index 71d186d6933a..bbc483b4b6e5 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1211,6 +1211,15 @@ void arch_set_freq_scale(const struct cpumask *cpus,
 {
 }
 #endif
+
+#ifndef arch_scale_freq_ref
+static __always_inline
+unsigned int arch_scale_freq_ref(int cpu)
+{
+	return 0;
+}
+#endif
+
 /* the following are really really optional */
 extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
 extern struct freq_attr cpufreq_freq_attr_scaling_boost_freqs;
-- 
2.34.1


