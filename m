Return-Path: <linux-acpi+bounces-10967-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B954A2F74D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 19:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16D171628AC
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Feb 2025 18:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE754257AD0;
	Mon, 10 Feb 2025 18:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Du09WhPo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023100.outbound.protection.outlook.com [40.93.201.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F32566D1;
	Mon, 10 Feb 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739212652; cv=fail; b=pRukngL761CnsM1hPZMoCNLIgX4+9+u12YDHOWC2Ra3y6aq4KAwbX99obIIkMLi9ZzhDxAWD/0KyDatJoz1mMfvoCfy4g8cOgOBIDir9gAqNakE0UwHtyEjojyz846is3iJGL/AwngnC/++04dLg7hQpualRL/a+XleW/r1GCSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739212652; c=relaxed/simple;
	bh=oA6i1AcbH9A0xick7QSDdChjnUk64VXAyd8aLe1COUA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNhY2bqL+QHOv3KWHLgeeuAwM0GFAc+56/7XID6D0fo01hbOgnm7uAlSw6JaBRnLtiELvV0khqJN0B/BdA8g8sSrnh6HdUD7hbHd2UidpPQ+m4/lbt9zMC5cxRceEzH12xJKtBYNU4OuRS+yE8UPdBCtKk30zmNxJExeURiXzmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Du09WhPo; arc=fail smtp.client-ip=40.93.201.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiY90hQGVDtODw4RPjUaZHIGZty+2y+SR94/I7r0FzTPAWIQctm9L2QxszwctDA1JVfg8YQtYW46kJNgHe1LKHeb1HGS6o+W8281YoNwrjRKsU3AqdokaizvslPDQdpx8CaEFONzTqmvdFmUklMaX6pYyJbXU2onSseGenC5M44aO6PEa4rZFkF0qpLEJ47EorLU7kGIWxzw48ekpA4xHrSuI+Pi/KUFTRTtklB7J7agOwZfNMGlqFpR3uEQqjA8uOWhMA0nYvjVeS7s/HzK5C2Mlj1imdcK2n+rhsNKq1/jfDOQBKZlv6Jfyd36ZuZEOS2NMUssi6EHfLdHKTA3dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgU8s4Qe5/1NuMf3EBz5aHzKCiTveUaT4bV9M0R4gY4=;
 b=GqK027iG7GcRi5o0Y/WxTHHJ6XOv1me44GBT5WZS/YarQNETMDvCCaXYcBDKJqXJCv1QPBAe2llDmBULj0Y9k3hWwSJHmfnCP0J1eGFw9l0+X0uzSYHyJedq3/X7fXuSJ2Sar3QQMCauOUfbiZ8kwkEzpiEBCQ9OVe/QTtjTRjJD1TglVXvrlwUxiNRtaGfj9tZz+T076okYIKBA+bxRlJz4xWbxcdJviDdPqI0i5iimRs16CDylrp1BjFXYp4RaIE2lfwNhbqEOXDVDXnJz7vHHFGKlzSJODdE2fIAS/3ypGRnvas8CMtjJxFacTmhSqVziOOIBGqFy/i9XAffqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgU8s4Qe5/1NuMf3EBz5aHzKCiTveUaT4bV9M0R4gY4=;
 b=Du09WhPoe1FGX5JVLoivbBgZjtyLUWLGSkNB4kfT5BNOpdX4HvpIbGrzHVlH9DvGbnxhlJ89rcku94VbfgXPQDpkNGtqRIPGlOqqV7QC/eu3gjXDTAyU2ENL4M2hr2q+2s8PsV4iMxxm+d2St83MSL9G8Vt4San/2fBWosowsTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BN0PR01MB7101.prod.exchangelabs.com (2603:10b6:408:150::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Mon, 10 Feb 2025 18:37:28 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%4]) with mapi id 15.20.8445.008; Mon, 10 Feb 2025
 18:37:28 +0000
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
Subject: [PATCH v3 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Mon, 10 Feb 2025 10:37:01 -0800
Message-Id: <20250210183705.1114624-6-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BN0PR01MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: 714e4de0-9911-4322-8774-08dd4a01f86f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aZiE3sZcJ2q2t2VBNmHxFDdy+ej1UNA+UCkZo9a7Ky7eHPQov8l6g2g9r7QY?=
 =?us-ascii?Q?Bilg41ESkhpyjCBLKx60PriO86d9ZEUstLj5BW8iyOnPfWThPJC5myblgsnu?=
 =?us-ascii?Q?FH05rWsplBhm1cjOy93p3CXx5IhocYFTaJYeHwFAGeNvRJeJsrxPEBq+FGq7?=
 =?us-ascii?Q?glTJ8uGONG6Koii8kRsaUjWK4Cg1ZB1cxYjYrf2QSxvRsZ638iRjUi9MUJH1?=
 =?us-ascii?Q?5j4L+WoGuHKfXnPcdHxLSpe94VMZxcfFDtwI/dPlkNJZ0MwqWMrFK+HhCW0A?=
 =?us-ascii?Q?YRl+Efuw33AjSf4yq7p7t/164P+HS456FrbxdNkljRWzDD5Q+VBNsAlbPfNe?=
 =?us-ascii?Q?fkeQKEgxj+hQJjE9v296PQ8KdEmAAyKgp0QM5qrJ5DIjQ/Eu8HX3mhncRZLp?=
 =?us-ascii?Q?2abm8HW0hh+LtKt4zLLrAlo08SZ1IW6DDRumzC/bk2+UZkw2Cw+1cvEvqyAO?=
 =?us-ascii?Q?ecsQXahncD34xLv3JxV3Gr3QJy++lGiOQ8YHn07B/CRrgTpi19TcIzkJSa/C?=
 =?us-ascii?Q?0cBzh2IIS6yh9bLWhllwMvfI9QXICTLi7CKOtQoseQbLvohw7Z3OmN480u0f?=
 =?us-ascii?Q?KjCr924uBqmHiSraRxIL5KvYvWSiz8aQUpwz2TA9WTPAuevmuEeKBTQwC0nv?=
 =?us-ascii?Q?BLEaKZhf3W75f+LALRdHI3h2gT1S+NJkkPcXxPjmwXHIM7w54EE8ynHjhlVO?=
 =?us-ascii?Q?gUyaS177sz6i2KRyEgy5TtRuP1GGcyxM9t7ah9Nzlf3OjcLf229EyLanOnyi?=
 =?us-ascii?Q?SQOIgr4LOaz6er7ztxdwDS6aOv17Q7gHadABYbwpDY15nCiDBaecCGFyKb+v?=
 =?us-ascii?Q?jhMv2UIEjf9a3Y5+5/s5EyAXyjUqfbhr0wklgzsd8u8WLJaHsEfkXsiFzgr+?=
 =?us-ascii?Q?ldyOG9BWZWzAZMZTFpM49DF2+tnogH/6xwCy0F+XOPpiMNBeb1oVtxF9fgJD?=
 =?us-ascii?Q?pz5dCZBNHhk/Le6myg/5LGkIWuIxhObwaORBw23d1SEXHkNJVZWPYCPBdHCT?=
 =?us-ascii?Q?y3HY/wfljDxUUKpmdQrUK+X3cG+rAZT+vrVS/Ot+pUthSenwWeD7kdgbLw95?=
 =?us-ascii?Q?RpwoGyOl+2s9S0tal7HwBPhBSMOkYT6GjNVpnYaVgIgBUS50uLO7NrpY9bGt?=
 =?us-ascii?Q?n8ATG6qQcbl7g2E5OH/OlUivrjCyBMxWy2OepTZZdW41xc/imTDHRiIYhSP6?=
 =?us-ascii?Q?eMx+QeGNgOLuBz40meH8YWYmdHjFaCjqMfEUX2Va2Q8wV4ix7i/I46m9EI58?=
 =?us-ascii?Q?JXyU+YO24TMblFHxrUc4HXH62c0mIHrtOFUyN5ORjlj/Y0nmd4qspF7hN40e?=
 =?us-ascii?Q?jqE9L0zQRfleru3oDgr4uTR8/cqy3HPqDTyYbrSvS2mDkPjOgCjsWxP2br5M?=
 =?us-ascii?Q?+58JzOAvTgF+a756s4qSD/yp5+2tNP6NPUzPT3VGhCJpv3nLWVMVd7ht6WPb?=
 =?us-ascii?Q?zF0Vfxlt8r1eu92LX+1syFBk9lTO0Abi3TwNLByLQWNlVvlTFFGm1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWSiJ9IWMueqnGQFmzXKmG4SMGGtLOx3qLTGTd+RdW+JZ8P/4Tj8Uty0Vxml?=
 =?us-ascii?Q?hjRe8jnocUlu6czhpdLNa/RnOM0A0q4Mk5IKfy968cdcZjU5P/jzgsesFoaZ?=
 =?us-ascii?Q?dD/hhBYGnxJ7d8RCptnJXVW/sZHbzRPX7GTRoLCrRrpV7PCpDQdYo5VttQuE?=
 =?us-ascii?Q?NC3VPD9RzHMX2JBGuIGyR2QuwSjkTYIxgRksASY0WM83u9LCOD+HOFmT3nuD?=
 =?us-ascii?Q?pM6NjvnhTz7jqkC7hPXv1Epl3XA4l2qC0UVKRem7N3czGAFP11YM4Lc9HVqj?=
 =?us-ascii?Q?tR2orKJGFJ+XYGIFI2x3pJiwcox6I4kRlVeOMejQYpQLWlXtOU2r7w8iFBQK?=
 =?us-ascii?Q?5UJSmGOJNmNp+uCcYzJWZ+JftTyq/qG35vsq0UYKhoCQLIy6TlSY+uWdPDZO?=
 =?us-ascii?Q?TWd4sFF1jdk3Ut9FdtDkjdNDFcA+iChLl3/PKwDv6+8XAkTL+/vtRjBK9nGT?=
 =?us-ascii?Q?3t2K/ZfGRl75b8FU3TwRkzoPkTPKja7yqoQJDm1P5TZzkPbswdpKv6zxTfyO?=
 =?us-ascii?Q?AfVhPe3t3duNbRgIEb1yH49Z5EcXDySqSTyJ4Ox3RhgjNSqfgCJrNpVh+poR?=
 =?us-ascii?Q?/TKA5H6Jnf5JwtqOGVmQitO0Ex7ps0m1YFMdhqtokebMDZFJfYo7MQYWraIw?=
 =?us-ascii?Q?+rm85nbxNeBUzQs37zyTESjbfWEG4HiDedZaRQ2IJVQx6s53Nfgt1Z+9uGZg?=
 =?us-ascii?Q?ABYyvnK4TBJ9B/+OYwA84EaMowXdqITjxO+1+NbhppTm4f7CiN/zrk/7WTjL?=
 =?us-ascii?Q?6pk314xv56mkl2D0XiWpjhq+xsmSUtScg4z4ROtuhBpRCogMPiWpQBMs1o+D?=
 =?us-ascii?Q?pPEKWynenGtH2wHARVg8M4Ks5TdCtQCogwyRi68pTOtmwQH/hCKR5vFIlOtj?=
 =?us-ascii?Q?WNzQRsGm5ajiUPQIko00sgQDkXmvYEWXkg47KqJZ6h0SWJX/lyDI4IWiPkq1?=
 =?us-ascii?Q?LAYtvGaHjP53CeRHzct3aS7iEh+PO84TV1DIXUmqOTwAT9wmkLBhCr59n7CI?=
 =?us-ascii?Q?3R+QCLdu6S3t6bvMInNP5eWq4t4m2J7C7YdpNvfjTsBuozXsKuYZzr+8McSG?=
 =?us-ascii?Q?ElLQX20Sv8SWj+9VdYhfhMNt81ruQsBFJBMdmK/FeJz2YifPf3s0qpmz4dAH?=
 =?us-ascii?Q?W53GnUNXcTpMwBnteaRHXoAgJGYcpBN0JohDNtyeK/5yyWLt5DDbMAfjQNBQ?=
 =?us-ascii?Q?nMSguwq0OYuzaSxIjOpGpS1TqN7HRGQH2X3R4AYjjTsO+8TkXBkYboZfdeuw?=
 =?us-ascii?Q?tMq0KfGjYUzlCrra7NtYqP5Kw5iCE7/kIbJQ9hwHG+DzflVjZ43GW/HWAvc4?=
 =?us-ascii?Q?ui7tkIIHwg54gpbJ6My7iuH7px/Zd1yuIxEHjaMtbIM/CG02NDWlpgt9H8RN?=
 =?us-ascii?Q?sZwBhDtcOirYqR0rv0e/XqQCsvSX1wzgijufGbDq1oI9tb//yy+dGaOkEliP?=
 =?us-ascii?Q?TsbuXlYHIVTHhlxpLBxcCWPSs3rHzkddMnTWuSs/7hzeck0jj7u+GaePT1Oc?=
 =?us-ascii?Q?qNb2jrbnEtD/wBUXb6Z+W2lz9CxNIcvAC5W58kyMw/1CmMjyZ/8nsayzqvDi?=
 =?us-ascii?Q?TwAuyDMVq98w/s5w+TO1RiW2oxxIuQM4iQfh5XUxSykPNTejZg7OoJKhjTHo?=
 =?us-ascii?Q?Dy/r7eWbP/KL/VpzrERSNr0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714e4de0-9911-4322-8774-08dd4a01f86f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 18:37:28.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/zVx7SCDn8kgZz19yDtq+2KC9on7NeYUw2GXkt8McQKLAytmZnaAKIJ2IMTn37Dtnzdv2Lr0Kg2kt4XaJvCTt+er/L5GBD1lcpcfdw5SMzl7hGcnmzN1RNICyDBn0/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB7101

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 drivers/acpi/apei/apei-internal.h |  2 +-
 drivers/acpi/apei/einj-core.c     | 65 ++++++++++++++++++++++++-------
 drivers/acpi/apei/einj-cxl.c      |  2 +-
 3 files changed, 52 insertions(+), 17 deletions(-)

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
index 0f65e8bc4c30..369d92e410c1 100644
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
@@ -174,12 +176,12 @@ static int __einj_get_available_error_type(u32 *type)
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
@@ -649,6 +651,8 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+#define BUFF_SIZE	32
+static char einj_buf[BUFF_SIZE];
 static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
 	{ BIT(0), "Processor Correctable" },
 	{ BIT(1), "Processor Uncorrectable non-fatal" },
@@ -665,6 +669,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
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
 
@@ -672,17 +682,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
 		if (available_error_type & einj_error_type_string[pos].mask)
 			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
 				   einj_error_type_string[pos].str);
-
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
+			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
+				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
+					   einjv2_error_type_string[pos].str);
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
@@ -715,9 +729,22 @@ int einj_validate_error_type(u64 type)
 	return 0;
 }
 
-static int error_type_set(void *data, u64 val)
+static ssize_t error_type_set(struct file *file, const char __user *buf,
+				size_t count, loff_t *ppos)
 {
 	int rc;
+	u64 val;
+
+	memset(einj_buf, 0, BUFF_SIZE);
+	if (copy_from_user(einj_buf, buf, count))
+		return -EFAULT;
+
+	if (strncmp(einj_buf, "V2_", 3) == 0) {
+		if (!sscanf(einj_buf, "V2_%llx", &val))
+			return -EINVAL;
+	} else
+		if (!sscanf(einj_buf, "%llx", &val))
+			return -EINVAL;
 
 	rc = einj_validate_error_type(val);
 	if (rc)
@@ -725,11 +752,13 @@ static int error_type_set(void *data, u64 val)
 
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
@@ -737,7 +766,7 @@ static int error_inject_set(void *data, u64 val)
 		return -EINVAL;
 
 	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
-		error_param3, error_param4);
+				error_param3, error_param4);
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(error_inject_fops, NULL, error_inject_set, "%llu\n");
@@ -786,9 +815,15 @@ static int __init einj_probe(struct platform_device *pdev)
 		goto err_put_table;
 	}
 
-	rc = einj_get_available_error_type(&available_error_type);
+	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
 	if (rc)
 		return rc;
+	if (available_error_type & ACPI65_EINJV2_SUPP) {
+		rc = einj_get_available_error_type(&available_error_type_v2,
+						   ACPI_EINJV2_GET_ERROR_TYPE);
+		if (rc)
+			return rc;
+	}
 
 	rc = -ENOMEM;
 	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
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
2.34.1


