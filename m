Return-Path: <linux-acpi+bounces-1047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34CA7D91A9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA441C20F61
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A6156DC
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L24RwGMH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DB1173D
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:04:15 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14872D40
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso12197825e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393851; x=1698998651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=L24RwGMHA181FTA5H2iJVIE6oJBGLqBWg85c0yDhYhDgZ9Ox9Hc1ORQ7rO0MXisXlL
         0gDMH/x0sTlJQINhM/UOCAIxOmENsXtaySZKUDbDbWabcZqTlVqEmMywfmSRiuebHLwF
         4yNZajeH7zjRYQArVx5+D+fHTOTrhCyNHlvarxz5n/o7CFvnPubPdSGuhWViWJ5BKugn
         E70mGdjeQx2nEWovHP81d3oULXEYupE9mopY2Kzx1YHA7B2EOaxPe8tyBEGLAzjIWmWE
         RerpeqIsAz94yMRTE3jbOEmJAU4Zz4D0A/lcE5xRtd9ITvtFNhUIFZa0z6W5vI7EWPLy
         cZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393851; x=1698998651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8u+U/9u4ohr5MnGNG/ipD+T+tLh/PNcKnY6Yu8ixWw=;
        b=pZmIAzacYrHJHcGCGBugWqajrPkm7d7oXZY+D7t7TOrjrRwSF1VDVeGG6/XpJXsaJk
         Wo9lPkIMcOqod2mfTPOVaHEMAOB3f8Sw5O1YSEKHlgzCulWzDu/oIeUmK5rOEvIWeDfZ
         XCR2pOvKx8tp4Z8jzS5TWPkPvlm8xYNlZmp4J78rwy0gH70fseuMr9P37L1h9Nu4GY0N
         N3O+dByK0JHA6NQVAx71bvUcTisYQ6QRn6L4XFXYlE8qF1RB6NhYFXYPmTRpxkpi1Q4l
         h7WZyfCMug20O95xZ78B2uXTfq+RjIz+w+S2ySdM55eEsvvvRERzwtqwYj5RBthqJ44A
         rwdw==
X-Gm-Message-State: AOJu0Yx6d91rhT5LNU4prIXXwXmHee0D+FVrErbWo6ZAonbx3Ppj5Zlk
	PUQ++/AsIabKWiUHx5BtufQEvg==
X-Google-Smtp-Source: AGHT+IHHJHw9trOJbFgvgeyKGPFkJl88ylA+IM/8RiCtB8m/EeKXjTdIKw4FH7YnjB4Tz158dwBttg==
X-Received: by 2002:a05:600c:3594:b0:405:4daa:6e3d with SMTP id p20-20020a05600c359400b004054daa6e3dmr1555522wmq.39.1698393851126;
        Fri, 27 Oct 2023 01:04:11 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:10 -0700 (PDT)
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
Subject: [PATCH v4 3/7] cpufreq/schedutil: use a fixed reference frequency
Date: Fri, 27 Oct 2023 10:03:56 +0200
Message-Id: <20231027080400.56703-4-vincent.guittot@linaro.org>
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


