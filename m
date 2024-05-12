Return-Path: <linux-acpi+bounces-5777-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 454588C372D
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 17:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE2B428143A
	for <lists+linux-acpi@lfdr.de>; Sun, 12 May 2024 15:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E092A1D7;
	Sun, 12 May 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGanWsrl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1686C134A9
	for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529329; cv=none; b=py6Im6ywLVy2KQfbWrh7cIMfm8UYIRgjPWx+kLFkStIsEatBeLavUIT/iU6BsltEQ9guDeTP9bYmaAYQ4sCx6gJZhnZxb6aIkYap+bTPq/YJGG3DDvUuZPiIaVTND5iQyolvduVcsB/IbFcIVtF6gEf5uCrxtd59TeCCwdoPdsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529329; c=relaxed/simple;
	bh=UNHdYxURJhJ7xPIkAVsM9wKCO9QDW4+ykfvHr3W+uiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx1PgHgBw0vwM+FhjKKY5MIxXq2nSNvEEqGGykjiYJxe20Q0SlEFOkKeP/HID2PK58JXumcwjIEVdyl+G5Bj06FMz3tKrz1k8uf/zyIZUO3rzCYyImGMq3YsVPr9Mhfbq8FhpxmQOiFiDVaNDn6b7y7Oq5Pn1rUOUhOMEKKY9Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NGanWsrl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715529327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKHt59TviHnsVG6oX16d4C5g4hFq5miS1rIIYT3+Dxs=;
	b=NGanWsrl+dTrZsha2+SqTcQdwrIpjynIUsK1PUvdl7owUFOlYroXfMuR8bFOlrOxQoVJz5
	tVSY7SxeDsVzqELJtyu2Aupj3xgXWMnx0SBl7b6gTkhLYaj28muFLb9/cNAZRe85Lw5bPT
	uoogWoA5Q96xW1MOJvHCJt72Qn3BbyY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-N_UPWED-MVGHtdW-ysXuCw-1; Sun, 12 May 2024 11:55:25 -0400
X-MC-Unique: N_UPWED-MVGHtdW-ysXuCw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34da8f1bf7cso2415114f8f.2
        for <linux-acpi@vger.kernel.org>; Sun, 12 May 2024 08:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715529324; x=1716134124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AKHt59TviHnsVG6oX16d4C5g4hFq5miS1rIIYT3+Dxs=;
        b=kQ6HzSTD94pMbdVNdy5NSrUw1izQPqHchmg5PaUDkvHS7CpLr8/rsvkm45B7gDtoFh
         /EpBLlhEOYO8VoITOPuxegKVlag7Kodez8oaJ5ecQYcHinK2uwoTHCaveF33XA5tlJyt
         C69ErU1QyKksyLPwOd016Vj7CjgID/O0LTOLwRBCiwWjaO4Fr60n4wG7kN8r/mKHRxS6
         l/Hxd7dv9N03pastPicM/G0HaTauWW4a1+U0pEs2r+PESTAN1IdcmZV2862KRPxykj00
         fba0i7J5x37L3Jxrk1c63oLDmK+DaGNgMic3BEp3YWwie1kZ3RpTt7hq12kJDNeZddra
         AgYA==
X-Forwarded-Encrypted: i=1; AJvYcCUmMpjgiDrdcG54q7WT3tIRMX6L+vHNCneKJNsQo6xra5mI6FFnqSEzVjNfpnWiviBdkKCKo6W5e7SJCw5kO/NvP9MQUCGSzcm07A==
X-Gm-Message-State: AOJu0YywgGaB10a/CnNZLEVyTx2Ha0Nd5PXC6X3PxaSb7PrqD7W7jICE
	qX/511pU4JCsPr9s0Nsqh1dhBh4UxX3kWaRY8inBwbUlQU71gXij9GTsp59yWgpMyaxS1PSm7ah
	RH5TIy6wDXJ1GuWm2PSXuAdLlSohkF/lkpC3K1gZsv0n6lzO8j2RWiFlfjqJfzqJdORjPMg==
X-Received: by 2002:a05:6000:551:b0:33e:c91a:127e with SMTP id ffacd0b85a97d-3504aa632eemr6300976f8f.63.1715529324020;
        Sun, 12 May 2024 08:55:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfDB9OfoubHipK6dK804KkqHmlfb8sfo+1QzWL+IuCti9m/3605D6me5gqqwsbjy+2O/6mWA==
X-Received: by 2002:a05:6000:551:b0:33e:c91a:127e with SMTP id ffacd0b85a97d-3504aa632eemr6300969f8f.63.1715529323672;
        Sun, 12 May 2024 08:55:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c822fsm469155066b.138.2024.05.12.08.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 08:55:23 -0700 (PDT)
Message-ID: <931a326f-3fd2-4126-a794-2157abad8568@redhat.com>
Date: Sun, 12 May 2024 17:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Andy Shevchenko <andy@kernel.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
 AceLan Kao <acelan.kao@canonical.com>
References: <20240218151533.5720-1-hdegoede@redhat.com>
 <CAAd53p6h3G-eHO=va11_YEODtmnpfxqhXpQ1xw3ZAKa3X5-ayQ@mail.gmail.com>
 <98f6e530-1f1b-4c4e-9f70-2f8dff74575b@redhat.com>
 <CAAd53p4r=+fUkmUm9dQWDm4uYhm7rgMESTtv=zZer5RB5oiHRw@mail.gmail.com>
 <ZjtJVpWvNuusC_O9@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZjtJVpWvNuusC_O9@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 5/8/24 11:43 AM, Andy Shevchenko wrote:
> On Wed, May 08, 2024 at 12:42:05PM +0800, Kai-Heng Feng wrote:
>> [+Cc AceLan]
>> On Wed, Apr 24, 2024 at 5:58 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>> On 4/24/24 10:04 AM, Kai-Heng Feng wrote:
>>>> On Sun, Feb 18, 2024 at 11:15 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> I recently learned that some Dell AIOs (1) use a backlight controller board
>>>>> connected to an UART. Canonical even submitted a driver for this in 2017:
>>>>> https://lkml.org/lkml/2017/10/26/78
>>>>>
>>>>> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
>>>>> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI device
>>>>> with an UartSerialBusV2() resource to model the backlight-controller.
>>>>>
>>>>> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration()
>>>>> to still create a serdev for this for a backlight driver to bind to
>>>>> instead of creating a /dev/ttyS0.
>>>>>
>>>>> Like other cases where the UartSerialBusV2() resource is missing or broken
>>>>> this will only create the serdev-controller device and the serdev-device
>>>>> itself will need to be instantiated by the consumer (the backlight driver).
>>>>>
>>>>> Unlike existing other cases which use DMI modaliases to load on a specific
>>>>> board to work around brokeness of that board's specific ACPI tables, the
>>>>> intend here is to have a single driver for all Dell AIOs using the DELL0501
>>>>> HID for their UART, without needing to maintain a list of DMI matches.
>>>>>
>>>>> This means that the dell-uart-backlight driver will need something to bind
>>>>> to. The original driver from 2017 used an acpi_driver for this matching on
>>>>> and binding to the DELL0501 acpi_device.
>>>>>
>>>>> AFAIK you are trying to get rid of having drivers bind directly to
>>>>> acpi_device-s so I assume that you don't want me to introduce a new one.
>>>>> So to get a device to bind to without introducing a new acpi_driver
>>>>> patch 2/2 if this series creates a platform_device for this.
>>>>>
>>>>> The creation of this platform_device is why this is marked as RFC,
>>>>> if you are ok with this solution I guess you can merge this series
>>>>> already as is. With the caveat that the matching dell-uart-backlight
>>>>> driver is still under development (its progressing nicely and the
>>>>> serdev-device instantation + binding a serdev driver to it already
>>>>> works).
>>>>
>>>> I was about to work on this and found you're already working on it.
>>>>
>>>> Please add me to Cc list when the driver is ready to be tested, thanks!
>>>
>>> I hope you have access to actual hw with such a backlight device ?
>>>
>>> The driver actually has been ready for testing for quite a while now,
>>> but the person who reported this backlight controller not being
>>> supported to me has been testing this on a AIO of a friend of theirs
>>> and this has been going pretty slow.
>>>
>>> So if you can test the driver (attached) then that would be great :)
>>>
>>> I even wrote an emulator to test it locally and that works, so
>>> assuming I got the protocol right from the original posting of
>>> the driver for this years ago then things should work.
>>>
>>> Note this depends on the kernel also having the patches from this
>>> RFC (which Rafael has already merged) applied.
>>
>> There are newer AIO have UID other than 0, like "SIOBUAR2".
>>
>> Once change the "0" to NULL in 'get_serdev_controller("DELL0501", "0",
>> 0, "serial0");', everything works perfectly.
>>
>> With that change,
>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Do we have tables with _UID set to 0?
> If so, we would need more complex approach.

passing NULL as uid argument to get_serdev_controller() makes it skip
the UID check altogether and there is no reaosn to expect the special
"DELL0501" HID to be attached to more then 1 uart, so this should be fine.

Regards,

Hans




