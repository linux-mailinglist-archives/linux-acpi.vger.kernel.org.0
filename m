Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E7B39C317
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFDWCq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:62958 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230175AbhFDWCo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:44 -0400
IronPort-SDR: 8rcv9kNAqEWdOHPqEOzF51BJ3XQ1iRGUNHVFLn1ehd+tjVTs3PR42lHLQ/dMVSWoH6viiq2Xu5
 TtK3E+Rj3fmg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539939"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539939"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:54 -0700
IronPort-SDR: eWTn1Vi+IMkY3Axgc5bdTGvvQpShUF3cqq1mk+Y5AqrtHzgGx+OOTSaGtBDGVpcLCkcYEyFXZv
 xUS0Re6nmSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146694"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:54 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 00/14] ACPICA version 20210604
Date:   Fri,  4 Jun 2021 14:25:54 -0700
Message-Id: <20210604212608.2604267-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series contains the linux-ized patch set of ACPICA version
20210604. The patch mostly contains additional structures for ACPI
tables. In addition, this patch set contains ACPICA support for
a new OperationRegion subtype called PlatformRtMechanism (for PRM).
As far as ACPICA is concerned, this subtype will hand off a buffer to a
handler registered by the OS.

Other than that, I will be leaving Intel and this will be my last
ACPICA release. With that said, Rafael will take over this role for
the timebeing. If you have any ACPICA related questions, I will be
around for a few more days so please feel free to reach out.

Thanks,
Erik Kaneda

Alison Schofield (2):
  ACPICA: Add defines for the CXL Host Bridge Structure (CHBS)
  ACPICA: Add the CFMWS structure definition to the CEDT table

Bob Moore (5):
  ACPICA: iASL: Finish support for the IVRS ACPI table
  ACPICA: iASL: Add support for the SVKL table
  ACPICA: iASL Table Compiler: Add full support for RGRT ACPI table
  ACPICA: iASL: Add support for the BDAT ACPI table
  ACPICA: Update version to 20210604 Version 20210604.

Erik Kaneda (3):
  ACPICA: Fix memory leak caused by _CID repair function
  ACPICA: iASL: add disassembler support for PRMT
  ACPICA: Add support for PlatformRtMechanism OperationRegion handler

Fabian Wüthrich (1):
  ACPICA: Add _PLD panel positions

Kuppuswamy Sathyanarayanan (2):
  ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
  ACPICA: Add SVKL table headers

Wei Ming Chen (1):
  ACPICA: Use ACPI_FALLTHROUGH

 drivers/acpi/acpica/acutils.h   |   2 +
 drivers/acpi/acpica/exfield.c   |   8 +-
 drivers/acpi/acpica/exserial.c  |  12 +++
 drivers/acpi/acpica/nsrepair2.c |   7 ++
 drivers/acpi/acpica/utprint.c   |   2 +-
 drivers/acpi/acpica/utuuid.c    |  41 ++++++++++
 include/acpi/acbuffer.h         |  10 +++
 include/acpi/acconfig.h         |   2 +
 include/acpi/acpixf.h           |   2 +-
 include/acpi/actbl1.h           |  41 +++++++++-
 include/acpi/actbl2.h           | 132 ++++++++++++++++++++++++++++++++
 11 files changed, 254 insertions(+), 5 deletions(-)

-- 
2.29.2

