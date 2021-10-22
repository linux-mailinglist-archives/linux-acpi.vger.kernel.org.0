Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8B437B82
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Oct 2021 19:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhJVRMT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Oct 2021 13:12:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:62689 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233676AbhJVRMT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Oct 2021 13:12:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216511656"
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="216511656"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2021 10:09:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,173,1631602800"; 
   d="scan'208";a="495758000"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by orsmga008.jf.intel.com with ESMTP; 22 Oct 2021 10:09:52 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/4] Introduce Platform Firmware Runtime Update and Telemetry drivers
Date:   Sat, 23 Oct 2021 01:09:13 +0800
Message-Id: <cover.1634899519.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The PFRU (Platform Firmware Runtime Update) kernel interface is designed
to interact with the platform firmware interface defined in the
`Management Mode Firmware Runtime Update
<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf>`
specification. The primary function of PFRU is to carry out runtime
updates of the platform firmware, which doesn't require the system to
be restarted.  It also allows telemetry data to be retrieved from the
platform firmware.

=============
- Change from v4 to v5:
  - Remove Documentation/ABI/pfru, and move the content to kernel doc
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
    Shrink the range of ioctl numbers declared in
    Documentation/userspace-api/ioctl/ioctl-number.rst
    from 16 to 8. (Greg Kroah-Hartman)
    Change global variable struct pfru_device *pfru_dev to
    per PFRU device. (Greg Kroah-Hartman)
    Unregister the misc device in acpi_pfru_remove().
    (Greg Kroah-Hartman)
    Convert the kzalloc() to devm_kzalloc() in the driver so
    as to avoid freeing the memory. (Greg Kroah-Hartman)
    Fix the compile warning by declaring the pfru_log_ioctl() as
    static. (kernel test robot LKP)
    Change to global variable misc_device to per PFRU device.
    (Greg Kroah-Hartman)
    Remove the telemetry output in commit log. (Greg Kroah-Hartman)
    Add link for corresponding userspace tool in the commit log.
    (Greg Kroah-Hartman)
    Replace the telemetry .read() with .mmap() so that the userspace
    could mmap once, and read multiple times. (Greg Kroah-Hartman)
- Change from v3 to v4:
  - Add Documentation/ABI/testing/pfru to document the ABI and
    remove Documentation/x86/pfru.rst (Rafael J. Wysocki)
  - Replace all pr_err() with dev_dbg() (Greg Kroah-Hartman,
    Rafael J. Wysocki)
  - returns ENOTTY rather than ENOIOCTLCMD if invalid ioctl command
    is provided. (Greg Kroah-Hartman)
  - Remove compat ioctl. (Greg Kroah-Hartman)
  - Rename /dev/pfru/pfru_update to /dev/acpi_pfru (Greg Kroah-Hartman)
  - Simplify the check for element of the package in query_capability()
    (Rafael J. Wysocki)
  - Remove the loop in query_capability(), query_buffer() and query
    the package elemenet directly. (Rafael J. Wysocki)
  - Check the number of elements in case the number of package
    elements is too small. (Rafael J. Wysocki)
  - Doing the assignment as initialization in get_image_type().
    Meanwhile, returns the type or a negative error code in
    get_image_type(). (Rafael J. Wysocki)
  - Put the comments inside the function. (Rafael J. Wysocki)
  - Returns the size or a negative error code in adjust_efi_size()
    (Rafael J. Wysocki)
  - Fix the return value from EFAULT to EINVAL if pfru_valid_revid()
    does not pass. (Rafael J. Wysocki)
  - Change the write() to be the code injection/update, the read() to
    be telemetry retrieval and all of the rest to be ioctl()s under
    one special device file.(Rafael J. Wysocki)
  - Remove redundant parens. (Rafael J. Wysocki)
  - Putting empty code lines after an if () statement that is not
    followed by a block. (Rafael J. Wysocki)
  - Remove "goto" tags to make the code more readable. (Rafael J. Wysocki)
- Change from v2 to v3:
  - Use valid types for structures that cross the user/kernel boundary
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

Chen Yu (4):
  efi: Introduce EFI_FIRMWARE_MANAGEMENT_CAPSULE_HEADER and
    corresponding structures
  drivers/acpi: Introduce Platform Firmware Runtime Update device driver
  drivers/acpi: Introduce Platform Firmware Runtime Update Telemetry
  tools: Introduce power/acpi/pfru/pfru

 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 drivers/acpi/Kconfig                          |    1 +
 drivers/acpi/Makefile                         |    1 +
 drivers/acpi/pfru/Kconfig                     |   16 +
 drivers/acpi/pfru/Makefile                    |    2 +
 drivers/acpi/pfru/pfru_update.c               | 1010 +++++++++++++++++
 include/linux/efi.h                           |   50 +
 include/uapi/linux/pfru.h                     |  283 +++++
 tools/power/acpi/pfru/Makefile                |   25 +
 tools/power/acpi/pfru/pfru.8                  |  137 +++
 tools/power/acpi/pfru/pfru.c                  |  407 +++++++
 11 files changed, 1933 insertions(+)
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h
 create mode 100644 tools/power/acpi/pfru/Makefile
 create mode 100644 tools/power/acpi/pfru/pfru.8
 create mode 100644 tools/power/acpi/pfru/pfru.c

-- 
2.25.1

