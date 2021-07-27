Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA55E3D7143
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 10:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhG0Icz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 04:32:55 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12269 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbhG0Icy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2021 04:32:54 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GYqdt663Lz1CNvq;
        Tue, 27 Jul 2021 16:26:58 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 16:32:52 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 16:32:51 +0800
Subject: Re: [PATCH v6 0/9] ACPI/IORT: Support for IORT RMR node
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-acpi@vger.kernel.org>, <iommu@lists.linux-foundation.org>
CC:     <linuxarm@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <joro@8bytes.org>, <robin.murphy@arm.com>,
        <wanghuiqiang@huawei.com>, <steven.price@arm.com>,
        <Sami.Mujawar@arm.com>, <jon@solid-run.com>,
        <eric.auger@redhat.com>, <yangyicong@huawei.com>
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <fb7a2f1a-faf4-8d0c-bf1a-31cade789f12@huawei.com>
Date:   Tue, 27 Jul 2021 16:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/7/16 16:34, Shameer Kolothum wrote:
> Hi,
> 
> Major Changes from v5:
> - Addressed comments from Robin & Lorenzo.
>    : Moved iort_parse_rmr() to acpi_iort_init() from
>      iort_init_platform_devices().
>    : Removed use of struct iort_rmr_entry during the initial
>      parse. Using struct iommu_resv_region instead.
>    : Report RMR address alignment and overlap errors, but continue.
>    : Reworked arm_smmu_init_bypass_stes() (patch # 6).
> - Updated SMMUv2 bypass SMR code. Thanks to Jon N (patch #8).
> - Set IOMMU protection flags(IOMMU_CACHE, IOMMU_MMIO) based
>    on Type of RMR region. Suggested by Jon N.

I use the updated firmware from Huiqiang(Cced), tested on
my Kunpeng 920 server, the 3408iMRraid and 3416iMRraid can
work as expected with SMMUv3 enabled.

Tested-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Huiqiang Wang <wanghuiqiang@huawei.com>

Thanks
Hanjun
