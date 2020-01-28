Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0A14BC85
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 16:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgA1PBj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 10:01:39 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbgA1PBj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 10:01:39 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5BFBE50E8A17CDAF3232;
        Tue, 28 Jan 2020 14:46:08 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 14:46:07 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 14:46:07 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <jeremy.linton@arm.com>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        gregkh <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAK8P3a2famGETLM7JgEh+eUJ9HSqm_Fu79uAkU_BPOkDvV2ROg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <683fc9df-3655-5044-f81c-00e2896a268d@huawei.com>
Date:   Tue, 28 Jan 2020 14:46:07 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2famGETLM7JgEh+eUJ9HSqm_Fu79uAkU_BPOkDvV2ROg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 28/01/2020 12:50, Arnd Bergmann wrote:

Hi Arnd,

> On Tue, Jan 28, 2020 at 12:18 PM John Garry <john.garry@huawei.com> wrote:
>>
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
> 
> Would it be possible to make this the root device for all on-chip devices
> to correctly reflect the hierarchy inside of the soc?

I don't think so. The information about the SoC is got from the PPTT, 
which only describes processors, caches, and physical package 
boundaries. It doesn't include references to on-chip devices.

Having said that (and unrelated to this series), we could add 
/sys/devices/system/soc folder, similar to node folder.

> 
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
> That matches a single machine, right? It doesn't seem very generic
> that way.

Yes :) The problem is that the PPTT ID structure is open to use how the 
implementer wants, so we can't assume everything/anything implemented 
according to the spec examples. Maybe we could call it type1 or 
something like that for platforms which did use the convention in the 
spec example.

> 
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
> 
> I'd rather not see nonstandard attributes in a "generic" driver at
> all. Maybe the
> you can simply concatenate the vendor and  LEVEL_2_ID into a single string
> here?

I actually don't really require the vendor attr. And since "vendor" is 
not in the set of standard soc driver attrs, it can just be omitted.

> 
>> +                       soc = kzalloc(sizeof(*soc), GFP_KERNEL);
>> +                       if (!soc)
>> +                               return -ENOMEM;
>> +
>> +                       soc_dev_attr = &soc->dev_attr;
>> +                       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
>> +                                                        soc_id);
> 
> On the other hand, it would make sense to fill out additional fields here.
> You have already matched the name of the board from the
> acpi_platform_list, so there are two strings available that could be put
> into the "machine" field, and it would make sense to fill out "family" with
> something that identifies it as coming from ACPI PPTT data.

OK, maybe the ones you suggested could be added. I did just want to 
start out with a minimal sets of files, especially since we don't always 
have a direct mapping between soc driver attrs and this PPTT ID structure.

Thanks,
John
