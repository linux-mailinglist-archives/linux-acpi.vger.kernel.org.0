Return-Path: <linux-acpi+bounces-1942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D947FE6B5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 03:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28894B20E85
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1940F9CE
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gJeX5uHA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ECBD5E
	for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 16:39:53 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-58d439e3e15so179401eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 16:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701304792; x=1701909592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=gJeX5uHA1xRqlJ/NiA8klcilclFAkpTYoxKBf2ye+8qryZEh2tC6Ns0dAY8FdjXziV
         ZUDnlI8kYjSxCj9nAOh37pJd+ErExStgh7MgF5jPSpwIg0JcOyZ/+wKLRKoWBSCMbT1F
         PxL0Jom0KbNcioSagO/WECnaxufHktzDqUznGVUXUlp7hXviyKPQPc7F9p7kwjQRN9zl
         XKd1RWv6bCXpJ+fHMPYZLSUnKVtgMsPyq5ypXQvxsU7o7Q/0gqU2Oex6U1sjV1jpOPFs
         AvdabnAch/SxZjfHaDOZXkcy4ooJrMuH/piV/3/s5PI3fB5FQnZc4oN/Uwuh/k/7GBQz
         EU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701304792; x=1701909592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqKTf6r/9DX5X0G9N0YPszfAss74aB4UlJwKc4ipXlY=;
        b=GaeQ+VK10guQw/HuvoLCDw5lssQcSZfJXqK3DIoVBBzbLHNbcD+PMnK+AZlXQpVeU/
         FY6gkjccggdDuP3VFX3P7WXkolrEnV0U7lNwmHBJZqMa9cMszjQOUybgE3BodS4GIXiE
         Vkp8wlW2rS2M/vEs7BFzfIxCOnMTmHimvAuzU5QcXhNzuG+aB5/hAnGtqCgi4pMPL/Ki
         NDBkqeEIx8U/zNtxSqw/AosW7ityeM6GhEkH0Nletpcgwlxchw2b10v6aaw2tX715oHX
         XHKXqgweM28ifiEs2tOpqMQT2NhO0KEf+DrnTAK10tX1s9sFUL9y3GUNZ1s+l3E2ENn0
         jHrg==
X-Gm-Message-State: AOJu0Yw9upB+XJ+67r3dAfTkHCeY4ohNdyxWxhc1hs+KncdLhzWQSd6X
	we1lr5lxo+TGvxvws3kULbarXw==
X-Google-Smtp-Source: AGHT+IG4kpqJkp5MuGe0QWOyJQ+HDuDWisfSFN2LiYZ3lNwDJg400B3FZHlbHx5WpKar2Jc43DZwNA==
X-Received: by 2002:a4a:a645:0:b0:58d:6bf6:4daf with SMTP id j5-20020a4aa645000000b0058d6bf64dafmr7941560oom.2.1701304792652;
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b0057327cecdd8sm2410792oon.10.2023.11.29.16.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 16:39:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8V5r-005qzk-3H;
	Wed, 29 Nov 2023 20:39:51 -0400
Date: Wed, 29 Nov 2023 20:39:51 -0400
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
Subject: Re: [PATCH 3/7] ACPI/IORT: Handle memory address size limits as
 limits
Message-ID: <20231130003951.GA1394392@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ae6199a9cf035c1defd42e48675b827f41cdc95.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:00PM +0000, Robin Murphy wrote:
> Return the Root Complex/Named Component memory address size limit as an
> inclusive limit value, rather than an exclusive size.  This saves us
> having to special-case 64-bit overflow, and simplifies our caller too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c  |  9 +++------
>  drivers/acpi/arm64/iort.c | 18 ++++++++----------
>  include/linux/acpi_iort.h |  4 ++--
>  3 files changed, 13 insertions(+), 18 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

