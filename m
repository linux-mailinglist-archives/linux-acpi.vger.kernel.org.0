Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D89C3AB9DA
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 18:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbhFQQow (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 12:44:52 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:6999
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230387AbhFQQou (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 12:44:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1KxDzY8HBaf7MGiUwTJNsUimGQZrpsiVQhntH98E07TxG2f8YbvLmhUT9h+3uQglErcXS4yIn61tqlEIqHMyhvkKFHKBk4pwDrGe1R0ACmLzwXMluIb/cTU3agKTK5OvHXiJbhyG0FOuSfLYXRe8Z4wvRIT0Np0xaWb8mSCoSXGbpVdkxWw2VtXCVacT8STjqar8sqMZuQ+DsFAbRZyK0nrFvsDpKshDstKq1BNg+pVKwxJFk2/9aeYVTR1fumoq9G8Oj97qFccpYLRnvJYtisDR5wxwbdNIwivPuEaTsKri4g7Q2MuK6h2/V2puHLCEIyABdh4HoVQG4vvPSzTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20wUNHMI/qxowpHbdKtVM1AMFeSDDQuPV+hs1eqAS5E=;
 b=Zq0hHY9qCByRPmqn+sNHO060Hnq18ZBpXvIxo0mUy1vP+GTtZHklgqo79UAkSMRO37X0ICVDwndH9JYlK/FfCi8zE1MnMcFpKygXNDHRpViJYOvfQFIc+G1kUMA0Ebblga9ytx9sEhUFsJKDOszHWEMkt2QIHBHRnPlN6ipQdleGjDmtpviIS5hoNjoSFU0VAuMIxRGyULPmruS6h/f9nJ5ecAcnoWmom5H+78UIrIgiRgvFtoNo6clVtJysTn7KjGMbPkAYLLM4AsDdOzFEJW9saYCfDlPdRV4vI7WtCVzse0OqmyxTDr42kmwZonCfq5sDa7zm7LPmEfdkrtzq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20wUNHMI/qxowpHbdKtVM1AMFeSDDQuPV+hs1eqAS5E=;
 b=lf+ZPGmqCYIJHPT8TRxnagDH7FZMFYhSt5fOO9tMiZYh6K6S4dwpieLUCu+NmWnBY2mgyA/Ae+yssWh8TDOtMNtv2lZhcGIXaix1yYT4dLlNDOgAOvCaQBxP3CE74UDRpWShPsc+8Zq/6YELdCVNVABREp+PwG8bgAlW734SPhU=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:42:37 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:42:37 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/5] ACPI: PM: s2idle: Add support for new Microsoft UUID
Date:   Thu, 17 Jun 2021 11:42:11 -0500
Message-Id: <20210617164212.584-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617164212.584-1-mario.limonciello@amd.com>
References: <20210617164212.584-1-mario.limonciello@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [76.251.167.31]
X-ClientProxiedBy: SN6PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:805:de::19) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:42:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5bdbccd-4668-4195-a5e8-08d931aeea09
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671505176337824E82D07C5E20E9@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vF4Q05O+n/jFrF2A8FIzVAiiLZ/+qyLYBE5YgT5EN8J3inrzCxr6d8TcC8oyPcNB1th3SBdvlr69yVnd5VPs6BugVNIXAC4qDwaEhRBNy0txVY44Z0cbvL2E2IaoHTFhMxeI+F4ypERxH84siYQGB2dOVrJDlLk1ICanZnXWhtN7c4Sj+csIYYPs1ijiYKxP/ZpC6AfxdY7OESuS0s0HYpbK3/nO43shtEscUczNQ3ySYc1XjzfzlDYMXUiVCoTdlvrD8+X2gKHp5jeOE3kxf/+4VHWPJK36rB7OADxUMwuvITtRPFtDtjYshnjJFX+pMltgkTJ96sQTH7RDp7FEPCBobep+ZepAhoe41TNtWMHfHJl6ryMTpYoDi8Y300OIJgkoiZ3gZ/GGX6GlbZqKnXOyofuIoh5dyUR6GKatmrgBULuxbdGQDx8TeVYQ27XuoKye8eCLoUF24DLYWJoa/P+IlxxqXR851cAwXiHWgkuFzZN0w13p1bQuu6ftKHqspMGF812G1ziTYaJwnVsL/rBAz8e055o0Ro3Cs1lGBI6jL+6peN4cJ5wjW92YK+kWLcoBjzRpPHvH5aq+YJwaC0/nFB+6TlgQ6oYdulGMx7EPKQdgGjN0APTPK6f2q/wzehAOrYwMld8PkulEAD0Njh5qn2l7es78+DjQfHwJE8pWjT/LkCUjLnFmncDdOxkrZ+HMSMGNBuuGPxFL7H8i/MUEjfOOdIDH1GgmVzTjTr9LjWVuex7vR+5Ahh2vMI3oDx1EI3GIMZBhSkQKQZ00Ig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(47530400004)(52230400001)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(316002)(45080400002)(8676002)(86362001)(44832011)(966005)(6666004)(110136005)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(2906002)(5660300002)(7696005)(956004)(8936002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HMNrYRZQEsyMX3boGuBDLBpfBcEYPV9aet5xoyyxgw9yEhfBldNg64CjSg1f?=
 =?us-ascii?Q?ig5UNLyCnL5OE0gDaNgH268dTuVpFeOsea58f5XyGVhXP71crCWq8ao7oNNk?=
 =?us-ascii?Q?JyH25xOamHGwlj9yrW4Ew5Whc1rOhu8HrX7L4KjoMusQu79Zwqgw5OgYfiIe?=
 =?us-ascii?Q?4hD/dEvmFSqlhltA7BxvKbdU3edo7aFVfQ0ZfX788gAVz9Skmkj7zNc7sNwm?=
 =?us-ascii?Q?ZiaUNm6CV1ADzAjLtiFEh7AU0Rx0P3o3hegmvl+Qrfn6Iuv0bhsDMYBLGxXG?=
 =?us-ascii?Q?rTOPgPZqHERMtEIIRif7giVKY8oXsECbnS4EhgSm2tY5xysa5Ug2n+1jDg07?=
 =?us-ascii?Q?5E0dEhEMFhUhJMKykMTutOqYk6HLUkAkN1W+wd9U/LUMiGlOdsbeG5RZYEWx?=
 =?us-ascii?Q?ItM5xI/VF3Ghq8k8+eL4nnUK4w+kSXKHyYUOWEgYQuqPM4xI79BLLwnW6UXp?=
 =?us-ascii?Q?U3Km+e6xehoMMHXXGDYJL7r0oLHI3BxMSY8qTxMBoRkAejlc+/19rjKHdLSJ?=
 =?us-ascii?Q?Pzdw5sc23iWQwgI96Ua8m+ZGk/etZPtYknbxi5GBQXmwB/tqA4zzKs8MrIOT?=
 =?us-ascii?Q?Ml/xyVuuHuilmRdo6OK0t6Cw6ZgmLWPeG5eQYXg78aQozQMxuf/6lS22CAn1?=
 =?us-ascii?Q?0w/cTP4dGyJWjTEfbD7JY7gsVhD3vw8EB++VAHF2DnQwgOd1rp0L0d4gIYbo?=
 =?us-ascii?Q?VKd7JNI6kX0ucJX+vWBMLnC4Ko0csDY6hijeC4CkM2JdXGsV38qbgIJmiKlC?=
 =?us-ascii?Q?GU7UaNmi8bZvZ1AY30GDCyxcxbTWZcdeL5YU/KgWwrhJLE8Q1SOut2Ej56FC?=
 =?us-ascii?Q?or/BTFgY32lC4apxl5pM2JbCGgpUBFlXL4mmpIzplbeDGi10bv0EoWemDPMr?=
 =?us-ascii?Q?Ue8OeLZirybzvC2I+iDu3hCNh3C4reqCjfW5J8x7muxi3V2mMB801pZROrcv?=
 =?us-ascii?Q?WkR6qC7ses9kjokO3zTTxtv0N7WxedwsRVFVqNYB46hggT8mBJtTDBXqM7za?=
 =?us-ascii?Q?m4gTEYpjDfET+hKiTIchB5lrPn7n1sXfHLpTp+EMFkxRnYIJAPPLPbnUDRtH?=
 =?us-ascii?Q?IJsOY2aqPEcD78rIO2E9yFULYNGmxU2iRGj3NkLPdhiIiG6jcQVNID3+ZBXj?=
 =?us-ascii?Q?K1c6nTze0pqId+opQp+kvU4YNaAN3Y4aVUkcQU8vdvmKwHW19QFmO68CR40u?=
 =?us-ascii?Q?pKlY/9p1KjpyNv9uGX18IabHyx/9I00yZ/ocmADxsigFyQThNscUY2+/Vodm?=
 =?us-ascii?Q?qmqhrj4SS6yrctoLqpPLjSwur1yB0qal+hDIjw7aMK8TcqsxGR0gACYBjQ0W?=
 =?us-ascii?Q?BkT0qOHj8v+yQz6aKMBaYPUj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bdbccd-4668-4195-a5e8-08d931aeea09
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:42:37.0993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TeYSCvoY1unzgei7cWJXXe6nbL5dzfs7e5ke4+4mddqxgHKWatlBOOO8hD+gLiqU4A2Pe+jPPAmRzMYHj2yLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

This adds supports for _DSM notifications to the Microsoft UUID
described by Microsoft documentation for s2idle.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications
Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/acpi/x86/s2idle.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 0d19669ac7ad..3f2a90648ec9 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -32,6 +32,9 @@ static const struct acpi_device_id lps0_device_ids[] = {
 	{"", },
 };
 
+/* Microsoft platform agnostic UUID */
+#define ACPI_LPS0_DSM_UUID_MICROSOFT      "11e00d56-ce64-47ce-837b-1f898f9aa461"
+
 #define ACPI_LPS0_DSM_UUID	"c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
 
 #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS	1
@@ -39,6 +42,8 @@ static const struct acpi_device_id lps0_device_ids[] = {
 #define ACPI_LPS0_SCREEN_ON	4
 #define ACPI_LPS0_ENTRY		5
 #define ACPI_LPS0_EXIT		6
+#define ACPI_LPS0_MS_ENTRY      7
+#define ACPI_LPS0_MS_EXIT       8
 
 /* AMD */
 #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
@@ -51,6 +56,9 @@ static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
 static int lps0_dsm_func_mask;
 
+static guid_t lps0_dsm_guid_microsoft;
+static int lps0_dsm_func_mask_microsoft;
+
 /* Device constraint entry structure */
 struct lpi_device_info {
 	char *name;
@@ -366,14 +374,18 @@ static int lps0_device_attach(struct acpi_device *adev,
 		rev_id = 0;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
+		lps0_dsm_func_mask_microsoft = validate_dsm(adev->handle,
+					ACPI_LPS0_DSM_UUID_MICROSOFT, rev_id,
+					&lps0_dsm_guid_microsoft);
 	} else {
 		rev_id = 1;
 		lps0_dsm_func_mask = validate_dsm(adev->handle,
 					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
+		lps0_dsm_func_mask_microsoft = -EINVAL;
 	}
 
-	if (lps0_dsm_func_mask < 0)
-		return 0;//function eval failed
+	if (lps0_dsm_func_mask < 0 && lps0_dsm_func_mask_microsoft < 0)
+		return 0; //function evaluation failed
 
 	lps0_device_handle = adev->handle;
 
@@ -412,7 +424,14 @@ int acpi_s2idle_prepare_late(void)
 	if (pm_debug_messages_on)
 		lpi_check_constraints();
 
-	if (acpi_s2idle_vendor_amd()) {
+	if (lps0_dsm_func_mask_microsoft > 0) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	} else if (acpi_s2idle_vendor_amd()) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF_AMD,
 				lps0_dsm_func_mask, lps0_dsm_guid);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY_AMD,
@@ -432,7 +451,14 @@ void acpi_s2idle_restore_early(void)
 	if (!lps0_device_handle || sleep_no_lps0)
 		return;
 
-	if (acpi_s2idle_vendor_amd()) {
+	if (lps0_dsm_func_mask_microsoft > 0) {
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
+				lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
+	} else if (acpi_s2idle_vendor_amd()) {
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT_AMD,
 				lps0_dsm_func_mask, lps0_dsm_guid);
 		acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON_AMD,
-- 
2.25.1

