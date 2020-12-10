Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72072D6223
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 17:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730905AbgLJQin (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 11:38:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2242 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390577AbgLJQid (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 11:38:33 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CsKJt4gsFz67Mn0;
        Fri, 11 Dec 2020 00:35:10 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 17:37:49 +0100
Received: from [10.210.172.228] (10.210.172.228) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 16:37:48 +0000
Subject: Re: [PATCH v5 4/5] Driver core: platform: Add
 devm_platform_get_irqs_affinity()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>, <tglx@linutronix.de>
CC:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <lenb@kernel.org>, <rjw@rjwysocki.net>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <linux-acpi@vger.kernel.org>,
        <dwagner@suse.de>
References: <1606905417-183214-1-git-send-email-john.garry@huawei.com>
 <1606905417-183214-5-git-send-email-john.garry@huawei.com>
 <X9EYRNDXS1Xcy4iU@kroah.com>
 <36730230-9fd7-8c6c-b997-328beea2fc31@huawei.com>
 <X9Ehy28876ezAOLH@kroah.com> <ed238cc6e4a6b865b2dc965f52fe0550@kernel.org>
 <X9I+2ydy8VDOaiec@kroah.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <2cce8111-37b9-e29b-6f9a-4866891f7a7c@huawei.com>
Date:   Thu, 10 Dec 2020 16:37:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <X9I+2ydy8VDOaiec@kroah.com>
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

Hi Greg,

> {sigh} why do hardware engineers ignore sane busses...

The next HW version is an integrated PCI endpoint, so there is hope.

> 
> Anyway, if you all are going to maintain this, no objection from me, it
> should go through the irq tree.

OK, thanks. So this is getting quite late for 5.11, and none of it has 
seen -next obviously. However, the changes are additive and should only 
affect a single driver now. I'm talking about this series now, not 
Marc's companion series.

I just need to hear from Thomas on any merge preference.

Thanks,
John


