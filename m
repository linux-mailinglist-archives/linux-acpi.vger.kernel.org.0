Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF53C62C1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Jul 2021 20:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbhGLSmp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Jul 2021 14:42:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:19676 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234875AbhGLSmp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Jul 2021 14:42:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="208217320"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="208217320"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:39:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; 
   d="scan'208";a="459282015"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 11:39:54 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m30qK-00CKO8-B3; Mon, 12 Jul 2021 21:39:48 +0300
Date:   Mon, 12 Jul 2021 21:39:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 0/6] ACPI: glue / driver core: Eliminate
 acpi_platform_notify() and split device_platform_notify()
Message-ID: <YOyMdICr/30LhTao@smile.fi.intel.com>
References: <2780027.e9J7NaK4W3@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2780027.e9J7NaK4W3@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 12, 2021 at 07:19:57PM +0200, Rafael J. Wysocki wrote:
> Hi Greg et al,
> 
> This series doesn't change functionality (at least not intentionally), but
> it get rids of a few unneeded checks, parameter passing etc.
> 
> Patches [1-2/6] simplify the ACPI "glue" code.
> 
> Patch [3/6] renames a couple of ACPI functions to avoid name collisions going
> forward.
> 
> Patch [4/6] gets rid of acpi_platform_notify().
> 
> Patch [5/6] rearranges the software nodes code along the lines of what happens
> to the ACPI "glue" code in patch [4/6].
> 
> Patch [6/6] deals with device_platform_notify().
> 
> Please review and let me know if there are any concerns regarding this.

The result looks good to me, but perhaps the ordering can be changed to
minimize addition of the lines that are going to be removed inside the same
series.

In either case, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


