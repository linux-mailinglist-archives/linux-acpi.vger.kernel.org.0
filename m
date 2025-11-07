Return-Path: <linux-acpi+bounces-18679-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC36C41C55
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 22:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8BBE34C15F
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 21:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AFAF2F1FDE;
	Fri,  7 Nov 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUTfR0zq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA072EDD7E;
	Fri,  7 Nov 2025 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762550571; cv=fail; b=eVrewniwlUDKgYAdsbtVB4Qwt4qWEeLSC3Kd6vPUhmdLs/r+QS1CUVdpenWAi4ZvNcM+8a8ZrfMwmVE0bVMxlpIF5+mnOncy0IfhriHRzAz2XJqBVdYsl15Xp24R99Y1VALTdM90BfUOKV/FxOCCjlsx7KyGpDqeLetVjvdPDHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762550571; c=relaxed/simple;
	bh=VFRza2m/DC7jXphAIg4VSp0DB9/e7cznYUXptYXOlDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QhuLKY4bVzvCcFiS8S9mAL6prtP+Jf5bPm7tdhM7iQwqtz85PMj8592BTDWMdG1R3fIt8Oyc5t/0jE13MfajinacEp83UR3mRerfhtkMD3EsUawAuv1OXHTogavmkhS/i9S4/9jGFZ0wlPOudlgj0TOFJqv5uAK/EX5Qh+uCKWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUTfR0zq; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeTRXFCABzly8cfI96x6oc5H7eDD8WTudxiAtikPZ/vpgH4m+NrmoK13qMdnrR1HA/5dFf5ZMQooYz4HeP+999P9faDx51lY6aWeri90eXWw2kpCDZa/qnNfZZJbq9Jm/XmZPFObBWMTKOXNkgDskRnn9Tywv1K++qW/88dsV9VDwepSRZajLDAxx7dE6BcZY7xYXjJnc/TdO6qClMCvzK32370TTCz0mzh2AIkf92tZUaAANdLsvUAJGIhtUy7FtL+iOpKlNXr93o9Ys9CqUkSQbauczf5tYFGQMMOpFCaweQpxQFuhXLyP2MulBbaqtrkxxwq44rlJtMqO2zejsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBJ9Ptvb/JAWmGXBCIpoliNWM4CIlOEa1lPNfCweeWY=;
 b=R5EyADxrEiK4wVD2ZUhpCaVV1LfIliHlm+ToXPDGvcTQgID+WbVSf75DbUE5wBg55WJVDxtfSLYQ/NKlvB+jXrE//Wgp/6r77u+D5Uz8ibqmZXYrXoS0QaTzyy0vwi2Qq7cLc8zabdnUv6gxDkwbuC0D9tZENB4BWkk5ixIqIAye1q61iGXtSv0uh0q2yxInRX9iDyDMA/JXMPH6QTsVgwGba8rNV3vueRJzoDTLPLcuJWD5ftVDkYyAuulr4rVGiTemWoZD/PjH9uTAo8qUNfFHW9LsD1EMahM6ypTiq9yldDu+V/WYzuXK7+i3hhZWIiFzRRVIWL2nTCQ3KQJHnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBJ9Ptvb/JAWmGXBCIpoliNWM4CIlOEa1lPNfCweeWY=;
 b=AUTfR0zqsXOlNq9MCyt/REbuelkHfbDs8zIgKaaB8npZYTjby4YX2wMtBGagQ0TJo/y+ec23VkqJJkwlVLokOS8+B/C8AyTjhPn91j+TXtxSPr/8ic8DoQBLzAUlVag/c8btV2YXCuX5KZ6Td8UlbFhecoE8aMSN24Q3THvs7FMYU3TLC5Xy69f3jKgWOpBmT5C3MASTIuffP8ConWx5xaldaWQicjQ2GVCN7CL8hIUdHX6vuiaP+YB33Utf/FvFYYHzBuyjfrBpSujb1wHeS4SJADWnCMe6QWj7nUszOqqKX+d0fkzhg+kQ2947sY4klvRapimEFY/acl06i2MUDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 21:22:46 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Fri, 7 Nov 2025
 21:22:46 +0000
Message-ID: <2f19b56f-04b3-4b37-99b2-0fa22473d13b@nvidia.com>
Date: Fri, 7 Nov 2025 13:22:43 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] arm_mpam: Add basic mpam driver
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251107123450.664001-1-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: e79581d5-b33d-4f5d-a262-08de1e43cb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VngzYkoxQVdRaCsyMUlSckd6aG54VzVtOEQ1cVBlVW85TmZ3TVZRUWl0OFZ4?=
 =?utf-8?B?NjB5Rld3WGtmU0xxMlZWUWQ4QjhtdjJZK2lCWXYrV0tpcU5NUEk2QUx2NDd5?=
 =?utf-8?B?Q2JFYldtVTErTHpRMzhWaXgvMkNQZExob3R5QTFQZ3NYUUVrTDllUDI2WERB?=
 =?utf-8?B?Y21nZnFDajhZMCtTZ3JFVXBJRjY0bElTU1k1U25wU0NhU1A1bTVoek1aY3VC?=
 =?utf-8?B?S1ExdWFZM3JMZlN0TFJCS2FscFZMUUJLWlRUK2wvVEY2dk5OV2N6ZDUrYmd3?=
 =?utf-8?B?dVoyb3lCOFVxekQ0dGVxNy9WaTE3VDgrZFMwcHVueU9pYmZkdEkxNGw1RXJv?=
 =?utf-8?B?Qk5zdnE5R3pRd3RUWSs5emtKaWk5U1FyM21nU24vbnNIZVN5TE9nRFRwOGdi?=
 =?utf-8?B?dzVQekpLQ0VITm9aTkRxdHlPT2Y5blRIRHkwc3JZMHZQU0JkTm1aeURlZEFm?=
 =?utf-8?B?VUFCT2xZd3dPR0NEckhYVHQ0QVM3Q1NrWGloellWRkRyWlhjMUl4eEZCbGE4?=
 =?utf-8?B?bFdiQ0xsMnpyaTU4bjdGWmVCREFPRG1jcmY1NGFTNjV4YmdjbmJjRHhoSlEv?=
 =?utf-8?B?Zk9wdmZ4ejVVeEt3NkJ6emRRODZOa2NBU2R2SzUxQlI2dFAra1NzbThMbW5N?=
 =?utf-8?B?MkF4NHJaNC9wWWZDTUFNRks1VmJDV2VHd2xCeTBIK2dqU2IrdS9MWXMxaXBO?=
 =?utf-8?B?QkVodlVHcFhrMG0xajRMOTBYMzdXcHRERHpzNnZ4RXN1Q3NPYWxKOGh6RjYv?=
 =?utf-8?B?Q0x0RUtEUUl3ZzdDZlMvVi9QM05tTDk1RWU4dXFpVEFUdk9UUytpVUtaaTRF?=
 =?utf-8?B?Y3Y5cXAyalJKeVBteDQ4SjJtczlrNEZGaU1lc2J0NjUxOWMxekoxMGUvcWtK?=
 =?utf-8?B?Z0N0QlQ4OVJET2tYK2hnWlBQTDZHOXlhYUs1eVdFVFNHREVHMnN1bTBEaEZ4?=
 =?utf-8?B?N0cvOGxFVHZ6ejVNM2kzUVpHbW1UeFVUSTVEaHlUaHpjMmh0eUl5MStSUCtM?=
 =?utf-8?B?NHRQREIzM1llVWVwajQ2WWxGcitoYTFXRklDUDNSb3ZjSVJZblZweDFDeEUz?=
 =?utf-8?B?ZWN6azNIWVM5ZGU3dHRxUjRsanNxSWdCSDluN1RSdEhya2xwV01kUnovYlFH?=
 =?utf-8?B?NVJadW41MUZNRVVuSkRzSFFtYkREWEUydGNXVmhDbXZJVGlPS3JXQUZSY1pL?=
 =?utf-8?B?V1R3amdnQzN5WE1kUkR0U2lYUXlrVG1wT29tT3Z6RkRJWXpkeThaRkdydWpB?=
 =?utf-8?B?d1ZIZzBQTlF4Um96MWpxYVhlUnlNUkdsTFE4Z2gzZXhtRWRLL3ZlVC84dWYy?=
 =?utf-8?B?MzNINGM3c3ZmcGpkanN0RU51WVBnR3cxSXZ4S0FkRkw1STJzME1uMEJkY1U5?=
 =?utf-8?B?eHBmUUJKNkZaSk5Ed2dIaFZ0T3pyd1ZPL2M2RFdSNTRNSHlCU0lFbnpqaENu?=
 =?utf-8?B?MjFNR0dPdm0xMTQzRkFPR0dWeTNZL1VEbjJ3NmRwNXk3Q2FIRysrSEw5bmF0?=
 =?utf-8?B?ODhLOXdPSkhtK05FMVV4WXNVYUtydk1zcit1UWlML09qTE4veWdCODNHQTZi?=
 =?utf-8?B?UlBnSWtnUkdHeTA2RmpFMjh3cEtzZHpUSjBncHNTWC8rSnNRN3VvL2JZSWdx?=
 =?utf-8?B?S2ZFaUtoK3NRM2Y5VXYyOVlGTVhvMDQwVEl3V2lPRTE5MjZ6UndZWjhiakpP?=
 =?utf-8?B?bkRLZDRnc091dUhFdDh1OW9LN2l5RkxlUFBkdlRuQjlHSytEaEpuNDZJZUtY?=
 =?utf-8?B?a0pKaVY2MXo0VytBQ0lFUXNuc3d6S1FOQkhTOHluOHczOTBWWHp1SlFZTWZY?=
 =?utf-8?B?c3lYYkVKSGVJZCtRbFloa3QrOTFMczZueXEybk5pQVU3ZHVyT0pmcUpwVzg3?=
 =?utf-8?B?VUVDN2EwQmNhQkhEVGRTdkhVU3ExdHUwenA2M1pURWZ1cStYNkQ0M3hUOXZa?=
 =?utf-8?B?OWhYTGl5RHoyeXhNaEh3ZlFxMDFFUktGMzNJZGZDOXFKcXpxN1prbkVrVThR?=
 =?utf-8?B?dDVKTitlZi9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjYrSUFOV1lISkxuY0tsaEhENmNva1JFUksyM1FzbmYyVlQ0bk94eVNWZ0Fz?=
 =?utf-8?B?OXBjaHE3K29IanBNemozSVBWMW1LNnhycDFqTWdJSjJORlczUk9Pd2NobEw5?=
 =?utf-8?B?Wm9mclVLNkMrc0tGRlpZQVZkaDI1R21EejFzVlJEMkU1SzNIZ1hSQUluK29l?=
 =?utf-8?B?V2R2QjRleDk1bG1SeHJpRG1iVzdWWldEb0dzSUhlM3FNRWM4R0puQUlHZzhE?=
 =?utf-8?B?WWY4cFV0VkhLUFJXYzV6b0ZzZnFCcldHT3NTaStTaDBvZk5OUCswM0JxTDlk?=
 =?utf-8?B?c1ZQTGo4U1hlcHY5WllDSkl3YVhxMFZ4QVNEeGI4S3QvTklZcXkwelFGNE44?=
 =?utf-8?B?RS9GeGFuRzdjQ2pLMjRFTHF1SklKR20vMlpzdUxJRnYwZWh2QVA3SWhTbmxy?=
 =?utf-8?B?Y2ZIN2hrMjg0MGRsU3dxN3pWRDkrNEI1Z1Fna3lFMm9CVU9tQzFhWDNCOEpo?=
 =?utf-8?B?cDgyMEdjL0FkeHhYdk4vQWdsRlZqRjJMbTJ2QlJYNE5CMWw5MmkxL0daZjZn?=
 =?utf-8?B?cWtyWUdVZlI1Qkpmb3ZGTkVkVWE4ZkRWa210a0poazZWQ0hVd0pmOVAwNkNt?=
 =?utf-8?B?bDUxbGZVUVNHMnRwTTRBZ0dIbHVESzRaaDBsWi9vM0lybXFMQk9NTC9mMDlk?=
 =?utf-8?B?M203SWUzQmZsUU5DSUt1MmRnVk5wdmJHTTZjcnZTekkxOGQrR1ExR1E2STlN?=
 =?utf-8?B?V1ZEb1paaVI3MkFnMk0xTGhzcWtLaFJud2dvY1ppY0FvSnh5QVE3cFNsV0Ju?=
 =?utf-8?B?VzdqS1RHRHlBUGcwNmo0Rk5RdllkUjJJS0F4T1paUFdzckRJZWcyZUVPYlcz?=
 =?utf-8?B?OERBbGV6YUlZS0wvQ3htUkVrZnk3UjhpT29ZUm54WjkyVEhSRzdzd0JQYkJP?=
 =?utf-8?B?NUhFYkVUS2pkdTdISHc1UlJ2OHJyS3JHMUtuMzN3dFlxdURVak9tdEwwcGwv?=
 =?utf-8?B?eW4vRVl4WVF3Y2NTTXdvc1k5dHNUTXVYcE9tT1Q2ZVdQd2NiKzJEbzAvTDht?=
 =?utf-8?B?LzFMOHBZMDBKSysvd0tKNzJYZmV0VUxTczNoZktUMEczVmRobEI2Z0JWKzJa?=
 =?utf-8?B?dGhaeUFjUVZhU3VIVmdMdnZkY3NBT3ZJZ2tWV1pTTzJPWTlJRVlYdzBKeEs3?=
 =?utf-8?B?MnNpMWFmZXhPdXhUbGZSRlY4OS9JOHd1WHYyUU8wM0lQcm41R1MrUzN6bDRk?=
 =?utf-8?B?SG1ncG0rY0dzVllPWlVQZ0t5akxSMUErVVN2a1lseVk3NG5RZW5mejE0V2hu?=
 =?utf-8?B?bVE4WUUySEg1RHIxVmRqN0laL3Q1NGNpQkZ1S2I0QVdJSTBBY09qcktoNzhz?=
 =?utf-8?B?SnFaaG5wRWdrTXVxQVd0QzJrd3NCTEFMWWluc2NOcXFEcHh3bGdKYXBGRkY3?=
 =?utf-8?B?SkVnSGVxLy9WbUkwSlNaRHdXM3JUNzRENGZXUnd4QjR3ZUpSLzZRbkIxYnhJ?=
 =?utf-8?B?RWttS1VwZDFjekRPVzF1UnhuTnB1cGEvcGovOGhQR2hVNUs4SnB5c3N0RUIx?=
 =?utf-8?B?UFZQQlNHZkdKYXZhL1MvRXY3MlZRMXNHTHJrMEFIdHVyL1ZJNXRCL3huME4w?=
 =?utf-8?B?VU1ZcU1kNy9VNEc4Z3pvUkhSeE5iRUhndFJoSWljdSs2ZzVxTXExbHFMVnVM?=
 =?utf-8?B?enk5aEkzTUJXaWM3WjlaMmFTellYVFZJZ1BFMzZLVmczczd4QTkvdEQ3TFZh?=
 =?utf-8?B?dVZIU3oxZjhCdUQ5QmZSQU13b2JvY2htcnJON3JqdHM3ekR4MFJlQU9INmNz?=
 =?utf-8?B?eGpLOXhRc3krKytBMzMxMFFCc3FuUGNSR0JmZ2tmQk5XS1p3VEhHUXJ3bGVq?=
 =?utf-8?B?c3crV25IY2xNM2F0R1E4akVrWmExNjl6MFZlUFp6YnVoN2d0Z0NiendDeHNj?=
 =?utf-8?B?Wmw5bnJNd3ZGVjYvc3BuRmV4ZlF1OENFNEFqSUhTWXFnMHpNTlBsS0dvQmNS?=
 =?utf-8?B?V2lYZkJBOUZBZnZtYWtGQ3ZzNk1FM2tLVldNRnFsN3hyYklhVnkxYldDM25H?=
 =?utf-8?B?UEdHZWNrem1OM014UDhUYWpTTmxYTUhnR3NyT0JtZUtndkZRQXExeGEra0JX?=
 =?utf-8?B?YkYwSjRYS1BVK1JsNXYzOTl5SElEckhZWlp4eFNvZEpCbFdqNUNnVGxsVUgr?=
 =?utf-8?Q?s+LXwTUii1cZJbBT0ZTXZeJh5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79581d5-b33d-4f5d-a262-08de1e43cb77
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 21:22:46.2495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6XIjw+JbvDzSeyAAr+NhWGDClHGEJ/I45xGVpsTjrJD/8xg83SvMV82FM39sV//nI+7G1hIa4yX0qzZRaRA1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629



On 11/7/25 04:34, Ben Horgan wrote:
> Hi all,
> 
> This version of the series comes to you from me as James is otherwise
> engaged. I hope I have done his work justice. I've made quite a few
> changes, rework, bugs, typos, all the usual. In order to aid review,
> as Jonathan suggested, I've split out some patches and made an effort
> to minimise the amount of churn between patches.

[SNIP]

> This series is based on v6.18-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v4

Build, boot, ACPI parse, and Kunit tests pass.

> 
> The rest of the driver can be found here: (no updated version - based on v3)
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1
[SNIP]

Thanks.

-Fenghua


