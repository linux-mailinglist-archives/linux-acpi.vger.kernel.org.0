Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A912A2887E6
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Oct 2020 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgJILdy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 9 Oct 2020 07:33:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732000AbgJILdx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Oct 2020 07:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602243231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZRmIEX+5coj1lckLNFd6QB/eWw8ns4LBmqZd7pHr2I=;
        b=DF1xvZiZNK1IDY9sE5pxdgxYOaX4WOFAz4QDp9SEn3/DLziBLYvcruIoRptc75pWHHgwm/
        +kxMBh+FdtxlCHQEtJY68YADZydRHpVHxVgqT29YkOYW1XDBry9EKskxCsExherMKdeTvd
        Zpjf6Fe+lrjMLVa7O4C8OEOdA38+MXI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-qvNKguHqNnK6oIMEXYbBqQ-1; Fri, 09 Oct 2020 07:33:49 -0400
X-MC-Unique: qvNKguHqNnK6oIMEXYbBqQ-1
Received: by mail-ed1-f70.google.com with SMTP id a73so660597edf.16
        for <linux-acpi@vger.kernel.org>; Fri, 09 Oct 2020 04:33:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PZRmIEX+5coj1lckLNFd6QB/eWw8ns4LBmqZd7pHr2I=;
        b=jb7S/1t/V5vRV+B5lBIHW6Fb93rMMRr2K32WL0pNqPFs69sJ4pJV9ZQYYE7M4PKMvP
         pYnv5PXKAtTaRDzwGaSgnk/22RXkL1o0SxSs6wftbY7v3jR+oRZxbr1zwgmKPfQp0usL
         E8IQWUjVP7I13dwIP9N2KL02h6J/OwX5dlhJ5pTsSHdvkYXfxM0hC/LjWVt5eLq3DcjG
         bn3bHRHOJcga88u3ZlmyvKRPFyUwff7MaPiwlJU06sn8YnNfNPXnsUpkvDCQ0/HREDGv
         Ll4ypr6l6+ByZojk5eY3otjVPLGYbzPQfi2Su6euP6405kuYUcpevIfpgsSejiZfcnaH
         d3VQ==
X-Gm-Message-State: AOAM531sKarz/Jn3Ljm1uXT59W5hadPISUbeXE59hbv28SeM6lBvFaKX
        xyWkEmdWYVZ6hcyoxzuOtgPaV6yy2XcQGJlDom6y4j9D/4ARUEkRUhVg8R9i083CaIf2y/UtKoc
        1wzjWTbXwXyBnD67VQmiSKw==
X-Received: by 2002:a17:906:1914:: with SMTP id a20mr13378300eje.425.1602243228255;
        Fri, 09 Oct 2020 04:33:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwUpPqn4/BzN1UKwHf8EhXhi8gQQP/FiIe93a8JlxOVrgBQgzNUBLvR6AThQkC3hr6K4V1VZA==
X-Received: by 2002:a17:906:1914:: with SMTP id a20mr13378271eje.425.1602243227968;
        Fri, 09 Oct 2020 04:33:47 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id i14sm6066775edu.40.2020.10.09.04.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 04:33:47 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
Cc:     Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <809a45c7-735d-52e8-edfc-f3e74058063e@redhat.com>
Date:   Fri, 9 Oct 2020 13:33:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB263669227D122BB7699951E6FA0C0@DM6PR19MB2636.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/5/20 2:58 PM, Limonciello, Mario wrote:
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
> 
> If introducing an API for this - let me ask the question, why even let each
> driver offer a class interface and userspace need to change "each" driver's
> performance setting?
> 
> I would think that you could just offer something kernel-wide like
> /sys/power/performance-profile
> 
> Userspace can read and write to a single file.  All drivers can get notified
> on this sysfs file changing.

In the case of the currently intended users of this API there will be
only 1 provider (using the system type). So that pretty much does what
you suggest.

But I can see there being multiple components in a system which
each can have their own performance-profile. E.g. in some desktop
cases the CPU and GPU may be in separate compartments of the case
which each have their own independent airflow (and thus cooling budget).

Some components may even have their own air cooling with their own
external radiator.

So given the (potential) case with multiple components with each
their own thermal-profile. Then exporting only a single setting
for all components combined has 2 problems:

That would mean either some complicated policy in the kernel
for this, or a simple one where we set them all to the same level.

The simple policy has a number of issues:

1. Setting all components to the same level assume they have
identical profile options, but one component might offer low-power,
while another component does not offer that (the other component
could instead e.g. only offer quiet which is not 100% the same).

2. It is a given that some power users will be wanting to be able
to control the profiles of different components separately, so
having just a simply/naive policy in the kernel for this is not going
to work for all use-cases.

That leaves doing some complex policy mechanism, but in general
where possible the kernel tries to stay out of enforcing policies,
instead (where possible) it is greatly preferred to only offer a
mechanism to allow the functionality and then let userspace handle
any policy decisions.

So I believe that having 1 class device for each component
which offers selectable performance profiles is best.

Note that something like the performance-profile-daemon Bastien
is working on might very will choice to implement a KISS policy
where all components get configured with a similar performance-profile,
resulting in what you are suggesting. But at least this way
leaves the possibility to do things differently open.

>> Cc: Mark Pearson <markpearson@lenovo.com>
>> Cc: Elia Devito <eliadevito@gmail.com>
>> Cc: Bastien Nocera <hadess@hadess.net>
>> Cc: Benjamin Berg <bberg@redhat.com>
>> Cc: linux-pm@vger.kernel.org
>> Cc: linux-acpi@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-performance_profile
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile
>> b/Documentation/ABI/testing/sysfs-class-performance_profile
>> new file mode 100644
>> index 000000000000..9c67cae39600
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
>> @@ -0,0 +1,104 @@
>> +Performance-profile selection (e.g.
>> /sys/class/performance_profile/thinkpad_acpi/)
>> +
>> +On modern systems CPU/GPU/... performance is often dynamically configurable
>> +in the form of e.g. variable clock-speeds and TPD. The performance is often
>> +automatically adjusted to the load by some automatic-mechanism (which may
>> +very well live outside the kernel).
> 
> Are you intending to word this specifically to cover both firmware and userspace
> implementations?  Or were you really meaning firmware implementations?

What I'm trying to cover here is both firmware (run by say some microcontroller/EC)
implementations as well and in-kernel implementations like cpufreq and possible
support for controlling GPU frequencies. Note this is intended to future proof
things in case e.g. a GPU driver, where freq. control is done inside the kernel.
would like to use this API. This scenario might never materialize.

Userspace implementations (which seems to likely become a thing on at least ARM)
I would expect to have their own API (e.g. dbus / configfile) to configure their
behavior rather then making a round trip through kernel space with some virtual
device exporting this sysfs API.


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
> 
> Another thought that comes to mind (which is completely separate from my previous
> idea):
> 
> Why not make this register to firmware-attributes class as being discussed in the
> new Dell driver?
> 
> It seems like it could easily be read as:
> /sys/class/firmware-attributes/thinkpad-foo/attributes/PerformanceProfile/current_value
> /sys/class/firmware-attributes/thinkpad-foo/attributes/PerformanceProfile/possible_values

That would be mixing boot-time settings with runtime settings under the same
API. At least some Thinkpads already have firmware attributes for selecting
the performance profile but that just sets the profile at boot.

More in general we could put pretty much anything which can be expressed as
a key=value pair inside that API, but doing so feels like abusing the API.
The firmware-attributes API really is intended only for setting values which
are stored in some nvram by the firmware, not for runtime changes.

Regards,

Hans

