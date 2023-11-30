Return-Path: <linux-acpi+bounces-2000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7977FF649
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 17:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AB7B20B49
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 16:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A5C54F82
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j23gMi96"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF0345BFC;
	Thu, 30 Nov 2023 14:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF04C433C7;
	Thu, 30 Nov 2023 14:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701356218;
	bh=GpBXBuO6iixv10ETLZMpn7khg0ZMspsWXBNle1mq37U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j23gMi96EXhnTOprv0TuU8Or8MmOdcYvxLznXcAghhv7HR0rRqVqQRMf9Aewyy3RU
	 TencKa4igtrQMc6Lq+diZUvs83N2Bpn8QGWosZCW7yh28lDHF2YRNTbHhpECuyM6Bu
	 yD5m6LOMCxB/x0aUNdz+mVVFadzg42PLNNwEagtyGJLuY6/freGE7/3IBC2u7V7H1s
	 UMSlsk9jaIqSN+7TI/iPysEbW61wDGbTVr3y6WSMeL7taITRvVKBM/NlzF3+iH5aGH
	 Wz9nBpWNpjjurYTharEeuEjfPdzAZEGHHiBPwZ2RYRgjZj1pCoVKZvqeQmvql3YhL7
	 eyBS0bDjl16wA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bb92811c0so1025913e87.1;
        Thu, 30 Nov 2023 06:56:58 -0800 (PST)
X-Gm-Message-State: AOJu0Yw/yk5NlIjNUN6g0h3awUEQankLz8BXXnVcfE+0lazrQCTZ85wv
	FTf6MCe6NsJ72+sGpMYKWhi0ipfVcU/UqK3dDw==
X-Google-Smtp-Source: AGHT+IGo9+hwZbxNr54yXWh69cfY32jjew+hEBiuusC6kMJDQptRw29wukfMiu6+gPSwl3ItrcFP74MRuMgWAcqeURY=
X-Received: by 2002:a19:ac0d:0:b0:50b:c42e:7c4f with SMTP id
 g13-20020a19ac0d000000b0050bc42e7c4fmr1756657lfc.15.1701356195582; Thu, 30
 Nov 2023 06:56:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701268753.git.robin.murphy@arm.com> <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
In-Reply-To: <73becf4a75f15662b2dda5fba7cfeacdf3d866f8.1701268753.git.robin.murphy@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 30 Nov 2023 08:56:23 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Message-ID: <CAL_JsqJ+V_=um5+Kz1AofDxx8_gqdWGeYqPdaxMDV1HiPsvq=A@mail.gmail.com>
Subject: Re: [PATCH 2/7] OF: Simplify DMA range calculations
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
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 11:43=E2=80=AFAM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> Juggling start, end, and size values for a range is somewhat redundant
> and a little hard to follow. Consolidate down to just using inclusive
> start and end, which saves us worrying about size overflows for full
> 64-bit ranges (note that passing a potentially-overflowed value through
> to arch_setup_dma_ops() is benign for all current implementations, and
> this is working towards removing that anyway).
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/device.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

