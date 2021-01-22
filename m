Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E33300A9C
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 19:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbhAVSFd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 13:05:33 -0500
Received: from mail-mw2nam12on2063.outbound.protection.outlook.com ([40.107.244.63]:40449
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729309AbhAVSEm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 22 Jan 2021 13:04:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xav+grgVS2bXF0n/QywQCAj7vJnJL1rh6zi+Dzh19OAoeic2zUBjMD35Z28BWxqql9V0sUt3eaZkr85c2aVutal3NuSkX1BI3VoSMqWsthBr3EbF8OgsBJWPL5dj8LhvpFFrydJ4l2iodaumsK/Hi9NwEn70/S5nrD0NjvcjPET2moYNUj9esWx2pzOfvbo3ZZXp2niyQplNK3U4IpYF6+0QS7vXgsnyBXi97oMbIOrE/cDD+Nt/W1QgtG71K2BULDaEfJHgYDmMwhP4ZwUN+o8svFvhq1YQ4o+CN8zhhq8l8i0wTP5dV21vF77aGh3LQDmt25pjHqrmETfijjyq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFiLuNTtMo4Z7w8jm7baXDwpEng6CQGMtjShtLB9E1k=;
 b=JVxDLEe1PWAgcSXHSbArI3QSEpfMIDSfl6JaMwDCKFeyRwgNPYtlRj4K8OEoTxv2gT2+NA/NaCAtHa9uBZoQbOknsNqrt9HNcU+9kIlvoLC9xb9EwvPd4mlB9ABSoXhljBvd17IIfAeK5A5SpPOzaykyO4ImFKuAn9wHIL0US3Lxj6Ii+b9vVsa+kL2jDxyL5h73hunOvgCnhy+/5na2tlA5+8En5IVZaU9T01BgTnzA1PmJ9FN9NyhZ3nEiAkdbEiKWDimahWfxWskLMNrA67FZOxHMroAxCoHuim3ptlK+qMFPm8Pg55/TE6LNHl0acwqP6RMTlI2oeEtT16fbbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFiLuNTtMo4Z7w8jm7baXDwpEng6CQGMtjShtLB9E1k=;
 b=xGXY2bE+17b1VBDCwEdwNLwidsFmyxpYpB7qWySPOOwcZdzrbMWG7n0jEZgri3IM8MxQac2iBqfLPKroSzkvAlIyhChEgUcLMQStW+DtUM4Kjf9pMrqQmauR1gINNCWMSZuMzfWdCnBC/WvZD0yN++U/BOc8qg8x5QSSgUPyLjc=
Authentication-Results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4512.namprd12.prod.outlook.com (2603:10b6:806:71::9)
 by SA0PR12MB4509.namprd12.prod.outlook.com (2603:10b6:806:9e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Fri, 22 Jan
 2021 18:03:36 +0000
Received: from SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4]) by SA0PR12MB4512.namprd12.prod.outlook.com
 ([fe80::ed7d:d788:82d2:edd4%5]) with mapi id 15.20.3784.013; Fri, 22 Jan 2021
 18:03:36 +0000
From:   Terry Bowman <terry.bowman@amd.com>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, yazen.ghannam@amd.com,
        terry.bowman@amd.com, guohanjun@huawei.com,
        colin.king@canonical.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jon.grimm@amd.com
Subject: [PATCH] ACPI / APEI: Add is_ghes_type() to identify GHES sources
Date:   Fri, 22 Jan 2021 12:03:22 -0600
Message-Id: <20210122180322.1720413-1-terry.bowman@amd.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: CH0PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:610:77::22) To SA0PR12MB4512.namprd12.prod.outlook.com
 (2603:10b6:806:71::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolxb27ehost.amd.com (165.204.78.2) by CH0PR04CA0047.namprd04.prod.outlook.com (2603:10b6:610:77::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 18:03:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ef48018-88e6-4e3f-43d4-08d8bf0009fb
X-MS-TrafficTypeDiagnostic: SA0PR12MB4509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45092295EF5CC7519B96C93083A09@SA0PR12MB4509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:288;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMRSLniZt6XthhhOU0HS2mAp1tCh9sezbXeFxE9LAkOAgeJx+OxqDV2mLUoeusc0F15hHScoyyIIIAmt+Kbzxr+rsNPwrcfLmp9FUfrZxy/85tBLyc91uwC3N42C2SQtU/hvFb2xdUan0NsTT/cPi6/WHz6BQtzuacSZQGeSBrJktaE1ZetzqOzBR7xAF0Hd887yFfDYZ5ybrV421G+ZW2MDKDJ/v6kRtRfIKoKN0gkTYrwWumLy5EqSd+hECnqqdVOYYltct44Omyd++TxikSXKa5pGXXMAl2OISK9GNFsexlfoD9ZAbKvM9EMzdnPafBHxGzY3IuC2I7XBKwsKZHRflX4KwZzdSjzUcs5NHpVTVf+J6jimc2wWmFhEiqrilLAFugZV9zQdbvKHX3glIRDTlEuXBtHAVX9hewVTRRJHfN6CcsbOgZiycuU1R0FkWaBceirejc62zwpZz4Upv7OJrOF9dN2UYNCB2TKoKa0epHAo3xUmXHHDHg3pcJ0JmfMA2yvgT0rvoMP5Ol1rUy42WLYQmir1gTxOb76rMcSbmZ+8S7XCabr1Pc0WjQPd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4512.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(2616005)(44832011)(36756003)(956004)(86362001)(186003)(8676002)(16526019)(66946007)(66476007)(83380400001)(26005)(66556008)(2906002)(52116002)(7696005)(6666004)(4326008)(109986005)(478600001)(6486002)(1076003)(316002)(8936002)(5660300002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?r9HwTS8qTLd855f6iHg6cKZ1pi7NsUfP/AXMKMZOfaLEcW7+cT8Kd1Al22PH?=
 =?us-ascii?Q?oXWiRT6VgK8EjfJ9N07uhFe+q9IAIwOCvPzhF6VN1K/fN1+fhmij6l80Tysc?=
 =?us-ascii?Q?s2q4Cgayj5WNnoHqzdM4BM/D85rsnGixVOD2LrC9zMOcYJh7z/cBpPAAoYtY?=
 =?us-ascii?Q?huTGJn2TnHtZ2z76TB19rW42A9hCQDzCAtc9UIEnoi0CgSB7xP4tr/QpLyQQ?=
 =?us-ascii?Q?td/hqX8l3lcsFoL+/OspI5QLO2OVjbBIQpX6zmfpZuJ8c8ptJwOIRSiSncml?=
 =?us-ascii?Q?raB/m3qHgcpOH9cBKRhFBBLLKkAx+ogdV9tMazPZqGY30IPWah3AG9QO50I3?=
 =?us-ascii?Q?yKb/OWETVr8rRfWCY0fpQ5deRG+svXsxbQykz9oGbnuZwGQxnA0sGgoGwcfR?=
 =?us-ascii?Q?VLsNa5jFniUVLf//50iVp9FhMv04umyVP5S2Rj52Zo3aWDXN95LwkxGhR2xG?=
 =?us-ascii?Q?2txX4gsgWeKez/FqbWeI7FeaKMuEVlmv8bHqfNbdhZKWyObqc/8INL5X7ceS?=
 =?us-ascii?Q?iR4Nw6PZLA1Xi96MB0/KCRr6pF5sWa5S/6FrGeNRpOUOVwbKdM0vkDZ/2/mI?=
 =?us-ascii?Q?kJ8TdCwBwyjYE4JTPbCPwUXiUHWiuua8bxb9yCqIUujSHLuJospp7ExBgQhM?=
 =?us-ascii?Q?ODV02nUoB8LyZGVbmYLNds9hCvBSCTDot0R5DRgNxxjZiYknmU6xk96OUFp3?=
 =?us-ascii?Q?gq+mEpTLuIyIoENnweCKwsEoulp4ZNVedjj2Jh7XzEIL0x2Q42WajesFEesS?=
 =?us-ascii?Q?B7yuPGu/qEsD4qwWSNB2vuzAyAn++rUgDN3JvWppqgDg6U8vphsh3cHiNmPM?=
 =?us-ascii?Q?H55GAnAS0OK6WpmV0ZtC1PSLKgij14isblKC7N1enPCXDZP+MKAObz22uufB?=
 =?us-ascii?Q?AyOV6h7HhYN4cCoFXg9C17S67aBSZKJlnYt6s2nFhCsDLj2j2nRXFQDw7LzU?=
 =?us-ascii?Q?ejeTfA2RdQ0fFPkpgMwRFw654X5v7lyRdzvjdx46fFQ+n9+eDlrUxV3IC5Gv?=
 =?us-ascii?Q?mkQM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ef48018-88e6-4e3f-43d4-08d8bf0009fb
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4512.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 18:03:36.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYFqWyQZEmOV+W7I4mAuiSXBlWCeoUP68K9Q8r9jodguIoILRuvuRhstI078C+mylSQOi0CF7b0egAroq6ps5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4509
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Refactor duplicated GHES identity logic into is_ghes_type().

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Terry Bowman <terry.bowman@amd.com>
---
 drivers/acpi/apei/hest.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 6e980fe16772..bd702e0ef339 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -49,6 +49,12 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
 	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
 };
 
+static inline bool is_ghes_type(struct acpi_hest_header *hest_hdr)
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
+	if (is_ghes_type(hest_hdr))
 		(*count)++;
 	return 0;
 }
@@ -153,8 +158,7 @@ static int __init hest_parse_ghes(struct acpi_hest_header *hest_hdr, void *data)
 	struct ghes_arr *ghes_arr = data;
 	int rc, i;
 
-	if (hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR &&
-	    hest_hdr->type != ACPI_HEST_TYPE_GENERIC_ERROR_V2)
+	if (!is_ghes_type(hest_hdr))
 		return 0;
 
 	if (!((struct acpi_hest_generic *)hest_hdr)->enabled)
-- 
2.27.0

