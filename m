Return-Path: <linux-acpi+bounces-1939-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BA57FE33C
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 23:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06B62B20A2D
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9F47A4B
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Nov 2023 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FPRXhtOr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05A6D69
	for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:40:44 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6d81580d696so152756a34.2
        for <linux-acpi@vger.kernel.org>; Wed, 29 Nov 2023 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701290444; x=1701895244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=FPRXhtOrAV5xg2ep6+npC90ZSnpQalIGR2w53QMKa3XLO/hG0KmMCeIAEJYG9nBJWa
         /XyyUlxnf8qxAxQaWmKVhby4s5m9Ta/R4x8QhtH8YfdNzl+p6aeapMOLXIPz8RLo/pjh
         IOpI2VD/QnYVyMPPrxjtdK9wv8Otlic/ctIvKNQMpTzekcCTjVogfQF4jR5thhHXsjCs
         XONtlIfvzyaZj/K/WAsdq3tTQWkbny+MdS0Xc+CJBzPOQ/LHxjv7V0aeigbx0nYcDG9u
         Gawbifm5xn+KRSCUaJc1fnk6/rBRvV8nKVVLyaEi4QZnJFHIJEs+ftWuSwbPhkVly6xB
         Ux/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701290444; x=1701895244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i4is+UaFXgNmfUwcjSjgaiG0RVAiB9ug48COJL1kEfc=;
        b=p7QXZNrf/SbT0ZRPm1iUQdbjDMrW0/IFRehVphkoQVNWwuyW+ozdnv8kZcNbuGZIpe
         jAvIW/1Diujv+CKxn7j5w3P4TfwyyCXBfKMXEj/RAd+gFTU5qH1cjnfleVUyDPVgNv+n
         xkrv03wAVXXgELi/gXKY5pMXpNGst3A3NsTiIfgqpa3qD5rjijHZ5puuPaEWZZ8brUCg
         /ju5lXK6l2KgKEWw77u8TN6gbExONvCo0ofdmmjE6dFylRZoOoP36J8V9QiPEjAbnhwp
         HM2WUASMHR1vgOgqVf1A0U6YuryqDpp3OQH44Yo0cHq86tU/7eWQz5QQs3qbI2NFziCi
         5Dig==
X-Gm-Message-State: AOJu0YxV89xZCDPZMTZZxp+nfdJwhrdLPet+Ztesnm7tFCOY9I+dK48g
	PkKibEo6fuzCSlMl4JE0G2Zr0g==
X-Google-Smtp-Source: AGHT+IEnrq+40pWqc9tikvXUqS6Y6R2hs7giuPFXyADBt3dDnfao9L3w+T91fxfG4h2rkEvYDjFXYw==
X-Received: by 2002:a05:6830:1d41:b0:6d6:3ff8:aab7 with SMTP id p1-20020a0568301d4100b006d63ff8aab7mr19895331oth.1.1701290444152;
        Wed, 29 Nov 2023 12:40:44 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id e11-20020a9d560b000000b006d3161e612dsm2113398oti.30.2023.11.29.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:40:43 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r8RMQ-005pfu-R5;
	Wed, 29 Nov 2023 16:40:42 -0400
Date: Wed, 29 Nov 2023 16:40:42 -0400
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
Subject: Re: [PATCH 4/7] dma-mapping: Add helpers for dma_range_map bounds
Message-ID: <20231129204042.GP1312390@ziepe.ca>
References: <cover.1701268753.git.robin.murphy@arm.com>
 <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6626985d97ddc33a23b4b9fafa881b35001547e.1701268753.git.robin.murphy@arm.com>

On Wed, Nov 29, 2023 at 05:43:01PM +0000, Robin Murphy wrote:
> Several places want to compute the lower and/or upper bounds of a
> dma_range_map, so let's factor that out into reusable helpers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/loongarch/kernel/dma.c |  9 ++-------
>  drivers/acpi/arm64/dma.c    |  8 +-------
>  drivers/of/device.c         | 11 ++---------
>  include/linux/dma-direct.h  | 18 ++++++++++++++++++
>  4 files changed, 23 insertions(+), 23 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

