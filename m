Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765CE1E57EE
	for <lists+linux-acpi@lfdr.de>; Thu, 28 May 2020 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgE1Gxf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 May 2020 02:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1Gxe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 May 2020 02:53:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C8BC05BD1E
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 23:53:34 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so2593205pju.3
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 23:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=zbKuT3nrBchNOXLtoqggayeJJOXuYIPFyuAneEl5VZE=;
        b=WeIYDG9i+HPcpC+T7wLyd72laBytTR0RvEwehEj45sRWw4OKQzXYNNFynXnVehee4d
         Xz6/jjgw409iODdX8f+4nfB4ksOmJlLeRUjPatyd73dc4YdD/O6i/XN42ATrsS/CHqC2
         Hj1KqTS/6K1rdwTjZSmW73Clu5pi1g+wvul9mqCnXjpkHb3po6GXlCny3fXX4LNkVWWh
         +Rf0+FfG/tiIkuRFgH2XUOnYBAJUB98HYAgq5RhcSvah+qLAhflgOXk0g/sakA7NLXbh
         qEjIntovK2YBpTUr74m+FL9V9Iy1pdy/deZKUseiSeBwZTjQlJikyz4UUCdSr+OwEHgX
         9Dug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=zbKuT3nrBchNOXLtoqggayeJJOXuYIPFyuAneEl5VZE=;
        b=D0mtYEx21H/6ouzc+x+JU6Cw08Y44LSex9gSuOs2m4DCH2v5Hpqnori4FFmfcFy4FR
         e8ouj4RSI987SLxK1ToJXE2Arx2sZOVn3VfoojM3evo6ASEa4t8qKWxvaVIWTk+PTSLM
         XJ+SFfwXnYN6trJ4OwM2mksER9LBEy7zGkNdCHJncP4hX1WpEqXbrTFxSJuiYAsKmxZz
         VlWp28Lmg68n8yMW5L5ELysWBBc6un3MPkEthUo8WfMVFaVyq4A5mPtmap1MgnVB3NRO
         kFnAZW8dKyA0zwRm65BJS1mDP6ich1D9RvlhlK7/Qg08F0ecjYWySkX5sNhgMpwni3ww
         3JYw==
X-Gm-Message-State: AOAM530UnQ7SeZFGds9mljdgh+NVW7U905/vyALirjZ6MLCQofTb9OW0
        QlLdDdrO0JQMy6ZV/pwH4ZlVzw==
X-Google-Smtp-Source: ABdhPJzZUXUIWStr7BtNwklBZN744dC8lv7AAZWH3qxAABW36QOxKh3qydTDu9mclcxQ1QgO9lDG4g==
X-Received: by 2002:a17:90a:d317:: with SMTP id p23mr2285917pju.107.1590648813784;
        Wed, 27 May 2020 23:53:33 -0700 (PDT)
Received: from [10.140.6.42] ([45.135.186.12])
        by smtp.gmail.com with ESMTPSA id g18sm3799582pfq.146.2020.05.27.23.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2020 23:53:33 -0700 (PDT)
Subject: Re: [PATCH 2/2] iommu: calling pci_fixup_iommu in iommu_fwspec_init
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        jean-philippe <jean-philippe@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
References: <1590493749-13823-1-git-send-email-zhangfei.gao@linaro.org>
 <1590493749-13823-3-git-send-email-zhangfei.gao@linaro.org>
 <20200527090115.GB179718@kroah.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <e8293663-7fb8-ee57-0b9f-b3057b8aae7d@linaro.org>
Date:   Thu, 28 May 2020 14:53:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200527090115.GB179718@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2020/5/27 下午5:01, Greg Kroah-Hartman wrote:
> On Tue, May 26, 2020 at 07:49:09PM +0800, Zhangfei Gao wrote:
>> Calling pci_fixup_iommu in iommu_fwspec_init, which alloc
>> iommu_fwnode. Some platform devices appear as PCI but are
>> actually on the AMBA bus, and they need fixup in
>> drivers/pci/quirks.c handling iommu_fwnode.
>> So calling pci_fixup_iommu after iommu_fwnode is allocated.
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/iommu/iommu.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 7b37542..fb84c42 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -2418,6 +2418,10 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>>   	fwspec->iommu_fwnode = iommu_fwnode;
>>   	fwspec->ops = ops;
>>   	dev_iommu_fwspec_set(dev, fwspec);
>> +
>> +	if (dev_is_pci(dev))
>> +		pci_fixup_device(pci_fixup_iommu, to_pci_dev(dev));
> Why can't the caller do this as it "knows" it is a PCI device at that
> point in time, right?
Putting fixup here is because
1. iommu_fwspec has been allocated
2. iommu_fwspec_init will be called by of_pci_iommu_init and 
iort_pci_iommu_init, covering both acpi and dt

Thanks
