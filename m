Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E746129EA1A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgJ2LJN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 07:09:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:36124 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727511AbgJ2LJM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Oct 2020 07:09:12 -0400
IronPort-SDR: vs/kD+VKbQ+mhyFnnEQ3F5heZqgySy1u3tTb7G7y8c9NWUZT7nu9qpPWBeijnz/VLSV+zd5GVp
 pqd886wskvNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="165829587"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="165829587"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 04:09:05 -0700
IronPort-SDR: TnuoHTOtSJoidxqg86ZfgGsp6OA2XKLMs9lRDeYv7C1z9PgsyZUv/oxTSvbI1+edMnrshBbmOS
 i9PpqSGERNwQ==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="356228672"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 04:09:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kY5ok-001CHc-Mx; Thu, 29 Oct 2020 13:10:06 +0200
Date:   Thu, 29 Oct 2020 13:10:06 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v1 1/3] Documentation: firmware-guide: gpio-properties:
 Fix factual mistakes
Message-ID: <20201029111006.GI4077@smile.fi.intel.com>
References: <20201028205101.47583-1-andriy.shevchenko@linux.intel.com>
 <20201029081315.GO2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029081315.GO2495@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 10:13:15AM +0200, Mika Westerberg wrote:
> On Wed, Oct 28, 2020 at 10:50:59PM +0200, Andy Shevchenko wrote:
> > Fix factual mistakes and style issues in GPIO properties document.
> 
> Can you clarify here what factual mistakes this fixes :)

The IoRestriction has wrong direction in the examples.
I'll do in v2.

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


