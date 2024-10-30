Return-Path: <linux-acpi+bounces-9109-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E0A9B6007
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 11:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B67282FB1
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 10:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F21E32B7;
	Wed, 30 Oct 2024 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EFGMsupr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C691E2854
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283943; cv=none; b=uZQ73y5RUNy11BNFqLEI1nDEA7PJzdQRCTrV2rIqd5krsQWfK9Ni8orz2/aRHMh7hVm+SaYEk6uIudjE2mZmJ/wEqvqzG/75nuO06Y7kjh4Z10jeHrtDcg0CwEtakeKSypk5jIXxusy7CBGLXT1KC+xmdgJ+ZAsagxujG2Is9RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283943; c=relaxed/simple;
	bh=zmCLICy9LTiNLkwLvnW4mzn0GQwpDoaxhlof1YVkf3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J5+NPJKvV4xWKaFmLQpBbLakRBbD0fm5sRWDqFKSX3CnGAkT0L2ro860XtDclOQ6b0RfpijgSE2pEk3XqdlOTvdGwe6QxP3svrz0R00GO4gDe9TxvbaktyHpRmQfiUApUfysnnhTH4tnMp6fs/ilx78LP+cDGwNY36as3RoelP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EFGMsupr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730283940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xKLA0oWLDgkF5rCii7yrEur7jFosX6RQn0CfkZ28I4E=;
	b=EFGMsuprpsxpe3OfMUsxqcUYM4mfDRIqlGZfD9ueFuofOKPTUSNFItwKnfFU4R3ljTZPXQ
	eiC8NQ4hfOydlnlgtCGZYzbCst1GmJw9SkCymlcMNLvU5bltsMameLyBrRREljmjmUUCHc
	4xU7vc06CYCVSAyEMGcTcrfiyTIv9no=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-hKkW5-9KOna85ZhEDKsdew-1; Wed, 30 Oct 2024 06:25:38 -0400
X-MC-Unique: hKkW5-9KOna85ZhEDKsdew-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d458087c0so481130f8f.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 03:25:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283937; x=1730888737;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKLA0oWLDgkF5rCii7yrEur7jFosX6RQn0CfkZ28I4E=;
        b=OCcFWb/Lv4T5kC+nvOqDbW4tD77OhkIUSFlgTU49/hFI1KWCbT17SNDUz4XLbHUPC7
         CBdvrdSRqhrb+k0TVF3WDHVFmxnmy5yToIQ/QEcC+p1o3brPCEaCwNomPojfmX3kJmDG
         lsrp9pk8MxVaKp/x1VTTom8M9ZlGF506NrSV+4WL7JaPw30KTeihlaWx6A4BCs5znTqA
         wjNpRY9IhuIs01DeKXuVqlf1+xL7dI8SCAU+4lAvTyLhqfqFrOTFQkaAsne2+FTk0GgI
         5JMKWZqaYd4oL/IoLlLj27GxHUVwTKwUKxr41syHJxrUW9Gpw80X0xBu4+wg9GnEVctb
         g0+A==
X-Forwarded-Encrypted: i=1; AJvYcCXzIgtNyVLcC+AewcCYf+IlMGXZlL1jFGlaNqz8cAcLZkABAtU2qQ+jbb1qgKFRaAgOxVeJ3NvoBOQV@vger.kernel.org
X-Gm-Message-State: AOJu0YxiKztuSP5NL0Iwi9jUDHjYL7iR7Z5VQ20U4fBGSSLhGUJSvJpz
	emZilMFktGWSB0z3vFnxhx9GjWFWxCKQ0PGF6lJKtFAvHzViUZwTPLMVioyc1Li+4BEDqQan2Qn
	LR610FQgU13ak+LzJhIv4Th1QDjjCqcb7gZ92xeRuIpydGM5yJkB5vwF2/Cg=
X-Received: by 2002:a05:6000:cca:b0:367:8e57:8 with SMTP id ffacd0b85a97d-381b97a85b5mr1420476f8f.19.1730283937359;
        Wed, 30 Oct 2024 03:25:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE97Pf9dhOPLjCXei3bbCF4D3qdGOOrwidgytfYoVyQ27lzp16/fse+MiEKENg5AXoEOEOrgw==
X-Received: by 2002:a05:6000:cca:b0:367:8e57:8 with SMTP id ffacd0b85a97d-381b97a85b5mr1420436f8f.19.1730283936919;
        Wed, 30 Oct 2024 03:25:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9aa83asm16969125e9.31.2024.10.30.03.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 03:25:36 -0700 (PDT)
Message-ID: <55df76a9-afa3-4dc0-a7f9-ff9b6f139448@redhat.com>
Date: Wed, 30 Oct 2024 11:25:33 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] memory: implement
 memory_block_advise/probe_max_size
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
 dave.jiang@intel.com, ira.weiny@intel.com, alison.schofield@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
 gregkh@linuxfoundation.org, akpm@linux-foundation.org, rppt@kernel.org
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-2-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241029202041.25334-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.24 21:20, Gregory Price wrote:
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
>   drivers/base/memory.c  | 48 ++++++++++++++++++++++++++++++++++++++++++
>   include/linux/memory.h | 10 +++++++++
>   2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 67858eeb92ed..099a972c52dc 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -110,6 +110,54 @@ static void memory_block_release(struct device *dev)
>   	kfree(mem);
>   }
>   
> +/**
> + * memory_block_advise_max_size() - advise memory hotplug on the max suggested
> + *				    block size, usually for alignment.
> + * @size: suggestion for maximum block size. must be aligned on power of 2.
> + *
> + * Early boot software (pre-allocator init) may advise archs on the max block
> + * size. This value can only decrease after initialization, as the intent is
> + * to identify the largest supported alignment for all sources.
> + *
> + * Use of this value is arch-defined, as is min/max block size.
> + *
> + * Return: 0 on success
> + *	   -EINVAL if size is 0 or not pow2 aligned
> + *	   -EBUSY if value has already been probed
> + */
> +static size_t memory_block_advised_sz;

Nit: if everything is called "size", call this "size" as well.

> +static bool memory_block_advised_size_queried;
> +int memory_block_advise_max_size(size_t size)

Not that memory_block_size_bytes() uses "unsigned long". I don't think 
it matters here. Or could it on 32bit? (I assume that code will not 
really matter on 32bit)

> +{
> +	if (!size || !is_power_of_2(size))
> +		return -EINVAL;
> +
> +	if (memory_block_advised_size_queried)
> +		return -EBUSY;
> +
> +	if (memory_block_advised_sz)
> +		memory_block_advised_sz = min(size, memory_block_advised_sz);
> +	else
> +		memory_block_advised_sz = size;
> +
> +	return 0;
> +}
> +
> +/**
> + * memory_block_advised_max_size() - query advised max hotplug block size.
> + *
> + * After the first call, the value can never change. Callers looking for the
> + * actual block size should use memory_block_size_bytes. This interface is
> + * intended for use by arch-init when initializing the hotplug block size.
> + *
> + * Return: advised size in bytes, or 0 if never set.
> + */
> +size_t memory_block_advised_max_size(void)
> +{
> +	memory_block_advised_size_queried = true;
 > +	return memory_block_advised_sz;> +}
> +

I wonder if both should.could be "__init" ? So they could only be called 
from __init ... which sounds like the tight thing to do?

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


