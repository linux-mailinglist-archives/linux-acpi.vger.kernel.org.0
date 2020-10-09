Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8300E288755
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 12:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731809AbgJIKw5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 06:52:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731740AbgJIKw5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 06:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602240774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b2KmhyJYuwfzClA4XY5dqci0ZQ4SyQqC2jJEQonb8LA=;
        b=Lc9BaTUAeMbdnBYKiLo3lNQI8AEO/QvlxJtLEtNgKXf6SEd7tT3UoIxzVQxS9KqOPU0WGh
        4hfrAJRQXW7RtAzDaCkkcUN4NtGvMaLCnv3UECgbBgz2hZE+yGLsBzzyw4puJc+pR0tnPG
        By7NAY0HpvPV9KAueR+XzflmnWNU6xs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-5O654d71OJSPfIQVmK-uWg-1; Fri, 09 Oct 2020 06:52:53 -0400
X-MC-Unique: 5O654d71OJSPfIQVmK-uWg-1
Received: by mail-ed1-f71.google.com with SMTP id n16so3423019edw.19
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2020 03:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b2KmhyJYuwfzClA4XY5dqci0ZQ4SyQqC2jJEQonb8LA=;
        b=CjnMmdz2yAuTkYuHr83BVzd7dp3J5xVGMnywOZKqp6ZmT9ECPcUr/rCekviwefwMz8
         1l6rM6M3gs/sPiiEjDxCRi2b0LPCBx0t6GGkeFiixoSBSLI93RyV/N4vWlHEVPQYJAQk
         cCcbXr2rXUxmHE4Uc2OvUJjgTdLEBXp4DO1w2cOwLkNa6Fuz2XRoT0Lpyhb720/olUQS
         dbHCMWj0oai7ONaaV/HSo2y2J4LnSuw955la6/2FDDLt4aV0buHC26Cm5X8xxB6Ry5jr
         Qv/BTzidWi6dLUZYnZS6ZYg5kaLw5+7G179g0yg3opX+uWX1Q/NearAG6xllvW8Xannj
         wa1Q==
X-Gm-Message-State: AOAM533KIoyo2a2qZoxMDGZmYiZgWTqQF7np0U0M0UpmCnpULaxhhZPt
        bGHkNWJ+PIDvjztz74W1qz/4hsY9sVTI4EuV3KyzmWkjIzGIjmDVPMQR13XjzqfN0+ue3hYXCFn
        kI1B5C1dYWlEd2mC+HWX+bQ==
X-Received: by 2002:a05:6402:1446:: with SMTP id d6mr13836310edx.244.1602240771736;
        Fri, 09 Oct 2020 03:52:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk2PfNW1NkoSH52LJaUH6ugaTFiZoxJGCN7TcohXu5wXflzKhdG6ONwhefqnIoI4tfeXGwHw==
X-Received: by 2002:a05:6402:1446:: with SMTP id d6mr13836295edx.244.1602240771475;
        Fri, 09 Oct 2020 03:52:51 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id w4sm5953979edr.72.2020.10.09.03.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 03:52:50 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     Elia Devito <eliadevito@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com> <2051253.irdbgypaU6@pce>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <79eac00c-1788-7a28-4229-b850f9fa6a64@redhat.com>
Date:   Fri, 9 Oct 2020 12:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2051253.irdbgypaU6@pce>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/5/20 12:29 AM, Elia Devito wrote:
> Hi Hans,
> 
> On 2020-10-03 9:19 a.m., Hans de Goede wrote:
>> On modern systems CPU/GPU/... performance is often dynamically configurable
>> in the form of e.g. variable clock-speeds and TPD. The performance is often
>> automatically adjusted to the load by some automatic-mechanism (which may
>> very well live outside the kernel).
>>
>> These auto performance-adjustment mechanisms often can be configured with
>> one of several performance-profiles, with either a bias towards low-power
>> consumption (and cool and quiet) or towards performance (and higher power
>> consumption and thermals).
>>
>> Introduce a new performance_profile class/sysfs API which offers a generic
>> API for selecting the performance-profile of these automatic-mechanisms.
>>
>> Cc: Mark Pearson <markpearson@lenovo.com>
>> Cc: Elia Devito <eliadevito@gmail.com>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: Benjamin Berg <bberg@redhat.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>> 1 file changed, 104 insertions(+)
>> create mode 100644
>> Documentation/ABI/testing/sysfs-class-performance_profile
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile
>> b/Documentation/ABI/testing/sysfs-class-performance_profile new file mode
>> 100644
>> index 000000000000..9c67cae39600
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
>> @@ -0,0 +1,104 @@
>> +Performance-profile selection (e.g.
>> /sys/class/performance_profile/thinkpad_acpi/) +
>> +On modern systems CPU/GPU/... performance is often dynamically configurable
>> +in the form of e.g. variable clock-speeds and TPD. The performance is
>> often +automatically adjusted to the load by some automatic-mechanism
>> (which may +very well live outside the kernel).
>> +
>> +These auto performance-adjustment mechanisms often can be configured with
>> +one of several performance-profiles, with either a bias towards low-power
>> +consumption (and cool and quiet) or towards performance (and higher power
>> +consumption and thermals).
>> +
>> +The purpose of the performance_profile class is to offer a generic sysfs
>> +API for selecting the performance-profile of these automatic-mechanisms.
>> +
>> +Note that this API is only for selecting the performance-profile, it is
>> +NOT a goal of this API to allow monitoring the resulting performance
>> +characteristics. Monitoring performance is best done with device/vendor
>> +specific tools such as e.g. turbostat.
>> +
>> +Specifically when selecting a high-performance profile the actual achieved
>> +performance may be limited by various factors such as: the heat generated
>> by +other components, room temperature, free air flow at the bottom of a
>> laptop, +etc. It is explicitly NOT a goal of this API to let userspace know
>> about +any sub-optimal conditions which are impeding reaching the requested
>> +performance level.
>> +
>> +Since numbers are a rather meaningless way to describe performance-profiles
>> +this API uses strings to describe the various profiles. To make sure that
>> +userspace gets a consistent experience when using this API this API
>> document +defines a fixed set of profile-names. Drivers *must* map their
>> internal +profile representation/names onto this fixed set.
>> +
>> +If for some reason there is no good match when mapping then a new
>> profile-name +may be added. Drivers which wish to introduce new
>> profile-names must: +1. Have very good reasons to do so.
>> +2. Add the new profile-name to this document, so that future drivers which
>> also +   have a similar problem can use the same new. Usually new
>> profile-names will +   be added to the "extra profile-names" section of
>> this document. But in some +   cases the set of standard profile-names may
>> be extended.
>> +
>> +What:          /sys/class/performance_profile/<device>/
> available_profiles
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +               Reading this file gives a space separated list of profiles
>> +               supported for this device.
>> +
>> +               Drivers must use the following standard profile-names
> whenever
>> +               possible:
>> +
>> +               low-power:              Emphasises low power consumption
>> +                                       (and also cool and
> quiet)
>> +               balanced-low-power:     Balances between low power
> consumption
>> +                                       and performance with a
> slight bias
>> +                                       towards low power
>> +               balanced:               Balance between low power
> consumption
>> +                                       and performance
>> +               balanced-performance:   Balances between performance and
> low
>> +                                       power consumption with
> a slight bias
>> +                                       towards performance
>> +               performance:            Emphasises performance
> (and may lead to
>> +                                       higher temperatures and
> fan speeds)
>> +
>> +               Userspace may expect drivers to offer at least several of
> these
>> +               standard profile-names! If none of the above are a good
> match
>> +               for some of the drivers profiles, then drivers may use
> one of
>> +               these extra profile-names:
>> +               <reserved for future use>
>> +
>> +What:          /sys/class/performance_profile/<device>/current_profile
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +               Reading this file gives the current selected profile for
> this
>> +               device. Writing this file with one of the strings from
>> +               available_profiles changes the profile to the new value.
>> +
>> +               Reading this file may also return "custom". This is
> intended for
>> +               drivers which have and export multiple knobs influencing
>> +               performance. Such drivers may very well still want to
> offer a
>> +               set of profiles for easy of use and to be able to offer a
>> +               consistent standard API (this API) to userspace for
> configuring
>> +               their performance. The "custom" value is intended for
> when a
>> +               user has directly configured the knobs (through e.g. some
>> +               advanced control-panel for a GPU) and the knob values do
> not
>> +               match any of the presets represented by the
>> +               performance-profiles. In this case writing this file will
>> +               override the modifications and restore the selected
> presets.
>> +
>> +What:          /sys/class/performance_profile/<device>/type
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +               Performance-profiles may be system-wide, or for a specific
>> +               device (e.g. CPU / GPU). System-wide profiles are
> typically
>> +               used on devices where where a single cooling solution is
>> +               shared between all components, such as laptops and NUCs.
>> +
>> +               Reading this file indicates the type of the device for
> which
>> +               the thermal-profile is being configured.
>> +
>> +               Valid values: "system"
>> +               Reserved for future use values: "cpu", "gpu"
>> --
>> 2.28.0
> 
> This looks good to me, the only consideration I have is that in my opinion the
> quiet profile and the cool profile should not necessarily match the low-power
> state because the quiet profile could cause thermal throttling without
> benefiting consumption, instead the cool profile (with the fans almost
> always on) would lead to an unnecessary increase in noise.

Ah I see, so you are interpreting cool as "cool to touch / low temps" not
as in cool by not generating much heat. That is not an unreasonable interpretation
and I see that the hp-wmi stuff you are working on has separate cool and
quiet profiles (and does not seem to have one which explicit targets low-power).

So I agree that we should not lump these together leading to the following
set of standard profile names (for now, can be extended in the future) :

                 quiet:                  Emphasises quiet running
		cool:                   Emphasises low temperatures
                 low-power:              Emphasises low power consumption
                 balanced-low-power:     Balances between low power consumption
                                         and performance with a slight bias
                                         towards low power
                 balanced:               Balance between low power consumption
                                         and performance
                 balanced-performance:   Balances between performance and low
                                         power consumption with a slight bias
                                         towards performance
                 performance:            Emphasises performance


> another question is the notebooks that offer both quiet and cool profile,
> which profile should be associated as low power?

That is a good question, IMHO the kernels role here is to provide a
mechanism to control these kinda profiles in various systems / components.

If the UI for this takes the form of a slider going from low-power
to performance, then on hardware which only offers cool and quiet
as options, like the hp-wmi interface seems to do, which one to
pick when the user selects low-power is a policy decision left
up to userspace. Likely the performance-profile-daemon Bastien is
working on, so from the sysfs API pov this is solved by just offering
cool and quiet as profile choices and then userspace needs to figure
out what to do (sorry Bastien).

Note if the driver knows that one of cool vs quiet also leads
to low-power, while for the other one that is not so much the case,
then it would make sense for the driver to also offer low-power as
an alias to one of the two (*) since the chances that the driver knows
this are better then that the performance-profile-daemon will know.

Regards,

Hans


*) or maybe in that case offer only low-power + one of the
other 2 options ?  Either way works I guess...

