Return-Path: <linux-acpi+bounces-1050-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB57D91AD
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51B61B20B2B
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E1156D0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/hXih+d"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B8B1173B
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:04:21 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF91BD
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507a62d4788so2769887e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698393857; x=1698998657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c18WsKqkMLxlFb2kxy1TvqZw0mGllHhrI7E/VCZUkXM=;
        b=q/hXih+d/oCm2aSJa4q02OZKkW1RVmFrLh1IxuBe0NS8MK1lPFBQxs1qnKHV66sqWN
         ZohVFDk9Fy7SxPXr4CgkXE62CTCSwLokru99Ir7CgPg1eppEgeDjmVRGg57qR0t7CdxD
         gVcpsr1HauYsCItYCXmlsbJ7D5H1nEOp/MVFmjfoGGQKOwrZGle4tjNGKkb7R3EQPWAG
         h6re274P+wmBwUOxaZK97BKffAmFeLqeTlGgpC0jjUprR6itqqEUSzSFbCvoCa5aKc5K
         VuUOxt+HOWB/VeTQuNAfW5KqlVvqg8k4ADKMJOpNwkBAfUnW7AQcBE4LQPMAL4jNFqzo
         jGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698393857; x=1698998657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c18WsKqkMLxlFb2kxy1TvqZw0mGllHhrI7E/VCZUkXM=;
        b=Ep+8OrNuJu+xtfKDd7vsE+lDIZtKXLhmhSkRi1FcMeODhT8xYbm+Nvr0Ff61OaW/c/
         J33CXMGkUlQVwtF2j83cXLHXgsBmZ92tiHHloi/2cMnSrwJ0uQGNQQ4wqo07t80G6rEX
         PRoRLWUxpAw3Lz/eChca6xwU8xNHR5VwA7YD2i4ETj1OXnQr5erol7kmzScjoZ2mjG7y
         86IY/rjKaBUO49CgvQ62k3CKfqULFZg8xESoqzW2OAZt6O+L+bnOc22ORvijZpOSxztw
         pn/xR4qrGw9y6aueUaUYfjAAoGgNWFD6Wej2aGlEsGJyxF0UHjs9+CwQDZ/jouMQr8Es
         9ZZQ==
X-Gm-Message-State: AOJu0YyBnN8yvG+kxeUMIl4racL9I7dp08UjCLRERPoBLGH2zZk9k1Wi
	1bKAWxvz744jGnmFCbiA96FKQA==
X-Google-Smtp-Source: AGHT+IHpcSQk7VGAghux/3WEwWVJDF1pL/epq9owFA/njCZANYAUuDKZLjuGtdumKBq3GHr3rbcd2A==
X-Received: by 2002:a05:6512:3287:b0:500:aed0:cb1b with SMTP id p7-20020a056512328700b00500aed0cb1bmr1288833lfe.24.1698393856230;
        Fri, 27 Oct 2023 01:04:16 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:c5e:e24e:ad0b:58c6])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c025100b004083729fc14sm4397488wmj.20.2023.10.27.01.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 01:04:15 -0700 (PDT)
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
Subject: [PATCH v4 6/7] cpufreq/cppc: set the frequency used for computing the capacity
Date: Fri, 27 Oct 2023 10:03:59 +0200
Message-Id: <20231027080400.56703-7-vincent.guittot@linaro.org>
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

Save the frequency associated to the performance that has been used when
initializing the capacity of CPUs.
Also, cppc cpufreq driver can register an artificial energy model. In such
case, it needs the frequency for this compute capacity.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/arch_topology.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 9a073c2d2086..d4bef370feb3 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -349,6 +349,7 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 
 void topology_init_cpu_capacity_cppc(void)
 {
+	u64 capacity, capacity_scale = 0;
 	struct cppc_perf_caps perf_caps;
 	int cpu;
 
@@ -365,6 +366,10 @@ void topology_init_cpu_capacity_cppc(void)
 		    (perf_caps.highest_perf >= perf_caps.nominal_perf) &&
 		    (perf_caps.highest_perf >= perf_caps.lowest_perf)) {
 			raw_capacity[cpu] = perf_caps.highest_perf;
+			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
+
+			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
+
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -375,7 +380,15 @@ void topology_init_cpu_capacity_cppc(void)
 		goto exit;
 	}
 
-	topology_normalize_cpu_scale();
+	for_each_possible_cpu(cpu) {
+		capacity = raw_capacity[cpu];
+		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
+				     capacity_scale);
+		topology_set_cpu_scale(cpu, capacity);
+		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
+			cpu, topology_get_cpu_scale(cpu));
+	}
+
 	schedule_work(&update_topology_flags_work);
 	pr_debug("cpu_capacity: cpu_capacity initialization done\n");
 
-- 
2.34.1


