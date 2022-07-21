Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA8B57D1E8
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jul 2022 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiGUQsq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jul 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiGUQsp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jul 2022 12:48:45 -0400
Received: from smtp.umanwizard.com (smtp.umanwizard.com [54.203.248.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D8978812E
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jul 2022 09:48:44 -0700 (PDT)
X-Fes-Received-For: linux-acpi@vger.kernel.org
X-Fes-Received-From: brennan@umanwizard.com
Received: From [192.168.1.247] ([71.190.149.125]) By umanwizard.com ; 21 Jul 2022 16:48:36+0000
Message-ID: <67dba9b3-a939-98a0-ad86-da398a03c6df@umanwizard.com>
Date:   Thu, 21 Jul 2022 12:48:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] Expose ACPI battery "measurement accuracy" property to
 sysfs.
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <len@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <7d5bd8b6-15ba-a99c-349e-cfbd94942239@umanwizard.com>
 <CAJZ5v0h9BJxR6aNBFwn4O=PEJ=VfBYa0CL8c6HyWkxrrVLypZA@mail.gmail.com>
From:   Brennan Vincent <brennan@umanwizard.com>
In-Reply-To: <CAJZ5v0h9BJxR6aNBFwn4O=PEJ=VfBYa0CL8c6HyWkxrrVLypZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Fes-Encrypted: true
X-Fes-Ehlo-Domain: [192.168.1.247]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 2022-07-21 07:01, Rafael J. Wysocki wrote:
> On Fri, Jul 15, 2022 at 9:08 PM Brennan Vincent <brennan@umanwizard.com> wrote:
>>
>> This property, expressed in thousands of a percent,
>> reports how accurate the device claims its
>> capacity metrics to be. It may be useful for battery
>> monitoring tools.
>
> For changes like this, it is usually required to at least provide a
> pointer to a user space utility that will use the given ABI.
>
> Are you aware of any plans to use this new attribute in any existing utilities?

Nope, I just had it due to some local tinkering and sent it in case it's useful.

It's up to you, if you don't want to apply it without proof of usefulness, that's fine.

>
>> ---
>>  drivers/acpi/battery.c                    | 7 +++++++
>>  drivers/power/supply/power_supply_sysfs.c | 1 +
>>  include/linux/power_supply.h              | 1 +
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 306513fec1e1..933f3de4dd67 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -300,6 +300,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
>>         case POWER_SUPPLY_PROP_SERIAL_NUMBER:
>>                 val->strval = battery->serial_number;
>>                 break;
>> +       case POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY:
>> +               val->intval = battery->measurement_accuracy;
>> +               break;
>>         default:
>>                 ret = -EINVAL;
>>         }
>> @@ -322,6 +325,7 @@ static enum power_supply_property charge_battery_props[] = {
>>         POWER_SUPPLY_PROP_MODEL_NAME,
>>         POWER_SUPPLY_PROP_MANUFACTURER,
>>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>>  };
>>
>>  static enum power_supply_property charge_battery_full_cap_broken_props[] = {
>> @@ -336,6 +340,7 @@ static enum power_supply_property charge_battery_full_cap_broken_props[] = {
>>         POWER_SUPPLY_PROP_MODEL_NAME,
>>         POWER_SUPPLY_PROP_MANUFACTURER,
>>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>>  };
>>
>>  static enum power_supply_property energy_battery_props[] = {
>> @@ -354,6 +359,7 @@ static enum power_supply_property energy_battery_props[] = {
>>         POWER_SUPPLY_PROP_MODEL_NAME,
>>         POWER_SUPPLY_PROP_MANUFACTURER,
>>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>>  };
>>
>>  static enum power_supply_property energy_battery_full_cap_broken_props[] = {
>> @@ -368,6 +374,7 @@ static enum power_supply_property energy_battery_full_cap_broken_props[] = {
>>         POWER_SUPPLY_PROP_MODEL_NAME,
>>         POWER_SUPPLY_PROP_MANUFACTURER,
>>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>>  };
>>
>>  /* Battery Management */
>> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
>> index 4239591e1522..844dbd61295f 100644
>> --- a/drivers/power/supply/power_supply_sysfs.c
>> +++ b/drivers/power/supply/power_supply_sysfs.c
>> @@ -220,6 +220,7 @@ static struct power_supply_attr power_supply_attrs[] = {
>>         POWER_SUPPLY_ATTR(MODEL_NAME),
>>         POWER_SUPPLY_ATTR(MANUFACTURER),
>>         POWER_SUPPLY_ATTR(SERIAL_NUMBER),
>> +       POWER_SUPPLY_ATTR(MEASUREMENT_ACCURACY),
>>  };
>>
>>  static struct attribute *
>> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
>> index cb380c1d9459..4c48ee26f1b5 100644
>> --- a/include/linux/power_supply.h
>> +++ b/include/linux/power_supply.h
>> @@ -174,6 +174,7 @@ enum power_supply_property {
>>         POWER_SUPPLY_PROP_MODEL_NAME,
>>         POWER_SUPPLY_PROP_MANUFACTURER,
>>         POWER_SUPPLY_PROP_SERIAL_NUMBER,
>> +       POWER_SUPPLY_PROP_MEASUREMENT_ACCURACY,
>>  };
>>
>>  enum power_supply_type {
