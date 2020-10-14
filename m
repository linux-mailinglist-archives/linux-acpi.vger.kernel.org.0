Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01C028E20E
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Oct 2020 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbgJNOQz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Oct 2020 10:16:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389017AbgJNOQt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Oct 2020 10:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602685006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=++8e9iOxSY+RpUnB/GBipOSqGXVaeDK6uGe2hiMTZ8U=;
        b=Y0TOkfETQi1FGk4Uusg1PbMzqNIUG6c5wb4CLblYq/DTuG6ez+QPWURMzmyK1eL7iMGdR0
        eMdqHz7aYjyjzAx8Mr4Y5702WfimGGaMCJ0L7cIIQ5f5JaY2dKXBf6wQ2tXRfoXW3EmW3X
        E83lvN32DFB7Z2AZTzqFmTmfjz5oAvU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-SxKcrxc8PBCCB9BIh7GbqA-1; Wed, 14 Oct 2020 10:16:44 -0400
X-MC-Unique: SxKcrxc8PBCCB9BIh7GbqA-1
Received: by mail-ej1-f72.google.com with SMTP id j7so1237485ejy.7
        for <linux-acpi@vger.kernel.org>; Wed, 14 Oct 2020 07:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=++8e9iOxSY+RpUnB/GBipOSqGXVaeDK6uGe2hiMTZ8U=;
        b=lnkKdCxR6nV62BLJGYy4OdQrsJq5MTUj0Xg6LsVsOVm7Q04buEl3Cm3lLNmSWS85eZ
         28VXKwZCz01p4ZMT4nvsK+PwenJ4yDkcWvqWNPgsT3gIV14TatdW2jyAIeL5yV/DLPyQ
         qA3j339lZXw/5vcQC1/j3EXPtUCVRJTqX/d3n7EWQDMZmf0bUEHKb+K7UjYWBEItZSxY
         2Gk+GftztFKe+PbdOvBAvgOHHa8nxiyAijn+jDCyLhhCHEXXel/+ugukEFw4ir2TccTM
         nUG/kMWYLaZm7RCJXkLn+Rt+au6lJ/3kvPtrZhMk9klssouAVOrQ66friKB+k5lmMOxl
         jKGw==
X-Gm-Message-State: AOAM533T0p+5T3yi0waOiVgIoTkWjZlaoKtpDYQE1pLCjpHy/4kCgp1v
        iFXQ98z8vrYqzhcAK5Kz8wEPhZ/LaMbYG8mHNYDaISOTPhCCFblK5fKTaSCGo9ubB7DlIGkRhEh
        +EyqyPtx5WNet8bOVP6n6BA==
X-Received: by 2002:a05:6402:31af:: with SMTP id dj15mr5278852edb.275.1602685002303;
        Wed, 14 Oct 2020 07:16:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyilwn5X7QPrk9+0EJewUdJMiTr0JcM2q1QXDTKATbCczz8IIV16OVlye9q3b1m8Rj8UoV8GQ==
X-Received: by 2002:a05:6402:31af:: with SMTP id dj15mr5278786edb.275.1602685001694;
        Wed, 14 Oct 2020 07:16:41 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id jw9sm1829822ejb.33.2020.10.14.07.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 07:16:40 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Bastien Nocera <hadess@hadess.net>,
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
        Mark Pearson <markpearson@lenovo.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
 <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <85a36eb58cb9774f1907582dfc75295ed847200c.camel@hadess.net>
 <DM6PR19MB26364E6AA2F51981F592CE58FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <c73ffad8fd6bff8ff20d91930b097bff82be1c8f.camel@hadess.net>
 <DM6PR19MB2636B067186B08B744EA2163FA0A0@DM6PR19MB2636.namprd19.prod.outlook.com>
 <CAJZ5v0jBJBTTb3qBGH0UWOAfvY24gWqJQA=MahnhaTdMu-w0Bw@mail.gmail.com>
 <394f897a-4dac-7016-ea17-c37b67589e07@redhat.com>
 <CAJZ5v0is93pUzy8L0s0F+i6j9ecGutRv54ji0Nx3wr-15Y8uBA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <fec6eaeb-cc40-a2d2-87cb-bcae338bbe80@redhat.com>
Date:   Wed, 14 Oct 2020 16:16:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0is93pUzy8L0s0F+i6j9ecGutRv54ji0Nx3wr-15Y8uBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/14/20 3:55 PM, Rafael J. Wysocki wrote:
> On Tue, Oct 13, 2020 at 3:09 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 10/12/20 6:42 PM, Rafael J. Wysocki wrote:
>>> On Wed, Oct 7, 2020 at 8:41 PM Limonciello, Mario
>>> <Mario.Limonciello@dell.com> wrote:
>>>>
>>>>> On Wed, 2020-10-07 at 15:58 +0000, Limonciello, Mario wrote:
>>>>>>
>>>>>>> On Mon, 2020-10-05 at 12:58 +0000, Limonciello, Mario wrote:
>>>>>>>>> On modern systems CPU/GPU/... performance is often dynamically
>>>>>>>>> configurable
>>>>>>>>> in the form of e.g. variable clock-speeds and TPD. The
>>>>>>>>> performance
>>>>>>>>> is often
>>>>>>>>> automatically adjusted to the load by some automatic-mechanism
>>>>>>>>> (which may
>>>>>>>>> very well live outside the kernel).
>>>>>>>>>
>>>>>>>>> These auto performance-adjustment mechanisms often can be
>>>>>>>>> configured with
>>>>>>>>> one of several performance-profiles, with either a bias towards
>>>>>>>>> low-power
>>>>>>>>> consumption (and cool and quiet) or towards performance (and
>>>>>>>>> higher
>>>>>>>>> power
>>>>>>>>> consumption and thermals).
>>>>>>>>>
>>>>>>>>> Introduce a new performance_profile class/sysfs API which
>>>>>>>>> offers a
>>>>>>>>> generic
>>>>>>>>> API for selecting the performance-profile of these automatic-
>>>>>>>>> mechanisms.
>>>>>>>>>
>>>>>>>>
>>>>>>>> If introducing an API for this - let me ask the question, why
>>>>>>>> even let each
>>>>>>>> driver offer a class interface and userspace need to change
>>>>>>>> "each" driver's
>>>>>>>> performance setting?
>>>>>>>>
>>>>>>>> I would think that you could just offer something kernel-wide
>>>>>>>> like
>>>>>>>> /sys/power/performance-profile
>>>>>>>>
>>>>>>>> Userspace can read and write to a single file.  All drivers can
>>>>>>>> get notified
>>>>>>>> on this sysfs file changing.
>>>>>>>>
>>>>>>>> The systems that react in firmware (such as the two that prompted
>>>>>>>> this discussion) can change at that time.  It leaves the
>>>>>>>> possibility for a
>>>>>>>> more open kernel implementation that can do the same thing though
>>>>>>>> too by
>>>>>>>> directly modifying device registers instead of ACPI devices.
>>>>>>>
>>>>>>> The problem, as I've mentioned in previous discussions we had about
>>>>>>> this, is that, as you've seen in replies to this mail, this would
>>>>>>> suddenly be making the kernel apply policy.
>>>>>>>
>>>>>>> There's going to be pushback as soon as policy is enacted in the
>>>>>>> kernel, and you take away the different knobs for individual
>>>>>>> components
>>>>>>> (or you can control them centrally as well as individually). As
>>>>>>> much as
>>>>>>> I hate the quantity of knobs[1], I don't think that trying to
>>>>>>> reduce
>>>>>>> the number of knobs in the kernel is a good use of our time, and
>>>>>>> easier
>>>>>>> to enact, coordinated with design targets, in user-space.
>>>>>>>
>>>>>>> Unless you can think of a way to implement this kernel wide setting
>>>>>>> without adding one more exponent on the number of possibilities for
>>>>>>> the
>>>>>>> testing matrix, I'll +1 Hans' original API.
>>>>>>>
>>>>>> Actually I offered two proposals in my reply.  So are you NAKing
>>>>>> both?
>>>>>
>>>>> No, this is only about the first portion of the email, which I quoted.
>>>>> And I'm not NAK'ing it, but I don't see how it can work without being
>>>>> antithetical to what kernel "users" expect, or what the folks consuming
>>>>> those interfaces (presumably us both) would expect to be able to test
>>>>> and maintain.
>>>>>
>>>>
>>>> (Just so others are aware, Bastien and I had a previous discussion on this topic
>>>> that he alluded to here: https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/1)
>>>>
>>>> In general I agree that we shouldn't be offering 100's of knobs to change
>>>> things and protect users from themselves where possible.
>>>>
>>>> Whether the decisions are made in the kernel or in userspace you still have a matrix once
>>>> you're letting someone change 2 different kernel devices that offer policy.  I'd argue it's
>>>> actually worse if you let userspace change it though.
>>>>
>>>> Let's go back to the my GPU and platform example and lets say both offer the new knob here
>>>> for both.  Userspace software such as your PPD picks performance.  Both the platform device
>>>> and GPU device get changed, hopefully no conflicts.
>>>> Then user decides no, I don't want my GPU in performance mode, I only want my platform.
>>>> So they change the knob for the GPU manually, and now you have a new config in your matrix.
>>>>
>>>> However if you left it to a single kernel knob, both GPU and platform get moved together and
>>>> you don't have these extra configs in your matrix anymore.
>>>>
>>>> The other point I mentioned, that platform might also do something to GPU via a sideband and
>>>> you race, you can solve it with kernel too by modifying the ordering the kernel handles it.
>>>>
>>>> Userspace however, you give two knobs and now you have to worry about them getting it right
>>>> and supporting them doing them in the wrong order.
>>>>
>>>>>> The other one suggested to use the same firmware attributes class
>>>>>> being
>>>>>> introduced by the new Dell driver (
>>>>>> https://patchwork.kernel.org/patch/11818343/)
>>>>>> since this is actually a knob to a specific firmware setting.
>>>>>
>>>>> This seemed to me like an implementation detail (eg. the same metadata
>>>>> is being exported, but in a different way), and I don't feel strongly
>>>>> about it either way.
>>>>
>>>> OK thanks.
>>>
>>> IMV there are two choices here:  One is between exposing the low-level
>>> interfaces verbatim to user space and wrapping them up into a certain
>>> "translation" layer allowing user space to use a unified interface (I
>>> think that is what everybody wants) and the other  boils down to how
>>> the unified interface between the kernel and user space will look
>>> like.
>>>
>>> Personally, I think that something line /sys/power/profile allowing
>>> drivers (and other kernel entities) to register callbacks might work
>>> (as stated in my last reply to Hans).
>>
>> Note to others reading along I pointed to this thread in this thread:
>> https://lore.kernel.org/linux-pm/20201006122024.14539-1-daniel.lezcano@linaro.org/T/#t
>> and Rafael's "last reply" above refers to his reply in that thread.
>>
>> For the sake of people reading along I'm reproducing my reply
>> there below.
> 
> For completeness, my response in the other thread is here:
> 
> https://lore.kernel.org/linux-pm/CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com/T/#t
> 
>> Rafael, it seems more appropriate to continue this discussion
>> in this thread, so lets discuss this further here ?
> 
> And because I sent it before reading this message, let me reproduce it
> below (with some additions).

And I just did the same thing (replied to your reply in the other thread),
I guess I was too quick.

So I too will reproduce my reply here.

And I still believe it is best to then stick to this thread from now on,
because this reproducing thing is not really productive...

>> My reply to Rafael from the other thread:
>>
>> First of all thank you for your input, with your expertise in this
>> area your input is very much appreciated, after all we only get
>> one chance to get the userspace API for this right.
>>
>> Your proposal to have a single sysfs file for userspace to talk
>> to and then use an in kernel subscription mechanism for drivers
>> to get notified of writes to this file is interesting.
>>
>> But I see 2 issues with it:
>>
>> 1. How will userspace know which profiles are actually available ?
>>
>> An obvious solution is to pick a set of standard names and let
>> subscribers map those as close to their own settings as possible,
>> the most often mentioned set of profile names in this case seems to be:
>>
>> low_power
>> balanced_power
>> balanced
>> balanced_performance
>> performance
>>
>> Which works fine for the thinkpad_acpi case, but not so much for
>> the hp-wmi case. In the HP case what happens is that a WMI call
>> is made which sets a bunch of ACPI variables which influence
>> the DPTF code (this assumes we have some sort of DPTF support
>> such as mjg59's reverse engineered support) but the profile-names
>> under Windows are: "Performance", "HP recommended", "Cool" and
>> "Quiet".  If you read the discussion from the
>> "[RFC] Documentation: Add documentation for new performance_profile sysfs class"
>> thread you will see this was brought up as an issue there.
> 
> Two different things seem to be conflated here.  One is how to pass a
> possible performance-vs-power preference coming from user space down
> to device drivers or generally pieces of kernel code that can adjust
> the behavior and/or hardware settings depending on what that
> preference is and the other is how to expose OEM-provided DPTF system
> profile interfaces to user space.

I was hoping / thinking that we could use a single API for both of
these. But I guess that it makes sense to see them as 2 separate
things, esp. since DPTF profiles seem to be somewhat free-form
where as a way to pass a performance-pref to a device could use
a fixes set of values.

So lets say that we indeed want to treat these 2 separately,
then I guess that the issue at hand / my reason to start a
discussion surrounding this is allowing userspace to selecting
the DPTF system profile.

The thinkpad_acpi case at hand is not using DPTF, but that is
because Lenovo decided to implement dynamic DPTF like behavior
inside their embedded controller (for when running Linux) since
DPTF is atm not really supported all that well under Linux and
Lenovo was getting a lot of complaints about sub-optimal
performance because of this.

So the thinkpad_acpi solution is in essence a replacement
for DPTF and it should thus use the same userspace API as
other mechanisms to select DPTF system profiles.

And if we limit this new userspace API solely to setting DPTF
system profiles, then their will indeed be only 1 provider for
this for the entire system.

> The former assumes that there is a common set of values that can be
> understood and acted on in a consistent way by all of the interested
> entities within the kernel and the latter is about passing information
> from user space down to a side-band power control mechanism working in
> its own way behind the kernel's back (and possibly poking at multiple
> hardware components in the platform in its own way).

Ack.

> IMO there is no way to provide a common interface covering these two
> cases at the same time.

I see your point, esp. the free form vs common set of values
argument seems to be exactly what we have been going in circles
about during the discussion about this so far.

>> The problem here is that both "cool" and "quiet" could be
>> interpreted as low-power. But it seems that they actually mean
>> what they say, cool focuses on keeping temps low, which can
>> also be done by making the fan-profile more aggressive. And quiet
>> is mostly about keeping fan speeds down, at the cost of possible
>> higher temperatures.
>>
>> <edit in this version of the reply:>
>> I wonder if the HP profiles are actually just fan speed profiles ?
>> Elia do you know ?
>> </edit>
> 
> I don't think so.
> 
> AFAICS, in both the Thinkpad and HP cases the profile covers the
> entire platform, which in particular means that they cannot co-exist.

Ok.

>> IOW we don't really have a 1 dimensional axis.
> 
> Well, AFAICS, DPTF system profile interfaces coming from different
> OEMs will be different, but they are about side-band power control and
> there can be only one thing like that in a platform at the same time.

Ack.

>> My class proposal fixes this by having a notion of both
>> standardized names (because anything else would suck) combined
>> with a way for drivers to advertise which standardized names
>> the support. So in my proposal I simply add quiet and cool
>> to the list of standard profile names, and then the HP-wmi
>> driver can list those as supported, while not listing
>> low_power as a supported profile.  This way we export the
>> hardware interface to userspace as is (as much as possible)
>> while still offering a standardized interface for userspace
>> to consume.  Granted if userspace now actually want to set
>> a low_power profile, we have just punted the problem to userspace
>> but I really do not see a better solution.
> 
> First, a common place to register a DPTF system profile seems to be
> needed and, as I said above, I wouldn't expect more than one such
> thing to be present in the system at any given time, so it may be
> registered along with the list of supported profiles and user space
> will have to understand what they mean.

Mostly Ack, I would still like to have an enum for DPTF system
profiles in the kernel and have a single piece of code map that
enum to profile names. This enum can then be extended as
necessary, but I want to avoid having one driver use
"Performance" and the other "performance" or one using
"performance-balanced" and the other "balanced-performance", etc.

With the goal being that new drivers use existing values from
the enum as much as possible, but we extend it where necessary.

> Second, irrespective of the above, it may be useful to have a
> consistent way to pass performance-vs-power preference information
> from user space to different parts of the kernel so as to allow them
> to adjust their operation and this could be done with a system-wide
> power profile attribute IMO.

I agree, which is why I tried to tackle both things in one go,
but as you said doing both in 1 API is probably not the best idea.
So I believe we should park this second issue for now and revisit it
when we find a need for it.

Do you have any specific userspace API in mind for the
DPTF system profile selection?

And to get one thing out of the way, in the other thread we had some
discussion about using a single attribute where a cat would result in:

low-power [balanced] performance

Where the [] indicate the active profile, vs having 2 sysfs attributes
one ro with space-separated available (foo_available) values and one
wr with the actual/current value. FWIW userspace folks have indicated
they prefer the solution with 2 separate sysfs-attributes and that is
also what e.g. cpufreq is currently using for governor selection.

I don't really have a strong opinion either way.

Regards,

Hans



