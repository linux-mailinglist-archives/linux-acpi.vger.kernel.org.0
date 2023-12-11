Return-Path: <linux-acpi+bounces-2281-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A580CF8B
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 16:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9575C281D52
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Dec 2023 15:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6FA4B5B6;
	Mon, 11 Dec 2023 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYfQtKQq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575843B184;
	Mon, 11 Dec 2023 15:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0802C433C8;
	Mon, 11 Dec 2023 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308633;
	bh=/Q/CO2qks8dFDHzFLXjWAPDdN+fTVkPHlrET0acGnpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYfQtKQqfbt28442XHv+EFC1AIN9ykQs7HiHfK60S/GFWPuNrPR21RFeG3odtUkj1
	 PQdLGeQ7Dj9r9gomv7Y96bzm6rEEb67gBL2swNErG64/tjOWml+uGFCNDutqFUuWYs
	 bKBc92oC+gJTZ0cfo7pFXmwpv39v4hvlCtH6EU8vp21o/fwt1yuuSsG9ltmFSw8owj
	 pjY2vBqTtpgm49TFlcShfsiAXfzygLabIQUSGpeLeOaEHtxso6Pa10H7OrmwC9fNMf
	 3KGgA+dzYMGZmEjxO0FYuwqeOOiSuZv9xx39lZD6s2m40mGFrGCHxmzsic+6dFyIe0
	 ymi88cjfcV9Ng==
Date: Mon, 11 Dec 2023 15:30:24 +0000
From: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Christoph Hellwig <hch@lst.de>,
	Vineet Gupta <vgupta@kernel.org>,
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
	Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231211153023.GA26048@willie-the-truck>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
 <20231211132757.GE25681@willie-the-truck>
 <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b22090-485f-49c9-a536-849fd7f92f8e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Dec 11, 2023 at 03:01:27PM +0000, Robin Murphy wrote:
> On 2023-12-11 1:27 pm, Will Deacon wrote:
> > On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> > > Return the Root Complex/Named Component memory address size limit as an
> > > inclusive limit value, rather than an exclusive size.  This saves us
> > > having to special-case 64-bit overflow, and simplifies our caller too.
> > > 
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > >   drivers/acpi/arm64/dma.c  |  9 +++------
> > >   drivers/acpi/arm64/iort.c | 18 ++++++++----------
> > >   include/linux/acpi_iort.h |  4 ++--
> > >   3 files changed, 13 insertions(+), 18 deletions(-)
> > 
> > [...]
> > 
> > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > index 6496ff5a6ba2..eb64d8e17dd1 100644
> > > --- a/drivers/acpi/arm64/iort.c
> > > +++ b/drivers/acpi/arm64/iort.c
> > > @@ -1367,7 +1367,7 @@ int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
> > >   { return -ENODEV; }
> > >   #endif
> > > -static int nc_dma_get_range(struct device *dev, u64 *size)
> > > +static int nc_dma_get_range(struct device *dev, u64 *limit)
> > >   {
> > >   	struct acpi_iort_node *node;
> > >   	struct acpi_iort_named_component *ncomp;
> > > @@ -1384,13 +1384,12 @@ static int nc_dma_get_range(struct device *dev, u64 *size)
> > >   		return -EINVAL;
> > >   	}
> > > -	*size = ncomp->memory_address_limit >= 64 ? U64_MAX :
> > > -			1ULL<<ncomp->memory_address_limit;
> > > +	*limit = (1ULL << ncomp->memory_address_limit) - 1;
> > 
> > The old code handled 'ncomp->memory_address_limit >= 64' -- why is it safe
> > to drop that? You mention it in the cover letter, so clearly I'm missing
> > something!
> 
> Because an unsigned shift by 64 or more generates 0 (modulo 2^64), thus
> subtracting 1 results in the correct all-bits-set value for an inclusive
> 64-bit limit.

Oh, I'd have thought you'd have gotten one of those "left shift count >=
width of type" warnings if you did that.

Will

