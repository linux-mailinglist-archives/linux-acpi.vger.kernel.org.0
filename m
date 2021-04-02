Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DA35253D
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Apr 2021 03:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbhDBBpP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Apr 2021 21:45:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15587 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBBpP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Apr 2021 21:45:15 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FBN9P0psmz1BFlH;
        Fri,  2 Apr 2021 09:43:05 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 2 Apr 2021
 09:45:02 +0800
Subject: Re: [PATCH v14 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
 <20210401154718.307519-11-jean-philippe@linaro.org>
 <20210401171101.GB9447@willie-the-truck>
CC:     <devicetree@vger.kernel.org>, <kevin.tian@intel.com>,
        <linux-acpi@vger.kernel.org>, <joro@8bytes.org>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>,
        <vivek.gautam@arm.com>, <iommu@lists.linux-foundation.org>,
        <robh+dt@kernel.org>, <linux-accelerators@lists.ozlabs.org>,
        <guohanjun@huawei.com>, <zhangfei.gao@linaro.org>,
        <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <lenb@kernel.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <8e55e807-69f2-6492-e4a0-0dd9250142bc@hisilicon.com>
Date:   Fri, 2 Apr 2021 09:45:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210401171101.GB9447@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/4/2 1:11, Will Deacon wrote:
> On Thu, Apr 01, 2021 at 05:47:19PM +0200, Jean-Philippe Brucker wrote:
>> The SMMU provides a Stall model for handling page faults in platform
>> devices. It is similar to PCIe PRI, but doesn't require devices to have
>> their own translation cache. Instead, faulting transactions are parked
>> and the OS is given a chance to fix the page tables and retry the
>> transaction.
>>
>> Enable stall for devices that support it (opt-in by firmware). When an
>> event corresponds to a translation error, call the IOMMU fault handler.
>> If the fault is recoverable, it will call us back to terminate or
>> continue the stall.
> 
> Which hardware is this useful for? Stalling adds a fair amount of complexity
> to the driver, so I don't think we should support it unless we're likely to
> see platforms that both implement it and do something useful with it.

Hi Will，

HiSilicon Kunpeng920's ZIP/SEC/HPRE engines(drivers/crypto/hisilicon/) are using
stall mode.

UACCE driver(drivers/misc/uacce/) is used to export these engines to user space.
A user space library: https://github.com/Linaro/uadk offers APIs to help users
to use these engines.

In fact, we only need a quirk(https://lkml.org/lkml/2021/3/8/1506) based on this
IOPF series to make whole solution mainline ready. So please also take this
patch, we need it! :)

Best,
Zhou

> 
> Will
> 
> .
> 

