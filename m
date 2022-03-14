Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884844D8817
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 16:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiCNPcV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242231AbiCNPcU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 11:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEF933ED19
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 08:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647271869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P0iSh+7F8co8uEu6ZcaAsAU45dh7setUOfi55pSd15w=;
        b=Zbv+M2kzugfoqYDUdtuPVWiDKpZVIPQJ9RdGNnRMCOLXrhBT+n8djGIFPYhSXGIyXdz+ep
        FbpbHcltCPwsOu1AfNQWmAwRBBLx52aShWvD1iu8cMmZ5e4vhmjZudXaUhBfg0ogDmOdGw
        4PZv3/fnsB5JMop8rIwHGc83A0hE+9E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147--I_H9BNrNVmqTtJMoo4rGw-1; Mon, 14 Mar 2022 11:31:08 -0400
X-MC-Unique: -I_H9BNrNVmqTtJMoo4rGw-1
Received: by mail-ed1-f69.google.com with SMTP id o20-20020aa7dd54000000b00413bc19ad08so8977983edw.7
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 08:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=P0iSh+7F8co8uEu6ZcaAsAU45dh7setUOfi55pSd15w=;
        b=8GFV/2JECVu4vv8pZ2LQx5/G/yFehHNYcTK+Y1w7yZyx6WOOqbdfbCHbexTOyldxTy
         44O5J/b6REH3Muhhdn09YW33J7ls0eYhOqYAEH5jDrRicQd5wo5/eSLdWm+3l9oebeYq
         F0IkgS2T6GeFt1PR+pFFz0zvhoh8qxruYsy+cA0S+8EOyA4ta60IPJjk4EThaGPSPywk
         5J+g+L9OpXbZ2hoHJtiBffr60zaOuWaaMnjqL6EbhV9nV+HTt2YoypSzN63jduSA372X
         JXvMaUwaS6cFaIEOmwJZ53A6HGDh3K42T9D7kLVmFsuh1298irDysqw5q2PxP0JeyOGo
         8IGw==
X-Gm-Message-State: AOAM5332v2ZjdvgwVGcaRfnvqYCHiRIasy1NRKZQd+vL7fzsPSu+2mJY
        nUqHT6h3FVnnzOQANj07IFiHsr80Un4NyHX+PV8DMDkDZtDayAiEMnbtrfTUK5RTAIqeB5twF5t
        Z1+W+RBUTzdgjrViIP+8siA==
X-Received: by 2002:aa7:c982:0:b0:416:1dd3:7704 with SMTP id c2-20020aa7c982000000b004161dd37704mr21084014edt.69.1647271867378;
        Mon, 14 Mar 2022 08:31:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuuXh2fuJoEg0AXordz6dDf6YfwG44iKoHRS5P0pPQ036mQwhsvF53wmAoZzSPOkObHFk/cA==
X-Received: by 2002:aa7:c982:0:b0:416:1dd3:7704 with SMTP id c2-20020aa7c982000000b004161dd37704mr21083998edt.69.1647271867204;
        Mon, 14 Mar 2022 08:31:07 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id z17-20020a50f151000000b004162ecc0c9fsm8258742edl.68.2022.03.14.08.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 08:31:06 -0700 (PDT)
Message-ID: <78fc0363-2ae6-bd75-ecfb-606ce411c79a@redhat.com>
Date:   Mon, 14 Mar 2022 16:31:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [External] Re: [RFC] ACPI: platform-profile: support for AC vs DC
 modes
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mark Pearson <markpearson@lenovo.com>
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
In-Reply-To: <c16ea8ba-5944-0384-4bc3-d5438fe5e1f7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 3/14/22 15:43, Hans de Goede wrote:
> Hi Mario,
> 
> On 3/14/22 14:39, Limonciello, Mario wrote:
>> [Public]
>>
>>>>
>>>> I cycled through a few different implementations but came down on what I
>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>> makes it overall more complicated than it needs to be and less flexible.
>>>
>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>> because I'm wondering how the firmware API here actually looks like,
>>> something which so far is not really clear to me.
>>>
>>> When you say that you considered using 6 values, then I guess that
>>> the firmware API actually offers 6 values which we can write to a single slot:
>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>> performance
>>>
>>> ?
>>>
>>> But that is not what the RFC patch that started this thread shows at all,
>>> the API to the driver is totally unchanged and does not get passed
>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>> switches between say ac-balanced and dc-balanced internally.
>>>
>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>> the OS at all, this is handled internally inside the EC, correct ?
>>>
>>
>> No - on Lenovo's platform there are 6 different profiles that can be selected
>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>> use on AC.
> 
> Ah, I already got that feeling from the rest of the thread, so I reread
> Mark's RFC again before posting my reply today and the RFC looked like
> the same 3 profiles were being set and the only functionality added
> was auto profile switching when changing between AC/battery.
> 
> Thank you for clarifying this. Having 6 different stories
> indeed is a very different story.
> 
>>> Otherwise I would expect the kernel internal driver API to also change and
>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>
>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>> and based on the direction try to implement the thinkpad-acpi change after that.
>>
>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>> modeled on top of this the way that you want.
> 
> I fully agree and since you introduce the concept of being on AC/battery to the
> drivers/acpi/platform_profile.c cpde, please change the 
> profile_set and profile_get function prototypes in struct platform_profile_handler
> to also take a "bool on_battery" extra argument and use that in the thinkpad
> driver to select either the ac or the battery tuned low/balanced/performance 
> profile.
> 
> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
> in the next RFC.
> 
> Also notice how I've tried to consistently use AC/battery in my last reply,
> DC really is not a good term for "on battery". AC also is sort of dubious
> for "connected to an external power-supply" but its use for that is sorta
> common and it is nice and short.

One last request for the v2 RFC, please also Cc Bastien Nocera, so that
he can take a look at the proposed uapi changes from the userspace side
of things.

Regards,

Hans

