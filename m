Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F734866A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 02:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbhCYB1i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 21:27:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14578 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239810AbhCYB1F (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 21:27:05 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5S8H1ySPz19H57;
        Thu, 25 Mar 2021 09:25:03 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.162) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 09:26:57 +0800
Subject: Re: [PATCH] ACPI: AC: fix some errors and warnings reported by
 checkpatch.pl
To:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <1616504247-48744-1-git-send-email-tanxiaofei@huawei.com>
 <CAJZ5v0jKBXuvuhMiLCRJKhk9Ctbmh6mTcRqSh-_WnwHVZ0PabQ@mail.gmail.com>
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "ACPI Devel Maling List" <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>
From:   Xiaofei Tan <tanxiaofei@huawei.com>
Message-ID: <3d663f6a-69d7-56db-fa4d-593c7e7857f8@huawei.com>
Date:   Thu, 25 Mar 2021 09:26:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jKBXuvuhMiLCRJKhk9Ctbmh6mTcRqSh-_WnwHVZ0PabQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.192.162]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael，

On 2021/3/24 23:57, Rafael J. Wysocki wrote:
> On Tue, Mar 23, 2021 at 2:01 PM Xiaofei Tan <tanxiaofei@huawei.com> wrote:
>>
>> Fix some errors and warnings reported by checkpatch.pl, including
>> following five types:
>
> Well, they are coding style issues rather than errors.
>

Right, i could change the description.

>> ERROR: "foo * bar" should be "foo *bar"
>> ERROR: code indent should use tabs where possible
>> WARNING: Block comments use a trailing */ on a separate line
>> WARNING: braces {} are not necessary for single statement blocks
>> WARNING: void function return statements are not generally useful
>>
>> Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> ---
>>  drivers/acpi/ac.c | 32 +++++++++++++-------------------
>>  1 file changed, 13 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>> index b86ee6e..07987854 100644
>> --- a/drivers/acpi/ac.c
>> +++ b/drivers/acpi/ac.c
>> @@ -78,17 +78,16 @@ static struct acpi_driver acpi_ac_driver = {
>>  struct acpi_ac {
>>         struct power_supply *charger;
>>         struct power_supply_desc charger_desc;
>> -       struct acpi_device * device;
>> +       struct acpi_device *device;
>>         unsigned long long state;
>>         struct notifier_block battery_nb;
>>  };
>>
>>  #define to_acpi_ac(x) power_supply_get_drvdata(x)
>>
>> -/* --------------------------------------------------------------------------
>> -                               AC Adapter Management
>> -   -------------------------------------------------------------------------- */
>> -
>> +/*
>> + * AC Adapter Management
>> + */
>
> Please use the /* ... */ (one-line) comment format here and below for
> comments that aren't longer than one line.
>

Sure.

>>  static int acpi_ac_get_state(struct acpi_ac *ac)
>>  {
>>         acpi_status status = AE_OK;
>> @@ -109,9 +108,9 @@ static int acpi_ac_get_state(struct acpi_ac *ac)
>>         return 0;
>>  }
>>
>> -/* --------------------------------------------------------------------------
>> -                            sysfs I/F
>> -   -------------------------------------------------------------------------- */
>> +/*
>> + * sysfs I/F
>> + */
>>  static int get_ac_property(struct power_supply *psy,
>>                            enum power_supply_property psp,
>>                            union power_supply_propval *val)
>> @@ -138,10 +137,9 @@ static enum power_supply_property ac_props[] = {
>>         POWER_SUPPLY_PROP_ONLINE,
>>  };
>>
>> -/* --------------------------------------------------------------------------
>> -                                   Driver Model
>> -   -------------------------------------------------------------------------- */
>> -
>> +/*
>> + * Driver Model
>> + */
>>  static void acpi_ac_notify(struct acpi_device *device, u32 event)
>>  {
>>         struct acpi_ac *ac = acpi_driver_data(device);
>> @@ -174,8 +172,6 @@ static void acpi_ac_notify(struct acpi_device *device, u32 event)
>>                 acpi_notifier_call_chain(device, event, (u32) ac->state);
>>                 kobject_uevent(&ac->charger->dev.kobj, KOBJ_CHANGE);
>>         }
>> -
>> -       return;
>>  }
>>
>>  static int acpi_ac_battery_notify(struct notifier_block *nb,
>> @@ -282,9 +278,8 @@ static int acpi_ac_add(struct acpi_device *device)
>>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>>         register_acpi_notifier(&ac->battery_nb);
>>  end:
>> -       if (result) {
>> +       if (result)
>>                 kfree(ac);
>> -       }
>>
>>         return result;
>>  }
>> @@ -293,7 +288,7 @@ static int acpi_ac_add(struct acpi_device *device)
>>  static int acpi_ac_resume(struct device *dev)
>>  {
>>         struct acpi_ac *ac;
>> -       unsigned old_state;
>> +       unsigned int old_state;
>>
>>         if (!dev)
>>                 return -EINVAL;
>> @@ -352,9 +347,8 @@ static int __init acpi_ac_init(void)
>>         }
>>
>>         result = acpi_bus_register_driver(&acpi_ac_driver);
>> -       if (result < 0) {
>> +       if (result < 0)
>>                 return -ENODEV;
>> -       }
>>
>>         return 0;
>>  }
>> --
>
> .
>

