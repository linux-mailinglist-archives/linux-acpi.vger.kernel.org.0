Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58A92FB90D
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jan 2021 15:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395397AbhASOSN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jan 2021 09:18:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:56091 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbhASJm5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 19 Jan 2021 04:42:57 -0500
IronPort-SDR: 2+0q67q8GBU3/KckoNoXFYkGbkfh/R04KpJtvCyHA7qOLu3mE9mUwrrahVNWr5XELwKSuaJ9fg
 W5lRDlnF3Cgw==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="263710730"
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="263710730"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 01:41:00 -0800
IronPort-SDR: 4TZ3Mo3Tu7C/tfZdY7fsSqYsn9yNgc+q6areqBN1q+dAU4F8Pn89V95q9Ae319iCJELd6D6ztg
 PezPEO3U27Yg==
X-IronPort-AV: E=Sophos;i="5.79,358,1602572400"; 
   d="scan'208";a="365678805"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 01:40:57 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1nWR-003M1r-QO; Tue, 19 Jan 2021 11:41:59 +0200
Date:   Tue, 19 Jan 2021 11:41:59 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        AceLan Kao <acelan.kao@canonical.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI / device_sysfs: Use OF_MODALIAS for "compatible"
 modalias
Message-ID: <20210119094159.GQ4077@smile.fi.intel.com>
References: <20210119081513.300938-1-kai.heng.feng@canonical.com>
 <YAaXz9Pg5x3DsCs3@kroah.com>
 <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7tdFiARtW1RXsjN8+OwRXWzMnok_rfKHDHCh-JSam3cQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 19, 2021 at 04:41:48PM +0800, Kai-Heng Feng wrote:
> On Tue, Jan 19, 2021 at 4:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Jan 19, 2021 at 04:15:13PM +0800, Kai-Heng Feng wrote:

...

> > Who will use OF_MODALIAS and where have you documented it?
> 
> After this lands in mainline, I'll modify the pull request for systemd
> to add a new rule for OF_MODALIAS.
> I'll modify the comment on the function to document the change.

I'm wondering why to have two fixes in two places instead of fixing udev to
understand multiple MODALIAS= events?

-- 
With Best Regards,
Andy Shevchenko


