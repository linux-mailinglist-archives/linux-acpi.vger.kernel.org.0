Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A648245B505
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Nov 2021 08:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhKXHOS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Nov 2021 02:14:18 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:27291 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbhKXHOS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Nov 2021 02:14:18 -0500
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HzXGy1GJ2zbj6f;
        Wed, 24 Nov 2021 15:11:06 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:11:08 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 24 Nov 2021 15:11:07 +0800
Subject: Re: [PATCH] acpi/tables: Add AEST in ACPI Table Definition
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211105041635.1481738-1-ishii.shuuichir@fujitsu.com>
 <a71761c6-5b8a-a4d5-c65a-7d3b3cd0d92f@huawei.com>
 <TYCPR01MB6160ABE0B422073A35F3A58EE9619@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9f2dfba4-4802-27d3-bc14-071f84a4824a@huawei.com>
Date:   Wed, 24 Nov 2021 15:11:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <TYCPR01MB6160ABE0B422073A35F3A58EE9619@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/11/24 8:52, ishii.shuuichir@fujitsu.com wrote:
> Hi, Hanjun.
> 
> Thanks for the comment.
> We apologize for the delay in replying due to my vacation.
> 
> We understood this to be a point in response to the description of the patch comment.
> What do you think of the following description?
> 
> When We added AEST using the Upgrading ACPI tables via initrd function,
> the kernel could not recognize the AEST,
> so added the AEST table to the list to enable the table upgrade function.

Looks good to me.

Thanks
Hanjun
