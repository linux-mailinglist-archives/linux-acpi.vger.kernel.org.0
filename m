Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D06EF123608
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Dec 2019 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLQTzA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Dec 2019 14:55:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:56006 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727587AbfLQTzA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Dec 2019 14:55:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Dec 2019 11:55:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,326,1571727600"; 
   d="scan'208";a="217624417"
Received: from sibelius.jf.intel.com ([10.54.75.23])
  by orsmga006.jf.intel.com with ESMTP; 17 Dec 2019 11:54:59 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 3/5] ACPICA: acpisrc: add unix line ending support for non-windows build
Date:   Tue, 17 Dec 2019 11:35:21 -0800
Message-Id: <20191217193523.20204-4-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191217193523.20204-1-erik.kaneda@intel.com>
References: <20191217193523.20204-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 48ef9f7456f0a73d1d6023ea8e79442cdcff757f

Link: https://github.com/acpica/acpica/commit/48ef9f74
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 include/acpi/platform/acenv.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 35ab3f87cc29..94e89ad478f5 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -128,6 +128,17 @@
 #endif
 
 
+/*
+ * acpisrc CR\LF support
+ * Unix file line endings do not include the carriage return.
+ * If the acpisrc utility is being built using a microsoft compiler, it means
+ * that it will be running on a windows machine which means that the output is
+ * expected to have CR/LF newlines. If the acpisrc utility is built with
+ * anything else, it will likely run on a system with LF newlines. This flag
+ * tells the acpisrc utility that newlines will be in the LF format.
+ */
+#define ACPI_SRC_OS_LF_ONLY 0
+
 /*! [Begin] no source code translation */
 
 /******************************************************************************
-- 
2.21.0

