Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB6144473C
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhKCRhH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:37:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:59850 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229621AbhKCRhH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:37:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231402290"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="231402290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:34:08 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="468185500"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:34:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miK90-003KKR-GO;
        Wed, 03 Nov 2021 19:33:50 +0200
Date:   Wed, 3 Nov 2021 19:33:50 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YYLH/ot/h5aucfiM@smile.fi.intel.com>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <b23d4a6e5bedd0bc3912fb42a771c4b8c078905a.1635953446.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b23d4a6e5bedd0bc3912fb42a771c4b8c078905a.1635953446.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 11:44:03PM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
> 
> The Linux kernel provides interfaces for the user to query the parameters
> of telemetry data, and the user could read out the telemetry data
> accordingly.
> 
> PFRU and PFRU Telemetry both invoke _DSM to trigger the low level actions.
> However the input parameters and ACPI package result as well as the
> functions are different from each other. It is hard to extract the common
> code between them, so introduce separated files for them.
> 
> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/pfru.

Comments from previous patch partially apply here.

-- 
With Best Regards,
Andy Shevchenko


