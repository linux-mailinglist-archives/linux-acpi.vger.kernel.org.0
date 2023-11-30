Return-Path: <linux-acpi+bounces-1999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76037FF647
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 17:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B36281745
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 16:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583CF54FB1
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 16:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z07Tt3+J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA9B51C38;
	Thu, 30 Nov 2023 14:47:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E9C433C9;
	Thu, 30 Nov 2023 14:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701355631;
	bh=dNJWSo8E6GQ4fVWyXjpzy+fiTadQolXDNmtZRzZe2RQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z07Tt3+J1NH+TmhZzsMsKbN95ezIMx9gO6IVPWDmheCO7/DZ4cIc3mKfBZkYG+mk8
	 DNjfF191aWJFzXt0tFERiWHMAhCgsUjIMtj0QjSyiYuScgky6GROZfN8oFVsLLV8Fh
	 kqUsT5L/F04a2czctAFDaowp8TqZT5l2nFUBoQckD9o2xcx7hAQrMFTy0fQMeVc0TG
	 Lx4Qsr+T9b7kqpyawUYdIeCbTpQdjuheHKqbeEr8vpcuV9DSItgV6Fp5A54853lPov
	 QO6cnUqaX+qLgfYjV6oNryejUGgDSHhBDXDVii8gxX9wkIly2gFjzYAnGFkm8fnsP1
	 fNhXSojcCqUQw==
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a19067009d2so66573366b.3;
        Thu, 30 Nov 2023 06:47:11 -0800 (PST)
X-Gm-Message-State: AOJu0YwdDh55HylaVCV88VA6iW8d8GpOlRpPiMXw1/9mt9ipMujcw6xg
	rR4SWYooanPfwOPEXuSsW0u4ULMcIWqKyPzaXg==
X-Google-Smtp-Source: AGHT+IHSmMEE+qYvPFQMyf7A7mr7f1220m4lfUsZ3/p1781IxEAccKr7vlPfmbnUSIcpUxea8isNLTGiW3bfb0ZEQ0w=
X-Received: by 2002:a05:6512:2102:b0:50b:c543:c4cf with SMTP id
 q2-20020a056512210200b0050bc543c4cfmr3437536lfr.6.1701355609063; Thu, 30 Nov
 2023 06:46:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701268753.git.robin.murphy@arm.com> <950378c6f39270a255452733ff2305e56fb05cc5.1701268753.git.robin.murphy@arm.com>
In-Reply-To: <950378c6f39270a255452733ff2305e56fb05cc5.1701268753.git.robin.murphy@arm.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 30 Nov 2023 08:46:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK_StOWTOBCR6OaAqu63_kyVKsA46qJ4ky9iSyB-yKZ2g@mail.gmail.com>
Message-ID: <CAL_JsqK_StOWTOBCR6OaAqu63_kyVKsA46qJ4ky9iSyB-yKZ2g@mail.gmail.com>
Subject: Re: [PATCH 1/7] OF: Retire dma-ranges mask workaround
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
> From what I remember, the fixup adding 1 to the dma-ranges size was for
> the benefit of some early AMD Seattle DTs. Those are likely extinct by
> now, and anyone else who might have deserved to get the message has
> hopefully seen the warning in the 9 years we've had it there. The modern
> dma_range_map mechanism should happily handle odd-sized ranges with no
> ill effect, so there's little need to care anyway now. Clean it up.

The commit has a tested by for Seattle, but the series adding this was
for an issue on TI Keystone[1]. Looks like the patch adding this fixup
and warning did 2 things. It added 1 to the default mask when
'dma-ranges' was not present (which keystone needed) and added 1 if
the DT value was a mask along with the warning. It's not clear what
Seattle needed, but there was a fix to dma-ranges about a year
later[2].

I thought at some point we allowed 32-bit DTs to specify a ~0 size to
avoid having to use 2 cells to express 4G size which wouldn't have
been a warning, but I can't find any discussion on that. It would have
been earlier than 2015 I think... Anyways, there is no upstream dts
with that either, so I think we're good.

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/device.c | 16 ----------------
>  1 file changed, 16 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

[1] https://lore.kernel.org/all/1425405134-24707-1-git-send-email-m-kariche=
ri2@ti.com/
[2] https://lore.kernel.org/all/1455162671-16044-4-git-send-email-Suravee.S=
uthikulpanit@amd.com/

