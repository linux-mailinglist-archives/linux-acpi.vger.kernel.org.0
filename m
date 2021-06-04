Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D854E39C324
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFDWCw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:62958 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231384AbhFDWCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:47 -0400
IronPort-SDR: lJbsPhk101VMfQCHJt7wsAKRseTcHXIXcQE9ZqMsvAkBNqNzG8a+QuR4PbcYJ6w+0ALjrpgwrn
 W4p3AdFnLUBw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539948"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539948"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:56 -0700
IronPort-SDR: Gieryd6BJJrUakb3ebE4ADEzyC0V3P1iyBeuNUHMistNpQYPLG4jtVaGwPENHlHct11pJRxP7O
 6vvWS1WkTr0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146721"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:56 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>,
        Daniel Scally <djrscally@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 08/14] ACPICA: Add _PLD panel positions
Date:   Fri,  4 Jun 2021 14:26:02 -0700
Message-Id: <20210604212608.2604267-9-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Fabian Wüthrich <me@fabwu.ch>

ACPICA commit 1d36b551fa6749e650da1dfd3e809146e6ac6a2e

The ACPI specification v6.3 defines the panel positions in chapter 6.1.8
"_PLD (Physical Location of Device)"

Link: https://github.com/acpica/acpica/commit/1d36b551
Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acbuffer.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 18197c16149f..3e8d969b22fe 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -207,4 +207,14 @@ struct acpi_pld_info {
 #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
 #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)	/* Offset 128+16=144, Len 16 */
 
+/* Panel position defined in _PLD section of ACPI Specification 6.3 */
+
+#define ACPI_PLD_PANEL_TOP      0
+#define ACPI_PLD_PANEL_BOTTOM   1
+#define ACPI_PLD_PANEL_LEFT     2
+#define ACPI_PLD_PANEL_RIGHT    3
+#define ACPI_PLD_PANEL_FRONT    4
+#define ACPI_PLD_PANEL_BACK     5
+#define ACPI_PLD_PANEL_UNKNOWN  6
+
 #endif				/* ACBUFFER_H */
-- 
2.29.2

