Return-Path: <linux-acpi+bounces-9268-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E39BAF4E
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 10:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03454280579
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 09:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF771ADFFB;
	Mon,  4 Nov 2024 09:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hssNPxY9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117691AB6EA
	for <linux-acpi@vger.kernel.org>; Mon,  4 Nov 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730711500; cv=none; b=WwkYLxJVjF82K6FfpSiEYA2Mvq7RWNL71ApyjE9/ZmcHoIrD+d+RaD5jz6PmzU2kXxNG+Kaq6102wnQkR8gdCwMVO0nc1c5y4rwSjCq7oQNnU64BpXVK9uGxRaPWFDyahCgSwXuArPnTQsC0Y+jCqvm4NkGxP57+E7P8EVhkARM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730711500; c=relaxed/simple;
	bh=tWFxkRLt/fLOUsterIBkjf+5P4MGei/wC4OAn0qV78Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oh6FVpO0YS72+mg0oHb2+ju+EpHJdF1zjRYbw/zut9Xz4oa8hbtxHSA/MIPumMBvVMjEysHR5VDVFZGPYaf+k7qcANcRBzYP3ASlIb4fbe90Hw7EHw0wnmhSi5IxqiE3w4tX4FxVNPNDa7I10FiTnSdJRk8N2kgaJW+xreu3xHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hssNPxY9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730711497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=F5GBnbTWa1MyC7D6IBGUS3qI/n0lLUpUo8vpqAqxL/o=;
	b=hssNPxY94vHbxgCaFqyPa7mqR+ToM6vImUeuQag/0m0kglBxgQjodgVm4axF0Zng4JfOSC
	4Ga9w6aG9U9qsg/iwVcRmC2gRlf7hRIAxITdIVQo1Db2rENmocz318g2ucF/ddqJSI9HXT
	MGVFXHZr3JnaDaU31SUC0Vms65o92/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-Um1JnLfgOXCaeNEybPKV3w-1; Mon, 04 Nov 2024 04:11:36 -0500
X-MC-Unique: Um1JnLfgOXCaeNEybPKV3w-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315af466d9so26727575e9.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 Nov 2024 01:11:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730711495; x=1731316295;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F5GBnbTWa1MyC7D6IBGUS3qI/n0lLUpUo8vpqAqxL/o=;
        b=gtplQyT8Ij1s0JkFjkDduNLdch0nQjQd4HlGS22YpoTGvMOoMGqEDo+KLHcAQltrUr
         JCivkm2DaZ2YvX8kZD5XX191OtZ8fVyz+/Gdba/YUigc+eWMcq4DugHEbRjPilFUsUCs
         8H1DNSu7pEYac60okFX0T0tFhtAycjkUKDhhjYtq+gHyVBT4ZPAG7U+u10/VSpCVOVwP
         2Hxm7agW5HC6HaMWrdW5v7apSaIpOwz8YBTrk/PFFPLA82bNq1DEPQP/WRwOUsEFmDF6
         4ZcPyHnDZ/l9z7QX3MZIlwLKeul2ftzQLXlRZTZyZV4se2GuA4GdDqrPu2OJr4eKh3Ct
         Twxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnf/Gd8UXg4LZTkdygmOZpAGOA+emeS53c6caJETS10S7zuncfvRotwbgPMye8EOaVXgj0l0CjyHva@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn7922B74BudZTf7sVT/sfxZnDF6Vb/WSLx2B+6tB+MuFl+q6w
	aTyJOsbG+Cj/LitXitsw2UPuTuW+N0+uXgzeFsBCC7VXsxV24vRSgigmtO9UQ9E9SaZB79wqC7c
	Ukl6t4rbnPsn6Jms5B1j7SBZhm8eZbJjqYDAW6fOcQBGzcURIsH96Vov/DS0=
X-Received: by 2002:a05:600c:a41:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432832562aemr95620215e9.21.1730711494812;
        Mon, 04 Nov 2024 01:11:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2oEen6hZ9Tpzjl+0FcjG6DVLxdS7k3BMPeNTAGjmdzWfXq16F04C+WZVLVGBJoQRI7XFkfw==
X-Received: by 2002:a05:600c:a41:b0:42a:a6d2:3270 with SMTP id 5b1f17b1804b1-432832562aemr95619905e9.21.1730711494430;
        Mon, 04 Nov 2024 01:11:34 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113de0esm12664081f8f.85.2024.11.04.01.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 01:11:33 -0800 (PST)
Message-ID: <3700141f-e12f-4a58-8e36-5f95ef500d8b@redhat.com>
Date: Mon, 4 Nov 2024 10:11:31 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
 dave.jiang@intel.com, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-4-gourry@gourry.net>
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
In-Reply-To: <20241101134706.1185-4-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.11.24 14:47, Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


