Return-Path: <linux-acpi+bounces-1245-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB327E15D9
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 19:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 931D9B20CAF
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 18:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0945517983
	for <lists+linux-acpi@lfdr.de>; Sun,  5 Nov 2023 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IqXVHE7t"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAB4168A4
	for <linux-acpi@vger.kernel.org>; Sun,  5 Nov 2023 17:55:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838EDEE
	for <linux-acpi@vger.kernel.org>; Sun,  5 Nov 2023 09:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699206939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fd/39Q+ldoVf5VWKnHQ/ghXrqcDy2syROa9KrYZuz/I=;
	b=IqXVHE7tfpxVOeimPXn4vyvH7OY2t3kQqxvtrcPGQru73zPBo30S+fpExZk81iANyfk6tv
	boEQWrMeaDpMj0U1KyE0BeObcS+QyzrEbIfSfyZeZh4N1wpGH4GP+kg0Dqdu8fPz5NfynA
	LRW05RH0mhNQrWV3FT5v268dz1WrbPI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-Ny784rxTP_W_qcNH4JwAKg-1; Sun, 05 Nov 2023 12:55:37 -0500
X-MC-Unique: Ny784rxTP_W_qcNH4JwAKg-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6bcefd3b248so3750938b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 05 Nov 2023 09:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699206936; x=1699811736;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fd/39Q+ldoVf5VWKnHQ/ghXrqcDy2syROa9KrYZuz/I=;
        b=cEs+Rc9e3Xu5DYWopOmu1Vf+t47+7tv9l5qXYcSUYV8RXjDrsxJf96qZK+nPhVKOyh
         /NZnRQ+4K/x3nY/dQ4nZmWHUYCHZlTNjZAdPMmuUauGSzIQFOx5rwj718GjQ67jLEo7z
         Ij66L4mNmxnE2n+p16Opp9keMefvexeZkgJf6BB7GX1Y/KdV9PD21U3QxTP6d7yldb8w
         JqKt1MkBIc/r5T8NtjRKWEbU7WLjcCo4RSyHLvYq/1Iel38QLu7op8sfVGwdpMze9k5n
         Y6bF1+v0b7/yhIdNVvaBSt0QtKMAI4yIFWy8SysvIxWRFBJHHLFFDaHpS7nCUPvegnAI
         erSQ==
X-Gm-Message-State: AOJu0YwE1jb3bPFaXz4O+SQqc/MnBv1y1z2WVbdAzO29oULEIlpvZCiF
	T644uomG+Zn3RF66f/9BvoqChs5NBuvoWItuU3163LA0fSYB+gLxW8K0OD6KRABt4UHwjDNNR49
	YEnJ3v/qCjPcZUGlGhOpCYQ==
X-Received: by 2002:a05:6a00:14d6:b0:6be:4e6e:2a85 with SMTP id w22-20020a056a0014d600b006be4e6e2a85mr36240604pfu.30.1699206936711;
        Sun, 05 Nov 2023 09:55:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFk2pBjd4CJ2rMONJoZ1WOco/rxQ9zWrHoyH1EeQbHLv9sJvLzIuEzeP3ARVcsr8N00dE/hMg==
X-Received: by 2002:a05:6a00:14d6:b0:6be:4e6e:2a85 with SMTP id w22-20020a056a0014d600b006be4e6e2a85mr36240554pfu.30.1699206936324;
        Sun, 05 Nov 2023 09:55:36 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id ff7-20020a056a002f4700b0068620bee456sm4312142pfb.209.2023.11.05.09.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 09:55:35 -0800 (PST)
Date: Sun, 5 Nov 2023 10:55:34 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linuxfoundation.org, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev, 
	Lu Baolu <baolu.lu@linux.intel.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dexuan Cui <decui@microsoft.com>, devicetree@vger.kernel.org, 
	David Woodhouse <dwmw2@infradead.org>, Frank Rowand <frowand.list@gmail.com>, 
	Hanjun Guo <guohanjun@huawei.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Joerg Roedel <joro@8bytes.org>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-tegra@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin <marcan@marcan.st>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Robert Moore <robert.moore@intel.com>, 
	Rob Herring <robh+dt@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Krishna Reddy <vdumpa@nvidia.com>, 
	Vineet Gupta <vgupta@kernel.org>, virtualization@lists.linux-foundation.org, 
	Wei Liu <wei.liu@kernel.org>, Will Deacon <will@kernel.org>, 
	Zhenhua Huang <quic_zhenhuah@quicinc.com>
Subject: Re: [PATCH RFC 04/17] acpi: Do not return struct iommu_ops from
 acpi_iommu_configure_id()
Message-ID: <oe2b62jjtcki7ti4qw6ktzvat7eszrpm7vphgsdvfp5uwdoj3r@wc62cpauchw6>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <4-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <xvgdxrlcpvafst6qypgwehtleaihsedgoiat6akv6au2j4xrjw@rk4dl4xbnq6o>
 <20231105132409.GA258408@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231105132409.GA258408@nvidia.com>

On Sun, Nov 05, 2023 at 09:24:09AM -0400, Jason Gunthorpe wrote:
> On Fri, Nov 03, 2023 at 05:48:01PM -0700, Jerry Snitselaar wrote:
> > > @@ -1632,10 +1633,15 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
> > >  
> > >  	acpi_arch_dma_setup(dev);
> > >  
> > > -	iommu = acpi_iommu_configure_id(dev, input_id);
> > > -	if (PTR_ERR(iommu) == -EPROBE_DEFER)
> > > +	ret = acpi_iommu_configure_id(dev, input_id);
> > > +	if (ret == -EPROBE_DEFER)
> > >  		return -EPROBE_DEFER;
> > >  
> >                 return ret; ?
> 
> Maybe? Like this seemed to be a pattern in this code so I left it

Yeah, it is fine. I think it just caught my eye, because of this earlier
bit in the patch:

        if (err == -EPROBE_DEFER) {
-               return ERR_PTR(err);
+               return err;

which needed to get rid of the ERR_PTR.

Regards,
Jerry

> 
> > > +	/*
> > > +	 * Historically this routine doesn't fail driver probing due to errors
> > > +	 * in acpi_iommu_configure()
> > 
> >               acpi_iommu_configure_id()
> 
> Thanks
> 
> Jason


