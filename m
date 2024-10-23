Return-Path: <linux-acpi+bounces-8928-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2328D9ABC88
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 05:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE9B6B21B18
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 03:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D14130E58;
	Wed, 23 Oct 2024 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MDhCOrFH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913520323;
	Wed, 23 Oct 2024 03:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729655951; cv=none; b=TVT5YvRR+Hzm4FHBt67oKRn19yRZf6Vaec0e0+tIerbxe25Czgy46LIyaC84vyMTyYfRx/AEqEWxCM/QSPayBdRRWES+PCxf7WVYOfSm6Z2iTdhwHXQ9SpdUEwzET1/sPsD2KCrTgBM+MHTDtNLCd3xKmAkkVFB2w4vqScuamJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729655951; c=relaxed/simple;
	bh=g5cqLHIhhziHP8DCtHjYhtoc/ooi/oC22aoIYVVEMTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsP0RulvTIyCFye54dk6k0skA9KZ3ydRMtwTf7x9fDR1oZmnaSRabrOZONFDTBUk80n/SeqBAWHHNQq2rWqDgkUPuX0Iu7m7TDNBLZdd5TDAQN64UD067rnnKfQ+3GtA7yqCyNi3+a1ReK8mO9gaD8EgScY2qxh3BoQmMHg1vsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MDhCOrFH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729655950; x=1761191950;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g5cqLHIhhziHP8DCtHjYhtoc/ooi/oC22aoIYVVEMTQ=;
  b=MDhCOrFHtI+AYrRKTlN3E3iRFLty3mMoBiykeEWSM35GZNylI2EDbn78
   NDSoad0a0LlJ4fKyqbFKV9R2k1TYiQ8hXyWA6/A0Gt2fQodH1bJzLUdod
   jRpBkWIJOhUVCGu4alk64zyzgmGsvwdGwHlPkNn6RAaZ/VJh4lr4fsW55
   /tbgbev9NKAqHozFJvxkhXlzuqLIIp/i6GSIpegfdi7LKeJ4cLOBqLPe1
   bieZPMGdSc7vv/GBQJyp8ag/IWBplz3p38o3LgsJnGlbuYCn/8YPYL0BZ
   LCfhhFMg9CfqqcWlV9ux+CsN/jbqv2cz8NdVUQClnYosxdlN1zh8BnPik
   A==;
X-CSE-ConnectionGUID: YLn1Tfg4QWy5BuZopfGYUA==
X-CSE-MsgGUID: sR9ZIYJgTUG3/VmVT/Jwjw==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="16845939"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="16845939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:59:09 -0700
X-CSE-ConnectionGUID: RB5AmNbMTyept5cv29GXZA==
X-CSE-MsgGUID: PQHENjMvR9K6VfaBxfz2Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="84050895"
Received: from jwolwowi-mobl.amr.corp.intel.com (HELO desk) ([10.125.147.24])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 20:59:08 -0700
Date: Tue, 22 Oct 2024 20:58:56 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20241023035829.pq6uurkajiv3vpfv@desk>
References: <20241022034608.32396-1-mario.limonciello@amd.com>
 <20241022034608.32396-5-mario.limonciello@amd.com>
 <20241022115720.GGZxeTIEqLBQwHjsiE@fat_crate.local>
 <4476c7a5-bc48-4686-b815-3fae0838b7f9@intel.com>
 <13fd2271-f64e-4573-afdb-9881b8c399fe@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13fd2271-f64e-4573-afdb-9881b8c399fe@amd.com>

On Tue, Oct 22, 2024 at 11:13:00AM -0500, Mario Limonciello wrote:
> > This makes me feel a _bit_ uneasy.  0x20 here really does mean "Atom
> > microarchitecture" and 0x40 means "Core microarchitecture".
> > 
> > We want to encourage folks to use this new ABI when they want to find
> > the fastest core to run on.  But we don't want them to use it to bind to
> > a CPU and then deploy Atom-specific optimizations.
> > 
> > We *also* don't want the in-kernel code to do be doing things like:
> > 
> > 	if (get_intel_cpu_type() == TOPO_CPU_TYPE_EFFICIENCY)
> > 		setup_force_cpu_bug(FOO);
> > 
> > That would fall over if Intel ever mixed fast and slow core types with
> > the same microarchitecture, which is what AMD is doing today.
> > 
> > Having:
> > 
> > 	TOPO_CPU_TYPE_EFFICIENCY, and
> > 	TOPO_CPU_TYPE_PERFORMANCE
> > 
> > is totally fine in generic code.  But we also need to preserve the:
> > 
> > 	TOPO_HW_CPU_TYPE_INTEL_ATOM
> > 	TOPO_HW_CPU_TYPE_INTEL_CORE
> > 
> > values also for use in vendor-specific code.
> 
> What you're suggesting is to keep an enum in the intel.c code and any code
> that needs to match atom vs core can directly use
> 
> c->topo.intel_type == TOPO_HW_CPU_TYPE_INTEL_ATOM

To be able to match ATOM and CORE in the affected processor table, the
enums need to be defined in a way that they can be used in the common code.
Specially for !CONFIG_CPU_SUP_INTEL case.

