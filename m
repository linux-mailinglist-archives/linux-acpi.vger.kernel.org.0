Return-Path: <linux-acpi+bounces-14140-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDEAACE6B2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Jun 2025 00:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893EA179019
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Jun 2025 22:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4704823184C;
	Wed,  4 Jun 2025 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="jAx59wBD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023110.outbound.protection.outlook.com [40.93.201.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75822E402;
	Wed,  4 Jun 2025 22:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749076705; cv=fail; b=KfwCKBj2XCn5KIkWiiLRHBF9SAoxcS/P/dkFNsDJM11VJsAn5GjvLhrbIMKIdzGxZ24tqn54GAsZ4Gg1zFJhrp3IqJ6E/GTduDsCAcj4rzU2AhAfYPKduPKupIMBFQX8UDp/Cr+0pWm5BjxlC7bH2NhieuWum2bU4W7RHoN7uTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749076705; c=relaxed/simple;
	bh=u/gHZ/oTKrn29Sm/I1DAL8Ho3MGqRSGOHLMGs82HCDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O/HMtoiLvgQXLk7/I5f907olHjmz8/Pvy0T2DYqmhxeDhNiRK6jnZRlYJnypReUFtOCZmBswhmFVJnlYSdrj0e6E5cDWOjhZOTS5c3UWXxQDU559PT3g+xRkepgbKDetosM81hcLuTXO1F0PJXrlaJBLaMrpHNMvbIPgqdDXLwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=jAx59wBD; arc=fail smtp.client-ip=40.93.201.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gwm3UMu+NRQBWumS0MDZDI/rFK24mGWCWQsAqCsfYLmS15gX5ZCgWsJcVL89Go73zOZ/s6psE34NQ2l/xm0tkQE7tz95bEffvEwKJQHacqsHckEiXSiV8t15bimvfVdUFl+7Bh47qKWgAIuUnNlWoaqz0bkGIMS4j6vzRWS+Ahaoah6RlhOxQxVnJyaxIU9++EmhoEsrVForYwKHbJi5LBgp4PoBUjNtdIk6Z6dPcirCROPPNtpgTnGNKqrG/pfWGVY+XYOdrmHDXXQbS5OhysqA/U19/thW0M4gUze8OZNKDkia5etJKEgJ9rOrXtIUvVVfE1JhUCp8mvD5pA+tZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIoOjmjHCZUwbrQeji4v4hiCoy827hvx3i9UArmDi60=;
 b=C+jP1AeOldcLtqDTuPZno7Djrlgwc4t4j2OFCw8/61wZu4DDmGMy011Ik/7fIz1tZony8UcqTwPjE8Pa/KZOSXo/HLsHCAGF0mJaKgFiDaoWBbJv+QwDViv21LOkAHmDh7vKftCmff/BRrdM+IgJOYS6ATlQZIbP7z4lyi2kvpd0pkQ3htzt/O3npOiyCj5M0Gpc3OBCY9dwGAjXpw5zXoA0lgk+aLE+pzAIEgb6wDHqdY6Xu4w464GCftDDQq+IlM4z7Lx9hxQmwKw8NJo8KRwjDOrkMttql5r5GYV/k503IhIk2eYty+7JALdBMvRJABrLoDeyxJTOMJkp416qaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIoOjmjHCZUwbrQeji4v4hiCoy827hvx3i9UArmDi60=;
 b=jAx59wBDq8o9I7+lIqLZ2MOkfd0aZnv0aez/cy4JFh1M7GdpORWn7iLumUVGfiJChI7M9uBv97jZhqH2cUlMoGo3mlYdfKWrnxk9TiQm+agCw9UJNI5P8NNT2Yjh+tJKAdOiwlR+k12UGxur20UjxqC1M7+v2wX8qZQQ57csQkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 CH7PR01MB8810.prod.exchangelabs.com (2603:10b6:610:24a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.34; Wed, 4 Jun 2025 22:38:20 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 22:38:20 +0000
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
Subject: [PATCH v8 2/7] ACPI: APEI: EINJ: Enable the discovery of EINJv2 capabilities
Date: Wed,  4 Jun 2025 15:37:59 -0700
Message-ID: <20250604223804.842501-3-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
References: <20250604223804.842501-1-zaidal@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: bb5e0911-cafe-42d1-2044-08dda3b881fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KKweepRgk0Vwyq/gy0NVo6PJ2s2dsPmITTu0eW108ExClaV3+BV/i0fyzxG?=
 =?us-ascii?Q?G1jPzVqvXq21nJGts7Pw4KIjzyaoY0Cf+NyVao/aUP2CJCxgl6GeXW3Vhlof?=
 =?us-ascii?Q?GmEnHxoH0OvaWC2+vlAwaC1i0gofMndelIE7vYQ5tfCwDRDme4I0jaWC+nIj?=
 =?us-ascii?Q?WAihfPO6Io70dIkU4FLGCLN9Oo1IrVFtxICjMw0WdHF8A4dcQkPuOWDQDeG/?=
 =?us-ascii?Q?IvUplHQflZ6CWLtc+1XDhtytZe6He+bfC/+ZYD5bUYKKGQFznI/FuewDaC2X?=
 =?us-ascii?Q?Rmzfli4gW1/72qbISvV1aNFIQlUU2PcPDMq1aiwg0uJWKRn7ZVCdMf3vcKe/?=
 =?us-ascii?Q?8wHNXaQb6/B0z1dpP6g61fEBG/57n6OasifcNUEYgMOveM9I0VGetGQIIxWe?=
 =?us-ascii?Q?zwV9+MxpNRXMi5Jsl6UDfa7uarSTsB1Z99NNlu37q1gznEPOZWA4972WGNAy?=
 =?us-ascii?Q?JpHK22j9Joe8r6YiX60t+zrXHa/3v21rSc9sHfQD4B2GmyZGbeqbHqDu0pGH?=
 =?us-ascii?Q?Tz7AvV3mu9mjxs8FY48sSoOkL3Z5hPh4+hZ/Xckwp2oEsVzCcp0Mc89eEshR?=
 =?us-ascii?Q?vjGlIw2JdBMiR+G82Z9x9BWMzv8jrSKhB8keB+eT6SlnUVDrNHCy+Z3lRGgv?=
 =?us-ascii?Q?E/f+WYi+OaHs+7qxXDKJswfgMNPKuMjuUhth2PMQxeROYJkuMOvxinJCRaqx?=
 =?us-ascii?Q?9JriQoSyrmlECUQ9XUa6zB/Be88UznFvJtl7RkV403mXvJdXQEDkBCy5yaxz?=
 =?us-ascii?Q?f0j5eAKxi7vE3kBz/PhP2fzBNRyoB9jQQ9S+IkKbN/S04jOQvt1/aJcz55Hx?=
 =?us-ascii?Q?iaj0JS8uZLuTXFBCdjp4KrbUBAHgVSNGM+wVjOLg6wJ2Bz+/DHZxzJ38jbpQ?=
 =?us-ascii?Q?s2O6De33YCB0qutuizd0cgwuTIopQJedVDllGPfhhQSvEIvFf1yP2H4s6jnn?=
 =?us-ascii?Q?iZd89ZY7ObeBMJNTk/wxJH9ZCohSS0dedp3jS5LsWuBtcTJK7XUdxKnyUr6l?=
 =?us-ascii?Q?Kcqu9aTcVKYP83gLStlVu0MkVaOozlvywqXAgtcEYb5gqXG+o16OdhD4rUr2?=
 =?us-ascii?Q?cnwz2YQWYhg9VZMaB5jOwBAiO5qedU96JbdzI4ZQbZmKHnEI8H32g4AL4Zs1?=
 =?us-ascii?Q?qtYjrxt6Y4QyGbD+U7TkjSXe5h/C+get+zT3iWKP2IS0aifuSFmipwjVbdQ+?=
 =?us-ascii?Q?eXP9kfi42IZqHTYynAd7HaY+/Wb5tVwd6PD38Fbn6j68c/qBPmL12qkcmVVs?=
 =?us-ascii?Q?fysvKnbf17QfFCpEGpU3PXZ69tCvW17sFnuD7RxEDN76W5jeOy9LRp8gPDb7?=
 =?us-ascii?Q?PlguZjLBtIO+bNcKqGaNodLJuviSb8/Rw8W6bFdV2eKSaZxf/EbBl6QSN3Nc?=
 =?us-ascii?Q?Gts0+OemxVLOxBABC5sSy5lCIUmwn2UKxCNmfy3ediNocCJmqW1/LGRSeyxc?=
 =?us-ascii?Q?wKs1Y28ePrXBFb8lt/QQnVKRl6UeKEU+4dOTsJRbD1EAfVnLY0HKOSMOhbSo?=
 =?us-ascii?Q?aosMHZeHY6i6E9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GX4q62P0d2Cj96EsdK5Z6MyYWM8RLJyGp4T4rAVfNYokOwBl6Ommb2BKhBK8?=
 =?us-ascii?Q?0KBeo2xlxn+hJ9FaL2CBJjEtXTJCJXUFzziSEntmRXiZVgFTYdhsS5CwxZKA?=
 =?us-ascii?Q?oq3q53Tn6gYHT2OsfoFwIc5t4iEwjD2WNvSeEhaTK+I/z7GdKHxSE3QcdvZP?=
 =?us-ascii?Q?wiA3DPQ6EPNE95maXtRjYTef7NrKguLLHApvhhLJ34Qfeih+j60awQaeDYAA?=
 =?us-ascii?Q?IyCBJ2s05jcVlJaiM2/knh1FBU1/Feh2nTBGa9SoM6JF5iBj4VEmGdtZ4hou?=
 =?us-ascii?Q?B8ByhZmOPVloZ5kHjSZ0INO9vQlBXZ8MCz8NHcDKHKsJ3NzNSVG0c4+B+dJd?=
 =?us-ascii?Q?d3P5L2Lpn2JhkyFplN9qPrXXeStQcbJM4hj9jlTVSHsRWlf38xWGtIzcwYbY?=
 =?us-ascii?Q?MYQ00XteJzW/eMgEiW/r88/yd89zzqcxa8kXgcxypXWr8hNw+wS5J4NcFnjv?=
 =?us-ascii?Q?Vkm9rWKGrdfBLjFJEQFVYvNBvH1Eo3o251fjwMPO5422yxB15yTBtuFCz66K?=
 =?us-ascii?Q?hB4OK8ZTVNMn02SW2UhT2TukUO9Czk9hFXWgnh4q1ACYsKXJVbYRwymYTyh4?=
 =?us-ascii?Q?r8sK2bqSTTPGjMmgx0J9KNnwX0TBWn7HWtJIcqI0pnXedLdjKPrGq9oCBq2X?=
 =?us-ascii?Q?kH45Qwh50rXCLEkU14FcATcJ/cuWjAkzxUfKDYVwyqk8HOIpSfOuZQmCmHRd?=
 =?us-ascii?Q?2cuaYMa/OvW5/5umfw8Q4mLmJdUuSmOeizx6fWpONAipeS/sk7bGQneABlDd?=
 =?us-ascii?Q?/7uFjF9rT/pjbkHIoXkIAVZmB4xLn7vpqbCdNq+EagZDKoWfX77he9JFbV9/?=
 =?us-ascii?Q?rlq8LbQ0lzszjhzjB3n2gFJd5YZuKaVP0Kq9nu9N28vltlQkrB75aqPh8HBk?=
 =?us-ascii?Q?aR8a4zeuHgt2jtIdymHSnF1MSCGJ5d/D2XgTMojicg4jTrssS4ypjAWmse5M?=
 =?us-ascii?Q?6mjzMmpayVQ4Vy2SyJd/EBe6o11Mb23kKqGI79yHjMMZxESdWI5ZilHpEepu?=
 =?us-ascii?Q?ll2gx+f9R2AgILMPlHUSo2cqjBPJ7fKkCEbQvXfL7M3lShPiVRKatgZ+Po6z?=
 =?us-ascii?Q?r3hyPXQvSylYLf+TH7vHN4ZBxWNk1i0lGGqxSVa/ed2cD8tn75YYYKrnTTtY?=
 =?us-ascii?Q?BOS+rrOz8fcSx7JX/z733iTg3HFBRoNpfH82GsmRW5FRKVDPrZJtRR7SxTZU?=
 =?us-ascii?Q?vYgyn4O88vSRfyKgxnHEyUtJWhJDrtrOplJ5dWtf4KyWZJRH7Ad256dVw1ow?=
 =?us-ascii?Q?kbtWPVm6v13OLK3gKDsExrIp2BHoQ0CiDavhKJiE+qqUe4mhJu4tX583a/Iz?=
 =?us-ascii?Q?X0f83dAw6QjeumV4qvV6Zw/+vtAlCHFuiiUdcoi9uf0+fWnv3971WcjHfr2T?=
 =?us-ascii?Q?Genh+4rfX73SPfik8ZiWjCzHuX2XeqVkvlQIoih5YbM6yFvea+m6lqArGn58?=
 =?us-ascii?Q?EuPdu8Y4DwAZoHnXEUq+tGu1g5NzI5WHJb6ezkKG8P8QpHIr3pzJWZtRMkVd?=
 =?us-ascii?Q?v62yJm+jSdYZ212PSAS+Woa91PhO0g60YsVAagjo3GsQPMqVN6OrtMx4O+qs?=
 =?us-ascii?Q?bP5qdA/nk8nWjktmf2NB+XVEDaqpO6eVnUQQQCdN3WF2RHE/eOZ1z0BousvW?=
 =?us-ascii?Q?i2fQiDH8otHQ/NXD89zvuRg=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5e0911-cafe-42d1-2044-08dda3b881fd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 22:38:20.7966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BuVxDb7PCnz93XzqVaVB4fqXxX3M/by+zKydp3sEGWUikvhm2xuZoMahxnW/038GbPJ7lS3h8JgO9m6mztKF7Z9rCBu4Ic2kIL7NRp3/11J+1tT5bWBNCIBBq+QtDcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB8810

Enable the driver to show all supported error injections for EINJ
and EINJv2 at the same time. EINJv2 capabilities can be discovered
by checking the return value of get_error_type, where bit 30 set
indicates EINJv2 support.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
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


