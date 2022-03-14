Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0116A4D8A30
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Mar 2022 17:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbiCNQ50 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Mar 2022 12:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiCNQ5Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Mar 2022 12:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3AC583A73B
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647276973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJwT368S/akmsx6REUgVkKdPn+bNcYk1uByzAbR+MCw=;
        b=G81l+9zutrtmAM9smlhdX6QWbBJ3UDS7UkSvSdXfG/9Rq/er98Hdcc5mDnCytVhPKSn9IS
        hvJkTiW6b4B/ji3gXAAWdcOut2Dq9jKT2c7Y3rc17pN6nM+fGxP5h/xXIyHaRoMSY1IzX0
        7eqFpYjwh05d+4g7NHIYHomoUEnD+5s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-ei7VpJDvPjO4WA06_47THQ-1; Mon, 14 Mar 2022 12:56:12 -0400
X-MC-Unique: ei7VpJDvPjO4WA06_47THQ-1
Received: by mail-ej1-f72.google.com with SMTP id hx13-20020a170906846d00b006db02e1a307so8265217ejc.2
        for <linux-acpi@vger.kernel.org>; Mon, 14 Mar 2022 09:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yJwT368S/akmsx6REUgVkKdPn+bNcYk1uByzAbR+MCw=;
        b=DiJqQExva2Xuk2/m0mjmx38poVTmqH5lqEhAgiVaFY9RNVzUzM05yAZ/O5MR+1HBos
         1vxWyelWeu5G+peSGyDHQEETdbutA3aHxQCxWaNDPyGSJnMBNlh7g6K83AydWKDbEjDB
         ObexGvTjehjJGzDEQOxd7TwIu0zOTELD4k+YofSk348xZav3zYDdMcEfmYih9cdeJDNo
         xrnQ/M4BC42YW6H4+XW24QKkaBbk1IuiDiPuzOoOEiXnSEZISqqmQ+63+vdT6nAx8LQv
         dCWUFhb6aC6lbCPZ1e9AslstViun1/jLAdLHEinPmdXs4wLbhWiZc6ZNZXteAYDRrsih
         Aw1g==
X-Gm-Message-State: AOAM53012iurqSmdzL0vS+jC8nTiEN2K2vjnpqyt9rXOSdBL2K9PZpuS
        g5lUWatiwrsQBE61SKVyYsZS1/04ZPnAVU9BCMKiPYCEcSr+uEhGXwDIxkJx8EojdrAuAL5/xa5
        AsivFony1WrJDIyR1Q+KlTA==
X-Received: by 2002:a17:907:7b86:b0:6da:8a95:35bf with SMTP id ne6-20020a1709077b8600b006da8a9535bfmr18818967ejc.652.1647276970818;
        Mon, 14 Mar 2022 09:56:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc6Sc+pkE5bSOD6c4a1XkwCGwDUBadmqD6sTwfXL5OUX6ewjpvDTvR0DHDkiKMYA/ha35ygQ==
X-Received: by 2002:a17:907:7b86:b0:6da:8a95:35bf with SMTP id ne6-20020a1709077b8600b006da8a9535bfmr18818950ejc.652.1647276970547;
        Mon, 14 Mar 2022 09:56:10 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:cdb2:2781:c55:5db0? (2001-1c00-0c1e-bf00-cdb2-2781-0c55-5db0.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:cdb2:2781:c55:5db0])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm7078762ejz.57.2022.03.14.09.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 09:56:09 -0700 (PDT)
Message-ID: <f0d069d0-40c7-b875-0f24-d3a89451d272@redhat.com>
Date:   Mon, 14 Mar 2022 17:56:09 +0100
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
 <78fc0363-2ae6-bd75-ecfb-606ce411c79a@redhat.com>
 <49205849-4239-3558-f377-797e7561848e@lenovo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <49205849-4239-3558-f377-797e7561848e@lenovo.com>
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

Hi,

On 3/14/22 16:32, Mark Pearson wrote:
> 
> 
> On 2022-03-14 11:31, Hans de Goede wrote:
>> Hi,
>>
>> On 3/14/22 15:43, Hans de Goede wrote:
>>> Hi Mario,
>>>
>>> On 3/14/22 14:39, Limonciello, Mario wrote:
>>>> [Public]
>>>>
>>>>>>
>>>>>> I cycled through a few different implementations but came down on what I
>>>>>> proposed. I considered 6 values - but I don't think that makes sense and
>>>>>> makes it overall more complicated than it needs to be and less flexible.
>>>>>
>>>>> Ah, so to be clear, my 2 scenarios above were theoretical scenarios,
>>>>> because I'm wondering how the firmware API here actually looks like,
>>>>> something which so far is not really clear to me.
>>>>>
>>>>> When you say that you considered using 6 values, then I guess that
>>>>> the firmware API actually offers 6 values which we can write to a single slot:
>>>>> ac-low-power,dc-lowpower,ac-balanced,dc-balanced,ac-performance,dc-
>>>>> performance
>>>>>
>>>>> ?
>>>>>
>>>>> But that is not what the RFC patch that started this thread shows at all,
>>>>> the API to the driver is totally unchanged and does not get passed
>>>>> any info on ac/dc selection ?  So it seems to me that the ACPI API Linux
>>>>> uses for this writes only 1 of 3 values to a single slot and the EC automatically
>>>>> switches between say ac-balanced and dc-balanced internally.
>>>>>
>>>>> IOW there really being 2 differently tuned balance-profiles is not visible to
>>>>> the OS at all, this is handled internally inside the EC, correct ?
>>>>>
>>>>
>>>> No - on Lenovo's platform there are 6 different profiles that can be selected
>>>> from the kernel driver.  3 are intended for use on battery, 3 are intended for
>>>> use on AC.
>>>
>>> Ah, I already got that feeling from the rest of the thread, so I reread
>>> Mark's RFC again before posting my reply today and the RFC looked like
>>> the same 3 profiles were being set and the only functionality added
>>> was auto profile switching when changing between AC/battery.
>>>
>>> Thank you for clarifying this. Having 6 different stories
>>> indeed is a very different story.
>>>
>>>>> Otherwise I would expect the kernel internal driver API to also change and
>>>>> to also see a matching thinkpad_acpi patch in the RFC series?
>>>>
>>>> The idea I see from Mark's thread was to send out RFC change for the platform profile
>>>> and based on the direction try to implement the thinkpad-acpi change after that.
>>>>
>>>> Because of the confusion @Mark I think you should send out an RFC v2 with thinkpad acpi
>>>> modeled on top of this the way that you want.
>>>
>>> I fully agree and since you introduce the concept of being on AC/battery to the
>>> drivers/acpi/platform_profile.c cpde, please change the 
>>> profile_set and profile_get function prototypes in struct platform_profile_handler
>>> to also take a "bool on_battery" extra argument and use that in the thinkpad
>>> driver to select either the ac or the battery tuned low/balanced/performance 
>>> profile.
>>>
>>> And please also include an update to Documentation/ABI/testing/sysfs-platform_profile
>>> in the next RFC.
>>>
>>> Also notice how I've tried to consistently use AC/battery in my last reply,
>>> DC really is not a good term for "on battery". AC also is sort of dubious
>>> for "connected to an external power-supply" but its use for that is sorta
>>> common and it is nice and short.
>>
>> One last request for the v2 RFC, please also Cc Bastien Nocera, so that
>> he can take a look at the proposed uapi changes from the userspace side
>> of things.
>>
> Ack - will do.

So I've been thinking a bit more about this while I was outside for some
fresh air.

First of all let me say that I do agree that the having in essence 6
different profiles thing needs a kernel solution.

What I'm not entirely sure about is if this needs to be something
generic, with a new userspace-API as you proposed in the v1 RFC,
or if it would be better to just solve this in thinkpad_acpi.c .

Now that I've a better grasp of the problem, I'll start a new email
thread on this tomorrow with all the various take-holders in the Cc
to try and answer that question.

It probably is a good idea to wait with doing a v2 of the RFC until
we've had that discussion...

Regards,

Hans

