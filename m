Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C7D677FAC
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Jan 2023 16:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjAWP16 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Jan 2023 10:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjAWP14 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jan 2023 10:27:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B422728;
        Mon, 23 Jan 2023 07:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674487671; x=1706023671;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2O9BtSsVVJHtPRdt8tXpowOfHBthP23V97SyyouGhUM=;
  b=mDgIm5tvAiUohCOe4IgbKRFGoHMHXhxKoIFNVSHiDiChrnYe9UkzDuSz
   aPC9ANs2PBIdmESEVS7cgtmCXp4iipMoPa+5pqUrRj+MBpRjnbQNW5k7U
   uXmnpy2zH/0Yc3d6CQPeJqtvE3MJ1KvVKDJyEShSE43bgO0/QqyAGIe57
   p+0LKdK5YT7QC0hFX4xj3yvrn3aQ2a1YUyWRmpZIVA+3ZUnx5WG83RSDs
   IE34VK3yyfw4xE7yti/QY32y0wiNqY3n+idTBHA36jQNiPpEQk24XV1fz
   V+Tm8t6sQx3K/QF26S73GuoDi1Fvl6xpwo/VshFxnNpvaVvb32chmisAe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390566340"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="390566340"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 07:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="692227608"
X-IronPort-AV: E=Sophos;i="5.97,239,1669104000"; 
   d="scan'208";a="692227608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 23 Jan 2023 07:27:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pJyjb-00DnhI-0g;
        Mon, 23 Jan 2023 17:27:47 +0200
Date:   Mon, 23 Jan 2023 17:27:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 7/8] ACPI: property: Skip MIPI property table without
 "mipi-img" prefix
Message-ID: <Y86ncn54H30xyjJU@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-8-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123134617.265382-8-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 23, 2023 at 03:46:16PM +0200, Sakari Ailus wrote:
> For all _DSD properties, skip going through the MIPI DisCo for Imaging
> property name substitution table if the property doesn't have "mipi-img-"
> prefix.

...

> -	{ "mipi-img-lens-focus", "lens-focus" },
> -	{ "mipi-img-flash-leds", "flash-leds" },
> -	{ "mipi-img-clock-frequency", "clock-frequency" },
> -	{ "mipi-img-led-max-current", "led-max-microamp" },
> -	{ "mipi-img-flash-max-current", "flash-max-microamp" },
> -	{ "mipi-img-flash-max-timeout", "flash-max-timeout-us" },
> +	{ MIPI_IMG_PREFIX "lens-focus", "lens-focus" },
> +	{ MIPI_IMG_PREFIX "flash-leds", "flash-leds" },
> +	{ MIPI_IMG_PREFIX "clock-frequency", "clock-frequency" },
> +	{ MIPI_IMG_PREFIX "led-max-current", "led-max-microamp" },
> +	{ MIPI_IMG_PREFIX "flash-max-current", "flash-max-microamp" },
> +	{ MIPI_IMG_PREFIX "flash-max-timeout", "flash-max-timeout-us" },

I don't thing it ads to the readability, so I don't know why this (part of the)
change is needed.

-- 
With Best Regards,
Andy Shevchenko


