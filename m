Return-Path: <linux-acpi+bounces-21078-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8M0sH2KpnGklJwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21078-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:24:18 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA96117C52A
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 20:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27FDF3102C1B
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B8036D501;
	Mon, 23 Feb 2026 19:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aX2bm0sw";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aX2bm0sw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011056.outbound.protection.outlook.com [40.107.130.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0136AB47;
	Mon, 23 Feb 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873914; cv=fail; b=GFD23qW+AUGo7Cvi6srAyVrAnpBr0HrAbBL1E8PfK2zJPJ9oN11S8xh6Ckuo6kFmh+JzKhQHMAOD6g+PA7pIv00seFlj4gD/ajAq5F7DhytwZmkk5zy29sr+rGc1/1PK4g+ra8BKHF+DAa4JkI0MlWLafnwmIli6SW0P+mdohRM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873914; c=relaxed/simple;
	bh=T61qiH7rUIiUzIEMxTaEX4BeBgvvtqULBaV6ZpSqZXY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B6YgwyLOLHtK020XavLsvuj8gDROI+iwLBco7PJspxrRJONOYKxGrAXNZSoGbwojPHm9VJVdY33FUTt1Nfmoi/tNEx0c94woWMy9wGPBimmQcC90inSgRIkvUOJdcSKuK+WyVS+eFU/YYrkEaoHGWE4z3oEvrX053zY+syHMWbo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aX2bm0sw; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aX2bm0sw; arc=fail smtp.client-ip=40.107.130.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=d7ua+vtfGJVHeVHyl1TdbKA2Qgrp6yVGFoB2nLHGjcKp9usLPmTIJ5Hc869rQ2gKs0APkjRmFbiYrw7ir/dRfgcPzB7LLO9H24+LuQXZEM8LucwwbCRsL44y2tke/SjcgVst3yAidL51melv8MqB1VUHjSJTYsLfGOSFsask8SjNUgx07EpurXwEFJH/QyI6fPSUrpzbW6i9R0Pr5SYrDqcuYvSJbgIMmnrC/iEAhsMvH72A4bRFPUMGWOttvC1CuKptPe5XIW0QfHstpewr9FZzwq/2thLDkypMxnX8+t/8TC7rlvDk26pYvrQQdaF32CStAdfh+m/GHImm03fauQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyRu18NGEPp+KLyNi3dZJ0WzqOijpAK7ytIFLhlIeeM=;
 b=hqQDbiGFI67wb4Lh6NRUQKORp8dfpEWSOcZddK0a6q/Sqtc3y4naoF2w+6nyZ9qAiMZ1yiFojIpQJvyRhLInNUjZRyXrJp/7VEJdlMwqqZmajU+yEXW2xrimdbfHpR5UeP1Ln0suiV1AZKMur6hxAVGBQLT/Q0L//hotolOUXEo60pCS4/s3WwBAyAalbDAwkYdIV38JedKEWZpWK0y1L475vPYRIBq3n9nyEKqTZpYy51WoTlHhvP5DyFRQCxXTB67uPRllzPgkG0L6hgmBLR0EJ7udVNz8uOIa9+gZ1VWHoGfv0/Pt6sbaLYqopnU9u2/Q0rRrQ1AgJJflF6PpPw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyRu18NGEPp+KLyNi3dZJ0WzqOijpAK7ytIFLhlIeeM=;
 b=aX2bm0swMyjGvwJZEVIr0OL5kXDkevgdK4zG8DXoDpxklyKtPlyBtvDRsjEYZauWr1avDJYCyUebsN59HPXM1jiH/ZwSBgzIP3BR6qtxTcw9u7tdq+NqwA1/NXLLsp5mqlJjE7W1armV5WCRfL6DDIygaVsYCcIyLCuJKzfSH1g=
Received: from DU2PR04CA0190.eurprd04.prod.outlook.com (2603:10a6:10:28d::15)
 by DB4PR08MB8103.eurprd08.prod.outlook.com (2603:10a6:10:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:11:43 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:28d:cafe::3f) by DU2PR04CA0190.outlook.office365.com
 (2603:10a6:10:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Mon,
 23 Feb 2026 19:11:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Mon, 23 Feb 2026 19:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FMpn+iTyEIKxBLxQKCN3/narAG31+MiDPZYyybwLjiyvKRclPK3E56TF5O0XuFlpZgcYAXO9KuKFATcAykRkmybrrt6J04P9cfKcU0J8ZqM8cmf4txy6OcuWY+Yh4l/Q8CEl3gOuVz015VhpOZUBaUfOh2SR5ifBfQEjomay/thkqtzQRY9N3vd+2c6H/Xlv8oblveqTt8Tt4k4f/6SRIsyPHN7m2f2mZnaRunyfI6IyQGqSYplyQDjzxmiuLTI7ggrDdjW4MMsMIA0aHmAvKiPGluJxu2pyV+WKXZ396lIkmre1ZkH7niazhsIsnrE3MII5BhklY8KkwU2ZMjkkug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyRu18NGEPp+KLyNi3dZJ0WzqOijpAK7ytIFLhlIeeM=;
 b=d1ZzhyBlom8pmJx+agiWE6FPJi/5TrO5L+4vYkBxXERBYnnIpKkGd7KGVtnp891u2BKuGysrV8WwZWppM1u6lt9/NAnBIGgqS+K37paDAYEF6xwC5c/T6c1eKt2lKA6szLtEzU3ZCOCj+/2rWQql8k/PVAL6AIj8eP3zvxMoDy2Wp86YiOXlQnsR3vE5IbBMWB0Ijk+jL1LJ9BzedGyH9YyGuqN0+rmvBg7vttWiPlJVOGf2o7SfrPBd5cjdDzRij4Aw28P5DZCjeYN2osuwKse2yGcVKrlN5DO6C+V8tHwxtxMuC7efDLJhmTs5DHCyvmT4o2u+0Q+wk4VvZlSipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyRu18NGEPp+KLyNi3dZJ0WzqOijpAK7ytIFLhlIeeM=;
 b=aX2bm0swMyjGvwJZEVIr0OL5kXDkevgdK4zG8DXoDpxklyKtPlyBtvDRsjEYZauWr1avDJYCyUebsN59HPXM1jiH/ZwSBgzIP3BR6qtxTcw9u7tdq+NqwA1/NXLLsp5mqlJjE7W1armV5WCRfL6DDIygaVsYCcIyLCuJKzfSH1g=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DBBPR08MB4903.eurprd08.prod.outlook.com (2603:10a6:10:df::17)
 by VI0PR08MB10619.eurprd08.prod.outlook.com (2603:10a6:800:20d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:10:40 +0000
Received: from DBBPR08MB4903.eurprd08.prod.outlook.com
 ([fe80::7aa:aaf5:5f11:4744]) by DBBPR08MB4903.eurprd08.prod.outlook.com
 ([fe80::7aa:aaf5:5f11:4744%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:10:39 +0000
Message-ID: <c3dff3dd-3e09-44e2-a394-0d174b407a67@arm.com>
Date: Mon, 23 Feb 2026 19:10:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] RAS: add DeviceTree firmware-first CPER provider
To: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: Dmitry.Lamerov@arm.com, catalin.marinas@arm.com, bp@alien8.de,
 robh@kernel.org, rafael@kernel.org, will@kernel.org, conor@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 krzk+dt@kernel.org, Michael.Zhao2@arm.com, tony.luck@intel.com
References: <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-0-347fa2d7351b@arm.com>
 <20260220-topics-ahmtib01-ras_ffh_arm_internal_review-v2-11-347fa2d7351b@arm.com>
 <571e56ba-83c0-4d0a-8893-5a86789c22bb@kernel.org>
Content-Language: en-GB
From: Ahmed Tiba <ahmed.tiba@arm.com>
In-Reply-To: <571e56ba-83c0-4d0a-8893-5a86789c22bb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0517.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::20) To DBBPR08MB4903.eurprd08.prod.outlook.com
 (2603:10a6:10:df::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DBBPR08MB4903:EE_|VI0PR08MB10619:EE_|DU2PEPF00028CFC:EE_|DB4PR08MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 2545ee5b-8e7a-421b-b7f7-08de730f614b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Z3BUUG1oTXRDck1EVlY4UWVqRW1zTm0vemovZStjaWhEQXhVSGpNWEZNVHNz?=
 =?utf-8?B?OVE1bGZES3EvV3J5UzhTUnJvTFVpNGR0NGxEVzdHNmRzRElMeVJGd3RxQzlL?=
 =?utf-8?B?VTFOQjlIWUY2NE1QZmFPVlg2dFdSNFgvNHhOc0s0NlVNVFhvWUVRUFJJYkh6?=
 =?utf-8?B?WUZPQlRkRkFuZDQ5V0FIMW93dVMrc015Y2R3TEVvTVpPTzFoZG80cWtHZG96?=
 =?utf-8?B?U1Y4S0xUSnVzWkFaNHRFQUVSd2Y0b3k2Qm1IdmN3L1RQVU50a1lEZ2pyWUZB?=
 =?utf-8?B?dTB3Z1lxK0hGS2l5cGtVVHRITjRRNi9kWHB1SWV3VXV4eFMyc2NCMTQ4cTNk?=
 =?utf-8?B?U0ZxUEpEY1Y0aFZhNlRETmZmU2NOZjFYckc5bjhGQUNqNkJBdmg2bVA1aWc5?=
 =?utf-8?B?ZWt6OW51R1lUMEt0SGJuSzhBSHpvT09aQjFLQ2JXaGRHWnhUV0Z5UXlVUldL?=
 =?utf-8?B?bXNuSTA0WDFXOCtkQ2NJb1NJeStiNXEzQTA4V1FrZWVwbTlaT1U3dFVKMndD?=
 =?utf-8?B?Y29jTEZhUUlROExCUll3Z3JlejAvakQwZ0JVNmtsNVRoNTZkOGFUTFlrWUxL?=
 =?utf-8?B?TTcreGw3Y0c1dGhUOG1NUkQwa09rWFRLdDdzVUd1M3FLMWtzVUx3bGdqUk9D?=
 =?utf-8?B?SkYzMmJIMXNsZHJUTElJd0Z0dTFpSldHRmc1WWZRQ2FrUVFLTldZbjg0OUdx?=
 =?utf-8?B?WW5ROHZCUk0yV2IwZG1FYUNYVTY0NUpibk81NnpQK3oybmM2QTFtd3hNOHk5?=
 =?utf-8?B?WVQ5cVlrR09ZRkdLVjhVaDNqZmMwYTJiM2FSaVFxNFh5V0xQVUljdEhzUXpl?=
 =?utf-8?B?aXoyODRoNC8wbWtQTi9BaDZsbGd0bEFTTU9hQ2JMR3VvUXc1bHN2bU90VmRo?=
 =?utf-8?B?NEFiZjFvQXVyWThKdndYdGVDSkZrdC84VmJLRk8xckZUQVlqVW4vRTZZbkFn?=
 =?utf-8?B?bnJuMHNWdXZKM3VmY0VqZTNNdW0vcEFxaWplamM3WitOcmhNdCs3SkQwdHBB?=
 =?utf-8?B?TWdLQ1JqSW1Td1dLSTdwbGc1RVZ6SnJDVXdzSXNvRFg1YUQxYjB2OTJnSjRy?=
 =?utf-8?B?T2pJb0g3bGJlcWgrUDd6VDBxRm1STEoreFRZTndrcm0zZ2lURXFQUWZIbzhs?=
 =?utf-8?B?Nmowb085dkdQeEpqMjU0VHBmQnVYSmhIYWJYelpCZkY1amhHTkRUaTlLODEx?=
 =?utf-8?B?L1RGcUpKVHdOb3lsa1NkT2E1eU9ZZUdNVEE4NkhtV003NFNvSjRLUlRjSkVH?=
 =?utf-8?B?c05WeG1DNnp5MGs3a2QxWms4Tkh6NFhGWjVBNDJiUjh1ZERhM1hBMjR1cHdH?=
 =?utf-8?B?cmdQemxMWGVjMUhzbEJSdnJDU24yZ3dwMno4QW8wanpybFFWY0xTZys0Y01x?=
 =?utf-8?B?OExDSUoxRlYrc3ZBY2VaNGxnNWlmcWVYU1h3R1N2ZXp4NWozelM5WUoycWsr?=
 =?utf-8?B?L2NteVlUc2JPaTdDNzRHblFOK3poaXpKSGhhZFhNYlNOcHUxajhhM1Y5NXRw?=
 =?utf-8?B?ODMzSERFOUFKZmoyREZvaGlTTkkva2d0Z0FhWEV1RW4zUDZXZmJ3UDU3UjFJ?=
 =?utf-8?B?TVFJRzVYbTk2Qm1tM2xNRVQ5bUJyVWNCNWIwRHlEcjVmRDcxKzB4MnIxUUMv?=
 =?utf-8?B?MHRuWVkzS2o3azNZS3hFakZkazRWYTlkZStWTGNSMnJvWmpReTRWeEN1SmRa?=
 =?utf-8?B?Q0ZZSm9HYmVtdnNNT0V5Y1pQdDE3Z3F6a0kyTis0ZjFFVmIwejR0ODRSODRZ?=
 =?utf-8?B?bjFuQlJLUnF2eUVxWEVhTnNxMTdBbHM5Z2dNd3FIYjNYT2ViWk5DNHhuVzg5?=
 =?utf-8?B?aUpmcTdKdzJ5MEUvK0R5SmswNUZmbUhJVFpvSWQ5YzF3ZXVwZXd6elNEMWQw?=
 =?utf-8?B?b1h4NE9HaExYN2wzMlRpdEp0VmdmQkhLamJUNDQ5a3IrU1ZKMFhzS0JRVlhj?=
 =?utf-8?B?bklEWXN5WnVkUW1nZmFYZDNlZ0sraFVMaEcwbnZGVnZjZmxvTi9vTmk3bVZi?=
 =?utf-8?B?U0oxVGdvR3JueEFhSW1PR2VFNVlMVG9WMEJ5a3I2VE0zbWFSYTVRZDNQTTUx?=
 =?utf-8?Q?4fkpud?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR08MB4903.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10619
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3ded1fbf-ccea-486b-da16-08de730f3b6f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|376014|82310400026|7416014|36860700013|30052699003|35042699022|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHhiOEtpRjhDdXR2MEE5YVF0cFN5MEVmdHpqdmluSHA4VFZCOVBuaGxHM3hY?=
 =?utf-8?B?V3Q0NURJOVVuVGRyY2ZiMW5MT3hwQnpSSXpBSGtVZjd2VWxuNkhqKy9wUGFR?=
 =?utf-8?B?OWRweUYvbnd3TnFTc25PS0kzL2dCaTUrRWhHZUZPQ1hLZHl2NE8rdkN2WFBU?=
 =?utf-8?B?SUlQUlNYMm9zQkVBUmhNY3lWd014MXloYVVTYnZicEVGanZ2WldncGY4aGt2?=
 =?utf-8?B?YzhkbmM1WWYvalVIQ2pUTTNWVmhpZ0E0ejhRYXRpcGdYTFpwckdROHgzQXVi?=
 =?utf-8?B?enZUSGR6WHVSaytaR0grdGoyMVI3d0wxK05OTndXNmpYdThkay96cG55VjlK?=
 =?utf-8?B?TGJPSjRSYXRYWFVtSGNFWUdKYjBZWml5WE5oMXFvVDV5bnUvWVIwZ2xEdmY0?=
 =?utf-8?B?ZmxlNXFwN1dMeisreldlS1ZXSjVNNzd4NGpqZFl5OEZtSUtNOHpHNnM5aExC?=
 =?utf-8?B?YUFHazY2bGs4ZmVlQXZZNUhNanZhZk45OGtkdXlWdkt4ZGd4V1h2OFVDR2kx?=
 =?utf-8?B?aFNpL09qOXVJYktZbGdSYStVYTRZMDJMUmlEb21MeTVEVU42cnZxdVZFbkVz?=
 =?utf-8?B?dWo4eXJETzQ0c1Rkd216RXB3a2k2NzBobWIxRnBVNnpxd1JnMVdXZHNEVnRN?=
 =?utf-8?B?MTZ0OGhQbTFyUVh0bHFpQ3g5ZGRyWUYzYWd6MkE4VGNhS0JNc2hiTDVWZFZy?=
 =?utf-8?B?bERoRkdicTQwMFA2cTduSXpLNHFPOGhQMGtsUUlmSTZKc0RyYXlLVG1nRktS?=
 =?utf-8?B?b0pRc3FOd0ZCbDNIVXNaQmM3b2tvdUovSFFRTXFnMk9XSVBwTUI3SHlITVk3?=
 =?utf-8?B?WTIzZTJkYzF2NW5UZ3pURXZoaWQ2a3JML3JVK01ZRjdRbWJBUUZTdjZUNTUy?=
 =?utf-8?B?ZmNTcnJGRmRTdjVNa0hDSDIzYUpFeXcwYThrbjRlV0RqTVlidGdjNXA2eGdN?=
 =?utf-8?B?amVzSXkxaUFQVGIwTjdkTXI0ZElGRmV0T0x1dHhtVkZGQWtvS1JSbm1KNENa?=
 =?utf-8?B?RFYybkJYVWRiUHFLa2Q2OWFKd2p1Uy9xcktEaTVDNk1Uck54d1RMUHR0eGY1?=
 =?utf-8?B?OVQ4a3RsSG5obHVQTlQzYkU5OEVacCtKZEVjekwvWjBiNW5FYmUrWlpNSXo2?=
 =?utf-8?B?SEsxT3BJVFhHN25oSk9YeDlzYlFxT2h1TzlkcWY2TzQrOWtZSnhtZVVXamJ3?=
 =?utf-8?B?TUg1NmFOSXdDbUNYWlpOdVpjdDVOcVdobG41bFBZb0t1bGl0OVJqNVM4RkFH?=
 =?utf-8?B?ZHdZdUhIUWM2R0FNU0lhbHEwNU9VNE1pcFlCUVowdFZvR09ZZ1JoSktpT3NQ?=
 =?utf-8?B?MVVHY3RuS2U4aCs0YlFKYVBRZWV4SXhKaWJTVGZkSEJwR2NjTXZ3L3hVRXY3?=
 =?utf-8?B?bTl0d3Y4OENMTUxmd0pnSTZCaG1MUnYrSCt1anljODR4SllBODF1WjRlS3lM?=
 =?utf-8?B?L3I5UFNBMTdhUDRKZXo0VURpUENzQmVsNnZtMHJVUWRYU25lUFp4MkZwVWxF?=
 =?utf-8?B?dzVRbTJwdS9WTTRnYktXVElFUG5KY0x3VVY2QWp0Zk02RkxjTnhycjFrYlBx?=
 =?utf-8?B?Vk1PcGJGYkdBK2JaeDlDWEhHMjVCb2grbm9jY2lLSmRUV0tmWnV5dW95S01X?=
 =?utf-8?B?NDY3ZlB1U2N6aE5nNkw4aHZUdjdrbTgwUk91aFpRQXlUYS9jTTNTVkw4SGky?=
 =?utf-8?B?c25rcUw5b0MzOWJnbm4zdXcza3pkZzkvNUs4bk4zWFNsWkFjS2c4eGUyQ0k5?=
 =?utf-8?B?aXpWY2o2S3BhSGV1eEs2eW1RdjFlL3E0Q2xZOFNNWGpNMkRBUFBLWlZoV29C?=
 =?utf-8?B?UmtZNk9CMFlQVjVXVUJNWWVOV0ZXYWVNdjNpV0dEWXFSNmFuTlpwZFJpWDFr?=
 =?utf-8?B?RjRxTkNkQnNxTm1zak0xNjVldG9HTFBMd0paSFZQNm92ME5rZDcybHVNeU9Y?=
 =?utf-8?B?TTJaZ2Z0cStsT1JpYlFaMERwaC9ObnQ1YjdyaG10MEJuaEhIVlB5bmplWk91?=
 =?utf-8?B?TUFYWnFPemxZczkxZlRwTE5lMGoyQmdnQjNTbElqeTBzeUhFL2FTNDJFdWhF?=
 =?utf-8?B?Wll1cXczbWk5Nmd4ZUpzd2QzZm5SRHNIZlBnSWV4WlhvTTg0SFBBS2ZWRnRH?=
 =?utf-8?B?YW15bndCMmFsSmsvNWYzQ2RaS1Q5ay9BeGdWWElFeVdEVVlGNlJzNXdWa0Fl?=
 =?utf-8?Q?2he9eTDrhfdodrsKkXajtss=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(376014)(82310400026)(7416014)(36860700013)(30052699003)(35042699022)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CzMMJRRtew1Zz2CLAMa2RJv70fDL7Yfx7VWi/9u1MLpMsVnvJcuJaFM+sDjF4YnssBQPJmgHMJbDaVj+2S4Y+pDzOeQUF6oqLGHUyVBtxkuW9v6fXfDDr3iKu7eStvayKtYDaAqLX2V/lYdOuB+jywVbJmxiNJmZvR8fwNVxzupyQhPdG6/z3CtZyIA+nNQR0Rr1QC9/W097ghMKoaOs5Kq9ndjs9g46IAKjdlbw7VErdKOuEtE7uz/LgLmqTBHCzlaSOqi/30uscfDDPwIVAAkU7cyGrrNQL0jzLuGa3oIDS+zo7CX8VQIh0puXh5krfud5HKnGcTrT/AdQsV9FOaOvu7TH61ln+FU1AX0hXil7fA62AFHWn+lascDVkkos0kmZIkJxfP2FgFzBTXTpW4Vard9vflNC6/G9hlyZ650mA2mJ4TvOPZ+C5KqRqchk
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:11:42.6215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2545ee5b-8e7a-421b-b7f7-08de730f614b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR08MB8103
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-21078-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:mid,arm.com:dkim,arm.com:email,bootlin.com:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahmed.tiba@arm.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-acpi,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: EA96117C52A
X-Rspamd-Action: no action

On 21/02/2026 09:06, Krzysztof Kozlowski wrote:
> On 20/02/2026 14:42, Ahmed Tiba wrote:
>> +	rc = ghes_ffh_init_ack(pdev, ctx);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = ghes_ffh_init_pool();
>> +	if (rc)
>> +		return rc;
>> +
>> +	ctx->estatus = devm_kzalloc(&pdev->dev, ctx->status_len, GFP_KERNEL);
>> +	if (!ctx->estatus)
>> +		return -ENOMEM;
>> +
>> +	ctx->generic = devm_kzalloc(&pdev->dev, sizeof(*ctx->generic), GFP_KERNEL);
>> +	if (!ctx->generic)
>> +		return -ENOMEM;
>> +
>> +	ctx->generic->header.type = ACPI_HEST_TYPE_GENERIC_ERROR;
>> +	ctx->generic->header.source_id =
>> +		atomic_inc_return(&ghes_ffh_source_ids);
>> +	ctx->generic->notify.type = ctx->sync ?
>> +		ACPI_HEST_NOTIFY_SEA : ACPI_HEST_NOTIFY_EXTERNAL;
>> +	ctx->generic->error_block_length = ctx->status_len;
>> +
>> +	ctx->irq = platform_get_irq_optional(pdev, 0);
> 
> Please read the kerneldoc - wrong check in if.

Got it. I’ll follow the kerneldoc: use `if (irq < 0) return irq;`.

>> +	if (ctx->irq <= 0) {
>> +		if (ctx->irq == -EPROBE_DEFER)
>> +			return ctx->irq;
>> +		dev_err(&pdev->dev, "interrupt is required (%d)\n", ctx->irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	rc = devm_request_threaded_irq(&pdev->dev, ctx->irq,
>> +				       NULL, ghes_ffh_irq,
>> +				       IRQF_ONESHOT,
>> +				       dev_name(&pdev->dev), ctx);
>> +	if (rc)
>> +		return rc;
>> +
>> +	platform_set_drvdata(pdev, ctx);
>> +	dev_info(&pdev->dev, "Firmware-first CPER status provider (interrupt)\n");
> 
> This does not look like useful printk message. Drivers should be silent
> on success:
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/coding-style.rst#L913
> https://elixir.bootlin.com/linux/v6.15-rc7/source/Documentation/process/debugging/driver_development_debugging_guide.rst#L79

I will drop it.

> 
>> +	return 0;
>> +}
>> +
>> +static void ghes_ffh_remove(struct platform_device *pdev)
>> +{
>> +}
>> +
>> +static const struct of_device_id ghes_ffh_of_match[] = {
>> +	{ .compatible = "arm,ras-ffh" },
>> +	{ /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, ghes_ffh_of_match);
>> +
>> +static struct platform_driver ghes_ffh_driver = {
>> +	.driver = {
>> +		.name = "esource-dt",
>> +		.of_match_table = ghes_ffh_of_match,
>> +	},
>> +	.probe = ghes_ffh_probe,
>> +	.remove = ghes_ffh_remove,
>> +};
>> +
>> +module_platform_driver(ghes_ffh_driver);
>> +
>> +MODULE_AUTHOR("Ahmed Tiba <ahmed.tiba@arm.com>");
>> +MODULE_DESCRIPTION("Firmware-first CPER provider for DeviceTree platforms");
>> +MODULE_LICENSE("GPL");

Best regards,
Tiba


