Return-Path: <linux-acpi+bounces-8880-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69A9A6EE7
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 17:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32491C22A7C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 15:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EC31CCB3C;
	Mon, 21 Oct 2024 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1wljKeU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE54A1CBEA3
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 15:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526256; cv=none; b=Z0aeMjmbOu9qRFguBHJPe9MXqrLRuHVzEI2HASnvXE+Y0fuWYzIaZJMi3IMAxKXAs6TXIpO6NNLbovSBvb6LDU4ZXdCACekyXcF5rfJA7bX70HrTIHeezeUIPA4bF0RO+lBO/a0SojcVMDfaojhyrKkTKLtDFBwa2F/9ccHGqkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526256; c=relaxed/simple;
	bh=GuBVjdCswPOcpg5ScXk6aUTpFwNNKk4GkyHaPTJrCOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Swou2/BXBtAgWBr6Y/5dqpTZiMm3eXCwqqg77+gqNoaBHqLaoVdSW4oYnBR+Sz6aF46V+KLOEkjEkGKLJSAw7H9ee6xie0TPSubkNRTYXlkrjhgHzTRRdKN+iXyLw+ivJhwlypcQ+NeGC3brnr+s6qilrvu2pNW0IMo0JNZTc4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1wljKeU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729526253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1QlQ2dXZhMX0eKo544n2v7YaT6/JERR2+wEBtNN+cRE=;
	b=D1wljKeUVlM1g6BvDZ0Po7vCMR/YZ6579iHo2q48FxJgnpwadn7f7311X7nYjGL0kagEZZ
	elaBPQN4ix+y14RSg2WylCTnQTbeHqmngVbpOSwDBnuIobjzVHpeZPy4MkfEgjqhP4x4Oa
	DGqiTNlME2JJjXjqQQhgVPchMmZm17M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-qAV7jy91NrmirotMfQDMFg-1; Mon, 21 Oct 2024 11:57:31 -0400
X-MC-Unique: qAV7jy91NrmirotMfQDMFg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315c1b5befso33306165e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 08:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729526250; x=1730131050;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1QlQ2dXZhMX0eKo544n2v7YaT6/JERR2+wEBtNN+cRE=;
        b=B4hAAsf+E/xuzja/mekSDBa8OQAqoW01u2YTD4PaBFvnHPNfUOeETNuc0hzPvNy6Zf
         wzN1BLn8jCNnMy1Ot0HdA0oNXNeOpMPLE4Yc4hHFhg+CAE77d5SDSYqBRNC+sWJPjz4d
         cYA2xA7tnfqQl6BWmhhjFe7PYPqgxc3HQWLOiizoAHj1aZHrB1WbpVRU3hUMUQtU/EtV
         TUs1/Bg51uWG2nk+0bkhCQM721oKEZgubG3+6y9k9MeHA6H0lEhv0oqJTK6YG/QZHOrR
         xYr0QjRdvPrQSmKzS39EjFMsvxc9kGfus4uf7g+fVneikoZATTDGsK2V4K0dSq2qg1Af
         xmDQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3giTZEJMMRaSrUV4j6FbhewoCxS/z5rBfijUDc9txTheCZLI1MA3iLfOU/IO/bdB/7f6k7y5i4uSi@vger.kernel.org
X-Gm-Message-State: AOJu0YwYD8WW4ua8C5GZN9pOiYi/tbr93OkaikUlkBWnX/X1Q/HsYheD
	L1uRKjiB/ZkbT89bZqB+MI8R/VzPsuVggP8peIuZnBrs2wLlzf+KY5C9ZqOQt0dQV+T4PFvomaX
	wvl6VmSHN3a8jW6OuMljIe8lFGj0OPcI9teagBkAnwfFij3CwYgqw4SC+rjvPFjo/E+s=
X-Received: by 2002:a05:600c:4ed2:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-43161622989mr74517295e9.4.1729526250562;
        Mon, 21 Oct 2024 08:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7jzs7xFKTi3jP8Jjtc+4lpuyikIkraQffpHNepeehyLvEhQaPmfAsjgu+PgFf5PV6UVv76Q==
X-Received: by 2002:a05:600c:4ed2:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-43161622989mr74517035e9.4.1729526250182;
        Mon, 21 Oct 2024 08:57:30 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:1600:e899:f836:758b:6fef? (p200300cbc7281600e899f836758b6fef.dip0.t-ipconnect.de. [2003:cb:c728:1600:e899:f836:758b:6fef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f57102asm61064805e9.1.2024.10.21.08.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 08:57:29 -0700 (PDT)
Message-ID: <eb380e90-f5f5-40d5-b0a7-54b2bb50f7a3@redhat.com>
Date: Mon, 21 Oct 2024 17:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] x86: probe memblock size advisement value during
 mm init
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
 haibo1.xu@intel.com, dave.jiang@intel.com
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-3-gourry@gourry.net>
 <7b877356-f5c5-4996-904b-6c3b71389255@redhat.com>
 <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZxZpTlnhYPqg-tGh@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 16:46, Gregory Price wrote:
> On Mon, Oct 21, 2024 at 01:12:26PM +0200, David Hildenbrand wrote:
>>
>>
>> Am 16.10.24 um 21:24 schrieb Gregory Price:
>>> Systems with hotplug may provide an advisement value on what the
>>> memblock size should be.  Probe this value when the rest of the
>>> configuration values are considered.
>>>
>>> The new heuristic is as follows
>>>
>>> 1) set_memory_block_size_order value if already set (cmdline param)
>>> 2) minimum block size if memory is less than large block limit
>>> 3) [new] hotplug advise: lesser of advise value or memory alignment
>>> 4) Max block size if system is bare-metal
>>> 5) Largest size that aligns to end of memory.
>>>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>> ---
>>>    arch/x86/mm/init_64.c | 16 ++++++++++++++++
>>>    1 file changed, 16 insertions(+)
>>>
>>> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>>> index ff253648706f..b72923b12d99 100644
>>> --- a/arch/x86/mm/init_64.c
>>> +++ b/arch/x86/mm/init_64.c
>>> @@ -1439,6 +1439,7 @@ static unsigned long probe_memory_block_size(void)
>>>    {
>>>    	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
>>>    	unsigned long bz;
>>> +	int order;
>>>    	/* If memory block size has been set, then use it */
>>>    	bz = set_memory_block_size;
>>> @@ -1451,6 +1452,21 @@ static unsigned long probe_memory_block_size(void)
>>>    		goto done;
>>>    	}
>>> +	/* Consider hotplug advisement value (if set) */
>>> +	order = memblock_probe_size_order();
>>
>> "size_order" is a very weird name. Just return a size?
>>
>> memory_block_advised_max_size()
>>
>> or sth like that?
>>
> 
> There isn't technically an overall "max block size", nor any alignment
> requirements - so order was a nice way of enforcing 2-order alignment
> while also having the ability to get a -1/-EBUSY/whatever out.

I see. But we (MM) just call it "order" then, like pageblock_order, 
max_order, compound_order ... but here we use "size everywhere" so I 
prefer to just sticking to that.

> 
> I can change it if it's a big sticking point - but that's my reasoning.

Simply enforce it when setting the size. We call it "memory_block_size" 
everywhere and it's also a power-of-2 etc and sanity-check that in 
memory_dev_init().


-- 
Cheers,

David / dhildenb


