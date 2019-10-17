Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7289CDA7A3
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2019 10:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390610AbfJQInm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Oct 2019 04:43:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4237 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389616AbfJQInm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Oct 2019 04:43:42 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C12EFBB53CE048EF0C1F;
        Thu, 17 Oct 2019 16:43:39 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 16:43:33 +0800
Subject: Re: [PATCH] ACPI: fix the warning assignment of 0/1 to bool variable
To:     Tian Tao <tiantao6@huawei.com>, <jonathan.cameron@huawei.com>,
        <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>
References: <1571300793-41282-1-git-send-email-tiantao6@huawei.com>
CC:     <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <18e362dd-680c-ebd3-39e2-da0e3eaab61f@huawei.com>
Date:   Thu, 17 Oct 2019 09:43:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1571300793-41282-1-git-send-email-tiantao6@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 17/10/2019 09:26, Tian Tao wrote:
> It fixes the warning as follows reported by coccicheck:
> drivers/acpi/cppc_acpi.c:908:4-45: WARNING: Assignment of 0/1
> to bool variable.
>

Tian Tao,

Please check this:
https://lore.kernel.org/linux-acpi/1571148451-91114-1-git-send-email-john.garry@huawei.com/T/#u

John

> Signed-off-by: Tian Tao <tiantao6@huawei.com>
> ---
>  drivers/acpi/cppc_acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 3b25259..3afbd1e 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -905,7 +905,7 @@ void acpi_cppc_processor_exit(struct acpi_processor *pr)
>  			pcc_data[pcc_ss_id]->refcount--;
>  			if (!pcc_data[pcc_ss_id]->refcount) {
>  				pcc_mbox_free_channel(pcc_data[pcc_ss_id]->pcc_channel);
> -				pcc_data[pcc_ss_id]->pcc_channel_acquired = 0;
> +				pcc_data[pcc_ss_id]->pcc_channel_acquired = false;
   				kfree(pcc_data[pcc_ss_id]);
>  			}
>  		}
>


