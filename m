Return-Path: <linux-acpi+bounces-6145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 037198D8A8A
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 21:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25EEA1C238A1
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2024 19:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E392E13A878;
	Mon,  3 Jun 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b="oX1I3/Mw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717D54411;
	Mon,  3 Jun 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717444450; cv=none; b=MFCM5YYb0lXEreGhWC8aSOHUP1FmsMfWKbnmmI+fVO4EUq6dxsC1LKSUc1KdYL+p+2y3zrAKv0S9QC8eiZHrN9kaDdayK3w5cgUcWhH6W5+NvTunQp/y8t94EhhpepaxBeaBzdx5Png/uNBj3mUsOJhcj62mr4H8tHGtexyvqFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717444450; c=relaxed/simple;
	bh=bbR0UkL+rJ2U3ug0EEXqJ4OwpK9TIK2mcfab+Af2L2I=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=NnFXjPdEDpVnQa2Rs0Yvy+oYKpHNiB6nxpLBZJ18Ht44p1D9Oq6CZQGfGOgC/Z6tN0TLG7oihV0Y3VmKOiav2BGwiREvlL4pjS5FsDd/uUVKBPjJmCabq494KlnhGTZyBArsvPPymGDDHNVZEwds14+cnNPIquEPhOR36KO/pYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz; spf=pass smtp.mailfrom=oldschoolsolutions.biz; dkim=pass (2048-bit key) header.d=oldschoolsolutions.biz header.i=jens.glathe@oldschoolsolutions.biz header.b=oX1I3/Mw; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oldschoolsolutions.biz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oldschoolsolutions.biz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oldschoolsolutions.biz; s=s1-ionos; t=1717444427; x=1718049227;
	i=jens.glathe@oldschoolsolutions.biz;
	bh=gqJz7G2xwcGk8EgKoBW+9VkU/+1eejcff/SKMh7Lakk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:
	 References:To:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oX1I3/MwQJiCO1YczR+A2Lw+Ul3EGKWqC1pAZzdJTJ3Xl3XFGc2GlYyDDAHj6LvP
	 DfcU8en9H2FptsxY2GboX2txAih9KKSAaceZUKRLP7aoAvOgacmQnOskGJrzEHerZ
	 BUDWrYLj7lVUduhYItDBsbS1O7ffVgGaaN+mBFQfs7R+efRpA3t/deB3UytbtG8b6
	 IAS0rL9vBx91NZbiz4UHrPPANFdcYk/gyC7L8+6tpRu8u2aRjVtIWO87H+ajbERN9
	 gctjOwSK2hpS6qhKzMdkjDhgfc1Cn6upPNXY8fneslFWq8cdxIp5GVXUYIULHDQ82
	 SvZezi3c0hvJ04gyPQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.0.174] ([80.128.165.129]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MuDsZ-1sSz8q3MAX-00tUD3; Mon, 03 Jun 2024 21:47:02 +0200
Message-ID: <11e39001-e5bc-4556-b3dd-4e1a49d9089c@oldschoolsolutions.biz>
Date: Mon, 3 Jun 2024 21:46:54 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] iommu/dma: Make limit checks self-contained
Content-Language: en-US
References: <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
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
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
In-Reply-To: <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
X-Forwarded-Message-Id: <aeb13631-7504-4c3c-ba7b-812bf121a60f@oldschoolsolutions.biz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9c99kyQQfpozQptynYVyBfVRMj3iy1A5iJPxASpd8GXrJAmVA03
 +q+mABXmx/Po+2ZkaKZaii2r7p/wsmwFqyneNaOkzXNuod5NCFb/9Bbk5fKev04U5OIJmnj
 dexD9HPZn5syUfG4fXa/QS2J9BEedKd2BARmzcjXVHKYwKhv8S99eRM98nJJZh3fuI566ck
 1mgQIvfXteESB/sppQETw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SLvh+62L2ig=;F/J8To5vlR0Ku1q/CNsIzpmRXUZ
 dENfKDDE6/dXxcbV/NS6p+AUP52vqtwny+JcH/0huaVziIJKvv/YgSDyLloKjPiIvLpoXDVJp
 v6CBeACWBZPKxQmuqVgvk4LE/VL94FvDLuQUTbll1N3JjHiKsXP6aCONlAK+bmAJ0bK2jf+g4
 jPSk0UZv3O8YO3y0+frXvJIDCUlf8Z7TeFAAQVN89X6sUWy/NuGx/VVZqlhs68Q+YF9LMT5HW
 o0G1US+rd8qoWeBBeK73vNM+NN6xl1zPhY1xcakI5wbWsjLEpRiu7WzmDc/4d7ypx0d1EuhzV
 80do57W1EKfcVMSUcAJO+K/ISmVR54BSU8ziVq0d0wOAi3xyfJ7G2lUHAgY1ezK/5U95/mEiN
 iNFKXhKPRJZBiRyt1NbBMvRjVJlZw9V1kTv8fCU7yfL8LinNwxfk7wrqT6pKpyIVQmvPVas51
 YchiCWsmsEz4M+BNnhUmHKXyUl6W6IttQmYDILL4Hkju6GomHZZ19fKbILkHLte3cq7VgGipY
 ZR/cuaqH/0KYC4eVt9/QmgjnsUgAjEed7xG6YG/PSTBjXw1YfeTNgJyh+2/8I77CzOfiGBesz
 hyqm8dyggThPOOVoi++VJS/gCcWX/oNTa9oUOXQrvqkfAS8WZuyJXpGbOUiAQRg4VgTnjSsw+
 eGk7y6wx3jaxB0wqkxT6R+dujCIeSzJAXgqDmgLv3sxHEUDafQUciTj6F2DzDRzmAxCU73POq
 ZhgRASJVFV6OgdMmLCkl7gVwIDP7+PzSwr/xIZ5tJkkA9tZDbVcm4o=













Hi Robin,

an observation from 6.10-rc1: On sc8280xp (Lenovo X13s, Windows Dev Kit
2023), when booted to EL2 with the arm-smmuv3 under control of Linux, it
fails to set up DMA transfers to nvme. My box boots from nvme, so I only
got a black screen. @craftyguy booted from USB, and got this:

[ 0.008641] CPU: All CPU(s) started at EL2

...
[    1.475359] nvme 0002:01:00.0: Adding to iommu group 5
[    1.476346] nvme nvme0: pci function 0002:01:00.0
[    1.477134] nvme 0002:01:00.0: enabling device (0000 -> 0002)
[    1.478457] ------------[ cut here ]------------
[    1.479233] WARNING: CPU: 5 PID: 95 at drivers/iommu/io-pgtable-arm.c:3=
04  __arm_lpae_map+0x2d0/0x3f0
[    1.480040] Modules linked in: pcie_qcom phy_qcom_qmp_pcie nvme nvme_co=
re
[    1.480858] CPU: 5 PID: 95 Comm: kworker/u32:4  Not tainted 6.10.0-rc1 =
#1-lenovo-21bx
[    1.481669] Hardware name: LENOVO 21BXCTO1WW/21BXCTO1WW, BIOS N3HET88W =
(1.60 ) 03/14/2024
[    1.482483] Workqueue: async async_run_entry_fn
[    1.483309] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    1.484136] pc : __arm_lpae_map+0x2d0/0x3f0
[    1.484963] lr : __arm_lpae_map+0x128/0x3f0
[    1.485789] sp : ffff80008116b2e0
[    1.486613] x29: ffff80008116b2f0 x28: 0000000000000001 x27: ffff591c40=
fb9ff8
[    1.487447] x26: 0000000000000001 x25: 0000000000001000 x24: 00000000ff=
fff000
[    1.488285] x23: 0000000000000003 x22: 00000001038c8000 x21: 0000000000=
000f44
[    1.489117] x20: 0000000000000001 x19: ffff591c4947bd80 x18: ffffffffff=
ffffff
[    1.489944] x17: ffff591c4945bc00 x16: ffffc0bbfadf8768 x15: ffff591c43=
89e000
[    1.490771] x14: 0000000000000000 x13: ffff591c4947bd80 x12: ffff800081=
16b540
[    1.491599] x11: 0000000000000dc0 x10: 0000000000000001 x9 : 0000000000=
000009
[    1.492410] x8 : 00000000000001ff x7 : 0000000000000000 x6 : 0000000000=
000002
[    1.493197] x5 : 0000000000000003 x4 : 0000000000000001 x3 : 0000000000=
000001
[    1.493978] x2 : 0000000000000003 x1 : 0000000000000000 x0 : ffff591c49=
47bd80
[    1.494771] Call trace:
[    1.495541]  __arm_lpae_map+0x2d0/0x3f0
[    1.496320]  __arm_lpae_map+0x128/0x3f0
[    1.497091]  __arm_lpae_map+0x128/0x3f0
[    1.497861]  __arm_lpae_map+0x128/0x3f0
[    1.498620]  arm_lpae_map_pages+0xfc/0x1d0
[    1.499377]  arm_smmu_map_pages+0x24/0x40
[    1.500132]  __iommu_map+0x134/0x2c8
[    1.500888]  iommu_map_sg+0xc0/0x1d0
[    1.501640]  __iommu_dma_alloc_noncontiguous.isra.0+0x2d8/0x4c0
[    1.502403]  iommu_dma_alloc+0x25c/0x3c8
[    1.503162]  dma_alloc_attrs+0x100/0x110
[    1.503919]  nvme_alloc_queue+0x6c/0x170 [nvme]
[    1.504684]  nvme_pci_enable+0x228/0x518 [nvme]
[    1.505438]  nvme_probe+0x290/0x6d8 [nvme]
[    1.506188]  local_pci_probe+0x48/0xb8
[    1.506937]  pci_device_probe+0xb0/0x1d8
[    1.507683]  really_probe+0xc8/0x3a0
[    1.508433]  __driver_probe_device+0x84/0x170
[    1.509182]  driver_probe_device+0x44/0x120
[    1.509930]  __device_attach_driver+0xc4/0x168
[    1.510675]  bus_for_each_drv+0x90/0xf8
[    1.511434]  __device_attach+0xa8/0x1c8
[    1.512183]  device_attach+0x1c/0x30
[    1.512927]  pci_bus_add_device+0x6c/0xe8
[    1.513653]  pci_bus_add_devices+0x40/0x98
[    1.514357]  pci_bus_add_devices+0x6c/0x98
[    1.515058]  pci_host_probe+0x4c/0xd0
[    1.515756]  dw_pcie_host_init+0x250/0x660
[    1.516452]  qcom_pcie_probe+0x234/0x320 [pcie_qcom]
[    1.517155]  platform_probe+0x70/0xd8
[    1.517854]  really_probe+0xc8/0x3a0
[    1.518543]  __driver_probe_device+0x84/0x170
[    1.519230]  driver_probe_device+0x44/0x120
[    1.519914]  __driver_attach_async_helper+0x58/0x100
[    1.520603]  async_run_entry_fn+0x3c/0x160
[    1.521295]  process_one_work+0x160/0x3f0
[    1.521991]  worker_thread+0x304/0x420
[    1.522666]  kthread+0x118/0x128
[    1.523318]  ret_from_fork+0x10/0x20
[    1.523968] ---[ end trace 0000000000000000 ]---
[    1.524788] nvme 0002:01:00.0: probe with driver nvme failed with error=
 -12

 From bisecting this I landed at this patchset, and I had to revert it
to make it work again on 6.10-rc1. From what I've seen the issue appears
to be coming from of_dma_configure_id(), where instead of the base and
size parameters a map is given now somewhere in the device structure for
arch_setup_dma_ops().
Since this only happens with arm-smmuv3 under Linux control, it could be
either malformed dt or some gap in determining the right map for the dma
from the given parameters.

The additional definition in the dt (sc8280xp.dtsi) for the pcie2a port
is this:

 =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 iommu-map =3D <0=
 &pcie_smmu 0x20000 0x10000>;

This worked since v6.8. The repository with a working version can be
found here:
https://github.com/jglathe/linux_ms_dev_kit/tree/jg/el2-blackrock-v6.10.y

with best regards

Jens

On 4/19/24 18:54, Robin Murphy wrote:
> It's now easy to retrieve the device's DMA limits if we want to check
> them against the domain aperture, so do that ourselves instead of
> relying on them being passed through the callchain.
>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Tested-by: Hanjun Guo<guohanjun@huawei.com>
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a3039005b696..f542eabaefa4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -660,19 +660,16 @@ static void iommu_dma_init_options(struct iommu_dm=
a_options *options,
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> - * @base: IOVA at which the mappable address space starts
> - * @limit: Last address of the IOVA space
>    * @dev: Device the domain is being initialised for
>    *
> - * @base and @limit + 1 should be exact multiples of IOMMU page granula=
rity to
> - * avoid rounding surprises. If necessary, we reserve the page at addre=
ss 0
> + * If the geometry and dma_range_map include address 0, we reserve that=
 page
>    * to ensure it is an invalid IOVA. It is safe to reinitialise a domai=
n, but
>    * any change which could make prior IOVAs invalid will fail.
>    */
> -static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_=
t base,
> -				 dma_addr_t limit, struct device *dev)
> +static int iommu_dma_init_domain(struct iommu_domain *domain, struct de=
vice *dev)
>   {
>   	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> +	const struct bus_dma_region *map =3D dev->dma_range_map;
>   	unsigned long order, base_pfn;
>   	struct iova_domain *iovad;
>   	int ret;
> @@ -684,18 +681,18 @@ static int iommu_dma_init_domain(struct iommu_doma=
in *domain, dma_addr_t base,
>
>   	/* Use the smallest supported page size for IOVA granularity */
>   	order =3D __ffs(domain->pgsize_bitmap);
> -	base_pfn =3D max_t(unsigned long, 1, base >> order);
> +	base_pfn =3D 1;
>
>   	/* Check the domain allows at least some access to the device... */
> -	if (domain->geometry.force_aperture) {
> +	if (map) {
> +		dma_addr_t base =3D dma_range_map_min(map);
>   		if (base > domain->geometry.aperture_end ||
> -		    limit < domain->geometry.aperture_start) {
> +		    dma_range_map_max(map) < domain->geometry.aperture_start) {
>   			pr_warn("specified DMA range outside IOMMU capability\n");
>   			return -EFAULT;
>   		}
>   		/* ...then finally give it a kicking to make sure it fits */
> -		base_pfn =3D max_t(unsigned long, base_pfn,
> -				domain->geometry.aperture_start >> order);
> +		base_pfn =3D max(base, domain->geometry.aperture_start) >> order;
>   	}
>
>   	/* start_pfn is always nonzero for an already-initialised domain */
> @@ -1760,7 +1757,7 @@ void iommu_setup_dma_ops(struct device *dev, u64 d=
ma_base, u64 dma_limit)
>   	 * underlying IOMMU driver needs to support via the dma-iommu layer.
>   	 */
>   	if (iommu_is_dma_domain(domain)) {
> -		if (iommu_dma_init_domain(domain, dma_base, dma_limit, dev))
> +		if (iommu_dma_init_domain(domain, dev))
>   			goto out_err;
>   		dev->dma_ops =3D &iommu_dma_ops;
>   	}

