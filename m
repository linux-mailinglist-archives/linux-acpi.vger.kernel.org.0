Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2A339BD97
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 18:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFDQup (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 12:50:45 -0400
Received: from mga07.intel.com ([134.134.136.100]:64998 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhFDQup (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 12:50:45 -0400
IronPort-SDR: bVgKiHNIO7K9UpYg5QcnG5CHVjHfmn0H2sZ8dSZWuJTLXkQ1otwn7lE6KlanPWhLWNSHK/YYNU
 w+n496gDkGQQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="268190871"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="268190871"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:48:57 -0700
IronPort-SDR: 9wOlInoqYA751mr8le012/TypXkupO6akfjIziX+RfVvml843oacg8MmH07/bH657qTNtYtTLz
 a//8QdSiohsw==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="551217750"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:48:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lpD09-00HGfZ-3C; Fri, 04 Jun 2021 19:48:53 +0300
Date:   Fri, 4 Jun 2021 19:48:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 1/2] ACPI: bus: Constify stubs for CONFIG_ACPI=n case
Message-ID: <YLpZdRKsj4UZbfgN@smile.fi.intel.com>
References: <20210604163433.12707-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604163433.12707-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 04, 2021 at 07:34:32PM +0300, Andy Shevchenko wrote:
> There is a few stubs that left untouched during constification of
> the fwnode related APIs. Constify three more stubs here.

Kbuild bot found another non-const APIs in use which requires an additional
change. I'll send v3 soon. Please, ignore this one.

-- 
With Best Regards,
Andy Shevchenko


