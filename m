Return-Path: <linux-acpi+bounces-12718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BBCA7B24C
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F98189B9A4
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9B1F37CE;
	Thu,  3 Apr 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="if/Qw+9L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594E71F12F2;
	Thu,  3 Apr 2025 23:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722051; cv=fail; b=JQgb80lqviTmd22zUBctBCA8R3FJI4PJD2YJj5wj/PEDM/zMHTDtyg8mvN38DIZPxUmEWQMwO/5KA1GPWxWDcNCD9FN6n+i0jFqrXhBcF9xbzPTVbJdI8uFbo/tpTFhu4MYNbhKlbIltM4UYIDSUSRS5nWhZ8kMmRTG556kpRTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722051; c=relaxed/simple;
	bh=S86WihB82vxxno/BIteZNs+msI04CdzIhMIrbAvXIMo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdWFrLEmCubu6qujgfhL3iEhDRF0R8EYadOmGDLJdM9HpIUdt9BckxyyLdkDc7e2WBxxVwpDuylr/VmsnIe3jcV4YIy+5NzZSVSH2O8pFKgEEegCo7yri5OjvHUOUulslV4WPCMamFtPnxaCg/v2X9M9wGUfnD22wn7n6ejSGk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=if/Qw+9L; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYnLzh6bIQCnFMD9jzRSr+L1R/SIEWYHRa1Ps2UJ32bG94TldAEl21a/Asah2XHBd1yxsB4BjMS8WJECVi+WL8qul712Jys/7GYmOwEgrEqHHrfhZa5QCs6s+EfaLcbmer50GIqwFB9ygIg4j+vQeMVe4zs3StzBYQN95/N+FoiaGAUYOAVSa5RDahq0I5R5NNuSwQWqpOKsIumUrTqr2Bl/ldGhLfHXF2kBo0C+Qxe+FJT0Gow0QvSOSofE2dAA7oI+YIp6tJoIjEe/Qabb019HouwrWS8C+hceCqbCZMlbVsHOIb/ymS5MyIPh46Irjrehd2s5Pe0vIDdJvjpr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCAJ75EktdlwyIlq8GyFjYM5y1B214Ldw4A925zUBCA=;
 b=ZVi3H2BKRc1nJnFKVI0jBBe85d/994oEYIMLm5ovUnIXUsFm0cRl1fKeanPjGb0qeupQW+D2ZSWwd3A5eIh4+5w3KHni1ZqWwrpo7SYHs+lnfNHlLDCjNhudzUe8WP9ACdlMYvb9ky5sopAwaNmplozEA0VRm0SQMiDcTpUIvWDe51zVkW1J9EOVpO2ZN3XXb2GIcBY03hXT2QGQwDetbDCJDEs15U2+HGNptIE6/rsLgmOPvZFGuK3GIgc9mLHk0jdBkrVg4eKfmWP425V0N3zqZBlyHr7jGUsMxBLPS6nLhfuP6RgSY9Hw8psCTo0qWalk5se9WDg45MKiToC1WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCAJ75EktdlwyIlq8GyFjYM5y1B214Ldw4A925zUBCA=;
 b=if/Qw+9LYVQc1NgSkFddK3uCQx9GDMqEmJmZ7q6hGie43c9PHf+ljGHsCiUd0BI+x0JcBET82bzuSG9wQW3QGdcn4m1CqXR12+kBGpS2AQlnx24DTKwcPR5wHpAI1GEVlV7MtgpfrEFv9uCrrzUCBxXVrEk1wVr7eLHDkyH7RE4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:14:04 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:14:04 +0000
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
Subject: [PATCH v5 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Thu,  3 Apr 2025 16:13:38 -0700
Message-ID: <20250403231339.23708-9-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2b383345-3eef-4f65-8670-08dd73053a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7L398faQyqP4N+UL05FcdKowmiILth5ze5XlErbRTu/RollH4wBq8puUM9h1?=
 =?us-ascii?Q?19502KvFAKPgOGShVCZduEQ1ay1v3WDYpmi6qQyrjaccCnWlc9zNvmyETUiS?=
 =?us-ascii?Q?OnwuZjLA1B5ePwdIDXABMA/YfqeX1zMEMSjc+k6egeEvUZo/wVmatUjpJVkE?=
 =?us-ascii?Q?tFtKxzNraMERNQTHAoRefDfm98N23xKxoSaJACQX/jER6nDLVTC5gvwFyKNV?=
 =?us-ascii?Q?tqGqZUFMGXWMDw7AROUpggzb/rNXHJxoSEJrNYI+aUDJx/66PRZW2gAve+ab?=
 =?us-ascii?Q?Z9Obc5Ho0UTRJBH5BbaO/lVP9Uv4oBd8W5K29ivT2z4kpw0kWk+KMeMle7Ru?=
 =?us-ascii?Q?lD1ozJkrOO96URvx/hLPxqqcK14mTpcVuGAvS1itz4iZH8RYTV1rKF9CXRL8?=
 =?us-ascii?Q?/XVtQrH1+JRPBhG5CgEyYzJytzN1tGxIjD16x8fi7tasZJzSSGuecyFujfzg?=
 =?us-ascii?Q?yTR4o6lYBm/n+jRwhg4eyw80FK67BeXAMrhBnkr+myNUyoPrQOPk7L06ALWw?=
 =?us-ascii?Q?ySGTa0+2UmlVxXhVfD9a1Xtas1KCccpFSV0FqiPFmeAd0o2ZEqO5LxImIm63?=
 =?us-ascii?Q?STdbXRjc4dZE0ahhbcjMQkHNrCnOGregf9GijXnjdIDMcbudFTH6PP9qg7XM?=
 =?us-ascii?Q?mCdMxYrHZhsl58MuN+DeGTQYQPlMKijcVviH4/q+OIsXXS8jYqcuMi0yyW1x?=
 =?us-ascii?Q?KpXxidhMMksktfsJgCsMNc3BTcq563MiR7htqUqxjnpNqVq7hZh+u2hVgLSk?=
 =?us-ascii?Q?u0DL3IE/7lV7NyN5evJY+oFPbZlHWHzP2UvBeWjRaZ2Z6ZrwbyowxA85/3qh?=
 =?us-ascii?Q?CqhE1iYJg9YF5okKYZtss6kEY3DSyjSGzZyG5+fO9F2G+Nb8Lsww2QZguUU3?=
 =?us-ascii?Q?c1eETILmnLzgORvnHJtsVYuZ5zsKEprNKiLRfP/N+8tE5r701S58QMG2PeEA?=
 =?us-ascii?Q?5tpRGP2HTlgan4+NhgRH87iQ6wdLk/5LUAfrS9m+AaTP2ULHAzrjPkl9THIG?=
 =?us-ascii?Q?Wcue5sdj/4FnsvTFqVAlCKUUPFF+4WdqYNNHxWR+xweYZv+cF/xZfsV6RLUo?=
 =?us-ascii?Q?lGa1VjfFixHFfHApkHbCEqmv8jneDGnYyrzQOJeQzS5biVLg7fu9ynDIYANu?=
 =?us-ascii?Q?XjtkouwTF9ffnli14M9yUzvDlo/dMH+96E7j5GSUFBqvuU9j2zAj/Ux/nbBL?=
 =?us-ascii?Q?zVE8+uudyyd8dULqzyucVP+LFDj+ACNp8K9BcE2pagpVv4SokqKg8A4f6AwE?=
 =?us-ascii?Q?yHRykBRHcIhmwTUuP98zBrgzR8sUD+4DrrcP+5l59OIy8RstKAUUO4amNDtI?=
 =?us-ascii?Q?Sy80DpF6ujnz5HzGksZVu9kXKOxCNLXDHlQc2jlifSwzoYeWyBD7JQCE4Wv8?=
 =?us-ascii?Q?/MU6pv8J2YCKHbaQ/6txhBukpBbpCOej2d3r904wcrXV5nYNr0xzg8N5YQg8?=
 =?us-ascii?Q?frBy3mjoh+WNsd8afqNReuP1j7JUbdb9w+vIdcQbGlSHiihCX9XPiw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W+7VilQX5Th+3/HM9kdPPA8aFPPeP/vH2pDXrnBf0c4uMDkLUKBm7x9VlxE7?=
 =?us-ascii?Q?wuLUONCpps8/eeuHS0/5Ql4c5FWQXgKQwnjmvnop6orihklfFb4C/u8gys/L?=
 =?us-ascii?Q?omhlyef+ZLicYZmopkabyuDyRj3RDuivlJqL5whowJ5ls8UtVKmV4JULbroq?=
 =?us-ascii?Q?jNd8lIHqJXOrHfrWE4NhBnn74AlV1UNnzRv/n+AJnzLrUWxVbyCZJRUEfuJC?=
 =?us-ascii?Q?qbitQKtb5LgLBJ339CDFCUatBcvn3OSSDlhtonwr2aQ0+TRmmlqspJp8WLip?=
 =?us-ascii?Q?R9kFt0OOuW6SBVS5gdPDqXeMlJ2pwZf33CZFZvhkgyNk6MM2Ds7Qe/JNZXm4?=
 =?us-ascii?Q?4mNmbRiVSNSBzDlIqvIeVTHoppDd+a32dO6CnnErE1uON8R4zg0YnNOjh6Iw?=
 =?us-ascii?Q?aGSlf3jcWwD4i1ZdY2rxefQEFnnOBoJtNpd1DyYvBgcObDIKTkmqjxKdIUGD?=
 =?us-ascii?Q?Ni8iXikmDADtdVVqEUvdnltDvXQv1EDgS+P0ED+B864SYBhAjAkHCZ+XhZ58?=
 =?us-ascii?Q?IOygbIruA8w+LuO2r7fTrwr1Gpv8DsZrTVQGEkgZ5z2vBEN7kSklATADWxLO?=
 =?us-ascii?Q?bLRyzceI+z/EeJBVHSDIBCNCnvRSMf1kcrPr5D2khISo95Qa3sIEJSlEBjBd?=
 =?us-ascii?Q?FkhqwXHQQ6wUKuUZ66DTtBkopV48cM8l6nqpeh53lM9YrtR7ZPV6LFgW6qH/?=
 =?us-ascii?Q?uabDsHOsBfBgtZC2G7Avae59Vo4+WUg/GwbeUm8CPn2Q/nfCSFd7s6LHUHe2?=
 =?us-ascii?Q?8ufeKfrs0SeB9IgIDiC8yHrTqBH8buNLfN+Q5yjsDP9AHzTxuG8kHoPWL0vP?=
 =?us-ascii?Q?NfGPOa/7F7EtccLH6laTGFMQgl0O5ouLX03RSSAK+pUAZrXeddWOGx/bMcrF?=
 =?us-ascii?Q?hDD+XXyO+N8tqwvKUPOX+8VP94mwtsgbPEKFl2+mhy+T2khsxLcEv0Y2OhPM?=
 =?us-ascii?Q?8IYoeRulc7EyzcI0/N2Pa9fT9wvN0IJZidsPXqKKp77yFe9PzGh4ECTeVSps?=
 =?us-ascii?Q?6a19HCTk/TusAdCnRZJ5rpjHQozPoGU7G5Bq/fqpkF69mwLDxqhJIksUAePx?=
 =?us-ascii?Q?4OiJqqVrwjDluCZW/JlF7Cq+2ZFQbrJgwo47HniPOOMYUKfruoEwyocouXAZ?=
 =?us-ascii?Q?3aZTN+o2ESYLsVA3Rjf2/SI//ko6OF9TLEnSfS3C5ekz7AuLoVZYpTV5dNj5?=
 =?us-ascii?Q?xsdbfoK0vzPY8PNq5hT5TU8AyJKXn7aoVltaaayr/mm9zJTOYrg39D+G626u?=
 =?us-ascii?Q?6OvWj3pF9IUM08+Cjw/nqlhpbsmK1bvJ0vJeRrPNq47vbW5vOFrrxYONY/ZL?=
 =?us-ascii?Q?ygo3zaheEL9EnWbHSanpWhBAAyUTkr4k9K8EwJcCR4dYq9PDQI0GMLw/+V5u?=
 =?us-ascii?Q?qmc1wHBTIul5dC1s+3biKfREEpzc92CD5zHFbN9Fx1/p4X92QVsy40XL2Uj/?=
 =?us-ascii?Q?zE1nC84A6lHr1umqR7Hxtz9tdUYAUhSlnQDSb9/WhDpF8A4xeclKVKyoN9nT?=
 =?us-ascii?Q?fv3ytbg+drhq3sAut1quZbseGb9+GANTLL74+NoxNs0RiYkYTOTv8ZqHYJrv?=
 =?us-ascii?Q?hbhGf73Zq9QRMwHzq1jXVrNZElpRFRIFct6Xki4sq8lT2hk/wR34qUs92uNa?=
 =?us-ascii?Q?wEe+vcce6Ws5SmtsyeRY6PI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b383345-3eef-4f65-8670-08dd73053a17
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:14:04.5194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBNmz4kbLafAd9YCwFbdv93FEHkzKjBIfo78b8ixJQEIIdK/O/9kwHAxWMGKlCcl9lWjJe1X/bNSx+YwcJC383HVd32jjsT2frV8ziuzaJyAN1WyM4HHz+hq2p22mGca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Enable the driver to inject EINJv2 type errors. The component
array values are parsed from user_input and expected to contain
hex values for component id and syndrome separated by space,
and multiple components are separated by new line as follows:

component_id1 component_syndrome1
component_id2 component_syndrome2
 :
component_id(n) component_syndrome(n)

for example:

$comp_arr="0x1 0x2
>0x1 0x4
>0x2 0x4"
$cd /sys/kernel/debug/apei/einj/
$echo "$comp_arr" > einjv2_component_array

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 108 ++++++++++++++++++++++++++++++----
 1 file changed, 97 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index dd7626da360c..b90865c2d995 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -34,6 +34,7 @@
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
 #define COMP_ARR_SIZE		1024
+#define COMPONENT_LEN		32
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -87,6 +88,13 @@ enum {
 	SETWA_FLAGS_APICID = 1,
 	SETWA_FLAGS_MEM = 2,
 	SETWA_FLAGS_PCIE_SBDF = 4,
+	SETWA_FLAGS_EINJV2 = 8,
+};
+
+enum {
+	EINJV2_PROCESSOR_ERROR = 0x1,
+	EINJV2_MEMORY_ERROR = 0x2,
+	EINJV2_PCIE_ERROR = 0x4,
 };
 
 /*
@@ -110,6 +118,7 @@ static char vendor_dev[64];
 
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -180,6 +189,8 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -287,11 +298,30 @@ static void __iomem *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		struct set_error_type_with_address __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
 		if (p) {
-			memcpy_fromio(&v5param, p, sizeof(v5param));
+			int offset, len;
+
+			memcpy_fromio(&v5param, p, v5param_size);
 			acpi5 = 1;
 			check_vendor_extension(pa_v5, &v5param);
+			if (available_error_type & ACPI65_EINJV2_SUPP) {
+				len = v5param.einjv2_struct.length;
+				offset = offsetof(struct einjv2_extension_struct, component_arr);
+				nr_components = (len - offset) / COMPONENT_LEN;
+				/*
+				 * The first call to acpi_os_map_iomem above does not include the
+				 * component array, instead it is used to read and calculate maximum
+				 * number of components supported by the system. Below, the mapping
+				 * is expanded to include the component array.
+				 */
+				acpi_os_unmap_iomem(p, v5param_size);
+				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
+				v5param_size = offset + struct_size(&v5param.einjv2_struct,
+					component_arr, nr_components);
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -483,10 +513,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 		return rc;
 	apei_exec_ctx_set_input(&ctx, type);
 	if (acpi5) {
-		struct set_error_type_with_address *v5param, v5_struct;
+		struct set_error_type_with_address *v5param;
 
-		v5param = &v5_struct;
-		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
+		v5param = kmalloc(v5param_size, GFP_KERNEL);
+		memcpy_fromio(v5param, einj_param, v5param_size);
 		v5param->type = type;
 		if (type & ACPI5_VENDOR_BIT) {
 			switch (vendor_flags) {
@@ -506,8 +536,50 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (is_V2) {
+				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				component_arr = v5param->einjv2_struct.component_arr;
+				str_len = strlen(user_input);
+
+				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,
+					&synd, &bytes_read))) {
+					pos += bytes_read;
+
+					if (nr_parsed != 2)
+						goto err_out;
+					if (count >= nr_components)
+						goto err_out;
+
+					switch (type) {
+					case EINJV2_PROCESSOR_ERROR:
+						component_arr[count].comp_id.acpi_id = comp;
+						component_arr[count].comp_synd.proc_synd = synd;
+						break;
+					case EINJV2_MEMORY_ERROR:
+						component_arr[count].comp_id.device_id = comp;
+						component_arr[count].comp_synd.mem_synd = synd;
+						break;
+					case EINJV2_PCIE_ERROR:
+						component_arr[count].comp_id.pcie_sbdf = comp;
+						component_arr[count].comp_synd.pcie_synd = synd;
+						break;
+					}
+					count++;
+					if (pos >= str_len)
+						break;
+				}
+				v5param->einjv2_struct.component_arr_count = count;
+
+				/* clear buffer after user input for next injection */
+				memset(user_input, 0, COMP_ARR_SIZE);
+			} else {
+				v5param->apicid = param3;
+				v5param->pcie_sbdf = param4;
+			}
 		} else {
 			switch (type) {
 			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
@@ -531,7 +603,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -583,6 +656,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -593,10 +669,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 	u64 base_addr, size;
 
 	/* If user manually set "flags", make sure it is legal */
-	if (flags && (flags &
-		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
+	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
+		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
 		return -EINVAL;
 
+	/* check if type is a valid EINJv2 error type */
+	if (is_V2) {
+		if (!(type & available_error_type_v2))
+			return -EINVAL;
+	}
 	/*
 	 * We need extra sanity checks for memory errors.
 	 * Other types leap directly to injection.
@@ -746,7 +827,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -765,9 +846,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
 	if (strncmp(einj_buf, "V2_", 3) == 0) {
 		if (!sscanf(einj_buf, "V2_%llx", &val))
 			return -EINVAL;
+		is_V2 = true;
 	} else {
 		if (!sscanf(einj_buf, "%llx", &val))
 			return -EINVAL;
+		is_V2 = false;
 	}
 
 	rc = einj_validate_error_type(val);
@@ -789,6 +872,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
@@ -942,7 +1028,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
-- 
2.43.0


