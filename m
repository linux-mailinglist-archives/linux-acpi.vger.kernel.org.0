Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F2A29DE9C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 01:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390954AbgJ2Az1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 20:55:27 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.3]:57091 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732262AbgJ2AzR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Oct 2020 20:55:17 -0400
Received: from [100.112.2.115] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.us-east-1.aws.symcld.net id F7/6D-43594-1F21A9F5; Thu, 29 Oct 2020 00:55:13 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRWlGSWpSXmKPExsWSLveKXfej0Kx
  4g+vT2Cz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RovLu+awWXzuPcJo0dTZBGR1TGax
  WL3nBbMDt8ekmTOYPXbOusvu8WvbGhaPzSu0POadDPR4v+8qm8fnTXIB7FGsmXlJ+RUJrBkXL
  t9gK/jnVPFg01e2Bsalll2MXBxCAv8ZJT6/u8ME4bxglHh/dA97FyMnh7BAnsSuDY+Yuxg5OE
  QEvCW+rK4GqWEWaGKSWNj+jwWi4RijxIz/XWANbALaElu2/GIDsXkFbCU27d/PAmKzCKhKTFk
  8nRnEFhUIl+i4sYMJokZQ4uTMJ2A1nAJ2ErsWHwWLMwtYSMycf54RwhaXuPVkPlRcXqJ562yw
  ORICChJ3Dt9gh7ATJJa9vMM8gVFwFpKxs5CMmoVk1CwkoxYwsqxiNEsqykzPKMlNzMzRNTQw0
  DU0NNI1ALH0Eqt0k/RKi3VTE4tLdA31EsuL9Yorc5NzUvTyUks2MQKjMKWAIWUH493XH/QOMU
  pyMCmJ8trzzooX4kvKT6nMSCzOiC8qzUktPsQow8GhJMHrJACUEyxKTU+tSMvMASYEmLQEB4+
  SCK+/IFCat7ggMbc4Mx0idYpRl2Pz3KWLmIVY8vLzUqXEeRlAigRAijJK8+BGwJLTJUZZKWFe
  RgYGBiGegtSi3MwSVPlXjOIcjErCvBUgU3gy80rgNr0COoIJ6Iic3BkgR5QkIqSkGpg2+PPrr
  L35IiF/hckZjnuTXJTrXWc3qz5KkzqkyW3rMnOKctvC4rPGVZ8UPhSKVpzQ+ecq5Xp9+SXHj1
  Y9rG1h86/Kcp8S81l5uZfB8d/iy94fMhZPK9p9RcuPlUVujdxqv4qtFb5la54nT1x2ehdry81
  osUezp2278vgqjyOfjNMZpUIebrsl64Sf3XlnIrzZuDFMNHt2zOGA8+/auKe6Ru5VMn6/x1rA
  9t+b1JleStPY13z4vl7eS8f5vYfegrqTK5cwK1t9k9k/P3rzZGbvORqHS3yltCzrhfXi/7pri
  X19Ebgt+9zJir8zlygrybO/mChc+XlDjlEsx33RFaz8VbqOS5/Vvrbs2ZDKcFyJpTgj0VCLua
  g4EQAG3+W5yQMAAA==
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-17.tower-386.messagelabs.com!1603932910!57216!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 31468 invoked from network); 29 Oct 2020 00:55:12 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-17.tower-386.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Oct 2020 00:55:12 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id E439699ED56A749B23F5;
        Thu, 29 Oct 2020 08:55:07 +0800 (CST)
Received: from localhost.localdomain (10.46.59.124) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Wed, 28 Oct
 2020 17:55:04 -0700
Subject: Re: [External] Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <eliadevito@gmail.com>,
        <bberg@redhat.com>, <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20201027164219.868839-1-markpearson@lenovo.com>
 <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
 <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <b3e61ee4-3fca-ce06-2216-977586baae4e@lenovo.com>
Date:   Wed, 28 Oct 2020 20:55:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <d5f0bcba-5366-87da-d199-a85d59ba6c1c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.59.124]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thanks Hans and Bastien,

On 28/10/2020 13:23, Hans de Goede wrote:
> Hi,
> 
> On 10/28/20 2:45 PM, Bastien Nocera wrote:
>> Hey Hans, Mark,
>>
>> On Tue, 2020-10-27 at 12:42 -0400, Mark Pearson wrote:
>>> From: Hans de Goede <hdegoede@redhat.com>
>>>
>>> On modern systems the platform performance, temperature, fan and
>>> other
>>> hardware related characteristics are often dynamically configurable.
>>> The
>>> profile is often automatically adjusted to the load by somei
>>> automatic-mechanism (which may very well live outside the kernel).
>>>
>>> These auto platform-adjustment mechanisms often can be configured
>>> with
>>> one of several 'platform-profiles', with either a bias towards low-
>>> power
>>
>> Can you please make sure to quote 'platform-profile' and 'profile-name'
>> this way all through the document? They're not existing words, and
>> quoting them shows that they're attribute names, rather than English.
I'm leaning towards changing these to become "platform profile" and 
"profile name" (no quotes in the actual text). Any objections?

>>
>>> consumption or towards performance (and higher power consumption and
>>> thermals).
>>
>> s/thermal/temperature/
>>
>> "A thermal" is something else (it's seasonal underwear for me ;)
I'm removing that sentence from an earlier review so it's moot, but 
enjoy your underwear! (which reminds me that I need a new set of 
thermals for the winter...)

>>
>>> Introduce a new platform_profile sysfs API which offers a generic API
>>> for
>>> selecting the performance-profile of these automatic-mechanisms.
>>>
>>> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
>>> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in V1:
>>>   - Moved from RFC to proposed patch
>>>   - Added cool profile as requested
>>>   - removed extra-profiles as no longer relevant
>>>
>>>   .../ABI/testing/sysfs-platform_profile        | 66
>>> +++++++++++++++++++
>>>   1 file changed, 66 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-platform_profile
>>> b/Documentation/ABI/testing/sysfs-platform_profile
>>> new file mode 100644
>>> index 000000000000..240bd3d7532b
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-platform_profile
>>> @@ -0,0 +1,66 @@
>>> +Platform-profile selection (e.g.
>>> /sys/firmware/acpi/platform_profile)
>>> +
>>> +On modern systems the platform performance, temperature, fan and
>>> other
>>> +hardware related characteristics are often dynamically configurable.
>>> The
>>> +profile is often automatically adjusted to the load by some
>>> +automatic-mechanism (which may very well live outside the kernel).
>>> +
>>> +These auto platform-adjustment mechanisms often can be configured
>>> with
>>> +one of several 'platform-profiles', with either a bias towards low-
>>> power
>>> +consumption or towards performance (and higher power consumption and
>>> +thermals).
>>> +
>>> +The purpose of the platform_profile attribute is to offer a generic
>>> sysfs
>>> +API for selecting the platform-profile of these automatic-
>>> mechanisms.
>>> +
>>> +Note that this API is only for selecting the platform-profile, it is
>>> +NOT a goal of this API to allow monitoring the resulting performance
>>> +characteristics. Monitoring performance is best done with
>>> device/vendor
>>> +specific tools such as e.g. turbostat.
>>> +
>>> +Specifically when selecting a high-performance profile the actual
>>> achieved
>>> +performance may be limited by various factors such as: the heat
>>> generated
>>> +by other components, room temperature, free air flow at the bottom
>>> of a
>>> +laptop, etc. It is explicitly NOT a goal of this API to let
>>> userspace know
>>> +about any sub-optimal conditions which are impeding reaching the
>>> requested
>>> +performance level.
>>> +
>>> +Since numbers are a rather meaningless way to describe platform-
>>> profiles
>>
>> It's not meaningless, but rather ambiguous. For a range of 1 to 5, is 1
>> high performance, and 5 low power, or vice-versa?
> 
> It is meaningless because the space we are trying to describe with the
> profile-names is not 1 dimensional. E.g. as discussed before cool and
> low-power are not necessarily the same thing. If you have a better way
> to word this I'm definitely in favor of improving the text here.

I'm good with 'ambiguous' here as numbers are (interestingly) ambiguous. 
I've not thought of anything better
Any objections?

> 
>>
>>> +this API uses strings to describe the various profiles. To make sure
>>> that
>>> +userspace gets a consistent experience when using this API this API
>>
>> you can remove "when using this API".
Ack
>>
>>> +document defines a fixed set of profile-names. Drivers *must* map
>>> their
>>> +internal profile representation/names onto this fixed set.
>>> +
>>> +If for some reason there is no good match when mapping then a new
>>> profile-name
>>> +may be added.
>>
>> "for some reason" can be removed.
Ack
>>
>>>   Drivers which wish to introduce new profile-names must:
>>> +1. Have very good reasons to do so.
>>
>> "1. Explain why the existing 'profile-names' cannot be used"
>>
>>> +2. Add the new profile-name to this document, so that future drivers
>>> which also
>>> +   have a similar problem can use the same name.
>>
>> "2. Add the new 'profile-name' to the documentation so that other
>> drivers can use it, as well as user-space knowing clearly what
>> behaviour the 'profile-name' corresponds to"
How about just :
"2. Add the new profile name, along with a clear description of the 
behaviour, to the documentation."

It should be clear for all 'consumers' - regardless of origin
>>
>>> +
>>> +What:          /sys/firmware/acpi/platform_profile_choices
>>> +Date:          October 2020
>>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>>> +Description:
>>> +               Reading this file gives a space separated list of
>>> profiles
>>> +               supported for this device.
>>
>> "This file contains a space-separated list of profiles..."
Ack
>>
>>> +
>>> +               Drivers must use the following standard profile-
>>> names:
>>> +
>>> +               low-power:              Emphasises low power
>>> consumption
>>> +               cool:                   Emphasises cooler operation
>>> +               quiet:                  Emphasises quieter operation
>>> +               balanced:               Balance between low power
>>> consumption
>>> +                                       and performance
>>> +               performance:            Emphasises performance (and
>>> may lead to
>>> +                                       higher temperatures and fan
>>> speeds)
>>
>> I'd replace "Emphasises" with either "Focus on" or the US English
>> spelling of "Emphasizes".
Darn - Google confirms that Emphasizes is more correct now. For some 
reason that's slightly disappointing :)
Ack.
>>
>>> +               Userspace may expect drivers to offer at least
>>> several of these
>>> +               standard profile-names.
>>
>> Replce "at least several" with "more than one".
Ack
>>
>>> +
>>> +What:          /sys/firmware/acpi/platform_profile
>>> +Date:          October 2020
>>> +Contact:       Hans de Goede <hdegoede@redhat.com>
>>> +Description:
>>> +               Reading this file gives the current selected profile
>>> for this
>>> +               device. Writing this file with one of the strings
>>> from
>>> +               available_profiles changes the profile to the new
>>> value.
>>
>> Is there another file which explains whether those sysfs value will
>> contain a trailing linefeed?
> 
> sysfs APIs are typically created so that they can be used from the shell,
> so on read a newline will be added. On write a newline at the end
> typically is allowed, but ignored. There are even special helper functions
> to deal with properly ignoring the newline on write.
> 
> Regards,
> 
> Hans
> 
> 
OK - does that need to actually be specified here? Or is that just 
something I keep in mind for the implementation?

Mark
