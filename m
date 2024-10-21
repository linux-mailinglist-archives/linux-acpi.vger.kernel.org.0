Return-Path: <linux-acpi+bounces-8877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F409A6C5C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 16:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33351F22A6A
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 14:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4371FA261;
	Mon, 21 Oct 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZBq15AK5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D11F941B
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521595; cv=none; b=OXCvMrs89lzWkSEXUbBEByYHOoQhRa5uCE1NxgF3zAW14wW2KvQbULOs4OPGpMq1C/Gdsr83Qyozf/M6myOrVz/8avPFkY4+aMik1qe4bISF0qO1uafKc3XIFb1R9kKPgNH17on1T2IoBnUiuMdgi3Bg5W9pGpIwzI7mOVxAtd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521595; c=relaxed/simple;
	bh=uMtbkt7MShDxCt5FX6kmDCLEOQrSOdDCjrPJVBe1XYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAkSA6WW0wXnNdqL+QxUxITsLn9GjSzp6n/ot3kOMs7nNTZ+vli2iW4S51WBLf2gPyC6vllt3EHyYt5On2te6W9qraZvdhuToXzUrwIX2PE6s//psbUsO9w9WPcDSxQ+R9DFRgNEiSXrRrdVvHpz9KOgoHFUBuy4XINs2CVatQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZBq15AK5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6cbc28f8e1bso34754986d6.0
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1729521590; x=1730126390; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QBwvaCcMFp61JVh2xwSwuOplQvwOE8lvZKAngP58VqI=;
        b=ZBq15AK5OM3g+Nc0zIQPjIIy75cQL+ffYldhRqlQIiBMqgENEo4giSujsumk2OIrmA
         nHwIQcUX0Syf0pr2McZlMzswihQtldV4h08/aq0459j5SACK02oC1UrtkwgX5d9ueYNo
         f3E2QpbybVf75BqnHjEJ5q46z/bJsytt8gtyI662cQ0rBJdXSzv/WmV3lQ+EomS51XG4
         tfYSEc2qIYYBv2sXQ7um6xOmKzbo/M1hj3GcJMjOqVsbXMRCaYi4ND5kKw/1d+EvwkCa
         PSd8snyVVtouzGrUPt0gwtyhBdD9yytYzcBFAJxXp+4PflTyOy56i8eVPKtGrdKZ1E2I
         Ycbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521590; x=1730126390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBwvaCcMFp61JVh2xwSwuOplQvwOE8lvZKAngP58VqI=;
        b=Nlem49wzWL+Pp/gfpow4YPE4NHEwzCAhTP3u7bZmqRbT7FS8vCZzW9SlEKUmk/99uE
         YwLDdBim2rqdenCJDv6c7y29BCWYfbe4eZ2GbwTo9MQNsxsOf+duzu3z/7NZfwMACUyP
         bZpOcBs6biMJ7MXkMLxaPG0PnC41o1MupFwO78MTBUDmoRLf8NaZK9osz9U8ZOXoy/ni
         DUxdVudyXyRRywxJAHpPy0iKVU/K0y/rEOq7WD07yXyaj+ig3TSxO8b3V8oII82u4zgF
         2tZqF88oZ6jprJ3QMtPrvopJlkmhwo4m2LM4BpsgotqJYC65T3lHLVmOoCY6jzbMwq77
         ljIg==
X-Forwarded-Encrypted: i=1; AJvYcCWe67dxa8kgUJA0/gtYqKV2fW+KQzVgbSiGtuXgYC9sXesLWr62VQqskpDzHg+pJfC1vqB/TvvrmJux@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzWx1MmPqpMZ/7ws+cGPVSp67yq5KMZhPfkSVdCLGzz9D3b5c
	VucQ4KLGc2rm3Kh484uf6CoRLj+EPmyUfK1QLss5ZXzklQV6EhBK8yPRa9qIdYY=
X-Google-Smtp-Source: AGHT+IGwsR9nAFy5MvyVbGW/I5DDauVanyhn/ZsHEw5JDwji7gr1JZ+g7udLuUSB5y7QkaH+lDD7BQ==
X-Received: by 2002:a0c:c690:0:b0:6cd:fa19:2b64 with SMTP id 6a1803df08f44-6cdfa192c79mr99765406d6.39.1729521590563;
        Mon, 21 Oct 2024 07:39:50 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0091ad82sm17423896d6.63.2024.10.21.07.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:39:50 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:39:51 -0400
From: Gregory Price <gourry@gourry.net>
To: Mike Rapoport <rppt@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	dan.j.williams@intel.com, ira.weiny@intel.com, david@redhat.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	rrichter@amd.com, ytcoode@gmail.com, haibo1.xu@intel.com,
	dave.jiang@intel.com
Subject: Re: [PATCH v2 1/3] mm/memblock: implement memblock_advise_size_order
 and probe functions
Message-ID: <ZxZntygJWqxq0zGt@PC2K9PVX.TheFacebook.com>
References: <20241016192445.3118-1-gourry@gourry.net>
 <20241016192445.3118-2-gourry@gourry.net>
 <ZxTF93VzRiygScA1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxTF93VzRiygScA1@kernel.org>

On Sun, Oct 20, 2024 at 11:57:27AM +0300, Mike Rapoport wrote:
> On Wed, Oct 16, 2024 at 03:24:43PM -0400, Gregory Price wrote:
> > Hotplug memory sources may have opinions on what the memblock size
> > should be - usually for alignment purposes.  For example, CXL memory
> > extents can be as small as 256MB with a matching physical alignment.
> > 
> > Implement memblock_advise_size_order for use during early init, prior
> > to allocator and smp init, for software to advise the system as to what
> > the preferred block size should be.
> > 
> > The probe function is meant for arch_init code to fetch this value
> > once during memblock size calculation. Use of the advisement value
> > is arch-specific, and no guarantee is made that it will be used.
> 
> I'm confused.
>  
> Aren't we talking about memory blocks for hotplugable memory here?
> This functionality rather belongs to drivers/base/memory.c, doesn't it?
>

You're right, I should have put it there - i got distracted by the ifdef
mess around get_block_size_bytes/set...order and just tossed it into memblock
to avoid it.  I should be able to ifdef the definition in the header and move
it into memory.c
 
> > Calls to either function after probe results in -EBUSY to signal that
> > advisement is ignored or that memblock_get_size_bytes should be used.
> > 
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >  include/linux/memblock.h |  2 ++
> >  mm/memblock.c            | 49 ++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 51 insertions(+)
> > 

