Return-Path: <linux-acpi+bounces-2282-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7CE80CFB6
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 16:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301AE1F219C5
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0574BA85;
	Mon, 11 Dec 2023 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Kd6WeysL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2374E8
	for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 07:36:35 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-67a9be1407aso30137886d6.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Dec 2023 07:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702308995; x=1702913795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h1q90IyUaHdLCptoKkTSBnvLA7N8/ZWOhYeli5kaqA4=;
        b=Kd6WeysLupP/7Ajdb+oLoJYeErg+1AyWELbof8xQpToPzW0tzf2R/xKDDmgy1XjGKt
         HCrYIWl8mxLWrPTNhUHjTAftXwheT2qHvkgdG6AX5cNl6IOoaWoNVAAdRn/FhxukcGbF
         Gfr/8uijIjWY68zll/7HfwzVvSlGRiIg3o+PqNvZyrLDgPMXyA2t9nmIasp6PFZARViZ
         Ae8OLgjHR4pdnT0tVANBcdHd52mT3enV5K5YddwlpvuwgAhUC0lSH1/1yhosT5ylkpGk
         QWdfUQRhyaXH0jlq7/h4kFgHsJfp4npTkoWPHF0ESG9MGgQ/Kjhoi+L7hoorSbFDgXV7
         dz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308995; x=1702913795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1q90IyUaHdLCptoKkTSBnvLA7N8/ZWOhYeli5kaqA4=;
        b=Ld4vAW2KjjW3aVHHuw0m5M52bpy1CmjOWpe3UU1Ywuv7berurnHRF+5oNoZrKrsJ9e
         DJeHcurHVHBVjTivtqs6YVDq+RXcoxmjKV4h1ZGMQBb/+DOvdMYDMDudtO8IZ7WNFWFq
         gx0y8BPjzLzeAhVguvg9IJmQ6j0aP48BCd5P39WR21/7DByLF2cbLZpuDkgNPvv6TDZy
         3A8iALjbkylZLZ/FRrp5Jp+Nug6b00Yfg5/JuZ95fYb3VElzlB2SRhTfWCoqHF+EP5SA
         +mQDNlf2HXXi8mOUhL4tIcnMkQytV3VpjQAgD/BXa+KPpR9lWbjyWjsbpeXiSDzTVZn0
         VjpA==
X-Gm-Message-State: AOJu0YyNylp/08ijMEhDW6hDVaitD1WsAehVFEvKuAGslup6II3RBlO0
	B3209fPxyG+xkySO02TZG1zRwQ==
X-Google-Smtp-Source: AGHT+IE8NOv9U3J00bm5dbyWdx4BsSKRZT/5tARJRo3dRn9euR4880YaUsJYjW9+kaMr2xVXZQP3Xw==
X-Received: by 2002:a0c:ee47:0:b0:67a:b99e:4228 with SMTP id m7-20020a0cee47000000b0067ab99e4228mr4459026qvs.52.1702308994824;
        Mon, 11 Dec 2023 07:36:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id g2-20020ad45102000000b0067a1e5ef6b1sm3324868qvp.106.2023.12.11.07.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:36:34 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rCiKf-00Ccc2-Kg;
	Mon, 11 Dec 2023 11:36:33 -0400
Date: Mon, 11 Dec 2023 11:36:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231211153633.GD1489931@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
 <20231211132757.GE25681@willie-the-truck>
 <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
 <20231211153023.GA26048@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211153023.GA26048@willie-the-truck>

On Mon, Dec 11, 2023 at 03:30:24PM +0000, Will Deacon wrote:
> On Mon, Dec 11, 2023 at 03:01:27PM +0000, Robin Murphy wrote:
> > On 2023-12-11 1:27 pm, Will Deacon wrote:
> > > On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> > > > Return the Root Complex/Named Component memory address size limit as an
> > > > inclusive limit value, rather than an exclusive size.  This saves us
> > > > having to special-case 64-bit overflow, and simplifies our caller too.
> > > > 
> > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > ---
> > > >   drivers/acpi/arm64/dma.c  |  9 +++------
> > > >   drivers/acpi/arm64/iort.c | 18 ++++++++----------
> > > >   include/linux/acpi_iort.h |  4 ++--
> > > >   3 files changed, 13 insertions(+), 18 deletions(-)
> > > 
> > > [...]
> > > 
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index 6496ff5a6ba2..eb64d8e17dd1 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> > > >   { return -ENODEV; }
> > > >   #endif
> > > > -static int nc_dma_get_range(struct device *dev, u64 *size)
> > > > +static int nc_dma_get_range(struct device *dev, u64 *limit)
> > > >   {
> > > >   	struct acpi_iort_node *node;
> > > >   	struct acpi_iort_named_component *ncomp;
> > > > @@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
> > > >   		return -EINVAL;
> > > >   	}
> > > > -	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> > > > -			1ULL<<ncomp->memory_address_limit;
> > > > +	*limit = (1ULL << ncomp->memory_address_limit) - 1;
> > > 
> > > The old code handled 'ncomp->memory_address_limit >= 64' -- why is it safe
> > > to drop that? You mention it in the cover letter, so clearly I'm missing
> > > something!
> > 
> > Because an unsigned shift by 64 or more generates 0 (modulo 2^64), thus
> > subtracting 1 results in the correct all-bits-set value for an inclusive
> > 64-bit limit.
> 
> Oh, I'd have thought you'd have gotten one of those "left shift count >=
> width of type" warnings if you did that.

Yes, UBSAN generates warnings for these cases. I'm not sure if it is
actually undefined C behavior or just "suspicious", but such is what
it is..

Jason

