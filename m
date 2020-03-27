Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1DE0196164
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgC0WnM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727729AbgC0WnM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:12 -0400
IronPort-SDR: YYogQBXvRGRRsLFu5mVi/ldXIGyTq3exIIpv9OIcv4HYclbZl/7gbDYiJIE1t5k00VEqCQ4VRj
 pdKxV+5kNJxQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:12 -0700
IronPort-SDR: jlVZ53caVBqQ/5rXXhZoCB566OkbR64B2xfEOkvN6lsEnV0h3flXpFGsc9XE7VCXvT3Jd2sgYW
 1GDqlroBGj5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051968"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:11 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     =?UTF-8?q?Micha=C5=82=20=C5=BBygowski?= <michal.zygowski@3mdeb.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 03/10] ACPICA: Fix IVRS IVHD type 10h reserved field name
Date:   Fri, 27 Mar 2020 15:21:03 -0700
Message-Id: <20200327222110.1204634-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Michał Żygowski <michal.zygowski@3mdeb.com>

ACPICA commit 87a1ab2b2a63e28776261c48bdbae345f790d05d

According to AMD IOMMU Specification Revision 3.05 the reserved field
should be IOMMU Feature Reporting. Change the name of the field to the
correct one.

Link: https://github.com/acpica/acpica/commit/87a1ab2b
Signed-off-by: Michał Żygowski <michal.zygowski@3mdeb.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 93323aeddc5a..2175b3f84f02 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -308,7 +308,7 @@ struct acpi_ivrs_hardware_10 {
 	u64 base_address;	/* IOMMU control registers */
 	u16 pci_segment_group;
 	u16 info;		/* MSI number and unit ID */
-	u32 reserved;
+	u32 feature_reporting;
 };
 
 /* 0x11: I/O Virtualization Hardware Definition Block (IVHD) */
-- 
2.25.1

