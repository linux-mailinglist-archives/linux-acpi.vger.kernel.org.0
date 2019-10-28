Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E41E77D6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 18:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390724AbfJ1RtM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 28 Oct 2019 13:49:12 -0400
Received: from mga05.intel.com ([192.55.52.43]:58210 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730981AbfJ1RtM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Oct 2019 13:49:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Oct 2019 10:49:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,240,1569308400"; 
   d="scan'208";a="205240171"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2019 10:49:11 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 28 Oct 2019 10:49:10 -0700
Received: from orsmsx122.amr.corp.intel.com ([169.254.11.32]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.29]) with mapi id 14.03.0439.000;
 Mon, 28 Oct 2019 10:49:10 -0700
From:   "Schmauss, Erik" <erik.schmauss@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH v2 00/12] ACPICA version 20191018v2
Thread-Topic: [PATCH v2 00/12] ACPICA version 20191018v2
Thread-Index: AQHVi37VnZRkL5AwUk+Mvr5HUTYSd6dwr3SA//+dI/A=
Date:   Mon, 28 Oct 2019 17:49:10 +0000
Message-ID: <CF6A88132359CE47947DB4C6E1709ED53C6648FF@ORSMSX122.amr.corp.intel.com>
References: <20191025213700.14685-1-erik.schmauss@intel.com>
 <20191028155833.GN32742@smile.fi.intel.com>
In-Reply-To: <20191028155833.GN32742@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjAyZGYzNDUtNzA1NS00MjhkLTk2MWQtNWU4MzkyYjdiZWUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicFkyUTd4QnNpYzFaN1NjZnZnYU5pMEd1ejh2Q2pvcHFia2JWUXJNZGZqTzB5Z0J2anpSOU1EOU9UU2hTUTQ3aSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Monday, October 28, 2019 8:59 AM
> To: Schmauss, Erik <erik.schmauss@intel.com>
> Cc: Rafael J . Wysocki <rafael@kernel.org>; linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v2 00/12] ACPICA version 20191018v2
> 
> On Fri, Oct 25, 2019 at 02:36:48PM -0700, Erik Schmauss wrote:
> > V2 - fixed build warnings
> >
> > This patchset contains the linuxized patches for ACPICA version
> > 20191018. There are several debugger changes but they are meant for
> > acpiexec at this time. acpi_load_table definition has been modified
> > and a new acpi_unload_table has been added. These new interfaces can
> > be used as a part of config fs to load and unload tables.
> >
> > Other than that, Bob has run clang on our code base and removed
> > several compiler warnings.
> >
> > This patchset is also available here:
> > https://github.com/SchmErik/linux/tree/v20191018
> >
> 
> I have tested this series and it works in my case.
> Thank you!
> 
> P.S. Rafael, I think we can also append the oneliner I have added in the
> comment to the patch 5.

I agree. It makes sense to use the interface in the same commit for linux

> 
> >
> > Bob Moore (5):
> >   ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly
> >     "set but never read" warnings.
> >   ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
> >   ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment"
> >     warnings.
> >   ACPICA: Add new external interface, acpi_unload_table
> >   ACPICA: Update version to 20191018
> >
> > Erik Schmauss (6):
> >   ACPICA: utilities: add flag to only display data when dumping buffers
> >   ACPICA: debugger: add command to dump all fields of a particular
> >     subtype
> >   ACPICA: debugger: surround field unit output with braces '{'
> >   ACPICA: debugger: add field unit support for acpi_db_get_next_token
> >   ACPICA: acpiexec: initialize all simple types and field units from
> >     user input
> >   ACPICA: debugger: remove leading whitespaces when converting a string
> >     to a buffer
> >
> > Nikolaus Voss (1):
> >   ACPICA: make acpi_load_table() return table index
> >
> >  drivers/acpi/acpi_configfs.c    |   2 +-
> >  drivers/acpi/acpica/acdebug.h   |   2 +
> >  drivers/acpi/acpica/acstruct.h  |  10 +++
> >  drivers/acpi/acpica/acutils.h   |   9 +--
> >  drivers/acpi/acpica/dbconvert.c |   4 ++
> >  drivers/acpi/acpica/dbdisply.c  |   2 -
> >  drivers/acpi/acpica/dbfileio.c  |   2 +-
> >  drivers/acpi/acpica/dbinput.c   |  36 +++++++++-
> >  drivers/acpi/acpica/dbmethod.c  |   4 ++
> >  drivers/acpi/acpica/dbnames.c   | 114 ++++++++++++++++++++++++++++++++
> >  drivers/acpi/acpica/dbobject.c  |   1 -
> >  drivers/acpi/acpica/dscontrol.c |   2 +-
> >  drivers/acpi/acpica/dsfield.c   |  12 +---
> >  drivers/acpi/acpica/evgpeblk.c  |  11 +--
> >  drivers/acpi/acpica/evgpeinit.c |   3 -
> >  drivers/acpi/acpica/evmisc.c    |  12 +++-
> >  drivers/acpi/acpica/evregion.c  |   4 +-
> >  drivers/acpi/acpica/evrgnini.c  |   1 -
> >  drivers/acpi/acpica/hwxfsleep.c |   3 +
> >  drivers/acpi/acpica/nsconvert.c |   2 +-
> >  drivers/acpi/acpica/nsdump.c    |   6 +-
> >  drivers/acpi/acpica/nsxfname.c  |   4 +-
> >  drivers/acpi/acpica/psobject.c  |   7 +-
> >  drivers/acpi/acpica/rscreate.c  |   3 +
> >  drivers/acpi/acpica/tbdata.c    |   3 +
> >  drivers/acpi/acpica/tbxfload.c  |  40 ++++++++++-
> > drivers/acpi/acpica/utbuffer.c  |  52 ++++++++-------
> >  drivers/acpi/acpica/utids.c     |   2 -
> >  drivers/acpi/acpica/uttrack.c   |   2 +-
> >  drivers/firmware/efi/efi.c      |   2 +-
> >  include/acpi/acpixf.h           |   8 ++-
> >  31 files changed, 291 insertions(+), 74 deletions(-)
> >
> > --
> > 2.21.0
> >
> 
> --
> With Best Regards,
> Andy Shevchenko
> 

