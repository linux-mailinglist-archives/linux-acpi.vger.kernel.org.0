Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F20534013
	for <lists+linux-acpi@lfdr.de>; Wed, 25 May 2022 17:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiEYPNJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 May 2022 11:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245038AbiEYPMb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2022 11:12:31 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2388BB36FE
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 08:12:25 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r6-20020a1c2b06000000b00396fee5ebc9so3541280wmr.1
        for <linux-acpi@vger.kernel.org>; Wed, 25 May 2022 08:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fGUpPWSrdU78NE568Vi5RUu5F1/oAZko7D0EGEMZcTs=;
        b=ly2REis4yQXudDb1MLYh74zNRkgBN/c6oZzobXxjktwZkuhhTU0Wx+HAWxzKCS7VWZ
         AL0iLQNjukhoN/0FwbkyqDSqtfMdPDN7nnTUMcHoIBGRhPcYWHZsbpU0ublXE9/O2gdf
         3K2Mr3bZT4Qe9HolD2eHLcIXkLcL24PMSCON8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fGUpPWSrdU78NE568Vi5RUu5F1/oAZko7D0EGEMZcTs=;
        b=EVzxbnqE0DmDPl1kcbHWgMXHm2i8SCjpVlUDutrljXpg/06Zw2n9LtTGHXS28UWwhs
         SRtUm3oa+tAmUfDdXxk9lo0BKeruPd0q7SPqCBUGdBOcKMcbRtH2iCNChktCX+xXPIhR
         lYlvY42IMLZ6NJhkF7gQgShEUe6RF37BkTlIuk60/d096T1yO5mpLTTRTYXfEfcoX9bs
         8kX7ejMkMkGu7kisGlASQgTsK5SBGCvYF/BFO1hQubgmoqShpVvgpUuiUvWsObwq0v0S
         1GzZ0dUIw+flzf7Yg8g78EK9eZEOAjaejcWBzgQtQkKNwWog4nxjSsx0XGFZxg6mhLTH
         7tHw==
X-Gm-Message-State: AOAM531Z47x6KJbscWvqSYvX2pkzXY/GjgWJlLwF7h6Nypp4N7p2blgo
        CQYQMLTMNAhM8sdTrdfRNLNzeg==
X-Google-Smtp-Source: ABdhPJyf5MZFhqZum/8sY+o7JAm0UvmGWJpAAUbWNAawaQCAVL/h8KmxD+PlAyEjOXhtMiQTzOq6Jw==
X-Received: by 2002:a05:600c:4e91:b0:394:8d30:d6dd with SMTP id f17-20020a05600c4e9100b003948d30d6ddmr8444794wmq.21.1653491543368;
        Wed, 25 May 2022 08:12:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u14-20020a5d434e000000b0020c5253d8fcsm2669373wrr.72.2022.05.25.08.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:12:22 -0700 (PDT)
Date:   Wed, 25 May 2022 17:12:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>, Lyude <lyude@redhat.com>,
        Daniel Dadap <ddadap@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        nouveau@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 00/14] drm/kms: Stop registering multiple
 /sys/class/backlight devs for a single display
Message-ID: <Yo5HVDb5Ak4Ddqt/@phenom.ffwll.local>
References: <20220517152331.16217-1-hdegoede@redhat.com>
 <871qwrfcwr.fsf@intel.com>
 <614a7cef-bfe6-c631-dc4c-d9e99a0b0937@redhat.com>
 <87r14rdu9a.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r14rdu9a.fsf@intel.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 18, 2022 at 01:12:33PM +0300, Jani Nikula wrote:
> On Wed, 18 May 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> > Hi,
> >
> > On 5/18/22 10:44, Jani Nikula wrote:
> >> On Tue, 17 May 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> >>> Hi All,
> >>>
> >>> As mentioned in my RFC titled "drm/kms: control display brightness through
> >>> drm_connector properties":
> >>> https://lore.kernel.org/dri-devel/0d188965-d809-81b5-74ce-7d30c49fee2d@redhat.com/
> >>>
> >>> The first step towards this is to deal with some existing technical debt
> >>> in backlight handling on x86/ACPI boards, specifically we need to stop
> >>> registering multiple /sys/class/backlight devs for a single display.
> >> 
> >> I guess my question here is, how do you know it's for a *single*
> >> display?
> >> 
> >> There are already designs out there with two flat panels, with
> >> independent brightness controls. They're still rare and I don't think we
> >> handle them very well. But we've got code to register multiple native
> >> backlight interfaces, see e.g. commit 20f85ef89d94 ("drm/i915/backlight:
> >> use unique backlight device names").
> >> 
> >> So imagine a design where one of the panels needs backlight control via
> >> ACPI and the other via native backlight control. Granted, I don't know
> >> if one exists, but I think it's very much in the realm of possible
> >> things the OEMs might do. For example, have an EC PWM for primary panel
> >> backlight, and use GPU PWM for secondary. How do you know you actually
> >> do need to register two interfaces?
> >
> > On x86/ACPI devices this is all driven by acpi_video_get_backlight_type() /
> > by the drivers/acpi/video_detect.c code. That code already will break on
> > systems where there are 2 backlight controls, with one being ACPI based
> > and the other a native GPU PWM backlight device.
> >
> > In this scenario as soon as the native GPU PWM backlight device shows up
> > then, if acpi_video_get_backlight_type()==native, video_detect.c will
> > currently unregister the acpi_video# backlight device(s) since userspace
> > prefers the firmware type over the native type, so for userspace to
> > actually honor the acpi_video_get_backlight_type()==native we need to get
> > the acpi_video# backlight device "out of the way" which is currently
> > handled by unregistering it.
> >
> > Note in a way we already have a case where userspace sees 2 panels,
> > in hybrid laptop setups with a mux and on those systems we may see
> > either 2 native backlight devices; or 2 native backlight devices +
> > 2 acpi_video backlight devices with userspace preferring the ACPI
> > ones.
> >
> > Also note that userspace already has code to detect if the related
> > panel is active (iow which way the mux between the GPU and the panels
> > points) and then uses that backlight device. Userspace here very
> > much assumes a single panel though.
> >
> >> I'm fine with dealing with such cases as they arise to avoid
> >> over-engineering up front, but I also don't want us to completely paint
> >> ourselves in a corner either.
> >
> > Right. Note that the current code (both with and without this patchset)
> > already will work fine from a kernel pov as long as both panels
> > are either using native GPU PWM or are both using ACPI. But if we
> > ever get a mix then this will need special handling.
> >
> > Note that all userspace code I know is currently hardcoded
> > to assume a single panel. Userspace already picks one preferred
> > device under /sys/class/backlight and ignores the rest. Actually
> > atm userspace must behave this way, because on x86/ACPI boards we
> > do often register multiple backlight devices for a single panel.
> >
> > So in a way moving to registering only a single backlight device
> > prepares for actually having multiple panels work.
> >
> > Also keep in mind that this is preparation work for making the
> > panel brightness a drm_connector property. When the panel uses
> > a backlight device other then the native GPU PWM to control the
> > brightness then the helper code for this needs to have a way to
> > select which backlight_device to use then and the non native
> > types are not "linked" to a specific connector so in this case
> > we really need there to be only 1 backlight device registered
> > so that the code looking up the (non native) backlight device
> > for the connector gets the right one and not merely the one
> > which happened to get registered first.
> >
> > And I believe that having the panel brightness be a drm_connector
> > property is the way to make it possible for userspace to deal
> > with the multiple panels which each have a separate brightness
> > control case.
> 
> Agreed.
> 
> Thanks for the explanations and recording them here.

Can we stuff a summary of all the things we've discussed here into
Documentation/gpu/todo.rst so that we have this recorded somewhere more
permanently? Also good place to make sure everyone who was part of these
discussions has a chance to ack the overall plan as part of merging such a
patch.

Just feels like this is big&complex enough to justify a todo entry with
what's going on and what's still to be done.
-Daniel


> 
> BR,
> Jani.
> 
> >
> > Regards,
> >
> > Hans
> >
> >
> >
> >
> >
> >> 
> >> BR,
> >> Jani.
> >> 
> >> 
> >>>
> >>> This series implements my RFC describing my plan for these cleanups:
> >>> https://lore.kernel.org/dri-devel/98519ba0-7f18-201a-ea34-652f50343158@redhat.com/
> >>>
> >>> Specifically patches 1-6 implement the "Fixing kms driver unconditionally
> >>> register their "native" backlight dev" part.
> >>>
> >>> And patches 7-14 implement the "Fixing acpi_video0 getting registered for
> >>> a brief time" time.
> >>>
> >>> Note this series does not deal yet with the "Other issues" part, I plan
> >>> to do a follow up series for that.
> >>>
> >>> The changes in this series are good to have regardless of the further
> >>> "drm/kms: control display brightness through drm_connector properties"
> >>> plans. So I plan to push these upstream once they are ready (once
> >>> reviewed). Since this crosses various subsystems / touches multiple
> >>> kms drivers my plan is to provide an immutable branch based on say
> >>> 5.19-rc1 and then have that get merged into all the relevant trees.
> >>>
> >>> Please review.
> >>>
> >>> Regards,
> >>>
> >>> Hans
> >>>
> >>>
> >>> Hans de Goede (14):
> >>>   ACPI: video: Add a native function parameter to
> >>>     acpi_video_get_backlight_type()
> >>>   drm/i915: Don't register backlight when another backlight should be
> >>>     used
> >>>   drm/amdgpu: Don't register backlight when another backlight should be
> >>>     used
> >>>   drm/radeon: Don't register backlight when another backlight should be
> >>>     used
> >>>   drm/nouveau: Don't register backlight when another backlight should be
> >>>     used
> >>>   ACPI: video: Drop backlight_device_get_by_type() call from
> >>>     acpi_video_get_backlight_type()
> >>>   ACPI: video: Remove acpi_video_bus from list before tearing it down
> >>>   ACPI: video: Simplify acpi_video_unregister_backlight()
> >>>   ACPI: video: Make backlight class device registration a separate step
> >>>   ACPI: video: Remove code to unregister acpi_video backlight when a
> >>>     native backlight registers
> >>>   drm/i915: Call acpi_video_register_backlight()
> >>>   drm/nouveau: Register ACPI video backlight when nv_backlight
> >>>     registration fails
> >>>   drm/amdgpu: Register ACPI video backlight when skipping amdgpu
> >>>     backlight registration
> >>>   drm/radeon: Register ACPI video backlight when skipping radeon
> >>>     backlight registration
> >>>
> >>>  drivers/acpi/acpi_video.c                     | 69 ++++++++++++++-----
> >>>  drivers/acpi/video_detect.c                   | 53 +++-----------
> >>>  drivers/gpu/drm/Kconfig                       |  2 +
> >>>  .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 14 +++-
> >>>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  9 +++
> >>>  .../gpu/drm/i915/display/intel_backlight.c    |  7 ++
> >>>  drivers/gpu/drm/i915/display/intel_display.c  |  1 +
> >>>  drivers/gpu/drm/i915/display/intel_opregion.c |  2 +-
> >>>  drivers/gpu/drm/nouveau/nouveau_backlight.c   | 14 ++++
> >>>  drivers/gpu/drm/radeon/atombios_encoders.c    |  7 ++
> >>>  drivers/gpu/drm/radeon/radeon_encoders.c      | 11 ++-
> >>>  .../gpu/drm/radeon/radeon_legacy_encoders.c   |  7 ++
> >>>  drivers/platform/x86/acer-wmi.c               |  2 +-
> >>>  drivers/platform/x86/asus-laptop.c            |  2 +-
> >>>  drivers/platform/x86/asus-wmi.c               |  4 +-
> >>>  drivers/platform/x86/compal-laptop.c          |  2 +-
> >>>  drivers/platform/x86/dell/dell-laptop.c       |  2 +-
> >>>  drivers/platform/x86/eeepc-laptop.c           |  2 +-
> >>>  drivers/platform/x86/fujitsu-laptop.c         |  4 +-
> >>>  drivers/platform/x86/ideapad-laptop.c         |  2 +-
> >>>  drivers/platform/x86/intel/oaktrail.c         |  2 +-
> >>>  drivers/platform/x86/msi-laptop.c             |  2 +-
> >>>  drivers/platform/x86/msi-wmi.c                |  2 +-
> >>>  drivers/platform/x86/samsung-laptop.c         |  2 +-
> >>>  drivers/platform/x86/sony-laptop.c            |  2 +-
> >>>  drivers/platform/x86/thinkpad_acpi.c          |  4 +-
> >>>  drivers/platform/x86/toshiba_acpi.c           |  2 +-
> >>>  include/acpi/video.h                          |  8 ++-
> >>>  28 files changed, 156 insertions(+), 84 deletions(-)
> >> 
> >
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
