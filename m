Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07A4D87B7
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241317AbiCNPGa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 11:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242383AbiCNPGY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 11:06:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F483EBBF
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 08:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647270312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fOy8f6cj6s2wj9AGd4w/SPK3fCSmNG85FZVc9IDVx9A=;
        b=UuX9Ch53QtE6Aq2tygZf9/N3cDi5JFiedAyZ5Ili/Sub4Ei9G5CHXXLWTtzfMDBbpwMYru
        VdPv8yI3pKlOpKFc5MRzRXU83e8V7yFcdjy2jruH+i82qX/SS8x1XYJiF9vwqcA1XEqzpH
        2EKeD5G6w/kSr4DKKQgvqWbAj4Ant6w=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-j-xoO_UvMz2D13VjJjPbDg-1; Mon, 14 Mar 2022 11:05:08 -0400
X-MC-Unique: j-xoO_UvMz2D13VjJjPbDg-1
Received: by mail-ed1-f72.google.com with SMTP id r8-20020aa7d588000000b00416438ed9a2so8915699edq.11
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 08:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fOy8f6cj6s2wj9AGd4w/SPK3fCSmNG85FZVc9IDVx9A=;
        b=EFQJi7BoGD0MRi0Ymu8ZOYchdfxbVdo1FVfECcUVQigcciGBKpzEARMnAHTpgHCAFT
         I44iaIghs25ihp2QElor5jJ2Y2JDwBBcBZv+4jnpW/sd2vDEn+G9VTh2aHGMIrF9bo3q
         wQive6/TqSDgdAFh0KPRsAzGIKkTpggLgDPTXVAubqdE54owmrgO0v7zmqqOe2dWET2q
         ejvwG8vyriz1b2rDPGwdpL6doZqI/GXCn6YLZNaRvhmqimGf6mE1VWNOJMhPWVH5c2mu
         iIazpPYox6eio8WB4SP0EqiZB2Yy5vcpuyGSje2wRjcokMdxkFvplzVmVnE3bgw2jmyh
         uGgg==
X-Gm-Message-State: AOAM532AF7NMDQg9h5wult4PJMFMANHjrkG7xCe8Bbeuz/BpjyQvlPov
        sbHo2EehXafSiP48M3alwM5L6sRjjSdD79yQKBieZHqRWAfMs5Q2iPOizvVPcpq3hpl03TmT19p
        vzYX68cqD+G0HLPLbLiVOKg==
X-Received: by 2002:a17:906:eb51:b0:6db:a3d:3a0b with SMTP id mc17-20020a170906eb5100b006db0a3d3a0bmr18909829ejb.140.1647270307698;
        Mon, 14 Mar 2022 08:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKkyWILj/uSnUtqSnKVDm04QHnSXjZ4arZqMK0nAIJqO/0paQj4L3FaVFAfdBelObKMZtbUg==
X-Received: by 2002:a17:906:eb51:b0:6db:a3d:3a0b with SMTP id mc17-20020a170906eb5100b006db0a3d3a0bmr18909812ejb.140.1647270307407;
        Mon, 14 Mar 2022 08:05:07 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k3-20020a05640212c300b0041605b2d9c1sm7904468edx.58.2022.03.14.08.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:05:07 -0700 (PDT)
Message-ID: <63a1c7a3-f023-b709-4b3e-7a505d5f97ed@redhat.com>
Date:   Mon, 14 Mar 2022 16:05:06 +0100
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
 <c18abb55-6874-6e1e-bdb0-9d96d52987cd@redhat.com>
 <BL1PR12MB5157C14DE5F521D4B5C08366E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
 <7fac7bee-124a-90b0-6f47-e7b7e9948d6c@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <7fac7bee-124a-90b0-6f47-e7b7e9948d6c@lenovo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/14/22 15:59, Mark Pearson wrote:
> 
> Hi Hans & Mario
> 
> Thanks for all the comments.
> 
> On 2022-03-14 10:43, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 3/14/22 14:39, Limonciello, Mario wrote:
>>> [Public]
>>>
>>>>>
>>>>> I cycled through a few different implementations but came down on what I
>>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>>> makes it overall more complicated than it needs to be and less flexible.
>>>>
>>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>>> because I'm wondering how the firmware API here actually looks like,
>>>> something which so far is not really clear to me.
>>>>
>>>> When you say that you considered using 6 values, then I guess that
>>>> the firmware API actually offers 6 values which we can write to a single slot:
>>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>>> performance
>>>>
>>>> ?
>>>>
>>>> But that is not what the RFC patch that started this thread shows at all,
>>>> the API to the driver is totally unchanged and does not get passed
>>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>>> switches between say ac-balanced and dc-balanced internally.
>>>>
>>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>>> the OS at all, this is handled internally inside the EC, correct ?
>>>>
>>>
>>> No - on Lenovo's platform there are 6 different profiles that can be selected
>>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>>> use on AC.
>>
>> Ah, I already got that feeling from the rest of the thread, so I reread
>> Mark's RFC again before posting my reply today and the RFC looked like
>> the same 3 profiles were being set and the only functionality added
>> was auto profile switching when changing between AC/battery.
>>
>> Thank you for clarifying this. Having 6 different stories
>> indeed is a very different story.
> 
> Apologies if I wasn't clear. I was trying to come up with a design that
> took advantage of the AMD platforms have 6 settings, but was extensible
> generally to other situations.
> 
> I will redo the patches and add the thinkpad_acpi on top - that will
> help it be clearer.
>>
>>>> Otherwise I would expect the kernel internal driver API to also change and
>>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>>
>>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>>> and based on the direction try to implement the thinkpad-acpi change after that.
>>>
>>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>>> modeled on top of this the way that you want.
>>
>> I fully agree and since you introduce the concept of being on AC/battery to the
>> drivers/acpi/platform_profile.c cpde, please change the 
>> profile_set and profile_get function prototypes in struct platform_profile_handler
>> to also take a "bool on_battery" extra argument and use that in the thinkpad
>> driver to select either the ac or the battery tuned low/balanced/performance 
>> profile.
> 
> OK - I was thinking that, but I also figured the thinkpad driver could
> get the power status directly so it was largely redundant (and saves churn
> on all the other platform profile drivers - there are quite a few now)

If we get the power-status in 2 places things could get out of sync, there
could be unexpected race conditions, etc. Better to do just do it in one
place and pass the result along.

>> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
>> in the next RFC.
> Absolutely - that was intended. My aim with this RFC was to get feedback
> on if it was acceptable or not, and if the design had to change. Really
> appreciate all the good points.
> 
>>
>> Also notice how I've tried to consistently use AC/battery in my last reply,
>> DC really is not a good term for "on battery". AC also is sort of dubious
>> for "connected to an external power-supply" but its use for that is sorta
>> common and it is nice and short.
>>
>> Sorry if this seems like bikeshedding, but using DC for "on battery" just
>> feels wrong to me.
> Ack - and I'm good with the suggestion.
> 
>>
>>
>>>>> The biggest use case I can think of is that a user wants performance
>>>>> when plugged in and power-save when unplugged; and they want that to
>>>>> happen automatically.
>>>>
>>>> Right, so this what I have understood all along and I'm not disagreeing
>>>> that this is a desirable feature, but it _does not belong in the kernel_!
>>>>
>>>> Also taking Mario's remark about the EC-firmware using differently
>>>> tuned balanced profiles based on ac vs dc, here is how I envision this
>>>> working:
>>>>
>>>> 1. Laptop is connected to charger
>>>> 2. EC notices this and:
>>>> 2.1 Internally switches from balanced-dc settings to balanced-ac settings
>>>> 2.2 Sends out an event about the laptop now being on AC, which the kernel
>>>>     picks up and then sends to userspace (this already happens)
>>>> 3. Userspace, e.g. power-profiles-daemon, gets the event that the laptop is
>>>>    now an AC and in its settings sees that the user wants to switch to
>>>>    performance mode on AC and uses the platform_api in its current form to
>>>>    ask for a switch to performance mode
>>>> 4. The EC gets a command telling it to switch to performance mode and
>>>>    switches to the ac-tuned version of performance mode since the laptop is
>>>>    on ac.
>>>>
>>>
>>> None of this happens internally on the EC.
>>
>> Ack, I understand now thank you for clarifying this.
> Sorry for not being clear here
> 
>>
>>> Also there is nothing in this design
>>> that guarantees it needs to be EC driven profile changes.  It could be other
>>> mailboxes, ASL code, SMM etc.
>>>
>>> The key point here is that thinkpad acpi has 3 AC and 3 DC profiles to choose from,
>>> so some level from thinkpad acpi above needs to pick among them.
>>
>> Ack.
>>
> I think this is what makes having the design in the kernel more important.
> 
> I understand the keeping the kernel small, but the thinkpad_acpi driver
> needs to guarantee it knows it will get the notification. Without that I
> don't think I can implement the feature reliably
> 
> An alternative to the implementation is for me to do this in just the
> thinkpad_acpi driver and just for PSC mode, and that's what I started
> with when I looked at this (it's quite a nice simple implementation FWIW).
> But I figured having something that was configurable has benefits, and
> something that is applicable to all platforms is a nice feature as well.
> 
> If doing thinkpad_acpi only would be preferred and more acceptable let
> me know - but I think it's more limiting overall

I believe that given the hardware interface it makes sense to handle this
in the kernel; and for other platforms this will also give the option
to have 2 separate profiles for ac/battery and have the kernel auto-switch,
and they can just ignore the extra bool on_battery parameter to the
getters/setters.

Note we do still eventually need to get Rafael to weigh in and get
his consent on this too.

Regards,

Hans

