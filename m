Return-Path: <linux-acpi+bounces-8905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7F9AB354
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 18:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDB61F24A6A
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 16:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F631B5EB0;
	Tue, 22 Oct 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U77OVPOO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD416139CEF;
	Tue, 22 Oct 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612997; cv=none; b=TWRb76m7vwxxcbQBR0uQnYwLn0zj7qkD/09EknuqsCTpUb2LLATqWor3eDghuFOpghxr93kAOaOPqE42E31JjXwQ36fgkIcCX2Tsu3NCWfwDnnAa/xl9KhIlX9u/8nHJr4BGQoRIntjs/SMLq98i9yXsoQF98CIST1Jf/MxWmho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612997; c=relaxed/simple;
	bh=ISVdsy4ol+QmH4I1SCgwtlnI5AxGo+ZDt6xAM4TS7po=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTrKq+DPNaSHSC3kWSbk9WU+sqQlH1AFYAGa/W1xxdEggrctMCu25qyW4wrJ0fRvZ7u+ku1RFMG9t9R8gw1CP8ttmlnTwAAHglTHsk2XXk3L2v+o49FnMdNZ7tgw4excBUyGqQXxAULGqvP5xoA3H8xO7Fa7RRRSuFfZ7AuTc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U77OVPOO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729612996; x=1761148996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ISVdsy4ol+QmH4I1SCgwtlnI5AxGo+ZDt6xAM4TS7po=;
  b=U77OVPOOpzCwOEmtskAM51d8EMhO3S/vHc2fdaiATbAxdAw1pQWMLmpw
   im25xMScO1x16XCcFl1IDrhcdDThMD7hIU6Oa5yxaNyl46i2KViWt+pdt
   qQKPCFMKz91RL5YAyWy79PMtI3EFzESKuqtb09EK2MSoIoToQ4Iw23mJe
   I9E+h4KWoSYCl8xQdzIBgD7LR946QfzLpu6Y8zRQ19dwjInmNyqpIrs8d
   ox5rdFQtr+BMaFPtKPIA+BPowlR9koa5DvCnADAFE0PX8uUhZjTjYq9Ex
   mbeF1Fh5sK9NeT0v0IUXH9h1n8I684s70epoeoWkbRrkk8NOW4tj+RRyg
   Q==;
X-CSE-ConnectionGUID: ZMiAnSKuShS+1GxDGlXfvw==
X-CSE-MsgGUID: LISvUtt/SK6PY2t0+WurBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29271981"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29271981"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:03:15 -0700
X-CSE-ConnectionGUID: y5gz1it2S0ySWm4h6zKsRw==
X-CSE-MsgGUID: 9WhImbTmRcq96Ok9+EWd3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79859709"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.124.220.121]) ([10.124.220.121])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 09:03:13 -0700
Message-ID: <4476c7a5-bc48-4686-b815-3fae0838b7f9@intel.com>
Date: Tue, 22 Oct 2024 09:03:12 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
To: Borislav Petkov <bp@alien8.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/22/24 04:57, Borislav Petkov wrote:
> +enum x86_topology_cpu_type get_intel_cpu_type(struct cpuinfo_x86 *c)
> +{
> +	switch (c->topo.intel_type) {
> +	case 0x20: return TOPO_CPU_TYPE_EFFICIENCY;
> +	case 0x40: return TOPO_CPU_TYPE_PERFORMANCE;
> +	}
> +	return TOPO_CPU_TYPE_UNKNOWN;
> +}

This makes me feel a _bit_ uneasy.  0x20 here really does mean "Atom
microarchitecture" and 0x40 means "Core microarchitecture".

We want to encourage folks to use this new ABI when they want to find
the fastest core to run on.  But we don't want them to use it to bind to
a CPU and then deploy Atom-specific optimizations.

We *also* don't want the in-kernel code to do be doing things like:

	if (get_intel_cpu_type() == TOPO_CPU_TYPE_EFFICIENCY)
		setup_force_cpu_bug(FOO);

That would fall over if Intel ever mixed fast and slow core types with
the same microarchitecture, which is what AMD is doing today.

Having:

	TOPO_CPU_TYPE_EFFICIENCY, and
	TOPO_CPU_TYPE_PERFORMANCE

is totally fine in generic code.  But we also need to preserve the:

	TOPO_HW_CPU_TYPE_INTEL_ATOM
	TOPO_HW_CPU_TYPE_INTEL_CORE

values also for use in vendor-specific code.

In the ABI, I think we should probably make this an explicit
power/performance interface rather than "cpu_type".  As much as I like
the human readable "performance" and "efficiency", I'm worried it won't
be flexible enough for future maniacal hardware designers.  To be 100%
clear, all the hardware designs that I know of would fit in a two-bucket
("performance" and "efficiency") scheme.  But we've got to decide
whether to commit to that forever.

