Return-Path: <linux-acpi+bounces-8958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 286489B0477
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 15:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8147CB21B08
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CC11632DD;
	Fri, 25 Oct 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CJW9J89y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B01E52D;
	Fri, 25 Oct 2024 13:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864082; cv=none; b=iy3OuVEd7XUdzzNYUk/UmiTdBTQRA+Z9mX/iINdOmlO36D0l7lVBl26G9EtR5HilYAjQ2Pl3iLJMlk12MXyYksVgfndp19yX2EpUOGkrxVvhAI87RLgKVOtKmMaZMyTi40l2XoG9GA24NfF4zI2nJ+/K+1l/HLY7dcfyrAGlg3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864082; c=relaxed/simple;
	bh=OnFq4WteU5KRucioQ1H10LmdIxIH0KT/oS2vvPVepv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/L2naQchu3QkTga8FxQsOn/b8CAzpHmhi/1UDFgvl36yDB/hJprs9pzDOk+o4Sr0lEk4avKEnRKqqgd3NlnQswGO0s/WnvKLVFDuqwtVkRS1YAZ0eK+g4+EXuT02n7EAmkpjNr9NCMgXxVra7To0jPFjZ/3DqbQ6hhVTgOVYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CJW9J89y; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D9A7C40E0284;
	Fri, 25 Oct 2024 13:47:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3w6nO41vcqtz; Fri, 25 Oct 2024 13:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729864069; bh=T6XAVjF3P3ZWxOpvmiPo1HttyQrVPVhctAS392r3j/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJW9J89y6ecaVCStPYD7HSZzNw6DVYUorhjcN3hqj6CVHHdHqUzeyexEUlg6gcuTp
	 bHZX8X+seYHJgfGkiyrR9FRefsBwyryGLG8/Skeq4jHA9FNH/Zp054WssoxvzFtSfN
	 zLimaohmMVmA4A6Bi20PdKIzHtweTmqRCAYhCg6LF8b6lzd6zyeL8uQhkpIvsIlKtS
	 HbO9P2t/s+4me6fTPsyKM4KcrxbZne08BUQEb9jMSs5X56eSqwMKOhWx9HZ6WM4z+l
	 U/Gy4GMs3LlfUNfKNdXPD2i/NNQqQH+lzbTWNaNk/ZWdBfJOlcj2pHD3xxKDuGuq9I
	 VClQh9HhiWEGi2qC3/mqN/7KbLOJAK0ZreMx2gKe5aKVCMF9PWY0vURPMXKnEBIt4N
	 dZLsEuSegCa+K/2m9cl/ye21VxsSsewmHmBVm7QMu/WvO1F0nrLEP4pp0GidlfFf61
	 G+fxYVO1ZrNe9QD8tYOamxgViMpFZBte8H0H1RpHt3QdajIkStghiI9pk6BwtgHYd1
	 2HNuub94NNfuELIgLrxxNtvbibaNZy0rghRreIh8AkZ9UFD3GJrjU820rRRh05ntQ+
	 ugJnX+W26rwGFV4VAZItja9ocozDsZDk/Gq3HbO1VNG5/wW3giCxAQ3OF75L2RKpnB
	 GJzDtk+PT7+ate0lxRI4kkE8=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CED8140E028A;
	Fri, 25 Oct 2024 13:47:33 +0000 (UTC)
Date: Fri, 25 Oct 2024 15:47:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Message-ID: <20241025134727.GOZxuhb0MSVESR5juz@fat_crate.local>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
 <20241023174357.34338-5-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023174357.34338-5-mario.limonciello@amd.com>

On Wed, Oct 23, 2024 at 12:43:56PM -0500, Mario Limonciello wrote:
> From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> 
> Sometimes it is required to take actions based on if a CPU is a performance
> or efficiency core. As an example, intel_pstate driver uses the Intel
> core-type to determine CPU scaling. Also, some CPU vulnerabilities only
> affect a specific CPU type, like RFDS only affects Intel Atom. Hybrid
> systems that have variants P+E, P-only(Core) and E-only(Atom), it is not
> straightforward to identify which variant is affected by a type specific
> vulnerability.
> 
> Such processors do have CPUID field that can uniquely identify them. Like,
> P+E, P-only and E-only enumerates CPUID.1A.CORE_TYPE identification, while
> P+E additionally enumerates CPUID.7.HYBRID. Based on this information, it
> is possible for boot CPU to identify if a system has mixed CPU types.
> 
> Add a new field hw_cpu_type to struct cpuinfo_topology that stores the
> hardware specific CPU type. This saves the overhead of IPIs to get the CPU
> type of a different CPU. CPU type is populated early in the boot process,
> before vulnerabilities are enumerated.
> 
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>  * Remove a bunch of boilerplate code
>  * Convert to showing string in debugfs
>  * Rename to get_topology_generic_cpu_type/get_topology_cpu_type_name
>  * Add Intel definitions to intel-family.h
> ---
>  arch/x86/include/asm/intel-family.h   |  6 +++++
>  arch/x86/include/asm/processor.h      | 18 ++++++++++++++
>  arch/x86/include/asm/topology.h       |  9 +++++++
>  arch/x86/kernel/cpu/debugfs.c         |  1 +
>  arch/x86/kernel/cpu/topology_amd.c    |  3 +++
>  arch/x86/kernel/cpu/topology_common.c | 34 +++++++++++++++++++++++++++
>  6 files changed, 71 insertions(+)

Except the minor touchup below, I don't have any complaints about this
anymore.

Intel folks?

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 795619ea1334..9f9376db64e3 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -156,7 +156,7 @@ extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
-enum x86_topology_cpu_type get_topology_generic_cpu_type(struct cpuinfo_x86 *c);
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
 static inline unsigned int topology_max_packages(void)
 {
diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
index 60d5d74189a3..8277c64f88db 100644
--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -28,7 +28,7 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
 	}
 }
 
-enum x86_topology_cpu_type get_topology_generic_cpu_type(struct cpuinfo_x86 *c)
+enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c)
 {
 	if (c->x86_vendor == X86_VENDOR_INTEL) {
 		switch (c->topo.intel_type) {
@@ -48,7 +48,7 @@ enum x86_topology_cpu_type get_topology_generic_cpu_type(struct cpuinfo_x86 *c)
 
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
 {
-	switch (get_topology_generic_cpu_type(c)) {
+	switch (get_topology_cpu_type(c)) {
 	case TOPO_CPU_TYPE_PERFORMANCE:
 		return "performance";
 	case TOPO_CPU_TYPE_EFFICIENCY:

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

