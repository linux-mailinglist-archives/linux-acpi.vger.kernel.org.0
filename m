Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2E2CA6F1
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 16:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391711AbgLAPXt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 10:23:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2184 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390214AbgLAPXt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 10:23:49 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Clm5B6ZqVz67Kmg;
        Tue,  1 Dec 2020 23:20:46 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 1 Dec 2020 16:23:06 +0100
Received: from [10.47.7.145] (10.47.7.145) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 1 Dec 2020
 15:23:04 +0000
Subject: Re: [PATCH v4 1/5] genirq/affinity: Add irq_update_affinity_desc()
To:     Thomas Gleixner <tglx@linutronix.de>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <lenb@kernel.org>,
        <rjw@rjwysocki.net>, <gregkh@linuxfoundation.org>, <maz@kernel.org>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>
References: <1606757759-6076-1-git-send-email-john.garry@huawei.com>
 <1606757759-6076-2-git-send-email-john.garry@huawei.com>
 <87y2iih1pv.fsf@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <22315d74-0696-85ef-882c-85961cfb4f32@huawei.com>
Date:   Tue, 1 Dec 2020 15:22:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <87y2iih1pv.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.145]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Thomas,

I'll go with something extra like:

> 
>> Add a function to allow the affinity of an interrupt be switched to
>> managed, such that interrupts allocated for platform devices may be
>> managed.
> 
> Could you please add a paragraph which explains the limitations of that
> interface?

This new interface has certain limitations, and attempts to use it in 
the following circumstances will fail:
- For when the kernel is configured for generic IRQ reservation mode (in 
config GENERIC_IRQ_RESERVATION_MODE). The reason being that it could 
conflict with managed vs. non-managed interrupt accounting there.
- The interrupt is already started, which should not be the case during init
- The interrupt is already configured as managed, which means double init

> 
>> +/**
>> + * irq_update_affinity_desc - Update affinity management for an interrupt
>> + * @irq:	The interrupt number to update
>> + * @affinity:	Pointer to the affinity descriptor
>> + *
>> + * This interface can be used to configure the affinity management of
>> + * interrupts which have been allocated already.
> 

/*
  * There are certain limitations on when it may be used - attempts to 
use it for when the kernel is configured for generic IRQ reservation 
mode (in config GENERIC_IRQ_RESERVATION_MODE) will fail, as it may 
conflict with managed/non-managed interrupt accounting. In addition, 
attempts to use it on an interrupt which is already started or which has 
already been configured as managed will also fail, as these mean invalid 
init state or double init.

...

Let me know if not good, if not I'll post again soon.

Thanks,
John
