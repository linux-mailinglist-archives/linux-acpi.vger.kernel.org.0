Return-Path: <linux-acpi+bounces-1078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C217DA3A1
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Oct 2023 00:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC89280FCB
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC56405D6
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JSwmKxwL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6056405DC;
	Fri, 27 Oct 2023 22:33:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7515AF;
	Fri, 27 Oct 2023 15:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOYHmLmKw0qdiqtMvy1iTs0iRsJb0KC2qRG0UR6UdD24yKF74GBqZN/G1lBAfJJQ4buKdC8xuTSSWS1ib6FUN30WqyTfNFZ32isD0rCKINqc77ClMqVBTyiCfhdTUaWdhn1CZaPQpd2Jd3uxlzsM8+8F36NziGpUHMQS4O3MQnjyRCfaspHuSLr27bwar8vjj56/eSg9lXEE6NgiDT5rg7GRBFZ+xzw7dUuFBlJAKb/NKw2OkRU4dWkADK4QmX4e/+uZEKM1OIqtsT38BOvp8TjpCGquXdPBYeJZiLHm9/lewh8WmHJEed86q2Q1ld1fdjbrO0WnSlKet3gWHr0z8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHMPNia1dswb2Zej4BsgjxALURfmPV4irwuvM5w6tGM=;
 b=iw2dDT37T8L6gc13wHvf3oUxWjol4w9OD6uqxyiG+wW4oz47J58y6W2o/guq76CRZb/6NJHPToWCHYK841e6aKgUVPTLDdYe0ehupVzIZVG9umCSdOmOew8+D5B90zGmFYhgxZrXyyuZ6fV/vE50ZRIhP9yjhVooF/i5dBkEefChlzSTMGFPV1cgX4oWVKoVLP1h4ODuDOl7h7pCVZ6CLdllvEXD0vvpqDDf2t2wZUrMxD9zLLf57pO1XosuQ1S/EfBe9xqDRAJB6d+dApLbOx5ax03SGkX89riyg5yr5U9Cveq7OJpxVCISKdQb/qJwR2NRc6vKgPeyHbMcTNUZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=chromium.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHMPNia1dswb2Zej4BsgjxALURfmPV4irwuvM5w6tGM=;
 b=JSwmKxwLyD7Ef2jCFzIjZjzZLbq33LJqqxxlx5TrdbJ4tAvynLhdsALq0Hcz7q/YHlg3uf0Wlz3f4oOO86d2TeSmeQ3Tth9DhjyYSE4gQ2D/uPV/bv7N/0OtOP2zgWYkmco/ee6lr0F8++q1HjPkqCYGGGglS+5ulgrN3/6H3Kdjllu6izALzqsZ39AIdKq4tl4fyl/VYEjmql2HgDuRVq0PhN+uaJAFSfVAdPCzzhqNGfItLBL2uj3cetqgnDQdPS49M6aAxZ687XACTlEZ4d7oVOIp4PFv9lmBD3YrprZ5akXzk42S6pmrafEQDE3PZuQBNqwJoivASkliHYQrtA==
Received: from SA0PR11CA0042.namprd11.prod.outlook.com (2603:10b6:806:d0::17)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 22:33:49 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::ac) by SA0PR11CA0042.outlook.office365.com
 (2603:10b6:806:d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24 via Frontend
 Transport; Fri, 27 Oct 2023 22:33:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 22:33:49 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 27 Oct
 2023 15:33:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Fri, 27 Oct 2023 15:33:36 -0700
Received: from build-jeshuas-20231025T093157439.nvidia.com (10.127.8.14) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41
 via Frontend Transport; Fri, 27 Oct 2023 15:33:36 -0700
From: Jeshua Smith <jeshuas@nvidia.com>
To: <keescook@chromium.org>, <tony.luck@intel.com>, <gpiccoli@igalia.com>,
	<rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>, <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
	<treding@nvidia.com>, <jonathanh@nvidia.com>, Jeshua Smith
	<jeshuas@nvidia.com>
Subject: [PATCH V3] ACPI: APEI: Use ERST timeout for slow devices
Date: Fri, 27 Oct 2023 22:33:09 +0000
Message-ID: <20231027223309.22883-1-jeshuas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MN6PR12MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: fbc724d3-b864-40b4-4541-08dbd73cca40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a9sIvckRT20PXvbTJvQ9t2Xz22hfJQ1M7xAbMg5nsyT8URGaAy5Y6q1jL+vlOHuAZSRrVLoGRNlvq26onfs12Z/f5XF0wk3hCXdzdyhZFdKrrw+EGxsJeFkYgwyIrSsoN4zRX6a/g4Zs0p4XFLZgEwY3a/URyC0b4U2EwORYlYayxlCBZG6taI+wzZdLJs5uB0CiFKkmKRTp7k/Z+LzccA/8emQprDXcm2BP+iL5Bu3px2bBQUIMpeKlKiFADRZwSUR3uMXvWphCQkMz6lpRzuuPB2fazJklf4Cvy2EoKwQyhN1TPRj5PuZnYPANuoo1YDnsqiWntZAflJjhYL1cnb5Kbs9Bysg9g6Yy9NMV8dcSe1cltDgFj5s88RlJhkmWOKU7PzUdHjpqCds+Z3GiayooxC2DYtDyecR4bebHCwEf9LSJsjp+o/jM0S+CJ+TOE3dWkwY4amERUCfTiQ9BvxYvRyOFLEjzKlfkJ/v6HWfPuwei7ATxkahDMM/s1OHAJl/Ol4PJqffyhulppERzD0Yg+Lp76/7w9btNHEosSS0L/gubMkRoDCuShuP9V94OCxXgzJmzghOoY+1sIGeFq8APfsSGFobHIbSg9br3AKjbB37pGxY4O/csuSdp9rwGeil52VnKDphHjmBhGlkMNYquOvoBbhJ/KdNPT77sqKKQu2YESjzGciO0cuq51Fg46qM/dT+q6lnyXYyNsSYajGe5u7RgNsLnT3M71x6U/C4JMdKNoQLW/qBmdmvm2EfU
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(426003)(40480700001)(478600001)(336012)(83380400001)(6666004)(86362001)(40460700003)(8936002)(8676002)(5660300002)(41300700001)(7416002)(4326008)(107886003)(2616005)(26005)(1076003)(36756003)(316002)(356005)(2906002)(110136005)(7696005)(82740400003)(54906003)(7636003)(36860700001)(70586007)(47076005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 22:33:49.3026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbc724d3-b864-40b4-4541-08dbd73cca40
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542

Slow devices such as flash may not meet the default 1ms timeout value,
so use the ERST max execution time value as the timeout if it is larger
and if the ERST has the "slow" attribute set.

Example:
A NOR flash spec lists "Page program time (256 bytes)" as 120us typical,
and 1800us max. A 32KB error log would be (32K/256) = 128 nor-flash
pages. Writing those 128 nor-flash pages would then take
120us * 128 = 15ms typical, or 1800us * 128 = 230.4ms max.

Without this change, when pstore calls APEI's ERST code to write a 32KB
error log to the NOR flash in the example, the code will flag a timeout
after 1ms and return an error to pstore. With this change, unless the
max time value from the ERST table is exceeded, the code will not flag a
timeout and will return success to pstore after the operation completes.

Signed-off-by: Jeshua Smith <jeshuas@nvidia.com>
---
v3:
* Extended commit message based on feedback from Borislav Petkov
* Use bitfield.h based on feedback from Tony Luck

v2:
* no longer add copyright.
* no longer add unused ERST_EXEC_TIMING_TYPICAL defines.
* set timings to 0 if the ACPI_ERST_EXECUTE_TIMINGS operation isn't supported,
  which will result in the default timeout being used.

 drivers/acpi/apei/erst.c | 41 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index 247989060e29..90dc0fc68dad 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -25,6 +25,7 @@
 #include <linux/pstore.h>
 #include <linux/vmalloc.h>
 #include <linux/mm.h> /* kvfree() */
+#include <linux/bitfield.h>
 #include <acpi/apei.h>
 
 #include "apei-internal.h"
@@ -59,6 +60,9 @@ static struct acpi_table_erst *erst_tab;
 #define ERST_RANGE_NVRAM	0x0002
 #define ERST_RANGE_SLOW		0x0004
 
+/* ERST Exec max timings */
+#define ERST_EXEC_TIMING_MAX    GENMASK_ULL(63, 32)
+
 /*
  * ERST Error Log Address Range, used as buffer for reading/writing
  * error records.
@@ -68,6 +72,7 @@ static struct erst_erange {
 	u64 size;
 	void __iomem *vaddr;
 	u32 attr;
+	u64 timings;
 } erst_erange;
 
 /*
@@ -97,6 +102,19 @@ static inline int erst_errno(int command_status)
 	}
 }
 
+static inline u64 erst_get_timeout(void)
+{
+	u64 timeout = FIRMWARE_TIMEOUT;
+
+	if (erst_erange.attr & ERST_RANGE_SLOW) {
+		timeout = FIELD_GET(ERST_EXEC_TIMING_MAX, erst_erange.timings) *
+                          NSEC_PER_MSEC;
+		if (timeout < FIRMWARE_TIMEOUT)
+			timeout = FIRMWARE_TIMEOUT;
+	}
+	return timeout;
+}
+
 static int erst_timedout(u64 *t, u64 spin_unit)
 {
 	if ((s64)*t < spin_unit) {
@@ -191,9 +209,11 @@ static int erst_exec_stall_while_true(struct apei_exec_context *ctx,
 {
 	int rc;
 	u64 val;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 stall_time;
 
+	timeout = erst_get_timeout();
+
 	if (ctx->var1 > FIRMWARE_MAX_STALL) {
 		if (!in_nmi())
 			pr_warn(FW_WARN
@@ -389,6 +409,13 @@ static int erst_get_erange(struct erst_erange *range)
 	if (rc)
 		return rc;
 	range->attr = apei_exec_ctx_get_output(&ctx);
+	rc = apei_exec_run(&ctx, ACPI_ERST_EXECUTE_TIMINGS);
+	if (rc == 0)
+		range->timings = apei_exec_ctx_get_output(&ctx);
+	else if (rc == -ENOENT)
+		range->timings = 0;
+	else
+		return rc;
 
 	return 0;
 }
@@ -621,10 +648,12 @@ EXPORT_SYMBOL_GPL(erst_get_record_id_end);
 static int __erst_write_to_storage(u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_WRITE);
 	if (rc)
@@ -660,10 +689,12 @@ static int __erst_write_to_storage(u64 offset)
 static int __erst_read_from_storage(u64 record_id, u64 offset)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_READ);
 	if (rc)
@@ -703,10 +734,12 @@ static int __erst_read_from_storage(u64 record_id, u64 offset)
 static int __erst_clear_from_storage(u64 record_id)
 {
 	struct apei_exec_context ctx;
-	u64 timeout = FIRMWARE_TIMEOUT;
+	u64 timeout;
 	u64 val;
 	int rc;
 
+	timeout = erst_get_timeout();
+
 	erst_exec_ctx_init(&ctx);
 	rc = apei_exec_run_optional(&ctx, ACPI_ERST_BEGIN_CLEAR);
 	if (rc)
-- 
2.17.1


