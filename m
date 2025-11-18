Return-Path: <linux-acpi+bounces-19027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A37CDC6AA68
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D4E83A2DA1
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E33557FC;
	Tue, 18 Nov 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e9fA6fp5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646E328B48;
	Tue, 18 Nov 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483051; cv=fail; b=hPtl42X30ZmDNoY9x4900B6sNt5KVzffuyew47FrWdasD0Xs9FBm3NgFdxgyz6SinEK+pZsIPlx+f6Xt3K04jkiX1JwvNU6A4rQ5TSx7vvGeI84juolfV2n8QE6nNrT1boHNKxGQOJcE9g7LlBBV72DFKRN4qWTUc2G+9Lwl9ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483051; c=relaxed/simple;
	bh=uvp7einneaMz8OVr2SSLL2CJoScWqyWmbIl7p6uU4ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oL3awjgVWCL9yF+y15+lThXseuGvwwPsdbFHK6MtFQhgeuo8PBoRHlZMvVaGIcxQI7ZXo4FUuoHFSDgQqN3wxlUTKmjQKFIiQN8ts1DrpgJ6Eu/IbTGhNBZHx/GiTq/LDRAQpwxl6r3zjPb9em/rM0tdS8vvTjLyDHS6RR7wkQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e9fA6fp5; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxe7lmuk75e19K2d4KA+Nh399KavYgw3ymiPOevLiBj6JKZCwfs3EQpRnX7cXHs4ucgm2d84YSn0Q4QiuVEQJ7vq6lgjLg8jNsI1+YUHVeGlhbQTmPz0AmGD3c4ThU8mdaAa4tOGrzkS2k/AOPWLcNYRUqX8FG4A57KlR+7RJsPiFN8hxoIwZY8T963s/BwYfjY6UCndMzvUmKEC5k6lQQtQWA45w09aU3ulqUBPPsBJkqhaPwhmxW3HtLkBccYSEryTyPNSu6nElwLg5D+t3YOTc0UCO8MK9LRBvDrJB4moExhsI7nlmAx5WdzABReXTQzXpmIkaA97Rkydu5/A0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T7RpjBwBbLA1zDoAp3NuEowZM8miZTR+5hPBN0IyOz4=;
 b=S4sQsqSh9NVNUjAi0dp2w7XtLlAD36JwEb/8y3UYhuRPR9PGQtgmQMbe3DYDnwnnoVah+vYahol9qUTJiCrYf3rZHkl4aP8AJoyMazDsUbkm641hn3TnAT7LorANScddxbloAl2bzctZEZeq2gSLXcQfnNZsBk/3jRkhYKRX6ztpAgp+TJNeZosD5TIDUuWPf/35tNScUzkrqKeuvlHOCJVDl5wuXx89HhAOUKy0BMmJbUDSinatK7MZQQJsDwqs9R74L91lgm7warGaOfqVbVrK3a9+/0Cq4dqzk6UbCBTfmR5uDPp/BPqOZxO4h6FROwNrgANRROL8JaZdHe2bVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T7RpjBwBbLA1zDoAp3NuEowZM8miZTR+5hPBN0IyOz4=;
 b=e9fA6fp535lxtr6pzhzosljMAbp3rrPmIoPgAD1XIM3veadOtdkRVR1hUbWhMnTvC8rq+9ZrPvfudQEpTmspFB6dioeisitvAprbHOwHrOTHwZpV+R4cZlnscIde18AWE7OJk+WcSIlICwmSWkMAOckvBXK4iW2da+dYTTN3m6IY/xG5kqU9H/mCHNrCfVjkulrN+yYxaHXZa8X0Be6Enm+E8Mn4caXhcJCk3CKS+EO0V9/rNrCeBpfuyk6VPNmWwLX9HBWlvSorfouMzBLcbj0E3sWTpm4ntKMw6bFWkCeZdnfo44Mdb/tqpGshSB+OC/WS1bJwXAKeIOawNaSUdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS0PR12MB7780.namprd12.prod.outlook.com (2603:10b6:8:152::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.19; Tue, 18 Nov 2025 16:24:03 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Tue, 18 Nov 2025
 16:24:03 +0000
Message-ID: <d555d2e8-2bc8-4be8-af13-3dc3ffe9b8ca@nvidia.com>
Date: Tue, 18 Nov 2025 08:23:59 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/34] arm_mpam: Probe hardware to find the supported
 partid/pmg values
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-15-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-15-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0109.namprd07.prod.outlook.com
 (2603:10b6:510:4::24) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS0PR12MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f17691f-9eb7-400d-59e4-08de26bee33c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJMdUw2clRiQkg1TnM1RHo0LytOUEdESGw4SmRtNnJUTUFvT2hDZjliclJp?=
 =?utf-8?B?eEZMMTI2Nk95cUJtOUtoSWNBSVM1M3lOKzF0aWRQRGxvUDQ2UW9LazRCOERv?=
 =?utf-8?B?K1NwalV5ejNZKzNJUTNxRExveDVFcVl2ZUZDV1psdzJ2K2I1ZjlFcEFvQ0Q5?=
 =?utf-8?B?Q3pnQ0E0Mm1sM2tFMnpBeVllMHdDN1RUMmtPbk9HYmNITnR6STljVW5xZ1BP?=
 =?utf-8?B?VVBuTWNUYlVVZklBeFBlVFRxb3d3dUhPTE5CZ3BoYi9wRklNdG9NdW10ZlBi?=
 =?utf-8?B?bTA3c1JXM2lCSWtWUGcrU1Q2eHYxRnRIb1dDdWE0QU5oVUZaMExnekpVVnIx?=
 =?utf-8?B?c2NrcEdTd09jenNMSFRRcDR0SlZLc2grenRCYWNRbGZldytTWFljZ2FEUzd1?=
 =?utf-8?B?cDB2MXVUZDlwMGYycjlPdGkvRm01NThhbHB4UnBEVlBWd1dDRjBKY1BTK2JZ?=
 =?utf-8?B?NUYxOTFmZm1uMWl2MTBScU9XK0EzWnVxWkdyZlppZ2duU2FSL1EwdmRIZ2I2?=
 =?utf-8?B?NzFHRHJNK203WTN3eXhJWUlvSkZpMXRjamZKU241U0dBQXVKUFNUNXZOU0pp?=
 =?utf-8?B?emZoNStETlBHQytKM1I5R0tEWHZWUnhEMEF6aXV0ZWU3akxnMVV0amNrRjdn?=
 =?utf-8?B?MHRQcUlrMjRPRkpoNXpOcVFFYVlrOWRxWG1DZWZ3ZjI5WlJZVTh6V0FzUHJw?=
 =?utf-8?B?S1dGdmdwcFVoZ00rSVBnbzQ4YVNRM2VoZ0pvK0xpbGlSdE1uSFdHK0JsTGRN?=
 =?utf-8?B?UTFTNHJHSlVZNmtnSGx2MWJTOVJSZTFHZWpjdHd0S2tOcXRaOEdTaGhFNUJL?=
 =?utf-8?B?Q1NrQ2drV0NUR25hd0hac0ZsWXJsbVJWVHkwelVwMlV1M0R1dlpzdk9xQTh1?=
 =?utf-8?B?Y0R1TXRqUFg5MmQzVDh1RzFCeGVUUHFiRkVmNVU3VXBtRGxhWGV0REliZmxz?=
 =?utf-8?B?Wi9yQ2plb0NZQkpNZ3g4UzZZNFk4bmErOU1nNGdKYVNmLzZldlYrcVA1OFpQ?=
 =?utf-8?B?dXpvWTJqdjQ3cjNnbHFzbXNJVEloT09Zbm9MdnlNd0E1dWFrbVNlTkM1MXRp?=
 =?utf-8?B?NWhEYTNTVGE4TFVWVHNzL2ZKZmhsaUtHOTRsMjNOekk0cUlVSHlsY29SaWp5?=
 =?utf-8?B?d093bFF3SURab0FOZHRleDkwR2xFK0U3ZElpanc5RWRvWS8zaGhFazJVcHpy?=
 =?utf-8?B?RzNvc3ZXWTI0MXY1dGxnOURFQ1ZQUk1LaFhIeEpicHhidkNHbU9Jc2I3Vksv?=
 =?utf-8?B?UjZ6N0hSOW5pSnBjNGFIdzY2aE5lSmZlN0N4bHZMVDY3akNZOEpZT0FyenMr?=
 =?utf-8?B?dHlYUTR0K0gxUUFPLzdBa2dsWWRwdzRWL3NLUFQ1cUVMalZURDRTYnAxM2E4?=
 =?utf-8?B?UGU1Nk9tM3J1VmJHM3ViR1I0bEpUamZhMXFjUXh4OWptanZPOTNvWTJWS3ZV?=
 =?utf-8?B?VmRzSm42amwrZHRIUVhNbUFNdkthTXZrK0VudEM0VmFmQ09jbTNxdVRndFlO?=
 =?utf-8?B?VWpheVZ1NW9XV2dXMWlWQ3RTTTRyZzhyZGVGZW9HbEN2aE5kd0pYSUZMOHB0?=
 =?utf-8?B?S3Q5ZUZOckF5MVpjai9rMHpDVzhSY3JGMXJrNis0WDIzNCtyUC9tY0szVEIx?=
 =?utf-8?B?TXNuRG5obHdPVlg4U2djb3F1VkMvdmNNODZ5RHNtZElQdEFsaFBsbjVDc0dz?=
 =?utf-8?B?L0NqQUJLbElTZUxrNDcvTnhLMlpsUjVXTFA1OFc2eFU5NnNrRHU5K24yMVpj?=
 =?utf-8?B?amlmb2tIOW5SZ1c4b2JsczE2L3g0aU5hS2FpYWs0NmFEY0tUSHVVZ0hEY0ZG?=
 =?utf-8?B?NUpydUtCMjBQc1ZFRHA0MWZCL1JtS2VBbExNSlhmdjJrcTBuRGFZMWlhZFNX?=
 =?utf-8?B?Uk12UGIvQzhVRFZzT1Z2YVVSME94N2VCTytlVmdyZFp5UUpJVUZHTGhpS2du?=
 =?utf-8?Q?819GHT566JvoC7nENUZpUwRY4fQWq6Gr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDBFUXFJd2NvNEFhOHMySjRmajBEUkhFVkU0MWs2UU10NkJheFVIOWRHWDdr?=
 =?utf-8?B?eDFCWDZuUlNaQW1GMFF4RWF5UEVHdmFsRHhjU3ZEblp5ZWdDd2l4TFhTYjRo?=
 =?utf-8?B?dFM4RFFnNkxyY0lqOFJ5elFQdlNFWGNrZnQ5cFdZWWhIV1NYa3M4VWVBdlAr?=
 =?utf-8?B?RE5YenYwWE9UM0lEcEx2SGhTNlBJY2xUWVRzeGRNcS9iR1M2ZGt6eW1lQWFn?=
 =?utf-8?B?Y0hDbGRyUVFDSVJLd25QRVhBMzVwc1Z4c2I4d1FmeXVXMGNYOWs5MDUwOEZs?=
 =?utf-8?B?NWtBLy9ZK1F4UGNJWng4NFZjU3FWdEowYzhhKzB4TjdzQjFEcHFqWkdobVZI?=
 =?utf-8?B?T2tISXA4S0IybTZnUnlDcFBoNDV5MmVCQm0yRy8wZHgwM0Q5QjI0TkpHNTE1?=
 =?utf-8?B?QTU4bmdTaFhEMTR6ZjNOY296VUhoWk1IcDVUbFN2T2RQanJ0MHdFSkJiaVho?=
 =?utf-8?B?ZlJtb1FtTkUvMjRTNno1SUg2dUlCUVNEcWg3TXRwNVgySVlBQUQ0U0dsQThu?=
 =?utf-8?B?dzFYZjlwTkZjRVJacFJrTHZQUTBST08yR1Q5c1VxRy9HRUp3YWRNUGNZc0F2?=
 =?utf-8?B?Vk9nSkRUNTAwYVNrSDcwZlEyaDFjOU1UM3VIL1ZCM0FocHdISHJ4RDBsTE9v?=
 =?utf-8?B?elpPeFRXZDVZaWZ6V04wemlhL1FnV1ZNTm02MmR0N2pjMTV2bWN5OU5yUXR2?=
 =?utf-8?B?aStYTVFxYkNhL1gwNlR0aWlScGZsYkFwV21JVVAyVWs0NWxMMGx2eFM0RlpW?=
 =?utf-8?B?K3hza1lPNXN4ZWlFOEN1NkR0MTU0M0Z2S1dJRVB5azlhVTdFckZUQStVS2RL?=
 =?utf-8?B?dGU2U0JrZVg1NVIxb0h4Z01kMWxxTk9CaVlrcDg0OE0wVitPdVo2MCtyUjdN?=
 =?utf-8?B?N1lxU3BsK3lrM25EdTFwSldvbHgzczZPMW8vMDAzYkFXcGZsNVpPelJZOXVo?=
 =?utf-8?B?dG9aRmxCbWxGZkhqTlNZb2VFWnVXclRUNEJxTk52TnYrY21uQzFzNkVzbHE4?=
 =?utf-8?B?Y1JDY3hxR052eExnZVlqN3RzMFFFODdxSzduNk1yUHZLWDNtZ1hjUWlQWUJp?=
 =?utf-8?B?ZGdjTmJYTWd2RERQL3N6dFdzbGVOcWhHbk0rZDVlZUZsbzNjalJqcXdSWEpU?=
 =?utf-8?B?azg1TmQxTmlmaktmOFp0RmlIV0tGeTZlajlTbG5mU0tGRkZqSEpFcWdDWVFX?=
 =?utf-8?B?MERiWXJUZDRhZE0rK3IwTmFyN2xFeVp5cm84cm9BNmE1cXpheDhQeFNFdjJs?=
 =?utf-8?B?NlVxb1hOUjBacmVMbWVOUWlQV1BaYW1GR0VpVkllaWl3QUo1ZktuemhrclhK?=
 =?utf-8?B?Mlh3eEZqbzV4UitNdWRzU2JVcXFaRXRiSmVMVzBwam5rcVloZHEyMUFnNFls?=
 =?utf-8?B?R0FnRVRMbXpUVDRBaE5ldFhmWjdiVnRya0cybzdBZjV5TFJZQmw5dEpxdHlk?=
 =?utf-8?B?NThsTGNGTW9zc3VvTlMySWJkRTZ2b1VLczNqSVdjM1FqSmRpNzZzODJ4akhi?=
 =?utf-8?B?eHN0OVFqOG1kRGM2SG15OHBlQ3UyWHdwUncvdWQ0VEdHMU0xV2pKNTZnazcy?=
 =?utf-8?B?Ymtjb01lZURSY3hIcWJiaUoyTWZqQUk2S1RCYUl5U0RBYUJkYkowWmh6TWNJ?=
 =?utf-8?B?UDVUM2lqNXFueE5RMW0zaGttUDRlcERYZVR4VEJ3L29rWVA2eitIanlPN2RY?=
 =?utf-8?B?S1JGNzV3WTFPd2plVUZVM2FRd0lua21PZDNBa0htbjJKR0JzcHRrZGd3emZs?=
 =?utf-8?B?YXZQbTRuQ2RHVEVlZFlzTUh6K0cyM216TDNVS0ZQcXFRTXZSOEtuMWRIZlFz?=
 =?utf-8?B?S3pMaTJnUWsvMUdwdVJncGYzL2VIQU1yY2FMa1Iva1VxR0RCUVZ4aU1KMkdj?=
 =?utf-8?B?QWp2TVVEZ05xR2ZwOFJQVFZ4VHBPU3kweGk2T1dBQ2doVHhZci9uaVRNak5s?=
 =?utf-8?B?VEZRaGdtcytka1QrY3B0ek9IVHFVRUMycjhtZTVPUU9acmlnVzRUUFQ5dm40?=
 =?utf-8?B?SlRlbjhwbGxXRmlzU3d5SW5GdnR4d3UzRVhZc1FYc1N5ZCtHSTVjYytQMXVv?=
 =?utf-8?B?MUg3TlArYURPTXZrQzJTdWprVzB1eTFrY0VjMzh6MkZZY2VzbkE2c04weVov?=
 =?utf-8?Q?4Mom1tqtyJebvJWenYEoK/zdB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f17691f-9eb7-400d-59e4-08de26bee33c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 16:24:03.2727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGGnOg45f7XCHjG7nCmbo3XaprxVugDtIVhB7bqh5TcXfLIwICRINwkzYFPepZ7zVQYYSG522V8fvILYHRVKIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7780



On 11/17/25 08:59, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
> 
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
> 
> This adds the low level MSC write accessors.
> 
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
>  From Jonathan:
> Stray comma in printk
> Unnecessary braces
> ---
>   drivers/resctrl/mpam_devices.c  | 148 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |   6 ++
>   include/linux/arm_mpam.h        |  14 +++
>   3 files changed, 167 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index 51284f55ae9b..ac1c770cea35 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -6,6 +6,7 @@
>   #include <linux/acpi.h>
>   #include <linux/atomic.h>
>   #include <linux/arm_mpam.h>
> +#include <linux/bitfield.h>
>   #include <linux/cacheinfo.h>
>   #include <linux/cpu.h>
>   #include <linux/cpumask.h>
> @@ -42,6 +43,15 @@ static atomic_t mpam_num_msc;
>   static int mpam_cpuhp_state;
>   static DEFINE_MUTEX(mpam_cpuhp_state_lock);
>   
> +/*
> + * The smallest common values for any CPU or MSC in the system.
> + * Generating traffic outside this range will result in screaming interrupts.
> + */
> +u16 mpam_partid_max;
> +u8 mpam_pmg_max;
> +static bool partid_max_init, partid_max_published;
> +static DEFINE_SPINLOCK(partid_max_lock);
> +
>   /*
>    * mpam is enabled once all devices have been probed from CPU online callbacks,
>    * scheduled via this work_struct. If access to an MSC depends on a CPU that
> @@ -143,6 +153,70 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>   
>   #define mpam_read_partsel_reg(msc, reg) _mpam_read_partsel_reg(msc, MPAMF_##reg)
>   
> +static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +{
> +	WARN_ON_ONCE(reg + sizeof(u32) >= msc->mapped_hwpage_sz);

This check may cause false warning when reg range is still valid. Need 
to change to:
+	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);

With this minor change,

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

[SNIP]

Thanks.

-Fenghua

