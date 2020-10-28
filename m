Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD0429D785
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 23:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732806AbgJ1WZI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 18:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732787AbgJ1WZG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 18:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603923903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sq1B8u8NLUEB8OJpFZ9ZPM/0L4/ZYp1FVYQZCWkCea0=;
        b=QJMfoN4oYHNnQCMpewagHKJbpwrphefKQ/4+CPvqMsnYceFMPgxNivIkuhjt1p1AYxLyfz
        y5Az/LxE7nNQIBdyvip6zZlyeKvxatq+Hf5B3uS2Hn35/ha8L+C2SSy3mMhH1SrrOC+6Tn
        F1BmyrQAoY2w332xVa7ix5BnRZDVSfU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-qR7hfgGQPJ-vvdv23BYIBw-1; Wed, 28 Oct 2020 13:23:16 -0400
X-MC-Unique: qR7hfgGQPJ-vvdv23BYIBw-1
Received: by mail-ed1-f70.google.com with SMTP id dc23so59487edb.13
        for <linux-acpi@vger.kernel.org>; Wed, 28 Oct 2020 10:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sq1B8u8NLUEB8OJpFZ9ZPM/0L4/ZYp1FVYQZCWkCea0=;
        b=BHeGQUbfmhZI+SJk20/gKrFfXDOCYrmJuuaOeLXslzeuT/D8iYzNxNDKyj8EIpfB+7
         n8Ga598+yU9dDY6HbgE94gna5ckzY+u4442w7RipSn8Y+9dGQZlzM17IZ/TBLaDUwx/i
         Gk+YPRuLqFByXXSy4BqvXvbd5IbU6HAdS4NJ4SjWv1abkySXNnP97kw3e2CxT4PfSuO7
         RvblJb8alPI2tCnuv7CxH8I2+6oqff9SqpkUogRMGDe0nRIZPUq/2Ag5JNrMh/oWUZJf
         cIURO2CzhfKT6O1pcCwp3L4m4OsRxF23GxVolEOBOjx8L+tI9sj+fr2YvmzHiTs2UdVg
         R5Rg==
X-Gm-Message-State: AOAM531d3LGjkfs2Erm0zAZF5zEuuRqdcl5LLZfeUDFCCEESHYZu3XFE
        Re/mcNULmK44HOqryKEZ7hQdN6edfGmOwx7s/gEJNdOQ7SRxGsZeiSU06triHml2lPqBeOhcFnO
        BC05hJGOejadC24uWvYqoJA==
X-Received: by 2002:a17:906:6453:: with SMTP id l19mr125870ejn.366.1603905794984;
        Wed, 28 Oct 2020 10:23:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzREE5X9JMuMW0uT+945/sNIo/Jw2GIPaYjye6jFS3w2G6zpJDNsvl2GTmVFhYI71fL0HiW4A==
X-Received: by 2002:a17:906:6453:: with SMTP id l19mr125853ejn.366.1603905794640;
        Wed, 28 Oct 2020 10:23:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id l17sm112230eji.14.2020.10.28.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 10:23:13 -0700 (PDT)
Subject: Re: [PATCH] Documentation: Add documentation for new platform_profile
 sysfs attribute
To:     Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <markpearson@lenovo.com>
 <20201027164219.868839-1-markpearson@lenovo.com>
 <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
Date:   Wed, 28 Oct 2020 18:23:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/28/20 2:45 PM, Bastien Nocera wrote:
> Hey Hans, Mark,
> 
> On Tue, 2020-10-27 at 12:42 -0400, Mark Pearson wrote:
>> From: Hans de Goede <hdegoede@redhat.com>
>>
>> On modern systems the platform performance, temperature, fan and
>> other
>> hardware related characteristics are often dynamically configurable.
>> The
>> profile is often automatically adjusted to the load by somei
>> automatic-mechanism (which may very well live outside the kernel).
>>
>> These auto platform-adjustment mechanisms often can be configured
>> with
>> one of several 'platform-profiles', with either a bias towards low-
>> power
> 
> Can you please make sure to quote 'platform-profile' and 'profile-name'
> this way all through the document? They're not existing words, and
> quoting them shows that they're attribute names, rather than English.
> 
>> consumption or towards performance (and higher power consumption and
>> thermals).
> 
> s/thermal/temperature/
> 
> "A thermal" is something else (it's seasonal underwear for me ;)
> 
>> Introduce a new platform_profile sysfs API which offers a generic API
>> for
>> selecting the performance-profile of these automatic-mechanisms.
>>
>> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in V1:
>>  - Moved from RFC to proposed patch
>>  - Added cool profile as requested
>>  - removed extra-profiles as no longer relevant
>>
>>  .../ABI/testing/sysfs-platform_profile        | 66
>> +++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
>>
>> diff --git a/Documentation/ABI/testing/sysfs-platform_profile
>> b/Documentation/ABI/testing/sysfs-platform_profile
>> new file mode 100644
>> index 000000000000..240bd3d7532b
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-platform_profile
>> @@ -0,0 +1,66 @@
>> +Platform-profile selection (e.g.
>> /sys/firmware/acpi/platform_profile)
>> +
>> +On modern systems the platform performance, temperature, fan and
>> other
>> +hardware related characteristics are often dynamically configurable.
>> The
>> +profile is often automatically adjusted to the load by some
>> +automatic-mechanism (which may very well live outside the kernel).
>> +
>> +These auto platform-adjustment mechanisms often can be configured
>> with
>> +one of several 'platform-profiles', with either a bias towards low-
>> power
>> +consumption or towards performance (and higher power consumption and
>> +thermals).
>> +
>> +The purpose of the platform_profile attribute is to offer a generic
>> sysfs
>> +API for selecting the platform-profile of these automatic-
>> mechanisms.
>> +
>> +Note that this API is only for selecting the platform-profile, it is
>> +NOT a goal of this API to allow monitoring the resulting performance
>> +characteristics. Monitoring performance is best done with
>> device/vendor
>> +specific tools such as e.g. turbostat.
>> +
>> +Specifically when selecting a high-performance profile the actual
>> achieved
>> +performance may be limited by various factors such as: the heat
>> generated
>> +by other components, room temperature, free air flow at the bottom
>> of a
>> +laptop, etc. It is explicitly NOT a goal of this API to let
>> userspace know
>> +about any sub-optimal conditions which are impeding reaching the
>> requested
>> +performance level.
>> +
>> +Since numbers are a rather meaningless way to describe platform-
>> profiles
> 
> It's not meaningless, but rather ambiguous. For a range of 1 to 5, is 1
> high performance, and 5 low power, or vice-versa?

It is meaningless because the space we are trying to describe with the
profile-names is not 1 dimensional. E.g. as discussed before cool and
low-power are not necessarily the same thing. If you have a better way
to word this I'm definitely in favor of improving the text here.

> 
>> +this API uses strings to describe the various profiles. To make sure
>> that
>> +userspace gets a consistent experience when using this API this API
> 
> you can remove "when using this API".
> 
>> +document defines a fixed set of profile-names. Drivers *must* map
>> their
>> +internal profile representation/names onto this fixed set.
>> +
>> +If for some reason there is no good match when mapping then a new
>> profile-name
>> +may be added.
> 
> "for some reason" can be removed.
> 
>>  Drivers which wish to introduce new profile-names must:
>> +1. Have very good reasons to do so.
> 
> "1. Explain why the existing 'profile-names' cannot be used"
> 
>> +2. Add the new profile-name to this document, so that future drivers
>> which also
>> +   have a similar problem can use the same name.
> 
> "2. Add the new 'profile-name' to the documentation so that other
> drivers can use it, as well as user-space knowing clearly what
> behaviour the 'profile-name' corresponds to"
> 
>> +
>> +What:          /sys/firmware/acpi/platform_profile_choices
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +               Reading this file gives a space separated list of
>> profiles
>> +               supported for this device.
> 
> "This file contains a space-separated list of profiles..."
> 
>> +
>> +               Drivers must use the following standard profile-
>> names:
>> +
>> +               low-power:              Emphasises low power
>> consumption
>> +               cool:                   Emphasises cooler operation
>> +               quiet:                  Emphasises quieter operation
>> +               balanced:               Balance between low power
>> consumption
>> +                                       and performance
>> +               performance:            Emphasises performance (and
>> may lead to
>> +                                       higher temperatures and fan
>> speeds)
> 
> I'd replace "Emphasises" with either "Focus on" or the US English
> spelling of "Emphasizes".
> 
>> +               Userspace may expect drivers to offer at least
>> several of these
>> +               standard profile-names.
> 
> Replce "at least several" with "more than one".
> 
>> +
>> +What:          /sys/firmware/acpi/platform_profile
>> +Date:          October 2020
>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>> +Description:
>> +               Reading this file gives the current selected profile
>> for this
>> +               device. Writing this file with one of the strings
>> from
>> +               available_profiles changes the profile to the new
>> value.
> 
> Is there another file which explains whether those sysfs value will
> contain a trailing linefeed?

sysfs APIs are typically created so that they can be used from the shell,
so on read a newline will be added. On write a newline at the end
typically is allowed, but ignored. There are even special helper functions
to deal with properly ignoring the newline on write.

Regards,

Hans


