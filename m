Return-Path: <linux-acpi+bounces-11149-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2856A34066
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E4616A775
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Feb 2025 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0EF22154A;
	Thu, 13 Feb 2025 13:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D30h3pef"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65270830
	for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453471; cv=none; b=Ha/crnPh1bVv8f6JI0HKbaHDBEJ9KJZQAW3BgkhiNoQrNt21xFEiEugUFwis7cmR2aVAWFgGizQTesrljmji5Tpd4G1z5q8tksCV7uU+a1mf7diUZpFyteC+JTqgdNoo4yVxDnEMikzXP/xF9L3uhj9XR/l2jYjhIe9o0mQXRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453471; c=relaxed/simple;
	bh=dOATMjDzOPalxL1eUQa9QCm1USug2Hqz+6q3MMEZu58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2bLWRdga2ChJ+b5UllcJEPJEyoYZVhtfQMElhIiNa2zSGu6lzUbPnFYrLKeEx+7vX0C5l+4O1cjGzwekwZ1aqc+ILLmF2ox7AYK4QerG9ndY8qY76cZXOfGXw0BtRzwj1goqEmonipT3qIDFkyWagAIFkLoEJSbRdvzpB3bosI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D30h3pef; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739453468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JjpRJqtASrs0zPy9YEw4HWdsUUlvDyIX7wqjcyCj9/k=;
	b=D30h3pefwJmtabmKJuGO9BmcMVgpemK77ZuEd5zp+y1pFKAI81HIQso9H8mZ2CO7CsNeLa
	hW0X5qCmMuxkUVLW+vSO5EmFK1NhSnvD5FoV+7mmyLDHddkx43PEdW4KNHZ8xNzZ5Gt/B1
	OEV8f98K2uZIjF0ty/CvPEjzAw/m3mI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-PgDss4LlMU67py_dYLTGvw-1; Thu, 13 Feb 2025 08:31:07 -0500
X-MC-Unique: PgDss4LlMU67py_dYLTGvw-1
X-Mimecast-MFC-AGG-ID: PgDss4LlMU67py_dYLTGvw_1739453466
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43961fb0bafso3603875e9.2
        for <linux-acpi@vger.kernel.org>; Thu, 13 Feb 2025 05:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739453466; x=1740058266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JjpRJqtASrs0zPy9YEw4HWdsUUlvDyIX7wqjcyCj9/k=;
        b=H5oQAbcoXxc6/V6QDGDs+/IqRDekXGh+W3HeeLgKowqmLT1VcWl799en+sej4dTtoE
         tHo3zwD6e+qOVkvxha+I++TeeMEd3CrRiyNL1vfB9NPAGXY3bydFeWbr5kBQkbe5yDlj
         dyuNXfr/bfjzwp5ez4S/Qo73CWvPUTd1l9CtOIHeZi+hnM8X32mbVYYNL4+wGPEIe1tG
         eFLFk9Uq1lbSH1eEGthj8koLYxZ36HKnre3xviv4aG5dlWoExxecD8Lw3dvbxvfoFkQK
         a81LW/igfu6G/U6bgksmAXUHHoQ49T0CtvVn7SRRMkARwfSeFsD1pliNPDEoSC9GfeL3
         X0yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZlVvY8P4xu1lATLsZ4+0sUMpI06MUHW0YPvaiQ4tj6vQ4DBWY6Jnl0RZUB/zQq/eMBdFy7GXGIE9c@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnpr2FqTENr04UHl/F7eYxOoXzniMgJaRD24dIayq9Lf4jSHcr
	t5lFd9AkH0clzwNcjKd8rAx+LzSNwafTtEQy7cp4qLmPl55CqTB4O73OLZWFPt2dt3FfmmcCSPh
	T5wE6dfOSe7Z7f6bsa1hhY+8r6IUShYW5UbgrX56bQl3rA6/yqdWz6Dgsp/E=
X-Gm-Gg: ASbGnctgQ/UB2FJPwnYtCXLPns63u5//Onrjl2S/ZZQrJfLM7uQXeadBNhs6OUVzSYG
	ebQiFiZ/I7D1SXZel4XxmXY2lwL8vUF9sjZjhV24vv+E2CRmz0uinxW1D4D8A3ZKKZSlwPcpw3f
	VPAaFv8Y/LUd+raKdJWrL3HemMCZTSZbFcTr10DJ5/JyRqSC9PJ6P0Y8xeArL8qT69SpPSYieR0
	DF7FsXYp6BcxCx/dK0hJX1rjONk+Ecw5zoDCfGSX+h7snXABkF4Vx6hTYY/ll8bAaVM0NK89SrP
	yp+Ls+SUllf7A/LtZ7QsOJnvG8eYmZwJrmW2qIQ0DrJiRy7VASuX/p+hMdR556mbLB9il2NXbyu
	vb3b83NESrYkLlyhJQNHvBVvYTxiUuw==
X-Received: by 2002:a05:600c:501f:b0:439:44eb:2d84 with SMTP id 5b1f17b1804b1-43960179d20mr38301915e9.9.1739453464906;
        Thu, 13 Feb 2025 05:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvhnf4BCsiGYNOPmMT6Fw5WdkyqlOwKTPMiMZbgQwNydA41A8fPbg5T04Z1INYvXVnfGaJOg==
X-Received: by 2002:a05:600c:501f:b0:439:44eb:2d84 with SMTP id 5b1f17b1804b1-43960179d20mr38298995e9.9.1739453462644;
        Thu, 13 Feb 2025 05:31:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c718:100:347d:db94:161d:398f? (p200300cbc7180100347ddb94161d398f.dip0.t-ipconnect.de. [2003:cb:c718:100:347d:db94:161d:398f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259fe1efsm1911948f8f.97.2025.02.13.05.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 05:31:01 -0800 (PST)
Message-ID: <a93beb19-fa0d-4000-812a-a4bfd88d40e5@redhat.com>
Date: Thu, 13 Feb 2025 14:30:59 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ACPI/MRRM: Add "node" symlink to
 /sys/devices/system/memory/rangeX
To: "Luck, Tony" <tony.luck@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Moore, Robert" <robert.moore@intel.com>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown
 <lenb@kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>,
 "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Oscar Salvador <osalvador@suse.de>, Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250210211223.6139-1-tony.luck@intel.com>
 <20250210211223.6139-4-tony.luck@intel.com>
 <2025021111-deepen-landing-4252@gregkh>
 <d19e60d7-8abb-4e46-8935-bc989b1d5d68@redhat.com>
 <SJ1PR11MB6083929661A91F9F60F7C8CBFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <SJ1PR11MB6083929661A91F9F60F7C8CBFCFD2@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.02.25 19:05, Luck, Tony wrote:
>>> What is going to remove this symlink if the memory goes away?  Or do
>>> these never get removed?
>>>
>>> symlinks in sysfs created like this always worry me.  What is going to
>>> use it?
>>
>> On top of that, we seem to be building a separate hierarchy here.
>>
>> /sys/devices/system/memory/ operates in memory block granularity.
> 
> What defines the memory blocks? I'd initially assumed some connection
> to the ACPI SRAT table. But on my test system there are only three
> entries in SRAT that define non-zero sized memory blocks (two on
> socket/node 0 and one on socket/node 1), yet there are:
>      memory0 .. memory32 directories
> in /sys/devices/system/memory.

Each memory block is the same size (e.g., 128 MiB .. 2 GiB on x86-64).

The default is memory section granularity (e.g., 128 MiB on x86-64), but 
some configs allow for increasing it: see 
arch/x86/mm/init_64.c:memory_block_size_bytes(), and in particular 
probe_memory_block_size().

They define in the granularity in which we can online/offline/add/remove 
physical memory managed by the buddy.

We create these block during boot/during hotplug, and link them to the 
relevant nodes.

They do not reflect the HW state, but the state Linux manages that 
memory (through the buddy).

> 
> The phys_device and phys_index files aren't helping me figure out
> what each of them mean.

Yes, see Documentation/admin-guide/mm/memory-hotplug.rst

phys_device is a legacy thing for s390x, and phys_index is just the 
memory block ID.

You can derive the address range corresponding to a memory block using 
the ID.

/sys/devices/system/memory/block_size_bytes tells you the size of each 
block.

Address range of block X:
   [ X*block_size_bytes .. (X+1)*block_size_bytes )


Now, the whole interface her is designed for handling memory hotplug:

obj-$(CONFIG_MEMORY_HOTPLUG) += memory.o

It's worth noting that

1) Blocks might not be all-memory (e.g., memory holes). In that case,
    offlining/unplug is not supported.
2) Blocks might span multiple NUMA nodes (e.g., node ends / starts in
    the middle of a block). Similarly, in that case
    offlining/unplug is not supported.

I assume 1) is not a problem. I assume 2) could be a problem for your 
use case.

> 
>> /sys/devices/system/node/nodeX/ links to memory blocks that belong to it.
>>
>> Why is the memory-block granularity insufficient, and why do we have to
>> squeeze in another range API here?
> 
> If an MRRM range consists of some set of memory blocks (making
> sure that no memory block spans across MRRM range boundaries,
> then I could add the {local,remote}_region_id files into the memory
> block directories.
> 
> This could work now while the region assignments are done by the
> BIOS. But in the future when OS gets the opportunity to change them
> it might be weird if an MRRM range consists of multiple memory
> block range, since the region_ids in each all update together.

What about memory ranges not managed by the buddy (e.g., dax/pmem ranges 
not exposed to the buddy through dax/kmem driver, memory hidden from 
Linux using mem=X etc.)?

> 
> /sys/devices/system/memory seemed like a logical place for
> memory ranges. But should I jump up a level and make a new
> /sys/devices/system/memory_regions directory to expose these
> ranges?

Let's take one step back. We do have

1) /proc/iomem to list physical device ranges, without a notion of nodes 
/ other information. Maybe we could extend it, but it might be hard. 
Depending on *what* information we need to expose and for which memory.

/proc/iomem also doesn't indicate "System RAM" for memory not managed by 
the buddy.

2) /sys/devices/system/memory/memoryX and /sys/devices/system/node/

Again, the memory part is more hotplugged focused, and we treat 
individual memory blocks as "memory block devices".


Reading:

"
The MRRM solution is to tag physical address ranges with "region IDs"
so that platform firmware[1] can indicate the type of memory for each
range (with separate tags available for local vs. remote access to
each range).

The region IDs will be used to provide separate event counts for each
region for "perf" and for the "resctrl" file system to monitor and
control memory bandwidth in each region.

Users will need to know the address range(s) that are part of each
region."

A couple of questions:

a) How volatile is that information at runtime? Can ranges / IDs change?
    I read above that user space might in the future be able to
    reconfigure the ranges.

b) How is hotplug/unplug handled?

c) How are memory ranges not managed by Linux handled?

It might make sense to expose what you need in a more specialized, 
acpi/MRRM/perf specific form, and not as generic as you currently 
envision it.

-- 
Cheers,

David / dhildenb


