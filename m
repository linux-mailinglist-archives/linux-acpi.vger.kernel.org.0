Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A239A14C8B8
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Jan 2020 11:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgA2K1d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Jan 2020 05:27:33 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2327 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgA2K1d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Jan 2020 05:27:33 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 37804B6EB07BAEE4412C;
        Wed, 29 Jan 2020 10:27:31 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 10:27:31 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jan
 2020 10:27:30 +0000
Subject: Re: [PATCH RFC 2/2] soc: Add a basic ACPI generic driver
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-3-git-send-email-john.garry@huawei.com>
 <CAOesGMiCVSvL8H+haLoz=xyiX1CxBSRL_pbCgx-DLhN+5xRn9g@mail.gmail.com>
 <4c6462e3-e368-bd9f-260f-e8351c85bcc2@huawei.com>
 <CAJZ5v0jN5ED_U2s06--8Rx-S4g-wuVxw9YPR12_WL3TnV81_Ag@mail.gmail.com>
 <b6cc7edd-fbb9-ed7a-412e-0d75e4c8ec2b@huawei.com>
 <CAJZ5v0jbh_zU8getDO2VdsQ7qzjnwkTXjsNd+j+j=K4PPDO05w@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <651c836a-327c-f91d-fc5d-ab6f59c1b8db@huawei.com>
Date:   Wed, 29 Jan 2020 10:27:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jbh_zU8getDO2VdsQ7qzjnwkTXjsNd+j+j=K4PPDO05w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

>>
>>> Any reasons for not putting it into drivers/acpi/pptt.c specifically?
>>> .
>>
>> I don't think so.
>>
>> One thing is that the code does a one-time scan of the PPTT to find all
>> processor package nodes with ID structures to register the soc devices -
>> so we would need some new call from from acpi_init() for that.
> 

Hi Rafael,

 > Or an extra initcall or similar. [Calls from acpi_init() are basically
 > for things that need to be strictly ordered in a specific way for some
 > reason.]>
 > Why would that be a problem?

I don't see a problem if we want to use a soc driver, but that is 
starting to look unlikely.

Alternatively, if we want to create some folder under 
/sys/firmware/acpi, any restriction comes from the folder location.

For a folder like /sys/firmware/acpi/pptt, we need to ensure acpi_kobj 
is initialized; acpi_kobj is set from subsys_init(acpi_init), so 
module_init() for pptt module would suffice.

However if we wanted to make pptt folder a sub-folder from those created 
in acpi_sysfs_init() - then we would need to make that parent folder 
kobj non-static. Again, module_init() would suffice.

Thanks,
John

