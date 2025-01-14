Return-Path: <linux-acpi+bounces-10622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FBEA10BC1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B60166122
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 16:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B2F192B70;
	Tue, 14 Jan 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PteL88LU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A601B1553A3
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736870752; cv=none; b=AkOl2W6MYpdBdfHr77pFWpd4oSSkJnrtAjPkFzwrnI2YYGInCALikmCLIJUBPYctytbteHHDFfBCRFA0VTIoYALtmVamZUt7fFFHKcVQ7ShHeNHQ72BIIx22XRMMFDnjLfQXfsEL/O9MPPyKUEjs9oSal60+iVaCs3wR0zPAwIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736870752; c=relaxed/simple;
	bh=hmBUv9k5F6YiPFvNJjqllp6DqB0AWaHj5SLIvSoxa3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VXmiHhG3AlFwcet/VkI+jlDHvgX8YSsPwe8kl2/TJbQawogM+MqoQFNN0s8zJ4UfJOOaxi021nJjsu3eZapSi3EL151qzfvDCeZK24mpiVHC8sno2QtCIzq2KIkWIItNX2p+iIjjIZp/a4lmn2nG7b/xJTHSiiSWMNOJskp+guc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PteL88LU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736870749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VMkCYOsyvm47TSe6Vd45OKr+yexY9Ah5sYc4Xs9in04=;
	b=PteL88LUMWpSjWEjrOc24jCsRrZlk8BNdV0ex2uUxnFXwwjtRMSc1Y67zLdueoa9yqXdG8
	zhF6H53F6HyPTOsIkPkHWfw7XvfWzxm3FH9Wui8I+4t8Wwg0ub36sUz1YVctGmeKoZfJNj
	L3xiFsYOep9WlCacB+eRdJ/yxGHXxJA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-TcKLno4mPC6ALUOVa0Dzcw-1; Tue, 14 Jan 2025 11:05:48 -0500
X-MC-Unique: TcKLno4mPC6ALUOVa0Dzcw-1
X-Mimecast-MFC-AGG-ID: TcKLno4mPC6ALUOVa0Dzcw
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385dcadffebso2744958f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 08:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736870747; x=1737475547;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VMkCYOsyvm47TSe6Vd45OKr+yexY9Ah5sYc4Xs9in04=;
        b=MGCpN30xJsPYXGaLkmUat8E1oWtJQ7vx5usRvNvHeNHYYrEWBcxG5/30rx4eOQ7ENT
         8Ewyq9DIbtzyuRaXwy/Iz8mSEfhRDV5INQ0F8YD+WWOeaIlTIoDDBSyN/mX8wQmZBE1X
         CnpbTsAx5LqqTXw5d0VDoc3J2/lACke2aq4Di8IxeNKFDP2yPjJyq5iQMEtqSK7YBAKL
         x2xhRYnSvG3q+yElQz1L2IUHN0+aa64p7GtOS6ZYR6cCIA1gjJtFtGEyoenYLHWCUyOr
         vaHLcvdHr5nHvSdmdzs6KbbKUyiLfFJqDlMGRZ9iast7KVIuh3kZId85YvAXy0WwPC5E
         tVfg==
X-Forwarded-Encrypted: i=1; AJvYcCXt3sg9gaQZMoXHCEHYsKDTIBpXiYC3eQfCLGiIIZTLAUUgd6UYZdM8upIjc6sazg98zz+ItM0tImdb@vger.kernel.org
X-Gm-Message-State: AOJu0YzNxR0ICuvxO4ViMFHKkVmZwxrNagRwbEDFKj8A8eLAMwWRQXsR
	00Qx6WhHd82xTpgUsq4bS//fqTwoIKJ7hG8N6ZxLZI+uZhO6g/+Dw3UhqEdST4OlJeH+x6DPexf
	c6ixMPdyeIedckQhfzauI/SIgVCtVdVH4GvmPSt4Lg9/VPbzfFktOeP2bdnk=
X-Gm-Gg: ASbGncv0spLSxe2LNGjJhLl2fXDfMEFCyXW2iPc4fluBY8+GHAwPHgrJQB53inHFAlZ
	Bz6lgrFxZgSBQdXPcOQgYGGQ1j2atf4U8LIe7SiVQN8qrvixKM13VPyoQWKowRo1ZUKWo+ZijgT
	U6YIF6CNuahOcOtmdv7fL7qRk733zi12GP7Hr5cbD2rvKw2qNiNXslgIqXa1QeVnOjWMG2Ddgz0
	WlJdvwBqqc8LmNhWA9pVbDv9ENAZAI5wxuEiWdI4W1XmxEaFJNyCTeR8QdSWhrLTDti0zCp+3av
	rWbwfHybQIE8nwFbo+1cLasEioKDMw+VVj0AzOPOijinJqScoPsnawCrx/oIW6RmPRLlQ8KDjx9
	9qH/+2NUT
X-Received: by 2002:a05:6000:1a8c:b0:385:f677:8594 with SMTP id ffacd0b85a97d-38a87336b29mr23628218f8f.43.1736870746800;
        Tue, 14 Jan 2025 08:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs9YS2msqw5L28+0H4IC2QOw/GUIfGbzadBCdsTOQu3IaDPwgnpqFU9VHHEOsiFIcxgS2ITA==
X-Received: by 2002:a05:6000:1a8c:b0:385:f677:8594 with SMTP id ffacd0b85a97d-38a87336b29mr23628041f8f.43.1736870744788;
        Tue, 14 Jan 2025 08:05:44 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d090sm15089833f8f.2.2025.01.14.08.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 08:05:44 -0800 (PST)
Message-ID: <7493daa0-b15c-43e8-9235-78a0a1a8c8a6@redhat.com>
Date: Tue, 14 Jan 2025 17:05:41 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mm/fake-numa: allow later numa node hotplug
To: Bruno Faccini <bfaccini@nvidia.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
 ziy@nvidia.com, jhubbard@nvidia.com, mrusiniak@nvidia.com,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org
References: <20250106120659.359610-1-bfaccini@nvidia.com>
 <20250106120659.359610-2-bfaccini@nvidia.com>
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
In-Reply-To: <20250106120659.359610-2-bfaccini@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.01.25 13:06, Bruno Faccini wrote:
> Current fake-numa implementation prevents new Numa
> nodes to be later hot-plugged by drivers.
> A common symptom of this limitation is the
> "node <X> was absent from the node_possible_map"
> message by associated warning in mm/memory_hotplug.c:
> add_memory_resource().
> This comes from the lack of remapping in both
> pxm_to_node_map[] and node_to_pxm_map[] tables
> to take fake-numa nodes into account and thus
> triggers collisions with original and physical nodes
> only-mapping that had been determined from BIOS tables.
> This patch fixes this by doing the necessary node-ids
> translation in both pxm_to_node_map[]/node_to_pxm_map[]
> tables.
> node_distance[] table has also been fixed accordingly.

You're allowed to use up to 72 chars per line, and adding some empty 
lines might make this easier to read.

Did you forget to CC ACPI folks + mailing list?

> 
> Signed-off-by: Bruno Faccini <bfaccini@nvidia.com>
> ---
>   drivers/acpi/numa/srat.c     | 86 ++++++++++++++++++++++++++++++++++++
>   include/acpi/acpi_numa.h     |  5 +++
>   include/linux/numa_memblks.h |  3 ++
>   mm/numa_emulation.c          | 45 ++++++++++++++++---
>   mm/numa_memblks.c            |  2 +-
>   5 files changed, 133 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index bec0dcd1f9c3..59fffe34c9d0 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -81,6 +81,92 @@ int acpi_map_pxm_to_node(int pxm)
>   }
>   EXPORT_SYMBOL(acpi_map_pxm_to_node);
>   
> +#ifdef CONFIG_NUMA_EMU
> +/*
> + * Take max_nid - 1 fake-numa nodes into account in both
> + * pxm_to_node_map()/node_to_pxm_map[] tables.
> + */

Having the fake-numa stuff in here looks quite hacky; but I'm no expert, 
so I'll let ACPI folks comment (on CC) on the details.


-- 
Cheers,

David / dhildenb


