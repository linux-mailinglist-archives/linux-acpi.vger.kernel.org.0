Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4AEC1DDD0A
	for <lists+linux-acpi@lfdr.de>; Fri, 22 May 2020 04:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgEVCNo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 May 2020 22:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgEVCNo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2020 22:13:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67FC08C5C0
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2020 19:13:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y18so4445332pfl.9
        for <linux-acpi@vger.kernel.org>; Thu, 21 May 2020 19:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HANfjGaXtL4q1FSiLdXuotCYBYmAdZjgvWQJr0H9YMg=;
        b=lelQxwbz5KvLR8BmclI8jocAnat7kuQ1eoRzL4S3qO9Am83e3fverb4PWKqs6DEOyV
         NCdrcMPKKWM2WpSrCYZ8JIgZVhlby1jGUdTgnc5paxcSO+yOhjHZ0waaLltp5qtM79Ir
         7cVjPp9/qLsXl1tg2uYAOzrV72+cuggHGqg4L3wQxpNUiWn39K2jb05JVfUJ+E/EZ+ad
         tnxMBzEG/SPmbLbYrXFMbKdRrE9cidfG4wyUFnoPSK0Eyss0/H/7RVn/PUEBUQJcz/Ti
         /GBlephoJpBLfGqCBvjK2aMoFrvN0D/c7fg7WlMhF+ZE3/QFFcrN31nexgxv+NnNa+Mo
         Qptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HANfjGaXtL4q1FSiLdXuotCYBYmAdZjgvWQJr0H9YMg=;
        b=DyXxqmM52O3RnXQqeuTTQpZOXv0jdP8/CXU32UJfPwaxzKjrHQwGkLRJLluYR1ZPDW
         8y9ZrnXsR0yZ04acRuqAYsQ+vAeSVYxalK4yz/1Pewopdk8SMhwD4gMpI8MLzePVbvzw
         XME8AGzA1RdLY0mlCwGAuXbdN1yaoG4EEho6F0zwOQOFA6BxicnWLK/vyDVxnSY5To2F
         R4sg6NdoyCwAasuQY28I2V3dvc5MeGxqxRVRMZbhASKoyA/0lPByl5SKMpbFCurQgN4V
         53eHW1H8bhHd0ULL57cXiG//xoMXs5L6FPVtj6eQVFpFpShvovWtJ4ATC6JayaG68Fsd
         cvpw==
X-Gm-Message-State: AOAM531JTYF8hE7nJ1EyWoiOzzcCJm0YiPqZQ6lnHZDeJSsj/p/1f4t2
        +Owc4PtVqw8M+6j6ups3cjfwjw==
X-Google-Smtp-Source: ABdhPJxh64wrCE5tLGl7klLmD3mr5bD+4uqj8uhZIjERdP/SqzgqKR0fB/XxlGgIJJR01XokaX+kyA==
X-Received: by 2002:a63:c58:: with SMTP id 24mr11923950pgm.246.1590113623304;
        Thu, 21 May 2020 19:13:43 -0700 (PDT)
Received: from [10.191.1.102] ([45.135.186.71])
        by smtp.gmail.com with ESMTPSA id y5sm5043843pge.50.2020.05.21.19.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 19:13:42 -0700 (PDT)
Subject: Re: [PATCH 0/2] Let pci_fixup_final access iommu_fwnode
To:     Joerg Roedel <joro@8bytes.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <631857df-8e70-88e3-9959-1a750faf4f85@linaro.org>
Date:   Fri, 22 May 2020 10:13:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589256511-12446-1-git-send-email-zhangfei.gao@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi, Joerg

On 2020/5/12 下午12:08, Zhangfei Gao wrote:
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
>   
>
> Zhangfei Gao (2):
>    iommu/of: Let pci_fixup_final access iommu_fwnode
>    ACPI/IORT: Let pci_fixup_final access iommu_fwnode
>
>   drivers/acpi/arm64/iort.c | 1 +
>   drivers/iommu/of_iommu.c  | 1 +
>   2 files changed, 2 insertions(+)
>
Would you mind give any suggestion?

We need access fwspec->can_stall describing the platform device (a fake 
pcie) can support stall feature.
can_stall will be used arm_smmu_add_device [1].
And stall is not a pci feature, so no such member in struct pci_dev.

iommu_fwnode is allocated in iommu_fwspec_init, from of_pci_iommu_init 
or iort_pci_iommu_init.
The pci_fixup_device(pci_fixup_final, dev) in pci_bus_add_device is too 
early that  iommu_fwnode
is not allocated.
The pci_fixup_device(pci_fixup_enable, dev) in do_pci_enable_device is 
too late after

arm_smmu_add_device.


So the idea here is calling pci_fixup_device(pci_fixup_final) after
of_pci_iommu_init and iort_pci_iommu_init, where iommu_fwnode is allocated.



[1] https://www.spinics.net/lists/linux-pci/msg94559.html

Thanks

