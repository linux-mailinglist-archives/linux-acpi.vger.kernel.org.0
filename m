Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 956761AC62F
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Apr 2020 16:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388359AbgDPOfP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Apr 2020 10:35:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:37704 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442013AbgDPORb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Apr 2020 10:17:31 -0400
IronPort-SDR: ctvYkLTXhpWe68q4mB7rj1epUrhjj/6CIdUeXSu688ytYdRaW4k587JjMQ+W2LTUX5vREAx49g
 eK9PFSNk5ZDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 07:17:30 -0700
IronPort-SDR: nNhPh8yY5LWX0JiAFW/fjHon2zQMrTXSaBa/C9M33JWkvjotn9dguAJItmREhpyILssKg6pSTu
 IrXb49j4tEnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,391,1580803200"; 
   d="scan'208";a="288910450"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 16 Apr 2020 07:17:28 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jP5Kc-0012r5-Pn; Thu, 16 Apr 2020 17:17:30 +0300
Date:   Thu, 16 Apr 2020 17:17:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
Message-ID: <20200416141730.GE185537@smile.fi.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 08, 2020 at 07:09:00PM +0300, Andy Shevchenko wrote:
> When I started looking into the intel_cht_int33fe driver for an example of use
> software node API, I have noticed that it's hard to get and code a bit messy.
> Here is a clean up, main part of which is to introduce node groups and API to
> register and unregister them. This and some pre-existing APIs can be used in
> the driver.
> 
> So, because of cross-subsystem nature of this series, I may recommend to create
> myself the immutable branch which can be pulled to Rafael's and Greg's trees
> respectively. I'm also open for other proposals how to proceed.

Greg, Rafael,
any suggestion how to proceed with this series?

(It has been reviewed and tested).

> Andy Shevchenko (6):
>   device property: export set_secondary_fwnode() to modules
>   software node: Allow register and unregister software node groups
>   platform/x86: intel_cht_int33fe: Convert software node array to group
>   platform/x86: intel_cht_int33fe: Convert to use set_secondary_fwnode()
>   platform/x86: intel_cht_int33fe: Switch to use
>     acpi_dev_hid_uid_match()
>   platform/x86: intel_cht_int33fe: Fix spelling issues
> 
>  drivers/base/core.c                           |   1 +
>  drivers/base/swnode.c                         |  48 ++++++++
>  .../platform/x86/intel_cht_int33fe_typec.c    | 106 +++++++++---------
>  include/linux/property.h                      |   3 +
>  4 files changed, 108 insertions(+), 50 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
With Best Regards,
Andy Shevchenko


