Return-Path: <linux-acpi+bounces-6146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92CF8D8A9A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 21:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381C1B284AE
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 19:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5B013AA3B;
	Mon,  3 Jun 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="HNQZFbxv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6CB20ED;
	Mon,  3 Jun 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444564; cv=none; b=WHOzI9EHZMa+Iuy4nkC7ownMTxmoQlMAe3bXUiB/ND5HEAgEza0+4zP3Fj77PHLzAQ0iTv0w+fHf0ZKK4sHnq8wvBUgx/zsMvd1dFAfpHB02dWbqvbQLtc1udxyLgAzkMaMxtu+t2UU3LfpxpOWQDQwl/BaqvdRAoxucq2DMy1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444564; c=relaxed/simple;
	bh=X02/WrcKG3y6tPosHO5YUNSdqDVkQDTVr3S+20CPbGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KA8YtshiV92Q2NOZqKnkZGg+Dw+Y6mxTM6WYy2adSwRViVVMWDtI8OI4uAcP5V+UgrHMj+z8yp15ZHGwg/S+8VEKhJLJqhb8nLqKxSusF1iq3lJvg5yDYmaRwp2wyHKryfn1Y4Ih0icJvx0BbsXZedZq54SMqCtA4zdrDU5XshE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=HNQZFbxv; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1717444555; x=1718049355;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=X02/WrcKG3y6tPosHO5YUNSdqDVkQDTVr3S+20CPbGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=HNQZFbxv4wWkrF+W7wobqlWCXDH3m4+DT87C2AGRVIWtdylbvLh6n2UwQsIt1SiX
	 HlmzQk+5pzrCYnu1g3nPgBj/ALYjf3zmVhMZwieaQprmtzdyX0lMBmc+6qArBtrnW
	 cxRcxvKEVUadMvJF1s9flL4Ga1DQPPKdWEDyPGxCsPFX5l2yFcwG/96N+n5zNVB+z
	 mRCR7fZzqYHVwYmFHtsqOgeJcKTYYxbBwPVdMk/Hfp2QUH4oo4xbCIKHjWuBK/L9/
	 +l87GaNi1vCod6gzM1wXzuG5HDjkNK4MzeR7E2eo+EXH04zrxGmGtFOnWj4eOVjCQ
	 bsdBeWgpsQdSJ6mzGQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([91.64.229.215]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M42X0-1sEDgf3Pua-0002kL; Mon, 03 Jun 2024 21:49:45 +0200
Message-ID: <753fd496-ea66-42dd-a607-a879c3cce6b6@oldschoolsolutions.biz>
Date: Mon, 3 Jun 2024 21:49:43 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1713523152.git.robin.murphy@arm.com>
 <e28a114243d1e79eb3609aded034f8529521333f.1713523152.git.robin.murphy@arm.com>
 <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
 <a4105d70-bec5-4fff-b9bf-04d0b03f81d6@arm.com>
Content-Language: en-US
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <a4105d70-bec5-4fff-b9bf-04d0b03f81d6@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iScz297IREJFID4bB3dtWwm3UthsXvjTmxRXzgKye5unhq4O8El
 UAp0YhhOkMt18jGteSmf+HbA5IqXBght1LGj55BFwT5gKovF2QMJd2VLv6ju+yQgF8OEFS2
 6TaC7X10u8+U2BtvRcbGKRdmDiXJzZtuViJBoL2mdaHA+YN3BjKzQAkCp4jPPCqkuGrfhjb
 TmZJ62CruJPxm1u+aLqdg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qGcpoOb2bMA=;OYMmfwCyP4ATmR7YLDzYf0NQvOT
 Vq4EF7Zw55G8zloA1nBYhi3PnJpDKhr6DQuKVQr3x/OZ4bVovUeOP9Yt8JkF/Y3cuKHRYd3pm
 z4EcOGd2xQWOmhytIzyqyIMwTugk4WHA4YgupoSI1ss7Myt9hMlbYsWlRzM3OScGnvMS+UoGb
 85l5GjXASHV/+xZMzoM6p+FGBmXvmTDYF/19wfEPLgPQgUwiwgn0esCVk1U2P2+j3SWunOhkO
 BiT6hEAASzaCLrCGWU+YcKfGZaLrBXIACblUeG+jswWpEWNOrFotuhFFZvyD53sAJpqX493Uo
 RwJKpMm5DOvg8pEw0YqLojiX34HiIKBwZNUFhtu/mUXR0n5InMvQnYnX/U6uuuySmdovXF0y7
 2r7d6YthJBJD03qjdVn0/V7C8YoLzH6jOWNXhF0vKkw6oMAbh2hCOgCLqReGEcgt+M/4D9F9K
 nfzg//8+1S/scX2BM1ehQRkwh8TwpKYkML4JgnLavGn/9ip6PmTXKuwq/6K1W4sXNnNRxKVyq
 s0Yp07QJy+Qh5Z7VDbTO8oCxx5Yh+p07HDY03lTpxYjerStd4Si+JiqgDPWwnYjn5wbZXoS8u
 EbH9hA1EUtv6nU1AfKSZz3WaDCCSBkvdbKGvcmcMOOq/X64/O4yyJOlRFwLHBqpf3XkEVVasK
 BUOxk3YQFpJRwFmpdawerEUUjoxOvJEPg1NzAFRaW45XQGnAIaKA9KuFwTxAmHyr1msW30x/l
 h0Pf1q34pySadLyjOAfbs/cNEk2HLfWCTQtmVOKYuIwDbsfKzG6Z8M=

Hi Robin,

oh that was fast. Will test, thanks!

with best regards

Jens

On 6/3/24 21:46, Robin Murphy wrote:
> Hi Jens,
>
> On 2024-06-03 8:37 pm, Jens Glathe wrote:
>> Hi Robin,
>>
>> an observation from 6.10-rc1: On sc8280xp (Lenovo X13s, Windows Dev Kit
>> 2023), when booted to EL2 with the arm-smmuv3 under control of Linux, i=
t
>> fails to set up DMA transfers to nvme. My box boots from nvme, so I onl=
y
>> got a black screen. @craftyguy booted from USB, and got this:
>
> Indeed, I see there's a dma-ranges property with a base of 0 in that
> DT, so all manner of hilarity may ensue. The fix is here, just waiting
> to be picked up:
>
> https://lore.kernel.org/linux-iommu/159193e80b6a7701c61b32d6119ac68989d4=
57bd.1716997607.git.robin.murphy@arm.com/
>
>
> Thanks,
> Robin.

