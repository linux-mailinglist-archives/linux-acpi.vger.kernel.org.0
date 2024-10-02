Return-Path: <linux-acpi+bounces-8530-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDAF98D364
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 14:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4B741C2123A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Oct 2024 12:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F281CFECA;
	Wed,  2 Oct 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCPRe8g/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26071CFEB7
	for <linux-acpi@vger.kernel.org>; Wed,  2 Oct 2024 12:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872520; cv=none; b=ArxPIeqZJ91Ax9c39zJ6rQL6rpR3FmxMAKxXvQSYOipn42p6Sm/xp1zI3yuCb2oks3+uasppzz3TIcev+WuVz/xL+XEW8ilFR22ePn+6uyTzm1WmHqEtG/tAvpuwu9pmxOgXDqYys/NvaGPqpqD2sjA/Kf+II4uCtFpPMNu5smY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872520; c=relaxed/simple;
	bh=/w0+6cd+hbeMW+ipGN774Tj4cMLGVHebRzaAYr+UC/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc61/VR+PkV2kkPb+TohmeHDrew+jtFd/3Wd0xKuJnWC50hJYfgz1W4ZNAnhF9HcjYJwNtoNeyh88/3bD4ULffqbFcRAenb51Oktj+HGViaZIrI7uVieYCJb7TBttPjeIGgSWQONGCKBRrQuIVrrhHKpz/MEoN0klP0OfwzDuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCPRe8g/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727872517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PSEsK0rh/QeUS/t8G2KMmdNRmVd+6fD0oOLOmeE69U0=;
	b=PCPRe8g/8m7H1zEsygKisZbTtjwdkVZOZlxzSR5KfT7YCyN+6vUNhtCINVCslswebJVF4N
	ymHG2JM5OhK3PgmT69vGjfvWlwKXFog2/DnKXDx3DeW2YG3fgh1ghHx9t/GN7ThE2eCbO/
	sz/reRXLrdbjYtOyag4PfRJmReAA34w=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-6vzJDKS4OkqLTyD4Yeudvw-1; Wed, 02 Oct 2024 08:35:16 -0400
X-MC-Unique: 6vzJDKS4OkqLTyD4Yeudvw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a8d13a9cc7aso456216166b.1
        for <linux-acpi@vger.kernel.org>; Wed, 02 Oct 2024 05:35:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727872515; x=1728477315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSEsK0rh/QeUS/t8G2KMmdNRmVd+6fD0oOLOmeE69U0=;
        b=E0msWxj/ZaOA1z8S1s9nPvDA5D87l8wspfC8s1MB/ASwd5wylAEzyrcdpDLZc4fuaK
         9mVsfy2Vs2cEg84tNkpHc9vTcEhXzNMC06TRbH6b56XBkQZsAgtbGBBaKNdGMvUX4Bib
         ku8OQgvIh45vObAMZewE1ZT+IYoJ22sLQBkVVk5Lsqfa0kZtUOwqdePYumyE1c2NyXze
         r+3CJulseRhr/CL3bhHZxxB7+2JMbYdmMbTcG35Z39pkLbnBawJgP0zJ1UC4qWPLBf8b
         0XMRu97BQYMUpCy2CDtI0Hqk/XYuhhWmKQvZe+T5ih6DNMoRa7LYxc6OHfjR/KgaeTx5
         4q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVBUfcb7xn36pnJTCR0PvfEd+w37wSo0nq93sZKVl6ILCLFJPLzYF/EojWrEBB9FhZWLi8IPPjeIXdC@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkh33TQ3khwkyzCcd2k7RF4zpZjoP5uenMJZ8mYH1eaQXrUvTq
	XkqcGjl9K+AzrpyFy0tHHev6ez/EtLFX3h4yD/Lm6avuilDj2MHl1L1N1IlL3tKWi8YyjA2+9dX
	QPXvWkvIyCE45UcmjZnD2Xh496L2JMU+Ofg0oJx23Is808mipilJB33dq9po=
X-Received: by 2002:a17:907:1ca0:b0:a8d:35cf:85f6 with SMTP id a640c23a62f3a-a98f838bdf4mr271741266b.57.1727872515325;
        Wed, 02 Oct 2024 05:35:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAcDBl8oud/YVHjO5L2jwtH7Aoi6ik2xgh7z9rYEDo73FiEesYboUK8tdayUNjiZIFRJpwow==
X-Received: by 2002:a17:907:1ca0:b0:a8d:35cf:85f6 with SMTP id a640c23a62f3a-a98f838bdf4mr271738166b.57.1727872514888;
        Wed, 02 Oct 2024 05:35:14 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27da39bsm859892066b.90.2024.10.02.05.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 05:35:13 -0700 (PDT)
Message-ID: <ab75a39e-94e2-4b1a-9406-e05ebc816b03@redhat.com>
Date: Wed, 2 Oct 2024 14:35:13 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when
 unregistering a battery hook
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, dilinger@queued.net, lenb@kernel.org,
 ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241001212835.341788-1-W_Armin@gmx.de>
 <20241001212835.341788-3-W_Armin@gmx.de>
 <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gSYp5Umo-wsKvQ2Nff7YZ=_3-4bzG3TnKqMpHvxCmR5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2-Oct-24 2:08 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 1, 2024 at 11:28 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> When a battery hook returns an error when adding a new battery, then
>> the battery hook is automatically unregistered.
>> However the battery hook provider cannot know that, so it will later
>> call battery_hook_unregister() on the already unregistered battery
>> hook, resulting in a crash.
>>
>> Fix this by using the list head to mark already unregistered battery
>> hooks as already being unregistered so that they can be ignored by
>> battery_hook_unregister().
>>
>> Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Hans, are you going to take this series or should I apply it?

AFAICT the patches don't really depend on each other, so my plan
was that you take patches 1-2 and I take patch 3 as a fix for
6.12-rc# .

Does that work for you ?

Regards,

Hans




> 
>> ---
>>  drivers/acpi/battery.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index dda59ee5a11e..1c45ff6dbb83 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -715,7 +715,7 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>>                 if (!hook->remove_battery(battery->bat, hook))
>>                         power_supply_changed(battery->bat);
>>         }
>> -       list_del(&hook->list);
>> +       list_del_init(&hook->list);
>>
>>         pr_info("extension unregistered: %s\n", hook->name);
>>  }
>> @@ -723,7 +723,14 @@ static void battery_hook_unregister_unlocked(struct acpi_battery_hook *hook)
>>  void battery_hook_unregister(struct acpi_battery_hook *hook)
>>  {
>>         mutex_lock(&hook_mutex);
>> -       battery_hook_unregister_unlocked(hook);
>> +       /*
>> +        * Ignore already unregistered battery hooks. This might happen
>> +        * if a battery hook was previously unloaded due to an error when
>> +        * adding a new battery.
>> +        */
>> +       if (!list_empty(&hook->list))
>> +               battery_hook_unregister_unlocked(hook);
>> +
>>         mutex_unlock(&hook_mutex);
>>  }
>>  EXPORT_SYMBOL_GPL(battery_hook_unregister);
>> @@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *hook)
>>         struct acpi_battery *battery;
>>
>>         mutex_lock(&hook_mutex);
>> -       INIT_LIST_HEAD(&hook->list);
>>         list_add(&hook->list, &battery_hook_list);
>>         /*
>>          * Now that the driver is registered, we need
>> --
>> 2.39.5
>>
> 


