Return-Path: <linux-acpi+bounces-12712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22389A7B241
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 01:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E02D176FF8
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F821DED46;
	Thu,  3 Apr 2025 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="WwCz1Ihb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11022135.outbound.protection.outlook.com [40.107.200.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82491DC185;
	Thu,  3 Apr 2025 23:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722039; cv=fail; b=FRpeCuxCyRmLdGyeJId8kVKTYU88bjQx8+il4/7wNLW1kN1C0dJqUh7KX5QlPKNOlx+Ws9eji5DfiygXICKscp3Z6ceFoZfxZhsrmMczgJQCvN2kanZx9xj+nXS92McyLdHrpgsXx/lfsIaqul/r+OJCo5mKRhVvT/7qmKD6Bac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722039; c=relaxed/simple;
	bh=lj5had70qO6Ow0GYZz+ibBwyDVYDGwrlNM7RApgHdpQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X8Pg9W89ZNLMjWmEuGMhVmEW+Mfx750ONK4ixLo/UHqFhHT96uAwA2DVDWpHzDJf2mRiPhg8Yk39maEU2GXGcF4D59D09Pf5LzmXsRQw7b3QyBNKH5G7v+qC3782yrMXhrUEGEmaF2gtEB1VCBGyQikZBsNHLGgt5NI8F34jg6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=WwCz1Ihb; arc=fail smtp.client-ip=40.107.200.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AdJGTTpRt8uh6T+5L25r13jXxwlbUYU5E4xj55FCQg1Kfs5rgqdPqQuUhwHfmnAepC3N3zq8ZKKOWTzw9XxpWfuSRBehN3AS4sIUDJzL4lkxGBIln+0jGhcaoxdqQjgvSvi0SwueLD3RYQ8y7NXLSVnwXwy7NkkBWiUJDQE3Ab+fhxj8FE5AWLwwf+9q0PM9gIoxj64ONuhzA4LI3ZJeFDmPN1puEQtmGHgCYgpnRBzm3VtK0efDk+XcCn1WfWUYYab2/nM+bMmQcz1NAtyN9bRS5qwDvzrR59M3O/zDyYkUBCnglVDzR9BwTQ1ubM9QKFHv6WpVu1xe6gz1HfVqWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC2Bv+57hkDsxTdhS+EBRhw0I5redOX0svtmAypV+Tg=;
 b=rmMX7061wHYbP4sAgHACLM5eUzz6vLimLpM28B4x+FDoDTMX7I8v33ap2hQH/UMRNC84JASDhycl11oAAiXC/fng+hv8zwykHSFDAnhJzxbEFUs/Xbg37wh0AnNjhScOx2TGtngZ+0akHdktgxVpODMoDwlB1k272pbS/x8NyEhuWezNPQcymT/oR7iLKqhMUK7fGpyW8dCGm/kzeqNxFZGTLCDz7Dyubjf6aqBHE6ZZDSLgHwpLh1gTyQAvdczIDGl6PAXaq0np/NXJz7uWfpJmoch86SjlV65K2bEo7FFbeuwLle0WQZH2taP69LOVdYbaNZ2GAmC1Z+FNxZoRgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC2Bv+57hkDsxTdhS+EBRhw0I5redOX0svtmAypV+Tg=;
 b=WwCz1IhbT70A0OqtI7TAkI+mKLB1FHNUOj5xxi7/lXgj+LfWYy3kjE/QTH8+/ZOm22GcxRRs1SzTWz1PMoNWEOqmyyOgrjbPZ1d0W8LEXIqJq8nFndgnSv0U1RGsbPOh1/Of8JIFzaGbyrFFPdPMDRCjabgGDoDZ2ALVAejC5ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB6925.prod.exchangelabs.com (2603:10b6:408:168::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 23:13:54 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 23:13:54 +0000
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
Subject: [PATCH v5 2/9] ACPICA: Add EINJv2 get error type action
Date: Thu,  3 Apr 2025 16:13:32 -0700
Message-ID: <20250403231339.23708-3-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4df1278f-40da-4ba4-3be9-08dd730533f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgZY6GZObddAaeH7FpeXc/si9nNsJdEupU1LVBT70p+vz1FPz11+5gTxf3b0?=
 =?us-ascii?Q?8q8OUVFCR7n/d1GMjlytGia7yv3R/71Wy9UzYFU53LA4KoO/MkgaTpoXJvQy?=
 =?us-ascii?Q?FP6i4RLLjJq8dAnh4nvycbt6NLMcFigX0awZLsepJCX5Zq0ec8ky3DjrvWPT?=
 =?us-ascii?Q?hoWXb7eX2DBtW9qKY9x0crYYlaJampR5vTZNeM3eIn2TJ6CntKTCfe8tgXng?=
 =?us-ascii?Q?/ebjthFheM4LnT/HVhY51NzSMDMPZXVidfJE1uIcepgVlZ6e42etnaZ81hmx?=
 =?us-ascii?Q?4YQkaNUF9x1RuQRws9e4iqNVGjq/M6csg+zUmv6I+BOB0c6sEsWHru78vWMg?=
 =?us-ascii?Q?3lUaeXN998Ty8ze/rhrgKhaGsfyG0TY3Y3kdNEewJbdJru9fHr4RmFYcS5Ad?=
 =?us-ascii?Q?KQw3uAvn8nK4/pcURZeGDBgSk72boqlX+m3h7zrGQ3c2ENRTMseiMW44iu9Z?=
 =?us-ascii?Q?SnhegoDpoQFH4+21Jy9hlOZ1ssLc8WnBogEHnrl6vMTgKesmEjxOxZbjskod?=
 =?us-ascii?Q?wMUSHKoehnNIoCA7PgXSD6y/8RIjAmoytAvf/8Cf+8KAZUY1LJuy2IN80SCk?=
 =?us-ascii?Q?3Ev5x//eInjru6Xcu9VB/y+Q6AmWdLvjYkzjaJWW2B3w+mLcQGxKRD3TxUsK?=
 =?us-ascii?Q?Xlh1fEt/qU4VBoxPfAT7hr94Vyi6tM//hecw5mPibQxBfOKZsAYk8XwyGU9h?=
 =?us-ascii?Q?QWIyapwBxXsv41UYpu2C+9muZZ78R5D5CGSCaZTQC13E7R+gzK3FZL4gNYFl?=
 =?us-ascii?Q?WwGqIzNJ4qS7IPpKqTNT95kg+JbmGkYp8eMGc3aMTEFpZtBwDw9APQylm0Ks?=
 =?us-ascii?Q?nEDlsGas7MUvFkt8N2XX1jri6eiZBAWDAA+I7FqabSdBVS+QieNkV9P2CIbR?=
 =?us-ascii?Q?PF9zI6n6g6kXOE9a6mZ8PNjCQuWNy10tfax74GJEoVTSrZjdFKIAf6hjwSDv?=
 =?us-ascii?Q?dr+Gp9kXf5+bn+4/NrfzgP7paSUY38RIjkHF3MMbYkxdMDlHK2X3NuGxaKL2?=
 =?us-ascii?Q?YtGubZwg0sqyNO0VIHeko8wBQW/M6R5W6NkRHG2Dos5a3SGU/rjCQglc/gFZ?=
 =?us-ascii?Q?8BjFz7tC7JVdATQeG+qXQHEQtDCWmyFFEFMWSLCY+2oUu1utyBAPp2MLj9T0?=
 =?us-ascii?Q?NzbjSRkgtDdnBubweklY1ZeuUcoeiaUkKsqSsi5GA5+m9e3sRmGLUWlZEYbr?=
 =?us-ascii?Q?9zkAvn5gWvqihX2EBY0Ue1zRx8zQEakDEjSKq1+4C5LEiWCjOnwSqBVaOIOq?=
 =?us-ascii?Q?IiTvhb3WLYtnGsenDnCpWrkfIRHPlIPMdT7Nuao4nxqAwDqC1PnMhgdwRtf3?=
 =?us-ascii?Q?SNmSkGVy1f56XZbHQq7NcoqoP9ubifd5C+4n4hAYh9nSqhtt4iX7GSN7cxqD?=
 =?us-ascii?Q?VEVhT6lQnNc07Aj0FGkI+4S5C2xK6m4dMA8WloeIPRm98d5X8dJwzvWqJ/JR?=
 =?us-ascii?Q?V24F+FHpcLstp4II3uloSpIxPucca9i+pl0s7c9RvPsFDBmTAmOeLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osE9XjauIf3IvvOmuESlsy+frUY+Lo4qufuKdJz3+R6Cpp16t2iV4xskm/GU?=
 =?us-ascii?Q?xM2iQ2fBcqwO1qGTU0709aZUeWcqLbpWQNtxLcOQsMYMxVrzMgJm1PGlqjTV?=
 =?us-ascii?Q?a/IQ4OUo1Hd8D3LftbXllP4d5wJ5+wl6VxhggDxd9H31UVOzPdAUXtJr+Wax?=
 =?us-ascii?Q?Je2Qs6rb87Jpx1OEJ+h+caiWlDDgxenAFP9uwB8aBgIGxgOU/pjVy7Cclafs?=
 =?us-ascii?Q?q4qFC92AUYhV0ZFB7HUptwGAEegFu4s0HsxGRzPdnPvXOEpn+ED8g7KFOafw?=
 =?us-ascii?Q?QAzoHNW4SDXxszYcYXqWz/wPcUuMpdVGNZQUuGbnNmIPuCo9v4CGL7ZgYPcL?=
 =?us-ascii?Q?gmR6p+MEBrgKwGez7VwlWfkTBKH7fQGJkYpBwSc+Yl4kt3iUiDjHubcEpioz?=
 =?us-ascii?Q?l4hjwGHI8ExcxFMJ4fCLyeY8FjC6yjyxjRH1x8VaA4mCeahbTuCaq9+rU2vv?=
 =?us-ascii?Q?XicxYLcQP4T/sl/5IkM3SFgsQnM6C3Pa0hkQxKuAH95YK3lkjuXVmQ1Bm2gr?=
 =?us-ascii?Q?t6f6BcuAunaBRfJ/m2InqBc26eoSZKnB8pbHNcAPVxI5Zwhmd2IE0W9hzrQr?=
 =?us-ascii?Q?VpLvdsnxdnkW6KKfkCgdssj3RrpEumvEVsuMEy9692Jw9Pu/zeYy7/agamRe?=
 =?us-ascii?Q?K7Om10m0mmLCXYqe1V4XLBE+ZzxCEl+sdW/7RmQ+dLp7PZnDfAkutAfsxnn2?=
 =?us-ascii?Q?ZQWhCDtQWLGKtGi903dKwu0ikbtunC9n3Msj2sRbxfahmrE8C2nzL1vSdDAS?=
 =?us-ascii?Q?8hWwP1OHl0j9UqR6TeAf/VWQTEXP2GgXmPzNBFer12ol5nyy9mls4cGqxMSa?=
 =?us-ascii?Q?RUVLxmuPgzCQBDqmxdpHQc6sbGb85VniOxc/qYgdVevW5cN1ZR4seh+HtHYL?=
 =?us-ascii?Q?DGBFBltoMsEWBkhhtRgn8+bQGWBSzNvGsTqsSS7i+fn+u1Tbpki5F/b6NBc0?=
 =?us-ascii?Q?UAgpB6gaIG+P5piVbr0wXhrEFBO1FqYz8OMRboG6+k05eWoC0JN/vAmBIpYU?=
 =?us-ascii?Q?jScTul8fe7MhtEpc2Vw/j5DukxIVz3vq5nmnKcxaYp+aAEPjZgAOwL8uhswu?=
 =?us-ascii?Q?h8CS66mcWSJ5kPutCwmzgqR1zngv7AkS3QCJtUcK5xCxkt0cAAw6POL2AhEp?=
 =?us-ascii?Q?x38Yd+5Wq9bCcT1KxiDB5gtcxbj5Hy0JCUB2k9c4+9fNB1KjNIRL4rt8QjNt?=
 =?us-ascii?Q?IuivF3JojZqi4NXGPRurdeJtdvQuHU3uP29sU/CswqlKTmHf/lUWTq7KRWmt?=
 =?us-ascii?Q?6WK2PVAeYGzh5RqAJFR0/WsJfZ96sPQkEVD5DP35k7W1u4/C9OrOHsEYT1rF?=
 =?us-ascii?Q?Lg0A1dVxtkOaLA2yEA7XyERNSX6Ma3eJTjK/cbnZVNbXKCnKjuo+yM3G9dpR?=
 =?us-ascii?Q?NYDV9kXjOsgbv8tmRieG9W9A++KAsN8EtfrQZc83hZNg/6xdvo7Va9mWAG/o?=
 =?us-ascii?Q?Ow1MQZXvMQMOFitCdaMojPgzdespMxxNlD306lE5B1vjJnuSgK18MM0rWTm5?=
 =?us-ascii?Q?YB9pjtpaZcEl3LUErpKAmytMsd6mQPo27nBT0oZlKFFMgckLQzZXoXHaXfvM?=
 =?us-ascii?Q?heOxFS5diLWoLFdNg1IK4VoJy2wo+gdHSfIl8UVfiQOce/uXir80UukvbrEa?=
 =?us-ascii?Q?arJGh12VP/sTXsy3kkjew58=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df1278f-40da-4ba4-3be9-08dd730533f5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 23:13:54.2190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0ifVIXSAbIGv+PBUjxB0RvOvzA7zVgdqCdzR03iQ5Rp7bKw+NNmFLcLziPF1HgEf6nUWO+5k0dSURFukiynOufJlRVvAj6VF1FMPJlZEBdnPwORF8LNGPqfqzPUbFmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6925

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs(1)(2).

Proposed ACPI spces for EINJv2:
(1) https://github.com/tianocore/edk2/issues/9449
(2) https://github.com/tianocore/edk2/issues/9017

This commit is not a direct merge, it will come from ACPICA
project, see pull request(3).

(3) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index c701c434976c..f52d5cafaf76 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1034,7 +1034,8 @@ enum acpi_einj_actions {
 	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
 	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
 	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
-	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJV2_GET_ERROR_TYPE =		0x11,
+	ACPI_EINJ_ACTION_RESERVED =		0x12,	/* 0x12 and greater are reserved */
 	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
-- 
2.43.0


