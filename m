Return-Path: <linux-acpi+bounces-2266-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7AB80C720
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 11:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB5411C209BA
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A82D636;
	Mon, 11 Dec 2023 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UhOLaaMc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A674CF
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:06 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3334a701cbbso4484551f8f.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 02:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702291744; x=1702896544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RP/GniFhlk8mpJf3Vw6rSOsMkhpCi/hEV2/F0s2ZGQ=;
        b=UhOLaaMcg0rmnRaLEDJXXeGiigbuJe6gBK2wre5vXd8BjEH0gFa4mV0y8WRWp8fgar
         5S/7lzfGGOoDQ5Ub9q3Yk9sNE+8iOvWoUP6rOzv6rMsKh+aX8RBaNsXRtnkJscZVQpc6
         L3tb+yRuVRXabXk24VNxAY8WK0DpTituLryeqSmIicy/0Tky3vWtd5CWRKZol3I2guJx
         aIH707PW/2IOmmaWhey+Qu1+kLq90mwyLQnTyV6uQX1Q5QzIe4bvm3Qx4VfsUuK+VpDQ
         jkn5lrCHIvik5gTJYbsImgHDD7VPTFK1UVs99Onjw7W+mBQBi8zdob/WLyUQ6+Wd7ZHE
         iD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702291744; x=1702896544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RP/GniFhlk8mpJf3Vw6rSOsMkhpCi/hEV2/F0s2ZGQ=;
        b=MYeE6y9keklE6lk+IdVlI+9FRul+XulXegPaSkGr/eapg/Uhz4SpdwhfqljBbRE3FD
         a7kGqdrPKF6JgO1hbkxrb00exA0SQKKDHn4T4xU+H0IbT7tvkXXJ+WiIs1n4tq+hkrQA
         FWr19rIoMrxL/6q/DN3Tvcruvww2FhCCW0PlN99KMQigUvsgkJtx1uSXPzJeZmoOZy3w
         moHyVJcvj4AnPzBf8uiUntTnWx4n6Um5qJmvmibLKGQZJYzEA/cczR7Qtgxx3o+tow4X
         6NGOjSF/S1QQ9NSeBTR28B+c2XWFjsyK7mQ+RBaymUTKLmPF8Frc6B3Whx07jF/9vaDX
         RjHg==
X-Gm-Message-State: AOJu0YwxssvM2/HKuYsTfp4B1vzAG0fj2UE9acLp7PrupyTXd5x2bjTA
	39vFgFD5MDBtKnvKDeWDcevaUg==
X-Google-Smtp-Source: AGHT+IF4eR0dSmCOZr8X8sS8Dj4KfNlP6x21UczztX823PG+ip/O5DiWO/XLFap24V6etMilxZ5itA==
X-Received: by 2002:adf:eed1:0:b0:333:2fd2:3bd4 with SMTP id a17-20020adfeed1000000b003332fd23bd4mr1400970wrp.141.1702291744711;
        Mon, 11 Dec 2023 02:49:04 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a8d:abc:f0ae:3066])
        by smtp.gmail.com with ESMTPSA id e16-20020adffd10000000b003346db01263sm8232579wrr.104.2023.12.11.02.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 02:49:04 -0800 (PST)
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
Subject: [PATCH v7 3/7] cpufreq/schedutil: Use a fixed reference frequency
Date: Mon, 11 Dec 2023 11:48:51 +0100
Message-Id: <20231211104855.558096-4-vincent.guittot@linaro.org>
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
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 4ee8ad70be99..95c3c097083e 100644
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
@@ -140,9 +162,9 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 				  unsigned long util, unsigned long max)
 {
 	struct cpufreq_policy *policy = sg_policy->policy;
-	unsigned int freq = arch_scale_freq_invariant() ?
-				policy->cpuinfo.max_freq : policy->cur;
+	unsigned int freq;
 
+	freq = get_capacity_ref_freq(policy);
 	freq = map_util_freq(util, freq, max);
 
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
-- 
2.34.1


