Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D269D2D57F6
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 11:12:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgLJKLz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 05:11:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2239 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730876AbgLJKLq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 05:11:46 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cs8l83X7Lz67Ntq;
        Thu, 10 Dec 2020 18:08:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 11:10:58 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 10:10:53 +0000
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
To:     Marc Zyngier <maz@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>, <tglx@linutronix.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
 <X9Ehy28876ezAOLH@kroah.com> <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c1c56bdf-6f0c-2372-4705-9be4584094bd@huawei.com>
Date:   Thu, 10 Dec 2020 10:10:19 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.172.228]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09/12/2020 19:39, Marc Zyngier wrote:
>>
>> Ok, I'd like to have the irq maintainers/developers ack this before
>> taking it in the driver core, as someone is going to have to maintain
>> this crazy thing for forever if it gets merged.
> 
> I'm actually quite happy with this, and as it turns out, the crazy
> system that has this SAS thing keeps my backside warm all year long.
> As long as this machine keeps ticking, I'm happy to help with this.
> 
> So if that helps:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>

Cheers

> 
> We need to work out the merge strategy for the whole lot though, given
> that it crosses 3 subsystems over two series...

Thomas originally suggested taking the genirq change himself and then 
providing a tag for others to merge:

https://lore.kernel.org/linux-scsi/87h7qf1yp0.fsf@nanos.tec.linutronix.de/

Not sure if that still stands. The small ACPI change could go in a cycle 
after rest merged, but may be best not to split up.

The worst that will happen without Marc's series is that is remove + 
re-probe the SCSI driver is broken, so I'm happy as long as that ends up 
in same kernel version somehow:

https://lore.kernel.org/lkml/20201129135208.680293-1-maz@kernel.org/

Thanks,
John

