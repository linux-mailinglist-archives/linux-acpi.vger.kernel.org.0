Return-Path: <linux-acpi+bounces-13060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D36DA8A614
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 19:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7BE177BC8
	for <lists+linux-acpi@lfdr.de>; Tue, 15 Apr 2025 17:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323712222D8;
	Tue, 15 Apr 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KiEi9yA6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1D422155D;
	Tue, 15 Apr 2025 17:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739685; cv=none; b=n4wARz/rVCMaDaO/ASV5msLiXrOm/zo7PWsQuy1Bul8sQgDVUzNTGwW9m3Edm96exaL+y3tDBnfvMZviRhMCwaK5YPSylqkBZ3Px7IpTuAbbng/GJURM2eOfEgwweo3lxhmD0HjfKFJ8fxBa7uytqE8tZZeOCDiwX0pfzN2vIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739685; c=relaxed/simple;
	bh=69w5XRAVRo4B8tW8B+6me/eiI+8uGbt4kOiC78uyOTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nxf51o7V6/VfhE4uSbXvJhZ0IHfMZNt6b93ImxGJJ+1qMpRLtm8z3L4Srgs15A+eMuzI3KMj/3vD70Zfjg84am2FOcKFw7oPPVPZlGS2qd+t/yAwI+E+y/rkZz++vpVD/kIuHQAgBAQg2vs0AkDfJ2wwlhSuDVCuRHGLlGmaITQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=KiEi9yA6; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 53FHsB8H2944048
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 15 Apr 2025 10:54:17 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 53FHsB8H2944048
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025032001; t=1744739658;
	bh=pNndxC21p/pG47yKhAM5OiOsZZCcOgZwxSGhU/cAUvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KiEi9yA6ruqqdF2JUjfioY3jS2/UX/SSTCdvPiEX8j5tzphKYrItz8YbwBG6cRk3b
	 OAMQlysFsrRvNm+KoEKxyXfL4NXrMR+PzCxMVtSA5PbsVZ16s9kL3mwuYgrYVqp78R
	 QvlkTHan0hoOUyrPRt4KbbWm0odI/W3btdIXEW9ku4MqRnucV2QQr2feJluqQXo0y2
	 QSH/phXacbtci5h+v6ErUirSD5UHQwm8VwbixmQ0plfsGDUgYGFaBKaim1mDDpZhCH
	 iiccAjkLAboE/wV3krjnyRoyFkhRBDyXYsxNYp6qIJkgknff6D/yY7OqdSM74Qzg3H
	 iYvEDRRIIAMBQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org
Subject: [PATCH v1 3/3] x86/cpufeatures: Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES to X86_FEATURE_AMD_HTR_CORES
Date: Tue, 15 Apr 2025 10:54:10 -0700
Message-ID: <20250415175410.2944032-4-xin@zytor.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415175410.2944032-1-xin@zytor.com>
References: <20250415175410.2944032-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shorten X86_FEATURE_AMD_HETEROGENEOUS_CORES to X86_FEATURE_AMD_HTR_CORES
to make the last column aligned consistently in the whole file.

Suggested-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/include/asm/cpufeatures.h       | 2 +-
 arch/x86/kernel/acpi/cppc.c              | 2 +-
 arch/x86/kernel/cpu/scattered.c          | 2 +-
 arch/x86/kernel/cpu/topology_amd.c       | 2 +-
 tools/arch/x86/include/asm/cpufeatures.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 78d0fd7dd690..25243d93d106 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -478,7 +478,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOV	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_HTR_CORES	(21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 78b4e4b40985..7047124490f6 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -272,7 +272,7 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
 	}
 
 	/* detect if running on heterogeneous design */
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES)) {
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES)) {
 		switch (core_type) {
 		case TOPO_CPU_TYPE_UNKNOWN:
 			pr_warn("Undefined core type found for cpu %d\n", cpu);
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 16f3ca30626a..c75c57b32b74 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -53,7 +53,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_HETEROGENEOUS_CORES,	CPUID_EAX, 30, 0x80000026, 0 },
+	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 535dcf511096..4f7a5b737a7f 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -182,7 +182,7 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_topoext = cpu_parse_topology_ext(tscan);
 
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
 		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
 
 	if (!has_topoext && !parse_8000_0008(tscan))
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 3e04290131d7..8f8a7db27eb9 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -478,7 +478,7 @@
 #define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
 #define X86_FEATURE_CLEAR_BHB_LOV	(21*32+ 4) /* Clear branch history at vmexit using SW loop */
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32+ 5) /* Fast CPPC */
-#define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32+ 6) /* Heterogeneous Core Topology */
+#define X86_FEATURE_AMD_HTR_CORES	(21*32+ 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32+ 7) /* Workload Classification */
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 
-- 
2.49.0


