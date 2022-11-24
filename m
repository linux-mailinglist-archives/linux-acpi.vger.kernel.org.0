Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8906370A8
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Nov 2022 03:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiKXCxC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Nov 2022 21:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKXCxA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2022 21:53:00 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192836C703
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2022 18:52:58 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NHjFv0rPHzHw6r;
        Thu, 24 Nov 2022 10:52:19 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 10:52:56 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 24 Nov 2022 10:52:55 +0800
Subject: Re: [PATCH] PNP: fix name memory leak in pnp_register_protocol()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <yangyingliang@huawei.com>
References: <20221122125425.1107474-1-yangyingliang@huawei.com>
 <CAJZ5v0hcsvfoSbYmvNyTZ9KE-4rCL4LLCGHcbeGSVUACroLjOg@mail.gmail.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <fbdccb77-ad47-bd92-f688-b563bacc0d0f@huawei.com>
Date:   Thu, 24 Nov 2022 10:52:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hcsvfoSbYmvNyTZ9KE-4rCL4LLCGHcbeGSVUACroLjOg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2022/11/24 2:50, Rafael J. Wysocki wrote:
> On Tue, Nov 22, 2022 at 1:57 PM Yang Yingliang <yangyingliang@huawei.com> wrote:
>> After commit 1fa5ae857bb1 ("driver core: get rid of struct device's
>> bus_id string array"), the name of device is allocated dynamically,
>> it need be freed in error path.
>>
>> Current all protocols used in pnp_register_protocol() is static, they
>> don't have a release function(), so just call kfree_const() to free
>> the name.
>>
>> Fixes: 1fa5ae857bb1 ("driver core: get rid of struct device's bus_id string array")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   drivers/pnp/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
>> index 6a60c5d83383..390e449c17ef 100644
>> --- a/drivers/pnp/core.c
>> +++ b/drivers/pnp/core.c
>> @@ -72,8 +72,10 @@ int pnp_register_protocol(struct pnp_protocol *protocol)
>>          mutex_unlock(&pnp_lock);
>>
>>          ret = device_register(&protocol->dev);
>> -       if (ret)
>> +       if (ret) {
>>                  pnp_remove_protocol(protocol);
>> +               kfree_const(protocol->dev.kobj.name);
> Having to refer to dev.kobj here doesn't seem right.
After calling dev_set_name(), the 'dev.kobj.name' pointer a allocated name.
>
> Shouldn't this just use dev->init_name and allow the core to sort out
> the error case?
dev_set_name(&protocol->dev, "pnp%d", nodenum) is called outside 
device_register(),
the name should be freed by calling put_device() (kobject_cleanup()).

Comment of device_register says:
   NOTE: _Never_ directly free @dev after calling this function, even
   if it returned an error! Always use put_device() to give up the
   reference initialized in this function instead.

Current all caller's device(pnpacpi_protocol.dev and 
pnpbios_protocol.dev) is const, they
don't need be freed, and don't have a release() function. So I just call 
kfree(name) instead
of calling put_device() here.

Thanks,
Yang
>
>> +       }
>>
>>          return ret;
>>   }
>> --
> .
