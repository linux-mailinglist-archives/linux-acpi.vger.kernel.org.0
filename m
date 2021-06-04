Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465F339C31A
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhFDWCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:62960 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhFDWCp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:45 -0400
IronPort-SDR: XPli/shphUxf1Uc1/iruSWrezK33XNXYnxHwYG0Z0YhNcfFW7t2eLVx4lHx/hVIFVpcVm18KdO
 hoqoyKbhl8kg==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539940"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539940"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:55 -0700
IronPort-SDR: CHpZXvDPMI7YH5xj9pKYLtYnUeWCCYTgprxyHBXQkGWYv570lcjQpHcR/anBQoFheZHey5iXD5
 A+HstBjdjjaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146697"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:54 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 01/14] ACPICA: ACPI 6.4: MADT: add Multiprocessor Wakeup Mailbox Structure
Date:   Fri,  4 Jun 2021 14:25:55 -0700
Message-Id: <20210604212608.2604267-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

ACPICA commit f1ee04207a212f6c519441e7e25397649ebc4cea

Add Multiprocessor Wakeup Mailbox Structure definition. It is useful
in parsing MADT Wake table.

Link: https://github.com/acpica/acpica/commit/f1ee0420
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 18cafe3ebddc..3b6f45a2edc8 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -763,6 +763,20 @@ struct acpi_madt_multiproc_wakeup {
 	u64 base_address;
 };
 
+#define ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE	2032
+#define ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE	2048
+
+struct acpi_madt_multiproc_wakeup_mailbox {
+	u16 command;
+	u16 reserved;		/* reserved - must be zero */
+	u32 apic_id;
+	u64 wakeup_vector;
+	u8 reserved_os[ACPI_MULTIPROC_WAKEUP_MB_OS_SIZE];	/* reserved for OS use */
+	u8 reserved_firmware[ACPI_MULTIPROC_WAKEUP_MB_FIRMWARE_SIZE];	/* reserved for firmware use */
+};
+
+#define ACPI_MP_WAKE_COMMAND_WAKEUP    1
+
 /*
  * Common flags fields for MADT subtables
  */
-- 
2.29.2

