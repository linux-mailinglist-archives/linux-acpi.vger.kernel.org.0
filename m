Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E76C1E05B7
	for <lists+linux-acpi@lfdr.de>; Mon, 25 May 2020 06:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgEYEBN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 25 May 2020 00:01:13 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgEYEBN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 May 2020 00:01:13 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A2F656DD459D6BF4860;
        Mon, 25 May 2020 12:01:11 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Mon, 25 May 2020 12:01:01 +0800
Subject: Re: [PATCH] ACPI/IORT: Remove the unused __get_pci_rid()
To:     Hanjun Guo <guohanjun@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200509093430.1983-1-yuzenghui@huawei.com>
 <3a2e10af-2999-89e4-fa21-95c1c6411a22@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8752dba8-68bf-254c-bb46-dd80d4cd3361@huawei.com>
Date:   Mon, 25 May 2020 12:00:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3a2e10af-2999-89e4-fa21-95c1c6411a22@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/5/9 17:56, Hanjun Guo wrote:
> On 2020/5/9 17:34, Zenghui Yu wrote:
>> Since commit bc8648d49a95 ("ACPI/IORT: Handle PCI aliases properly for
>> IOMMUs"), __get_pci_rid() has become actually unused and can be removed.
>>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> Looks good to me,
> 
> Acked-by: Hanjun Guo <guohanjun@huawei.com>

Hi Will,

Could you please take this patch [*] into v5.8 (if it's not too late)?
I've tried and it can be applied to for-next/acpi cleanly.

[*] 
https://lore.kernel.org/linux-acpi/20200509093430.1983-1-yuzenghui@huawei.com/


Thanks,
Zenghui
