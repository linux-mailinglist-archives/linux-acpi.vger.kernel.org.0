Return-Path: <linux-acpi+bounces-1462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FC67EA4E2
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 21:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C51C208C7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5BF250EB
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 20:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UDz++v72"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863F424A11
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 20:23:36 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A92710D9
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699907014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
	b=UDz++v728cnjhBP5mHYKtusMPfGvPebQ2vefvEtyu2yOvPumEttY9cJ1kovly7+R5iRQOB
	YyeudiBEdTNh5w21tWRNPYKpHXj1LSfXS5jAtvD1H6m0/nvgtRfvt6YOzriZKEv7MTbCc4
	VY+0SGAR/lnTFLOSlskIg3+CjYUCfvE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-SsZLXRHHOwOyKOdEOMoNtA-1; Mon, 13 Nov 2023 15:23:33 -0500
X-MC-Unique: SsZLXRHHOwOyKOdEOMoNtA-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-41b83b8dbe1so58278611cf.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 12:23:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699907013; x=1700511813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqWGwV812/CXYndzj2W50PA7KOMPm+tHC+e+xjD2/M0=;
        b=ajkLtQhX/bXfD+kBkTGaBRL71HsQEFtBYUf6UKm1OLZSa+vwOMFa/vOFNR80DHS4PL
         kKuOBNtLBMa+IrNG2NdnKy59zdoO4SxuPFkzQebKXFITt5FpHiVkhy2KRIBcimPPXMOG
         s82CUZGf5gZyXAbQErnSPnXyklzHe+iYRCjbUWknUfUC19batWD4uCPm4Z41bBv2rrQF
         7ykegXsnrXkB6i1kLCTv+lwQ8k0L1AMz7Stskl6M3ficef0GRYUftJzz+SHoyazoGfmA
         YadI9GlmNs4pfwokGo9Uu0JHNadWoG/6Di/znzB82mEwFrc6jZTmNnxIZKGMf+aVCIOe
         3bYA==
X-Gm-Message-State: AOJu0Yzg7x61nxdDMe2KOeetVl1C3seRkiseHDP3o+PLwhfuhdVVqsId
	aGwCIy4KK688UNoDQZo0SNxj+/iN1TTRPZyTY2rMEUIUAgqcxEExd+7Y0ScLAiwQabyuQr5Wj3D
	aerqfZEX58swlRqcIEn3Arw==
X-Received: by 2002:ac8:7dcb:0:b0:41c:c489:5737 with SMTP id c11-20020ac87dcb000000b0041cc4895737mr180991qte.52.1699907013255;
        Mon, 13 Nov 2023 12:23:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETLe6ua2NZBk5C5HvQsSQRhq7xoJL++WLnwlLCZjQoU3YIRy9czQKgZx9fuBDkEqY7LDc6Jg==
X-Received: by 2002:ac8:7dcb:0:b0:41c:c489:5737 with SMTP id c11-20020ac87dcb000000b0041cc4895737mr180976qte.52.1699907013032;
        Mon, 13 Nov 2023 12:23:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z10-20020ac8710a000000b004196a813639sm2177639qto.17.2023.11.13.12.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:23:32 -0800 (PST)
Date: Mon, 13 Nov 2023 13:23:31 -0700
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
Subject: Re: [PATCH RFC 15/17] iommu: Add ops->of_xlate_fwspec()
Message-ID: <j56kfjb5dt3drcxh56lyc4om3qjnwddot2i5f62f6u6gwefj7i@rxmgclwaevf4>
References: <0-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
 <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15-v1-5f734af130a3+34f-iommu_fwspec_jgg@nvidia.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>


