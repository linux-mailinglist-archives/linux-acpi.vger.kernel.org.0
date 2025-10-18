Return-Path: <linux-acpi+bounces-17933-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CF437BEC335
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 03:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4C7C4E1EFB
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 01:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ED3481CD;
	Sat, 18 Oct 2025 01:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OiJdhpzV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4522F01;
	Sat, 18 Oct 2025 01:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760749296; cv=fail; b=LSCn7kn6GaUIZyGwJU3jxg7boOvvW89MIjubtzntSbTBPkWe42bXfpYDq6/aanEki+wEEvwhmMg0wMiLdD1qaHpn2A+kvVB9Ub0nDEOz5GrtXxrD0CVsYPMdVXfMQF1LuxlhimjcERg1u+SZAOM3LYSmleddCKoLFFpxo3lSkGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760749296; c=relaxed/simple;
	bh=5qwM0KgrYzVBp3hyxH/z20KINa/Yfbs9VtWjdfjY6Fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tInNYiK7UfRZI4VRelA3g387Z5HGuPbPNcPcPlPDUltpb0iM8gubtf9XlECP8ZLmY2jgkksk9gJUT2KwR4VM1L88C5orh5VWHAk3NQx7W5HONXGT28zip5oyAH8GWxsEtSXIxq0A9qRf1DN7pp0n/TbTQuqX8cxKMK4lAwJwYr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OiJdhpzV; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr9njaXTcEqu/fn0HNxBgpYglVnPRbEoRkpbIMwnkJ/UaQvbrns/A0KXi9BZ98oacp3muA7Kmo7vVXs5f6rhP0MiqBspM2RMv4F1biKHBDfIwpryWu7xzkufftb6Ddipr/AnO4PMBEvzb1vpJZzRx0myz9X9wJYxOu1KtAaRwdTOfI7k1kV7aMjlS42QkEefLC7eAxgNwd5C+0ueFqnFmZ2mU9eNb/sdjFJuXs3vU2QXfOe1EzkoA1uzOLQFXvA8NkQr5Zla3KDAzems6kOAY45vpWtHYhhIHBiamI+pmEqPfZfyy9JmZJBDxJ/L0LGpYa3LO20UqFOIWZMqKOj59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9KNn77qdX8ETulhX0OKpS5QrnBNsmJlREMvRgvS7U4=;
 b=j09Kw3XmEBKCKX8EyPBGgHGEmlhDroL/IeENP/P1Dxycn4ZvrKkMSrYnVeHFM/j/esxFb8mHCW3REVOu8rFx0zXXS1SKClRAweGNHm1pM4HROalsnWDDfVGvrUcxFt4jcZRr43is6jlKgWNhLvy7nlpNaNZMHC8ehKoUh/bkHQMO6CRpoakt76/Hh1VcgXl2XNU41vRvlmezgYSFaVzlGqamAEYKqSxCLO/a8Fe63THLSSNEgvB5QahbtJp27yBB8ye2LpLwyWlmxfcJa1dqFOwWAZWVRN9hRQIvrkPK+bmPkageHrBcPxkeJDQkX0P5qhNyLutsC2Rd/UGwut/2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9KNn77qdX8ETulhX0OKpS5QrnBNsmJlREMvRgvS7U4=;
 b=OiJdhpzVi9ulTdbNa/Eyj1kXPyXKRCmfnQMme8W5qbgfKZdWI4Os++Zt94LYlN4wZTj0dovduRQQTrh+KTCiTnkzfh3ZVlNJSWpKKyptJjkhQuGU2SyW02DZpK7s2VjUgDdieQo17vCzilyNiyu35IF9HQTRwChCd9HqAr2Z7O9jZlCnL9P1Lu8n/UVsKWwD4l/fGbRnZ2JOlQwfoU+tRZUgMpBCQsKRgRX6udhlPg+Nb7PHwxN8h9cdumOfrN9T7dev2LycDgNW6BMeXYOyHbrqyYFdlY/0P8qabmqIG0DD2vVAD6+9en5hkLMWqjYOgtfblm600RAm0GH0NLU4qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 CH8PR12MB9768.namprd12.prod.outlook.com (2603:10b6:610:260::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.11; Sat, 18 Oct 2025 01:01:32 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9228.011; Sat, 18 Oct 2025
 01:01:31 +0000
Message-ID: <df84f19d-ff8e-47fd-94ac-8ea5bb6a01f4@nvidia.com>
Date: Fri, 17 Oct 2025 18:01:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arm_mpam: Add basic mpam driver
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
 Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
 Gavin Shan <gshan@redhat.com>
References: <20251017185645.26604-1-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251017185645.26604-1-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0389.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::34) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|CH8PR12MB9768:EE_
X-MS-Office365-Filtering-Correlation-Id: cab101e7-ce7c-4ee8-5306-08de0de1e030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWx1T3hsUWxsWktqUTZydU4xd0VRRzA0ZE5nL2E5c0l4RkdVTURGN201WXNH?=
 =?utf-8?B?UGlqanBhUFhHVVVCM01vdm02NXFJQWtNbUhpV2t4Q0dLNDMwU2dWdy9MWmVD?=
 =?utf-8?B?UEkrc0tOYmd2K29vTG9ka2EvRjJwYXduVzNSSzFRUmptY2hha3VTak5vRUpn?=
 =?utf-8?B?ckJMMlRUVUVUOS9pd0lWdnVyZHA1b3RwblBSYzVNUnc3eEJ5NFFWdVR2VmRK?=
 =?utf-8?B?MUVSY0M3UHlyZVh3UldseVN5MTdsalNsUk9MUWdhK3JHT3l4eHg2ZUhmK2RQ?=
 =?utf-8?B?UlFXRFJLaE1mSjFRNnJ5MTE2WWw1NDRUeWxObklvenJ5RkVYQllQbGl3bW1H?=
 =?utf-8?B?V2hGUlBvNjN3V0N0TUVlZ2w5ZSswWjRCUUY2YzlmNzJFQWVHZnhXZEs2dHBG?=
 =?utf-8?B?cEJzUWg5dXNnRGJlWXJNN0htb3NVSDBPakdhZ2MvTk1SUUtmTlBEWk1mWHJW?=
 =?utf-8?B?S3BsWVNtMVRhejFNajV2cnFqcEJDc0VwY0xiSGd4cHJuZTFPTWdXeWFQVnMv?=
 =?utf-8?B?RzNWWHRiOGxYVzZ3a0FVakFMazhsZ01tL2VpU0JyMm8zT3lNR1hrTDdTR2JL?=
 =?utf-8?B?SUJwd2dlZjVoSkFzVGlEWUhCemNaZjBZdVdyVkhDN0RVVHBlTSt4bWtoVnZx?=
 =?utf-8?B?cVkyTEZYWHVIbWlSdWpFbFVJbGJGWG1Jci83MWhHdlZmdFIrY3QvdGp5Vzlp?=
 =?utf-8?B?S2tEQzdvVUVwNXV1UitJdUVkbGFZUjhxUmhaMm9xdmRYSmlZOFFUNXZPUWh0?=
 =?utf-8?B?SGZXb01BZ3p5SDRMYUxlQ29Hazcxc2JsL1NjSVE5UGhqUC9uNHpSeFZXdDlE?=
 =?utf-8?B?NE10ZllISHEvUkJtSGRiVjVLcUt5Q0Q4bGhoaVdwYlIwUEJaaDd1R0RxdHY2?=
 =?utf-8?B?SVVyWUZPMXF1OUEybzRiRTNoTCtCL3laNWRUNG92bE1RTXlVV1NMSUNiM1Ev?=
 =?utf-8?B?N2lVdlkvbVhIZExUdzdCOUlHZzNzOXVESytLOWlkSzludVZEVVhlanhLTjh3?=
 =?utf-8?B?SkRrLzRLcXcxVEg1Vy9TVzBJeklzaFlGNm5KY1RmWmtoTkxNMGc4bTcvd2Rk?=
 =?utf-8?B?VDdaaXozNWJQYldGUStRU011VG5VcGR0YU90OU1VTXUrR0JSdFlLK0R3MVpq?=
 =?utf-8?B?aUorNkZONFM5SHBCeVBJMWlIcThiQStkN2JZMjBldmtVMEd2akZTOStlUi9F?=
 =?utf-8?B?REpwZFIzMUovQk10VHNORk9RR2M4VUpycWVUeHNFd1MrSWs2ODN1RURySlM5?=
 =?utf-8?B?TVJ4ZkQ0YmdCUy9SUG9maDFTT0ZzSlZDUkxncldVU3pOdXBJQm83Rmx4ZHpY?=
 =?utf-8?B?emlTSTJzUHRHRWszaElmd2V1ZVlmSTRSWXY2TFZHUUtoV3huZU4vK1I1cjlK?=
 =?utf-8?B?N0p5RWNpMGRHZVRrRWdZZDNNZGExVndacDUxQTRHQ1NleGduU0VjSDN0WmpH?=
 =?utf-8?B?MGsrQ29CQ1dKNTJyU1AxeW9Gd2NwR2VtaXpoWDUzeXRMRXAxL1lndjRqV29Z?=
 =?utf-8?B?OTlsSW1Tb1JlL2pRRUJpd3BxS21KYlMydzRLUm9zOW9uWkZnTW55TlNDOFFF?=
 =?utf-8?B?UTlOdk9WU1QzSFlCTU1MVmZkREV1bEIwTEJXazMzcmlpaFBrM2RjSDl4Wlg4?=
 =?utf-8?B?Y2RzQ0k4bDRHRVhhQWdNNC8zSktDRCtqaExOSzV5MC9FaWRaN0V0MUxKMzZZ?=
 =?utf-8?B?VUJtejZKOXBSUTd1dXJzeHJRb3ppVCswblc1Nitwb1NuY2RoKzBVYmkzcGw3?=
 =?utf-8?B?UUFCYnM3UlZreFFiZ3EybjN2cnpvWkp6bjBsQ3BVVXNValpRS084N0J1SDlD?=
 =?utf-8?B?aGFEbHRoODZ6R2diL3JKc2tMT21GejdKSXRXcWJ0bXhLdS9CSWRkUHAveU9o?=
 =?utf-8?B?RlJyTlNaaVJxVlI0Sjh0SU5HZzVDZHJ3eVJ0U0RPNjBXcGtGK2dVcUpreE8z?=
 =?utf-8?Q?POTvuN8eCqSHI561tYWF+98oc0dfkbVc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXpaYnNtQUxDaXBxK2dtL2VQZHNSL1ZpMmFmbzM2MzB2NURDNGJUSk5MNWxU?=
 =?utf-8?B?TStTcmFQa2NuOWUwUlUzRHhEQkRCR21LdUFRazNmTGNjODA4Z0tORXVSY0t1?=
 =?utf-8?B?WVlkam5vNmc2Q0RIUllQc3R3a1E5cjVGanlxRjE5blVXZWxXOVV2NVRoSWpl?=
 =?utf-8?B?VE1WT3YxTmlNZUlKRUNWVUxITkhuWWpNUTREb1pvOW9tK1lCNVNZM01iUlRI?=
 =?utf-8?B?VUEydUtPc2Z2OW8xUWFQY0xZNmVwN2QwWm5Rb2pDd0djdlhLdkdzOFdsbmc3?=
 =?utf-8?B?S3VjRmdwV1ROL2tMVjF6OFhLVEtTdWI0dkJkK2hFY3RCWTNuRkpGaTR4TTZm?=
 =?utf-8?B?QXlFc0I5R1FHeFJTYzNpdVg5NnNYRjVZSHViSVVsdXdqY1h6U3Y2cThMc3Jk?=
 =?utf-8?B?QzVKNUQ1QzRsOG5hR3JKdGJuUlVpSHRScTZYWjRJa1FnbEM4MXpNNFJDZW9E?=
 =?utf-8?B?dDZ5UHBsa3ZLRUJScWdSY3BBVGN1WXFUTkRPN3NuWXhWVE9TS242c2RIZ3hi?=
 =?utf-8?B?bUlpbEtZeWQ1N2pycmVKV0w2UGNqNlhwRjVFNlIwVGUvUklwS0xZNFRsQlVw?=
 =?utf-8?B?QXlwYWZGWTlacXNaZEpiRElQMXJwK0xOSlAzZmt5b29xZmU4VDRGbUNlOVhm?=
 =?utf-8?B?aXU4anJWbklCck8rUGtlL1JabW9zb1I3Y1dSYlJyaWFrSFE2bHVYeS9Nb3l4?=
 =?utf-8?B?bXZ5dzlkVWFDMmV0NWJaVkx2QXptTDBHRGhWazhBUTRaa1J0TldDMzNWYzl4?=
 =?utf-8?B?MUYyNmdERnBpQWhRK0QxVG9xVHFhOE5HSE1pbzR2dk9ZNXNrbDBHamY4bUhv?=
 =?utf-8?B?Q1I4ZHloSTFycUgvRGdOWDJlZVg1VmFqMmFYdUNoa3RWSzN1UElKTUFKSzc4?=
 =?utf-8?B?eTB4Nk5qQk8vWGtobndiRDEycjJra3V3VTZNdkdCb05uM2JHMXNTZzJUZVRi?=
 =?utf-8?B?dktsTDg0bGc0b21NUU9lRWxIRFM0d0ZMdWVnT21Jc21PS0NudzJEYUg2SHg2?=
 =?utf-8?B?TVhzUktLalZRb3dtTCtWck9KNk1vRUNzbFRnUzJ0ZXg1NkhvRGU0TjlKd2Vy?=
 =?utf-8?B?aDZuVEE4NzBYUlNSN3JIUXBYbmVmY2hGT09NWFNWcGk5TGU4SUxvbzUyZ2t4?=
 =?utf-8?B?bjd5Ry9oQzBrUmVsNTA3eXJUQ2xkUkp3TmNoc2t1RE9XRUZYblFadFRZczRX?=
 =?utf-8?B?cHFUSEJmR0kxZCtlQUFSSjBBWGtCeHlQOHFwUSt0RXZwRU5Ed2NybnNCaC9K?=
 =?utf-8?B?YkRiTWxSNkdsaUlpdWxJMWhGcFROdjRlUXpreXpWVTVCcnlza2Zldm0rTkpU?=
 =?utf-8?B?ZnJodTFUWEpaZGRDWFEzdGhKMU00c2I4b3d6UXg3MW1LQ2xKZm5OM3l4UUpi?=
 =?utf-8?B?NUladXRmTm44YnZNK1I2U3BleW9ESXd5UWlFWGsrTTBkUnB5cHgxcWhKdFVF?=
 =?utf-8?B?ZC8yWEZFRmVLdUpubzQyZ05HOTZVTitOQXRyTGFpOUo3S3Zra2c3Z050cUhG?=
 =?utf-8?B?UjJwZXRLSWw0TklOV2daSEkrV1NTd1YwK1lZOC9vWG9hV2xWWlR6ZWQwd1RQ?=
 =?utf-8?B?QUthdlJSTUUxYTE2YTRGSmV2WldhUy9FMkxjdzRBTTRNSkZWWTlTemF2d2No?=
 =?utf-8?B?b21oanZmZXVLWlJLVllhV0lMTW1Ja1NYajV3UWNFcXhwTk4yaWtxUEFSeUtO?=
 =?utf-8?B?K04rT2s5N05RdlNsbzNTZTBVQTJIZkp2a3RwZkdJd1lIQ0JMcGg0SG9Xcnho?=
 =?utf-8?B?cnZjV2FlczRKdGNjRlN2WW5HRmhmUUtJNTVrOWtwVXplbXdMZThTd3VLMnZi?=
 =?utf-8?B?eHBjLytMcGJGbXVtMjhMTFhoNGlqWW0zUFQxVCtFZ3RhaXQrQlNaTnl5MXI4?=
 =?utf-8?B?Q0ZaQjlRT0o1ak1kdW1SRG9sNUMwYWNmWTlkSmNMa0V6cUg5cGJaTFo2LzFs?=
 =?utf-8?B?YmQrK3JLcThPN09qQk95RnJYL1hUbDhCUGY5WUJpL0o4QmFYams2SmpiOWJ0?=
 =?utf-8?B?WjBGajRHQ2tFWnRQeVNrNFVGclVERnBDQi92SVgxTHF0aTd6d1BPWWNtRzVh?=
 =?utf-8?B?bVRCUDBoOXlIaHJhWFMyc3E5U0FBRCt0N1ZGNWR0aUhveVB1VWpKM3N5VFpl?=
 =?utf-8?Q?S2kKKkTW898QARoIls4yVTdaV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cab101e7-ce7c-4ee8-5306-08de0de1e030
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2025 01:01:31.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pg8b99B1hva7HiVfImsZNJ8Ql1Lnro4bLFa2wFdH+oyHMIp1GVQIWlsY0HXq6x4+3c1oatrx0b3BvDxdaNfI1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9768



On 10/17/25 11:56, James Morse wrote:
> Hello,
> 
> A slew of minor changes, nothing really sticks out.
> Changes are noted on each patch.
> 
> ~
> 
> This is just enough MPAM driver for ACPI. DT got ripped out. If you need DT
> support - please share your DTS so the DT folk know the binding is what is
> needed.

[SNIP]

> This series is based on v6.18-rc4, and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/driver/v3
> 
> The rest of the driver can be found here:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v6.18-rc1
> 
> What is MPAM? Set your time-machine to 2020:
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

In case you build/test the mpam/snapshot/v6.18-rc1 branch, need to apply 
the following patch. After applying this patch, this series and the rest
of the drivers run successfully on my machine.

diff --git a/drivers/resctrl/mpam_internal.h 
b/drivers/resctrl/mpam_internal.h
index f890d1381af6..132d29e53ae9 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -645,6 +645,11 @@ static inline void
mpam_resctrl_teardown_class(struct mpam_class *class) { }
   #define MPAMF_IIDR_VARIANT    GENMASK(19, 16)
   #define MPAMF_IIDR_PRODUCTID    GENMASK(31, 20)

+#define MPAMF_IIDR_IMPLEMENTER_SHIFT    0
+#define MPAMF_IIDR_REVISION_SHIFT    12
+#define MPAMF_IIDR_VARIANT_SHIFT    16
+#define MPAMF_IIDR_PRODUCTID_SHIFT    20
+
   /* MPAMF_AIDR - MPAM architecture ID register */
   #define MPAMF_AIDR_ARCH_MINOR_REV    GENMASK(3, 0)
   #define MPAMF_AIDR_ARCH_MAJOR_REV    GENMASK(7, 4)

[SNIP]

Thanks.

-Fenghua

