Return-Path: <linux-acpi+bounces-15323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70805B12A2A
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jul 2025 12:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B76EAA3180
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Jul 2025 10:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FB71DED5C;
	Sat, 26 Jul 2025 10:59:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from vps-ovh.mhejs.net (vps-ovh.mhejs.net [145.239.82.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33285747F;
	Sat, 26 Jul 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.82.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527583; cv=none; b=FURhVM1l/S/H8ggZGGTvE+MXqSPoBQQwk8enRKTNDjhIR3p5SmW1Uww+vBT4vQF2FSb11kFB/ENZp8XuvMb99OGPL5dm9JiIXzR3gZS0GiZ+VU36djCa3fi7hHW1/KU3+1UpfPz1aIeqo6k7+T1upjcQHq3E4RlwxXKwkMFvfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527583; c=relaxed/simple;
	bh=/jX8QDpuY/ZP/MGLYrbIRDl7f0ITapCuZ2vMpL+bM6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NXRyldd3/3qeh7yF2xL8Meo2NMHMaYcPXA4iGUC4qWqk51ATlpPAf+IL4uaL/RtLYBeWB2MVGMaw47j/uBJxWWf1L+AT6hVoTuqM63Fat2+5DEBliIGFI8ps6zjgfczjibFcjYqSRVjFCmuXf49LvGa6W0ZhT3mp43RjzA6HL08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name; spf=pass smtp.mailfrom=vps-ovh.mhejs.net; arc=none smtp.client-ip=145.239.82.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vps-ovh.mhejs.net
Received: from MUA
	by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <mhej@vps-ovh.mhejs.net>)
	id 1ufcck-00000001JZS-2IrI;
	Sat, 26 Jul 2025 12:59:30 +0200
Message-ID: <2b756bf6-57d0-475c-a72c-f3f65503467e@maciej.szmigiero.name>
Date: Sat, 26 Jul 2025 12:59:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power
 resource quirk
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <999bc59ab1cb18764c5b85afb75da9625365ce1a.1752959347.git.mail@maciej.szmigiero.name>
 <CAJZ5v0jKgKzsdGq6scU7fozFgerhPLEMJi93RHV7f=iRc1VY8Q@mail.gmail.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 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
Disposition-Notification-To: "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>
In-Reply-To: <CAJZ5v0jKgKzsdGq6scU7fozFgerhPLEMJi93RHV7f=iRc1VY8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: mhej@vps-ovh.mhejs.net

On 21.07.2025 16:20, Rafael J. Wysocki wrote:
> On Sat, Jul 19, 2025 at 11:26 PM Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>>
>> This laptop (and possibly similar models too) has power resource called
>> "GP12.PXP_" for its Intel XMM7360 WWAN modem.
>>
>> For this power resource to turn ON power for the modem it needs certain
>> internal flag called "ONEN" to be set:
>>
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
>> This flag only gets set from this power resource "_OFF" method, while the
>> actual modem power gets turned off during suspend by "GP12.PTS" method
>> called from the global "_PTS" (Prepare To Sleep) method.
>>
>> In fact, this power resource "_OFF" method implementation just sets the
>> aforementioned flag:
>>
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
> 
> ONEN is not set when the image kernel gets control, which is not
> unexpected (the _OFF method of this power resource has not been
> evaluated yet), but I wonder why the power resource is off at that
> point.
> 
> _PTS is only evaluated while preparing to hibernate or suspend the
> system, so the restore kernel (the one started to load the image and
> jump to the target kernel stored in the image) does not evaluate it
> and the power resource is off nevertheless.
> 
> I gather that during regular initialization it gets turned on somehow?

It's a failed / aborted hibernation case so _PTS was called by the hibernating
kernel (this call turned off modem power) but nothing has turned it back on.

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

>> Overall, this means the modem is dead after hibernation finish until the
>> laptop is rebooted since the modem power has been cut by "_PTS" and its PCI
>> configuration was lost and not able to be restored.
> 
> Well, I'm not sure about this.
> 
> _PTS is evaluated during hibernation, but the BIOS gets control next.
> It reinitializes the platform (presumably not completely) and starts
> the boot loader which loads the restore kernel, which carries out a
> regular kernel initialization of the platform including the
> acpi_scan_init(), and that should turn the power resource in question
> on.  It doesn't do it and I wonder why.
> 
> Something seems to be missing in that path.
>
> Anyway, it looks like it might suffice to add an initialization quirk
> for this power resource to evaluate _OFF and _ON for it to start with,
> in acpi_add_power_resource().

As I wrote above, in this case there's no actual power cycle of the
entire machine, so AFAIK this power resource isn't re-added.

>> The easiest way to workaround this issue is to call this power resource
>> "_OFF" method before calling the "_ON" method to make sure the "ONEN"
>> flag gets properly set.
>>
>> This makes the modem alive once again after hibernation finish - with
>> properly restored PCI configuration space.
>>
>> Since this platform does *not* support S3 the fact that
>> acpi_resume_power_resources() is also called during resume from S3 is
>> not a problem there.
>>
>> Do the DMI based quirk matching and quirk flag initialization just
>> once - in acpi_power_resources_init() function similar to existing
>> acpi_*_init() functions.
>>
>> This way the whole resume path overhead of this change on other systems
>> amounts to hp_eb_gp12pxp_quirk flag comparison.
>>
>> Opportunistically convert the single already existing DMI match-based
>> quirk in this ACPI power resource handler ("leave unused power
>> resources on" quirk) to the same one-time initialization in
>> acpi_power_resources_init() function instead of re-running that DMI
>> match each time acpi_turn_off_unused_power_resources() gets called.
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>> ---
>>
>> This Intel WWAN modem in general has *a lot* of issues with
>> suspend/resume on various laptop platforms (not only HP).
>>
>> More patches are needed for these, hopefully they can be mainlined
>> too so suspend/resume work out of the box for users (that's
>> important functionality on a laptop).
>>
>> See the following ModemManager issue containing patches also for
>> Thinkpad T14 G1 and Dell Precision 3561:
>> https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/992
>>
>>
>> Changes from v1:
>> * Move hp_eb_gp12pxp_quirk flag initialization via DMI match to
>>    new acpi_power_resources_init() function for reduced resume path
>>    overhead.
>>
>> * Move also the existing DMI match-based quirk for leaving unused power
>>    resources ON to acpi_power_resources_init() function for consistency.
>>
>> * Update patch description about acpi_resume_power_resources() being
>>    called also from S3 resume not being an issue on this platform.
>>
>>   drivers/acpi/internal.h |  1 +
>>   drivers/acpi/power.c    | 86 ++++++++++++++++++++++++++++++++++++++++-
>>   drivers/acpi/scan.c     |  1 +
>>   3 files changed, 87 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
>> index e2781864fdce..63354972ab0b 100644
>> --- a/drivers/acpi/internal.h
>> +++ b/drivers/acpi/internal.h
>> @@ -140,6 +140,7 @@ int __acpi_device_uevent_modalias(const struct acpi_device *adev,
>>   /* --------------------------------------------------------------------------
>>                                     Power Resource
>>      -------------------------------------------------------------------------- */
>> +void acpi_power_resources_init(void);
>>   void acpi_power_resources_list_free(struct list_head *list);
>>   int acpi_extract_power_resources(union acpi_object *package, unsigned int start,
>>                                   struct list_head *list);
>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
>> index b7243d7563b1..944c17b471d5 100644
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
>> @@ -63,6 +64,9 @@ struct acpi_power_resource_entry {
>>          struct acpi_power_resource *resource;
>>   };
>>
>> +static bool hp_eb_gp12pxp_quirk;
>> +static bool leave_unused_power_resources_on_quirk;
> 
> This name is a bit too long IMV.  unused_power_resources_quirk would suffice.

Ack.

>> +
>>   static LIST_HEAD(acpi_power_resource_list);
>>   static DEFINE_MUTEX(power_resource_list_lock);
>>
>> @@ -992,6 +996,18 @@ struct acpi_device *acpi_add_power_resource(acpi_handle handle)
>>   }
>>
>>   #ifdef CONFIG_ACPI_SLEEP
>> +static bool resource_is_gp12pxp(acpi_handle handle)
>> +{
>> +       const char *path;
>> +       bool ret;
>> +
>> +       path = acpi_handle_path(handle);
>> +       ret = path && strcmp(path, "\\_SB_.PCI0.GP12.PXP_") == 0;
>> +       kfree(path);
> 
> Having to do this on every resume for every power resource on this
> platform seems a bit overkill to me.

This platform has just 12 power resources so checking their names on
resume path is hardly a significant overhead:
> [    0.390300] [      T1] ACPI: \_SB_.PCI0.GP12.PXP_: New power resource
> [    0.390562] [      T1] ACPI: \_SB_.PCI0.GP13.NCRD.WLRT: New power resource
> [    0.390745] [      T1] ACPI: \_SB_.PCI0.GP24.P0NV: New power resource
> [    0.391945] [      T1] ACPI: \_SB_.PCI0.BUSA.XHC0.P0U0: New power resource
> [    0.392040] [      T1] ACPI: \_SB_.PCI0.BUSA.XHC0.P3U0: New power resource
> [    0.392933] [      T1] ACPI: \_SB_.PCI0.BUSA.XHC1.P0U1: New power resource
> [    0.393028] [      T1] ACPI: \_SB_.PCI0.BUSA.XHC1.P3U1: New power resource
> [    0.393907] [      T1] ACPI: \_SB_.PCI0.BUSA.HDEF.APPR: New power resource
> [    0.394063] [      T1] ACPI: \_SB_.P0S0: New power resource
> [    0.394097] [      T1] ACPI: \_SB_.P3S0: New power resource
> [    0.399913] [      T1] ACPI: \_SB_.P0S1: New power resource
> [    0.399948] [      T1] ACPI: \_SB_.P3S1: New power resource


> Besides, if you add a new function for it, you might as well put
> everything including the final delay to it and call it instead of
> __acpi_power_on() for the quirky power resource.
> 
> That would be much cleaner code IMV.

Will create a replacement __acpi_power_on() for this power resource
(including the power OFF and delay part) and call it from
acpi_resume_power_resources() instead of ordinary __acpi_power_on()
on this platform.

>> +
>> +       return ret;
>> +}
>> +
>>   void acpi_resume_power_resources(void)
>>   {
>>          struct acpi_power_resource *resource;
>> @@ -1013,8 +1029,34 @@ void acpi_resume_power_resources(void)
>>
>>                  if (state == ACPI_POWER_RESOURCE_STATE_OFF
>>                      && resource->ref_count) {
>> +                       bool eb_gp12pxp = hp_eb_gp12pxp_quirk &&
>> +                               resource_is_gp12pxp(resource->device.handle);
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
>> @@ -1024,6 +1066,41 @@ void acpi_resume_power_resources(void)
>>   }
>>   #endif
>>
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
>>   static const struct dmi_system_id dmi_leave_unused_power_resources_on[] = {
>>          {
>>                  /*
>> @@ -1046,7 +1123,7 @@ void acpi_turn_off_unused_power_resources(void)
>>   {
>>          struct acpi_power_resource *resource;
>>
>> -       if (dmi_check_system(dmi_leave_unused_power_resources_on))
>> +       if (leave_unused_power_resources_on_quirk)
> 
> I'd prefer this change to go into a separate preparatory patch, along
> with the addition of acpi_power_resources_init().

Will do.

>>                  return;
>>
>>          mutex_lock(&power_resource_list_lock);
>> @@ -1065,3 +1142,10 @@ void acpi_turn_off_unused_power_resources(void)
>>
>>          mutex_unlock(&power_resource_list_lock);
>>   }
>> +
>> +void __init acpi_power_resources_init(void)
>> +{
>> +       hp_eb_gp12pxp_quirk = dmi_check_system(dmi_hp_elitebook_gp12pxp_quirk);
>> +       leave_unused_power_resources_on_quirk =
>> +               dmi_check_system(dmi_leave_unused_power_resources_on);
>> +}
>> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
>> index fb1fe9f3b1a3..bb74e7834435 100644
>> --- a/drivers/acpi/scan.c
>> +++ b/drivers/acpi/scan.c
>> @@ -2702,6 +2702,7 @@ void __init acpi_scan_init(void)
>>          acpi_memory_hotplug_init();
>>          acpi_watchdog_init();
>>          acpi_pnp_init();
>> +       acpi_power_resources_init();
>>          acpi_int340x_thermal_init();
>>          acpi_init_lpit();
> 
> I'm not yet convinced about adding a quirk to
> acpi_resume_power_resources().  I'd very much prefer to add one to the
> initialization part.
As far as I can see this power resource only needs special handling
on the resume path.
The initialization path or normal runtime power switching path do not
need any special handling of this power resource.

Thanks,
Maciej


