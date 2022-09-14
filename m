Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED25B7E82
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Sep 2022 03:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiINBlZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Sep 2022 21:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiINBlY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Sep 2022 21:41:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2CD550A6
        for <linux-acpi@vger.kernel.org>; Tue, 13 Sep 2022 18:41:24 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MS2yT4fVBzmVBC;
        Wed, 14 Sep 2022 09:37:37 +0800 (CST)
Received: from [10.67.110.176] (10.67.110.176) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 14 Sep 2022 09:41:09 +0800
Subject: Re: [PATCH] PNPBIOS: remove unused pnpid32_to_pnpid() declaration
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <rafael.j.wysocki@intel.com>, <bjorn.helgaas@hp.com>,
        <rene.herman@gmail.com>, <len.brown@intel.com>,
        <linux-acpi@vger.kernel.org>
References: <20220913224121.GA629552@bhelgaas>
From:   cuigaosheng <cuigaosheng1@huawei.com>
Message-ID: <e14710d3-c494-a88c-08fe-9831629fc917@huawei.com>
Date:   Wed, 14 Sep 2022 09:41:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20220913224121.GA629552@bhelgaas>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.176]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> I would word the commit log as:
>
>    All uses of pnpid32_to_pnpid() were removed by 25eb846189d2 ("PNP:
>    add pnp_eisa_id_to_string()"), so remove the declaration, too.
>
> Regardless,
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks for taking the time to review this patch, I have made a patch v2 and submitted it.

link: https://patchwork.kernel.org/project/linux-acpi/patch/20220914013317.1135178-1-cuigaosheng1@huawei.com/

ÔÚ 2022/9/14 6:41, Bjorn Helgaas Ð´µÀ:
> On Sun, Sep 11, 2022 at 05:45:35PM +0800, Gaosheng Cui wrote:
>> pnpid32_to_pnpid() has been removed since
>> commit 25eb846189d2 ("PNP: add pnp_eisa_id_to_string()"),
>> so remove it.
> Woof, I guess I messed that up, sorry :(
>
> I would word the commit log as:
>
>    All uses of pnpid32_to_pnpid() were removed by 25eb846189d2 ("PNP:
>    add pnp_eisa_id_to_string()"), so remove the declaration, too.
>
> Regardless,
>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
>
>> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
>> ---
>>   drivers/pnp/pnpbios/pnpbios.h | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/pnp/pnpbios/pnpbios.h b/drivers/pnp/pnpbios/pnpbios.h
>> index 2ce739ff9c1a..f3302006842e 100644
>> --- a/drivers/pnp/pnpbios/pnpbios.h
>> +++ b/drivers/pnp/pnpbios/pnpbios.h
>> @@ -153,7 +153,6 @@ extern int  pnpbios_dont_use_current_config;
>>   extern int pnpbios_parse_data_stream(struct pnp_dev *dev, struct pnp_bios_node * node);
>>   extern int pnpbios_read_resources_from_node(struct pnp_dev *dev, struct pnp_bios_node *node);
>>   extern int pnpbios_write_resources_to_node(struct pnp_dev *dev, struct pnp_bios_node *node);
>> -extern void pnpid32_to_pnpid(u32 id, char *str);
>>   
>>   extern void pnpbios_print_status(const char * module, u16 status);
>>   extern void pnpbios_calls_init(union pnp_bios_install_struct * header);
>> -- 
>> 2.25.1
>>
> .
