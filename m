Return-Path: <linux-acpi+bounces-9134-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B419B6944
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B21B1F2227C
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DD42144CF;
	Wed, 30 Oct 2024 16:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpK4xw0n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F04821440F
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730306126; cv=none; b=asC+/bg/RRzjwtJlgDU6dcsBSKeCQYPZR7Z7rEN5XKtH4HJ5ZaRRdg/H0vy9PTXhcP6IQ4IT6XD1HtMbzyE8hhW0Ezkzzd7CxJEIsSBKclJEjDb/9lXxe+GhCkDTsnS941Sgi4xgtJZcYptKDC74QV88ik+uqVrpxGEOuKGt1yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730306126; c=relaxed/simple;
	bh=dhrozV30TGx4VYLiojNcQH9l5EgARbwA5XiErr+7L1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q/tkN0Pl2ktsZh2ON9isfDtEvnO4fDQUdEGOHS9HDqLdKYrl6jYZ2eOrKROeTF4KrkHhaULKI6VcQ2rcTU19gnDw2qYAvPDuCs6bHk76K7YI7uvvF/MPXLMv7480Vg4jmFxcQd0fiUCn7BJC7iAxB4a4o3tEltPHneREC28Ucu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HpK4xw0n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730306123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xkqgwW5DDeMgXcXsiXK7EYvX8QOBdi4WhcFSY0Iyx7U=;
	b=HpK4xw0nx2+GmLYpuYsMJFwZZbzcBxwDGq/rLHhwDSRu2L37gpSYdzsfqBfMpkxJyM3pSC
	Kda9QhAghh1maXfTwqal5gs2Cd3fKlXxRyZit0c+oCkmPxv3SA4BysHyHglwy0XIWcTSnB
	4sDKWxLB1sovE+VBa+g1eKrIyVZ0Iy8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683--N-8Z3lMNHOdlF7dRDA_hw-1; Wed, 30 Oct 2024 12:35:22 -0400
X-MC-Unique: -N-8Z3lMNHOdlF7dRDA_hw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53a0b48e8d4so9077e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 09:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730306121; x=1730910921;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkqgwW5DDeMgXcXsiXK7EYvX8QOBdi4WhcFSY0Iyx7U=;
        b=wGTM2EN5VsJwJJxiYTyluKo2mzgHo65JB8IZtJUXFUCRCVWaAnQzJaQdibVMxbFjqp
         g2BR4pe/A1gliDuTUkREgmKbVRG5NgHjuhZKAvlqybVSZ9/fls4IHCL5l6qquhWEa4Dx
         YcipeFNoQYh7s1mzUC/uILoyznez2Inv2vqlj6JUF1NVCJJ7+MnZVWBzFxn+aYiIgaKo
         pvCFkg5NS0Z7P3GhWJZmNpDDuPDsCXD6L/0BWW0A/Td3pS0Zum4xgoke5tsjh1TthCpM
         EhyJEEloA/X71T1QBYrZIRmZikSqQfCK7NGmYFFjgS328dGTt1VX7+5ZhmwvgFoDUtyB
         cGSg==
X-Forwarded-Encrypted: i=1; AJvYcCVA5ezYOf8wU5xIaz6/my1+TRT6bm5EcWDPdCw6Oy2jcno6hYmTnkLj3Osw9tIZn/a4ZxvQA/hGmYkI@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFHgR2seu3bSX5sy5wyV0+Z/mI0AouHu5f8IeN79ZiEGop24C
	taHMs3KfcDtk6SVIiMhgRyezwqH2srKdPjqrfv9G71NSuWdchYF1J/uHMhPgfnb2FNdKAalgA/e
	v6BfViUcLGsC8LfrRMDpCjYKj6WN940sJ505xzH/Cda42m6k4NPGZxjwGDCI=
X-Received: by 2002:a05:6512:6517:b0:53c:6999:1791 with SMTP id 2adb3069b0e04-53c69991a99mr1335609e87.25.1730306120662;
        Wed, 30 Oct 2024 09:35:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBIX4YAlC7xoL2jdNmLWbtxSn1v+FBNKJjuAg2C9j5Ikk8Ss+h9mz2eCOmNNpGMndTbF0v+w==
X-Received: by 2002:a05:6512:6517:b0:53c:6999:1791 with SMTP id 2adb3069b0e04-53c69991a99mr1335577e87.25.1730306120159;
        Wed, 30 Oct 2024 09:35:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a99c8sm25842275e9.29.2024.10.30.09.35.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 09:35:19 -0700 (PDT)
Message-ID: <c99e0eca-49f6-4167-ad2b-d4168193ea7e@redhat.com>
Date: Wed, 30 Oct 2024 17:35:18 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
 dave.jiang@intel.com, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
 <55df76a9-afa3-4dc0-a7f9-ff9b6f139448@redhat.com>
 <ZyJJ5Pvfj4Spcyo7@PC2K9PVX.TheFacebook.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZyJJ5Pvfj4Spcyo7@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.10.24 15:59, Gregory Price wrote:
> On Wed, Oct 30, 2024 at 11:25:33AM +0100, David Hildenbrand wrote:
>> On 29.10.24 21:20, Gregory Price wrote:
>>> Hotplug memory sources may have opinions on what the memblock size
>>> should be - usually for alignment purposes.  For example, CXL memory
>>> extents can be 256MB with a matching alignment. If this size/alignment
>>> is smaller than the block size, it can result in stranded capacity.
>>>
>>> Implement memory_block_advise_max_size for use prior to allocator init,
>>> for software to advise the system on the max block size.
>>>
>>> Implement memory_block_probe_max_size for use by arch init code to
>>> calculate the best block size. Use of advice is architecture defined.
>>>
>>> The probe value can never change after first probe. Calls to advise
>>> after probe will return -EBUSY to aid debugging.
>>>
>>> On systems without hotplug, always return -ENODEV and 0 respectively.
>>>
>>> Suggested-by: Ira Weiny <ira.weiny@intel.com>
>>> Signed-off-by: Gregory Price <gourry@gourry.net>
>>> ---
>>>    drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
>>>    include/linux/memory.h | 10 +++++++++
>>>    2 files changed, 58 insertions(+)
>>>
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index 67858eeb92ed..099a972c52dc 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
>>>    	kfree(mem);
>>>    }
>>> +/**
>>> + * memory_block_advise_max_size() - advise memory hotplug on the max suggested
>>> + *				    block size, usually for alignment.
>>> + * @size: suggestion for maximum block size. must be aligned on power of 2.
>>> + *
>>> + * Early boot software (pre-allocator init) may advise archs on the max block
>>> + * size. This value can only decrease after initialization, as the intent is
>>> + * to identify the largest supported alignment for all sources.
>>> + *
>>> + * Use of this value is arch-defined, as is min/max block size.
>>> + *
>>> + * Return: 0 on success
>>> + *	   -EINVAL if size is 0 or not pow2 aligned
>>> + *	   -EBUSY if value has already been probed
>>> + */
>>> +static size_t memory_block_advised_sz;
>>
>> Nit: if everything is called "size", call this "size" as well.
>>
> 
> Mostly shortened here because
> 
> 	if (memory_block_advised_sz)
> 		memory_block_advised_size = min(size, memory_block_advised_size);
> 
> is over 80 characters lol.  Happy to change if you have strong feelings.

Feel free to exceed 80 chars if there is good reason to -- like in this 
case. checkpatch.pl nowadays complains if you exceed 100 chars.

No strong feelings, making it consistent in some way would be "nice" ;)

-- 
Cheers,

David / dhildenb


