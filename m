Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25228633D28
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Nov 2022 14:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiKVNKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Nov 2022 08:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKVNKr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Nov 2022 08:10:47 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958D1403D
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 05:10:46 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGl3r56lZzRpPc
        for <linux-acpi@vger.kernel.org>; Tue, 22 Nov 2022 21:10:16 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:10:45 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:10:45 +0800
Subject: Re: [PATCH v2] PNP: fix name memory leak in pnp_alloc_dev()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-acpi@vger.kernel.org>
CC:     <rafael.j.wysocki@intel.com>
References: <20221111012358.661210-1-yangyingliang@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <7cfb5d2e-e802-7210-f18d-e4f861d28f1d@huawei.com>
Date:   Tue, 22 Nov 2022 21:10:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20221111012358.661210-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022/11/11 9:23, Yang Yingliang wrote:
> After commit 1fa5ae857bb1 ("driver core: get rid of struct device's
> bus_id string array"), the name of device is allocated dynamically,
> move dev_set_name() after pnp_add_id() to avoid memory leak.
> 
> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v1 -> v2:
>    Move dev_set_name() after pnp_add_id().
> ---
>   drivers/pnp/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index 4df5aa6a309c..6a60c5d83383 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -148,14 +148,14 @@ struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *protocol, int id,
>   	dev->dev.coherent_dma_mask = dev->dma_mask;
>   	dev->dev.release = &pnp_release_device;
>   
> -	dev_set_name(&dev->dev, "%02x:%02x", dev->protocol->number, dev->number);
> -
>   	dev_id = pnp_add_id(dev, pnpid);
>   	if (!dev_id) {
>   		kfree(dev);
>   		return NULL;
>   	}
>   
> +	dev_set_name(&dev->dev, "%02x:%02x", dev->protocol->number, dev->number);

Lots of places in the kernel didn't check the return value of
dev_set_name(), so it looks good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
