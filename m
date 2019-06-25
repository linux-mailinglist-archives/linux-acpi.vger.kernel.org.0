Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3BA45514F
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2019 16:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbfFYOO5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 25 Jun 2019 10:14:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:12722 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbfFYOO4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 25 Jun 2019 10:14:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 07:14:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,416,1557212400"; 
   d="scan'208";a="182899347"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 07:14:49 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 17:14:48 +0300
Date:   Tue, 25 Jun 2019 17:14:48 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 2/2] ACPI: PM: Allow transitions to D0 to occur in
 special cases
Message-ID: <20190625141448.GJ2640@lahna.fi.intel.com>
References: <10419005.Mb09WM6RCc@kreacher>
 <2807567.5m5tnf7bLv@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807567.5m5tnf7bLv@kreacher>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 25, 2019 at 02:06:13PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If a device with ACPI PM is left in D0 during a system-wide
> transition to the S3 (suspend-to-RAM) or S4 (hibernation) sleep
> state, the actual state of the device need not be D0 during resume
> from it, although its power.state value will still reflect D0 (that
> is, the power state from before the system-wide transition).
> 
> In that case, the acpi_device_set_power() call made to ensure that
> the power state of the device will be D0 going forward has no effect,
> because the new state (D0) is equal to the one reflected by the
> device's power.state value.  That does not affect power resources,
> which are taken care of by acpi_resume_power_resources() called from
> acpi_pm_finish() during resume from system-wide sleep states, but it
> still may be necessary to invoke _PS0 for the device on top of that
> in order to finalize its transition to D0.
> 
> For this reason, modify acpi_device_set_power() to allow transitions
> to D0 to occur even if D0 is the current power state of the device
> according to its power.state value.
> 
> That will not affect power resources, which are assumed to be in
> the right configuration already (as reflected by the current values
> of their reference counters), but it may cause _PS0 to be evaluated
> for the device.  However, evaluating _PS0 for a device already in D0
> may lead to confusion in general, so invoke _PSC (if present) to
> check the device's current power state upfront and only evaluate
> _PS0 for it if _PSC has returned a power state different from D0.
> [If _PSC is not present or the evaluation of it fails, the power
> state of the device is assumed to be D0 at this point.]
> 
> Fixes: 20dacb71ad28 (ACPI / PM: Rework device power management to follow ACPI 6)
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
