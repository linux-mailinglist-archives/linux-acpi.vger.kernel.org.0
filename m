Return-Path: <linux-acpi+bounces-9964-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A978F9E5FE9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 22:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36AC218849B1
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 21:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAC1CBE8C;
	Thu,  5 Dec 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vYKB058O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11023133.outbound.protection.outlook.com [40.107.201.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3101BD012;
	Thu,  5 Dec 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733433552; cv=fail; b=tMKd+CkkIia+Nvs37RErqo7M2XjFYTzeBTJ8S2RAHTY2nuV6kuqFEWPuiKo98vQOkRxgY0UCRXHJ16BRPc9W24VXp61wzHtAMGUJmPWgPZCtIEhPxXj8C2Xh8LdWuH1CDNsIyUKMZYgv1uoo8r0spHEB62WueTvrHR9Pp//UcV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733433552; c=relaxed/simple;
	bh=h/75/6tbGgbTfJAgQleixF7WlE85+LTnt1R8panQoKg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvlOjFeoC/EQNrgv64VLYpDR3s1lA3ay2B3qhLvw1k7xImMd9dA7NcSsgl0yj6qIrn1/gm1QhbFDcG8XpLDw4u4vnqJraKFkd/F6pIlBZc/bwCKgOaFq0wRdRUZtglR7tgJDIS89OvKkmE8Kyde8v8jtuwF2OmfyvkCMq9qa56A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vYKB058O; arc=fail smtp.client-ip=40.107.201.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbRGsfMTJJbWdOFIPsTMo+og+9sqlmhCb89V0VdDVPt3QdsdyNJsekYc+n9R+/LaeHgYRX04KyWiaHofpe8M7VzlGeHfRUHuqCWMeb9YbGdJT4o4AR4aRpqghYfPO2hOchD9A2F/yeHjh/hCHmv/vaGyWWfhgBVReFtA1HT/ffWShlAm3kQh5PVfK5jB7AErrMXCVxLQ6aETLgx+OjRXgKd8DUTYYhzZMc0YQxTLofSv9UC5RFcfwAdiRUy9WhPYfJPhJai6kVoPAeVmdRIHp5QuN6cxqbdb3dFmnjPOjrbrtzXCM8xn/kKpblRuCE/30YgeozvweEFN8LDgb8sU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Iw96XrCZsImEjBbBaMr99I59rm+pRnxQsSWrzp0qIg=;
 b=L5b/gpU4zwk0Y9SN4uERQanbVw1CgL3A3lGKPY07FMrLCn3jjwTJmR0NUxugXK7c00OZAj1KAbNJV7EvgOg9V9wV3TNHJkj/bTF3egybtCqhV0pDJDDNWEwuMWVoWeE6EaDS7vtcSXe6l1sJ0g6FzMdzGYs0qV1ZNiH2nVZ0lnVfg5xfYceWWDgGYXFN7Ry9EsJVKXFXlJOQlWQOjiLe1g7o/44CiPAp73BOQerifGPvaE4O3XabNW5RIryrqK6sKQ49wKJCc1E/DAGZR98tu0xKRR2DC1nJR8mlI0j8lkxIB8OFPE1JHJcvAycXMVBuam65WKp69TWHyC18SgrKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Iw96XrCZsImEjBbBaMr99I59rm+pRnxQsSWrzp0qIg=;
 b=vYKB058OKkQgTIVSugvRtJpf4TRcFgH8/BOTSpTWJ7geDXtppCV6I5O7SPbtyEDzfDo811Pa5nXypvVnopQvuYtwBLS0k7AgKFLF7xkdE+p0lEUMi0hEmDPVhHQ+T3q2VpcMKoyy0/Biz7Zxkb5pxRfEPXxw8ac01Dy47nZY3u8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 DS0PR01MB8004.prod.exchangelabs.com (2603:10b6:8:145::17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.9; Thu, 5 Dec 2024 21:19:06 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%3]) with mapi id 15.20.8251.007; Thu, 5 Dec 2024
 21:19:06 +0000
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
Subject: [PATCH v2 1/9] ACPICA: Update values to hex to follow ACPI specs
Date: Thu,  5 Dec 2024 13:18:46 -0800
Message-Id: <20241205211854.43215-2-zaidal@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|DS0PR01MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 6972daca-cfdf-4800-9e0d-08dd1572737f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j4rNlyZO2C6DvL0jsWmqKvZTgRYbPBQeuliQJhBEJmmuCQN2xKwenM1bB8/q?=
 =?us-ascii?Q?Zi7rDAjgmzppan6cTYNU/w3vjo17dz3q+0rSC0GjC2W90XZ4JpYeKxXPMnTY?=
 =?us-ascii?Q?RdQjRWFXQLg4NNjji+n18IGaAqP+02CrrlFwSAWR+bWAXDqpHTBp7IcEwMbm?=
 =?us-ascii?Q?0iClMFPRQHFwNWVccA5FemFN/xvRaCVvUczRyxonLlaz8wsDLbNr74T3Puyj?=
 =?us-ascii?Q?IIqKhO+kgBgBg2HVd+ZX21ai3s6ohZRnqV+4o6tYseBTNPof5lzxr+KHtiP3?=
 =?us-ascii?Q?spROiXWdZrnB9LU933T8mEigI1wdF4niDpNs7nQ/LJ6C0mu5zU5++5zQTMRe?=
 =?us-ascii?Q?UuxYFcuSsWO2Jm5exQhbtAisjByr+5B8gXnWDyaVC2/qJKsSACG2ivrpkE+N?=
 =?us-ascii?Q?MTgjW0Pwr9RPyHwRArZu96zaQ6BZcheGzhaWY/c3lRVNNco9XAsvzb41PPbE?=
 =?us-ascii?Q?Hhf3wp4wBCUdgB83nQHX46kIc2Y+6xlP1eh9H3Vu0FsZdaqH5QqJ3xA+Cxsn?=
 =?us-ascii?Q?FBbOZxSuJ0bNQD7NMKNLALmHhCbrlPUJAtUPOPnXbrrliOQ1B9t2VNXQ73GH?=
 =?us-ascii?Q?7fjBfFGcx0q0h2OBjzs3rFNiHUEbU+bE/f3JB4zA2BV0VJdgBdZpZFVROwx9?=
 =?us-ascii?Q?AJweHCLV9TIbQCNFmQ1iNMi4Jit9K1QTR1Nzir3k3QT45jyXYc8NmVGcve1X?=
 =?us-ascii?Q?zNxz8obetYI04T+1CJRapEIsXGL84jr8p5W13gUI/51NDE6q2TPvoStsJadA?=
 =?us-ascii?Q?iT6r57MOCFTjORVtQnfngrRUFhqB+CHaC1S4Y1SSUSzpYzokN8sMcDQRBU8P?=
 =?us-ascii?Q?0ATTd0Kq44f+867YWoNvML3EbDQ2WJkTf719N7nW3xqbLlCfATNF4QO67mK+?=
 =?us-ascii?Q?7X0oKFoxwTe42RF3zoa68SE2pLknoa1cDMLwioCFVUq41IF1YqLIBJ66Ad5f?=
 =?us-ascii?Q?mvcqAQb+UHT7FHThGoW2xT/EmV0eOUzNmTuVJGuz/E83YZDYycACMuoh8aLv?=
 =?us-ascii?Q?d0QLDDPggWOqRfXgI0+d0VJkPbpMu2muR+1gWleDlx1u+BFV/RFiJT6dwgTN?=
 =?us-ascii?Q?1z/LwadyIhBTbRSZToIYwhtR+ZhoeUisJUKPIjpmlmeXATKWx8+tD5sLDWXx?=
 =?us-ascii?Q?cRD1mjqrQGHlc2IJh0d+tL9jEBlnRCPQVExM47uiuNzyxt5k3iW6+k6EQH+/?=
 =?us-ascii?Q?x60BmwAlnOBFuPN/QMoBHu5GZOAQOVmcQ1Ptkuc0aAJuwuI3szbaGcTKUsWf?=
 =?us-ascii?Q?So85UKpTNOfmdgZH4PP4n8cGrxDPdsE5Ug55UyQsMCdgwNJEZuq13VABSmbb?=
 =?us-ascii?Q?Ts6cfJFb4RL+jzXhndvFloVU7Hi2cofxHAEf9po7yIsm139+NIXDCFSwwIgX?=
 =?us-ascii?Q?UGH28bEiLfx8YmjtCUd0sUVL/hsLm9PLGOWKVCw3iu8zZZ9+/gtLdrU1ub4l?=
 =?us-ascii?Q?zSDtNb43yes=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p3sQLxv6TdEYK7HBslrn2k36Nz+AYRenfaBs/98A+VUQ/HfkEiWtnK+K+6T2?=
 =?us-ascii?Q?uhH4OSotAb/S42IMkMQBiOgMB2cHBTq3oAJ9fQ2s8YJg3Q8SS51sN/TICjwe?=
 =?us-ascii?Q?RTQHj38HmuUDYeeS95Qkd2B1GaDIdmIhMtNNzDYPHp9LtY+hNGDlb1urdCNb?=
 =?us-ascii?Q?PnwVhpaNMZk3KRUwgOsDeARGkqXMm7Kcj/NlDBcN0ze5HvyO/gvbH7KCAgCe?=
 =?us-ascii?Q?ElUwJwdfuCTwUeNfrFl8YEMs5Ie2Mw4cFMSlcSf+3m9Tp0PYv5fhrCaxtjDR?=
 =?us-ascii?Q?NJBL0eBZsuQG1Iki2d+B+1+E/bjaE1niaj/BhXB0JC+rZXVYLJvXJyD81q1l?=
 =?us-ascii?Q?A+cMDySoX2bvowjnLN7qB0vwQMRQ8JvLjshVhqU3nC2yz0JcBDAkILcBbl8H?=
 =?us-ascii?Q?032Va02Gxs1/RROsun3Ds5eAlXzIYCuujtjyzsQUxuDtLUg5qlFE9i4Or+Bi?=
 =?us-ascii?Q?wjV8cLuFMlG4/hLjlL/zFrT2l/zl2hrE4z1FcG/Wm4C75It5LAooraLpdWl0?=
 =?us-ascii?Q?Q3GamXjsnMeVe7jjI/PXj7WZsciKM6KoACP/GTmXPYwLtFqHhnGVqwVXf2MY?=
 =?us-ascii?Q?FK1DceB+SKV8edpFANfdRENstLmTIRH9H2U44c/7GKJBrXXuyqENKeWZXqxA?=
 =?us-ascii?Q?J60EH4fTog9UvxZiO7si7oKHnKAONe2hfBB7hx1Or/l4cagzE6DDqIUwt7hj?=
 =?us-ascii?Q?nP1C+pT67lXACn7dx22p02FGIBY3KRma9dStHKcnL4iK1v8kOjqZxkQ7wxTx?=
 =?us-ascii?Q?L866dLbMvwsVCOZM7jbokjbe5tezYefOgPWb2R8flgbQlkOHUVOTN1QijJwu?=
 =?us-ascii?Q?NnLQy2CH0pSAZC0c2CzujaRxMmpB4wpgeoQN9S+7/hs4jhUl1MVW4Z+dd2/s?=
 =?us-ascii?Q?r0N5ylGrKPDlx4EXgyOJIJ/vQIqayIxtFO14/p3bCk3VRHlFZyVv8HlR3OU9?=
 =?us-ascii?Q?Wvnh67ABWdGXwgz+GWSB+SX+jcy+dzwHdk5+cbdm7xEyVA5BNSWTzVZzM5Mf?=
 =?us-ascii?Q?qJMG1LDHEAeTvGPonfPMGCaPVMKDDIEwYYP+reGPAJlUUqIbI+RgSsC9ThhE?=
 =?us-ascii?Q?SPGZ2se+Tppd+TIFPbsM07frP9pYS/wc9uQ0otg35Ps3LiIQ0vsw3DAXLNOp?=
 =?us-ascii?Q?Eloz8rSYKpPgD6V1ZpwQHCmmXTGTyLxS5RJ3D+rKUIWdrUYr1AC3NCRKmkgg?=
 =?us-ascii?Q?NcfWBTgADAzwJOjLSKEfjghLwrpAPUKfx34YVGwmmGvsfYh7VMuMM7funDQF?=
 =?us-ascii?Q?kfIyd5cVle9B3yYDUhdTy03GRbzz/0TEKXTj2as9zFCpicQnP//BUiIGMG7B?=
 =?us-ascii?Q?Ey+57digK3S/b6J80fgQEL7ut0kQJHNIQ0E3F1H/pjP8O5VkKdaTqnh2IC2x?=
 =?us-ascii?Q?ZG0j01+vxR06hJ8gbD7OBF5ymjsivAs5onSYlMJNeOW/keyT/jROc4cZ5KxC?=
 =?us-ascii?Q?APb9C/bAau8EBm0LEpXXyEmiRrNPX8le5ApY82oXnF8HFbK5iLvAzLKlqswT?=
 =?us-ascii?Q?Vum7GF5VcRDwCcJ35Hn4UporSmNDDCPPnvUP5Mwypd9jX8WL729I0Tp9dLyB?=
 =?us-ascii?Q?mE5KZlOlnxAZyGCq1nIQxHKz9gNXknfUybKPwjene26vByDad21aS5zljVYO?=
 =?us-ascii?Q?D7XlyIW4X0xukpLaKRFzVtQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6972daca-cfdf-4800-9e0d-08dd1572737f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 21:19:06.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRhr+LwQS0Iy+to2rQiqy96jtxj2xtS+Qodqcf6gjinylo17LYblhV+Yv6VyblhXHoy75+TL/ErZ3K6Le27sYdDPuC7wEAGhSnXyXl6UUW+9LT93s87YL9KdtIK10uTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8004

ACPI specs(1) define Error Injection Actions in hex values.
This commit intends to update values from decimal to hex to be
consistent with ACPI specs. This commit and the following one are
not to be merged and will come form ACPICA project see pull request(2).

(1) https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html
(2) https://github.com/acpica/acpica/pull/977

Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
---
 include/acpi/actbl1.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 387fc821703a..c701c434976c 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -1024,18 +1024,18 @@ struct acpi_einj_entry {
 /* Values for Action field above */
 
 enum acpi_einj_actions {
-	ACPI_EINJ_BEGIN_OPERATION = 0,
-	ACPI_EINJ_GET_TRIGGER_TABLE = 1,
-	ACPI_EINJ_SET_ERROR_TYPE = 2,
-	ACPI_EINJ_GET_ERROR_TYPE = 3,
-	ACPI_EINJ_END_OPERATION = 4,
-	ACPI_EINJ_EXECUTE_OPERATION = 5,
-	ACPI_EINJ_CHECK_BUSY_STATUS = 6,
-	ACPI_EINJ_GET_COMMAND_STATUS = 7,
-	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS = 8,
-	ACPI_EINJ_GET_EXECUTE_TIMINGS = 9,
-	ACPI_EINJ_ACTION_RESERVED = 10,	/* 10 and greater are reserved */
-	ACPI_EINJ_TRIGGER_ERROR = 0xFF	/* Except for this value */
+	ACPI_EINJ_BEGIN_OPERATION =		0x0,
+	ACPI_EINJ_GET_TRIGGER_TABLE =		0x1,
+	ACPI_EINJ_SET_ERROR_TYPE =		0x2,
+	ACPI_EINJ_GET_ERROR_TYPE =		0x3,
+	ACPI_EINJ_END_OPERATION =		0x4,
+	ACPI_EINJ_EXECUTE_OPERATION =		0x5,
+	ACPI_EINJ_CHECK_BUSY_STATUS =		0x6,
+	ACPI_EINJ_GET_COMMAND_STATUS =		0x7,
+	ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS =	0x8,
+	ACPI_EINJ_GET_EXECUTE_TIMINGS =		0x9,
+	ACPI_EINJ_ACTION_RESERVED =		0xA,	/* 0xA and greater are reserved */
+	ACPI_EINJ_TRIGGER_ERROR =		0xFF	/* Except for this value */
 };
 
 /* Values for Instruction field above */
-- 
2.34.1


