Return-Path: <linux-acpi+bounces-8903-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08FA9AA1AD
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 14:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFDBA1C2111E
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 12:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CA319ABD5;
	Tue, 22 Oct 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Dl0lNlbN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1ED155352;
	Tue, 22 Oct 2024 12:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729598641; cv=none; b=FukqSPlhThVGMSE1awPS25gWtxh2bQYs15BOHJx1i5OmVI3QtYh73/Ylz/MFPzepCfjEZRx0kVDzcpU/pt6//tO9MJxGfOJbEUTJMKrE29p21741G1z85LInibzHUJsL1prVqUC7vgEAIJG4P7Jg+CwgsYz6h34bPbAkqf6W6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729598641; c=relaxed/simple;
	bh=NgCtIzKiGY/nslo9ezbBgMQ1pL7i1/faclhNOFZQpJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCP9eu0PFNSJU9Z5s8Ihmmypzr070focgwXLlgHNHkR1i5xLxQ9a3dyTnXDzScr66tMgmkNPFOklPtzvhPp3WMCL9C++2MQOREuhABGgRHnTBkkfK7lcK+WEn8SUKXik8qVypZss/sA6qew50FxNdJwG0ET02R11/j2O33T9bWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Dl0lNlbN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4CA3840E0198;
	Tue, 22 Oct 2024 12:03:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cgcp_Bd57fi2; Tue, 22 Oct 2024 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729598633; bh=aK7P9pIYchVSzDvlVR3vBAJ4PDLSNW38/lQvSJv3ax8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dl0lNlbN/KcTdK/5Yahtwj9XVdcCPMdx8jaesTsiP0dWeqYRBNtm6YAH2t1MOvrMe
	 owAcrte1DCYlesPXaJQavnwnyhAIUCIIw6XfpxHKL/5zpqeiq1fWOfb/TruTCcwiEz
	 J6oFV+17exskkkjoBOmk33ROgrvl8jm+2SvvPlCG+08Az9nEvs4vEf9gkBfbRrV+mo
	 OJOuoMTd8CaXmL+GLJoHMbQg5efMXg6G5eIAVlxCyzOlszy8yyvTyrpz/Jwzy8nq49
	 qQiJ3naHQsCbSORUg4B9LO0VNvMdVuP45XMq3t52PTOtjhEbfbMthoabvLeAbXGWZO
	 /OxYWkvy32wlSxA9glrYF4BS3Sly1eIrpqWCRZbC50NDROPT8HPzkJRRNnLUpQO6qV
	 gs5LLVOYq3ZYPNs2PphBz5WFeqPRkrI8MSHFiEFmIBLaMI0pO8eObvH6vbmWHTlw9S
	 ts4xs20xBZKpvt2IuERxy4gFh6k0jqiUZLUKBoIUrpOxzawUXoR3237QihkoHn/rnv
	 YdsBOZuks/vfkGluZl3uL1e1rHChsB8IcCAJ53QZV8hkNRlw51hHZDP0Ls/OVbXFCj
	 Vs4KF9hJMdfdgXlxODSj572RhVQVbGxZxGyX44ascwDnjuKvibAIarP7QaSfNwcuOB
	 T2bzom07+h+/pcRe6yRtijbQ=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE5D840E015F;
	Tue, 22 Oct 2024 12:03:36 +0000 (UTC)
Date: Tue, 22 Oct 2024 14:03:36 +0200
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
Message-ID: <20241022120336.GCZxeUmHL5p6chpt0m@fat_crate.local>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>

On Tue, Oct 22, 2024 at 01:57:20PM +0200, Borislav Petkov wrote:
> diff --git a/arch/x86/kernel/cpu/topology_common.c b/arch/x86/kernel/cpu/topology_common.c
> index 9a6069e7133c..38220b64c6b3 100644
> --- a/arch/x86/kernel/cpu/topology_common.c
> +++ b/arch/x86/kernel/cpu/topology_common.c
> @@ -27,6 +27,23 @@ void topology_set_dom(struct topo_scan *tscan, enum x86_topology_domains dom,
>  	}
>  }
>  
> +const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c)
> +{
> +	enum x86_topology_cpu_type type;
> +
> +	if (c->x86_vendor == X86_VENDOR_INTEL)
> +		type = get_intel_cpu_type(c);
> +	if (c->x86_vendor == X86_VENDOR_AMD)
> +		type = get_amd_cpu_type(c);
> +
> +	if (type == TOPO_CPU_TYPE_PERFORMANCE)
> +		return "performance";
> +	else if (type == TOPO_CPU_TYPE_EFFICIENCY)
> +		return "efficiency";
> +	else
> +		return "unknown";
> +}

I guess you still need topology_cpu_type() in your next patch but that's easy
- you simply call it in get_topology_cpu_type_name().

The point being debugfs will dump the name of the core type and not some magic
number which no one knows.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

