Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD919C297
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Apr 2020 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388587AbgDBNYr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Apr 2020 09:24:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37574 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387752AbgDBNYq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Apr 2020 09:24:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 161D3C4E1BD1255181A0;
        Thu,  2 Apr 2020 21:24:43 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 21:24:35 +0800
Subject: Re: [PATCH] ACPI: PPTT: Inform user that table offset used for
 Physical processor node ID
To:     John Garry <john.garry@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sudeep.holla@arm.com>, <jeremy.linton@arm.com>,
        <linuxarm@huawei.com>, <wanghuiqiang@huawei.com>
References: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <1fb8515d-a0ec-42bc-a9bc-4790dc3ee1c3@huawei.com>
Date:   Thu, 2 Apr 2020 21:24:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1585830145-208714-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/4/2 20:22, John Garry wrote:
> If the the Processor ID valid is not set for a Physical Processor Package
> node, then the node table offset is used as a substitute. As such, we
> may get info like this from sysfs:
> 
> root@(none)$ pwd
> /sys/devices/system/cpu/cpu0/topology
> root@(none)$ more physical_package_id
> 56
> 
> Inform the user of this in the bootlog, as it is much less than ideal, and
> they can remedy this in their FW.
> 
> This topic was originally discussed in:
> https://lore.kernel.org/linux-acpi/c325cfe2-7dbf-e341-7f0f-081b6545e890@huawei.com/T/#m0ec18637d8586f832084a8a6af22580e6174669a
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4ae93350b70d..b4ed3c818e00 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -515,6 +515,8 @@ static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
>  		if (level == 0 ||
>  		    cpu_node->flags & ACPI_PPTT_ACPI_PROCESSOR_ID_VALID)
>  			return cpu_node->acpi_processor_id;
> +		if (level == PPTT_ABORT_PACKAGE)
> +			pr_notice_once("Physical package node Processor ID valid not set, will use table offset as substitute\n");
>  		return ACPI_PTR_DIFF(cpu_node, table);
>  	}
>  	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",

Looks good to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

