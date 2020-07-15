Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF006220A1B
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jul 2020 12:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbgGOKgS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Jul 2020 06:36:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728781AbgGOKgR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jul 2020 06:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594809375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wiSCBjycVCPv8/N9BMr3/gyuicD7ppAVVyblKxMHKUw=;
        b=a0QCKKB243YckFSdNJISJ5rkLkjdqHiBgGweqzs5GhzdZlukfEt9M8BklpFx6mcXwh4Uyu
        f+Wk3pMEqYSOIEQGcbertgCtw3eCei/vo0gudGM54p3ki9P0ahulHnlgWJlfw3/QRUyxn4
        cUfQ7U98eszPTMjIeTkH+SWhZsF2vpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-zCmOfhS-PaWkDE8b56MEnA-1; Wed, 15 Jul 2020 06:36:13 -0400
X-MC-Unique: zCmOfhS-PaWkDE8b56MEnA-1
Received: by mail-ej1-f69.google.com with SMTP id y10so568018ejd.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Jul 2020 03:36:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wiSCBjycVCPv8/N9BMr3/gyuicD7ppAVVyblKxMHKUw=;
        b=JcbUa6uFcpoY+fPutm/Flk/9grd7Y551PXUt1wXCYQCixsC7JLifhdM0fYWkngOOJl
         giTjLbh32BnUrnEFNK7JKs0KpoWPRMDXcNUDaYwgB20DoNcoRoWNzatVrG4N6Y+6Rbq/
         OeDf5KDS0rwUKbrQcqMBp5+sNEe6Q4t7WW/Agh1scTDjybK38mHs6zGhVP4je3TgWNO/
         NvOVBAuLnVx1m2RXz/QbeGWFr+U3U9GEbYb0u1iIrGgIKPV8EMthDHV9jNRbCsOVv1pG
         c2hFxTD1Xu4TDSaVGMDXkYbtSOagOGmyo8VL59NF6AGBXyNX7V4z21yxFP6g6CR48kRa
         krPg==
X-Gm-Message-State: AOAM531MsEkcdNAs82hOZyi30Xf0QSH/C/N5t0yK7uLIRYCaeJUJgB2j
        6nH+tAqFqRoIDi8gk9vy5pVp5bLwuizd8zDO0neyCERNPftAXNZIG1Y0ClbhmtsimDHoGSjFol3
        PLNu6Hpt65OsQG8WvzSyTqg==
X-Received: by 2002:a50:8143:: with SMTP id 61mr9054628edc.202.1594809372308;
        Wed, 15 Jul 2020 03:36:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXSyvdbbV1stEpburXx1M/4JSQ67jKGWeZ3uoy3q2JOBfL70S3cXSjlUPWmSkeY6OTJEgteA==
X-Received: by 2002:a50:8143:: with SMTP id 61mr9054615edc.202.1594809372104;
        Wed, 15 Jul 2020 03:36:12 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id l22sm1663826ejr.98.2020.07.15.03.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 03:36:11 -0700 (PDT)
Subject: Re: [Bug 1854502] New: Noticeably Increased CPU temperature
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
References: <bug-1854502-8448@https.bugzilla.redhat.com/>
 <9b3d85b5-b562-631f-adfd-6460bc6c4179@redhat.com>
 <CAJZ5v0gO7b8X6MMDO_UvGBc-PNH-o=U47+MuS1uk4E_tSF-Ogg@mail.gmail.com>
 <db2b75b7-afc9-7a44-762f-2a4ebd63b4ee@redhat.com>
 <e330796c-fbad-c8d9-f334-c2e5bf156d3f@redhat.com>
Message-ID: <30f6f9ca-24ce-fef0-8c33-3581d959d09b@redhat.com>
Date:   Wed, 15 Jul 2020 12:36:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <e330796c-fbad-c8d9-f334-c2e5bf156d3f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 7/10/20 2:35 PM, Hans de Goede wrote:
> Hi,
> 
> On 7/9/20 2:31 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 7/7/20 5:43 PM, Rafael J. Wysocki wrote:
>>> Hi Hans,
>>>
>>> On Tue, Jul 7, 2020 at 5:32 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> I got a copy of the below bugreport in my mailbox and I
>>>> was wondering if this rings any bells.
>>>>
>>>> Are there any relevant power-management / scheduler
>>>> changes in 5.7 (vs 5.6) which might be related?
>>>
>>> There were a few, but I'm not sure how they can cause thermal issues to happen.
>>>
>>>> And is there any quick way for the reporter to test this
>>>> (by e.g. picking a different scheduler / cpufreq-governor).
>>>
>>> Well, as usual, I would recommend looking for possible configuration
>>> differences between the good and bad cases, ie. different default
>>> governors, different cpufreq/cpuidle drivers etc.
>>>
>>> Also, if the system is Intel-based, run turbostat to collect CPU PM
>>> information for both the good and bad cases.
>>
>> Ok I've asked the user to run some tests and provide powertop
>> and turbostat outputs for both the cold and hot cases.
>>
>> I will follow-up on this when I know more.
> 
> Ok, I've asked the user to gather the necessary info. He has collected
> screenshots from both powertop and turbostat under both 5.6 (with the
> CPU staying cool) and with 5.7 (where the CPU runs a bit hot) both with
> the system fully idle.
> 
> The screenshots are attached to the bug as a tarbal:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1854502
> 
> I've never looked at turbostat output before so I do not know what
> I'm looking for there. But the powertop output does show a significant
> difference.
> 
> On the powertop overview page we can see that 5.7 has slightly less
> wakeup then 5.6 (probably just normal variation) but despite this,
> the "idle stats" page shows that under 5.6 we get 90/91% C7 residency,
> where as 5.7 only reaches 85%, that seems like a significant difference
> to me. IOW the CPU is in a higher powerstae (consuming more power) for
> 15% of the time with 5.6, vs 10% with 5.7.
> 
> Note that this users system is somewhat customized, he is using
> bumblebee with the nvidia binary driver to run games, while
> using the i915 gfx for his normal desktop stuff. Doing his
> tests no apps are running using the nvidia GPU and in both
> cases the nvidia GPU is powered-down (according to the /proc/...
> info).
> 
> He is also using TLP and some utility to undervolt the GPU. None
> of this seems to explain the C7 residency difference though, so
> despite his non-standard setup it would be good (IMHO) to still
> see if we can try to root-cause that.

The user just reported in bugzilla that the issue is gone with
5.7.8, not sure what fixed it. But now there is no need to look into
this anymore.

Regards,

Hans

