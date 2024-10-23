Return-Path: <linux-acpi+bounces-8931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1909ACF97
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 18:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80461B22917
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 15:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE731C7B6D;
	Wed, 23 Oct 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dxilMT0R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459A1ADFF7;
	Wed, 23 Oct 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699185; cv=none; b=tPZ3buhdtOiKJG/h32n6u/dpAI8ylrZvgf0u0ATj1s7SGVUbkMKiLb0fx5FRVd+jl2jVmY/ypobk0gFHb4DG+5Bq6xAeZ+2KGYfGG6kYupeuPefpNfACGHVpcsuELywm6oe9MDJcaDiW9F+hVOMAzEdd611RAT1VA2WLs8VYpeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699185; c=relaxed/simple;
	bh=GsUOWRzwrE7DG+9tKZ6QZ9Tts8tnJB3rxE8B041WHCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4OHTn7ryWls1m9vmrHMwPmzjq4odAN6UHOWMLDENyZwPnGPtvreRZFG9Wld6I92hzdIe1lbbSBuCCvErDnBO53VCrTs8uNqNM5ve9HAlZ+TvnZo9a/ZWl5KdV+iENUhQmFaF55/n7XCEhhmxe5CFiMxnZk6v1l3FhXtxDc8JvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dxilMT0R; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D571740E0191;
	Wed, 23 Oct 2024 15:59:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id S0igavoDVErJ; Wed, 23 Oct 2024 15:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729699176; bh=THLojGZzwUHgbQk8Z9Tmp68GE4dUsNidwKKD7d7NBh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dxilMT0R4Mb3W2Bd50fQcYJTwrzt3FCFQBqTyM2POa4V967Opf2NKpv1HrtSSgVRs
	 Mzyq8DjCpFM21wP0UMvs9C3MeSVmlQ8c3V06NPuTXOP2Il92ykcTkDQ7pGu7gTxIWo
	 CJC/4CDVax4qi/mNecTYz1YM+O39Dz30yAunZ+cpppB6roacU4dLoNWsdetRFEHDSG
	 qycZJZ+l1eZht/czVKiw+CX52iOVPhWi2KhtJT9qEgHg5eAfk3Av073oqXEYbPoYy7
	 +qd9Z2g4/JeaMgXVeTB4X4gNlWO+bu+49BbmwTEcynjyOSKHXPrRAxuwiEy4+t2eBv
	 R7p4zmLBpd6vGnsS06zPIT4NMvsyxoEuMv/IqBUpL8MQ7K8n0r+QG7AojLshaZVOvM
	 k+pjyquqF8o7b3wJN8HgvC0qnnAclRs4KtRbP5JNRkMv0VG6AcPxjCFyMEK+aGZaLd
	 p9osYly5m7N2Ln+TnGlGq26eO4j4C5wx1ELWEvwo/c89KqJyj1Wwewh2aEyyHRsqyy
	 q5BQap9v1kEz7DAm9Xy8JRhbdJx9xcEq+uS7ep07xiib7V1jIHdOtpe7kqdwQtMAJQ
	 2KAUXRIH7Ta6epNqZXw9XtdckfK6UxOB8XCKsXHLBcyiuxsdppqGnoKkuBtiZG3smB
	 /HcGuyJjlS5oHoeYeTfcLJUw=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9D0A240E0198;
	Wed, 23 Oct 2024 15:59:20 +0000 (UTC)
Date: Wed, 23 Oct 2024 17:59:16 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Message-ID: <20241023155916.GCZxkdVGlNTr461XG4@fat_crate.local>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
 <20241023044015.r3uc5s3g35s7y6ad@desk>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241023044015.r3uc5s3g35s7y6ad@desk>

On Tue, Oct 22, 2024 at 09:40:15PM -0700, Pawan Gupta wrote:
> get_generic_cpu_type(struct cpuinfo_x86 *c)
> {
>      enum x86_topology_cpu_type type;
> 
> 	if (c->x86_vendor == X86_VENDOR_INTEL) {
> 	     switch (c->topo.intel_type) {
> 		     case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
> 		     case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
> 	}
> 	if (c->x86_vendor == X86_VENDOR_AMD) {
> 	     switch (c->topo.amd_type) {
> 		     case 0: return TOPO_CPU_TYPE_PERFORMANCE;
> 		     case 1: return TOPO_CPU_TYPE_EFFICIENCY;
> 	}
> 
> 	return TOPO_CPU_TYPE_UNKNOWN;
> }

Ok...

> get_intel_cpu_type(struct cpuinfo_x86 *c)
> {
> 	return c->topo.intel_type;
> }
> 
> get_amd_cpu_type(struct cpuinfo_x86 *c)
> {
> 	return c->topo.amd_type;

... except those silly wrappers can go. There's a reason cpuinfo_x86 has
well-defined members which can be used directly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

