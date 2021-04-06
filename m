Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924D0355E5F
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239904AbhDFWFS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Apr 2021 18:05:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:54926 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233015AbhDFWFR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Apr 2021 18:05:17 -0400
IronPort-SDR: NTro/LruEVB+f5lnUAFRVAh08csjxVG1Iup3b8KADnVQNFK8XUgMpCtLLVAusyUbcTyDfb+6aF
 LQxhmJtsJLUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9946"; a="172640453"
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="172640453"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2021 15:05:08 -0700
IronPort-SDR: MERW5PJGdAgpnh6CCNY4eojCJQUHuxcP521vI4xl870zy50M8xUDXTI9G00cCrWIWVO9dUci79
 gjGOZymCMkCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,201,1613462400"; 
   d="scan'208";a="379581707"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga003.jf.intel.com with ESMTP; 06 Apr 2021 15:05:08 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH v2 00/22] ACPICA release 20210331 (ACPI 6.4 support)
Date:   Tue,  6 Apr 2021 14:30:06 -0700
Message-Id: <20210406213028.718796-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains the Linux-ized patches of ACPICA version 20210331.
This release implements changes to implement the ACPI 6.4 specification
as well as several new tables defined outside of the ACPI specification.

v2: fix build issue stemming modified NFIT structure

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
 drivers/acpi/nfit/core.c          |   2 +-
 include/acpi/acoutput.h           |   2 +-
 include/acpi/acpixf.h             |   2 +-
 include/acpi/acrestyp.h           |   9 +-
 include/acpi/actbl1.h             |  54 ++++++-
 include/acpi/actbl2.h             | 240 ++++++++++++++++++++++++++----
 include/acpi/actbl3.h             |  70 ++++++++-
 include/acpi/acuuid.h             |   1 +
 include/acpi/platform/acgcc.h     |   2 +-
 tools/power/acpi/common/cmfsize.c |   2 +-
 23 files changed, 537 insertions(+), 44 deletions(-)

-- 
2.29.2

