Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDD859FA71
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Aug 2022 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbiHXMvH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Aug 2022 08:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiHXMvG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Aug 2022 08:51:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2F78670D;
        Wed, 24 Aug 2022 05:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661345465; x=1692881465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=gVDfDPEiVT6OL8hq48CmnNY2PbGIUK+1rwU/ND+ln1c=;
  b=U1cCwS59In011IEF8X5m5tpA2PN7fPTXlVbSidh3TjTAVvIIWxVHy+n4
   7NraAPh2Vwgx3iiLubJKboM/qn4HXyhH5nYTKsIotIrOQMjzt8nJZxzvP
   rkk7B8+FSY0q+8S8LnVKPDKk7UloYWi161JF0vYShQMu34d+hMZCMjy5l
   za4NLov7Xf4rSAeipyw6M4Ukpl3jSbMQax4j1Ve9PzVQKsYxSoqUtAz2R
   Wgno5fOoIF0mwjFWvTTJa0R0nKsc3CDEuIYBQe9lZH6SlrWLl+dtN+Deb
   B1aL47wP5cEzsuQf4fQYcVWzUrO4kERjPGhketn3wBBX+4DZBuZX8Uyu1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="320012758"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="320012758"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 05:51:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="670487177"
Received: from zlim2-mobl.gar.corp.intel.com (HELO localhost) ([10.252.52.23])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 05:50:58 -0700
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
        Lukas Wunner <lukas@wunner.de>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, nouveau@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v4 02/31] drm/i915: Don't register backlight when
 another backlight should be used
In-Reply-To: <20220824121523.1291269-3-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220824121523.1291269-1-hdegoede@redhat.com>
 <20220824121523.1291269-3-hdegoede@redhat.com>
Date:   Wed, 24 Aug 2022 15:50:56 +0300
Message-ID: <87v8qhiz4f.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 24 Aug 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> Before this commit when we want userspace to use the acpi_video backlight
> device we register both the GPU's native backlight device and acpi_video's
> firmware acpi_video# backlight device. This relies on userspace preferring
> firmware type backlight devices over native ones.
>
> Registering 2 backlight devices for a single display really is
> undesirable, don't register the GPU's native backlight device when
> another backlight device should be used.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/gpu/drm/i915/display/intel_backlight.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
> index 681ebcda97ad..a4dd7924e0c1 100644
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -8,6 +8,8 @@
>  #include <linux/pwm.h>
>  #include <linux/string_helpers.h>
>  
> +#include <acpi/video.h>
> +
>  #include "intel_backlight.h"
>  #include "intel_backlight_regs.h"
>  #include "intel_connector.h"
> @@ -952,6 +954,11 @@ int intel_backlight_device_register(struct intel_connector *connector)
>  
>  	WARN_ON(panel->backlight.max == 0);
>  
> +	if (!acpi_video_backlight_use_native()) {
> +		DRM_INFO("Skipping intel_backlight registration\n");

Could use drm_info with drm_device.

Either way,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

and ack for merging via whichever tree suits you best.


> +		return 0;
> +	}
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;

-- 
Jani Nikula, Intel Open Source Graphics Center
