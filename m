Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2019D2BA225
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Nov 2020 07:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgKTGI2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Nov 2020 01:08:28 -0500
Received: from mail-eopbgr700055.outbound.protection.outlook.com ([40.107.70.55]:14688
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgKTGI1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Nov 2020 01:08:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLPoAhyNDcwRvloesDwCNBwz6Wbh1WyOSBXiTRqt/NX2VlkH6btpmGiWi05c19LWQ2iOJGE0a7ZbXlozqMFZhJUmRIoa1ZtAMmmehD4n/C+4i17bGSwyyTeLMpT+b0w/XGku/m/WbSsWUE/cpgLGx6gKUxnomqlZxSvoHIRE0LhYUuq9gj0UyCVje6d1zVLumBmrP16qnm6UCgyMtFZ0fbHQSi0wt8ap7Pr2hFy5qpBiWkyrolm8MiTmWc6cKo8zye+5udjhk5qZ6+NRG6AUHPpVpjyCjRwTK4+K5c3uuqEog/wdRhkM7lnuMOSUZ4cZbQcUaZl2vp3Q3EMkjSTjwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ffEVtxzOvIXN7AuQFlD2BRIf2hn65c/IHUoKbXYd4=;
 b=kl/eZhi7lzcQLMD6MdQ/OpldbowotaCj85Iyb5Ncgli51Ko7YtYdx1zqAE7NL/FaA6JG0h11c8AhMLOToFlueRclUvK5E2Py9NDVcOjom3nkkOwc06VhXw9cAWRJScjSLaz+Kzxc8+sbtjI9NIvScjN4BeTqGMkoY0THSXKHdJh8C5jgkAwiG9HkbUrZ4jZPrFLq6u/kXB0BtmUlobUWXv453DYHIx54m1iiyxWEnuLPjNibVKDmYw9DRMT0iwaszzdx4OLhVpdEkKOerO/pQVfopRMjucpbr1hpiB9/3nFAue+wJYhile1a7GQsHS8pV332tE1ScBXV6WNZDnJcBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4ffEVtxzOvIXN7AuQFlD2BRIf2hn65c/IHUoKbXYd4=;
 b=V4tFFWFD0RVZQDnIeezWJI5pBz9j8r+s10HL4qjsEAIovN70snRTgdWzX6IXnm0EOTNcq1nMeJPVsGSI9g5WZvVZBfkafiyfBWmjJNO9cdKTd6Gus+8bSp6YOJyT5HgPaEyLyQqsk0SPeA/ijHqApw41yocy3OcLselUKjXnNa8=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2495.namprd12.prod.outlook.com (2603:10b6:802:32::17)
 by SN6PR12MB2800.namprd12.prod.outlook.com (2603:10b6:805:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Fri, 20 Nov
 2020 06:08:24 +0000
Received: from SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef]) by SN1PR12MB2495.namprd12.prod.outlook.com
 ([fe80::c9d:1af9:30b:c4ef%4]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 06:08:24 +0000
From:   Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Cc:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject: [PATCH v2] ACPI: PM: s2idle: Add AMD support to handle _DSM during S2Idle
Date:   Fri, 20 Nov 2020 11:37:52 +0530
Message-Id: <20201120060752.3146704-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::17) To SN1PR12MB2495.namprd12.prod.outlook.com
 (2603:10b6:802:32::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jatayu.amd.com (165.204.156.251) by MA1PR0101CA0055.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 06:08:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5a21864-8dd9-479a-c011-08d88d1ab073
X-MS-TrafficTypeDiagnostic: SN6PR12MB2800:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28006F8FE555145956B24F7D9AFF0@SN6PR12MB2800.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:110;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PDwHg4vtF7IA421MR2f4Ru6fu06x4d6Y1ASBMDofs+nA5bneK+F3L5WboGf9HRTI9yBJHb3fuokrWDixEpOF4BKFlvW87iJUlQo+knaIfOGWJTj5c3m4c0mVGlaLND1wj+UwFptNmIIgZf/92LPnFSy3kwVHXhbQv/2bhT4XMUw18e8/kEoFKiAtPzwOr+tb2TYCXZcjbqFpHs0MRHwNrRI4SynnVN8nL9/fpja2UQ2//aHW/4juCbjK3Bh3c6mrd8+oT7hmPtZ/UWGVUBGJlwOrkqTCfjTRX5FFUA6th9PzIQt0tpSVAWTCsaey19fG8jLHPxNOruYEhGgqOa9ds5bFG/GZzPhdxRSf/srttO3ktjPLzJ6a21z71bdEbIcvrd2My3KYeb8M3y/hNXanw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2495.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(6666004)(316002)(956004)(2616005)(478600001)(186003)(26005)(966005)(1076003)(36756003)(86362001)(83380400001)(5660300002)(16526019)(6486002)(4326008)(66476007)(66946007)(66556008)(8676002)(7696005)(52116002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vxa7mn18bib9B9t8oh5br/dKQy8prS8NHjmS+jfuZCUuTCatGz+a6vgI+F5k+yLT5rtTkcE2QwtmMkmgJ4GE7uNIjCR7hv/MMCfZ27aaXC+NTMsRfpO4nKONVEYup/7j57Itnd1ZaReD9ige/C1zqOaSli3qFALqBaDbeKviWaIqBicyz/mBxdcdt3jq9aNFJZmnzQumQ0pE1r19OWBRbq5qc80CJQarl3NBzwXOsMOkKQcHIEkBKMNJLaiGYl92jgLEr6EqBGvYAIf1mi/RvFoenxDL9XELFysT16YkVBEclNQWVUUdCsZBmDq5sxIdt8dzornSl2MVX5DYZ4kEVQhBNlBq42o3e0cpG+0yv42JIoaZmI4P08pIsEmCaNh8gvO3owLZ+0cX9wcL3GrlGj0AV7FDgJIX9jyduzQ1e0FaQYIDn6QHtjOHn1RpSf1AzMzTMAZXDKu0V9HPA5aXNLVwwo1L78jgvPs4viLslwif5EEgERkQlPX0nuGL2cbfL803Zlbgh0r1NFAwObVHiwaT8cfG2u6AJV1pRb+OS7HW79AUl/LEhQkkv6vUSdmUoV9VoUgpBEW4r1dDb2vjAH6V95H/nGAiy/kpPijbRnZ3IV5Cp+5qVUZxI2OhpUbtAzISMRP3CXG/Wke7br6aBA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a21864-8dd9-479a-c011-08d88d1ab073
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 06:08:24.3786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owiRCRkNgBLzDzzkwdAkBE68lLBir7HGFrkpqvMgdtFBsghYHJfin8H4o1fXH81MDVLz/qZTTod+mF+z0r39eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Initial support for S2Idle based on the Intel implementation [1] does not
work for AMD as the BIOS implementation for ACPI methods like the _DSM
are not standardized.

So, the way in which the UUID's were parsed and the ACPI packages were
retrieved out of the ACPI objects are not the same between Intel and AMD.

This patch adds AMD support for S2Idle to parse the UUID, evaluate the
_DSM methods, preparing the Idle constraint list etc.

Link: https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf # [1]
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
v2:(https://www.spinics.net/lists/linux-acpi/msg97104.html)
- Remove default case in switch.
- Add a routine acpi_match_vendor_name() required when building on a
  non-x86 based environment.
- Fixed spelling mistakes.
---
 drivers/acpi/sleep.c | 166 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 157 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index aff13bf4d947..b929fd0d2e04 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -710,6 +710,11 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
 
+/* AMD */
+#define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
+#define ACPI_LPS0_SCREEN_OFF_AMD    4
+#define ACPI_LPS0_SCREEN_ON_AMD     5
+
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
 static char lps0_dsm_func_mask;
@@ -733,8 +738,124 @@ struct lpi_constraints {
 	int min_dstate;
 };
 
+/* AMD */
+/* Device constraint entry structure */
+struct lpi_device_info_amd {
+	int revision;
+	int count;
+	union acpi_object *package;
+};
+
+/* Constraint package structure */
+struct lpi_device_constraint_amd {
+	char *name;
+	int enabled;
+	int function_states;
+	int min_dstate;
+};
+
 static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
+static int rev_id;
+
+static void lpi_device_get_constraints_amd(void)
+{
+	union acpi_object *out_obj;
+	int i, j, k;
+
+	out_obj = acpi_evaluate_dsm_typed(lps0_device_handle, &lps0_dsm_guid,
+					  1, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
+					  NULL, ACPI_TYPE_PACKAGE);
+
+	if (!out_obj)
+		return;
+
+	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
+			  out_obj ? "successful" : "failed");
+
+	for (i = 0; i < out_obj->package.count; i++) {
+		union acpi_object *package = &out_obj->package.elements[i];
+		struct lpi_device_info_amd info = { };
+
+		if (package->type == ACPI_TYPE_INTEGER) {
+			switch (i) {
+			case 0:
+				info.revision = package->integer.value;
+				break;
+			case 1:
+				info.count = package->integer.value;
+				break;
+			}
+		} else if (package->type == ACPI_TYPE_PACKAGE) {
+			lpi_constraints_table = kcalloc(package->package.count,
+							sizeof(*lpi_constraints_table),
+							GFP_KERNEL);
+
+			if (!lpi_constraints_table)
+				goto free_acpi_buffer;
+
+			acpi_handle_info(lps0_device_handle,
+					 "LPI: constraints list begin:\n");
+
+			for (j = 0; j < package->package.count; ++j) {
+				union acpi_object *info_obj = &package->package.elements[j];
+				struct lpi_device_constraint_amd dev_info = {};
+				struct lpi_constraints *list;
+				acpi_status status;
+
+				for (k = 0; k < info_obj->package.count; ++k) {
+					union acpi_object *obj = &info_obj->package.elements[k];
+					union acpi_object *obj_new;
+
+					list = &lpi_constraints_table[lpi_constraints_table_size];
+					list->min_dstate = -1;
+
+					obj_new = &obj[k];
+					switch (k) {
+					case 0:
+						dev_info.enabled = obj->integer.value;
+						break;
+					case 1:
+						dev_info.name = obj->string.pointer;
+						break;
+					case 2:
+						dev_info.function_states = obj->integer.value;
+						break;
+					case 3:
+						dev_info.min_dstate = obj->integer.value;
+						break;
+					}
+
+					if (!dev_info.enabled || !dev_info.name ||
+					    !dev_info.min_dstate)
+						continue;
+
+					status = acpi_get_handle(NULL, dev_info.name,
+								 &list->handle);
+					if (ACPI_FAILURE(status))
+						continue;
+
+					acpi_handle_info(lps0_device_handle,
+							 "Name:%s\n", dev_info.name);
+
+					list->min_dstate = dev_info.min_dstate;
+
+					if (list->min_dstate < 0) {
+						acpi_handle_info(lps0_device_handle,
+								 "Incomplete constraint defined\n");
+						continue;
+					}
+				}
+				lpi_constraints_table_size++;
+			}
+		}
+	}
+
+	acpi_handle_info(lps0_device_handle, "LPI: constraints list end\n");
+
+free_acpi_buffer:
+	ACPI_FREE(out_obj);
+}
 
 static void lpi_device_get_constraints(void)
 {
@@ -883,13 +1004,22 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func)
 	if (!(lps0_dsm_func_mask & (1 << func)))
 		return;
 
-	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, 1, func, NULL);
+	out_obj = acpi_evaluate_dsm(lps0_device_handle, &lps0_dsm_guid, rev_id, func, NULL);
 	ACPI_FREE(out_obj);
 
 	acpi_handle_debug(lps0_device_handle, "_DSM function %u evaluation %s\n",
 			  func, out_obj ? "successful" : "failed");
 }
 
+static bool acpi_match_vendor_name(void)
+{
+#ifdef CONFIG_X86
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return true;
+#endif
+	return false;
+}
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
@@ -901,9 +1031,17 @@ static int lps0_device_attach(struct acpi_device *adev,
 	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
 		return 0;
 
-	guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
+	if (acpi_match_vendor_name()) {
+		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
+		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
+		rev_id = 0;
+	} else {
+		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
+		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
+		rev_id = 1;
+	}
+
 	/* Check if the _DSM is present and as expected. */
-	out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
 	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
 		acpi_handle_debug(adev->handle,
 				  "_DSM function 0 evaluation failed\n");
@@ -919,7 +1057,10 @@ static int lps0_device_attach(struct acpi_device *adev,
 
 	lps0_device_handle = adev->handle;
 
-	lpi_device_get_constraints();
+	if (acpi_match_vendor_name())
+		lpi_device_get_constraints_amd();
+	else
+		lpi_device_get_constraints();
 
 	/*
 	 * Use suspend-to-idle by default if the default suspend mode was not
@@ -974,9 +1115,12 @@ static int acpi_s2idle_prepare_late(void)
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
 
-	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
-	acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
-
+	if (acpi_match_vendor_name()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD);
+	} else {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY);
+	}
 	return 0;
 }
 
@@ -1051,8 +1195,12 @@ static void acpi_s2idle_restore_early(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
-	acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
-	acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
+	if (acpi_match_vendor_name()) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD);
+	} else {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON);
+	}
 }
 
 static void acpi_s2idle_restore(void)
-- 
2.25.1

