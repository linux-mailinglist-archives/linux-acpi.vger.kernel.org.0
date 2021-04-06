Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B17355997
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Apr 2021 18:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240191AbhDFQu4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 12:50:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2771 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbhDFQux (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2021 12:50:53 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FFCvw47XMz680X5;
        Wed,  7 Apr 2021 00:41:16 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 6 Apr 2021 18:50:44 +0200
Received: from [10.210.166.136] (10.210.166.136) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 17:50:43 +0100
Subject: Re: [bug report] Memory leak from acpi_ev_install_space_handler()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <845f6ef8-d2a7-e491-8405-9526e4ba277a@huawei.com>
 <CAJZ5v0gRm+jsd1KtLtSgT=4pc9oab=EtW=zqBuKjHLJ=ZcUkiA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <752f16ed-29e3-840e-dc53-6fed24d73861@huawei.com>
Date:   Tue, 6 Apr 2021 17:48:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gRm+jsd1KtLtSgT=4pc9oab=EtW=zqBuKjHLJ=ZcUkiA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.166.136]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 06/04/2021 17:40, Rafael J. Wysocki wrote:
> On Tue, Apr 6, 2021 at 5:51 PM John Garry <john.garry@huawei.com> wrote:
>>
>> Hi guys,
>>
>> On next-20210406, I enabled CONFIG_DEBUG_KMEMLEAK and
>> CONFIG_DEBUG_TEST_DRIVER_REMOVE for my arm64 system, and see this:
> 

Hi Rafael,

> Why exactly do you think that acpi_ev_install_space_handler() leaks memory?
> 

I don't think that acpi_ev_install_space_handler() itself leaks memory, 
but it seems that there is something missing in the code which is meant 
to undo/clean up after that on the uninstall path - I did make the point 
in writing "memory leak from", but maybe still not worded clearly.

Anyway, I have not analyzed the problem fully - I'm just reporting.

I don't mind looking further if requested.

Thanks,
John

>> root@debian:/home/john# more /sys/kernel/debug/kmemleak
>> unreferenced object 0xffff202803c11f00 (size 128):
>> comm "swapper/0", pid 1, jiffies 4294894325 (age 337.524s)
>> hex dump (first 32 bytes):
>> 00 00 00 00 02 00 00 00 08 1f c1 03 28 20 ff ff............( ..
>> 08 1f c1 03 28 20 ff ff 00 00 00 00 00 00 00 00....( ..........
>> backtrace:
>> [<00000000670a0938>] slab_post_alloc_hook+0x9c/0x2f8
>> [<00000000a3f47b39>] kmem_cache_alloc+0x198/0x2a8
>> [<000000002bdba864>] acpi_os_create_semaphore+0x54/0xe0
>> [<00000000bcd513fe>] acpi_ev_install_space_handler+0x24c/0x300
>> [<0000000002e116e2>] acpi_install_address_space_handler+0x64/0xb0
>> [<00000000ba00abc5>] i2c_acpi_install_space_handler+0xd4/0x138
>> [<000000008da42058>] i2c_register_adapter+0x368/0x910
>> [<00000000c03f7142>] i2c_add_adapter+0x9c/0x100
>> [<0000000000ba2fcf>] i2c_add_numbered_adapter+0x44/0x58
>> [<000000007df22d67>] i2c_dw_probe_master+0x68c/0x900
>> [<00000000682dfc98>] dw_i2c_plat_probe+0x460/0x640
>> [<00000000ad2dd3ee>] platform_probe+0x8c/0x108
>> [<00000000dd183e3f>] really_probe+0x190/0x670
>> [<0000000066017341>] driver_probe_device+0x8c/0xf8
>> [<00000000c441e843>] device_driver_attach+0x9c/0xa8
>> [<00000000f91dc709>] __driver_attach+0x88/0x138
>> unreferenced object 0xffff00280452c100 (size 128):
>> comm "swapper/0", pid 1, jiffies 4294894558 (age 336.604s)
>> hex dump (first 32 bytes):
>> 00 00 00 00 02 00 00 00 08 c1 52 04 28 00 ff ff..........R.(...
>> 08 c1 52 04 28 00 ff ff 00 00 00 00 00 00 00 00..R.(...........
>> backtrace:
>> [<00000000670a0938>] slab_post_alloc_hook+0x9c/0x2f8
>> [<00000000a3f47b39>] kmem_cache_alloc+0x198/0x2a8
>> [<000000002bdba864>] acpi_os_create_semaphore+0x54/0xe0
>> [<00000000bcd513fe>] acpi_ev_install_space_handler+0x24c/0x300
>> [<0000000002e116e2>] acpi_install_address_space_handler+0x64/0xb0
>> [<00000000988d4f61>] acpi_gpiochip_add+0x20c/0x4a0
>> [<0000000073d4faab>] gpiochip_add_data_with_key+0xd10/0x1680
>> [<000000001d50b98a>] devm_gpiochip_add_data_with_key+0x30/0x78
>> [<00000000fc3e7eaf>] dwapb_gpio_probe+0x828/0xb28
>> [<00000000ad2dd3ee>] platform_probe+0x8c/0x108
>> [<00000000dd183e3f>] really_probe+0x190/0x670
>> [<0000000066017341>] driver_probe_device+0x8c/0xf8
>> [<00000000c441e843>] device_driver_attach+0x9c/0xa8
>> [<00000000f91dc709>] __driver_attach+0x88/0x138
>> [<00000000d330caed>] bus_for_each_dev+0xec/0x160
>> [<00000000eebc5f04>] driver_attach+0x34/0x48
>> root@debian:/home/john#
>>
>> Thanks,
>> John
> .
> 

