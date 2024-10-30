Return-Path: <linux-acpi+bounces-9127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE00B9B67C3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 16:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD23D1C20904
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Oct 2024 15:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470D213ECD;
	Wed, 30 Oct 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AhIA4s8M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5BF215018
	for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 15:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301913; cv=none; b=tzQPc7VjF3dxaGZl7mSzxL7/Se7uUdgVs57L2YRJNMWcmWl3lWwTgDaSkNtKjPuJng31LezBa3zOvYML5lcynCuxK2inszSZTp+p+w9BlQufn6G3k7PUME/NQAcEMkEbyfPgWiYhMDd+XUFya4/1ooEJyvt7o250hZ97W0xXl48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301913; c=relaxed/simple;
	bh=NEIgB2tFlQkG+JrX4hQVS8M95TFQSsPnWmdZLvR/njQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1/LThIvqMdM6Rxki676TFY+VjiJt7eCUpLiaFEfymUd+RluOkajZ/LSVmpI//odMILj+0jjDoPsPE3O44scnV7QO3qROM5tVIJeVb/wteXfu0yciPua20BNJs4llQ+6Z6svc1PZcPRA6aO6qRT8uJnMjptCxNAxrd5L4aZiy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AhIA4s8M; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4609967ab7eso46994561cf.3
        for <linux-acpi@vger.kernel.org>; Wed, 30 Oct 2024 08:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1730301910; x=1730906710; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YLqxwpXuJNQygjoc5/hn+2+ADZpj/AHIhIEEnWpyXU=;
        b=AhIA4s8MqbgWg+ZbRSzG+38DHbbAMKeSwtiPDf925OIgvJqOrGMQneQQtiY9POPQJF
         SwZ6ffTIme+H0/mzempof9BRw2AtR1yxNemfrprls9Wtcd+K4qnXqeliX+jEbpgc+WBU
         ILNstDkhBvL7gFhILPVzv7FngIcSZb5vPk0+VDATMM+yLIOFcGDmn1toMdf08YSd9m4H
         /s8uFfTH2fliMYZE4SDFkcagM0RousZX7LeQUHPck5SGfIFa6gkjfyMF6rBR5WxvNEAl
         QbD+tDKUWsNjyXkupOaP5XIOJPHV4dJnBQEYCcDXVzfOt5lr9wcvU90PdKd0Mry79P7r
         veXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301910; x=1730906710;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YLqxwpXuJNQygjoc5/hn+2+ADZpj/AHIhIEEnWpyXU=;
        b=tg0YjNLnxvEUxMPIeyHj3LOPXGXuFx0D8o4e07ByTY+8v6ftF0ZedEcr590e/gE8hs
         ZwIPdz1iR7j5exLCqudMaLaU13qWfVvPnbH+Skz3tLESb4bJ2wHT0h9790Wx3VFtnsZi
         h/11i0ANKWZaCAziBgy3dLsXyd0obaFqhxzGNHbPGV+Gfh/RGJHYPUjW9a29ElDRJgcw
         asXdI9K095TnqEQ2RwSbKxgnmCd5dFA6tQzHW0Np7s3jSH4e0WKaWPtR3uFhlIBP3BB6
         ZbOi5sxoBybqE1B0W1hkomAOOG2OTvZhrFOmM4FjeabvdAKr1ek8kS4niiBMuQNaBUyR
         vF4A==
X-Forwarded-Encrypted: i=1; AJvYcCXQxvShKDts4yFV/0FZq8KfTQhIPQ0O63PGSF1X2Q8/CrjKzH2IrwYir2mORyg4qkeVvsK8Ovr2bOjg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XfIOgs0NAvhEeG+VvHoItFcfXzUAneJM+bmNVOGyAJat0ypg
	alJGbJ3PIn9SEVP2HN2KD0lJSUakL3sE0koI9G06PZo/UPuNHjvM++SrzrF38Is=
X-Google-Smtp-Source: AGHT+IFdUZSjkUbpmwREg45uzgHne+Gkj526u++YBcKniEz4ijMYyFG+sSVSPyJ6DJno6yiyLbeAAg==
X-Received: by 2002:a05:622a:34a:b0:461:e77:d6be with SMTP id d75a77b69052e-4613bff1f08mr234444901cf.20.1730301908427;
        Wed, 30 Oct 2024 08:25:08 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46132297c39sm55537921cf.50.2024.10.30.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 08:25:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 11:25:13 -0400
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
Message-ID: <ZyJP2c-wHADaE8ox@PC2K9PVX.TheFacebook.com>
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

This will work, if start | end is < 256MB, the ACPI table is invalid by
definition since either the block itself is <256MB or the size is 0 (which
is nonsense).  So yeah i can simplify here. 

Ack. will push v5 once i get KLP to clear another warning.
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

