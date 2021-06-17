Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05B53AB9D8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 18:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbhFQQoq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 12:44:46 -0400
Received: from mail-co1nam11on2044.outbound.protection.outlook.com ([40.107.220.44]:6999
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230387AbhFQQop (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Jun 2021 12:44:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6eXBGcszCWpoAH9tz4DELRomjgGmHAhZ7r+RbHTG44A6eAsLKUudbNWJ9jYGGlXNwEIKDHu/kIPxRguN1zOn2StNISwkef2STFZF4aIPcEwN8cWt6YPE3VoJyn/RUvtC4ZaFZcFpqCJEYHuhIlgaqRKiVIM6vJUXfJ4NiyvkAXLA/Y4AFq8H61RBPOBK1dTU0ITTNUSFjkUbQNAr+hxEZedhqe9vdVzq8P2c+jXGWmsRaHNX0PZS44hYmCBLeeDWkr4I8mpKuKLks+V/Qtk3+G5b3emRWkya6agMVOl5z+MbfLJA67V1z1AkbNWOw6qbZ7wrhGw6xwfC7juRUHdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znl4jP9p6Dn7HKGtw+UAuzNdgwbq0RqWRqxn7vO/mX0=;
 b=JuMruFf+J8EsWrr/1MpNtbZ5ri5w+9NsCx2+XXsPT5nOdT88r/bFiVANKnh8fTAOPS9DpDhDS7mc/AEZxto3xwLxbND0YqKFlK96iBpSVX9smVcHGx/9iR6Z92/y2Ymstx+mS6l8TXPdHODu98kffLZq3HIusNg8QxoscjBoTvbbyX1F+kvFhUob7AZIIujFYhAWGRiBX1Doet299G9pQGavQomTPmojfu0M+SLye6Xzr1gmfVY/A5FXphuicsgjonongj4VmDxsoj8mLA5F1Xk2haMV60/eoWSBqdrHn06RfblBkF68OEdouTPJcb6bBJVDUCEMWjPhIB0LPktyiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Znl4jP9p6Dn7HKGtw+UAuzNdgwbq0RqWRqxn7vO/mX0=;
 b=q5hz7YVwWEWssjYP7+1Yhxr3WMyqlmJ8S4vvch5i1mF9sM5zoKjsWCSCIg07ROY7TsmcAlRx7/bG9AR11+ZaTKVvdbfqZV0YQEDmamghhkYDa0V2ty3a7RncTyec7bkMf7PHKk7usUML4HSjErzGU1Y2B1MYayi4ipBPYcMH5R0=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SN6PR12MB4671.namprd12.prod.outlook.com (2603:10b6:805:e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Thu, 17 Jun
 2021 16:42:36 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::9c16:2794:cd04:2be0%6]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 16:42:36 +0000
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Cc:     Julian Sikorski <belegdol@gmail.com>, teohhanhui@gmail.com,
        Shyam-sundar.S-k@amd.com,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/5] ACPI: PM: s2idle: Refactor common code
Date:   Thu, 17 Jun 2021 11:42:09 -0500
Message-Id: <20210617164212.584-2-mario.limonciello@amd.com>
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
Received: from AUS-LX-MLIMONCI.amd.com (76.251.167.31) by SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Thu, 17 Jun 2021 16:42:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 211f9008-b51e-4d2c-2072-08d931aee952
X-MS-TrafficTypeDiagnostic: SN6PR12MB4671:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB4671EF4833F892B8F576057AE20E9@SN6PR12MB4671.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:248;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mV1kVtttG8V2C6m/Zvz2LzHRVCTKuWurU0cmIHO8D0tMonIlm8ffpATJOvURvwfKdYqcI9kz+mV6tJAOUJzpElTejoOZLxhJzJ+EvIW6jk+cI63w5M8W/CAzFgvIte4sbnDmTRLJXkgUpDnJJXgn9QS5Xr87l+xvf7suTgktnZfXr1ckahoqt4VMg372ND1C4wVYVS6KsQbPwpoH7uETEUOdVvcP8/YVfeYEA5ASoPxzIjw4uRCrpdcWJMmAucuvRfYIo7tHBnP0CGJCzP+aPvMTvHWnZoz5hmNuWhD279Gl0zLeQHJazomGacwVqr367OnqlgHTo139olnWv5+vVFZW+dgvJ2ioEAk6MyjxmZgi+sU8XvrtAnELbY6XX2nxzzheosdVDZX3cQw0D7o9HctVnJivRDkz9imPpPl+mIDKWYtDN/FhBCrAKsk/r08t88RWOyFjqHjlp7m5eMZt2CLlYNAsxQGDtt5hnBhj9n7g1vlSbyLIsHw/Zy6s2HaYOpAe0r3X9cVSkBBnKK7z2HIke7X4hmqKQCmelDX1eQpkHFJ0nraon1v3cR2DtfSEQuBAnp8v2emI2STJsn57jHnKabg3RA4GaRfG/Bi6hB4LgpA9Sctom6v/57Z+O+GLCL8vc3yTUvxP0WgjE8d3u+TOWhZ4kwxiAwus95UOi7Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(16526019)(66946007)(478600001)(26005)(66476007)(6486002)(186003)(66556008)(316002)(8676002)(86362001)(44832011)(6666004)(110136005)(38350700002)(1076003)(38100700002)(4326008)(83380400001)(52116002)(2616005)(2906002)(5660300002)(7696005)(956004)(8936002)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7+N6WfA6CSFyNdJE66JlNRr/2qmCfV9gy4RR0Kok3yjpTTNHXIhzu5eg3/ea?=
 =?us-ascii?Q?onxExhatGv88re16YDYoi0VzcyCKzFcC0gJsoAqjQyctdCfMKLgawBIXFYIi?=
 =?us-ascii?Q?WpmqQI082MKtEX9HIhCuaejTUm6moIqem+bme8oRo8xbWsWjhFsJ+q3zNuqK?=
 =?us-ascii?Q?sbojJA12UmIp6vWtWUu4XzHzrcDwtEIV+fWRJW+9gOho8QmV20zo/96f7LfA?=
 =?us-ascii?Q?HVhTRyATyGWJJZRGJkiAZJO6N+jO0RmX/TOxR8moMlNCX4WQNI2b08dBHFhl?=
 =?us-ascii?Q?JJbjbipZ9qMO50QMvoSwPo9x2kLoaVFQgb6IVCUmLNGyuGaEcmk0yU9DMSUd?=
 =?us-ascii?Q?AIrEUxzera/Czrt9OUpCtSKNk//NwGvPGxf6zEI7QAzjGBp/R9lMBLKzZ542?=
 =?us-ascii?Q?wEPLMiGZrxrSXiZgTERUWjSx8TabU7ULrjmVtvB65FS7glFuRLkhaZajiU48?=
 =?us-ascii?Q?8h8N3x9yJYGSTqViY6OGcXHC5imANAuhmEgWn22p0QP33Lo+ea7vguzxt7Z6?=
 =?us-ascii?Q?LF4yvSh14YiQijDabIvKT8DPRb3ndHZ5hNHzmBk5pijzrjgdUkGtZUdWe5F7?=
 =?us-ascii?Q?it7dIxhK8Z/krCP3iCRBj3HDkdsfsVNiKt4F2BeJaYW3HNnO/VSVv/p90p9p?=
 =?us-ascii?Q?smYw5h/9437xNv2y4LttPN+ssDVyIXT2mncxL7d1VU33XAe8lso4mnUVDHh4?=
 =?us-ascii?Q?isJbGwQ8TkI/j4zABT7U3H9GHZnwznh8Y4DCGHeltHey4GA7pGCRhsHp8jna?=
 =?us-ascii?Q?0ODT/KXz1kqn6PyA/7lPvFjqlO/SeztvK7A2EQ8AKy5OCi7JleqQdKhaf6TO?=
 =?us-ascii?Q?+iak1+GP8iKpcq2Q0ujSwYYpZI8Sh1cTjIyMuHbq07tCiYonXOw+Wgt2jnxO?=
 =?us-ascii?Q?e9YQzfvBC56nYzthKZn2LdTCUpZ+DNKfjkXoOObN0wZg7F5BUDS+fXyEGk7C?=
 =?us-ascii?Q?2WgEi9EKJwnrFjCI2H2S0pLo/v8DLpFmIMtl/CfNQpHlUDsMZfWUrQoy5Bxf?=
 =?us-ascii?Q?1YXwPWkVjvPDHZqaqFxAslXJvdPMtYZOj4L1gToDi2gQRiNV/4LGwUQ9JPuL?=
 =?us-ascii?Q?tfp5KkNvXpfoglIXy5FlvwBqPuKeP7500u83/p3wS1RPXnxP+YiM156s40oy?=
 =?us-ascii?Q?NVr7kh6eZrT2DFjfkCSAFY7AhS+UEGQnu21+xuuA9tnXWg1o6XUuQXvxvsH0?=
 =?us-ascii?Q?Z2rv7tyEJaISMEaA2G/VPDPgi1OW39Cub1H6EzCRU9PwIFXnuhLRRSmILk8R?=
 =?us-ascii?Q?u5lh68ECuCYbH9gdjwgSjUC8/XtGK9q2QSpU4Aphz6IfsI0hm7jdh65VTep/?=
 =?us-ascii?Q?smlgFXZT1cOQZeydgYzXDBK5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211f9008-b51e-4d2c-2072-08d931aee952
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 16:42:36.0201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkOQGwcl+JvzU8FpeevtOWNbRsw1JLP4WK9Xan3oml+dXbK06WOhrRX5z3l7x3xsdxscPBV4BogNdB08bSkUyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4671
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Refactor common code to prepare for upcoming changes.
* Remove unused struct.
* Print error before returning.
* Frees ACPI obj if _DSM type is not as expected.
* Treat lps0_dsm_func_mask as an integer rather than character
* Remove extra out_obj
* Move rev_id

Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/acpi/x86/s2idle.c | 67 ++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index da27c1c45c9f..c0cba025072f 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -49,7 +49,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
 
 static acpi_handle lps0_device_handle;
 static guid_t lps0_dsm_guid;
-static char lps0_dsm_func_mask;
+static int lps0_dsm_func_mask;
 
 /* Device constraint entry structure */
 struct lpi_device_info {
@@ -70,15 +70,7 @@ struct lpi_constraints {
 	int min_dstate;
 };
 
-/* AMD */
-/* Device constraint entry structure */
-struct lpi_device_info_amd {
-	int revision;
-	int count;
-	union acpi_object *package;
-};
-
-/* Constraint package structure */
+/* AMD Constraint package structure */
 struct lpi_device_constraint_amd {
 	char *name;
 	int enabled;
@@ -99,12 +91,12 @@ static void lpi_device_get_constraints_amd(void)
 					  rev_id, ACPI_LPS0_GET_DEVICE_CONSTRAINTS,
 					  NULL, ACPI_TYPE_PACKAGE);
 
-	if (!out_obj)
-		return;
-
 	acpi_handle_debug(lps0_device_handle, "_DSM function 1 eval %s\n",
 			  out_obj ? "successful" : "failed");
 
+	if (!out_obj)
+		return;
+
 	for (i = 0; i < out_obj->package.count; i++) {
 		union acpi_object *package = &out_obj->package.elements[i];
 
@@ -336,11 +328,33 @@ static bool acpi_s2idle_vendor_amd(void)
 	return boot_cpu_data.x86_vendor == X86_VENDOR_AMD;
 }
 
+static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *dsm_guid)
+{
+	union acpi_object *obj;
+	int ret = -EINVAL;
+
+	guid_parse(uuid, dsm_guid);
+	obj = acpi_evaluate_dsm(handle, dsm_guid, rev, 0, NULL);
+
+	/* Check if the _DSM is present and as expected. */
+	if (!obj || obj->type != ACPI_TYPE_BUFFER || obj->buffer.length == 0 ||
+	    obj->buffer.length > sizeof(u32)) {
+		acpi_handle_debug(handle,
+				"_DSM UUID %s rev %d function 0 evaluation failed\n", uuid, rev);
+		goto out;
+	}
+
+	ret = *(int *)obj->buffer.pointer;
+	acpi_handle_debug(handle, "_DSM UUID %s rev %d function mask: 0x%x\n", uuid, rev, ret);
+
+out:
+	ACPI_FREE(obj);
+	return ret;
+}
+
 static int lps0_device_attach(struct acpi_device *adev,
 			      const struct acpi_device_id *not_used)
 {
-	union acpi_object *out_obj;
-
 	if (lps0_device_handle)
 		return 0;
 
@@ -348,28 +362,17 @@ static int lps0_device_attach(struct acpi_device *adev,
 		return 0;
 
 	if (acpi_s2idle_vendor_amd()) {
-		guid_parse(ACPI_LPS0_DSM_UUID_AMD, &lps0_dsm_guid);
-		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 0, 0, NULL);
 		rev_id = 0;
+		lps0_dsm_func_mask = validate_dsm(adev->handle,
+					ACPI_LPS0_DSM_UUID_AMD, rev_id, &lps0_dsm_guid);
 	} else {
-		guid_parse(ACPI_LPS0_DSM_UUID, &lps0_dsm_guid);
-		out_obj = acpi_evaluate_dsm(adev->handle, &lps0_dsm_guid, 1, 0, NULL);
 		rev_id = 1;
+		lps0_dsm_func_mask = validate_dsm(adev->handle,
+					ACPI_LPS0_DSM_UUID, rev_id, &lps0_dsm_guid);
 	}
 
-	/* Check if the _DSM is present and as expected. */
-	if (!out_obj || out_obj->type != ACPI_TYPE_BUFFER) {
-		acpi_handle_debug(adev->handle,
-				  "_DSM function 0 evaluation failed\n");
-		return 0;
-	}
-
-	lps0_dsm_func_mask = *(char *)out_obj->buffer.pointer;
-
-	ACPI_FREE(out_obj);
-
-	acpi_handle_debug(adev->handle, "_DSM function mask: 0x%x\n",
-			  lps0_dsm_func_mask);
+	if (lps0_dsm_func_mask < 0)
+		return 0;//function eval failed
 
 	lps0_device_handle = adev->handle;
 
-- 
2.25.1

