Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E0B55EF0E
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 22:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiF1UPU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 16:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbiF1UPH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 16:15:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 525843120B
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 13:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656446944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0us+YPR7sRu5GzqimM7W+6XFvNuV6NMSzbIRZ9Kh2A0=;
        b=ixWXl1LGP5ev7SToLLc36bLhNIR989yvhRogSubEbVmnb+7YTAmM/+KIxkgRHLXbS3SKMy
        aeI7P3jcqML6F+CWzWri+X5h7eYxm8O0pj/siUyu2s5GvRJrk8HYu7YielmrUmruziZWc+
        EKPFWMZMDvPWt0CcPUG1vPjSh1HCUGU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-149-uukBC9NdMu61G1jnOjhgRg-1; Tue, 28 Jun 2022 16:09:02 -0400
X-MC-Unique: uukBC9NdMu61G1jnOjhgRg-1
Received: by mail-ed1-f69.google.com with SMTP id v16-20020a056402349000b00435a1c942a9so10384855edc.15
        for <linux-acpi@vger.kernel.org>; Tue, 28 Jun 2022 13:09:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0us+YPR7sRu5GzqimM7W+6XFvNuV6NMSzbIRZ9Kh2A0=;
        b=CVWZWstKnpfvo4WghFQtoxNj4TBPweg11RprahIvacQRdr7Cfoz9oPn0F8DSMAYmpO
         8LQhQVRDQobGtvTbG6RFZzXwhTTvIdmcMpisFyC+nLbdSc0blou5NG1ze3SgKPq+bspt
         8hv4KpAn6ZZPKkj5HPOZZZXpqMpPOA5GT0hpC9w8IFh4HB7uTWSt7tQK1v0ueWzgGQ0M
         LgDzQT5towpXDbjmShcf5zsY/uL8uqiPe3fuZsRJf7g4PMTTVit+N/2WzUwiarbuX6h2
         xjIrSqtTfyZ+zs/Sq40UvKp9uN6HADJDTsjwaSvmXgrVjnULdAgWwTI3UnQ7vftfDAia
         xz4A==
X-Gm-Message-State: AJIora/dpiF5ZAj0/dqdHIVE5yd+AxnIFJfcVNVMsVV6swhur4ytIc4A
        JUAmv+eWkkHgVQ39sfe4Vob4NSKigHaT8IRxIn8VzN7zyWyo8+GJSa6QKFvRXv9Pisi8OX8FGct
        KNJqlEpECmxytCgjRQmlZQA==
X-Received: by 2002:a17:907:6d20:b0:728:46e4:dac6 with SMTP id sa32-20020a1709076d2000b0072846e4dac6mr304256ejc.280.1656446941441;
        Tue, 28 Jun 2022 13:09:01 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tjCjetBseNsFwX6gKQNOh5peHa9g+736NmMh+imAmNitHfWJlcSsT8PKXhMdqnACDkcDYiHA==
X-Received: by 2002:a17:907:6d20:b0:728:46e4:dac6 with SMTP id sa32-20020a1709076d2000b0072846e4dac6mr304235ejc.280.1656446941233;
        Tue, 28 Jun 2022 13:09:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906a08200b006fed93bf71fsm6920045ejy.18.2022.06.28.13.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jun 2022 13:09:00 -0700 (PDT)
Message-ID: <aae88f51-dfff-8ae1-5f15-91056ce22445@redhat.com>
Date:   Tue, 28 Jun 2022 22:09:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/7] ACPI: video / platform/x86: Fix Panasonic laptop
 missing keypresses
Content-Language: en-US
To:     Kenneth Chan <kenneth.t.chan@gmail.com>,
        Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>
References: <20220624112340.10130-1-hdegoede@redhat.com>
 <df35a580-3e4b-cf45-004f-7c6848a1dfae@message-id.googlemail.com>
 <CAPqSeKu0XRsgg1dQce+cc89LVrqX0GY0ak5Vzzv+PEHF2Pr95w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAPqSeKu0XRsgg1dQce+cc89LVrqX0GY0ak5Vzzv+PEHF2Pr95w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/26/22 08:58, Kenneth Chan wrote:
> Hi Hans and Stefan,
> 
> On Tue, 21 Jun 2022 at 02:10, Stefan Seyfried
> <stefan.seyfried@googlemail.com> wrote:
>>
>> Well, I looked into the acpi_video.c module and that one is to blame.
>> By default, it assumes that both "OUTPUT_KEY_EVENTS" and
>> "BRIGHTNESS_KEY_EVENTS" should be handled by this module.
>> But on the CF-51, this does not happen. "Video Bus" does not generate
>> any key events (I'm not sure about output, but plugging in a VGA monitor
>> and enabling/disabling it with xrandr or tapping the "display" fn-f3
>> hotkey does not get anything from "Video Bus" input device.
>>
> 
> The "display" Fn-F3 hotkey doesn't generate any key events on mine
> either.

Hmm, well that is unrelated to the double / missing other hotkeys,
but still worth investigating.

Normally that key just sends Windows-key (Super/Meta) + P, did you
check the atkbd for this being outputted?

You could install acpid and then run acpi_listen and see if any
events are reported for the key-press.

You could also try adding:

wmi.debug_event=Y to your kernel commandline and see if:

dmesg -w 

Shows any new output when the key is pressed ?


> I have no external VGA monitors to test it anyway.

Typically the key-press is handled independently from there
actually being an external monitor.

> Apart from that, the patches work perfectly on my Let's Note CF-W5.
> Cheers, Hans!
> 
> Tested-by: Kenneth Chan <kenneth.t.chan@gmail.com>

Thanks (to both of you).

Regards,

Hans


> 
> 
> On Sat, 25 Jun 2022 at 03:49, Stefan Seyfried
> <stefan.seyfried@googlemail.com> wrote:
>>
>> On 24.06.22 13:23, Hans de Goede wrote:
>>> Hi All,
>>>
>>> Here is a series fixing the missing keypresses on some Panasonic Toughbook
>>> models. These missing keypresses are caused by
>>> commit ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double
>>> trigger bug"), which made the panasonic-laptop driver unconditionally drop
>>> most WMI reported hotkeys.
>>>
>>> This series reverts that commit and then adds some more selective filtering
>>> to still avoid the double key-presses on some models, while avoiding
>>> completely missing keypresses on others.
>>>
>>> Rafael, these fixes rely on patch 1/7, which is a tweak to
>>> the acpi_video_handles_brightness_key_presses() helper. Without this
>>> tweak this series will cause a regression, so I would like to merge
>>> the entire series through the pdx86 tree, may I have your ack for this?
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>>
>>> Hans de Goede (6):
>>>    ACPI: video: Change how we determine if brightness key-presses are
>>>      handled
>>>    platform/x86: panasonic-laptop: sort includes alphabetically
>>>    platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger
>>>      bug"
>>>    platform/x86: panasonic-laptop: don't report duplicate brightness
>>>      key-presses
>>>    platform/x86: panasonic-laptop: filter out duplicate volume
>>>      up/down/mute keypresses
>>>    platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
>>>
>>> Stefan Seyfried (1):
>>>    platform/x86: panasonic-laptop: de-obfuscate button codes
>>>
>>>   drivers/acpi/acpi_video.c               |  13 ++-
>>>   drivers/platform/x86/Kconfig            |   2 +
>>>   drivers/platform/x86/panasonic-laptop.c | 112 ++++++++++++++++++------
>>>   3 files changed, 91 insertions(+), 36 deletions(-)
>>
>> The whole series works without any manual setup on my Toughbook CF-51:
>>
>> Tested-by: Stefan Seyfried <seife+kernel@b1-systems.com>
>>
>> Thanks again!
>>
>> Stefan
>> --
>> Stefan Seyfried
>>
>> "For a successful technology, reality must take precedence over
>>   public relations, for nature cannot be fooled." -- Richard Feynman
> 

