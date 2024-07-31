Return-Path: <linux-acpi+bounces-7159-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6CC942425
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 03:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21CA1C213E7
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Jul 2024 01:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DF946F;
	Wed, 31 Jul 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JRQZpw52"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D38BE0;
	Wed, 31 Jul 2024 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722389170; cv=none; b=dT3P/q8J530cfKCijzWzzIRldbIjFgwTRG0Ec62IOtIvlpfASYH5r1YU9U497ZP7klg1BuulrruTem5Wdwtbm46Mec1S3Yu3nTE6i0srlT6ns1GIs4YRb2Y/garLbxmJ47M8zDMeHyAUE/rlR6cbURUvDxoCimAmzDm9XtqxR5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722389170; c=relaxed/simple;
	bh=06LFBPA6T6F2EWn9cPGZo5IMaK6O3uRHX4yqHc0sRf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F7LMXiZsiF1q14cKLnxOtaxIlzABCKgr3IN5YkVIvczkoICM5aMnlyDGkhmy4fRjhP6v8MUJXPxgECGVaenP1GaJus99rOp8rDTSmOHQPIOpjsJbDx1D7Md3kvx7xaCBwD31C6BMm1cvCSztm+SnRbSeXpqMYsUx2KZzZ1nmHGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JRQZpw52; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722389168; x=1753925168;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=06LFBPA6T6F2EWn9cPGZo5IMaK6O3uRHX4yqHc0sRf8=;
  b=JRQZpw52ZF8ucm2W7O2l7EsVEnGl1s8hCaO6zcsU/yeo+CybWxbr4C6s
   /sgC3kAeY0P/c/eOLydQaghNAqoS5uLPiGqf8itIj0BZ2ioLqGjCwmX2b
   muO6YKc28hax0r2fCLzHO+Liboko17RHSOuJzwc9zYQx4H7A1B6Jp/m7t
   Oq0lnfE8JCki3Lf330YsnS9JHWUfuh3YJaY2KsjlFwpZWQsvxJh3KHIKA
   ndlEXSOQYSRxpK5M6YHCCgayhPkfDwDvnAY2+SNTXSxa5eIr/JM+ieFn8
   MzDGS0q/NVTB3okc4Ww6m5LeXrt39GUICefNxd4LH3iBB3tZW94o96pTE
   w==;
X-CSE-ConnectionGUID: dhb7ZssCQvKM1LwvMz5k3g==
X-CSE-MsgGUID: FoPtL126TeeK1c98M+ynpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20398231"
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="20398231"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 18:26:08 -0700
X-CSE-ConnectionGUID: /+iu9CEnTWma/xEo4/qtqg==
X-CSE-MsgGUID: TYcdjIGOQviTnArIcqjAYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,250,1716274800"; 
   d="scan'208";a="54562879"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 18:26:05 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  dave.jiang@intel.com,
  Jonathan.Cameron@huawei.com,  horenchuang@bytedance.com,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  dan.j.williams@intel.com,  lenb@kernel.org,  "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
In-Reply-To: <ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 29 Jul 2024 23:18:16 -0400")
References: <20240726215548.10653-1-gourry@gourry.net>
	<87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
	<877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqhbePA9Egcxyx7o@PC2K9PVX.TheFacebook.com>
Date: Wed, 31 Jul 2024 09:22:32 +0800
Message-ID: <87cymupd7r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Tue, Jul 30, 2024 at 09:12:55AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > On Mon, Jul 29, 2024 at 09:02:33AM +0800, Huang, Ying wrote:
>> >> Gregory Price <gourry@gourry.net> writes:
>> >> 
>> >> > In the event that hmat data is not available for the DRAM tier,
>> >> > or if it is invalid (bandwidth or latency is 0), we can still register
>> >> > a callback to calculate the abstract distance for non-cpu nodes
>> >> > and simply assign it a different tier manually.
>> >> >
>> >> > In the case where DRAM HMAT values are missing or not sane we
>> >> > manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).
>> >> >
>> >> > If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
>> >> > cannot reasonable determine where to place the tier, so it will default
>> >> > to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).
>> >> 
>> >> Why do we need this?  Do you have machines with broken HMAT table?  Can
>> >> you ask the vendor to fix the HMAT table?
>> >>
>> >
>> > It's a little unclear from the ACPI specification whether HMAT is
>> > technically optional or not (given that the kernel handles missing HMAT
>> > gracefully, it certainly seems optional). In one scenario I have seen
>> > incorrect data, and in another scenario I have seen the HMAT omitted
>> > entirely. In another scenario I have seen the HMAT-SLLBI omitted while
>> > the CDAT is present.
>> 
>> IIUC, HMAT is optional.  Is it possible for you to ask the system vendor
>> to fix the broken HMAT table.
>> 
>
> In this case we are (BW=0), but in the other cases, there is technically
> nothing broken.  That's my concern.
>
>> > In all scenarios the result is the same: all nodes in the same tier.
>> 
>> I don't think so, in drivers/dax/kmem.c, we will put memory devices
>> onlined by kmem.c in another tier by default.
>> 
>
> This presumes driver configured devices, which is not always the case.
>
> kmem.c will set MEMTIER_DEFAULT_DAX_ADISTANCE
>
> but if BIOS/EFI has set up the node instead, you get the default of
> MEMTIER_ADISTANCE_DRAM if HMAT is not present or otherwise not sane.

"efi_fake_mem=" kernel parameter can be used to add "EFI_MEMORY_SP" flag
to the memory range, so that kmem.c can manage it.

> Not everyone is going to have the ability to get a platform vendor to
> fix a BIOS bug, and I've seen this in production.

So, some vendor build a machine with broken/missing HMAT/CDAT and wants
users to use CXL memory devices in it?  Have the vendor tested whether
CXL memory devices work?

>> > The HMAT is explicitly described as "A hint" in the ACPI spec.
>> >
>> > ACPI 5.2.28.1 HMAT Overview
>> >
>> > "The software is expected to use this information as a hint for
>> > optimization, or when the system has heterogeneous memory"
>> >
>> > If something is "a hint", then it should not be used prescriptively.
>> >
>> > Right now HMAT appears to be used prescriptively, this despite the fact
>> > that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
>> > the memory-tier code. So this patch simply realizes this intent when the
>> > hints are not very reasonable.
>> 
>> If HMAT isn't available, it's hard to put memory devices to
>> appropriate memory tiers without other information.
>
> Not having a CPU is "other information".  What tier a device belongs to
> is really arbitrary, "appropriate" is at best a codified opinion.
>
>> In commit
>> 992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
>> Aneesh pointed out that it doesn't work for his system to put
>> non-CPU-nodes in lower tier.
>> 
>
> This seems like a bug / something else incorrect.  I will investigate.
>
>> Even if we want to use other information to put memory devices to memory
>> tiers, we can register another adist calculation callback instead of
>> reusing hmat callback.
>> 
>
> I suppose during init, we could register a default adist callback with
> CPU/non-CPU checks if HMAT is not sane. I can look at that.
>
> It might also be worth having some kind of modal mechanism, like:
>
> echo "auto" > /sys/.../memory_tiering/mode     # Auto select mode
> echo "hmat" > /sys/.../memory_tiering/mode     # Use HMAT Info
> echo "simple" > /sys/.../memory_tiering/mode   # CPU vs non-CPU Node
> echo "topology" > /sys/.../memory_tiering/mode # More complex
>
> To abstract away the hardware complexities as best as possible.
>
> But the first step here would be creating two modes.  HMAT-is-sane and
> CPU/Non-CPU seems reasonable to me but open to opinions.

IMHO, we should reduce user configurable knobs unless we can prove it
is really necessary.

--
Best Regards,
Huang, Ying

