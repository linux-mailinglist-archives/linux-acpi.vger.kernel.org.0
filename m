Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E996023165
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2019 12:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731473AbfETKe5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 May 2019 06:34:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7661 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731455AbfETKe5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 May 2019 06:34:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 926B8E26C95E4047DF58;
        Mon, 20 May 2019 18:34:54 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 May 2019
 18:34:51 +0800
Subject: Re: [PATCH] ACPI/IORT: Fix build without CONFIG_IOMMU_API
To:     Christoph Hellwig <hch@lst.de>, <will.deacon@arm.com>
CC:     <jean-philippe.brucker@arm.com>, <lorenzo.pieralisi@arm.com>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20190520065746.17068-1-hch@lst.de>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <dc52ba2d-76d7-ebb1-7284-bdcd71f6e010@huawei.com>
Date:   Mon, 20 May 2019 18:34:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20190520065746.17068-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2019/5/20 14:57, Christoph Hellwig wrote:
> IOMMU_FWSPEC_PCI_RC_ATS is only defined if CONFIG_IOMMU_API is
> enabled.
> 
> Fixes: 5702ee24182f ("ACPI/IORT: Check ATS capability in root complex nodes")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/acpi/arm64/iort.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 9058cb084b91..3e542b5d2a2d 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1074,9 +1074,10 @@ const struct iommu_ops *iort_iommu_configure(struct device *dev)
>  		info.node = node;
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     iort_pci_iommu_init, &info);
> -
> +#ifdef CONFIG_IOMMU_API
>  		if (!err && iort_pci_rc_supports_ats(node))
>  			dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
> +#endif
>  	} else {
>  		int i = 0;

This was reported, please refer to this patch from Lorenzo:

https://patchwork.kernel.org/patch/10946845/

Thanks
Hanjun

