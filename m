Return-Path: <linux-acpi+bounces-12615-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEFCA78252
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 20:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC4618813D2
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B102222AC;
	Tue,  1 Apr 2025 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bxgVL3n3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A66221F34
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743532443; cv=none; b=Ct5bBFZ+pDVjBdGtDqONusUp4NoFiQrCIeSjPsJ1JaxnftSMuJP2YbWdZ02h6zTmFgz2BS29L4k64FVK0ACiv/eUeThrruKSKwowjTWLKuy8XgL7ukTkoWGVDkmAgIcTKZ0en5nEjsYK7t29kZkY0+SWS1zS7r5+flK4qlKZlLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743532443; c=relaxed/simple;
	bh=X8LDjNcfXQ4Bn/njeKqzo2cM5/0QgsnINerxJbWT884=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkKn78Xbu41flDA4zTsygBfXxVLzrX22y7iHi7dQsJ4zNgDtWnCNaM+JrAIxGBEdyhhH3znp0DgA61X60MheCIAH0OwRZYURSOfwcj2eDGhn2aIWHf+9pMxOD4BJlC9gdTSAV0vsx/gvIXajrfDJc1WoJyRqW8VtfwgMwnm8eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bxgVL3n3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-47663aeff1bso55821331cf.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1743532440; x=1744137240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvFO86uOfXys++aHN99bumZHLvFpFBrUvW1hjDZlBME=;
        b=bxgVL3n3e+PDofbiAT4TqUKsTxcbwLnTYM1Kre0JlfHg5Z0Bkxi3iW1a1jd+RZMkZc
         gY+gineO8xxaAMpBpe40zMhix/aQhNuJyM8x+5OzAeeV3WuL4QWtqWSI/ukQPNR+SNAm
         1lbty8gnJBtWHKHpkx72Xd1sqsum7XdZJy9+tDCgPoed2a5DdZbPxxm1C9Xvpw7QJmUe
         8Q6GIMZtc7E1zn8AdSqbJMhCBiGBWrLp8P7Jzvd/tBbEXFO7VLX8g+RxBk2NSM2BdAEF
         et9xn2ZXhYHicb3oCMFnHqFCdMv/E3hG1i/FTfWOfgB44ArZLhm0f3EilcHaHpOIZmCa
         k/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743532440; x=1744137240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvFO86uOfXys++aHN99bumZHLvFpFBrUvW1hjDZlBME=;
        b=nSrGMlq3c3SrQrDN4yVA3mr+pvmIQb1vOzYRFJj7Da9oMlyeQ4BBLiDlGFAWDP/5Vv
         X4e4PqzVoRV1JhKhesfNqMQni5HY0rHDeffBzgO/xTO08EMpnu0debvv/7pmGRPBoUxb
         Wym4H5gt81Zq9EYQ/XqH/uV17h5Rd52UIP6BIri/AyxQVtOyuha2W5pNvcSSYsF33b9p
         RackfDUmfFOBlPzML8h3xCtsRJViVcbK+A3JDQcKRrttKvtv+jYu9nISRJiDVwo0iHA8
         gruvMLPjAX0SbPL7aCOVg7c2MAfGqNUos8EOrNfrqow20FV0ePafQt3PcFHpN728x46N
         0dpA==
X-Forwarded-Encrypted: i=1; AJvYcCURW/ODgfbXwUUYvR7YRCu/8R+qrW9Hz7UBNLOPUlVcAImHQkeb+bqB/+n/MdtebzuDcSCSssb/bcrp@vger.kernel.org
X-Gm-Message-State: AOJu0YyaG1yT24ZVJ8mgs5wdq93GLo9KLZNIbG74Jq+/yTxUOZD25XA9
	9he0MONwHOXnLKiNOA3ZJtOI2EuEkJhAAG8MDC8+isjYNHoKqiCAhu19MFGLP18=
X-Gm-Gg: ASbGncv7ng5wNAszN2JA1XV3xyhDQ0oxDVHpi2p8s3vNaO51DYIxQOVwwJO9D05dxyy
	W1IqyPMaFh6SkfHgKFKyp2GmZaJrmJw3Dqua0m4t5KG2c1nazUvg0rqgEPpmJ/DPdqOrNFN2kme
	Wz9I8dDE9DvOvLfE3KzUIadcYoN2aVwmT1xEpswqaHa16GMhBNetnplAc2LBKxJ/pw542/t1Lh4
	6R5VlWlPWfWv+hqH86OEafAxv0Qbcn32o2NpKBmu5tWAROKvYixDevbquZbBwlGFLeMQmZEwzGQ
	Qh6o6Ki9o3lE870ntrD8GcrtiocBpJmzQxJgt4690xLBly+J2bCp+VW5fqeTz+lflTuRcPahEfh
	fSzbzu1msgyA8RKhIb738JTZbnfo=
X-Google-Smtp-Source: AGHT+IEIYtaOaF9anjPimhqDpAgFdltbw1UzV5b/pfKJo08pDKfU/jOer4wWpo31Zghqh/X5Dhy8Cw==
X-Received: by 2002:a05:622a:1a01:b0:476:7b0b:3110 with SMTP id d75a77b69052e-477ed72a711mr245214581cf.20.1743532440314;
        Tue, 01 Apr 2025 11:34:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-477831a6579sm68620191cf.73.2025.04.01.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 11:33:59 -0700 (PDT)
Date: Tue, 1 Apr 2025 14:33:57 -0400
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org, linux-acpi@vger.kernel.org
Cc: kernel-team@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, david@redhat.com,
	osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, rppt@kernel.org, bfaccini@nvidia.com,
	haibo1.xu@intel.com, dave.jiang@intel.com,
	Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <Z-wxlQBIIjqbbPqu@gourry-fedora-PF4VCD3F>
References: <20250127153405.3379117-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127153405.3379117-1-gourry@gourry.net>

On Mon, Jan 27, 2025 at 10:34:02AM -0500, Gregory Price wrote:
> v8: nits and tag pickups
> 

I apparently already cleaned up the remaining nits. So this has been
stable.  Just did a rebase on mm-unstable and it was clean, so this
should pluck cleanly.

Andrew, do you think this should go through mm or another subsystem?

~Gregory

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
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Tested-by: Fan Ni <fan.ni@samsung.com>
> 
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
> 2.48.1
> 

