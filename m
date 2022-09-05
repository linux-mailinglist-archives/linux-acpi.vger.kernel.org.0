Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366945ACE19
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Sep 2022 10:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiIEIh6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Sep 2022 04:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237951AbiIEIhm (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Sep 2022 04:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E79F52098
        for <linux-acpi@vger.kernel.org>; Mon,  5 Sep 2022 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662366952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FKWvK74RqhWO5Ba3E7ZgA5XXRtVg9Ah/YW25Q16K5a0=;
        b=jSxIAxVV0kkj/MJ8Lck/VU0Hta1GNnsLoxZHNnviaxwCGwoCD/Qj+HU2XPSYHa9+bPYaqC
        HASyb36uHILCCO4sIXe82P6wRbV8QL/angGzGu/1uFqlrjwhcY+3UPbVhj3+/P1uvLj6AG
        ySSu+87NZJjUJ+7qRiy5UFpzBTls3JU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-2oMPObM8M0ap31FBM_Ty2A-1; Mon, 05 Sep 2022 04:35:50 -0400
X-MC-Unique: 2oMPObM8M0ap31FBM_Ty2A-1
Received: by mail-ed1-f69.google.com with SMTP id dz16-20020a0564021d5000b004489f04cc2cso5419646edb.10
        for <linux-acpi@vger.kernel.org>; Mon, 05 Sep 2022 01:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=FKWvK74RqhWO5Ba3E7ZgA5XXRtVg9Ah/YW25Q16K5a0=;
        b=BSDEOAUBTPDejkc1hFcmVwgeSOkFMe5rKki3Fhi2WpZk17rULDeqIBZ4jH+KI+72iR
         bjPSmmHsPACvmVULmESE9hAG+QnY4sE+TsvcIW4BA01Kf8cfWjQ+XFcdHDdnDbYN9gqb
         4+QufX+fUAVVQLbn/HVa3PBYSay0lwLOKfJB/iUiJIJrDqXJFvn75ofddNGR3aRjVxPq
         nwNOCh+dg51SSwTkH/Z1UGnEFKU6dhJ/l0dlNpiDwldHneGGW5LvJZKe41irig/KeH3Q
         eoalsPedpGxCKPVJcCOgOgreGh/FFz721dMmYDLxMaTlqiTjQ/64/XY6kvqDY8SAK4iK
         pUKA==
X-Gm-Message-State: ACgBeo2XAKSBVmMJfcWX0hSVMcWRILZbPFR0kyH2b55bFpH0wtnsQmNh
        Q2zvaZ86X7wfkrg9OppHc7RdVyez3OxCTQmPTn/FagHhZ39jwHEWaDcgMI2S3/wUH8OXjcBA5nD
        8SAlJ6BZgJrfBfSnpPhCDJg==
X-Received: by 2002:a05:6402:f92:b0:44e:84e0:1d2a with SMTP id eh18-20020a0564020f9200b0044e84e01d2amr3153076edb.395.1662366949025;
        Mon, 05 Sep 2022 01:35:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4VBNuR9PQ8/ymdedcVLZvd83Z5BrbBJNdtbcbD4W3JQHoyQWf8ni6TYgJ7xy7xpT4yxIFbjA==
X-Received: by 2002:a05:6402:f92:b0:44e:84e0:1d2a with SMTP id eh18-20020a0564020f9200b0044e84e01d2amr3153055edb.395.1662366948816;
        Mon, 05 Sep 2022 01:35:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ee35-20020a056402292300b0044dde9244fdsm3162245edb.8.2022.09.05.01.35.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 01:35:48 -0700 (PDT)
Message-ID: <261afe3d-7790-e945-adf6-a2c96c9b1eff@redhat.com>
Date:   Mon, 5 Sep 2022 10:35:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] Immutable backlight-detect-refactor branch between acpi,
 drm-* and pdx86
To:     Ben Skeggs <bskeggs@redhat.com>, Karol Herbst <kherbst@redhat.com>,
        Lyude <lyude@redhat.com>, Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

Now that all patches have been reviewed/acked here is an immutable backlight-detect-refactor
branch with 6.0-rc1 + the v5 patch-set, for merging into the relevant (acpi, drm-* and pdx86)
subsystems.

Please pull this branch into the relevant subsystems.

I will merge this into the review-hans branch of the pdx86 git tree today and
from there it will move to for-next once the builders have successfully build-tested
the merge.

Regards,

Hans


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/backlight-detect-refactor-1

for you to fetch changes up to 4f96b1bc156e7076f6efedc2a76a8c7e897c7977:

  drm/todo: Add entry about dealing with brightness control on devices with > 1 panel (2022-09-03 12:17:27 +0200)

----------------------------------------------------------------
Immutable backlight-detect-refactor branch between acpi, drm-* and pdx86

Tag (immutable branch) with v6.0-rc1 + the (acpi/x86) backlight
detect refactor work. For merging into the acpi, drm-* and pdx86
subsystems.

----------------------------------------------------------------
Hans de Goede (31):
      ACPI: video: Add acpi_video_backlight_use_native() helper
      drm/i915: Don't register backlight when another backlight should be used (v2)
      drm/amdgpu: Don't register backlight when another backlight should be used (v3)
      drm/radeon: Don't register backlight when another backlight should be used (v3)
      drm/nouveau: Don't register backlight when another backlight should be used (v2)
      ACPI: video: Drop backlight_device_get_by_type() call from acpi_video_get_backlight_type()
      ACPI: video: Remove acpi_video_bus from list before tearing it down
      ACPI: video: Simplify acpi_video_unregister_backlight()
      ACPI: video: Make backlight class device registration a separate step (v2)
      ACPI: video: Remove code to unregister acpi_video backlight when a native backlight registers
      drm/i915: Call acpi_video_register_backlight() (v3)
      drm/nouveau: Register ACPI video backlight when nv_backlight registration fails (v2)
      drm/amdgpu: Register ACPI video backlight when skipping amdgpu backlight registration
      drm/radeon: Register ACPI video backlight when skipping radeon backlight registration
      platform/x86: nvidia-wmi-ec-backlight: Move fw interface definitions to a header (v2)
      ACPI: video: Refactor acpi_video_get_backlight_type() a bit
      ACPI: video: Add Nvidia WMI EC brightness control detection (v3)
      ACPI: video: Add Apple GMUX brightness control detection
      platform/x86: nvidia-wmi-ec-backlight: Use acpi_video_get_backlight_type()
      platform/x86: apple-gmux: Stop calling acpi/video.h functions
      platform/x86: toshiba_acpi: Stop using acpi_video_set_dmi_backlight_type()
      platform/x86: acer-wmi: Move backlight DMI quirks to acpi/video_detect.c
      platform/x86: asus-wmi: Drop DMI chassis-type check from backlight handling
      platform/x86: asus-wmi: Move acpi_backlight=vendor quirks to ACPI video_detect.c
      platform/x86: asus-wmi: Move acpi_backlight=native quirks to ACPI video_detect.c
      platform/x86: samsung-laptop: Move acpi_backlight=[vendor|native] quirks to ACPI video_detect.c
      ACPI: video: Remove acpi_video_set_dmi_backlight_type()
      ACPI: video: Drop "Samsung X360" acpi_backlight=native quirk
      ACPI: video: Drop NL5x?U, PF4NU1F and PF5?U?? acpi_backlight=native quirks
      ACPI: video: Fix indentation of video_detect_dmi_table[] entries
      drm/todo: Add entry about dealing with brightness control on devices with > 1 panel

 Documentation/gpu/todo.rst                         |  68 ++++
 MAINTAINERS                                        |   1 +
 drivers/acpi/Kconfig                               |   1 +
 drivers/acpi/acpi_video.c                          |  64 ++-
 drivers/acpi/video_detect.c                        | 428 ++++++++++++---------
 drivers/gpu/drm/Kconfig                            |  14 +
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  14 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   9 +
 drivers/gpu/drm/gma500/Kconfig                     |   2 +
 drivers/gpu/drm/i915/Kconfig                       |   2 +
 drivers/gpu/drm/i915/display/intel_acpi.c          |  27 ++
 drivers/gpu/drm/i915/display/intel_acpi.h          |   3 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |   7 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +-
 drivers/gpu/drm/nouveau/nouveau_acpi.c             |  10 +
 drivers/gpu/drm/nouveau/nouveau_acpi.h             |   4 +
 drivers/gpu/drm/nouveau/nouveau_backlight.c        |  13 +
 drivers/gpu/drm/radeon/atombios_encoders.c         |   7 +
 drivers/gpu/drm/radeon/radeon_encoders.c           |  11 +-
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |   7 +
 drivers/platform/x86/Kconfig                       |   1 +
 drivers/platform/x86/acer-wmi.c                    |  66 ----
 drivers/platform/x86/apple-gmux.c                  |   3 -
 drivers/platform/x86/asus-nb-wmi.c                 |  21 -
 drivers/platform/x86/asus-wmi.c                    |  13 -
 drivers/platform/x86/asus-wmi.h                    |   2 -
 drivers/platform/x86/eeepc-wmi.c                   |  25 +-
 drivers/platform/x86/nvidia-wmi-ec-backlight.c     |  82 +---
 drivers/platform/x86/samsung-laptop.c              |  87 -----
 drivers/platform/x86/toshiba_acpi.c                |  16 -
 include/acpi/video.h                               |   9 +-
 .../platform_data/x86/nvidia-wmi-ec-backlight.h    |  76 ++++
 32 files changed, 588 insertions(+), 507 deletions(-)
 create mode 100644 include/linux/platform_data/x86/nvidia-wmi-ec-backlight.h

