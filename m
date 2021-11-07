Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389E44736F
	for <lists+linux-acpi@lfdr.de>; Sun,  7 Nov 2021 16:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhKGPSo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 10:18:44 -0500
Received: from mga17.intel.com ([192.55.52.151]:12866 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234773AbhKGPSo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 7 Nov 2021 10:18:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10160"; a="212848030"
X-IronPort-AV: E=Sophos;i="5.87,216,1631602800"; 
   d="scan'208";a="212848030"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2021 07:16:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,216,1631602800"; 
   d="scan'208";a="451169642"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.186])
  by orsmga006.jf.intel.com with ESMTP; 07 Nov 2021 07:15:57 -0800
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
Subject: [PATCH v9 0/4] Introduce Platform Firmware Runtime Update and Telemetry drivers
Date:   Sun,  7 Nov 2021 23:15:14 +0800
Message-Id: <cover.1636283832.git.yu.c.chen@intel.com>
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
be restarted. It also allows telemetry data to be retrieved from the
platform firmware.

=============
- Change from v8 to v9:
  - Use GUID_INIT() instead of guid_parse() during boot up.
    (Andy Shevchenko)
  - Drop uuid, code_uuid, drv_uuid in struct pfru_device as they
    are not needed. (Andy Shevchenko)
  - Drop type casting from void * in valid_version().
    (Andy Shevchenko)
  - Use kfree() instead of ACPI_FREE() in non-ACPICA usage.
    (Andy Shevchenko)
  - Use sizeof(rev) instead of sizeof(u32) in copy_from_user().
    (Andy Shevchenko)
  - Generate physical address from MSB part to LSB.
    (Andy Shevchenko)
  - Use devm_add_action_or_reset() to add ida release into dev resource
    management. (Andy Shevchenko)
  - Use devm_kasprintf() instead of kasprintf() to format the
    pfru_dev name.(Andy Shevchenko)
  - Remove redundant 0 in acpi_pfru_ids. (Andy Shevchenko)
  - Adjust the order of included headers in pfru.h.
    (Andy Shevchenko)
  - Replace PFRU_MAGIC with PFRU_MAGIC_FOR_IOCTL in uapi file.
    (Andy Shevchenko)
    Use devm_kasprintf() instead of kasprintf() to format the
    pfru_log_dev name.(Andy Shevchenko)
    Remove redundant 0 in acpi_pfru_log_ids. (Andy Shevchenko)
- Change from v7 to v8:
  - Remove the variable-length array in struct pfru_update_cap_info, and
    copy the non-variable-length struct pfru_update_cap_info to userspace
    directly. (Greg Kroah-Hartman)
  - Use efi_guid_t instead of guid_t when parsing capsule file.
    (Andy Shevchenko)
  - Change the type of rev_id from int to u32, because this data will
    be copied between kernel and userspace. (Greg Kroah-Hartman)
  - Add a prefix for dev in struct pfru_device to parent_dev, so as
    to indicate that this filed is the parent of the created miscdev.
    (Greg Kroah-Hartman)
  - Use blank lines between different macro sections. (Greg Kroah-Hartman)
    Illusatrate the possible errno for each ioctl interface.
    (Greg Kroah-Hartman)
  - Remove pfru_valid_revid() from uapi header to avoid poluting the global
    namespace.(Greg Kroah-Hartman)
  - Assign the value to the enum type explicitly.(Greg Kroah-Hartman)
  - Change the guid_t to efi_guid_t when parsing image header in get_image_type()
    (Greg Kroah-Hartman)
  - Remove the void * to other type casting in valid_version(). (Andy Shevchenko)
  - Combined the assignment of variables with definitions. (Andy Shevchenko)
  - Define this magic for revision ID. (Andy Shevchenko)
  - Make the labeling consistent for error handling. (Andy Shevchenko)
  - Replace the UUID_SIZE in uapi with 16 directly. (Andy Shevchenko)
  - Add blank line between generic include header and uapi header.
    (Andy Shevchenko)
  - Arrange the order between devm_kzalloc() and normal allocation in
    acpi_pfru_probe() that, the former should always be ahead of the
    latter. (Andy Shevchenko)
- Change from v6 to v7:
  - Use __packed instead of pragma pack(1).
    (Greg Kroah-Hartman, Ard Biesheuve)
  - Use ida_alloc() to allocate a ID, and release the ID when
    device is removed. (Greg Kroah-Hartman)
  - Check the _DSM method at early stage, before allocate or parse
    anything in acpi_pfru_[log_]probe(). (Greg Kroah-Hartman)
  - Set the parent of the misc device. (Greg Kroah-Hartman)
  - Use module_platform_driver() instead of platform_driver_register()
    in module_init(). Separate pfru driver and pfru_telemetry driver
    to two files. (Greg Kroah-Hartman) 
- Change from v5 to v6:
  - Use Link: tag to add the specification download address.
    (Andy Shevchenko)
  - Drop comma for each terminator entry in the enum structure.
    (Andy Shevchenko)
  - Remove redundant 'else' in get_image_type().
    (Andy Shevchenko)
  - Directly return results from the switch cases in adjust_efi_size()
    and pfru_ioctl().(Andy Shevchenko)
  - Keep comment style consistency by removing the period for
    one line comment.
    (Andy Shevchenko)
  - Remove devm_kfree() if .probe() failed. 
    (Andy Shevchenko)
  - Remove linux/uuid.h and use raw buffers to contain uuid.
    (Andy Shevchenko)
  - Include types.h in pfru.h. (Andy Shevchenko)
  - Use __u8[16] instead of uuid_t. (Andy Shevchenko)
  - Replace enum in pfru.h with __u32 as enum size is not the
    same size on all possible architectures.
    (Andy Shevchenko)
  - Simplify the userspace tool to use while loop for getopt_long().
    (Andy Shevchenko)
- Change from v4 to v5:
  - Remove Documentation/ABI/pfru, and move the content to kernel doc
    in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
  - Shrink the range of ioctl numbers declared in
    Documentation/userspace-api/ioctl/ioctl-number.rst
    from 16 to 8. (Greg Kroah-Hartman)
  - Change global variable struct pfru_device *pfru_dev to
    per PFRU device. (Greg Kroah-Hartman)
  - Unregister the misc device in acpi_pfru_remove().
    (Greg Kroah-Hartman)
  - Convert the kzalloc() to devm_kzalloc() in the driver so
    as to avoid freeing the memory. (Greg Kroah-Hartman)
  - Fix the compile warning by declaring the pfru_log_ioctl() as
    static. (kernel test robot LKP)
  - Change to global variable misc_device to per PFRU device.
    (Greg Kroah-Hartman)
  - Remove the telemetry output in commit log. (Greg Kroah-Hartman)
  - Add link for corresponding userspace tool in the commit log.
    (Greg Kroah-Hartman)
  - Replace the telemetry .read() with .mmap() so that the userspace
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
  tools: Introduce power/acpi/tools/pfru

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 drivers/acpi/Kconfig                          |   1 +
 drivers/acpi/Makefile                         |   1 +
 drivers/acpi/pfru/Kconfig                     |  13 +
 drivers/acpi/pfru/Makefile                    |   2 +
 drivers/acpi/pfru/pfru_telemetry.c            | 458 ++++++++++++++
 drivers/acpi/pfru/pfru_update.c               | 598 ++++++++++++++++++
 include/linux/efi.h                           |  46 ++
 include/uapi/linux/pfru.h                     | 262 ++++++++
 tools/power/acpi/.gitignore                   |   1 +
 tools/power/acpi/Makefile                     |  16 +-
 tools/power/acpi/Makefile.rules               |   2 +-
 tools/power/acpi/man/pfru.8                   | 137 ++++
 tools/power/acpi/tools/pfru/Makefile          |  23 +
 tools/power/acpi/tools/pfru/pfru.c            | 417 ++++++++++++
 15 files changed, 1969 insertions(+), 9 deletions(-)
 create mode 100644 drivers/acpi/pfru/Kconfig
 create mode 100644 drivers/acpi/pfru/Makefile
 create mode 100644 drivers/acpi/pfru/pfru_telemetry.c
 create mode 100644 drivers/acpi/pfru/pfru_update.c
 create mode 100644 include/uapi/linux/pfru.h
 create mode 100644 tools/power/acpi/man/pfru.8
 create mode 100644 tools/power/acpi/tools/pfru/Makefile
 create mode 100644 tools/power/acpi/tools/pfru/pfru.c

-- 
2.25.1

