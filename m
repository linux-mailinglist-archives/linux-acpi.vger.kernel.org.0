Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DBB28CEEC
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Oct 2020 15:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbgJMNJg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 13 Oct 2020 09:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45716 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728388AbgJMNJg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 13 Oct 2020 09:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602594573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYoLERdYqiwrge/RFON654uxOf57ox4XJoSTutIfBEg=;
        b=U6gaj6dAq28b62jh4h3RoLCfewOqgIFR526ZQK/5FICMyRK5B13LsZlRWQE0XnL4e3pzg6
        0o6U9h9arxmXNE/Ezze1S+S+ks6XzzAhFdiMp+acatFyF/NnbtNDs+0oYAuTtj7VvveB9u
        k9C03NMs25ZohANByzxSrL/BxXNV8dM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-492-gQeB1ZVzPRS0iivJf1UMdg-1; Tue, 13 Oct 2020 09:09:31 -0400
X-MC-Unique: gQeB1ZVzPRS0iivJf1UMdg-1
Received: by mail-ed1-f71.google.com with SMTP id a15so7614152eda.15
        for <linux-acpi@vger.kernel.org>; Tue, 13 Oct 2020 06:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pYoLERdYqiwrge/RFON654uxOf57ox4XJoSTutIfBEg=;
        b=ifKfhWoGz+Ti4WxKjfnWTjRhnl7b6vUCi8x58lt55/OFSV03Ie3ovD4GnGYdXtCWQ6
         Umk/DM1yrNQLqhGX6GS1nyGDosTdGYcMyHTXZVa+GpmlHrY+5c+qdP32wZ5Uzsj9sz/L
         lmmxzxvNgP8cb0mecO1G33n3j39CF8RkoHzyleU509XQpiQodO6AAZC5DcqonZU7mIlP
         q3/9VmMhc+QwHkKZ+z0prYc35PXO02kWdFkyBd1ZTK2zTvSMQhM2QjVK4uf5Ob/N6+u0
         xZCKzKrRPbWS3XdSSKOziWAm/08foL62Qzb3+jhXxPDjVYoCqQUieP70qgEwSkmu6q8O
         3C6w==
X-Gm-Message-State: AOAM5315EH/By69pWT5pdFm1xOVNg25Ba693pGMxt8KTGB0f4zbIypwj
        cJpzJequTHYODXIEN2TrmqiS4iI9lr7jyRkIyMqUatxF9ciqZo3DzLD6bX7RDaEhbXsDROcOX2P
        DCqnHOG2K+3SuvKyhUlO1Fg==
X-Received: by 2002:a17:906:118f:: with SMTP id n15mr34324102eja.394.1602594568843;
        Tue, 13 Oct 2020 06:09:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFofbCot5FjJJsFvPWfb0b6xBdK/KZ7WESdzyrT4ROUQd91ZTi1Jm0bhyA7VHl9b2jiU1qjQ==
X-Received: by 2002:a17:906:118f:: with SMTP id n15mr34324068eja.394.1602594568470;
        Tue, 13 Oct 2020 06:09:28 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id sd18sm12116119ejb.24.2020.10.13.06.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 06:09:27 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Pearson <markpearson@lenovo.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
 <DM6PR19MB26364E6AA2F51981F592CE58FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <c73ffad8fd6bff8ff20d91930b097bff82be1c8f.camel@hadess.net>
 <DM6PR19MB2636B067186B08B744EA2163FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <CAJZ5v0jBJBTTb3qBGH0UWOAfvY24gWqJQA=MahnhaTdMu-w0Bw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <394f897a-4dac-7016-ea17-c37b67589e07@redhat.com>
Date:   Tue, 13 Oct 2020 15:09:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jBJBTTb3qBGH0UWOAfvY24gWqJQA=MahnhaTdMu-w0Bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/12/20 6:42 PM, Rafael J. Wysocki wrote:
> On Wed, Oct 7, 2020 at 8:41 PM Limonciello, Mario
> <Mario.Limonciello@dell.com> wrote:
>>
>>> On Wed, 2020-10-07 at 15:58 +0000, Limonciello, Mario wrote:
>>>>
>>>>> On Mon, 2020-10-05 at 12:58 +0000, Limonciello, Mario wrote:
>>>>>>> On modern systems CPU/GPU/... performance is often dynamically
>>>>>>> configurable
>>>>>>> in the form of e.g. variable clock-speeds and TPD. The
>>>>>>> performance
>>>>>>> is often
>>>>>>> automatically adjusted to the load by some automatic-mechanism
>>>>>>> (which may
>>>>>>> very well live outside the kernel).
>>>>>>>
>>>>>>> These auto performance-adjustment mechanisms often can be
>>>>>>> configured with
>>>>>>> one of several performance-profiles, with either a bias towards
>>>>>>> low-power
>>>>>>> consumption (and cool and quiet) or towards performance (and
>>>>>>> higher
>>>>>>> power
>>>>>>> consumption and thermals).
>>>>>>>
>>>>>>> Introduce a new performance_profile class/sysfs API which
>>>>>>> offers a
>>>>>>> generic
>>>>>>> API for selecting the performance-profile of these automatic-
>>>>>>> mechanisms.
>>>>>>>
>>>>>>
>>>>>> If introducing an API for this - let me ask the question, why
>>>>>> even let each
>>>>>> driver offer a class interface and userspace need to change
>>>>>> "each" driver's
>>>>>> performance setting?
>>>>>>
>>>>>> I would think that you could just offer something kernel-wide
>>>>>> like
>>>>>> /sys/power/performance-profile
>>>>>>
>>>>>> Userspace can read and write to a single file.  All drivers can
>>>>>> get notified
>>>>>> on this sysfs file changing.
>>>>>>
>>>>>> The systems that react in firmware (such as the two that prompted
>>>>>> this discussion) can change at that time.  It leaves the
>>>>>> possibility for a
>>>>>> more open kernel implementation that can do the same thing though
>>>>>> too by
>>>>>> directly modifying device registers instead of ACPI devices.
>>>>>
>>>>> The problem, as I've mentioned in previous discussions we had about
>>>>> this, is that, as you've seen in replies to this mail, this would
>>>>> suddenly be making the kernel apply policy.
>>>>>
>>>>> There's going to be pushback as soon as policy is enacted in the
>>>>> kernel, and you take away the different knobs for individual
>>>>> components
>>>>> (or you can control them centrally as well as individually). As
>>>>> much as
>>>>> I hate the quantity of knobs[1], I don't think that trying to
>>>>> reduce
>>>>> the number of knobs in the kernel is a good use of our time, and
>>>>> easier
>>>>> to enact, coordinated with design targets, in user-space.
>>>>>
>>>>> Unless you can think of a way to implement this kernel wide setting
>>>>> without adding one more exponent on the number of possibilities for
>>>>> the
>>>>> testing matrix, I'll +1 Hans' original API.
>>>>>
>>>> Actually I offered two proposals in my reply.  So are you NAKing
>>>> both?
>>>
>>> No, this is only about the first portion of the email, which I quoted.
>>> And I'm not NAK'ing it, but I don't see how it can work without being
>>> antithetical to what kernel "users" expect, or what the folks consuming
>>> those interfaces (presumably us both) would expect to be able to test
>>> and maintain.
>>>
>>
>> (Just so others are aware, Bastien and I had a previous discussion on this topic
>> that he alluded to here: https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/1)
>>
>> In general I agree that we shouldn't be offering 100's of knobs to change
>> things and protect users from themselves where possible.
>>
>> Whether the decisions are made in the kernel or in userspace you still have a matrix once
>> you're letting someone change 2 different kernel devices that offer policy.  I'd argue it's
>> actually worse if you let userspace change it though.
>>
>> Let's go back to the my GPU and platform example and lets say both offer the new knob here
>> for both.  Userspace software such as your PPD picks performance.  Both the platform device
>> and GPU device get changed, hopefully no conflicts.
>> Then user decides no, I don't want my GPU in performance mode, I only want my platform.
>> So they change the knob for the GPU manually, and now you have a new config in your matrix.
>>
>> However if you left it to a single kernel knob, both GPU and platform get moved together and
>> you don't have these extra configs in your matrix anymore.
>>
>> The other point I mentioned, that platform might also do something to GPU via a sideband and
>> you race, you can solve it with kernel too by modifying the ordering the kernel handles it.
>>
>> Userspace however, you give two knobs and now you have to worry about them getting it right
>> and supporting them doing them in the wrong order.
>>
>>>> The other one suggested to use the same firmware attributes class
>>>> being
>>>> introduced by the new Dell driver (
>>>> https://patchwork.kernel.org/patch/11818343/)
>>>> since this is actually a knob to a specific firmware setting.
>>>
>>> This seemed to me like an implementation detail (eg. the same metadata
>>> is being exported, but in a different way), and I don't feel strongly
>>> about it either way.
>>
>> OK thanks.
> 
> IMV there are two choices here:  One is between exposing the low-level
> interfaces verbatim to user space and wrapping them up into a certain
> "translation" layer allowing user space to use a unified interface (I
> think that is what everybody wants) and the other  boils down to how
> the unified interface between the kernel and user space will look
> like.
> 
> Personally, I think that something line /sys/power/profile allowing
> drivers (and other kernel entities) to register callbacks might work
> (as stated in my last reply to Hans).

Note to others reading along I pointed to this thread in this thread:
https://lore.kernel.org/linux-pm/20201006122024.14539-1-daniel.lezcano@linaro.org/T/#t
and Rafael's "last reply" above refers to his reply in that thread.

For the sake of people reading along I'm reproducing my reply
there below.

Rafael, it seems more appropriate to continue this discussion
in this thread, so lets discuss this further here ?

My reply to Rafael from the other thread:

First of all thank you for your input, with your expertise in this
area your input is very much appreciated, after all we only get
one chance to get the userspace API for this right.

Your proposal to have a single sysfs file for userspace to talk
to and then use an in kernel subscription mechanism for drivers
to get notified of writes to this file is interesting.

But I see 2 issues with it:

1. How will userspace know which profiles are actually available ?

An obvious solution is to pick a set of standard names and let
subscribers map those as close to their own settings as possible,
the most often mentioned set of profile names in this case seems to be:

low_power
balanced_power
balanced
balanced_performance
performance

Which works fine for the thinkpad_acpi case, but not so much for
the hp-wmi case. In the HP case what happens is that a WMI call
is made which sets a bunch of ACPI variables which influence
the DPTF code (this assumes we have some sort of DPTF support
such as mjg59's reverse engineered support) but the profile-names
under Windows are: "Performance", "HP recommended", "Cool" and
"Quiet".  If you read the discussion from the
"[RFC] Documentation: Add documentation for new performance_profile sysfs class"
thread you will see this was brought up as an issue there.

The problem here is that both "cool" and "quiet" could be
interpreted as low-power. But it seems that they actually mean
what they say, cool focuses on keeping temps low, which can
also be done by making the fan-profile more aggressive. And quiet
is mostly about keeping fan speeds down, at the cost of possible
higher temperatures.

<edit in this version of the reply:>
I wonder if the HP profiles are actually just fan speed profiles ?
Elia do you know ?
</edit>

IOW we don't really have a 1 dimensional axis.
My class proposal fixes this by having a notion of both
standardized names (because anything else would suck) combined
with a way for drivers to advertise which standardized names
the support. So in my proposal I simply add quiet and cool
to the list of standard profile names, and then the HP-wmi
driver can list those as supported, while not listing
low_power as a supported profile.  This way we export the
hardware interface to userspace as is (as much as possible)
while still offering a standardized interface for userspace
to consume.  Granted if userspace now actually want to set
a low_power profile, we have just punted the problem to userspace
but I really do not see a better solution.


2. This only works assuming that all performance-profiles
are system wide. But given a big desktop case there might
be very well be separate cooling zones for e.g. the CPU
and the GPU and I can imagine both having separate
performance-profile settings and some users will doubtlessly
want to be able to control these separately ...

Regards,

Hans

