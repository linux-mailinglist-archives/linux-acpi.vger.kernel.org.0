Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA5686B5E
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Feb 2023 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjBAQP7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Feb 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbjBAQPy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Feb 2023 11:15:54 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08EBA76412
        for <linux-acpi@vger.kernel.org>; Wed,  1 Feb 2023 08:15:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADCB24B3;
        Wed,  1 Feb 2023 08:16:29 -0800 (PST)
Received: from [10.57.90.200] (unknown [10.57.90.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35CFD3F64C;
        Wed,  1 Feb 2023 08:15:46 -0800 (PST)
Message-ID: <f51ea97a-2eaa-e13d-ef3d-74586cf3d847@arm.com>
Date:   Wed, 1 Feb 2023 16:15:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ACPI/IORT: Increase allocation size up to sizeof(struct
 acpi_iort_node)
Content-Language: en-GB
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lvc-project@linuxtesting.org
References: <20230201021213.GC446@altlinux.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230201021213.GC446@altlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2023-02-01 02:12, Alexey V. Vissarionov wrote:
> The node is a pointer to struct acpi_iort_node, so it's just 4 or 8
> bytes, while the structure itself is several times bigger.

That is indeed true. Something that is also true is that "&node" is of 
type "struct acpi_iort_node **", and is a pointer to a pointer object. 
One of these facts is more relevant to this code than the other.

> Found by ALT Linux Team (altlinux.org) and Linux Verification Center
> (linuxtesting.org) using SVACE.

If your tool really thinks we should be copying 17 bytes out of an 
8-byte object, please fix it before "verifying" any more code.

Thanks,
Robin.

> Signed-off-by: Alexey V. Vissarionov <gremlin@altlinux.org>
> Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
> 
> ---
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 38fb84974f352cc8..edb94b52bf3a21ce 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1832,7 +1832,8 @@ static int __init iort_add_platform_device(struct acpi_iort_node *node,
>   	if (ops->dev_add_platdata)
>   		ret = ops->dev_add_platdata(pdev);
>   	else
> -		ret = platform_device_add_data(pdev, &node, sizeof(node));
> +		ret = platform_device_add_data(pdev, &node,
> +						sizeof(struct acpi_iort_node));
>   
>   	if (ret)
>   		goto dev_put;
> 
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
