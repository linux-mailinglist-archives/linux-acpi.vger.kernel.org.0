Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451504FBE15
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Apr 2022 16:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbiDKODd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Apr 2022 10:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346807AbiDKODb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Apr 2022 10:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BFA831DEC
        for <linux-acpi@vger.kernel.org>; Mon, 11 Apr 2022 07:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649685676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y4F8dqXHcBu4Aif1bka3gidub9+IdsEqN8o95WTESwk=;
        b=K2wXljTbjOkta547ZfhHGrRAGSc7g8Y+7tMg7E3eUXutqBBPCpJNM0rbRlQxOsnt8zJtk8
        NneTC7PhQMcsRsBUFxpObkgNKujqX5B9ZyTwUcU2rGMKtjwzxF6flyGCxuqmyzelnsDpiF
        8ksVV3JgMCp/zNgrugyJfxjFCpNALbg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-279-DkFIRoopNMe3VuFPHhfnhw-1; Mon, 11 Apr 2022 10:01:15 -0400
X-MC-Unique: DkFIRoopNMe3VuFPHhfnhw-1
Received: by mail-ej1-f70.google.com with SMTP id qb5-20020a1709077e8500b006e8942c5339so998205ejc.14
        for <linux-acpi@vger.kernel.org>; Mon, 11 Apr 2022 07:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=y4F8dqXHcBu4Aif1bka3gidub9+IdsEqN8o95WTESwk=;
        b=7pYFv9CyEarg21GtfKAMYI8xA7ClG9s6sRCceomCfdjrrbnvw9F0AbOD04b0bbYprW
         zDnoot+hWca9hY9J04XFMoigmrv0N0C0Ti+WA2w5gzDmxk3LNKTTcztIsdpDBlUL1ZFK
         6nXC0v9kFyvhy1Qs/B20jmsm2ux3S+iZI2djELw6aVVi50P1ngUk2Ihl5NSvumzTqQ4r
         A1FoJG/bUGPPJjpXO6BOZ/ZDJNtNkGJopzzc4hItJ0pDoJo+Z2fxKZxyoy9RKRC7xCjw
         IDwSj3c45ifemHoJZbf1MAgYJkC4ZsrJXLR2FAGB/D39Fp+LxI3zCn/DcD2r91NpLamY
         fSrg==
X-Gm-Message-State: AOAM533dT3UJ1nYRzWG2NYtOWOfZmd8/J92XYyMeV71A99NW6ivAOHUO
        kzuogb8KzXNDCGuOAloHV3DXUE2EWeW4oz4FbJg63i7q69SMWlXqVyZmqI2Z/BhqfxHfw7/dtiU
        ri/mthSCMDoSbBfxJgOl0rg==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr30060024ejc.712.1649685673426;
        Mon, 11 Apr 2022 07:01:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4xzb1BjJ/58+VPibM2TbZRBOLWheMfWS3L+4AvaOAVyXa61wjTMGMfUCBt5PtxsG84x9vKg==
X-Received: by 2002:a17:907:1b20:b0:6da:649b:d99e with SMTP id mp32-20020a1709071b2000b006da649bd99emr30059978ejc.712.1649685672932;
        Mon, 11 Apr 2022 07:01:12 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id p14-20020aa7cc8e000000b0040f13865fa9sm14716997edt.3.2022.04.11.07.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 07:01:12 -0700 (PDT)
Message-ID: <d60c470a-ba46-f719-5cc0-8a4b1c9c8cc3@redhat.com>
Date:   Mon, 11 Apr 2022 16:01:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] [discuss] Split /sys/firmware/acpi/platform_profile
 into ac and battery profiles?
Content-Language: en-US
To:     Mark Pearson <markpearson@lenovo.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Bastien Nocera <hadess@hadess.net>
Cc:     linux-acpi <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
References: <03b7d1dc-42af-7964-ab7a-bdcc6644cc71@redhat.com>
 <4b3c2dce-6271-57c3-b9d0-a186b7c82b33@lenovo.com>
 <d9aa08ef-cc0a-9edf-19a4-6fe75959b3b8@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <d9aa08ef-cc0a-9edf-19a4-6fe75959b3b8@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Mark,

On 4/1/22 21:24, Mark Pearson wrote:
> Hi
> 
> On 3/21/22 18:29, Mark Pearson wrote:
>>
>> Thanks Hans
>>
>> On 2022-03-15 05:16, Hans de Goede wrote:
>>> Hi All,
>>>
>>> AMD based ThinkPads (1) have separate ac (connected to an external 
>>> powersource) and on battery tuned versions of the low-power, balanced
>>> and performance profiles. So in essence they have six profiles:
>>> low-power-ac, low-power-battery, balanced-ac, balanced-battery,
>>> performance-ac and performance-battery.
>>>
>>> The question is how to deal with this. There is a previous
>>> discussion about this here: 
>>> https://lore.kernel.org/platform-driver-x86/20220301201554.4417-1-markpearson@lenovo.com/>>>  From that previous discussions 3 possible solutions come to mind:
>>>
>>> 1. Simply treat this as 6 different profiles, maybe with documenting 
>>> -ac/-battery postfixes for the profile-names and let userspace sort
>>> it out.
>>>
>>> Pro:    -Simple from the kernel side Contra: -Does not work with
>>> existing userspace code -This is quite ugly IMHO / does not feel
>>> right
>> Agreed - I initially looked at implementing it this way and it's not
>> good. I don't recommend it
>>
>>>
>>> 2. Only export three profiles to userspace, while going "all in" on
>>> this concept and change drivers/acpi/platform_profile.c to add new: 
>>> /sys/firmware/acpi/platform_profile_ac 
>>> /sys/firmware/acpi/platform_profile_battery files which can contain
>>> different desired settings for the ac/battery case and have the
>>> kernel automatically switch between the two and also have it pass the
>>> ac/battery state to platform_profile_handler.profile_set so that for
>>> hw which has different ac/battery flavors of the profile the driver
>>> knows which one to select (without needing to detect this itself)
>>>
>>> Pro:    -This matches well with the behavior which we want for the
>>> user (which is for the system to save the profile as 2 separate
>>> settings for ac/battery and switch the profile to the last selected
>>> setting for ac/battery when the state changes) -Solve the ac/battery
>>> state listening/notification only once instead of having all
>>> platform_profile drivers DIY Contra: -This means deprecating
>>> /sys/firmware/acpi/platform_profile and defining how it maps to the 2
>>> new files, e.g. if it is written does that only set the current
>>> active profile, or both ? -Userspace needs to be adjusted to use the
>>> new uapi and once it has been adjusted it also still needs to work on
>>> the older kernels which will be tricky/nasty to implement and also
>>> is a problem from CI / testing pov.
>>
>> I don't think the contra here is that complicated or causing backwards
>> compatibility issues.
>>
>> For the platform_profile attribute
>>  - If you read it then you get the current active configured profile
>> regardless of whether you are plugged in or not.
>>  - If you set it then it sets both ac and battery profile and they
>> stay in sync
>>
>> For the platform_profile_ac and platform_profile_dc
>>  - If you read it you get the configured setting for that power mode
>>  - If you set it, then that mode is active for the appropriate power mode
>>
>> I think that keeps this backwards compatible and user space can decide
>> on their own schedule/preferences/design if they implement something extra.
>> Am I missing something?
>>
>>>
>>> 3. Only export three profiles to userspace and have the 
>>> drivers/acpi/platform_profile.c "core" code pass the ac/battery
>>> state to platform_profile_handler.profile_set so that for hw which
>>> has different ac/battery flavors of the profile the driver knows
>>> which one to select (without needing to detect this itself)
>>>
>>> Pro:    -Solve the ac/battery state listening/notification only once 
>>> instead of having all platform_profile drivers DIY -Leaves the
>>> existing userspace API 100% unchanged and leaves existing userspace
>>> code working without it requiring any changes Contra: -As part of the
>>> discussion on this the RFE to "have separate "last selected"
>>> ac/battery profile settings and automatically switch when the state
>>> changes" has surfaced; and that is not solved
>>>
>> All looks reasonable to me.
>>
>>>
>>> Writing it down like this, to me 3. is the clear winner. The only 
>>> downside of 3. I can come up with arguably is better solved in 
>>> userspace (2), esp. since this will likely also require some UI
>>> design work to somehow make it clear to the user that there are two
>>> different settings (3).
>>
>> For me I went with #2 in the RFC implementation as I thought it was a
>> nice feature to have generally which is it's big plus - but I'm
>> genuinely fairly split as to whether #2 or #3 is best. I could easily go
>> either way.
>>
>> One Q I have is that I would like our platforms to have the ability to
>> auto-switch between AC and battery profile for their configured mode
>> automatically. So if we go with option #3 I want to implement an event
>> handler in the thinkpad_acpi driver for these platforms. Does that raise
>> any flags or concerns? I prototyped this before I wrote the RFC and it's
>> pretty simple.
>>
>>>
>>> Also even if no UI changes are deemed necessary this will still
>>> require userspace changes to save+restore the two separate "last
>>> selected" profile settings over reboots.
>>>
>>> Please let me know what you think of this, and of course another 
>>> completely different approach is welcome too.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>> 1) Although AMD based ThinkPads are the trigger for this discussion, 
>>> this applies to more new AMD based laptops, so this is not ThinkPad 
>>> specific
>> It's not even really AMD specific - doing support for them was just want
>> got the idea started.
>>>
>>> 2) IMHO it would be good to file a RFE issue for this against p-p-d: 
>>> https://gitlab.freedesktop.org/hadess/power-profiles-daemon/-/issues/new>> Once we reach conclusion if this is a ack or nack I can do that.
>> I'd love for my team to get more involved with development at that level
>> if possible.
>>
>>>  3) AFAICT Windows does the 2 separate "last selected" ac/battery
>>> profile settings thing while just showing a single slider in its UI,
>>> but that really is a whole other discussion which the userspace/UI
>>> folks can have.
>>
>> Thanks
>> Mark
> 
> Just wanted to check that, with limited responses, this thread is
> effectively closed and the decision is to go with #3 - we'll leave any
> implementation up to user space (if they want to take it on).

Yes I was hoping for some more feedback here from e.g. Rafael, but
I agree that it seems that the conclusion is to go with 3. which
is also the option which I prefer myself.

> Maybe this
> is the prod I needed to go and play there. As a note, if anybody does
> take this and needs help testing etc just let me know.
> 
> I do plan to follow up with a thinkpad_acpi specific patch for our
> platforms using PSC mode.

Sounds good, note as I indicated in the original description of 3.
I think it might be good to do the AC/battery switching listening
inside the core platform_profile code as I expect more drivers to
eventually need this.

Regards,

Hans


