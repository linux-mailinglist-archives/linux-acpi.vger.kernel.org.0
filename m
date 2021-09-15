Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5202D40CCFF
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 21:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhIOTG3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 15:06:29 -0400
Received: from sonic302-22.consmr.mail.ne1.yahoo.com ([66.163.186.148]:37648
        "EHLO sonic302-22.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229738AbhIOTG3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 Sep 2021 15:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netscape.net; s=a2048; t=1631732709; bh=pzOgJAW/BAqeaqccm3YEgRudRwOIrWkfR9OJpYV+4bU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=D8hKJ6cUGFnOyH4RCj4zGZqu49gEbZhhq7xhwRDa5kwNIfwioPpI8Hk68l6DnKeDlTwaunQfUdkbUdIjzPE0YjoEWWfVnzRJ/XGeOVQYNfdxdYIpRAe/zPMoDg76HdKLeJv4zG3RxI80z3ecIbWRxPro/qYDy7RZk7JB3V+tNRJqK4OQ5PBPq+EMq6R+MVzHw0cVDrPdGmSHVUkmZcZi9VkEubzRo0PrK8V/ndGG213uGujGItrIIp4wbjpMRMX2Uh44WrQEel4atYAKj1NkcbaHcWxZ+U59uo8LJilOdgFQy/XeuX6fe+N0gLkjnRVUXWYER2lMPHtIgnKs6O3GhA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1631732709; bh=tZ0LeFLUi7db+GSd8bKQKWXYy2/ql8IEq7dsMrZx+zA=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=RLBcR2Ntrw+DkBWJwe5AHB12l0cfyyGdD6zMbF3URIw0RTpIxC7/0xh+uTbowTimZ1T/Cbm2YOI8mTeyUNhE7TONJZJG4DfsZZiCRzBhJrPFA7O+eo+ZXLP4h10ED0a4bR5c4SQPgLb8sQpodzUPd+sQK1ANTNlgbAxWcTTTFFSla3rYuYu0j1at4DhBQKesvh41VuFV/zUWiJNy/HSCGo5o5cWOMttSz09zohusBj4+/c2DMs2+Bp6oJQ+Vw9QOXtjzGAgq4Ks8v4xYJ5lJJd/L+h97L1xdYPHvhAqWE+lRF8mKioDLNnTc+cL+i7ei5IvU3zxu6bhwoFx7dQT2SQ==
X-YMail-OSG: .ysEupMVM1nSMBACJmpZPD5ekCJ0OkmX4yfLrJv8QxjiI21dRPbToV5ZUpEzxRc
 TwvkKjsFgygV4B20b5Oka9IBGKDUcIyzKjnCWjFSESnMMzkBrej6ZdQ3g6h12Nc.al1n5YokmS5f
 NYKUG.cEwxOMVkHXTPmhd7zcR_OPtxY3f.xruMSLQ_h0JsWV4sx_YA.0dp0MpQCHOLaMCmlJLdV3
 NvHcFxwgGVGoMKTVr0FNWf._nazJNcOdZlL8uYnvb0fMR9B65exeedZqV5lchuNzR7UZ2kZ8pUTJ
 e0Z2wlHwKwbaKE.mRnfN7pG.x0EGSAkyIpsyDlTQnHoRT3FMFVd96rnzWD69fk4oMN.WDDuKLjTD
 f.kUQxtUOXPAzRzNtP7iplqRHSE0f.9Z5Qy3WUwxmOTU9TGvrSFzB4tmy4_jgXLwn3YxiTEH_bz1
 GseDwFdT.CbN_Fp_UszR09KaK0oN3ez.9yRD_JGu7L5GCXBlUyIdB5FKYTFwCYdMP3qxfyxNnhzC
 riGkMSe7NH5eaiYey.vTXvQgy.0gjCRSEq07WW3H6OJucTU3RRHdI.axEjCyMz4dXDtmazoh6HDt
 QgBtOScSyvb0DQWu0iRJnVqJ2fT052UD5mHagc2c3MlYSGu3lL4pPfPdem4UF5IwSpqRX_yPHULS
 YtiroIO6CW74.ty3aj3GhtSLpE2LpduMsX_vA1mIZXRCQOXQWaUtZu8NtnYBdl1Vppr3HgzkFs2O
 aASzUPvjKWvFCRxJetcz1yaxQWbhwQujaj7apS1c_NuJwr2PcLI1it0yG.E9PwIQYJ9WJXc4NfUI
 CJLIHwEQm0VH7vMxObW8Q7aQBKkwJ7lBHl.BiuVYdgPDQB2k9va_s3YKRJWCPcTVi6gBJipbxvDJ
 y1TF.rmPNAQ3t.7mAUpnrXh_z88SNmvUcWu5NYLBA7nSUsjbKsjFUZ8oUZYVSPkxFnYXjAxfppgM
 0WS.fsOHq8stwXotoNJ5m3x4_Cj0_hECkYbAJbmF65lqJxbzZa0XAuYtpN82y8VJZSLKWCIJboVO
 XYk4dMK9ykKefbZfXTGsL2Th4rdqypt6PXLnlaDRDhESxkUAMiH4moGhjfkxQogJ5Hn0PKV878F9
 UTuFyneOKdWLlZOzSky.h_o4O8r.TSChI9PlhjUqMG.0IutE4NylwIXxz2J7HiNgbP6HFs.XzwGi
 il0ntI610kh.ePRDHijiiWBBFOAaMrAQm0hkTfeimy8QM2APzpcsZaNaKL0X_DwYZbZ8Y3ep6J_u
 _FzRopuxWIOhiOH7uDD3DSAPdIsvHwQF21XVW4Q03oRyXPUbEI.HbnbDQUFZ8kLPUPoGwNWsSCj1
 VNSZkE4RlXBM8LH_gslwLRtqLbDZkqrvquRkE0uTrQ5cqBX02OUqgtEhzMZ_ADNqtzT3KyLrxcBK
 XwAZFsT4.2Fp7Pseq3TcMFB.bUKnY384ximDi2McfepdyjCeoh2cO8xbCOcPcVz4L7Cb41ZPDT5O
 lamtSXQvWUG4SqbtY5CaYFbW1Bva.Pp_ots3hLgDUfDQx_wMAR4jW0nQQQxzcGPIatz3zurk4FIt
 t2ykGiGNJVbIFxJsKA6gyD3UuwZ8sQX1FKK6rK439Uli4G0eu0hKDNEpgecFmqfq0mG_MAQSppwb
 184UFtsEZ8xemy_t.EO0iKVLX_FVS88flLU3opKlV684c.oDJIPP386zVKfZMlzMdHjUNQOY1.4Q
 LmWnnHGFr.COgHt4F0uCLZK8cmZ8W3IYzhsdg2pMdN5d69BF5mF1Ff5o4DKBew7KSjLeTI4IAeOB
 tPDVU5UL17EeHY7.KkzhYdgT1qCpow..BXqHNWIpfJPToEEUMopcfeSIoIgiBXsRSivoFch9Q2G2
 rst.NgEpQCQrhNkP0NqoYZ8A3Md854kyGltAzt_5FVvVbHhanIS2zLEF0kxthufK_91zoWVsbPfe
 6_drv6PxVYvVA1SOjix.Un2U6YuCnkBE0MynWs.7s4IdwKil8G3ZHd9qR_bjwJNYpe_t9T5WX3xZ
 UtKhB0qxXPmD0vwEeZwuazF5t98UesUt9pLdyToPWhY5YqxB9jWBeUbZA28C4XL3UZsy8yV3ULOW
 _5ydHs4B.isJOp5hMwbEtjjUBudDx6lKDW7bzD6ily1Kn84V6ZzFSnJu3gKYwHLonp9LSCNfeipR
 JB8gEZTGXkAJfYw8lR8ffdhFfPv6HJnhDvKoNwHFQJWyp6rVhSuwz.sMdWd1ocAJr5mLNX5mFVry
 fgBeQKTOl2Lf_r9oesbVWqPdeFBWBBqXJtQ9cwCrlbJCKQHSQq7oJqjFZUBfoPJ0VNZcJ84PhlD.
 vSp6acp3XAMNYairvh2tW2NVLoCKcFbAQM9gjZ476Cls-
X-Sonic-MF: <manuelkrause@aim.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Sep 2021 19:05:09 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 1f3452adc11ecc80765aba0ddb1b736b;
          Wed, 15 Sep 2021 19:05:06 +0000 (UTC)
Subject: Re: [PATCH v3] ACPI: resources: add legacy irq override exception by
 DMI info
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
References: <20210915130905.11196-1-hui.wang@canonical.com>
 <CAJZ5v0g1_zMKX9WeSDF5SXib1EFTke3wMHqtJm-+YtQzSyM6dQ@mail.gmail.com>
From:   Manuel Krause <manuelkrause@netscape.net>
Message-ID: <8e93e2ee-b403-c938-d730-7deacbfd759e@netscape.net>
Date:   Wed, 15 Sep 2021 21:05:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g1_zMKX9WeSDF5SXib1EFTke3wMHqtJm-+YtQzSyM6dQ@mail.gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.19013 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 15/09/2021 20:13, Rafael J. Wysocki wrote:
> On Wed, Sep 15, 2021 at 3:09 PM Hui Wang <hui.wang@canonical.com> wrote:
>>
>> After the commit 0ec4e55e9f57 ("ACPI: resources: Add checks for ACPI
>> IRQ override") is reverted, the keyboard of those Medion laptops can't
>> work again.
>>
>> To fix the keyboard issue, here adding an override check by DMI info,
>> this will not affect other machines and this design refers to
>> the prt_quirks[] in the drivers/acpi/pci_irq.c.
>>
>> If we meet similar issues on other platforms, we could expand the
>> table of skip_override_table[] or medion_laptop[].
>>
>> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
>> BugLink: http://bugs.launchpad.net/bugs/1909814
>> Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Reported-by: Manuel Krause <manuelkrause@netscape.net>
>> Tested-by: Manuel Krause <manuelkrause@netscape.net>
>> Signed-off-by: Hui Wang <hui.wang@canonical.com>
>> ---
>>   drivers/acpi/resource.c | 49 +++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index ee78a210c606..7bf38652e6ac 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/ioport.h>
>>   #include <linux/slab.h>
>>   #include <linux/irq.h>
>> +#include <linux/dmi.h>
>>
>>   #ifdef CONFIG_X86
>>   #define valid_IRQ(i) (((i) != 0) && ((i) != 2))
>> @@ -380,9 +381,51 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>>   }
>>   EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>>
>> +static const struct dmi_system_id medion_laptop[] = {
>> +       {
>> +               .ident = "MEDION P15651",
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
>> +                       DMI_MATCH(DMI_BOARD_NAME, "M15T"),
>> +               },
>> +       },
>> +       { }
>> +};
>> +
>> +struct irq_override_cmp {
>> +       const struct dmi_system_id *system;
>> +       unsigned char irq;
>> +       unsigned char triggering;
>> +       unsigned char polarity;
>> +       unsigned char shareable;
>> +};
>> +
>> +static const struct irq_override_cmp skip_override_table[] = {
>> +       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0 },
>> +};
>> +
>> +static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>> +                                 u8 shareable)
>> +{
>> +       int i;
>> +
>> +       for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
>> +               const struct irq_override_cmp *entry = &skip_override_table[i];
>> +
>> +               if (dmi_check_system(entry->system) &&
>> +                   entry->irq == gsi &&
>> +                   entry->triggering == triggering &&
>> +                   entry->polarity == polarity &&
>> +                   entry->shareable == shareable)
>> +                       return false;
>> +       }
>> +
>> +       return true;
>> +}
>> +
>>   static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>                                       u8 triggering, u8 polarity, u8 shareable,
>> -                                    bool legacy)
>> +                                    bool check_override)
>>   {
>>          int irq, p, t;
>>
>> @@ -401,7 +444,9 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>           * using extended IRQ descriptors we take the IRQ configuration
>>           * from _CRS directly.
>>           */
>> -       if (legacy && !acpi_get_override_irq(gsi, &t, &p)) {
>> +       if (check_override &&
>> +           acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
>> +           !acpi_get_override_irq(gsi, &t, &p)) {
>>                  u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>                  u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>
>> --
> 
> Applied as 5.16 material under the subject "ACPI: resources: Add
> DMI-based legacy IRQ override quirk" with some changelog edits.
> 
> Thanks!
> 

We have to thank you, Rafael, for investing your time and 
covering this issue + fix again!

I just want to add now, that also PATCH v3 works fine on here 
(with kernel v5.14.4 now).

I'm still not familiar with the kernel patch queueing mechanisms, 
so forgive my possibly bothering question:
Would it be possible (e.g. for you) to get that fix into earlier 
kernel versions? Simple reason to ask for it: Some people 
thinking over to return their newly bought machine of this type 
without proper out-of-the-box Linux support.
It shouldn't be my business, but I understand those folks' concerns.


TIA and best regards,

Manuel
