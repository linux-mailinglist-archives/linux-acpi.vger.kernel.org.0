Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F88B64634A
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 22:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiLGVdG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 16:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLGVdD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 16:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA82E5C76A
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 13:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670448729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O54su66YMwrnLOZNslYM9ezQO8/3y0DK5VsFhhbAWKM=;
        b=f/MzVNmR0JLVbg91d84Rds3Lrm7siRpmc6jRN657EheGjgQ2QE/BAtcsHE8D46/5gPsasD
        McCIFKzkTHnlbB7JsxplsHRLIibRwVHEv3x3gtIGApTsXwTs4iYSAdbQfU3qIZ/W9bNnFa
        b4i8/NMLhsy3eu3o6PsbQckU8NZKEX8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-RXAEVQWrPASr42tMEggS1Q-1; Wed, 07 Dec 2022 16:32:08 -0500
X-MC-Unique: RXAEVQWrPASr42tMEggS1Q-1
Received: by mail-ed1-f69.google.com with SMTP id t4-20020a056402524400b004620845ba7bso10680734edd.4
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2022 13:32:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O54su66YMwrnLOZNslYM9ezQO8/3y0DK5VsFhhbAWKM=;
        b=6G3IlrGKIFNb3A0beHXtuchWGgnPaJaEUxl8JMdu/7ibshcYatFau7IbcVjaU8nW9I
         AkNvMWPb/jUh8P6MuCawVrDDF//eftJn/wGoOhwtvDcH2IyZ9BjnoNNPNonstvyBAubG
         I6aAtSDPQtHNhuwc54xTdK5s9kCBmab2pktcCcipiom+v2nE3FK9ej7E6xBZNTdjPCgN
         U05CNYisNCJcNHdXopKv/3B9fc4K0aqjq4QmaTAi7CxueVgweFyQEHfiw8Ubk8ULsuK7
         /FqZo08qYDp2jf3LwHPoAujCfwUDRbXa6K+LVhY6iMI1EN3cdg0+UcfgwF8HubcRpUrl
         BqDA==
X-Gm-Message-State: ANoB5pkHernFz4aRv37VaZnaKiTlmeNIiTQEJfvlUNqzCX+gIcNI25I5
        fA3Y7gQZufOGAYBgCqkic/ZTFxzflD6R3paY9avdodiq6EPbWlAqCoW+buRYc5PFW3PqWbFEJIQ
        cTiEIXl4kO7frlbNopti3Ew==
X-Received: by 2002:a17:906:6149:b0:78d:a154:ae with SMTP id p9-20020a170906614900b0078da15400aemr61835178ejl.259.1670448727074;
        Wed, 07 Dec 2022 13:32:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4/VdLbEomoIXolnYGvgQJrd/6ZotF4DzUhWc53/saDBx87RpgaFv0w/2lXTqRzt8hJ1v8qbA==
X-Received: by 2002:a17:906:6149:b0:78d:a154:ae with SMTP id p9-20020a170906614900b0078da15400aemr61835170ejl.259.1670448726789;
        Wed, 07 Dec 2022 13:32:06 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 12-20020a170906300c00b007c10d47e748sm2227775ejz.36.2022.12.07.13.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 13:32:06 -0800 (PST)
Message-ID: <0d958ffb-88a6-cef3-d885-b1e0fd00c3fb@redhat.com>
Date:   Wed, 7 Dec 2022 22:32:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
Content-Language: en-US, nl
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Daniel Dadap <ddadap@nvidia.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
References: <20221207193134.763-1-mario.limonciello@amd.com>
 <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
 <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0c0b2a2c-7e70-50b4-c8e1-ef5e97447217@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 12/7/22 22:21, Limonciello, Mario wrote:
> On 12/7/2022 15:04, Hans de Goede wrote:
>> Hi All,
>>
>> Mario, thank you for working on this.
> 
> Sure
> 
> <snip>
>>
>> Note that the problem of the creating a non functional acpi_video0
>> device happened before the overhaul too.
>>
>> The difference is that now we have the in kernel GPU drivers
>> all call acpi_video_register_backlight() when they detect an
>> internal-panel for which they don't provide native-backlight
>> control themselves (to avoid the acpi_video0 backlight registering
>> before the native backlight gets a chance to register).
>>
>> The timeout is only there in case no drivers ever call
>> acpi_video_register_backlight(). nomodeset is one case, but
>> loosing backlight control in the nomodeset case would be fine
>> IMHO. The bigger worry why we have the timeout is because of
>> the nvidia binary driver, for devices which use that driver +
>> rely on apci_video# for backlight control.
>>
>> Back to the issue at hand of the unwanted (non functional)
>> apci_video# on various AMD APU using desktops.
>>
> 
> Thanks for explaining.
> 
>> The native drivers now all calling acpi_video_register_backlight()
>> gives us a chance to actually do something about it, so in that
>> sense the 6.1 backlight refactor is relevant.
>>
>>> To avoid this situation from happening add support for video drivers
>>> to notify the ACPI video detection code that no panel was detected.
>>>
>>> To reduce the risk of regressions on multi-GPU systems:
>>> * only use this logic when the system is reported as a desktop enclosure.
>>> * in the amdgpu code only report into this for APUs.
>>
>> I'm afraid that there still is a potential issue for dual
>> GPU machines. The chassistype is not 100% reliable.
> 
> Have you ever seen an A+N machine with unreliable chassis type?

Not specifically. I just know from experience to not
rely on chassis type.

E.g. I would not be surprised to have some of the desktop-replacement
class laptops from e.g. clevo which sometimes even come with
a desktop CPU for moar power, have their chassis type wrong.

Granted those are not using AMD APUs (yet), but that might change
with the ryzen 7000 series where every CPU is an APU too...

> Given Windows HLK certification and knowing that these are to
> be based off reference BIOS of laptops, I would be really surprised
> if this was wrong on an A+N laptop.

I agree this is unlikely. But I have seen all sort of wrong
chassis-type settings in devices which are not from the
big OEMs.  And AFAIK these sometimes also play fasr and loose
with the Windows certification.

>> Lets say we have a machine with the wrong chassis-type with
>> an AMD APU + nvidia GPU which relies on acpi_video0 for
>> backlight control.
>>
>> Then if the LCD is connected to the nvidia GPU only, the
>> amdgpu code will call the new acpi_video_report_nolcd()
>> function.
> 
> + Dan Dadap
> 
> Dan - the context is this series:
> https://patchwork.freedesktop.org/series/111745/
> 
> Do you know if this is real or just conceptual?
> 
>>
>> And then even if the nvidia binary driver is patched
>> by nvidia to call the new  acpi_video_register_backlight()
>> when it does see a panel, then acpi_video_should_register_backlight()
>> will still return false.
>>
>> Basically the problem is that we only want to not try
>> and register the acpi_video0 backlight on dual GPU
>> machines if the output detection on *both* GPUs has not
>> found any builtin LCD panel.
>>
>> But this series disables acpi_video0 backlight registration
>> as soon as *one* of the *two* GPUs has not found an internal
>> LCD panel.
>>
>> As discussed above, after the backlight refactor,
>> GPU(KMS) drivers are expected to call
>> acpi_video_register_backlight() when necessary for any
>> internal panels connected to the GPU they are driving.
>>
>> This mostly fixes the issue of having an acpi_video0 on
>> desktop APUs, except that the timeout thingie which was
>> added to avoid regressions still causes the acpi_video0
>> backlight to get registered.
>>
>> Note that this timeout is already configurable through
>> the register_backlight_delay module option; and setting
>> that option to 0 disables the timeout based fallback
>> completely.
>>
>> So another fix for this might be to just change the
>> default value of register_backlight_delay to 0 for
>> kernel 6.2 .  This is a change which I want to make
>> eventually anyways; so we might just as well do this
>> now to fix the spurious acpi_video0 on desktop APUs
>> issue.   And if this does cause issues for nvidia
>> binary driver users, they can easily work around this
>> by setting the module option.
>>
>> Or alternatively we could go with this series,
>> reworked so that calling acpi_video_report_nolcd()
>> only cancels the timeout.  This way drivers for another
>> GPU can still get the acpi_video0 if necessary by
>> explicitly calling acpi_video_register_backlight().
>>
>> Personally I have a small preference for just changing
>> the default of register_backlight_delay to 0, disabling
>> the timeout based fallback starting with 6.2 .
> 
> How about we do both?  Then you can always restore register_backlight_delay without risk of introducing
> regression of acpi_video0 coming back to desktop APU's.

Doing both sounds like a good idea, I like it.

It would be great if you can rework the series to just cancel
the timeout from acpi_video_report_nolcd() + add a patch
to change the default register_backlight_delay to 0.

>> I did not do this for 6.1 because there were already
>> many other backlight changes in 6.1, so I wanted to
>> have the fallback behavior there as a safeguard
>> against things not working as planned.
>>
> 
> If you're open to my idea of both since I'm already
> touching all this anyway I am fine to roll that change
> into another patch for default of 0 too in a v2.

Adding the patch for default of 0 sounds great, thanks.

Regards,

Hans



