Return-Path: <linux-acpi+bounces-5772-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18018C3196
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 15:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674C61F216D5
	for <lists+linux-acpi@lfdr.de>; Sat, 11 May 2024 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F855101A;
	Sat, 11 May 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifrUf1RF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3D4437C
	for <linux-acpi@vger.kernel.org>; Sat, 11 May 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433621; cv=none; b=Wi3Hb0McAz3mJZfMeyrsiUm0yl3/n+UKuZWISQnRrA4NLqnfH1pnzuCmeeWyCULkuMdW9VW/BXVKL5ypE+NUYVFvmisRIfbpirLH7mgcpyf+1X/j2ImGxAEPH8wQJWpyLrN5j+8urCX2i3LD/O0V190AKoIRnmS3OXMhCL4PaZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433621; c=relaxed/simple;
	bh=lsNWZAstN6JklxmNj0EBWwa9HQ/+FmY6fWC0NwZcO90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hk5v7hdKdrT4UVY9PbwaNloiqstnusgAs/Sk3+hc1Le94VWj66Kv/gAYbbV5o4UJ77pC1mbH0ep7C5pl43t61B3oCE3spo4kvdpg5Fx7Hv7eO9FpwGlpJIacKi0zoMHRXMhN1FJfG5r8Obxvw/m7yR29lhJBNcuko6mdqJNlv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifrUf1RF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715433618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mso+ldaHS1MkbDb5MVSF1XQRwC68tdsJ+W0VpbFTGlc=;
	b=ifrUf1RFRZyJLfmkOJqZgntIDVYg4PT3E5X8qCFV280B6lgXxxfR1qwB15J3FYA/qoMSIo
	tGjq8yP75O7oJSB50DSDsqoP+wQbnk3by3kU+jhVdDin3J9dirBbC4Y2Qt6l6PlE6UdFrb
	69zZ7Bxhvl0T6y1nw8HaLS8r7Sdsqi0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-xjOrXTj5NxCD2hEYP31FMA-1; Sat, 11 May 2024 09:20:07 -0400
X-MC-Unique: xjOrXTj5NxCD2hEYP31FMA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-51b0eed7614so2190909e87.1
        for <linux-acpi@vger.kernel.org>; Sat, 11 May 2024 06:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715433606; x=1716038406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mso+ldaHS1MkbDb5MVSF1XQRwC68tdsJ+W0VpbFTGlc=;
        b=g2nWE7ofmQyLNIa8qEnMpldL6qTZXOeDXdzDQO4F3d+MBKc5cYKZDkGfBga5/l7XtI
         6MUmExNErKMTlobUPjCf+fVtOOXFdVhKqHXyW7+27MISXv9OP8WrEL+k+60qtOt7JcmN
         vNnuN7ptcX1VD/y1dWAfQFIl6hFlsmS8Gu3zfdBKkJSjlsLuilZQuMbgkNBxVPVT+S27
         mJ5Dqq/HXPH6ErJQ1lHmQY2QKshnO1i7nIsK5nZ/SFiDI7JS84/8nReJntzoLL3qrPAM
         b0CfgN+hR9y6XSh0l6+Jnmrv0kCZO6FV+N/3g4kIQ36+vg6RjDcCna5LtjVtunHN56v6
         RrQg==
X-Forwarded-Encrypted: i=1; AJvYcCVHF9f+R20SFuYlQutKAyRqycLsB6Zd2S0vd4S4nS7vHYyo+F82KRgL8TZR5FPgDRg2e7z7eDd2bFNpSwVXhouDsmilqmqL+V1dUQ==
X-Gm-Message-State: AOJu0YzvJHDxqENnFW4nxJaZ2mf8dfLro8T02N1aJ3IsFh4FKHzE5a3i
	3CRIyWE8UuKg/OChREraBmzxFymmUSLQUXyAKwXevAvaovTuPxiO/sO8PvbBYDLeYxgrIWb+h/F
	1pL+1DQl5C8fjEiGu0lMPzweFzwZrIUvKCpnxR+o7HCszsZz6yx5fPHJOMeo=
X-Received: by 2002:a05:6512:ea0:b0:520:676a:7322 with SMTP id 2adb3069b0e04-52210278595mr5525477e87.46.1715433606029;
        Sat, 11 May 2024 06:20:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsnp+I/y1GS9oFbumrTx3SogsZQH0L3T84s1uJaWdQKIqBrvfQTdixxg1HhEWDu2dNR8h+Gg==
X-Received: by 2002:a05:6512:ea0:b0:520:676a:7322 with SMTP id 2adb3069b0e04-52210278595mr5525464e87.46.1715433605598;
        Sat, 11 May 2024 06:20:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b01501sm323183366b.165.2024.05.11.06.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 06:20:04 -0700 (PDT)
Message-ID: <b0d72461-c483-4b92-9e38-c14dc39c7e2e@redhat.com>
Date: Sat, 11 May 2024 15:20:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
 <27722d8b-ecdc-40d4-af47-8150a8a0a2e6@redhat.com>
 <87c1a667-b0cc-46b7-b7a8-2baead94e456@gmx.de>
 <CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 5/10/24 12:03 PM, Rafael J. Wysocki wrote:
> On Fri, May 10, 2024 at 12:32 AM Armin Wolf <W_Armin@gmx.de> wrote:
>>
>> Am 09.05.24 um 12:35 schrieb Hans de Goede:
>>
>>> Hi Rafael,
>>>
>>> On 5/8/24 2:50 PM, Rafael J. Wysocki wrote:
>>>> [Resending because it appears to have got lost, sorry for duplicates.]
>>>>
>>>> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
>>>>> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
>>>>>> Hi,
>>>>>>
>>>>>> On Mon, Apr 29, 2024 at 4:55 PM Heikki Krogerus
>>>>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> There's a bug that is caused by an EmbeddedControl OpRegion which is
>>>>>>> declared inside the scope of a specific USB Type-C device (PNP0CA0):
>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218789
>>>>>> And in this bug you are essentially proposing to install the EC
>>>>>> OpRegion handler at the namespace root instead of the EC device.
>>>>>>
>>>>>> This sounds reasonable, although AFAICS this is a matter of modifying
>>>>>> the EC driver (before the EC OpRegion handler is installed by the EC
>>>>>> drvier, ACPICA has no way to handle EC address space accesses anyway).
>>>>>>
>>>>>>> It looks like that's not the only case where that OpRegion ID is used
>>>>>>> outside of the EC device scope. There is at least one driver in Linux
>>>>>>> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
>>>>>>> for the EmbeddedControl OpRegion, and based on a quick search, the
>>>>>>> problem "Region EmbeddedControl (ID=3) has no handler" has happened
>>>>>>> with some other devices too.
>>>>>> AFAICS, installing the EC address space handler at the EC device
>>>>>> object itself is not based on any sound technical arguments, it's just
>>>>>> been always done this way in Linux.  It's quite possible that the EC
>>>>>> address space handler should have been installed at the namespace root
>>>>>> from the outset.
>>>>> Okay, thank you for the explanation. So can we simply change it like
>>>>> this (I may have still misunderstood something)?
>>>> Roughly speaking, yes, but it is missing an analogous change around
>>>> the removal.
>>>>
>>>> Please see the appended patch (which I have created independently in
>>>> the meantime).  It doesn't break stuff for me and Andy points out that
>>>> there are examples of EmbeddedControl OpRegions outside the EC device
>>>> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
>>>>
>>>> So I think that this change can be made relatively safely (but adding Hans and
>>>> Mario to the CC in case they know something that might be broken by it).
>>> +Cc Armin for WMI EC handler
>>>
>>> No objections from me against registering the EC handler at the root,
>>> when I saw that the WMI driver was registering its own handler I was
>>> already wondering why we did not just register the acpi/ec.c handler at
>>> the root level but I did not have time to pursue this further.
>>>
>>> One question which I have is does the drivers/acpi/ec.c version handle
>>> read/writes of a width other then 8 bits ? Armin recently added support
>>> for other widths to the WMI version of the OpRegion handler to fix
>>> issues on some laptop models:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c663b26972eae7d2a614f584c92a266fe9a2d44c
>>>
>>> Regards,
>>>
>>> Hans
>>
>> Hi,
>>
>> the handling of multi-byte reads/writes was taken from the ec driver itself, so
>> using the standard ec handler should make no difference for the WMI driver.
> 
> Thanks for the confirmation!
> 
> So AFAICS acpi_wmi_ec_space_handler() will not be necessary after this
> change, but so long as it is installed by acpi_wmi_probe(), it will be
> used for opregions in the WMI device scope, so I'd prefer to remove it
> in a separate patch to avoid making too many changes in one go.

Ack.

> Let me add a changelog to the patch posted here
> 
> https://lore.kernel.org/linux-acpi/5781917.DvuYhMxLoT@kreacher/
> 
> and submit it properly along with a separate change removing
> acpi_wmi_ec_space_handler().

This sounds good to me.

Regards,

Hans



