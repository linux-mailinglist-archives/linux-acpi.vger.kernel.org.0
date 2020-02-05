Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E481533D0
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2020 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBEPYk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Feb 2020 10:24:40 -0500
Received: from mga01.intel.com ([192.55.52.88]:52769 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbgBEPYj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Feb 2020 10:24:39 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 07:24:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="343681672"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Feb 2020 07:24:36 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Feb 2020 17:24:35 +0200
Date:   Wed, 5 Feb 2020 17:24:35 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: Forcing non-ACPI watchdog driver
Message-ID: <20200205152435.GE2667@lahna.fi.intel.com>
References: <1580915129.23547.3.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580915129.23547.3.camel@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2020 at 04:05:29PM +0100, Jean Delvare wrote:
> Hi all,

Hi,

> Is there a way to prevent the ACPI WDAT watchdog interface from being
> used and force the use of a native watchdog driver instead?
> 
> I have a customer who reports a regression on kernel upgrade. Old
> kernel (v4.4) uses iTCO_wdt and watchdog works, new kernel (v4.12) uses
> wdat_wdt and watchdog doesn't work (instant reboot when opening the
> device). While I'm going to look for fixes to backport, I think it
> would be pretty convenient to have a way to just revert to the working
> driver until the new driver is fixed somehow. But I can't see any way
> to do that at the moment, short of disabling ACPI completely, which is
> definitely too extreme to be considered.
> 
> Am I missing something?

You should be able to revert to iTCO_wdt by simply disabling
CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
which means that iTCO_wdt is used instead.
