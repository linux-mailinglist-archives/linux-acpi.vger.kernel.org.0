Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565EE4D855A
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 13:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbiCNMtF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 08:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242260AbiCNMs1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 08:48:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE5ECDC5
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 05:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647261922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ko9Pq+nujR93rrqWCg4cr/ojM0WA1IT4uWw4ERwFbho=;
        b=RzILbf+ZFXLja6LinKm8MEymIXQuvA5M4+sBZwBqUjIUQgGsFREqmybc59WLeaz2EBtVwR
        fuCGxUesHreiRnloG7kfaFaihWxR8xX8WyCHpBKpcxcmgYvY/J/BfqUyBQXdX0dYpJKOmr
        fwxvs6kYWsvmYL39+fWJe/4oQb5C9nI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-qszimuBDNAG5cG7tRKPaaA-1; Mon, 14 Mar 2022 08:45:21 -0400
X-MC-Unique: qszimuBDNAG5cG7tRKPaaA-1
Received: by mail-ed1-f69.google.com with SMTP id l8-20020a056402028800b0041636072ef0so8569350edv.13
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 05:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ko9Pq+nujR93rrqWCg4cr/ojM0WA1IT4uWw4ERwFbho=;
        b=PI54NkhDsV2Z4nn4rTUbWWvXMcM1z0Y2UpGeiGvZCyVyDYY9OlwmKmmyJa+IC4KDCj
         jkdjPi/2n5AOvgbclqsT+57plSQD2+Tg8PREO4xmAf9+8JQRPXrbXe4uEUfXjPJWghuH
         QqRG1NONJ5EgI12YRaVZWhxzzX7NDZwpAzn2gjFUbNSdjgKfRZ2wCMDYWegleDKPD7Yf
         qRPiUllY6tfhTe2jMNylA9LYMAtJ7/r9ysO5PXdc3G6/3mSTEVa0Y4dJn5jAoSYMqFlJ
         K4bAyJ5UGnL2Ps1bYyxTjRTC/BQWEDKo6VIvstBiIp5lMA7BDmSeVAEMADfZXwjIC6SS
         wIag==
X-Gm-Message-State: AOAM533jb7dQWMbNcdwHZcMCm/sCoarPShDnEROpwvY0KrkqPuXVEOfM
        jR1FEjxTGO/ikEl1pxaFjjyHSxkia8rtg2VwN4yQ1dDKoC8bbjOlBAuEmcUBlSX18y+xxmqoRXP
        Xue0muI7sBryYFFpD5hyX7g==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr19839654edw.113.1647261920319;
        Mon, 14 Mar 2022 05:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrpc8wiG9oQ3qlRC2XNAiY6B5+pwU1vsVE6vrq4nkf+MiQB1tgYnnhLIcbB33yteCeHna8YA==
X-Received: by 2002:a05:6402:1148:b0:413:11e0:1f58 with SMTP id g8-20020a056402114800b0041311e01f58mr19839638edw.113.1647261920000;
        Mon, 14 Mar 2022 05:45:20 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id b9-20020a056402278900b004186d013655sm3765988ede.33.2022.03.14.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 05:45:19 -0700 (PDT)
Message-ID: <c18abb55-6874-6e1e-bdb0-9d96d52987cd@redhat.com>
Date:   Mon, 14 Mar 2022 13:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <markpearson@lenovo.com>
 <20220301201554.4417-1-markpearson@lenovo.com>
 <65d8cf3b-0eea-0583-fa23-e2c71287fb85@redhat.com>
 <BL1PR12MB5157CDB77675859B7F279578E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <7b281a37-5163-6cd7-360e-1c63bde714a8@redhat.com>
 <BL1PR12MB5157125246817A70649C12F7E2099@BL1PR12MB5157.namprd12.prod.outlook.com>
 <1cd4ae24-ae92-302e-ac87-76ef15472a9f@redhat.com>
 <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <2180533b-c921-5ae4-e6bc-569728a4f990@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

On 3/8/22 18:44, Mark Pearson wrote:
> 
> Thanks Mario & Hans
> 
> On 2022-03-08 11:10, Hans de Goede wrote:
>> Hi,
>>
>> On 3/8/22 16:55, Limonciello, Mario wrote:
>>> [AMD Official Use Only]
>>>
>>>>> I don't think that's right for the PSC Thinkpads.  They have dedicated
>>>>> different tunings for each of the slider positions on AC vs DC.
>>>>>
>>>>> So "balanced" on AC will not be the same as "balanced" on DC.
>>>>
>>>> I see, but it is not like balanced on AC is closer to performance
>>>> on DC then it is to balanced on DC, right? IOW in the UI we should
>>>> still call them both balanced ?
>>>
>>> I feel that's a gross oversimplification to say balanced on AC is close
>>> to performance on DC.  There are *so many* other (otherwise invisible)
>>> tuning knobs behind what PSC does that Lenovo has weighed out the benefits
>>> of using for different circumstances.  
>>>
>>> You nerf all this by just having one user space facing knob and let userspace
>>> change to performance mode when you on charger.
>>
>> The way I see this there are 2 ways this can work on the kernel to fw/ec
>> boundary:
>>
>> 1. There are actually 6 values we can write to a single slot:
>>    ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-performance
>>
>> 2. There are separate ac-setting + dc-setting slots to which we can
>>    write one of 3 values: low-power, balanced, performance; and the fw/ec
>>    automatically picks which slot to used based on ac vs battery status
>>
>> If 1 is the case for PSC then I agree that the kernel should indeed get involved
>> and it should automatically write either the ac or dc variant of the last
>> userspace requested value so that things behave as expected.
>>
>> If 2 however is the case then I think all that is necessary is for the
>> driver to just write the last userspace selected value to both slots.
>>
>> Note that neither case requires a userspace API change when solved
>> as I suggest.
> 
> I cycled through a few different implementations but came down on what I
> proposed. I considered 6 values - but I don't think that makes sense and
> makes it overall more complicated than it needs to be and less flexible.

Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
because I'm wondering how the firmware API here actually looks like,
something which so far is not really clear to me.

When you say that you considered using 6 values, then I guess that
the firmware API actually offers 6 values which we can write to a single slot:
ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-performance

?

But that is not what the RFC patch that started this thread shows at all,
the API to the driver is totally unchanged and does not get passed
any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
uses for this writes only 1 of 3 values to a single slot and the EC automatically
switches between say ac-balanced and dc-balanced internally.

IOW there really being 2 differently tuned balance-profiles is not visible to
the OS at all, this is handled internally inside the EC, correct ?

Otherwise I would expect the kernel internal driver API to also change and
to also see a matching thinkpad_acpi patch in the RFC series?

> The biggest use case I can think of is that a user wants performance
> when plugged in and power-save when unplugged; and they want that to
> happen automatically.

Right, so this what I have understood all along and I'm not disagreeing
that this is a desirable feature, but it _does not belong in the kernel_!

Also taking Mario's remark about the EC-firmware using differently
tuned balanced profiles based on ac vs dc, here is how I envision this
working:

1. Laptop is connected to charger
2. EC notices this and:
2.1 Internally switches from balanced-dc settings to balanced-ac settings
2.2 Sends out an event about the laptop now being on AC, which the kernel
    picks up and then sends to userspace (this already happens)
3. Userspace, e.g. power-profiles-daemon, gets the event that the laptop is
   now an AC and in its settings sees that the user wants to switch to
   performance mode on AC and uses the platform_api in its current form to
   ask for a switch to performance mode
4. The EC gets a command telling it to switch to performance mode and
   switches to the ac-tuned version of performance mode since the laptop is
   on ac.

So same end-result, but without introducing new userspace API. Note that
even if we were to go with your RFC userspace would still need to be
adjusted to use the new uapi, so AFAICT we really win nothing by doing this
in the kernel.

> This patch let's that happen for any platform - regardless of if it has
> separate support.

Doing this fully in userspace also allows this to happen for any platform.

> If a vendor wants to handle plugged in vs battery to a
> more nuanced degree they can, but that's at the individual driver level.
> 
> I originally thought that maybe this should be done in user space but:
> 
> 1) It takes a lot longer for user space changes to get rolled out and
> make it into distros.

Distros usually are quicker in updating userspace bits which are required
for hw-enablement purposes; and for this to be really useful it
needs a UI to control it, so it will need userspace support regardless
of where we solve it.

> 2) Not all users will get to use it - sure Gnome and KDE might get the
> feature but chances of other desktops picking it up are small. I could
> look at releasing a utility to do it but....urgh. Nobody gets a good
> experience that way. Linux packaging is a minefield.

Many many hw-enablement things, like thunderbolt authentication, proper
automatic switching of audio streams, proper handling of various hotkeys
like vol / brightness up/down, privacy screen on/off toggling, easy use
of VPNs and wwan modems, are all not or very poorly supported in other
desktop-environments. I often get bug reports from users using other
DEs about things like this and there really is nothing which we can
do about this. In some cases like i3 window-manager the norm
is actually for users to have to write custom scripts for everything.

Other DEs do try, but simply lack the manpower, this is an unfortunate
situation, but not really a good argument for just shoving everything
in the kernel.

> 3) The power events happen in the kernel which is perfect. Once I
> figured that out it seemed a no-brainer to me.

That same event also gets forwarded to userspace over the power_supply
class uapi.
> I think user space should add the ability to have a nice GUI to toggle a
> unplugged profile setting. But the guts of it seem to me to belong
> better in the kernel.

There is nothing which the kernel can do here, which userspace cannot
also do; and generally speaking in cases like this userspace can do it
better, because it can add a lot more fancy policy like (random example):
switch to performance mode when on AC and the battery is fully charged.

There will be many different usecases here and hardcoding a single
simple but also dumb policy in the kernel really is not doing anyone
any favors.

>>> At least the way Windows does this is that it offers "one" UI slider but you
>>> have last selected values based on if you're plugged in or on battery.
>>>
>>> 1) So on battery I might have balanced selected to start out.
>>> 2) Then I plug in a charger, and balanced is still selected but this has
>>> different characteristics from balanced on battery.
>>> 3) Now I change to performance while on charger.
>>> 4) Then I unplug charger and it goes back to my selection for battery: "balanced".
>>
>> The above is more about policy then it is about mechanism, userspace
>> can easily remember 2 separate settings for ac vs battery and restore
>> the last set value for ac or battery when changing between the 2.
>>
>> Since this mostly about the policy which profile to set when this
>> really belongs in userspace IMHO and solving this in userspace means that
>> we will have a single universal solution for all the different
>> platform_profile implementations, and we seem to have quite a lot of
>> those (at least one per laptop vendor, Lenovo currently has 2)
> 
> I disagree here. This is more universal by design. I was surprised at
> how many vendors are using platform-profiles (I think it's awesome!) but
> now they can all get this too. The intention here is very strongly not
> supposed to be Lenovo specific.

A userspace solution, at least at the power-profile-daemon level will
be just as universal. And as for unsupported DEs, whether users have
to manually poke a sysfs file, or have to manually make a dbus call
(which can also be done from the shell) really does not make much
of a difference.

> The follow on patch that I could do in thinkpad_acpi to use a different
> setting in unplugged/plugged mode - that will be Lenovo specific and
> taking advantage of the functionality the Lenovo FW is offering. That
> doesn't seem unreasonable to me.
> 
>>>> If that is right then I think my point still stands, if PSC
>>>> has 2 separate slots (one AC one DC) for the performance
>>>> setting, then we can just set both when userspace selects a
>>>> performance level and have the actual e.g. balanced -> performance
>>>> change be done by userspace when userspace select the machine
>>>> has been connected to a charger.
>>>
>>> But you *don't want to* actually select performance when you switch to a
>>> charger.  If you have 3 value slots for AC and 3 value slots for DC you
>>> should only be swapping between what is in those 3 values slots.
>>
>> That only works if all implementation have separate AC and DC profile
>> slots, which most won't have. If we just sync the 2 slots for implementations
>> which do have 2 slots and then always "fake" 2 slots in userspace we
>> have a universal implementation which will work well everywhere, without
>> any significant downside to the implementations which do have 2 slots.
>>
> I'm missing something in this bit. If a vendor is providing platform
> profiles all we're doing is letting a user choose the profile they want
> depending on their power situation. I don't think there are empty slots
> particularly.
> 
> I've got a feeling I'm missing something obvious - but my experience of
> user space is it's really hard to get a consistent experience for all
> Linux users reliably - everybody is running something different.
> If nothing else I think that should be a big factor for adding this
> support to the kernel.

See above, userspace not doing its job properly is really not a good
argument to put something in the kernel. The kernel generally is
about resource management/sharing and hardware abstraction,
in general where possible the kernel should provide mechanism with
no, or a very minimal policy and leave the rest up to userspace.

This feels like just shoving something into the kernel just because
that is convenient, not because it really belongs in the kernel,
but we want the kernel to be as small as possible (it really already
is much too big) because:

1. Any kernel bugs are fatal if they get triggered, unlike hitting
   a bug in userdspace code, hitting a bug in kernelspace code will
   almost always take the entire system down.
2. Kernel memory is not swapable

> Obviously if this feature isn't wanted I'll drop it - but I think it's
> something useful that users will appreciate on any HW.

Above you are talking about changes to the thinkpad_acpi driver
to possibly use some sort of "hardware" support for ac/dc profile
switching, that is something which might be sensible to support
in the kernel, although given that that is Lenovo specific a
generic userspace solution to offer the same functionality by
having p-p-d switch profiles on ac/dc changes seems like it
would work just as well, avoiding the need for anything lenovo
specific .

Regards,

Hans

