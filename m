Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E9F2D7BC5
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Dec 2020 18:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730484AbgLKQ6R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Dec 2020 11:58:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2249 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbgLKQ5r (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Dec 2020 11:57:47 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Csxgd6z7Lz67KK6;
        Sat, 12 Dec 2020 00:53:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 11 Dec 2020 17:57:00 +0100
Received: from [10.47.11.239] (10.47.11.239) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 11 Dec
 2020 16:56:58 +0000
Subject: Re: [PATCH v5 5/5] scsi: hisi_sas: Expose HW queues for v2 hw
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <maz@kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-acpi@vger.kernel.org>, <dwagner@suse.de>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-6-git-send-email-john.garry@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7a30086c-8a23-2272-fac9-a66ca92ae2f8@huawei.com>
Date:   Fri, 11 Dec 2020 16:56:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <1606905417-183214-6-git-send-email-john.garry@huawei.com>
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

On 02/12/2020 10:36, John Garry wrote:
> As a performance enhancement, make the completion queue interrupts managed.
> 
> In addition, in commit bf0beec0607d ("blk-mq: drain I/O when all CPUs in a
> hctx are offline"), CPU hotplug for MQ devices using managed interrupts
> is made safe. So expose HW queues to blk-mq to take advantage of this.
> 
> Flag Scsi_host.host_tagset is also set to ensure that the HBA is not sent
> more commands than it can handle. However the driver still does not use
> request tag for IPTT as there are many HW bugs means that special rules
> apply for IPTT allocation.
> 

Hi Martin, James,

Is there some way in this patch can be merged for 5.11 via the SCSI 
tree? It has a dependency on the earlier patches in the series, now 
picked up via irqchip tree. I've seen multiple rounds of SCSI pull 
requests before, but not sure when we have that or if the tree is 
rebased for those.

Thanks,
John


> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/hisi_sas/hisi_sas.h       |  4 ++
>   drivers/scsi/hisi_sas/hisi_sas_main.c  | 11 +++++
>   drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 66 +++++++++++++++++++++-----
>   3 files changed, 68 insertions(+), 13 deletions(-)
> 
