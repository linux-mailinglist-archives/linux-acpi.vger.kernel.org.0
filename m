Return-Path: <linux-acpi+bounces-7119-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2AD940345
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 03:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FE31B217CD
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Jul 2024 01:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDA2905;
	Tue, 30 Jul 2024 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhLx/YnX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F0C6FD3;
	Tue, 30 Jul 2024 01:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722302193; cv=none; b=g36ijuIL/2v+qJUpM0nYM9ZXx038fq6NW0OXEzNo33mnXL6UiqlSqgDM2A2MiisyExcwWrZf2almkC904223dr4mamKHQ/JlvP6PiXS8hSz6LRIaAAkCBrbHA65twHI4jKcS5+Yc8RTqoZKS7QmtJchb7GVAov8+ArV7gamHddM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722302193; c=relaxed/simple;
	bh=SxYB33kknq3g61Lw+Frbi/7XC84m2aM2NRAipQSxfZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xv4z5vpMeF7qjo7KIBFuAinbqF36UfQ3p8yJtruJXQv7rcgAZYzUnzmRpJjCRsxeTdkJSuEaYIIay5cK7pG5Ii89Zaz+GO/4sFQ4VDLoxC6ENiFSx+Nrb3Vr682v0jgDHpyv62aMvN8OsC2vjuDA8FcGIhpMcE9liU4N9obo0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhLx/YnX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722302192; x=1753838192;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SxYB33kknq3g61Lw+Frbi/7XC84m2aM2NRAipQSxfZ0=;
  b=fhLx/YnXc2WwwaifyAch5Pguy3P/gp/1UFces3gfnbFVyLnSN338Fwse
   RjUZmwFQMEgKgF8a6VbDun5FIdJAkW9o+5oJFM5xRHX2XOrqFc32H1FjV
   X4gArAyYlgL2hqNsM23hqYJMTIhPfps/rZbZUawYdIR9W9BhU6Zc4fvsG
   45QMNhUvEFZLlEEKW09Zdq1zyqym+8u8RbLENjJYmpi4XY0OxBsD4iKYg
   vExy4oO7GcTepGQ1UKXnZwkWnTn3W8MfeFmSSIV+d7uNi9Vu03Q8O4td4
   o2zKNKWVl6i09jwryLDpq7/0IHdNpH7klqwCcsdt9sOHIl5laIm1YPjHH
   Q==;
X-CSE-ConnectionGUID: B6tgRBgaTreuDrYSGwu03Q==
X-CSE-MsgGUID: vsqvDjElRXasVVx7O7763g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19933797"
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="19933797"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:16:32 -0700
X-CSE-ConnectionGUID: tm+3ugd8QyKNtsjjBQf4Vw==
X-CSE-MsgGUID: aJ1byG5/ROWt+SDXLRMMpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,247,1716274800"; 
   d="scan'208";a="54131848"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 18:16:29 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org,  akpm@linux-foundation.org,  dave.jiang@intel.com,
  Jonathan.Cameron@huawei.com,  horenchuang@bytedance.com,
  linux-kernel@vger.kernel.org,  linux-acpi@vger.kernel.org,
  dan.j.williams@intel.com,  lenb@kernel.org, Aneesh Kumar K.V
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] acpi/hmat,mm/memtier: always register hmat adist
 calculation callback
In-Reply-To: <ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com> (Gregory Price's
	message of "Mon, 29 Jul 2024 10:22:52 -0400")
References: <20240726215548.10653-1-gourry@gourry.net>
	<87ttg91046.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<ZqelvPwM2MIG26wY@PC2K9PVX.TheFacebook.com>
Date: Tue, 30 Jul 2024 09:12:55 +0800
Message-ID: <877cd3u1go.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Gregory Price <gourry@gourry.net> writes:

> On Mon, Jul 29, 2024 at 09:02:33AM +0800, Huang, Ying wrote:
>> Gregory Price <gourry@gourry.net> writes:
>> 
>> > In the event that hmat data is not available for the DRAM tier,
>> > or if it is invalid (bandwidth or latency is 0), we can still register
>> > a callback to calculate the abstract distance for non-cpu nodes
>> > and simply assign it a different tier manually.
>> >
>> > In the case where DRAM HMAT values are missing or not sane we
>> > manually assign adist=(MEMTIER_ADISTANCE_DRAM + MEMTIER_CHUNK_SIZE).
>> >
>> > If the HMAT data for the non-cpu tier is invalid (e.g. bw = 0), we
>> > cannot reasonable determine where to place the tier, so it will default
>> > to MEMTIER_ADISTANCE_DRAM (which is the existing behavior).
>> 
>> Why do we need this?  Do you have machines with broken HMAT table?  Can
>> you ask the vendor to fix the HMAT table?
>>
>
> It's a little unclear from the ACPI specification whether HMAT is
> technically optional or not (given that the kernel handles missing HMAT
> gracefully, it certainly seems optional). In one scenario I have seen
> incorrect data, and in another scenario I have seen the HMAT omitted
> entirely. In another scenario I have seen the HMAT-SLLBI omitted while
> the CDAT is present.

IIUC, HMAT is optional.  Is it possible for you to ask the system vendor
to fix the broken HMAT table.

> In all scenarios the result is the same: all nodes in the same tier.

I don't think so, in drivers/dax/kmem.c, we will put memory devices
onlined by kmem.c in another tier by default.

> The HMAT is explicitly described as "A hint" in the ACPI spec.
>
> ACPI 5.2.28.1 HMAT Overview
>
> "The software is expected to use this information as a hint for
> optimization, or when the system has heterogeneous memory"
>
> If something is "a hint", then it should not be used prescriptively.
>
> Right now HMAT appears to be used prescriptively, this despite the fact
> that there was a clear intent to separate CPU-nodes and non-CPU-nodes in
> the memory-tier code. So this patch simply realizes this intent when the
> hints are not very reasonable.

If HMAT isn't available, it's hard to put memory devices to
appropriate memory tiers without other information.  In commit
992bf77591cb ("mm/demotion: add support for explicit memory tiers"),
Aneesh pointed out that it doesn't work for his system to put
non-CPU-nodes in lower tier.

Even if we want to use other information to put memory devices to memory
tiers, we can register another adist calculation callback instead of
reusing hmat callback.

--
Best Regards,
Huang, Ying

