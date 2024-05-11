Return-Path: <linux-acpi+bounces-5773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2BE8C31CC
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D3722820A4
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC32A537F8;
	Sat, 11 May 2024 14:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIMeWh8y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72ED5339D
	for <linux-acpi@vger.kernel.org>; Sat, 11 May 2024 14:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715437345; cv=none; b=u4jML3RYEQBauyev2cdZfwNlkaJ18fNdC71FaNnVptVN3tA7VAblIqbqH8Wbx+apkRKULDQ7L5K+twEgGALv/chEZE9ySyicW5G4/nF976qLZzTiKT3wVamV4A27RWvrPpHyj9yiMNYRgnL233WdDhIkMVu1Q8UREvWYPz6rMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715437345; c=relaxed/simple;
	bh=2nluxmBLShxEQAmFlrah4H25BKHq5qSZXBKmpwbNDfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mt1ZVhq2jTbNmR5e+8L4u9lFpyZsgpFk8rYvUOB7TI85cWWlNIc/YRQJfi17OQt/U/Mm35fMM853AAIpc5e9PoX5BTppf+f9QO2DJpVDu71vh+fnHwfbM3DI/sw9UeuBNkPV6+k2x4EfGipIUWsfeK3pEzT9gP4uySUCrZgsHks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIMeWh8y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715437342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u79CuW9gzfeLmG03jb/ruAzJDdGVKbSE15GXrfIyirU=;
	b=gIMeWh8y5aZ2YjmKJMQ1XFv6a6JN79UU+5m0j2v2DMDc/9Godsscl/kaAd8isMUZEvHx1S
	xuIyxxqFIOFhpPaE5NUCgYJs7/Efh1fMwGsVNM+53l4fCkqvruLEz+dwGFvpu4L9cj1y6L
	GdaG7BREhhLpzwhCBupVaTUlKydTD18=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-ZoaJecb8PBSUvq2-0O-ZYA-1; Sat, 11 May 2024 10:22:21 -0400
X-MC-Unique: ZoaJecb8PBSUvq2-0O-ZYA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59d0fb7731so194007366b.0
        for <linux-acpi@vger.kernel.org>; Sat, 11 May 2024 07:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715437340; x=1716042140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u79CuW9gzfeLmG03jb/ruAzJDdGVKbSE15GXrfIyirU=;
        b=hxba06+2C2Euctq4YdTkIyx8JL47YyIKxVQ2GOB4zWY7UVD9PV9KaAb0zsFbS7ge1b
         ReKfQAxMRzmE+z09Hwj7BYkX7a7hvRQFswawg/r9kGEMchlxVBMeY750Gkf3dMrqALJ2
         mHWoIJHkjn4aihoRugcIOY7ohy43ufUZ1uG+64m5DxPT/iQfhb45ypUzah4MnA8egZDZ
         Zxceb8yqOsbZE/5uPbUsNLd4H7PY6SBZ+Aq1cXq9gm50j49ifYIIVv/EmzZA1siVKvca
         FD8gkZaBd/prgYb8ZeGL/QwltQZ6+Q8/6pWZgSLKEZaVWiiWdF6O8EVCMDc9PyifmGap
         ETGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFJlSQd53MFQKDHyyvfIiAkwyc2dXaTTbEPUAFChk6ODItQy+zqM6IZB80TPxTtSBjCd97EkMljcqnMroZbkdSg8aOeEZcxOFqaQ==
X-Gm-Message-State: AOJu0YzW+JGkPzMw6cK/mV8Ey2Bi42LdstLC69znKWYSRa/mATKEWuKE
	z8sb6Zsu+ElkkED8yHCTSiJs8mmAylJdbbOWtzX18vM0xPigUc+jpLdQ2FYwgg/Ae13XPbxJQFi
	9R+HAkN2gzPPb+EqbeMmz5oFzI9DgAgpDIZic8OOJvj5bLFP2J3U4A9wI4rWL2T91F+o=
X-Received: by 2002:a17:907:7e84:b0:a55:6f6c:3bae with SMTP id a640c23a62f3a-a5a2d3c2da2mr416014766b.0.1715437340168;
        Sat, 11 May 2024 07:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0ayLkjAFtt6O21mNG5wp9vGBE9KW5PeTIOWqzmEs+Ms1FbVK7IWCmeknxqoIDmNEpUSYs9w==
X-Received: by 2002:a17:907:7e84:b0:a55:6f6c:3bae with SMTP id a640c23a62f3a-a5a2d3c2da2mr416013666b.0.1715437339761;
        Sat, 11 May 2024 07:22:19 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7dd4sm330650766b.139.2024.05.11.07.22.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 07:22:18 -0700 (PDT)
Message-ID: <0107bd7c-b4d5-40d3-9147-ed06e1c1f430@redhat.com>
Date: Sat, 11 May 2024 16:22:17 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0iC_DNTj38eCPywgG3v_pkOVOhY9itdgX09AJ7U3yRB4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rafael, Armin, et. al.,

On 5/10/24 8:00 PM, Rafael J. Wysocki wrote:
> On Fri, May 10, 2024 at 7:39 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Am 10.05.24 um 19:29 schrieb Andy Shevchenko:
>>
>>> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
>>>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>>>>> On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>>>>>
>>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>>
>>>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
>>>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC address
>>>>>>> space:
>>>>>>>
>>>>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
>>>>>>>
>>>>>>> This happens because the EC driver only registers the EC address space
>>>>>>> handler for operation regions defined in the EC device scope of the
>>>>>>> ACPI namespace while the operation region being accessed by the _DSM
>>>>>>> in question is located beyond that scope.
>>>>>>>
>>>>>>> To address this, modify the ACPI EC driver to install the EC address
>>>>>>> space handler at the root of the ACPI namespace.
>>>>>>>
>>>>>>> Note that this change is consistent with some examples in the ACPI
>>>>>>> specification in which EC operation regions located outside the EC
>>>>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
>>>>>>> so the current behavior of the EC driver is arguably questionable.
>>>>>> Hi,
>>>>>>
>>>>>> the patch itself looks good to me, but i wonder what happens if multiple
>>>>>> ACPI EC devices are present. How would we handle such a situation?
>>>>> I'm wondering if this is a theoretical question or do you have any
>>>>> existing or planned systems in mind?
>>>>>
>>>>> ec_read(), ec_write() and ec_transaction() use only the first EC that
>>>>> has been found anyway.
>>>> Its a theoretical question, i do not know of any systems which have more than
>>>> one ACPI EC device.
>>> The specification is clear about this case in the "ACPI Embedded Controller
>>> Interface Specification":
>>>
>>>   "The ACPI standard supports multiple embedded controllers in a system,
>>>    each with its own resources. Each embedded controller has a flat
>>>    byte-addressable I/O space, currently defined as 256 bytes."
>>>
>>> However, I haven't checked deeper, so it might be a leftover in the documentation.
>>>
>>> The OperationRegion() has no reference to the EC (or in general, device) which
>>> we need to speak to. The only possibility to declare OpRegion() for the second+
>>> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
>>> supports 2+ ECs, it doesn't support OpRegion():s for them under the same
>>> RegionSpace.
>>>
>>> That said, the commit message might be extended to summarize this, but at
>>> the same time I see no way how this series can break anything even in 2+ ECs
>>> environments.
>>
>> Consider the following execution flow when the second EC probes:
>>
>> 1. acpi_install_address_space_handler_no_reg() fails with AE_ALREADY_EXISTS since the first EC
>> has already installed a handler at ACPI_ROOT_OBJECT.
>>
>> 2. ec_install_handlers() fails with -ENODEV.
>>
>> 3. acpi_ec_setup() fails with -ENODEV.
>>
>> 4. acpi_ec_add() fails with -ENODEV.
>>
>> 5. Probe of seconds EC fails with -ENODEV.
>>
>> This might cause problems if the second EC is supposed to for example handle EC query events.
>> Of course if we only support a single EC, then this situation cannot happen.
> 
> This is kind of moot though until a system with 2 ECs is available.
> It is hard to say whether or not it is supported until it can be
> tested.

I do not believe that this is as theoretical as it sounds though.
If the ECDT and the DSDT disagree on the EC-s command_addr or
data_addr, then the check to re-use the boot_ec acpi_ec object
(struct acpi_ec *boot_ec) in acpi_ec_add() around line 1644:

                if (boot_ec && ec->command_addr == boot_ec->command_addr &&
                    ec->data_addr == boot_ec->data_addr) {

will fail and the separately allocated acpi_ec which "ec" points to at this
point will be kept around (rather then free-ed and replaced with the boot_ec).

And then when the below line runs on the newly allocated ec:

        ret = acpi_ec_setup(ec, device, true);

the newly allocated ec obj does not have EC_FLAGS_EC_HANDLER_INSTALLED set in
ec->flags so this acpi_ec_setup() call will call

               status = acpi_install_address_space_handler_no_reg(ec->handle,
                                                                  ACPI_ADR_SPACE_EC,
                                                                  &acpi_ec_space_handler,
                                                                  NULL, ec);

A second time. Now the above is from the old code and if we currently hit this
then the boot_ec acpi_install_address_space_handler_no_reg() call will have been
done with:

	ec->handle = ACPI_ROOT_OBJECT

and the second call for the not boot_ec matching DSDT EC will use the handle from
the DSDT EC.

Given how much quirks we have to deal with ECDT vs DSDT EC mismatches I'm pretty sure
that there is hw out there were we hit this path and atm we essentially treat that
as 2 ECs routing any OpRegion calls outside of the scope of the DSDT EC handle
to the boot_ec object and OpRegion calls any under the scope of the DSDT EC handle
to the regular "ec" object allocated in acpi_ec_add()

For such buggy hardware the old behavior can be preserved by passing which handle
to use for the acpi_install_address_space_handler_no_reg() call to acpi_ec_setup()
and pass ec->handle, rather then ACPI_ROOT_OBJECT when not re-using
the boot_ec in acpi_ec_add().

I think preserving the old behavior when we hit such buggy hw is the best thing
to do here. While at it we should probably also start logging a warning when
we hit this code path.

This does mean that we also need to keep acpi_ec.address_space_handler_holder
around for when unregistering the opregion handler.

Regards,

Hans



