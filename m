Return-Path: <linux-acpi+bounces-13101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E455A92D07
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Apr 2025 00:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804B217B3A3
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4603D2153D3;
	Thu, 17 Apr 2025 22:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="SnkKpUD3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU002.outbound.protection.outlook.com (mail-westusazon11023137.outbound.protection.outlook.com [52.101.44.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5462135CD;
	Thu, 17 Apr 2025 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.44.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744927238; cv=fail; b=M6mT/u9zRvt3FZusI+prD8Php/rCPyb4p951G2junw7b80QxFtQ/fDlR+HHQK7Z+AQQArJJOx3rHIjN5vuExIu5lKJiyZ4qo/Vdr7H4VzpaaKyWHuAXpg6+Ou8Nts0QlmC2LGn+yjelsv+nhaw/JYTmHsdN5wcQ725GAZgRbdaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744927238; c=relaxed/simple;
	bh=rLfjSCtgS+mI8IedzfcZcYNnB1saXqE72EPcM1SNaEI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrCioUSfcpVGqYnXqf7QHIki26Ui37WLXi4JilyjtNbxtTw4FDeBLSGxydd42tmV4p2JTiClgsYm1haZIigRAZxbvm2j6DL0tcD5g+QFQNU1xIWLuGixkwiUMdZpvUzI7YIXXMrQTvjmqYCAGfNiUcKyzmOYWFQbwC3dRNMaWcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=SnkKpUD3; arc=fail smtp.client-ip=52.101.44.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wzyd8KJooWJVYe+mFwwg9L9gAmMLSL58EXBOOE6FYhMVWrqzpN6ogUjjkFZ/ynYmpuw7MrRqhBWcOY5g+mT3J9F6L0/nnMh6jpY04+J9gmwUu9HdI6W6Z/gDw7B/IB/7WU7nEQpf8U33cR6h2+o9RZwBwUc4ZPUHXkMixtkAm7txg4xMS84rDPS0ydTRYIIh5jPme51prc5luUdeEAGw/DyKLBfmdtlLjl0Eho4xkOWFdkE7/qR23c5+anuXZJZFwAT7GE87sqbcsqEwLEDDKk/WuiRECnvwX4zvia5UiI2cjtXe3B5OryGpkI0I3LuDQQmEegZJ2mbPDQnzTcj6mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVYmWsKR+bi8SXlglxzrFGZ0xl76OQEVKxg9417i0RU=;
 b=afsnkDdog2Uhs7bnKn0YZI/hIe4aZkPC3f8KzLRX+I0sL/kd4JZOJeEL72lmkeVgrNLAH4h10Oq/ZQhw8R+8+1+LNEXFSi217Xp+Vd5jXBLVPQ6abr680hBuNtBEy9kTToofWSosSeLpVOeqWMLVLpkfgXRgu12oThFpQcxq5kPzxZi8gZcM5zm3ifw3jEn5Dvz483OkIO29mWw1hfZo9novJ4ePU1JO37N8J/ngffTfZ+921JZUdcsi1WaXZpb51qZOa/nxy9mcp6+XZfHRlSdgpNpMTX5N1cG0KOePSzkw2LZTWIbcPUda/cYJZ7DnF63JVObYcpvwUK2lGPSsOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVYmWsKR+bi8SXlglxzrFGZ0xl76OQEVKxg9417i0RU=;
 b=SnkKpUD3orFZkr3XVV5Fg8XSXwQpKLt3ofdqLbGuIxGYazDvS332pIRxABcV0qBvNMJVa/XTpV1ZjG/cUBHkHAU8lh6Uyq51bq6aSbZXTDwfciln6v22qtoF2liY9aTrab6f2Nj+Q3SEYhXZcGj/3wOBhP5UE0gLukvWZEw3qqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 LV2PR01MB7597.prod.exchangelabs.com (2603:10b6:408:17e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.36; Thu, 17 Apr 2025 22:00:33 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8655.025; Thu, 17 Apr 2025
 22:00:33 +0000
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
Subject: [PATCH v6 2/9] ACPICA: Add EINJv2 get error type action
Date: Thu, 17 Apr 2025 15:00:12 -0700
Message-ID: <20250417220019.27898-3-zaidal@os.amperecomputing.com>
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
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|LV2PR01MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e6d496-38db-42ca-98c2-08dd7dfb467b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0VPp7/hrMmgLy39osDfsAg887OcFYhNaCWEgsADKAOU2hzY0enO2agCHwFJl?=
 =?us-ascii?Q?/Bxk3o4JowbD4NhqgnXLimmWdHkWVmQ4oizH/4DKoAuHSINg5R8lRBkoc5up?=
 =?us-ascii?Q?m/bd4gQbXsGD0rXoWP6MAAU7NiOwb3mL1ahCN+0YWQ9Vj5ANc6coyLHFWoBo?=
 =?us-ascii?Q?7x/qljQ7JxqiXx48iA7IT7h6HdcZ8b+fEZD+3O6ZCLgzEcZmBoGTop4I+lxP?=
 =?us-ascii?Q?kXVaryZJ9O77N/cr5tQy0l+XVe6W+jzOtGVSNHuChJnWRg7XH4mLmH69T5LG?=
 =?us-ascii?Q?Jm8AaXL0hd+kv0V0xK+VAIwkR2EZ3Gq9baPziCYg8acXN/s1w5+zYyxTlCLb?=
 =?us-ascii?Q?7y0uOAmdRQwG2crglsw7TWD0QAKtfvH1ia1PtSoob7P+TcetyCXM2C5YB3Yg?=
 =?us-ascii?Q?7TacBNiNWzjuvcnVVYcrlpmFs6GnKGvHfribzxLFvV4AHTz5cegH5rYtHHfr?=
 =?us-ascii?Q?DxIU2egT01o0nJjOgdlgFYEra5CtDXR7vdwAD8yjoF3JmEaUpJQLLjP0JYCx?=
 =?us-ascii?Q?5rDYgAo+kpyoevc3/nyyZ7ATjkYQ2XrIAIezy1+eVEIhTKMaoxSLUKH6EqRR?=
 =?us-ascii?Q?Z8ZOHEM5n9Qa32+ol76oDCQn6ylaoPPJWd7k90dIYTlEWNyQabIlfvqqy06o?=
 =?us-ascii?Q?sv6hek2+vbg7TZfaR9LwqBYAPkRhAzZkPIeokIeN/wLB06weEy2UQ6GA+AWO?=
 =?us-ascii?Q?jNtiH5HkDD0CmItAUZ5AFhazKUSGdyseIyKonvUOEXWHiB85rE4qLsUrtPLD?=
 =?us-ascii?Q?YnFmW5ts0ADsjNbh53JFYMbctkZ0e6uhR6bougWYaly8v8t5/4YQ2tlZB7df?=
 =?us-ascii?Q?XwNbAlXakIRyweV3l0uuKP0ujEG/vHgXNUIakRJabuqbeHGU9Tdf5m/qrjVr?=
 =?us-ascii?Q?Rej2gr0lq+TCvTpie6dvSSRlOHLKouuNlCwS1UAyZCkAl61mvVpmG/qAo1Ik?=
 =?us-ascii?Q?nGKyRawr48xFwbB7FtVlR7CzLbTxM47c+fLP00otTissixTf5Uy2bQJA3PZK?=
 =?us-ascii?Q?t1upy3lVcDXbdALaiREBUifo4kzFvFg1zrVFoMoslnWk2KPct8LlgwrmXS4L?=
 =?us-ascii?Q?RYK6QvXvEzJ55SNRtRvkQhzjwPx8rUdTlveCczsYS/qk966Bk4cAM/tDWFhg?=
 =?us-ascii?Q?S4Sp0hY0krCx4elHCJOJEHa0TxURtIaGn/perwYu/LDrvxxvxtRSnA6R3dhp?=
 =?us-ascii?Q?EpTuXwUMN6RRaaWijCeyNTPf0pv7XEl5cg/IyxfQLD5g26egVs78cCdSvXa6?=
 =?us-ascii?Q?ChzDVX1E5fzQ3VeFkVa37AgfrPI3KRs9iau19ISgd6mQmAo7o+HorS4GgApJ?=
 =?us-ascii?Q?F5ZAfDE0idnouCVExrDMCjaiuaJnh32EMrAuP2qe8p5bO4LmnT3LJ+Zsj9o2?=
 =?us-ascii?Q?aLQZVXQROSVdbhkqNvhAK9x3FQzK6ddV93lKb43/MPM8Lxj+ClyscOWsvf5d?=
 =?us-ascii?Q?Kkcuu0Xgadukx0voPhwjxCoJXQq6zPAcHSdAVFT5EqOqdozn3HNCtx2vq3XB?=
 =?us-ascii?Q?gSgf8UHF4oRDcy9iLhGof7AWom5kSN8QnDdt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+tXnJMrujSvsNzNTFRmRnNvSr2j8wHUc3Ne6M3XFMP/jPf3M5yRVbIrBwS7?=
 =?us-ascii?Q?umsA1u1lKUx209rLFD8Dz513PF62qP9K7qcZFiZX8ctBMQljgsd+37ZrdCkx?=
 =?us-ascii?Q?EAGycCmLHzfdsZYzRWm0Bi9sS3J1IbfZ8uvsYkTdG8wbHE/7rfsQL96UdlDn?=
 =?us-ascii?Q?LxHizBH9Ea695gw2U5y/32H+bBExV0daco8Ew1OrOnlg+7aiygYurgSkv51K?=
 =?us-ascii?Q?dsj3jdDZx1eje971HBsKtwkxh6DNJ3buaOsm10f1mQSjqKDGoJxcplK1teC+?=
 =?us-ascii?Q?BbFLhfy/srYivSw+hvfNTE7zGaIRzS0/e/dOtJffYTuYMeQ//8/cD26bttjv?=
 =?us-ascii?Q?vhqteag0mKWS+6fz8ZtyZU2HI9hCqtHj7aDEB/bmRq5hX+zuFAkWV9Y2fM5O?=
 =?us-ascii?Q?dOL3cuG0Tb091cfkzs89G0lP2/Fw5q5ybR5JKHvkI+tLKEeAUH7SnTSVus9b?=
 =?us-ascii?Q?h32XwdRyO8mjTQ8Cb+9vBf0T0d97rtoyLrk0fqCc9Kl8FGeLSdB+7Ix/fZuv?=
 =?us-ascii?Q?+QEuvYsMKJ/dgHaxvEiyXHVIc4X9ocFdYHmbRV6+xoecfBrQ/48V4nRxcuUm?=
 =?us-ascii?Q?XDuOGj2ZHeJY17EIuU6YatyzjvkPI0F3wQWX8IE6QgeYYV/PzZtx7Og8d0ex?=
 =?us-ascii?Q?ZY934k3Kpk3JQ0+zhNUQzJKfoWWHUi6fBGyGaB9yN8RIb31LiI99g4vjpb03?=
 =?us-ascii?Q?kCYCIYXTgBDQTYEU5U0u0Jmvuxrs4KiKfr2/L2VH+yj3xMDkNO4eBu4puhJ3?=
 =?us-ascii?Q?rZ6COz2HYxTXBTmXXNO3PZ09pR0G+sDMLrHEEH7sSCZCUAFlumRcRv7z6HvK?=
 =?us-ascii?Q?qohKqzbZAZUTnqG/EAipybkoGmOoaFfQLTmaJ8qquMB3IiRU5FvpmyR7J5Tq?=
 =?us-ascii?Q?gi3L+ER54kZs707rNXuNk2qNCHYs2h9Z1S6rkM0ERWln7vK+nLQz0azuL9Pd?=
 =?us-ascii?Q?i4i/pQE3S4z3MC6w1JxJzzsEdqJBoykQ7QR0dVHinOamHvbYxzOGMLUAHu/1?=
 =?us-ascii?Q?OMkkXP0W/5mNJreDQf2HyFM6bfg5QzCwN8AFH/5qjj9WHOzLJpUKN7a+DGbO?=
 =?us-ascii?Q?wd1On1HknUNrA9AYp8yNdxS1sJlL8EZjJ+VzFvl8qSdgKnR/IPpU/vKRdLEF?=
 =?us-ascii?Q?22KTlOOhoXh6LVQKF3QXvbuVCPHVEtWv+EFH7jhGtxQhiH4H2MPy+dbmat33?=
 =?us-ascii?Q?fWIsYB1lvhUNh0bTjm+8boM8O4fDhPw+jzD5U1Hn2cQPnNa2bX8FzMhD4W8d?=
 =?us-ascii?Q?hYuVrcwKN0T1koTpW/Res6S/GjF0Z9pK6szsOr+1rBhGSBODvzG6WafNlJW0?=
 =?us-ascii?Q?eCldCytGz94MhiYVEiblIbq61vnFzyb5a72sxckBKd3gWXzw6rCPa3cuV5Qz?=
 =?us-ascii?Q?hrej1isOY7UjThhpsgEF5GpyQPcenBrC61aPllG3fiZ4+MhIb7B4iDjEI362?=
 =?us-ascii?Q?RIrxEpmES1AGWK6yCBZ2FlbY7EHnrI8hE1g06y7Tv/1qnncruRXULlVtNdU8?=
 =?us-ascii?Q?f0ntu2kyfAQPvN6D7V9K0P4brz+p1ybc0Xu+oHwklLZbQ1HA+oFyUwFfJhtW?=
 =?us-ascii?Q?T8/F22fm1EMunxaXmFJNFUoxArKHzVpzREMXd5MNgd87G9kJgUb+dYKovfUP?=
 =?us-ascii?Q?vEmllMKTIB068M64Bin07O8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e6d496-38db-42ca-98c2-08dd7dfb467b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 22:00:33.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UhNF8q245kJHFRBAMZcVj07VHlvXyLRkhImpVpg+AKYUIiueuR8zdz4HhmfMUblELtKhF0JEHo5QMXruJY76zyxMIWc1/Ax3ZFL6Oo6OH05wvho4AP8V7dQvEkhGZhC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7597

Add EINJV2_GET_ERROR_TYPE as defined in the approved new ACPI
specs[1][2].

Proposed ACPI spces for EINJv2:
Link: https://github.com/tianocore/edk2/issues/9449 [1]
Link: https://github.com/tianocore/edk2/issues/9017 [2]

This commit is not a direct merge, it will come from ACPICA
project, see pull request[3].

Link: https://github.com/acpica/acpica/pull/977 [3]

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


