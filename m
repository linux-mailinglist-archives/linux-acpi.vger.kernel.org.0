Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF8155D97D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiF1KeO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 06:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbiF1KeN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 06:34:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF61131394;
        Tue, 28 Jun 2022 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656412452; x=1687948452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahssOpzE03JgiEPd7aO9UUEH0/nuSOcqYqlgvAT6dJs=;
  b=WAm1pO6UO16PUStd41MT6XWkKvs0lSgn+RxkrbyVa2H1+e3EB7KT/Uhs
   6O7Alz69JupExCGLZS5b6iXZKI5LfeClcrjVizRTyL4MEP0xOe/N9bTYE
   qXA5K2vmG4EzrZCipY713c9qg6c29hK+HhRaTwBvZ5G/Njc7ZeYpYRurK
   1BQFsulRPg3i6yG/TDUBa2w/w/vGxTq1QGe9SRBdMpCXim3R/9gnHxz/F
   VykSRBen6YPByg7GwfT+vdLN8apU6m+GmzdmnBUIfZbjNKSZUSLhg27eT
   UjSsu1mc6pcAIF8saSeBJCT/bukd8J+Em307LutynVdpwgeDHOMNsB9YA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="282439740"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="282439740"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:34:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="679989656"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:34:09 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1o68Xm-000wis-CY;
        Tue, 28 Jun 2022 13:34:06 +0300
Date:   Tue, 28 Jun 2022 13:34:06 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org,
        Stefan Seyfried <seife+kernel@b1-systems.com>
Subject: Re: [PATCH 6/7] platform/x86: panasonic-laptop: filter out duplicate
 volume up/down/mute keypresses
Message-ID: <YrrZHtO032v2BwJs@smile.fi.intel.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
 <20220624112340.10130-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624112340.10130-7-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 24, 2022 at 01:23:39PM +0200, Hans de Goede wrote:
> On some Panasonic models the volume up/down/mute keypresses get
> reported both through the Panasonic ACPI HKEY interface as well as
> through the atkbd device.
> 
> Filter out the atkbd scan-codes for these to avoid reporting presses
> twice.
> 
> Note normally we would leave the filtering of these to userspace by mapping
> the scan-codes to KEY_UNKNOWN through /lib/udev/hwdb.d/60-keyboard.hwdb.
> However in this case that would cause regressions since we were filtering
> the Panasonic ACPI HKEY events before, so filter these in the kernel.

...

> +	if (data == 0xe0) {
> +		extended = true;
> +		return true;
> +	} else if (extended) {

'else' is not needed.

> +		extended = false;
> +
> +		switch (data & 0x7f) {
> +		case 0x20: /* e0 20 / e0 a0, Volume Mute press / release */
> +		case 0x2e: /* e0 2e / e0 ae, Volume Down press / release */
> +		case 0x30: /* e0 30 / e0 b0, Volume Up press / release */
> +			return true;
> +		default:
> +			/*
> +			 * Report the previously filtered e0 before continuing
> +			 * with the next non-filtered byte.
> +			 */
> +			serio_interrupt(port, 0xe0, 0);

> +			return false;

Could be 'break;' but...

> +		}
> +	}

> +	return false;

You can go with 'if (!extended)' above.

-- 
With Best Regards,
Andy Shevchenko


