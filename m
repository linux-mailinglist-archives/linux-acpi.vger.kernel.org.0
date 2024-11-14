Return-Path: <linux-acpi+bounces-9590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1E9C8EB1
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 16:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FEEF1F21BAA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 15:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C502218BBA3;
	Thu, 14 Nov 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dao/fzUG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161B18A6DD;
	Thu, 14 Nov 2024 15:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598977; cv=none; b=twELnMIEqJmVsZsXSVDYSbNoYLDH99/JrFy8fBL5dD/CO7fdxxCALf/Ba2AIi5GO/36F3GsoqHsZ6v2xF+SN5jQ4pneDEbfkRI/PY8Y0KmEMQPQ6ip5Ysiy5GIjEQhjDuKSkvRFdfxWfS4hfhPudXYXnAS8OXTO9TDCnk+oUxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598977; c=relaxed/simple;
	bh=jk4S6Bk4Q0fqz/lxF2uzaH+S7bSOgCsQ5hk+2n65F3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlTeihdkYBDbyOoy943ox/1lmQvrEwpMXjfc+Mx62fwEOVvLRllkXzUfvktFIyBTpI9BbNuSyKsFaefp1qll6CXTd1W+tifuU4s5c8J8ENsrGcloDONoR6lBxAkvt9wx5MUkVVZXtRH2+YDK5PSM1tqQuXicgMOXbMbO/bIyog8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dao/fzUG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731598976; x=1763134976;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jk4S6Bk4Q0fqz/lxF2uzaH+S7bSOgCsQ5hk+2n65F3s=;
  b=dao/fzUGXZjSPhLJ2cilhYux5eHM2rlOyZYHt3AHeKMdKEHPKcHcbt2X
   dC9YaqRFJxs0nCrgOjqtyJykTGKSgBCRNU69LcjfEYEQzFTFw+AhhUJmp
   ylO5XEUc+Uff9JXGwrZHBDY1ogjPkFZ/ZXOT7SxVYHUsANoLHyS2Z+CAp
   Aq92NyiLXwj8ifrHQJmBzSMNSn3YE3qSGXPxP0dopjxc4YZ6ZWLJ+MYy5
   cMB5EA4tNjM/uda9Bmpb8ib+z2KusNVvfHgK/o04dOFL+obiAlsjTTIn6
   SDoCttyvXute2dKXp84+d583nxa60N2jgn3GxqrfTRCFItOWvd7pZY3Je
   Q==;
X-CSE-ConnectionGUID: 4Aq3UIgXR46OV/ny78fuCg==
X-CSE-MsgGUID: lPsdtd3ZTWuosvNRFSUuwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31731222"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31731222"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:42:56 -0800
X-CSE-ConnectionGUID: H8PO0C5zRemi7dbFBenCpA==
X-CSE-MsgGUID: /jsnB3PbSyyUcQ1c166UmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="89021628"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.62]) ([10.125.108.62])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 07:42:54 -0800
Message-ID: <f13b285d-cf5b-4edf-a7d5-933ccd20556a@intel.com>
Date: Thu, 14 Nov 2024 08:42:53 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] acpi: nfit: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl
To: Suraj Sonawane <surajsonawane0215@gmail.com>, dan.j.williams@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com
Cc: rafael@kernel.org, lenb@kernel.org, nvdimm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
References: <20241113125157.14390-1-surajsonawane0215@gmail.com>
 <c69d74f7-4484-4fc6-9b95-d2ae86ead794@intel.com>
 <1cab2343-8d74-4477-9046-7940917fa7be@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <1cab2343-8d74-4477-9046-7940917fa7be@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/14/24 2:19 AM, Suraj Sonawane wrote:
> On 13/11/24 22:32, Dave Jiang wrote:
>>
>>
>> On 11/13/24 5:51 AM, Suraj Sonawane wrote:
>>> Fix an issue detected by syzbot with KASAN:
>>>
>>> BUG: KASAN: vmalloc-out-of-bounds in cmd_to_func drivers/acpi/nfit/
>>> core.c:416 [inline]
>>> BUG: KASAN: vmalloc-out-of-bounds in acpi_nfit_ctl+0x20e8/0x24a0
>>> drivers/acpi/nfit/core.c:459
>>>
>>> The issue occurs in cmd_to_func when the call_pkg->nd_reserved2
>>> array is accessed without verifying that call_pkg points to a buffer
>>> that is appropriately sized as a struct nd_cmd_pkg. This can lead
>>> to out-of-bounds access and undefined behavior if the buffer does not
>>> have sufficient space.
>>>
>>> To address this, a check was added in acpi_nfit_ctl() to ensure that
>>> buf is not NULL and that buf_len is greater than sizeof(*call_pkg)
>>> before casting buf to struct nd_cmd_pkg *. This ensures safe access
>>> to the members of call_pkg, including the nd_reserved2 array.
>>>
>>> Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
>>> Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
>>> Fixes: ebe9f6f19d80 ("acpi/nfit: Fix bus command validation")
>>> Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
>>> ---
>>> V1: https://lore.kernel.org/lkml/20241111080429.9861-1-surajsonawane0215@gmail.com/
>>> V2: Initialized `out_obj` to `NULL` in `acpi_nfit_ctl()` to prevent
>>> potential uninitialized variable usage if condition is true.
>>> V3: Changed the condition to if (!buf || buf_len < sizeof(*call_pkg))
>>> and updated the Fixes tag to reference the correct commit.
>>>
>>>   drivers/acpi/nfit/core.c | 12 +++++++++---
>>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
>>> index 5429ec9ef..eb5349606 100644
>>> --- a/drivers/acpi/nfit/core.c
>>> +++ b/drivers/acpi/nfit/core.c
>>> @@ -439,7 +439,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>>   {
>>>       struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
>>>       struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
>>> -    union acpi_object in_obj, in_buf, *out_obj;
>>> +    union acpi_object in_obj, in_buf, *out_obj = NULL;
>>
>> Looking at the code later, out_obj is always assigned before access. I'm not seeing a path where out_obj would be accessed unitialized...
> 
> I initialized out_obj to NULL to prevent potential issues where goto out might access an uninitialized pointer, ensuring ACPI_FREE(out_obj) handles NULL safely in the cleanup section. This covers cases where the condition !buf || buf_len < sizeof(*call_pkg) triggers an early exit, preventing unintended behavior.

ok

> 
>>
>> https://elixir.bootlin.com/linux/v6.12-rc7/source/drivers/acpi/nfit/core.c#L538
>>  
>>>       const struct nd_cmd_desc *desc = NULL;
>>>       struct device *dev = acpi_desc->dev;
>>>       struct nd_cmd_pkg *call_pkg = NULL;
>>> @@ -454,8 +454,14 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
>>>       if (cmd_rc)
>>>           *cmd_rc = -EINVAL;
>>>   -    if (cmd == ND_CMD_CALL)
>>> -        call_pkg = buf;
>>> +    if (cmd == ND_CMD_CALL) {
>>> +        if (!buf || buf_len < sizeof(*call_pkg)) {
>>> +            rc = -EINVAL;
>>> +            goto out;
>>> +        }
>>> +        call_pkg = (struct nd_cmd_pkg *)buf;
>>
>> Is the casting needed? It wasn't in the old code
>>
> 
> I tested the code both with and without the cast using syzbot, and it didn't result in any errors in either case. Since the buffer (buf) is being used as a pointer to struct nd_cmd_pkg, and the casting works in both scenarios, it appears that the cast may not be strictly necessary for this particular case.
> 
> I can remove the cast and retain the original code structure, as it does not seem to affect functionality. However, the cast was added for clarity and type safety to ensure that buf is explicitly treated as a struct nd_cmd_pkg *.
> 
> Would you prefer to remove the cast, or should I keep it as is for type safety and clarity?

I would just leave it as it was.

> 
>>> +    }
>>> +
>>>       func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
>>>       if (func < 0)
>>>           return func;
>>
> 
> Thank you for your feedback and your time.


