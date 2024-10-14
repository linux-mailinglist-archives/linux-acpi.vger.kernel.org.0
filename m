Return-Path: <linux-acpi+bounces-8782-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C3899D843
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 22:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC0B1F2346F
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2024 20:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34471D0E05;
	Mon, 14 Oct 2024 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9q4QnX+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167491C8797
	for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937967; cv=none; b=bktle+sV9mmTjudY6syZ6rl4zlbDTAJLiCHOMCrS/LCTvZY4F9Y7tLgswvqQpT7KlL5lqjvjhwhgamUR7UJb1kVWCzu6r7hAIjI5f5BvatP+2oo5l8oKgsWBbK2KPghmY0sqKsw7HAlNKU2OQ1OviI6v2FXpI4Ik1j/Kjcf6hmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937967; c=relaxed/simple;
	bh=BBWv8m+FJiNZQyLDR69iMqI0y2Tck6kmZY6eB39xR98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1odXBK7AV5eyHDwYU7SvxCBqgTq5pGBUimsi9ntI1fWsF0oDMF/TUOIVbmjwHN7jb9z8psffQJIlqlC2ahQ4MvB4K4MrJM/lSHxgc+C5D6QZg2V1XvKwjG3bvkTYBYp8LZ34wN3+sXpb2IMZtueBU7tW7wxWb7pRVwqHuiimJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9q4QnX+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728937965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iYSwD/C4U7CDnA1i065kPB6l0/mhsEkr4NjLjDag7OY=;
	b=a9q4QnX+gQN6qapqDlGqxS5aYsA1i1Dlawv9GzApI2bK2s30LSfg9EqYizf0hMsZNtcl0X
	Cgjs73y3c/3QwHy6F03wpxkN5t+eSuuP3IqKj63xye/AWLyyZM5/KkRjbcYr4LYAshaYlb
	7iueuAjamWJLXrJ/ZuEtS97F4rhMqno=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-eOued0nsMdSpWMhPQA-Qhg-1; Mon, 14 Oct 2024 16:32:40 -0400
X-MC-Unique: eOued0nsMdSpWMhPQA-Qhg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43117b2a901so38866285e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 14 Oct 2024 13:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728937959; x=1729542759;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYSwD/C4U7CDnA1i065kPB6l0/mhsEkr4NjLjDag7OY=;
        b=JeiUhdffEufjkXW+J5iEC+S4UAi/wJmKPeDIprgL6F6/1iLo1A9eWa8xSvGj/pETI5
         Mpj9+r+eu5XIhupM9uBYf66Br5L68yNbm0Z1uqxz1TKdDGOTyt27xoKz3hbLEPdPHc2Z
         R+o4ZStO9d+NEC1ZSF1VeYYQUochEgYBcU0pzjOqAsRj3X4/5U10rXaKNjXMVSt4fuAM
         3JPT3kbyS50arBqZHv6hkx2BR2WOA+1l/YIcf4+19le4fpkNfGXDxNThJyIDqYTG5GGt
         o6AFUo8Et1eP+eqqnj4FOHVjD1O2lyY50vt3MedYE8q2MuCYtbDu0MThBigjUqJB4Pfa
         mksg==
X-Forwarded-Encrypted: i=1; AJvYcCV9PZ2jOmI4bkYZg0zu3NN0is/GuL/H3U/bI3qWu3wGo7s/ZaP5nthb4QPf8yJgAykBi0GfvH1Cvaj+@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnUP/kR8KUjCGkT09opXwEsOA00ty8yKynFXsQHw2hkTNBf1T
	PklZP9AzyA2+9ANugh7gPiOnHyCG12g5sEqEwZfF9D5DNu01t0CzdsQ37zCnVazniL88qlb+/Nh
	Vl2Uh2TKI0iLLsvWUNKN6dDY2IKd1MVxbMcBx7kzSogGNFeM/URz2xQwv/uc=
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr106233975e9.6.1728937959404;
        Mon, 14 Oct 2024 13:32:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq0m0aS18BUeXh6W+kIpN+6D0hVXo0ZycftiRj3HIxgTiiwKnS80fAE21fY0VFaQLbbhlQZw==
X-Received: by 2002:a05:600c:3d89:b0:42e:8d0d:bc95 with SMTP id 5b1f17b1804b1-431255ceac1mr106233725e9.6.1728937958922;
        Mon, 14 Oct 2024 13:32:38 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:600:9fbb:f0bf:d958:5c70? (p200300cbc71e06009fbbf0bfd9585c70.dip0.t-ipconnect.de. [2003:cb:c71e:600:9fbb:f0bf:d958:5c70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4331sm165472335e9.36.2024.10.14.13.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 13:32:38 -0700 (PDT)
Message-ID: <01fbdcef-b923-4bb0-80b0-f1d3e57fe515@redhat.com>
Date: Mon, 14 Oct 2024 22:32:36 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 akpm@linux-foundation.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, alison.schofield@intel.com, rrichter@amd.com,
 terry.bowman@amd.com, lenb@kernel.org, dave.jiang@intel.com,
 ira.weiny@intel.com
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
 <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
 <d3203f2c-eff6-4e84-80cd-3c6f58dab292@redhat.com>
 <ZwVOE6JRS8Fd9_a8@PC2K9PVX.TheFacebook.com>
 <2c854e5e-c200-4ed9-bf21-778779af7e5b@redhat.com>
 <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Zw0p7-7ymn-0bPiC@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.10.24 16:25, Gregory Price wrote:
> On Mon, Oct 14, 2024 at 01:54:27PM +0200, David Hildenbrand wrote:
>> On 08.10.24 17:21, Gregory Price wrote:
>>> On Tue, Oct 08, 2024 at 05:02:33PM +0200, David Hildenbrand wrote:
>>>> On 08.10.24 16:51, Gregory Price wrote:
>>>>>>> +int __weak set_memory_block_size_order(unsigned int order)
>>>>>>> +{
>>>>>>> +	return -ENODEV;
>>>>>>> +}
>>>>>>> +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
>>>>>>
>>>>>> I can understand what you are trying to achieve, but letting arbitrary
>>>>>> modules mess with this sounds like a bad idea.
>>>>>>
>>>>>
>>>>> I suppose the alternative is trying to scan the CEDT from inside each
>>>>> machine, rather than the ACPI driver?  Seems less maintainable.
>>>>>
>>>>> I don't entirely disagree with your comment.  I hummed and hawwed over
>>>>> externing this - hence the warning in the x86 machine.
>>>>>
>>>>> Open to better answers.
>>>>
>>>> Maybe an interface to add more restrictions on the maximum size might be
>>>> better (instead of setting the size/order, you would impose another upper
>>>> limit).
>>>
>>> That is effectively what set_memory_block_size_order is, though.  Once
>>> blocks are exposed to the allocators, its no longer safe to change the
>>> size (in part because it was built assuming it wouldn't change, but I
>>> imagine there are other dragons waiting in the shadows to bite me).
>>
>> Yes, we must run very early.
>>
>> How is this supposed to interact with code like
>>
>> set_block_size()
>>
>> that also calls set_memory_block_size_order() on UV systems (assuming there
>> will be CXL support sooner or later?)?
>>
>>
> 
> Tying the other email to this one - just clarifying the way forward here.
> 
> It sounds like you're saying at a minimum drop EXPORT tags to prevent
> modules from calling it - but it also sounds like built-ins need to be
> prevented from touching it as well after a certain point in early boot.

Right, at least the EXPORT is not required.

> 
> Do you think I should go down the advise() path as suggested by Ira,
> just adding a arch_lock_blocksize() bit and have set_..._order check it,
> or should we just move towards each architecture having to go through
> the ACPI:CEDT itself?

Let's summarize what we currently have on x86 is:

1) probe_memory_block_size()

Triggered on first memory_block_size_bytes() invocation. Makes a 
decision based on:

a) Already set size using set_memory_block_size_order()
b) RAM size
c) Bare metal vs. virt (bare metal -> use max)
d) Virt: largest block size aligned to memory end


2) set_memory_block_size_order()

Triggered by set_block_size() on UV systems.


I don't think set_memory_block_size_order() is the right tool to use. We 
just want to leave that alone I think -- it's a direct translation of a 
kernel cmdline parameter that should win.

You essentially want to tweak the b)->d) logic to take other alignment 
into consideration.

Maybe have some simple callback mechanism probe_memory_block_size() that 
can consult other sources for alignment requirements?

If that's not an option, then another way to set further min-alignment 
requirements (whereby we take MIN(old_align, new_align))?

-- 
Cheers,

David / dhildenb


