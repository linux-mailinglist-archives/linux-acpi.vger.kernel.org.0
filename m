Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B362B64A2
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Sep 2019 15:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfIRNeF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Sep 2019 09:34:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:19399 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbfIRNeF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Sep 2019 09:34:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:04 -0700
X-IronPort-AV: E=Sophos;i="5.64,520,1559545200"; 
   d="scan'208";a="338331690"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Sep 2019 06:34:01 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 742172022B;
        Wed, 18 Sep 2019 16:33:59 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1iAa67-00025S-Sy; Wed, 18 Sep 2019 16:34:19 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v7 00/13] Device property improvements, add %pfw format specifier
Date:   Wed, 18 Sep 2019 16:34:06 +0300
Message-Id: <20190918133419.7969-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi all,

This set adds functionality into the device property API (counting a
node's parents as well as obtaining its name) in order to support printing
fwnode names using a new conversion specifier "%pfw". The names that are
produced are equivalent to its OF counterpart "%pOF" on OF systems for the
two supported modifiers ("f" and "P").

Printing a node's name is something that's been available on OF for a long
time and if something is converted to device property API (such as the
V4L2 fwnode framework) it always got removed of a nice feature that was
sometimes essential in debugging. With this set, that no longer is the
case.

Note: the set now depends on 2d44d165e939 ("scsi: lpfc: Convert existing
%pf users to %ps") that is expected from the linux-scsi tree. It is 

since v6:

- Added a patch for a warning note on re-using obsolete %pf oand %pF
  extensions.

- Rework %pfw validatition in checkpatch.pl according to Joe's comments.

- Unwrap a line wrapped by a previous versions in get_bprint_format().

- Handle %pf and %pF modifiers again in make_bprint_args() in case they're
  no followed by 'w'.

since v5:

- Added a patch to convert %pf to %ps in tools/lib/traceevent.c (first in
  the set).

- Fix ReST syntax in Documentation/core-api/printk-formats.rst.

- Fix returning root swnode name in patch "device property: Add
  fwnode_get_name for returning the name of a node". Use to_swnode()
  directly as well in the same patch.

- Tests: take root node name into account, use direct indices and remove
  the comma from the guardian entry.

- Add a comment on how fwnode_full_name_string() enumerates the nodes.

- Fix error string in fwnode_string().

- Move 'f' + default case as last in the switch in fwnode_string().

- Fix %pfw validation in checkpatch.pl.

since v4:

- Improved documentation for fwnode_get_nth_parent().

- Removed comma from the guardian entry in fwnode_pointer() testcase.

since v3:

- Remove underscores in argument name of fwnode_count_parents().

- Re-introduce "%pO?" error string.

- Unwrap a call to string() in fwnode_string().

- Removed a useless Depends-on: on a patch that was merged long ago.

- Unwrap a Fixes: line.

- Added a patch to move fwnode_get_parent() up to make the review of the
  following patch easier.

since v2:

- Better comments in acpi_fwnode_get_name_prefix().

- Added swnode implementation.

- Fixed swnode refcounting in get_parent() ("swnode: Get reference to
  parent swnode in get_parent op")

- Make argument to to_software_node() const (a new patch)

- Factored out confusingly named kobject_string() that had a single
  caller.

- Cleaner fwnode_count_parents() implementation (as discussed in review).

- Made fwnode_count_parents() argument const.

- Added tests (last patch in the set).

since v1:

- Add patch to remove support for %pf and %pF (depends on another patch
  removing all use of %pf and %pF) (now 4th patch)

- Fix kerneldoc argument documentation for fwnode_get_name (2nd patch)

- Align kerneldoc style with the rest of drivers/base/property.c (no extra
  newline after function name)

- Make checkpatch.pl complain about "%pf" not followed by "w" (6th patch)

- WARN_ONCE() on use of invalid conversion specifiers ("%pf" not followed
  by "w")

Sakari Ailus (13):
  tools lib traceevent: Convert remaining %p[fF] users to %p[sS]
  software node: Get reference to parent swnode in get_parent op
  software node: Make argument to to_software_node const
  device property: Move fwnode_get_parent() up
  device property: Add functions for accessing node's parents
  device property: Add fwnode_get_name for returning the name of a node
  device property: Add a function to obtain a node's prefix
  lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
  lib/vsprintf: Add a note on re-using %pf or %pF
  lib/vsprintf: Make use of fwnode API to obtain node names and
    separators
  lib/vsprintf: OF nodes are first and foremost, struct device_nodes
  lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
  lib/test_printf: Add tests for %pfw printk modifier

 Documentation/core-api/printk-formats.rst     | 34 +++++--
 drivers/acpi/property.c                       | 48 ++++++++++
 drivers/base/property.c                       | 83 +++++++++++++++--
 drivers/base/swnode.c                         | 43 ++++++++-
 drivers/of/property.c                         | 16 ++++
 include/linux/fwnode.h                        |  4 +
 include/linux/property.h                      |  8 +-
 lib/test_printf.c                             | 32 +++++++
 lib/vsprintf.c                                | 91 ++++++++++++-------
 scripts/checkpatch.pl                         |  9 +-
 .../Documentation/libtraceevent-func_apis.txt | 10 +-
 tools/lib/traceevent/event-parse.c            | 18 +++-
 12 files changed, 328 insertions(+), 68 deletions(-)

-- 
2.20.1

