Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB02A6C486B
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Mar 2023 12:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjCVLBw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Mar 2023 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjCVLBv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2023 07:01:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94225618BB;
        Wed, 22 Mar 2023 04:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679482910; x=1711018910;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lLkmv9Lb2TsOKy5ARez9rxBCQWWL/7A4qexM0edagOM=;
  b=bmlHiu7STW25n8vTIXakcyuJ08/hZ0o8H3ZXSpjRTXx9JOuQCuE9yYWs
   hH7QfX/cP/liRGknfx8uEOaWIuFAg0iaHiO9hrDGPhctpilqblUAl2Lg1
   6gQRN/XEmnuDQpEAWksWaC3VAgCoK9WfMniF6GgBnp3ehLYltOP6oeOvS
   LvpdqjB2HQ7R7GTi84fIO3996cvE6KNwFf9QL2hDP5tm1rOg4P44Z9pLb
   BqI6Cwq/z2FP/XL9W8dJl70LPAny4gBeiEFXrf7C/aYa03/mDO8ow+fWW
   lkGMMpVuD9FFO/XodGnQgdQnMjD5LsLgJjnxOVJDu/NzhJOHZMwEhP/K8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="318828680"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="318828680"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 04:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="712162151"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="712162151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2023 04:01:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pewDo-0076qg-0a;
        Wed, 22 Mar 2023 13:01:36 +0200
Date:   Wed, 22 Mar 2023 13:01:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-acpi@vger.kernel.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org, Marek Vasut <marex@denx.de>,
        Stephen Boyd <swboyd@chromium.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v14 03/10] drm/display: Add Type-C switch helpers
Message-ID: <ZBrgD61p/p17IOJL@smile.fi.intel.com>
References: <20230322104639.221402-1-treapking@chromium.org>
 <20230322104639.221402-4-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322104639.221402-4-treapking@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 22, 2023 at 06:46:32PM +0800, Pin-yen Lin wrote:
> Add helpers to register and unregister Type-C "switches" for bridges
> capable of switching their output between two downstream devices.
> 
> The helper registers USB Type-C mode switches when the "mode-switch"
> and the "reg" properties are available in Device Tree.

...

> +config DRM_DISPLAY_DP_TYPEC_HELPER

> +	bool
> +	default y

	def_bool y

> +	depends on DRM_DISPLAY_HELPER
> +	depends on DRM_DISPLAY_HELPER=TYPEC || TYPEC=y
> +	help
> +	  DRM display helpers for USB Type-C Displayport Alternate mode.

Hmm... Dunno if this help is enough.

...

> +	snprintf(name, sizeof(name), "%pfwP-%u", fwnode, port_num);

Would it be possible to have a dup in name and would it be a problem if so?

...

> +/**
> + * drm_dp_register_typec_switches() - register Type-C switches
> + * @dev: Device that registers Type-C switches
> + * @port: Device node for the switch
> + * @switch_desc: A Type-C switch descriptor
> + * @data: Private data for the switches
> + * @mux_set: Callback function for typec_mux_set
> + *
> + * This function registers USB Type-C switches for DP bridges that can switch
> + * the output signal between their output pins. This function uses devm_kcalloc
> + * to allocate memory, so it is expected to only call this in the driver probe
> + * functions.
> + *
> + * Currently only mode switches are implemented, and the function assumes the
> + * given @port device node has endpoints with "mode-switch" property.
> + * The port number is determined by the "reg" property of the endpoint.

`kernel-doc -v ...` should complain on absence of "Return" section.

> + */

...

> +	switch_desc->typec_ports = devm_kcalloc(dev, switch_desc->num_typec_switches,
> +						sizeof(struct drm_dp_typec_port_data),

						sizeof(*switch_desc_typec_ports),

?

> +						GFP_KERNEL);
> +	if (!switch_desc->typec_ports)
> +		return -ENOMEM;

...

> +#ifdef CONFIG_DRM_DISPLAY_DP_TYPEC_HELPER

Ah, maybe this should use IS_REACHABLE() ?

> +void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc);
> +int drm_dp_register_typec_switches(struct device *dev, struct fwnode_handle *port,
> +				   struct drm_dp_typec_switch_desc *switch_desc,
> +				   void *data, typec_mux_set_fn_t mux_set);
> +#else
> +static inline void drm_dp_unregister_typec_switches(struct drm_dp_typec_switch_desc *switch_desc)
> +{
> +}
> +static inline int drm_dp_register_typec_switches(
> +		struct device *dev, struct fwnode_handle *port,
> +		struct drm_dp_typec_switch_desc *switch_desc, void *data,
> +		typec_mux_set_fn_t mux_set)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif

-- 
With Best Regards,
Andy Shevchenko


