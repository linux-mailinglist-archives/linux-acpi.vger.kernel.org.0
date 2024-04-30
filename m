Return-Path: <linux-acpi+bounces-5495-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A178B716B
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 12:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0472F1C22280
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Apr 2024 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2C812C476;
	Tue, 30 Apr 2024 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jPhX06kA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4C12C534
	for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 10:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714474582; cv=none; b=EE7wYRlNy5M49UxG3/ncjoPddZugFDof/yXBprFtcY5JyZl23dkEWsHE6q/cLaAbd3G/tVXgp71GImPed/HTLOVdLwn5rWpSGwRIueHbtntt+xv7mzMcCnMATxDtCnhCxCPRZe6HMjeHXekf8ukEenJ+nttbyFgslOOJ9ghxwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714474582; c=relaxed/simple;
	bh=Z7yL0U/gcDov5K0l+LMi9J5dcrJohhCp1XV2fyheWlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HuFPIORsNZfBYqyc+RI+/SS3Z9+fTim85+fUOipMGW7zFY+271FxJ5SCigGY8KyEawLLhxsJZ3WfrXQOqOu94N8tK9RGdVvjnAE0ecleNkJAnvspKJob2gyQOoq1Bs18QztrQRC3m+KoLdM272y/kAB6Fr7zgPqWddHTNKrMa1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jPhX06kA; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-61af74a010aso54277787b3.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Apr 2024 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714474579; x=1715079379; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j3ANzOovClROUBS3Nn4nb+rVzx+/CIWtYXFgMiBCBSI=;
        b=jPhX06kARaHPP83POVRTG9tzx8oCzL0KabBEkcfE2yAD0fx0XRmByCRBALxyybNwXn
         2lcdeZqvmp4uALORJiCL5F/8Jli3BQql1TPq6+jgtRgjfJDEKNvUuVxzLskQrfzoSle7
         P62908K5PW4AiRaLOvSUUkXbP+6a0cdpNLgOkeTmXiJ1hvJRBBh0f1/nn5zHGlrW8MUq
         AUP3H4OJW7Caj1oveeo6ViSHXxwh7R8lXx8DCbJiIiLK31vj+kZfXKfqpuuQEij2sL33
         B5I6qWr33xFAk0Xw/LjVjdfB0UWzl9cJ/eJCCFxqlBcR2+fm/P0ogeeNDLsU1w0u3xTG
         AhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714474579; x=1715079379;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3ANzOovClROUBS3Nn4nb+rVzx+/CIWtYXFgMiBCBSI=;
        b=nzF4iAJRLMDcFRQ0M37OjZvOG0d490TcOPBuXJONjnFhKt5ruE/vy5d6jLm6iSAUz6
         4LbJ3tCYhSBcQs7MEQi9I1iOINcdo5liM9QtSQnvxPBgz4FFQ3oeVOX3/Urum/ryOPfc
         kd8hdj8hCE6t3Dn3hpQGdMUZq6iKzQTV8QGR6pXLXucAhABRFM0yYnLGY2cTnsathVCp
         AUige4SYqTCP/jOwR75yKVZRu0606EGitXPAs/LDYSGyakwUnN3l1zu16r9vu8TS3cEz
         EI9xuoeM+o5VDTLiECrd7V9niJKKZ+kxrmHM0LeY7d5iBnDtoX0YBVbG5sCQ85MKSgm0
         j9JA==
X-Forwarded-Encrypted: i=1; AJvYcCWpe1Yn4UiJB4DsGNOFSR8f5lnwvY0BHtP/eUY6QddT1kPovQinmRO/netrpHcftioEh8tep3snLfqf1/R6q2tA1MHIpxBVau8d2w==
X-Gm-Message-State: AOJu0YykRvFj05JfFp+TiJJnnqigCjgmdq0SlpOm3pvtSb4s3JDCGx6L
	JYFHgIulVQnXR1GI5yuFXgkxUszcNqSADXicQ47k+QcLU4zLca2n9+wRxKYkiFmMbTo+bsD6gDn
	tMOXjcUuZHGmz5nrDygOfDcTWbAcwwcRnyTbLWw==
X-Google-Smtp-Source: AGHT+IGpcUPe4PzDbKJZuWjVEt2j2YgVnBnHAeHmwYGgyhtthmZCRgI611EqUANkd2RSTrLN4sfimNVOJdo7rmRvZvI=
X-Received: by 2002:a05:690c:14:b0:61a:fc3b:fdd3 with SMTP id
 bc20-20020a05690c001400b0061afc3bfdd3mr14804250ywb.43.1714474578907; Tue, 30
 Apr 2024 03:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713523152.git.robin.murphy@arm.com> <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
 <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru> <2662a5ba-3115-4fe5-9cec-bff71f703a82@arm.com>
 <CAA8EJprxLvYEP8+ggk8fw--kHaK+_QoYan4st2wWpPicHa6_+w@mail.gmail.com> <20d44077-d0a8-470a-bf6f-82683db894cf@arm.com>
In-Reply-To: <20d44077-d0a8-470a-bf6f-82683db894cf@arm.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 13:56:07 +0300
Message-ID: <CAA8EJpqu4d6G3wci7gKGhz0qBVwQ-DEJW3soG2QCyNPCg6Gq8g@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>, Vineet Gupta <vgupta@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Niklas Schnelle <schnelle@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Apr 2024 at 13:20, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2024-04-30 1:41 am, Dmitry Baryshkov wrote:
> > On Tue, 30 Apr 2024 at 01:26, Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> On 2024-04-29 5:31 pm, Dmitry Baryshkov wrote:
> >>> On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
> >>>> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> >>>> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> >>>> which means there should be no harm in achieving the same order of
> >>>> operations by running it off the back of iommu_probe_device() itself.
> >>>> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> >>>> letting us pull it all into the main flow properly. As a bonus this lets
> >>>> us fold in and de-scope the PCI workaround setup as well.
> >>>>
> >>>> At this point we can also then pull the call up inside the group mutex,
> >>>> and avoid having to think about whether iommu_group_store_type() could
> >>>> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> >>>> *before* iommu_device_use_default_domain() claims it... Furthermore we
> >>>> replace one .probe_finalize call completely, since the only remaining
> >>>> implementations are now one which only needs to run once for the initial
> >>>> boot-time probe, and two which themselves render that path unreachable.
> >>>>
> >>>> This leaves us a big step closer to realistically being able to unpick
> >>>> the variety of different things that iommu_setup_dma_ops() has been
> >>>> muddling together, and further streamline iommu-dma into core API flows
> >>>> in future.
> >>>>
> >>>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
> >>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >>>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> >>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> >>>> ---
> >>>> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
> >>>>       is covered as well, with bonus side-effects as above.
> >>>> v3: *Really* do that, remembering the other two probe_finalize sites too.
> >>>> ---
> >>>>    arch/arm64/mm/dma-mapping.c  |  2 --
> >>>>    drivers/iommu/amd/iommu.c    |  8 --------
> >>>>    drivers/iommu/dma-iommu.c    | 18 ++++++------------
> >>>>    drivers/iommu/dma-iommu.h    | 14 ++++++--------
> >>>>    drivers/iommu/intel/iommu.c  |  7 -------
> >>>>    drivers/iommu/iommu.c        | 20 +++++++-------------
> >>>>    drivers/iommu/s390-iommu.c   |  6 ------
> >>>>    drivers/iommu/virtio-iommu.c | 10 ----------
> >>>>    include/linux/iommu.h        |  7 -------
> >>>>    9 files changed, 19 insertions(+), 73 deletions(-)
> >>>
> >>> This patch breaks UFS on Qualcomm SC8180X Primus platform:
> >>>
> >>>
> >>> [    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
> >>
> >> Hmm, a context fault implies that the device did get attached to a DMA
> >> domain, thus has successfully been through __iommu_probe_device(), yet
> >> somehow still didn't get the right DMA ops (since that "IOVA" looks more
> >> like a PA to me). Do you see the "Adding to IOMMU group..." message for
> >> this device, and/or any other relevant messages or errors before this
> >> point?
> >
> > No, nothing relevant.
> >
> > [    8.372395] ufshcd-qcom 1d84000.ufshc: Adding to iommu group 6
> >
> > (please ignore the timestamp, it comes before ufshc being probed).
> >
> >> I'm guessing there's a fair chance probe deferral might be
> >> involved as well. I'd like to understand what path(s) this ends up
> >> taking through __iommu_probe_device() and of_dma_configure(), or at
> >> least the number and order of probe attempts between the UFS and SMMU
> >> drivers.
> >
> > __iommu_probe_device() gets called twice and returns early because ops is NULL.
> >
> > Then finally of_dma_configure_id() is called. The following branches are taken:
> >
> > np == dev->of_node
> > of_dma_get_range() returned 0
> > bus_dma_limit and dma_range_map are set
> > __iommu_probe_device() is called, using the `!group->default_domain &&
> > !group_lis` case, then group->default_domain() is not NULL,
> > In the end, iommu_setup_dma_ops() is called.
> >
> > Then the ufshc probe defers (most likely the PHY is not present or
> > some other device is not there yet).
>
> Ah good, probe deferral. And indeed the half-formed hunch from last
> night grew into a pretty definite idea by this morning... patch incoming.

Thanks a lot for the quick fix!


-- 
With best wishes
Dmitry

