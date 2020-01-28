Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49FA14BF6E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 19:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgA1SWI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 13:22:08 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726276AbgA1SWI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 13:22:08 -0500
Received: from LHREML714-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BBBB14C99F5943C6C623;
        Tue, 28 Jan 2020 18:22:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML714-CAH.china.huawei.com (10.201.108.37) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 18:22:05 +0000
Received: from [127.0.0.1] (10.210.167.110) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 18:22:04 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     Olof Johansson <olof@lixom.net>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
Date:   Tue, 28 Jan 2020 18:22:02 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.110]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/01/2020 17:51, Olof Johansson wrote:
> Hi,
> 
> On Tue, Jan 28, 2020 at 3:18 AM John Garry <john.garry@huawei.com> wrote:
>>

Hi Olof,

>> Add a generic driver for platforms which populate their ACPI PPTT
>> processor package ID Type Structure according to suggestion in the ACPI
>> spec - see ACPI 6.2, section 5.2.29.3 ID structure Type 2.
>>
>> The soc_id is from member LEVEL_2_ID.
>>
>> For this, we need to use a whitelist of platforms which are known to
>> populate the structure as suggested.
>>
>> For now, only the vendor and soc_id fields are exposed.
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>>   drivers/soc/Makefile       |   1 +
>>   drivers/soc/acpi_generic.c | 102 +++++++++++++++++++++++++++++++++++++
>>   2 files changed, 103 insertions(+)
>>   create mode 100644 drivers/soc/acpi_generic.c
>>
>> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
>> index 8b49d782a1ab..2a59a30a22cd 100644
>> --- a/drivers/soc/Makefile
>> +++ b/drivers/soc/Makefile
>> @@ -3,6 +3,7 @@
>>   # Makefile for the Linux Kernel SOC specific device drivers.
>>   #
>>
>> +obj-$(CONFIG_ACPI_PPTT)                += acpi_generic.o
>>   obj-$(CONFIG_ARCH_ACTIONS)     += actions/
>>   obj-$(CONFIG_SOC_ASPEED)       += aspeed/
>>   obj-$(CONFIG_ARCH_AT91)                += atmel/
> 
> Based on everything I've seen so far, this should go under drivers/acpi instead.

soc drivers seem to live in drivers/soc (non-arm32, anyway), so I 
decided on this location. But drivers/acpi would also seem reasonable now.

> 
>> diff --git a/drivers/soc/acpi_generic.c b/drivers/soc/acpi_generic.c
>> new file mode 100644
>> index 000000000000..34a1f5f8e063
>> --- /dev/null
>> +++ b/drivers/soc/acpi_generic.c
>> @@ -0,0 +1,102 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) John Garry, john.garry@huawei.com
>> + */
>> +
>> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/sys_soc.h>
>> +
>> +/*
>> + * Known platforms that fill in PPTT package ID structures according to
>> + * ACPI spec examples, that being:
>> + * - Custom driver attribute is in ID Type Structure VENDOR_ID member
>> + * - SoC id is in ID Type Structure LEVEL_2_ID member
>> + *    See ACPI SPEC 6.2 Table 5-154 for PPTT ID Type Structure
>> + */
>> +static struct acpi_platform_list plat_list[] = {
>> +       {"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
>> +       { } /* End */
>> +};
> 
> As others have said, this will become a mess over time, and will
> require changes for every new platform. Which, unfortunately, is
> exactly what ACPI is supposed to provide relief from by making
> standardized platforms... standardized.
> 

Right, and I think that it can be dropped. As discussed with Sudeep, I 
was concerned how this PPTT ID structure could be interpreted, and had a 
whitelist as a conservative approach.

>> +
>> +struct acpi_generic_soc_struct {
>> +       struct soc_device_attribute dev_attr;
>> +       u32 vendor;
>> +};
>> +
>> +static ssize_t vendor_show(struct device *dev,
>> +                          struct device_attribute *attr,
>> +                          char *buf)
>> +{
>> +       struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
>> +       u8 vendor_id[5] = {};
>> +
>> +       *(u32 *)vendor_id = soc->vendor;
>> +
>> +       return sprintf(buf, "%s\n", vendor_id);
>> +}
>> +
>> +static DEVICE_ATTR_RO(vendor);
>> +
>> +static __init int soc_acpi_generic_init(void)
>> +{
>> +       int index;
>> +
>> +       index = acpi_match_platform_list(plat_list);
>> +       if (index < 0)
>> +               return -ENOENT;
>> +
>> +       index = 0;
>> +       while (true) {
>> +               struct acpi_pptt_package_info info;
>> +
>> +               if (!acpi_pptt_get_package_info(index, &info)) {
>> +                       struct soc_device_attribute *soc_dev_attr;
>> +                       struct acpi_generic_soc_struct *soc;
>> +                       struct soc_device *soc_dev;
>> +                       u8 soc_id[9] = {};
>> +
>> +                       *(u64 *)soc_id = info.LEVEL_2_ID;
>> +
>> +                       soc = kzalloc(sizeof(*soc), GFP_KERNEL);
>> +                       if (!soc)
>> +                               return -ENOMEM;
>> +
>> +                       soc_dev_attr = &soc->dev_attr;
>> +                       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
>> +                                                        soc_id);
>> +                       if (!soc_dev_attr->soc_id) {
>> +                               kfree(soc);
>> +                               return -ENOMEM;
>> +                       }
>> +                       soc->vendor = info.vendor_id;
>> +
>> +                       soc_dev = soc_device_register(soc_dev_attr);
>> +                       if (IS_ERR(soc_dev)) {
>> +                               int ret = PTR_ERR(soc_dev);
>> +
>> +                               pr_info("could not register soc (%d) index=%d\n",
>> +                                       ret, index);
>> +                               kfree(soc_dev_attr->soc_id);
>> +                               kfree(soc);
>> +                               return ret;
>> +                       }
>> +                       dev_set_drvdata(soc_device_to_device(soc_dev), soc);
>> +                       device_create_file(soc_device_to_device(soc_dev),
>> +                                          &dev_attr_vendor);
> 
> Hmm, this doesn't look like much of a driver to me. This looks like
> the export of an attribute to userspace, and should probably be done
> by ACPI core instead of creating an empty driver for it.

OK, but I'm thinking that having a soc driver can be useful as it is 
common to DT, and so userspace only has to check a single location. And 
the soc driver can also cover multiple-chip systems without have to 
reinvent that code for ACPI core. And it saves adding a new ABI.

> 
> This would also solve the whitelist issue -- always export this
> property if it's set. If it's wrong, then the platform vendor needs to
> fix it up. That's the approach that is used for other aspects of the
> standardized platforms, right? We don't want to litter the kernel with
> white/blacklists -- that's not a net improvement.

Agreed.

> 
> 
> -Olof
> .

Thanks,
John

> 

