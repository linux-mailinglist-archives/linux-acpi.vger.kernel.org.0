Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9874FD3C4B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 11:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfJKJ2m (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 05:28:42 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52686 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbfJKJ2m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 05:28:42 -0400
Received: from 79.184.255.36.ipv4.supernova.orange.pl (79.184.255.36) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id a6fa11c8e3b0a2d1; Fri, 11 Oct 2019 11:28:40 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH v9 00/12] Device property improvements, add %pfw format specifier
Date:   Fri, 11 Oct 2019 11:28:39 +0200
Message-ID: <1588860.o9alHonHAX@kreacher>
In-Reply-To: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
References: <20191003123219.11237-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thursday, October 3, 2019 2:32:07 PM CEST Sakari Ailus wrote:
> Hi all,
> 
> This set adds functionality into the device property API (counting a
> node's parents as well as obtaining its name) in order to support printing
> fwnode names using a new conversion specifier "%pfw". The names that are
> produced are equivalent to its OF counterpart "%pOF" on OF systems for the
> two supported modifiers ("f" and "P").
> 
> Printing a node's name is something that's been available on OF for a long
> time and if something is converted to device property API (such as the
> V4L2 fwnode framework) it always got removed of a nice feature that was
> sometimes essential in debugging. With this set, that no longer is the
> case.
> 
> Note: the set now depends on commit b295c3e39c13 ("tools lib traceevent:
> Convert remaining %p[fF] users to %p[sS]") and commit 2d44d165e939 ("scsi:
> lpfc: Convert existing %pf users to %ps") which both are in v5.4-rc1.
> 
> Note 2: There's no full v8 set as I sent a patch fixing a single issue but
> there turned out to be a little more to fix, making this one v9.
> 
> since v7:
> 
> - Reword warning on re-use of %pf and %pF.
> 
> - Remove %pf and %pF support from vbin_printf() as well.
> 
> - Removed the first patch (now commit b295c3e39c13 ("tools lib traceevent:
>   Convert remaining %p[fF] users to %p[sS]")) from the set as it was
>   already merged through Arnoldo Carvalho de Melo's tree. Added
>   Depends-on: tag to the same patch.
> 
> since v6:
> 
> - Added a patch for a warning note on re-using obsolete %pf oand %pF
>   extensions.
> 
> - Rework %pfw validatition in checkpatch.pl according to Joe's comments.
> 
> - Unwrap a line wrapped by a previous versions in get_bprint_format().
> 
> - Handle %pf and %pF modifiers again in make_bprint_args() in case they're
>   no followed by 'w'.
> 
> since v5:
> 
> - Added a patch to convert %pf to %ps in tools/lib/traceevent.c (first in
>   the set).
> 
> - Fix ReST syntax in Documentation/core-api/printk-formats.rst.
> 
> - Fix returning root swnode name in patch "device property: Add
>   fwnode_get_name for returning the name of a node". Use to_swnode()
>   directly as well in the same patch.
> 
> - Tests: take root node name into account, use direct indices and remove
>   the comma from the guardian entry.
> 
> - Add a comment on how fwnode_full_name_string() enumerates the nodes.
> 
> - Fix error string in fwnode_string().
> 
> - Move 'f' + default case as last in the switch in fwnode_string().
> 
> - Fix %pfw validation in checkpatch.pl.
> 
> since v4:
> 
> - Improved documentation for fwnode_get_nth_parent().
> 
> - Removed comma from the guardian entry in fwnode_pointer() testcase.
> 
> since v3:
> 
> - Remove underscores in argument name of fwnode_count_parents().
> 
> - Re-introduce "%pO?" error string.
> 
> - Unwrap a call to string() in fwnode_string().
> 
> - Removed a useless Depends-on: on a patch that was merged long ago.
> 
> - Unwrap a Fixes: line.
> 
> - Added a patch to move fwnode_get_parent() up to make the review of the
>   following patch easier.
> 
> since v2:
> 
> - Better comments in acpi_fwnode_get_name_prefix().
> 
> - Added swnode implementation.
> 
> - Fixed swnode refcounting in get_parent() ("swnode: Get reference to
>   parent swnode in get_parent op")
> 
> - Make argument to to_software_node() const (a new patch)
> 
> - Factored out confusingly named kobject_string() that had a single
>   caller.
> 
> - Cleaner fwnode_count_parents() implementation (as discussed in review).
> 
> - Made fwnode_count_parents() argument const.
> 
> - Added tests (last patch in the set).
> 
> since v1:
> 
> - Add patch to remove support for %pf and %pF (depends on another patch
>   removing all use of %pf and %pF) (now 4th patch)
> 
> - Fix kerneldoc argument documentation for fwnode_get_name (2nd patch)
> 
> - Align kerneldoc style with the rest of drivers/base/property.c (no extra
>   newline after function name)
> 
> - Make checkpatch.pl complain about "%pf" not followed by "w" (6th patch)
> 
> - WARN_ONCE() on use of invalid conversion specifiers ("%pf" not followed
>   by "w")
> 
> Sakari Ailus (12):
>   software node: Get reference to parent swnode in get_parent op
>   software node: Make argument to to_software_node const
>   device property: Move fwnode_get_parent() up
>   device property: Add functions for accessing node's parents
>   device property: Add fwnode_get_name for returning the name of a node
>   device property: Add a function to obtain a node's prefix
>   lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
>   lib/vsprintf: Add a note on re-using %pf or %pF
>   lib/vsprintf: Make use of fwnode API to obtain node names and
>     separators
>   lib/vsprintf: OF nodes are first and foremost, struct device_nodes
>   lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
>   lib/test_printf: Add tests for %pfw printk modifier
> 
>  Documentation/core-api/printk-formats.rst | 34 ++++++---
>  drivers/acpi/property.c                   | 48 ++++++++++++
>  drivers/base/property.c                   | 83 ++++++++++++++++++--
>  drivers/base/swnode.c                     | 43 ++++++++++-
>  drivers/of/property.c                     | 16 ++++
>  include/linux/fwnode.h                    |  4 +
>  include/linux/property.h                  |  8 +-
>  lib/test_printf.c                         | 32 ++++++++
>  lib/vsprintf.c                            | 93 ++++++++++++++---------
>  scripts/checkpatch.pl                     |  9 ++-
>  10 files changed, 309 insertions(+), 61 deletions(-)
> 
> 

Applying the series (with the tags collected so far) as 5.5 material, thanks!




