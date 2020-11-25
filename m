Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98752C44BF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 17:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgKYQRO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 11:17:14 -0500
Received: from mga14.intel.com ([192.55.52.115]:39573 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729690AbgKYQRO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 25 Nov 2020 11:17:14 -0500
IronPort-SDR: IuYc6q9Z65wmimcbqot4Hq8o/4Blq81Fg1WV7omWMPf4Z8V9f0uD4zx7Mmuqfvm0dHkRnHQ70L
 w38daU3WXTjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="171380548"
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="171380548"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 08:17:07 -0800
IronPort-SDR: y0htdTTEiWEL1dF38nmNwqMIo1hmafs4TD+tkZ1/2xIrJeX3ndNqwj3tp5HFH0UqonoMR2anXZ
 8gx8kF0O7p6g==
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="478984679"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 08:17:05 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1khxUc-009fFc-Pd; Wed, 25 Nov 2020 18:18:06 +0200
Date:   Wed, 25 Nov 2020 18:18:06 +0200
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
Message-ID: <20201125161806.GY4077@smile.fi.intel.com>
References: <20201124095628.54373-1-andriy.shevchenko@linux.intel.com>
 <f33b4381ea3a4cf4b8e7f27676cd90ed@intel.com>
 <CAJZ5v0hxqydcoqTCDzR7O7Y4d71Qutx+k4sOmdvOY24f2-OWgg@mail.gmail.com>
 <20201125161028.GW4077@smile.fi.intel.com>
 <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0huXtSDtQEmUHx4NmjJhFNOVUMktD_eJ06=fsmZB40ayw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 25, 2020 at 05:10:50PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 25, 2020 at 5:09 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Nov 25, 2020 at 04:49:39PM +0100, Rafael J. Wysocki wrote:

...

> > There is one fix to the series [1]. But now I realized that I forgot to Cc
> > linux-acpi@. Do you want me resend it?
> 
> Yes, please!

Done! Sent as v2.

-- 
With Best Regards,
Andy Shevchenko


