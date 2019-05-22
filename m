Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D85A226416
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2019 14:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbfEVMyg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 May 2019 08:54:36 -0400
Received: from foss.arm.com ([217.140.101.70]:49970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbfEVMyg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 May 2019 08:54:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0364880D;
        Wed, 22 May 2019 05:54:36 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C32D23F575;
        Wed, 22 May 2019 05:54:34 -0700 (PDT)
Date:   Wed, 22 May 2019 13:54:29 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     jean-philippe.brucker@arm.com, lorenzo.pieralisi@arm.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI/IORT: Fix build without CONFIG_IOMMU_API
Message-ID: <20190522125429.GA7876@fuggles.cambridge.arm.com>
References: <20190520065746.17068-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520065746.17068-1-hch@lst.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Christoph,

On Mon, May 20, 2019 at 08:57:46AM +0200, Christoph Hellwig wrote:
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

Cheers, although there's an alternative fix from Lorenzo that I'll send up
for -rc2.

Sorry for the delay; been having email issues this week.

Will
