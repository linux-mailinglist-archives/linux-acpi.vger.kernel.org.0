Return-Path: <linux-acpi+bounces-11917-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2996EA55B1B
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Mar 2025 00:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252583B16FE
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 23:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9A5280CC5;
	Thu,  6 Mar 2025 23:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="TzSEUoNG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2132.outbound.protection.outlook.com [40.107.223.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681D280A33;
	Thu,  6 Mar 2025 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304937; cv=fail; b=UVyrTNjLmI+BXC/lHbh2xT6n8JkQSEZbcyNAIQ1rkdhn1PLGKDxmILRIaV81OsbQHLYNH4z9QESMgB1HMpl/EYCfMJNO+xnWXylB6j4x8lYOj3T228KJLBPsP2Uu+xfRFgfKE1fFIvjib+PBgQ4gtEEDGdSKpn0DZ3QTDcBqNUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304937; c=relaxed/simple;
	bh=/7AEWxQjYpLeVOd9r9fTpaGFVPmdZtInHQJt3LKfkOI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmZRRX5sKaehpb2hKEtlZ1o6ze5GvixwZPJHACITUnPNRZ11bHWZZannCY8BvD60EdCba9a0lHXfl7S4gjJhVWKAuQhZXQVlr6M6z40nA4dvUHsmI9+Kkow2CBH5bvPbEpGBnohOFw6HBLr9RghE54YsHZDLPkiLr/wikHZTSDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=TzSEUoNG; arc=fail smtp.client-ip=40.107.223.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bz8l020d/+LaPt+6chw0Az6OlkHqcN5TIL4vjROfMADg38cDi8PTCOwyxJgH98cHF1c/6gh8GeoAIRV4TZKOoRaq7UrSS91OFZZs8U9ynE0f1SjkpdlCW3kBQb9WU8bczatg6ESInwlNlAMczno4mpZbFu82j7KDbtTXaPRqIWLAiMX0QQvHWhbBwrEaJfEnaXAyr4FwNhVB6KEGr9CpSfakzDSCnFcQN8hC8z2AYFgqWzKt3Qvj1KmHYSIYfhxhe+n6nPOv5eHVzO3vqL7yfb4f/knJihxXFiHJYMMhtqOH+SWep9BCtOKVcX5JfEGQjfyC4Uv7Zven5oznKxRpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4g+99+MSpUZzZe+yJe/xJgQ96le67kE7X6P8xmutRIc=;
 b=tSR/d9ON0tQmWk6edfFF8WGY7TxwIyzF2k0EelQYlF+ldNXpWl/hoQSrsGcmZtjJ3Qg/a2jois4X0CAxFA97+lgEsJjBZDJMyR7uxXjk5OpEjrdXgFAy5ZSfSP11qc3l/jFTbNCNHA3Ytx7Np/+Z9hYJfVDzBp0jmXNneUfqtuLpvBzKU+XnKn0J4E2ZKDWq0pDSIw5M3T3ZMmJQG9ncIfHJJS5LG8zcxCCpPEr1U5pfjGop0Ai7GuMV8lLSzDiIdqWD5L/Mbj0Z+1zBGQ8ZHwJ44Tj9T7C3G+7Oap1RvGIkIgykETxpC64kM8BKHY7hY05vx7ZEUM2qkwub/ohQEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4g+99+MSpUZzZe+yJe/xJgQ96le67kE7X6P8xmutRIc=;
 b=TzSEUoNG0ZasEwPgH/43Py9AO3n9jjuSRuOkVBV1fZMwHggjwGBpWSuJfsHt0nwl2ofnBirXAa+BTL5vzbV511V9X/nQ1kCCj+KG5kySykecJ0lRupzw7cchZ5bwn3ZV9GzXwI3mAJbrr53RouBOnR/6kH2n477rvvhsdjfb9nk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DM4PR01MB7737.prod.exchangelabs.com (2603:10b6:8:65::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.17; Thu, 6 Mar 2025 23:48:53 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 23:48:53 +0000
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
Subject: [PATCH v4 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Thu,  6 Mar 2025 15:48:09 -0800
Message-Id: <20250306234810.75511-9-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DM4PR01MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 3560e557-60a8-41f3-5506-08dd5d0973bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6YtcGP2OyTiat4hdf3+RC7xvzn3oF9W3N/qJLtqt8ceJfg/113pTIvjqjQtv?=
 =?us-ascii?Q?8r1kIq0q8MHOn6BcTOyHHYx3m1JaRJaCIq/EODqR9jaVOf8YL42QqPTNbNA3?=
 =?us-ascii?Q?QKSBltWxv0ji6+tuuvVNOUKxVAB0VHEFM4nmTwd38qAW3BFLLOHHheWBPGeH?=
 =?us-ascii?Q?WSW7CMUx+YU+tM4rsUmxjhHfwa76rvJJbRZy+CwGnxjd7vIN/U/Ek7s3Moxf?=
 =?us-ascii?Q?vwFtO1Q5xVEKpecDYgAw7c4Pq8ULOHP8xXeZsDit5vWlcfnUs+8Xv9lGkgyK?=
 =?us-ascii?Q?02j1jTQpgS758R0HeLUvxMmVfMYEejJSq4ya3Wpuz3K5YoG/z2EhgdggdnpA?=
 =?us-ascii?Q?NQA2vu47bvR1DGw3Ktl4ONw7+PRASLgg3LLtw9i1nffmfo5RFRpXJY9s/l+t?=
 =?us-ascii?Q?hzV7NGxVsIfUonybbT45u2k/dlojaXvVUQzww6rH8Ans4FYnltjfTMUwBP6L?=
 =?us-ascii?Q?KnxksrEN1rhpYiLOZ1cDyhECUIzYgeD70uwDclThePu/LMk6nIxM43Icr8tJ?=
 =?us-ascii?Q?Ql8gJbJ3V0G+hcTqzf7fubfG+XgovsRDgwFPKSz9r9s3ncJTsBTMt34cgUOd?=
 =?us-ascii?Q?SN8m37tRxIVk5sZpn6ZdrkgitXroAFNslcqKmgCk8Gcz71Plz5fs9ocRZ/6+?=
 =?us-ascii?Q?u/+JPzeH13X94X9wwAo03wlzHX1Wz2N2NBePgsR2musfrUrjb0svfn5oz6Nd?=
 =?us-ascii?Q?Fei6H13hRBmwKnjLSfwP7D/hM+GmTrml3uNTcAjlIdYoBFZLIRy2kL8LG7b6?=
 =?us-ascii?Q?g32Q57WlfGd2ya0k/yXH9gvITQcd5VHz6vCXTAr/TUPNJp7Gq6hHmzBsEK2L?=
 =?us-ascii?Q?2Ri9LyAs034EvGwdU5DXVTOe5HI0aJyQ6JMeeE6CYbleyJFzxe1T1zKKsXPq?=
 =?us-ascii?Q?CXf0PddzQnMVri2HV5KmjclU4+RHCTW5pdkaV8hwT2BfTXb9x33DEzi+5z5a?=
 =?us-ascii?Q?sU78+Ew4eby/hlAh7c8/uxQhfocWiHAPoCjR9TxYvXmIf13j9F9gLAmQPyKk?=
 =?us-ascii?Q?2rgAOJ0PZ0QcDCIkNSlfI6T45ff+A8ILT0mMEzPHP8P8aibmPlapw50V8aFi?=
 =?us-ascii?Q?aO4jibZ6FpvqL9E/2P0uiT0BK4aL1JFVIK2+U0E6TdsIimJ28HopHqB4JvMJ?=
 =?us-ascii?Q?ZHU7mTnPLdBvjvBRkyqdnemLFLVLP9Efd/GF6SXFOi5EwBCGeu8iah4sxmY6?=
 =?us-ascii?Q?qbm7eiW4uBDGnaXZoERIWZV0tRgwg7LkdGRKPy7cpVHKjJ6qVblL/f1esQ/s?=
 =?us-ascii?Q?A0bwzRf0NkMpGcwOzBGnLrz1jHmAywY8e0aHYRMRG4wwUIYCJ+oyYF8x116d?=
 =?us-ascii?Q?jSRv8Nv2dbt1ckIA8pqUG/AfB3sX0p1wJoQuPPSOBA8vX2idSLcrzsQp473K?=
 =?us-ascii?Q?fw0cN09itOTFdODrKsPm20C1g3keWaIe02rksWfa4EwZZa3Dlq8bhzExxRjv?=
 =?us-ascii?Q?ZYbtU1GgKGXEW9ArwtZzChxgwWBw9LWagQiFeAZaKJZkwMt0XgIGzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pe9sscUfqJHE4g08oYaYKikxBjzqrBzWuuA8hWkVhp2PwCvXd+mHkUIM804u?=
 =?us-ascii?Q?H54bcy0Cm+K4Pa57gS53uM8KKYA2xQPVYGaMXhbZMMFoEGIfVcs4wK5OoAnC?=
 =?us-ascii?Q?5lDvo59m6xVwOt+WUuppEKzRFqVgQsPaiV/g5HIAuutG5GjJGR4hxfXaUqvC?=
 =?us-ascii?Q?MYu1ikAtFSx+5VacdLSJqFbJra3UmWxV2J+574hTJUqjuaSA8F+hjq24Pcga?=
 =?us-ascii?Q?2l54sRaEqRfSDs7smqba7qgy1zGeM2meI4kHUyMzvZcbdqUygDYj8UCgkg0h?=
 =?us-ascii?Q?AsnOxPZ0vktLJ7XszNHy977hO4uITbMis0tdJvkCRU/NbgztDVTit8rjOYE1?=
 =?us-ascii?Q?O6VgwZY6nS7sdC+pAoaIERm9OzI3VyKpQoWGUgfELA9hyq2+vzwOEbhHBTMc?=
 =?us-ascii?Q?r1SzOBc8DyYEkCWnvXXTYOG6ivqvk5hcTw8Bs/7iUPV0aH0sLdndwXxfGmKt?=
 =?us-ascii?Q?+eBsCYn0d5nAGWP62uMG9LZ58tlRoZJbr5yQ9GaHq646tu2f7d/VanYjB+0q?=
 =?us-ascii?Q?OQ2g29ejU43aCVQshp9GUbFmUnpCY01aKXfSVbf51uW0OznZBa7rOXZvvEV9?=
 =?us-ascii?Q?gg4soz8k7gzxi1jq+3JD026hZPRY2qHfVwHvKdSg2vrAAqSkG+obxgq+rVXu?=
 =?us-ascii?Q?6LPgXBxV+OzGZSYIlibN1m+KEFLaLp6LHPxczFh9+O6blqXl3siZ7TYly2y5?=
 =?us-ascii?Q?noeXMk0qGCWQOPqmg05wbvWpSDML8NADXHyix97vxje/aIE3qT31x/v9JcXl?=
 =?us-ascii?Q?ttBe9U7ZoxCIjYizd2274urxrWxBtu1lGqhQIV3De2fQjH+OXknEEN+cPAM9?=
 =?us-ascii?Q?gdaN/vnFb7XZvMqaTQl36yOej9i+tKhz4ohYQ/iZBkZQSa/yk+6WzNUiS4n/?=
 =?us-ascii?Q?wsNIf3ME0KsSpVrKplISedpuxVhEKTWcr4IwIaKZirMGIqTCLKOSsAtJIlGO?=
 =?us-ascii?Q?lMDItLn71u9B8LOr2jMugNwPZ9qLya/4R0RizWYmbzjA0/BWHIX614yzypGF?=
 =?us-ascii?Q?hswmq88DLv1iiyXTxYtmsy3qfafSIo9RVGqZ7biYNPcoU7F9wTL8o4s0ziUF?=
 =?us-ascii?Q?ntzdq4YUZTMFYmwfxiEKsS1nhdTvUlN25+1H2NIzu81VBxid3q/uO3fvPcqY?=
 =?us-ascii?Q?fC63+iNM8IMUjTvhwjM+oHeQIyFlFtUg+xPg4QqN+HdiFqYkp9pRy9LpUxDq?=
 =?us-ascii?Q?8mDpmu3Q9S0RiiC83gJQ3Hz8HIPHS+WKY4OUu8aB+bde5Ey1NuFItXgzjR2M?=
 =?us-ascii?Q?TYZEVGV3CAwQ1a8GqcjB/7gLKUp+xWgh2URWix8APGfr1UGeRp9Xg9tDkRC7?=
 =?us-ascii?Q?txZv3YcA3IzNSFff3Dj7tViCBALTJ08koL2l0Rl2LwWJ0xN6054DrwbYie+d?=
 =?us-ascii?Q?WTVjl0I5dcN0fKeCZpBV3JS/PdIpaaFJCvy+RW9ZEgr502qM8rCi3vL6Uvp9?=
 =?us-ascii?Q?74YJYOsx5VEQs7vj1MjrdTUWzFxxa3g0MetXgMsUAJ6OAB5XsgiFvbk6F4aC?=
 =?us-ascii?Q?w6yWrihGfOVdMlZzw3QrzAHyO+3m90bWuFzYxybO0zDGCGie1m2YQ1pYEwCa?=
 =?us-ascii?Q?HevpMKY+61tIqDnyh//qf+o+M5kZUtB9mLrEgPysfV86+n12vnNlGKZjc3cF?=
 =?us-ascii?Q?sLGjOVG+InHm98AO+Uc0HJ4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3560e557-60a8-41f3-5506-08dd5d0973bc
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 23:48:53.7098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XWTKkfyn6g+BeN7vmx6nscz5knWsJ31OwU+hGb921Y7Zsq76ULfGp+wO76NRvZeaxaklmbpIIl+vaBdWgdkatG+5Rh+wQOAPoMGKrrV+EfhBFKJuEZXanoFAtoJWUZoU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR01MB7737

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
 drivers/acpi/apei/einj-core.c | 101 ++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 4c748fa0a479..1aea84958b00 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -87,6 +87,13 @@ enum {
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
@@ -111,6 +118,7 @@ static char vendor_dev[64];
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static u64 component_count;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -181,6 +189,8 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -288,11 +298,24 @@ static void *einj_get_parameter_address(void)
 		struct set_error_type_with_address v5param;
 		void __iomem *p;
 
+		v5param_size = sizeof(v5param);
 		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
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
+				nr_components = (len - offset) / 32;
+				acpi_os_unmap_iomem(p, v5param_size);
+				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
+				v5param_size = offset + struct_size(&v5param.einjv2_struct,
+					component_arr, nr_components);
+				p = acpi_os_map_iomem(pa_v5, v5param_size);
+			}
 			return p;
 		}
 	}
@@ -484,10 +507,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -507,8 +530,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 			v5param->flags = flags;
 			v5param->memory_address = param1;
 			v5param->memory_address_range = param2;
-			v5param->apicid = param3;
-			v5param->pcie_sbdf = param4;
+
+			if (is_V2) {
+				int count = 0, bytes_read, pos = 0;
+				unsigned int comp, synd;
+				struct syndrome_array *component_arr;
+
+				if (component_count > nr_components)
+					goto err_out;
+
+				v5param->einjv2_struct.component_arr_count = component_count;
+				component_arr = v5param->einjv2_struct.component_arr;
+
+				while (sscanf(user_input + pos, "%x %x\n%n", &comp, &synd,
+					&bytes_read) == 2) {
+					pos += bytes_read;
+					if (count > component_count)
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
+				}
+				if (count != component_count)
+					goto err_out;
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
@@ -532,7 +596,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -584,6 +649,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -594,10 +662,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
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
@@ -747,7 +820,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -766,9 +839,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
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
@@ -790,6 +865,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
@@ -945,10 +1023,11 @@ static void __exit einj_remove(struct platform_device *pdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
+
 		if (vendor_errors.size)
 			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
 	}
-- 
2.46.0


