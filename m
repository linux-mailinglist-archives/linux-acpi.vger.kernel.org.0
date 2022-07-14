Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5674575737
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGNVtP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 17:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiGNVtK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 17:49:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5BA4C4333D
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jul 2022 14:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657835348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GEygyms7zlOuAkql49qmkvrHjnMin5vM9GXZnCkdn/I=;
        b=BPmWoHklyY+9zX6gSz8v4rvWxiY7uKy+f3zcmV4G6MwfIqeSK91XWXfr1XEVI1El8FzbnC
        kAzFaixXisn3NC3c8zG7iaS5xfe/hxFUeDQIIKMn7PQqkFyJ8TUQAv4z+/etwJ8Rhdqrxp
        GrIGDgezpC7vxQnIjoZpChum10G+I9w=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-kC9xNzNXNUalFKT4VaSuCA-1; Thu, 14 Jul 2022 17:49:07 -0400
X-MC-Unique: kC9xNzNXNUalFKT4VaSuCA-1
Received: by mail-qt1-f199.google.com with SMTP id v13-20020a05622a014d00b0031ea4c5d35dso2432430qtw.9
        for <linux-acpi@vger.kernel.org>; Thu, 14 Jul 2022 14:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=GEygyms7zlOuAkql49qmkvrHjnMin5vM9GXZnCkdn/I=;
        b=3A6EIfrolU2bUTC4Xd2HnOr2oBpmoPU8xnvssSMhvxKjIOmePQIoK7o1AaeEs52MxW
         OIez9KyJ5OyUvCuWByUVeUht+YKjf95BCztZzaZlsJUFvMbBK6YJn9122v64tPXmz70B
         kOujs8Y2DSuclmdkYFcOzlZeZiijMxd/M+lUfehWqTmjSGxdePgTzw7Q1VrlitXw+6og
         qm/76lK9aPS64vXmqDayfKJdWkP16519dAwgrDZxN02ktsrAxGWkBo6pKZmL9ycX+Flm
         dBkjlw4Q4qz19qmlc6gs9uVoG8NOGDcZ7qAQqe8KTcwfH2OtFV4tFeysmMhuhoryc952
         CzBQ==
X-Gm-Message-State: AJIora8u/KjK0D/JCWtNNxpM+r9GdW6uM8mE9HFidIo6YZ7ok34cZNgz
        mSrAEd6/xQXN9M2S+whMKe4oOHQbgShARz/9J5izEYh8Muvk8rPQM9La3Kaqz78e197SKw+9Ob0
        fmQWExabv9ROckAe+dJDyng==
X-Received: by 2002:a05:622a:348:b0:31e:b0a2:d69f with SMTP id r8-20020a05622a034800b0031eb0a2d69fmr10047562qtw.159.1657835346712;
        Thu, 14 Jul 2022 14:49:06 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tTDXt6vz+uk1u0IuFP9ZmteyZ2SIZZt8HyHxQyDYrCvqdskYmGr0Tx/0jncWIDnUhd/woGWw==
X-Received: by 2002:a05:622a:348:b0:31e:b0a2:d69f with SMTP id r8-20020a05622a034800b0031eb0a2d69fmr10047546qtw.159.1657835346460;
        Thu, 14 Jul 2022 14:49:06 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id p26-20020ac8461a000000b003051f450049sm2175597qtn.8.2022.07.14.14.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 14:49:05 -0700 (PDT)
Message-ID: <995cf5846d7ecdc02a4b38ab106e93fc58a7c037.camel@redhat.com>
Subject: Re: [PATCH v2 00/29] drm/kms: Stop registering multiple
 /sys/class/backlight devs for a single display
From:   Lyude Paul <lyude@redhat.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     nouveau@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:49:04 -0400
In-Reply-To: <20220712193910.439171-1-hdegoede@redhat.com>
References: <20220712193910.439171-1-hdegoede@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I assume you're probably good on review for the non-nouveau stuff, but if you
end up needing any help with that feel free to poke me!

On Tue, 2022-07-12 at 21:38 +0200, Hans de Goede wrote:
> Hi All,
> 
> As mentioned in my RFC titled "drm/kms: control display brightness through
> drm_connector properties":
> https://lore.kernel.org/dri-devel/0d188965-d809-81b5-74ce-7d30c49fee2d@redhat.com/
> 
> The first step towards this is to deal with some existing technical debt
> in backlight handling on x86/ACPI boards, specifically we need to stop
> registering multiple /sys/class/backlight devs for a single display.
> 
> This series implements my RFC describing my plan for these cleanups:
> https://lore.kernel.org/dri-devel/98519ba0-7f18-201a-ea34-652f50343158@redhat.com/
> 
> This new version addresses the few small remarks made on version 1 (mainly
> changing patch 1/29) and more importantly this finishes the refactoring by
> else addressing all the bits from the "Other issues" section of
> the refactor RFC (resulting in patches 15-29 which are new in v2).
> 
> Please review and test! I hope to be able to make an immutable branch
> based on 5.20-rc1 + this series available for merging into the various
> touched subsystems once 5.20-rc2 is out.
> 
> Regards,
> 
> Hans
> 
> 
> Hans de Goede (29):
>   ACPI: video: Add acpi_video_backlight_use_native() helper
>   drm/i915: Don't register backlight when another backlight should be
>     used
>   drm/amdgpu: Don't register backlight when another backlight should be
>     used
>   drm/radeon: Don't register backlight when another backlight should be
>     used
>   drm/nouveau: Don't register backlight when another backlight should be
>     used
>   ACPI: video: Drop backlight_device_get_by_type() call from
>     acpi_video_get_backlight_type()
>   ACPI: video: Remove acpi_video_bus from list before tearing it down
>   ACPI: video: Simplify acpi_video_unregister_backlight()
>   ACPI: video: Make backlight class device registration a separate step
>   ACPI: video: Remove code to unregister acpi_video backlight when a
>     native backlight registers
>   drm/i915: Call acpi_video_register_backlight() (v2)
>   drm/nouveau: Register ACPI video backlight when nv_backlight
>     registration fails
>   drm/amdgpu: Register ACPI video backlight when skipping amdgpu
>     backlight registration
>   drm/radeon: Register ACPI video backlight when skipping radeon
>     backlight registration
>   ACPI: video: Refactor acpi_video_get_backlight_type() a bit
>   ACPI: video: Add Nvidia WMI EC brightness control detection
>   ACPI: video: Add Apple GMUX brightness control detection
>   platform/x86: apple-gmux: Stop calling acpi/video.h functions
>   platform/x86: toshiba_acpi: Stop using
>     acpi_video_set_dmi_backlight_type()
>   platform/x86: acer-wmi: Move backlight DMI quirks to
>     acpi/video_detect.c
>   platform/x86: asus-wmi: Drop DMI chassis-type check from backlight
>     handling
>   platform/x86: asus-wmi: Move acpi_backlight=vendor quirks to ACPI
>     video_detect.c
>   platform/x86: asus-wmi: Move acpi_backlight=native quirks to ACPI
>     video_detect.c
>   platform/x86: samsung-laptop: Move acpi_backlight=[vendor|native]
>     quirks to ACPI video_detect.c
>   ACPI: video: Remove acpi_video_set_dmi_backlight_type()
>   ACPI: video: Drop "Samsung X360" acpi_backlight=native quirk
>   ACPI: video: Drop Clevo/TUXEDO NL5xRU and NL5xNU acpi_backlight=native
>     quirks
>   ACPI: video: Fix indentation of video_detect_dmi_table[] entries
>   drm/todo: Add entry about dealing with brightness control on devices
>     with > 1 panel
> 
>  Documentation/gpu/todo.rst                    |  68 +++
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/acpi_video.c                     |  59 ++-
>  drivers/acpi/video_detect.c                   | 415 +++++++++++-------
>  drivers/gpu/drm/Kconfig                       |  12 +
>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  14 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +
>  drivers/gpu/drm/gma500/Kconfig                |   2 +
>  drivers/gpu/drm/i915/Kconfig                  |   2 +
>  .../gpu/drm/i915/display/intel_backlight.c    |   7 +
>  drivers/gpu/drm/i915/display/intel_display.c  |   8 +
>  drivers/gpu/drm/i915/display/intel_panel.c    |   3 +
>  drivers/gpu/drm/i915/i915_drv.h               |   2 +
>  drivers/gpu/drm/nouveau/nouveau_backlight.c   |  14 +
>  drivers/gpu/drm/radeon/atombios_encoders.c    |   7 +
>  drivers/gpu/drm/radeon/radeon_encoders.c      |  11 +-
>  .../gpu/drm/radeon/radeon_legacy_encoders.c   |   7 +
>  drivers/platform/x86/acer-wmi.c               |  66 ---
>  drivers/platform/x86/apple-gmux.c             |   3 -
>  drivers/platform/x86/asus-nb-wmi.c            |  21 -
>  drivers/platform/x86/asus-wmi.c               |  13 -
>  drivers/platform/x86/asus-wmi.h               |   2 -
>  drivers/platform/x86/eeepc-wmi.c              |  25 +-
>  drivers/platform/x86/samsung-laptop.c         |  87 ----
>  drivers/platform/x86/toshiba_acpi.c           |  16 -
>  include/acpi/video.h                          |   9 +-
>  26 files changed, 468 insertions(+), 415 deletions(-)
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

