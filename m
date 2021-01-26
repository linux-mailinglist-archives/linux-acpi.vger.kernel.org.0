Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFCA3046F6
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Jan 2021 19:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390119AbhAZRR7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Jan 2021 12:17:59 -0500
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:49121
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405815AbhAZQdU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 26 Jan 2021 11:33:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGxIOg+kcf5ynst5k70KMSTiFKKhX4fEw1XkMBjlSS4RrFoqdfwqbqrtuYQhdcB6Npiwp/dX4XlRghoGH97ko+HnIA17Z7flpem4sDCR5l3RZ1ZeAZ0HV9zXKnfxNAjVaFCJmpde4bKm1vF08/dCDmVeq2a7CX9bRdtm2w5eJyHxsT1Xw5XKOGO2cO2Qd2k0aMrZzCt06hb8btKDIY+j8RiStdEETrUAhTTHtasY0nyqZm4fBj1Ei2AdIQIZn24ETvOWaBx6gOzEbV3LikGS383uvLem2TKzPbe581tKNa4Ib1ioK1fFoKmsCHdkhCJuEU0VJpajBGnsT1RNAG8x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa8AqGSYJj0vazGQE3/aYNHkELCzmTelROBSMzIlRKA=;
 b=B5dEjLyVHddH5PPvtgSh0ekjnUErg/pBX2BKS9eTIuZ6uRtnQn873NMMl8ZYZ30+PH7P2OzphgE+aSkBsPD141zmhZ7putRvoL/cj2ypQURN6lW3B4LCp1dg6lpGFlTbyaqQQ5UDuH0jE30f2Z8ejodepUKN/l62vsx7YQflEpGXIVMjzze8aW1YayzlNLNNxSouJes9DEx+HWKCHNkQ5OOQeJ10y5zTQgU9ruRo5Am7iNJ9y2nYhf65Zh+GgX7rvtL5hwpmhsFmGv23qGary3cP55OdhCsFRGwkrQNPf7vXhzsuArOjnBJH+vl+wvn61Ik22O26EirkTByP0xi1Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sa8AqGSYJj0vazGQE3/aYNHkELCzmTelROBSMzIlRKA=;
 b=j1y/zOzC+scftAEzxHrBa16JY+uIvocmtHkkmLojHjAJ8xcT9z4AgIHxFqbFeZxWHAscbeDoWD+Kr24JBijibKexNlIFeohN7snzco+kJdB+Gpn1OX7evgqyAEYITFuG13OnR+yvHYY/o1U5Izpz35S0/MKPhuuo1p1CGjie/7c=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11; Tue, 26 Jan
 2021 16:32:26 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4%5]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 16:32:26 +0000
From:   Terry Bowman <terry.bowman@amd.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, yazen.ghannam@amd.com,
        terry.bowman@amd.com, guohanjun@huawei.com,
        colin.king@canonical.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon.grimm@amd.com
Subject: [PATCH v2] ACPI / APEI: Add is_generic_error() to identify GHES sources
Date:   Tue, 26 Jan 2021 10:32:01 -0600
Message-Id: <20210126163201.1433505-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SA0PR11CA0138.namprd11.prod.outlook.com
 (2603:10b6:806:131::23) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by SA0PR11CA0138.namprd11.prod.outlook.com (2603:10b6:806:131::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 26 Jan 2021 16:32:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb746909-0af8-403a-fc1f-08d8c217f759
X-MS-TrafficTypeDiagnostic: SA0PR12MB4431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4431DDBCB46A466754598C8683BC9@SA0PR12MB4431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9J7AUbTu7OQ1NdzmXjjhadTNB7+2dxuGKcIT5+6PJQv2xxBHEK73w1+a53LlHFHMuUFkM7k0ogSxKXCioLztJeV3Tuw4d0arH7Zc3NtcIyhKXZVp7pURpdLw61OPykvfscdulQRUTiGP8kcdps8u+xCQljU/Dkt1Erg5J3rrfly6vVBWwvS2CuAWF4koA5wuUbGFp6AIEBBYmVbuqAXeN+SNaD871JQovwZvSrOm0pXAluQqZpmjZiCPEbDNz/VoWx+SIPT0p4E7o6BWJS+FBe0MVLtjIwuDUJtHw+wSOLVyaTzTsIYGzhrdA+hXV/PyekuC0ZBoM3uhEEoCL5YvriOONVLLUZ+O2n4ySsR1AsMU8LZ49Mp502GvbUEEny/kRSEeaIo0j6PaoAf1sXq3mq9ydD1TiUwMLnkWdbFQ9CVqJKN0qkQ4YuqflNq99GkYJiebkU/ioggMAsr9DwKR0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(478600001)(8936002)(66946007)(8676002)(7696005)(52116002)(109986005)(26005)(1076003)(6486002)(86362001)(956004)(2906002)(4326008)(5660300002)(186003)(6666004)(16526019)(36756003)(83380400001)(44832011)(66476007)(2616005)(66556008)(316002)(41533002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tNjU7uP+PiCfRx560FB28hZm3c5opMqNr3MfRUTFabgnI2TE1lCvfeBb/TbL?=
 =?us-ascii?Q?jqVaF/igY1sFC4hVaX9smLADNxXOAczlE4Vy8AMJDSdU/sfMBVcQmhZJi6Hq?=
 =?us-ascii?Q?nsnOZO4mDILKcHq7YnO4IWaZXfaosjQvCtBjAZNQz4CYKI0k9O+hZb21Yilq?=
 =?us-ascii?Q?g95SoQ2SSWvLxqESucbny0iCfO4CpozTPkPCY2lq//U91LzRhUUwoyfduEsk?=
 =?us-ascii?Q?PNy5FowITpLItkDCcDGx04d1Suw+fQh9j0Vz0DcVSjzhC+KYuFrefqP0Gc9J?=
 =?us-ascii?Q?KQBIGkZpU8Tj8Ib0dHzbC41WSQkvkmvZiZUzh4kK2XqdGB6RPSZvSTOUyA4Q?=
 =?us-ascii?Q?zOVCas/QthR1saVk8NQaqAmDi3ZVW76TOVeG6MnoPRaeu1f3dPfvavjoOuo4?=
 =?us-ascii?Q?utUPt7sBEXXtXQIAjtkA6rfa71lJvT7MXftH+FR0fsjViKTUnn3PtonIl3UZ?=
 =?us-ascii?Q?P8o0umykbumUFs4uRZjubHsjzZgcVL/gRRgSiDzq9VNeqJ1Pz7dxeqvFpjWJ?=
 =?us-ascii?Q?y6UVrFiSpukPG1V9RTGk1QSEPDgqIPiZ7e5+BJpbG7gclOW275BKsNYtTaAm?=
 =?us-ascii?Q?BnKf7jUfC3pDNV7SJoenDQrzWBkoeElzubaqz8YVLCOwLN6AmJ5CjEfcKbX/?=
 =?us-ascii?Q?6dLrZiWvNKB+ooenzkDJxCnVEB73SNLIdgLgui1nws2D+x0qNLXt1JOqzkbO?=
 =?us-ascii?Q?QwMxzw+at8NtHk/QT90t4mkNe4yJGgRMgvdOiI5DvFHf/jSYUuXe/lJZpAjH?=
 =?us-ascii?Q?MuskAG+BhT40sfZvESIzPf7Ybgc6dGrc3NP6WRzcen1GD5LPVrtFl2faI3My?=
 =?us-ascii?Q?21oTt0iD2+aC3rLMiDGW9YSMEFFyWF1zjAy8TaTnjv6jE92p+QZRNoY2r051?=
 =?us-ascii?Q?Kp3lBR+ADPuFIILGpDptwAM8ZIIBGlDPxLZumcawVrMe27ErxOW+0uyG72ho?=
 =?us-ascii?Q?BDKJRCJFbbdLDdjEE7UixiWuVLGNJkOiQwANwPbSkxkViNR+jhPphWsCmprT?=
 =?us-ascii?Q?y0qzC0VB+4frMFaNqeBrlJ09JfGpaiai0dEf2w2P/efBgwBQeUduoSZSRCxK?=
 =?us-ascii?Q?z73NAfOk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb746909-0af8-403a-fc1f-08d8c217f759
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 16:32:26.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xAGmVC1Em2mGew5IRh/V4aWm2or53egOcysN8Wx8cr/EngzVAq9Ozd98guxuFEPSIjHD7gqZqvXbAnrhGROvnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Refactor duplicated GHES identity logic into is_generic_error().

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Co-developed-by: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
Changes in v2:
  - Rename is_ghes_type() to is_generic_error()
  - Add co-developed-by
  
 drivers/acpi/apei/hest.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6e980fe16772..f220bb00e91b 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
 };
 
+static inline bool is_generic_error(struct acpi_hest_header *hest_hdr)
+{
+	return hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
+	       hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2;
+}
+
 static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
 {
 	u16 hest_type = hest_hdr->type;
@@ -141,8 +147,7 @@ static int __init hest_parse_ghes_count(struct acpi_hest_header *hest_hdr, void
 {
 	int *count = data;
 
-	if (hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR ||
-	    hest_hdr->type == ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+	if (is_generic_error(hest_hdr))
 		(*count)++;
 	return 0;
 }
@@ -153,9 +158,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 	struct ghes_arr *ghes_arr = data;
 	int rc, i;
 
-	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
-	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+	if (!is_generic_error(hest_hdr))
 		return 0;
 
 	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
--
2.27.0

