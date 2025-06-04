Return-Path: <linux-acpi+bounces-14138-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE283ACE6AD
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6124B3A8359
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F86F205501;
	Wed,  4 Jun 2025 22:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="XXcXQzqU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ECDBA49;
	Wed,  4 Jun 2025 22:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076701; cv=fail; b=LAa4IWdifvPzE3+zkBrVUXQL+U5RojiP4COJeJRfwQk288UD4noZUFpCGE1nx5aa21bp5Q/yzRrPyGSBYdAwuwod4lvAd0lRuUFFhcNTcG3yrrhNP/M97bF1kNX2rcWsC0xJjx0EgiJJoul6WY0RopyVQAtkLF0Th2KbQ01b3nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076701; c=relaxed/simple;
	bh=otZeO0hys3bfHu0TJVdqAgzgu0ou5UIxMV2eqDyxSOc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XwmQe56Vm/dhAeTbKuT+7swI+7+oenaJw9ffp07MOSK5kFuEYnbFr2vG5eSj5W8KcFspE1ShkPtRoOkLkB4sLVh8z6UkARg0FVMfoUPqD4jKIoHKnhvBG6Ky8q8Wv6I8cvNWTKnaKYfJSfCyzGfpnLa1HzIa6cfy6gjbAgG0bbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=XXcXQzqU; arc=fail smtp.client-ip=40.93.201.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rlM13sVyc6xB+iHxzPdDBvOhlsUmK2qpMXW017gw2vXEVty5PYX3SpfUEIAU4CE3sMTzpeN2VrwQxdV0inCPIfDLsKDTDk8t6k5psZyMOWZ5/PfdHqN3aL/Bqokm9I2L2XbLoq/937q9EgnojggiQw/n+nU4dA0ghxT5UyGcM6rOcFvcPR2znmmj636GIKUPIvFEbMxioe8U0+T0YCQzXEYHGb2knw2/VDVNQ+xOChkZ3c2Swz/uHd24Z8yDqp10lgMzXj6Zfczo3nIZlTvzgfXgd8Uvk0G3eVWbxkab283HZBRdbdbwhaB5iA25zO7o8NzSAA7JDAROJT2jrFFdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAfKKAONQOUeOTWLZleFiY/i9YWQmWLFyRL5u2ZM90M=;
 b=blcT9V/nU5BfsHsJY8O/4VOrq3+Z2jTClsA8dC9C/4MLE4SjwnN/n7b/rv9aIGzhqfUkkwXpPicwXuU2ZSfOOlyGfd3G1LKV/3C7cnfnHCE5cVTSnOJ7vmbeymSgHNkKS6RzXEZTk+/vGedq02/usaFmlowHnctOnhl49vzQI+kEzEhr1vWY9vl5xz9EUyU1ucFPUHCoGNresWq62/yTmRKYippT4noaOPO0ur2ZeDK05GVdjVYlblXqfCWu3iJmRfvXFsGtwbAfd9NhPBf+RrkStJBk6Pt/HWlVffdfTs8gVC3tjk+Y2nzIjcXfd5aXNSKNalM/UtpU3LOmrmEkPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAfKKAONQOUeOTWLZleFiY/i9YWQmWLFyRL5u2ZM90M=;
 b=XXcXQzqU0u5egcBiaZVK1Olsa7hE/sE4dat+A800FDtx7/R7E2vvChNmRw4JjWqOywhKPrxhaVgTppUredpfK7bLpo53KGFXDM1DNQ41eDcMBIvPqJWeaGtWkjs+bYLezQOeGsLD5G4c7Q156hF3Ul+eOzgx0IqJsUo9/p5qi/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CH7PR01MB8810.prod.exchangelabs.com (2603:10b6:610:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 22:38:16 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:16 +0000
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
	u.kleine-koenig@baylibre.com,
	jonathanh@nvidia.com,
	viro@zeniv.linux.org.uk,
	ira.weiny@intel.com,
	peterz@infradead.org,
	sthanneeru.opensrc@micron.com,
	gregkh@linuxfoundation.org,
	Benjamin.Cheatham@amd.com,
	dave.jiang@intel.com,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v8 0/7] Enable EINJv2 Support
Date: Wed,  4 Jun 2025 15:37:57 -0700
Message-ID: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|CH7PR01MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: e42980ae-4e1f-44c4-45e1-08dda3b87f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6I3qz6Woe73mk/h+23a1Tx6QyJjGw26S8PQEZgDQUx9ewYrFUXxwS4neY1Xl?=
 =?us-ascii?Q?A3hqMfycrDKnAD7iJNGeT8Z2Ju2YrYjwX8uI/+JEc8kOIsjLN5EuFxi5GJ+2?=
 =?us-ascii?Q?gIiMLKXp01DCHwWBnFqJsC99dHV47pS0F2w8xPKuDNgOeneFe/r9+AONMeSL?=
 =?us-ascii?Q?A0QMVQn5U9XiusD7EkobyGX860MjMbpM6aFnOugl2jNo53e0eUhblJAFKgz8?=
 =?us-ascii?Q?D/3VJja1bA8MfJdo5lL8GpMQaPPA9V3fU1jpglFH1bd5hJwNCGqO8h5bmXHu?=
 =?us-ascii?Q?Zq9YMygmex9sXogaxOa/hKYynFsGDEJ2PMkQUe535usGm/M0iscyaqO81YT1?=
 =?us-ascii?Q?ZK3Le5Hm696FM/mwhOB3ZyH/NJPy2NZczBhg9n6nRHzyz1uXEXROwNly3R2u?=
 =?us-ascii?Q?ngGR0fV22hWhE7Rqb7KCngimdVHEM9RBsBTGbTI5Tg+bBmfyx5Kh6JAzQ3eu?=
 =?us-ascii?Q?LrSyvRYZ6tH5ZjesKzLVAGz3OMwEwOdU7ll3RcAA+WtWRvdfcPcCAqBnj8KI?=
 =?us-ascii?Q?zPNcc3p9iAYJGP7ONY0wHSxgu53mOTIvlLqQZvDn6hXTTfqj5OomXPghzwH4?=
 =?us-ascii?Q?UzwOcdO56s8ZBiRvvmJSGnpWeNncPlTndMSv47MsbnYH/RLTYAioeyanZLxR?=
 =?us-ascii?Q?A0lRx+dpaCqmnEekMTuzryFg4mmMYjaCu1H69j5fO7JcT3j6uERGWW6r6Apz?=
 =?us-ascii?Q?VS7LH2jFTppIsNp2y9BIdRD6+4RVCaI4NGrgb2UkjJ7X5ao0J5v7rAxmKNHc?=
 =?us-ascii?Q?1KfnuDpFUqSbW/S1z5GuCaBLdRQ/TQ5Cf6aOjv/vbQ92wpfENM/zbsAPMKol?=
 =?us-ascii?Q?d1tvwuKMiuaAIammdriLsl/D9xmF0BCSM38To2LZ9JIELqEJi/ys3K9QGqhV?=
 =?us-ascii?Q?LV+w7iUxhLk0T8oHy0crnqNFFglTKqXL3bPv+8ptjQMrLUxfZITgvwvQzgon?=
 =?us-ascii?Q?t9CG052ZQgapxxS0QVGo8RcgjIWg0A8WNR5pFdSbZVV8wbAvk4h6xMoPEcNr?=
 =?us-ascii?Q?PfoZoM7ME8VkXy7SaC6YG/GZbf2QRKB9iOfpxizVX30k4Y7taNqLdY1U47x3?=
 =?us-ascii?Q?apbgYBFfgiGJwe7ru4/1025GtusD0WgtBxRJ08jMDQwApt2yX5Bln/50K1UT?=
 =?us-ascii?Q?OdXugwgeO4EkxKW/0lIlL3oTdEQxIdMBgpv61pdBKuxSP2LKjtydkRQIGFYH?=
 =?us-ascii?Q?VmR/a4G7btPxdtrxABPRj8em9zZ/iiS9lz9voc9pSlL0dS7W7YUNkW2gxxYv?=
 =?us-ascii?Q?6wvABMgrTCUlhtwlJDPXrYyGIRelsqH4/AmTgU8Ivuwt0YuO0lX603R2s+pC?=
 =?us-ascii?Q?BoGTj6IpV+CZXRN1foptPGxgc6K4CGrS3DazTtMHiuE2QGzqkzqC2c4i5pSG?=
 =?us-ascii?Q?6zO2Fird08y7UGLXFXyuH6eM/txsJrD6tl6zesv/HYp9gZovhzDC4drsJWCY?=
 =?us-ascii?Q?DvBuenSgSxV+6a5nnZ1fIoo8+ltg6jGt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q1Ddg+O8CEc/g5ZRgxFHFveK7kQhmsyhuFekEfj4ol6rq/AJoduIp3qtieC+?=
 =?us-ascii?Q?tshqsZV6wmt8XxwNbShR/7Qknxex7n+pQOrbV8cSgCzYoSqYFauNIA3QLRRv?=
 =?us-ascii?Q?jcT+etHHl1fU8mNaLpLu6nR2Ba3g7ynddEl4FbSWxgDgcRtONZFCcpLexcke?=
 =?us-ascii?Q?35k9PvZDTYDdza6qoGxx1/UtaGFKSbaXTMAa0vm8R0v9rkQxTxqdVNmjQuKc?=
 =?us-ascii?Q?agnKZaDjoqIhM5vJlT1pRl/TYr46Ymj8rZCSJR3M1iUsgVNAr24tpc91QmCv?=
 =?us-ascii?Q?j9kWi5DZIxB0EvTUQ8oBMRz2ZU0O7L0NW8Ha5y8oSksF8eHsytPTnLQd13ue?=
 =?us-ascii?Q?hnco6hz/ZdDgss/i8NxOaRTtWH6mwXNI1ZxdKwXsjVkx27s7ZV6OIn4PFFOm?=
 =?us-ascii?Q?k+9jYG+P9INqUZzlgNm+PoGKfMn6SdFfhTKk+F0GjuWLGkbtwZmrVRmEhHna?=
 =?us-ascii?Q?StNar/mKRv8o59J9tXoUzbOV6aLmJia6+M0EQc5JQq8tE6V3oFFKxTDlgmqx?=
 =?us-ascii?Q?Jrn37v6JtCLJnnBZuotJU1fXNonC4YyDqYD9XpVkFuPdIzTxRNnxdM+OZ3IX?=
 =?us-ascii?Q?LwfQWEsrL5rBM6Qf5sK04k+vqqqZKK3Q/MoqOfzuqT8z+ENZ/6E4R09DseX6?=
 =?us-ascii?Q?4iMriUEIhcFMD6riyM/FNAAS5ais2pSXe3u6NSkI6Ci0B7tB2fMRKufE42Mk?=
 =?us-ascii?Q?++c6Rs0VCCBmVUj89Ij4lZA+SjJvfPQPj5+s0r84DlEO7ocSh7t41o7ff+q4?=
 =?us-ascii?Q?gokmSzoH4vS0DtY3tvS/5cfCsGzs/WJqR2Xlnq5DUKzCC7oRni0jR6poz964?=
 =?us-ascii?Q?DG0wvJM0hlu7qtvlY4KU4IjjEf/zVuN7sbC+rwvaw9oWeH9E1q/iGoT0r0Us?=
 =?us-ascii?Q?a+VOz+aKhiqMYloc1Bl61eapcjaIyVsOAZaDJnsEleLfWGi0i8x1qS7s4vtt?=
 =?us-ascii?Q?SlBv1ExWH4BHo3vTZJv2G+wZ6IVxgvOlxrbJbODpKf82k2shSKFBe5cwSozs?=
 =?us-ascii?Q?xh1e1e84fbWc3NEbWjJP/vpWO/uO4mkwrP6M9p/YzhJybIUTXdE6mbm4u9vH?=
 =?us-ascii?Q?TP2kEJlubIGCo5cyWgMNyaejsMZkacjBTchr1h+EAvE7v1FnAvM2A/DYRnip?=
 =?us-ascii?Q?OrgGTWH+vOxyYGMe3Wv/36MqVU+OO+ic34MzzGHfu2Uospx8/yjaNeQDNhzP?=
 =?us-ascii?Q?HdVKd+siDJo2uejsMaoztLkeq+28ESHw4y/tZ6kLgfRgXXMsMgkdGzGFMjNx?=
 =?us-ascii?Q?IFpnjv25vdcKWk0Go+xx04ofBcHMFBx7yqSc/fOH21HH6qapDeg6Zv7O6jYn?=
 =?us-ascii?Q?t3+leuMI/pj1swS1953fRgRZW5VAx9qclzAN9g978ooAzXhqIKAE8u3Y8Egu?=
 =?us-ascii?Q?T/s4M6+heqg4BnrF/EBGDfNIycUEex+J65n7d2B+NmyDD6ofaEYDz3eTx6T9?=
 =?us-ascii?Q?0rZoxnfWgDDn5f5ybVLqH1GywhhBBq6Ud7NUfvikCcnfo8q/SBiGF28LzOW1?=
 =?us-ascii?Q?//kNVVHGK+iA77ookYlTaYMccIQGWt7JTLsbv5kNRRSVwQWL0pnwHad1ex4d?=
 =?us-ascii?Q?Ltiqu1isg7FuoDwAg+hew1NuPm1Qjbx4eVTsDlrAh9mEdZhN9oc5408S2ouV?=
 =?us-ascii?Q?YXZ2OiSW9Uwm86bO3egiWbw=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e42980ae-4e1f-44c4-45e1-08dda3b87f90
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:16.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihEvMdI5j0Ukv1mqgT//Hm4B5KrdwrQvtO0givSpiEPlKKgoDgI6vPLv1bTOVb3tvhfolMfsaOqCSL74egVuEY8ONIMvfTVu8X801JwmrkV1BWxrNuDBV8WpLFznmVEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8810

The goal of this update is to allow the driver to simultaneously
support EINJ and EINJv2. The implementation follows ACPI 6.6
specs[1] that enables the driver to discover system capabilities
through GET_ERROR_TYPE.

Link: https://uefi.org/specs/ACPI/6.6/18_Platform_Error_Interfaces.html#error-injection [1]

V5:
        *Users no longer input component array size, instead it
         is counted by parsing the component array itself.
V6:
        *Fix memory leak.
        *If EINJv2 initialization failed, EINJv1 will still work, and
         probe function will continue with disabled EINJv2.
V7:
        *Update component array to take 128-bit values to match ACPI specs.
        *Enable Vendor EINJv2 injections
        *Moved component array parsing and validating to a separate
         function to improve readability.
V8:
	*Update UI to use single value files for component array.
	*Update links to point to recent ACPI 6.6 spec release.
	*Updated commit messages and documentation patch.
	*Dropped the first two patches as they were merged via
	 ACPICA project.


Tony Luck (1):
  ACPI: APEI: EINJ: Create debugfs files to enter device id and syndrome

Zaid Alali (6):
  ACPI: APEI: EINJ: Fix kernel test sparse warnings
  ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
  ACPI: APEI: EINJ: Add einjv2 extension struct
  ACPI: APEI: EINJ: Discover EINJv2 parameters
  ACPI: APEI: EINJ: Enable EINJv2 error injections
  ACPI: APEI: EINJ: Update the documentation for EINJv2 support

 .../firmware-guide/acpi/apei/einj.rst         |  33 ++
 drivers/acpi/apei/apei-internal.h             |   2 +-
 drivers/acpi/apei/einj-core.c                 | 371 ++++++++++++++----
 drivers/acpi/apei/einj-cxl.c                  |   2 +-
 4 files changed, 339 insertions(+), 69 deletions(-)

-- 
2.43.0


