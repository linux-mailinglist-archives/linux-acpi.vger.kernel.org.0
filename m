Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202BA2B3B30
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 02:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgKPBkT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 15 Nov 2020 20:40:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7629 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgKPBkT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2020 20:40:19 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CZBb704ynz15KkL;
        Mon, 16 Nov 2020 09:40:03 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 16 Nov 2020 09:40:05 +0800
Subject: Re: [PATCH] ACPI: TAD: Fix reference imbalance in acpi_tad_probe
To:     Zhang Qilong <zhangqilong3@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>
References: <20201114111834.3466695-1-zhangqilong3@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <5b9e0aac-eed1-e372-19c8-46c70ce9493c@huawei.com>
Date:   Mon, 16 Nov 2020 09:40:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201114111834.3466695-1-zhangqilong3@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/11/14 19:18, Zhang Qilong wrote:
> It have enabled runtime and suspend the device before going
> to fail branch. We should call pm_runtime_resume to keep the
> usage counter balanced and pm_runtime_disable to keep disable
> depth balanced sequentially.
> 
> Fixes: 95c513ec84f7f ("ACPI: Add Time and Alarm Device (TAD) driver")
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
> ---
>   drivers/acpi/acpi_tad.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_tad.c b/drivers/acpi/acpi_tad.c
> index 7d45cce0c3c1..87ab606a0df8 100644
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -652,6 +652,8 @@ static int acpi_tad_probe(struct platform_device *pdev)
>   	return 0;
>   
>   fail:
> +	pm_runtime_resume(dev);
> +	pm_runtime_disable(dev);
>   	acpi_tad_remove(pdev);

acpi_tad_remove() did that job, so it's duplicate and wrong to add those
two function call I think.

Thanks
Hanjun
