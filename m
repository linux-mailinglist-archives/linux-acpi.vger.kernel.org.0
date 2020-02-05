Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76015355E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2020 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBEQig (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Feb 2020 11:38:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:4185 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgBEQig (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 5 Feb 2020 11:38:36 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 08:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,406,1574150400"; 
   d="scan'208";a="343744237"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 05 Feb 2020 08:38:32 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 05 Feb 2020 18:38:31 +0200
Date:   Wed, 5 Feb 2020 18:38:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, Tom Abraham <tabraham@suse.com>
Subject: Re: Forcing non-ACPI watchdog driver
Message-ID: <20200205163831.GG2667@lahna.fi.intel.com>
References: <1580915129.23547.3.camel@suse.de>
 <20200205152435.GE2667@lahna.fi.intel.com>
 <20200205163048.GD25403@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205163048.GD25403@roeck-us.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Feb 05, 2020 at 08:30:48AM -0800, Guenter Roeck wrote:
> On Wed, Feb 05, 2020 at 05:24:35PM +0200, Mika Westerberg wrote:
> > On Wed, Feb 05, 2020 at 04:05:29PM +0100, Jean Delvare wrote:
> > > Hi all,
> > 
> > Hi,
> > 
> > > Is there a way to prevent the ACPI WDAT watchdog interface from being
> > > used and force the use of a native watchdog driver instead?
> > > 
> > > I have a customer who reports a regression on kernel upgrade. Old
> > > kernel (v4.4) uses iTCO_wdt and watchdog works, new kernel (v4.12) uses
> > > wdat_wdt and watchdog doesn't work (instant reboot when opening the
> > > device). While I'm going to look for fixes to backport, I think it
> > > would be pretty convenient to have a way to just revert to the working
> > > driver until the new driver is fixed somehow. But I can't see any way
> > > to do that at the moment, short of disabling ACPI completely, which is
> > > definitely too extreme to be considered.
> > > 
> > > Am I missing something?
> > 
> > You should be able to revert to iTCO_wdt by simply disabling
> > CONFIG_WDAT_WDT from .config. Then acpi_has_watchdog() returns false
> > which means that iTCO_wdt is used instead.
> 
> That may not be possible in a generic distribution.

Right, they would need to build their own kernel. Currently there is no
way to do that without changing .config.
