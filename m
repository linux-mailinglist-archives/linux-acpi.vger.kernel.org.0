Return-Path: <linux-acpi+bounces-9111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891059B6061
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DD2282A47
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124671E47B0;
	Wed, 30 Oct 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAdBnCVV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8D1E47B2
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730284815; cv=none; b=qyNX5bxDtukBjyzUCy5qy5nB1k3WzGt8oPnJ2Hrwt0AfRmFtioJphKFy5jUw5f5sqxA6Je2blOuzFwRvHbhqs9pWXX/AzNh1mUk1fbTrdjvvsbtiQnyvSCfxHuii6lQuSygQePpI63swcy/BqFzEhRTWBPgNQ/PAp9Qe4jWRbwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730284815; c=relaxed/simple;
	bh=MUptrIFZ5MmerslHECojm4cPD/lX7r1eKpNrQ0rEWbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Po6lDGlL0EONpSXYW/j/lGyFurgkxPKyJg4Q1y2qsAyF0i7P60YOZ14mRvX9+I7rPBh5y+tMOoE7ZHfSgTW9hXo2oA79/x8Xb9/csPdFlGLaj33annSirUCqVyRoXn9xwU+NQolELFOBKjHmUtJYP2dgP7BRzGSnoEA1VVYOfIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dAdBnCVV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730284812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mLeQeKxO4bKCx0zllR0uO5tRuOw0Dm45NAsZWOAqEzw=;
	b=dAdBnCVVJR0cGbrXuTWYB2H3nLGob02/EhIDpZJ6QNafQX9RM9pCuoLnxzLBvVSHzOOwz4
	AuD2F2PUZ9xJxBixawxWd/JeM0C74Zt8+/cUXQ78YAe8/IZ4zu8OUPIkHxLopYK0FE95Rn
	KwTY71j8NrOaounDfSFzLJUjVEtPK7o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-xo6fJ5dcOlCZUOKUHmwW8A-1; Wed, 30 Oct 2024 06:40:11 -0400
X-MC-Unique: xo6fJ5dcOlCZUOKUHmwW8A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315cefda02so46811305e9.0
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 03:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730284810; x=1730889610;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mLeQeKxO4bKCx0zllR0uO5tRuOw0Dm45NAsZWOAqEzw=;
        b=Zn6RxU2qJXvia8r6R3X6Cot/TAX+W0UlfsGXBj3d91XnHPVwzGfGqYyRNCWteIPZsg
         YWh7yS/bxfoFxkR901mT/b1axfqyRAjF10Cikoh0zsLVCUUykgM0LfhlGxRzDvngoM1d
         no8xEMxNsywR6JUXoR5PgY6lh7C3A2xpkvyjZqBFgVFsggCfRcJ1zBKqboRlfSRnjNJ1
         d5vc5660fMOqYixK7KBFmMQghRUoF0e32ZLs38/3E07NANUko/lBlzt0tcek9RwhE6rL
         PLHIRCbVLqvxmPVZ7XEA5FHtmAXdIqUmLcWPDszMsL7LEuRUJtfpWBE9MMk/jq+rllON
         5EQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8OR7Pmmrt1CVfM0q9LYaUOgSZ8MgA8CArfvpm4iC0gL6UKHBWW/dzdYkfNVnAJl/NKHEh17F8cxq/@vger.kernel.org
X-Gm-Message-State: AOJu0YxRk5mfHaQX6h6SYVniCDeZIVNF8m8kN0vUG6pVDo/vWi2Pa5pu
	+14iR4QPeOZClXQO8MnGxr6dc0nWpRL8BxIMhXZwmVEWSMQA4+wkP+GzLGbPE7RTxfAyAgJq09E
	8mypDkQEzLErvBW/QHZ4kZnIgf2l4M3IJTZ4DUpWOHnG80PTaYQ5JGStz/f8=
X-Received: by 2002:a05:600c:3515:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4319aca3fe5mr112681575e9.11.1730284810321;
        Wed, 30 Oct 2024 03:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiEZzVF2gCazHGJtH0vEuDXfbOgnEmBrD4+SFTyK948KaP3norxDlCMnAsp660DUkE7QtV8A==
X-Received: by 2002:a05:600c:3515:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-4319aca3fe5mr112681295e9.11.1730284809957;
        Wed, 30 Oct 2024 03:40:09 -0700 (PDT)
Received: from ?IPV6:2003:cb:c733:7c00:d067:e327:4f99:7546? (p200300cbc7337c00d067e3274f997546.dip0.t-ipconnect.de. [2003:cb:c733:7c00:d067:e327:4f99:7546])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b70c44sm14957838f8f.80.2024.10.30.03.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 03:40:09 -0700 (PDT)
Message-ID: <c47337ea-f20e-44eb-95e8-c29b2db849a7@redhat.com>
Date: Wed, 30 Oct 2024 11:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] acpi,srat: give memory block size advice based on
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
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-4-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20241029202041.25334-4-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.24 21:20, Gregory Price wrote:
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
> 
> Use CFMWS base/size to report memory block size alignment advice.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   drivers/acpi/numa/srat.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 44f91f2c6c5d..a24aff38c465 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -14,6 +14,7 @@
>   #include <linux/errno.h>
>   #include <linux/acpi.h>
>   #include <linux/memblock.h>
> +#include <linux/memory.h>
>   #include <linux/numa.h>
>   #include <linux/nodemask.h>
>   #include <linux/topology.h>
> @@ -338,12 +339,26 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>   {
>   	struct acpi_cedt_cfmws *cfmws;
>   	int *fake_pxm = arg;
> -	u64 start, end;
> +	u64 start, end, align, size;
>   	int node;
>   
>   	cfmws = (struct acpi_cedt_cfmws *)header;
>   	start = cfmws->base_hpa;
> -	end = cfmws->base_hpa + cfmws->window_size;
> +	size = cfmws->window_size;
> +	end = cfmws->base_hpa + size;
> +
> +	/* Align memblock size to CFMW regions if possible */
> +	for (align = SZ_64T; align >= SZ_256M; align >>= 1) {
> +		if (IS_ALIGNED(start, align) && IS_ALIGNED(size, align))
> +			break;
> +	}

Are there maybe some nice tricks bi-tricks to avoid the loop and these 
hardcoded limits? :)

align = 1UL << __ffs(start | end));

Assuming "unsigned long" is sufficient in this code (64bit) and "start | 
end" will never be 0.

-- 
Cheers,

David / dhildenb


