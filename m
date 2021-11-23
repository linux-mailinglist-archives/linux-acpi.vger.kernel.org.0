Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862EC45998C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Nov 2021 02:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhKWBTN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Nov 2021 20:19:13 -0500
Received: from mga05.intel.com ([192.55.52.43]:63681 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230366AbhKWBTN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Nov 2021 20:19:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321155316"
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="321155316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 17:16:04 -0800
X-IronPort-AV: E=Sophos;i="5.87,256,1631602800"; 
   d="scan'208";a="509203594"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 17:16:01 -0800
Date:   Tue, 23 Nov 2021 09:15:06 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Robert Moore <robert.moore@intel.com>
Subject: Re: [PATCH v11 4/4] tools: Introduce power/acpi/tools/pfru
Message-ID: <20211123011506.GA994503@chenyu-desktop>
References: <cover.1637505679.git.yu.c.chen@intel.com>
 <a1f688cd4ade1257e96d13c91eba72a1aeef5d59.1637505679.git.yu.c.chen@intel.com>
 <YZt+VPI2n/MED9O6@smile.fi.intel.com>
 <20211122154842.GA10345@chenyu5-mobl1>
 <YZvQ7iZMJ9nZgh2+@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZvQ7iZMJ9nZgh2+@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 22, 2021 at 07:18:38PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 22, 2021 at 11:48:42PM +0800, Chen Yu wrote:
> > On Mon, Nov 22, 2021 at 01:26:12PM +0200, Andy Shevchenko wrote:
> > > On Sun, Nov 21, 2021 at 11:17:29PM +0800, Chen Yu wrote:
> > > > Introduce a user space tool to make use of the interface exposed by
> > > > Platform Firmware Runtime Update and Telemetry drivers. The users
> > > > can use this tool to do firmware code injection, driver update and
> > > > to retrieve the telemetry data.
> > > 
> > > Have you tried to build tools with `make O=/my/tmp/folder/for/kernel/build ...`
> > > which previously has been used for kernel builds?
> > >
> > I was not aware of that and just had a try. It seems that there is an issue in
> > tools/power/acpi that, only with the following patch appiled, the make O=xxx
> > would work:
> 
> Cool!
> Care to send a separate fix for this, please?
>
Ok, will do.

thanks,
Chenyu 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
