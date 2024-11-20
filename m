Return-Path: <linux-acpi+bounces-9709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A28479D4287
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05980B25D04
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592A16DEB5;
	Wed, 20 Nov 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG3luQkl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CB0824A0;
	Wed, 20 Nov 2024 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130431; cv=none; b=Hx9FVHYAq48f63OmkccBbG5MvcAaNYl8X2257SOIkqRaR0IF64mQtysC3tSxN6tHbrSfb9RhqvqeEdXZGaSjKchYjIUAuWR1MFzv39d4pVvhB9sYfw4xFdhqDQHfyCwy0ILTqhAU/HUovM0aSb5Et0QpQfVCTixvfwIEvPrvjU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130431; c=relaxed/simple;
	bh=JRJRo2Oi0ybA7ydeHsWAVZYbwxKIaKC6OjZznr5mapM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qaH1Q5tKRs0R5DUdDugWQi8LN50AaFJvXCi2GvP2OLL9FvYMFAMqWKUyGzvuR3GvrhJU5/fUozRPTRZ/iDqzSOVgshzUp6+hL7Ws2XL1Hr6xkBBM+4fnCuwbV85YvVKnhC3yvcpIlWtKfNeOSJM218bA5peGahHMS8i5qy0iunU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG3luQkl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21210eaa803so384455ad.2;
        Wed, 20 Nov 2024 11:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732130430; x=1732735230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVkMS7SOnuy3G4XpehNHTXXOXgHnTj+iNth4NXTwJqU=;
        b=PG3luQklfdD1GpxFQ2aS0qZ0LBqL3YMLag76cU53N2UR/mMwXeSSNMo3AU+MP6Eyu0
         2TwadSYNK0yRmH2KD5S2XTC2RlW5x0pyczgKLqQD+eMMOj5e/VASO7jSwqwv18ImMPth
         iXU4RD5t6NZgdLG2xEo5tQxTx53oxBaYRLSTUYyrIIz7cZFPgkd5PDsf71Ln7+iKqa8n
         FW2RvksWI5XgDiwMv08U8nnsr6Y5gU0+RtFLMtduudu2bVdwIBhWX1NlRDvxnJzJ72la
         awVlTCvmvgsPXWCP1d2VcIaMA/jQ9o4Kqzhi7kJoRnYwupZ1b8EVkQLnsqZ6+mNUcnYr
         ipqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732130430; x=1732735230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVkMS7SOnuy3G4XpehNHTXXOXgHnTj+iNth4NXTwJqU=;
        b=u3R6anDZlxfWf6Hsz4XZ3k1nDgoE2jBbzpdi1NVuR5fwzPCoMrvwuDjmyPDWn4iSu2
         kmM32FwrQA49Q3sUloHj4nUJRsIA/cPRsxqBQmc0/plOpFEYyGWlaSrRAPIPTPy/gmhs
         d8L+c9HgDFqiTjVIaureJMZVNYxQFKPZQMhnmn6FKHCXhPVy3usK9/gKJUduIuTwJahB
         rDTh9ZZIDfQCi6euyt0Id96WMpGIpgXp6vU5wnRJPkP/IVipnEQZsgubdrGxFvgzSnxh
         Aj6Hgv/1Kud9ZM3Q0KHjmJwH4cOKj4o0JleSsTE1jmDJsbbHWsy+tG3wob5/w+I+2mgi
         n5eg==
X-Forwarded-Encrypted: i=1; AJvYcCXJu5LQ+ExRK6d1cOdjbL0qJFJTKYxN4ibxHCSfYQ30k/m4oNeAipsRQfV2Ft2T8KHeE1Tz0mD+ru4M@vger.kernel.org, AJvYcCXrSugMVECg/r0cH0TzkG4ikMRze4cnJHSFs8pZIPaBtQxbAxHfdAklReTV/mCz3y/TLY20ljvWQZOR@vger.kernel.org, AJvYcCXyCOGodHGC16Zt8OgmMP6wZdZ3f+TO1KLSvRRB6pMS5cq/18yfp03vGDAMGfGh5jSaBj8oGsQ0i8j5DDxm@vger.kernel.org
X-Gm-Message-State: AOJu0YyajWgBQgLbA8RzC94sJ/4buzWB1GIzcMxP7sq0tzOWKUF6HfwP
	lcxTObM1mBNd/Nt4swTVQt26HyXitFkmEzoIfvLAUviW9aeiRb2Z
X-Google-Smtp-Source: AGHT+IGkeFT658eRFseEUmi+fYk0b8sEK0+TJIC98SNQyfI5clZCIt4++25ouRAtqYHNHR4LI1Nv3Q==
X-Received: by 2002:a17:902:f606:b0:211:fb9c:b1ce with SMTP id d9443c01a7336-2126a3a4ab3mr45550455ad.17.1732130429634;
        Wed, 20 Nov 2024 11:20:29 -0800 (PST)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21209a60aa3sm66621535ad.184.2024.11.20.11.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:20:29 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 20 Nov 2024 19:20:26 +0000
To: Gregory Price <gourry@gourry.net>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, kernel-team@meta.com,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v6 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <Zz42ehwdXDcX8rIu@smc-140338-bm01>
References: <20241106155847.7985-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106155847.7985-1-gourry@gourry.net>

On Wed, Nov 06, 2024 at 10:58:44AM -0500, Gregory Price wrote:
> When physical address regions are not aligned to memory block size,
> the misaligned portion is lost (stranded capacity).
> 
> Block size (min/max/selected) is architecture defined. Most architectures
> tend to use the minimum block size or some simplistic heurist. On x86,
> memory block size increases up to 2GB, and is otherwise fitted to the
> alignment of non-hotplug (i.e. not special purpose memory).
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
>  1) implement advise/query functions in driverse/base/memory.c to
>     report/query architecture agnostic hotplug block alignment advice.
>  2) update x86 memblock size logic to consider the hotplug advice
>  3) add code in acpi/numa/srat.c to report CFMW alignment advice
> 
> The advisement interfaces are design to be called during arch_init
> code prior to allocator and smp_init.  start_kernel will call these
> through setup_arch() (via acpi and mm/init_64.c on x86), which occurs
> prior to mm_core_init and smp_init - so no need for atomics.
> 
> There's an attempt to signal callers to advise() that query has already
> occurred, but this is predicated on the notion that query actually
> occurs (which presently only happens on the x86 arch). This is to
> assist debugging future users.  Otherwise, the advise() call has
> been marked __init to help static discovery of bad call times.
> 
> Once query is called the first time, it will always return the same value.
> 
> Interfaces return -EBUSY and 0 respectively on systems without hotplug.
> 
> v6:
> - boot_cpu_has -> cpu_feature_enabled() in x86 code
> - ack tags
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> 

Tested on a CXL server with a directly attached cxl device, works as
expected.


Tested-by: Fan Ni <fan.ni@samsung.com>

Fan
> Gregory Price (3):
>   memory: implement memory_block_advise/probe_max_size
>   x86: probe memory block size advisement value during mm init
>   acpi,srat: give memory block size advice based on CFMWS alignment
> 
>  arch/x86/mm/init_64.c    | 15 ++++++++----
>  drivers/acpi/numa/srat.c | 12 ++++++++-
>  drivers/base/memory.c    | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/memory.h   | 10 ++++++++
>  4 files changed, 84 insertions(+), 6 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
Fan Ni (From gmail)

