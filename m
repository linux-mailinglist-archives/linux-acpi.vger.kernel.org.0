Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDFFDE7B37
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 22:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfJ1VRA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 17:17:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:42162 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbfJ1VRA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 17:17:00 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 19ea6a94ef8dfbed; Mon, 28 Oct 2019 22:16:58 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v2 00/12] ACPICA version 20191018v2
Date:   Mon, 28 Oct 2019 22:16:58 +0100
Message-ID: <2812725.QSNE5ueIqz@kreacher>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C6648FF@ORSMSX122.amr.corp.intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com> <20191028155833.GN32742@smile.fi.intel.com> <CF6A88132359CE47947DB4C6E1709ED53C6648FF@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Monday, October 28, 2019 6:49:10 PM CET Schmauss, Erik wrote:
> 
> > -----Original Message-----
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Sent: Monday, October 28, 2019 8:59 AM
> > To: Schmauss, Erik <erik.schmauss@intel.com>
> > Cc: Rafael J . Wysocki <rafael@kernel.org>; linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH v2 00/12] ACPICA version 20191018v2
> > 
> > On Fri, Oct 25, 2019 at 02:36:48PM -0700, Erik Schmauss wrote:
> > > V2 - fixed build warnings
> > >
> > > This patchset contains the linuxized patches for ACPICA version
> > > 20191018. There are several debugger changes but they are meant for
> > > acpiexec at this time. acpi_load_table definition has been modified
> > > and a new acpi_unload_table has been added. These new interfaces can
> > > be used as a part of config fs to load and unload tables.
> > >
> > > Other than that, Bob has run clang on our code base and removed
> > > several compiler warnings.
> > >
> > > This patchset is also available here:
> > > https://github.com/SchmErik/linux/tree/v20191018
> > >
> > 
> > I have tested this series and it works in my case.
> > Thank you!
> > 
> > P.S. Rafael, I think we can also append the oneliner I have added in the
> > comment to the patch 5.
> 
> I agree. It makes sense to use the interface in the same commit for linux

OK, done.

Please check the result in the bleeding-edge branch of my tree.

Thanks!



