Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4004945FC41
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Nov 2021 04:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhK0DGq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 22:06:46 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31913 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238261AbhK0DEq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 22:04:46 -0500
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J1GbW0kCXzcbV2;
        Sat, 27 Nov 2021 11:01:27 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 11:01:30 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 11:01:30 +0800
Subject: Re: [PATCH v2] acpi/tables: Add AEST in ACPI Table Definition
To:     Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>,
        <rafael@kernel.org>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lorenzo.pieralisi@arm.com>, <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>
References: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <ae3dc745-13b0-7f9c-4929-527de4b92d97@huawei.com>
Date:   Sat, 27 Nov 2021 11:01:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/11/25 16:32, Shuuichirou Ishii wrote:
> When We added AEST using the Upgrading ACPI tables via initrd function,
> the kernel could not recognize the AEST, so added the AEST table to
> the list to enable the table upgrade function.
> 
> Change log:
> v2 : The reason for committing in the commit log was not clear,
>       so it was pointed out and corrected.

Please remove the change log in the commit message.

> 
> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> ---

You can put the change log here then it will be removed
when applying this patch.

Thanks
Hanjun
