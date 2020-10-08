Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96A286D1C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 05:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgJHDWA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Oct 2020 23:22:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:29850 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727449AbgJHDV6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Oct 2020 23:21:58 -0400
IronPort-SDR: BK6nRqR1a9eNKNdCxDY0GtJISHyJJJmJi9rVx0Be6I0iV/2n/LQLspi8fl8pNp85ld41weCt6O
 o4iuVBE0zuuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="162613632"
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="162613632"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 20:21:58 -0700
IronPort-SDR: mYhaNxdlx+KkZQXu14rV2p9U8jnWBDPR/p6qQwsaHt8mVV0hgn6x0oSE/8A9Diu59lvB3nXEfV
 H/DESAbFnC6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,349,1596524400"; 
   d="scan'208";a="355229326"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 20:21:58 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 1/9] ACPICA: Add support for 64 bit risc-v compilation.
Date:   Wed,  7 Oct 2020 19:53:55 -0700
Message-Id: <20201008025403.2401736-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201008025403.2401736-1-erik.kaneda@intel.com>
References: <20201008025403.2401736-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 0def627be286620c64a5d4d60ce2373f119169a9

Add 64 bit risc-v architecture.  Useful for acpica tools and
incorporating ACPICA into the Firmware Test Suite.

Link: https://github.com/acpica/acpica/commit/0def627b
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/platform/aclinux.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 4151c76141fa..72f52a1342a0 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -194,7 +194,8 @@
 
 #if defined(__ia64__)    || (defined(__x86_64__) && !defined(__ILP32__)) ||\
 	defined(__aarch64__) || defined(__PPC64__) ||\
-	defined(__s390x__)
+	defined(__s390x__) ||\
+	(defined(__riscv) && (defined(__LP64__) || defined(_LP64)))
 #define ACPI_MACHINE_WIDTH          64
 #define COMPILER_DEPENDENT_INT64    long
 #define COMPILER_DEPENDENT_UINT64   unsigned long
-- 
2.25.1

