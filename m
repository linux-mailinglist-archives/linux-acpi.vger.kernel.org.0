Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C115879ADD6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbjIKVS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235857AbjIKJnG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 05:43:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A6FD
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694425381; x=1725961381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bzq9y54JjLfh+Qit4Lkg4X/qMowCYKt8RUri+Nlwq2I=;
  b=j5lmWQzJdlkClF70ZfQhUeP2nFp6h+jhxbNQzAqwT65+384c7tnT3zq9
   WF9sWJxudfuvZVDFrboxbH+sq9u2tOCOac/DxAXTHbJgD8LKxtekFmjKZ
   PiqfcfpgW2Zi03XcgmybNprVx8T6HAh7zJG/yxNM32gy9moNFWlJIDG0L
   fcVLPfVRqZKA6Px/BF6pwkKAFyQAG0XhD9c0MpQbvBTwT77hrt2cu30Wv
   0WsBZikhbxB7WaqjnAZiR/C9CmOoXfGpO6FwBBcloauYWp0da3LAjZ801
   OfQ6Ta+WIqMLartcVVL8i9rGeb5Ej3tSbjIXRFDnOqK0HYCWjLzqM/WA7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="442033824"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="442033824"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:43:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="743283447"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="743283447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:42:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdRX-008HV3-2u;
        Mon, 11 Sep 2023 12:42:55 +0300
Date:   Mon, 11 Sep 2023 12:42:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Ken Xue <Ken.Xue@amd.com>
Cc:     linux-acpi@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        rafael@kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] acpi: trigger wakeup key event from power button
Message-ID: <ZP7hH9i6ZQgINbcB@smile.fi.intel.com>
References: <20230908095747.446389-1-Ken.Xue@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908095747.446389-1-Ken.Xue@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 08, 2023 at 05:57:49PM +0800, Ken Xue wrote:
> Andorid can wakeup from various wakeup sources,
> but only several wakeup sources can wake up screen
> with right events(POWER, WAKEUP) from input device.
> 
> Regarding pressing acpi power button, it can resume system and
> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS
> are set in pm1a_sts, but kernel does not report any key
> event to user space during resume by default.
> 
> So, trigger wakeup key event to user space during resume
> from power button.

> Reported-by: kernel test robot <lkp@intel.com>

Are you sure?

> Closes: https://lore.kernel.org/oe-kbuild-all/202309080315.txQUEyHQ-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309080239.IiC7uLpW-lkp@intel.com/
> Closes: https://lore.kernel.org/oe-kbuild-all/202309080351.xHt2qhP2-lkp@intel.com/

Are you sure?

> 
> 

Blank lines are not allowed in the tag block.

> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> ---

How this change is different to the previous patch you sent?
Do you forgot versioning?
Do you forgot changelog?

Please, read Submitting Patches documentation before trying again.
It will help to make your contribution nice and understandable.

...

> +	if (button->type == ACPI_BUTTON_TYPE_POWER) {

	if (... != )
		return;

?

> +		input = button->input;
> +		input_report_key(input, KEY_WAKEUP, 1);
> +		input_sync(input);
> +		input_report_key(input, KEY_WAKEUP, 0);
> +		input_sync(input);
> +	}

...

> +#include <linux/acpi.h>

There is no users of this header.

Check how forward declaration can be used (as it's done in many other headers).


> +extern void acpi_power_button_wakeup(struct acpi_device *device);

...

> +static inline void acpi_power_button_wakeup(struct acpi_device *device)
> +{
> +}

This can be done on a single line.

-- 
With Best Regards,
Andy Shevchenko


