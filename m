Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69282481BD
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Aug 2020 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRJRD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 18 Aug 2020 05:17:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgHRJRD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 18 Aug 2020 05:17:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B5F6BE8540D178E13F7;
        Tue, 18 Aug 2020 17:17:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 17:16:49 +0800
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
To:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200818063625.980-1-yuzenghui@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <12667629-5c3f-4606-ec27-72e5ef19f35a@huawei.com>
Date:   Tue, 18 Aug 2020 17:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200818063625.980-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/8/18 14:36, Zenghui Yu wrote:
> * From v1 [1]:
>    - As pointed out by Hanjun, remove two now unused inline functions.
>      Compile tested with CONFIG_IOMMU_API is not selected.
> 
> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
> 
> Zenghui Yu (2):
>    ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>    ACPI/IORT: Remove the unused inline functions
> 
>   drivers/acpi/arm64/iort.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

Nice cleanup.

Acked-by: Hanjun Guo <guohanjun@huawei.com>

