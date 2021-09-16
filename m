Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A18840DE7E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Sep 2021 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240066AbhIPPtm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 16 Sep 2021 11:49:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:5843 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240042AbhIPPtl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 16 Sep 2021 11:49:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="202750825"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="202750825"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 08:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; 
   d="scan'208";a="545758569"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Sep 2021 08:48:17 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 0/5] Introduce Platform Firmware Runtime Update and Telemetry drivers
Date:   Thu, 16 Sep 2021 23:53:58 +0800
Message-Id: <cover.1631802162.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

High Service Level Agreements (SLAs) requires that the system runs without
service interruptions. Generally, system firmware provides runtime services
such as RAS(Reliability, Availability and Serviceability) features, UEFI runtime
services and ACPI services. Currently if there is any firmware code changes in
these code area, the system firmware update and reboot is required. Example of
bug fix could be wrong register size or location of the register. This means
customer services are not available during the firmware upgrade, which could
approach several minutes, resulting in not able to meet SLAs.

Intel provides a mechanism named Management Mode Runtime Update to help the users
update the firmware without having to reboot[1].

This series provides the following facilities.

  1. Perform a runtime firmware driver update and activate.
  2. Ability to inject firmware code at runtime, for dynamic instrumentation.
  3. Facility to retrieve logs from runtime firmware update and activate telemetry.
     (The telemetry is based on runtime firmware update: it records the logs during
      runtime update(code injection and driver update).

The Management Mode Runtime Update OS Interface Specification[1] provides two ACPI
device objects to interface with system firmware to perform these updates. This patch
series introduces the drivers for those ACPI devices.

[1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf

=============
- Change from v2 to v3:
  - Use valid types for structures that cross the user/kernel boundry
    in the uapi header. (Greg Kroah-Hartman)
  - Rename the structure in uapi to start with a prefix pfru so as
    to avoid confusing in the global namespace. (Greg Kroah-Hartman)
- Change from v1 to v2:
  - Add a spot in index.rst so it becomes part of the docs build
    (Jonathan Corbet).
  - Sticking to the 80-column limit(Jonathan Corbet).
  - Underline lengths should match the title text(Jonathan Corbet).
  - Use literal blocks for the code samples(Jonathan Corbet).
  - Add sanity check for duplicated instance of ACPI device.
  - Update the driver to work with allocated pfru_device objects.
    (Mike Rapoport)
  - For each switch case pair, get rid of the magic case numbers
    and add a default clause with the error handling.(Mike Rapoport)
  - Move the obj->type checks outside the switch to reduce redundancy.
    (Mike Rapoport)
  - Parse the code_inj_id and drv_update_id at driver initialization time
    to reduce the re-parsing at runtime. (Mike Rapoport)
  - Explain in detail how the size needs to be adjusted when doing
    version check. (Mike Rapoport)
  - Rename parse_update_result() to dump_update_result()
    (Mike Rapoport)
  - Remove redundant return.(Mike Rapoport)
  - Do not expose struct capsulate_buf_info to uapi, since it is
    not needed in userspace. (Mike Rapoport)
  - Do not allow non-root user to run this test.(Shuah Khan)
  - Test runs on platform without pfru_telemetry should skip
    instead of reporting failure/error.(Shuah Khan)
  - Reuse uapi/linux/pfru.h instead of copying it into the test
    directory. (Mike Rapoport)

Chen Yu (5):
  Documentation: Introduce Platform Firmware Runtime Update
    documentation
  efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
    corresponding structures
  drivers/acpi: Introduce Platform Firmware Runtime Update device driver
  drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
  selftests/pfru: add test for Platform Firmware Runtime Update and
    Telemetry

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/pfru.rst                    | 100 +++
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfru/Kconfig                     |  29 +
 drivers/acpi/pfru/Makefile                    |   3 +
 drivers/acpi/pfru/pfru_telemetry.c            | 412 +++++++++++++
 drivers/acpi/pfru/pfru_update.c               | 567 ++++++++++++++++++
 include/linux/efi.h                           |  50 ++
 include/uapi/linux/pfru.h                     | 149 +++++
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/pfru/Makefile         |   7 +
 tools/testing/selftests/pfru/config           |   2 +
 tools/testing/selftests/pfru/pfru_test.c      | 328 ++++++++++
 15 files changed, 1652 insertions(+)
 create mode 100644 Documentation/x86/pfru.rst
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_telemetry.c
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h
 create mode 100644 tools/testing/selftests/pfru/Makefile
 create mode 100644 tools/testing/selftests/pfru/config
 create mode 100644 tools/testing/selftests/pfru/pfru_test.c

-- 
2.25.1

