Return-Path: <linux-acpi+bounces-21313-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AF6nJ/Ybp2kUeAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21313-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 18:35:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C11F4B1B
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 18:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25EFC307E858
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9148095B;
	Tue,  3 Mar 2026 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1H+/Wj7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012007.outbound.protection.outlook.com [40.107.209.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CB3BED7D;
	Tue,  3 Mar 2026 17:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559185; cv=fail; b=kmFbyssyTRciJiDX27Pdv4IMBmxRdznkYTumkJ/ED0JW2XE5Fp83zU7w1bwB7cDio43LrJCEAZ39P6igcC/h8Qx66+nkwFs9cMDXa213dx40G3/OoP1afuoSbEYPCaNHl++2OvFontyKNUbAbgYyVzmOMhFp674PsP7RppRcDyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559185; c=relaxed/simple;
	bh=e4sYtq0I+Hhu2C1K+SGw+TEPfN35XYUM6jK4Gq50Vp8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cpDLOkbnfAqhz54/vsEeJIN5daMMoZ5H72O2Llq0N5X7pIX6cMDEPALfkBhQRbcSwPU7lVpczTQjfvzeRkjFgvoUtu7GnCnkoXyS5E6/29t3+8ZBb5wz+tH1q+/zbUYeow+JMT9h/+L7BOTbAbMM+ZjBYf20OK06bOLp8vxVw9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1H+/Wj7; arc=fail smtp.client-ip=40.107.209.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bl+R0xbf7clHyKAkKDLRCHxUl6CLFbA1X9HRK7AaEWJ/PsTT1qFnuHXIVm+XP+ykNw+dpHP9ZvoiG0m5OreCXZcreE479Lw/Z8xmmWQjg6TpyvrvIzJBzESj5GmFaGA3bWYUf6N2lEkpj3fIM3eIk9ugkswsO/Pqj7W9cTsk0ELDlNUw2IyMN/bJET+c+OlFCUdy5Lk2zTtFeYtvc9jRk0BYAZmd1+eXX+Rnee5UgDjfIcIsOqphQLuRe4gMXORSuJ98U6NNaXAgWtcVaSloZ8fyXa5UuUlTTqPc/7hIZAeEedqE6fPlVq3GCYTcL0o2gh1yYWZArTTDahFaV4qHog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJScsBtqVNP7sJ+Pm7/oen+PiT0zJQLonM1mP7RzOI8=;
 b=G3HjhjRWHGLbUGxLvMLArpQLZNFmn8bGxO8eZeRaL//1DKtgBlOx91YDGIgyXzlBwe38hxBI2aplUblEEdZd4MOlNkWZHUd/SDKlzStJA+b7i28kQ8BlPxSqSyLeeDL8odcU+2+dSfK0+lIwd3FD8Nw0g36IULTZICoqG15b18MB9WzTw+jOdw4m/O6WJb/jPaUS9PgjQDhOJRwPlCsuiCuZZHsjpN6X6c2k8eycvYIUx5zZTMc0kRf30C5dFhYL5Wae7VDag5NDy8yia+8MUaQTf9X1obGfXeHrY7fVBA3SeBb3l59H556oWsQQ8gVL5nijFlAI3DgvdouFYyxgqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJScsBtqVNP7sJ+Pm7/oen+PiT0zJQLonM1mP7RzOI8=;
 b=m1H+/Wj7JYTSazM3ULsujtrIy1x9FvG034n1rZtA5T15Pa1yCsOrwSaMVVBwU05I2asEh7RgYxgVatMMGDLx/aBmU+9byN4h/85Se05BSYAEj8OmGheCKkVTV3BEPnguAQsX2XJARpYGkPiKAJ4NdX6cnY1HB8gxW4/WgBBMVi2poOmdAwNE1qFyWryz6HdGtykfxw+79S4hwYn+TPDITt5CINxPDuv1XZ5LuULu8LIJSkQ7kwxBESmvYCyn/VOlOTHDWHmGA18Xot4JFYPjQ5TeVcMipRU9SB1mAUna8qy5UMP+bF/rEqvDYeal+dPY1aiMpUn271k0Woq2OdT0cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by PH7PR12MB7137.namprd12.prod.outlook.com (2603:10b6:510:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 17:32:43 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%6]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 17:32:43 +0000
Message-ID: <48bdf87e-39f1-402f-a7dc-1a0e1e7a819d@nvidia.com>
Date: Tue, 3 Mar 2026 23:02:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/7] Enhanced autonomous selection and improvements
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: viresh.kumar@linaro.org, pierre.gondois@arm.com, zhenglifeng1@huawei.com,
 ionela.voinescu@arm.com, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, rdunlap@infradead.org, ray.huang@amd.com,
 gautham.shenoy@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com,
 zhanjie9@hisilicon.com, yumpusamongus@gmail.com, dedekind1@gmail.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
 ksitaraman@nvidia.com, sanjayc@nvidia.com, nhartman@nvidia.com,
 mochs@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20260206142658.72583-1-sumitg@nvidia.com>
 <48b52f98-119e-4693-806b-78d47f7a43bb@nvidia.com>
 <CAJZ5v0iOsqoZx0EZ3AqEk_8mrGxSj6wj-m8phRJ0cT71NTuBWA@mail.gmail.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <CAJZ5v0iOsqoZx0EZ3AqEk_8mrGxSj6wj-m8phRJ0cT71NTuBWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0124.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::13) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|PH7PR12MB7137:EE_
X-MS-Office365-Filtering-Correlation-Id: f7efd4d9-fe6b-4bd7-12c0-08de794ae04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	JDHzVck9TUQu5dwNk21Nxqu2txLyvc3khKVt/q4MKcJTBDjfk1BjoaqFtWkbRUamQF/kkUY4mA5imAURTy2kOS4fU3/3vSyX1t9WviWWyU9kY2tKufH9xmO9EFKp3K3EPZO5apGjk1EsLl9uu9ocWUmlp/H4c091Pt0E8EdPq5YegO1e7g5POm6PQquBAwkAGBM+FkD8saKqq9tNxs5gOkssJv/1A+3/fYSdT7XuP8nDIGfWtTKlxnqXQQfxEVy7oNLP/xiguib0oWhq6uAT1lMwwo0Y40SkX25nqRpGMuqa1asvLsdTjyrVR5HE1mLWH8eiAAwGhLQKU1mm9AxtlCQ2c724aqO99s7I1Z1tjoxV8eaz7e4+AtDXD3lAHW8uhjOZkPKWJG++ohJVZxmgxNN1fixgiYgbjsH/bdZ4iUm3AHmiWP7+3RpEGxkMAA73pA1R7xIdfAynfWSweC21A1OCU+VavOqsJU+XYKgLuqSYpQ9GaLTnAhC9v4VEdP/OCqx/t69pNf3nOwyFXeTseyOXYjlrED9ISdRwXY4FtEFCtKNxeb6Zfzj9UOFaBDL2crSiA3zR4xASTCDrox2RCIz937BkJjHrZjZe01S68MjhDx8ugoCblwzSvauPm2Q0MJ/mNnl34FakQ3wD0+YZTTQ1zbuBQB5UGDC6D9Yr1nbp7Kp3r5D6kqXusaZ9lckz+qt4f3gLSxB1uRQKOAG2vnXqml31mYM9OykmKe+jYy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lCRWtxTXlOYU5oRlBXS0ZNQ01jb2wyQzVORDlWZ1dMQkZ5UU5DRVNGbXNT?=
 =?utf-8?B?RHdZZjNFS2RNdlNmUi9BMHlTUnV2WGIwZDVNMDhreEZyUFkydkJydjRrbjJM?=
 =?utf-8?B?V2NVQjdWK0NOSHRndHozaWt2eFlpNE84WDFCUEJ2OG81TU1uR0czM0lsalgr?=
 =?utf-8?B?L1FEek4rREVOaU52Q0Ztc0tYeUJreC9zSklkZXBONjROMWk2dDR3cXZxS0NS?=
 =?utf-8?B?cUtXa1R0aUUyQUhnM2hRNFM3V2tOZUhQbU0zbWFKVEx2Mlg2em5NUTZnUTMy?=
 =?utf-8?B?dFJzTS9HcGxaVldndmJJYVoxNjJSTnJoYitSUE1KYno1K0xMcFU3SUlwdXE4?=
 =?utf-8?B?QjlBUnphQS8xMy9FeURzTktPZWFNdUVnK2lYbHViZlI1ZWdRY2dUcXFaTEt4?=
 =?utf-8?B?UTVaaHBaQWRGd3RlVUNSUlZEdTlDdlpqYm5DK01BcXEydlpEbHF3K2FMK0Nh?=
 =?utf-8?B?Q1RWVFhNaWNrd2ZBbzJBeU90bFkxQ0JkR2poUmZTSEdxYng4b24xdGJ2RlMw?=
 =?utf-8?B?WjVha0NOQ1BRenQ4a1V5UzRwZ1Fpdk41Nmg4M3J3N1FjQklvc01IT1JOQWpO?=
 =?utf-8?B?d3NrL2NyNzM3YkYzNjMrRy9lK1RBN3pyVzM2dEE2dzczcGlaaG56QTdXZXlL?=
 =?utf-8?B?Uk0zbHJxYTFYM2VGdlBqOUpkV3VtbWpyUDhoNEg2NncrcTkvTlJMUTNUS3dx?=
 =?utf-8?B?NGR6M1VBaDJVQjlWR0g1ZWNIcFFFYlRKR09QTWZOYThFdVFiVVlJY1pkOUVD?=
 =?utf-8?B?SzBwTTJKQyt2T0t0UDRWb2pkWkNiTHFDVDk4NHU2UHNqMFAzVEFxNU4yQXhO?=
 =?utf-8?B?bnlhRmkyc01jbDR1TVhxN2VoRTh6SnUwR3J0d0NjZ1pIS3BIbkgxMUJNZGJC?=
 =?utf-8?B?K05vSDl0M0lJVDR6YUFlalhoRjhEQlhCM0w0T2MyOXBtblRCdkVXUVpCWkx2?=
 =?utf-8?B?cEtKSVk0MGVrTk54RFhZU3FCdzBFeEFob3owUXdwVzgwYlVnKy9vNGdpRFFQ?=
 =?utf-8?B?anlQeTB5R0pCc0NnVDF3NnQ2RzM3ZWYwS1MrSEpoTmdqdHBmSElYaTV3SFRP?=
 =?utf-8?B?NGtMRXNHQ3Vld1ZjeHltZFBpcWNwU0toTU03YmNRanJ1MnlMZUFpaVJ4UEsw?=
 =?utf-8?B?U2E4c05OdGJDRlB0YTYxeHRNblc3QnExWTVtbHZGVjU0TGhxR2w2ajQyUldl?=
 =?utf-8?B?L1hJYWNKeHJGME9WVHZSQ2FkTGU3czB2cjFOZGhXMmpVOFFjaGpZZE9qRjQw?=
 =?utf-8?B?Z0dNQlRudWJjYlRNN3pFMUNoQUxSWmExaXVxcUZsZjVyQU1RYzRvdmVNcnV5?=
 =?utf-8?B?RngvcUhZS1ZUaG9rTG5OSEpJbG8rTzNsT0J5ZUtzNjRlT2tka0lIWHdkMDZY?=
 =?utf-8?B?eERoVFZaTDNxMGVjZFZvNmhndWt5WTNXRmNmSVRwYU5YSmJqQmwvNVk4SFdl?=
 =?utf-8?B?QW9uZXlYSXhjYnZXZXV5OWl1azg4Yy9XTVVyWktQUzZyRjZBMlFSU095eC92?=
 =?utf-8?B?SFB0T0pNK2N5RHRDMUFrVGdJMTJPYW1tTURBa2xZeTk5Znp1Z3RWRTVZRFRE?=
 =?utf-8?B?T3RHOTRaWUNQL01oc3htbGM4Q3g4N3FXRlNCajNyclYwZko3WXM3UkVzOGxj?=
 =?utf-8?B?RkxJTEVJNEpBZU5MTWlNMzlOdmp5RGR0U2pWOENYc0U2L3htWmtzYmU3Um9I?=
 =?utf-8?B?OGtlMW1CSW1BL2s0OXpLYVZXWmVHNHVVQndCZVV6Q0k4MjVZcHE2NnovMHBa?=
 =?utf-8?B?dTVLSjdsYU91Ni94R2pPS0QwL1ZXbFlVTGNscFhmbG0xcVpiTWoybG91UlEx?=
 =?utf-8?B?aXhjb25ybHdrcVJmNWtYamRKVnQ5U0cyWlpzcVN2N1lpVUJYeWM5WEFWeloz?=
 =?utf-8?B?Q2o4WlArNkhNWElXQS80dUhrZmYwMjM0S0xRb0VnN211a0ZMMCtTNlViZllk?=
 =?utf-8?B?bEdEMWtLYTY4a2JDMWNBRTdTRGYxS0VsUkcrWGh1TlVOL2sxdHNpZm9GMnYy?=
 =?utf-8?B?SEpFR0JQTU1wZU1mOC81Mzl0QmV3VzI2L2VUandla0FWcHc3M1B6SmhMelk4?=
 =?utf-8?B?S0QyWTdtcjNxTmwwNVNzLzRUUzJFbWJ4RVAvcnFFMng0THlOaU9nZGxSN3VS?=
 =?utf-8?B?aFhhbFcxckJ3S1kyWHhRSndMNFlraFNuS1NxbVYyUnlFWXlQT2E5ZkkwUWdF?=
 =?utf-8?B?dEsvOHd0Zy9xRnJMckNTRFBZdDJHeTZlbmdHb0J4V1paWVl3TmZqTFlENFRX?=
 =?utf-8?B?dzA2c3hWclg0eDYzZndhSkF6NDJIejlIOXc5SHpBQmVqZjFsZTRzSUFvaGNx?=
 =?utf-8?Q?R3VGcndE/kgp3iWl/r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7efd4d9-fe6b-4bd7-12c0-08de794ae04f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 17:32:43.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKspsO7exci1MEpFKBqdHOkGjE2dqQS+7/igbb205z2dTJW92tXHfTdvRZOJvycM6Nf6egSlbfe9+9PBsnuN2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7137
X-Rspamd-Queue-Id: 420C11F4B1B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	TAGGED_FROM(0.00)[bounces-21313-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linaro.org,arm.com,huawei.com,kernel.org,intel.com,lwn.net,infradead.org,amd.com,hisilicon.com,gmail.com,vger.kernel.org,lists.linux.dev,nvidia.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sumitg@nvidia.com,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On 28/02/26 02:06, Rafael J. Wysocki wrote:
> External email: Use caution opening links or attachments
>
>
> On Thu, Feb 26, 2026 at 2:59 PM Sumit Gupta <sumitg@nvidia.com> wrote:
>>
>>> This patch series improves the CPPC cpufreq driver with new ACPI APIs
>>> and enhancements for Autonomous Selection (auto_select).
>>>
>>> CPPC auto_select enables hardware-driven CPU performance scaling using
>>> Energy Performance Preference (EPP) hints. Currently, there's limited
>>> runtime control and visibility into CPPC performance registers.
>>>
>>> The series adds cppc_get_perf() API to read performance controls, updates
>>> MIN_PERF/MAX_PERF in target callbacks using existing scaling_min/max_freq
>>> interface similar to intel_cpufreq HWP handling, and exposes perf_limited
>>> register via sysfs to detect throttling events.
>>>
>>> The patches are grouped as below:
>>> - Patch 1: Add cppc_get_perf() API (independent).
>>> - Patch 2: Warn on missing mandatory DESIRED_PERF (independent).
>>> - Patch 3: Extend cppc_set_epp_perf for FFH/SystemMemory (independent).
>>> - Patch 4: Update cached perf_ctrls on sysfs write (independent).
>>> - Patch 5: Update MIN_PERF/MAX_PERF in target callbacks (depends on 4).
>>> - Patch 6-7: APIs, sysfs and doc for perf_limited (independent).
>> Gentle ping.
>>
>> If there are no further comments, could this be considered for merging.
> Applied as 7.1 material, thanks!

Thank you for applying the series.

>
> That said, wouldn't it be prudent to check cpc_read() return values 
> everywhere? They are handled quite inconsistently and this series 
> doesn't improve that. 

I will send a follow-up patch to address this.

Thank you
Sumit Gupta



