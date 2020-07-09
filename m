Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855B21A27A
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jul 2020 16:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGIOvQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jul 2020 10:51:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:24825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOvQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 9 Jul 2020 10:51:16 -0400
IronPort-SDR: qqo0VX+7TWeMNfnGsM+XSrwfUTttDa5RwJLMMtIy4C3mCM4YaA2VNJZEicIv5sKQ5Us3ZTcYQO
 /FQN9/iDQgUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="128077250"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="128077250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 07:51:15 -0700
IronPort-SDR: MbW0g/eZ77vvMA01QZmji7O3kRQ4moRTN4XvRHiluqP6HmWTpfg9hdrlBASAp+HqLAomFwTUAz
 jppCmBY6GwTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="323257228"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Jul 2020 07:51:12 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtXtI-000sMr-Pe; Thu, 09 Jul 2020 17:51:12 +0300
Date:   Thu, 9 Jul 2020 17:51:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 04/16] pwm: lpss: Add range limit check for the
 base_unit register value
Message-ID: <20200709145112.GB3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-5-hdegoede@redhat.com>
 <20200709125342.GX3703480@smile.fi.intel.com>
 <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
 <20200709142136.GZ3703480@smile.fi.intel.com>
 <c7925c63-9187-f89f-3a01-2ff252012615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7925c63-9187-f89f-3a01-2ff252012615@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jul 09, 2020 at 04:33:50PM +0200, Hans de Goede wrote:
> On 7/9/20 4:21 PM, Andy Shevchenko wrote:
> > On Thu, Jul 09, 2020 at 03:23:13PM +0200, Hans de Goede wrote:

...

> > You can use clamp_val().
> 
> I did not know about that, that will work nicely I will switch to clamp_val
> for the next version. I assume it is ok to keep your Reviewed-by with this
> very minor change?

Sure.

-- 
With Best Regards,
Andy Shevchenko


