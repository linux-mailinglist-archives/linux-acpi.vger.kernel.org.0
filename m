Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1624A6462EF
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Dec 2022 22:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLGVFN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Dec 2022 16:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiLGVFM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Dec 2022 16:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2735F4AF16
        for <linux-acpi@vger.kernel.org>; Wed,  7 Dec 2022 13:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670447056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ICL77EMVyedbML0m5xv9i/c+I7QKSRC/1mCTbM2cZbw=;
        b=awObiKlwWn+SpOj2RNHvUSTE5mMpygspGwVFSx1MPltXykDSlGTM5IeF8nFKlLu1ri7fHY
        6xvXDIsNbTz0dCxO+0zc9Qhw9GrVcBqySeYqWZqkeW7a00yJemXCOb2bO8JgbM2HG624wc
        QUtZhBG9QqkNq7ugH84BUPbBF5fg44o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-AwePGyO9Oz6g1elB5O-bxQ-1; Wed, 07 Dec 2022 16:04:14 -0500
X-MC-Unique: AwePGyO9Oz6g1elB5O-bxQ-1
Received: by mail-ed1-f69.google.com with SMTP id j11-20020aa7c40b000000b0046b45e2ff83so10639042edq.12
        for <linux-acpi@vger.kernel.org>; Wed, 07 Dec 2022 13:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICL77EMVyedbML0m5xv9i/c+I7QKSRC/1mCTbM2cZbw=;
        b=A3oFS3LudqhaGpY1xDWTD1Bu5mCzzT6TWRw3OU4o0MevhHOzUxizqlrhAkFy2Mg0hd
         XnuT6n5x7gGU+hWcBHa9OD+jl1mHCAurrXGnGsw3Aba231VXaKbO42P9oyhbzjji4k3i
         rKsK4FVO1Lz+D32axBsTKaZ4WZGcBql/Du/TnHiAYzHrbiGgBAOB6bCsTt5sF+f2llLv
         j4LQSmHHA035SHIynF/bhkvdZEEqS9s8lMrB3HkoWHY1KcrfFVZKGIfLE364iape8412
         5i6ytuVdFsrT+fzT+NeJzpbWGHD5tGpNumMCIjRf6EXjurHI7Qrvz4vJEt9B3kajMM4v
         5VPQ==
X-Gm-Message-State: ANoB5pndbne++l/2NlD7omYyflveBcA927Qovh/DP73AmeoGbHcHGfbF
        DcyjizK5CzY2BbYFqmvLAGFDFy3OmIUR0ph05706oMEAYsE42ouZyJafIvfACWZLBkZpqarl9qp
        +OGKFQha6VAL1X5JG46JrxA==
X-Received: by 2002:a17:907:a4c3:b0:7c0:7c22:d70d with SMTP id vq3-20020a170907a4c300b007c07c22d70dmr37137701ejc.707.1670447053708;
        Wed, 07 Dec 2022 13:04:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6FLXOABs3DbicSh2WH52mHLSQSSF7YdH3zersomdo0yD6fTXHGxj747T8coOeOx5NCuWVrtw==
X-Received: by 2002:a17:907:a4c3:b0:7c0:7c22:d70d with SMTP id vq3-20020a170907a4c300b007c07c22d70dmr37137691ejc.707.1670447053505;
        Wed, 07 Dec 2022 13:04:13 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ta17-20020a1709078c1100b007ae035374a0sm9044212ejc.214.2022.12.07.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 13:04:12 -0800 (PST)
Message-ID: <58ca6ed3-527e-8eed-0c50-64689e464fb4@redhat.com>
Date:   Wed, 7 Dec 2022 22:04:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 0/2] Avoid creating acpi_video0 on desktop APUs
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
References: <20221207193134.763-1-mario.limonciello@amd.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221207193134.763-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Mario, thank you for working on this.

On 12/7/22 20:31, Mario Limonciello wrote:
> In kernel 6.1 the backlight registration code was overhauled so that
> at most one backlight device got registered. As part of this change
> there was code added to cover the "nomodeset" case to still allow
> making an acpi_video0 device if the BIOS contained backlight control
> methods.
> 
> This fallback logic however is failing on the BIOS from a number of
> motherboard manufacturers supporting Ryzen APUs.  What happens is
> the amdgpu driver finishes registration and as expected doesn't
> create a backlight control device since no eDP panels are connected
> to a desktop.
> 
> Then 8 seconds later the ACPI video detection code creates an
> acpi_video0 device that is non-operational. GNOME then creates a
> backlight slider.

Note that the problem of the creating a non functional acpi_video0
device happened before the overhaul too.

The difference is that now we have the in kernel GPU drivers
all call acpi_video_register_backlight() when they detect an
internal-panel for which they don't provide native-backlight
control themselves (to avoid the acpi_video0 backlight registering
before the native backlight gets a chance to register).

The timeout is only there in case no drivers ever call
acpi_video_register_backlight(). nomodeset is one case, but
loosing backlight control in the nomodeset case would be fine
IMHO. The bigger worry why we have the timeout is because of
the nvidia binary driver, for devices which use that driver +
rely on apci_video# for backlight control.

Back to the issue at hand of the unwanted (non functional)
apci_video# on various AMD APU using desktops.

The native drivers now all calling acpi_video_register_backlight()
gives us a chance to actually do something about it, so in that
sense the 6.1 backlight refactor is relevant.

> To avoid this situation from happening add support for video drivers
> to notify the ACPI video detection code that no panel was detected.
> 
> To reduce the risk of regressions on multi-GPU systems:
> * only use this logic when the system is reported as a desktop enclosure.
> * in the amdgpu code only report into this for APUs.

I'm afraid that there still is a potential issue for dual
GPU machines. The chassistype is not 100% reliable.

Lets say we have a machine with the wrong chassis-type with
an AMD APU + nvidia GPU which relies on acpi_video0 for
backlight control.

Then if the LCD is connected to the nvidia GPU only, the
amdgpu code will call the new acpi_video_report_nolcd()
function.

And then even if the nvidia binary driver is patched
by nvidia to call the new  acpi_video_register_backlight()
when it does see a panel, then acpi_video_should_register_backlight()
will still return false.

Basically the problem is that we only want to not try
and register the acpi_video0 backlight on dual GPU
machines if the output detection on *both* GPUs has not
found any builtin LCD panel.

But this series disables acpi_video0 backlight registration
as soon as *one* of the *two* GPUs has not found an internal
LCD panel.

As discussed above, after the backlight refactor,
GPU(KMS) drivers are expected to call
acpi_video_register_backlight() when necessary for any
internal panels connected to the GPU they are driving.

This mostly fixes the issue of having an acpi_video0 on
desktop APUs, except that the timeout thingie which was
added to avoid regressions still causes the acpi_video0
backlight to get registered.

Note that this timeout is already configurable through
the register_backlight_delay module option; and setting
that option to 0 disables the timeout based fallback
completely.

So another fix for this might be to just change the
default value of register_backlight_delay to 0 for
kernel 6.2 .  This is a change which I want to make
eventually anyways; so we might just as well do this
now to fix the spurious acpi_video0 on desktop APUs
issue.   And if this does cause issues for nvidia
binary driver users, they can easily work around this
by setting the module option.

Or alternatively we could go with this series,
reworked so that calling acpi_video_report_nolcd()
only cancels the timeout.  This way drivers for another
GPU can still get the acpi_video0 if necessary by
explicitly calling acpi_video_register_backlight().

Personally I have a small preference for just changing
the default of register_backlight_delay to 0, disabling
the timeout based fallback starting with 6.2 .

I did not do this for 6.1 because there were already
many other backlight changes in 6.1, so I wanted to
have the fallback behavior there as a safeguard
against things not working as planned.

Regards,

Hans










> 
> Mario Limonciello (2):
>   ACPI: video: Allow GPU drivers to report no panels
>   drm/amd/display: Report to ACPI video if no panels were found
> 
>  drivers/acpi/acpi_video.c                         | 12 ++++++++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 ++++
>  include/acpi/video.h                              |  1 +
>  3 files changed, 17 insertions(+)
> 

