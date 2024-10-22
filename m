Return-Path: <linux-acpi+bounces-8902-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1C9AA18B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 13:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28571F231C6
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA72B19CC32;
	Tue, 22 Oct 2024 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eUsq/rpz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D119AA53;
	Tue, 22 Oct 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598273; cv=none; b=h42jW2wGLp6lHmncM6G5M7SY8V5dnnOvEBCDzQSoIU9BGHcA0aENJtY4CeDQGCQVf/yA/OiU0VB3WlIJrhG1o9g37yuF6e7RV8PgeXTIFM/VqzArNn4RWfMUwK3dAwefg9e3caqIeMzFZlLLKFpqEeACF2s0FlquW1MzCaCXd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598273; c=relaxed/simple;
	bh=LJ20BbFLug+ZvEobkVdonxqkNfg30v2aX3uCZO0FKLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqtvoEpjSMUadAmjOzFOv42jx/3kN//uk0Y11RhKHV467/APh2hBv87/TdNqFkFBSmzfms48PgQp3ShmvPcYa0k5WVN2FpPBAhxUwAKZXksQiFQeqjnvpEEBidU+XqoPd0uVmdlECWHPh7/HYnXd229fYr1/KJ2fEWKmDR4B6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eUsq/rpz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 007F940E0198;
	Tue, 22 Oct 2024 11:57:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 74LWwxef6vX0; Tue, 22 Oct 2024 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729598263; bh=Jk5AqbmKWNRZFPGQzSSPF5NSnDH4t+Yz1iAbe3geV9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eUsq/rpz4D4CXM+rTFlxGyy9fyVXq6z7Zv0B8AHG4taFzJ4+5YDhGcK69Tifa3naj
	 1JAfmhxXpETuQ3E68e8jeHDhczBAsQgx1341giSEGqSYwP3Vyq4Qh4JP+2eAOIAyWk
	 NHHuLpPpzJ+KUdgLX8n0teU0G6vjre8WhnKxdU3oQXBLBpIBHzESF5a0pDPAP5tl1Y
	 LocrA+/sSSl17wtFL2w1+8T3LKRREmWA8pnGQMNYN5tEeyTkBSXz8MUPvPTfdR5BOR
	 DA3bSzNpbrk3lMezD5angcZIrI6He04MO83ETG0i1LJkcEHFFZ3Zqme0QK6uj+nq+r
	 DNyNgut7HF2hU2Nuzvodt47pAOGKPAcBv20knkctuytEGv/Mn7AQxPYydud3TsQJE6
	 uf1fpTJdOrNWwudwcKy2p42DDxTZgY/1pMcShQlpNABvEniVvGOyDfwvWxSmwicwG3
	 947q+juk3m9mTqXcW+6DeNzx5XU1pSa/77SzCLH+aPH6O0WJ1i7z9ES75fHwuw7jeQ
	 cYdJIDg9yiiozH8dmnzqtviCFIlDjuVkQ9pzq35oEKoc8nO6KPdO+5ydTWVj43d9Xj
	 OLzPCBxEJ5iP89sat5am1KHDOp+dUVLIAoGdU3LEfrZwS7K3ITpbBkr50ewHT9Skyb
	 I3RrPyU0ePppA40vHCa6CZMY=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9091E40E0184;
	Tue, 22 Oct 2024 11:57:27 +0000 (UTC)
Date: Tue, 22 Oct 2024 13:57:20 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Message-ID: <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022034608.32396-5-mario.limonciello@amd.com>

On Mon, Oct 21, 2024 at 10:46:07PM -0500, Mario Limonciello wrote:
> * Take this patch from Pawan's series and fix up for feedback left on it.
> * Add in AMD case as well

Yah, this one is adding way more boilerplate code than it should. IOW, I'm
thinking of something simpler like this:

---

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 98eced5084ca..44122b077932 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -53,6 +53,7 @@ static inline void bus_lock_init(void) {}
 #ifdef CONFIG_CPU_SUP_INTEL
 u8 get_this_hybrid_cpu_type(void);
 u32 get_this_hybrid_cpu_native_id(void);
+enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c);
 #else
 static inline u8 get_this_hybrid_cpu_type(void)
 {
@@ -63,6 +64,18 @@ static inline u32 get_this_hybrid_cpu_native_id(void)
 {
 	return 0;
 }
+static enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
+{
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
+#endif
+#ifdef CONFIG_CPU_SUP_AMD
+enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c);
+#else
+static inline enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c)
+{
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
 #endif
 #ifdef CONFIG_IA32_FEAT_CTL
 void init_ia32_feat_ctl(struct cpuinfo_x86 *c);
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4a686f0e5dbf..c0975815980c 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -105,6 +105,24 @@ struct cpuinfo_topology {
 	// Cache level topology IDs
 	u32			llc_id;
 	u32			l2c_id;
+
+	// Hardware defined CPU-type
+	union {
+		u32		cpu_type;
+		struct {
+			// CPUID.1A.EAX[23-0]
+			u32	intel_native_model_id	:24;
+			// CPUID.1A.EAX[31-24]
+			u32	intel_type		:8;
+		};
+		struct {
+			// CPUID 0x80000026.EBX
+			u32	amd_num_processors	:16,
+				amd_power_eff_ranking	:8,
+				amd_native_model_id	:4,
+				amd_type		:4;
+		};
+	};
 };
 
 struct cpuinfo_x86 {
diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index aef70336d624..c43d4b3324bc 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -114,6 +114,12 @@ enum x86_topology_domains {
 	TOPO_MAX_DOMAIN,
 };
 
+enum x86_topology_cpu_type {
+	TOPO_CPU_TYPE_PERFORMANCE,
+	TOPO_CPU_TYPE_EFFICIENCY,
+	TOPO_CPU_TYPE_UNKNOWN,
+};
+
 struct x86_topology_system {
 	unsigned int	dom_shifts[TOPO_MAX_DOMAIN];
 	unsigned int	dom_size[TOPO_MAX_DOMAIN];
@@ -149,6 +155,8 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
+
 static inline unsigned int topology_max_packages(void)
 {
 	return __max_logical_packages;
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index fab5caec0b72..7d8d62fdc112 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1205,3 +1205,12 @@ void amd_check_microcode(void)
 	if (cpu_feature_enabled(X86_FEATURE_ZEN2))
 		on_each_cpu(zenbleed_check_cpu, NULL, 1);
 }
+
+enum x86_topology_cpu_type get_amd_cpu_type(struct cpuinfo_x86 *c)
+{
+	switch (c->topo.amd_type) {
+	case 0:	return TOPO_CPU_TYPE_PERFORMANCE;
+	case 1:	return TOPO_CPU_TYPE_EFFICIENCY;
+	}
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
diff --git a/arch/x86/kernel/cpu/debugfs.c b/arch/x86/kernel/cpu/debugfs.c
index 3baf3e435834..10719aba6276 100644
--- a/arch/x86/kernel/cpu/debugfs.c
+++ b/arch/x86/kernel/cpu/debugfs.c
@@ -22,6 +22,7 @@ static int cpu_debug_show(struct seq_file *m, void *p)
 	seq_printf(m, "die_id:              %u\n", c->topo.die_id);
 	seq_printf(m, "cu_id:               %u\n", c->topo.cu_id);
 	seq_printf(m, "core_id:             %u\n", c->topo.core_id);
+	seq_printf(m, "cpu_type:            %s\n", get_topology_cpu_type_name(c));
 	seq_printf(m, "logical_pkg_id:      %u\n", c->topo.logical_pkg_id);
 	seq_printf(m, "logical_die_id:      %u\n", c->topo.logical_die_id);
 	seq_printf(m, "llc_id:              %u\n", c->topo.llc_id);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index d1de300af173..7b1011d0b369 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -907,3 +907,12 @@ u32 get_this_hybrid_cpu_native_id(void)
 	return cpuid_eax(0x0000001a) &
 	       (BIT_ULL(X86_HYBRID_CPU_TYPE_ID_SHIFT) - 1);
 }
+
+enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
+{
+	switch (c->topo.intel_type) {
+	case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
+	case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
+	}
+	return TOPO_CPU_TYPE_UNKNOWN;
+}
diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 7d476fa697ca..03b3c9c3a45e 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -182,6 +182,9 @@ static void parse_topology_amd(struct topo_scan *tscan)
 	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT))
 		has_topoext = cpu_parse_topology_ext(tscan);
 
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
+		tscan->c->topo.cpu_type = cpuid_ebx(0x80000026);
+
 	if (!has_topoext && !parse_8000_0008(tscan))
 		return;
 
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 9a6069e7133c..38220b64c6b3 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -27,6 +27,23 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
+const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
+{
+	enum x86_topology_cpu_type type;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		type = get_intel_cpu_type(c);
+	if (c->x86_vendor == X86_VENDOR_AMD)
+		type = get_amd_cpu_type(c);
+
+	if (type == TOPO_CPU_TYPE_PERFORMANCE)
+		return "performance";
+	else if (type == TOPO_CPU_TYPE_EFFICIENCY)
+		return "efficiency";
+	else
+		return "unknown";
+}
+
 static unsigned int __maybe_unused parse_num_cores_legacy(struct cpuinfo_x86 *c)
 {
 	struct {
@@ -87,6 +104,7 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 		.cu_id			= 0xff,
 		.llc_id			= BAD_APICID,
 		.l2c_id			= BAD_APICID,
+		.cpu_type		= TOPO_CPU_TYPE_UNKNOWN,
 	};
 	struct cpuinfo_x86 *c = tscan->c;
 	struct {
@@ -132,6 +150,8 @@ static void parse_topology(struct topo_scan *tscan, bool early)
 	case X86_VENDOR_INTEL:
 		if (!IS_ENABLED(CONFIG_CPU_SUP_INTEL) || !cpu_parse_topology_ext(tscan))
 			parse_legacy(tscan);
+		if (c->cpuid_level >= 0x1a)
+			c->topo.cpu_type = cpuid_eax(0x1a);
 		break;
 	case X86_VENDOR_HYGON:
 		if (IS_ENABLED(CONFIG_CPU_SUP_HYGON))

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

