Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2621E2F0B70
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 04:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbhAKD11 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Jan 2021 22:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAKD11 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Jan 2021 22:27:27 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66595C061794
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jan 2021 19:26:47 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id m6so10138473pfm.6
        for <linux-acpi@vger.kernel.org>; Sun, 10 Jan 2021 19:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=o9DALHvMQ7c2790djtAoPkJytPERuXhfZ232KOAAAOo=;
        b=wS/W+UnxVXhtEtWCp9hr4E7rdFinMJMVBUxIeqn6319u9CPuDsvrdEFso4k7Hn11BC
         O7iKqsN3vEtb1Dkg2WQPmvSDzd+3W7d6S9zdcW46WjBxoqBt6Komi3wBa6uTRasulBHj
         c0ocjnhCqSgKcWT1blJwB1KsygFirTjmFamI5bkOa2viA9QWzpKG7Sz1ZILKufnuUyj7
         czXzKMaiSYk5Z78KheBj8vzPeYScx3XeTD5u4EJypar9GnQBOfSgqnxCTa3uai2uwjU5
         kC//20+eEdynRg+i9nig1GCU2O4ERndCDu+LZO3jFbopuF1fLrcg4TudwbWaKZpNa/ui
         z5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=o9DALHvMQ7c2790djtAoPkJytPERuXhfZ232KOAAAOo=;
        b=r9c12jZY0W+ZYsuSHNoMaid96hw3XzYihHkJusPJYG4XfTEIu9hWgC0Nz+IUOAab0c
         aJcBOewXH+XlfXi44xRRvTxL0pN5VzrJGGXcXC2x+sObyZ8T7qAoN/RWYOlpN10bAV2m
         2RDfg7NQhtLsl7Ganxm/MVCZqJ+fB0mfFQOPnkKJEnZEjNvpiap9JMfBohpJfnN7doCd
         r0y68ff2aYqAK3RbrgEB7oaSDyiIO3Msbz7F9/OzxvH65UJ5ezoyWdj98kxcddfj6JfF
         e7MEOX7os+/PoKRDbdchW8cY5k28DHoQBdsc35OiOU6IB8cZFSHdDIsq4cs14/pwpyQX
         KY9w==
X-Gm-Message-State: AOAM5315GSuvbUjc8sE02ecluh7yo5Om4yxVj8+MFioOycxom0YUnGP9
        tYWyx51Ip6ZCbDImfdnKFiwzxQ==
X-Google-Smtp-Source: ABdhPJzMm9ldMWkb2gXaK2PvamOC4omCPlaTwP8b9QNckusDWoe8R0otcwdwNmYcLOd55GXQrSrVhA==
X-Received: by 2002:a62:2b47:0:b029:19e:2c4b:6a8e with SMTP id r68-20020a622b470000b029019e2c4b6a8emr2085238pfr.30.1610335606890;
        Sun, 10 Jan 2021 19:26:46 -0800 (PST)
Received: from ?IPv6:240e:362:4bf:e00:57d:5da4:e49:50d? ([240e:362:4bf:e00:57d:5da4:e49:50d])
        by smtp.gmail.com with ESMTPSA id o123sm17495916pfd.197.2021.01.10.19.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Jan 2021 19:26:46 -0800 (PST)
Subject: Re: [PATCH v9 00/10] iommu: I/O page faults for SMMUv3
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
Cc:     lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        vdumpa@nvidia.com, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <d8e4c6f7-f194-3374-b6d6-6ea3006b57f5@linaro.org>
Date:   Mon, 11 Jan 2021 11:26:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2021/1/8 下午10:52, Jean-Philippe Brucker wrote:
> Add stall support to the SMMUv3, along with a common I/O Page Fault
> handler.
>
> Changes since v8 [1]:
> * Added patches 1 and 2 which aren't strictly related to IOPF but need to
>    be applied in order - 8 depends on 2 which depends on 1. Patch 2 moves
>    pasid-num-bits to a device property, following Robin's comment on v8.
> * Patches 3-5 extract the IOPF feature from the SVA one, to support SVA
>    implementations that handle I/O page faults through the device driver
>    rather than the IOMMU driver [2]
> * Use device properties for dma-can-stall, instead of a special fwspec
>    member.
> * Dropped PRI support for now, since it doesn't seem to be available in
>    hardware and adds some complexity.
> * Had to drop some Acks and Tested tags unfortunately, due to code
>    changes.
>
> As usual, you can get the latest SVA patches from
> http://jpbrucker.net/git/linux sva/current
>
> [1] https://lore.kernel.org/linux-iommu/20201112125519.3987595-1-jean-philippe@linaro.org/
> [2] https://lore.kernel.org/linux-iommu/BY5PR12MB3764F5D07E8EC48327E39C86B3C60@BY5PR12MB3764.namprd12.prod.outlook.com/
>
> Jean-Philippe Brucker (10):
>    iommu: Remove obsolete comment
>    iommu/arm-smmu-v3: Use device properties for pasid-num-bits
>    iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
>    iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
>    uacce: Enable IOMMU_DEV_FEAT_IOPF
>    iommu: Add a page fault handler
>    iommu/arm-smmu-v3: Maintain a SID->device structure
>    dt-bindings: document stall property for IOMMU masters
>    ACPI/IORT: Enable stall support for platform devices
>    iommu/arm-smmu-v3: Add stall support for platform devices

Thanks Jean
I have tested on Hisilicon Kunpeng920 board.

  Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
