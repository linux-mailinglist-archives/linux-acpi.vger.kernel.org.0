Return-Path: <linux-acpi+bounces-8440-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44698782C
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 19:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02FA71F22B9A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E715445E;
	Thu, 26 Sep 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="D6cu8zt7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2110.outbound.protection.outlook.com [40.107.241.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EEE322B
	for <linux-acpi@vger.kernel.org>; Thu, 26 Sep 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727370765; cv=fail; b=aihDwTGTnHIHCq6Oz9EkwaCynnYc8IVG91tvOybH+3EW5Id1UW/UZ0kcPmnelOTcb36iqVWvAFWwl6DbDerrkxKAtdT+ymAN6vbA4rGqIEGmG679usucZcF97mbRPz8zuI19NfcR6PXNEHr8fqIfoetREKuCtVbbiq0tONjZxV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727370765; c=relaxed/simple;
	bh=I+JAWQzCMVzIMGy4dux6m3fCzsmW/qhB8R0fqJBeuEA=;
	h=To:From:Subject:Message-ID:Date:Content-Type:MIME-Version; b=Yo39BAp40TJVarF6TlhxGc1DIDc/yTvODJat2uvuk1c187F7AVGpTovd6RCfkMFiU7DAmOiNvN/Kw7wuxM55GqA68+70GclZjuUz686SVLg2wdkOYPRqEkJaock2jOmVLx1/8nekWCGjxNVXcmN4C3g0pTQaej7CCfJV0QpH4j4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=D6cu8zt7; arc=fail smtp.client-ip=40.107.241.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GxiDK14SX5zVdpCQ7URkAk0BnxzaTaoAWRnSuK0SFblHs0wa4KKVERBReeCPbbszYu9/hT0kXN+GfywEkXmMKbqRzG/DI1GIRz1BbTBuBi7uZwHyGy5weG4mEHT0A3QcwiPvQcwN4HlD+qjXbEaUNX9lOvNIi5l8sRv6i1x8VmjESuGUXYjS+UnqJOEYwuK4+/Axc2W2eRQB8JEIGqR1paWlsE29uOw3bBunherZY8Dvx6BCsFPi8ZJVM7gtQQtoFbyvUgLlIBxPZZxc0xXXkEHjLEDdM8o8FQ7y3zCWLbjlnIUDMEw918dy6KmEc5dD3X0jy6x3liN+QKo4m2tyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+JAWQzCMVzIMGy4dux6m3fCzsmW/qhB8R0fqJBeuEA=;
 b=F04eGiYDvgo+9TcFpyTlnKwcv/zhGEZL0crKTMGIkXkqhE5favfcqHsVktm33fgUnMo6dEDvNk2yqoLqWRZTb8oRr4RO/jI81Fa/vDao3E0dBbKtRwf72Ht0Z1+KetGIKevtRgssPoK34R4XyrX7pbWkCwc3cgMjZskP1JOI6R0U/hhsdVGztymvmxvQ3wN9e4VeLRB6Hfi6lFjeTu6WCyiMcRFbCPKMF+HXuzJMDob84s7CtVzhJpj598SKsQVY1whzSY5K2vnJCSjo+aAPz82LtKFnSa0/PnQ75ZpnJCRTBwwOdT+5H17+SreNZnRjDwVWlwO8/73ww2qZzFOcgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+JAWQzCMVzIMGy4dux6m3fCzsmW/qhB8R0fqJBeuEA=;
 b=D6cu8zt7B1kv96g4Xx7rfK7OGUmXLl4c0IGJGX1quAx/chnT/vQlNIgyDrvbjLQaXOOQ/9Lt07Z82bku6+N2zsE7FriHtT2r7pQpyRxRdyIingNMUYhItiFN2FprvTuom2BcsJQR8fuOi3oEPd9WBJ1L/Rr7wmON3ib7mGq09LA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ef::11)
 by DU0PR10MB7553.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:425::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Thu, 26 Sep
 2024 17:12:32 +0000
Received: from DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:c1aa:6bc9:ca4]) by DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::142d:c1aa:6bc9:ca4%7]) with mapi id 15.20.8005.021; Thu, 26 Sep 2024
 17:12:32 +0000
To: linux-acpi@vger.kernel.org
From: Gilles BULOZ <gilles.buloz@kontron.com>
Subject: How to know what is causing many GPE03 interrupts ?
Organization: Kontron Modular Computers SA
Message-ID: <2b036818-daaf-17ef-d0e2-6540285429cd@kontron.com>
Date: Thu, 26 Sep 2024 19:12:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PAZP264CA0049.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1fc::16) To DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:3ef::11)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB6252:EE_|DU0PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: f5371bd7-212a-4cec-1d04-08dcde4e687b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzZWcGIxVVgrenJLSEkvV2M5bTRMMkRjUTNTSVZUZFU5ZkVoRzhWZEVWODlh?=
 =?utf-8?B?Rkg1VDFMdjl0YXVFNmRXNFQ5akJKY0RSb2ZUWW1NRnh2aXllczN5NW5ZVFNt?=
 =?utf-8?B?b2pYZjlwK1kwamo1OUZQZTN5QTVnSGtTdTlLMHNhRUZkVDkxTjN1MHM0Y25v?=
 =?utf-8?B?VmVIanp3ZjBuTXFNV3BSd0pMQ1hCTWZNVlc5T1dLSlhlWmhhVVN0M3FQQ2dO?=
 =?utf-8?B?SUNOdC91VW94eWk3bk1oc01uaTdMNEZnYk14N01YblY1aU1JenR0bDExSlFP?=
 =?utf-8?B?cWt3dWdoZnFvOW9pKzM3amh3dDh6bXB3NGNIVVNYcWVhY0dkYUFFTm14NFJC?=
 =?utf-8?B?cnFmRFk3czFnOFBpb3ZidFZxbmZ6S0FLYTh6OTBkSVFkQnFSTm1MRnE5TDV3?=
 =?utf-8?B?RElHOFZKUTBZakkwUERtMDc1ZHEzcDlFUzBEa3RNc2oycHM2QjNmZHVWYTJi?=
 =?utf-8?B?U1gwOWk0UERhWERFdnpnaFFvcHdOQ3hCOXdvcmZrRzZJZEk0dkY2eFEwVW1i?=
 =?utf-8?B?QndzczJPN1M5cllsZHBzNlM0dWZYVFVwRkxwUzY0RjFlQko1YTc0b29QcmFJ?=
 =?utf-8?B?clh2cUdBWklDYVRhQkcwVis2dDIxTjJONGlCYWF2N2p0TGR3dWRoZzgvblN1?=
 =?utf-8?B?NGYrejFSaXRPN043QWp4U1J3UmVKK1lJK2toOU1rSGNpSitaRHhpNVAramN0?=
 =?utf-8?B?VmRBdUYzMFh4SUJOUHVFbjZTdi8xSmFmeERScVkxcUMxbSsvUWNPTmxSRzdw?=
 =?utf-8?B?WlBOczZGcmJOdDdsUGxZaUY4TzhwWCtHcHAvQXhpN29Na3pzN3hPN0pmV3c2?=
 =?utf-8?B?Rk1jblo5L1dwRFdRQm40L0VWb2s0UUtaYWxMU2grT0s1YXc2QmNsY3lHdURr?=
 =?utf-8?B?bkJoMW9UZlNxcVlRbFhhMGt6M3FkVFVMS0FLTndiZDBnOFNpektZd3NVUG9I?=
 =?utf-8?B?N3dKSEt1NUxzbUlZcnplelI5c3hsMWNwRlhNSld1WEsrTjk3cTlzZ2xEdVRz?=
 =?utf-8?B?MW5ZTmZJVFczOUNVVWdBL21tdkt1ai9aUFgrdGFTMmJ3STZFMlJQTWtvMnV1?=
 =?utf-8?B?MXZoUmNJS0dHc25wYzdHSUswS1I0RTBJZlVZeHlJb2Uwcy8wYXR6dTJsTTFn?=
 =?utf-8?B?QVdIaGZuZTBlTWNnM1czamVGa2RZL1pNZklRbkZLVC9PQVpucVRobWpBQVVs?=
 =?utf-8?B?Nmp6dTZxUG9aV2U4Z3kxS1JqN1ZMc0FDSzcrbHdhREJVYkMrQ3BMdEpIQm9M?=
 =?utf-8?B?c0E0OC9LbkJTN2ZZcWUrdm52dWhoWktONGVWVzl6Ym1qallIbXpOczJPZk1I?=
 =?utf-8?B?OVZNNmtqQ2FqM2pCeVVkWVZ0Q1dFTlBYMUJMUHQwVVRSSncrS2o4cEJQQjcv?=
 =?utf-8?B?MmRPZ1lta0hzdzljWDN3cHRqa2FEa1luRXJkSC9tM29WNS9SN0Z6VDUyM0dU?=
 =?utf-8?B?SzJsUXNKeDFjaHlPTmNZUGpldUhzYmhscG9CSXltT1ZlQUpHNnlieTJ0aDhB?=
 =?utf-8?B?Nnc4ZDdVWElTMzZhdDVTWDNGbnpJSEgydkRtS1JJMG1PM3QrL2JiZ1FiU0xX?=
 =?utf-8?B?anNNdEJtNWNpYTRhZlp3YTA4ZisxZTdIbTRia2wwQVA5bzhyYUlXek1MNS9W?=
 =?utf-8?B?TXRBSE84RWFod3YzblUwNUF2ZDBWY2tEdTVRTCtjd1JLclhIYWNHcXBmVXBL?=
 =?utf-8?B?ODB1M2wvVXJqUnZ1TmdPeDNFVEJZalIxUlZLNmlXQlQwTi9oeVlScXd3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJQVy95YmdXMC84V3drRkFyTVpVQ0pqeDJVNTFtbVJRUWpLRG5UNktsQkRE?=
 =?utf-8?B?Z2pZYkxEWFYzT3ZuL05jRC9zSENjNmR1eDhDdFBDWDQ4S2IzMkIralg3LzFM?=
 =?utf-8?B?dU5OUHRvTkZsYjZLQytlWjU3d0FhN0UvY2tMbjQzTEhnMWRVWmRUUEptNlBQ?=
 =?utf-8?B?N0RBRVZnaGNXRWZHc3ljMFFxZUZrNWprZGJmNGVOS2RwMWovajFaOHRtZUxh?=
 =?utf-8?B?aUROV21WaUFiSGY5R1NLU285TEptVDR0Um5zUnhRSWU1eGZ4Y3JXRU82NFkx?=
 =?utf-8?B?WmtrV1hma0ZRaHFBV0NYZWJqN2ljL3BwS1gydWI4Vk1IcDYrbktvOGZqSUVX?=
 =?utf-8?B?VFp3YzRjV1dndG45dTNBa010L0FJakRSNitMMUh4cEc4NldGZE9xQW1UTm9P?=
 =?utf-8?B?MzFsU1dJUS81d1R1czNoQzNFN0hITUM1RHZrTlVWblFtWWF6ckVnZlE1ZitO?=
 =?utf-8?B?NzRxU2srNFNXYnBLQk43TGx5R3JTNEtpUXZoU1hLY04zLy9OcHJlRFRPK0Ra?=
 =?utf-8?B?bHUybFdaeEtLQXlCajg3N3VaZ1AyVnBWcnM2cXNaLzhnRVhqaUVZQVY4SW0r?=
 =?utf-8?B?dWh2cHpvSzNSVEs2QzVTOEFadHFSNzRoMjVjV0ljWXBNb0wzT1piVWxVNlJD?=
 =?utf-8?B?V0Q5ckk5WmZaaEdUQk1rcUY4WEdOKzFHWXlnV3V0T3R6WjA0eWc4VThyV2sx?=
 =?utf-8?B?VkpDang3VlNYSFJDVUk2MWFyZkhuZEFMaEo4eGZvQkFCdm9QUzg4WmhvZDlU?=
 =?utf-8?B?YVM0WkU2YW1VRnJYaTJHZGVka3owdWpySXo1VVZmT3poSVVEdko5OE8zUGMv?=
 =?utf-8?B?ZUlNV0Fkb3JsN203enNTeWNuM0VBUFFVa0lRY3RnaXdBRlRFOHVuazBaL0Jw?=
 =?utf-8?B?OE11OFk5UUU0dzVlRlQyNDBLWTAyQ1ZINjcySDRVcFR4U29lMHo1czMzNnQ4?=
 =?utf-8?B?S29Rb0FUWG5qVEsva1NlN0k2YURBUjNVS1ZXelYzTTlPNThjckdYY3lKa3lz?=
 =?utf-8?B?L3YzZzdxN2Y5aFlzMFJIbDJrekZqVnRBdUUrcFFWTlNWNEtHYVRvNm5ZU2xs?=
 =?utf-8?B?VElZY0g1SWM1bEdoNWZWUXZuT1UxeURSZ3RML2VPaHJQbGR6aUhESkNlNVF4?=
 =?utf-8?B?enYzcUdlc3NDczZNek5JWEt1QW41cGZOZUgxbUQrRnoxZ1A1cmluTGg0cTVC?=
 =?utf-8?B?T0JXQWZpd0ZkM1NrdEMyZ20va0IvNlVHYXIwVDJoS21POFpwUnp5ekt1b3Vj?=
 =?utf-8?B?UUJVdXNzWUl6Q0EyeUNMUHhnZGZEK1NKcGlHVFhMSWZNZnFYdWVpZ1Y0S3BH?=
 =?utf-8?B?bTlIR2RmMG80SC9MaHl1enJMWm1VT0RLN2oyczBhMzNMQjB4eXVXeHdYTTJH?=
 =?utf-8?B?d1dXN2hxTXZVY1owMGQrMjRKem9nZ29WZVFZaWtLTUxkcHFPNnRUc0ZsSTBS?=
 =?utf-8?B?OTNXVXJNVTIzYkFHd1A3d2t6MGQxTHZFeStBMFY3VHQraUhtZStjMWdFK3l1?=
 =?utf-8?B?akFwaW5jRUFEMEh3aVFjblFKaG1wbjlSMzBKRnp5NzBVSnlGWDI3WFhwc2NT?=
 =?utf-8?B?R3FuK2JGZnBkeEdhT0xNN1B1MnM5Rk8rQWhIaWRJQ2ZwVTdNVi9oNWN6NFBR?=
 =?utf-8?B?R3RjWUZiVFRJallWSWYrZEphVUFFY0hla0tGSms3MnpVVEVGOEIvZU1PeVJG?=
 =?utf-8?B?eVUrRUZNMkE5UURqZ1p6VWhnMTFyWkFLMTg2aXhWRmxvUHB0VzBiN0RmOVVC?=
 =?utf-8?B?djRzZjdRSTQ4cW5wakUxbHNKem9Wd2ZvSFVpNjJhZzVHUWJKbnZrZ0pKQjUz?=
 =?utf-8?B?MCtBdCtOYTdvMjZzV010L2VJYXd4aWhIM2c3SWZYS3FoM21CamxZVnpZRjNW?=
 =?utf-8?B?TnMyRlZlMFNibjZ3UG9GV1dzSlkzczNETDAwWm1KT0JQbkdHWjBHcGthWlBS?=
 =?utf-8?B?aHRyb1NiaVAzT0JlcHZ5UGpkOUI0SFhQbjdqMTQxbHltcVZKTVhyYmIwTUVO?=
 =?utf-8?B?VTk1T2dsQVFnUjViZE5vZ1NNcDdyN29FOGd2L2EwNUlmS2pXbFcrWFRGTjB4?=
 =?utf-8?B?ZkxucXN4SGNZdUJCRnVDaU56N09TelB3L1orSGlhN2QxUld3V0NFM2x4Vjg1?=
 =?utf-8?B?by9Nemxod3BFbWFvTmhtRS9lNTZGSWFsOVlpQTFib2t5UUVzeTg4MUxxM3py?=
 =?utf-8?B?Qnc9PQ==?=
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5371bd7-212a-4cec-1d04-08dcde4e687b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 17:12:32.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxW3mGbLdhS0+muojTIk6gN9+3cmF/8SBRUf3M1xOZ89N6F6egVCRuRgrHRv+WTse+NxiQabiCtnUdzxuDJ2OTUF7plgS9tTyc21RyzUT/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7553

Dear ACPI team,
One of our customer gets a very high CPU usage because of many interrupts
reported on /sys/firmware/acpi/interrupts/gpe03
I've dumped the ACPI and disassembled the ACPI tables but I'm unable to
find something obviously related to gpe03 in these tables.
I'had a look to drivers/acpi/sysfs.c and related kernel sources files in
the hope to understand any possible link between gpe03 and some ACPI
definition but at the end I'm lost in space.
Could you give me some tips or point me to some helpful document to point
me to the faulty hardware pin or device ?
Thanks very much for help
Gilles Buloz
Kontron Modular Computers


