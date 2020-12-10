Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36612D5EE9
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 16:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389334AbgLJPDX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Dec 2020 10:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389357AbgLJPDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 10:03:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D50C0613CF
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 07:02:34 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id w5so2061991wrm.11
        for <linux-acpi@vger.kernel.org>; Thu, 10 Dec 2020 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yIMMRnTxBZlC4YZJNFdYJ6J7cbSwJ7RU5QdF2zpUpmQ=;
        b=nadSjWgPLRXQEPJf4uRXLGEuAVn4mQmsEHxeEMxOB0nC45tkbS8+jLNhUCi4KGtWaa
         Irn9EgFsSH4vKuhqq+uxzYcqNUP7NK18APa6h9MtoQgTGfTBxoya5iSYsyTEvx2t+eVX
         gD625nwjbMF2sqDz0Sx/5K/ATyW2+6g3g+n/hzqEUguxf6PmfYAmaYZ7x14jpyeerVg4
         ooIQfNPgvJrcw2wM+eg6bvGdAtRljclqFBs35lLzgQUlSqC8RZg8JSiTzhxgKn0D0Hrg
         6nk7s1kDTCWPv6bmP8Jx+APG4LSOwJDbVw9Ot9M/OW8lH7Zpew+AFl/JD6HzcpDBbKlL
         7/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yIMMRnTxBZlC4YZJNFdYJ6J7cbSwJ7RU5QdF2zpUpmQ=;
        b=DFW2CeOz0xBBcPxg4wXxbXWKxYFO+rxYmiySBDWI+NR51G0WaqlFbppYT/Rxn//uF6
         fd+HL6DOvsiYUanjpVku1AL25SV/H1qxqR0b3HN3F6ZeOzuZ7zQR0Hvz5l7iVXfehK/a
         2GiCpjsowmaeQUj5Bqenzvte6sDMtjoCS8hvc07tOLqNZxleet6RPzxEsG6/UTjM/gcp
         5Ho9dIR+kH43xL2tqM34fjkbvp+e7agFnxyb5Ey72yVbDOTNiyXP7FkI3dhzBT80AQUG
         iXGmE7e1ls2mvtcO13qACe+NnYjpAKGrMEmGot9Zl4Tk4ZM3uWDqO2QrfFhiw1Nn4IR/
         8FFg==
X-Gm-Message-State: AOAM53019InDK5vg9bPW/ntTmlCUEeJv4gFi743kJwsd5blK0mcbun2M
        XHHI0n6pBdU4C1v1lYIvEMd9Ad1qpdAhfQ==
X-Google-Smtp-Source: ABdhPJx6xcUsXNMK1FiGlD46acqovWrmJ0F8nIjv9JMONCBu1akvk5+hLW0NYmSJp4snNWuH5PUm2A==
X-Received: by 2002:adf:b194:: with SMTP id q20mr8839193wra.199.1607612553469;
        Thu, 10 Dec 2020 07:02:33 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id i16sm8793466wrx.89.2020.12.10.07.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Dec 2020 07:02:32 -0800 (PST)
Subject: Re: acpi_device_notify() binding devices that don't seem like they
 should be bound
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>
References: <1409ba0c-1580-dc09-e6fe-a0c9bcda6462@gmail.com>
 <858bb2b0-e2b4-f0d4-0088-7106fec3cb8f@gmail.com>
 <9a9c176c-8991-cd12-d2da-34114a9d1aca@gmail.com>
 <CAJZ5v0gsAP1k2ej_5mgK5P_2rLn_GeMbjX9=-BG_die-6WmitA@mail.gmail.com>
 <529a22f7-52ba-f87d-f82b-8f94e1637ca9@gmail.com>
 <CAJZ5v0jy=WecHEQFzfu++uENWerHf5GqfwZMYNjQ2V=H7Geq8Q@mail.gmail.com>
 <7a2358bb-cd8c-83ec-51de-14947fc0e307@gmail.com>
 <CAJZ5v0hCcrX=EFjU6RfH-=twvrv3zzCorJPqOiKVuYGjsx403A@mail.gmail.com>
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <19c50e96-a102-add9-1812-85b8e7d62a0e@gmail.com>
Date:   Thu, 10 Dec 2020 15:02:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0hCcrX=EFjU6RfH-=twvrv3zzCorJPqOiKVuYGjsx403A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 10/12/2020 13:53, Rafael J. Wysocki wrote:
> On Thu, Dec 10, 2020 at 1:06 AM Daniel Scally <djrscally@gmail.com> wrote:
>> On 09/12/2020 16:53, Rafael J. Wysocki wrote:
>>> On Wed, Dec 9, 2020 at 5:20 PM Daniel Scally <djrscally@gmail.com> wrote:
>>>> Hi Rafael
>>>>
>>>> On 09/12/2020 15:43, Rafael J. Wysocki wrote:
>>>>> On Wed, Dec 9, 2020 at 10:55 AM Daniel Scally <djrscally@gmail.com> wrote:
>>>>>> On 08/12/2020 23:48, Daniel Scally wrote:
>>>>>>> Hello again
>>>>>>>
>>>>>>> On 06/12/2020 00:00, Daniel Scally wrote:
>>>>>>>> INT3472:08 is not an acpi device that seems to be a good candidate for
>>>>>>>> binding to 0000:00:00.0; it just happens to be the first child of
>>>>>>>> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
>>>>>>>>
>>>>>>>> The comment within acpi_find_child_device() does imply that there should
>>>>>>>> only ever be a single child device with the same _ADR as the parent, so
>>>>>>>> I suppose this is possibly a case of poor ACPI tables confusing the code
>>>>>>>> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
>>>>>>>> set to zero (as indeed do the machine's cameras), but I'm not
>>>>>>>> knowledgeable enough on ACPI to know whether that's to spec (or at least
>>>>>>>> accounted for). The INT3472 devices themselves do not actually seem to
>>>>>>>> represent a physical device (atleast, not in this case...sometimes they
>>>>>>>> do...), rather they're a dummy being used to simply group some GPIO
>>>>>>>> lines under a common _CRS. The sensors are called out as dependent on
>>>>>>>> these "devices" in their _DEP method, which is already a horrible way of
>>>>>>>> doing things so more broken ACPI being to blame wouldn't surprise me.
>>>>>>>>
>>>>>>>> The other problem that that raises is that there seems to be _no_ good
>>>>>>>> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
>>>>>>>> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
>>>>>>>> entries and the machine's cameras.
>>>>>>> After some more reading, I'm pretty confident that this is the problem
>>>>>>> now - I.E. that those devices having _ADR of 0 is what's causing this
>>>>>>> issue to materialise, and that those values should be set to something
>>>>>>> more appropriate. Still unsure about the best approach to fix it though
>>>>>>> from a kernel point of view; there doesn't seem to be anything out of
>>>>>>> whack in the logic, and I believe (correct me if I'm wrong) there can be
>>>>>>> legitimate instances of child devices sharing _ADR=0 with the parent, so
>>>>>>> the problem becomes how to identify the illegitimate instances so that
>>>>>>> they can be discarded. My experience in this is really limited, so I
>>>>>>> lean towards the conclusion that hard-coding exceptions somewhere might
>>>>>>> be necessary to handle this without resorting to patched ACPI tables.
>>>>>>> Whether that's within acpi_find_child_device() to prevent matching
>>>>>>> occurring there, or else setting the adev->pnp.bus_address to some
>>>>>>> alternate value after creation to compensate.
>>>>>>>
>>>>>>> I recognise that that's a horrible answer though, so I'm really hoping
>>>>>>> that someone has an idea for how to handle this in a better way.
>>>>>> Oops, missed this crucial line from the spec:
>>>>>>
>>>>>> "A device object must contain either an _HID object or an _ADR object,
>>>>>> but should not contain both."
>>>>>>
>>>>>> And here's the Device declaration for these objects:
>>>>>>
>>>>>>         Device (PMI0)
>>>>>>         {
>>>>>>             Name (_ADR, Zero)  // _ADR: Address
>>>>>>             Name (_HID, "INT3472")  // _HID: Hardware ID
>>>>>>             Name (_CID, "INT3472")  // _CID: Compatible ID
>>>>>>             Name (_DDN, "INCL-CRDD")  // _DDN: DOS Device Name
>>>>>>             Name (_UID, Zero)  // _UID: Unique ID
>>>>>>
>>>>>> So that's the broken part rather than the _ADR value of 0 specifically.
>>>>>> That at least gives a jumping off point for some logic to fix rather
>>>>>> than a hardcoded anything, so I'll try to work out a nice way to handle
>>>>>> that (probably ignoring adevs in acpi_find_child_device() with addr=0
>>>>>> and a valid _HID) and submit a patch.
>>>>> Please see the comment in find_child_checks(), though - it kind of
>>>>> tries to handle this case already.
>>>> It down-weights them currently yes, but does still allow them to match.
>>>> I think it makes more sense to not allow a match at all, at least in the
>>>> situation I've encountered, but I suppose the implication of the logic
>>>> in this check is that at some point we've encountered ACPI entries with
>>>> both _HID and _ADR that were potentially correct matches, which kinda
>>>> re-complicates things again.
>>> That's correct.
>> OK, that definitely makes it harder then. Sort of clutching at straws
>> here; is _ADR=0 a special case in any way? As far as I can tell it's
>> only a problem on my devices for that address but that could easily be
>> coincidence.
>>>>> I guess what happens is that _STA is not present under the device that
>>>>> is expected to be matched, so maybe the logic regarding this may be
>>>>> changed somewhat.
>>>> Hmm yeah I guess so, so this is kinda a combination of two problems
>>>> probably. And if the actual device that is expected to match had a _STA
>>>>> 0 then presumably the down-weighting of devices with a _HID in
>>>> find_child_checks() would ensure the correct dev was matched.
>>> That's the intended outcome.
>>>
>>> We may need another value (between the min and the max) to return when
>>> adev->pnp.type.platform_id is not set and _STA is not present.
>>
>> Unfortunately this turns out not to be the problem in this case; on
>> checking for _STA too, all the potential devices except the 2 cameras
>> and their dependee PMICs have a _STA present but set 0,
> Which means that they shouldn't be used.
>
>> so find_child_checks() throws -ENODEV; and downweights them below the devs
>> that shouldn't match.
> OK, so we want acpi_find_child_device() to return NULL in this case.
>
> What about making it return NULL if there is a matching device with
> _ADR and without _HID that is unusable (ie. _STA == 0)?

All the adevs with matching _ADR also have both _STA and _HID
unfortunately. Sorry; let me stop half-arsing this and show you
something useful:


[    0.219953] acpi_find_child_device(PNP0A08:00, 0x00, false)
[    0.220818] INT3472:00: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220821] INT3472:01: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220870] INT3472:02: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220892] INT3472:03: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220916] INT3472:04: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220941] INT3472:05: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220965] INT3472:06: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.220990] INT3472:07: _STA 0x00, _ADR=0x00000000, _HID=INT3472
[    0.221038] INT3472:08: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
[    0.221051] OVTI5648:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI5648
[    0.221061] INT3472:09: _STA 0x0f, _ADR=0x00000000, _HID=INT3472
[    0.221070] OVTI2680:00: _STA 0x0f, _ADR=0x00000000, _HID=OVTI2680
[    0.221079] INT3471:00: _STA 0x00, _ADR=0x00000000, _HID=INT3471
[    0.221105] INT33BE:00: _STA 0x00, _ADR=0x00000000, _HID=INT33BE
[    0.221130] INT3471:01: _STA 0x00, _ADR=0x00000000, _HID=INT3471
[    0.221156] INT33BE:01: _STA 0x00, _ADR=0x00000000, _HID=INT33BE


That's the debug output I included for each adev that's assessed as a
child of PNP0A08:00. _STA, _ADR and _HID present for all, _ADR 0x00 for
all, _STA 0x0f for the 2 sensors and their PMIC's and 0x00 for the rest.
The same situation holds on both of my devices.

