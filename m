Return-Path: <linux-acpi+bounces-20702-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MX1M82/eWl/ywEAu9opvQ
	(envelope-from <linux-acpi+bounces-20702-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 08:50:37 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AB59DDBF
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 08:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 845CC300DE25
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC24F327C18;
	Wed, 28 Jan 2026 07:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="TYCVuBik"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013041.outbound.protection.outlook.com [40.107.162.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D6291C3F;
	Wed, 28 Jan 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586633; cv=fail; b=H0T+Cbim2B6+Wq1euT9OxewZkyk+erC+G6KJMX33yW7ZN7k+i30xweKeZ5gtKnshWa6J0Upa1m0P+5jRJaSkRmbzWYMt5SjCNHA64K/Sf0SE0v6B8hwPnrD4E14LFo6h8iflmEicqxiqagBRDLVBY5RauVsYKXmekoxc/2JUyIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586633; c=relaxed/simple;
	bh=bA76/xSA06UWSYes/1wcZXT0mGnD9x8IpeAPcTZZLC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Eu2AYTVho0HICNSJx31LM5YzFcYkQIdYUtF3V8PdeTkCNejp0ou+8VXTQDo1gLzQXpbjhFfhpRyPiuWjInNi7hQ6Q41uWE75itgVJlqCgSA73cpNZxvwW2hmTpeFY3g8jbVB/RrZl8u33t22RkxLmNXHBWuR8WLbJLWtSCZAVhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=TYCVuBik; arc=fail smtp.client-ip=40.107.162.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0SDXEufjTfkXl3WUCydd+HWlvaSn+jXzAMVpGjZ5uGs9sn20zzqD7Qq60UtFaYlFuJcInMqzPZLnu+E+jxGGmgxEJon7uuVu/ARyQb5yW5SMeUj3gMDbRp65nd+bYXLvLacz4D5o6llIJWuWtkeQnmP4ddBf+RQV0BqO0ew3wu3Qk0JC//zEyr2dat9M3O+k1CE7JHi8pBI3AioeatbnVTnAFIxFzzrrzaaSydFidYmwCAwBB947gSeu5T1bKri+t9iiZExIoUwNKkKcGcxBNzOYT3YsfLqEsx+gwQB+uiuAmduewa0yK9dTYnqrKyHqeNZ9l0r5Wot/DZ7sSgEJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAh6GXuzoGPORt8OoMOgArHEgGvY2sk/dv9fQmxAgQc=;
 b=ClnW76TUhNp8lz9OEbZdau1bAZfXjmxxe10tsh3vRDoYYco1ojHc9uCnIQ4bWYyPFoJZ1exj27h4y1FZHezqrhOv96c0ZVKmEvYz97c9HNcCF4sRPgZdC8Ot7mn3zogYgogDnlZHTZPG27AzhChJK0EffdDtu0ErHM9z4S7EwqvJiWh6x9JpK7kwmROHNlrFDLa41rt1Z/dXtKJjAKS8c72cNxiJJcd28rnKiMtClKwXNxcoGP7kUgcVASnwt+XPHF25wgturXSHxCTBfeAAnXyHyJddV2aME1UN19lNAdd6L+3kZm78e4UKwQtSB5g/bk+gDFmRsOE1/B+JmVnuzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAh6GXuzoGPORt8OoMOgArHEgGvY2sk/dv9fQmxAgQc=;
 b=TYCVuBikW2+ikWuW3vqKMEMjaxUZDABFxEuvMlXsXliORflqCczSUZYqFqhwg2SDOK82uKVLS7dH0QK/NlnjpngzWheZirG2H0/qZE4nj9xX+7O6AkqkvxYbGA0k48Qv0XH6f31ihcm/+IOTB5fgsOrrHXwvhwChU9L5YnMcQXBlEbZEp6HVH4gq1OcJ3W9wlMakTt2/lKRBjBMFHBphrt3DP/pHSepjOFAtFB6AVlk41cNazNXHlVmWhUm7aQmUqBSI9ktAKSrtSaVBbX3dveDmBdBLOJRQneiMBwhtqjP6tsZZAQ7oCI6FxJKy5+K21DVMF3do20ztkYnaYB+VUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com (2603:10a6:20b:346::5)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Wed, 28 Jan
 2026 07:50:28 +0000
Received: from AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd]) by AS8PR04MB8450.eurprd04.prod.outlook.com
 ([fe80::d3ed:eac:1f17:e9bd%6]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 07:50:28 +0000
Date: Wed, 28 Jan 2026 15:50:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	Beleswar Padhi <b-padhi@ti.com>, Andrew Davis <afd@ti.com>,
	Yuntao Dai <d1581209858@live.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"mailbox@lists.linux.dev" <mailbox@lists.linux.dev>
Subject: Re: [PATCH] mailbox: Clean up the usage of mailbox_client.h
Message-ID: <aXm/v5KWJf3k7V6a@shlinux89>
References: <20260127-mailbox-v1-v1-1-cf15d7cece48@nxp.com>
 <aXieA6vpJEUvEKRe@bogus>
 <PAXPR04MB8459042676EF3E77D71C19428890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <PAXPR04MB84597C134FA912B4C929E11D8890A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <aXjhJzfHvxrP-zc7@bogus>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXjhJzfHvxrP-zc7@bogus>
X-ClientProxiedBy: SI1PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::12) To AS8PR04MB8450.eurprd04.prod.outlook.com
 (2603:10a6:20b:346::5)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8450:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7f5605-e5ce-4a1b-069e-08de5e41e6fd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0tRck1aY0R0SkFvVjFsKy9uekJiTHM3NlRnZWlaQ0ZORnVNNzZkblFKU0Vk?=
 =?utf-8?B?ZlE0N1JiUmtnV0ZoaGl5STJZZEhNVXhyVWhrWWZKV1k3OHVaNlVVTG8wZ0xK?=
 =?utf-8?B?V0JRR085VmNVanVtWlFQcDJuTlk3Zk9ndkl5cERqS2hMdUtuelRFa1FnVFdE?=
 =?utf-8?B?VnRqdkI1ZjgycEtSSTh2ZU5kYVpRSTBsT2J2bFFpMzhCSVRhY1VCNmNHRlpS?=
 =?utf-8?B?V29rM2NPUjdCbEJQME5ZWDFmbGd0VTcvTG9OT055VDNRK2plTDlic09qZFY5?=
 =?utf-8?B?MHFBTVZrWE9tUkNqRG1OalF4YnlSeTVlemhPSFUwYmYvbzZUQTk4ajVjMVpP?=
 =?utf-8?B?VythdTE0c0ptZVl6TG9Qa1RHQ3U1V1IxaHN5L3VmWmM1Mm0rNjQ4TlV1NHJ1?=
 =?utf-8?B?OWtqUXRyMEZmcU9TSEwxRk5xUDVPYTc0M01aZDAyWDVTZlNaWHFhU1BnQitw?=
 =?utf-8?B?Nm9oYUY2eFozTUZ1TkZWWUZuQ2dYSCtsMVlpS3dtTHdLbzd0MVJoR01NTm1B?=
 =?utf-8?B?L2x3c1dFc21menpwNndLUGFScWJQMWprSzN3UGJGcm45Uks1R2hMSHZUQVNG?=
 =?utf-8?B?a05GTEJVeUNRYmJTTUdzdFZoOFpYL3FJV1lyVGlJdktjZTVHdDRiU1JiT0xx?=
 =?utf-8?B?aW9UaG5IQkUxVHJScmRWdUY1Z2JiS3EyVENISC9GcWxVM1RPZjlZUmhQSVdP?=
 =?utf-8?B?ZUhxc3Jka3Ztd0MyYm9wd0FTQ09ROUsvdUZMVXJZbm1DcVpzd2FsVG1YTDls?=
 =?utf-8?B?ZW5CMnBVN24wTWo4TXE2UGxyVWlmWTdFNHdhNkl6QlE4SmJ0eG9LaVFiRDV1?=
 =?utf-8?B?R1UrakpSb0xyRjZXcklNWmh3R0VoSjhQVjM1dDJ0TnBpclA0Q21SNWhFMkhu?=
 =?utf-8?B?M216WGRySktwekoyNXVlcnNNQWRKMWQ2Z1phVFZHOTQ2MnZYV0lmSHNMZmVU?=
 =?utf-8?B?SjJZdnFEczJIdFZXWGhkNWlueStxTVdpSDY4by90UGJuVHI3cTgzbmRsKzdJ?=
 =?utf-8?B?Tkl5bHZvOWtTRjZGQlNpTHJrYWFEMnRHSWlHTmtGRTNFdnlhWnlYMTV4N1p4?=
 =?utf-8?B?NGhOYXFMM2k2UzExSk5zVEtic0lWeUVwYld6RnoybjZiZHRCTVJnNnF6TjFY?=
 =?utf-8?B?OTF4emhtNTdLOEZDdUZPamRDTkJ6b2tleGtXMjZySlBlVXRsYTY4NTRoTnJF?=
 =?utf-8?B?MkFJYnYzT1J5WS9CM21HUERQNzZhUEJsUUN2NWNURGRkdGdkZGxBUVBjS2g4?=
 =?utf-8?B?K1RsczNScVNVbmNZU0p2dXRHRGg0UDBZZmNNbkNjR2k3M2g4SnpQTG5oWjVR?=
 =?utf-8?B?ZGQyK3JNZXpKTjI1NFpjMFFnV3dManF4U2xyQXgzb1M0Q1RVNnFKQytHRFRw?=
 =?utf-8?B?V2Z0SVA0ekR2L2c2NHBoZWhoTlNzVG9ubHFRRVovV2lrYnR3dkMyemVTRVB6?=
 =?utf-8?B?UWJIRWVkV0NyK2N6TkJGcitxaStVV3JkdjlvUERmL0w0YTNrL2JudmNIdUVZ?=
 =?utf-8?B?RlB4ZVJPOERtY1ZJTTJOakdHWkt5Z2JMTldpbW5Rb01tRUxGajZLQ244YURr?=
 =?utf-8?B?dGNqMi9tdHRzU1dMNnd2cXZCcklkbm5YQmxUZlc0TWhzY3doLzRXelJSdHY4?=
 =?utf-8?B?M0lnR2J0WDhyK2tOTW9qL2x0QWkyR0xWcmFMNmcremh6U3RaSlA3Mk5qK3lH?=
 =?utf-8?B?QVkra2N3a0RnNm1PSGVrdGVJN05GQ0FFM09TVHUzSUY5V1dtb2h3WEVtbHBq?=
 =?utf-8?B?Tzl6MUNscDVDNjJZWmlVQ0hFT0dlOUlBSWFuYnBIMTNtQXVqemo1UGZ5Q2tL?=
 =?utf-8?B?QWNkY0lGWkxaU09YQWRHTmcvTTk4TFVqZEJFb3lNK1k0V24wdmpMUDdQWTZI?=
 =?utf-8?B?dWhCYmt0d0phT0MrK2ZnTnZqd1J1cmUrMklVOHY2MGwvMFVtbkN0YmZjQXFW?=
 =?utf-8?B?T2NReUN3R0kvYjIrRE5EZEpyYWJydzUwa09TclBGd254VjhjblZ0Umc1enhp?=
 =?utf-8?B?S05FaFduM3VzMHNpTEgwL2dwZ2xiNGZqT00vdFVLUmxlQTNNSFdhK0RjTmIy?=
 =?utf-8?B?TlJXSWZNOUpyRklkaUlWbERtN0pxWUpVMlMxVlBHUGZZS1QwTnNCemlGTmRr?=
 =?utf-8?B?L3ZycUVmSXhQNUM1UmhUcWRwdk12ZkFqSC9GSlNGTG1LeFF3ZDVucU5tTTkr?=
 =?utf-8?Q?eup0HI2M+D4OF6OUYIx4VtA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8450.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDhYVHZIbEJTNC9Jb1RlbHoxdkZ0bFFIc1lHRVBCNXdQVk8yS1FOZHliZlBP?=
 =?utf-8?B?NzUyVXdtQ04rK0dvS0RaTlE2NHZCT0hneGhOTVJsdndxVE9qN3Q4ZVl4TGtx?=
 =?utf-8?B?L3BrOEZUNkRRcncraUpCVnFpK0hOK1VCVUdyR2RyOEZBcG9xdmFVYTFaWXEz?=
 =?utf-8?B?ZGx2Sy9icTRKenVsUHBTaEpMYUxENjNYNyszYWp6TkhFWVJDSnM4blc1ck5I?=
 =?utf-8?B?ZGIybUJVaHIvN0NsckQxdFhWOGFaT0wrN0ltOVQwTXMzbWlVaisrLzRybUc4?=
 =?utf-8?B?S2JxWFNWRjNKRnh0K2hTMW10bExIdXlpK1RhQlo4MllGTWduNWxRekt2MmFN?=
 =?utf-8?B?ZHNUZjZ3TkhoTkJ2OXQrcDJQYllVYXJ5aVozblRKL0prc20xMU5rRXZsaEJh?=
 =?utf-8?B?OFAweEpDd3QzeGJ3dTFod0JRL1RnMW52OTBQMEVveFdyNE5ucDFpYUU3eHNx?=
 =?utf-8?B?NTZ2V2lEalcyQWNCVVMxdnhnanc0MXh4VW5RWkRhdERBQkhUbTRQQU1aU0po?=
 =?utf-8?B?eWNGdGhHS1E1K1BTbmNMd2JMKyt5OWRaSnlRY2pJOWkyRlBwejFyOU9zM2Rk?=
 =?utf-8?B?WnRqeFUvTDVLd1NVOXE2UzBocHR2Z0Rndmtuc0E1eTRpTndjRXhiRkhFWk9B?=
 =?utf-8?B?SS9iYm0zTytJTU1FS3RDTThHR2VtRDRQRlZOVTF2bGtLN0hWVHlwSnI0cnBS?=
 =?utf-8?B?RmJJb2hpaEZWV2Q1NzVkS1RQSVdJRHZkd1lFdjNxc3MrSnZUSUFNOXVRRlJ5?=
 =?utf-8?B?bElZQXdod1NFZDl6QVpZMThnek0wT2YxR20wMUJ0dWJtazBTdXFpWnlmSzVT?=
 =?utf-8?B?WjZDN0lrNkU2N1VENTNleW0vQjNoMFNZVGU4SmJ6NkRrSG1XS3Zua2phSmRI?=
 =?utf-8?B?T0FDenBVVmtEb2FDN0hrSk5zRnp0cU5SYkVNYXc3ZEFCQU5taEhHOFhyaXpG?=
 =?utf-8?B?M3ZJdnEzOVhSVWJwN1pucVp1dzBBQW55NWxsZXRXU2ZwbDZXS1dmOXloZXpK?=
 =?utf-8?B?Tk5xVWJqMllRa1VGbzkrNWdaN1Q2T3lTMW9sOTVlQWVjOVp5VC91bWh4SndW?=
 =?utf-8?B?a0dBaTVYeC9OVFErQno0WWZzZm1nN2c0UGYzYlpEQTJMOFpxVlZXeTVPYjYy?=
 =?utf-8?B?ajc0OFByR2RyU2lNZElTU2tnaWlSc0JRaTRSdzd4QmIwSlJEZUJkUkdkSGEy?=
 =?utf-8?B?RHpkUktlbjZZNTdWYXNKVTRVdmUza2ZPNG9ZejErRi9jWWkrbHFQSmN4c3BV?=
 =?utf-8?B?YW5LTnlWdXdGOEJyYTdRNjhnSDI3QnZTUzRLU3JIUzJRR3Z5MHdEUTRqTkpI?=
 =?utf-8?B?ZHJid3VSZVNQU0V1MmlzcnlkOGw0ck9qM1EzZmd5MjU0WFRaZDZIaVo0czUx?=
 =?utf-8?B?dVpXb0tQbGJ1MkgzbG5XYnZEZmM1Znp2Szh1YmNqMGZwaGZtcjlZbDBVLzBI?=
 =?utf-8?B?WmtscENiVDJIbnBEL0FnYlBPQzlRbGdYdmlnVk1LRG5CRHY2QlhNN25tQ0JE?=
 =?utf-8?B?ZzBYbGF3dmU3RjljNmgxQytHRWtPeWViNWRzUzV1dnhUczdORDFXYmlmS2J5?=
 =?utf-8?B?YllZdTUxaUQ4Q3JaaGhPcW8rMG16NVJBSitEaWdqN1JyTURFMm5sVjJCQjd1?=
 =?utf-8?B?SUEwVDB2aGhhZ0VJVXBiTUJTbC9UdnU4R3NTbWI1emora0RaSFBXUVBjdjMv?=
 =?utf-8?B?ZVpVQlp0OTRiaFk3RExpQVg2Z2plbGFLcWdBVTlXZ2QyZmV2N0lEemNnbEU3?=
 =?utf-8?B?U21HV3REYU1DSW1WSEZJUlNXQTg5bm1mSms1ajhEUms5amQybXpWZUZkMytl?=
 =?utf-8?B?elV6UE14YUVzLzJRdXZ3aFZnVGE2amQvbzJ6SHRlVUFJT0tXKytMKzlwT1BP?=
 =?utf-8?B?R3V5am1BL2FNK2ZpeWhNVDd4YkJEVFVPOFRHSjdQVkt1NGxHZmF1ck51N3BB?=
 =?utf-8?B?QXNLa0lFT2lteVlKbm9TbUhEMERCMjRRN2xxUVYwdnhwR1ZhZjQvVlhqNHFl?=
 =?utf-8?B?QktEVUtscmdnTGRyU21FTjI4WFhKeERLMEgrTDhPNyt1RkR1YVQ2Q1ViZCtv?=
 =?utf-8?B?bDUyQmIxdUIvTTN4QlBhTjVYRndtMVpDOEhpUjBNVnBNSTRKeWVPZWNwQW8w?=
 =?utf-8?B?RTU0VmY3a2w0YnB0bWdtTTdDZnNxemxhZ2tHb2Fsa094M1BxdTk2bzNoQzRv?=
 =?utf-8?B?Tmhqc2tUV3FHNTg1Yy94djUvUDFTbUo0Sm5xWnpzVFRleVFZVlN4V3dyOGcz?=
 =?utf-8?B?TEN4dng0WkVRVDhDQnZNOFdwZnhqNkJ0Rm5ZK3Z2dVhlOHM4ZzlOckNoMHh1?=
 =?utf-8?B?R0xNVW9RVzZtcU5ObmlkMXBETGl1NEdyR3VpVFY4OVVPYU1wYzEwZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7f5605-e5ce-4a1b-069e-08de5e41e6fd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8450.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 07:50:27.9806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDG3ymxrUmHztPgf9vDHsmsEa/FYJY6jxvlpthGFuOsd971oKcSJYV+bJ2a+SiBgNXQIlZdg4rkLmk0/sMJqqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20702-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,gmail.com,ti.com,live.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peng.fan@oss.nxp.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: C7AB59DDBF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 04:00:39PM +0000, Sudeep Holla wrote:
>On Tue, Jan 27, 2026 at 02:47:33PM +0000, Peng Fan wrote:
[...]
>> > > >  #include <linux/mailbox_controller.h> -#include
>> > > > <linux/mailbox_client.h>  #include <linux/io-64-nonatomic-lo-hi.h>
>> > > > #include <acpi/pcc.h>
>> > > >
>> > >
>> > > There is a call to mbox_bind_client() in pcc.c that is declared in
>> > > linux/mailbox_client.h
>> > 
>> > Thanks for raising this.
>> 
>> Check again.
>> 
>> include/acpi/pcc.h includes mailbox_client.h
>> 
>
>I see, I missed that. I’m fine with removing it, but the commit message
>doesn’t really apply here since it’s getting included anyway. I don’t see
>much point in removing it, but I’m fine either way.

I will remove the change to pcc.c in V2, since this driver uses
mbox_bind_client().

Thanks,
Peng

>-- 
>Regards,
>Sudeep
>

