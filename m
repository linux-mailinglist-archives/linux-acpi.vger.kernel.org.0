Return-Path: <linux-acpi+bounces-13517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEDCAAD057
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 23:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11ED19853D3
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 21:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C3242D74;
	Tue,  6 May 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="cmKGJKUa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022102.outbound.protection.outlook.com [40.93.200.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AC242925;
	Tue,  6 May 2025 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746567529; cv=fail; b=LUQk2JPxhPCLpRFmMsbRQTuys+oSDON4O8BPbWUhKgxSxCfb8ppqC3rZvw0XXvugky3HkwXhykxqLcZ52yHuBCaE6jnXRE4iq/emrQW8ANg67ccIUEjiN6xsf9zllWFH8FItWX49H4SG9tEFVreibuFq9HeKmxFwS5snd6q+eD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746567529; c=relaxed/simple;
	bh=PNEcV5WXaTl89tmntZbZ26Jmw3XvbC5UpGilY1EoAuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lg36Q7Y21WlA0O5B/HsF9k1PY3N6vnY6CoVReIqte8CouuoVo1GlA0g3QjbpUumvtaDR6NHoBUDX8k06kLMVC2kqCjJiSDPj4OUjlNCu4TA+7Rj/lRvLg/zzusNA3FInal1RtlqAR+QTf/weU2a1IyaLxQ46SyIqpjUgCmXjxx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=cmKGJKUa; arc=fail smtp.client-ip=40.93.200.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AisNW4ISMZozeX0iouvB7cJJqfOlBpOLA6pAtwgZxkS7l4sEBqOAs8EmCGugRphyP2fNC5XxU+BuLufPxV+w8B4f1/iA+b6INxgurk5Gln1rmrP9RC/XhxHFx7ieOAt3tz4Qfjd8p3MRjis1r6SA6gHqVd5sVrfmrVgS/gX2LTj0fbpifd8N9urXZU0xscfJPHvV9lJPZuNfEL+khEK/wWGXqSRI369Fi75pCiz/tcgaCyos/OvYXc0QI1H8E5IbvA5qL6SeymdsCOUxtpx6LK+eY7jxZEgNnS3DYOcZMb943acU+TCDVIROCTDSDOZNoZyGqTEuzQSpDd1R1CtWlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cP6oVO+3xZZqXf12B0fYcRcH/7BiO2oARAWntCa2is=;
 b=wxTVN25pfjXx4QTHxh5dS97vWFHTWziHChkHgcClb4zI9rP19yxP6+xKt9GLFZGGLbwagCu2Ml/6E8J4lhRcwLmWDo7lGhHLvt4CMagO6NUzoC0vJn1mF/P7d2tetT6bOqeeDRTd485OHb6vjdOXgALrJDtRdaHH43/lAGqdj5bSlZ2RDwQoATZz1hXLA2DyGf40e0Wi/tsBKhVc13RXTdqY5gI3+910k1GXzE/hwol7BuAmdYafJ6oBiwk8nxJKqS2zLNTAE+fxXZwo8VEKGXmOnT0d7F/9mplEgLok7CWKzT6KGlLcH+1A/zNVvRXhzI0py0wCw+DG7k5ot7Diqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cP6oVO+3xZZqXf12B0fYcRcH/7BiO2oARAWntCa2is=;
 b=cmKGJKUa89Hl9c2h0hemKCDu6xKZZ22c/rt/SGOF/xykdtVRVJAdQw3a6kA0URlwVhT6XTQW4LOOVMcCVz5npRA+XzFWAQrDJeN1mH25BDCcpbvX3zGO0NTVPhke3V4Gx1KXwu25qkimutIU0SJDkb9pAybum7UU8mAtdUpj+JU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA6PR01MB8904.prod.exchangelabs.com (2603:10b6:806:430::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 21:38:41 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 21:38:41 +0000
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
Subject: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for EINJv2 support
Date: Tue,  6 May 2025 14:38:13 -0700
Message-ID: <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: e17389d1-f7a7-4507-57b5-08dd8ce65e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fePo5vpkBT1b28KbQm55053NXmY7ZU0btdmI3uIzFGjiaXM9hQfs012cJF4m?=
 =?us-ascii?Q?KOMhLNKEv2chrgWlUXGZWX2JKX8msDiqZLo2mtbtlawpDuVUXyWfAbCSRba6?=
 =?us-ascii?Q?glR5uk2YjNwyd+GEde4bIK8kLKAmDifcdDOLFHVCyrkhrek5ttIdIu63n2e+?=
 =?us-ascii?Q?hsEWZgGEHNwOArtWndnPebvzC+M0UCcvVoiTmLCiuUbAtUFBqjbR544waMWW?=
 =?us-ascii?Q?erhXoed8bp+yGYTFTHyPx9AAs0xfJJuxJpSZpiWNBNfQ+m+c9aXUfC1J7oB+?=
 =?us-ascii?Q?Jhu52Th4nAABnS/Z1klgaTb86l0jonL/zJ5d3WhxobFc/Hsf9dvNf2h9RnT2?=
 =?us-ascii?Q?ggmsyohloWHymyGKr7EH42jrHIZkPPinj8f3aTv1qCbQ6DYviJApZu6Pp+Jk?=
 =?us-ascii?Q?M8uLahnLkYduG4Ilxk1aCpSXRZDhMsk87gq7y7Aqavypb3ogWQFl6B2drD96?=
 =?us-ascii?Q?N7RfMxnr+6ey5PYnAEuHeMM+YdeoQ6FMzMi1g+JlLYBIFtqStXu4kvUWT2H5?=
 =?us-ascii?Q?Q4oYdjbvkUyc27GTxyV5MIY69qE8rOPie+RrmgihKwsbbPpDHY4Vnj026YoJ?=
 =?us-ascii?Q?YAB5gvFYdmcocN+HahriHAW11QcJLFOLKMtD9IGHpOTynvF3naoJad1ZS3hR?=
 =?us-ascii?Q?hHr/3fvn2dBc5C4jezPSeozSBn8jlFKg01ZJjzYM4trNwcOAfFrLZvfbDL+U?=
 =?us-ascii?Q?oIqBtJlx8AouarvIs9d7j3Fb5QiITrJxrEKSzsWdMlv9Lk6r/BftplLIXEV8?=
 =?us-ascii?Q?6Q4ozomCP5vG6dge/Xs/Qh4T924VPJHETVVxqnrk9w9ReJlzgbVgCBEbJk4d?=
 =?us-ascii?Q?pIUg4ADxIEidOAdnEnnlH6/e1IGOCmgzknSy9ypdCIVNfcVr2pN6v8rS3mT4?=
 =?us-ascii?Q?QJl069TTa2AR2YDcjUgLwsPTWMS5ChatxXLFJTpIL1RAp4n7L7BTcdJWRor3?=
 =?us-ascii?Q?qvCGMrN2x9y+uFQ8V9qlRn3qvuzghbfy3yl7xLKRcybtX8W06okL9ot/Fqj2?=
 =?us-ascii?Q?WIZ0dz9OJEzQDLb0vvN0zjstc6OH1NCFh14zbx/MC7naTzjc420029JwJs6v?=
 =?us-ascii?Q?O2cRtDnNngI0E0wRrV49TIhURC1aIz1dPR9tZpUBSQWVG6UNsRrDaBtnY4UM?=
 =?us-ascii?Q?+8JVxhA12/yiYDP8reYnPuDb7dz9rTiWZMsbGJC8cU8IsGEl5nOXewbbRAEJ?=
 =?us-ascii?Q?/Ybos2EznDv/mHY86fThMB/O16pPWM7kIXvQtQJPAWTrZesCFo6nXrMDA3nX?=
 =?us-ascii?Q?9EOYS1c95pE0ueQ3zghvZxF+/PJ3fJq8mFQwKxbmHmUKfwLWeEzDzT6CTr/H?=
 =?us-ascii?Q?g9OZ6N/kOnC8N9XHuC1ujpd9q31I4LtiH84uNhWu83n0Yf1Y6wX/jFYL3m8q?=
 =?us-ascii?Q?jumiG6UfZomGEtkqyflo5C4bv1OihRa5f0zFcxTc1irAX5clc4mt968OSQqw?=
 =?us-ascii?Q?U9cFwTiOVpHIE062H1Q4ugZrTHkefuuqgf+M7bre0g76KiLwF5ZVDLH5qz1p?=
 =?us-ascii?Q?r1N4v4ygdAIkCWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpbfb4HcQS925C3v9bkxyZG5iW6O2fgTB+Q4Qw/vtEoYUXRJXfjP3fRsgLtO?=
 =?us-ascii?Q?gn60qCXfPDJ8BjMuTwyDj+ue1cRnNklmB0dgy8LzKTGyfkNuckSB9CYh7MzP?=
 =?us-ascii?Q?/Pu4C6sZFLlxLOTq8cNgCEl0ygCXfx1946K4Pw0mw4wLwAxTKSl5zXzj9i6t?=
 =?us-ascii?Q?Rl54OJunRbtwlpOIc6VG4JtEX0xSlivyZVBOIGDClysxGwYCl+ueU5AoJ9R3?=
 =?us-ascii?Q?6QV3eGbdpdBLKd+7LHVqn26axKqMHQ3EBasQ5cbd3Vsw5EGCTVB/F3JoBk6o?=
 =?us-ascii?Q?Bezsi5vjsk9VxpbnVPVKaZ0WFEhuNOA+q5HSdLQA1pWJtCS2aI3T9FqxDFMV?=
 =?us-ascii?Q?uzqKkl1tySUaMS2hqTTcLxEVLuI9zJy+8mZlIF/ggiG116JnYKQLPfd12GBq?=
 =?us-ascii?Q?tmgAZOVYCLhE1vrt/IdTiMsB17Arz9RFWCWYhMiDAY8C2+H45B46nF2O8xUQ?=
 =?us-ascii?Q?JGvT9nucQONZ450WEzcS1SwfVQijOcnZHhMYVgqFfYoEGbFhbCgVIPSYqlOL?=
 =?us-ascii?Q?kN9tqSMx139CXVQLf7v1q6T9vxmH703sy/hlp2bvKomGGAPhP1u9qOHzpg/5?=
 =?us-ascii?Q?4YWkwNnNqWqzhnW49VODXTS7ZOAIqr0hcWDTP4MrGK7A//0x4LcSDaO9eL5U?=
 =?us-ascii?Q?jLtQpHr2+L1RQRkUUm4wb6W4JCeOaRVvd81EirTN2+yOt+Eo7G1CPQCCD8xw?=
 =?us-ascii?Q?8uApsc9l2v3rd+whs9YoI0JHYUiSRzpxuImKJtue9zGV1HxVnViDcixif+xU?=
 =?us-ascii?Q?SNFyUl+OEQXG8v8tyB5udUxT0KEMVA2xSZGN+8cvIB6wJS9wLA8Z3oJHDeNN?=
 =?us-ascii?Q?09gwUti4JsFd/IpM9EIFSEkugFGhdzHsopSsIvJ0ACIwiDaOIZhS3KsKHhNf?=
 =?us-ascii?Q?9DtdDsm0bTEMO3dr1LmgFM5FmdxYVtViAgOwVcy5E7rUo2KSNukzsB3eWxVy?=
 =?us-ascii?Q?n/hTnqUXvFUpbVvuJJVsMJsWgSGpuhEqGuB+E8A+zmswugFavJai0C8Hl0GK?=
 =?us-ascii?Q?hA/IkbmAHxVy/SXrjiqE3p3XgvpkO9wwV9B8pAv85oGy2Gz6Co3CiuLdeJim?=
 =?us-ascii?Q?DxxQ7XG7bGMNydDzJAbLg73bcgSkWtA3AYqmHF1Bil46zUHCJPd0yTzoosRa?=
 =?us-ascii?Q?KL/UVO1jbDeQQFfeya2Gvfs6ji5bm86h327m5i74yEBJ0aKRhdKXZ0JEDO9Y?=
 =?us-ascii?Q?P3YmVA4zxrYU3Y7uUCUOsGliQowvdzLFPNwAO55YctAY/rnlByQvVCqIv4oG?=
 =?us-ascii?Q?ZB8JdZwp7cE8gjRn2SQBIXVwc9T9vSdnMOVMiLO/83lXssDxI32NlkWMIcRe?=
 =?us-ascii?Q?3UrpyOMYF1N0+eYVHl1+WWWsx02ZAadGSuXX6lAtl6a/Xf1psChPG0+WtD+b?=
 =?us-ascii?Q?PgkoIgimyETGnTNrgGuqKoLa3HguDn4IpHxjIe4V7VTh/9okX55YfmfwzgKe?=
 =?us-ascii?Q?SDrQfiqB7HgnUhXoX5m+31G0GDMLX6K6tLHhx6w380Xh9Wa33PfHw/bnVZsk?=
 =?us-ascii?Q?2lexibEJZQeLWDa+LOkmNV/DairvZH+4NTANLNNli1gfYbSMaTG4cANvQ55J?=
 =?us-ascii?Q?0Ull0qpC6GRvBXlKbLSsEmO7gZW3J0WDF03inSt8fx+FJKEMZ69XKfjAqsaU?=
 =?us-ascii?Q?4XLG6YUSzr8+whEPLIIdmBs=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17389d1-f7a7-4507-57b5-08dd8ce65e41
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 21:38:40.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3amVe2o3KyTXji6Zd3WFDZevn6iyaj4iIwB0Z81dwRQt/SNLRIkeH2QNt+ZjVsa2+WQ478CJhFu7i6lcqNIpVvA29qVHLuMOhOqMX+Ny/fIHsQcwaRshvHdtqkVUB49W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR01MB8904

Add documentation for the updated ACPI specs for EINJv2[1][2]

Link: https://github.com/tianocore/edk2/issues/9449 [1]
Link: https://github.com/tianocore/edk2/issues/9017 [2]

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 .../firmware-guide/acpi/apei/einj.rst         | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
index c52b9da08fa9..edf3a2165e75 100644
--- a/Documentation/firmware-guide/acpi/apei/einj.rst
+++ b/Documentation/firmware-guide/acpi/apei/einj.rst
@@ -59,6 +59,9 @@ The following files belong to it:
   0x00000200        Platform Correctable
   0x00000400        Platform Uncorrectable non-fatal
   0x00000800        Platform Uncorrectable fatal
+  V2_0x00000001     EINJV2 Processor Error
+  V2_0x00000002     EINJV2 Memory Error
+  V2_0x00000004     EINJV2 PCI Express Error
   ================  ===================================
 
   The format of the file contents are as above, except present are only
@@ -88,6 +91,8 @@ The following files belong to it:
       Memory address and mask valid (param1 and param2).
     Bit 2
       PCIe (seg,bus,dev,fn) valid (see param4 below).
+    Bit 3
+      EINJv2 extension structure is valid
 
   If set to zero, legacy behavior is mimicked where the type of
   injection specifies just one bit set, and param1 is multiplexed.
@@ -122,6 +127,13 @@ The following files belong to it:
   this actually works depends on what operations the BIOS actually
   includes in the trigger phase.
 
+- einjv2_component_array
+
+  The contents of this file are used to set the "Component Array" field
+  of the EINJv2 Extension Structure. The expected format is hex values
+  for component id and syndrome separated by space, and multiple
+  components are separated by new line.
+
 CXL error types are supported from ACPI 6.5 onwards (given a CXL port
 is present). The EINJ user interface for CXL error types is at
 <debugfs mount point>/cxl. The following files belong to it:
@@ -194,6 +206,26 @@ An error injection example::
   # echo 0x8 > error_type			# Choose correctable memory error
   # echo 1 > error_inject			# Inject now
 
+An EINJv2 error injection example::
+
+  # cd /sys/kernel/debug/apei/einj
+  # cat available_error_type			# See which errors can be injected
+  0x00000002	Processor Uncorrectable non-fatal
+  0x00000008	Memory Correctable
+  0x00000010	Memory Uncorrectable non-fatal
+  V2_0x00000001	EINJV2 Processor Error
+  V2_0x00000002	EINJV2 Memory Error
+
+  # echo 0x12345000 > param1			# Set memory address for injection
+  # echo 0xfffffffffffff000 > param2		# Range - anywhere in this page
+  # comp_arr="0x1 0x2				# Fill in the component array
+    >0x1 0x4
+    >0x2 0x4"
+  # echo "$comp_arr" > einjv2_component_array
+  # echo V2_0x2 > error_type			# Choose EINJv2 memory error
+  # echo 0xa > flags				# set flags to indicate EINJv2
+  # echo 1 > error_inject			# Inject now
+
 You should see something like this in dmesg::
 
   [22715.830801] EDAC sbridge MC3: HANDLING MCE MEMORY ERROR
-- 
2.43.0


