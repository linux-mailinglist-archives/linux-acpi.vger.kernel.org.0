Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E9C29AC10
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 13:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899837AbgJ0M3J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 08:29:09 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.116]:9586 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2899836AbgJ0M3H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 08:29:07 -0400
Received: from [100.112.7.7] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-east-1.aws.symcld.net id 75/DA-11870-B82189F5; Tue, 27 Oct 2020 12:28:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsWS8eIhj26X0Ix
  4g0UvrSz2X5ew6FpoYLHw/ilWi6/fbrNbvDk+ncli+b5+RovLu+awWXzuPcJo0dTZBGR1TGax
  WL3nBbMDt8ekmTOYPXbOusvu8WvbGhaPzSu0POadDPR4v+8qm8fnTXIB7FGsmXlJ+RUJrBnf9
  icWtGpWfF3+lqmBca98FyMXh5DAf0aJ5Q8fMEI4LxglLv5fw9bFyM4hLFAicTCpi5GTQ0TAW+
  L7pWlMICXMIPW9W6awQdQvYZSY8fcQO0gVm4C2xJYtv9hAbF4BW4nu9V9YQWwWAVWJzUcfgMV
  FBcIlOm7sYIKoEZQ4OfMJC4jNKaAm0dl4AizOLGAhMXP+eUYIW1zi1pP5UHF5ieats5lBbAkB
  BYk1D65B2QkSy17eYZ7AKDgLydhZSEbNQjJqFpJRCxhZVjGaJRVlpmeU5CZm5ugaGhjoGhoa6
  ZrpGhlb6CVW6SbrlRbrpiYWl+ga6iWWF+sVV+Ym56To5aWWbGIERmBKAdu7HYzb3nzQO8Qoyc
  GkJMq7ftf0eCG+pPyUyozE4oz4otKc1OJDjDIcHEoSvJMEZsQLCRalpqdWpGXmAJMBTFqCg0d
  JhNdOECjNW1yQmFucmQ6ROsWoKCXOywhMIUICIImM0jy4NlgCusQoKyXMy8jAwCDEU5BalJtZ
  gir/ilGcg1FJmPcVyHiezLwSuOmvgBYzAS1uq5gCsrgkESEl1cBUKXlCXUA/Tur8Kn+X2YG6d
  gZz3mqmP0nZknoj8/F954PVCm/dZGfKb721fbrPiy/d8/ac8nphPHfPwrzb+9/e7N2cX5h91O
  FvBVecVtSsx4u+Ls75tF3zzFOtmb6iDNFL7UXiJ0bx1HV9T+MonZYz4Wnbv72J+n815svwXzt
  69nfybist/cR5epc7ow7eFX9+QOUKV4X3n9y5JmvYDii9+HklRqlPqfenU9uPG9XX4q7mrl3A
  LpG19utFX6kXVXe+/bKbylR0ZrHD3HWz16y9eV9nJUO+7ttYlXaLkMXq75jb39llvd92N9Q8e
  OmC67f0ApUfr02+WD9vk2XgNAXxyKKCX3wSzJf3PpjUNCPGWomlOCPRUIu5qDgRALJOAW27Aw
  AA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-23.tower-406.messagelabs.com!1603801738!808234!1
X-Originating-IP: [104.232.225.12]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27457 invoked from network); 27 Oct 2020 12:28:58 -0000
Received: from unknown (HELO lenovo.com) (104.232.225.12)
  by server-23.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Oct 2020 12:28:58 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id B57836ECE6A6E4B1DADE;
        Tue, 27 Oct 2020 08:28:58 -0400 (EDT)
Received: from localhost.localdomain (10.46.57.204) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Tue, 27 Oct
 2020 05:28:56 -0700
Subject: Re: [External] Re: [PATCH] [RFC] Documentation: Add documentation for
 new platform_profile sysfs attribute
To:     Elia Devito <eliadevito@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     <dvhart@infradead.org>, <mgross@linux.intel.com>,
        <mario.limonciello@dell.com>, <hadess@hadess.net>,
        <bberg@redhat.com>, <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <markpearson@lenovo.com>
 <ef9b93a0-636f-9b96-9d5b-fee1e5738af7@lenovo.com>
 <1fbaf1fa-47c6-afe7-ca9e-41b3ad6a4556@redhat.com> <12633630.uLZWGnKmhe@pce>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <1bddcede-5e12-6089-8920-26dd5f534b44@lenovo.com>
Date:   Tue, 27 Oct 2020 08:28:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <12633630.uLZWGnKmhe@pce>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.57.204]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Elia

On 27/10/2020 05:19, Elia Devito wrote:
> Hi to all,
> 
> In data martedì 27 ottobre 2020 08:54:44 CET, Hans de Goede ha scritto:
>> Hi,
>>
>> On 10/26/20 8:55 PM, Mark Pearson wrote:
>>> Thanks Hans
>>>
>>> On 26/10/2020 14:33, Hans de Goede wrote:
>>>> Hi Mark,
>>>>
>>>> Thank you for this new version.
>>>>
>>>> On 10/26/20 6:44 PM, Mark Pearson wrote:
>>>>> From: Hans de Goede <hdegoede@redhat.com>
>>>
>>> <snip>
>>>
>>>>> +
>>>>> +If for some reason there is no good match when mapping then a new
>>>>> profile-name +may be added. Drivers which wish to introduce new
>>>>> profile-names must: +1. Have very good reasons to do so.
>>>>> +2. Add the new profile-name to this document, so that future drivers
>>>>> which also +   have a similar problem can use the same new.
>>>>
>>>> s/same new/same name/
>>>
>>> I've read this document so many times...I'm not sure how I missed that
>>> one. Thanks.>
>>>>> + Usually new profile-names will
>>>>> +   be added to the "extra profile-names" section of this document. But
>>>>> in some +   cases the set of standard profile-names may be extended.
>>>>
>>>> With the change from a more generic API to this new one more targeted
>>>> towards DPTF I would drop this part.
>>>
>>> OK - I have some questions then related to this change, below
>>>
>>>>> +
>>>>> +What:        /sys/firmware/acpi/platform_profile_choices
>>>>> +Date:        October 2020
>>>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>>>> +Description:
>>>>> +        Reading this file gives a space separated list of profiles
>>>>> +        supported for this device.
>>>>> +
>>>>> +        Drivers must use the following standard profile-names whenever
>>>>> +        possible:
>>>>> +
>>>>> +        low-power:        Emphasises low power consumption
>>>>> +        quiet:            Offers quieter operation (lower fan
>>>>> +                    speed but with higher performance and
>>>>> +                    temperatures then seen in low-power
>>>>
>>>> I think the description here is a bit too specific, this may cause
>>>> userspace to have expectations which are not necessary true. I would
>>>> describe this as just:
>>>>
>>>>          quiet:            Emphasises quieter operation
>>>
>>> Agreed. I'll update
>>>
>>>>> +        balanced:        Balance between low power consumption
>>>>> +                    and performance
>>>>> +        performance:        Emphasises performance (and may lead to
>>>>> +                    higher temperatures and fan speeds)
>>>>> +
>>>>> +        Userspace may expect drivers to offer at least several of these
>>>>> +        standard profile-names! If none of the above are a good match
>>>>> +        for some of the drivers profiles, then drivers may use one of
>>>>> +        these extra profile-names:
>>>>> +        <reserved for future use>
>>>>> +
>>>
>>> If we remove the extra profile-names section above then I think it should
>>> be removed here too. If someone wants to add a new 'mode' then it would
>>> be added to the list of 'standard names', and becomes a new option.
>>> Wanted to check I'm not missing something important.
>> You are completely right, any references to an extra profile-names section
>> should be removed here too. I did intend to add that it should be removed
>> here too, but I forgot.
>>
>>>>> +What:        /sys/firmware/acpi/platform_profile
>>>>> +Date:        October 2020
>>>>> +Contact:    Hans de Goede <hdegoede@redhat.com>
>>>>> +Description:
>>>>> +        Reading this file gives the current selected profile for this
>>>>> +        device. Writing this file with one of the strings from
>>>>> +        available_profiles changes the profile to the new value.
>>>>
>>>> The part about custom profiles below may be dropped. That was intended
>>>> for use with e.g. GPUs but since this now strictly is a system-level
>>>> profile API, the part below can be dropped now.
>>>
>>> Agreed
>>>
>>>>> +
>>>>> +        Reading this file may also return "custom". This is intended
>>>>> for
>>>>> +        drivers which have and export multiple knobs. Such drivers may
>>>>> +        very well still want to offer a set of profiles for easy of use
>>>>> +        and to be able to offer a consistent standard API (this API) to
>>>>> +        userspace for configuring their performance. The "custom" value
>>>>> +        is intended for when ai user has directly configured the knobs
>>>>> +        (through e.g. some advanced control-panel for a GPU) and the
>>>>> +        knob values do not match any of the presets represented by the
>>>>> +        platform-profiles. In this case writing this file will
>>>>> +        override the modifications and restore the selected presets.
>>>>> +
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>
>>> Thanks!
>>> mark
>>
>> Regards,
>>
>> Hans
> 
> This look good,
> only thing is that hp-wmi driver need a cool profile (Emphasises the computer
> cool to touch), if you can add it would be perfect.
> 
> Regards
> Elia
> 
> 
> 
Is low-power is different to cool? I figured low-power was going to be 
cool so combined them.
I could call it low-power-cool if that helps? It seems a little clunky 
but not too bad. I'm sure the user space folks can put sunglasses on it 
or something ;)

Mark
