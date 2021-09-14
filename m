Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AB940A744
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 09:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbhINHXt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 03:23:49 -0400
Received: from mga17.intel.com ([192.55.52.151]:36496 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239423AbhINHXp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 03:23:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="202084496"
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="202084496"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 00:22:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,292,1624345200"; 
   d="scan'208";a="451919968"
Received: from chenyu-desktop.sh.intel.com ([10.239.158.176])
  by orsmga002.jf.intel.com with ESMTP; 14 Sep 2021 00:22:21 -0700
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
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: [PATCH v2 1/5] Documentation: Introduce Platform Firmware Runtime Update documentation
Date:   Tue, 14 Sep 2021 15:28:00 +0800
Message-Id: <8c182383300b043195bc00a293dfd5b2fad59772.1631600169.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1631600169.git.yu.c.chen@intel.com>
References: <cover.1631600169.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add the Platform Firmware Runtime Update/Telemetry documentation.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: Add a spot in index.rst so it becomes part of the docs build
    (Jonathan Corbet).
    Sticking to the 80-column limit(Jonathan Corbet).
    Underline lengths should match the title text(Jonathan Corbet).
    Use literal blocks for the code samples(Jonathan Corbet).
---
 Documentation/x86/index.rst |   1 +
 Documentation/x86/pfru.rst  | 100 ++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/x86/pfru.rst

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 383048396336..3791fabf964c 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -37,3 +37,4 @@ x86-specific Documentation
    sgx
    features
    elf_auxvec
+   pfru
diff --git a/Documentation/x86/pfru.rst b/Documentation/x86/pfru.rst
new file mode 100644
index 000000000000..29fe0e518e6d
--- /dev/null
+++ b/Documentation/x86/pfru.rst
@@ -0,0 +1,100 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================================
+The Linux Platform Firmware Runtime Update and Telemetry
+========================================================
+
+According to the specification of `Management Mode Firmware Runtime Update
+<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_
+Rev100.pdf>`_, certain computing systems require high Service Level Agreements
+(SLAs) where system reboot fewer firmware updates are required to deploy
+firmware changes to address bug fixes, security updates and to debug and root
+cause issues. This technology is called Intel Seamless Update. The management
+mode (MM), UEFI runtime services and ACPI services handle most of the system
+runtime functions. Changing the MM code execution during runtime is called MM
+Runtime Update. Since the "MM" acronyms might be misunderstood as "Memory
+Management", this driver uses the name of "Platform Firmware Runtime Update"
+(PFRU).
+
+PFRU provides the following facilities: Performs a runtime firmware driver
+update and activate. Ability to inject firmware code at runtime, for dynamic
+instrumentation. PFRU Telemetry is a service which allows Runtime Update
+handler to produce telemetry data to upper layer OS consumer at runtime. The
+OS provides interfaces to let the users query the telemetry data via read
+operations. The specification specifies the interface and recommended policy
+to extract the data, the format and use are left to individual OEM's and BIOS
+implementations on what that data represents.
+
+PFRU interfaces
+===============
+
+The user space tool manipulates on /dev/pfru/update for code injection and
+driver update. PFRU stands for Platform Firmware Runtime Update, and the
+/dev/pfru directory might be reserved for future usage::
+
+ 1. mmap the capsule file.
+    fd_capsule = open("capsule.cap", O_RDONLY);
+    fstat(fd_capsule, &stat);
+    addr = mmap(0, stat.st_size, PROT_READ, fd_capsule);
+
+ 2. Get the capability information(version control, etc) from BIOS via
+    read() and do sanity check in user space.
+    fd_update = open("/dev/pfru/update", O_RDWR);
+    read(fd_update, &cap, sizeof(cap));
+    sanity_check(&cap);
+
+ 3. Write the capsule file to runtime update communication buffer.
+    kernel might return error if capsule file size is longer than
+    communication buffer.
+    write(fd_update, addr, stat.st_size);
+
+ 4. Stage the code injection.
+    ioctl(fd_update, PFRU_IOC_STATGE);
+
+ 5. Activate the code injection.
+    ioctl(fd_update, PFRU_IOC_ACTIVATE);
+
+ 6. Stage and activate the code injection.
+    ioctl(fd_update, PFRU_IOC_STAGE_ACTIVATE);
+
+    PFRU_IOC_STATGE: Stage a capsule image from communication buffer
+    and perform authentication.
+    [PFRU_IOC_ACTIVATE] Activate a previous staged capsule image.
+    [PFRU_IOC_STAGE_ACTIVATE] Perform both stage and activation actions.
+
+
+PFRU Telemetry interfaces
+=========================
+
+The user space tool manipulates on /dev/pfru/telemetry for PFRU telemetry log::
+
+ 1. Open telemetry device
+    fd_log = open("/dev/pfru/telemetry", O_RDWR);
+
+ 2. Get log level, log type, revision_id via one ioctl invoke
+    ioctl(fd_log, PFRU_IOC_GET_LOG_INFO, &info);
+
+ 3. Set log level, log type, revision_id
+    ioctl(fd_log, PFRU_IOC_SET_LOG_INFO, &info);
+
+ 4. ioctl(fd_log, PFRU_IOC_GET_DATA_INFO, &data_info);
+    Query the information of PFRU telemetry log buffer. The user is
+    responsible for parsing the result per the specification.
+
+ 5. Read the telemetry data:
+    read(fd_log, buf, data_info.size);
+
+Please refer to tools/testing/selftests/pfru/pfru_test.c for detail.
+
+According to the specification of `Management Mode Firmware Runtime Update
+<https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_
+Rev100.pdf>`_, the telemetry buffer is a wrap around buffer. If the telemetry
+buffer gets full, most recent log data will overwrite old log data. Besides,
+it is required in the spec that the read of telemetry should support both full
+data retrieval and delta telemetry data retrieval. Since this requirement is
+more likely a policy we leave this implementation in user space. That is to
+say, it is recommended for the user to double-read the telemetry parameters
+such as chunk1_size, chunk2_size, rollover_cnt in data_info structure to make
+sure that there is no more data appended while the user is reading the buffer.
+Besides, only after the runtime update has been run at least once, the telemetry
+log would have valid data, otherwise errno code of EBUSY would be returned.
-- 
2.25.1

