Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36353CD4A8
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jul 2021 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236747AbhGSLly (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Jul 2021 07:41:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:19753 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236918AbhGSLlv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Jul 2021 07:41:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="211042056"
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="211042056"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:22:31 -0700
X-IronPort-AV: E=Sophos;i="5.84,252,1620716400"; 
   d="scan'208";a="430831674"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 05:22:29 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m5SHu-00FVcR-V4; Mon, 19 Jul 2021 15:22:22 +0300
Date:   Mon, 19 Jul 2021 15:22:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     Jon Nettleton <jon@solid-run.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] software node: balance refcount for managed sw nodes
Message-ID: <YPVufjevu5WaaIxQ@smile.fi.intel.com>
References: <20210716101602.1891-1-laurentiu.tudor@nxp.com>
 <YPF40t5bhgTFM2wK@smile.fi.intel.com>
 <CABdtJHuKyybhJazpAc8KT54ELtZ319rdb6CbSH6zB5x3NhgtAw@mail.gmail.com>
 <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb009f85-687e-d560-9cc5-1ac4f586a6bd@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jul 19, 2021 at 03:00:17PM +0300, Laurentiu Tudor wrote:
> On 7/16/2021 8:21 PM, Jon Nettleton wrote:
> > On Fri, Jul 16, 2021 at 2:17 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> On Fri, Jul 16, 2021 at 01:16:02PM +0300, laurentiu.tudor@nxp.com wrote:
> >>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>
> >>> software_node_notify(), on KOBJ_REMOVE drops the refcount twice on managed
> >>> software nodes, thus leading to underflow errors. Balance the refcount by
> >>> bumping it in the device_create_managed_software_node() function.
> >>>
> >>> The error [1] was encountered after adding a .shutdown() op to our
> >>> fsl-mc-bus driver.
> >>
> >> Looking into the history of adding ->shutdown() to dwc3 driver (it got reverted
> >> later on), I can tell that probably something is wrong in the ->shutdown()
> >> method itself.
> > 
> > Isn't the other alternative to just remove the second kobject_put from
> > KOBJ_REMOVE ?
> > 
> 
> Or maybe on top of Heikki's suggestion, replace the calls to
> sysfs_create_link() from KOBJ_ADD with sysfs_create_link_nowarn()?

_noearn will hide the problem. It was there, it was removed from there.
Perhaps we have to understand the root cause better (some specific flow?).

Any insight from you on the flow when the issue appears? I.o.w. what happened
on the big picture that we got into the warning you see?

-- 
With Best Regards,
Andy Shevchenko


