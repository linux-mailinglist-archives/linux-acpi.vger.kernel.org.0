Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844051A7A80
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Apr 2020 14:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439977AbgDNMR4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Apr 2020 08:17:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:59340 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439975AbgDNMRy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Apr 2020 08:17:54 -0400
IronPort-SDR: kCy9ybyzJ7X/NEkBLNAyMHZ2Kc8I8/fq6dsoSEhdNdv9WcZfJTTLuJsdSi9DKG3EYlyugCemY+
 hmisjG3W5vig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:17:53 -0700
IronPort-SDR: tgNO9BW/LFJq57860VL9SqW6A1b9aVbkqfBFG3/yjlo4RplJEiXet+Tmr17H/1RTVAKc0BH0X6
 DY8C7bpnA0Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="363360009"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 05:17:50 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 15:17:49 +0300
Date:   Tue, 14 Apr 2020 15:17:49 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v1 0/6] platform/x86: intel_cht_int33fe: clean up series
Message-ID: <20200414121749.GG2828150@kuha.fi.intel.com>
References: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408160905.12101-1-andriy.shevchenko@linux.intel.com>
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
> 
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

These are all OK by me. FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

thanks,

-- 
heikki
