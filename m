Return-Path: <linux-acpi+bounces-19485-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69813CACCFC
	for <lists+linux-acpi@lfdr.de>; Mon, 08 Dec 2025 11:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB348300AC2A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Dec 2025 10:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996502DA759;
	Mon,  8 Dec 2025 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Op4LJDUc";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Op4LJDUc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013043.outbound.protection.outlook.com [40.107.162.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498E263F54;
	Mon,  8 Dec 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.43
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765188584; cv=fail; b=D3T2gxvcWpIh81CsquunDEvEUuIeSqnBhPmhn9iepUJFsyFN7HVG/3hPGPrst7i7iUdbAf/oP1xyCpo+4BCODxP9Q95OCdbLXZKMac298O5qrE9nI1ozeYn16O//7pGzT4WLDxeKQ5UpAHee5UwK2PV01CW6q62d8g2wWCWZKO4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765188584; c=relaxed/simple;
	bh=lzPQztIpM4MGvItWr0tRcnabyRP6Qq43ZVmbmV+1V8k=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gr/hoyZuhpWrrvocBU2PZwqb+QJr7FRRqoH2Sl94B6xTNAJ2thE4/Tfvzfyl8VaZF82PeVnLfCamjUY1TWkCYy9Gukz8/U0dGwQX3o/7B9+0G8SuJVNkT8ymSfGWCTEgBkxJ079YN5Pw8MpYQwBX0BBWLO6+g43vSjWetonZL3k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Op4LJDUc; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Op4LJDUc; arc=fail smtp.client-ip=40.107.162.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vr6U21VKJG91Tf7/nincp/AMTj/iIHxBbRQdAUNweMtYcvWNT7EpU8r2saCvdhQDV+XpxePZPWZZCHAHoXSQko+hYZrYyYDyfZ4fOkfEfA9QZU40x9ml4V9ZHRo1bRzh3krk9wbARpyTPGR0SEg1q+QYcAKbZZrSznDeza/Ftczzbb7DrX29gz3UJ2kIb3q22uQ7GjFGEf8kAoaR6n8K6Yk5TpU0fL8AyL6oaY2R+3CAYuzMGDSIUx6rBjMeu7bI/GzWN24sGbWIxIcPLu/qcBnDsKTdP8jAdosiZQvielo95gFNI7kBUIF/HrZ1Do7XbRtSS0eGEUMSPuCvrmYxug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78T2sSBF+2fuVV2Agl/HbVclSOUmTIOIaDdb9JGO2LA=;
 b=NOgE0Lo5rIJWx2ecUp83atBfgsIcBW+gwfyZ0MKLdnPTq2DqrcUrMRtvEpmGw7+ZCrmXTs9aHr8NjCGoXyPzWeQ8GC62drL6lD4C2aH/syLDy16BRjg/lTgfwSC5AyGYLivkE5If/KF5evUSU/vOIBl0635lmmiokOSSFsZNzfVFpeov0cgfSb0A6AkhHJ6vLoyVRWZBAzTftBo30wOaz1/OZPIGejQLKO4lUu1MrKuTHfSRX4VNAT9Bsnc0NrgUm4vXhaBdX8Y2mnqwrnMqsM772z+na2T0MBJFb4lwclQ+lTwE7s2TWCBMZcyxaoMht4ylwVVwLi0WdPmUsM+sGg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=hisilicon.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78T2sSBF+2fuVV2Agl/HbVclSOUmTIOIaDdb9JGO2LA=;
 b=Op4LJDUcwd85xtVegTdOnLEtRMcDNgK04t1erCue9DPScuonKYUFgAueP6USeHS0RmoJRx8kg4QfGWS3W2yZk06RkS8mzENDm6B27t7B62qcjLIpCIHdULytk5lqJkwX7CrLaqXg5jd+Pja8/9gutdgIp/SOd11SVux4XUEyhP8=
Received: from AM6P193CA0123.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::28)
 by AS8PR08MB9043.eurprd08.prod.outlook.com (2603:10a6:20b:5c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:09:36 +0000
Received: from AMS1EPF0000003F.eurprd04.prod.outlook.com
 (2603:10a6:209:85:cafe::69) by AM6P193CA0123.outlook.office365.com
 (2603:10a6:209:85::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 10:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF0000003F.mail.protection.outlook.com (10.167.16.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4
 via Frontend Transport; Mon, 8 Dec 2025 10:09:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSD7YMsESaZXz9PfVyU87nOMWeFFB1SUJRJK5J7WZbxBDoqgZDsp0OPRlT+b6G1USyFmG+2jelIieLpFVlC6J+PRuOYBhlccB2W0rQWkbKXmV8I7C9qqX4qi6KGf9YJIoAHfzhVp/qtN0m7kWKJx+wjS15DhI5Y9bfQZ74f9OZXbEemw16Q7XSJP9kkwWTJ3uR0tnlWnbN2yn3SM0E6vZd6OY/tafkTK65aOVpHnWkHSujpgisYMoQXAq+uS1h+aWyuAZMAcDGIm1yuy7vVyQCfOjAy2xeqeG897FpBtYulTpkMm08CnUw5ZfToj0RklfCU7T6vrsh2X+GqIzw0XiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78T2sSBF+2fuVV2Agl/HbVclSOUmTIOIaDdb9JGO2LA=;
 b=N+EoYLg0MdDYbDkzTko1wRb9PVgWInGhwXKrqNpbzneHbA3VlLCCTPIclznSvZmeGBjjtWM6o5ojzaaGgpuYxoGHB576sRmxTdmmHp+BjNqD02If3dc/6CbnSIT/ETTFhpEobSsyd1P44mYPdk8SGEzpzilBXyCLl30BZXPNbI9njmEGSd+c+RZfG/1V+vDryxMq9SCkgitSM4LtMduPIGva+2wtlggz1+ppxwV1k4/FSEbjRa7VAcLQpCS2vVM1l0Q/cHYRG0jprBJEjJIRZlM4hXpOC4lOu1suBcpr4Ly5oJm45tTtw+fnXIBMc63QYLOCK2gEkJgK3AzEV/I68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78T2sSBF+2fuVV2Agl/HbVclSOUmTIOIaDdb9JGO2LA=;
 b=Op4LJDUcwd85xtVegTdOnLEtRMcDNgK04t1erCue9DPScuonKYUFgAueP6USeHS0RmoJRx8kg4QfGWS3W2yZk06RkS8mzENDm6B27t7B62qcjLIpCIHdULytk5lqJkwX7CrLaqXg5jd+Pja8/9gutdgIp/SOd11SVux4XUEyhP8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com (2603:10a6:800:20c::6)
 by PA4PR08MB5967.eurprd08.prod.outlook.com (2603:10a6:102:e7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 10:08:31 +0000
Received: from VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91]) by VI0PR08MB10391.eurprd08.prod.outlook.com
 ([fe80::fa6b:9ba8:5c2f:ac91%4]) with mapi id 15.20.9388.013; Mon, 8 Dec 2025
 10:08:30 +0000
Message-ID: <270216de-e7d1-4552-a04f-8b0fd7b79552@arm.com>
Date: Mon, 8 Dec 2025 11:08:28 +0100
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH v4 3/3] cpufreq: CPPC: Update FIE arch_freq_scale in ticks
 for non-PCC regs
To: Jie Zhan <zhanjie9@hisilicon.com>, viresh.kumar@linaro.org,
 rafael@kernel.org, ionela.voinescu@arm.com, beata.michalska@arm.com,
 zhenglifeng1@huawei.com
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, prime.zeng@hisilicon.com, yubowen8@huawei.com,
 lihuisong@huawei.com, zhangpengjie2@huawei.com, wangzhi12@huawei.com
References: <20251203032422.3232957-1-zhanjie9@hisilicon.com>
 <20251203032422.3232957-4-zhanjie9@hisilicon.com>
Content-Language: en-US
In-Reply-To: <20251203032422.3232957-4-zhanjie9@hisilicon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PA7P264CA0335.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:39a::18) To VI0PR08MB10391.eurprd08.prod.outlook.com
 (2603:10a6:800:20c::6)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI0PR08MB10391:EE_|PA4PR08MB5967:EE_|AMS1EPF0000003F:EE_|AS8PR08MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: a77f0c33-099d-4d87-d0c7-08de3641e2fb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?YnFwY1FOL3pkQkNYRWpnaHUvQnQzWG5zZWRlVFN6V3hTZWkzOGhtQ1VsNzkw?=
 =?utf-8?B?dnBaaWRiUlNwbWlDQkRJTzl0dk9nV0RneEE1ZTFHNktGT28ya3d4ZzE0ODlu?=
 =?utf-8?B?OFpqeU80RlNrN3JIZlVPblhBT3ZPemNtcnF4dG5BeVlzUEtleWpKd1Rua2Nh?=
 =?utf-8?B?MUtwZXY4SUcxekNLTW9rWUVMQ3NyRTAwbzVYcStSWjE5SENOTEFHemR1L3FS?=
 =?utf-8?B?SGJpMjdaTTlSUGt2aC9GMlBueExvZ3hLS084bm82QmpmRkt0MDdFRkVLODZ4?=
 =?utf-8?B?WEw1L1pZWWlQbWhOUUFmeWFGYVo5TkxpWC9FUEJ3THJxSmpnbTcyY04rMHF5?=
 =?utf-8?B?SlFjYkNNS0xuVVVPSW9ZdlIwY04wTVJpREk4MVRkSTltZU5xN2JhRFFzY3Iw?=
 =?utf-8?B?RFMwWEJteE82VnRJRGhJNm4yWWtkcnFlZCs4OEo3YktuQTY4NkEweUlHSTdj?=
 =?utf-8?B?d3FVMVpFMzNaT05tb3dwVkNoaTF0a3RlU0hOZFRwQlFhL2ppVUZGRjU0VXdN?=
 =?utf-8?B?UDJlSUhBaEhKVjFiNGNvanZGS1RqTmoycmFIN2ZkSFliRUNyanhpb21rb2lQ?=
 =?utf-8?B?OXJxTUZkcU9xckJGQ2lmRzZER2x5N0FJenRmYW5IRW9La0U2SVFZRG5SeUxo?=
 =?utf-8?B?Ty9NMmsrYmlZa2VHZUZBSGxPTU1Fc29VS3ZraDIxTXNyZHBGS2REMDcwT0tK?=
 =?utf-8?B?MEg1UjVSejREN2J4Zk5tbk5DTkpzcEtEa0tjcHBoZzVZOFBJdURwUEJMdnZk?=
 =?utf-8?B?Wlpva1Rta3J5RWpMRVl1QUVDT2duaGxRQXhtSlUxSTh2TkJZTTlQd2w4R3dj?=
 =?utf-8?B?NmFlYzBvbkVNUEQ1SzJZUzFWOU45by9MYTJMdGdSZUR2LzNWcnQwVmpnRlhl?=
 =?utf-8?B?ME5pak1LWWswclk0N0kzU0R5ZWJLRmNSRXF5ek01RE9seUlkd1VJM0tKQmZR?=
 =?utf-8?B?aXo4V1FCTFZ5Z2dJbElOUThkL0FISHhzdVU5a1pnL0NDdVJNT2drdWVLUHMr?=
 =?utf-8?B?ZklOQWZReWJsTVlIdEp4S28wWUFyVDFzZG92YTNjb0Vza3YzZVVXRDBPckpo?=
 =?utf-8?B?VGphaUs1SC80L2tvL2ZpTEJYYUNBZXUzU0g1Sk9RUTRjb3M1TjB1VERtcWpq?=
 =?utf-8?B?TlRpbEhFTXo1MDAwNnN2RXEyelRHRFkyc2Q5VUlqZVBIVzk3VE1nZk1UL2p0?=
 =?utf-8?B?R0hNdDM2R3dXcmdMbkk5aTlvVEdXTU85cFhqOXlCM2syVzRGNmRjQXVnRmZX?=
 =?utf-8?B?RnhoVWtOQUFGRW1aa1lyQTdidDVrNzNSS2tpVFFybFRqd0w3a3ZsZEMxV0tj?=
 =?utf-8?B?S2lZaVJlRHZzcjVsbk9mN3FzdngyUjlCcXlqMDZtb2UxN2F5OUZKZkc2TXRK?=
 =?utf-8?B?OFNJMHBzcTBTd3ZPVG9kRkhpTU54Q3FNUjFmN21jMnpYUDdmSWRrY1NPRXIx?=
 =?utf-8?B?OHlxeXRrSWdqYStNL3BXUEN5b0poUnFpanhJR0NPVGNQaUc1UDl5QnVKVGhW?=
 =?utf-8?B?R0hJbmxyM2tSTHJYVHhuTUk0aHJSYUt3cUs0cXNSRUt6QnJCUHp2MUgzem9h?=
 =?utf-8?B?SnFuUmpSbmVBL3RsY1poRTcraFlHOTZISC9JWTdFc2FqOEh6VHp1VDJjSUQ4?=
 =?utf-8?B?Z09RYlhtY0xoNUxQZXR5eFdYdWdrS05SVXdHdW9HRGZMNG9kT2hNS1ROczdj?=
 =?utf-8?B?RWdycTJaOFNHU1VPeE1wSXpQUzB4c2RhUmRFSDRMTWVKZ2lJU25EMUZIMXdn?=
 =?utf-8?B?clQ1Ty8wVUlkSXBSMGhjTlloQkJTOVBIREREa1lGUENBRUs4VExoTy9CMCtI?=
 =?utf-8?B?SGlCNmxoODBiMDZBS0VPSWpMYy9KS0QxSVdZOHJuTmt3QmVoVFljdDJVbXhw?=
 =?utf-8?B?dCtQZzZIVkp1aE51MkZZYVpOaFMxVUw0cnRLL2hqMkdiQWlQcVVpMnlWL2ZI?=
 =?utf-8?Q?TiU2yltxXCMID6Es13r64A8/vUH22VTv?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR08MB10391.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5967
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	946723b0-6132-44e2-efc7-08de3641bc8b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|35042699022|36860700013|14060799003|82310400026|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TS9EUEYrRWpXUTRCQU40bGoxMHpMaVgrd3lNWHZTSUo3cmNyVGtMaU10R05S?=
 =?utf-8?B?bmhCWFJKbjFydGdQclpDREZ5OVhXVlFwNGdUZnlpVGdzdGIvNGN6cXlQQTZp?=
 =?utf-8?B?bUJJMVNKdm91WHNFK2ZnbXJOMUI2VER0S0RxMmc2WXMwRDBtYlhnOUdORUE5?=
 =?utf-8?B?RVo5bnY4THcxTFlBVjk2cWNmcHRINSs5emhkYjRHVGFLOGg4VGdGRk40a2J4?=
 =?utf-8?B?VGhqcWJ1VmwydTAyc3hXZG5uNDBQZS9PVm5jZ0syci8yWWFaKzg0RlphR3NQ?=
 =?utf-8?B?YjVjeFU5aEJZdWFmTmNNYlVKVWVMSk0yQUNkSkF6aGorNUFacGdZemIybVpE?=
 =?utf-8?B?RzhoZThmamtidnZzczV3Z2ozTHFjTG94aWd1ZGlHdDZNaVU3cGdqclBUd1Zv?=
 =?utf-8?B?YWJWUE5CbmJTUzZkc2JqdnJaZVEyT1Y0SWtUVWswZy9GUEJORFE3aWkzTjR6?=
 =?utf-8?B?Zkx1QlpvU05lek4zaTJwYUd1Nk56YkkrOVZaVWFFOHJKL05hV1N5bG9ROHE4?=
 =?utf-8?B?WU9kQVJpazVTZnZselFjS3ZnWjFQaitPWkdDeGtObk1sRHRkZnNJdE5UelNl?=
 =?utf-8?B?NklxNGliR1Nad3kzTjJDblFHL0ZEdDdPanovRjhHenB4bWhqZDc0QXR6R3Q1?=
 =?utf-8?B?QmhWcnV1LzNaK3huR3psU3VSSm5tQll2a1FmSWdrSFgxdlFWa0poaC9FK2th?=
 =?utf-8?B?d1QwbnN1Tng2ZlNCdWZFQ1RVWDNEdkZ5ZHhkdGkybTJySkdST0VhNCtha01k?=
 =?utf-8?B?ak5yVlpvRFFxZGlyYjRnbnNpRnNMdzU3S05tcjNXaVhIZisxNzg5QTVVL0o0?=
 =?utf-8?B?Uk8zT2ZjN09zdkoyQ3FkVDJmKy91RFJiY3ovOXRacXZNUEc0YzhsYlNGV21F?=
 =?utf-8?B?eVM3YktLSTNZbW8vYjVrL2xHZ2FyVUdvcGEvZVFIQ2FHQkFXK3pjaWxqU1J5?=
 =?utf-8?B?OEFwSWozcitkL2x4blJheE1neXVzSTFYdGMvaHUvcWs0RkdsaDZyUkY0aFJV?=
 =?utf-8?B?aCtueHRCWFJqNGFnc3lkS1NUZzQya05sR245OFc0U2N1OHQzQlJLbjdHMWVL?=
 =?utf-8?B?UUduNGwrRXI1cjdTeWlLYzZYNXBWalkybFhmUmJ1bUExdUdZSkhJUnF1bHpk?=
 =?utf-8?B?SEptcWFHVTJTcXNNU1Z4ak03K2pJWjJvT0FhVklpaFlRRjUxMFhPbmFxemhW?=
 =?utf-8?B?UFhXWXRJdTNZYWlibXI2NVNheEtGTUZsMkd6MG13R0lEVnM4Z0pPdmlqQ2Rr?=
 =?utf-8?B?UXFOblhyYytncFpBeG9mVldCVnIrSFFsK0hmTklBWWFRMzRBam5tU0g0TG90?=
 =?utf-8?B?aDZiS1RvNHIrOC9GeC9KazV3UjlKY1Vhb0cySjM3RnlEU0VSV0lOZTF2Q0tW?=
 =?utf-8?B?aVV1R3dteWJQcEVVNGpuVHlUdFhyRWxsbXB5RXozWndkeHM3UGpCNzVlMFlU?=
 =?utf-8?B?R1NGR0ZLeHhTNFlwTmxrYWZ2cVRPWVYyOU5zbHhncFNwYmNUWFFibklwa29P?=
 =?utf-8?B?UkoweHNPbi83LzBrUithTTVreW82Rzc3SVArTVZDZjdFRi8zM0FZTkdPMEJE?=
 =?utf-8?B?OXAvWmNZRm1EaG5WVjUxUmNMSHNPK2NFVDBvQXhEbFhXeGZjQWdrZDA4N0tu?=
 =?utf-8?B?amhYS1dtUnJxaXl3cExHRGFTd2hRcmdaa1RRMkNUUFhhOFhnWVllNDJiemMz?=
 =?utf-8?B?a3JBb0JXYUxrRTV0Mit5dWVqRWtEaTYxUVduTDczQW1PNldoY3ZBRjBoQWFs?=
 =?utf-8?B?U3R5VlptUG9nQjhSbm9lM1NSanc4aVVaSStWeGl3UGx2Wng3ZnZlcUJ5QVUw?=
 =?utf-8?B?NGtpbEFIZlhGL1JaalFlZEVzNFFhYk4vWmRhS2ZZb0RCSjFGekxaeitkT0Ra?=
 =?utf-8?B?OFlLTmRlQVJFN0ZZdVhnMWt0V0ppN1Q3bDBVandlMkpxRXBYZC9oS2JrQnFC?=
 =?utf-8?B?aTFQalhRTEhvU21QWU43NlIrM1NlNUxlSTN1WDZrUGlGYWVpbzlqcVpEU0JV?=
 =?utf-8?B?U1V6bUt3RFZaODRNNW9WTmF5QmpGdC8xQ3F4bWdWa3BPOVk3UUxlbVpkV2Mz?=
 =?utf-8?B?eDgzaXBIZ2NlbEEveUZMZ2psN205OVVLYytrZXZSbDFDQlNrQXlBOE01amJP?=
 =?utf-8?Q?fYpI=3D?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(35042699022)(36860700013)(14060799003)(82310400026)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 10:09:34.1210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77f0c33-099d-4d87-d0c7-08de3641e2fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000003F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9043

Hello Jie Zhan,


On 12/3/25 04:24, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
>
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.
>
> Furthermore, with the CPPC FIE registered, it throws repeated warnings of
> "cppc_scale_freq_workfn: failed to read perf counters" on our platform with
> the CPC regs in System Memory and a power-down idle state enabled.  That's
> because the remote CPU can be in a power-down idle state, and reading its
> perf counters returns 0.  Moving the FIE handling back to the scheduler
> tick process makes the CPU handle its own perf counters, so it won't be
> idle and the issue would be inherently solved.
>
> To address the above issues, update arch_freq_scale directly in ticks for
> non-PCC regs and keep the deferred update mechanism for PCC regs.
>
> Signed-off-by: Jie Zhan<zhanjie9@hisilicon.com>
> ---
>   drivers/cpufreq/cppc_cpufreq.c | 77 +++++++++++++++++++++++-----------
>   1 file changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 947b4e2e1d4e..36e8a75a37f1 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
[...]
> @@ -236,10 +265,8 @@ static void __init cppc_freq_invariance_init(void)
>   
>   static void cppc_freq_invariance_exit(void)
>   {
> -	if (fie_disabled)
> -		return;
> -
> -	kthread_destroy_worker(kworker_fie);
> +	if (kworker_fie)
> +		kthread_destroy_worker(kworker_fie);

Shouldn't we have:
   kworker_fie = NULL;
here aswell ?

>   }
>   
>   #else


Otherwise, for the 3 patches:

Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>


