Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB235484B
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Apr 2021 23:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241740AbhDEVuH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Apr 2021 17:50:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:26874 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241688AbhDEVuF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Apr 2021 17:50:05 -0400
IronPort-SDR: IPSetev/C9/pKn0CTekh/qbdkvffa6GRfoAD6FBSvrua1frmcsI7reBbp6OxuJZ1K/yqM63PFV
 V39y+6PN1EuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="213278750"
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="213278750"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 14:49:58 -0700
IronPort-SDR: nULLDJ6T4h8Jr8rwOP1NU4D1LVqnq8BQmUNIIGQr/6V/ElLuUoInx9VOqe67aIzAcMHiPEFEW8
 tr7Y6KzUH4aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,307,1610438400"; 
   d="scan'208";a="380673574"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2021 14:49:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 00/22] ACPICA release 20210331 (ACPI 6.4 support)
Date:   Mon,  5 Apr 2021 14:14:48 -0700
Message-Id: <20210405211510.484603-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains the Linux-ized patches of ACPICA version 20210331.
This release implements changes to implement the ACPI 6.4 specification
as well as several new tables defined outside of the ACPI specification.

This patch set is also available here:

https://github.com/SchmErik/linux/tree/20210331

Alexander Monakov (1):
  ACPICA: Add parsing for IVRS IVHD 40h and device entry F0h

Ben Widawsky (1):
  ACPICA: CXL 2.0: CEDT: Add new CEDT table

Bob Moore (8):
  ACPICA: ACPI 6.4: NFIT: add Location Cookie field
  ACPICA: ACPI 6.4: HMAT: add new fields/flags
  ACPICA: ACPI 6.4: Add new flags in SRAT
  ACPICA: ACPI 6.4: PMTT: add new fields/structures
  ACPICA: ACPI 6.4: add CSI2Bus resource template
  ACPICA: iASL: Add support for CEDT table
  ACPICA: iASL: Decode subtable type field for VIOT
  ACPICA: Update version to 20210331

Colin Ian King (1):
  ACPICA: Tree-wide: fix various typos and spelling mistakes

Erik Kaneda (8):
  ACPICA: ACPI 6.4: Add new predefined objects _BPC, _BPS, and _BPT
  ACPICA: ACPI 6.4: add USB4 capabilities UUID
  ACPICA: ACPI 6.4: add CXL ACPI device ID and _CBR object
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Structure
  ACPICA: ACPI 6.4: PCCT: add support for subtable type 5
  ACPICA: ACPI 6.4: PPTT: add new version of subtable type 1
  ACPICA: ACPI 6.4: add SDEV secure access components
  ACPICA: ACPI 6.4: add support for PHAT table

Jean-Philippe Brucker (2):
  ACPICA: iASL: Add definitions for the VIOT table
  ACPICA: acpisrc: Add missing conversion for VIOT support

Shameer Kolothum (1):
  ACPICA: IORT: Updates for revision E.b

 drivers/acpi/acpica/acpredef.h    |  15 ++
 drivers/acpi/acpica/acresrc.h     |   4 +
 drivers/acpi/acpica/acutils.h     |   1 +
 drivers/acpi/acpica/amlresrc.h    |  19 ++-
 drivers/acpi/acpica/rscalc.c      |   4 +-
 drivers/acpi/acpica/rsdump.c      |   8 +
 drivers/acpi/acpica/rsdumpinfo.c  |  26 ++++
 drivers/acpi/acpica/rsinfo.c      |   6 +-
 drivers/acpi/acpica/rslist.c      |   9 +-
 drivers/acpi/acpica/rsmisc.c      |  19 +++
 drivers/acpi/acpica/rsserial.c    |  75 ++++++++++
 drivers/acpi/acpica/utresdecode.c |  10 +-
 drivers/acpi/acpica/utresrc.c     |   1 +
 include/acpi/acoutput.h           |   2 +-
 include/acpi/acpixf.h             |   2 +-
 include/acpi/acrestyp.h           |   9 +-
 include/acpi/actbl1.h             |  54 ++++++-
 include/acpi/actbl2.h             | 240 ++++++++++++++++++++++++++----
 include/acpi/actbl3.h             |  70 ++++++++-
 include/acpi/acuuid.h             |   1 +
 include/acpi/platform/acgcc.h     |   2 +-
 tools/power/acpi/common/cmfsize.c |   2 +-
 22 files changed, 536 insertions(+), 43 deletions(-)

-- 
2.29.2

