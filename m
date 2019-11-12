Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87A24F8C62
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2019 11:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbfKLKCd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Nov 2019 05:02:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51763 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfKLKCd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Nov 2019 05:02:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id q70so2410884wme.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2019 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZV0/xI1cDNWDAAg48JcA6ok2jrNXH3VpcMDZqiMr7I0=;
        b=oVIDt4YtXTKXNM9krSx7RMkK8r+fjJ35bJ8lpRBRuYXC410u/er0oxn8R73DvegE97
         eSSvdbU5bMDRSD5zu58Reg5Iyi2uOh4GMZ/gzsx/atLCDjtSfi/4+xaaplQ4iX9h+Fzi
         5sHfscuNeDiG+pZUgrx05j3rugfj23QMzhNgcwY+FjyxqoXzye3c9AAiUsZXxBFU3yXS
         9YT57qpqCIcdrMNP1on1kK481clziXxRXujGjtt5YdJroPVhO+746HlezpHoatBeNFIQ
         7LKqJ+bOxki1Ow8W5F+unwBVD9Wmi9Rh1g2sey4IWFR1W7LUlWof8eKD2YIjSGJShXlZ
         WFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZV0/xI1cDNWDAAg48JcA6ok2jrNXH3VpcMDZqiMr7I0=;
        b=nrfqQ/0MlDZp4rTll8Yb1OnHeAO6Ffm/BTuklGV8Qs3jS1MyRiPZe9SM/2Zr3B4atZ
         1+pLZ6IrW7OUskqV/uj6YoVzNUWLUdhBC+4imsxQP6ZsnJqhUOQ9YutYYA0E4VKvIF7t
         Jr0EhYhTym6SjSWdWI+3jVd0ehiNayN113qpXTN1IWzzUdb1HlpvdVzo3ot0sYG7RH7B
         DcnuWntMlXc9MUzc9elpBAcv17j+lDTY+FFKwGTiRd7DKxZHeWQdiDD0c7RqN7aSh9ZN
         GIftEbkLy4lK20EFrpio0QrgCACRZwsi5+cLvMBbO4t8rziBoRX00ofoy2KzvskL+tUp
         TgAg==
X-Gm-Message-State: APjAAAXTEJGOE6GHNxUDoeTpaNPApA6tml6e1CQndE+cXH0wUzscPZIO
        B3veCAZBBrY67pX++UbrCQOm0w==
X-Google-Smtp-Source: APXvYqzLCvkm7qvFyXa0u7U5lfFZDS5G4zvBKLQqPGTW83KJwLuQTVwDbiqILJp0uaQwb4ST+KcByA==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr3232608wmh.138.1573552951206;
        Tue, 12 Nov 2019 02:02:31 -0800 (PST)
Received: from [10.57.1.46] ([45.135.186.94])
        by smtp.gmail.com with ESMTPSA id w81sm4138966wmg.5.2019.11.12.02.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 02:02:30 -0800 (PST)
Subject: Re: [PATCH v2 0/8] iommu: Add PASID support to Arm SMMUv3
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org,
        will@kernel.org, robin.murphy@arm.com, zhangfei.gao@linaro.org,
        eric.auger@redhat.com, jonathan.cameron@huawei.com
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
From:   zhangfei <zhangfei.gao@linaro.org>
Message-ID: <8a23f064-129a-02c3-4e14-63db45d7f851@linaro.org>
Date:   Tue, 12 Nov 2019 18:02:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108152508.4039168-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/11/8 下午11:25, Jean-Philippe Brucker wrote:
> This is version 2 of the series I sent a while ago [1], adding PASID
> support to the Arm SMMUv3 driver.
>
> Changes since v1:
> * Dropped the patch adding auxiliary domain support. It's an easy way to
>    test PASID, by populating PASID contexts using iommu_map/unmap(), but
>    I don't know if it will ever have real users.
>
>    Since v1 I changed my testing gear, and am using the zip accelerator
>    [2] instead of a software model. It only uses SVA and testing
>    auxiliary domains would require additional changes that would never go
>    upstream. SVA requires another 20 patches (including I/O page faults)
>    that I will send later, but at least I know that this will get used.
>
> * ioasid patch has been carried by Jacob and should be merged for v5.5 [3]
>
> * Split patch "Add support for Substream IDs" into patches 4 and 5.
>
> * Added IORT support (patch 3) and addressed other comments.
>
> [1] https://lore.kernel.org/linux-iommu/20190610184714.6786-1-jean-philippe.brucker@arm.com/
> [2] https://lore.kernel.org/linux-iommu/1572331216-9503-1-git-send-email-zhangfei.gao@linaro.org/
> [3] https://lore.kernel.org/linux-iommu/1570045363-24856-1-git-send-email-jacob.jun.pan@linux.intel.com/
>
> Jean-Philippe Brucker (8):
>    dt-bindings: document PASID property for IOMMU masters
>    iommu/arm-smmu-v3: Support platform SSID
>    ACPI/IORT: Support PASID for platform devices
>    iommu/arm-smmu-v3: Prepare for SSID support
>    iommu/arm-smmu-v3: Add support for Substream IDs
>    iommu/arm-smmu-v3: Add second level of context descriptor table
>    iommu/arm-smmu-v3: Improve add_device() error handling
>    iommu/arm-smmu-v3: Add support for PCI PASID
Thanks Jean for the patch
The series tested well on Hisilicon platform KunPeng920
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>


