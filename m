Return-Path: <linux-acpi+bounces-1229-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463467E0F5C
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 13:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69CF51C20952
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A8D1A58B
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Nov 2023 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYAXZEUD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B04C15F
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 10:59:22 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BE61BD
	for <linux-acpi@vger.kernel.org>; Sat,  4 Nov 2023 03:59:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c50906f941so40985321fa.2
        for <linux-acpi@vger.kernel.org>; Sat, 04 Nov 2023 03:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699095559; x=1699700359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=NYAXZEUDPWjiusNBkZ9H9ZywJSGk5TsqkMxvoizsjXl3+eSUBeQFbTgvUVVzxSM4nz
         32dLYfmE20s6/jFNw6Jiuov+MkfGHdmXknmJAjkARtbzAOWI9UE4RZCqP15IAppqfAqX
         dg3jHHHLYiH84U0rN25nrd5cJaGpceKqOTPe3ClOFM7621MQH+A4xH75WhYQUgehGvlo
         cRAPWrFfSYRvWVklHa+3H+sv/NPygojeuWMEISAoNZh0NeZsk5az6bdacjSbDRcNrIsE
         TRG77Pjb9txDtMflGbkj/0DOtXCQKUXj2B5gTJqaogXXCvnZLeC1cBhWK6yQ59OSF+KU
         IFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699095559; x=1699700359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aduCSyHEYIhu+IO52anhhUtjmJcDS68d0TTkBLTxAgE=;
        b=CNCOXUM6/HwLTffdKgfCKy90lTZYMth+MYKIVAL/kjATB80yF/tLR0js/RcSsyxKRO
         iSXt95KpjpBLCeVt/5HkHH6+wwUFQ4LnqBA8xIfUgkNBKZ67cIdsYZHeKJM3WRTQCI6Y
         Py+fmmEwyPgMAS6ATYaic8sRBpwviwL2eJZaPzt9eJdwGYMfSSMCfIbdEDRohe9fLqZ4
         GRADEfhWzK0AMHmuhf1xicfAIRcIMrf1+U69KEwLAgJqCmp3G/sO71hNpnltG6wqoKP4
         M8bBOWE2m4N0hwub3InIqtCY/CMiDzrLKHAbTZLcQAGGZnLzTQSACCyBtgWd72/DTCnO
         apAw==
X-Gm-Message-State: AOJu0Yx4wOLKCypynXXkRnQqfzapNh7QIxZRRQNa/FASMgRZbEIJUUf6
	k1NVVZpXZ9Hv7QIkhC02q3KZpg==
X-Google-Smtp-Source: AGHT+IEKPOs60LYQNjgCF6O3RJzRkpTLUhSiH7KaHbkzBZx3/tQp4+sLFyShZ9/I8RYwzr2SsuMl7w==
X-Received: by 2002:a05:651c:1052:b0:2c5:1045:71cb with SMTP id x18-20020a05651c105200b002c5104571cbmr17415933ljm.32.1699095558043;
        Sat, 04 Nov 2023 03:59:18 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:3172:eb13:5bac:126a])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b004053a6b8c41sm5315809wmq.12.2023.11.04.03.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Nov 2023 03:59:17 -0700 (PDT)
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
Subject: [PATCH v5 4/7] energy_model: Use a fixed reference frequency
Date: Sat,  4 Nov 2023 11:59:04 +0100
Message-Id: <20231104105907.1365392-5-vincent.guittot@linaro.org>
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


