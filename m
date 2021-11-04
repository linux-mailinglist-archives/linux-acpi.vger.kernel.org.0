Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02F5F44534F
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 13:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhKDMvP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 08:51:15 -0400
Received: from mga07.intel.com ([134.134.136.100]:10297 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhKDMvP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Nov 2021 08:51:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="295141523"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="295141523"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:48:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="729277126"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 05:48:35 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 69D5520BFE;
        Thu,  4 Nov 2021 14:48:33 +0200 (EET)
Date:   Thu, 4 Nov 2021 14:48:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] ACPI: Make acpi_fwnode_handle safer
Message-ID: <YYPWobCg7DHmcKDx@paasikivi.fi.intel.com>
References: <20211103133406.659542-1-sakari.ailus@linux.intel.com>
 <20211103133406.659542-2-sakari.ailus@linux.intel.com>
 <CAJZ5v0i4ZqKPUw1oHT9kt9F6OnZE9AjHZ89tzGm2OHFp-88-YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i4ZqKPUw1oHT9kt9F6OnZE9AjHZ89tzGm2OHFp-88-YQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael,

On Wed, Nov 03, 2021 at 06:55:17PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 3, 2021 at 2:33 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Check that the fwnode argument passed to acpi_fwnode_handle is non-NULL,
> > and return NULL if it is, otherwise the fwnode. Thus the caller doesn't
> > have to ensure the argument is a valid non-NULL fwnode.
> >
> > Cc: stable@vger.kernel.org # v5.15 and up
> 
> Why?
> 
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> That's because you want to avoid a NULL check in the second patch and
> it adds a ton of redundant NULL checks all over the place.
> 
> Like for example in include/acpi/acpi.h:
> 
> #define ACPI_COMPANION_SET(dev, adev) set_primary_fwnode(dev, (adev) ? \
>             acpi_fwnode_handle(adev) : NULL)
> 
> You should at least get rid of this one.

That's a fair point.

acpi_fwnode_handle() doesn't have a tonne of users so it's entirely
feasible to change the users as necessary but in either case I guess I'll
drop this from stable as it's likely to conflict with some of these.

-- 
Regards,

Sakari Ailus
