Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E2511EECF
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Dec 2019 00:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfLMXsv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 13 Dec 2019 18:48:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:56595 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbfLMXsv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 13 Dec 2019 18:48:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Dec 2019 15:48:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,311,1571727600"; 
   d="scan'208";a="388836441"
Received: from spandruv-mobl.jf.intel.com ([10.255.89.247])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2019 15:48:49 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, corbet@lwn.net, lenb@kernel.org,
        rui.zhang@intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 1/2] Documentation: ACPI: Documentation for Fan performance states
Date:   Fri, 13 Dec 2019 15:48:39 -0800
Message-Id: <20191213234840.9791-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191213234840.9791-1-srinivas.pandruvada@linux.intel.com>
References: <20191213234840.9791-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Added documentation for performance states information for the ACPI
Fan object.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../acpi/fan_performance_states.rst           | 65 +++++++++++++++++++
 Documentation/admin-guide/acpi/index.rst      |  1 +
 2 files changed, 66 insertions(+)
 create mode 100644 Documentation/admin-guide/acpi/fan_performance_states.rst

diff --git a/Documentation/admin-guide/acpi/fan_performance_states.rst b/Documentation/admin-guide/acpi/fan_performance_states.rst
new file mode 100644
index 000000000000..91f10738e158
--- /dev/null
+++ b/Documentation/admin-guide/acpi/fan_performance_states.rst
@@ -0,0 +1,65 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+ACPI Fan Performance States
+===========================
+
+When the optional object _FPS is present for ACPI devices PNP0C0B or INT3404,
+additional attributes are displayed under acpi device object. These attributes
+display information about each performance state.
+
+For more details about ACPI Fan _FPS please refer to the ACPI specification at:
+
+http://uefi.org/specifications
+
+Example display for INT3404 ACPI device folder::
+
+ $ ls -l /sys/bus/acpi/devices/INT3404:00/
+ total 0
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state0
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state1
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state10
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state11
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state2
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state3
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state4
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state5
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state6
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state7
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state8
+ -r--r--r-- 1 root root 4096 Dec 13 20:38 state9
+ -r--r--r-- 1 root root 4096 Dec 13 01:00 status
+ ...
+ ...
+
+In the above example, each of the state* attribute represent one performance
+state. Each performance state contains information about the properties of a
+state in the following format:
+
+control_percent:trip_point_index:speed_rpm:noise_level_mdb:power_mw
+
+For example::
+
+ $cat /sys/bus/acpi/devices/INT3404:00/state1
+ 25:0:3200:12500:1250
+
+Description of properties:
+
+* control_percent: Indicates the value to be used to set the fan speed to a
+specific level using the _FSL object. The value here is from 0-100 percent.
+
+* trip_point_index: The active cooling trip point number that corresponds to this
+performance state. The range is from 0-9.
+
+* speed_rpm: Indicates the speed of the fan in revolutions per minute.
+
+* noise_level_mdb: Indicates the audible noise emitted by the fan. By the
+specification the value represents the noise in 10ths of decibels. Here
+it is multiplied with 100 to present in milli-db, to avoid loss of
+precision.
+
+* power_mw: Indicates the power consumption in milliwatts.
+
+When the fields are not populated or invalid in the configuration,
+"not-defined" is displayed.
+
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index 4d13eeea1eca..71277689ad97 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -12,3 +12,4 @@ the Linux ACPI support.
    dsdt-override
    ssdt-overlays
    cppc_sysfs
+   fan_performance_states
-- 
2.17.2

