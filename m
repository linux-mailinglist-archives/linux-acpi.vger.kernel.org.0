Return-Path: <linux-acpi+bounces-13104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D80A92D0D
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 863239247BF
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF6822068F;
	Thu, 17 Apr 2025 22:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="RoLJ3XWw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023122.outbound.protection.outlook.com [40.107.201.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB0321CFEA;
	Thu, 17 Apr 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927246; cv=fail; b=WlOOQd3LTa/S8SqFeJiz3cLXhzzO1jfPuNZ6j/j2GGYf2nC4IE16Yot/IGPGgqfYmH9TNd/A0OQTUp7K0UGYRpf2rKaIisw7ssHCKrZ+0vw45e91FQ8qTIV53mm37Y73GvybULdPKJjMTUkNEWKs1V4H3bEeNio60FRfyn1UOnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927246; c=relaxed/simple;
	bh=lY+RHFhlgBCOVWT4R/5hi/RN1INSM5BGBuzlNK0Qx1c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGkjLqesTTg20fOmxySjJ4hFRtbfXYgUJhT4pr7F32AqxLjX7uII5qkMgpzBL8aQuccVg0lEvAMrthUzVkI/GUXBo8GhI4CcngPKGIuB12RIkys0pfezREm9MnF3MfLUCc707tUz/QGf65OFf5Qxgl6Yi3rURTOun+BumxTpomc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=RoLJ3XWw; arc=fail smtp.client-ip=40.107.201.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NV6SsH0/SRFaxySVSdRuvkNXTDDy5oRmNa4Er54YZDA7xoMYi3Pst9U4XZjdvDTjq+qHMNN2+JWbURPo/Fq8fo+soQKAAhte4Yfx36BFu7Nyc49fSacjJBX1Y2xeWTo9VXWiOMukKkwayIe4qMbJ6JUq58qAOkMP3szKwvFMqaD6QqyYbM/LcvzrJri5C1gTuZC+W3nJUV+UEHU5+g8/qGYq92dXA0xC3ZtNqi7q6Jef309zgIRstoxBU4Syefcs4ZKLnwVr4+1ZRcam1ibJNnCQjdvftojAodXmsTl2xdMNZmSJ2sLTfi10Ozbmpbm9syonm68kBaR323M/DFz6kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BquAVzk5n+UIKpX4MWOPjCBYEX9yuzjuEmrEWYq9jzA=;
 b=gZZraDVHh2SqJxvcanmPkt2zVZ67MI3Su2LlxLyyYtMbwyy1o2flNSJmozqBBR1460Kdaqxg2e+kgWc+NU22z1purBZwFibxYZM+8yIMMrD6Vemyo4ktiROP8vlnCEUso+Adhdxwsh82WvhHvXg0IDUR6nrIYlFkIYY5EwBhfG4zuRWS+J3XkfAp3F9mAYq9Q8rQ5/tnD1NHKkhB3ikZrrKP85Hus44nvXOjv3CG7ea/YIwvEVtFbnyfNzPOqUJaeI4T+KZ/ImovYMEB12V7Ug3dJe97XknjLABPIehMYqZ3jFmSpgA9KMl7uzF9Fc8M0RTy+GyI6z78NsZlLagDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BquAVzk5n+UIKpX4MWOPjCBYEX9yuzjuEmrEWYq9jzA=;
 b=RoLJ3XWwXYU39ppQOiZJYcUdtFO8ATLvyMDl1fJhwF6C9PQ/04MUv/VwNIAQG8QQRQ3eQYbb+kmuvMj9yGKzjGGFSRvzSIVLQ/9rS86cPeOyWM37RWSIKXkTFlQtK84ovE0YUsMlBH1ecRbWWaTn1KS2sQFmgk0r/Ek0KcqbZCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 SA1PR01MB7327.prod.exchangelabs.com (2603:10b6:806:1f6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.21; Thu, 17 Apr 2025 22:00:38 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:38 +0000
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
Subject: [PATCH v6 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Thu, 17 Apr 2025 15:00:15 -0700
Message-ID: <20250417220019.27898-6-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2eabac2f-9f24-49c4-0335-08dd7dfb499d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JoiMOEpC/EGWpK0YV306J1YHjvql2ja9loyrDzKYUW3EL2UCwwQ6HNT+7c2B?=
 =?us-ascii?Q?XZAYWAXZxBGRFXrAvK9FPp66RZiG96Km3lWO/KGgIlsul6IV8CI9e0V2oyek?=
 =?us-ascii?Q?rweQ3naxUbytQI0b0Qlcd1/OlYFpEU2luhJ4Wml6Rd0siWorjm5V/Pd8xmF/?=
 =?us-ascii?Q?lazFFfJKlEYT3DWMsKVIS+gHITnmcIQaDwk9/BhBBBeZVwOhTzSuIugXNBPZ?=
 =?us-ascii?Q?Vk+pclrVAvILWLYUGtKSpzA3nJxSSYH0gGNJ03kP1fuRnPNStaDfqv7FQe5U?=
 =?us-ascii?Q?Adj6+q/pjz/D8FUXMCjCPmuRGhlaHZ9WjU0NWAlIoBHw/pOhSKUHcU1A4bDI?=
 =?us-ascii?Q?srSeItEvL4uEJ2lNHStjCb9JBHnLLDQpI2W0yv1c4dykuEICWDsrO1KW1rau?=
 =?us-ascii?Q?6v4zbxe6ATEubRFKLm95aP6Pelp/t0RdSS7GOvJrF11D/TuM0BKhYJiVOg8X?=
 =?us-ascii?Q?W2QDsUxCtNyRDB+w/93giv1sjGWNhNry3iNsPmiHI9AVAemJU4HjXy2GEx/f?=
 =?us-ascii?Q?fMffok8Gc6frE4g4hYZfqY/ivNz0gyowrBZPht94j/q/VXguSywubsKRrhqV?=
 =?us-ascii?Q?mfyXbz3RmBSXK7KqXLPeNAc8EECycevUrRoEyrnFTtxTHXwrnu7mtPHCNUx1?=
 =?us-ascii?Q?/jRLOkaCg9DPPrmCrmMbAtaIWjQ52IXIVlmGRZNzFXIIdtEVYG8vIjrUQM77?=
 =?us-ascii?Q?pTdarVyRClNamq23zOYAaSd7fezbrE12ytEo1qI+rHNVre3y6GjWShGI6R6z?=
 =?us-ascii?Q?9iB9Jjdbc38ZuoR1OZYYaOIsLKkDvPfh91DyUZZWtlm0o5KdEWauDqr0+HcY?=
 =?us-ascii?Q?mV4vS12uLxdEK1/1uH6+OlrvKFpR6Y9CsNy9gGrur9K5m6paSTA3MrHJ7RW1?=
 =?us-ascii?Q?6ibkwRjWIOkeGbQBUQqs2fhJ3PKF0KQUaaWAJf4YzC/hTEYtwe9Wq3oGatb3?=
 =?us-ascii?Q?S6wzCJyybbd53IidgTj0Vix4CR7mrfaOnRdfvO8iOH7zLIV1f/Jn8oZwIJtu?=
 =?us-ascii?Q?sDaBjQLRDDZsTLkOCD6+jbSwbUFlDAe+8YsoRGkIBkaUy8GytrrjjbkPueUP?=
 =?us-ascii?Q?6p4E6YsvA6QMqPZmKstr45DWNIrYuV4VHAUsYXCQpDQM/o8OglsFTkDuF88a?=
 =?us-ascii?Q?xYvxnngQuQuv2a0zpE+ciIT0UbgsJeqmstwxDg6uhReIm9DUZroq4ERsgzdC?=
 =?us-ascii?Q?v44iwBuH6FzaRD975l0me01e+qZQyIBBaKFcVH6dIVaTRVV/p9JURtypdvve?=
 =?us-ascii?Q?QjOcslRk6hdc+gVylJG55VGzfaqixwc/VhwSbhhJyiN8MBxn9YPzV+4tocRr?=
 =?us-ascii?Q?VfVhX7gImQnsNI2HQiPr/vqTvFCERAbTTpAhkBzO0oHpPaV4A9hQTDUmJOMW?=
 =?us-ascii?Q?dallRWKU89nnIrC4JrZlHlCZ+10jfP4Y+hynigBD5+b/hGhqiQnpH4tQF85T?=
 =?us-ascii?Q?XkZ4c+IvthH2yC7rn47izbMBk4fDvI/lYey5TuDqBVb1Gv5XKLudMI9v/4ez?=
 =?us-ascii?Q?VW4Z0xN69quhg+s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0770pJ3U/bcP3mgkiQ89Z4VxxAhRg95hllRoHMcAgSagFxygGuNnlbQA/93S?=
 =?us-ascii?Q?RG+hKKG2Q+XJyghfb/ezk21R8Xmz6cxg0TDA9O5zvZ1qEEDYBlvu1j0fzGyr?=
 =?us-ascii?Q?4EY3wYpcGxGuRX6z5Tc1SqX/vT83g1VHdtjsBMw54MYWu5SLJLqb2BNzJCcm?=
 =?us-ascii?Q?AE+8JWFagg8c+orfvBXkSwyAdgFvxWJBqOWtuycI1B8jw1QrvFJzs/wGUlJA?=
 =?us-ascii?Q?X4YPDrThyiUvbYNidT9/eOC1u0rPOHNzxF2vez1SZ11kmkqCvktDSW8K36Qn?=
 =?us-ascii?Q?E+PIP3QmByrhOyEAUAsnBaLvcFHut1cWVuP7T6gNRyuBZX2or8YAZbqd0hef?=
 =?us-ascii?Q?gftDWGPHyuLyy1Ut8GnbWmdbKAf8iCN1iK7nwsY266Ms1BuT3R0qLFWf09bL?=
 =?us-ascii?Q?wpD1kyZzicgcdHudh6EEILu4CAWyHZPUp0wNiVr0eN4KxxIPWxc393MedUQ6?=
 =?us-ascii?Q?mH727z3gH75UURSYbFv+ulaeaFbNg0Y5qMLg+HopMBBxMhAF2kS2U4Epl0d7?=
 =?us-ascii?Q?UpNebYFaa8J1T/tL/7H8M9sGW/8gO5Yb4GgQBLFQHvAxdM4D/Flq4Iq5og7O?=
 =?us-ascii?Q?MxZXf99v/QHHMepBiXzS9ncLD7zWGBw91AkwCtmzW2UcDmghxqqLUZzeUsrG?=
 =?us-ascii?Q?biP+RFVPneo25senkZxD6mTY86+JH6AWOedNQpWfxsKbAFkDYIGIrFANwwUb?=
 =?us-ascii?Q?EtaBsEY/P82KiZD0JCqdcCylMppkzz9dnaSOOn1eF3r/6/U+K2U4I4rtNzKr?=
 =?us-ascii?Q?DnDa3Nc9dUdQRXiCrMNc09iFa1r6fe3uA5vSeQmXng2sUD3yluEJMrXKC5aG?=
 =?us-ascii?Q?XAtBudOnOKdGm2iKHUx4iNPG/uYXraX0VjFC89u3rDoIMuvEZxgWAXNXJXjj?=
 =?us-ascii?Q?WbeyOL2Lqld/yOPRcsZYJxj7exyYZ914EB3tH1MI5jhiHZf1aK07fYfZA60b?=
 =?us-ascii?Q?l96Q0pDmSc5mnuoqt3AyV4PETPqvGrXXgF9EKWycx5jlB7FEVzKV/NC/ZWML?=
 =?us-ascii?Q?L06kkFLQXN/yOJ6DvJobskcbCXQG3mF9dYuLC6PWqEbJABTc6pmBB9FLXfj+?=
 =?us-ascii?Q?5RUVGMnuT4jpgqmFLgAvSnX3UNq4L6a8aggGIkW0kTTRHEMxfM53jpCVx3Q/?=
 =?us-ascii?Q?dnlFzpR0rjHpfVhOebo6YVQiRFqMwqwSoTy4hG+58BTB6wdXz55rJMQVp/gd?=
 =?us-ascii?Q?JYtB8+SR/5soHtSoNhHTnu9KJA+jZD+K7onWcOA0+doCtw41vgsiNCLg8uVX?=
 =?us-ascii?Q?EZmDUvFH7HXtj7+HZQe9lSH4YKTtrt0VjcrE89f+2Wsvx1+/HHgSHsQSxWXE?=
 =?us-ascii?Q?U1uFYDkfjUhDdR8p3Zz3Z+mrC3R/T8gFVjsOZQudiQg73QwcVovEsPCQrNBR?=
 =?us-ascii?Q?a+r8kvHJxbwxwtiHvtIhs87wAmZXWKw1ydwAWYqxdpZvo1k+Dy7wlUMoOZKe?=
 =?us-ascii?Q?LMZAd1I8xHVRu4KpDkzahWgcUQCkFYO83UJFs0AVmbcVys709HuhHDJRVpRz?=
 =?us-ascii?Q?r/X4amspVwUwCL9XoT7M29hS/FTbG+7c1/dfPORKem2bz4YgQAOs8SGJ8oJd?=
 =?us-ascii?Q?0DsiIUbxqX/F97c0FB77/6zkqRl5e6O03MUF8hsomjUkoGD6sVFAtMUXTmAm?=
 =?us-ascii?Q?LpURg2KtvpeWW4TfNTVJkOQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eabac2f-9f24-49c4-0335-08dd7dfb499d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:38.2888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHce/GmWmX+Q9nqtl41fOW69jLlCsKINQXylXkPJ80+oE6yiTLpA1YXmhnXLkWTK4vgPv4YIlB1pruKAFrGyd5eGvXmGY/91YyyMUdHHg6qNJQHIvTykffJjEl9/w2XB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7327

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index ada1d7026af5..ee26df0398fc 100644
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
@@ -783,7 +830,7 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_types(&available_error_type, &available_error_type_v2);
 	if (rc)
 		return rc;
 
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


