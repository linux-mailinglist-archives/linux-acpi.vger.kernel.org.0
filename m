Return-Path: <linux-acpi+bounces-4203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E80876BEA
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 21:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77F131C215E0
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Mar 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3E75E06D;
	Fri,  8 Mar 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HLshlY0J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFC5E062
	for <linux-acpi@vger.kernel.org>; Fri,  8 Mar 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709930239; cv=none; b=rB1dCDKgUKIi9OkxEMowDOYVZJLlR4i7HE4CH9br5YNfa57ZN7rFZzHNmRx4w/vpIovzb/6BGgXlLVuNwkAxdmfymLeq2rwleXi1CuUzHjViZbtdtGh7zHSuJN26DcmzilEPlsBo5MFOxIEmio72maKhhnCFMJR82VOWZJgHu64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709930239; c=relaxed/simple;
	bh=Bi3P4E1LMVNI9ICHZizJgPWFi1cAG6MJcwmbCUE+tB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN/wjz0x2wGkcFHuiskkrK6rcFxul0cFgO5x0a2ROd0OLraN0tEKQLgCERytDmqUvzXdYXp1+oi65AO+TYoQT3sgLpZ2iUiHH+0BDuCAdVCzTIidsyj3zMIQcoNfgamYGKZ0A144Yw6Q2LKnkU4m7ABkCz9v/fdqhTLk8ZKzEQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HLshlY0J; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a1cba5d46fso426620eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 08 Mar 2024 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709930237; x=1710535037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=HLshlY0JdEldHta3JUKzPHooseYZMDrj2DHryLYDs5peuYjAuXzdIHxf1El6VBnEzY
         ksY0Rv2pL6VWtrierriq21rd9UsObnawXA4p4AIgBlizBDnz9aN1Vh/qFXOdoilqfmdl
         2Msr1y8zrAmn+ef3dwTz7cREbJzefJTqGBtl0lcciyj0SoinX7jsRrdF+1eBzX5YjImP
         lj65zjhX8XvLydEBSxgTC0EZyrS7BlRIo9qZVM1T2PbyOJ3DUyJDTxQMaUlsRBWWeQGO
         R4A1v7dzeGxbht847VPfHRQHWbUApaKkCZJcU9B6aNAtLgR36Z1fZ1yNTw+AOPWOkl7S
         ddug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709930237; x=1710535037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjWpdrEe1CBSB6fUsA969odLMNfAGSgF6jvNlFE06WQ=;
        b=YQMo4UB0vnrzBuoR4bKWdrMzOEXSb15KzJv4zvY0wd2WDO51tWfySXRq70j6QKvZ+J
         6UCdyJXx8Wk8knq1R4F5+jm8bhEAptw3v/hoiaP9ofbywS6ppu7IdCCoyZMaBACQnKKP
         QBcn3MQrXuOkh2o75khq1tzfXz0Y7v1LWo1JxqHQaDHAzuGa6M+K3RWcd72LzBLbFqjM
         /8n7+lOHSyDmph6conOD8l8u6+qNCtWXtz3Jywn8RDWiOC3vgqF6CQYiG4Av6EEyCa9k
         B4l0cAI5bK+IcVUBHR0y2ybKN3ueyDJKKoYnurqclsbPAeVC3Hwg6oMEcxTO30/F1OCW
         lNtw==
X-Forwarded-Encrypted: i=1; AJvYcCX4tl2Tna2B8T5qcXn/uFv+VtzneKsXo38BDtRy1FVKaV/BHFoG9saqKCOH51n9w3ZoZFNCqzeC5EWfPCKnm7W9S9zB10t0ta800A==
X-Gm-Message-State: AOJu0YzFsTbo6e2+ZLKI47CLTjuNRIDfeCUgbZVbMSrAxjUo+8zqWAk9
	3gOBV2GGgFNAkXm0ideiErNxvpkwUAvnOmjtuMBngTOagx6ZeV1WanZFMaxv35o=
X-Google-Smtp-Source: AGHT+IEqmZ/bPScFDErmd2Bdge5ElcWmdcXhPkDOr+1siQATWKStEMzgbLHSA9vyfoc0LpJeGpIgyw==
X-Received: by 2002:a4a:2b11:0:b0:5a1:25fc:7be0 with SMTP id i17-20020a4a2b11000000b005a125fc7be0mr413338ooa.3.1709930236902;
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id bi3-20020a05682008c300b005a0859a4a01sm19059oob.36.2024.03.08.12.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 12:37:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rigxv-007xzf-Er;
	Fri, 08 Mar 2024 16:37:15 -0400
Date: Fri, 8 Mar 2024 16:37:15 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 6/7] iommu/dma: Centralise iommu_setup_dma_ops()
Message-ID: <20240308203715.GA9225@ziepe.ca>
References: <cover.1707493264.git.robin.murphy@arm.com>
 <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202fcca3269201bc9c4a8198253f195433d0c4ff.1707493264.git.robin.murphy@arm.com>

On Fri, Feb 09, 2024 at 04:50:03PM +0000, Robin Murphy wrote:
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

