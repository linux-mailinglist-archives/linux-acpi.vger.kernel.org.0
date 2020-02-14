Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5335215F666
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2020 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbgBNTI1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Feb 2020 14:08:27 -0500
Received: from mga02.intel.com ([134.134.136.20]:26791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbgBNTIZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702889"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 00/10] ACPICA release 20200214
Date:   Fri, 14 Feb 2020 10:47:54 -0800
Message-Id: <20200214184804.15114-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series contains the 20200214 release of ACPICA. For linux,
this a relatively small release. Major changes include Enabling the
sleep button on ACPI legacy wake. Aside from that, this release mainly
consists of changes in the converter, type casts to suppress compiler
warnings when building in 64 bit mode on msvc 2019, and updates to
comments.

This patch set is also available for viewing at the following link:



Anchal Agarwal (1):
  ACPICA: Enable sleep button on ACPI legacy wake

Bob Moore (4):
  ACPICA: Fix a comment "enable" fixed events -> "disable" all fixed
    events.
  ACPICA: Table Manager: Update comments in a function header
  ACPICA: Fix a couple of typos
  ACPICA: Update version to 20200214 Version 20200214.

Erik Kaneda (2):
  ACPICA: ASL-ASL+ converter: remove function parameters from
    cv_init_file_tree ()
  ACPICA: ASL-ASL+ converter: make root file a parameter for
    cv_init_file_tree

Sven Barth (3):
  ACPICA: cast the result of the pointer difference to u32
  ACPICA: cast length arguement to acpi_ns_build_normalized_path() as
    u32
  ACPICA: use acpi_size instead of u32 for prefix_path_length

 drivers/acpi/acpica/acconvert.h |  4 +---
 drivers/acpi/acpica/acmacros.h  |  4 ++--
 drivers/acpi/acpica/evevent.c   |  2 +-
 drivers/acpi/acpica/hwsleep.c   | 12 ++++++++++++
 drivers/acpi/acpica/nsnames.c   |  6 +++---
 drivers/acpi/acpica/nsxfname.c  |  2 +-
 drivers/acpi/acpica/tbxface.c   | 12 ++++++------
 drivers/acpi/acpica/utobject.c  |  2 +-
 include/acpi/acpixf.h           |  2 +-
 include/acpi/actbl1.h           |  2 +-
 10 files changed, 29 insertions(+), 19 deletions(-)

-- 
2.21.0

