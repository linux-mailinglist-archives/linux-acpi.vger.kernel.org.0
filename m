Return-Path: <linux-acpi+bounces-9071-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF92F9B49E0
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 13:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B3F1F237C5
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 12:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8351DE3C5;
	Tue, 29 Oct 2024 12:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV27EICT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E651DFCB
	for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205646; cv=none; b=s0m+wljpAoAonRFOTXZzoVgjCDZ0mcPvT9ZaOc3MBcB6rNT4HFx1GoEe8fj3JBJ40+BDt+vOs28TmHLJ7mI/SfiW5p9RTBj/frlsdh3PB6OEK4j7zR9fTn41yd/+lLefme4PF9BeOJAYUqMkj1ipx74zkdrBD/0bxPJdksJ5Kz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205646; c=relaxed/simple;
	bh=lf9xsJsx5+qwPXqJTzPv8qSkVJCfziN25/C6A4c1s2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8UoP5ZWhFbzDAogGKEGZXO80W+wW1VJCuVaNu7aksDDbUBxCcoytBvUuMNQGv8Kw4sDIRe1GqWj8rFXqozMdGEfOfRhXbeJoPwLFU5QNhP1DEhtvdGot0v9mCivEjS6jJ5dkPW50DhxHHH+KgAN5oshGai7hHVxJITl4L67xzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV27EICT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730205643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZgQ+GJqq3Nxx+v0YM6GOKU3kFivGoe04a8Z3ZVcvHZo=;
	b=gV27EICT/AUa8uqYuaNvR//Gp1VVD3Ar0FBYpS+ckaaJZ9n9qLTlvgDFu6aTZk4K+iPnVv
	WdFia/o6jKEQn5FrJFLxC8iAINkA59h5bO5bn/u1BMVcp0IpAfm1I++mfiEKLEwrQRM2zu
	PzXFiETMaKSS1sdSAyYCK2mIpjNrfyo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-IDTEsU_WMuCKzUBMjbla1w-1; Tue, 29 Oct 2024 08:40:42 -0400
X-MC-Unique: IDTEsU_WMuCKzUBMjbla1w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4af408dcso2475355f8f.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Oct 2024 05:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730205641; x=1730810441;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZgQ+GJqq3Nxx+v0YM6GOKU3kFivGoe04a8Z3ZVcvHZo=;
        b=jlI4sJoq2D7AYpRNrxXGZXO2pH0FdDl/uEiqLSS8Mvez44mlAmapeM8iNc+Puf3nRM
         2R9bZ+8yqMP4J8GMq+nApzA2kfBYM0Ii4/FCYb4ptxsDCZsfT5I6shRgS3mnghWgb67s
         biasASvQ7/X18bh6Gv4ateJU8SxYDyoaseKHxEtCu6l41FFTLyWmJi0LIq+mKq0506JA
         PkfVyN5aqF2Hun1/DSUfy5GhIbCyefsRNFZ5Mj8G6OCC5jeOQyE+jJagAImgUA8Txt4S
         +Y5I51P3GiLg0+HbgYm15fDPVmtioula7e/NJ+TWOwzyQ5KEVfc4oyHk6HsoMasTyFVn
         O2Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWgN6eP6rNkQYKVEwLmVjn6fMkLBb1reRlhf6neGq/x93DfehWk+BHWkFTgVONR+H2RisZM5fXBuTcH@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf6fwWCLr7j/6jC43VH+I+clbxKxZQ/mz+rn6Hcz4m43N0ouFq
	BcUfZgomhwQWq44Sgxzg1ARaxMT4dreMFQt7/vdnmG8Q9QBMjxzmzYcTIp8ovquTpk2uJ/pxCiU
	hjfUj00gcfXlv0bIXm32gFFmEVXWbAcjEvSuX8ZZzMQ3ftUAaFpGwDkXl/zM=
X-Received: by 2002:a5d:424f:0:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-38061206092mr8068378f8f.48.1730205640855;
        Tue, 29 Oct 2024 05:40:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHe4FAWl4TUErCarr7Sq59Sn0p4AW/LNhN08ETD5unSMd0lk1j1y+M42RvjMcClYxj85N4XjQ==
X-Received: by 2002:a5d:424f:0:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-38061206092mr8068349f8f.48.1730205640418;
        Tue, 29 Oct 2024 05:40:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e? (p200300cbc72d8500d87aed8e1e805a7e.dip0.t-ipconnect.de. [2003:cb:c72d:8500:d87a:ed8e:1e80:5a7e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f74f9sm145756915e9.31.2024.10.29.05.40.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:40:39 -0700 (PDT)
Message-ID: <07102ea5-ee43-4c11-ab3c-a35cfce9003b@redhat.com>
Date: Tue, 29 Oct 2024 13:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] x86: probe memory block size advisement value
 during mm init
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
 <20241022213450.15041-3-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241022213450.15041-3-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.10.24 23:34, Gregory Price wrote:
> Systems with hotplug may provide an advisement value on what the
> memblock size should be.  Probe this value when the rest of the
> configuration values are considered.
> 
> The new heuristic is as follows
> 
> 1) set_memory_block_size_order value if already set (cmdline param)
> 2) minimum block size if memory is less than large block limit
> 3) if no hotplug advice: Max block size if system is bare-metal,
>     otherwise use end of memory alignment.
> 4) if hotplug advice: lesser of advice and end of memory alignment.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   arch/x86/mm/init_64.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index ff253648706f..93d669f467f7 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1452,13 +1452,17 @@ static unsigned long probe_memory_block_size(void)
>   	}
>   
>   	/*
> -	 * Use max block size to minimize overhead on bare metal, where
> -	 * alignment for memory hotplug isn't a concern.
> +	 * When hotplug alignment is not a concern, maximize blocksize
> +	 * to minimize overhead. Otherwise, align to the lesser of advice
> +	 * alignment and end of memory alignment.
>   	 */
> -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> +	bz = memory_block_probe_max_size();
> +	if (!bz) {
>   		bz = MAX_BLOCK_SIZE;
> -		goto done;
> -	}
> +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> +			goto done;
> +	} else
> +		bz = max(min(bz, MAX_BLOCK_SIZE), MIN_MEMORY_BLOCK_SIZE);
>   
>   	/* Find the largest allowed block size that aligns to memory end */
>   	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {


Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


