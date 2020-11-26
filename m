Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C19C2C50C8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 09:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgKZIzC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Nov 2020 03:55:02 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2157 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgKZIzC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Nov 2020 03:55:02 -0500
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ChWjK6Sxyz67GsH;
        Thu, 26 Nov 2020 16:52:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 26 Nov 2020 09:55:00 +0100
Received: from [10.210.172.213] (10.210.172.213) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.1913.5; Thu, 26 Nov 2020 08:54:59 +0000
Subject: Re: [PATCH v3 1/5] genirq/affinity: Add irq_update_affinity_desc()
To:     Daniel Wagner <dwagner@suse.de>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <gregkh@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <maz@kernel.org>
References: <1606324841-217570-1-git-send-email-john.garry@huawei.com>
 <1606324841-217570-2-git-send-email-john.garry@huawei.com>
 <20201126085145.jjioc7belyny5kp4@beryllium.lan>
From:   John Garry <john.garry@huawei.com>
Message-ID: <47442f07-4ea2-46ed-59a8-c1fa2857f4c4@huawei.com>
Date:   Thu, 26 Nov 2020 08:54:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20201126085145.jjioc7belyny5kp4@beryllium.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.213]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

> 
> On Thu, Nov 26, 2020 at 01:20:37AM +0800, John Garry wrote:
>> +	activated = irqd_is_activated(&desc->irq_data);
>> +	if (activated)
>> +		irq_domain_deactivate_irq(&desc->irq_data);
>> +
>> +	if (affinity->is_managed) {
>> +		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
>> +		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
>> +	}
>> +
>> +	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
>> +
>> +	/* Restore the activation state */
>> +	if (activated)
>> +		irq_domain_deactivate_irq(&desc->irq_data);
> Shouldn't this be irq_domain_activate_irq() ?

Yeah, I think so. Blushes.

Cheers,
John
