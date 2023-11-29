Return-Path: <linux-acpi+bounces-1938-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E82257FE33A
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 23:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2478281FF1
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9023B786
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bzTFhvsx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D7010C8
	for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:36:44 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-58dc434442dso604396eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290204; x=1701895004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SEEWYYfbaxLfYva0ae/C7ZnG1wW28/cSiuyFpLC5DM4=;
        b=bzTFhvsx7tgX8irz4bWPK02IEj84iIYed4ZhSta9GVEBkEXbfjM3fo795qNaVP85sp
         KZT+GDrHkxbEDOek2xxef8dQxSUdyZQYwV+lO4Ayqq9OE+ubjQXyt1+irJWIx8YvDXOW
         uIKBi5NC8OsSltJIrqqRi4Sc+/Gvh4QyuEVazrSly3/pAoyTDBeOtx2h+6fknd5BzBqc
         +RpsqNT08Zm+s1Wt3VYPb0+huS7q+FUQrbmTXhbqVVh8sXTD+9mPc47Qjqmim6V17Gl3
         8i75eH0TiS2E5Mwb4Y65OdwP1hWT/ylM8y4LR5Jch1TrqV+iHJrIfWSCiTJCgXHUoSek
         CyWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290204; x=1701895004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEEWYYfbaxLfYva0ae/C7ZnG1wW28/cSiuyFpLC5DM4=;
        b=ZUk5IKORs332hemGaX/BVwBhPH8cTf92Myej/mN1HbHrOLYCJlHdiclSZF7gowG6Om
         ys3M6DAGRQ/fsfPHocEAfk6d+8HukFj9m8M2xhdjZNaclctVFNnFfoSw1pjL0+Y+/HmG
         UcIqLLSKlymNpd6P5Cf4P4AB9TdixFrGX6HGrM6y6mqqeg6lt3RyHT6nGwACVijCbZEe
         0hN06RIscTBkaeqAp/L2SfBcjqbsrmg2iONSNWXIvmFoNK1bt1PpFK1tnSDGQLaExWTW
         k+5agqJOPIk9K5tqC/UjbKb5XXA1smzIOxDj8QYOvVcEjyBi+aORRB4TBN1CFqcNFiHW
         je0g==
X-Gm-Message-State: AOJu0Yw2xb4L2xtPwFWtg/KdXbaWYZQG52ApXIOQa0M9PhfkAIWT4jet
	ly9GgGBPL5Wwsx4EuIZsoOKRYQ==
X-Google-Smtp-Source: AGHT+IHmOgaQ+837kiXjy012BQ8mhYf6brt1F8AtFjpilauVwFsZjspevsWNCbIpo0nFHydtgIy6ZQ==
X-Received: by 2002:a05:6871:3322:b0:1fa:29b7:f2a0 with SMTP id nf34-20020a056871332200b001fa29b7f2a0mr7173525oac.23.1701290203779;
        Wed, 29 Nov 2023 12:36:43 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id z19-20020a056870515300b001efce0658e6sm3567983oak.39.2023.11.29.12.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:36:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RIY-005pe4-9r;
	Wed, 29 Nov 2023 16:36:42 -0400
Date: Wed, 29 Nov 2023 16:36:42 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
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
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] dma-mapping: Clean up arch_setup_dma_ops()
Message-ID: <20231129203642.GO1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:42:57PM +0000, Robin Murphy wrote:
> Hi all,
> 
> Prompted by Jason's proposal[1], here's a first step towards truly
> unpicking the dma_configure vs. IOMMU mess. As I commented before, we
> have an awful lot of accumulated cruft and technical debt here making
> things more complicated than they need to be, and we already have hacks
> on top of hacks trying to work around it, so polishing those hacks even
> further is really not a desirable direction of travel. And I do know
> they're hacks, because I wrote most of them and still remember enough of
> the context of the time ;)

I quite like this, I was also looking at getting rid of those other
parameters.

I wanted to take smaller steps because it is all pretty hairy.

One thing that still concerns me is if the FW data restricts the valid
IOVA window that really should be reflected into the reserved ranges
and not just dumped into the struct device for use by the DMA API.

Or, perhaps, viof/iommufd should be using the struct device data to
generate some additional reserved ranges?

Either way, I would like to see the dma_iommu and the rest of the
subsystem agree on what the valid IOVA ranges actually are.

Jason

