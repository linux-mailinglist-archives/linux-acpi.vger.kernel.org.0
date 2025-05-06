Return-Path: <linux-acpi+bounces-13514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D33AAD033
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2388F7B4231
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7D9240604;
	Tue,  6 May 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="biAHIceh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022121.outbound.protection.outlook.com [40.93.200.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520C723FC4C;
	Tue,  6 May 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567522; cv=fail; b=FSviW5yCOI12ocCwP4565voDWNGFOXNwPBkoSGVR2gBobNrzI5u4tDJTQ4lKkQhA+Uxi0SNnFCPrTTJKn9qHHk/sUbvVQN20DV3cgoNAdbzLKVFbVYMEDl+XAcFSBAanIxweGtrggYgqWeK+X5056noNzRpJDcjC+lBRMyPR518=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567522; c=relaxed/simple;
	bh=z+HTn4JR6XI5EG5Y5reC8jLcW3XwDSXDQ7TAWCZTV9c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xn92tP6wocDttSUIGRm0uwSoRB7a92KUpI2HH+Dy0XkLf1Kzrc4ZFXNNAATJh3KvFb9BSj4YEWaE3/jADTGMoC9BRE8KSB+tpnL83iGmEXANFxl2s3vtO6IcetQil3K0scK5PeBVqurVWG+TRS0VN5kJRlJm1R+YfTcEqPLoU2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=biAHIceh; arc=fail smtp.client-ip=40.93.200.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5IpkYiLrBC+zR3OE2xxZ4I7XfpNX9uzzo+I9yUZah8PRLUVhyPYEQtBXelwqZUnJBKim/eBMg/qhB1cV2qTSk9sAOB4Hv5Snsq7dNEe36Y5DkdUDmMpHOykcmromEFNtBImuRMxZphHAiIrvxmuVe0Q02l2KP+u3ChPpRWDZ0lsbaxzNX3ccSOIDIhTn4KjOPDiJ+kqEkPbF0ZR6L/P8eZErwufjvsr28PiqwIjMgiY77OwaeeMxQd7t6J9HZgjCleMY/BBiUcp+GPCzN1dcuH3wu+hOF6PBz8wToVKDPtY22ZjspQxWzQkAU3iX7MZKgSDz2DoJMhoPvhAYrQB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXDDfDFNSp5EwMGCIJzhjKP6n0kBSh15xXLsJdw2Byg=;
 b=j29TqInJWSyt4+aqv/R3JQypAsBO0r1JUzHpfacJxqBdtB/eywvQuw9c/VDBiJtxzeCmbvrvxVvQ6xRaOxTbbiCuoJ2zoonhvnmiAO0Tzxnz1zI90bzvZ0I8ciBwEwifGRC6C8fUmaPgKJwoAOEf4VtqxbiKwAvG+qlBR3pj00LfGF3WMTuneTjrMN9+5qawh47fnd3z/Z8VUwv9pS1Cpz3ZYWu8mqfDWsewj3ul8N1+EXISFVa1ytBtT5K/ztnmPQLEzd1G6A1njklAMfKD5s/M/koqTFpVt6wf7s7sN9TtGGEhTL/FgAHNlYUPRWPRhWunpyLsvyTo0f8e7vXs2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EXDDfDFNSp5EwMGCIJzhjKP6n0kBSh15xXLsJdw2Byg=;
 b=biAHIcehV+iL3ZvwZXhhZbqnGPMV7SVpyCjyxtwjTBf3GsY+ae6n6zvrdVXL9cxc4bxoh3AvoUiMvmyLYDRFCq5BIUh8L6r1kyMVe+1GOt/CQf+3PkHPRWW5SHEK8A94RoEF9PAJN8MG2HVRH3zpiWUmlBDOO02NRqXUealQLqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:36 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:36 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v7 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Date: Tue,  6 May 2025 14:38:10 -0700
Message-ID: <20250506213814.2365788-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA6PR01MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 4883dca8-837c-4d53-0c0b-08dd8ce65b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JaZse7fNb5XoG3/X21fQnQI8qFRwHlYlDty/94JoMnptTJ2vm98l48znGxvW?=
 =?us-ascii?Q?tya2MW7GPcmSRc1eh4HeKdUrNYo+XWIP7rFUi3mMRxUTewmS25mTfPTz8Vt6?=
 =?us-ascii?Q?puoV0ojGGl8SwISWH+BG1CLuK5S3TOHWCzhhew1YAB1br6EPk2wq2z2pllTC?=
 =?us-ascii?Q?NNC+0vkyU46IefOlCquehjPBuOirNvGhXSUQTg6s7E03f8SrtUiVF1G+FbXm?=
 =?us-ascii?Q?el3Sef55iYXuuHKSSKTbRHnpc0HaDV1wHCacwWzmQZ31p+fYLrqCwftAVtxW?=
 =?us-ascii?Q?WYicsNdW/qVIuaTzdVrCj4uN21JD1ouvSd8OY2Sm2jk5nrUwSL2nItGrpC2K?=
 =?us-ascii?Q?esRPTE/k0fFPKHWOph4lO86RvDgOw2hzPjqKOzaopEEcVoYPXvxBJ/s8qXYd?=
 =?us-ascii?Q?Fqyk8cN5MblrgMR/nPQMVt6T12Sy9lpnaTlZ9ij/eoKwhCB6W+w99K9+o3xm?=
 =?us-ascii?Q?nhcuBGcL6xFkEj6vEPIpIaXMM3cz/PmlShD8jwyA6oiWRz/jmr1oKAXlH+OH?=
 =?us-ascii?Q?KN1N0FQCJiHMmfAso2Oj7UC6QEBPFR23/dDiTP+2Vc1FGcDJJ9qey4bJIAUX?=
 =?us-ascii?Q?HyNT2RhU0jO8L6at0UkmP8gbx55XVBPTAlLrwDABTljA1AH2RnCrSdGjiaTH?=
 =?us-ascii?Q?fNjw9fT98usuu8ec7WdJXVfiSAkJ1QU8KONcD2oYiHyMHMRfR+vuy37rTD1d?=
 =?us-ascii?Q?C7EyCrE4Y97SV7B0D6bppFawywWcRngLCyxJM2zfWiPkM344qgW1vncPjM57?=
 =?us-ascii?Q?a4hiDlo2bfJxLrhHA6K0DgJOxa909GB7259qT+OUcCLj56CPfRqrkxWd7yDl?=
 =?us-ascii?Q?mbcDzzThDK9YMZ3JqyPVTWI3Hvus47LIbNEppEtyUqUgDZ+vJFVpR7z2HNwt?=
 =?us-ascii?Q?4bBGq4BdWDJD3eQghAn6rN3WWN+yb1YK7R0qzmaSB3vKGCZpLa74jG60UXai?=
 =?us-ascii?Q?T5UM2dN7h5H1/WSmCexDTpu5+roTlxO5M+zTG5DIK3k71zpL9kE44XzphTsO?=
 =?us-ascii?Q?hx4y4rJ4/Z9xHaUlUxTVG0ZfMEIz/66p5LptyVKUgWTkXz6/fgE3ofNzHBNw?=
 =?us-ascii?Q?O5hXFt3oSE9X9h5o+EIRTwMkU8ee2OY9PWaPtp7dEdc89vfgSGLAXoIzqZ0c?=
 =?us-ascii?Q?eEPW327XAQJayMSrI1aEDdNPwone2rj05S0VUpnMQfiT43plcC+2aHixR26T?=
 =?us-ascii?Q?lLEiwbnddfLQij4m4UU1uxGzUifTtyfHhYA0flvtpNAhmY4D17iNETXOMvzN?=
 =?us-ascii?Q?eXUdP3RpujgQ5/Nx2hMHvSh1fCSJQlIqHGr11ylT8utJunDPnllSF10nqKFC?=
 =?us-ascii?Q?WYWv+jaYthN4rkueenh6uCy47bVn48Bypy3D48+mMfvynceM82He2fZHJQHp?=
 =?us-ascii?Q?uELCRdr+gBvKonzMGvhVis4KkzPoiwjVJTJOBuhuM3A1v01YtgmblhnVPRgo?=
 =?us-ascii?Q?MnPt6w1hVichSJBHxpUkWuGNFxA4pkLeewFoinYdyVlB5QSx2okXK/bHaPOj?=
 =?us-ascii?Q?/MBSMQ/7GkOUKzc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iODJves44wD9UMhKYWvOlhANa0kyEUc85OMjZuZpVfZ7emNKOotGUbPCfOMZ?=
 =?us-ascii?Q?dEGnkzoas7dQLOQ/hekbWNfZs4fUq4sl3rcXuR/t3wI+wpGzZC6e4egeSb8c?=
 =?us-ascii?Q?imPH32RYfs0u0oAO/rZyljDYKxcchWLMegvKVb8qCSMIVRRUnjTegPHtC3hi?=
 =?us-ascii?Q?UN93fy4XAXNW3eiRqgcfIn10SFV9u73/XE3Y3SwuRUKfhn7qweWWZL6XVL6a?=
 =?us-ascii?Q?I/BqjpQF1DX9TzecV/dveYQcp0Ud+CQEodMVgQMB/0rKwkijhdg8cmPuduEv?=
 =?us-ascii?Q?Ia8dlqjDbLyq+d0Wvii6KiRIZ/hJ9uw1YyXCuSAYbgW0azggzjVrx4FiylG9?=
 =?us-ascii?Q?UrZhK869nSy6ndSE5d6ZVoQRwrCmyCc7vTQaCqg6B/ZAZlIViy28PXrIrzqj?=
 =?us-ascii?Q?6zzi0nTaA3hRifoRs//ZpzEHnxlOiXvizzcu6ehQHtW8C9z53U+RsJqpt2f5?=
 =?us-ascii?Q?HNmiJUPTiZhwiwY/gp5htGtHt1cQVjnjTDRiUI7tekMM1wCMLfyA/J4Qlqz2?=
 =?us-ascii?Q?gPNmpQRHeanb2tjyXL+aycV+dIRZAmb3aOQzGYW9I6PMzXz0wbCWb3kRWCkX?=
 =?us-ascii?Q?ZF+nG1WaniIuoeFFWo7EDpGOCyHkKHl1EpivO84rdE40xjsapgH0FLd2JTlA?=
 =?us-ascii?Q?Ip8aE05zcAzi84x+DReIOknrzOIElczbW/Oheq7IM+yHmwfJQ7G5G+VAX9ee?=
 =?us-ascii?Q?2A5pPcQxgDhqp1tRDupsGaeaC1B0oUPrXMx+LTVxERAaDC/NNTAI2kCekSvp?=
 =?us-ascii?Q?Fx+RKeEDkobqAw74ynVQkNQY9mkTT32K018rRhEZrtxP8nQ2AcP5DrFIlMi6?=
 =?us-ascii?Q?maWo0R210lZJUAuNculmG7VTxdnBlrDNVZLW5lwsGalpuTno95m+mC8fqFGI?=
 =?us-ascii?Q?6gNK5lkpnyJDoQzr/++o+ppfb4ptPc6DahgZi/qT4pTL25/+H6JxqPMPpj38?=
 =?us-ascii?Q?tfimbLPsqMz2ve9wz0/fndyfP3tnTNUrJzAhPv3CEMOUPc83fKskayGUUXtR?=
 =?us-ascii?Q?eY/2nArsKnqbSIjXkXxTyyVJ6AAtOgtNw9cdGX2TL1Xi67kLEeHTjwUBtoif?=
 =?us-ascii?Q?x0Z2AIqcSTzqZqumDkUPi6VD404bc7rSj7YBmY+/dU0rVH8WBSJk625H28vH?=
 =?us-ascii?Q?cwtDNUwQ7d1crh5b1cXZUsAlMpM/+hdjWlEuEm01i7aJQhDcArFp44TTrJN4?=
 =?us-ascii?Q?2FcgyT+dogTp6HLDnMIorWRsWpkjhChqISLDMa4zvEggx2QQUsoeBAiiCCNy?=
 =?us-ascii?Q?v8LZZmm7+qH58cImGSCZkV/ELC0ZngDuaQlz11WYfRVGnd1NBKQjf+JkHkNP?=
 =?us-ascii?Q?SmhvCtg9BfJRgJdxe0hXobDQBQ8Wg9hPSnT2AGZv2hItAJR8OYP60XfBEITx?=
 =?us-ascii?Q?01nZk9malTqwcniCaOZ3m3/qg14wgqmzgCvI4ThvW9DIdFBYylkIWfP56gSQ?=
 =?us-ascii?Q?qjD56b7sX2a7w+v0rB6btI+00XohkdgPfDX2e7uFKObAm93+YV7Cs4ogtvHM?=
 =?us-ascii?Q?efXicWVjQYb0bGvMfiQmn4TNGL1PKp3s2hLMHW/VpJhN1zm+dMzpBCCP9b8c?=
 =?us-ascii?Q?SbNbmE3uMin/T/YQyYH5ccoa1WSjya4/s0K4NTxA+acDIupnrMZ+hYaxThYD?=
 =?us-ascii?Q?ZiSijD8Aj4l7ikWWdoLZS7o=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4883dca8-837c-4d53-0c0b-08dd8ce65b78
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:36.2940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AaWfnRovvlI1vcjfGEtalklJgp4gqAo+xxuazCvyPqw/KGq8ffHotH7yjzgieafk5PYL9AOA6ByLmCF7kgjOxWCzr5hTJ8QisglME72ajmRTNm2DIAtFWoUP7Pduul8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

Add einjv2 extension struct and EINJv2 error types to prepare
the driver for EINJv2 support. ACPI specifications[1] enables
EINJv2 by extending set_error_type_with_address struct.

Link: https://github.com/tianocore/edk2/issues/9449 [1]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index ee26df0398fc..60e4f3dc7055 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -50,6 +50,28 @@
  */
 static int acpi5;
 
+struct syndrome_array {
+	union {
+		u8	acpi_id[16];
+		u8	device_id[16];
+		u8	pcie_sbdf[16];
+		u8	vendor_id[16];
+	} comp_id;
+	union {
+		u8	proc_synd[16];
+		u8	mem_synd[16];
+		u8	pcie_synd[16];
+		u8	vendor_synd[16];
+	} comp_synd;
+};
+
+struct einjv2_extension_struct {
+	u32 length;
+	u16 revision;
+	u16 component_arr_count;
+	struct syndrome_array component_arr[] __counted_by(component_arr_count);
+};
+
 struct set_error_type_with_address {
 	u32	type;
 	u32	vendor_extension;
@@ -58,6 +80,7 @@ struct set_error_type_with_address {
 	u64	memory_address;
 	u64	memory_address_range;
 	u32	pcie_sbdf;
+	struct	einjv2_extension_struct einjv2_struct;
 };
 enum {
 	SETWA_FLAGS_APICID = 1,
-- 
2.43.0


