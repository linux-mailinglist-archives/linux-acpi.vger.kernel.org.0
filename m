Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6CE7477
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2019 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388953AbfJ1PI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Oct 2019 11:08:28 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43422 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfJ1PI2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Oct 2019 11:08:28 -0400
Received: from cust-east-parth2-46-193-72-114.wb.wifirst.net (46.193.72.114) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 5d2e8ad309cf977a; Mon, 28 Oct 2019 16:08:25 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Schmauss, Erik" <erik.schmauss@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 00/12] ACPICA version 20191018
Date:   Mon, 28 Oct 2019 16:08:25 +0100
Message-ID: <2645368.DDsniWIdCY@kreacher>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C6641E5@ORSMSX122.amr.corp.intel.com>
References: <20191024185556.4606-1-erik.schmauss@intel.com> <CAJZ5v0gqN3yGcLLVntYQgwxVsUhbEZ8L0UJNXOh=xA6nmgTQLA@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED53C6641E5@ORSMSX122.amr.corp.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Friday, October 25, 2019 7:08:14 PM CET Schmauss, Erik wrote:
> 
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Friday, October 25, 2019 2:19 AM
> > To: Schmauss, Erik <erik.schmauss@intel.com>
> > Cc: Rafael J . Wysocki <rafael@kernel.org>; ACPI Devel Maling List <linux-
> > acpi@vger.kernel.org>
> > Subject: Re: [PATCH 00/12] ACPICA version 20191018
> > 
> > On Thu, Oct 24, 2019 at 9:13 PM Erik Schmauss <erik.schmauss@intel.com>
> > wrote:
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
> > > Bob Moore (5):
> > >   ACPICA: Results from Clang changes/fixes From Clang V5.0.1. Mostly
> > >     "set but never read" warnings.
> > >   ACPICA: Win OSL: Replace get_tick_count with get_tick_count64
> > >   ACPICA: More Clang changes - V8.0.1 Fixed all "dead assignment"
> > >     warnings.
> > >   ACPICA: Add new external interface, acpi_unload_table
> > >   ACPICA: Update version to 20191018
> > >
> > > Erik Schmauss (6):
> > >   ACPICA: utilities: add flag to only display data when dumping buffers
> > >   ACPICA: Debugger: add command to dump all fields of a particular
> > >     subtype
> > >   ACPICA: debugger: surround field unit output with braces '{'
> > >   ACPICA: debugger: add field unit support for acpi_db_get_next_token
> > >   ACPICA: acpiexec: initialize all simple types and field units from
> > >     user input
> > >   ACPICA: debugger: remove leading whitespaces when converting a string
> > >     to a buffer
> > >
> > > Nikolaus Voss (1):
> > >   ACPICA: make acpi_load_table() return table index
> > 
> > Queuing up as 5.5 material with some minor subject/changelog modifications.
> [Schmauss, Erik]
> 
> Sorry about the build errors...I'll send a v2 today.

Replacing this one with the v2 in my tree, thanks!



