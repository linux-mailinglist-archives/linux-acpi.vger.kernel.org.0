Return-Path: <linux-acpi+bounces-5884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F358C89A3
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF7B286D22
	for <lists+linux-acpi@lfdr.de>; Fri, 17 May 2024 15:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D54E12F5AF;
	Fri, 17 May 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aoDpudXu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67C12F590
	for <linux-acpi@vger.kernel.org>; Fri, 17 May 2024 15:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715961248; cv=none; b=P3oz3e8iOsTn2hBwIjL4P1zzw9cWNtDjFdhOy+Gl9C8HlfJr5a1GmD6d6racIOH1C0nCAWVqeBuwCoVh+Ypa8Wq1P42P7C7pQ0ff8WmyC9b76afFDnYTZRo2JdBAk3OXybBAXjjU4FtyZe05AS/Xdr2GDyhEh+tywoHsmSv7tPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715961248; c=relaxed/simple;
	bh=GtR205AL/6z6bhbjj9jZVXspU9EbN88dltK9qhVAKwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1F8ReCQ8W3crQ9MCL4A6iONolD6OkXJ/kkGhkt269zGGoqecT0JUGguKICQ0p5rlF2mLz1/0Azx/gAllwI8FFXXqKz3Zg53+gkf2PoxVtTGKjnxAzMgdrLZ7hjNsy0cUX9VeV2EMlJO5ZSAXy/SPv6nhJQHFatX8ug+K8Hx/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aoDpudXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715961245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DG0jKqywJmYPZtEkQ4yb1Wz+sniBONy5u9KhxoyaZJ4=;
	b=aoDpudXumIJAZqvx66BUZvI9eb7W8pCSvRFgsA1MjcWxzR9lajYtXtVcJ3JZ8xUgEaISzs
	wFjHd2YfDjnLpSPrliHvNTn98SLXr3XHLD4IW+N2a6O1avStrqtjYsP83WGNVQXm7n7UMu
	3ynOdnEbi/B86VFbtXfAXjhN5SjJOsE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-npp5uKhNP9mzcmA0hapVdg-1; Fri, 17 May 2024 11:54:03 -0400
X-MC-Unique: npp5uKhNP9mzcmA0hapVdg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-792c26500adso1238508985a.0
        for <linux-acpi@vger.kernel.org>; Fri, 17 May 2024 08:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715961243; x=1716566043;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG0jKqywJmYPZtEkQ4yb1Wz+sniBONy5u9KhxoyaZJ4=;
        b=N/ACCFPdYU38J/90xNcUvAM1qeFG465V8LWZTjrJ9qYgfYSfZFgWzhFbton+yDV5p1
         LBAP3pmW+APnyFPnSI7X1u98GhAlyqZT6JOsflIpbOl7ovs0Vqqg2J7HfUlDmANCEmQ0
         GXyk8/jeVj57MqP5zCSunbz3DIy6u2wm00YjdeLhrx8ar/1xv5AvBN9yDkgoWm286yoy
         PZ3pyL7ngmO0ZDuVilbYt2ttA11U3P6pIBcFcypgdqzCHYNguDrIwr/67K9mWEiK90O4
         q/6uSpYoZ8ABuHVv5U7h/8D4E7WXi+2sqI2qCX0aYRZoGnZmZ1ZnlDup0OyWZno+zHxf
         Brrw==
X-Forwarded-Encrypted: i=1; AJvYcCW5CGVOVM9lLRJzr2WDh89C4Y+tWsCr4u3P7YgnPFEY79zpJSCfQInypiOd57+m7WyzFfDAdJSnVQAM7a2bIqLQDAz3m7n+0LP3cg==
X-Gm-Message-State: AOJu0YzWcoQvGRoT+/wnt6lFKO+Gp2e6rSjLAYJVyr2f+xgpMukE1kHx
	WaJEuhJEEBJhVxcsUBgyshbjYrwF9F9XufbDufcLUVDg2t86UNUcgZBupJkEuJJGDlYWG/dZihA
	fuOGdA5yZYQVi9f4w3n5St35soXvRJMyQRmaHJPNilvoMXlNO+PACywYha90=
X-Received: by 2002:a05:620a:3711:b0:792:a479:a149 with SMTP id af79cd13be357-792c75efae3mr2858671685a.55.1715961242769;
        Fri, 17 May 2024 08:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ8cT74yc8MeEU6UnvYabk6/lhty/Rg5OQz0t3lcsp+LinIwPDdtF6YTvshxklm1hQT7os6Q==
X-Received: by 2002:a05:620a:3711:b0:792:a479:a149 with SMTP id af79cd13be357-792c75efae3mr2858665285a.55.1715961242014;
        Fri, 17 May 2024 08:54:02 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf2fc57asm913121485a.81.2024.05.17.08.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 08:54:01 -0700 (PDT)
Date: Fri, 17 May 2024 08:54:00 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>, 
	Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
Message-ID: <njy2zop3cufg4vzrkftyn57sgr2shlvkze77jordhohyqeshvs@pazp6hkuk4r2>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
 <243d441d-dda8-442a-a495-83bf9725a14c@nvidia.com>
 <48c39306-c226-4e7f-a013-d679ca80157e@arm.com>
 <46fc1b7f-7d10-4233-b089-aa173ad3bbeb@nvidia.com>
 <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <981c85f3-6d43-4c2b-a440-88bf81a18e55@arm.com>

On Fri, May 17, 2024 at 04:03:57PM GMT, Robin Murphy wrote:
> On 17/05/2024 3:21 pm, Jon Hunter wrote:
> > 
> > On 15/05/2024 15:59, Robin Murphy wrote:
> > > Hi Jon,
> > > 
> > > On 2024-05-14 2:27 pm, Jon Hunter wrote:
> > > > Hi Robin,
> > > > 
> > > > On 19/04/2024 17:54, Robin Murphy wrote:
> > > > > It's now easy to retrieve the device's DMA limits if we want to check
> > > > > them against the domain aperture, so do that ourselves instead of
> > > > > relying on them being passed through the callchain.
> > > > > 
> > > > > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > > > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > > > ---
> > > > >   drivers/iommu/dma-iommu.c | 21 +++++++++------------
> > > > >   1 file changed, 9 insertions(+), 12 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > > index a3039005b696..f542eabaefa4 100644
> > > > > --- a/drivers/iommu/dma-iommu.c
> > > > > +++ b/drivers/iommu/dma-iommu.c
> > > > > @@ -660,19 +660,16 @@ static void
> > > > > iommu_dma_init_options(struct iommu_dma_options *options,
> > > > >   /**
> > > > >    * iommu_dma_init_domain - Initialise a DMA mapping domain
> > > > >    * @domain: IOMMU domain previously prepared by
> > > > > iommu_get_dma_cookie()
> > > > > - * @base: IOVA at which the mappable address space starts
> > > > > - * @limit: Last address of the IOVA space
> > > > >    * @dev: Device the domain is being initialised for
> > > > >    *
> > > > > - * @base and @limit + 1 should be exact multiples of IOMMU
> > > > > page granularity to
> > > > > - * avoid rounding surprises. If necessary, we reserve the
> > > > > page at address 0
> > > > > + * If the geometry and dma_range_map include address 0, we
> > > > > reserve that page
> > > > >    * to ensure it is an invalid IOVA. It is safe to
> > > > > reinitialise a domain, but
> > > > >    * any change which could make prior IOVAs invalid will fail.
> > > > >    */
> > > > > -static int iommu_dma_init_domain(struct iommu_domain
> > > > > *domain, dma_addr_t base,
> > > > > -                 dma_addr_t limit, struct device *dev)
> > > > > +static int iommu_dma_init_domain(struct iommu_domain
> > > > > *domain, struct device *dev)
> > > > >   {
> > > > >       struct iommu_dma_cookie *cookie = domain->iova_cookie;
> > > > > +    const struct bus_dma_region *map = dev->dma_range_map;
> > > > >       unsigned long order, base_pfn;
> > > > >       struct iova_domain *iovad;
> > > > >       int ret;
> > > > > @@ -684,18 +681,18 @@ static int
> > > > > iommu_dma_init_domain(struct iommu_domain *domain,
> > > > > dma_addr_t base,
> > > > >       /* Use the smallest supported page size for IOVA granularity */
> > > > >       order = __ffs(domain->pgsize_bitmap);
> > > > > -    base_pfn = max_t(unsigned long, 1, base >> order);
> > > > > +    base_pfn = 1;
> > > > >       /* Check the domain allows at least some access to the
> > > > > device... */
> > > > > -    if (domain->geometry.force_aperture) {
> > > > > +    if (map) {
> > > > > +        dma_addr_t base = dma_range_map_min(map);
> > > > >           if (base > domain->geometry.aperture_end ||
> > > > > -            limit < domain->geometry.aperture_start) {
> > > > > +            dma_range_map_max(map) <
> > > > > domain->geometry.aperture_start) {
> > > > >               pr_warn("specified DMA range outside IOMMU
> > > > > capability\n");
> > > > >               return -EFAULT;
> > > > >           }
> > > > >           /* ...then finally give it a kicking to make sure it fits */
> > > > > -        base_pfn = max_t(unsigned long, base_pfn,
> > > > > -                domain->geometry.aperture_start >> order);
> > > > > +        base_pfn = max(base,
> > > > > domain->geometry.aperture_start) >> order;
> > > > >       }
> > > > >       /* start_pfn is always nonzero for an
> > > > > already-initialised domain */
> > > > > @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device
> > > > > *dev, u64 dma_base, u64 dma_limit)
> > > > >        * underlying IOMMU driver needs to support via the
> > > > > dma-iommu layer.
> > > > >        */
> > > > >       if (iommu_is_dma_domain(domain)) {
> > > > > -        if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> > > > > +        if (iommu_dma_init_domain(domain, dev))
> > > > >               goto out_err;
> > > > >           dev->dma_ops = &iommu_dma_ops;
> > > > >       }
> > > > 
> > > > 
> > > > I have noticed some random test failures on Tegra186 and
> > > > Tegra194 and bisect is pointing to this commit. Reverting this
> > > > along with the various dependencies does fix the problem. On
> > > > Tegra186 CPU hotplug is failing and on Tegra194 suspend is
> > > > failing. Unfortunately, on neither platform do I see any
> > > > particular crash but the boards hang somewhere.
> > > 
> > > That is... thoroughly bemusing :/ Not only is there supposed to be
> > > no real functional change here - we should merely be recalculating
> > > the same information from dev->dma_range_map that the callers were
> > > already doing to generate the base/limit arguments - but the act of
> > > initially setting up a default domain for a device behind an IOMMU
> > > should have no connection whatsoever to suspend and especially not
> > > to CPU hotplug.
> > 
> > 
> > Yes it does look odd, but this is what bisect reported ...
> > 
> > git bisect start
> > # good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> > git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> > # bad: [6ba6c795dc73c22ce2c86006f17c4aa802db2a60] Add linux-next
> > specific files for 20240513
> > git bisect bad 6ba6c795dc73c22ce2c86006f17c4aa802db2a60
> > # good: [29e7f949865a023a21ecdfbd82d68ac697569f34] Merge branch 'main'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
> > git bisect good 29e7f949865a023a21ecdfbd82d68ac697569f34
> > # skip: [150e6cc14e51f2a07034106a4529cdaafd812c46] Merge branch 'next'
> > of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> > git bisect skip 150e6cc14e51f2a07034106a4529cdaafd812c46
> > # good: [f5d75327d30af49acf2e4b55f35ce2e6c45d1287] drm/amd/display: Fix
> > invalid Copyright notice
> > git bisect good f5d75327d30af49acf2e4b55f35ce2e6c45d1287
> > # skip: [f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8] Merge branch
> > 'for-next' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git
> > git bisect skip f1ec9a9ffc526df7c9523006c2abbb8ea554cdd8
> > # bad: [f091e93306e0429ebb7589b9874590b6a9705e64] dma-mapping: Simplify
> > arch_setup_dma_ops()
> > git bisect bad f091e93306e0429ebb7589b9874590b6a9705e64
> > # good: [91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b] ACPI/IORT: Handle
> > memory address size limits as limits
> > git bisect good 91cfd679f9e8b9a7bf2f26adf66eff99dbe2026b
> > # bad: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e] iommu/dma: Make limit
> > checks self-contained
> > git bisect bad ad4750b07d3462ce29a0c9b1e88b2a1f9795290e
> > # good: [fece6530bf4b59b01a476a12851e07751e73d69f] dma-mapping: Add
> > helpers for dma_range_map bounds
> > git bisect good fece6530bf4b59b01a476a12851e07751e73d69f
> > # first bad commit: [ad4750b07d3462ce29a0c9b1e88b2a1f9795290e]
> > iommu/dma: Make limit checks self-contained
> > 
> > There is a couple skips in there and so I will try this again.
> > 
> > > > If you have any ideas on things we can try let me know.
> > > 
> > > Since the symptom seems inexplicable, I'd throw the usual memory
> > > debugging stuff like KASAN at it first. I'd also try
> > > "no_console_suspend" to check whether any late output is being
> > > missed in the suspend case (and if it's already broken, then any
> > > additional issues that may be caused by the console itself hopefully
> > > shouldn't matter).
> > > 
> > > For more base-covering, do you have the "arm64: Properly clean up
> > > iommu-dma remnants" fix in there already as well? That bug has
> > > bisected to patch #6 each time though, so I do still suspect that
> > > what you're seeing is likely something else. It does seem
> > > potentially significant that those Tegra platforms are making fairly
> > > wide use of dma-ranges, but there's no clear idea forming out of
> > > that observation just yet...
> > 
> > I was hoping it was the same issue other people had reported,
> > but the fix provided did not help. I have also tried today's
> > -next and I am still seeing the issue.
> > 
> > I should have more time next week to look at this further. Let
> > me confirm which change is causing this and add more debug.
> 
> Thanks. From staring at the code I think I've spotted one subtlety which
> may not be quite as intended - can you see if the diff below helps? It
> occurs to me that suspend and CPU hotplug may not *cause* the symptom,
> but they could certainly stall if one or more relevant CPUs is *already*
> stuck in a loop somewhere...
> 
> Thanks,
> Robin.

I ran into an issue with arm-smmu as well with an nvidia orin system. From what I could
see with the system, which seemed a bit odd to me, was it had a bridge and a wireless
nic in the same iommu group, and had a mapping for the bridge at 0xffff000. It was
failing when it tried to set up pci resources for the wireless nic as it was
trying to map it to 0xffff000 and arm_lpae_map path would reject it since
there already was a mapping there.

I'll try to spend more time with it today if I can grab one of the systems.

> 
> ----->8-----
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 89a53c2f2cf9..85eb1846c637 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -686,6 +686,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
>  	/* Check the domain allows at least some access to the device... */
>  	if (map) {
>  		dma_addr_t base = dma_range_map_min(map);
> +		base = max(base, (dma_addr_t)1 << order);
>  		if (base > domain->geometry.aperture_end ||
>  		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>  			pr_warn("specified DMA range outside IOMMU capability\n");


