Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60A336E22A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Apr 2021 01:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhD1X2X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Apr 2021 19:28:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:56096 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhD1X2W (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Apr 2021 19:28:22 -0400
IronPort-SDR: ubJs5szqey04z/fGxNYdyyuJlRh1FQAXa4vCQSCbiIaE2NSJtr4RmKEDM4TPhxlR7M1gAgzJl4
 7fg7mxQ7SC2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="282215241"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="282215241"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 16:27:37 -0700
IronPort-SDR: EKrsUp3cVtERmCcKqKi6oJi4NvEYdJf5sM1YYpnApdEQ1IHFk5mXZI5Tw+wtppHXXy5ZTpUjgT
 0W9VxBEEnGoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="466120973"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by orsmga001.jf.intel.com with ESMTP; 28 Apr 2021 16:27:36 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Gordon Ross <gordon.w.ross@gmail.com>
Cc:     Moore@vger.kernel.org, Robert <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [RFT PATCH] ACPICA: Fix memory leak caused by _CID repair function
Date:   Wed, 28 Apr 2021 15:52:47 -0700
Message-Id: <20210428225247.1701392-1-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 5fc4f4b87d6890d48d050ab279ed01f0132662ca

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

Link: https://github.com/acpica/acpica/commit/5fc4f4b8

Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
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

