Return-Path: <linux-acpi+bounces-5828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 514C48C64C2
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 12:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98518B25150
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C838A5A0F8;
	Wed, 15 May 2024 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KnrIbPcK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75995A0E6
	for <linux-acpi@vger.kernel.org>; Wed, 15 May 2024 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715767560; cv=none; b=H/1Zcb/qH1/fpKSVrwESLT53fU6alX2ln5zGLdiBNaMySJkbDJVEKvz628ukgI76Z32W4/R5rl5/lFwmr756uclCFuzuuEn2Y6xGqXgqxqmOKtuSNRNKTQ6182gmCYGvPaTZ+npr3TDQeKxyaJKGxT/xI084S567HZnpto4Qkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715767560; c=relaxed/simple;
	bh=CX66xMYKV1gM459YjEKFxls/5VGDqwafhoYrA8DM5P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yv8WL1rp8u/PYPMQGTApWwUoU30+6uhlUzL4c8PHCdg8xvwmCLmKhCH7GJu9QvC/wumN6nPXQN4Vv6aNAYtksWecwQ5Z780fBNs6bSXo4kU6cWe5Ng5Rd7PXxKd/gt1nlGbHDhlkOCg5hMZ7Af31vejxLj670rpDZuBjUeyTUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KnrIbPcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715767557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7D4rwsuQPds/lLo9Uf5QXb2sqnAvhWaiivN9/fVNJ+E=;
	b=KnrIbPcKtqxTfS1TJUo+f/ZIuzcRtRP1e05PuKZgIm1vOctYrwPJVrwxgp/uimm5IzdfIH
	ibhvTcZDMTUChgw7L/HiZR36VThuEhfcmAO7aw+MlYmyVgEfYPPChKoTCsYoP72ACKdfx8
	WEgqMTGnfECI2NuMVi3OPP5Z7hNW0Wk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-mev0W7O7Pvu7fcPSGjHOuA-1; Wed, 15 May 2024 06:05:14 -0400
X-MC-Unique: mev0W7O7Pvu7fcPSGjHOuA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a599dbd2b6aso384601066b.2
        for <linux-acpi@vger.kernel.org>; Wed, 15 May 2024 03:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715767513; x=1716372313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D4rwsuQPds/lLo9Uf5QXb2sqnAvhWaiivN9/fVNJ+E=;
        b=o8gWG+JCbiRVE3ZzNbscCjy/Qcdgvkqo0y/1zYtws4QLin90cdj5NWyfMzFdf6MO/S
         vtkiPoBQXm41wJ92IOsNyAaL/0iza7J5tgzQYyDPn/Hmg7W2jLg/6VzPjYvmz+UhJQC6
         8jxfgLpjYoJGgnSmIXgcLXppSBty4ga9Q9xTSYKCxF4LKwZWxyFKRFTTdXeonMLhqbDS
         UaMSwqVzUS8i8TnIA+cOuAoV7VuWL4F8E/Z92dVUZYuKGJIsRJG7lzC2WQQYzIX93wqp
         nFxPBYmZOXzch84IzdDxjuDHZmvBGW/iZkEWRl3plgTxcB+yP2ACndj9W6+0jh8wsWYs
         nR9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUolGLsBka6Iyyw679IJswHaGK+iCeqRV7nb38LeE0G23eJogXK+KjxCl9gLsl2uBcRZqx+GSLiq1tUiI2jEBXHaB3XhCZpBXhaCg==
X-Gm-Message-State: AOJu0YwGaz3gDYsmlxh1s0fJii/DUbG7y1OlNmRg42+YhFXL0YkGH2vc
	pj9JCbpsEN78MYfGyWKcMtI4G9FEijBc8/eTw3/fdrZb0vjz6+rS8L9tkCrWPKN9pJB6erNWzmv
	sqA7z3FkWbiZXq4cLXkWzvx1Rr+K8jvYTvMwqK57xPTagWovLVAXefmL6J3k=
X-Received: by 2002:a17:906:235b:b0:a59:a532:ed58 with SMTP id a640c23a62f3a-a5a2d55ac04mr938949166b.28.1715767512985;
        Wed, 15 May 2024 03:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdG7194CTa0E76vcXtWF15kNifljbozOjvXhwDFpAkes8MFNv4DwyA6z9Q8gozAoRvFZYPgA==
X-Received: by 2002:a17:906:235b:b0:a59:a532:ed58 with SMTP id a640c23a62f3a-a5a2d55ac04mr938946966b.28.1715767512431;
        Wed, 15 May 2024 03:05:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d27bsm832514766b.21.2024.05.15.03.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 03:05:12 -0700 (PDT)
Message-ID: <7c0125b4-fa09-4aba-b216-602e8f72c6ac@redhat.com>
Date: Wed, 15 May 2024 12:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Armin Wolf <W_Armin@gmx.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <22937f20-93fd-4ae2-a5cb-31e5a477ac37@gmx.de>
 <CAJZ5v0iC_DNTj38eCPywgG3v_pkOVOhY9itdgX09AJ7U3yRB4Q@mail.gmail.com>
 <0107bd7c-b4d5-40d3-9147-ed06e1c1f430@redhat.com>
 <CAJZ5v0gARWrS+x2EeWjYA2o3H7NkEtYE65C0DsSTGj0N=8uv-g@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0gARWrS+x2EeWjYA2o3H7NkEtYE65C0DsSTGj0N=8uv-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 5/14/24 9:40 PM, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Sat, May 11, 2024 at 4:22 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael, Armin, et. al.,
>>
>> On 5/10/24 8:00 PM, Rafael J. Wysocki wrote:
>>> On Fri, May 10, 2024 at 7:39 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>>>
>>>> Am 10.05.24 um 19:29 schrieb Andy Shevchenko:
>>>>
>>>>> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
>>>>>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>>>>>>> On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>>>>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>>>>>>>
>>>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>>>
>>>>>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
>>>>>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC address
>>>>>>>>> space:
>>>>>>>>>
>>>>>>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
>>>>>>>>>
>>>>>>>>> This happens because the EC driver only registers the EC address space
>>>>>>>>> handler for operation regions defined in the EC device scope of the
>>>>>>>>> ACPI namespace while the operation region being accessed by the _DSM
>>>>>>>>> in question is located beyond that scope.
>>>>>>>>>
>>>>>>>>> To address this, modify the ACPI EC driver to install the EC address
>>>>>>>>> space handler at the root of the ACPI namespace.
>>>>>>>>>
>>>>>>>>> Note that this change is consistent with some examples in the ACPI
>>>>>>>>> specification in which EC operation regions located outside the EC
>>>>>>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
>>>>>>>>> so the current behavior of the EC driver is arguably questionable.
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> the patch itself looks good to me, but i wonder what happens if multiple
>>>>>>>> ACPI EC devices are present. How would we handle such a situation?
>>>>>>> I'm wondering if this is a theoretical question or do you have any
>>>>>>> existing or planned systems in mind?
>>>>>>>
>>>>>>> ec_read(), ec_write() and ec_transaction() use only the first EC that
>>>>>>> has been found anyway.
>>>>>> Its a theoretical question, i do not know of any systems which have more than
>>>>>> one ACPI EC device.
>>>>> The specification is clear about this case in the "ACPI Embedded Controller
>>>>> Interface Specification":
>>>>>
>>>>>   "The ACPI standard supports multiple embedded controllers in a system,
>>>>>    each with its own resources. Each embedded controller has a flat
>>>>>    byte-addressable I/O space, currently defined as 256 bytes."
>>>>>
>>>>> However, I haven't checked deeper, so it might be a leftover in the documentation.
>>>>>
>>>>> The OperationRegion() has no reference to the EC (or in general, device) which
>>>>> we need to speak to. The only possibility to declare OpRegion() for the second+
>>>>> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
>>>>> supports 2+ ECs, it doesn't support OpRegion():s for them under the same
>>>>> RegionSpace.
>>>>>
>>>>> That said, the commit message might be extended to summarize this, but at
>>>>> the same time I see no way how this series can break anything even in 2+ ECs
>>>>> environments.
>>>>
>>>> Consider the following execution flow when the second EC probes:
>>>>
>>>> 1. acpi_install_address_space_handler_no_reg() fails with AE_ALREADY_EXISTS since the first EC
>>>> has already installed a handler at ACPI_ROOT_OBJECT.
>>>>
>>>> 2. ec_install_handlers() fails with -ENODEV.
>>>>
>>>> 3. acpi_ec_setup() fails with -ENODEV.
>>>>
>>>> 4. acpi_ec_add() fails with -ENODEV.
>>>>
>>>> 5. Probe of seconds EC fails with -ENODEV.
>>>>
>>>> This might cause problems if the second EC is supposed to for example handle EC query events.
>>>> Of course if we only support a single EC, then this situation cannot happen.
>>>
>>> This is kind of moot though until a system with 2 ECs is available.
>>> It is hard to say whether or not it is supported until it can be
>>> tested.
>>
>> I do not believe that this is as theoretical as it sounds though.
>> If the ECDT and the DSDT disagree on the EC-s command_addr or
>> data_addr, then the check to re-use the boot_ec acpi_ec object
>> (struct acpi_ec *boot_ec) in acpi_ec_add() around line 1644:
>>
>>                 if (boot_ec && ec->command_addr == boot_ec->command_addr &&
>>                     ec->data_addr == boot_ec->data_addr) {
>>
>> will fail and the separately allocated acpi_ec which "ec" points to at this
>> point will be kept around (rather then free-ed and replaced with the boot_ec).
> 
> Good point.
> 
>> And then when the below line runs on the newly allocated ec:
>>
>>         ret = acpi_ec_setup(ec, device, true);
>>
>> the newly allocated ec obj does not have EC_FLAGS_EC_HANDLER_INSTALLED set in
>> ec->flags so this acpi_ec_setup() call will call
>>
>>                status = acpi_install_address_space_handler_no_reg(ec->handle,
>>                                                                   ACPI_ADR_SPACE_EC,
>>                                                                   &acpi_ec_space_handler,
>>                                                                   NULL, ec);
>>
>> A second time. Now the above is from the old code and if we currently hit this
>> then the boot_ec acpi_install_address_space_handler_no_reg() call will have been
>> done with:
>>
>>         ec->handle = ACPI_ROOT_OBJECT
>>
>> and the second call for the not boot_ec matching DSDT EC will use the handle from
>> the DSDT EC.
> 
> If I'm not mistaken, this can be addressed by using ACPI_ROOT_OBJECT
> to install the EC address space handler for first_ec only and
> ec->handler for the other EC devices found in the ACPI namespace.

Yes that should work and is a nice solution, that would require
moving the setting of first_ec to above the ec_install_handlers()
call in acpi_ec_setup(), with that small change we could do:

                status = acpi_install_address_space_handler_no_reg(
					(ec == first_ec) ? ACPI_ROOT_OBJECT : ec->handle,
                                        ACPI_ADR_SPACE_EC, &acpi_ec_space_handler, NULL, ec);

in ec_install_handlers() and mirror that in ec_remove_handlers().

> 
> This actually is the case when ECDT is present and so (for consistency
> and to address the issue leading to the $subject patch) it can be done
> when there's no ECDT either.
> 
> Note that first_ec is only set once and never cleared (it would be
> cleared during the EC driver removal if it were not equal to boot_ec,
> but the latter is always the case AFAICS), so there can be only one ec
> object with the address equal to first_ec.

Right I was wondering the same, wondering why we have boot boot_ec and
first_ec.

I guess when there is no ECDT we could somehow not find the DSDT defined
EC during acpi_ec_dsdt_probe() due to some weirdness in the DSDT (e.g.
dynamically set _HID) but then find it later, then we would hit a case
where boot_ec is left at NULL and only first_ec is set.

In that case in the theoretical case of acpi_ec_remove() getting called
(which should never happen) then we would clear first_ec. But that clearing
is done by acpi_ec_free() which gets called *after* ec_remove_handlers()
so even then we can still mirror the (ec == first_ec) check in
ec_remove_handlers() and it will do the right thing.

The other way around however, when there is a boot_ec then that will
indeed always be the same as first_ec and first_ec will never get
cleared and this will be the common case.


>> Given how much quirks we have to deal with ECDT vs DSDT EC mismatches I'm pretty sure
>> that there is hw out there were we hit this path and atm we essentially treat that
>> as 2 ECs routing any OpRegion calls outside of the scope of the DSDT EC handle
>> to the boot_ec object and OpRegion calls any under the scope of the DSDT EC handle
>> to the regular "ec" object allocated in acpi_ec_add()
>>
>> For such buggy hardware the old behavior can be preserved by passing which handle
>> to use for the acpi_install_address_space_handler_no_reg() call to acpi_ec_setup()
>> and pass ec->handle, rather then ACPI_ROOT_OBJECT when not re-using
>> the boot_ec in acpi_ec_add().
>>
>> I think preserving the old behavior when we hit such buggy hw is the best thing
>> to do here. While at it we should probably also start logging a warning when
>> we hit this code path.
> 
> Yes, that would be useful IMV.
> 
>> This does mean that we also need to keep acpi_ec.address_space_handler_holder
>> around for when unregistering the opregion handler.
> 
> Well, see above.

Ack.

TL;DR: I like your suggestion of doing something like:

                status = acpi_install_address_space_handler_no_reg(
					(ec == first_ec) ? ACPI_ROOT_OBJECT : ec->handle,
                                        ACPI_ADR_SPACE_EC, &acpi_ec_space_handler, NULL, ec);

And drop acpi_ec.address_space_handler_holder, so lets go with that.

Regards,

Hans



