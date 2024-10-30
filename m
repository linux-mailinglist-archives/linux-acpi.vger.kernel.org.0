Return-Path: <linux-acpi+bounces-9123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 806A49B66CC
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F767282765
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 15:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA0C1F7062;
	Wed, 30 Oct 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DYEUmdjF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68981EBFF7
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300496; cv=none; b=qf7RTTlMZSfwVaffYeVQmPhfp7PlfAEjYPi/Wk6x5KPyD4ymzDwg122gYWpOZ6sf8BaKSITAW/pOQxqVT1fyGQApcbpxV/nArVg/Litm2E1ksPaZ2AMGLaz/Ar1FR7odcisPfs4OQw1iWyEBFEi9Uf4KjY9vTgFl+D4hZTMyMAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300496; c=relaxed/simple;
	bh=FL8y5vH2DP6OO+W2bGbV05vpOD/N9aEaxA/0pmFdX6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8deBXyCxxKp7crC+2Us9mNhfMMbIga2mYaGcBQIgWNYJLIAoNxkLCYYZEEnI/yWlqSYBAVTd7eMIMrb/PKoMh7+/g6UYNaIFB81p9VX2m3qITS0hwrb/HccXQnwddEs2B6OOJ983qQcjFiUM7G98waC09pa+Oo3qXoO+l22yTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DYEUmdjF; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbe90c7c95so48331976d6.1
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730300492; x=1730905292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Q8Onf+m3kOOMRY7hbWMtGK0sJkECClNbY5UDCI4RFs=;
        b=DYEUmdjFGdHgGK+dT9jD0zmz6subT09g6tL6rJhMKfF8dqY2awwrdV8R8S2rk6uZgA
         vBP8DnXGob/dsbV8kRhSA8mBwkshJTMpk1wp2nZkDTS83ADsTR67Ihq4AWcPygx14/Kp
         Cf22nv2pZBx+5OvVsUOEg4mMWMzmaMA0wqnVLHWJ6fxpGKczSSsY28721hreIn2NsgsB
         vP1mxnvCMF58N7hP/NgsuZxEws2qmynqwhJmnDvouVcJhNmO4LVFoUw6g+lWvkVXIr/f
         lKCW9pCjtzK1swnQ3N7HQYqQLqI8roVWKeCGycXnYPDfEFpP0tFF2oAy4xS4Ck9aPjii
         TNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730300492; x=1730905292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Q8Onf+m3kOOMRY7hbWMtGK0sJkECClNbY5UDCI4RFs=;
        b=LPo1AEPE8vMnPBGA+RSzEsG5pksaeOdFuX2xD6ZmFQOTmZL/c/4t+hsFsSaS0HdGwO
         892vdXDhkYY7fbaWI8/xcI15GOPYWLQFDA0ym1nT/pDx26NL3R4KPEjXo+S6qrPs9mNh
         R9eqUL5S9kyaEPJ4XBK9aE76KXTGO23I6lKoUBzIKnjaoA0NKkGdjXMsLbcjHisnoqFT
         ItglQe2hYRK7Pxm2Z/FUo8CkTGyBDmjU7gOFcw8mecd5ulI4lWJBQiT4lKxzGATLm3Th
         mWFzev7RUpIiio+O+yVT3vE7K3xt9RVqXYScs0xovh/RntGoeU7T9G0kD09xwCkIAflO
         bd2w==
X-Forwarded-Encrypted: i=1; AJvYcCXkQ0ED8smZLWPB9CgL13N8eXvaDXKqCthcfiFf92rWjqsWUL9IRtVaSJLYvt1xNXraEvKKVkXxIYR4@vger.kernel.org
X-Gm-Message-State: AOJu0YxwvKgI/bUNhrx93tDY9H0+e6ckd9rpix6G7Qvw+12G5tLIuGJ7
	skr7/R8M2IgAV7p0rFuJIQ5+M/8hW3lnAbm4W0WeqWA+qxafr1oc5FDCpjEJwV8=
X-Google-Smtp-Source: AGHT+IHhuKpLShK8fctWjn/NG1FZnDN5PDqypx/YhKTIWg3COMyVpTWAl/pGdOiRoamvWFhjIhqKWQ==
X-Received: by 2002:a05:6214:398c:b0:6ce:1011:60c1 with SMTP id 6a1803df08f44-6d185849638mr176475236d6.35.1730300491405;
        Wed, 30 Oct 2024 08:01:31 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d1798a8455sm52968066d6.32.2024.10.30.08.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:01:31 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:01:36 -0400
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, hpa@zytor.com, rafael@kernel.org,
	lenb@kernel.org, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v4 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZyJKUAcn8iLoV7PI@PC2K9PVX.TheFacebook.com>
References: <20241029202041.25334-1-gourry@gourry.net>
 <20241029202041.25334-4-gourry@gourry.net>
 <c47337ea-f20e-44eb-95e8-c29b2db849a7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c47337ea-f20e-44eb-95e8-c29b2db849a7@redhat.com>

On Wed, Oct 30, 2024 at 11:40:08AM +0100, David Hildenbrand wrote:
> On 29.10.24 21:20, Gregory Price wrote:
> > Capacity is stranded when CFMWS regions are not aligned to block size.
> > On x86, block size increases with capacity (2G blocks @ 64G capacity).
> > 
> > Use CFMWS base/size to report memory block size alignment advice.
> > 
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > ---
> >   drivers/acpi/numa/srat.c | 19 +++++++++++++++++--
> >   1 file changed, 17 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 44f91f2c6c5d..a24aff38c465 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/errno.h>
> >   #include <linux/acpi.h>
> >   #include <linux/memblock.h>
> > +#include <linux/memory.h>
> >   #include <linux/numa.h>
> >   #include <linux/nodemask.h>
> >   #include <linux/topology.h>
> > @@ -338,12 +339,26 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >   {
> >   	struct acpi_cedt_cfmws *cfmws;
> >   	int *fake_pxm = arg;
> > -	u64 start, end;
> > +	u64 start, end, align, size;
> >   	int node;
> >   	cfmws = (struct acpi_cedt_cfmws *)header;
> >   	start = cfmws->base_hpa;
> > -	end = cfmws->base_hpa + cfmws->window_size;
> > +	size = cfmws->window_size;
> > +	end = cfmws->base_hpa + size;
> > +
> > +	/* Align memblock size to CFMW regions if possible */
> > +	for (align = SZ_64T; align >= SZ_256M; align >>= 1) {
> > +		if (IS_ALIGNED(start, align) && IS_ALIGNED(size, align))
> > +			break;
> > +	}
> 
> Are there maybe some nice tricks bi-tricks to avoid the loop and these
> hardcoded limits? :)
> 
> align = 1UL << __ffs(start | end));
> 
> Assuming "unsigned long" is sufficient in this code (64bit) and "start |
> end" will never be 0.
>

I don't think 0 itself is necessarily invalid, but it would be strange.

I can look a bit.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

