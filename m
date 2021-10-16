Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708A74301EC
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 12:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbhJPKXR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 06:23:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:23721 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244150AbhJPKW4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 06:22:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="215208524"
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="215208524"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 03:20:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,378,1624345200"; 
   d="scan'208";a="549399511"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by fmsmga004.fm.intel.com with ESMTP; 16 Oct 2021 03:20:44 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 0/4] Introduce Platform Firmware Runtime Update and Telemetry drivers
Date:   Sat, 16 Oct 2021 18:26:06 +0800
Message-Id: <cover.1634310710.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The PFRU(Platform Firmware Runtime Update) kernel interface is designed
to interact with the platform firmware interface defined in the Management
Mode Firmware Runtime Update specification[1]. The primary function of
PFRU is to carry out runtime updates of the platform firmware, which
doesn't require the system to be restarted.  It also allows telemetry data
to be retrieved from the platform firmware.

[1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf

Chen Yu (4):
  efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
    corresponding structures
  drivers/acpi: Introduce Platform Firmware Runtime Update device driver
  drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
  tools: Introduce power/acpi/pfru/pfru

 Documentation/ABI/testing/pfru                |  41 +
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfru/Kconfig                     |  16 +
 drivers/acpi/pfru/Makefile                    |   2 +
 drivers/acpi/pfru/pfru_update.c               | 943 ++++++++++++++++++
 include/linux/efi.h                           |  50 +
 include/uapi/linux/pfru.h                     | 150 +++
 tools/power/acpi/pfru/Makefile                |  25 +
 tools/power/acpi/pfru/pfru.8                  | 139 +++
 tools/power/acpi/pfru/pfru.c                  | 336 +++++++
 12 files changed, 1705 insertions(+)
 create mode 100644 Documentation/ABI/testing/pfru
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h
 create mode 100644 tools/power/acpi/pfru/Makefile
 create mode 100644 tools/power/acpi/pfru/pfru.8
 create mode 100644 tools/power/acpi/pfru/pfru.c

-- 
2.25.1

