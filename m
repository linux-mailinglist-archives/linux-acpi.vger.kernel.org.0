Return-Path: <linux-acpi+bounces-14315-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329BFAD7ECC
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D163A0DC8
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8F92E2F0A;
	Thu, 12 Jun 2025 23:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="D/HSKD1V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023101.outbound.protection.outlook.com [52.101.44.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE22E2EF4;
	Thu, 12 Jun 2025 23:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770035; cv=fail; b=Xeo+LfE/julIfcidbbG5ksGsmt4RlwCuH3QzA4Yj+ZMP/XW3dsTcNC8h4r178z7LhqP1i3cDmh0+ejK/Acw6tXc/Xg2uCGikmy+Uc7C5fh/ZawaO3vZCaLX2kqQ3etgpt0k5nODKjxOTiqdU9L90/MYNsoq1zrln2OrWPLqkL3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770035; c=relaxed/simple;
	bh=PuAstvfzSZ+Xv8JNyoid1C2KdE57FrOuGQREJg8fOXo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kGIeVezkeiDbwS0QeIvR6V/ErMSekw1+q5P8+QuNzL/vU6CWRTMQXRxbWXeTr28CHCgUCsMI9hw0EgSDXLgyHuNNChbUQSnXT/16NxyxzvJ7+Fzyf5gTeVOJ6BZpnDZkTx255OLz55317x+J5CHX+TYEg86ZEocr7iiJ6YBTvcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=D/HSKD1V; arc=fail smtp.client-ip=52.101.44.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KouXXdyT22i/63akpin/emijynxQAH5j5T9LbbOBKpKzHz82jkQwycSyYIlfCA3byuCcELJZRlahOLZCzYvZclXoUb1gGY988puyzCuPX/YMcpV+ctsD2sSCRmCd8nmSCYpGveE5zh+QD4Y/xvlUs8mjbGUsGR+6OEqFe9kqYPuYAoGM0wiGDhFL+OwRyMQQ9/8eiAIKMsHAE3vOxNqOH+E9a9P4R3j+aJK8DVR8hivJ0q0ceme20fP8c2eWdlvsef8+bqRo3MEjV/15qX2vgAHb7CWFdTrS1igDQiiNBw0s9yjlRD8blOq4PdaVgMCXY3qaNHznHRINfwYsXihKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP4jsgzUxaemQyb8N9sXH3giTLCs5orhfORAS1wCAZM=;
 b=jhDGf5BWSLv1cYgmn0hW7wwwwQWgD52Q9fTCdXRL7FC/mnszRrSixh4GeYcQFgI2iPN6ujtlJY7SUtFN0Ge02cae75b1rtQUinEaBtONQbe02jKgVKCbfQL1T182tIPKTabJfi2xS7H7bfZCcdqBOgmaXIhLJRrCTVkkLqhiONZp2ikwVDrgmCcr/eMMHzR6gELDJ96ZuTYZAhZGT6tcJNOedKdZRV0Gn0ysylIrASGcJQ88MlDGAhyd1Sj9t2VfAuc63V56KXsiPjC3yuHhMkWzbzAkUDbg7US+/IoRy67nrFVL/EvRicqD9SLb3FUKhHioxt2fbEveikiKGSFZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP4jsgzUxaemQyb8N9sXH3giTLCs5orhfORAS1wCAZM=;
 b=D/HSKD1Vn2B6DB564EBIjjWTqmost0bYD2gJExd3BbogOtMOnfn+SDdZkuW6jrP+F27DiFBdI0dbJ5sZbLrXqSzu59wv/nkuRwaohnHAHnda+soxGIyC7OsU4W13b0HKEAElSAej0qW278t5oJbkK+fis4nQqIcsZyg9EGpWraA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:51 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:51 +0000
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	bp@alien8.de,
	kees@kernel.org,
	gustavoars@kernel.org,
	zaidal@os.amperecomputing.com,
	Jonathan.Cameron@huawei.com,
	sudeep.holla@arm.com,
	jonathanh@nvidia.com,
	u.kleine-koenig@baylibre.com,
	dan.carpenter@linaro.org,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	alison.schofield@intel.com,
	dan.j.williams@intel.com,
	gregkh@linuxfoundation.org,
	peterz@infradead.org,
	dave.jiang@intel.com,
	Benjamin.Cheatham@amd.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v9 5/7] ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome
Date: Thu, 12 Jun 2025 16:13:25 -0700
Message-ID: <20250612231327.84360-6-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
References: <20250612231327.84360-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS7PR01MB9364:EE_
X-MS-Office365-Filtering-Correlation-Id: decf65e0-c2dd-4869-3f7f-08ddaa06cb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVmwEgisR8oJ+JJQb59SOTmNF+nbIjx6ZkQ8YePS+JmXzCsIq3eQpyWbLoqv?=
 =?us-ascii?Q?AtBg68aUBGSJ4ekiadQfjzniQa4oFgJ0ja4hqV15b/hFQg9FXhXe+47ytj6A?=
 =?us-ascii?Q?CLXrylVBQfXYPbTQRntU0c4+dJRKO2VKyOCspe9Cb3rujhcapznOQTYex3zO?=
 =?us-ascii?Q?xb2eS8Y5BWkVlww+8ZirFoYaN7R0e28/ZqVIfBvor9QdFjwNScHgvhGEp55+?=
 =?us-ascii?Q?EaZDFM261rCFg+Z9ke6/d9fiJte98K6hSyN+pldwXdH58oXJnM3Qn83+DUOR?=
 =?us-ascii?Q?kXSM2TzKQLUIgyC5Fxob076+nCw/Bua5hhEgiRhrwI3L57LB7aSIxRFrO6rl?=
 =?us-ascii?Q?wduNoTPwSP2dr3JndqGtP98kTaKJ5Cnu0KxaxSO8gxInlg0gZGBR92JRFifZ?=
 =?us-ascii?Q?0y1fP2zCbTHb0ir1qOIGRk0o25m3aTrXVHfnqcbuSyZqeAZPBd6lljl11h8K?=
 =?us-ascii?Q?i81PHpBLgA6QnulDM4WcrHDa1eLwYN5emPcMilxa6G/PxV2e+XDXLd2SoFUX?=
 =?us-ascii?Q?Miz8US47ZCKSK28oIF4g0WBsPnEUVOl5myo7sJkVjSDiJ2xw7rb1eqzYM/AL?=
 =?us-ascii?Q?8rDqTlZXCyqSSd2pnjBbHYKBaMrysGD5B/jfPRx+gkOB6Rqqxk0idYWFQKsd?=
 =?us-ascii?Q?TWUgqIRAjYLnQcZhFwmJZMUmmTFE7b79DoxHuUMgFvOtg9lQIcm4w/ISiirX?=
 =?us-ascii?Q?IvFCkCZguQJ2sbJZ6tw2+LdqAT+tkXPCLFucHrc0lN/h7tgsbJK5L+zOYgT+?=
 =?us-ascii?Q?I+t8C0stA2Yf+kf4Rp81020pNdp4bt/1elVtRIhVbRW/DVpKcZh3oIe2MnCz?=
 =?us-ascii?Q?miuq8ClPrtAbjZZQgx6mmXt6ly/v5aPFKk9IaNdzDj7VYgeb6qvtKrb8/6Ag?=
 =?us-ascii?Q?eKsQaaAe4R3CElgz17gUB96HmXzhpETrvKzl1zTkSzLclwX4r3iP9l4Y/r/l?=
 =?us-ascii?Q?pKLpM6qO5Sa5q0f3Kulc1dlnMa8xfmZEG7jMOZw+cjZIGDodKx7VGuKYq1FQ?=
 =?us-ascii?Q?BeH3bhnV0aNWyKzghvD0Aia6ib4GcrKAayQDzVapz6fWVt2MIEGE3cbq0gEu?=
 =?us-ascii?Q?cGAYNK9P9ugMSnIZbKrkfGZYx54+OlrGUZ5IFkPF0AbansbdG6985fH36Y4E?=
 =?us-ascii?Q?bN0R4ZScy/fuDVUhwbUehdJBJZymSJmUYjyVuho4HxSGvNwHJXlYVym4vVH8?=
 =?us-ascii?Q?Hnynx9Ut666/PUPwehzcRgKIcTySlYIy0LnK25om/BEiHYk6Pyn0YBx9QKUm?=
 =?us-ascii?Q?d+lODfgDjvKq4TekwrdWXVMMqFhrn+bsU23YisGU9BEVlMODGDqj9LfGBMZV?=
 =?us-ascii?Q?WVOiJNgcMmO45RgGkiE8cj5lgNOGwf+ix1J51wEe6mgCdPY5Yjf+UcrLuNur?=
 =?us-ascii?Q?DEst2NRR3TFjHEYQNO5Em/MEUkGDk5ifB7LScYMD2UzGS5GX93yaZlnF1EDE?=
 =?us-ascii?Q?R4hmsKmMsWeI6NnfQAXYWmclA8qPzX28WO9RpgB3gYdBC5EZwj98wfbgF2rj?=
 =?us-ascii?Q?bCiuuEbLMGwYoRY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hO9ucTRdNVWDDqfvMBvhdr6+VkLcQCD1YPNP9rgc/bt+sGZTJnGbKJ8fNwfj?=
 =?us-ascii?Q?AywTq50oKXXmKV7sDxUpSPCcPIOfkR9q/gIvmZ4tCjAytMRuVA2//6ChXf4S?=
 =?us-ascii?Q?y5HpNT4GZJHyXwEm5x1UUKrmGRHcQDK7hOailI/pFTq5Q+xvN3Oh+Pdk4Rx7?=
 =?us-ascii?Q?ed/d57n0UZ6pAM/GG5A1Rn2oSqfmghMZHgOtlC3FO3867ivxOPS1CEcH26J/?=
 =?us-ascii?Q?47EyTZ+TJeHWnmI/dGCLejyg2awd6g3B6SmgIGbSl+lUBPdRv1tUofv1Wc+9?=
 =?us-ascii?Q?4JGXNyzMgI6XLmPq4XacJ9nN2d3QjTiu8cBD3eWO5vriS8Rx9T18GvneGKvQ?=
 =?us-ascii?Q?oqUJAMBVPw1bSCrbWtSPg406JXiVOI7vwp/1mM5lMKMPwyxQmM4GPW9R1Icr?=
 =?us-ascii?Q?IgO/RP7wcdBmLRf2MQhKw6Jmzv+bLYP+p8p0Mjn+YsQrvQSzD/RMqjtgFooe?=
 =?us-ascii?Q?AKQ3xjTYwEQSWKS7129RhaESW9V9tLiWgHOXFpFG0vch5J9tqEzBitySG3F/?=
 =?us-ascii?Q?ulwa25FBxCGw4dRqFoJWVhuSI4cVzuDdhKqejXVwsIHTPC3092vT0E/9JFH9?=
 =?us-ascii?Q?OmojjalkwFa/bbRa670q5Tx7kSc1qjV0RziI7e0KuzlDMvBjGTnOsomOeN7P?=
 =?us-ascii?Q?SrF64WksvedsRZxGOgG1qWFgo6uoVG95aDRmbY/491Gg7C92KTSRpkh/znAj?=
 =?us-ascii?Q?OqdMZKGTcDoCvPZluA0c395kTzW+frG4HVthK+vrVIeG5fK+YCsVxQMPAZUu?=
 =?us-ascii?Q?R5u8qbSxHyA5JqLlvKbQhDYrwIIUHJXv8JrsyDzYnyUqpkxKkTHzzTdh4Xrv?=
 =?us-ascii?Q?Zo78GUflG8cLiCVCRM9zPD0Ozw89qaIAWzOc5+1EPLjQUFbJKVxfhlPDvnhI?=
 =?us-ascii?Q?9l2OPyvFjCE46NYqWWHEhqdnKmufYoR3rI0jtefin7yXJXeumhx8p4NxJVb5?=
 =?us-ascii?Q?r3GTboHgP8uB64mNb1keTSoryGWAXzJ3xFjjG5e0ma/liygWWp13e2lw2Ex4?=
 =?us-ascii?Q?4aXvc+O5fPy/mC9WHj2a928S/wtS5S/oHx5wVOsuEgcKBbYMNFyc8LgQnvTi?=
 =?us-ascii?Q?/97JI5OrS3IP0KdhcYpaX8Hd/5Y/xie2m+sD1Mj7mcEf3FRkrmTaj4u+2ha1?=
 =?us-ascii?Q?Dcy+DrraZBDd2BHW+UC/SXZtrpNnro6I35iCm/efuslD7rpbSXKcK76kuzc+?=
 =?us-ascii?Q?sQIOL+arDZ7bCyJp/7YAoAtQ9XyVkSNOkNy+jdxw8xrtZYM65PrfHcQ0aFN8?=
 =?us-ascii?Q?CmSXdU39zYTVFinNoMiZDYESv57VDdA4riwstXWRR6qg+Sz5QK0l85yAtyDO?=
 =?us-ascii?Q?0/N244M7wPvcFvO+z60zXI9sFaYWXkx9gy43miAU96J1U+4Eq4A3y6LGXVN1?=
 =?us-ascii?Q?cw8B97O6U7ebMe184AQFd7ZFtjF+nVTRZpcfWTggNuwRlJFlXn1nWI6nJUYs?=
 =?us-ascii?Q?RoozipkgvUu9kTFvePUwODaDkCKEKimtVics5KImHZZ6L873X5Ejda16iYER?=
 =?us-ascii?Q?CTmrW2/jWlL/uY4kVC20nP0+eLtsfe2mRD8Pik5IIAZNb67bf8J+ft5BQvqp?=
 =?us-ascii?Q?YsJTZzpxpL9RX6qAGWJhn2DnYDgtgN9BoJNxnl+Hc8ir6tZBoPLuU4Vu0M3m?=
 =?us-ascii?Q?N0cEN25y2z9Ewyo7CMesTWc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decf65e0-c2dd-4869-3f7f-08ddaa06cb2b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:51.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+y2h65CpzoLquXNw7uFs/jLKVMFOeT+aIjJA2T0ocHaPQIUhYOc7CE5/BTiL5ncmtSbXpT9imQefW+SzesGoOJkUx6GAgYYSb841/VUpHJ6FeflKLe/QujhnwGDDx8n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364

From: Tony Luck <tony.luck@intel.com>

EINJv2 allows users to inject multiple errors at the same time by
specifying the device id and syndrome bits for each error in a flex
array.

Create files in the einj debugfs directory to enter data for each
device id and syndrome value. Note that the specification says these
are 128-bit little-endian values. Linux doesn't have a handy helper
to manage objects of this type.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/einj-core.c | 98 +++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 08cac48293a2..8d60e5f1785c 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define COMPONENT_LEN		16
 #define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
@@ -110,6 +111,7 @@ static char vendor_dev[64];
 static u32 max_nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
+static struct syndrome_array *syndrome_data;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -711,6 +713,7 @@ static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
 static char einj_buf[32];
+static bool einj_v2_enabled;
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -847,6 +850,98 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
 	return 0;
 }
 
+static ssize_t u128_read(struct file *f, char __user *buf, size_t count, loff_t *off)
+{
+	char output[2 * COMPONENT_LEN + 1];
+	u8 *data = f->f_inode->i_private;
+	int i;
+
+	if (*off >= sizeof(output))
+		return 0;
+
+	for (i = 0; i < COMPONENT_LEN; i++)
+		sprintf(output + 2 * i, "%.02x", data[COMPONENT_LEN - i - 1]);
+	output[2 * COMPONENT_LEN] = '\n';
+
+	return simple_read_from_buffer(buf, count, off, output, sizeof(output));
+}
+
+static ssize_t u128_write(struct file *f, const char __user *buf, size_t count, loff_t *off)
+{
+	char input[2 + 2 * COMPONENT_LEN + 2];
+	u8 *save = f->f_inode->i_private;
+	u8 tmp[COMPONENT_LEN];
+	char byte[3] = {};
+	char *s, *e;
+	size_t c;
+	long val;
+	int i;
+
+	/* Require that user supply whole input line in one write(2) syscall */
+	if (*off)
+		return -EINVAL;
+
+	c = simple_write_to_buffer(input, sizeof(input), off, buf, count);
+	if (c < 0)
+		return c;
+
+	if (c < 1 || input[c - 1] != '\n')
+		return -EINVAL;
+
+	/* Empty line means invalidate this entry */
+	if (c == 1) {
+		memset(save, 0xff, COMPONENT_LEN);
+		return c;
+	}
+
+	if (input[0] == '0' && (input[1] == 'x' || input[1] == 'X'))
+		s = input + 2;
+	else
+		s = input;
+	e = input + c - 1;
+
+	for (i = 0; i < COMPONENT_LEN; i++) {
+		byte[1] = *--e;
+		byte[0] = e > s ? *--e : '0';
+		if (kstrtol(byte, 16, &val))
+			return -EINVAL;
+		tmp[i] = val;
+		if (e <= s)
+			break;
+	}
+	while (++i < COMPONENT_LEN)
+		tmp[i] = 0;
+
+	memcpy(save, tmp, COMPONENT_LEN);
+
+	return c;
+}
+
+static const struct file_operations u128_fops = {
+	.read	= u128_read,
+	.write	= u128_write,
+};
+
+static bool setup_einjv2_component_files(void)
+{
+	char name[32];
+
+	syndrome_data = kcalloc(max_nr_components, sizeof(syndrome_data[0]), GFP_KERNEL);
+	if (!syndrome_data)
+		return false;
+
+	for (int i = 0; i < max_nr_components; i++) {
+		sprintf(name, "component_id%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_id, &u128_fops);
+		sprintf(name, "component_syndrome%d", i);
+		debugfs_create_file(name, 0600, einj_debug_dir,
+				    &syndrome_data[i].comp_synd, &u128_fops);
+	}
+
+	return true;
+}
+
 static int __init einj_probe(struct faux_device *fdev)
 {
 	int rc;
@@ -918,6 +1013,8 @@ static int __init einj_probe(struct faux_device *fdev)
 				   &error_param4);
 		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
 				   einj_debug_dir, &notrigger);
+		if (available_error_type & ACPI65_EINJV2_SUPP)
+			einj_v2_enabled = setup_einjv2_component_files();
 	}
 
 	if (vendor_dev[0]) {
@@ -966,6 +1063,7 @@ static void __exit einj_remove(struct faux_device *fdev)
 	apei_resources_release(&einj_resources);
 	apei_resources_fini(&einj_resources);
 	debugfs_remove_recursive(einj_debug_dir);
+	kfree(syndrome_data);
 	acpi_put_table((struct acpi_table_header *)einj_tab);
 }
 
-- 
2.43.0


