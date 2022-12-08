Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72094646C18
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Dec 2022 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLHJoi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Dec 2022 04:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiLHJoh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Dec 2022 04:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AB26DCF5
        for <linux-acpi@vger.kernel.org>; Thu,  8 Dec 2022 01:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670492621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QOPQI6SqAzpqn+J3Vr+5gc53ySVAptDT9STnmKemzW0=;
        b=KuT76ggqEOLXIHRfQl763BJAOqsuAkJ9xTEybUW1WrRa7wukuepcVgYo03SPgFJYPyIdHX
        SVulPvNMqNnIwp0ftJJPeIndnTjxVL757ks/jG7g/a0DBETos9n6CBGEdVBeWL/1VDQShH
        /lkZOdoQm0gRCGBk96IXp71DSj+otJE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-n83_vMp3MByf_vLm8q-qnQ-1; Thu, 08 Dec 2022 04:43:40 -0500
X-MC-Unique: n83_vMp3MByf_vLm8q-qnQ-1
Received: by mail-ej1-f70.google.com with SMTP id ds15-20020a170907724f00b007c0abebc958so751758ejc.2
        for <linux-acpi@vger.kernel.org>; Thu, 08 Dec 2022 01:43:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOPQI6SqAzpqn+J3Vr+5gc53ySVAptDT9STnmKemzW0=;
        b=Qmmd3FnQqOpsiJ2d5IrnSbinKQFam+MSe7zYRN9NEjx8fkCHVfO7nAa8JbHWPYRJHX
         GWneewa+3eO4x1BpUgmjewJ4ljxDDEhzZhLVKa1hinTMfeMb7MUalNp8gi/scb6UK+c3
         NPIwqsPoO1S2uBjVX+bd+N4o5U0Cr6b2+vCkW4FyJNPXw1FkGmxdty3UHgF88zvoJ+AW
         ZCdwtQLXHDV+lXJkmZda7RN3/ZMGpVp8TI8Z1jgc42HNzIEe167CtbvcuQDJPNggawnI
         ZtBUxevX4jwy8SgGBCrvjKmSnuLkQLv9toY5A59atD2RXlS/9LYSjiNZY4IDy4pO0NQB
         oAqw==
X-Gm-Message-State: ANoB5pmergRbiaKZP9xDQma21XVldaUJJPfrpoXT5wdFReTAPqnn/H8C
        Tp5kElmg56nvaAhByD3BN4mkentkOAfcP1C9dOYUbFYSYldUj7VsFywkJG73xTWHdgfdqBOEoYY
        9eFte2uWo8OZ2jYBiu2JJmw==
X-Received: by 2002:a17:906:1b55:b0:7c1:ac7:a57a with SMTP id p21-20020a1709061b5500b007c10ac7a57amr8300468ejg.348.1670492619262;
        Thu, 08 Dec 2022 01:43:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4FrjbczRcOqiRlM1zZZtfZnuQsP7UqvdZhR4of4qPYEXKCvwbkjsrL4FnThrnCzOaLy30oBw==
X-Received: by 2002:a17:906:1b55:b0:7c1:ac7:a57a with SMTP id p21-20020a1709061b5500b007c10ac7a57amr8300464ejg.348.1670492619059;
        Thu, 08 Dec 2022 01:43:39 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id 7-20020a170906318700b007c0aefd9339sm8521375ejy.175.2022.12.08.01.43.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 01:43:38 -0800 (PST)
Message-ID: <56fa6d12-1996-7ab3-9ad7-790a3b23e1c8@redhat.com>
Date:   Thu, 8 Dec 2022 10:43:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/3] Adjust ACPI video detection fallback path
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Alexander Deucher <Alexander.Deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
        Daniel Dadap <ddadap@nvidia.com>
References: <20221208010910.7621-1-mario.limonciello@amd.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221208010910.7621-1-mario.limonciello@amd.com>
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

Hi,

On 12/8/22 02:09, Mario Limonciello wrote:
> In kernel 6.1 the backlight registration code was overhauled so that
> at most one backlight device got registered. As part of this change
> there was code added to still allow making an acpi_video0 device if the
> BIOS contained backlight control methods but no native or vendor drivers
> registered.
> 
> Even after the overhaul this fallback logic is failing on the BIOS from
> a number of motherboard manufacturers supporting Ryzen APUs.
> What happens is the amdgpu driver finishes registration and as expected
> doesn't create a backlight control device since no eDP panels are connected
> to a desktop.
> 
> Then 8 seconds later the ACPI video detection code creates an
> acpi_video0 device that is non-operational. GNOME then creates a
> backlight slider.
> 
> To avoid this situation from happening make two sets of changes:
> 
> Prevent desktop problems w/ fallback logic
> ------------------------------------------
> 1) Add support for the video detect code to let native drivers cancel the
> fallback logic if they didn't find a panel.
> 
> This is done this way so that if another driver decides that the ACPI
> mechanism is still needed it can instead directly call the registration
> function.
> 
> 2) Add code to amdgpu to notify the ACPI video detection code that no panel
> was detected on an APU.
> 
> Disable fallback logic by default
> ---------------------------------
> This fallback logic was introduced to prevent regressions in the backlight
> overhaul.  As it has been deemed unnecessary by Hans explicitly disable the
> timeout.  If this turns out to be mistake and this part is reverted, the
> other patches for preventing desktop problems will avoid regressions on
> desktops.

Thanks, the entire v2 series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans




> Mario Limonciello (3):
>   ACPI: video: Allow GPU drivers to report no panels
>   drm/amd/display: Report to ACPI video if no panels were found
>   ACPI: video: Don't enable fallback path for creating ACPI backlight by
>     default
> 
>  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
>  include/acpi/video.h                            |  1 +
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 

