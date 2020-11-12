Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39622B09DD
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 17:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbgKLQZv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 11:25:51 -0500
Received: from mga14.intel.com ([192.55.52.115]:2848 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgKLQZu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 11:25:50 -0500
IronPort-SDR: vPZRiRcu74fFZh30T2V0QAxEioQHzsFq0CzvRCph7EiMjBhfeUXkj3xdXaBNLoEpttAjmmJeoF
 WZaMGJOqmQxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="169552063"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="169552063"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 08:25:48 -0800
IronPort-SDR: HnFhUfAeEv6D8XvBXOOrg7BGzzmrCYRCn27+agB5kKmjw/Im6JJ6y+O/YfwArYjvovMOH5RczE
 DbZladEUztXA==
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="474332999"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 08:25:46 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kdFQt-006Fcv-MA; Thu, 12 Nov 2020 18:26:47 +0200
Date:   Thu, 12 Nov 2020 18:26:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 2/3] rtc: ds1307: Make use of device properties
Message-ID: <20201112162647.GI4077@smile.fi.intel.com>
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
 <20201112155753.36834-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112155753.36834-2-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 12, 2020 at 05:57:52PM +0200, Andy Shevchenko wrote:
> Device property API allows to gather device resources from different sources,
> such as ACPI. Convert the drivers to unleash the power of device property API.

> +	const char *ds3231_clks_names[] = {
> +		[DS3231_CLK_SQW] = ds3231_clks_init[DS3231_CLK_SQW].name,
> +		[DS3231_CLK_32KHZ] = ds3231_clks_init[DS3231_CLK_32KHZ].name,
> +	};

I realised I can do this slightly better, i.e. drop the names from the struct
and move them here while declaring latter as static and moving outside of the
function.

In any case I'll wait for comments for the rest and this patch before updating.

-- 
With Best Regards,
Andy Shevchenko


