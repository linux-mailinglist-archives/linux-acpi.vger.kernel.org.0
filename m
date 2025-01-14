Return-Path: <linux-acpi+bounces-10580-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2CDA0FD5B
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 01:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1E82169AB6
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 00:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBDB5258;
	Tue, 14 Jan 2025 00:27:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B24A1D;
	Tue, 14 Jan 2025 00:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736814439; cv=none; b=tHiKUt01WG6hKCO9Gy4DHts7/BDBgUN96nh0+m+aVrh1vTkWSa19sn2nN5UeMFH74i3TVU5V3gs5a0Noq6fSOpRn5ZRhdSSIkC7Q4rsxQy+e3788isAzzUhnI4mcGg5iD7TGRM9lTE866nTLldIGiEEBz+7z6cthQQpLmmfb0WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736814439; c=relaxed/simple;
	bh=NK4XWAUbCpUAc41KidmEaeovvstXtG1lWSoNfb1tcWg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FFwn+bW7M0qC0r0oJ4FA/Z8S/eS5xm0Oq7+OtD45fw6JSIUr0a5Cyv6Zzcq14ntoJSVMZyX3YgyYEcR+JO7KL1IIXAxJV3wCHwqfPGG12m3P3QweskFdZuoc36XPs8sDmQlNdY5WT0VruMEhwaooxwXF74IiXReLAcHT1kI2q6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1tXUlu-00000005dAb-1ltZ;
	Tue, 14 Jan 2025 01:27:06 +0100
Message-ID: <e2e76ae3-ba99-4975-b9b7-2946f593c800@maciej.szmigiero.name>
Date: Tue, 14 Jan 2025 01:27:01 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power
 resource quirk
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <fdf629284a00da61384eadea6ac0cd78c20e7e11.1735490662.git.mail@maciej.szmigiero.name>
 <CAJZ5v0j+gUjTGAVCxBQad3Bb5D0ai+dRa5kmNu_ohf5TCnpUhQ@mail.gmail.com>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <CAJZ5v0j+gUjTGAVCxBQad3Bb5D0ai+dRa5kmNu_ohf5TCnpUhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

On 7.01.2025 19:46, Rafael J. Wysocki wrote:
> On Sun, Dec 29, 2024 at 5:45 PM Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>>
>> This laptop (and possibly similar models too) has power resource called
>> "GP12.PXP_" for its Intel XMM7360 WWAN modem.
>>
>> For this power resource to turn ON power for the modem it needs certain
>> internal flag called "ONEN" to be set:
>> Method (_ON, 0, NotSerialized) // _ON_: Power On
>> {
>>          If (^^^LPCB.EC0.ECRG)
>>          {
>>                  If ((ONEN == Zero))
>>                  {
>>                          Return (Zero)
>>                  }
>> (..)
>>          }
>> }
>>
>>
>> This flag only gets set from this power resource "_OFF" method, while the
>> actual modem power gets turned off during suspend by "GP12.PTS" method
>> called from the global "_PTS" (Prepare To Sleep) method.
>>
>> In fact, this power resource "_OFF" method implementation just sets the
>> aforementioned flag:
>> Method (_OFF, 0, NotSerialized) // _OFF: Power Off
>> {
>>          OFEN = Zero
>>          ONEN = One
>> }
>>
>> Upon hibernation finish we try to set this power resource back ON since its
>> "_STA" method returns 0 and the resource is still considered in use as it
>> is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
>> and its parent PCIe port ACPI device (GP12).
>> But the "_ON" method won't do anything since that "ONEN" flag is not set.
>>
>> Overall, this means the modem is dead after hibernation finish until the
>> laptop is rebooted since the modem power has been cut by "_PTS" and its PCI
>> configuration was lost and not able to be restored.
>>
>> The easiest way to workaround this issue is to call this power resource
>> "_OFF" method before calling the "_ON" method to make sure the "ONEN"
>> flag gets properly set.
>>
>> This makes the modem alive once again after hibernation finish - with
>> properly restored PCI configuration space.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> 
> Thanks for the patch, but I'd rather find a different way of
> addressing the problem at hand because there are at least two
> potential issues with this approach.
> 
>> ---
>>   drivers/acpi/power.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index 25174c24d3d7..1db93cf8e4f6 100644
>> --- a/drivers/acpi/power.c
>> +++ b/drivers/acpi/power.c
>> @@ -23,6 +23,7 @@
>>
>>   #define pr_fmt(fmt) "ACPI: PM: " fmt
>>
>> +#include <linux/delay.h>
>>   #include <linux/dmi.h>
>>   #include <linux/kernel.h>
>>   #include <linux/module.h>
>> @@ -991,9 +992,57 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
>>   }
>>
>>   #ifdef CONFIG_ACPI_SLEEP
>> +static const struct dmi_system_id dmi_hp_elitebook_gp12pxp_quirk[] = {
>> +/*
>> + * This laptop (and possibly similar models too) has power resource called
>> + * "GP12.PXP_" for its WWAN modem.
>> + *
>> + * For this power resource to turn ON power for the modem it needs certain
>> + * internal flag called "ONEN" to be set.
>> + * This flag only gets set from this power resource "_OFF" method, while the
>> + * actual modem power gets turned off during suspend by "GP12.PTS" method
>> + * called from the global "_PTS" (Prepare To Sleep) method.
>> + * On the other hand, this power resource "_OFF" method implementation just
>> + * sets the aforementioned flag without actually doing anything else (it
>> + * doesn't contain any code to actually turn off power).
>> + *
>> + * The above means that when upon hibernation finish we try to set this
>> + * power resource back ON since its "_STA" method returns 0 (while the resource
>> + * is still considered in use) its "_ON" method won't do anything since
>> + * that "ONEN" flag is not set.
>> + * Overall, this means the modem is dead until laptop is rebooted since its
>> + * power has been cut by "_PTS" and its PCI configuration was lost and not able
>> + * to be restored.
>> + *
>> + * The easiest way to workaround the issue is to call this power resource
>> + * "_OFF" method before calling the "_ON" method to make sure the "ONEN"
>> + * flag gets properly set.
>> + */
>> +       {
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 855 G7 Notebook PC"),
>> +               },
>> +       },
>> +       {}
>> +};
>> +
>> +static bool resource_is_gp12pxp(acpi_handle handle)
>> +{
>> +       const char *path;
>> +       bool ret;
>> +
>> +       path = acpi_handle_path(handle);
>> +       ret = path && strcmp(path, "\\_SB_.PCI0.GP12.PXP_") == 0;
>> +       kfree(path);
>> +
>> +       return ret;
>> +}
>> +
>>   void acpi_resume_power_resources(void)
>>   {
>>          struct acpi_power_resource *resource;
>> +       bool hp_eb_gp12pxp_quirk = dmi_check_system(dmi_hp_elitebook_gp12pxp_quirk);
>>
>>          mutex_lock(&power_resource_list_lock);
>>
>> @@ -1012,8 +1061,34 @@ void acpi_resume_power_resources(void)
>>
>>                  if (state == ACPI_POWER_RESOURCE_STATE_OFF
>>                      && resource->ref_count) {
>> +                       bool eb_gp12pxp = hp_eb_gp12pxp_quirk &&
>> +                               resource_is_gp12pxp(resource->device.handle);
> 
> This is quite a bit of a useless overhead for all of the systems that
> don't actually contain this defective power resource.

There's already an existing dmi_check_system() in similar
acpi_turn_off_unused_power_resources() function.

This function is called just once during system wake so it is
hardly a hot path.
In any case, that hp_eb_gp12pxp_quirk flag initialization part
could be easily moved to some init function that's run just once
during system boot.

Then the whole overhead on other systems amounts to hp_eb_gp12pxp_quirk
flag comparison as resource_is_gp12pxp() won't be called on them
due to && operator short-circuit evaluation behavior.

> Also, according to your description, the problem is
> hibernation-specific and this function is also called on resume from
> suspend-to-RAM.

This platform supports just s2idle - no S3 support there, so that's
not a problem.

>> +
>> +                       if (eb_gp12pxp) {
>> +                               acpi_handle_notice(resource->device.handle,
>> +                                                  "HP EB quirk - turning OFF before ON\n");
>> +                               __acpi_power_off(resource);
>> +                       }
>> +
>>                          acpi_handle_debug(resource->device.handle, "Turning ON\n");
>>                          __acpi_power_on(resource);
>> +
>> +                       if (eb_gp12pxp) {
>> +                               /*
>> +                                * Use the same delay as DSDT uses in modem _RST
>> +                                * method.
>> +                                *
>> +                                * Otherwise we get "Unable to change power
>> +                                * state from unknown to D0, device
>> +                                * inaccessible" error for the modem PCI device
>> +                                * after thaw.
>> +                                *
>> +                                * This power resource is normally being enabled
>> +                                * only during thaw (once) so this wait is not
>> +                                * a performance issue.
>> +                                */
>> +                               msleep(200);
>> +                       }
>>                  }
>>
>>                  mutex_unlock(&resource->resource_lock);
> 
> It looks like the modem's driver is modular and not included into the
> initrd image, so the restore kernel doesn't initialize it during
> resume from hibernation.
> 
> Have you tried to build that driver into the kernel or add it to the initrd?

I did a quick test with the WWAN modem driver that's built into the kernel
and in the case of 100% successful hibernation the modem indeed works after
resume.

But in case of aborted (or failed) hibernation it is still broken
(this scenario can be simulated easily by writing to /sys/power/pm_test).

While a failed hibernation entry might sound like a corner case in practice
it is far from it unfortunately - I start to experience it regularly after
about 2 weeks of uptime when the machine RAM usage starts to exceed 50%
(I start to get memory allocation failures during hibernation as that other
50% of RAM gets used by AFAIK snapshot copy of the memory).

Other things, like for example btrfs scrub running in background, or active
wake event may also cause failed hibernation entry.

What's worse, even successful hibernation and restore after that doesn't
bring back the modem to the working state - a clean reboot of the machine
is necessary for that.

It's also worth noting that the root cause of the problem is firmware bug
that reports this power resource as OFF via "_STA" but does not allow turning
it ON via just "_ON" method call so that's what we probably should be fixing.

I've updated that laptop BIOS to the latest version but sadly it does not
seem to bring any DSDT changes with respect to the previous one.

Thanks,
Maciej

