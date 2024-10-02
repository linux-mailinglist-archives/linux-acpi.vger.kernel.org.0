Return-Path: <linux-acpi+bounces-8534-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D498DDB3
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 16:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC95B1C23E07
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2661D0E35;
	Wed,  2 Oct 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q3SCJe0h"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1981D0DE1;
	Wed,  2 Oct 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880539; cv=none; b=mY6aaqm0BTjJSx5EHHrS/JDKdWRS+pcvwj/t1cNQWveWqj3KVbScQUWAEs/lTg8yRZLWhzdTYgk/YLsp4vRwJ2YHriRYCMGuqlUIKwjfk2tz0Mc9ktvdSt/hKp8mZItohw8J2gfD58SdJ1O2sALPmXzNol3DXcQFZ5AH2tqjk8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880539; c=relaxed/simple;
	bh=hgL+SIZwX1CfbfQphYp0LsT6ce8jIAiHfS9mJF/xc3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXRKXeNOCMI/aCYvIPp7tW8MIRUilx5ScckC83PKS9c3uyFhC0HASaS25vM4LTr9taJvRWa8xEK5S0QEfHR22GMAbmzedfM3FWInaYVo01IvGmhd6Du/t9fE70XeEzOXGBGa8sB7RKGuiK1vl5I3SAHqefsX9kvSqZGAx8KSDj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q3SCJe0h; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727880522; x=1728485322; i=w_armin@gmx.de;
	bh=+150BzsvHWdjm9oMxMxUL2iSB227NebcKnRhO4jxsNU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q3SCJe0hMjDS1CRxVoRLKEW7ROIa6c6letyGDjAu5qXIygt8PSVQLdOUMH81H3Zx
	 PZMW7OUUGRPy5Ggw48e3MqYFNE91QSToH1WF7y2XNgoR6ixLXos9f2V8rNvVjeuEy
	 Y9Xj6P3An7arutWGZbZ8fFqNpt4C0i/R0+m4G0ugNE5HH49eGDX6Yo4kurNyYQYa4
	 d+qywg1YzPJM1jxhdaoeqgX++GVBiix2434lBxHyMOi/NrCgjoc94QO22z9MxzRIf
	 WPxqWcoxmPYwY2EQ61b4IMCDkobBcw2FKpAI8GcEM8rAvJ+pmVFi3wkJ7myVkHQv7
	 gwNrqSXlvg2klYRLTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHAH-1sGbIX0YCh-00bilL; Wed, 02
 Oct 2024 16:48:42 +0200
Message-ID: <c6e1fce8-2813-4829-b17a-aebe37997327@gmx.de>
Date: Wed, 2 Oct 2024 16:48:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 1/3] ACPI: battery: Simplify battery hook
 locking
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: pali@kernel.org, dilinger@queued.net, lenb@kernel.org,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241001212835.341788-1-W_Armin@gmx.de>
 <20241001212835.341788-2-W_Armin@gmx.de>
 <CAJZ5v0geqx92+XG-yxXnBFUeNBBygwvAbkxPBEtKi6f88_RYJA@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0geqx92+XG-yxXnBFUeNBBygwvAbkxPBEtKi6f88_RYJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mg4L1Bt9zKb80QmPRIzkCJoYz5/gqfVrzzaBoYhWKMgsOH2VcqR
 722hkZ6d0pDrcvSu6R2Rlhc2SPexPz4Jz5eII4SZN1I3mcJC/0x6pTgmdYO6Qv34JN02pRF
 qU0rlprGSXVXfmzSlxWvBpdmM+MMZo/NDyAD7jVxNn+XWOAHfRGSzlblII9tqXJs9yDpODR
 DWI9DdpcKsqmzeTJb7AkA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BuWsPbXKx0s=;Wz/zZ2ZHKfRd72EvziyaOxlxWGF
 JjEtBfuEh4E86aGz+G0FMnVjrr+66X7eAga7WAMXGmorHM/ZHFlFw15ExMXGBzdMzRkHcer6q
 SKz3eYcpEpM2crp/xAcSPl3jD1vmUONRVmFTWA5JgjJtyGVU6FyQsUyOnfC60QpzJ33T7sZtX
 XRzRv+lur5f4K1/o0ncmc8zn2Ud6Bwvg101pj8Jy6e+Hfx7uf+Moc+IoiP7mNjhO3sKj7yK36
 Qu0pU3vArU6ZtBSOaxdcd8TK4F9YjW3DJXqdRKsEFbozZE976f+X6baemDTDhm5QsgDvur2oP
 JtLqhUXu/IOfQnzBbl/YkcunHIVH3bGXbZ5aYwWKN1E6CFBAOnVSawre1ppfx7JS7lpdpDu9n
 OX61gu44oo4awHEqxRSM1AxVu0skuD4Iap0o3CALh56tL6Z0GzV6k4Gat43RDGo02kCja3Zrh
 88phvllebJfUXyaz+FLz6Cld3AA6/zRbtJSoq7LWUV44bNyCiUTrqoJ7Um7ixFFX/EED097S9
 6xmWI87bZ6x3aG+TR9/ZIcFqlxVZ/KKINvTwK8vRX/W0ut+q+RMV2XS961XQRa4qpOx+wG9VE
 VJZXCue8ml188Qw33BpJvAM6uN+5zIy8gUzeNl9djx8ExdnN5xyCeolgo865549+0iqmuk0c0
 wZ/iic+uW04uIjOBLo2lL9RH/+Ts+Xk9RpWeNG5Uybfvt3MxX0Ve/kmQG9ml338eFAKnWmIoy
 iR6GOMk8cRJXoQytCNnmCMu4ZK7QkmwtLCEMwjVaV878wYleUvIZT4SJ8o7DPRB97Izmt81Ml
 BEDszX74hnlNZzoVjhgfpOZw==

Am 02.10.24 um 14:06 schrieb Rafael J. Wysocki:

> On Tue, Oct 1, 2024 at 11:28=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrot=
e:
>> Move the conditional locking from __battery_hook_unregister()
>> into battery_hook_unregister() and rename the low-level function
>> to simplify the locking during battery hook removal.
>>
>> Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
> Well, "looks good to me" doesn't usually mean "Reviewed-by", but you
> can retain the tag in this particular case.
>
> But in the future please don't add Reviewed-by or Acked-by tags from
> people to patches if you have not actually received those tags.

Sorry, it seems that i mixed up the Reviewed-by tags. I will try to be a b=
it
more careful next time.

Armin Wolf

>> Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/acpi/battery.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index f4599261cfc3..dda59ee5a11e 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -703,28 +703,28 @@ static LIST_HEAD(acpi_battery_list);
>>   static LIST_HEAD(battery_hook_list);
>>   static DEFINE_MUTEX(hook_mutex);
>>
>> -static void __battery_hook_unregister(struct acpi_battery_hook *hook, =
int lock)
>> +static void battery_hook_unregister_unlocked(struct acpi_battery_hook =
*hook)
>>   {
>>          struct acpi_battery *battery;
>> +
>>          /*
>>           * In order to remove a hook, we first need to
>>           * de-register all the batteries that are registered.
>>           */
>> -       if (lock)
>> -               mutex_lock(&hook_mutex);
>>          list_for_each_entry(battery, &acpi_battery_list, list) {
>>                  if (!hook->remove_battery(battery->bat, hook))
>>                          power_supply_changed(battery->bat);
>>          }
>>          list_del(&hook->list);
>> -       if (lock)
>> -               mutex_unlock(&hook_mutex);
>> +
>>          pr_info("extension unregistered: %s\n", hook->name);
>>   }
>>
>>   void battery_hook_unregister(struct acpi_battery_hook *hook)
>>   {
>> -       __battery_hook_unregister(hook, 1);
>> +       mutex_lock(&hook_mutex);
>> +       battery_hook_unregister_unlocked(hook);
>> +       mutex_unlock(&hook_mutex);
>>   }
>>   EXPORT_SYMBOL_GPL(battery_hook_unregister);
>>
>> @@ -750,7 +750,7 @@ void battery_hook_register(struct acpi_battery_hook=
 *hook)
>>                           * hooks.
>>                           */
>>                          pr_err("extension failed to load: %s", hook->n=
ame);
>> -                       __battery_hook_unregister(hook, 0);
>> +                       battery_hook_unregister_unlocked(hook);
>>                          goto end;
>>                  }
>>
>> @@ -804,7 +804,7 @@ static void battery_hook_add_battery(struct acpi_ba=
ttery *battery)
>>                           */
>>                          pr_err("error in extension, unloading: %s",
>>                                          hook_node->name);
>> -                       __battery_hook_unregister(hook_node, 0);
>> +                       battery_hook_unregister_unlocked(hook_node);
>>                  }
>>          }
>>          mutex_unlock(&hook_mutex);
>> @@ -837,7 +837,7 @@ static void __exit battery_hook_exit(void)
>>           * need to remove the hooks.
>>           */
>>          list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) =
{
>> -               __battery_hook_unregister(hook, 1);
>> +               battery_hook_unregister(hook);
>>          }
>>          mutex_destroy(&hook_mutex);
>>   }
>> --
>> 2.39.5
>>

