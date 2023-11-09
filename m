Return-Path: <linux-acpi+bounces-1381-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D57E6856
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 11:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B01C208EA
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7917D199B5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Nov 2023 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2XoNOc/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7763168AA
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 10:14:56 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8314930C4
	for <linux-acpi@vger.kernel.org>; Thu,  9 Nov 2023 02:14:55 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4083f613275so4555835e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 09 Nov 2023 02:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699524894; x=1700129694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=B2XoNOc/UvEkRo9hxP5p1Y+/rylqTlP3mpJpsnqcRVhqXeUBHOrpDAr/QbiG4v0gac
         KbITUVpfPRbT7B2PCPJpKJ44jFCcIwxQr6IiwXs2MLAScSMyildYvBopvyezCP1E0q9m
         BGDj7nYrYa+dWF7na8dtTgGOBic5lJpmdxpY2oDmjYv7l7W4GYLUMZ0nd6mqII+t7GZi
         yIzwyAnQHmLIqZ88AuJvLuyknLFegie3phbl4pVTE7JKnCIqhFUZ0y3hb+ckUwyzt1h8
         Ip6Fwb5153oFvDGCmBa03thse64naSSLLxF2YV5nZdxlcK+vOqBZNZKAvAMgXK4a2JyP
         xNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524894; x=1700129694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=P3zIYl64DXfAW6J1f3zzhkT04/PJMQt70v0JYqvMYbwLVJ3qJLNMtPwJbjgUG7CSpP
         ASxO96qiWcdVGg4AOXqE2C4quyWQggQomVP/muyQavAKjyug0kseu+eCR3iGTjaevHeH
         4GTHFcUcBE0HrexDfDxxfFodzW7AE1SIyuOEkQVtsvyE+dng+cT3gQElJk2hKvNI8wbX
         3hcSxvHEph5YXJ0S6di6+h3g+QASK77WZRHQKHtnyT8I4zsmpZCIEfHLUFA4nl3gwf1m
         wEZdGlNWN9KO+swxT0spShETjGHRy+ELxjuzTs5P9csMeYp39Oa8BE1kT0Nu8RRIUsQn
         /d6g==
X-Gm-Message-State: AOJu0Yw+zTw0ok2nj3f6nlj+mDdDZLrMvgW5MsA3NJRtM89egeImA+ht
	ExI4HGVSXp39cldhp7DkjzQBbQ==
X-Google-Smtp-Source: AGHT+IEYIB6ScZWDEgpcZ/S2cHjVchJEeCFHQxgRNVNplqpr7l/I6Xe67qLyHn6zzj6QW+TyS8tvqg==
X-Received: by 2002:a1c:7516:0:b0:40a:28b1:70f8 with SMTP id o22-20020a1c7516000000b0040a28b170f8mr3876852wmc.21.1699524893988;
        Thu, 09 Nov 2023 02:14:53 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:26e5:c6da:63bc:dd99])
        by smtp.gmail.com with ESMTPSA id m17-20020a05600c4f5100b003fefb94ccc9sm1611816wmq.11.2023.11.09.02.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:14:53 -0800 (PST)
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
Subject: [PATCH v6 4/7] energy_model: Use a fixed reference frequency
Date: Thu,  9 Nov 2023 11:14:35 +0100
Message-Id: <20231109101438.1139696-5-vincent.guittot@linaro.org>
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

The last item of a performance domain is not always the performance point
that has been used to compute CPU's capacity. This can lead to different
target frequency compared with other part of the system like schedutil and
would result in wrong energy estimation.

A new arch_scale_freq_ref() is available to return a fixed and coherent
frequency reference that can be used when computing the CPU's frequency
for an level of utilization. Use this function to get this reference
frequency.

Energy model is never used without defining arch_scale_freq_ref() but
can be compiled. Define a default arch_scale_freq_ref() returning 0
in such case.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 include/linux/energy_model.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index b9caa01dfac4..c19e7effe764 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,7 +224,7 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 				unsigned long max_util, unsigned long sum_util,
 				unsigned long allowed_cpu_cap)
 {
-	unsigned long freq, scale_cpu;
+	unsigned long freq, ref_freq, scale_cpu;
 	struct em_perf_state *ps;
 	int cpu;
 
@@ -241,11 +241,11 @@ static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
 	scale_cpu = arch_scale_cpu_capacity(cpu);
-	ps = &pd->table[pd->nr_perf_states - 1];
+	ref_freq = arch_scale_freq_ref(cpu);
 
 	max_util = map_util_perf(max_util);
 	max_util = min(max_util, allowed_cpu_cap);
-	freq = map_util_freq(max_util, ps->frequency, scale_cpu);
+	freq = map_util_freq(max_util, ref_freq, scale_cpu);
 
 	/*
 	 * Find the lowest performance state of the Energy Model above the
-- 
2.34.1


