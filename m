Return-Path: <linux-acpi+bounces-742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2667CE2E8
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB6E71C20ABE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2803D382
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f85jNDyj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F9B3C08B
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 16:25:53 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E864D131
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40837ebba42so11655285e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646348; x=1698251148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Z47rGwNrqDmeGZQL2+O4h6n0CW6ulSbmPrUuoIVrkg=;
        b=f85jNDyj+YCeVocfqQ9Wnfs6HCEUPsoxfnev59jx74f0GdAE6LnN6JA1kxfwn44r0M
         QcVN7Ajxs4kNGmRdV91XHS5Bf1UALo7T1EguSZOqENx96Qe2d/+ExLpKKIhs1JBk3B59
         o3ekzF3iMtipAtwxwcYx0KL1AyMDSdwQTJq7oqTJ3tOhAyatLMYYLUYmHLhxBBD8dKI9
         +LMqXKotmIDdJLSjCVO4QvGu8lpa1JlnfYYDR5ST9NPaVElWRC6o31ezWTF0ZX3PwgMi
         xg09U1UdhUXKCtLMlM71gEnWP4mF4zSN0KvGVwUJUkfUQQbHe0NCpUnRzRYHibAr29Tk
         7PpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646348; x=1698251148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z47rGwNrqDmeGZQL2+O4h6n0CW6ulSbmPrUuoIVrkg=;
        b=Enm8SwTCsl71L0aYUSoKPPzPTztk4iTs2/Nu82W2mjCDI3yJZGNGsnICPa/mKab2NH
         Qeqic43ygffbulW3xp8miAzBhiLRF5tFQY6hGs6+cng2uUALsd4gVIKFUEeLTScPwcO/
         LP7iHOdtI4L3HQs8grAg88fXOsiOpI81AmkTtBjj968opA8K94QC0CePK0WnftXwkhgc
         EBkLfnYYAEtZCRkQL35ydug00+7P0OSJXUt9722/o1XLLvv7ROsXOGClmah7jt/NIqsq
         dYb6cOF7ruv+mHH+f46xNN1zYQupbg+JMqwVgsIJVCP4/Sauf4NmovQZPoNRnHfoKA0o
         5fJw==
X-Gm-Message-State: AOJu0Yy8AJzwhKkGqD2xv32Us+VixKn0bnYboj6HsTUF9EIKv/dSjEWw
	tJVSSNSzxJ8CAkO5Vh2HX7gJow==
X-Google-Smtp-Source: AGHT+IEFZf427eGHrOOELv98mOJEzuRAUylMVQKBwFbh9aeFtmb3e8o2V3eMOH20VJR0QjYnkJDkZQ==
X-Received: by 2002:a05:600c:4f15:b0:401:bdd7:49ae with SMTP id l21-20020a05600c4f1500b00401bdd749aemr4828030wmq.18.1697646348170;
        Wed, 18 Oct 2023 09:25:48 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:47 -0700 (PDT)
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
Subject: [PATCH v3 2/6] cpufreq: use the fixed and coherent frequency for scaling capacity
Date: Wed, 18 Oct 2023 18:25:36 +0200
Message-Id: <20231018162540.667646-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018162540.667646-1-vincent.guittot@linaro.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

cpuinfo.max_freq can change at runtime because of boost as an example. This
implies that the value could be different from the frequency that has been
used to compute the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent frequency
that can be used to compute the capacity for a given frequency.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

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


