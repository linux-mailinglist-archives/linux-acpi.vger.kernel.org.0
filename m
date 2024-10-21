Return-Path: <linux-acpi+bounces-8867-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7679A60B1
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 11:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E036F1C21B5D
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 09:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4BB1E3DF9;
	Mon, 21 Oct 2024 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZfn12au"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26251E376F
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504308; cv=none; b=pUlr8/CxyN1plRg6PMTU+t1Ytq/DVmOgrJXi5Ws+G7gGj183BhCgVlWqlVyCjM0CykeXPW/IbkB3n6EtW2QZb/V+hvYgfQ4qJWGaQ5LSvwrW21/TGr/LyOTzOuA8xQcVNFukQdTUaMktDolCHWdf1zi4Qo6nRS+2X6lCxmurUNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504308; c=relaxed/simple;
	bh=ytPENfmd0OUkgNYTEli53dWkpmSBjoNnOIojmXzpoow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/cIMn490fCIE5mk82qtEIpuDpII+oioJ3yNuTKxwnpBsuqFThTgywKsHC8TsAV8pgrKMW12czs3O8Q9rv8xD9iTcxDjOFaM6o54wsCSEgoGYyqBQOgOLdHNG6wp9d8i0jyB+teR+QVe9sc7mJV9rMCWZ/vdnAzl3GMtEQq81M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZfn12au; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729504305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4nn/+beuGSyT6IppBG0CXPg7AYEwhH2O7vh6xIs2kpA=;
	b=ZZfn12auFXAfbUnpbsLJmb4GyG9Lw4O0a7eO5CFA9G4K0i/ZQyb05da2JurbSqBddOhxmx
	OyXaMAhma6/6GYhN89uorNo/phcrTxVFV6C+eBhqmB+HfPN5ygeUyQCQkPpCDn/ei5oGIx
	RZ4mAKT9v1ut3hKGU6xn9l5wYaJaQFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-V6qgB1PyO42mSTSXiThoAA-1; Mon, 21 Oct 2024 05:51:42 -0400
X-MC-Unique: V6qgB1PyO42mSTSXiThoAA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315d98a873so27856225e9.1
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 02:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729504301; x=1730109101;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nn/+beuGSyT6IppBG0CXPg7AYEwhH2O7vh6xIs2kpA=;
        b=MZO1BjOH3ZVsYTR3+n4lfHYwXC8dyopi3PvcdlMnp8jVn5GUJgYPF7NdFfcVjyPxxO
         KJ3HUqDPrK7bZV1mqdX9kW3Bymq6L+FsrpJFeUpJphOFFkjYvH2LjvFRitZwtu/XhEzj
         dbNqisUoM7nVUFaesN3fVsxX0VT5IzdRZ/3G3lXK/26/VRiYZTTMbdDbNmRdRLY5ANcz
         YshjSxqTfE1d19yq+fbSoN5xPHLEtjt2WLuGkTif9eqUwc6uyNAqs9hw9rgWdCkg0hMd
         +IaYlmZmgjZk2tTwfE2Z0Lhs5Rem024sKK9TqqBIKvtgpR2PnmysJHKTnx2eZLF5hKHT
         zbYA==
X-Forwarded-Encrypted: i=1; AJvYcCVNl35kHRToI1DNYhRGnMgHVGNobcAclT0lGneIQyA4p/oaj71YAeCr/3bJhv/kXoPvqtCeI1vxRwS5@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuaua5JPIzIAsvpCJud6eJ60jKAOhF8xawKYHxzGob54wLBama
	Ce/aY/ZtPztB1wU88zAiKDwC4tSbKW1fc7n667HL9VsjuKA5PzxN/VfZy4iSHqIDCMSDpH/pkqk
	OWYfrDDlwyyRlKXAA58njJu8sMeCG1/du+dZlALnUBBvBErEcK6kHqaNLRHs=
X-Received: by 2002:a05:600c:1d1a:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-43161641cdfmr87276475e9.13.1729504301191;
        Mon, 21 Oct 2024 02:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL1nqu+VttUCQ0203kNMq9H/NLS7ZxrRhe0hPz/aN+ndMq9UmgQAQTp//+Oz8jWOZFaykk3g==
X-Received: by 2002:a05:600c:1d1a:b0:431:6153:a258 with SMTP id 5b1f17b1804b1-43161641cdfmr87276245e9.13.1729504300815;
        Mon, 21 Oct 2024 02:51:40 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:36d3:2b96:a142:a05b? ([2a09:80c0:192:0:36d3:2b96:a142:a05b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a477d9sm3898910f8f.26.2024.10.21.02.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 02:51:40 -0700 (PDT)
Message-ID: <c811debe-32db-4c77-a799-ee89427a5174@redhat.com>
Date: Mon, 21 Oct 2024 11:51:38 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/memblock,x86,acpi: hotplug memory alignment
 advisement
To: Gregory Price <gourry@gourry.net>, x86@kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com,
 dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
 rafael@kernel.org, lenb@kernel.org, rppt@kernel.org,
 akpm@linux-foundation.org, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, rrichter@amd.com, ytcoode@gmail.com,
 haibo1.xu@intel.com, dave.jiang@intel.com
References: <20241016192445.3118-1-gourry@gourry.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
In-Reply-To: <20241016192445.3118-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



Am 16.10.24 um 21:24 schrieb Gregory Price:
> When physical address regions are not aligned to memory block size,
> the misaligned portion is lost (stranded capacity).
> 
> Block size (min/max/selected) is architecture defined. Most architectures
> tend to use the minimum block size or some simplistic heurist. On x86,
> memory block size increases up to 2GB, and is otherwise fitted to the
> alignment of non-hotplug (special purpose memory).
> 
> CXL exposes its memory for management through the ACPI CEDT (CXL Early
> Detection Table) in a field called the CXL Fixed Memory Window.  Per
> the CXL specification, this memory must be aligned to at least 256MB.
> 
> When a CFMW aligns on a size less than the block size, this causes a
> loss of up to 2GB per CFMW on x86.  It is not uncommon for CFMW to be
> allocated per-device - though this behavior is BIOS defined.
> 
> This patch set provides 3 things:
>   1) implement advise/probe functions in mm/memblock.c to report/probe
>      architecture agnostic hotplug memory alignment advice.
>   2) update x86 memblock size logic to consider the hotplug advice
>   3) add code in acpi/numa/srat.c to report CFMW alignment advice
> 
> The advisement interfaces are design to be called during arch_init
> code prior to allocator and smp_init.  start_kernel will call these
> through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
> prior to mm_core_init and smp_init - so no need for atomics.
> 
> There's an attempt to signal callers to advise() that probe has already
> occurred, but this is predicated on the notion that probe() actually
> occurs (which presently only happens on x86). This is to assist debugging
> future users who may mistakenly call this after allocator or smp init.
> 
> Likewise, if probe() occurs more than once, we return -EBUSY to prevent
> inconsistent values from being reported - i.e. this interaction should
> happen exactly once, and all other behavior is an error / the probed
> value should be acquired via memory_block_size_bytes() instead.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>

Just as a side note, a while ago there was a discussion about variable-sized 
memory blocks -- essentially removing memory_block_size_bytes().

The main issue is that this would change /sys/devices/system/memory/ in ways it 
could break existing user space. I believe there are other corner cases that are 
a bit nasty to handle (e.g., removing parts of a larger memory block), but 
likely it could be handled.

-- 
Cheers,

David / dhildenb


