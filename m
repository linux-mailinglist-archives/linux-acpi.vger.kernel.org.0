Return-Path: <linux-acpi+bounces-19061-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACAC6CC70
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 414B6293AD
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39F230BF64;
	Wed, 19 Nov 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D11aueJl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010010.outbound.protection.outlook.com [52.101.61.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B39223817E;
	Wed, 19 Nov 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763528274; cv=fail; b=EN0MehjyLgP8uQwnw33j0py3LieNf5Lk+LkoEV1eN9n8aOBhO7QDZ2WcZqSEfa9QHRT4UQiVRPCzKNZSIy4+ylJvFMawj90AYjYhQePax7VbQxpYsk7Uex3IxCHInWkpX8PDyE3/cE7JPy9S3Kg/n5ggMURrV5hRHclF+GnsItc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763528274; c=relaxed/simple;
	bh=1JWnA0OBOtXVTl1w1F52AZQAFqiKZJ8hG2RxF5kU518=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W5n1CBk6hBFbEhz+YedeFIB2+kPha2WCPx4TDwRVsXB1boMbJaoDJVEUW4mUHyJiIiXYZxuguPxFmSwy0xAPPcz03jVSAYk1LuWqGE5AT8ZwKHSJP3vVAeVmJePtQgy0ybYFnuIezDNKpTBjU0PO0jFAD3VM9W3/3P2WIYeqGtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D11aueJl; arc=fail smtp.client-ip=52.101.61.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsELmOGUAoNzvKppH7WrR6K/T+rIhf5PfD3vMD53xwIeiMSrHBlrgpZnJZUR44Mc6WTpgPRnROGmIgZKK/KWsdMM1PCwqF7T2oVF988Z9l8FWKLg6kcShdjEGpXuxs9iqMhUfUdWLeSx/FxBA6z3aN3QVyD9+0RZFtZuviM7TT5WBRj7R3Lyl6WV/bGA6VAZ5Hi8IswOkBhWZvmvAEOQzBLCnhJXddU22i3epGOP+n6Jkme5DzChfnczC+lImPMkjwvy7fnoNikihIHf6FZRSSta37Mv5AmpB21qQI/jzrnAV7e2VJylcrjvG1kvJbGk/SH0ceifWLZlf3yxmUulpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWgojWfKf6EtUAHA/xL2ngSvYFcqBlxUEFvgiFqdRSA=;
 b=WejLRhxKwiqGGimzVXSr6/ddi392cGgiUUZ4Oqbn6bNOOFO6PfSGp5UZ/o7nelbfHlGLNadOaJdH5+hdY/tFIz1z9hXwnPsuKdMqw97LJko2qJb1kHxuTEapahqgQf4QcTdc7MHd7cS41JiEnAe8OpA1hgIgllIVuGDzu7uoRBHWUgMNhoc/q04cW0ALzmdu1mSySCB0Nt07NziOgKUVXmPAUIbcp2mKvNL4D8evyKO//FK0Qjtn8rOFZgi0TogX3AprXqxzK8D3TDaYaBdjE+q1XysiFoPMpCiXykWy0cMVLnWbQfM+WyizUbbl5V6zfglia+W98USQnvzZEw2beg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWgojWfKf6EtUAHA/xL2ngSvYFcqBlxUEFvgiFqdRSA=;
 b=D11aueJlSZMyDlg/ta8U3J7a2evld1zSVHxcvDBeIonbMY6alow/6TGC1vM7NEjEFAH6Qag5uVi95iH0nXGB4jmkouPpBXwCk1TKW86jWhJFj33geYjU79FZup03Exhfk9HLSZ63uGz5rk2TboCFIcl7AAv31+DAkxiUyxi9ZqZYQob/Gh0wqoeZ1bO0PL2oojsgqwdEK2TZw902FdbpG8bfsxVUWGedvkKZR3fbR9NmdTjsudUKUySurEyOs5V3ED5ncnYJ88IVRRbqB5sxDfbaEuEzKA5svvKjch2fVLFhlQgoKnq2wOHthCqqr5g0HhxO2whBKoLsDsZ1sOxzMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DM4PR12MB5961.namprd12.prod.outlook.com (2603:10b6:8:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Wed, 19 Nov 2025 04:57:50 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 04:57:49 +0000
Message-ID: <6b8ada8c-7793-4d12-ae78-027be63874dc@nvidia.com>
Date: Tue, 18 Nov 2025 20:57:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/34] arm_mpam: Probe for long/lwd mbwu counters
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
 <20251117170014.4113754-30-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-30-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DM4PR12MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4d9981-338f-4f56-29a7-08de2728305a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHpiMTVNM3hYL1U0ZXdGMDdEemtSTzV6Z09QaWhMdi9iRXVEY3drMVQ5T3Nu?=
 =?utf-8?B?cHdhMWJhd0U1YTFCMVAxMFFaMm4vNVVrRTRXbk84NjRoTjRnUTdyTUlrbHlT?=
 =?utf-8?B?MFF0NDZSR2JlRlNDQjBqUHdmdzN6dmNqTXZaZGg2T29rT3hRZWh4Z0lkTXZ2?=
 =?utf-8?B?UFQ5OFZUT1hacmxxU2VzSitwVGkzU043MCs4Qm1WTDN4cW1pajdJbGNKandV?=
 =?utf-8?B?cjdNSDZwS2c5Si91aXVBVXJIMUpUd1NweFFSSkNoUHZmZ0hTbDV6UHNZWnNB?=
 =?utf-8?B?dUFxR082MHU0aFQ0cENGbXVLUlY2aTI1MXpIRnBkTHU3WjZONDN2c1dHL0Nh?=
 =?utf-8?B?dUlXWHV5SEpZY0QrQVN5M0wrRWZ2Q29BZU4zaS9PY1pRUFBLMW9wWDhHRVhs?=
 =?utf-8?B?cFhjNmhHN3pyMUZKc0o1M0JsOHdOOTI3UVhvVms5ZThyZW5ZeU41azV1NUdB?=
 =?utf-8?B?QStock45QXlRcVI2Sjd2bTFUQ04zYWhpODdsUGFvUFlhbUk2dnc4bXlCQlow?=
 =?utf-8?B?a2lUNTJOUHJIdGJxNjlnVVBEUFJMNW9sRnNKaHNhUnlkc3RwVlFDelNlM0JG?=
 =?utf-8?B?UWRXRXZOOGRlRDh6NnZJaW1oVG82ZERiNzhhZTdsV250TzhaM3RPaThWRC9o?=
 =?utf-8?B?SlhsN0RTU2ExTWVPNXlESUZzOEZXSm5tQWtiVEZuMFRrdWZEWVVUdnRKSk9q?=
 =?utf-8?B?ejg5Q2FNQVM0TllGZjlHSVJsT2JrVDhRZ1NBcjR6bzFpdVAraUJ3d3VDZUIr?=
 =?utf-8?B?TUgwcHBHdEw4NzlQbmtUc2U3WWtIQ1RweHhJQnlXWEI2cTEwVzNzd2hVUDVr?=
 =?utf-8?B?WnZmYlRQRXpUd3p5T2FYaVNaa2hiWTl1TjFMOEpEWTJNYnRVQUU2b2tJOTU1?=
 =?utf-8?B?RWVtQTFMbytZdHlDS1FJam5Wa3pPTmxHT2ozdXNzRDNRMzNocFM1RTFYNXJQ?=
 =?utf-8?B?eWhWckx1ZG8vbFdZQ0dLTS83dXd1S2FyeWViV2o2cDhHZ21OWHl5TzUzMm5D?=
 =?utf-8?B?bURUN2UwOUFPVGcyTkdMOE4wQXlsMGMrMTdrTlowY3F6b0hRSTd4YXRFVXUr?=
 =?utf-8?B?ODlMKzhPYzVaMnlQQTVCUUlTVVVyVDRBVVliU1hROS9XVmRnYzNFOGtzUk1u?=
 =?utf-8?B?aEJyUkZ5UXk5SWI2QXp5aXhvSHYveUQ1ak5LRVRUZDBCdXhNNFJPK0xyVEhJ?=
 =?utf-8?B?WkpMUVZFRWZrVWMyL1pYS2lyQzhZUnduTDZTcmVrZGtIUlJ1aERqZ0VDYWo5?=
 =?utf-8?B?L3gwUW5HSHdwSi9lM2J1ZU1JdjlqZmFwNWo1YmtIYm5sVWRVTzZkUk9ScDNm?=
 =?utf-8?B?VUsvQnhPRmpRQnVxQmxvbFA1RlQvdWlZTnpYM1BLTmhEVDRYMWhaeWxXcGI3?=
 =?utf-8?B?eFUxY1hVSVVTTk1yNGxNbGt5NkpEVTFna0RFMHYrZ0x6NUF1RTBRSkY1WEVI?=
 =?utf-8?B?ODBxTW42VW9maTRHQlRpazczdFpPSVlnVTRoNjlNUFZFelczaGtqekJJcTlq?=
 =?utf-8?B?TC96dzEwS0NLZ2FZRHZRK3BUTi9uTkI3cHg4a3hValRMRHlLNi83WHVkU1o2?=
 =?utf-8?B?MnJ4eHFhRit3QWNWVXppdGNjU3hwTncyanQ4bXh2K1RvQURyOHJZbzlmMmdS?=
 =?utf-8?B?d2l6RkwvT08vUTFCNklCZ2xVQXNlL1VoNE0wcUs5aG5lR1kxMVBlNFo2KzRz?=
 =?utf-8?B?bVE2eVRSWjF4cjlSclp4Wm5FUWNHRENtYU8ybmR1OVFTMVpsQ3F2eXRPbVBI?=
 =?utf-8?B?dFpaV3k5eEZCdlh5UkVrd2VWMGpsR09LU2JXWkRTYzEyRUtJVC9pUFNieXdS?=
 =?utf-8?B?cmpMM3dxU1M0RmJyWmltZ3ErZldwb0JvVDRobXpUVTBQeG15aEQyR0RiYXFT?=
 =?utf-8?B?NStqZVlZR3dVVDNxSHdrdnBXaGY2V0ZpczNUc2MzS25EMGtDK01ZN0V0V25Y?=
 =?utf-8?Q?HsUGOQdQS6UuGW/X6Gb9GimPRBsTMPKL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUM0cVJoZENYTXF6NkU1OW4rZ2JRdXFHaExEb1Jrc0hzbmc2TldJWWtXWlNp?=
 =?utf-8?B?RGNCcUNIS2wrMm5QOC9icUsrOXFNL3poOWZyUWg0YVNxblVEMDdPN3hQM1F6?=
 =?utf-8?B?KzRZVzhrRU42Ukx3ZUNBSUxXM0NKRllSYmw2K3E1eTFJdGNBWk9KSG9Pb2Ew?=
 =?utf-8?B?UnQ2ai9teEZ3U1dTZFhEVXpRVW95bDdUQW9Nc3RNYkxyRWNCUG5kN0N1TlJq?=
 =?utf-8?B?ZXRjenByZEJyMUdaOTBFMklCOEx4UnFrRUFacXkvNzRMT01IblIxaldTK1Fz?=
 =?utf-8?B?dDVTc1ZqOHdUY1NCVHZydzBpYzJDNkk0eGE5VmVRYk1rbVBYbi9uYTk0clQz?=
 =?utf-8?B?K0NJRWZ2bys0OUVRcFphMGRZSnYxbkFmSVMyNWZTSXpkY3hoUWM2YllYNkQ1?=
 =?utf-8?B?K2JzOEZrL2xNZ0FvMnVieElRY0NEZndvZXg0bVVXWE5zVnIwWHhUWHE1Sllk?=
 =?utf-8?B?cUF2eXVTdGgxL2RMTGROMGVYTkVEa3FBakUxNlJvYjJualE0c2wzRERITkRv?=
 =?utf-8?B?cFRvSkUzK1pWK2VHOXRnSWNFWkI1R0F5bXR1ZnZ2NmlINFZTdjdTYStzUEFi?=
 =?utf-8?B?VUZTcytxbnhqaVhNMHdaVStBbDg4VW1uK3RNQ3F5UGpXWFl2VTBUT01EeUJV?=
 =?utf-8?B?bm40dGpuWTdjeUNhM3plNjRrMFN5K1MzOGtuOGhuUEZVYllyRk5iRzVQRWJy?=
 =?utf-8?B?MmlHTmRZb290czdORG8rdzNRYlloOVFIUWdOK1FyMDA2c0Zuak1XMFFVZWg5?=
 =?utf-8?B?d0M2VTRnRzJta0Z1Rm5LaGNUaFUxN2hRaERIUHNjMDJuRk5aRnlpTklNZGJG?=
 =?utf-8?B?U2J6NkkvaFp1MHN4QlFzMnBRQ0lwNCtja0pzckdaK00rQ001cVFKMy9aTFA5?=
 =?utf-8?B?cWNpTDBiZVJSWHFwYW9qN2QrYkY0Rk5wb1JtcEQySXZlRW12cUdkQzY0ZURw?=
 =?utf-8?B?MFNscjdpRVpmL0piSFBwT2w1SXI4V0pneWtYbjk1T1BMekRwekVtQXViUmNZ?=
 =?utf-8?B?bXAyK1IyUHhoUGE0V21pY2JLNW5HMjNEODhpMlBEWWRxc2Z2TFBhVGhOaHRU?=
 =?utf-8?B?SVdTQ1ZoVUdoWThBMFFzUFRLaDlnSlNsUmorend5MnQzZnI1djdnN0lKYjJC?=
 =?utf-8?B?VmNxVFlrUmcvV1VlYnd1M2gxeTVheXdaanE0aVlwRk1tMjVjaVVPTDlFMDg5?=
 =?utf-8?B?Mzh6dExHejdxRHBEUXpML2dnemVkZnJBWGxPM2MvVjBmTUxSNWw1K3loQWEv?=
 =?utf-8?B?M0tFeVVVOEUyWGwzcHRNUTBseDlhY1JMWENoMktrMFNWcWRsYzBCekp1M3o2?=
 =?utf-8?B?ZnhWb2VzVm01R28yTVpndXFmb3FORDFlRHFhU3FrTndSWkZpQW1MZXdhdjFh?=
 =?utf-8?B?T3RObjJaYXMrbG95UHNrQTNIWGRjeHR1Q05rbGdKSHhrMTNNQUNoTUdicWFa?=
 =?utf-8?B?cW5FMzc5akkxdXBUL0JuakZRNnJ1SnNQR09lSE5VaC9oMXBldUhBdHFvdTE0?=
 =?utf-8?B?OU95WVU0Q2tSVkk5VDd1QkQ2NExCdmdnb1pWaWJGQlZUeEhhSHl5cTNzWjF1?=
 =?utf-8?B?UWhvQ3JETlZ3ZWVGc2Q3RUVLUFlkRHQ0Qm5kNTJWRlBDRk1PZ3M1NnoySXdT?=
 =?utf-8?B?ci9YSEFrR3JEWnRRQlorWjlRTkMxRVY1ZnRtNVhEOU1PMTZUcDJoTHVyWDJs?=
 =?utf-8?B?a3BhK1FwaTVTZTJJZnh5QmttMXQyUHhiNERHb3FuY1RncHdmMTI2S2JCck41?=
 =?utf-8?B?b1YwR1MrK1FSd293M2pIeGFBeW9pNXVUQUFiV3BUcTkvRVZWUHdPcnhHcWdF?=
 =?utf-8?B?UnZlSjFVMTIvMVBNMUcrcG14c1d6QjZXejF2Q3R5L3g1SUJheGdEUVVlVTN4?=
 =?utf-8?B?L1BTVUw0aERyS3A4ZFo2UG9zZlduWUI4b09MRE5oYmJZWFNaMnRYdHlsY0pa?=
 =?utf-8?B?S25xbk1WQWRFaUE0ejBxQWVYVnorOFh3NmdwR3E4K1hCK2s5bjc1WlA2VVll?=
 =?utf-8?B?anpSdjVwTTc3N0VDNmJvU1luVlJsVUVzWDlVaXZLcHAyVTVPLzhNZDl6eHF5?=
 =?utf-8?B?YU4wNFBCeUZGWFNVcDlTUmxabHpSbThNSGVYSWFGWmY1YTdqb3dqWkZKSVg2?=
 =?utf-8?Q?oCT/Ia+O9r/vY1iwdYhFvwgcE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4d9981-338f-4f56-29a7-08de2728305a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:57:49.8408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXp46gi0JfIO9ibvOTpoJ3VP6yQ9AQOWBjguuOfzYqS3bf1NDuCABfYdd3sZyVVcF7osjpoHlMp/1c1tmkt4vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5961



On 11/17/25 09:00, Ben Horgan wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> mpam v0.1 and versions above v1.0 support optional long counter for
> memory bandwidth monitoring. The MPAMF_MBWUMON_IDR register has fields
> indicating support for long counters.
> 
> Probe these feature bits.
> 
> The mpam_feat_msmon_mbwu feature is used to indicate that bandwidth
> monitors are supported, instead of muddling this with which size of
> bandwidth monitors, add an explicit 31 bit counter feature.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [ morse: Added 31bit counter feature to simplify later logic ]
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

