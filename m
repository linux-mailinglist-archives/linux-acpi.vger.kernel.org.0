Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A99829EAFC
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJ2LvS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 07:51:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:49846 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbgJ2LvS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 07:51:18 -0400
IronPort-SDR: K9KMeXBIH5LPd66nPO9XhcYnJKV+SUN2ASkaBHqd0xxkI2utglbK8Y+B+17b8KZgk7EoRt6oyF
 lEt1Gl4xLxcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="230056668"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="230056668"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 04:51:17 -0700
IronPort-SDR: tqxmH3YvnSIkn4qOpeh65alLfLY9lyzIJi1RBwJkNeFFecjaUULXWwjFgvmUBvkxkcf89WrvZD
 7ZCnddrWNkVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="425027626"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 29 Oct 2020 04:51:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 29 Oct 2020 13:51:13 +0200
Date:   Thu, 29 Oct 2020 13:51:13 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <20201029115113.GA2288851@kuha.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
 <20201029111303.GL26150@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029111303.GL26150@paasikivi.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 01:13:03PM +0200, Sakari Ailus wrote:
> These functions are doing pretty much the same thing but with different
> parameters. How about implementing a macro or a few, which would take all
> the parameters as arguments and return the function to call? A few variants
> may be needed. Individual functions performing different tasks would become
> very simple.

I would prefer to do that as the second step, if you guys don't mind.
I think this was already talked about, but maybe only internally.
Those macros should then be used also in other places where the same
steps are being executed, for example in drivers/base/power/domain.c.

thanks,

-- 
heikki
