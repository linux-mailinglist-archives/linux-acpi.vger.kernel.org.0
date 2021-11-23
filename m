Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19945A7B4
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 17:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhKWQfC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Nov 2021 11:35:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:48071 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230356AbhKWQfC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Nov 2021 11:35:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="233776328"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="233776328"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:31:32 -0800
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="474810199"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 08:31:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mpYha-009pue-Ql;
        Tue, 23 Nov 2021 18:31:26 +0200
Date:   Tue, 23 Nov 2021 18:31:26 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wei Liu <wei.liu@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v1 1/1] ACPI: Replace kernel.h with the necessary
 inclusions
Message-ID: <YZ0XXoH05cUQ+UMj@smile.fi.intel.com>
References: <20211110111640.62807-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110111640.62807-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 10, 2021 at 01:16:40PM +0200, Andy Shevchenko wrote:
> When kernel.h is used in the headers it adds a lot into dependency hell,
> especially when there are circular dependencies are involved.
> 
> Replace kernel.h inclusion with the list of what is really being used.

Anybody any comments on this? I really want to shrink kernel.h usage in
headers rather sooner than later...

-- 
With Best Regards,
Andy Shevchenko


