Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA61E0FB0
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390794AbgEYNnX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 09:43:23 -0400
Received: from 8bytes.org ([81.169.241.247]:44546 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388794AbgEYNnV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 09:43:21 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 9FEF7327; Mon, 25 May 2020 15:43:19 +0200 (CEST)
Date:   Mon, 25 May 2020 15:43:18 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] Let pci_fixup_final access iommu_fwnode
Message-ID: <20200525134318.GB5221@8bytes.org>
References: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 12, 2020 at 12:08:29PM +0800, Zhangfei Gao wrote:
> Some platform devices appear as PCI but are
> actually on the AMBA bus, and they need fixup in
> drivers/pci/quirks.c handling iommu_fwnode.
> So calling pci_fixup_final after iommu_fwnode is allocated.
> 
> For example: 
> Hisilicon platform device need fixup in 
> drivers/pci/quirks.c
> 
> +static void quirk_huawei_pcie_sva(struct pci_dev *pdev)
> +{
> +	struct iommu_fwspec *fwspec;
> +
> +	pdev->eetlp_prefix_path = 1;
> +	fwspec = dev_iommu_fwspec_get(&pdev->dev);
> +	if (fwspec)
> +		fwspec->can_stall = 1;
> +}
> +
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa250, quirk_huawei_pcie_sva);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_HUAWEI, 0xa251, quirk_huawei_pcie_sva);

I don't think it is a great idea to hook this into PCI_FIXUP_FINAL. The
fixup list needs to be processed for every device, which will slow down
probing.

So either we introduce something like PCI_FIXUP_IOMMU, if this is
entirely PCI specific. If it needs to be generic we need some fixup
infrastructure in the IOMMU code itself.

Regards,

	Joerg
