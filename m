Return-Path: <linux-acpi+bounces-8960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAC09B04CC
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 15:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31B1BB24C31
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18DBA1F754F;
	Fri, 25 Oct 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ayXK74NW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0837370815;
	Fri, 25 Oct 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729864674; cv=fail; b=Rdujw0oNAk3pnNDvEHnxQqfh/usq5yx2kdPemrUAHmCSAtS3GVM2oZMjEwDgYoZJcnZvcJvy1LDtdQMNsimGm7MClfskuOODXfMYoAMzDMI4qQydJEZYkjuGQ8fRDRnnrdIdzVqp/khmz9n4CHkuMzlZ0eQV7Fh/UaJvoMSkHYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729864674; c=relaxed/simple;
	bh=D262Vwv71abgTDY61dRhNm+X3RO+XsPUD4RMIY8++Xs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E4OWAIAmL/KC3bWM94156W2uOlpcF66yEID8xoEhiRmhK/R0k9O1r3un+SIwt0jgfuYfueEmFLordx4zOSUF/Qb2iVCuKyaUMnV3nJBtHxo58fmM/x/IH5OyX8nUrYMP+5ixUTw1TKWW38Hn7AzqMP7A2SL7gMbU0QHifSc9ryc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ayXK74NW; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDh4KRrfAS/B1Y6YZIHzL4zRThgR0DIU0Kqgwp04ySb5QAz33a1M879iuyrmLbW06FtlkLSnpyOOANPTAEavFbrUYUo3idVPp413Ok37jlFCU7ZAZtxxPGrAU6E3C6C39Ne6QR439MSAKbLikxFRGkvTq7poIkY9PU1X/LK6DC2QrSQuMEJoSsAWnXzx40KnSVRxvoeNp5s8uBENMUarS/2ydxZZNXaNexpf5tlfANbMCFRXJnG2tmrUPlgQTS3zle59zhYFcjD7bJ4v1JMqWyzfWAh79Y9ipTLyAwPHuiFn0kMLekQQ2Vzka0IrnjtLCg3eT8ktwgt5W0r54ZZluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5LVEQcy6Pci4I7q2nwGo3FrHu769xuq8snEOWStFLo=;
 b=XLTT1nSDogFdKURz70xRx6AkTUCfjTVO98OF3WXgxM2cbcKx4s6LeB65lor0SK0xUBbLjxYvHosgKaDJ80gamyRC5gClv+Zia0/bGY/eF8qDDwIcqwNg7Kjko2w2tlQUAfUV+qxTfoVCW/wkxlRnndlOCu51Mx1Qc9ifyuQ8+JKTh3yXPH8s3pKLQWGZiEIztsUgLRPuUKmKhQdTugQLiWlBQi0Pg0bLEBpghsj0TEIgZbhS6EXlhFUaKQUDHhrXGKfLI+4rxyOKTNiLwOpcV80elrTBldM2YxM7IHOEONHLyRNViICtxCWJDCpWmWdSUSh3p/bj9O28Ru0IRiBscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5LVEQcy6Pci4I7q2nwGo3FrHu769xuq8snEOWStFLo=;
 b=ayXK74NWr4kIP7dQOUXUoxNSX7enuZQadySQJGGRGhTkVwOF49PeQXy04OXCCwhF0X3C3fC1hxRDY1ICf+80Ouar0OnsAafwQJfFOVJ12g6ac3vqsxb88uF5YqIvLI5ACklY84vEOYKipcbtC15KSLQ8WFLFXjeQBwZ0+XyipJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 13:57:49 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::c48a:6eaf:96b0:8405%6]) with mapi id 15.20.8093.021; Fri, 25 Oct 2024
 13:57:49 +0000
Message-ID: <f1f8c20d-ec13-49d3-ac47-a2fcd4433baf@amd.com>
Date: Fri, 25 Oct 2024 08:57:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] x86/amd: Use heterogeneous core topology for
 identifying boost numerator
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
 Perry Yuan <perry.yuan@amd.com>, Brijesh Singh <brijesh.singh@amd.com>,
 Peter Zijlstra <peterz@infradead.org>, Li RongQing <lirongqing@baidu.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
 <20241023174357.34338-6-mario.limonciello@amd.com>
 <20241025135107.GPZxuiS38_s3KWe8xj@fat_crate.local>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241025135107.GPZxuiS38_s3KWe8xj@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0154.namprd04.prod.outlook.com
 (2603:10b6:806:125::9) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: b8ba2f94-5025-46c6-00ac-08dcf4fd02b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFBvRkJuOFprM0thM3doQ2V1ekNLaFArZ25FS3JJcDQ2SFBSSkRJVm5nVklK?=
 =?utf-8?B?TFZHbUR5dkVOWGk5TzBpaUpWalNJbnQ0V2QwZnIzM2JJbzVidnFaRitMd1dO?=
 =?utf-8?B?SWcrRHREdHZYRmZMQ2dneWdhTHdyanZIMlVvSkhFdWxRdXBTRkpJdXkyUHFs?=
 =?utf-8?B?ek82UHBlK1lWbXp6ZFNnTU9objVYME05Vnc1emxVZzJHa0lhdHZ0WTdLYlhs?=
 =?utf-8?B?OWhaeFdhZElGRzVoWUZVUk43N1pCR1VzT1hRZ3NyKzJxVkYzVjBoTDVvc0k1?=
 =?utf-8?B?UVlpdVZWWXlPL0NhQ3JyRGRGQmE2U1dUVFNqZ0k5TTBySXVrS0JkaUE1NG9k?=
 =?utf-8?B?bFJXWVIrWkpjSFdMVEpOUE1tQXh0NllZZ1ZqallaM000OTY5ZzRGVHZ6NHAv?=
 =?utf-8?B?MVYzR1ozWDdjWkgyVnErZW83UlBYTjlaajBHR1VpZllBdnl0czNocVJpYndX?=
 =?utf-8?B?NkFsK1FZa0lVcjNCVmZ6SFpIVkN0RE00c01LVEphYS8zZFJDanI5M1pzdk1D?=
 =?utf-8?B?aFM3S09rdnJ2UldVM1Y4MndrRVExWUNib2JLQzNFUkYvMkc0bkNYaGJmMHBz?=
 =?utf-8?B?NStIVXdXQjIxbm0xVkV2bnlvK0poK1psWHd5WHJieDQ5Y0ZuSEN2N3VpOC8y?=
 =?utf-8?B?eFpOaVVpTWw4b0VNMndnTWVHZm9kZ2hqMGoyV1hvOVpramkrNlJiTkQ3dy9S?=
 =?utf-8?B?YlMzcm9wcjh1QUlnc2EweFJ1SHNkWUVZMkVFU3hWNUJUeXlyTG9vTThrS1do?=
 =?utf-8?B?dGtXTGVZck56RFU2VERoL2dhSmhMaWZuaEluWHhLcmJaaXg1U25zaGw4M3Iz?=
 =?utf-8?B?VWhLTzFsNGl4T0wxaFhwVG81OE0yWnN2WVJkOC9QUk9rbnhYTW80MWw3dU9t?=
 =?utf-8?B?T3FJWHVJUGcvaDZEMmZYUnFmbm9hTVI1UmVMWDAwUHN5Q25YWDFPazNaR010?=
 =?utf-8?B?d0V5LzlXdXlQK3BpR0JSYnE4UTVVMG95cTZhNTVHV0g5NFRvdm8rOS83d2t1?=
 =?utf-8?B?MGQ0d29lNkRlQWRWdlNhcTJudDE1UjV4L2oxWVhnVUVlMUh1NUl0YnZkT2k0?=
 =?utf-8?B?SW1kc2ZHbDVWeG9aaGNoMTFtTzRLcXlkU0lURTNGdDVscmUwaDRqWFQ3bDI1?=
 =?utf-8?B?bEx1NkEwN0RESWgrcDYwb2R0N0hCSndTUGgwNXBRaXZqUTJISnZYSW9VMGpI?=
 =?utf-8?B?eElkU0NMSlhwN3RERjViVldwclNHaG9vWDA4MFlZZENtYldwM1hRTmV3azc5?=
 =?utf-8?B?RHl4SlZCUTZnTStMd0hoYnRyZDJzQnRySlB5OXUwb0l4T2cwWC83cytieVlr?=
 =?utf-8?B?TUpkR3BFcjJ5bGEzTjlGdnVVMUJnWG5KL1NYNWlGU3QyS2h3ZFhLR3BrS0NY?=
 =?utf-8?B?TnpvWXhTUXFPMFZ4ZWtOYTBDdS9qZ3N1QTFrOFdYdlQxeXNnd05aZm94UDVM?=
 =?utf-8?B?WWRLVExUcDZVbWt4RFhoK3Fja2p3ZWhBZWlyRVQvQzEydGd5ZjhJeUpZMUg3?=
 =?utf-8?B?b1R1bzRMWFFZU0hJMTdING1mWndlSzdQcERkSVd2NVd1UmNvWm5kdUtKajlJ?=
 =?utf-8?B?LzMvczRQcXZOTTR6ZHJmTUt2NEhReEJyVTJveUttSXFGM2RHRWh2Mk5lTDJ1?=
 =?utf-8?B?WmxVUEhMQjAxTldZcFRNYXo3WVV3YmVwdGM5azc0OXFDcXpDM1IxU3NsMDJN?=
 =?utf-8?B?K2J1K2JnZkg3cStRQjQxNnpLQmRzbVQ1bHp4czY5aEludVUwMThCQ3lCc3JW?=
 =?utf-8?Q?i05lY4kSlOJoxVpsxTW/WCitmCVY6P8OsnhaBJB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVNxOURremhHRW1Fd0ZXa1FqY2xZb0lCblZ3cVh3dG1oL3lIbm9kMWY5Uis5?=
 =?utf-8?B?d01sMWUvS0lUTWpFNVA5dXdyWlNJdzRxV2ljMmNNZldxV1ovcWUwWWQwTXVh?=
 =?utf-8?B?N0syVWxwYksveFdYOU5jbG1INXoxdHVlYkpRRkdWV01zOHJXVVJjNGE0Wmov?=
 =?utf-8?B?Z2duR0FWbUpFSU5oMXBDdUV6ZnN3ak1MRDE0NmNVVG9FRW12VktDWGluOCtR?=
 =?utf-8?B?T0tsVmZjVDRPdXpSQmNFSCtxN1YyMFlpVzJzYmhHV09kMzgyTERaZGVjRFBF?=
 =?utf-8?B?elBGbktmL3Y3cE1aa1IxQ2NKS1pJc05sZnc2SDRNMnB6U0tzZjlmTkxDR3Zx?=
 =?utf-8?B?NnlxVnlzazF4U3R4SHEyaWQvelVOQSt2TmRRb21QNXRNOG5uZlVoc2xkSDBw?=
 =?utf-8?B?bmovaHZ0cGZmVmM0cmxDRjNtT1pIT3orTGxxWkplbWtJbTRoK0J3VTJHNXUy?=
 =?utf-8?B?WFpVVno3dDk4Q0VRQmxFbzBPVFJTQWYwSEFESmdmV1hSSWs0K1dXL2lEc0M3?=
 =?utf-8?B?UWFTT0djVDhlOG1PMWpoVkVUZ2FsNUNiQWU3UGdiU0VMMGNsQ0FkdEprMjNx?=
 =?utf-8?B?UUV4bmFGRmoyMlROaG9nWGNsWENOV3VORFZ3Z3ZaRmc2dEp5T3gxNFdtQlpa?=
 =?utf-8?B?bzlOZXBTNHlQQklkTUNBYUJJYnpNaCtsaHZqNERxWHphdFY0bkRVbUNlc0p1?=
 =?utf-8?B?eTJDRnk0SkVJVjZhMnRzSStXWDh6RkJYbGU0b294V1lQbThGeXExOEtFbWt1?=
 =?utf-8?B?d2J3d0lrdEdvYVVxS3ZXNHpQbUlaaE1jVGt5UFVlb2Jsd0ZNNW1VdEVZcmNE?=
 =?utf-8?B?aFBYZDVIcHpKamllUkxUaTJ4YmN1azR2R2QyZUtuU2pFTExkT1RDTlVmU24v?=
 =?utf-8?B?T3F1c0UyN3J5dnJDQ2I3QjhrVEx2eG9jcW1DNlV3d1NmS0ZRZWprM1Zyb29O?=
 =?utf-8?B?dFFpK3paR0NUdmpsWVh2eDNXcHpXTHpoV0h0Z2VidytxTjU3TTUxRXgrWFpz?=
 =?utf-8?B?eDcrcTQ2LzhTcjNqc0prV2RlT1VOMGFBUGRXTHdXRFZRZy9qU0lPS2h3enBs?=
 =?utf-8?B?S01pTHBHdFpvRXNraWRoZ3ArSFVtNGdaOXg0QWxvSzBWWTJnUzBjYUF5TkFp?=
 =?utf-8?B?TE56TXlWRkQ5dXNWaCtwV0NjRndZNndlMU5UYytzaDBMYzVQWERWbVhQWHNF?=
 =?utf-8?B?enFKYzNJY3Q1MVBWd0xpdHdEdHhNbFhYZ2l1SlRIQnZvUzliSTJubXlzdjJO?=
 =?utf-8?B?RjVHSEJyaUlBQW1YYy9ZckhMWHpvWmk1Z2hBd2l1UFBCTmU1QUdpU2d1dUJC?=
 =?utf-8?B?ZDROekFHUDNHTGNzMEZTMVljaXpMT09hT0ZDRG1lbWFUV1MrOEJHMUFtQjBp?=
 =?utf-8?B?M0x3eG40d1ZwTENQQVZWbnFncHRvdHlOb2hmRzMxMXFiUmROeHZmdmhyL084?=
 =?utf-8?B?aGVOUFJEWXo4aUQxV041OEU0V1Z1eGxhYjlpV3llVEQ5UnVmN1ROZ0d6VnNE?=
 =?utf-8?B?U2hZZFhiRmUyZVdxaUNBZ1BYK0diT2FaWWI5eE40MlRFS0tuY2lweElxeVRO?=
 =?utf-8?B?SnVlTTJHd1ZPeTJjNlFQQURFLzdtcjNLL3FNWmUxNVFQeC9WR1QvTzlycEVn?=
 =?utf-8?B?MnpTekJzenRPL0lRY2w4YUI3QUJ1ZXRqeUxTd3J3NFlQK29qeGcvOUQvQmw3?=
 =?utf-8?B?MEphVDA0dTVtVHk2OWoxSk41MHZRRzFJOUdYQVpiOTlsTHU0RC9uVi9VYTA4?=
 =?utf-8?B?SXArUVNKb3lFWVZLZkIvdEljcjBZclFiblBGWXVVRUhoYnRoL0N1Tmx6dmJt?=
 =?utf-8?B?TnZSYWYxaVlSVW9mV1VLdzBFNFN5enVQSGNCMlJzTEMxS0JIVm9lU1hRMmt3?=
 =?utf-8?B?WGFNWmV2MHg3UmU2MUlPMXYwOFlRTHhKcG9YY0dlR3RGbHZ3bTVxUVRkSnBT?=
 =?utf-8?B?a0dPS3JjcGd4ZHhsdjFjZG1zYjNnREF6TWZNb3lLMzlqcCs1aU1LS1dHeXpV?=
 =?utf-8?B?ZHc5S05CQlpLZHlhNktoekozNkJhRFdXZS9aZ0VZQTg1OTJCUjRGN2RLdkJa?=
 =?utf-8?B?NUM1MU1zMGZQYldlZUdKTldFUGFOZHpzUzFXSXdVREFaZDB6VVQ2b0Y1SVlo?=
 =?utf-8?Q?5R+kbc71Vfl2CO+IoONDw0L4w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8ba2f94-5025-46c6-00ac-08dcf4fd02b0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:57:49.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHYneUjV/4931s/rQw6MtYc3MT/kvmXVYLLQj8XhHrNAZ5pqZmAuKCtLw/tewurd3x/bgp53nCmgIFn1ZGn0+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533

On 10/25/2024 08:51, Borislav Petkov wrote:
> On Wed, Oct 23, 2024 at 12:43:57PM -0500, Mario Limonciello wrote:
>>   int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   {
>> +	enum x86_topology_cpu_type core_type = get_topology_generic_cpu_type(&cpu_data(cpu));
>>   	bool prefcore;
>>   	int ret;
>> +	u32 tmp;
>>   
>>   	ret = amd_detect_prefcore(&prefcore);
>>   	if (ret)
>> @@ -261,6 +263,27 @@ int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   			break;
>>   		}
>>   	}
>> +
> 
> What's the difference between this case:
> 
>> +	/* detect if running on heterogeneous design */
>> +	switch (core_type) {
>> +	case TOPO_CPU_TYPE_UNKNOWN:
> 	     ^^^^^^^^^^^^^^^^^^^^^^^
> 
>> +		break;
>> +	case TOPO_CPU_TYPE_PERFORMANCE:
>> +		/* use the max scale for performance cores */
>> +		*numerator = CPPC_HIGHEST_PERF_PERFORMANCE;
>> +		return 0;
>> +	case TOPO_CPU_TYPE_EFFICIENCY:
>> +		/* use the highest perf value for efficiency cores */
>> +		ret = amd_get_highest_perf(cpu, &tmp);
>> +		if (ret)
>> +			return ret;
>> +		*numerator = tmp;
>> +		return 0;
>> +	default:
> 
> ... and this case and why aren't you warning if TOPO_CPU_TYPE_UNKNOWN?
> 
> I think for that you need to check X86_FEATURE_AMD_HETEROGENEOUS_CORES and
> warn if set but still CPU type unknown or?

Yeah; you're right.  An earlier version of this behaved differently and 
I missed updating this switch/case when using Pawan's updated patch.

After we get Intel feedback on the previous patch I'll drop the 
'default' case in the next version and switch it to this:

case TOPO_CPU_TYPE_UNKNOWN:
	if (cpu_feature_enabled(X86_FEATURE_AMD_HETEROGENEOUS_CORES))
		pr_warn("Undefined core type found for cpu %d\n", cpu);
	break;

> 
>> +		pr_warn("WARNING: Undefined core type %d found\n", core_type);
>> +		break;
>> +	}
> 


