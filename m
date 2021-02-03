Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E60230E27D
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 19:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBCS2G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 13:28:06 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:57228 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhBCS2E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 13:28:04 -0500
Received: from 89-64-80-249.dynamic.chello.pl (89.64.80.249) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.537)
 id d0d4daa77e01edd2; Wed, 3 Feb 2021 19:27:21 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/5] ACPI: AC: Clean up printing messages
Date:   Wed, 03 Feb 2021 19:27:20 +0100
Message-ID: <1933500.ANFmzMss4A@kreacher>
In-Reply-To: <2b40c1c6-85f8-92dd-7f97-819a6366a333@huawei.com>
References: <2367702.B5bJTmGzJm@kreacher> <5584914.5WsbVgmIkf@kreacher> <2b40c1c6-85f8-92dd-7f97-819a6366a333@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wednesday, February 3, 2021 2:31:08 AM CET Hanjun Guo wrote:
> Hi Rafael,
> 
> On 2021/2/3 2:14, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> > in ac.c with acpi_handle_debug() and acpi_handle_info() calls,
> > respectively, which among other things causes the excessive log
> > level of the messages previously printed via ACPI_EXCEPTION() to
> > be more adequate.
> > 
> > Drop the _COMPONENT and ACPI_MODULE_NAME() definitions that are not
> > used any more, drop the no longer needed ACPI_AC_COMPONENT definition
> > from the headers and update the documentation accordingly.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> > 
> > v1 -> v2: Changelog update
> > 
> > ---
> >   Documentation/firmware-guide/acpi/debug.rst |    1 -
> >   drivers/acpi/ac.c                           |   12 +++++-------
> >   drivers/acpi/sysfs.c                        |    1 -
> >   include/acpi/acpi_drivers.h                 |    1 -
> >   4 files changed, 5 insertions(+), 10 deletions(-)
> > 
> > Index: linux-pm/Documentation/firmware-guide/acpi/debug.rst
> > ===================================================================
> > --- linux-pm.orig/Documentation/firmware-guide/acpi/debug.rst
> > +++ linux-pm/Documentation/firmware-guide/acpi/debug.rst
> > @@ -52,7 +52,6 @@ shows the supported mask values, current
> >       ACPI_CA_DISASSEMBLER            0x00000800
> >       ACPI_COMPILER                   0x00001000
> >       ACPI_TOOLS                      0x00002000
> > -    ACPI_AC_COMPONENT               0x00020000
> >       ACPI_BATTERY_COMPONENT          0x00040000
> >       ACPI_BUTTON_COMPONENT           0x00080000
> >       ACPI_SBS_COMPONENT              0x00100000
> > Index: linux-pm/drivers/acpi/ac.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/ac.c
> > +++ linux-pm/drivers/acpi/ac.c
> 
> In this file, printk() is still using, how about convert them
> all into pr_*? I think patch on top your or update this patch
> are both OK.

Good idea.

Thanks for all of the comments.  They will be addressed in the v3 that will be
posted shortly.



