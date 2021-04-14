Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAD735EFA7
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Apr 2021 10:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348392AbhDNIbJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 14 Apr 2021 04:31:09 -0400
Received: from gusto.metanet.ch ([80.74.154.155]:57953 "EHLO gusto.metanet.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348354AbhDNIbI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 14 Apr 2021 04:31:08 -0400
Received: from localhost (localhost [127.0.0.1]) by gusto.metanet.ch (Postfix) with ESMTPSA id 68DF94F00E0C;
        Wed, 14 Apr 2021 10:30:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fabwu.ch; s=default;
        t=1618389039; bh=5SsTW1zu9Sed9K5FwzyQnWus7k+zjY5e1l+06+Ml/fE=;
        h=From:To:Subject;
        b=q0wkBhBQ3CifybgYqlONel1dhauSPeZkZZzZX1lIU2LNHYMxq7KrFbnKsToW8a6BB
         cl2jQCo/3WG+4BDfixWiQyk9aIOA8SiDCPUphRHapwmctwZcRlCnKD1pA+eVoSi8IZ
         pCg2MWqgZqIvPJU1QahIoq1oYhkGRXHRMgsnE4Hw=
Authentication-Results: gusto.metanet.ch;
        spf=pass (sender IP is 2001:67c:10ec:574f:8000::124) smtp.mailfrom=me@fabwu.ch smtp.helo=localhost
Received-SPF: pass (gusto.metanet.ch: connection is authenticated)
From:   =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
To:     linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Cc:     Jacopo Mondi <jacopo@jmondi.org>, Yong Zhi <yong.zhi@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Fabian=20W=C3=BCthrich?= <me@fabwu.ch>
Subject: [PATCH v3 1/2] ACPI: Add _PLD panel positions
Date:   Wed, 14 Apr 2021 10:30:21 +0200
Message-Id: <20210414083022.25453-2-me@fabwu.ch>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414083022.25453-1-me@fabwu.ch>
References: <20210413063435.18111-1-me@fabwu.ch>
 <20210414083022.25453-1-me@fabwu.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI specification v6.3 defines the panel positions in chapter 6.1.8
"_PLD (Physical Location of Device)"

Signed-off-by: Fabian Wüthrich <me@fabwu.ch>
Reviewed-by: Daniel Scally <djrscally@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 include/acpi/acbuffer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/acpi/acbuffer.h b/include/acpi/acbuffer.h
index 18197c16149f..d42e82a82852 100644
--- a/include/acpi/acbuffer.h
+++ b/include/acpi/acbuffer.h
@@ -207,4 +207,13 @@ struct acpi_pld_info {
 #define ACPI_PLD_GET_HORIZ_OFFSET(dword)        ACPI_GET_BITS (dword, 16, ACPI_16BIT_MASK)
 #define ACPI_PLD_SET_HORIZ_OFFSET(dword,value)  ACPI_SET_BITS (dword, 16, ACPI_16BIT_MASK, value)	/* Offset 128+16=144, Len 16 */
 
+/* Panel position defined in _PLD section of ACPI Specification 6.3 */
+#define ACPI_PLD_PANEL_TOP			0
+#define ACPI_PLD_PANEL_BOTTOM			1
+#define ACPI_PLD_PANEL_LEFT			2
+#define ACPI_PLD_PANEL_RIGHT			3
+#define ACPI_PLD_PANEL_FRONT			4
+#define ACPI_PLD_PANEL_BACK			5
+#define ACPI_PLD_PANEL_UNKNOWN			6
+
 #endif				/* ACBUFFER_H */
-- 
2.31.1

