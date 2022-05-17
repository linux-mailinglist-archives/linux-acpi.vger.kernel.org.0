Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451B452A620
	for <lists+linux-acpi@lfdr.de>; Tue, 17 May 2022 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236663AbiEQPXs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 May 2022 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234922AbiEQPXs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 May 2022 11:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1371D4F466
        for <linux-acpi@vger.kernel.org>; Tue, 17 May 2022 08:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652801025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7nJqaMKU0QZZRpkaVkXvoI5hrSAoyhlwswTv6wQi4hM=;
        b=gXaazZ5dBWrswBWcMi+sN8TWfDdPSd9kMIhEk2EiqRG/CNBdnsr/Di9ekkWVMlMVrkfCAd
        8kkj2V/hXFA/EYAJTUx+qYL2E1f5Ij3yIBMfrmzgE/wZ58H7BjsR1i7woWJ7ohYtBoDCpf
        oOBouo/qraEKaDC2U95D1vYc2nX2HYM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-Q6i2ip8ZM4SjQYuBZ7G8BA-1; Tue, 17 May 2022 11:23:41 -0400
X-MC-Unique: Q6i2ip8ZM4SjQYuBZ7G8BA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D9183817A6B;
        Tue, 17 May 2022 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99322C15D7D;
        Tue, 17 May 2022 15:23:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
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
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Pan@vger.kernel.org, Xinhui <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/14] drm/kms: Stop registering multiple /sys/class/backlight devs for a single display
Date:   Tue, 17 May 2022 17:23:17 +0200
Message-Id: <20220517152331.16217-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

As mentioned in my RFC titled "drm/kms: control display brightness through
drm_connector properties":
https://lore.kernel.org/dri-devel/0d188965-d809-81b5-74ce-7d30c49fee2d@redhat.com/

The first step towards this is to deal with some existing technical debt
in backlight handling on x86/ACPI boards, specifically we need to stop
registering multiple /sys/class/backlight devs for a single display.

This series implements my RFC describing my plan for these cleanups:
https://lore.kernel.org/dri-devel/98519ba0-7f18-201a-ea34-652f50343158@redhat.com/

Specifically patches 1-6 implement the "Fixing kms driver unconditionally
register their "native" backlight dev" part.

And patches 7-14 implement the "Fixing acpi_video0 getting registered for
a brief time" time.

Note this series does not deal yet with the "Other issues" part, I plan
to do a follow up series for that.

The changes in this series are good to have regardless of the further
"drm/kms: control display brightness through drm_connector properties"
plans. So I plan to push these upstream once they are ready (once
reviewed). Since this crosses various subsystems / touches multiple
kms drivers my plan is to provide an immutable branch based on say
5.19-rc1 and then have that get merged into all the relevant trees.

Please review.

Regards,

Hans


Hans de Goede (14):
  ACPI: video: Add a native function parameter to
    acpi_video_get_backlight_type()
  drm/i915: Don't register backlight when another backlight should be
    used
  drm/amdgpu: Don't register backlight when another backlight should be
    used
  drm/radeon: Don't register backlight when another backlight should be
    used
  drm/nouveau: Don't register backlight when another backlight should be
    used
  ACPI: video: Drop backlight_device_get_by_type() call from
    acpi_video_get_backlight_type()
  ACPI: video: Remove acpi_video_bus from list before tearing it down
  ACPI: video: Simplify acpi_video_unregister_backlight()
  ACPI: video: Make backlight class device registration a separate step
  ACPI: video: Remove code to unregister acpi_video backlight when a
    native backlight registers
  drm/i915: Call acpi_video_register_backlight()
  drm/nouveau: Register ACPI video backlight when nv_backlight
    registration fails
  drm/amdgpu: Register ACPI video backlight when skipping amdgpu
    backlight registration
  drm/radeon: Register ACPI video backlight when skipping radeon
    backlight registration

 drivers/acpi/acpi_video.c                     | 69 ++++++++++++++-----
 drivers/acpi/video_detect.c                   | 53 +++-----------
 drivers/gpu/drm/Kconfig                       |  2 +
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 14 +++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++
 .../gpu/drm/i915/display/intel_backlight.c    |  7 ++
 drivers/gpu/drm/i915/display/intel_display.c  |  1 +
 drivers/gpu/drm/i915/display/intel_opregion.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c   | 14 ++++
 drivers/gpu/drm/radeon/atombios_encoders.c    |  7 ++
 drivers/gpu/drm/radeon/radeon_encoders.c      | 11 ++-
 .../gpu/drm/radeon/radeon_legacy_encoders.c   |  7 ++
 drivers/platform/x86/acer-wmi.c               |  2 +-
 drivers/platform/x86/asus-laptop.c            |  2 +-
 drivers/platform/x86/asus-wmi.c               |  4 +-
 drivers/platform/x86/compal-laptop.c          |  2 +-
 drivers/platform/x86/dell/dell-laptop.c       |  2 +-
 drivers/platform/x86/eeepc-laptop.c           |  2 +-
 drivers/platform/x86/fujitsu-laptop.c         |  4 +-
 drivers/platform/x86/ideapad-laptop.c         |  2 +-
 drivers/platform/x86/intel/oaktrail.c         |  2 +-
 drivers/platform/x86/msi-laptop.c             |  2 +-
 drivers/platform/x86/msi-wmi.c                |  2 +-
 drivers/platform/x86/samsung-laptop.c         |  2 +-
 drivers/platform/x86/sony-laptop.c            |  2 +-
 drivers/platform/x86/thinkpad_acpi.c          |  4 +-
 drivers/platform/x86/toshiba_acpi.c           |  2 +-
 include/acpi/video.h                          |  8 ++-
 28 files changed, 156 insertions(+), 84 deletions(-)

-- 
2.36.0

