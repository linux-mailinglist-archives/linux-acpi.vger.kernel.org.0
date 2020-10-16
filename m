Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 467862903D0
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406744AbgJPLLB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 07:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24784 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406674AbgJPLLB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 07:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602846659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOERbbEx7nVCNHLlMb3rSnmIO9vt1UAO946lTC4L+xc=;
        b=BgyFuUhGCHc+CNlaVEuKhwjT5d+oq5e8MTD/j4q+KNLi+COldA4ou1ihtHMRfISDioVEFZ
        ozf+8GaCS2DUDa7rFRyl90hzpPSvzdlg96QTJfMplNCUC0jXZEj3eUBmDlPNWjMmw5W3V3
        xzBZXaRIttxh6m4X1U9D8oL0WWeyI7w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-1EV7b0sNOISH91r0Cu31Wg-1; Fri, 16 Oct 2020 07:10:57 -0400
X-MC-Unique: 1EV7b0sNOISH91r0Cu31Wg-1
Received: by mail-ed1-f71.google.com with SMTP id ay19so827357edb.23
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2020 04:10:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kOERbbEx7nVCNHLlMb3rSnmIO9vt1UAO946lTC4L+xc=;
        b=qvYBxcvzgnyYwPst0lL/Jpg+tfjWvuM48AF7FxV+cjpUgV7weWGROCpyakpL7RWf0m
         Z7QVsydGZ1gI3dV8mo0jvhuWB2aYDbpz8TTmGSLEl4KvjJIq25z0oUcXj/we8dWc8cc4
         ppE7ij5S/kw+l4PU7BrEsFZIb9KBF/hqpEXowHLXfIUrT0vxO19ryvPOAxK486Uw7iqV
         WAYNV0qXGOiSBkuA9dNvhF9Y0LdXamnDOj8ImPnj8MNJ/Q16yZ5ygZ7R4QUtW9MLM065
         z2/iUaEUDlpfNTfDUg93azJcMNurPoLmk3sh0hBnZBVWX8zcX0yFeaBt5aWvn6Fq4FbU
         FrnA==
X-Gm-Message-State: AOAM532wTkzjmWqzhcZ/J0BoK52duEKcdKWx/S6vDmIkZxFKNTNpd3SQ
        P64Qsl1S242ymo7RzOV6FvLDq5EMymdMnFDJ8gGprBt/8et0RfvB8PIREk4eCcxOUTdig22SwMy
        tIHRsKY3hByviKfqRoOKhCg==
X-Received: by 2002:a50:c309:: with SMTP id a9mr3223867edb.199.1602846656241;
        Fri, 16 Oct 2020 04:10:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+iD0vQ3CWmW+0Tj/Lolks366zfvPUxo3S7eFXQ4IACS8Nha9I/OIrD7KLkJUTlI56BBzdlw==
X-Received: by 2002:a50:c309:: with SMTP id a9mr3223845edb.199.1602846655995;
        Fri, 16 Oct 2020 04:10:55 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 11sm1321247ejy.19.2020.10.16.04.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 04:10:55 -0700 (PDT)
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the
 DTPM framework)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <mpearson@lenovo.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
 <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com>
 <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
 <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com>
 <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
Date:   Fri, 16 Oct 2020 13:10:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<note folding the 2 threads we are having on this into one, adding every one from both threads to the Cc>

Hi,

On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
> On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:

<snip>

>>> First, a common place to register a DPTF system profile seems to be
>>> needed and, as I said above, I wouldn't expect more than one such
>>> thing to be present in the system at any given time, so it may be
>>> registered along with the list of supported profiles and user space
>>> will have to understand what they mean.
>>
>> Mostly Ack, I would still like to have an enum for DPTF system
>> profiles in the kernel and have a single piece of code map that
>> enum to profile names. This enum can then be extended as
>> necessary, but I want to avoid having one driver use
>> "Performance" and the other "performance" or one using
>> "performance-balanced" and the other "balanced-performance", etc.
>>
>> With the goal being that new drivers use existing values from
>> the enum as much as possible, but we extend it where necessary.
> 
> IOW, just a table of known profile names with specific indices assigned to them.

Yes.

> This sounds reasonable.
> 
>>> Second, irrespective of the above, it may be useful to have a
>>> consistent way to pass performance-vs-power preference information
>>> from user space to different parts of the kernel so as to allow them
>>> to adjust their operation and this could be done with a system-wide
>>> power profile attribute IMO.
>>
>> I agree, which is why I tried to tackle both things in one go,
>> but as you said doing both in 1 API is probably not the best idea.
>> So I believe we should park this second issue for now and revisit it
>> when we find a need for it.
> 
> Agreed.
> 
>> Do you have any specific userspace API in mind for the
>> DPTF system profile selection?
> 
> Not really.

So before /sys/power/profile was mentioned, but that seems more like
a thing which should have a set of fixed possible values, iow that is
out of scope for this discussion.

Since we all seem to agree that this is something which we need
specifically for DPTF profiles maybe just add:

/sys/power/dptf_current_profile    (rw)
/sys/power/dptf_available_profiles (ro)

(which will only be visible if a dptf-profile handler
 has been registered) ?

Or more generic and thus better (in case other platforms
later need something similar) I think, mirror the:

/sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
for a system-wide energy-performance setting, so we get:

/sys/power/energy_performance_preference
/sys/power/energy_performance_available_preferences

(again only visible when applicable) ?

I personally like the second option best.

Regards,

Hans

