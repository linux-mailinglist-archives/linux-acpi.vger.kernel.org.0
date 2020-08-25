Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C47251412
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Aug 2020 10:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHYIWa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Aug 2020 04:22:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:59286 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgHYIW3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Aug 2020 04:22:29 -0400
IronPort-SDR: +uvwERLmVArAAaOMKDcOu7+R8IaZgBeZdq06o+Z1oS586d4US5i6CwnDHi/3C5hF8J0xqzudpH
 tu1W9D3lb8Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="153637398"
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="153637398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2020 01:22:28 -0700
IronPort-SDR: 0ShbA1Ett/jB2ldH4FHGwyu6LSx4xmAZ4qy2+qLFaPU236w4oBROoZWlPtWCntXpEi2v7yCrgB
 z0g3a3U2lBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,351,1592895600"; 
   d="scan'208";a="402643628"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 25 Aug 2020 01:22:25 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Aug 2020 11:22:24 +0300
Date:   Tue, 25 Aug 2020 11:22:24 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Utkarsh H Patel <utkarsh.h.patel@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v2] PM: sleep: core: Fix the handling of pending runtime
 resume requests
Message-ID: <20200825082224.GX1375436@lahna.fi.intel.com>
References: <1954100.8R8RjBe1nF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1954100.8R8RjBe1nF@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Mon, Aug 24, 2020 at 07:35:31PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It has been reported that system-wide suspend may be aborted in the
> absence of any wakeup events due to unforseen interactions of it with
> the runtume PM framework.
> 
> One failing scenario is when there are multiple devices sharing an
> ACPI power resource and runtime-resume needs to be carried out for
> one of them during system-wide suspend (for example, because it needs
> to be reconfigured before the whole system goes to sleep).  In that
> case, the runtime-resume of that device involves turning the ACPI
> power resource "on" which in turn causes runtime-resume requests
> to be queued up for all of the other devices sharing it.  Those
> requests go to the runtime PM workqueue which is frozen during
> system-wide suspend, so they are not actually taken care of until
> the resume of the whole system, but the pm_runtime_barrier()
> call in __device_suspend() sees them and triggers system wakeup
> events for them which then cause the system-wide suspend to be
> aborted if wakeup source objects are in active use.
> 
> Of course, the logic that leads to triggering those wakeup events is
> questionable in the first place, because clearly there are cases in
> which a pending runtime resume request for a device is not connected
> to any real wakeup events in any way (like the one above).  Moreover,
> it is racy, because the device may be resuming already by the time
> the pm_runtime_barrier() runs and so if the driver doesn't take care
> of signaling the wakeup event as appropriate, it will be lost.
> However, if the driver does take care of that, the extra
> pm_wakeup_event() call in the core is redundant.
> 
> Accordingly, drop the conditional pm_wakeup_event() call fron
> __device_suspend() and make the latter call pm_runtime_barrier()
> alone.  Also modify the comment next to that call to reflect the new
> code and extend it to mention the need to avoid unwanted interactions
> between runtime PM and system-wide device suspend callbacks.
> 
> Fixes: 1e2ef05bb8cf8 ("PM: Limit race conditions between runtime PM and system sleep (v2)")
> Reported-by: Mika Westerberg <mika.westerberg@linux.intel.com>

I guess the more correct here is

Reported-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I also got confirmation that this fixes the reported issue and did not
seem to cause regressions either :)

Please add the following tags:

Tested-by: Utkarsh H Patel <utkarsh.h.patel@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>

Thanks for fixing this!
