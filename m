Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA092D7CFA
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 18:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392464AbgLKRed (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 12:34:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2252 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgLKRec (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 12:34:32 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsyWc5rDdz67NCh;
        Sat, 12 Dec 2020 01:31:40 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Dec 2020 18:33:50 +0100
Received: from [10.47.11.239] (10.47.11.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 11 Dec
 2020 17:33:48 +0000
Subject: Re: [PATCH v5 5/5] scsi: hisi_sas: Expose HW queues for v2 hw
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <jejb@linux.ibm.com>, <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, <dwagner@suse.de>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-6-git-send-email-john.garry@huawei.com>
 <7a30086c-8a23-2272-fac9-a66ca92ae2f8@huawei.com>
 <yq1k0tontu8.fsf@ca-mkp.ca.oracle.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9a1e5af4-e9b4-efe8-fd17-a8cb58da75ad@huawei.com>
Date:   Fri, 11 Dec 2020 17:33:11 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <yq1k0tontu8.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.11.239]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 11/12/2020 17:20, Martin K. Petersen wrote:
>> Is there some way in this patch can be merged for 5.11 via the SCSI
>> tree? It has a dependency on the earlier patches in the series, now
>> picked up via irqchip tree. I've seen multiple rounds of SCSI pull
>> requests before, but not sure when we have that or if the tree is
>> rebased for those.
> I'll do a postmerge branch for a few things, including your patch and
> the megaraid patch.

Great, thanks.

By a strange coincidence both those patches are doing the same thing.

John
