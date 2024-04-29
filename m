Return-Path: <linux-acpi+bounces-5465-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFCC8B5F07
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 18:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA2283B21
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483E84D15;
	Mon, 29 Apr 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ga7I3Ezj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD823201
	for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408285; cv=none; b=NiR2pyzfzQFcU1+nsaxwyhaznrKMapWY9ZFYy543P48Dy0Q2be96Mm+e8ZZdq1wchxQRhgsNGUd388rFn/16cWDS+DsqSWJb5KLamNiq5hK2XwOlWbHjBuevxC5vN0kEIsgjA5OF5+R3fXP3hiTwZel94fE5Vhe1LJl/0g93y38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408285; c=relaxed/simple;
	bh=eDE2L21JKW8N96Vi3ng/YDqFma0PceL01iOHHG7iHr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeXkpvmMXPtPGBuv560dEdcElQSNBuRUw+FfYykqHSPSKYw3I6ONGC2bEL0X7nwEgzv3I13HtWXDkl9uiU7/Ir5JrxdnM5+xM8o8xrqZO3NqucNd6AxJdOmBPLSWg/XoulG04mOQDb5d93y1nHJpfZ2Njgwc2AlJA2cPs36sLRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ga7I3Ezj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2def3637f88so45924731fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 09:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714408282; x=1715013082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AzGLiR69PoJGRhtxNKXAUaM6fxmHvGr503ePlBzc+m0=;
        b=ga7I3Ezj6Bh9Y7IKjN4AkwZeUr/08cTH2ZrlL8igbsZyoeRV6Cx1FHeqLili6rrQ1w
         EXSRdd75oqS1r+KzTKHmUV1eYFMH/BTiMaATHHnBNgUzyOeObIjmdvjzOV7ZKWuiDJW9
         yRLlbAgn4V/1ATL3KPTmb7tqaZUzf/yTm5io6J2MJRHzeGgreX1g9L9tDVQmtE/gfI/H
         /W09EflLcX0l+p0VmN0nVsW9fExaxu+dFFJLciZhs3kk26boNs4asiGBIYYQ3wauXOV0
         35t4NHWVbdf1bSPu0nxlxlyhWhvSH60BEGGkD3f9GiXwTtScUf8qkcgXXUHDwP85fSqU
         p4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408282; x=1715013082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AzGLiR69PoJGRhtxNKXAUaM6fxmHvGr503ePlBzc+m0=;
        b=Dd1MmW3i4n4eFqwBV26Mcs/rL406KYivVE166r0TqiL6Z6d8g7PV1vmdU7IL9Mo/Sy
         fQrpAdJFF6lfG2FqvxuhoBKHvAGy2rAWYx8UKU/CrQh/8Y1m/aRj4UywqCyktb1V+hwZ
         1zLp/mYJ/jE+PUts7P+2xDC7BgvTr5C8zNCYq/USYfyl74uNM9N65+DH9RvxKeG95ARi
         4tx4sK8qpRmjQdGP/8RKB4UO4qCxqpw/y31GtzT5F1oKm+GeAMKL/n9VO+beoc+ccC5C
         /mz4xQediVHd1dYj/xoApc2GulZ+PjRkadcXM89Y/ndDvmaoJ/Z7B65z7lY2aFpIGsde
         EfuA==
X-Forwarded-Encrypted: i=1; AJvYcCWTXT1y45jMn1ANdKo6AInfustC24rMUeqSvBKb9MO7ytTlRUbEoBmX6eu/yPzWOFdwKBdsNbEnVK2vZGDxBtIKelK4rsgqNOjKhg==
X-Gm-Message-State: AOJu0YynqJ3Emnumg8zhKX5g8fKO4CyxGrXrj8nMdRZ/aOhFGSH6uN07
	DWHn1pYchyfE/2haJLW9oh/baBKuAdSF3zV1ArQYX3APu47QJIKZpHSMxeHiieA=
X-Google-Smtp-Source: AGHT+IHk3Z5XGDbb0v+Fmz92VybJVjDFdKDawu/AbXxfV/kYiZFIeb4QW5ZOrzeqL0UzpA0hXaFkSQ==
X-Received: by 2002:a05:651c:1992:b0:2de:6f52:5c8d with SMTP id bx18-20020a05651c199200b002de6f525c8dmr53916ljb.21.1714408281677;
        Mon, 29 Apr 2024 09:31:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id h22-20020a2eb0f6000000b002dfa8b1a07asm961511ljl.111.2024.04.29.09.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 09:31:21 -0700 (PDT)
Date: Mon, 29 Apr 2024 19:31:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <Zi_LV28TR-P-PzXi@eriador.lumag.spb.ru>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bebea331c1d688b34d9862eefd5ede47503961b8.1713523152.git.robin.murphy@arm.com>

On Fri, Apr 19, 2024 at 05:54:45PM +0100, Robin Murphy wrote:
> It's somewhat hard to see, but arm64's arch_setup_dma_ops() should only
> ever call iommu_setup_dma_ops() after a successful iommu_probe_device(),
> which means there should be no harm in achieving the same order of
> operations by running it off the back of iommu_probe_device() itself.
> This then puts it in line with the x86 and s390 .probe_finalize bodges,
> letting us pull it all into the main flow properly. As a bonus this lets
> us fold in and de-scope the PCI workaround setup as well.
> 
> At this point we can also then pull the call up inside the group mutex,
> and avoid having to think about whether iommu_group_store_type() could
> theoretically race and free the domain if iommu_setup_dma_ops() ran just
> *before* iommu_device_use_default_domain() claims it... Furthermore we
> replace one .probe_finalize call completely, since the only remaining
> implementations are now one which only needs to run once for the initial
> boot-time probe, and two which themselves render that path unreachable.
> 
> This leaves us a big step closer to realistically being able to unpick
> the variety of different things that iommu_setup_dma_ops() has been
> muddling together, and further streamline iommu-dma into core API flows
> in future.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com> # For Intel IOMMU
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2: Shuffle around to make sure the iommu_group_do_probe_finalize() case
>     is covered as well, with bonus side-effects as above.
> v3: *Really* do that, remembering the other two probe_finalize sites too.
> ---
>  arch/arm64/mm/dma-mapping.c  |  2 --
>  drivers/iommu/amd/iommu.c    |  8 --------
>  drivers/iommu/dma-iommu.c    | 18 ++++++------------
>  drivers/iommu/dma-iommu.h    | 14 ++++++--------
>  drivers/iommu/intel/iommu.c  |  7 -------
>  drivers/iommu/iommu.c        | 20 +++++++-------------
>  drivers/iommu/s390-iommu.c   |  6 ------
>  drivers/iommu/virtio-iommu.c | 10 ----------
>  include/linux/iommu.h        |  7 -------
>  9 files changed, 19 insertions(+), 73 deletions(-)

This patch breaks UFS on Qualcomm SC8180X Primus platform:


[    3.846856] arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402, iova=0x1032db3e0, fsynr=0x130000, cbfrsynra=0x300, cb=4
[    3.846880] ufshcd-qcom 1d84000.ufshc: ufshcd_check_errors: saved_err 0x20000 saved_uic_err 0x0
[    3.846929] host_regs: 00000000: 1587031f 00000000 00000300 00000000
[    3.846935] host_regs: 00000010: 01000000 00010217 00000000 00000000
[    3.846941] host_regs: 00000020: 00000000 00070ef5 00000000 00000000
[    3.846946] host_regs: 00000030: 0000000f 00000001 00000000 00000000
[    3.846951] host_regs: 00000040: 00000000 00000000 00000000 00000000
[    3.846956] host_regs: 00000050: 032db000 00000001 00000000 00000000
[    3.846962] host_regs: 00000060: 00000000 80000000 00000000 00000000
[    3.846967] host_regs: 00000070: 032dd000 00000001 00000000 00000000
[    3.846972] host_regs: 00000080: 00000000 00000000 00000000 00000000
[    3.846977] host_regs: 00000090: 00000016 00000000 00000000 0000000c
[    3.847074] ufshcd-qcom 1d84000.ufshc: ufshcd_err_handler started; HBA state eh_fatal; powered 1; shutting down 0; saved_err = 131072; saved_uic_err = 0; force_reset = 0
[    4.406550] ufshcd-qcom 1d84000.ufshc: ufshcd_verify_dev_init: NOP OUT failed -11
[    4.417953] ufshcd-qcom 1d84000.ufshc: ufshcd_async_scan failed: -11

-- 
With best wishes
Dmitry

