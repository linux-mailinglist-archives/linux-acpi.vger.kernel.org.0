Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2597410114C
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2019 03:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfKSCWg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Nov 2019 21:22:36 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:57154 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbfKSCWg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Nov 2019 21:22:36 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 09AD612459B90E74DFA0;
        Tue, 19 Nov 2019 10:22:33 +0800 (CST)
Received: from [127.0.0.1] (10.177.251.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 19 Nov 2019
 10:22:26 +0800
Subject: Re: [PATCH v2] ACPI: sysfs: Change ACPI_MASKABLE_GPE_MAX to 0x100
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Dexuan-Linux Cui <dexuan.linux@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>,
        Dexuan Cui <decui@microsoft.com>
References: <cc03ba18-4949-9244-639c-94f461f03361@huawei.com>
 <CAA9_cmc7BuWkBHadHRAxfch43KWovb6rSr2AR9y3bVue0M9EhQ@mail.gmail.com>
 <CAJZ5v0g35zvSB88d7qK8n1uRGCuO5VNK11jHVQRNKwyQW4vZSQ@mail.gmail.com>
 <CAA42JLYCod=mymBiDDXxQ1sts7e-Ot_q9SKdJxjSkcsZRVGDTQ@mail.gmail.com>
 <CAJZ5v0iAbf7qQeyeR6CVYTX8v=OpEcbFksTHgQ0LAZk-QKqHpQ@mail.gmail.com>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <9eff3584-a25b-ca47-d38f-ce83862baa18@huawei.com>
Date:   Tue, 19 Nov 2019 10:22:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iAbf7qQeyeR6CVYTX8v=OpEcbFksTHgQ0LAZk-QKqHpQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.251.225]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2019/11/19 5:15, Rafael J. Wysocki wrote:
> On Mon, Nov 18, 2019 at 8:44 PM Dexuan-Linux Cui <dexuan.linux@gmail.com> wrote:
>>
>> On Mon, Nov 18, 2019 at 1:04 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Sat, Nov 16, 2019 at 9:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>>>>
>>>> On Wed, Nov 13, 2019 at 11:17 PM Yunfeng Ye <yeyunfeng@huawei.com> wrote:
>>>>>
>>>>> The commit 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel
>>>>> parameter cover all GPEs") says:
>>>>>   "Use a bitmap of size 0xFF instead of a u64 for the GPE mask so 256
>>>>>    GPEs can be masked"
>>>>>
>>>>> But the masking of GPE 0xFF it not supported and the check condition
>>>>> "gpe > ACPI_MASKABLE_GPE_MAX" is not valid because the type of gpe is
>>>>> u8.
>>>>>
>>>>> So modify the macro ACPI_MASKABLE_GPE_MAX to 0x100, and drop the "gpe >
>>>>> ACPI_MASKABLE_GPE_MAX" check. In addition, update the docs "Format" for
>>>>> acpi_mask_gpe parameter.
>>>>>
>>>>> Fixes: 0f27cff8597d ("ACPI: sysfs: Make ACPI GPE mask kernel parameter cover all GPEs")
>>>>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>>> ---
>>>>> v1 -> v2:
>>>>>  - drop the "gpe > ACPI_MASKABLE_GPE_MAX" check
>>>>>  - update the docs "Format" from <int> to <byte> for acpi_mask_gpe parameter
>>>>>  - update the commit comment
>>>>>
>>>>>  Documentation/admin-guide/kernel-parameters.txt | 2 +-
>>>>>  drivers/acpi/sysfs.c                            | 4 ++--
>>>>>  2 files changed, 3 insertions(+), 3 deletions(-)
>>>>
>>>> Bisect flags commit eb09878e1301 "ACPI: sysfs: Change
>>>> ACPI_MASKABLE_GPE_MAX to 0x100" in -next as the reason for a boot
>>>> regression in my qemu-kvm test environment. It spews:
>>>>
>>>> [    1.456728] ACPI: Masking GPE 0x0.
>>>> ...
>>>> [  161.721420] ACPI: Masking GPE 0x0.
>>>>
>>>> ...and then hangs.
>>>>
>>>> A straight revert gets the configuration back on its feet.
>>>>
>>>> qemu-system-x86_64 --version
>>>> QEMU emulator version 4.0.50 (v4.0.0-928-g49c6c6ac0cd8)
>>>
>>> OK, I'll drop it then, thanks!
>>
>> We're seeing the same issue wtih 5.4.0-rc7-next-20191118 on a Linux VM
>> running on Hyper-V :
>>
>> [    0.133029] ACPI: 1 ACPI AML tables successfully acquired and loaded
>> [    0.144023] ACPI: Interpreter enabled
>> [    0.145023] ACPI: (supports S0 S5)
>> [    0.146023] ACPI: Using IOAPIC for interrupt routing
>> [    0.147024] PCI: Using host bridge windows from ACPI; if necessary,
>> use "pci=nocrs" and report a bug
>> [    0.148031] ACPI: Masking GPE 0x0.
>> ...
>> [  774.839023] ACPI: Masking GPE 0x0.
>> [  774.840023] ACPI: Masking GPE 0x0.
>>
>> I guess the patch is only tested on a physical machine and not on a VM...
> 
> It looks like the patch hasn't been tested at all.
> 
> Please try to change the data type of gpe in
> acpi_gpe_apply_masked_gpes() to u16 and see if that helps.
> 
Sorry for this problem, I have no good test after modification according to
inspection opinions.

The first version patch is ok, the type of gpe is changed to u32. and I have
test it before.

thanks.
> .
> 

