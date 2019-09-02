Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B49CA5882
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 15:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfIBN5a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 09:57:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:52288 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730136AbfIBN5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:29 -0700
X-IronPort-AV: E=Sophos;i="5.64,459,1559545200"; 
   d="scan'208";a="183314992"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Sep 2019 06:57:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 9E27A20B48;
        Mon,  2 Sep 2019 16:57:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i4mpo-00067D-GN; Mon, 02 Sep 2019 16:57:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        rafael@kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH v5 00/11] Device property improvements, add %pfw format specifier
Date:   Mon,  2 Sep 2019 16:57:21 +0300
Message-Id: <20190902135732.23455-1-sakari.ailus@linux.intel.com>
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

Sakari Ailus (11):
  software node: Get reference to parent swnode in get_parent op
  software node: Make argument to to_software_node const
  device property: Move fwnode_get_parent() up
  device property: Add functions for accessing node's parents
  device property: Add fwnode_get_name for returning the name of a node
  device property: Add a function to obtain a node's prefix
  lib/vsprintf: Remove support for %pF and %pf in favour of %pS and %ps
  lib/vsprintf: Make use of fwnode API to obtain node names and
    separators
  lib/vsprintf: OF nodes are first and foremost, struct device_nodes
  lib/vsprintf: Add %pfw conversion specifier for printing fwnode names
  lib/test_printf: Add tests for %pfw printk modifier

 Documentation/core-api/printk-formats.rst | 34 ++++++---
 drivers/acpi/property.c                   | 48 +++++++++++++
 drivers/base/property.c                   | 83 +++++++++++++++++++--
 drivers/base/swnode.c                     | 55 +++++++++++++-
 drivers/of/property.c                     | 16 +++++
 include/linux/fwnode.h                    |  4 ++
 include/linux/property.h                  |  8 ++-
 lib/test_printf.c                         | 37 ++++++++++
 lib/vsprintf.c                            | 88 ++++++++++++++---------
 scripts/checkpatch.pl                     |  4 +-
 10 files changed, 319 insertions(+), 58 deletions(-)

-- 
2.20.1

