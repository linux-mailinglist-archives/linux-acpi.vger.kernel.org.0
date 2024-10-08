Return-Path: <linux-acpi+bounces-8612-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34923995268
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 16:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF26D1F2617B
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Oct 2024 14:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1D01E0086;
	Tue,  8 Oct 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="MhgcSAsu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C733E1DFE1B
	for <linux-acpi@vger.kernel.org>; Tue,  8 Oct 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399101; cv=none; b=Eno7i7GPOjl0ZnZwP2Zu2KkIicr/ggPb/nVz+FRFWWlMykqqDXpUpsEYlwBphMQUXMnWRg3MtVi68E7dg15Y94fRhunhK9TkSmRg181XXWzUq2KMJ37ige0XDJZ81ZMCYVjuXhaiIS4jGGJy1KE2Zfw4gG+Sd1TTgPkCFZelrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399101; c=relaxed/simple;
	bh=FdX000BfNXmYUb4opHXMevAqiMWP56/tqAYYlyDF/SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8cXDjAble7KJHxbo3TMbvgIYeFFzRFUdZfSfbmaw5BqAE4mD6nGKMyUnUyJl3i8+Fv9xIe515Wlp62t1OCpeAkF3a1281SCDCjVcr/zenjbXALNzjfGNweCp/pS5MlwrpTb1k+y8pHEIT3oPLM59xrUBvqiZgqhsJvgIcutD14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=MhgcSAsu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a9ad8a7c63so567069685a.3
        for <linux-acpi@vger.kernel.org>; Tue, 08 Oct 2024 07:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728399099; x=1729003899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=MhgcSAsuU+jCrZX0l4hWSH5pUs0TMn9rZR9g9vqnKmTJlaAUqcXirI1m91ppzNRdB2
         yBW0ompQ8CCS2isafEyPBA68NaRTDth/Iuv2ZSxib0nglHmssItSMkO2WkgY/3OLGrGO
         ToaWBIPzhzTbIlfJDtUdbqUwsxwnQRDnrlK2ZvKRygTzG+gUq2b9Ex84naglBcpfUoUj
         wKvsgMH9YkY3vCqAeLusFZAh+22QaaBhPw2shOjIhNEYp1uyE6S7uxvAdo12eyF7wU+i
         IMOZpfkMfT4yA830bdiXc1fw5iuXocEb7hT32rTjkJxJvQRilU7FhSao9UNXq3wB8NgH
         E7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399099; x=1729003899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+8u49KVyhPOrweO2lc6eBFQS+Hc6vnffHct6u8Jv+w=;
        b=aoB7gGAHi5KdBwNErEZ8LUQeCl+8yjGmxnBMyh7EaQRALBxcXsa+AFTj5hisOKVcOR
         F66YOVl3HO0PG2HxEWWxJNIy+bUxV53o2L3wmT5vZlHqCFG4rQza8TLvO1Y+DmcZwwns
         BCLEtv5WNhWlp9p5/4kqdyj39mmw0eYCUvzS6LevqYrv7qcf5kPLbOQ8l+zHPvP6CTSn
         lLhrKQSQcfFKiHhO/rTpiI7Cr8yAHOF5mKKcNzQg7Po2JhrrjKdlQw44um5GH5dVUmxg
         TbbLjCJuyszKWHzEOsJmezFu9Z6DNzAsJCCTNWygBie+BlAdd7h+1bO8nkfZ2rGOKUuy
         LT2g==
X-Forwarded-Encrypted: i=1; AJvYcCXa/EQhFx8ZDK9DW2lGi1VyVArd/5zKY9Y/boonYukRVqszxWY2NkunraHLcsgO/knN+iXDNU+bZNQw@vger.kernel.org
X-Gm-Message-State: AOJu0YwhLFklstayW8abugEdOSLsA5sYu2kVbWEy0bgP41UvqVRiTsSq
	Y+KivAepKy5zuiJeEzJQGxY/DfXjkI+azL0kW3yHcqb1aPAqx+dyLXZCZsJTMd8=
X-Google-Smtp-Source: AGHT+IFq4ejAZimMFPt1747gCyE+Qz23dQBrY1mL0z6fT+fBj1wX7llJiqwXX1zCd9TNFYGsXrL5tg==
X-Received: by 2002:a05:620a:29c4:b0:7ac:e30e:f6f with SMTP id af79cd13be357-7ae6f48699fmr2414673785a.43.1728399098773;
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae75635ca8sm360029085a.60.2024.10.08.07.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:51:38 -0700 (PDT)
Date: Tue, 8 Oct 2024 10:51:29 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: linux-cxl@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	osalvador@suse.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, terry.bowman@amd.com, lenb@kernel.org,
	dave.jiang@intel.com, ira.weiny@intel.com
Subject: Re: [PATCH 1/3] memory: extern memory_block_size_bytes and
 set_memory_block_size_order
Message-ID: <ZwVG8Z3GRYLoL_Jk@PC2K9PVX.TheFacebook.com>
References: <20241008044355.4325-1-gourry@gourry.net>
 <20241008044355.4325-2-gourry@gourry.net>
 <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039e8c87-c5da-4469-b10e-e57dd5662cff@redhat.com>

On Tue, Oct 08, 2024 at 04:03:37PM +0200, David Hildenbrand wrote:
> On 08.10.24 06:43, Gregory Price wrote:
> > On CXL systems, block alignment may be as small as 256MB, which may
> > require a resize of the block size during initialization.  This is done
> > in the ACPI driver, so the resize function need to be made available.
> > 
> > Presently, only x86 provides the functionality to resize memory
> > block sizes.  Wire up a weak stub for set_memory_block_size_order,
> > similar to memory_block_size_bytes, that simply returns -ENODEV.
> > 
> > Since set_memory_block_size_order is now extern, we also need to
> > drop the __init macro.
> > 
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   arch/x86/mm/init_64.c  | 2 +-
> >   drivers/base/memory.c  | 6 ++++++
> >   include/linux/memory.h | 4 ++--
> >   3 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..6086f99449fa 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1424,7 +1424,7 @@ void mark_rodata_ro(void)
> >   /* Adjustable memory block size */
> >   static unsigned long set_memory_block_size;
> > -int __init set_memory_block_size_order(unsigned int order)
> > +int set_memory_block_size_order(unsigned int order)
> >   {
> >   	unsigned long size = 1UL << order;
> > diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> > index 67858eeb92ed..f9045642f69e 100644
> > --- a/drivers/base/memory.c
> > +++ b/drivers/base/memory.c
> > @@ -110,6 +110,12 @@ static void memory_block_release(struct device *dev)
> >   	kfree(mem);
> >   }
> > +int __weak set_memory_block_size_order(unsigned int order)
> > +{
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_GPL(set_memory_block_size_order);
> 
> I can understand what you are trying to achieve, but letting arbitrary
> modules mess with this sounds like a bad idea.
> 

I suppose the alternative is trying to scan the CEDT from inside each
machine, rather than the ACPI driver?  Seems less maintainable.

I don't entirely disagree with your comment.  I hummed and hawwed over
externing this - hence the warning in the x86 machine.

Open to better answers.

> -- 
> Cheers,
> 
> David / dhildenb
> 

