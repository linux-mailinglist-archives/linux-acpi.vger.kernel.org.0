Return-Path: <linux-acpi+bounces-5927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8748CB532
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 23:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E35A1C210F8
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 21:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C948B14D6FA;
	Tue, 21 May 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pOiDHUwz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2120.outbound.protection.outlook.com [40.107.92.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B8114C580;
	Tue, 21 May 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716325872; cv=fail; b=gY6kfy7wQQadOdoT2LM18TEpEOFutQpcWN4zQoUJfTltBb5jEJvp+s1PtFQkAQAGiQByfh+OSLR2sFV/6lfkQkGNbKL8xo/NZE43IWcA0N2VBDwG7JjIARk6+ruzYWL9vwgWv8RXtrrwYKMZUNH+qokUt10HBaCDY3TuoEhnG3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716325872; c=relaxed/simple;
	bh=pn/AwO2rweeEgIbHvSwXspfFwsfPelMopfV+CFHtqkc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F93kprxWHeOKp/Lj5TNOA2n6H7mnPzsRhjsc4SlvWrl7QkQFSO6YoELvfIPiBSr9fF1wZhjnf0ciYOAH2tcsjeTie1McXSuBeNu9WnLOhH9sAmsoRFJTgaB8Q2sH+iwyK7CyPOuutgjrzVe+bvvTLGQH/Pd/7x2/qc1v43ZHrHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pOiDHUwz; arc=fail smtp.client-ip=40.107.92.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhbrQwYrvzvVtxYTzMkD5IEEyKmDeJClRMKamRyklnMQriay7ajGjso5Oxp0QfosTCQFhzvlvpMpK6EfThI3sj23HmN0vfDCpQapXNUG+ZXg2/aQXNxow60PlnS3gkJRP6m0114tm+MQ7vhaQ4Enu0PjROK4B6mDtJuzYSbTFjn9YJyxpl+w8rk456rtaOj1LeHmaIhLXRQhaqVq3bWj3g1gtwamvl2AZuXoQDrMqoEzpmYVaITyiIp3HmkCa4Obix/VMr6WMjD3GV3v5gVOWTbWk53Rai3aTcf2Lq6wCcSoXK8B3pddUBTYxJUK5Ck3VuRAvuFoayq/et2b/wBsqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDpk5WkSbUbdCTmSLfJRqaBqSuk1bwkxJM/n0gnz4wE=;
 b=LUZoR9UqEN69z6YRUvFOlil2G39tlJEuUnn+VWLES87rOGHWMCVxqF1xLE82WK6F+7nxU5LS9ZfZoLrOSW+gK+xV6/g4wpRWifRb4qhKfrToKkR4Ph66GZ09TKq2kxYKohIWnbAO+wOP/dmpgSyuydpMUy5i/1lQUzh2FEvklwk7RrnsdE5U7WfEzhkP692qJzsAKQl16x6MmsY0gsnjhFDoFfysiLe27dctJCb0MmejIOpnLvhH2ph3Q4VQTAxenOk1d2Ljr/VKuC+UUsBF5LttCHQZ/OixsemACAT0hv/K9nIoncc2+O4WYqI2MgtGSyhikJeZNE2bCpjtloJosw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDpk5WkSbUbdCTmSLfJRqaBqSuk1bwkxJM/n0gnz4wE=;
 b=pOiDHUwzKFjxcn2oJbFvA2YsI1eLLWtpHb0aqlJYml+kO+8UQ7mZ0eD5VMIf5OkFGQ82Y9gVEjMp2kzE2r0xZItqYwCEHTmSZ9wWgiunB0kMka80vjvIb5XW4YupCWqjWDvyuS10TaXp4gjdH09QIHNclnENDdHkPR5lM6SHHzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 MW6PR01MB8627.prod.exchangelabs.com (2603:10b6:303:23e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.35; Tue, 21 May 2024 21:11:05 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 21:11:05 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	robert.moore@intel.com,
	Jonathan.Cameron@huawei.com,
	Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com,
	arnd@arndb.de,
	Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de,
	john.allen@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [RFC PATCH v2 6/8] ACPI: APEI: EINJ: Add debugfs files for EINJv2 support
Date: Tue, 21 May 2024 14:10:34 -0700
Message-Id: <20240521211036.227674-7-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
References: <20240521211036.227674-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:303:86::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|MW6PR01MB8627:EE_
X-MS-Office365-Filtering-Correlation-Id: ec2c3762-cdc8-45e0-d6c8-08dc79da85a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|366007|52116005|376005|38350700005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dFwYLX3ae1ObLBNOZC3fRqNaALCfhMU8U9NfwLo+U1lz/xxATQ1S4S33i6Ho?=
 =?us-ascii?Q?QeUWYge2IRl7lONJwPrxCg8unwFkJQ7+YJmKKd6cZajAqiP1pLaxb8Ong3Yq?=
 =?us-ascii?Q?NYFjsWh0C8KlZY7dGeObQdYleM7p71+feVMQrUprJO35UjglfK8GLeWRSz4h?=
 =?us-ascii?Q?8UWZjnqs9WWu6QDg3ljoHF7L9iHXJHdMDmGPW3jMuX+DYsKsnIYROoJoszn7?=
 =?us-ascii?Q?RD1OkTohx9ly0H/nYapiRqtCf+iNr7gxr93AxUgsNVfuKX/MRfXd8ByIGaax?=
 =?us-ascii?Q?tg1mG1QGs4UThY867q2ag3juofv/17+vBmpwprCbodjNkjucslTp9+xKlHSu?=
 =?us-ascii?Q?y5Qr5Id0w8l56ntBC0timuXdjbiYLdKpupx5GmGzN3a7EQnjezGEnXGPLL7P?=
 =?us-ascii?Q?UcnhHJK1XQtsxJ6Coo/0tbmpckOMT0Ua4JF15d21aoDuGPVUbTtbctVTiQSE?=
 =?us-ascii?Q?9JCLuM/C5lChb6UYvzNkw5/a8ltMmmgWPWUue7hYTo9qqif9043ahxejNgSE?=
 =?us-ascii?Q?eT32u3OIYAdf76oTbGiuRoiN6A1wUWWmVSVXYOl3X1Sf1uAY0mwXpFC0THoc?=
 =?us-ascii?Q?LsdfWzQSnynnqUBHzJmzUnjiacnYVxhq9SkmYwuDt8yeioA5sQO4YzsD4JTS?=
 =?us-ascii?Q?GC4ueh9eKxHU7ZfgFerRHuDxD0X8m7gFenSsHq5L+OX3fCkHFdtQG95l+gg8?=
 =?us-ascii?Q?wDRIEHjdGVaFOaIMSDIKi4r8urGw9UC4jGuAUtuP2T3mA8+LT84N9odqgPAO?=
 =?us-ascii?Q?mAgR4RFzwv0EdODUqSpynL0ERQRcddM+RQxK7ETtk/av07T2cpnQ4aBALK3u?=
 =?us-ascii?Q?RHCBILirbbF2wSU6hUeV+QzFnhmfRvqhNvBdr/gram4dHdhk/M+LK9ZIe8KF?=
 =?us-ascii?Q?T3nhfMK30/heWY74qlAmYXONy9lLtzcgjl1lqJEhfV5/+dm6AQTNR/LM1QFJ?=
 =?us-ascii?Q?+4zCVq9jbm059e8WJ2oYkvVQFiGsxe5AxMfNSj9yJtBCD89S4FtSre0lV01P?=
 =?us-ascii?Q?/AJS1eV6uyeXKNKB9Wiu1S0BKphFAksqsvSA1nBAgVVWn3aBRXrjwi5KlqCr?=
 =?us-ascii?Q?c6+eltB3fJ13GF+wvgl/Hke5bJ83AN34w07zsMF5K705xSARcIO87NCcpTdO?=
 =?us-ascii?Q?b1dtm6sS+6fXrjGcRLAJ2oqXeNDPf8lbrgLp1tD/Re9D6AlJpHmUXLsMQb0Y?=
 =?us-ascii?Q?VHu+pWY9zK8S1plRZVSlXsrcYTSUoRmo+asTMU196XGsNOlAasADQqmbnK7f?=
 =?us-ascii?Q?n5ctU5tEMjZdOsHsFxBzWSkXVccoCeoGu+lJhhx+hQGKXyc5eB1qOarmmyyb?=
 =?us-ascii?Q?EHnXKAK4syFlbPJkRJ3yM1X4TAz4ZFm9NwFxUMjqRsYKbF2WM4Lzh3BJGB/c?=
 =?us-ascii?Q?M5x/uzs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(52116005)(376005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sIw4V3phj5KbWMVmxAP2Qq53m0wMg1IMh41MHOeGE5Dk8YB6kMICGCQi5Er?=
 =?us-ascii?Q?93ba8TO9pjjp0rOaJ2T+CNk4fLQij1Tjyfo36dqgJjKfzHJ5O+R5L0/ym7t3?=
 =?us-ascii?Q?0lupUFyibtTp6oBnrkjMdOpfMK+KJjZJ4LfzqeQrRt6mZI638F2d27ys5ulB?=
 =?us-ascii?Q?3Fs5WEcJGONbcrokA8bw4nCxijBkjHLkNRGEO8dB8sAqU2PssjoINL/ZEaPD?=
 =?us-ascii?Q?A6uBDEVKJTp0sAAwDbJEM3M09s/1i3sOsN1ULZk1zmqrSvCZRELtAPEHMhIa?=
 =?us-ascii?Q?LNOvXIdd9fmPeqtaOKkMkm98KuxLaLYGBL55wbSZ9+BkR3R7J1WYMjxEU+48?=
 =?us-ascii?Q?jh74mhvtiLnx35MAdXCzP0smbRSTiv6jW7vL6rf4Lsj3c8cLAMieG3Afr1KS?=
 =?us-ascii?Q?rEDrg2uDcUwso5DmP4JH1b7v6LXb1FnHYgHcdsRzNT/tFN4rJRP5xYkyoK37?=
 =?us-ascii?Q?qyS5X076YQaN7a1f8tRLA1+GsNnaYiZua1fkQ9pwgHa35WLhB7S80DOXyL29?=
 =?us-ascii?Q?PqUhKp6ZLy9E17j1vUWbgyqvVZ5+g0hPwsRT9DRkwQo8MJ3cgkL6qNUp++jp?=
 =?us-ascii?Q?53W+lm1SLbuqhhYikI1deH9IMvMj25JsX4da6sabjkEs306PSPM/mufkOPJ1?=
 =?us-ascii?Q?UbbTN/0b5WhqlVk4nzzoKEHftwxQN8q7nzPikJxg858DYM/nGzyYjj5uAe6J?=
 =?us-ascii?Q?yQyWaMYcybuYzA1sobfn84YFEya3P6KY5di47PVzofCm9nlwNZX5YkeQU3Ly?=
 =?us-ascii?Q?kRP2uowjQINwL3UWt5Phim/MLhthjy/55v3D+lViVN0LqHAsrtN6yxhSCsaX?=
 =?us-ascii?Q?ZPTFmRqIHxZOK5Re3SmrUYIgaasTrRLZ8GiqboGRELuSobx6F1IThzqRoIWW?=
 =?us-ascii?Q?Jt+JpZuNbZpaPAd5AXkw8DSa3KqPlHOeZF0ZntZz1pd/PxnDajX9bmpCbwWl?=
 =?us-ascii?Q?/6yrA/tuWsP1XBuwn1rfiCfF5lD7s0QZFqhCZf2NwhWZYiDNXyfT/mNaFDUL?=
 =?us-ascii?Q?dYeuajy4llmpqcrOGfkP8mLBjo5GylsrRrr1NtjVIz21U+j0vDTY3RKls5tA?=
 =?us-ascii?Q?WXeTVyzomS1d0/gCwYpB+iETnfWFTi/8lf2QtswHEGPs+OoKfdDWfZqhl8+S?=
 =?us-ascii?Q?nehJIfWoMa3CBP7wwcPhGzX0A09DT+efJAe4YsPv/ny6dQtRTkWKMbrLFfdw?=
 =?us-ascii?Q?PPFrVK1WSEwkHRqdBng9M+b+BTZugUoVr8bL+UCTnFMWZufGZWQj47eMjYBv?=
 =?us-ascii?Q?vxbeNiKTdJYZJoRZow2+lm6c/UZyLp/1b1Dhj9qmaglDyRlSrSo9WnUYwlov?=
 =?us-ascii?Q?IHYy1+TiKhGSiy3hfFgmz16gNjzmZoGAtdegcG/f7rpv0UhVJCUVtMBu1fF3?=
 =?us-ascii?Q?JvbuPgTiqM8Ns4PsEk5k90JkQPaJeWPqS7p30ylU8YFtc4czXLqEJO6ZuU3o?=
 =?us-ascii?Q?FKHyYYz2ApaVbsQOEttH6HufwpnOHvQ4VJ0nCcIG+ZwlnlRxch8ZHKjafoSN?=
 =?us-ascii?Q?XaOFV6G7smpt4iOHjlIElD551INYoYimUaogPVifqIXTbEpUBPit1CHUFtOm?=
 =?us-ascii?Q?hNlhnoKVOgrUWSVjhwvIQoC5YfqkIZzKtY+o7mjUxhaNSdXCw1mEs1380fGY?=
 =?us-ascii?Q?p02TVla6MjVjFwuSTKwqmtk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2c3762-cdc8-45e0-d6c8-08dc79da85a5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 21:11:03.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0AlrPHx7DHrJf6ne4DWeN2hk/6Ui1bnvvn+Vt/JbSeqE9c/zPJCz2xpR14dpiOJEdG0XlRI3ZeEUFqNxiPJg/3u8xt1MPN7ZKhiZXF8sC0m+ctD9J9hXaUI/vwzIVDB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR01MB8627

Create a debugfs blob file to be used for reading the user
input for the component array. EINJv2 enables users to inject
errors to multiple components/devices at the same time using
component array.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2021bea02996..2e30ebed079b 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMP_ARR_SIZE		1024
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -107,6 +108,9 @@ static struct debugfs_blob_wrapper vendor_blob;
 static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
+static struct debugfs_blob_wrapper einjv2_component_arr;
+static u64 component_count;
+static void *user_input;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -859,6 +863,19 @@ static int __init einj_probe(struct platform_device *pdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP) {
+			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
+					einj_debug_dir,	&component_count);
+			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
+			if (!user_input) {
+				rc = -ENOMEM;
+				goto err_release;
+			}
+			einjv2_component_arr.data = user_input;
+			einjv2_component_arr.size = COMP_ARR_SIZE;
+			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
+					einj_debug_dir, &einjv2_component_arr);
+		}
 	}
 
 	if (vendor_dev[0]) {
@@ -908,6 +925,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
+	kfree(user_input);
 }
 
 static struct platform_device *einj_dev;
-- 
2.34.1


