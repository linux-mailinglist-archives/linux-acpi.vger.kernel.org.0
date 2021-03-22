Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C733452CC
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Mar 2021 00:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhCVXKK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Mar 2021 19:10:10 -0400
Received: from mga06.intel.com ([134.134.136.31]:20267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhCVXJi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Mar 2021 19:09:38 -0400
IronPort-SDR: lmGrAHVnVB7y6BnD1KW4HzQ6zT6kE4gYfc/z89/InlOJOhg9835TE1+QyqHK4Ww/sFgIUQPKKY
 Fv6LoqjC5Jyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="251718881"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="251718881"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 16:09:37 -0700
IronPort-SDR: zKQ+WIFL5+FL5gxXKb6qlpFa7cVFzx5UKdN/50t37YAACb74V3vb7JlxEpz/6VsNE+HYggay8L
 o4QESAjZ5voA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="607510493"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga005.fm.intel.com with ESMTP; 22 Mar 2021 16:09:37 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 0/4] Implement Platform Runtime Mechanism plumbing
Date:   Mon, 22 Mar 2021 15:37:03 -0700
Message-Id: <20210322223707.1838823-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Platform Runtime Mechanism (PRM) is a firmware interface that exposes
a set of binary executables that can either be called from the AML
interpreter or device drivers by bypassing the AML interpreter.

This mechanism offers a more performant way to execute native code
than ASL and a less disruptive approach than ASL invoking SMI by writing
to the SMI command port.

This patch seies adds linux support to invoke PRM through a new ACPI
OperationRegion address type. The native code is ran as if it were a
UEFI runtime service by calling efi_call_virt_pointer to function
pointers exposed in the PRMT ACPI table.

According to the PRM specification, the PRM binary should only consist
of unprivleged instructions. Code that enables Linux to run PRM in CPL3
is currently in-progress and will be released in the future.

The code follows the PRM specification and has been tested on QEMU
running an OVMF image that was integrated with a sample implementation
in Michael Kubacki's EDK2 staging branch.

Links: 

PRM specification:
https://uefi.org/sites/default/files/resources/Platform%20Runtime%20Mechanism%20-%20with%20legal%20notice.pdf

The EDK2 staging branch:
https://github.com/tianocore/edk2-staging/tree/PlatformRuntimeMechanism/PrmPkg


Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>


Erik Kaneda (4):
  ACPICA: iASL: add disassembler support for PRMT
  ACPICA: Add support for PlatformRtMechanism OperationRegion handler
  PRM: implement OperationRegion handler for the PlatformRtMechanism
    subtype
  ACPI: Add \_SB._OSC bit for PRM

 drivers/acpi/Kconfig           |   5 +
 drivers/acpi/Makefile          |   1 +
 drivers/acpi/acpica/acutils.h  |   2 +
 drivers/acpi/acpica/exfield.c  |   8 +-
 drivers/acpi/acpica/exserial.c |  12 ++
 drivers/acpi/acpica/utuuid.c   |  41 +++++
 drivers/acpi/bus.c             |   3 +
 drivers/acpi/prmt.c            | 302 +++++++++++++++++++++++++++++++++
 drivers/acpi/tables.c          |   9 +
 include/acpi/acconfig.h        |   2 +
 include/acpi/actbl2.h          |  40 +++++
 include/linux/acpi.h           |   2 +
 include/linux/prmt.h           |   7 +
 13 files changed, 432 insertions(+), 2 deletions(-)
 create mode 100644 drivers/acpi/prmt.c
 create mode 100644 include/linux/prmt.h

-- 
2.29.2

