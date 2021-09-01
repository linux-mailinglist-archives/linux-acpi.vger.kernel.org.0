Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F993FD517
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Sep 2021 10:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243097AbhIAIQO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 04:16:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14446 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243098AbhIAIQL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2021 04:16:11 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GzxbB0PPNzbgJT;
        Wed,  1 Sep 2021 16:11:18 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 16:15:12 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 1 Sep 2021 16:15:12 +0800
Subject: Re: [PATCH] ACPI / PPTT: get PPTT table in the first beginning
To:     Zenghui Yu <yuzenghui@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>,
        <viresh.kumar@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
References: <20210720112635.38565-1-wangxiongfeng2@huawei.com>
 <20210720133751.u6k6bdm7qco3gn65@bogus>
 <a1390a6f-62aa-4cfd-b34e-1dbf0aedfc50@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <30c0b347-54fa-4113-d533-74b101b90f46@huawei.com>
Date:   Wed, 1 Sep 2021 16:15:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a1390a6f-62aa-4cfd-b34e-1dbf0aedfc50@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/9/1 15:29, Zenghui Yu wrote:
> On 2021/7/20 21:37, Sudeep Holla wrote:
>> On Tue, Jul 20, 2021 at 07:26:35PM +0800, Xiongfeng Wang wrote:
>>> When I added might_sleep() in down_timeout(), I got the following
>>
>> Sorry it is not clear if you are able to reproduce this issue without
>> any other modifications in the mainline kernel ?
> 
> Jump in this thread as the exact splat is triggered at boot time
> in the latest mainline kernel thanks to commit 99409b935c9a
> ("locking/semaphore: Add might_sleep() to down_*() family").

Please see the patch provided by Thomas Gleixner, it should
fix this issue in a better way:

https://lkml.org/lkml/2021/8/31/352

Thanks
Hanjun
