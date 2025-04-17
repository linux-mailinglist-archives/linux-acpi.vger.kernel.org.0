Return-Path: <linux-acpi+bounces-13107-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173B8A92D11
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6727F9247E8
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E012222A2;
	Thu, 17 Apr 2025 22:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dyXbd1Hg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA4622173A;
	Thu, 17 Apr 2025 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927252; cv=fail; b=kiJivvKKoZVPQXIucLipfLkNsG3nSqdiyy6qigtEGVHEBnt1WsGhJotvFWsejkULwXXRB/j3y+mTLyA7IbyJoM5yV5nNgqUF1XHOt1wHzjUwlt7bIuKpYPHDVuPTaX9L5XgOt3whueobPcu5/rb/GfVRLxmwfN8Yduo568h9ZYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927252; c=relaxed/simple;
	bh=f3NF4mnLeZwPrAbdNfRjhP0N02ulEq2MpvP2DoNN534=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V4DpfXjstXOqzkNP667i3HahSn5ORAn0/jdU/5CnihZFUIh2FrMGBv+q0tgKvCoTxabp9m03gr15kxvTLdWsztzMAJW/OsVxI09TFjKYo+PI8uJGIL0JVlC4p3M9Y+Yl0mpP3z3MbjxFSt6MuuBHlnlEgBTMVx7kXuRbh50V8Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dyXbd1Hg; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wHpy2VABvJsCdLuyKHLbyEtHdPaMUBih1akvSmvhN+7MWmU4Wvaxbyb3zS11MN/Ngk3XIaBFJ2IOatgyvxCYySXCJNSIRAl+7lC/IYBak//35WVmBJUElZdrCPxr1N5tMQEkf8wfYvM7+vDj2guaAhaA1QEoJEI7QCgFeIGSufn5o4e7ojQ4HRRBci2aN7L6dYhOlMip0e+G6Gu3EKriZn2lEP2+P4fMr07tWXXk7ubohRkzIkLQIhgmOjkZHNbgdUFaowHP/4zlXUyesTS0u7Glm3lBLxjmsresCQfTCCvNHwQCM5O9bLXP3Xwxobjik3qEhDSJLBEnj3GpYo8WEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS+Mh2+ZRPrK597srySc/dlv30BePRkw1oQWoy6//FU=;
 b=BF8Lrdj839OXK2XChsIvadMLM4ERJ6zBgluJG24zqSykfWEwN3oaIMuw5ZHFUdySKp6w9zxd4msLnwPH5kVWbz60qKjXty0NpgsNLEpXaA+RiF2v+4N1QrrVA5C99tt0c7ZG5C/kPAetZ2GVPFqI+I2QPtNxG5SovFfBhIEKXQeg3uWKYNLOeheZim7J1KiEwATstyZWJulX4n0gBb3vg0HxKKkKv6bsHthRASEaoPoN5IYJZ6nIWfN4yFo25RWZoYP9lsDZXnqvyCB9tR2ojvfiNzxlfXKkKERtji1iLF6ZsiRf0EAQHBZzs1by5kf4+Z/Rsi5JSKoZFR9UtxGVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS+Mh2+ZRPrK597srySc/dlv30BePRkw1oQWoy6//FU=;
 b=dyXbd1Hg+B8ck8ZyeWl19vof15CYfVF8i6vMNxNulHEVmdBZGZVemccP/QEl9UzMt39lLc347vhHYi4Uu0hxsdsI3w75OQ+iHv3Ia/xHj5H6QsIPmi9CcxYi4UKbv9Nl99WUwRo/gd/FiGbIkKN8+5lGgzVNLjR4Gh/kyrL4shY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:42 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:42 +0000
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
Subject: [PATCH v6 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Date: Thu, 17 Apr 2025 15:00:18 -0700
Message-ID: <20250417220019.27898-9-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
References: <20250417220019.27898-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::23) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|SA1PR01MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: f5768e00-d721-46a5-4d27-08dd7dfb4c32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gmoCioSZfNozBHwltENVplgPGCSa4buuoyg86BzFBKmIvBXpQwcULINbE/zQ?=
 =?us-ascii?Q?50w3i/LFzLRIyrJO/uT966rwPt0Al9ZXCPM2/BH6isirO+NnWWikU5YAWBd5?=
 =?us-ascii?Q?Ly/mTDGcDhRmabI5rb+KAjERmM+9aUNGXXVSvs9c+N/+aOIz13j78y1s0gqp?=
 =?us-ascii?Q?8NW7/rKsK3jheKkrHP/YPmT67e5rHfa/sqvSA+NxCtVkYVI8jDiSS551ZS6y?=
 =?us-ascii?Q?whrS+muEH6psp161ovYof036MmdEauchN9zsO+KStTJ3uFRWZ16wgkeajpnz?=
 =?us-ascii?Q?WMGX0V/eIPQC2w1aaXy5k0jeAzCYPB1skPWub/U32adOAy2sQFfyYRpIjd0B?=
 =?us-ascii?Q?fsGPa1wWbTbiN0NFIoEPHgtFYlUN72iwfRldz1G23+f6w59X57r0jxmegDL3?=
 =?us-ascii?Q?qsWiqYiSrbPmnSpP3ltiUFI9uuGNqSm6lMmLxIreBWYB8o3RcET+/bYGD6Ab?=
 =?us-ascii?Q?ITVDYDI/yWMEl9VWs1sMWm8QzJZwTSfDQErgFTv9QnvDk9kRk+rgkQ3hMOsL?=
 =?us-ascii?Q?ATDW3gWTbTsqXgEZBYfEnkpLfHT8Ah8mJ4E3HuuB2Fuu4znc2eQNWpqf8bOx?=
 =?us-ascii?Q?t1XVoiENM8wPpM2ccUmSOSKi23f3JEV/+DFeHUxsdV3x4IoKC9x1I2QcOGdB?=
 =?us-ascii?Q?CKyEkaXtEvTZWx5imd4JalV33ITh8ypm/OdoANSl5kqtjwqZVMkyQDrKFh2t?=
 =?us-ascii?Q?vM5QawXADri2Nx3OxOKCYKbBzdOTbXV3W6W9uhDZEYJuSDc0YFx517jPFb7N?=
 =?us-ascii?Q?oqBdmM69AGPr+mju/KGZ5+5XsaCRz1Q/bl80DoIA8oJKL7GhI3wtPLxbEwE7?=
 =?us-ascii?Q?jG0HVpwVoBersh1q+OOIIVKvxABGFkADV8dZymFj6FkT8jNHLSs75w+Z9Vcv?=
 =?us-ascii?Q?QEDsYTxc9+auRP9fN1tluMDGv6PoMelK0Jd5s9NsUz8Wic2dfWc4T522daT4?=
 =?us-ascii?Q?oSTNjm6MeD4NBhTmoqKP8/zAC/sulv1NoAydwP1hpfPkDKkUJMz+T221HNWX?=
 =?us-ascii?Q?Fn099ultCYt5NSojR64A8G1kqCmOHYG5LENnLwZ++SI76MuXhwafTfQxU9QF?=
 =?us-ascii?Q?elhrpa64Kwtwd6bt4e+hQoNMNDou9FJFLh2E0GYXGZhZc+c2DF2ZW/UdHUmx?=
 =?us-ascii?Q?xpyE7ioA/JLGCAUlNkG+T+0qrZSEU8dh4HD3FH6dxmN72j9A87R0eGNOvm9p?=
 =?us-ascii?Q?S0BUVV4oD52/kxJ0IkS2bZ4yyQULwoRHj+vJoY5xuN+snpkgyUnpQmVActF9?=
 =?us-ascii?Q?571shkiZaMIwImilznJPO+oz/Eqz5lnyuIokQIxuJKV7aUgKWNYzbyxE1vXK?=
 =?us-ascii?Q?hgeYPd23oCGQ353ieOVmRKBvoHXDBkW/hqivvzTRYTb08RfDd3r8ahwquUE9?=
 =?us-ascii?Q?/5kCh4DD30c1aqIdSrNWgvSOnwnnnb9Rz+ivkXs3lHlvfbzYd+iKLtEGPRIW?=
 =?us-ascii?Q?C64Zw7q651uw2dqWbtYEoHUyhH4rzKWB/UN/+Y2UPJVAzxWz5zXlV2XWCNfX?=
 =?us-ascii?Q?whxNzq7L9tS2Cyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvGLA0wDSkOMxY6qd7YErjTA9j4+mKkEni+sa5o90EnBR5HN8k1ll44OEg+E?=
 =?us-ascii?Q?Kd0WVslVJiOxAkzGzd7yfAlzUXVdJ6KLGY/4olzq3YZKAeIM6RWAMrIVKgjl?=
 =?us-ascii?Q?mHYDiBQShFqn7J6aBJzi4AIOAptYlA24eO/Xk8DvPiPx8fQemNGwKHoeau4t?=
 =?us-ascii?Q?VmMJ+sMOuIPnEjDzUgxemTOf62UL2Ox5Bmf7V59U66S5AMXezeCeF6uZnmnj?=
 =?us-ascii?Q?EJ741PAEegRswWcuicuXLCqymzYEiHuQneI8jxHVaT3q8M85nQMjdm3TC355?=
 =?us-ascii?Q?HoYduSF7NKMfQ8kPku2bIlrInzkhnGSOqKeM2D1ITPg7mPzWAemdXOKFdaof?=
 =?us-ascii?Q?fvqOaxqK+zlDOXPuIO0rhlJ6u81hHeA06YreD+IvuMrE9MiHa42yiTLqguqK?=
 =?us-ascii?Q?o/M43rVwTrhIrs+qnK5OXZf39xinLw2HIBGdc/Cafjh/fad3vCfWeZTIkCVs?=
 =?us-ascii?Q?s416lQlSQsF7RrzuxKLqghen2t6fFkMUBK1FOOGYBe1ak+gc0A7S6koKZzTk?=
 =?us-ascii?Q?nEO0O91lDxBUpEQOVjI9eRSU6P7UtCUMd/Bz2wc5q/lUmsEYVMBOC8kUEIdC?=
 =?us-ascii?Q?/h+9tPgwN/yO7RU3C2ar4lROx4ADVp9dkO7GPJlKS45BTuHn3P8q7OlArHOb?=
 =?us-ascii?Q?NeNtGmnbkiD0yFKMZEsBsZ4ONXahW6wfBmzo/zeEhid6CdAvz55eWjFQ7mvA?=
 =?us-ascii?Q?AFTIJkhQUb1LPM4nI7FYZ16hbPHhCUWpoqmFKPEVVOsFKotgvvBcn2VvUfRm?=
 =?us-ascii?Q?TSLCU+s4Tw1E5V3Wf2tlrKvTkrGDkeZ9U3ucINFGAXFvs8iLFmpgJAv4u5W2?=
 =?us-ascii?Q?9e8Y0QepN3Mzms1CWTPC1sd++SwtpYTG3LWZBVGGLvp6RICa/cxE0K0mJ+EX?=
 =?us-ascii?Q?IeBM0zZCuqfTz4BBJpSpjEapuDqk/I+egoQlN+WPj/FcW7RA6u4N62JQ6WPp?=
 =?us-ascii?Q?EYQTEJriQwsgvY5sZgYxEAwJi4NHAXv1kVJAF2ZV5ZMZu59kpfQlnY2D6Q7s?=
 =?us-ascii?Q?biV8jS6RkCdKYoeCo8hf2PG2SXxpab9F5f0zwncA6gzn/hzNhKwFVwceYzU0?=
 =?us-ascii?Q?34Yt1WqAI+sOA+rZkFWtAUwj4MSmonq1BrstXYjJs/8Fnu7mkXKTAfT1h4ph?=
 =?us-ascii?Q?91COaZFf9FNAlbDLlDp+PjuQ0lnY0mwAW/ZZUGcz5SLxNRULrbi09UVan7Lr?=
 =?us-ascii?Q?7xFk4OdraOmDuqOOizcbnVXeEsU01xZfdwmMpvgxC6X+lTrGSsFPB1KeTMgQ?=
 =?us-ascii?Q?P5QZnT8Mt/AxvfKWIbTDbY3QuIhemvapmWadz04x9FzjdQIp31TQUGoC2RlA?=
 =?us-ascii?Q?HMDm+d6n4pbOU8pCUtH1NNVsZnjK+ecnbWJr8zGJYmPSzshmvGWeGj1SmRmC?=
 =?us-ascii?Q?76Wfurh4Ue9MbUCOCyOcwO8OsgwBr1RNa7T6QYyWKYty6Rzkn2hyXKQsDMxH?=
 =?us-ascii?Q?iAziDFjMjE7g//JAfy9UHH+01npLrYJSFMoJZflXXi49gEv8E4cFO558qcko?=
 =?us-ascii?Q?Ug+ZnadOcDnr6FoDqo0eDqh4oNkcOzbdNV88cw5RbbICHut15r1qAv7cY6XI?=
 =?us-ascii?Q?E/1fA4UQhIrb3/LmTZPmx35ORDjpbpDC18gqkXznikdbJr/ZWjvq33rdmFus?=
 =?us-ascii?Q?x+DcPgZr6oDXICEzqE5jr6k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5768e00-d721-46a5-4d27-08dd7dfb4c32
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:42.6766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fG15m+/bzNFHcehyYy6T8lyERYxq0snTY6w+aqGXwmuL0cEj4QgJDZTevpBnyDYPvi2tkNtXrw5oNYnsPQ6iNFkMbfCzCdtDZH82xOcwwqliirXnGRusHMfj2j5mdJG1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

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
 drivers/acpi/apei/einj-core.c | 112 ++++++++++++++++++++++++++++++----
 1 file changed, 101 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 2c22615ac72c..66c5eea33095 100644
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
@@ -110,6 +117,7 @@ static char vendor_dev[64];
 
 static struct debugfs_blob_wrapper einjv2_component_arr;
 static void *user_input;
+static int nr_components;
 static u32 available_error_type;
 static u32 available_error_type_v2;
 
@@ -180,6 +188,8 @@ static DEFINE_MUTEX(einj_mutex);
 bool einj_initialized __ro_after_init;
 
 static void __iomem *einj_param;
+static u32 v5param_size;
+static bool is_V2;
 
 static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 {
@@ -304,11 +314,31 @@ static void __iomem *einj_get_parameter_address(void)
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
+				nr_components = (len - offset) /
+						sizeof(v5param.einjv2_struct.component_arr[0]);
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
@@ -500,10 +530,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
@@ -523,8 +553,54 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
+					if (nr_parsed != 2) {
+						kfree(v5param);
+						goto err_out;
+					}
+					if (count >= nr_components) {
+						kfree(v5param);
+						goto err_out;
+					}
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
@@ -548,7 +624,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 				break;
 			}
 		}
-		memcpy_toio(einj_param, v5param, sizeof(*v5param));
+		memcpy_toio(einj_param, v5param, v5param_size);
+		kfree(v5param);
 	} else {
 		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
 		if (rc)
@@ -600,6 +677,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
 	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
 
 	return rc;
+err_out:
+	memset(user_input, 0, COMP_ARR_SIZE);
+	return -EINVAL;
 }
 
 /* Inject the specified hardware error */
@@ -610,10 +690,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
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
@@ -764,7 +849,7 @@ int einj_validate_error_type(u64 type)
 	if (tval & (tval - 1))
 		return -EINVAL;
 	if (!vendor)
-		if (!(type & available_error_type))
+		if (!(type & (available_error_type | available_error_type_v2)))
 			return -EINVAL;
 
 	return 0;
@@ -783,9 +868,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
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
@@ -807,6 +894,9 @@ static int error_inject_set(void *data, u64 val)
 	if (!error_type)
 		return -EINVAL;
 
+	if (is_V2)
+		error_flags |= SETWA_FLAGS_EINJV2;
+
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
 		error_param3, error_param4);
 }
@@ -955,7 +1045,7 @@ static void __exit einj_remove(struct platform_device *pdev)
 
 	if (einj_param) {
 		acpi_size size = (acpi5) ?
-			sizeof(struct set_error_type_with_address) :
+			v5param_size :
 			sizeof(struct einj_parameter);
 
 		acpi_os_unmap_iomem(einj_param, size);
-- 
2.43.0


