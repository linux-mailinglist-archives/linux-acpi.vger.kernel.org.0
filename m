Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDC75AB1F6
	for <lists+linux-acpi@lfdr.de>; Fri,  2 Sep 2022 15:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiIBNqa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 2 Sep 2022 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbiIBNpx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Sep 2022 09:45:53 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABB7FC11A;
        Fri,  2 Sep 2022 06:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662124899; x=1693660899;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=/NRcLs2FH7Yj/TRPNvW19fp4y9VVTFA7hNnEtx6+aXw=;
  b=AlJPF+VjBkHA6UhqciTORr4UgnF+vuC2UsqNtVuPw5QtiGU21RwocZIo
   JelJOIKYOxhSTZsd7XVbcoqnQdc787u2zfXobjHt1f9fEm8vdRvQdqVPU
   Ni4nkrOBYRH9GXDShfcLIa1tjOCRvHDRI7Q7j2i5GRbYgWCC0oUf9qQaw
   Q1SwGaV57ICNXQQKOX0cnsPzkocMweTikUov8KF3Hj5150ZCIMAKwl11G
   isvQpkQ4kOHe55Ml3H2Ix7XjlEoPNDuwxv/gnU+39QI8VLtEDCvMrYMP5
   76MnqXvn28ZTRQXc6MQWP1ZoaHa+LEdPqT2QvwQClOOylkC2Tmxf/LNqn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="276378482"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="276378482"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:20:39 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="674351857"
Received: from svandene-mobl.ger.corp.intel.com (HELO localhost) ([10.252.55.245])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 06:20:32 -0700
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
        David Airlie <airlied@redhat.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v5 11/31] drm/i915: Call acpi_video_register_backlight()
 (v3)
In-Reply-To: <20220825143726.269890-12-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220825143726.269890-1-hdegoede@redhat.com>
 <20220825143726.269890-12-hdegoede@redhat.com>
Date:   Fri, 02 Sep 2022 16:20:21 +0300
Message-ID: <87k06lewve.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 25 Aug 2022, Hans de Goede <hdegoede@redhat.com> wrote:
> On machins without an i915 opregion the acpi_video driver immediately
> probes the ACPI video bus and used to also immediately register
> acpi_video# backlight devices when supported.
>
> Once the drm/kms driver then loaded later and possibly registered
> a native backlight device then the drivers/acpi/video_detect.c code
> unregistered the acpi_video0 device to avoid there being 2 backlight
> devices (when acpi_video_get_backlight_type()==native).
>
> This means that userspace used to briefly see 2 devices and the
> disappearing of acpi_video0 after a brief time confuses the systemd
> backlight level save/restore code, see e.g.:
> https://bbs.archlinux.org/viewtopic.php?id=269920
>
> To fix this the ACPI video code has been modified to make backlight class
> device registration a separate step, relying on the drm/kms driver to
> ask for the acpi_video backlight registration after it is done setting up
> its native backlight device.
>
> Add a call to the new acpi_video_register_backlight() after the i915 calls
> acpi_video_register() (after setting up the i915 opregion) so that the
> acpi_video backlight devices get registered on systems where the i915
> native backlight device is not registered.
>
> Changes in v2:
> -Only call acpi_video_register_backlight() when a panel is detected
>
> Changes in v3:
> -Add a new intel_acpi_video_register() helper which checks if a panel
>  is present and then calls acpi_video_register_backlight()
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Apologies for the delay. I truly appreciate the effort you've put into
this series, and I'm looking forward to seeing the next steps in drm!

Reviewed-by: Jani Nikula <jani.nikula@intel.com>

And ack for merging via whichever tree you think best.


> ---
>  drivers/gpu/drm/i915/display/intel_acpi.c    | 27 ++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_acpi.h    |  3 +++
>  drivers/gpu/drm/i915/display/intel_display.c |  2 +-
>  3 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.c b/drivers/gpu/drm/i915/display/intel_acpi.c
> index e78430001f07..9df78e7caa2b 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.c
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/pci.h>
>  #include <linux/acpi.h>
> +#include <acpi/video.h>
>  
>  #include "i915_drv.h"
>  #include "intel_acpi.h"
> @@ -331,3 +332,29 @@ void intel_acpi_assign_connector_fwnodes(struct drm_i915_private *i915)
>  	 */
>  	fwnode_handle_put(fwnode);
>  }
> +
> +void intel_acpi_video_register(struct drm_i915_private *i915)
> +{
> +	struct drm_connector_list_iter conn_iter;
> +	struct drm_connector *connector;
> +
> +	acpi_video_register();
> +
> +	/*
> +	 * If i915 is driving an internal panel without registering its native
> +	 * backlight handler try to register the acpi_video backlight.
> +	 * For panels not driven by i915 another GPU driver may still register
> +	 * a native backlight later and acpi_video_register_backlight() should
> +	 * only be called after any native backlights have been registered.
> +	 */
> +	drm_connector_list_iter_begin(&i915->drm, &conn_iter);
> +	drm_for_each_connector_iter(connector, &conn_iter) {
> +		struct intel_panel *panel = &to_intel_connector(connector)->panel;
> +
> +		if (panel->backlight.funcs && !panel->backlight.device) {
> +			acpi_video_register_backlight();
> +			break;
> +		}
> +	}
> +	drm_connector_list_iter_end(&conn_iter);
> +}
> diff --git a/drivers/gpu/drm/i915/display/intel_acpi.h b/drivers/gpu/drm/i915/display/intel_acpi.h
> index 4a760a2baed9..6a0007452f95 100644
> --- a/drivers/gpu/drm/i915/display/intel_acpi.h
> +++ b/drivers/gpu/drm/i915/display/intel_acpi.h
> @@ -14,6 +14,7 @@ void intel_unregister_dsm_handler(void);
>  void intel_dsm_get_bios_data_funcs_supported(struct drm_i915_private *i915);
>  void intel_acpi_device_id_update(struct drm_i915_private *i915);
>  void intel_acpi_assign_connector_fwnodes(struct drm_i915_private *i915);
> +void intel_acpi_video_register(struct drm_i915_private *i915);
>  #else
>  static inline void intel_register_dsm_handler(void) { return; }
>  static inline void intel_unregister_dsm_handler(void) { return; }
> @@ -23,6 +24,8 @@ static inline
>  void intel_acpi_device_id_update(struct drm_i915_private *i915) { return; }
>  static inline
>  void intel_acpi_assign_connector_fwnodes(struct drm_i915_private *i915) { return; }
> +static inline
> +void intel_acpi_video_register(struct drm_i915_private *i915) { return; }
>  #endif /* CONFIG_ACPI */
>  
>  #endif /* __INTEL_ACPI_H__ */
> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
> index 6103b02c081f..129a13375101 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -9087,7 +9087,7 @@ void intel_display_driver_register(struct drm_i915_private *i915)
>  
>  	/* Must be done after probing outputs */
>  	intel_opregion_register(i915);
> -	acpi_video_register();
> +	intel_acpi_video_register(i915);
>  
>  	intel_audio_init(i915);

-- 
Jani Nikula, Intel Open Source Graphics Center
