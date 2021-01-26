Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194DF305C4C
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Jan 2021 13:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313129AbhAZWt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 17:49:26 -0500
Received: from mga04.intel.com ([192.55.52.120]:36382 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731383AbhAZRyg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 12:54:36 -0500
IronPort-SDR: L/uIIItjI/LsSYtI9Q9Zmmt+FMszO/mthjHDQVylSjZXxUAuc0g+u2hdHRZ5M4kinZtckaf8gd
 OkvaU9hIHWDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177372717"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="177372717"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 09:46:55 -0800
IronPort-SDR: 9BOZyjjP+wxn+s2WqjrByA6IhdwaBxr36rjbSTSKPNfWFL2a9iQRmsy3zDtDd+tOU4Upl5wCqq
 YpuFtUeqFGbg==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362068232"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 09:46:51 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 26 Jan 2021 19:46:49 +0200
Date:   Tue, 26 Jan 2021 19:46:49 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 5/6] ACPI: Add support for native USB4 control _OSC
Message-ID: <20210126174649.GE1988617@lahna.fi.intel.com>
References: <20210126155723.9388-1-mika.westerberg@linux.intel.com>
 <20210126155723.9388-6-mika.westerberg@linux.intel.com>
 <CAJZ5v0jT4crr7fyQE4oVijvTU0hhKOEUvDLziPZZ7J0Hvjrj2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jT4crr7fyQE4oVijvTU0hhKOEUvDLziPZZ7J0Hvjrj2w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On Tue, Jan 26, 2021 at 06:35:20PM +0100, Rafael J. Wysocki wrote:
> > +       capbuf[OSC_QUERY_DWORD] = 0;
> > +       capbuf[OSC_SUPPORT_DWORD] = 0;
> > +       capbuf[OSC_CONTROL_DWORD] = control;
> > +
> > +       status = acpi_run_osc(handle, &context);
> 
> This is the same _OSC that is evaluated in
> acpi_bus_osc_negotiate_platform_control(), right?

Yes, but different UUID.

> So shouldn't the capbuf[OSC_SUPPORT_DWORD] be whatever is negotiated
> through acpi_bus_osc_negotiate_platform_control()?  At least that
> would be consistent with acpi_pci_osc_control_set().

The ACPI 6.4 spec says that the support field for this _OSC is reserved
(table 6.14 in the spec). So as far as I can tell this is not the same
as what we pass for the platform _OSC.
