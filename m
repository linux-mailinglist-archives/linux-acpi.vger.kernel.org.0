Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79DE22548B6
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Aug 2020 17:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgH0PK6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 27 Aug 2020 11:10:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:63437 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbgH0LqE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 27 Aug 2020 07:46:04 -0400
IronPort-SDR: PXO21OzUWi4J0WHCto5Gs3eeOtyknVu7ccMKnCZGqGPFMpbUX4BsZyBPXlarbEvO5/nc4qQKRh
 ZFXOjvGWRflA==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="156468838"
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="156468838"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 04:45:56 -0700
IronPort-SDR: /2UVt3hVsUNgpfzeY4s8zl95PQk/KqISyqzbMfXg7P3H35vDcCqU5chpt/N+8MVpzZq4x2zXSi
 3ww9xkYwo4rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,359,1592895600"; 
   d="scan'208";a="329570112"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 27 Aug 2020 04:45:54 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kBGLo-00BoFo-QP; Thu, 27 Aug 2020 14:45:52 +0300
Date:   Thu, 27 Aug 2020 14:45:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ACPI / PMIC: Move TPS68470 OpRegion driver to
 drivers/acpi/pmic/
Message-ID: <20200827114552.GD1891694@smile.fi.intel.com>
References: <20200814132726.11456-1-andriy.shevchenko@linux.intel.com>
 <20200814132726.11456-2-andriy.shevchenko@linux.intel.com>
 <20200817103525.GD1375436@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817103525.GD1375436@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 17, 2020 at 01:35:25PM +0300, Mika Westerberg wrote:
> On Fri, Aug 14, 2020 at 04:27:26PM +0300, Andy Shevchenko wrote:
> > It is revealed now that TPS68470 OpRegion driver has been added
> > in slightly different scope. Let's move it to the drivers/acpi/pmic/
> > folder for sake of the unification.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks!
Rafael, can we apply these?

-- 
With Best Regards,
Andy Shevchenko


