Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C1D1C4B41
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 03:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgEEBIh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 May 2020 21:08:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:50714 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgEEBIg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 May 2020 21:08:36 -0400
IronPort-SDR: QjGlxs4bvN+H9BBmB6oiOJBQAdTKx88pcD5XlaAH6ctFKDh0I9XnvrsQw7EeshWbYCXauFhMtM
 nvqSAgVze2/w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:08:35 -0700
IronPort-SDR: z15S8BQT2z/AoW6A49bzYHEKIoy6H150LdSpSFrJYY1QEuwjPZCPlRRCTf2NN9Ljy8/0613LL0
 FO0+oqDelnxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="460865787"
Received: from sibelius.jf.intel.com ([10.54.75.172])
  by fmsmga005.fm.intel.com with ESMTP; 04 May 2020 18:08:34 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Yue Haibing <yuehaibing@huawei.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 1/6] ACPICA: Make acpi_protocol_lengths static
Date:   Mon,  4 May 2020 17:46:49 -0700
Message-Id: <20200505004654.2870591-2-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200505004654.2870591-1-erik.kaneda@intel.com>
References: <20200505004654.2870591-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yue Haibing <yuehaibing@huawei.com>

ACPICA commit 0ebacf12b8ca66ce6d3fce4d349b3f2448da18cb

A linux-based static analyzer (sparse) caught this as a warning.
Making this variable static will result in better optimizations and
ensure that this variable does not get used outside of this file.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
[ek: commit message]

Link: https://github.com/acpica/acpica/commit/0ebacf12
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/exfield.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
index e85eb31e5075..3323a2ba6a31 100644
--- a/drivers/acpi/acpica/exfield.c
+++ b/drivers/acpi/acpica/exfield.c
@@ -22,7 +22,7 @@ ACPI_MODULE_NAME("exfield")
  */
 #define ACPI_INVALID_PROTOCOL_ID        0x80
 #define ACPI_MAX_PROTOCOL_ID            0x0F
-const u8 acpi_protocol_lengths[] = {
+static const u8 acpi_protocol_lengths[] = {
 	ACPI_INVALID_PROTOCOL_ID,	/* 0 - reserved */
 	ACPI_INVALID_PROTOCOL_ID,	/* 1 - reserved */
 	0x00,			/* 2 - ATTRIB_QUICK */
-- 
2.25.1

