Return-Path: <linux-acpi+bounces-6878-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1702792FEDB
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEE4286D39
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Jul 2024 16:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249217623E;
	Fri, 12 Jul 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RkORRYgZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C45B157E6B;
	Fri, 12 Jul 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720803571; cv=none; b=YK63rIMepTrywioxPnSDvg/7IZe1j0rmHLTdZmVFAbUhZjl8G9HOtx/yWtPoxAuf6rJdWzIgdJdJHvwMA/T0S6L/aPswK86cFlrm0PIvtCbHip8Flq6LEuuRQbUEIUgT14cxVK1EXZZOl+y1mHvKHJncjGfaIJ4w36QhqSf8JCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720803571; c=relaxed/simple;
	bh=x9ZM1/j8yYnEd24zw5/rw2NXKGigQjhfNiPb4VIXqFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NSUnTBf/qg0L/c6AzSJ78gOo8NgQztMQdULMZZuVdUcjR965Vrm8reOy6ysxeBDMbu5AFDlMIWrX2C3zvMUWwJ4Pm2Km5iWBzCV0+vE8jxXAc7EbryDKMSpKLVcaCanphozNI9KfP6VHo6+sAI+4Dlg1P/XRcDUXrA0KBQKsBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RkORRYgZ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720803569; x=1752339569;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x9ZM1/j8yYnEd24zw5/rw2NXKGigQjhfNiPb4VIXqFQ=;
  b=RkORRYgZ/fe4lvNUQrD3uCUfLHFR1qIgEKO5oDtpO4P4BkjmHKLVTHLf
   oxv/HanzEHcwW7rVTgqLTiHzZt8nNCzpt9Gk7/PXm47npmj6HK3OwMKiP
   2z3u3s1whMd9Egy9joXEJoamJWE5tcbKBYxPklyq44PEnP6q5vCbCDiW1
   WzL4VaaUSZRaPra79HkSY0KaM82Yh1P3D7OBgpyuWC01NVAGmB7OBshPr
   ard8i1NJu98q8KBwpN6ZIsSe9gNZmwZGuMeBhP1Zt5oJ6cyGF8UsPD8ee
   ju42N0djW5r8eV+NMFd3tVw8C+Mjt273DnsKWt9XRDlKRU/2gBIC0YjZD
   Q==;
X-CSE-ConnectionGUID: HOIUen/pTQCrpoYJ0UnYqw==
X-CSE-MsgGUID: i/b+rmTYTz2GiQgjJYj3Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11131"; a="28848032"
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="28848032"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 09:59:29 -0700
X-CSE-ConnectionGUID: /FgE2eLUQz2m+H9S1xVpGg==
X-CSE-MsgGUID: Arkeun4/TuOPGe8//C1++A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,203,1716274800"; 
   d="scan'208";a="86462516"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.110.150]) ([10.125.110.150])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 09:59:28 -0700
Message-ID: <23ab3394-8862-4da5-97ee-1355d9a21e40@intel.com>
Date: Fri, 12 Jul 2024 09:59:27 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: HMAT: Mark hmat_set_default_dram_perf() as __init
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Huang, Ying" <ying.huang@intel.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>,
 Ho-Ren Chuang <horen.chuang@linux.dev>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
References: <20240710-fix-modpost-warning-default_dram_nodes-v1-1-8961453cc82d@kernel.org>
 <87jzhsa05p.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAJZ5v0gHHkFnJEf2CQ5Rmz9+_7u1EqBPiycuFL1huPJf9Pvc6Q@mail.gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <CAJZ5v0gHHkFnJEf2CQ5Rmz9+_7u1EqBPiycuFL1huPJf9Pvc6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/12/24 2:40 AM, Rafael J. Wysocki wrote:
> On Thu, Jul 11, 2024 at 8:56 AM Huang, Ying <ying.huang@intel.com> wrote:
>>
>> Nathan Chancellor <nathan@kernel.org> writes:
>>
>>> After commit 4dc70b711dbc ("memory tier: consolidate the initialization
>>> of memory tiers"), there is a modpost warning when
>>> hmat_set_default_dram_perf() is not inlined into its callsite, as it
>>> appears that default_dram_nodes may be accessed after its memory has
>>> been freed.
>>>
>>>   WARNING: modpost: vmlinux: section mismatch in reference: hmat_set_default_dram_perf+0x18 (section: .text) -> default_dram_nodes (section: .init.data)
>>>
>>> The single callsite, hmat_init(), is __init, so this warning is not a
>>> problem in reality but it is easily solvable by marking
>>> hmat_set_default_dram_perf() as __init, which should have been done when
>>> this function was added in commit 3718c02dbd4c ("acpi, hmat: calculate
>>> abstract distance with HMAT").
>>
>> Good catch!  Thanks for your fix!  If it's necessary, feel free to add
>>
>> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> Thanks for the patch and the review!
> 
> I'm expecting Dan/Dave to take care of it (or please let me know if
> I'm expected to pick it up).
> 
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202406292310.hlRATeZJ-lkp@intel.com/
>>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
>>> ---
>>> I left off a fixes tag as I assume this is going to be squashed into the
>>> former change mentioned above, as it is still in mm-unstable, but feel
>>> free to add one if the patch is going to be standalone.

Should this be picked up by Andrew instead since it's already in mm-unstable?

>>> ---
>>>  drivers/acpi/numa/hmat.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>>> index a2f9e7a4b479..ca0c0ea3e1ef 100644
>>> --- a/drivers/acpi/numa/hmat.c
>>> +++ b/drivers/acpi/numa/hmat.c
>>> @@ -933,7 +933,7 @@ static int hmat_callback(struct notifier_block *self,
>>>       return NOTIFY_OK;
>>>  }
>>>
>>> -static int hmat_set_default_dram_perf(void)
>>> +static __init int hmat_set_default_dram_perf(void)
>>>  {
>>>       int rc;
>>>       int nid, pxm;
>>>
>>> ---
>>> base-commit: 17bcc624e67da6383060ee24483db77aa17276aa
>>> change-id: 20240710-fix-modpost-warning-default_dram_nodes-38b6faffe3da
>>>
>>> Best regards,
>>
>> --
>> Best Regards,
>> Huang, Ying
>>

