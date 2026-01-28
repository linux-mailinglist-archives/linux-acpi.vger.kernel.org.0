Return-Path: <linux-acpi+bounces-20708-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DfdNAMDemku1gEAu9opvQ
	(envelope-from <linux-acpi+bounces-20708-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 13:37:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D13A1558
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5528302D13F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 12:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F50234EF17;
	Wed, 28 Jan 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jLK+UFya"
X-Original-To: linux-acpi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349934F465;
	Wed, 28 Jan 2026 12:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769603559; cv=fail; b=aT+3I+zmzRhAbyv91wdztXRgo61h3DFJHTVK6vPf64D/BIT1qAJM7qztS1bKw2dfEMTTJhO+i5uHy7iRP4Pe1QOXRfoNzvISq11S9OG3q07YWJcCSEbKck+YrYDG+K7UfpxByIIekh3zfnOu65b+z03yIjX/exeBfp7TV8aLhHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769603559; c=relaxed/simple;
	bh=wzUsMRZTj0n3i7QtosKTIBY6GrfIyqmorPXEevnOPvI=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=JkHBzKKUwdrf4JvOiK/9fi7BFfuprGAc/VcbwaYs/afDdQ/Q4DeIS+6MU0I+S/gKjHJTHccyXxpVR1cadS/jg8ATgAKIslv0KEvS9YMu4E+dH8iKWdeesTjLguL6oUbHCJ0W7GA92BVvjiyKxofv6kiutExpZ308rFeuETh/EOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=jLK+UFya; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m194q2oshMsRGlQKshSXd43+ORr4G87vQrwaUxPxNxM17/k1agxG53xy5JxJZDZ6hIlluYoYqoVIOvo2coW8XCkBqZqUAcZKuogyPVM8gyVFdWQo6d9Ub5CEXg0p4s+q1h1oXsM/ts8damlU4hcuKivR0q60PnA4mRaT2AjaC5R0wZQwnXCEwVoJuHCEQzb3nsdvoJOU8NMyLii7ix++J/Je1/10cl7t1ublBjBa3iRftjDmB9HD6x2oimsj3bPd0pO8nM8+67Lhr2meLNW/AodfmZWzfeNX4a0FJPwPNg91UpdJ8DoT+iEjAIGJTCd3o7N7S5MDa4JLDdRjFC/C/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QRNqUMrl8UT9VWd9dw1wzZwdgfB6mngQpudSKYHUj7o=;
 b=h9kbvUDKuIdypN1EWYLgLcc4TrgHbZ6sbKZVoWLs/4eU/xUPkJayiSF3RuoeAG+w/i6UhbCOHWhhn88enQjQT5w3Q9QS4VZyuk8BVoV8kPBInaydX0k76Ba7jYgTua6QiT57YQ+O5GH6iZKwRfR+KeeXE3vlismxjBuLfH0ScBkFkVV1s6P5DZcm6OGQzh9nVvuZkQQAkoL7O2+IIOH8TMDt6ykKa2hqdJte32AzeMYmlIS+S1EBIsxZnIBWTw+yFNAHJ/9MEtgKKE/TT+Q3vifLPf5MFYmZF86QGU9Uqmdgt54ORAzGCiIUSLnQ6wvD/ib+OsF2AYKyL02s8ft+xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRNqUMrl8UT9VWd9dw1wzZwdgfB6mngQpudSKYHUj7o=;
 b=jLK+UFyaJ9PlhlLkDqKHnf1ZMCu/f+qq4qggkRdM8ereUIZtbiIkEPvVcEPYMhmX2v2J7FBP27+ZylgKV6kC/xFOelGflQT4ecbBswSy5wdOjRhv+q7wOKXXQQvC+VmL8zPSIMHxDxXbjBLYCHeQVjTGagYBxLWCBIQcykl+HFb5RR1YVZd678w79gZ6YEFy3/ipd5L8Fgyl66b1v0vUqJxUF3N0QeweL3Qxt1wSIxfhH1shanr0PdvOl0Ph9CDdSe02Li5hIIi+K3JPWT8Ht2Todpb3/O71qB2TDPNoTwqe4vTcatXLT3Cq5GCU3zxlMo0VwRJVyX68ojxgMmA8og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5)
 by DU2PR04MB9067.eurprd04.prod.outlook.com (2603:10a6:10:2f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 12:32:32 +0000
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd]) by AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 12:32:31 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 28 Jan 2026 20:32:10 +0800
Subject: [PATCH v2] mailbox: Remove mailbox_client.h from controller
 drivers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-mailbox-v1-v2-1-54936bb08f15@nxp.com>
X-B4-Tracking: v=1; b=H4sIAMoBemkC/23MQQ7CIBCF4as0sxZTSGnVlfcwXdRhsJNYaMAQT
 MPdpV27/F/yvg0iBaYIt2aDQIkje1dDnRrAeXIvEmxqg2pV30o1iGXi99NnkaSQXS/RqKvWlqA
 e1kCW84E9xtozx48P38NOcl//Mrsk0EptBiSk7nJ3eT2jX2AspfwAPkJ+WaIAAAA=
X-Change-ID: 20260127-mailbox-v1-1461cd2955fe
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>, 
 Yuntao Dai <d1581209858@live.com>, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org, mailbox@lists.linux.dev, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To AS8PR04MB8450.eurprd04.prod.outlook.com
 (2603:10a6:20b:346::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8450:EE_|DU2PR04MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb91b98-3758-4cc5-6259-08de5e694e88
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkZWUGNXaU9kbVBKVmtla0xFY3dtbFNmVTV0TUxET3E4dFhaNVZrOGljQlZV?=
 =?utf-8?B?d0pTRHg1VGxNWmhXNDJvTXhPTVN3Ni94NVRGaDd5MzkrVWVrTFQzc2tBeW1t?=
 =?utf-8?B?a2E3MHdKaGJuVVN2Tng3NjVvUUhjNWNqbjczaG1SdUwvUWEwMXkyUW5qNUsx?=
 =?utf-8?B?enZ1dno1NHVTY0M4R2pQRUpaWGc2SmI0RFZmOWpqS2lXaVVNMDJhbGRLRnJy?=
 =?utf-8?B?alZkRlkzWkZQVmcyU2xGL1UyTlAxZ3JHUVorSUtaQlQvTnFFWm9ZZVlXMlV3?=
 =?utf-8?B?dFlhUjd1aEZ3a2NvbWFqOVhFR1NVUmQrU2lFRUxxWnA2N0tUN2wrSFQ3SS9H?=
 =?utf-8?B?aks2NC90aDhGcndvN0hUWGNoVDN4QnFIL3VzQ1Mvckd5ZUh6a0d6RVJoenEx?=
 =?utf-8?B?RDRKczI2N1ZreXh0NDkwUTlDZFNMU2dwN3VrdVRvK2Y4aEdpZGh4YnhVVTQ4?=
 =?utf-8?B?a0hDaC9oSHFUaEN1QXdHRWlUNDdNY21Ma1kxL0xQVUthWkJnY2g5NURuUUR3?=
 =?utf-8?B?NGRxUWRaa0cvMGdYTzcydmQ4cjc5aENmQjkwamg5dzZkYmJBTDdiK1NmRnk2?=
 =?utf-8?B?cmZwbk1BbTlaOTJISEdTZEpES2c3VjZINHJaWkhSWkZiVk8vY044MjRSUTgz?=
 =?utf-8?B?UWh6VW8xVzNDUzdXb3pBaHU5YXlMRHZEb2J1N1E2czlMVCtnV3dtaGNiTjla?=
 =?utf-8?B?LzRuMTdKN0Z6QVdZR1YvbmljM0o1QU9VV29OUnBkYkw1bTFJVGJzT1ZwYzJn?=
 =?utf-8?B?dWZkM01hMmgxTS85ajJCT1VUYUVMOHFIalVrWldDenF0TDFIcnJkYi9KNFc5?=
 =?utf-8?B?c3RHdE9qQzNOTEJIY1ZDdHprTE45cjh3OERQNC8wWktIcE9laHphTGhveWlo?=
 =?utf-8?B?QlVYeVlIM2xaN2RzYVA1ck9SbTUzNDJvRDZYcEl0V1JaMVJRWEliMkNuMkYy?=
 =?utf-8?B?V2xoNElIOFFKZmdoaXFVK2srdTltaUUzVW1SczczbXordDBOcnRuRVhVUWpR?=
 =?utf-8?B?TVRpcmNHemhTbk1TVjVUd3Nsei9aR3A0ZmNUR0ZHS0U3dnZsbnVGUHpqZVpB?=
 =?utf-8?B?Y1JQYmtIbHR0ZFlQWU5BWEViaXF4MnBhcU9ia1dVNVplaFhxdTZHT3pyamxu?=
 =?utf-8?B?S3FzMnhPQTVtMWVvVWtieTR2dkttcDhJNkZCa3BkdncxRnhqeDBsRWNaT0JI?=
 =?utf-8?B?TXhOMkZsdTVHbVV4SVNNZlNZMnpEZ0xhUGJUaU5iVkxtUHo3aUNtdFdVeWgz?=
 =?utf-8?B?SEh5dTU5RXJ6RkVSeVdYU0pwSmF4Vi8rbVVhWGIvZ0tLbE9uRmw2bERSSnFQ?=
 =?utf-8?B?QjVJUmpYMWNsdkxZT0l1TXVJNy8yQ2E0WWxGZVdhT2Z5d2FGTWJObXZ3V2pm?=
 =?utf-8?B?V3g2MzZRRitSL3hKU1lJc0dFbzlsVm5WeldOZk9CeERnekxVS2RRQmFKZ1VD?=
 =?utf-8?B?cXVpOHBFa1IyWEZCN3JkTkMwUzhTZlQ2cDV6Y25NQ3BwZEE0NmJhUHd6TGJ0?=
 =?utf-8?B?cHJBUnhhN2N2UkZMRktFU0ZpdGVGWGtOS0NEVklSOWc2TWJYOW9LaUNLVERk?=
 =?utf-8?B?NDVaclY1TVI2eEMxKy9LVXBrcE4wbkJEUTNCVTA0U1l5L2pCWGUzQ2VUVGFs?=
 =?utf-8?B?eW0yMlFlL3dSZG5KNCtoQlRYN1N1TmlVK0pCWnNCeDVkZ0JBSFVGSExkMmNo?=
 =?utf-8?B?SC9HU0xyeEhrZkQzaVpuczRaWlZtWTdyOEsrR2hwNlNLMTRMK3dIc3IvTUM0?=
 =?utf-8?B?Z3ZveitCekc4dEhIYmdKbms1TzcrVUdaYWR2R0ZTcDBKd2FDNGhyQTcyaDJL?=
 =?utf-8?B?QmZSWlZ4Vk04TUtyV2Y1M081RlRyelhiZEVDVFFVbThWNzNrSDFHWWhRTVNq?=
 =?utf-8?B?WEFlcDkvdURtYk44NXRFbWJ0MWI0L1lPVlVoQkNEN0Q5aVZBU3FvZnlxUktM?=
 =?utf-8?B?QzZGN28vb04wcHpWWXZOVlcybjNkOWkwSmEvVURHQzQ4RTVlWENNWWdXaDEw?=
 =?utf-8?B?NXpLUGdqZGVUODJZM3JENVAzOUZCSkpZcWlkeVl1QWx4OFlsOEJIVWpSSkZW?=
 =?utf-8?B?REdXalNZS3JhaThZcXFoRXlPdVRmeTU2UDR2T0N5UkdyRW03aEVFbG9EdW1U?=
 =?utf-8?B?RmZIZE1xTkpnMGlGRnMzeGF5K2xseG1OMlVqNW0yblVwVXJSRTE1UVNtWG10?=
 =?utf-8?Q?/mzotp4KKeKElAMiGopwblM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8450.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVRMcWZ0d0FpcmkwWGZTbTdiME84aXBpR3RWT1E1M0g4OXI1amVjWGtpZWY4?=
 =?utf-8?B?K1Njcng4U2w4Ym9lUEtSL250Z1cvN09RTmdQYThMMmtLbFFMdmRVRjNiMTRo?=
 =?utf-8?B?N25uN3lzVWNKM1UxdVRwMkhIcFpQNnNEWUVVM2pTbEdncHA4aHlNaUgvcVlx?=
 =?utf-8?B?dTJOemYybXZFOG80YkVGcEl1bERIM0VzVStRaUVESDFwZVFDWE00blRlbzFu?=
 =?utf-8?B?cTROL3MzZmZrbitlUmw4NTBsdW1VMUpMY1ZIMHJqTTRpOFN4dFhab3pVWDZY?=
 =?utf-8?B?SXlXNitaRzZTL0dqeWRjSHBzWmVTUTBtWVd5VHY3SHY4M04ydGRzcXRNWTdH?=
 =?utf-8?B?NW55UnFPeHRLNG1IS2hUbk5uU1JjeTlYcDYyYUJSeldzcW51dktIN3VVVk1L?=
 =?utf-8?B?N1dHbVUxdi96QlpWbjEyWHJONG9IVmw0SmwwNzlDMm5DRkpDSWluSXBFTGRw?=
 =?utf-8?B?WGd4a2M3UjFzTVFzYnVrZGRMZlY4QlpndlJtSm5sZncvSjFvY2ZrNHpwdmtT?=
 =?utf-8?B?N0grOTRiMkpIMUEzVGRKWVZGNk9BMGExV25TQWFjdWZ0ZHdqQy9VVkNpKzla?=
 =?utf-8?B?T2d2V2NoK1FjTkdNUjlZaGxjaW94bnI0Sm9kYTRjSUdDdFlkM25MUFZQTWtQ?=
 =?utf-8?B?akhCR2trQ3NXTVIzcUJxQVM1d0J2NTY5bERJSkw4cGtBVFhmWFpUMHV0YndY?=
 =?utf-8?B?dXdHYWxodHJTVXd2MXVacUhNRVJqL3h0ZzduZmNTdE5zcHliQjgra0hTQmxI?=
 =?utf-8?B?aFQvb0N2Zzh3RVV2QTUzd3dvOGNuUm1pUzRiTW1EbHFvMXFpOXE2V2wxSzUv?=
 =?utf-8?B?ZXBuN3gvTm1SQmkxTTk0WDdjUEwvTVFHdzdYeEFpanZpSkRYdlVQTzRPM1Ny?=
 =?utf-8?B?cEdsdkZnUEZuZFNYeWhOOHB0SnFXcUpYaDZHYUZmRlREZ3duSmJiaGd0OUto?=
 =?utf-8?B?a0QyMDlMdEQ3N3V5SGpOVjhCQ25QZXBBZktpTURyNVBLdHhycEdONDVOdW93?=
 =?utf-8?B?QjNVakRpVnJvNThUUWhwVkdLajZzWStIeUJjN1l0MWRvbmdpSFR2d3hNZ0ZY?=
 =?utf-8?B?S3F0S1JFcUZpdlJoenRyQ01QYzBKWS9Oc1BlMGNZSlU3bzJlSHF2Ui9UY3FI?=
 =?utf-8?B?bVZEWTRhZGlkOVBhVHNVK2RZMkF4VzFLMjVvREpvTWtMZXB3SkJ0WThtNWow?=
 =?utf-8?B?VW5aQXQ5d21KeDBoTEZGREdsTHNyTHRRSStZcVlreUpIN1N5Z3BBemxLWS9P?=
 =?utf-8?B?YzBrOHIwZGgzd3hwMnUwMW1BeEt0cUxBakRoR094T2l6cDhuaS9JWTdVZExh?=
 =?utf-8?B?SG9TdzlqQVhsWTVMSVpabU5jNGx0UkJMRE4yYTdEWm02M1p5aU9mR3hPb2M5?=
 =?utf-8?B?UXRqRmJmUmZUeklSOHV2TzFDV0F6dlJsZXc3cWNTcmpsOUM4MjJIcklzZk5h?=
 =?utf-8?B?QW84Z3kvcUZEc29iMFhPSkNDRDB0eWk3UlhGKytkemI5UDdWRUF1WDBEQ1FT?=
 =?utf-8?B?a1c4emNZZ25HSFQyOTMvMWRRWjZJT3Rvd0JVV3hmY2pScmFjUm5meXR1VWxB?=
 =?utf-8?B?Z3RIdlBLMUdTaGRnSjFPbmVQcm1JSCt4a1cySEVzSWJXcklkTWlvR3p3RUkw?=
 =?utf-8?B?Q003aVM3S3kwM05ZZUFKY3JwQmFSYXFKNXJvTjI5Tk5BWDNyNkhyYnpVdGYy?=
 =?utf-8?B?NXhHVHNoenBrQk5pVVJxb1paMWladU41emJDZjNKNTdYbzR4eW1SRGg0aU1p?=
 =?utf-8?B?bjBNNFBISXpqWkJkSmZlZW5SODJYSE5McUxGU1hIWVZObVZTY0pHeG5RTmM2?=
 =?utf-8?B?Z0I3Vy9VL0UreXhHUEFlYi9HLzdHZS9oVitBK0RwVWVURHI0RnNsM1lpZVJ0?=
 =?utf-8?B?TDFTWFRaTk5FVVJPMFhpVHB0WmRsNWlzd1d4OUFmTGFJUG91WGxrQStyRGRV?=
 =?utf-8?B?T242VG1sWVZJaUtlK2xZR3poQWIyaWcvK25VTkx4RkltS2dORlkxKzVrMkgx?=
 =?utf-8?B?aDFZZW9mWEJxWnNXcnFpQnlQdTFSZStqeXZmY3ZrMkg5THgrZ3V6bWQxZmdy?=
 =?utf-8?B?RS9ScTJCODAwcXV0MFhEdUV2LzZnbExDN08vU0NSODNmRFArVzlHTXRjMG1I?=
 =?utf-8?B?ODhoU3NCYVYrUXFWYWt3QUVrR0V5NlN3alFQY2hCekJYOUl2ZEhTRnY0K2tq?=
 =?utf-8?B?cXlrTkdpMDNjb0s2WDBONjZYc1M0UW5EeU1yczJONWhHbDkxOFdXWHNnN095?=
 =?utf-8?B?M3gwWGZyOS96WEp3aitkckVhUlZaM3hxTURaNkw0dkxOci9hVmZZU1hPZ2oz?=
 =?utf-8?B?WE5VUnE0dk84ZGF0THF5TkxBL3UxS3VHZWZYN1RTb3R0S29sQVpXZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb91b98-3758-4cc5-6259-08de5e694e88
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8450.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 12:32:31.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X32p1j5PpBsI5hjfGzL4jV5AjZMGuMg7zjF8HuGzlBif9gDbJG8d5an7+/E1vzjXd/APiUK9ExYw4Nm5dL/Iyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9067
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20708-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ti.com,live.com,vger.kernel.org,lists.linux.dev,nxp.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:mid,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45D13A1558
X-Rspamd-Action: no action

From: Peng Fan <peng.fan@nxp.com>

mailbox_client.h should be used by mailbox consumer drivers, not mailbox
controller (provider) drivers. The affected drivers do not use any mailbox
client APIs, so the include can be safely removed.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Drop changes to pcc.c
- Update patch subject and commit log
- Link to v1: https://lore.kernel.org/r/20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 1 -
 drivers/mailbox/cv1800-mailbox.c     | 1 -
 drivers/mailbox/omap-mailbox.c       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 41f79e51d9e5a92089a3fd798e848d837fb2775a..5d278bb5a4c0635dfc46b4a6dc3addf0b3b5d1be 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
 #include <linux/mailbox/brcm-message.h>
 #include <linux/module.h>
 #include <linux/msi.h>
diff --git a/drivers/mailbox/cv1800-mailbox.c b/drivers/mailbox/cv1800-mailbox.c
index 4761191acf782654c1724df2c9cc619e1d7c985c..4bca9d8be4ba2c8debf6e48a5ddc2873f14b64fd 100644
--- a/drivers/mailbox/cv1800-mailbox.c
+++ b/drivers/mailbox/cv1800-mailbox.c
@@ -11,7 +11,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kfifo.h>
-#include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 17fe6545875d01606b80e678fca82bf44f6eaffa..d9f100c18895224cf323b073db93ce94d7e16d18 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -21,7 +21,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/mailbox_controller.h>
-#include <linux/mailbox_client.h>
 
 #include "mailbox.h"
 

---
base-commit: ca3a02fda4da8e2c1cb6baee5d72352e9e2cfaea
change-id: 20260127-mailbox-v1-1461cd2955fe

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


