Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C501352B53A
	for <lists+linux-acpi@lfdr.de>; Wed, 18 May 2022 11:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiERI4L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 May 2022 04:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiERIzx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2022 04:55:53 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E60D13C345;
        Wed, 18 May 2022 01:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652864147; x=1684400147;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=C57//7ylgGo/HSVGnaIk0RKSXtsb/KUCW24SV/5qRTc=;
  b=MEcaoCfhA4bdX74ZnE44N5gh0KPB8PX5bO6d19NlAsABOlIbbPhlra0/
   blacyCD0YWq0792PUUatEqjtjakuAQUiy2c7hh/qnWat2M0yEdXcNFxi7
   jQf/Jr7m0b4wTrorub8O6eFraHxPNOxYT0KjXfvvsNuUQ4VA9BHe/XUAo
   ax7uApZPVFWKM1BoX1i5kDmCTeGmp8Rj81EricIa+9DLRqozLAi4Gx7uY
   ReFC+i+vXuzkgcvalkzsUsKN2jdgZ45p9gpCXBhfXcCiYbQFKM6sqt16H
   VMRvfImXMus/1RjluctL12NN1MiEu+3LTf+a/0xNEcNcxVTvRo4Ab5wfU
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="334613520"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="334613520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 01:55:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="597666716"
Received: from ksobisz-mobl.ger.corp.intel.com (HELO localhost) ([10.249.132.195])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 01:55:38 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
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
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
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
Subject: Re: [PATCH 01/14] ACPI: video: Add a native function parameter to
 acpi_video_get_backlight_type()
In-Reply-To: <20220517152331.16217-2-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220517152331.16217-1-hdegoede@redhat.com>
 <20220517152331.16217-2-hdegoede@redhat.com>
Date:   Wed, 18 May 2022 11:55:35 +0300
Message-ID: <87y1yzdxtk.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 17 May 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> ATM on x86 laptops where we want userspace to use the acpi_video backlight
> device we often register both the GPU's native backlight device and
> acpi_video's firmware acpi_video# backlight device. This relies on
> userspace preferring firmware type backlight devices over native ones, but
> registering 2 backlight devices for a single display really is undesirable.
>
> On x86 laptops where the native GPU backlight device should be used,
> the registering of other backlight devices is avoided by their drivers
> using acpi_video_get_backlight_type() and only registering their backlight
> if the return value matches their type.
>
> acpi_video_get_backlight_type() uses
> backlight_device_get_by_type(BACKLIGHT_RAW) to determine if a native
> driver is available and will never return native if this returns
> false. This means that the GPU's native backlight registering code
> cannot just call acpi_video_get_backlight_type() to determine if it
> should register its backlight, since acpi_video_get_backlight_type() will
> never return native until the native backlight has already registered.
>
> To fix this add a native function parameter to
> acpi_video_get_backlight_type(), which when set to true will make
> acpi_video_get_backlight_type() behave as if a native backlight has
> already been registered.
>
> Note that all current callers are updated to pass false for the new
> parameter, so this change in itself causes no functional changes.


> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index becc198e4c22..0a06f0edd298 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -17,12 +17,14 @@
>   * Otherwise vendor specific drivers like thinkpad_acpi, asus-laptop,
>   * sony_acpi,... can take care about backlight brightness.
>   *
> - * Backlight drivers can use acpi_video_get_backlight_type() to determine
> - * which driver should handle the backlight.
> + * Backlight drivers can use acpi_video_get_backlight_type() to determine which
> + * driver should handle the backlight. RAW/GPU-driver backlight drivers must
> + * pass true for the native function argument, other drivers must pass false.
>   *
>   * If CONFIG_ACPI_VIDEO is neither set as "compiled in" (y) nor as a module (m)
>   * this file will not be compiled and acpi_video_get_backlight_type() will
> - * always return acpi_backlight_vendor.
> + * return acpi_backlight_native when its native argument is true and
> + * acpi_backlight_vendor when it is false.
>   */

Frankly, I think the boolean native parameter here, and at the call
sites, is confusing, and the slightly different explanations in the
commit message and comment here aren't helping.

I suggest adding a separate function that the native backlight drivers
should use. I think it's more obvious all around, and easier to document
too.


BR,
Jani.

-- 
Jani Nikula, Intel Open Source Graphics Center
