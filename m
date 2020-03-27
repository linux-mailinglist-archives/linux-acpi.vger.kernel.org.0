Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65793196166
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 23:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgC0WnN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 27 Mar 2020 18:43:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:52441 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgC0WnN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 27 Mar 2020 18:43:13 -0400
IronPort-SDR: KgwRsrTrUVV6jLnywDwERy1pHxjszm1aktIWlmKiwQOIZ/S2TRqwJdUDJCMJxcGCuq7/4J9guq
 VPJgiAYAxR4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 15:43:12 -0700
IronPort-SDR: RwrZBSuGXdkIsVpivyBYWUzqiD4FKeEQ+sp3SzgNjXNKqYLeqwDcaNi0IKjulCZyxcBUlyIaCP
 27WO6kKPAGsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,314,1580803200"; 
   d="scan'208";a="294051979"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Mar 2020 15:43:11 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     John Levon <john.levon@joyent.com>,
        MSathieu <18145111+MSathieu@users.noreply.github.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 06/10] ACPICA: utilities: fix sprintf()
Date:   Fri, 27 Mar 2020 15:21:06 -0700
Message-Id: <20200327222110.1204634-7-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327222110.1204634-1-erik.kaneda@intel.com>
References: <20200327222110.1204634-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: John Levon <john.levon@joyent.com>

This commit contains changes for the following commit ID's:
8f99a6ccd3b8e5c3d3d68c53fdbb054c2477eeb4
d30647af53abd334cbcf6362387464ea647bac9e
d3c5fb4cf5b2880d789c987eb847fc3de3774abc

On 32-bit, the provided sprintf() is non-functional: with a size of
ACPI_UINT32_MAX, String + Size will wrap, meaning End < Start, and
acpi_ut_bound_string_output() will never output anything as a result.

The symptom we saw of this was acpixtract failing to output anything.

Link: https://github.com/acpica/acpica/commit/8f99a6cc
Link: https://github.com/acpica/acpica/commit/d30647af
Link: https://github.com/acpica/acpica/commit/d3c5fb4c
Signed-off-by: MSathieu <18145111+MSathieu@users.noreply.github.com>
Signed-off-by: John Levon <john.levon@joyent.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/utprint.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index a874dac7db5c..681c11f4af4e 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -332,7 +332,12 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 	int i;
 
 	pos = string;
-	end = string + size;
+
+	if (size != ACPI_UINT32_MAX) {
+		end = string + size;
+	} else {
+		end = ACPI_CAST_PTR(char, ACPI_UINT32_MAX);
+	}
 
 	for (; *format; ++format) {
 		if (*format != '%') {
-- 
2.25.1

