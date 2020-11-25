Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B8F2C44AD
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 17:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgKYQJ3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 11:09:29 -0500
Received: from mga04.intel.com ([192.55.52.120]:63457 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730443AbgKYQJ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 11:09:29 -0500
IronPort-SDR: vbnoq/AQOxwG+HIxgLDnm672rrSzmF5JXugOCEvHR6IYjwFLlTSuWcSpvaCz5DYJDOmXIZPlwV
 y3Ep4ljjBUMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="169596912"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="169596912"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 08:09:28 -0800
IronPort-SDR: grlmE6dT9V4TCbWNdnH9xXNf0WoSQ5Aku798nFHZd8cjKu1oSkFXqYWzfdYU02uZmqoapwaZjc
 H66VbfzK523Q==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="535354686"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 08:09:26 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khxNE-009f8q-IP; Wed, 25 Nov 2020 18:10:28 +0200
Date:   Wed, 25 Nov 2020 18:10:28 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v1] ASoC: Intel: catpt: Replace open coded variant of
 resource_intersection()
Message-ID: <20201125161028.GW4077@smile.fi.intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
 <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 04:49:39PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 24, 2020 at 1:13 PM Rojewski, Cezary
> <cezary.rojewski@intel.com> wrote:

...

> Applied as 5.11 material, thanks!

Thanks!

There is one fix to the series [1]. But now I realized that I forgot to Cc
linux-acpi@. Do you want me resend it?


[1]: https://lore.kernel.org/lkml/20201119105327.89917-1-andriy.shevchenko@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko


