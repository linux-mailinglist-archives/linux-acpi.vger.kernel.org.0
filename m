Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A66B839C31B
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhFDWCs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:18462 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230227AbhFDWCq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:46 -0400
IronPort-SDR: L3Vsm1csd8puZh/1SVesvympWctxl0Gc+SsXkaPtWtlOtrL7PDnXhcjBiVKcLurtRugREAMxLu
 p3+QzRAQwzmw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184060106"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="184060106"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:56 -0700
IronPort-SDR: kOih0kN7SZ1MsEBc4gYDG5iTUl/Wt7zzFxdug2r5RsrNk+ydFx79Ds9N6HBsX4B1CDZ9f9F1g+
 XV5aVbDJnTew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146728"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 10/14] ACPICA: Add defines for the CXL Host Bridge Structure (CHBS)
Date:   Fri,  4 Jun 2021 14:26:04 -0700
Message-Id: <20210604212608.2604267-11-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Alison Schofield <alison.schofield@intel.com>

ACPICA commit 5ace82441a34f8d45725f12f6bd2677e79c186a6

CXL 2.0 defines length and version field values for the CHBS.
Include them in the ACPI CEDT table definition.

Link: https://github.com/acpica/acpica/commit/5ace8244
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/actbl1.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index ce59903c2695..8532f56a51d6 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -330,6 +330,16 @@ enum acpi_cedt_type {
 	ACPI_CEDT_TYPE_RESERVED = 1
 };
 
+/* Values for version field above */
+
+#define ACPI_CEDT_CHBS_VERSION_CXL11    (0)
+#define ACPI_CEDT_CHBS_VERSION_CXL20    (1)
+
+/* Values for length field above */
+
+#define ACPI_CEDT_CHBS_LENGTH_CXL11     (0x2000)
+#define ACPI_CEDT_CHBS_LENGTH_CXL20     (0x10000)
+
 /*
  * CEDT subtables
  */
-- 
2.29.2

