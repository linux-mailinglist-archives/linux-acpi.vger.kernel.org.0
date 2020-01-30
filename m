Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F35CD14DE95
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Jan 2020 17:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgA3QMY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Jan 2020 11:12:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727299AbgA3QMY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Jan 2020 11:12:24 -0500
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 8207B7581DCDBE01EE6A;
        Thu, 30 Jan 2020 16:12:22 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 30 Jan 2020 16:12:22 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jan
 2020 16:12:21 +0000
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <jeremy.linton@arm.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
 <20200128123415.GB36168@bogus> <20200130112338.GA54532@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bfa7770b-d323-1f2a-98c8-44c2142c9124@huawei.com>
Date:   Thu, 30 Jan 2020 16:12:20 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200130112338.GA54532@bogus>
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

On 30/01/2020 11:23, Sudeep Holla wrote:
>> I personally would not prefer to add the support when I know it is getting
>> deprecated. I am not sure on kernel community policy on the same.
>>
> OK, the details on the proposal to deprecate can be now found in UEFI
> bugzilla [1]
> 

Wouldn't it be a better approach to propose deprecating the field when 
there is a readily available alternative, i.e. not a spec from a 
different body in beta stage?

To me, this new SMC support will take an appreciable amount of time to 
be implemented in FW by SiPs when actually released. And if it requires 
an ATF upgrade - which I guess it does - then that's a big job.

Thanks,
John

> --
> Regards,
> Sudeep
> 
> [1]https://bugzilla.tianocore.org/show_bug.cgi?id=2492
> .

