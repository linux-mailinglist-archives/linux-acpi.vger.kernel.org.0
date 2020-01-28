Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9280414B4F0
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jan 2020 14:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgA1Ndw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jan 2020 08:33:52 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2315 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgA1Ndw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Jan 2020 08:33:52 -0500
Received: from lhreml706-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3CA825C12289569A1C47;
        Tue, 28 Jan 2020 13:33:50 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml706-cah.china.huawei.com (10.201.108.47) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 28 Jan 2020 13:33:49 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 28 Jan
 2020 13:33:49 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <jeremy.linton@arm.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <20200128115629.GB2680602@kroah.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ae2c9384-4fb9-b3ea-d6a8-aaa652ffdafc@huawei.com>
Date:   Tue, 28 Jan 2020 13:33:48 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200128115629.GB2680602@kroah.com>
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


Hi Greg,

>> +
>> +#define pr_fmt(fmt) "SOC ACPI GENERIC: " fmt
> 
> You have a device, why do you need pr_fmt()?
> 

The only print in the code can be removed, below, so I need not worry 
about this, i.e. remove it.

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
>> +	{"HISI  ", "HIP08   ", 0, ACPI_SIG_PPTT, all_versions},
>> +	{ } /* End */
>> +};
>> +
>> +struct acpi_generic_soc_struct {
>> +	struct soc_device_attribute dev_attr;
>> +	u32 vendor;
>> +};
>> +
>> +static ssize_t vendor_show(struct device *dev,
>> +			   struct device_attribute *attr,
>> +			   char *buf)
>> +{
>> +	struct acpi_generic_soc_struct *soc = dev_get_drvdata(dev);
>> +	u8 vendor_id[5] = {};
>> +
>> +	*(u32 *)vendor_id = soc->vendor;
>> +
>> +	return sprintf(buf, "%s\n", vendor_id);
>> +}
>> +
>> +static DEVICE_ATTR_RO(vendor);
>> +
>> +static __init int soc_acpi_generic_init(void)
>> +{
>> +	int index;
>> +
>> +	index = acpi_match_platform_list(plat_list);
>> +	if (index < 0)
>> +		return -ENOENT;
>> +
>> +	index = 0;
>> +	while (true) {
>> +		struct acpi_pptt_package_info info;
>> +
>> +		if (!acpi_pptt_get_package_info(index, &info)) {
>> +			struct soc_device_attribute *soc_dev_attr;
>> +			struct acpi_generic_soc_struct *soc;
>> +			struct soc_device *soc_dev;
>> +			u8 soc_id[9] = {};
>> +
>> +			*(u64 *)soc_id = info.LEVEL_2_ID;
>> +
>> +			soc = kzalloc(sizeof(*soc), GFP_KERNEL);
>> +			if (!soc)
>> +				return -ENOMEM;
>> +
>> +			soc_dev_attr = &soc->dev_attr;
>> +			soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%s",
>> +							 soc_id);
>> +			if (!soc_dev_attr->soc_id) {
>> +				kfree(soc);
>> +				return -ENOMEM;
>> +			}
>> +			soc->vendor = info.vendor_id;
>> +
>> +			soc_dev = soc_device_register(soc_dev_attr);
>> +			if (IS_ERR(soc_dev)) {
>> +				int ret = PTR_ERR(soc_dev);
>> +
>> +				pr_info("could not register soc (%d) index=%d\n",
>> +					ret, index);
> 
> pr_err()?

Yes, more appropriate.

> 
> And shouldn't the core print out the error, not the person who calls it?

Sure, that would sounds reasonable, but I just wanted to get the index 
at which we fail. I could live without it.

> 
> 
>> +				kfree(soc_dev_attr->soc_id);
>> +				kfree(soc);
>> +				return ret;
>> +			}
>> +			dev_set_drvdata(soc_device_to_device(soc_dev), soc);
>> +			device_create_file(soc_device_to_device(soc_dev),
>> +					   &dev_attr_vendor);
> 
> You just raced with userspace and lost.  Use the built-in api that I
> made _just_ because of SOC drivers to do this correctly.
> 

Fine, there is the soc device custom attr group which I can use. But, as 
Arnd said, maybe we can drop this custom file.

Cheers,
John
