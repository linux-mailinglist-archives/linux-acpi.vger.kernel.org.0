Return-Path: <linux-acpi+bounces-9070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8059B49DC
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 13:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34FEB22061
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 12:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED192040BE;
	Tue, 29 Oct 2024 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZqNxVhi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E706B66E
	for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 12:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205594; cv=none; b=PGqmroDxLt39TYdRLlVnZMCFj8X8rsfRUbd0Qr6k4xZQlqWfkY57ijPvVoJhNg3s0BKE9lHOToGdJKpNqpoCj7s9QtW4mpgycHBf2RLvxpOzs36VCMf0yWB7WSWlySCYUFh2+6p/PaYS2vEXHF/R8rf57Adw2urJf66HgGISs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205594; c=relaxed/simple;
	bh=NjnXUQsQzLAHiduJjZJWEcABE1u9s+HplZsHIVfrt9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPCSJOSkfAHdQ/93t1srV2Cw6Wa6avGW+1zdnDTDkEXnRqkjLWgg1ZdUynN6gOmBIMToGEuvcLjp7aKIQh3CogWwLdQkKwazbX3NsoRlmjMqipgVMHZGRUsgvkYvPURr8lIZt2yCvAfRSJ04/oCOBbJPlTXGPHFn+ytcTlm1pjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZqNxVhi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730205590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cJdMre7/q+8lGEX+hKjTbivVtpNxUnp+P1g8amF8oVA=;
	b=JZqNxVhiWFEy/XfHUN558/ZMvHeU4wlYC9fWCmnNvTodjPVVXQaIVF2l3xviAgLQjA76cT
	qhEp8QXt5Rxi928VMBtJTlQAu+LT8b30INZx8ug5Tq1XQgkBrZY/swwj8CxJVP+F8LpBPW
	8cWCv5aJIkJmK84Q8ZA5fmEuv3cnneE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-WMhDfVzeMYqKboNaNfLKdg-1; Tue, 29 Oct 2024 08:39:48 -0400
X-MC-Unique: WMhDfVzeMYqKboNaNfLKdg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4316655b2f1so35471905e9.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 05:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205587; x=1730810387;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cJdMre7/q+8lGEX+hKjTbivVtpNxUnp+P1g8amF8oVA=;
        b=RDbcloS7PGb/iZRjAiDZUQJP3Nnr3myS/8FvZGXHgqlsZrwOqq4qO63tz+7PSaC/3T
         tq7bBq2IQLiGtyRXLSHFj3qHM2TiA2SPkrekGn1Psfq4X9xbxY52cQXTUKUKF9Zq1CMN
         Ogo5IVu8fbiREptJPEfL5NZ3dv4BMOZWZDM6+bEOyVTJXb0SB4NRwnpfNcioaVuCfmdr
         hq02awgQ0Y70LhysOtgNw+HubJ6EqwgmTSN8yiunCFS05eFFI5BRHG5hU/0mzbnJro4X
         7LFTufPzEg6wev5y7nXHXGZtQapsSMgLhCjOA58PdcBbS2WsycwQ22uDWORuMVJHQJFv
         qWWg==
X-Forwarded-Encrypted: i=1; AJvYcCURvkgtrG2iLYNHwhenu9sEPGrVqUH5QpjJuNK50C6quMMp6R273gQhUibNnsBlJFMqBzOPWwKRkdtZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ29xA+i9HLI9VpBCIR23O7FL2oW7NIlyYaaR+84nFLkPWkhjC
	/1tQlUozIznyZxYp+W5/31GSrao7eNnZPwtCBmZUzmlodbH3wKnv1f7z89YSVmgsYrp9+4Bc3KE
	IoC3I05h5i/g1NCNO5OomEXSRrG7/HM3pPDbDlAxnIiVoO3INUuBwO9MSdHA=
X-Received: by 2002:a05:600c:468d:b0:431:594b:8e2b with SMTP id 5b1f17b1804b1-4319aca3b99mr92725945e9.12.1730205587587;
        Tue, 29 Oct 2024 05:39:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSy4lvC+tPblwD1JsH/uUvLgX2AGM7wYRZ7aaf6zlF94YdCvpJJT28mNJhs2jXTxKBu2voBw==
X-Received: by 2002:a05:600c:468d:b0:431:594b:8e2b with SMTP id 5b1f17b1804b1-4319aca3b99mr92725075e9.12.1730205585733;
        Tue, 29 Oct 2024 05:39:45 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e? (p200300cbc72d8500d87aed8e1e805a7e.dip0.t-ipconnect.de. [2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b56facasm172541035e9.33.2024.10.29.05.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:39:45 -0700 (PDT)
Message-ID: <2e90cce3-7a75-4827-81f1-01d9641c1b75@redhat.com>
Date: Tue, 29 Oct 2024 13:39:43 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] memory: implement
 memory_block_advise/probe_max_size
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: linux-cxl@kvack.org, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
 dave.jiang@intel.com, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-2-gourry@gourry.net>
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
In-Reply-To: <20241022213450.15041-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.24 23:34, Gregory Price wrote:
> Hotplug memory sources may have opinions on what the memblock size
> should be - usually for alignment purposes.  For example, CXL memory
> extents can be 256MB with a matching alignment. If this size/alignment
> is smaller than the block size, it can result in stranded capacity.
> 
> Implement memory_block_advise_max_size for use prior to allocator init,
> for software to advise the system on the max block size.
> 
> Implement memory_block_probe_max_size for use by arch init code to
> calculate the best block size. Use of advice is architecture defined.
> 
> The probe value can never change after first probe. Calls to advise
> after probe will return -EBUSY to aid debugging.
> 
> On systems without hotplug, always return -ENODEV and 0 respectively.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   drivers/base/memory.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/memory.h | 10 ++++++++++
>   2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 67858eeb92ed..a0fd9e1451aa 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -110,6 +110,49 @@ static void memory_block_release(struct device *dev)
>   	kfree(mem);
>   }
>   
> +/*


As Mike says, this documentation looks incomplete.

/**
  * memory_block_advise_max_size: suggest a maximum memory block size
  ...

> + * @size: suggestion for maximum block size. must be aligned on power of 2.
> + *
> + * Early boot software (pre-allocator init) may advise archs on the max block
> + * size.This value can only decrease after initialization, as the intent is to

Missing space after "size."

> + * identify the largest supported alignment for all sources.
> + *
> + * Use of this value is arch dependent, as is min/max block size.
> + *
> + * Returns: 0 on success
> + *	    -EINVAL if size is 0 or not pow2 aligned
> + *	    -EBUSY if value has already been probed
> + */
> +static size_t memory_block_advised_sz;
> +static bool memory_block_size_probed;
> +int memory_block_advise_max_size(size_t bz)
> +{
> +	if (!bz || (bz & (bz - 1)) != 0)
> +		return -EINVAL;
> +
> +	if (memory_block_size_probed)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_sz)
> +		memory_block_advised_sz = min(bz, memory_block_advised_sz);
> +	else
> +		memory_block_advised_sz = bz;
> +
> +	return 0;
> +}
> +
> +/*
> + * memory_block_probe_max_size provides a suggested maximum memory block
> + * size value. After the first call, the value can never change.
> + *
> + * Returns: advised size in bytes, or 0 if never set.
> + */
> +size_t memory_block_probe_max_size(void)

Can we call that "memory_block_advised_max_size()" ?

> +{
> +	memory_block_size_probed = true;

Call this "memory_block_advised_size_queried" ?

> +	return memory_block_advised_sz;
> +}



-- 
Cheers,

David / dhildenb


