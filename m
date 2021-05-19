Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D358388949
	for <lists+linux-acpi@lfdr.de>; Wed, 19 May 2021 10:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244633AbhESIXM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 May 2021 04:23:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3038 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbhESIXL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2021 04:23:11 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FlQlB6DTzzmXG3;
        Wed, 19 May 2021 16:19:34 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 16:21:50 +0800
Received: from [10.47.24.60] (10.47.24.60) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Wed, 19 May
 2021 09:21:48 +0100
Subject: Re: [bug report] Memory leak from acpi_ev_install_space_handler()
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        chenxiang <chenxiang66@hisilicon.com>
References: <845f6ef8-d2a7-e491-8405-9526e4ba277a@huawei.com>
 <CAJZ5v0gRm+jsd1KtLtSgT=4pc9oab=EtW=zqBuKjHLJ=ZcUkiA@mail.gmail.com>
 <752f16ed-29e3-840e-dc53-6fed24d73861@huawei.com>
 <MWHPR11MB1599342DCB12AEA5B7DD0D54F02C9@MWHPR11MB1599.namprd11.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3ab18796-f8b5-9498-a31a-5dfd21059ebb@huawei.com>
Date:   Wed, 19 May 2021 09:20:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <MWHPR11MB1599342DCB12AEA5B7DD0D54F02C9@MWHPR11MB1599.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.24.60]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 18/05/2021 22:48, Kaneda, Erik wrote:
> Hi John,
> 
>> I don't mind looking further if requested.
> Someone else reported this as well. 

I noticed. By chance, it was my close colleague Xiang Chen.

Could you try the patch below? I think it might help fix this issue..

It looks like the same problem, and you provided the same solution, so 
we can look to test it.

Thanks

> 
> Thanks,
> Erik
> 
> diff --git a/drivers/acpi/acpica/utdelete.c b/drivers/acpi/acpica/utdelete.c
> index 624a26794d55..e5ba9795ec69 100644
> --- a/drivers/acpi/acpica/utdelete.c
> +++ b/drivers/acpi/acpica/utdelete.c
> @@ -285,6 +285,14 @@ static void acpi_ut_delete_internal_obj(union acpi_operand_object *object)
>                  }
>                  break;
> 
> +       case ACPI_TYPE_LOCAL_ADDRESS_HANDLER:
> +
> +               ACPI_DEBUG_PRINT((ACPI_DB_ALLOCATIONS,
> +                                 "***** Address handler %p\n", object));
> +
> +               acpi_os_delete_mutex(object->address_space.context_mutex);
> +               break;
> +
>          default:
> 
>                  break;
> 

