Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1DE4769
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2019 11:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394289AbfJYJeg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Oct 2019 05:34:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:21579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393290AbfJYJeg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Oct 2019 05:34:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 02:34:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="188875359"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2019 02:34:33 -0700
Received: from andy by smile with local (Exim 4.92.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1iNvzM-00031f-SQ; Fri, 25 Oct 2019 12:34:32 +0300
Date:   Fri, 25 Oct 2019 12:34:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ACPI / PMIC: Add Cherry Trail Crystal Cove PMIC
 OpRegion driver
Message-ID: <20191025093432.GL32742@smile.fi.intel.com>
References: <20191024213827.144974-1-hdegoede@redhat.com>
 <20191024213827.144974-4-hdegoede@redhat.com>
 <20191025074518.GZ32742@smile.fi.intel.com>
 <230f4820-688f-4b04-ee62-771486fcfa63@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <230f4820-688f-4b04-ee62-771486fcfa63@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 25, 2019 at 11:06:40AM +0200, Hans de Goede wrote:
> On 25-10-2019 09:45, Andy Shevchenko wrote:
> > On Thu, Oct 24, 2019 at 11:38:26PM +0200, Hans de Goede wrote:

> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > as long as name pattern uses "chtcc".
> 
> As I already replied to your other similar remark, I would really like to
> stick with crc, crc to me means either crystal-cove or well a crc, cc triggers
> different associations in my mind. Also other crystal-cove files also use crc
> in their filename.

Okay, let's stick with crc for this one.

-- 
With Best Regards,
Andy Shevchenko


