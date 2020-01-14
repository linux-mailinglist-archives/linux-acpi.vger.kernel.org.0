Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB01013A193
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2020 08:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgANHU6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Jan 2020 02:20:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728831AbgANHU5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Jan 2020 02:20:57 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E8C54A801AFB970E380;
        Tue, 14 Jan 2020 15:20:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.223.23) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 15:20:47 +0800
Subject: Re: [PATCH v1] ACPI/IORT: Workaround for IORT ID count "minus one"
 issue
To:     John Garry <john.garry@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>
References: <1577708824-4873-1-git-send-email-guohanjun@huawei.com>
 <d3af932c-106e-ee6e-56d3-5a665fd9b357@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <b67fa77a-af21-9013-9162-1cfbd946e648@huawei.com>
Date:   Tue, 14 Jan 2020 15:19:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <d3af932c-106e-ee6e-56d3-5a665fd9b357@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.223.23]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/1/13 17:34, John Garry wrote:
> On 30/12/2019 12:27, Guohanjun (Hanjun Guo) wrote:
>> +};
>> +
>> +static bool apply_id_count_workaround;
>> +
>> +static struct iort_workaround_oem_info wa_info[] __initdata = {
>> +    {
>> +        .oem_id        = "HISI  ",
>> +        .oem_table_id    = "HIP07   ",
>> +        .oem_revision    = 0,
>> +    }, {
>> +        .oem_id        = "HISI  ",
>> +        .oem_table_id    = "HIP08   ",
>> +        .oem_revision    = 0,
>> +    }
>> +};
> 
> Am I right in saying that any future BIOS for these chipsets will have to continue to have buggy firmware? If so, it's unfortunate.

For better compatibility, I would say yes :(

For example, if you fix that in the firmware, and update
the IORT revision number, then it will run pretty good
on new version of the kernel, but not on old version of
kernel without the backporting of this patch.

Thanks
Hanjun

