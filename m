Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3955DE62
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343539AbiF1Kfj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Jun 2022 06:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiF1Kfi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jun 2022 06:35:38 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00531399;
        Tue, 28 Jun 2022 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656412537; x=1687948537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Ci8DfysHblkeyhLSE3h8K3QZUSIUJa57/PqOK9DH8E=;
  b=mJbIjhcYPr6qhyOFG2EOkxQE0H43Ey8iOlOJmJoUxiy1xTu/yPE0NlPz
   s79pL71gCNlgcKIrwS2plIV+C/q+W/oQHbrhjzvgAYk/GkXQOUmls/yZV
   M4SPjj07AHKEfSDbsLFOpSWsuuGdeZQr6UWsYKbtSjk8F7FeAwOq27Sxj
   SEttkeFlX+8w1Pur6ugJX5vGfUlCdx/QWq5gEBfHFqPbQeoyhzfSd/pS6
   g0d0Y75LXwNdGumgAS41TByyDoozdMybNWrUzPunw4i+VJ5Xu+zXgHvXV
   +udHnVqA0rXwd245useLGhVdNY85io6ntgxLbjgUKA1gi4ROE6DK1NX68
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="280465087"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="280465087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="836628710"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 03:35:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o68ZA-000wj1-BR;
        Tue, 28 Jun 2022 13:35:32 +0300
Date:   Tue, 28 Jun 2022 13:35:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org,
        Stefan Seyfried <stefan.seyfried@googlemail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/7] ACPI: video / platform/x86: Fix Panasonic laptop
 missing keypresses
Message-ID: <YrrZdKUxPhT5qR5F@smile.fi.intel.com>
References: <20220624112340.10130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624112340.10130-1-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 24, 2022 at 01:23:33PM +0200, Hans de Goede wrote:
> Hi All,
> 
> Here is a series fixing the missing keypresses on some Panasonic Toughbook
> models. These missing keypresses are caused by
> commit ed83c9171829 ("platform/x86: panasonic-laptop: Resolve hotkey double
> trigger bug"), which made the panasonic-laptop driver unconditionally drop
> most WMI reported hotkeys.
> 
> This series reverts that commit and then adds some more selective filtering
> to still avoid the double key-presses on some models, while avoiding
> completely missing keypresses on others.
> 
> Rafael, these fixes rely on patch 1/7, which is a tweak to
> the acpi_video_handles_brightness_key_presses() helper. Without this
> tweak this series will cause a regression, so I would like to merge
> the entire series through the pdx86 tree, may I have your ack for this?


I followed this series on Bugzilla,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

with or without my comments addressed (they are optional)

> Regards,
> 
> Hans
> 
> 
> Hans de Goede (6):
>   ACPI: video: Change how we determine if brightness key-presses are
>     handled
>   platform/x86: panasonic-laptop: sort includes alphabetically
>   platform/x86: panasonic-laptop: revert "Resolve hotkey double trigger
>     bug"
>   platform/x86: panasonic-laptop: don't report duplicate brightness
>     key-presses
>   platform/x86: panasonic-laptop: filter out duplicate volume
>     up/down/mute keypresses
>   platform/x86: panasonic-laptop: Use acpi_video_get_backlight_type()
> 
> Stefan Seyfried (1):
>   platform/x86: panasonic-laptop: de-obfuscate button codes
> 
>  drivers/acpi/acpi_video.c               |  13 ++-
>  drivers/platform/x86/Kconfig            |   2 +
>  drivers/platform/x86/panasonic-laptop.c | 112 ++++++++++++++++++------
>  3 files changed, 91 insertions(+), 36 deletions(-)
> 
> -- 
> 2.36.0
> 

-- 
With Best Regards,
Andy Shevchenko


