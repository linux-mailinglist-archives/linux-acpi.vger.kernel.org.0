Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430BF39C31E
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhFDWCt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:62960 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231263AbhFDWCq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:46 -0400
IronPort-SDR: Wn3RmQ1gXCwazYajhypgJO5in4yFJANQ3SXPvY3exfVlvNV+zLS374bT5Bd8NooKvtRK0/l6o5
 YCOx4YhY3x9g==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539944"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539944"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:55 -0700
IronPort-SDR: Yn2kWrOV5eRMLid3o+am3Yh0VU4a8EmYQgOVx2kDAs3DjpHDU7+X4cZhkf3ZhlVBvcH+9PodtV
 fPTPzJ3yWeGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146707"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 04/14] ACPICA: iASL: Finish support for the IVRS ACPI table
Date:   Fri,  4 Jun 2021 14:25:58 -0700
Message-Id: <20210604212608.2604267-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

1) Add compiler support for IVRS.
2) Update disassembler support for IVRS.
3) Add a new utility, ut_is_id_integer to determine if a HID/CID is
   an integer or a string.

ACPICA commit 7eb0b770cb0efcf089cb217b5f8bafc0c6395a3d

Link: https://github.com/acpica/acpica/commit/7eb0b770
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index d8fec67e4c8c..42c78fecca7c 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -447,6 +447,12 @@ struct acpi_ivrs_device_hid {
 	u8 uid_length;
 };
 
+/* Values for uid_type above */
+
+#define ACPI_IVRS_UID_NOT_PRESENT   0
+#define ACPI_IVRS_UID_IS_INTEGER    1
+#define ACPI_IVRS_UID_IS_STRING     2
+
 /* 0x20, 0x21, 0x22: I/O Virtualization Memory Definition Block (IVMD) */
 
 struct acpi_ivrs_memory {
-- 
2.29.2

