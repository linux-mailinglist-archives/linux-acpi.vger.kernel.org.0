Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300082D4F33
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Dec 2020 01:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgLJAHH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 19:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgLJAHH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2020 19:07:07 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CD9C0613CF
        for <linux-acpi@vger.kernel.org>; Wed,  9 Dec 2020 16:06:26 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id t16so3625838wra.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Dec 2020 16:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tjy1LWLIP+McMwNCb3WLGa4VfmcITsR9rybIXlWcX2s=;
        b=fagVm3x2xiJ3Bd/0sLGbXKx3AxS/Z6V1QZPhK2RTK8y2jWOQkweiAxW9eFLZOOUhsA
         6Ewpwaw4rimeBhu9kpambL3KbH1UwAIMDW1uF2+uPqAlMmidRMooazUdaNhDRYYgc0go
         s80w4Gjq990eRp3URrOMbV6MHziYcD95yBuUXfRfH6XJQqq2Mx7oQavq2+QaONQqDH8j
         oDERokVSEyXfayQN1iJLg/ixeFWdJoYGEhqZ1YT4Y2fDTWcwK2Qk+QyxPFq3CpN6G1G1
         gdoCXHINEuyHmfZGyoxR1J9cFbtBzRD0uTcywhLEQQNk5rbuuYyImTWVarkJP2/3yq/Y
         y8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tjy1LWLIP+McMwNCb3WLGa4VfmcITsR9rybIXlWcX2s=;
        b=pTnm7jXEDcVTgIoqgvk3UQlvqRLwLZTBI9eeHVHP9wG/Z2dFzQbxi83oKDE/rKS+vE
         ClG0NBGNThVUQSTdF7VxgzYDzYtjNBaBbfx8qkb83GjUGUZOlkE5sOjiGcL8np2kwA6k
         W12+gJ6umZWs53/xwv3WA8NG35DHJfrI4VXvozRWmzm1yt3n4vaT8sh0jDq+I/Z2+8I6
         OIFnHp+HMwiq9jQlG5veP/86S+v4+c2fAx9M1dfuu5euNhRFOA/O2o4Z0n83CkDw3rTN
         QGqVkPWAPetA+JWUx4sG3/tOPNgPig+0lOWDikt5M+v0fjqEg7OjcR03vutxwz02Svyt
         /UsQ==
X-Gm-Message-State: AOAM530aGAgct7XdEEzDG3TYC4fZUetYHA1xXVWOwmvV/44Jcwni2cvm
        eQprW4c8amqog3FEWrZpaj2cj2KccxOfgQ==
X-Google-Smtp-Source: ABdhPJyndRCALHabHnoEBYAPMEf/ofNQ01ytdMztj+rXMzvNay60ByW0MpAWCB+SBh+tHpx4e3CQaw==
X-Received: by 2002:adf:a2ce:: with SMTP id t14mr5409062wra.308.1607558785590;
        Wed, 09 Dec 2020 16:06:25 -0800 (PST)
Received: from [192.168.1.211] ([2.29.208.56])
        by smtp.gmail.com with ESMTPSA id z8sm6311614wmg.17.2020.12.09.16.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Dec 2020 16:06:24 -0800 (PST)
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
From:   Daniel Scally <djrscally@gmail.com>
Message-ID: <7a2358bb-cd8c-83ec-51de-14947fc0e307@gmail.com>
Date:   Thu, 10 Dec 2020 00:06:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jy=WecHEQFzfu++uENWerHf5GqfwZMYNjQ2V=H7Geq8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 09/12/2020 16:53, Rafael J. Wysocki wrote:
> On Wed, Dec 9, 2020 at 5:20 PM Daniel Scally <djrscally@gmail.com> wrote:
>> Hi Rafael
>>
>> On 09/12/2020 15:43, Rafael J. Wysocki wrote:
>>> On Wed, Dec 9, 2020 at 10:55 AM Daniel Scally <djrscally@gmail.com> wrote:
>>>>
>>>> On 08/12/2020 23:48, Daniel Scally wrote:
>>>>> Hello again
>>>>>
>>>>> On 06/12/2020 00:00, Daniel Scally wrote:
>>>>>> INT3472:08 is not an acpi device that seems to be a good candidate for
>>>>>> binding to 0000:00:00.0; it just happens to be the first child of
>>>>>> PNP0A08:08 that shares _ADR 0 and has _STA not set to 0.
>>>>>>
>>>>>> The comment within acpi_find_child_device() does imply that there should
>>>>>> only ever be a single child device with the same _ADR as the parent, so
>>>>>> I suppose this is possibly a case of poor ACPI tables confusing the code
>>>>>> a bit; given both PNP0A08:00 and _all_ of the INT3472 devices have _ADR
>>>>>> set to zero (as indeed do the machine's cameras), but I'm not
>>>>>> knowledgeable enough on ACPI to know whether that's to spec (or at least
>>>>>> accounted for). The INT3472 devices themselves do not actually seem to
>>>>>> represent a physical device (atleast, not in this case...sometimes they
>>>>>> do...), rather they're a dummy being used to simply group some GPIO
>>>>>> lines under a common _CRS. The sensors are called out as dependent on
>>>>>> these "devices" in their _DEP method, which is already a horrible way of
>>>>>> doing things so more broken ACPI being to blame wouldn't surprise me.
>>>>>>
>>>>>> The other problem that that raises is that there seems to be _no_ good
>>>>>> candidate for binding to 0000:00:00.0 that's a child of PNP0A08:00 - the
>>>>>> only devices sharing _ADR 0 and having _STA != 0 are those two INT3472
>>>>>> entries and the machine's cameras.
>>>>> After some more reading, I'm pretty confident that this is the problem
>>>>> now - I.E. that those devices having _ADR of 0 is what's causing this
>>>>> issue to materialise, and that those values should be set to something
>>>>> more appropriate. Still unsure about the best approach to fix it though
>>>>> from a kernel point of view; there doesn't seem to be anything out of
>>>>> whack in the logic, and I believe (correct me if I'm wrong) there can be
>>>>> legitimate instances of child devices sharing _ADR=0 with the parent, so
>>>>> the problem becomes how to identify the illegitimate instances so that
>>>>> they can be discarded. My experience in this is really limited, so I
>>>>> lean towards the conclusion that hard-coding exceptions somewhere might
>>>>> be necessary to handle this without resorting to patched ACPI tables.
>>>>> Whether that's within acpi_find_child_device() to prevent matching
>>>>> occurring there, or else setting the adev->pnp.bus_address to some
>>>>> alternate value after creation to compensate.
>>>>>
>>>>> I recognise that that's a horrible answer though, so I'm really hoping
>>>>> that someone has an idea for how to handle this in a better way.
>>>> Oops, missed this crucial line from the spec:
>>>>
>>>> "A device object must contain either an _HID object or an _ADR object,
>>>> but should not contain both."
>>>>
>>>> And here's the Device declaration for these objects:
>>>>
>>>>         Device (PMI0)
>>>>         {
>>>>             Name (_ADR, Zero)  // _ADR: Address
>>>>             Name (_HID, "INT3472")  // _HID: Hardware ID
>>>>             Name (_CID, "INT3472")  // _CID: Compatible ID
>>>>             Name (_DDN, "INCL-CRDD")  // _DDN: DOS Device Name
>>>>             Name (_UID, Zero)  // _UID: Unique ID
>>>>
>>>> So that's the broken part rather than the _ADR value of 0 specifically.
>>>> That at least gives a jumping off point for some logic to fix rather
>>>> than a hardcoded anything, so I'll try to work out a nice way to handle
>>>> that (probably ignoring adevs in acpi_find_child_device() with addr=0
>>>> and a valid _HID) and submit a patch.
>>> Please see the comment in find_child_checks(), though - it kind of
>>> tries to handle this case already.
>> It down-weights them currently yes, but does still allow them to match.
>> I think it makes more sense to not allow a match at all, at least in the
>> situation I've encountered, but I suppose the implication of the logic
>> in this check is that at some point we've encountered ACPI entries with
>> both _HID and _ADR that were potentially correct matches, which kinda
>> re-complicates things again.
> That's correct.
OK, that definitely makes it harder then. Sort of clutching at straws
here; is _ADR=0 a special case in any way? As far as I can tell it's
only a problem on my devices for that address but that could easily be
coincidence.
>>> I guess what happens is that _STA is not present under the device that
>>> is expected to be matched, so maybe the logic regarding this may be
>>> changed somewhat.
>> Hmm yeah I guess so, so this is kinda a combination of two problems
>> probably. And if the actual device that is expected to match had a _STA
>>> 0 then presumably the down-weighting of devices with a _HID in
>> find_child_checks() would ensure the correct dev was matched.
> That's the intended outcome.
>
> We may need another value (between the min and the max) to return when
> adev->pnp.type.platform_id is not set and _STA is not present.


Unfortunately this turns out not to be the problem in this case; on
checking for _STA too, all the potential devices except the 2 cameras
and their dependee PMICs have a _STA present but set 0, so
find_child_checks() throws -ENODEV; and downweights them below the devs
that shouldn't match.

