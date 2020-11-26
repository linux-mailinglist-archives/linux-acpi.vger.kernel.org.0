Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10AB52C4C77
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Nov 2020 02:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgKZBQT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 20:16:19 -0500
Received: from mail.loongson.cn ([114.242.206.163]:54304 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729679AbgKZBQS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 20:16:18 -0500
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxutDeAb9fnMMWAA--.37392S3;
        Thu, 26 Nov 2020 09:16:15 +0800 (CST)
Subject: Re: [PATCH] acpi: Fix use-after-free in acpi_ipmi.c
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1606222266-11685-1-git-send-email-tangyouling@loongson.cn>
 <CAJZ5v0i2RYpw-rxvGWXzetiaSO34EH6x3TN5-O2npZM25Kww7w@mail.gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <615eeadd-fc87-7b7a-f9cc-f2ef5046cea3@loongson.cn>
Date:   Thu, 26 Nov 2020 09:16:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0i2RYpw-rxvGWXzetiaSO34EH6x3TN5-O2npZM25Kww7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9AxutDeAb9fnMMWAA--.37392S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ur13ZF4rXFWUJFy5Jry3XFb_yoW8GFy3pF
        yxtay2vFW7KF1UGa1UZa4UXryrJa1jv34S9FW8Aw12k3Wq9ry3KryDAF15Ka47ZF9rGF42
        qa9rJ3W8C3WUZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
        uYvjxUc8nYUUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


Hi，
On 11/25/2020 11:53 PM, Rafael J. Wysocki wrote:
> On Tue, Nov 24, 2020 at 1:51 PM Youling Tang <tangyouling@loongson.cn> wrote:
>> kfree() has been called inside put_device so anther kfree would cause a
>> use-after-free bug.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   drivers/acpi/acpi_ipmi.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_ipmi.c b/drivers/acpi/acpi_ipmi.c
>> index 9d6c0fc..72902b6 100644
>> --- a/drivers/acpi/acpi_ipmi.c
>> +++ b/drivers/acpi/acpi_ipmi.c
>> @@ -130,7 +130,6 @@ ipmi_dev_alloc(int iface, struct device *dev, acpi_handle handle)
>>                                 ipmi_device, &user);
>>          if (err) {
>>                  put_device(dev);
>> -               kfree(ipmi_device);
> dev doesn't point to the same object in memory as ipmi_device, though,
> if I'm not mistaken.
>
> Please double check that and resend the patch if you are sure that it
> is correct.
You're right, dev really doesn't point to the same memory object
as ipmi_device. I'll send v2 later.

Thanks,
Youling.
>>                  return NULL;
>>          }
>>          ipmi_device->user_interface = user;
>> @@ -142,7 +141,6 @@ static void ipmi_dev_release(struct acpi_ipmi_device *ipmi_device)
>>   {
>>          ipmi_destroy_user(ipmi_device->user_interface);
>>          put_device(ipmi_device->dev);
>> -       kfree(ipmi_device);
>>   }
>>
>>   static void ipmi_dev_release_kref(struct kref *kref)
>> --
>> 2.1.0
>>

