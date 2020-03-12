Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC9C1833A1
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Mar 2020 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCLOtK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Mar 2020 10:49:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:33482 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727072AbgCLOtK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Mar 2020 10:49:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 07:49:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="389624041"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 07:49:06 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jCP92-0090qA-NX; Thu, 12 Mar 2020 16:49:08 +0200
Date:   Thu, 12 Mar 2020 16:49:08 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [RFC PATCH] i2c: acpi: put device when verifying client fails
Message-ID: <20200312144908.GX1922688@smile.fi.intel.com>
References: <20200312133244.9564-1-wsa@the-dreams.de>
 <20200312144739.GW1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312144739.GW1922688@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 12, 2020 at 04:47:39PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 12, 2020 at 02:32:44PM +0100, Wolfram Sang wrote:
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > 
> > i2c_verify_client() can fail, so we need to put the device when that
> > happens.
> 
> NAK, this will do double put and messing up with reference counters.
> Besides the fact, that device may disappear after looking up which leads us to
> even more problems.
> 
> See how i2c_acpi_find_client_by_adev() is used in callers.

Perhaps proper "fix" is to add the explanation to a comment in the code to
prevent false positive reports in the future?

-- 
With Best Regards,
Andy Shevchenko


