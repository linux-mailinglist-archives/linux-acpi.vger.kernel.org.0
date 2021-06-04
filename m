Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8039C321
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Jun 2021 00:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhFDWCt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 18:02:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:62960 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231365AbhFDWCr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 18:02:47 -0400
IronPort-SDR: 7YYU4YEojnb3UZ/WEzyYy/LOPEIM+w2ipYTcT4OHSwMu4OVRNLCY+zO/d3CbOgFdDaNOURzsZX
 3aVFvTzZQnCw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="265539947"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="265539947"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 15:00:56 -0700
IronPort-SDR: V4tVm4USqr++/9lRx5nBvPiqGAxLOufcMStwKnAZpbBkWJwLETOhKAdz0ODvUroJWATbzhYziD
 juAYC4Jwskkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="634146716"
Received: from sibelius.jf.intel.com ([10.54.75.166])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 15:00:55 -0700
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc:     Wei Ming Chen <jj251510319013@gmail.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Subject: [PATCH 07/14] ACPICA: Use ACPI_FALLTHROUGH
Date:   Fri,  4 Jun 2021 14:26:01 -0700
Message-Id: <20210604212608.2604267-8-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210604212608.2604267-1-erik.kaneda@intel.com>
References: <20210604212608.2604267-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Wei Ming Chen <jj251510319013@gmail.com>

ACPICA commit 2296edd39b4ce2d2dd691c1f309c4da00843ecc9

Replace /* FALLTHROUGH */ comment with ACPI_FALLTHROUGH

Link: https://github.com/acpica/acpica/commit/2296edd3
Signed-off-by: Wei Ming Chen <jj251510319013@gmail.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
---
 drivers/acpi/acpica/utprint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index e37d612e8db5..05426596d1f4 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -475,7 +475,7 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 		case 'X':
 
 			type |= ACPI_FORMAT_UPPER;
-			/* FALLTHROUGH */
+			ACPI_FALLTHROUGH;
 
 		case 'x':
 
-- 
2.29.2

