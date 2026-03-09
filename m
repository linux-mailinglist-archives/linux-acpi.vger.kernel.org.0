Return-Path: <linux-acpi+bounces-21525-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKteDax7rmnoFAIAu9opvQ
	(envelope-from <linux-acpi+bounces-21525-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 08:50:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4E3235065
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A113035272
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 07:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E0C369985;
	Mon,  9 Mar 2026 07:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="gIxOgyvL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE0366DAE;
	Mon,  9 Mar 2026 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773042385; cv=fail; b=Poowbl3UHPMcgkm9dKC5DuULc0j7WApHfWvxyXzrkUymyMRrAtgZQrcK5iCoABU7P6QjxJRvjwk/ZtUwhkKcM2n8aDCZEtX9Pei0/tG1AtWEIxeFJ7aUUFTb0XB0dr9kw+LPmaVyCBm9f6fikdozWDMwz3tgeO2ImjSvCGofJsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773042385; c=relaxed/simple;
	bh=dWhkFam6CouvLECdI0+fM+rS/oPnpMfOSKBoJ743Y70=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tt7IijI03RPcS3QXm6wciIU8UT8g801k98xwTpIPXMyzua9U7CUkbx2iW384GW2Oh7guzX2mEkzBMfQ7diTUPOJy6c4W6VJN8qPWSARr1qk5BQ2WYeMAoKI0rIBavEPHyKdP/bNcrUpgNUjKefTRLu0X1dT2YmqLtouxfUNUa/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=gIxOgyvL; arc=fail smtp.client-ip=52.101.72.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/9lBhNmnH/FPA0fuCb93xCzskgc9xLR4HcIl9YQfHJTSdg6iThkTw6MLxtB2vlw7irjTrX4wv0icGpRytESpH5isQXxUBSbSikozN0bNcleB+luwY7H3Xd8Gdbp8QygEsLl6NYmqOIHvtT4dguc8v8mOsT3uBbG+vGoVNygBV43APfHHD89s0WFFZKdCYh8TvwYRChJhGZM+EJD3weztmUmYLORuMTuILanDTfS7IU0XRQD1jQgTR7iBB6aPOUfB9xMsip0xiZ6VIWdzFV0wY3sU4FPafD7n8C2z/ooiOS8URGLZtNyMR4iXb9BoyLROkjJiTivpyMAfPm6yJ3xow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWhkFam6CouvLECdI0+fM+rS/oPnpMfOSKBoJ743Y70=;
 b=w4gHtgvdwoEAnDDQc1P/b+OobGnAXmJdz9dGv+Xmv2pRrtEP+v5/p/3bPRD0NpdIDnPPMDjeoXz6hAcNhfukCtUB6uQtU9ePIBzlm1TltBndMY/YJ8YnnFAaA0abnAZtjj27JAxJ2jLYOy5BMNj6kwCEs5WlReFreiLT8TBnyb43G4Zgsxai986e4NZCWpDPldPoAohb7QgeYo9JYgZGJR/yyGeFBvYpjEKaCT7CmUjUCIph7QX0gmq7WaqzKwr5BlUspa7JHUJM1cYNDR7iXvfymw2oYk9/JaxUglTFGF9drq1Rlqp65VNCqsFE3tcOUI3LVHbZiHtKgTaN8xJfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWhkFam6CouvLECdI0+fM+rS/oPnpMfOSKBoJ743Y70=;
 b=gIxOgyvL5PCx7HJTw7kaKDO0KPnpnOemXXM0zLDP8BEYUCmZShhlfqF6UKnTh9pdmiertvl2tiOzC2lEaeg6r5TZFccQh9Up/WZuR4AO4ZveWO40CpePcOjNnDc4UwNsTlYj8uJm9gB13usaYztedXwQDgTpAIL3bpNkFmHvHtjVtuyZhq4manzUYmBobWGJMUv7apzz954UyJeUME2B8p3NQorKtF6dVfaRpMYss5Y9bBIPLIeOiw3BL6G/RCD0qFBiNm6NpuVLvExXL+bZmkZ6l5Li5YtoG4b/Cux6X2QkrjCW3Bdq0LbuJMcSTY3NoZbMVyr+M0HhV7pk7QRynA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by DB9PR04MB11695.eurprd04.prod.outlook.com (2603:10a6:10:60f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 07:46:21 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::e99:f504:ce75:9bed]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::e99:f504:ce75:9bed%3]) with mapi id 15.20.9678.024; Mon, 9 Mar 2026
 07:46:21 +0000
Message-ID: <73904685-3670-4995-aa4c-a230ea423490@oss.nxp.com>
Date: Mon, 9 Mar 2026 09:49:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mailbox: remove superfluous internal header
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@kernel.org>,
 Peter Chen <peter.chen@cixtech.com>, Fugang Duan <fugang.duan@cixtech.com>,
 CIX Linux Kernel Upstream Group <cix-kernel-upstream@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260309073720.2108-2-wsa+renesas@sang-engineering.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20260309073720.2108-2-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|DB9PR04MB11695:EE_
X-MS-Office365-Filtering-Correlation-Id: d2093c38-fe59-415e-d829-08de7daff47e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	numfAVUBDDUCfkIbUQa6x1AibvRfr6dCzTIpoCrLfZP6BqI6xQI5bS3WxaCYJIwyX3ewCFLmDQCtjNy4UikovnYKPv8uh+yVbcfzBcWzqG1fN0N8TJG6z1ikQ9EdAlgD21cfdcJYqUVVQ77KD7NxaX+Qj9Vgupil9YBpZc2qoVVStS70wbyMMX+FbuBUVZTJKcTEEefMYXinx5GPq4klK6ntMzlVjwLNybXtiA+POZXRz/TBYjESooZ7xJq/6kNmzeBhiIS1HZiio7q55vCTocLzaQyztslyyyPm9vOOn/YXADSzl1k3LlnHIZLsXOfT47W6IoKT9GMKLhUvXH9pWykubr63eKWv5HTrYvuuG3WduL6esiWW69UeP7ARfDzwCcnLMgOu8bE8kpLbiOCygHfuQC20BCmmEFIBhIvrTEJ349QJCv7WSCXymIQ6WmL0MVjrW/T+Vfx7UKeEKDFTEMqsJu4CM5AHnEneh9XcAmDy9etFZcW52U9/bBc+ENfZ4qRI9OlGK7jiTox5Nzw5fP0EehUfnvEs+BwQ9qqQrPIr8tJpl1OpcTYc5G0mOI3ZV3pgr/dE6+ko1sBiVe3kgrpNi4DXma/nFCWMeOfK9HXQfoAQsp8UHC0i2YYtNWj57eIcABgBqU75VO3iovYiFdD7g68Jr2vM6ZojW8SAjHv695iwpNLU0Z1nhj0mjX7OtFi5RmR4qVWhDW7E6grP4namFAVlPB3jiOUOcLKdLw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnRMVnhNWERsSUlkZlB0VU5CK0hOS21zdmpqV3dSaXE3ZW5oWEJ4dkQzZWRS?=
 =?utf-8?B?WHg5TWI4dXZSYVNiYWw0cFEyVXVMUGNncFNmcUVWTTY5V2RXaWYvN0JZVmRv?=
 =?utf-8?B?Vk94TlZBY3pmVWwwQlBYWDRSdEdJUVVpbDd0M2ZvclBzVWZTcUxjbUhLUzIw?=
 =?utf-8?B?T0JwYVFSRG43bi9rZ0RoMmZNZWJKWVJwb2FlM2lKbnNvVWVJNnBONlYya0Y4?=
 =?utf-8?B?WFB2NFJZWFdzaUF3OFZKUTFlU0xNV2FJY29HU2R0UVlIUTBwMW41RGJKMjNE?=
 =?utf-8?B?dmx3KzdCQUVkZGpxZFJkNk05MC9YRVRRYXVURVN1OGNzTFlteDR5QjdqZTla?=
 =?utf-8?B?K2tYRWFHZHEvdTRmWFFmdk8weVJocW4vbnJqKytESGVSb3ZCMzZBWjBIbGNx?=
 =?utf-8?B?MkxERHRvYThRUEtleEpSWkh3MVpRZW1MV3R3MkE1MjdETndjM1RkckYrM3Vk?=
 =?utf-8?B?cWpnMzRmMEh3RVB4bkdTMm9xS0k2RHlPbGRPSkM1MTBzdW1MOVo1akY3WWZw?=
 =?utf-8?B?R3JtdlRBVGhtekpzdE42TkJKUWxqRGtjRHEvZ3RFUi8rNVNEQ2h0Q3FSMGQv?=
 =?utf-8?B?cjlwTUhLRHhQUk5CRTBYRDQ0YVlLZCsrUmFBOXFlbWFRc2RSYmNkRHFuOXU5?=
 =?utf-8?B?aURUWWxYM1pFWisveEtMYi9NRkRNSWpiaEhWWkg1NTVlOVljUlBPbklGRmFp?=
 =?utf-8?B?VnpxeFpoZ292bG1RVXlZVVB1cklJbkl2L3BnZ0FDWlZtVHFtUFhNYmIzenpa?=
 =?utf-8?B?b29FQ05TdGRoSVZ5MGZjTSs3c2NBcm9uUHg1b3IyYk9rMjM4SCt4UFFyZGdo?=
 =?utf-8?B?aWVTSzJmY0tQTjF1T3FPVFZjY2hZRG9pcmdOQVU4V3NpR0JoY0pzcHVObFhn?=
 =?utf-8?B?eHZYNVBKVmRvOUpxeVhPKzhDYWU1L3BLMldCQWx1dFdocmhXZ0NSMG1WaWp2?=
 =?utf-8?B?R3FDTFZDTjRlWDliYm9VUEt2OEpBVFEzQ2pycGYvcEJGR0VCT2xMY2Q0TC9U?=
 =?utf-8?B?MEtwMy9odEozekFqeU9LRUptd1JSbU45UExVdmh4dlBnSjNheFFvYnhOdmZC?=
 =?utf-8?B?amUyaWdyUEJkMnhyUmd1bU1DRkt3Ky95MjZwbHVKc2RwYlhNcGwyeEJpTzhZ?=
 =?utf-8?B?c2RWQlgvZktpaGErRDQzZE1MNHNMMnpwclNKYkFhRzl3bXJlRkw3QkFmQ2hk?=
 =?utf-8?B?VG1sNlN5alBuaHR2bWM1eklPVDg2Uy90M3NObThJdHh0K1ZUWnhLem83VDFD?=
 =?utf-8?B?Q3A5RTNEdVdtcHZNVVNqZHI2ZUlCbysweFZuTDJ4T3pKZzV6YUgyRE0wUTZQ?=
 =?utf-8?B?WlBPckhWei8vSkkrcHdMZGkyWm1KbjlvdncrTHdMemFYRDgvNDhJU0VobldY?=
 =?utf-8?B?Q1cvaHBnL1VYT2cwbm9xRktxT3dFd1JVUlNFbnR2YmhOU3FNdjIvMUtjSytW?=
 =?utf-8?B?cXAvWk9TOTFuakM3STh2UGZ4bkh6N00wcGtMVFg1TGN6NVlYejFoY3N0bFY3?=
 =?utf-8?B?Y29JU3UwSHBZcUJERHVqTGVHT3BnNE9wMFgyOXpobHFweUdtOVJWZUZRVjdK?=
 =?utf-8?B?V05yUDh4TVgvSFNxcDVjOGhNZ3RHUUtJbU4yKzJSM0hzZ3Raa2dhNHFKdWpn?=
 =?utf-8?B?ZmFtZDY0Wk0yaXpsUnhXL2Vyc0xkWHFDWllZL2FqbmhKQ3VhZjZpTDRON3Ew?=
 =?utf-8?B?S3IvWmw5Zk42RjRqQmx3cmVBZHQrajVUZmRzZGo0MFFCWTN1b3R1Tk9NTnRR?=
 =?utf-8?B?WWxDREVjVDNVYjdpL2ptU0JUL2hpblQ4eG5TWWh5QmtOcWtpZ2RjQjFiNWR4?=
 =?utf-8?B?NTBwTW9ZczJScHZ5eEgvcEJiTC9VcFowTmE2aWFXZFhGUW0vMFF6V2FlU0FG?=
 =?utf-8?B?dk1QeUZFZkg3QnBuMXFSaE5zS0V6TWVXTFR2bDdld3pGRm5SeDBqOGcwYTNw?=
 =?utf-8?B?dUViZlgvZHVlcnRlNE8wSXMreVRUTXpjSU8zSUFZdWJjZ1dHRHFRVnlNV3d4?=
 =?utf-8?B?M3o5azREOXJ5VGJQd0RRZnkzSzdpMmMrZVNJcllnT2NzRkxYRDk3S05FY1JT?=
 =?utf-8?B?NTdGR0hlVC9GM1l6WGdMM292eEpyek0wU2UzRzZqT0VqMy9sY0drREdCV29K?=
 =?utf-8?B?dUFSY2hLZ1d4cXVHMlBNYklBaGpkUnFCblRNQmpsaEIxK2ljVUY3OFVycFda?=
 =?utf-8?B?Tjh1RWp3MGhZTlQrQmgrS2pFTEh4WDR2SGdxa0N4cFp0aW1zWVgzWHU0SE82?=
 =?utf-8?B?djVCSlNWUks0dEo0MkgrMCs2Z2VveUFYTklCUCtva2l6UWtId0pSNDB2clJG?=
 =?utf-8?B?bkh1RWM5cU1wN3BNV01kSXdZWjlsNEllRHk4UERWZFY4aEJDa3k4dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2093c38-fe59-415e-d829-08de7daff47e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 07:46:21.0297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOoOiXqWfldNnqo+I/qIzAnelrqwzroqXfDNuBtPvdsa5XR42oLDH69eBzUDI1pWY3ddbJgbRYC9GFGiNDsicg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11695
X-Rspamd-Queue-Id: 7B4E3235065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21525-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,cixtech.com,gmail.com,nxp.com,pengutronix.de,nvidia.com,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.baluta@oss.nxp.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-acpi,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,NXP1.onmicrosoft.com:dkim,sang-engineering.com:email,oss.nxp.com:mid]
X-Rspamd-Action: no action

On 3/9/26 09:35, Wolfram Sang wrote:
> [You don't often get email from wsa+renesas@sang-engineering.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Quite some controller drivers use the defines from the internal header
> already. This prevents controller drivers outside the mailbox directory.
> Move the defines to the public controller header to allow this again as
> the defines are not strictly internal anyhow.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@kernel.org>


Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>



