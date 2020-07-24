Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2506722C193
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 11:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgGXJAn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 24 Jul 2020 05:00:43 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2521 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbgGXJAn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jul 2020 05:00:43 -0400
Received: from lhreml713-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 7D54AF63A0924D1CFC96;
        Fri, 24 Jul 2020 10:00:41 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml713-chm.china.huawei.com (10.201.108.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 24 Jul 2020 10:00:41 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Fri, 24 Jul 2020 10:00:41 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>
Subject: RE: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Topic: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Index: AQHWYUfqroZbmVDLlEO3jLbzt/fllakWZmIg
Date:   Fri, 24 Jul 2020 09:00:41 +0000
Message-ID: <b76444fed0a2468983b2a2c45d7d31b2@huawei.com>
References: <20200722103952.1009-2-shiju.jose@huawei.com>
 <20200723232046.GA1468652@bjorn-Precision-5520>
In-Reply-To: <20200723232046.GA1468652@bjorn-Precision-5520>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.85.142]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Bjorn,

Thanks for reviewing.

>-----Original Message-----
>From: Bjorn Helgaas [mailto:helgaas@kernel.org]
>Sent: 24 July 2020 00:21
>To: Shiju Jose <shiju.jose@huawei.com>
>Cc: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; bp@alien8.de;
>james.morse@arm.com; lenb@kernel.org; tony.luck@intel.com;
>dan.carpenter@oracle.com; zhangliguang@linux.alibaba.com;
>andriy.shevchenko@linux.intel.com; Wangkefeng (OS Kernel Lab)
><wangkefeng.wang@huawei.com>; jroedel@suse.de; Linuxarm
><linuxarm@huawei.com>; yangyicong <yangyicong@huawei.com>; Jonathan
>Cameron <jonathan.cameron@huawei.com>; tanxiaofei
><tanxiaofei@huawei.com>
>Subject: Re: [PATCH v13 1/2] ACPI / APEI: Add a notifier chain for unknown
>(vendor) CPER records
>
>On Wed, Jul 22, 2020 at 11:39:51AM +0100, Shiju Jose wrote:
>> CPER records describing a firmware-first error are identified by GUID.
>> The ghes driver currently logs, but ignores any unknown CPER records.
>> This prevents describing errors that can't be represented by a
>> standard entry, that would otherwise allow a driver to recover from an
>error.
>> The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
>> version 2.8).
>
>> +#ifdef CONFIG_ACPI_APEI_GHES
>> +/**
>> + * ghes_register_vendor_record_notifier - register a notifier for
>> +vendor
>> + * records that the kernel would otherwise ignore.
>> + * @nb: pointer to the notifier_block structure of the event handler.
>> + *
>> + * return 0 : SUCCESS, non-zero : FAIL  */ int
>> +ghes_register_vendor_record_notifier(struct notifier_block *nb);
>> +
>> +/**
>> + * ghes_unregister_vendor_record_notifier - unregister the previously
>> + * registered vendor record notifier.
>> + * @nb: pointer to the notifier_block structure of the vendor record
>handler.
>> + */
>> +void ghes_unregister_vendor_record_notifier(struct notifier_block
>> +*nb); #else static inline int
>> +ghes_register_vendor_record_notifier(struct notifier_block *nb) {
>> +	return -ENODEV;
>> +}
>> +
>> +static inline void ghes_unregister_vendor_record_notifier(struct
>> +notifier_block *nb) { }
>
>If you made CONFIG_PCIE_HISI_ERR depend on CONFIG_ACPI_APEI_GHES,
>you'd be able to get rid of these stubs, wouldn't you?  It doesn't look like
>there's any point in building pcie-hisi-error.c at all unless
>CONFIG_ACPI_APEI_GHES is enabled.
The stub is added because this interface is expected to use by the other drivers as well.
Some drivers may not want add the build depend on the CONFIG_ACPI_APEI_GHES
if the error reporting has less priority in the driver.
However we can add dependency on CONFIG_ACPI_APEI_GHES for building pcie-hisi-error.c.  
>
>> +#endif
>> +
>>  int ghes_estatus_pool_init(int num_ghes);
>>
>>  /* From drivers/edac/ghes_edac.c */
>> --
>> 2.17.1
>>
>>

Thanks,
Shiju
