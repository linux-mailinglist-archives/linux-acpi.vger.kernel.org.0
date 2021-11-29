Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44DE6460BFC
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Nov 2021 02:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376638AbhK2BGr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 28 Nov 2021 20:06:47 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14990 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbhK2BEr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 28 Nov 2021 20:04:47 -0500
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J2Rn61lxYzVfsf;
        Mon, 29 Nov 2021 08:58:50 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 09:01:28 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 09:01:28 +0800
Subject: Re: [PATCH v2] acpi/tables: Add AEST in ACPI Table Definition
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211125083240.123131-1-ishii.shuuichir@fujitsu.com>
 <ae3dc745-13b0-7f9c-4929-527de4b92d97@huawei.com>
 <TYCPR01MB6160526A9B559655FAEE2DEFE9659@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <25725e77-d6ba-aa33-6a1e-075f57e1b309@huawei.com>
Date:   Mon, 29 Nov 2021 09:01:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <TYCPR01MB6160526A9B559655FAEE2DEFE9659@TYCPR01MB6160.jpnprd01.prod.outlook.com>
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

On 2021/11/29 7:54, ishii.shuuichir@fujitsu.com wrote:
> Hi, Hanjun.
> 
> Thank you for your comment.
> We apologize for the basic mistake.
> 
> We will try to fix it as follows, is it OK?
> 
> ---
> Subject: [PATCH v3] acpi/tables: Add AEST in ACPI Table Definition
> 
> When We added AEST using the Upgrading ACPI tables via initrd function,
> the kernel could not recognize the AEST, so added the AEST table to
> the list to enable the table upgrade function.
> 
> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
> ---
> v3 : Changed the location of the change log so that it does not
>       disappear when the patch is applied.
> 
> v2 : The reason for committing in the commit log was not clear,
>       so it was pointed out and corrected.

Looks good to me.

Thanks
Hanjun
