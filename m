Return-Path: <linux-acpi+bounces-12711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E6EA7B23F
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCF3B901B
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54261DB363;
	Thu,  3 Apr 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UVwjIGps"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3521C84DD;
	Thu,  3 Apr 2025 23:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722037; cv=fail; b=k1QhgplczMxS9OE8OYOXDOe71U43Dagq6u9RVnyQbs34lqCKGL7BCykgLo7Rao/EENorCV9C+Q9wUVp73KwpJ/8/YeknFAFTCxYJ4N++HDprJ5dMrlvQtyoxaC7RyvD/xGkx8WvWVfPfhgOk+1K1wqfcSUjzZ+UMpt0m6LBUX14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722037; c=relaxed/simple;
	bh=rh3LiFDqONhqT7lgtvmvw+uS8ZAgywTqecr1wuFjXOs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pCiYtAI34Dh19EvZ6ftO2oOV4UNu9OwX97t5q4hkqd8oEp9IxT8cUgHhR4NlnxjCfrTJLigVE+8CQfMMll8mKsSpP8b+x5ugdKKTw1NHJ4rtMun7ut907iLJbj8J9WsX2dzybm+t2h9XOYoxbLz9XmkYRtgw6zrwqazRaBnrEOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UVwjIGps; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMNlPMCu6c68DDsNnjdNUDsvSBm7l+iMNfHb9V1sE3yL2+agp58V0wfVLkku1S/KzWd4/f3lF7sBEcmZP7OkgNaNSfqFVPYzSTpl8FDQf1j4ElYqi+jzRCzhMrctdDJJskcgCPtP1EwVjRM68gfgt18x8X7F129WhVDSPpWANEGcnF8JRQCZFeMWIgM7sSu87dLk0S1h4XHqHZCKNl4HeJCdhz8uKcuvbsAUFvSUnw0bvXE+coIMvflqCNtSIuIGCbhXsiUfsZTW4Ll3E93xQ2+VGgP7zapfeFhHR2STGjOKQVY6G4e0bB64LluQE8/nUpwDesvU+nzMCOWauDyktA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idYXSRMnu88WvOUoU1ZQinvDxg7UkQZgSz5uVYFZ2OY=;
 b=MFz2U+pQuvQo2hVyChzogkuthiclvWsFfBe+hUZ1dzafJ+wrlM01inC6e2mff5vcIRuKZl6DWjp1L8gD+PATZGKRIU8fM5YymTuJ6bGCErxTFHynTxNENWxs71jFuWQtv44Z1Ei3fivinivauKvBVM7uG29L2YwSwfAKQNy7iY4x51F53HlpttTz1UbgvqFjGYqRqe3aM82v+z9U6Jnc3OGSmjJiCyz8HWdV1ROghnpwMIxvnoQlo89fvKgBy71EyMZFqHPPpm2YfNXwB+Teue1zFNf31nDCEwotAl15REeyQHTjmOI+wgLzKBoSpiRZoWLcrlNtiL7pVo4etZHylg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idYXSRMnu88WvOUoU1ZQinvDxg7UkQZgSz5uVYFZ2OY=;
 b=UVwjIGps16/QE4PkTkDbJpHcYaX6y9OwOB8qMfiBle9aMS3n+L7jh0GI4F94ucxOTIUnBPcUHEopTY7jf5Rc4y9Q2S6FIk/hgMzS/a2l8fAQBzk326fRLKdokjoaIWpc9wCP2W7ZxBYCQ0A8v4ORuEDvY/pqSWXO/zTME2E9+HM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:52 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:52 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	dan.j.williams@intel.com,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com,
	viro@zeniv.linux.org.uk,
	arnd@arndb.de,
	ira.weiny@intel.com,
	dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v5 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Thu,  3 Apr 2025 16:13:31 -0700
Message-ID: <20250403231339.23708-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0246.namprd03.prod.outlook.com
 (2603:10b6:303:b4::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 73608f04-2340-4285-3933-08dd730532eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7soxUSA3VfpTQXpzdPbddEJAQ1TaWsUacfIlmegcgyrC9MP9OYCdMHltJFD4?=
 =?us-ascii?Q?ka1IkmsVzAC8f9WXYVaHy0gRHz5Jox4kNkn3TQcbg+GGUnbMKTqpjtfuT6d3?=
 =?us-ascii?Q?YTM4ByRaxTuc2oW094YAvqPXAea5lVvgnvh8g0ruQ1+qimGI15lxt10blqr9?=
 =?us-ascii?Q?0gbo1nFe/AvuSShKVRwOX7hIAH1yc5mtqRlsuUDYN7S+Tjct8KSN6MNs5z3L?=
 =?us-ascii?Q?o1o0FB0Ijzufv3n+pl/C8juvAjZi+vHsSPauW5yj0PgrZt4mRFRDKZT3Qbbp?=
 =?us-ascii?Q?bJZhXx/a7uGrkOYM8CYyoNJWlhk+GWhLziHz4VOxVHRTQHw3ZTBVJZ+iY6A8?=
 =?us-ascii?Q?r3c6FUlaBBg0FscM3xG/UIG3ppW3BVdkzxIC93cUGQTw/eADsui69by+ONJB?=
 =?us-ascii?Q?znzBdDFt/iy5wjpPSmL1FyJOR2MFtymbcKZAmmENnH6bVAVpb66PbDmzaP7n?=
 =?us-ascii?Q?IMuEr2JU/AmaOa7hyvrQDAXH3w3POv/jItPxauVHPXb40NgmyqMTAuH+gCJD?=
 =?us-ascii?Q?1aMCab7GAmqZ4JocsRxH6rANm+VW2DNXyK8UKfb53gLLY6Ctq+tS5Co/23mK?=
 =?us-ascii?Q?XK0CibMuKlYpckjEoAbNxK+XXzkmXIjZjNyVTuLxxguaPuhGKI05/UF6yi2M?=
 =?us-ascii?Q?qnPWREc9MFEfvtrfP1qyKv2Wxmj6C926GO1dXMvUJK7Bsutqf5/FC9+5f36j?=
 =?us-ascii?Q?i+YbHCfR6zrd8gph6BRIL+OtPaa3iRap8NSLTdWbnpjTYyAXu+BcClWjoSSf?=
 =?us-ascii?Q?PPaOlRg2XfSlkNnU2+sIPTRYZlQOvoATHyr5yWP57BG/sEazw7jpBtoN8Zkw?=
 =?us-ascii?Q?0LO4TzRxP2x7pqZIAQ3hDsmej01iYb2Dg9RQ4sgqTyPwqwirDQDi3TnPycLq?=
 =?us-ascii?Q?8CxGd26Y8PH4oi30w+iKvotwX0oBh+bOjNv6mCqkkS5A6t+fCZ6AtrabNOyA?=
 =?us-ascii?Q?fo1Z4dBRqMZ5SsOnKMbT3JwNeLv4inVvXWA9TaCBAE28IEUzfS754y1WLgbq?=
 =?us-ascii?Q?SSTD1rkWTwcgMUm/76gzfG0OgdywqTXHqQx/rfa0Z6LvhotYVxyyDelxgpvT?=
 =?us-ascii?Q?ZPyKlyUtSHu8ZL8a914BYFqyIG/28FYuEUXdXjObqjvUcvDJSUWTwR6Ixotz?=
 =?us-ascii?Q?LTg3AEqvlVYFPiMhMQDfOgUZu6OY2LEgPVbfV7UOmLvXdPZ0wT/HEv8EF5Ok?=
 =?us-ascii?Q?VBlGu6Zl5eeRJ/hQ1z8csw0ZIWXMN6ZMMcacqSatqSzLBzwEY7ASpVqzweQT?=
 =?us-ascii?Q?xvIa8ERABkP5l0Sp2KEXtB7iCmG2I8nXcKx4S8HjScY+Ir7rO0GX2S2lVQCs?=
 =?us-ascii?Q?2oB9fYBBow+hoKpa7lT8KBE5Q052K1mA8w6V9eAHdiNIgQcnjfIblhcKTWH3?=
 =?us-ascii?Q?YcClRIHqMMvrLvdL+83AHO7v/fe6RS8lIr5IgWv0XWAkJMKAiImjLSup4RBr?=
 =?us-ascii?Q?U6ImLg5uz7HUm70YRVXB5ji8ZYqQeldn9xoRhV1yXbGcyJy3POYyxA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Of7W6nMWnKKzMC9dkkQiJaXA+m7kwucKRCcOF62nBH1mF34XsM+ckHjgKKBq?=
 =?us-ascii?Q?S7urnmBBJxmQmH33SZfr6eHUfrzLooOlMoNuyZazlZeF1Yb4Wn6oHZgqdQrL?=
 =?us-ascii?Q?RvWoJuIkhrFmB57zHJAiGz6N3xIqe13OGtNJgoUGvFkIaPybeCW33PDpsArj?=
 =?us-ascii?Q?JF1kCMMiAzLgt0eK+Dq5HIIJq4FNOs1nqE616d56f2pJfSUS76AVpiJ/Bpwg?=
 =?us-ascii?Q?0cd5iL7VUBtHWIJ4L16rnRdIWHfiPvhOFbSlRoT6cauNYxgRiVyQw6GzhQ7j?=
 =?us-ascii?Q?1tiOlfWcgpmJ9s7aAz6XklmD3LcewMvnw3EkHKwcrZue7/GK3o68wJorIjOj?=
 =?us-ascii?Q?6MbawRiErSV03Ypw/dEUeSYHr4zHTJHf/VYZ7OJ4LoBsde/k+EBWKQiAj7on?=
 =?us-ascii?Q?EneCrXgE+PKB2WDvJ8YqJWrmrjHV2Goh0w9RVrijRRb/MgVG/iWn7kz5XBcB?=
 =?us-ascii?Q?Qk1Ozrhkn9Fj0ao9rigbANQa1b38Tnwdaxd40ZW4HDJTdTsvKVbQQS9TrfGd?=
 =?us-ascii?Q?/E/JOd0hjkFGXY+yuDOai/c9DdapL/xGr4qmTVqVqRP7Fn4OG90lVrekzckS?=
 =?us-ascii?Q?cYwbYWGfAo1jaDU2C2YjjCmoWg/Q/onYAoIzc+PkobX1Aecv58Wf0NH3N8LM?=
 =?us-ascii?Q?TgTSjhPrnNK6yf+ZP+jG0bDqjORfP7u8q7HsT0T4IRRL9qggxdXtGbHWA+eB?=
 =?us-ascii?Q?JCYS7CssxtrDq2EIfMtM/rIwovgKsOWM86ZU/bJmoCkQiEqD3w/uyfJ9PAZT?=
 =?us-ascii?Q?oaiITEZkRY/BXukKJ2dp5GCyZteYgS2GjESedi7nEUeW4O6jpabHs/oKLXZg?=
 =?us-ascii?Q?wcvrpe4rBV5RGdPKSCttM24z38Xx6DViG4N5f9DSJ+o1I7G3CRTf3d24jPZ7?=
 =?us-ascii?Q?5relwmO2ea9bVeRJ7I98nEyeuM5geBV+kJYJVeEDLShmZCX8fCHpdObXs6JV?=
 =?us-ascii?Q?EZz4NQ3Lqn1RRHA0D7XSVkIOkxkIzl+3jYJUirRLB5jjMWeRExzlKYquYJ2v?=
 =?us-ascii?Q?zcx2BBgsPA0b1xDTHRwDM+2pvQU8KQCfAOfAiQ+Fy89HzrWyDoBPXMRy3NZW?=
 =?us-ascii?Q?Z1nsF6h5g7xns4rdzSpMkbrbgcRrp1MU1kkhSHPlfTYrwyXIlqdaTQyjkAGD?=
 =?us-ascii?Q?AYFiz3YvoJ/hDdO/Q/a1WStDltsPRFdk70AIdoTUkFaoPg5Jj3MudqQNP7B+?=
 =?us-ascii?Q?PnVbkkYSgZshagpakZ+hnW89Lg3i4ibK/dWbTqUlEM4Fe+dkoinhtt9RVvkq?=
 =?us-ascii?Q?C7bFjqWIzIohDCY9cxhWrKLDaS4GwiEEmbZ4z84mi1UKq9cd3EMqCZ2UxjAE?=
 =?us-ascii?Q?41tP1JoKSvHxL+I3Iu6OaOAA1LxDZX7c8pVUBd+sS+vwtWvNUzrOAUx9LOpQ?=
 =?us-ascii?Q?B8KrvCb1mbbG9AzAEkBTq3Dl90rbYvS+8c9pA8dKkgLgvr0p8dgiLWlCKJ3n?=
 =?us-ascii?Q?RarjtHCvoDy+0njeGeRNQKn2bL1yVHOYP+0bMWWfk87vixfYagm3AdqKqL83?=
 =?us-ascii?Q?rrDngwZV9GLI5jNMsQXU+OPb4lrDWc1/v1c8+rrQKwH3HKEpgWTukSNTFX3e?=
 =?us-ascii?Q?zqLtsmAG3TOy5lZzQlyA2YkxrEfmW5PEYDjAPJNYBsIMyli79LPRy0FBf3h3?=
 =?us-ascii?Q?ZH3vMsrfv1nhEwMTxYsgpUE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73608f04-2340-4285-3933-08dd730532eb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:52.4791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uEJhdPyWtKIggscHYG1kXOdQJ8KJ1km34atBpKLnKZyjpD/pP4WFhMd37MDhjxuvZkRJPGu8afx1y6zrDYckFwj97ZhiExY9FXw+HVwRJCMLT+YBgEzjTD5wTFWYY4vX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..c701c434976c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1024,18 +1024,18 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
-	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+	ACPI_EINJ_BEGIN_OPERATION =		0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE =		0x1,
+	ACPI_EINJ_SET_ERROR_TYPE =		0x2,
+	ACPI_EINJ_GET_ERROR_TYPE =		0x3,
+	ACPI_EINJ_END_OPERATION =		0x4,
+	ACPI_EINJ_EXECUTE_OPERATION =		0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS =		0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
+	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
 /* Values for Instruction field above */
-- 
2.43.0


