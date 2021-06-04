Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC8539C31D
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbhFDWCs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:62965 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231199AbhFDWCq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:46 -0400
IronPort-SDR: QbM7DMNjnnRDWjm0SCgsWaz3QmwV86uFrqE8XuwiEr7pTlnlqJHHj9kgQP0RFk5Qcg/QTIgVDA
 GGOj06flFM5g==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539943"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539943"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:55 -0700
IronPort-SDR: ejh6YQ5phmyKeAhM94xK0Sppxm4OQNweM3Mb4vyK3NFnSXE/2w6jP6k6LO78LdDtNsTyrhsh+c
 8KEKHM4SKK6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146703"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 03/14] ACPICA: Fix memory leak caused by _CID repair function
Date:   Fri,  4 Jun 2021 14:25:57 -0700
Message-Id: <20210604212608.2604267-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 180cb53963aa876c782a6f52cc155d951b26051a

According to the ACPI spec, _CID returns a package containing
hardware ID's. Each element of an ASL package contains a reference
count from the parent package as well as the element itself.

Name (TEST, Package() {
    "String object" // this package element has a reference count of 2
})

A memory leak was caused in the _CID repair function because it did
not decrement the reference count created by the package. Fix the
memory leak by calling acpi_ut_remove_reference on _CID package elements
that represent a hardware ID (_HID).

Link: https://github.com/acpica/acpica/commit/180cb539
Tested-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsrepair2.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsrepair2.c b/drivers/acpi/acpica/nsrepair2.c
index 14b71b41e845..38e10ab976e6 100644
--- a/drivers/acpi/acpica/nsrepair2.c
+++ b/drivers/acpi/acpica/nsrepair2.c
@@ -379,6 +379,13 @@ acpi_ns_repair_CID(struct acpi_evaluate_info *info,
 
 			(*element_ptr)->common.reference_count =
 			    original_ref_count;
+
+			/*
+			 * The original_element holds a reference from the package object
+			 * that represents _HID. Since a new element was created by _HID,
+			 * remove the reference from the _CID package.
+			 */
+			acpi_ut_remove_reference(original_element);
 		}
 
 		element_ptr++;
-- 
2.29.2

