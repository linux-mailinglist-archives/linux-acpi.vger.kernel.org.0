Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13939F6A9
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhFHMcq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 08:32:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60730 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbhFHMcn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jun 2021 08:32:43 -0400
Received: from [123.112.67.167] (helo=[192.168.0.107])
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <hui.wang@canonical.com>)
        id 1lqasY-0005wK-QD; Tue, 08 Jun 2021 12:30:47 +0000
Subject: Re: [PATCH] ACPI : don't always override the acpi irq
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        manuelkrause@netscape.net
References: <20210608045632.8832-1-hui.wang@canonical.com>
 <CAJZ5v0inJMEAEDx4WGd4FNp3kYHGA4Pe-UkfpYTUQupKT0-A+Q@mail.gmail.com>
From:   Hui Wang <hui.wang@canonical.com>
Message-ID: <c28751fe-0f66-2c2e-c416-a998df8b75f2@canonical.com>
Date:   Tue, 8 Jun 2021 20:30:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0inJMEAEDx4WGd4FNp3kYHGA4Pe-UkfpYTUQupKT0-A+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 6/8/21 7:50 PM, Rafael J. Wysocki wrote:
> On Tue, Jun 8, 2021 at 6:56 AM Hui Wang <hui.wang@canonical.com> wrote:
>> The laptop keyboard doesn't work on many MEDION notebooks, but the
>> keyboard works well under Windows and Unix.
>>
>> Through debugging, we found this log in the dmesg:
>> ACPI: IRQ 1 override to edge, high
>> pnp 00:03: Plug and Play ACPI device, IDs PNP0303 (active)
>>
>> And we checked the IRQ definition in the DSDT, it is:
>>      IRQ (Level, ActiveLow, Exclusive, )
>>          {1}
>>
>> So the BIOS defines the keyboard irq to Level_Low, but the linux
>> kernel override it to Edge_High. If let the linux kernel skip the irq
>> override, the keyboard will work normally.
>>
>>  From the existing comment in the acpi_dev_get_irqresource(), the
>> override function only needs to be called when BIOS defines IRQ() or
>> IRQNoFlags, and according to page 419 and 420 of the
>> ACPI_6_3_final_Jan30.pdf, if IRQ() is empty or defines IRQNoFlags,
> Say "Section ... of ACPI 6.3" instead of referring directly to a PDF file.
>
> And if you refer to ACPI 6.4 instead, you may use a Link tag to point
> to the relevant section in the HTML format of the spec.
OK, go it.
>> the IRQ is High true, edge sensitive and non-shareable. The linux
>> ACPI driver (acpi_rs_set_irq[] in rsirq.c) also assumes so.
>>
>> So here add a function to check 4 conditions, if all of them are true,
>> call override function. otherwise, it means IRQ descriptior in the
>> BIOS is not legacy or is not empty.
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Reported-and-tested-by: Manuel Krause <manuelkrause@netscape.net>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/acpi/resource.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ee78a210c606..d346aa24ffd6 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -380,6 +380,16 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>>
>> +static bool acpi_dev_irq_empty_or_noflags(bool legacy, u8 triggering, u8 polarity,
>> +                                         u8 shareable)
>> +{
>> +       if (legacy && (triggering == ACPI_EDGE_SENSITIVE) &&
>> +           (polarity == ACPI_ACTIVE_HIGH) && (shareable == ACPI_EXCLUSIVE))
>> +               return true;
>> +       else
>> +               return false;
> Because the function returns bool, you can do
>
>    return legacy && triggering == ACPI_EDGE_SENSITIVE && polarity ==
> ACPI_ACTIVE_HIGH && shareable == ACPI_EXCLUSIVE;
>
> Also I'm not sure why a new function is needed for this at all, as the
> check can be done in-line below just fine.
>
> Moreover, as it stands, the only purpose of the "legacy" argument of
> acpi_dev_get_irqresource() is whether or not to do the override, so
> the triggering/polarity/shareable check can be used to determine the
> value of "legacy" when calling that function from
> acpi_dev_resource_interrupt() in the ACPI_RESOURCE_TYPE_IRQ case.

Got it, will do a change like that.

Thanks.

>
>> +}
>> +
>>   static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>                                       u8 triggering, u8 polarity, u8 shareable,
>>                                       bool legacy)
>> @@ -401,7 +411,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>           * using extended IRQ descriptors we take the IRQ configuration
>>           * from _CRS directly.
>>           */
>> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
>> +       if (acpi_dev_irq_empty_or_noflags(legacy, triggering, polarity, shareable)
>> +           && !acpi_get_override_irq(gsi, &t, &p)) {
>>                  u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>                  u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>
>> --
