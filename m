Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E73629EB9C
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 13:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgJ2MQw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 08:16:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:4166 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgJ2MQv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 08:16:51 -0400
IronPort-SDR: wz5mbBcWt23SabdG1xsKE/ZTZYol4bi/qWwpJykGUz2AO0ElKQWEcpqr/fbrTE3BNXkYZHjGpF
 dOgyEWf2n8aQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="164922428"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="164922428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 05:16:51 -0700
IronPort-SDR: Vm2ehaBlGG25ky/YO68dlqYUcsyjRz18VgyXv9ZcQPVmbkRy557zgchOy5WqFrz8vkcvR3TOWN
 UPaUjiN71JSg==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="323685824"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 05:16:49 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kY6sJ-001EaQ-MQ; Thu, 29 Oct 2020 14:17:51 +0200
Date:   Thu, 29 Oct 2020 14:17:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCHv2 1/3] software node: Power management operations for
 software nodes
Message-ID: <20201029121751.GK4077@smile.fi.intel.com>
References: <20201029105941.63410-1-heikki.krogerus@linux.intel.com>
 <20201029105941.63410-2-heikki.krogerus@linux.intel.com>
 <20201029111303.GL26150@paasikivi.fi.intel.com>
 <20201029115113.GA2288851@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029115113.GA2288851@kuha.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 01:51:13PM +0200, Heikki Krogerus wrote:
> On Thu, Oct 29, 2020 at 01:13:03PM +0200, Sakari Ailus wrote:
> > These functions are doing pretty much the same thing but with different
> > parameters. How about implementing a macro or a few, which would take all
> > the parameters as arguments and return the function to call? A few variants
> > may be needed. Individual functions performing different tasks would become
> > very simple.
> 
> I would prefer to do that as the second step, if you guys don't mind.
> I think this was already talked about, but maybe only internally.
> Those macros should then be used also in other places where the same
> steps are being executed, for example in drivers/base/power/domain.c.

I agree.

-- 
With Best Regards,
Andy Shevchenko


