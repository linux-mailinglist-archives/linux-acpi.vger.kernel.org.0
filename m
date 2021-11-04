Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3664453AD
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 14:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhKDNTP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 09:19:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:46178 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231684AbhKDNTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Nov 2021 09:19:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231548081"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="231548081"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 06:16:36 -0700
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="729282583"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 06:16:35 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 3694320CDB;
        Thu,  4 Nov 2021 15:16:33 +0200 (EET)
Date:   Thu, 4 Nov 2021 15:16:33 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 1/3] ACPI: Make acpi_fwnode_handle safer
Message-ID: <YYPdMRDOuMFQzku5@paasikivi.fi.intel.com>
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

I went through the users and it seems they don't actually even benefit from
this. So I'll drop the patch.

Most of these little macros are made safer that way but in this case it
seems callers have already acpi_device around, or do checks for other
purposes as well.

-- 
Sakari Ailus
