Return-Path: <linux-acpi+bounces-17583-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44246BB7F1B
	for <lists+linux-acpi@lfdr.de>; Fri, 03 Oct 2025 20:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A57E84EEC79
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Oct 2025 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CC62DA77F;
	Fri,  3 Oct 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J6kahqxm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70B31F19A;
	Fri,  3 Oct 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759517920; cv=fail; b=hbociOm5Jh1YHX6P6LRVk5JYKTIIwPwtDs90P+JFIoE1XnVXUDo3jHJQ0NTJwJGPH0Czo3eoi9AGpMcFpeC2hFSs15S2G9MtPwrQW8ReXBQfjP63X7NiScgzmCGm3j9m4H++cTJ8kpXs3LLk8Vv1QuQu+Tk49n5UMw8MEVcqvlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759517920; c=relaxed/simple;
	bh=Gjm3PtfIsJPazaJci07Wtb+toihYn/woBD7mnOiQ65I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SOdRU1LRobe7PyuxVAXAgO9bJq719uSvyj983G+flwa00OWdg/NwHMdBX34S7wQOEiqrKb+H82oI38fgd+rs2+CVuYJsEevpHUkjgN5NE9g5+YJOobxg3RaG3l+AXFKMcErD/9j0VW4mzjgHa1h6I+VWGw4+L2Zk0TSOTr2MYHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J6kahqxm; arc=fail smtp.client-ip=52.101.85.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ydjFT5JLioBMnq0/jFWM8tp1JTBLC+d9VoYSxOyiWuHol3oa+bfxbYYJrqHLnRRxmLOdIG0TUCT0JriksLWDtfwZGkBxIWn63rp1bDx3mTrUPcoGBTMMSwM0UBSu5dJ+d8HFgDzHMQgXtXdaXXezKjmGmeFqLD5i06rAMiHjo2ztVourrl419eCH6Vq+4rXnG/DbVvhzLpY4Vb4o5J0C1T9MiksfXECswf4B8CbAn1WgoiaiQ8N13iC6U7UAk39sPQQWdVZ/X4WLVgMG00stm7+Q4t19+n+TNH6JMeooavWJTCZalPf5U0L7Pkz112WYeEBPTSgxkGQM+Sz9pucJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AToYr6GqX2k58EBi++0Tev2JNXRP+ElDiEoewY/y0lI=;
 b=jjEC6MFTYOGoTyEMzlO9nB6f6O1Bg2qThkGpp2upjraopW6m+l/QqW5JzveQyRE7tPC4TrNH4ul7BjzndouYWpHBWTabOKVmpIG3QpBHuTeDW9q837Vb2IgGV+HatzNvRCiEzBJuveOKuf/1mO3HabtwEwX/jwxrSJEC8SYb/3nXI8RaUwzwo1SQtdZxg7x67ke7KeBLk5we6uGWdKbobA99bVsPfWm0OZX5ypzoc59ij7OgZraFqpsQvI6E8qKAI1o27fd/NbXwWTR3KIQtnFdlHplcVLpfrffB7ZJiTllTnokep6WH+YCzTxFOfx3ni8/E6Y2HOXUdQxBJ+4mWWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AToYr6GqX2k58EBi++0Tev2JNXRP+ElDiEoewY/y0lI=;
 b=J6kahqxmZmqQQGzRhbg2GiRJoxuBkDbDvWugl1Qs4dAyojDXgIRQRRtLe+PXLEoCVtAY4nJ3TU2zVSQvVEhnPK/pUWBh9fYWx1ksMR0B/cC6MU/2/JBN9Bk9TArSQtpYZN5PNS7u77/oQZTVWDRE6OvVuIlD6ySYxYW5dBnHDXHyFoiSYXexkQlQ2wIHdZ8zKNFssAvqiFh/W8d2QsS/F/bNPS6a/yqmpVbsWgcg6FpPrV7U4rlWXEG+QNzX0yEVEyFhIvG4hmWNyi0mAwc1IjLB6is8qUd1kZPzlQjEPhs9PkiNzQAnqMOWgVBHWd3vbWCfNqYseoJ+UHbG571Ncw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2661.namprd12.prod.outlook.com (2603:10b6:a03:67::13)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 18:58:35 +0000
Received: from BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2]) by BYAPR12MB2661.namprd12.prod.outlook.com
 ([fe80::f4fa:1948:9ea6:1ee2%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 18:58:35 +0000
Message-ID: <562d1f40-4ed9-4f5b-af1b-9de45e06079e@nvidia.com>
Date: Fri, 3 Oct 2025 11:58:35 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/29] arm_mpam: Probe hardware to find the supported
 partid/pmg values
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 baisheng.gao@unisoc.com, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-12-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-12-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::10) To BYAPR12MB2661.namprd12.prod.outlook.com
 (2603:10b6:a03:67::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2661:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e80019e-3260-444b-44e3-08de02aedb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk5vTnNVZG9jU2NoTEdiMm95ckhDd1hNVW82RGxxWkNpVDBSeHRvYlRyS3Fr?=
 =?utf-8?B?L2Y2RStkTkJGWE0zLzk2YmNkT2JmTkExcDdrdkdFOGtVQzVUNTlSVGx2SG5i?=
 =?utf-8?B?TTdka0dzQ0RrK1VtRXMydDR2VVIwL0NFbUo4dHlLSUlBb2lUaEhURE9RaUx1?=
 =?utf-8?B?bVVJNDcyeldJUnZURXVPTzQzVkt3WTl4bXVPQzNqTStNL2tWbElLeVZVZ0NZ?=
 =?utf-8?B?MkQ4dTBRelFOYU1MZGJYbnN4NFQvM1hBVnNoMkRUOVBPY0dXV252amo2TUlr?=
 =?utf-8?B?cVNESlByTHFNL2JheThVWTBrdFd0d3VMb0VUV1BIZW41MjNOOFRVaWNucG9X?=
 =?utf-8?B?MW1XTlNoOHgwL1lzZXRDZkdmQXRpdTY5b0V4KzJzRUxBSkxwcHo0TWZFUzQ1?=
 =?utf-8?B?TlBPSlYvcS9LZDh3cU9LQkhLOWlDNEhMV0hHZmUzQitOOWRna0MzNUJkNXdy?=
 =?utf-8?B?Qy9BaHNYUTF4S09kNXJPR25Gdy9PK0NLbXRRUnRPRDZNSlNtc3BqWDhpbjRm?=
 =?utf-8?B?eTgzSEdTcm1NL1pnZFBYOEFOWU5Pd2huS3V6V1d2czRqazlDYmhldmdERUZH?=
 =?utf-8?B?azJxS2IxRVd5b0xEUWl3bUhuUXRtMi9jRVliNmVxZnR6dGh3dytJSUk4MGo2?=
 =?utf-8?B?c1RyNHZFTU9kSlAzM1pHVnVHaEtwNSt2c0pJSXp2ZW1qNzdpcDVIRnFYYmxo?=
 =?utf-8?B?TWY4ZHV4MlBpSm9tak5uZWE2eVNpQ0hPTmxPODRyZnh0ZitQN0NIVWNXQXpT?=
 =?utf-8?B?eUZsc0FGcjBmRWFQQTg4MEkwN21mekZkdTROaSt3VXFSb1o0NnAyLy9KU0FC?=
 =?utf-8?B?ZkVWRTFpd3RJN3dlU0RjdG1laTBkamZuK3Yzc2pldStqYlQ5cmwzSldMMGQy?=
 =?utf-8?B?bFcydWRWY1dlVmpDUUY5TzNqUDVUMEFlZnJhVlVqa20yMUNLZnFjdEx2NTg3?=
 =?utf-8?B?b2RzYW9MdlE4cG5jNmgwSlY2RVdoRGMrUm9zZG16UXErWkVFdHF3dFI3WnZ0?=
 =?utf-8?B?QU5ETHhiMzdxTzMvQ1d6MFo5eXFuUHY2VlpSVWI0bWdyZFZINWg0b0czYTJm?=
 =?utf-8?B?TEpQYzl1MS84SWxmOXJIWkdiUSs2Y0xiN1FtVEtHb3c2L0lmS1NROWJ6MzV0?=
 =?utf-8?B?TEhxSm9ZNTRmM1B4a2ZIaDBETEltVlhxNGVDL2xEQzNKekhsNHFZSkZQRWx1?=
 =?utf-8?B?dnVZYXF4Z1BXVkJYUWdiRm5QY09EY1hZeXFBMlFIQlRqcEQxb0llVXp0L25h?=
 =?utf-8?B?bTZ5U2tITyttcGlEWFVSaStKKzdNV3h6RGF6b21QRXJ5YkpxRW5YakZNNzRN?=
 =?utf-8?B?NDBVVjg0c1ZNMmVHU2R5K1hFbzRBbldPaXgyaTB1NWdGL20yc2pwUThrT2ta?=
 =?utf-8?B?RVREQk1FcjV1Q2J5aGJQa2NRN3pWME5waGNtNUZLeVBkbEUvWnhrU08rd0dn?=
 =?utf-8?B?WEQwKzBqak1qVkhkRXBJWm9icTVTdTdQNmF4TkZEbkNOTnJOUThVNmpnbVNy?=
 =?utf-8?B?amZYNkoxdlI2clhWRGdwdjlMNU9DZ1c1UVdZYnlGZCs2VTdyaXd4bEQ1c2lE?=
 =?utf-8?B?bTFOTlJLWkZQK05YVlR6V2NiNE11bTlzbnJiL2tvSnFheGhtRVVTTnhWWm9O?=
 =?utf-8?B?WXJxRkRUYXJlRnVtbDRndWVGczFIVVpWMVFBbHRvdG85aUVoMzc0eTh2d1lx?=
 =?utf-8?B?UjB3SWNLbjRwQjQ1b0YvSzhlVzZjbFJIbnpOWW85cE0zbE9UN1MxZEM0d2Jw?=
 =?utf-8?B?c254cnBIa0laay81MXYvTTBXRGVKTG40VHpLV3ZFUTNiNVVGcVN1NENzRTZu?=
 =?utf-8?B?eFNxblQ1cXI1c0pLUVZOUElXQ09uZmNYUHY2bkpVVzBIc2crQlNOMHBwUE9u?=
 =?utf-8?B?VnZLeUtDM1VDOFN2cG4wejdJeWM2bm5NRUhBQUZzZ01YRXcyU0Nyd0EyNm1k?=
 =?utf-8?Q?i5Dd3xTazVVTQN24qOMaU1DdVjUyixlo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2661.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm9TTWFyZHJhS0YvZU1sNmxVMUpNZ2FXcTlsRkY4SHBtVUNrdzJ2SGsxQVF3?=
 =?utf-8?B?b3NrY0N4QVFQMDVJUlp1dU03QVVBMXZwZnJFdmpVTGwyaDFBczlRY0wvaStV?=
 =?utf-8?B?M3VtVklWclMrUVdNMG5VUGduMS9SYXFqU2xoTHNzOU0vcENnN2JrdVNFdWNV?=
 =?utf-8?B?SXA4RUZYMW5RczZGUlhoY3E2cGtvOGZnRVZES09GZ2J6UThzT01nQ0Jnd3Zw?=
 =?utf-8?B?b3dRMWlXamVDK29UbDdxdXZ6dVJYaWM0SlY3ejYvODQ5NGNidkVFdDBIWkk3?=
 =?utf-8?B?RmVxTWV1bHdIQTJTTlBCWVNFeXJRWFFodlo0bE5yQWxMMk1HdWx0STd3bFJi?=
 =?utf-8?B?a2lkSngxVFByaEhVRFZKdUF6WDlzSGg2R09EZkpBaTRwMlBTOW5yV2k5ckU5?=
 =?utf-8?B?ak9sTFVUd1lMemRoK2ZZL0R4OFJvTGpoeHpHdDQxZ1h5ZVFCSk9USDhMb3dG?=
 =?utf-8?B?TE0wYUF3WWZ0MXBMODNmemFsQUJLQlc3Z3hDTVdNa2VkRUM3R015eFhhd21w?=
 =?utf-8?B?elpKc0g1Qi9NTk01NmVORndBSjNieHdCaERJZUtzTE91YTlGUUJVa0oxUUwr?=
 =?utf-8?B?SmFXODJkZEU3UFBWRU9qd0JUN01nNlpvWGIxaDlEYTBRdXBMaUVXQS92NGRB?=
 =?utf-8?B?ZDEwNm5zRnllTjhrRmRtankzd3hsZi9YRFZ3UE9ZV0twVHpFbHArZ2FGbC9V?=
 =?utf-8?B?ZWV5RkxxbzN4WWgvU2wyUGRRY3lOSEgwYVJmYkNZbmlXWmFmbktVaVorSlRI?=
 =?utf-8?B?SHBQZ3AyQlVPR0lZSUxjS3gvaFc0d3hhMkxXdC9TL1FpVTcvZ3VGaTA5ei90?=
 =?utf-8?B?ZlJzM2xFSmpqM25ZWFJDQm9sKytGNWorOHducmlSVzNsVE1qN0pCMnYxdEhx?=
 =?utf-8?B?ZXFKRzdldm1EczN5SWdkME9rRHd5ZXI4Zy81NjhHVGxMa1dhbklNQlZCczhF?=
 =?utf-8?B?VysremF2SW41Zm85OU1vaGQ1S1BWSVowN2FSbUI3c1pIL1dtUkhOS3hmUS9y?=
 =?utf-8?B?Tkh6QStmK1BYMzhBMFIrS2piU09rZTBjVzFYUFVQZFk2V1B0ZzVFeVI1aDd0?=
 =?utf-8?B?am9qMDlQSFhjcGZOMHdCTkZwQlRnaFYyU0NvTlVGZ3g5SmlSeU1hUTFvV3k1?=
 =?utf-8?B?OHhlK25TeU9LRHFCOWNHSDJaenpXUkZ6RDJONHlzN3NIQkhXb3hJdTYvdU54?=
 =?utf-8?B?eUpQUUxzUmxTbFNqSjNhRS9rQWVweENlcTZDYkp4SEVyb3pEK0VaQXJvVytx?=
 =?utf-8?B?ZG9QSFM0OEZSSTVyU0xtQU1ENUlzc1ZZZHEzNlBOSmROQzJYN0p0WHNLWU1I?=
 =?utf-8?B?YVpxekYzSk0vcUlPK1hmTHRSSDBCNE5YTkZGaFl4QTRpTVFvRDdEWUxUaFRJ?=
 =?utf-8?B?cm9KUlNzb0dPZWRKcWlJRDlhRTlDZHFDQmlDck1valNKYUV0NVlvYUdGdXlB?=
 =?utf-8?B?c1hHZGlNYnNseFpmSEN6M0lwUGdDem9pazVsRVVkZWVCYUJDU2JyY2JlNmE1?=
 =?utf-8?B?eUlDSTc5VzFjdWMzT2lJaDAvL3BCSzNtektmdkhQNUJnSmx1WGQ1WXBScUdi?=
 =?utf-8?B?QTB2Q3NSTWZHREsxR0Q1L3RqakF1ZjA4NitKSG4rSnF6Rjh3NHN1VE4vcWtI?=
 =?utf-8?B?SDhPNDJJMk9RRnM0RkF2ZWxNQzlrMytyamxwTk9lc1F1YVE0aGM5VVEzcndv?=
 =?utf-8?B?OVFINVhwUGUyczY3UFJqSmttaUphTDlCUlQ5MXRsc1R2a01laTRIZzRsVnFU?=
 =?utf-8?B?SS8yZDIzUTNuRzk0SXBtems4QTRzMktWYURveFJ2Nk9HYUNRQjB5WXVSaFpZ?=
 =?utf-8?B?STZUYXJrdXMvOXZ2QkY4SnRXU25IT0dYNGVkQkJXWlV5SWk4RjNDbk82VVR5?=
 =?utf-8?B?QlF6RWZaSlBWVlgrczFrUFAwZ3NqUVRJQVV4V010K0FMOG5uTS9mbEFBZ2dq?=
 =?utf-8?B?MTNKcGdEVlp2ZWM2SWdGamFmYkJwSjQ1VFE0bmk3eTRzUHZQREszVnQ0Vnlu?=
 =?utf-8?B?WEpHa1BITy9HOXMyTCtha0Q3Q3lhTk1HcnFzUlhtdkJXYldJMnk5dHNvWlpM?=
 =?utf-8?B?NGhOK2VqZDBITVNRZDNDdG1KOS9BWVBUWlBHS0phZzVDTFMySThYbDlVbnBO?=
 =?utf-8?Q?UQVeeByMQiDTJw4qQEhWiyvtL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e80019e-3260-444b-44e3-08de02aedb13
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2661.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 18:58:35.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eIRb+f/CufQzVwjVd9w63DTxJ1FzA791uau1hfrA+xdli4fSNoqJMVft/gx0NU5crauFmO0zEZTCSJROIpo8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

Hi, James,

On 9/10/25 13:42, James Morse wrote:
> CPUs can generate traffic with a range of PARTID and PMG values,
> but each MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on
> each MSC, to find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
>
> While doing this, RIS entries that firmware didn't describe are created
> under MPAM_CLASS_UNKNOWN.
>
> While we're here, implement the mpam_register_requestor() call
> for the arch code to register the CPU limits. Future callers of this
> will tell us about the SMMU and ITS.
>
> Signed-off-by: James Morse <james.morse@arm.com>
[SNIP]
> @@ -113,6 +123,72 @@ static inline u32 _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg)
>   
>   #define mpam_read_partsel_reg(msc, reg)        _mpam_read_partsel_reg(msc, MPAMF_##reg)
>   
> +static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +{
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);

if reg + 4 == msc->mapped_hwpage_sz, the register is out of boundary as 
well.

So the validation should be:

WARN_ON_ONCE(reg + sizeof(u32) >= msc->mapped_hwpage_sz);

[SNIP]

Thanks.

-Fenghua


