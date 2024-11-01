Return-Path: <linux-acpi+bounces-9245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDDF9B9523
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 17:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A13282770
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Nov 2024 16:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE011CB337;
	Fri,  1 Nov 2024 16:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Rbk8xxT4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C765F1C8785
	for <linux-acpi@vger.kernel.org>; Fri,  1 Nov 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730477956; cv=none; b=nY0moXktT9Xom4bvUNmqYdIrFWH4tQcZ3a25FbulmeKi/lT/hjoAJuwnlZJc01NjW/GVZTSWpVK+fm5ulOazmnK0M6L+IztFblL6Q5Qkn29uH5MNitS5LXGRYRpc7eFS2uu3OdyyWMM0RQWJZB1ytc+OT1wOE8SdGGjG/JKqjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730477956; c=relaxed/simple;
	bh=7vZSs69RDO63OeEMDEazP0OF0Z+XKQWHF6dHh01dYrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CD7ngTUJtgBsCXBb0f1RJfH2GZFkkI6ycPxyV96SANKrHRCqbW1Bthv/jhqoZF74KRIjAh4K68D7jXMdTAxs2JvUyR/L+fsOqsRlP7mlg3okI6gZJOP3KJqeAz1K2o01QvJE5zZFKAc2+6WVSi2+t2YnUJy5NNLvfFyjTZQqTMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Rbk8xxT4; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso11486496d6.3
        for <linux-acpi@vger.kernel.org>; Fri, 01 Nov 2024 09:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730477952; x=1731082752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/bSsmwzcmIHT5+RxiruYL3qxqOwdT7Crq4ILwrDDOp0=;
        b=Rbk8xxT4U1VI6H8P1L1WQTx5K3niUcf9B8KeRlNhoYx8uC3Zc2sGc3utdE6jCz93ay
         icN8fDKpE+2WOsz4Bo0fT3Gu+xJF2bHenbTvANFNDRo7sf9e1RWlxL33+Gjngbuz6lWF
         RoVrO/qWMs5DVwbvongwhohCwOvQxfQVFhcHdRHAFpC0r1j6g9kWsaptV4AAripq2Ne4
         eQm/0qqa0El/5Uj9DbEuUT2EfbWsSWiRQEwWzhSghcDnK+WTw9JRCevJNf3Nin4BkiC8
         Zy6v9kpmiH27arBbDG1k0KwR7w0h2u6Wr0thWzjt2oXxF7qy2/dkQACdJ5freFWyRQGJ
         mCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730477952; x=1731082752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bSsmwzcmIHT5+RxiruYL3qxqOwdT7Crq4ILwrDDOp0=;
        b=Y8yhDUhHi2/DNJau3ZzhGubCtXkcefTJHqKUlQeI6By76ygBFpEQFS4uT4kpkEIddl
         LY+2KxwclIuWJgUEiJ61C8e6QRbPLZoIwAEp0KLcxdrv7CoUfRoL0jx8I2TDhP+Vtv8w
         Mea/sj6PFFfU3BMeF3bQm2QfsrLWekkBNwErPs2ElnacKDr9VHKcdc5ef1bj+QuhKezp
         4Rx2qsw7Ukp0RmXu0zVT+sgXdRuv0Xc8eQMElErfANSYMMXKxovFtJ43qVBT6bFvg2Rb
         dXFZOD+Dywb9LkfqJ7Aoav0DPLC4UJyFNrWZmcyBG+G7LGMEluJM9/c5UqcuWcA2pm66
         jhOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUegOBZyd/0mwvCE6/G9lxogJZGt54z0LDedH7E1VNjvvTu0HKNb6V77YDDZD4fuZGUpo5rUFtBMzzQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2a0cmwEhzDHYDc0FZ8c+2BO85UTDph5oF26FfaRHzXSSw3mlE
	VvjdrbcUBvSradgNfa8A4bd6BxoNFCcjEg0CQFlAtnJNqd8owurvz0mtXBnL6EQ=
X-Google-Smtp-Source: AGHT+IGTAWGI1voqkTMjn2gIYEEJTU7/GErDE+jq8ITjtfWt5vaUbYn+bhb3Su6Je6dsCpv9c0kwAA==
X-Received: by 2002:a0c:ec0c:0:b0:6d3:5274:f37e with SMTP id 6a1803df08f44-6d35274f42dmr81776906d6.40.1730477951529;
        Fri, 01 Nov 2024 09:19:11 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a6fedcsm182877585a.78.2024.11.01.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 09:19:11 -0700 (PDT)
Date: Fri, 1 Nov 2024 12:19:08 -0400
From: Gregory Price <gourry@gourry.net>
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-mm@kvack.org,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com, rrichter@amd.com, Terry.Bowman@amd.com,
	dave.jiang@intel.com, ira.weiny@intel.com,
	alison.schofield@intel.com, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org,
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, rppt@kernel.org
Subject: Re: [PATCH v5 2/3] x86: probe memory block size advisement value
 during mm init
Message-ID: <ZyT_fLBsVLlcnYNi@PC2K9PVX.TheFacebook.com>
References: <20241101134706.1185-1-gourry@gourry.net>
 <20241101134706.1185-3-gourry@gourry.net>
 <20241101155147.GBZyT5E190IxnQMzaP@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101155147.GBZyT5E190IxnQMzaP@fat_crate.local>

On Fri, Nov 01, 2024 at 04:51:47PM +0100, Borislav Petkov wrote:
> On Fri, Nov 01, 2024 at 09:47:04AM -0400, Gregory Price wrote:
> > Systems with hotplug may provide an advisement value on what the
> > memblock size should be.  Probe this value when the rest of the
> > configuration values are considered.
> > 
> > The new heuristic is as follows
> > 
> > 1) set_memory_block_size_order value if already set (cmdline param)
> > 2) minimum block size if memory is less than large block limit
> > 3) if no hotplug advice: Max block size if system is bare-metal,
> >    otherwise use end of memory alignment.
> > 4) if hotplug advice: lesser of advice and end of memory alignment.
> > 
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Gregory Price <gourry@gourry.net>
> > Acked-by: David Hildenbrand <david@redhat.com>
> > ---
> >  arch/x86/mm/init_64.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index ff253648706f..f1a495e998ce 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1452,16 +1452,21 @@ static unsigned long probe_memory_block_size(void)
> >  	}
> >  
> >  	/*
> > -	 * Use max block size to minimize overhead on bare metal, where
> > -	 * alignment for memory hotplug isn't a concern.
> > +	 * When hotplug alignment is not a concern, maximize blocksize
> > +	 * to minimize overhead. Otherwise, align to the lesser of advice
> > +	 * alignment and end of memory alignment.
> >  	 */
> > -	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
> > +	bz = memory_block_advised_max_size();
> > +	if (!bz) {
> >  		bz = MAX_BLOCK_SIZE;
> > -		goto done;
> > +		if (!boot_cpu_has(X86_FEATURE_HYPERVISOR))
> 
> s/boot_cpu_has/cpu_feature_enabled/
> 
> while at it.
> 

I don't personally understand the implications of this switch off hand,
probably warrants a separate patch submission if you think it's important
given the original logic is boot_cpu_has and I don't want to increase
scope change here.

~Gregory

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

