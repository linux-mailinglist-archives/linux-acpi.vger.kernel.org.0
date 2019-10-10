Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1427FD2B6E
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Oct 2019 15:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfJJNdk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Oct 2019 09:33:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387992AbfJJNdj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Oct 2019 09:33:39 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2EE84B697AC0BF877381;
        Thu, 10 Oct 2019 21:33:26 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Thu, 10 Oct 2019 21:33:18 +0800
From:   John Garry <john.garry@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <robert.moore@intel.com>,
        <erik.schmauss@intel.com>, <sudeep.holla@arm.com>,
        <rrichter@marvell.com>, <jeremy.linton@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>, <gregkh@linuxfoundation.org>,
        <guohanjun@huawei.com>, <wanghuiqiang@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH 1/3] ACPICA: ACPI 6.3: PPTT add additional fields in Processor Structure Flags
Date:   Thu, 10 Oct 2019 21:29:50 +0800
Message-ID: <1570714192-236724-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
References: <1570714192-236724-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Erik Schmauss <erik.schmauss@intel.com>

Commit b5eab512e7cffb2bb37c4b342b5594e9e75fd486 upstream.

ACPICA commit c736ea34add19a3a07e0e398711847cd6b95affd

Link: https://github.com/acpica/acpica/commit/c736ea34
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/acpi/actbl2.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b942..1d4ef0621174 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1472,8 +1472,11 @@ struct acpi_pptt_processor {
 
 /* Flags */
 
-#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)	/* Physical package */
-#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (2)	/* ACPI Processor ID valid */
+#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)
+#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (1<<1)
+#define ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD  (1<<2)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_LEAF_NODE            (1<<3)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_IDENTICAL            (1<<4)	/* ACPI 6.3 */
 
 /* 1: Cache Type Structure */
 
-- 
2.17.1

