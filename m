Return-Path: <linux-acpi+bounces-14312-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE3AD7EC6
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Jun 2025 01:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08C931893F7F
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Jun 2025 23:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC962E0B7E;
	Thu, 12 Jun 2025 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="sQeFecMX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023120.outbound.protection.outlook.com [52.101.44.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9132DECD0;
	Thu, 12 Jun 2025 23:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770028; cv=fail; b=cbAKQcGc0XqcIbXQEnSg+i8DoA3ekDeGFk9YPQ95iX7U8wezgwjCxws1Vdq/J/TvejVwrEm/r+hOHhD4BWWSotUsVWpN9FQpYKRHed7msCMOuCWUqLheLcNUD2q4tH+uayC9jwadq0x8Ck4BHrzuOzQicBvPRAD/vMj8MytzexI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770028; c=relaxed/simple;
	bh=VE4XGtYRsUOe9f60ySOgDCJPtO+rS/KYrzEme4zvNCY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lezW6QvDWTAu7SytoKULAyDDzclSP5xcTaxLZ2B4OA8V+KCfhLwGomYZAaUb0z3SIs2cC0NbufDcwzG/Md/EsV34yi1IK5sYPYiwG2jf9AClIH5g7vRROhgym4fWHCyFl/pwmmbD0zNBKHhleWht7YYekQnKqvOyjgr829Ck3eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=sQeFecMX; arc=fail smtp.client-ip=52.101.44.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X0aO6nRuOeM/WwUt6cl0u6+Dc/CIfpREAf2yPnvmW0sgUSNjkZv9MX12va7j7x7ch7EprXA2MZH6iZgGARQlOc67SVwAOGQvlJfoRM025NBBklBYJcU1z95sStPC0lH5I5cVROMCNw5/Ll09Sd4x83TiLo6yWgdHSYiv/siJyx+py1KfS9MbabxOjCgm/dZXx+Tbbpib+NIR270BUir3/bCMBXvGr+BfyhE3HK/W1XvHQ+CEAfkK/Mspql+tipvFfs5wIVaM4pmo7pNDZer1bhVfEP4B82B8N1vOPX/B76nEe3BxG/2rhdhSdlRoj+0prTOb/wwnOsiDltqeYTTmlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aV42x5o1xI2VHsjrdNiltl0pyAvBvPV48bTRuL7RrM=;
 b=NTCVcMem5pG9jWoFqn31GKPOpl4CuZSCH21Op+odEV8QKvMwt2cVIwi0H39840D/A6MHtH77DAEZ54zhSdqT9E+ybAKsgazl02MEmCcdgWCx3yE73LoBDyhXSanvil+OUjMveT9hOdRO2Bkgr2BWET51ncSZ8udFqW8rypv9OlT5KjTHVZh5zxT/1PxQ87UwWLxxXgT3uCPKRINAWcaVLnWhNmv5eN7C3RnbBAvLXL2/IV0GJ4Y4W0z3VvZ9aih3TQrimwqCuuLj0tWIIhQWM+4+2rlHWkzWMyxj1IEX2B9yVQCiuFoc/AZYwjwEJd0ZnG7x0IO/XMkAdbu/PLf16g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aV42x5o1xI2VHsjrdNiltl0pyAvBvPV48bTRuL7RrM=;
 b=sQeFecMXlQ9PFdoMXWHhFZ8tXhZpW4GdCJphckOsrjC24EYFLMBCsSBEnYX9BzcYPiSO8S3vjdqRl8/HbbOkW0ZEZPwiaHVfuCLtxcd6nqPryXniTXUYmH6YPq07Vd08145ghE2iQq0kBktO6JrFMDPXXwDV86R7907EgLXj27E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS7PR01MB9364.prod.exchangelabs.com (2603:10b6:8:24f::14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.19; Thu, 12 Jun 2025 23:13:44 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%7]) with mapi id 15.20.8835.019; Thu, 12 Jun 2025
 23:13:44 +0000
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
Subject: [PATCH v9 2/7] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Thu, 12 Jun 2025 16:13:22 -0700
Message-ID: <20250612231327.84360-3-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 76614012-4413-4db6-8b3c-08ddaa06c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pPAORS3aOan6smV/SDZJ/07bTHxE9R9Szu4PfHu+YPusyVNSs99AA9VE2Te6?=
 =?us-ascii?Q?oilVyIJ2+K5sTOK1q/QXRhLoVuYNqme1V2AAbqoPk7e8m49Par5133qCvlTg?=
 =?us-ascii?Q?BW7B2IMLkBANTMmyCIu21JXvmpaotXuQ9+CL1GbmspOeeTRh8REP+75qDkuv?=
 =?us-ascii?Q?69eGPUHr7imf10A+2TPzZj5zl24a5P9tB2dzXHGdzm1ugs7u3vRq6j09E/Hh?=
 =?us-ascii?Q?teJk2DEBL2jFNjhQiQimIxEQ+cRlOYQKtLqIpLzAY2K7AP4e15RO82hMcEvf?=
 =?us-ascii?Q?NBIq3+1rB+NeoW6bvw4rHKDUJr+5K8t2MoSohHgdiiUBrTKIuUNZ2aOskOGC?=
 =?us-ascii?Q?MHPYrLANuVzg17TwNwfIcZfXz+5cD5xu++RJE6FhHRf9FVIvRVwta3BrntQQ?=
 =?us-ascii?Q?yyaV65E2rth2lIzaL5Ixtvl8unutvjGvpsHgruK1gVc4l30v2LAAHHFYjUXK?=
 =?us-ascii?Q?Vimyb7Xbc/bYb96BoSWnFDwraK5fj/kO8O/j+aGYHpMVnLnMx7a1bRzBh+Ju?=
 =?us-ascii?Q?QYjz4crEjUeYkiAQpCzx9JvndTZe/M4rHwFmPNSgd4jYpLCBJfzChqZHEpzY?=
 =?us-ascii?Q?uLvzPpPCWPkc3ZBwvmJgwO+rln4JIXC2TDzjZBTIvrR8Ky0iQjOvYboXGXiM?=
 =?us-ascii?Q?0arvlj9sRQkRIZOQYXQanN+Muue54Zc1Ou8wTwTmyuroFJPbVIk3egLyO206?=
 =?us-ascii?Q?hGkmXfSdoVoIYBCsEIyCutdUVZibufHLxmxzMGvIA9rEj8Ncwls2wKDn41Xe?=
 =?us-ascii?Q?wkbYvx+q/Ba2HOCDE6m+VrXuiQllA0sqV++g4txX1U+rIclpgKcT97aoK8vL?=
 =?us-ascii?Q?iJCImKfti/uJEaah9WnYbdjwuf3Bbtl/S0RKRFoC5y+fw5hvXcyAbIcColaA?=
 =?us-ascii?Q?zoepMZlSgl2DWZWi6MRmOU0bS2ND3xfFtgQaiDmpEMjqLPkCG675SMvFHHLf?=
 =?us-ascii?Q?QSnF6mOPEsSa3KMvHgM/6ie9vGhp3OGdbJ8dVIgfyzSaC7JeUz+o5TUSvWbB?=
 =?us-ascii?Q?dCZ/TCKMVVCXpRBMi0oXQvp/XLCTokRAHEofpt9KsJo4YBuW6dobaZ1uswzI?=
 =?us-ascii?Q?Z6ZJhixgtEpGtTHv35Nw0tGmGEExgYXjty7KVy7Ybf6I6Z5Hm6xv35rmf29n?=
 =?us-ascii?Q?flSagQFgH3qeonV3eIZcwx2S7pwVqBmrnJj65q5oYZXJnmi1enIDuRK1tHVU?=
 =?us-ascii?Q?cM+t3llIdeY3sqRG66T4XKf4DMtzoYCg7FlDJAPk4GhDl7aWhGNe6CXw9S80?=
 =?us-ascii?Q?0FaKbCrs0RNGsP6DYusNH68eDA9HG6xefiyuvbUW/b7PCV6BxmzLVUJB9JSt?=
 =?us-ascii?Q?1nyRRaF0ZU7FG7E7AQMqOyftj+4Un68bhi0NpA1iJJYmZH6kJAAffvRL7IMD?=
 =?us-ascii?Q?KDULd3GyLb8j/Ll48wdodCBWj8t1KkBueSaPYIFNvSre38GjdI9GskMal0L7?=
 =?us-ascii?Q?ZJTl+x+SQRbJ8b+UfCCOP8/2vlybLGGR+aGR1irsMRsE1rt0Jgu+a9Z710Cx?=
 =?us-ascii?Q?M6Nd+SOkFYGaiHU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0E1HdhdN5vo57kF/EXXrRXYPRd8VkHm/wGCeXVbaGQvuFZo8vI2x+UyEYyOP?=
 =?us-ascii?Q?IRpVNGwu5QFJo8+2db2OCIT5Sjrmv6ylaOs49/YWhCrJsdNZ76BnlrBy/La+?=
 =?us-ascii?Q?zF+pLIjq6+4FDGiacZAL6lVN5INSF3ZpEfQ1P7+P0Tyq/25iSDiZ5YY72tS4?=
 =?us-ascii?Q?BG48B4m3urF5BwMCIpWIOdpTm9VRRuCgSQxNVGSRc4vokxhdipaQxoVz+v/e?=
 =?us-ascii?Q?ked/nhsBD3RHXyfHXIHXM7g9HcUvAOgHXCglz4YnyXjaB7nfiFRkzEj3aprb?=
 =?us-ascii?Q?SlZ/K6w31pxE+nRR5JLCxor6vpoTkRK1FIHOWan1NqZkG1Rx5gI+s56E5v1c?=
 =?us-ascii?Q?uLH63uWi1lZCv4f07FRYUUMdF3WKsU8J+CyONlTZy5FUEVF+nJdEHrJWt4lt?=
 =?us-ascii?Q?KMQpInVVsSgAq9raXbqWu7AluZTO8er5VWA659LlHGpIvDfgI+FuBuf7GB6c?=
 =?us-ascii?Q?D8JpX5p6F0u91JMyY18xAlqSRJ3K0mItFaugqiQb5o+H8A7Yf79WuF2VvK4/?=
 =?us-ascii?Q?yjF3UC4i6s8i51+E9z1towApm71zNx9HTgiPzjqoCiRRZC352tEwi11zJ6PK?=
 =?us-ascii?Q?Qt6jx5LDUHtFkAaJ7aINLyMSLr00HogqVyj6VWmYJNUn15kuCf+GYdhJ5m5d?=
 =?us-ascii?Q?8GXnjIq43ROHMNxjEls0OPGmtl02K6hWgcxkq4d/iUBSCaK17XO4cFuMSWLA?=
 =?us-ascii?Q?4pPRfkxMqUgodT/M8zaNFUtUQ8SfOKxpkSNeP5WaFp+XEzTmvyzGZ1ujRtlL?=
 =?us-ascii?Q?3g3D//LRDOWIH1A3Po618RA6nT0gkhR1sRrOwzOplsyW511RnKoB5vpQSWmt?=
 =?us-ascii?Q?f9F2RP8y6c0bNseqXl4KLACQD0dbSfpdni66cpAnDjWFWjF1N3KU4eUkzmtL?=
 =?us-ascii?Q?Pirj1E1zLDXrksTOX8ZhyIRqaKkOZRdHqtidFMs4GJ4uCN6vYZtis4KMlEvL?=
 =?us-ascii?Q?akm/unwlvLrbvsRI0+Qe3fM5F9WJLStySWy02cDmlD1OC3xcplog/nX5S0I1?=
 =?us-ascii?Q?kbcuYYV/ewaJZkhfvn3leYCO99Km9+fDx6ATpL/YEeJ3VTqbf1ThUzB+ZXpy?=
 =?us-ascii?Q?tsbU/YMhubQfzlni8BD/0aNInCrHA/wvctwgMWC5iTcN56p5BEKVkD9x6Otq?=
 =?us-ascii?Q?m/pls3A0vRSOerg7OIlA+d9Y6iiIm9vWTxE+zzztOsBBnE+ml7TIyJk096pA?=
 =?us-ascii?Q?itIT4xaM/aYnJdk1By/P2V8yr65ZbDCQTObRm3DSFAnm0MZnYeiITVWFym69?=
 =?us-ascii?Q?H39mqO5+rP+yXuUv7hZeUdtk50obUfK9EP4yL1WgfXFSrz0A0Z8xksgRFq4l?=
 =?us-ascii?Q?2q2a3G6BOBcbWKOcqj0q6jzeU6DH322GzjZGDd96qtrwLAbmmFr1Ngd2FH3l?=
 =?us-ascii?Q?WJLvMXXwfTwbZa/qQb+Exp1NfxJZMT52US3ZtmQHpzM9uyuxZ2b2/Xgxv09D?=
 =?us-ascii?Q?yuOxDafm+u1Ir5ZMv2AwB9u3p8sQaftavNp0sxe3XyOD1y8MlQL70z0aOmgS?=
 =?us-ascii?Q?3+jqg3W5DWAJFMTtKg/fCbMtfZ4mYAG2cdh+FqODIoMKMWQZJz4bdXgb55FH?=
 =?us-ascii?Q?KsKvjcH91eI021ThH5usWM84YP9pVUInX2W2yOEJjswAjNBgwADuo9/p78gL?=
 =?us-ascii?Q?SYFtJ0I7WvWc7lHSX1EGoBE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76614012-4413-4db6-8b3c-08ddaa06c726
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 23:13:44.6111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dBRW6FqRN44TWW1o86+E5HzWzCou+DJq4wOF69t+v4V6FV0J23GFMsDXnRX1tDotqeR7OB7Tmg683EnH2zu5+Rqhm2FUsq7JIoz0+TVMmRyRGpbWLdcgINNSo7CuMPF3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB9364

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 75 +++++++++++++++++++++++++------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
index cd2766c69d78..77c10a7a7a9f 100644
--- a/drivers/acpi/apei/apei-internal.h
+++ b/drivers/acpi/apei/apei-internal.h
@@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
 
 int apei_osc_setup(void);
 
-int einj_get_available_error_type(u32 *type);
+int einj_get_available_error_type(u32 *type, int einj_action);
 int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
 		      u64 param4);
 int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index b9cdd3e44855..f018d3970de8 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -33,6 +33,7 @@
 #define SLEEP_UNIT_MAX		5000			/* 5ms */
 /* Firmware should respond within 1 seconds */
 #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
+#define ACPI65_EINJV2_SUPP	BIT(30)
 #define ACPI5_VENDOR_BIT	BIT(31)
 #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
 				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
@@ -84,6 +85,7 @@ static struct debugfs_blob_wrapper vendor_errors;
 static char vendor_dev[64];
 
 static u32 available_error_type;
+static u32 available_error_type_v2;
 
 /*
  * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
@@ -159,13 +161,13 @@ static void einj_exec_ctx_init(struct apei_exec_context *ctx)
 			   EINJ_TAB_ENTRY(einj_tab), einj_tab->entries);
 }
 
-static int __einj_get_available_error_type(u32 *type)
+static int __einj_get_available_error_type(u32 *type, int einj_action)
 {
 	struct apei_exec_context ctx;
 	int rc;
 
 	einj_exec_ctx_init(&ctx);
-	rc = apei_exec_run(&ctx, ACPI_EINJ_GET_ERROR_TYPE);
+	rc = apei_exec_run(&ctx, einj_action);
 	if (rc)
 		return rc;
 	*type = apei_exec_ctx_get_output(&ctx);
@@ -174,17 +176,34 @@ static int __einj_get_available_error_type(u32 *type)
 }
 
 /* Get error injection capabilities of the platform */
-int einj_get_available_error_type(u32 *type)
+int einj_get_available_error_type(u32 *type, int einj_action)
 {
 	int rc;
 
 	mutex_lock(&einj_mutex);
-	rc = __einj_get_available_error_type(type);
+	rc = __einj_get_available_error_type(type, einj_action);
 	mutex_unlock(&einj_mutex);
 
 	return rc;
 }
 
+static int einj_get_available_error_types(u32 *type1, u32 *type2)
+{
+	int rc;
+
+	rc = einj_get_available_error_type(type1, ACPI_EINJ_GET_ERROR_TYPE);
+	if (rc)
+		return rc;
+	if (*type1 & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(type2,
+						   ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 static int einj_timedout(u64 *t)
 {
 	if ((s64)*t < SLEEP_UNIT_MIN) {
@@ -646,6 +665,7 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static char einj_buf[32];
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -662,6 +682,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(31), "Vendor Defined Error Types" },
 };
 
+static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
+	{ BIT(0), "EINJV2 Processor Error" },
+	{ BIT(1), "EINJV2 Memory Error" },
+	{ BIT(2), "EINJV2 PCI Express Error" },
+};
+
 static int available_error_type_show(struct seq_file *m, void *v)
 {
 
@@ -669,17 +695,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					   einjv2_error_type_string[pos].str);
+		}
+	}
 	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(available_error_type);
 
-static int error_type_get(void *data, u64 *val)
+static ssize_t error_type_get(struct file *file, char __user *buf,
+				size_t count, loff_t *ppos)
 {
-	*val = error_type;
-
-	return 0;
+	return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen(einj_buf));
 }
 
 bool einj_is_cxl_error_type(u64 type)
@@ -712,9 +743,23 @@ int einj_validate_error_type(u64 type)
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+static ssize_t error_type_set(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	int rc;
+	u64 val;
+
+	memset(einj_buf, 0, sizeof(einj_buf));
+	if (copy_from_user(einj_buf, buf, count))
+		return -EFAULT;
+
+	if (strncmp(einj_buf, "V2_", 3) == 0) {
+		if (!sscanf(einj_buf, "V2_%llx", &val))
+			return -EINVAL;
+	} else {
+		if (!sscanf(einj_buf, "%llx", &val))
+			return -EINVAL;
+	}
 
 	rc = einj_validate_error_type(val);
 	if (rc)
@@ -722,11 +767,13 @@ static int error_type_set(void *data, u64 val)
 
 	error_type = val;
 
-	return 0;
+	return count;
 }
 
-DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set,
-			 "0x%llx\n");
+static const struct file_operations error_type_fops = {
+	.read		= error_type_get,
+	.write		= error_type_set,
+};
 
 static int error_inject_set(void *data, u64 val)
 {
@@ -778,7 +825,7 @@ static int __init einj_probe(struct faux_device *fdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_types(&available_error_type, &available_error_type_v2);
 	if (rc)
 		goto err_put_table;
 
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index 78da9ae543a2..e70a416ec925 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -30,7 +30,7 @@ int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
 	int cxl_err, rc;
 	u32 available_error_type = 0;
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
 
-- 
2.43.0


