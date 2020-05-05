Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE61C4B44
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEEBIi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:40502 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgEEBIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:37 -0400
IronPort-SDR: OPvbQQT/0KdQcI92n789/53NvbQmlFI6pK0zsYqMxhNBRV9MPz9fb8psncLmf9lnpAN9x+BXIF
 D79mBITDO1Zg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:36 -0700
IronPort-SDR: XjNqaxG07zq2BzZam9t5zWiKGoqEBlQ7hHSjPiKqKitwV1vXeIb8Xx98Ku4kBulNq3pO0BNGRA
 xx+28bxxsZxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865804"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:35 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 6/6] ACPICA: Update version to 20200430
Date:   Mon,  4 May 2020 17:46:54 -0700
Message-Id: <20200505004654.2870591-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit c00a5cd99fa3fe6cd053a2a1a557e54b4fea26f7

Version 20200430.

Link: https://github.com/acpica/acpica/commit/c00a5cd9
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 49b519f36b69..1dc8d262035b 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20200326
+#define ACPI_CA_VERSION                 0x20200430
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.25.1

