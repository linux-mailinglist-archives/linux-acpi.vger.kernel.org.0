Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCB11E22B7
	for <lists+linux-acpi@lfdr.de>; Tue, 26 May 2020 15:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgEZNIE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 May 2020 09:08:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgEZNIE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 May 2020 09:08:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B87671FB;
        Tue, 26 May 2020 06:08:03 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20CD43F6C4;
        Tue, 26 May 2020 06:08:02 -0700 (PDT)
Date:   Tue, 26 May 2020 14:07:52 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>, will@kernel.org
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] ACPI/IORT: Remove the unused __get_pci_rid()
Message-ID: <20200526130752.GA23951@e121166-lin.cambridge.arm.com>
References: <20200509093430.1983-1-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509093430.1983-1-yuzenghui@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, May 09, 2020 at 05:34:30PM +0800, Zenghui Yu wrote:
> Since commit bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for
> IOMMUs"), __get_pci_rid() has become actually unused and can be removed.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/acpi/arm64/iort.c | 9 ---------
>  1 file changed, 9 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

If we miss v5.8 (which I think it is likely, even though this patch is
just removing dead code so it is safe at this stage) I will resend it
for v5.9 - not a problem.

Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 7d04424189df..ec94dbb60c7a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -789,15 +789,6 @@ void acpi_configure_pmsi_domain(struct device *dev)
>  		dev_set_msi_domain(dev, msi_domain);
>  }
>  
> -static int __maybe_unused __get_pci_rid(struct pci_dev *pdev, u16 alias,
> -					void *data)
> -{
> -	u32 *rid = data;
> -
> -	*rid = alias;
> -	return 0;
> -}
> -
>  #ifdef CONFIG_IOMMU_API
>  static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
>  {
> -- 
> 2.19.1
> 
