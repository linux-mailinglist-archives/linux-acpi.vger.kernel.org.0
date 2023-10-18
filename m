Return-Path: <linux-acpi+bounces-744-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE17CE2EA
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 18:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21191F22A71
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6B3D380
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Oct 2023 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="riusoBBx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AF03C09F
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 16:25:53 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD44125
	for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:51 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406609df1a6so65078035e9.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Oct 2023 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646349; x=1698251149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nf9NNvnyBz0qVw4ihr1xxMPaiT6voh2eHkh7WwYLcYs=;
        b=riusoBBxrkfcVne93EHWceXcnZ+8zALME/uUd+UCfFGIHDIBq3qf3b+YXYX4aU7fsv
         1jvmWm2M1l0VGRYPB23cEKBYdKn0R1MNx8M7SR50oXVLzEE0IvDLAay1eCMh3w5YGMgh
         5zbZWA0tUgzftDOLkhKmbUumPaw8GjBGx7qMPANpNEvuK+DEST/TP2WylKgejf67SKt3
         sovl7NRRzpMf/cPk9GAzQWMgTAkLA5hX+B0+WXet6HcOrpsHJfRYNU6+yCafpCFBe4Ny
         19ebVfJJa0GmUJ8Eg4fMF9P0pC/4AfMFH+3skKoK4nzQaePm+zG6j7abNGax3ZQIo0QT
         hKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646349; x=1698251149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nf9NNvnyBz0qVw4ihr1xxMPaiT6voh2eHkh7WwYLcYs=;
        b=f5GLSfFsF1MSIvZkpv8brz0dskQm0zDjFjWOlfcqBt+9tqP4xOmlPr8dYXiAtYf9N1
         3NO7Bbrc9PxSahxDnd0VwQun9bHOoxqiJYcLgueauTQAjcynzpvYT3qhUlnupQc8pyiI
         RggK2U0MTPpTbOSnHeAtUjDYnpwihYT6Bmv+Otx1EeGhvmV+S9rnW+eiC6pVF4aAwS1B
         2qiMAGeQoApnq58YT+nNFJ5K6hBzmiTsFGWeC93tvi5g6dASEQ2We9j/cu8EtXbCVoDr
         K2vTWQweWwIXHmhkdzkZCKhE8TTzXDpcAnj/muDqMYh16WOYKbmFAv8dHmimUwez6PWE
         ShqQ==
X-Gm-Message-State: AOJu0YwxcYThzRoN5XncGxtE1VU2McCxsydcuDpLB2lP8gWrxEvfgJef
	B6cBlzztCiPIV48Uy4jlO4d9JQ==
X-Google-Smtp-Source: AGHT+IFHq6gIgq9/fcdzlz7KWlERZAdzsq5hjSa77y4MZr6K71BH6ckGJqEW3amqmHnP0VNk6KQh3A==
X-Received: by 2002:a05:600c:1990:b0:406:177e:5df7 with SMTP id t16-20020a05600c199000b00406177e5df7mr4970619wmq.29.1697646349667;
        Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:49 -0700 (PDT)
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
Subject: [PATCH v3 3/6] cpufreq/schedutil: use a fixed reference frequency
Date: Wed, 18 Oct 2023 18:25:37 +0200
Message-Id: <20231018162540.667646-4-vincent.guittot@linaro.org>
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
implies that the value could be different than the one that has been
used when computing the capacity of a CPU.

The new arch_scale_freq_ref() returns a fixed and coherent reference
frequency that can be used when computing a frequency based on utilization.

Use this arch_scale_freq_ref() when available and fallback to
policy otherwise.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>

---
 kernel/sched/cpufreq_schedutil.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 458d359f5991..6e4030482ae8 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,6 +114,28 @@ static void sugov_deferred_update(struct sugov_policy *sg_policy)
 	}
 }
 
+/**
+ * cpufreq_get_capacity_ref_freq - get the reference frequency of a given CPU that
+ * has been used to correlate frequency and compute capacity.
+ * @policy: the cpufreq policy of the CPU in question.
+ * @use_current: Fallback to current freq instead of policy->cpuinfo.max_freq.
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


