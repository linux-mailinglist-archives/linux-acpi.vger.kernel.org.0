Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A252FA4D8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Jan 2021 16:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405772AbhARPd3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 18 Jan 2021 10:33:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:63972 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405947AbhARPdG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 18 Jan 2021 10:33:06 -0500
IronPort-SDR: qKLvXPzNERWBf1sJYJFKIoxPpHwWWhK2KqeG+GDfS5ma8jrjOK8jHdWbxyPHLu7Iui0cKRJW03
 /v+0mxgX4/zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9867"; a="165906259"
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="165906259"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 07:31:20 -0800
IronPort-SDR: KN74coCIjSJQJohpAoATfBJRz1D5s39ayV45mr7VDhXTMgjcNrAmW2NhN0GSFFsKeMr8Pp3dRd
 kvs8VKtCwqwQ==
X-IronPort-AV: E=Sophos;i="5.79,356,1602572400"; 
   d="scan'208";a="466400206"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 07:31:15 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l1WVu-002I8S-2f; Mon, 18 Jan 2021 17:32:18 +0200
Date:   Mon, 18 Jan 2021 17:32:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] ACPI: scan: Rearrange memory allocation in
 acpi_device_add()
Message-ID: <20210118153218.GX4077@smile.fi.intel.com>
References: <3494203.VBaj39JGmp@kreacher>
 <2999734.9HhbEeWEHR@kreacher>
 <8218eff4-6629-ac20-ec3f-a66aad445bb6@redhat.com>
 <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hv2FX2wtuwu9Jd1zZiGut9kUzQvCH5vXLMyFpqvvYOkA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jan 18, 2021 at 04:16:16PM +0100, Rafael J. Wysocki wrote:
> On Sat, Jan 16, 2021 at 1:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 1/14/21 7:46 PM, Rafael J. Wysocki wrote:

...

> > When I have cases like this, where 2 mallocs are necessary I typically do it like this:
> >
> >         const char *bus_id;
> >
> >         ...
> >
> >         } else {
> >                 acpi_device_bus_id = kzalloc(sizeof(*acpi_device_bus_id),
> >                                              GFP_KERNEL);
> >                 bus_id = kstrdup_const(acpi_device_hid(device), GFP_KERNEL);
> >                 if (!acpi_device_bus_id || !bus_id) {
> >                         kfree(acpi_device_bus_id);


> >                         kfree(bus_id);

Just to be sure, shouldn't it be kfree_const() ?

> >                         result = -ENOMEM;
> >                         goto err_unlock;
> >                 }
> >                 acpi_device_bus_id->bus_id = bus_id;
> >                 list_add_tail(&acpi_device_bus_id->node, &acpi_bus_id_list);
> >         }
> >
> >         ...
> >
> > So that there is only one if / 1 error-handling path for both mallocs.
> > I personally find this a bit cleaner.

-- 
With Best Regards,
Andy Shevchenko


