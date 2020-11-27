Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5400D2C5FF9
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Nov 2020 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgK0GR0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Nov 2020 01:17:26 -0500
Received: from mail.loongson.cn ([114.242.206.163]:53130 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728043AbgK0GR0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Nov 2020 01:17:26 -0500
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxmtHsmcBf1VsXAA--.51915S3;
        Fri, 27 Nov 2020 14:17:16 +0800 (CST)
Subject: Re: [PATCH v2] acpi: Fix use-after-free in acpi_ipmi.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1606353994-10348-1-git-send-email-tangyouling@loongson.cn>
 <CAJZ5v0hbLh3EKGmy-wCvE_z_BBnWBmnyN+5onL_n2R6VK3BDdg@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <cbb62360-4f3f-6b74-996f-478af0752894@loongson.cn>
Date:   Fri, 27 Nov 2020 14:17:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hbLh3EKGmy-wCvE_z_BBnWBmnyN+5onL_n2R6VK3BDdg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxmtHsmcBf1VsXAA--.51915S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Wr1DAw1ftr45Kr17GFWkXrb_yoW8Jr1fpF
        ZrJFWYvrW7tF1UGa1UZa4UWry8ta12v34S9r48K342kan09ryYkryrAF15GFy7XrykGr42
        qFZxt3W8KFyUZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2
        jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07jIksgUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 11/26/2020 10:22 PM, Rafael J. Wysocki wrote:
> On Thu, Nov 26, 2020 at 2:26 AM Youling Tang <tangyouling@loongson.cn> wrote:
>> kfree() has been called inside put_device so anther kfree would cause a
>> use-after-free bug.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   drivers/acpi/acpi_ipmi.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>> index 9d6c0fc..18edf8b 100644
>> --- a/drivers/acpi/acpi_ipmi.c
>> +++ b/drivers/acpi/acpi_ipmi.c
>> @@ -142,7 +142,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
>>   {
>>          ipmi_destroy_user(ipmi_device->user_interface);
>>          put_device(ipmi_device->dev);
> Does putting ipmi_device->dev (which is a different object than
> ipmi_device itself) really cause ipmi_device to be freed
> automatically?  If not, the change below will introduce a memory leak.
>
ipmi_device will be free so that there is no memory leak.
Similar to the following:
https://lore.kernel.org/patchwork/patch/1342136/

Thanks,
Youling.
>> -       kfree(ipmi_device);
>>   }
>>
>>   static void ipmi_dev_release_kref(struct kref *kref)
>> --

