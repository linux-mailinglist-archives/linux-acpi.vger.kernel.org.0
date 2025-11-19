Return-Path: <linux-acpi+bounces-19057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF98C6CBAA
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id ECC3D2CE36
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35602F7AC6;
	Wed, 19 Nov 2025 04:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcf51FSh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012070.outbound.protection.outlook.com [40.93.195.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F59D2F7ABB;
	Wed, 19 Nov 2025 04:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763526444; cv=fail; b=EPytySmj76W1dBG82BToe5Fs7nBofgLlYU5I2ks/37O5OuKm6X50xLOlh62zeGldG7ugYGNPNRlWrFrI2+8g33RVyj3WZxWkI4KXZybVePyYXum7QP5RFfyQA0ZruKa/OvYtSaqT2f+ZCAFLI9WF03CpCaPDCO+W+xYRc3xnlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763526444; c=relaxed/simple;
	bh=OTONv8ThXXXYmzMvLO1ze+wHF8JKH9Cf8KMWChAIBdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t9JJ+tf542g+IIXIjpNDM1LSOM4VrtZcpIWQmUygKR8UW7AMHJtD1NZXzmoTkSm0WNO8JJAn4iM+SDWYFrDpWowa72RZtNd5epXeAXVySgJVW82IpsCdRDvNlQYuIPs+PhPbynqL366q9jy1/E2jVu5cs5gjispcKmzmMJyWX1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcf51FSh; arc=fail smtp.client-ip=40.93.195.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpLRdIaCrBYyoRjTwDhhwAmTSlXqV9aJSSiDGhDF0D3aynnXZwSYQw9XYIulJqidizMqwmJFuZpho9NP+ZMdSIiFRMtycrT0jf8k9aImFTBKPHncsxssni40Bk0uow9pDIkNPLAFNL69V1wMNNFu8P8llgdGL0jGuzKA+10isKEyyMNIRNwLaclo1o27L0oyLQbpw/jbsuH2YpnRmu0E7vrDsiDLFZufD2W21MeWXUP/2y7Klb+64Hydrk7qAPjn0wHOVwLyBUpOs5KhoDnwx9QGrZfYsBaNLx67bRMqetB1rsy4vciXFNwER6UEooXa/l3chrJwJRxy+1ybsKjfsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfyebDKhVPTuaMYVMJszqz2C4L106pEP8M4RR07W5kU=;
 b=vkx+9YRQw9v2XLQqIO6+Eq3QKJ6FM0YFC2AQhF3Kez9F7mEHDKIeoI8kmtHTM3JXJdOxQthskXP3ICFDBuNt8GNVWZ/OSO0P9wE012FG5fSOn2PlHrp0FAqwsIhs5gyM0Q2rzN6KHSCggnlqxCg4JSik9gNt628v3/CjPprJD2WHHR4pCns75j0+FN/4QI09TmxV1sbyr/EjWzANDSs/njVBN59Hkroj2OehqJfpf9bDeexGD9I11CCOatE+Erauq0MCVpE+YIA5+wcaCZKzqj+81/n/oi4+CRla+wQQpJFytjPfHtl0ggLWETKgs3943XKjGwq5t6MVFXkqyhWTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfyebDKhVPTuaMYVMJszqz2C4L106pEP8M4RR07W5kU=;
 b=rcf51FShOpZXAVkf+QigEeUVYHWNSHFEVVDq1EusEM2muvuz6avf4LwvbfRwhm/qOqNgrAEEdVdL3L8r4QxEEJN+IYjj1WWjfqawnbA9RAarp+bpjqFTsSRMpVfGuYgi9vEqIUVmWAgQOJTu3a9Rx/QcjEqmnR9e3AwtNTtkaP9oKMRQT5WMfYhiWm2CiS/sh/SZ8opHikYMYHapEuaq/U/VgofHlo9adJ4DcCH1g8hVWB6jO9IRE4b5l5OnWAGxnEq/2Fz32nlVxSOMu7N+s1oc72+FWfU3WsxnnFsuB6wJ3lqiNag+ova3/t68NfhA31auXAOEADurfVlo2OhXFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS7PR12MB5886.namprd12.prod.outlook.com (2603:10b6:8:79::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.21; Wed, 19 Nov 2025 04:27:19 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9275.015; Wed, 19 Nov 2025
 04:27:19 +0000
Message-ID: <552ffc50-70c0-46db-b2af-eec7b511ec82@nvidia.com>
Date: Tue, 18 Nov 2025 20:27:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 28/34] arm_mpam: Consider overflow in bandwidth counter
 state
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
 Zeng Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-29-ben.horgan@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251117170014.4113754-29-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0035.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::10) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS7PR12MB5886:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ee8bf08-7604-4af5-e706-08de2723ed0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N1VQbklLVVN2SmNidXRMMG9NMVhadFVIVGFYam5BZVdMcElBU0RxMFhvd2FO?=
 =?utf-8?B?K1JGeitIZnFLSW5vNzM5TUI2MUtEQ3lGMXJjcDhtRlVnRy9uZ2g5VnpNb0tN?=
 =?utf-8?B?emxJTGVSVmZ0WUhNbmM4OWwvRWFEVVNQZGpVdFVYeHV0SFhuSXRqNmczUnZo?=
 =?utf-8?B?MzFzYVFmNFZSMXR5eHM2b0tOaWNRZ1FmRXc1aGxUeEpVd09BMGlTL3B5M3Bs?=
 =?utf-8?B?Wldlc0tyVUVsZnFDbmErYjJMVnQ3eVlTS3dJNmNBNFp6bGV4VTRBNHNrVkVD?=
 =?utf-8?B?RUE2dHMzYzRsdmVNZ3F0aVpFeDIzaTI4QWdPUFJBSDJCeUg1MUZYYm1nN1BB?=
 =?utf-8?B?TlphcFFIUURTZ0xwMXYzNzRGSjBTZ0ROUFRnU1Rka3QxZjVnS2hLQy9pWmR2?=
 =?utf-8?B?K0hpeUJObjZncTA1dkhtcjh2Q0d5NExaSkY5T0NoZnVNbDB1UzBOTVg1eGVF?=
 =?utf-8?B?NWVwUjQwdkhsYjFkQjRZcTA4MnNVRElFSkRvOXdvaEdaS1RDTG1IME1GR0Nk?=
 =?utf-8?B?bVY5eXZtbllwdlZ1N0JPZXZqa200NlplSnlOdlpoVGc5Sld0U2VWTXhlanU2?=
 =?utf-8?B?WjMvMU01bkorUldwdlQ2enZKaWEvV2xkK1FmNUJBWVFCTEhma1hzOUtEZDZE?=
 =?utf-8?B?NDZ0OTV3R0s2Vlczak12SWVKVUxSSlZ1RTdTdVZwcVFQQksxZEJOZG96VTdi?=
 =?utf-8?B?UWhPcmxaNW16ZGR4NytyZFd3NDJqVkxaZXJvNjVDOWVGV1VNNjE4WmZnZExo?=
 =?utf-8?B?R3Jvc29qRE9pUEFwWGRONGt0VGpoSjhFTnNJTjBNKzVIRzlPeUQxTHFLN1Ix?=
 =?utf-8?B?NVAvSEQ5K3ZxVEphT2orS2FGV2VXRHZ5dzFsaDZMU1FOdktua1J6bks5ZWxI?=
 =?utf-8?B?WWV4T0dmVjlGS0FnUEVDbVNCRWRMdVpjZ2lCMEt3WHoxd2h2RFdkYWVMc3Fn?=
 =?utf-8?B?SzA5ZFNwSHZ5ZlhQT0tNUEdPUkkwVHZ5VFBPSVN5TUNnbFlyMmlEazQ5WnRE?=
 =?utf-8?B?bmRQdXZJelowRldNVlVXWmFHbTl3ZU9JeHdScnVUZ1NTelNJYmlqcHA0alBs?=
 =?utf-8?B?V01JOXhYMzZTZzhKTFpJWjI3bVIrN3BERWVkL0VwMnh6NldxdTI0SXJNUnZ6?=
 =?utf-8?B?UnhQRmZWakpsTk5qVzFoUkNBeFdRbzRQZStjWEhsUEFaWG5jc2ZUMTVyS1JP?=
 =?utf-8?B?QW5DMkhGYlh0M3VpMUFrZGl3K25OcjZrRWhwbEdKa3N6cUhOWVNQeUxMa3k4?=
 =?utf-8?B?M3Fwc3l0cEhpOGZ5cTlIaHJDZ0IxTVg1U085KytINmRHVE11ZDFqTlJPd3lO?=
 =?utf-8?B?M0cwTDhPR1VYemlZYTNDdi9aTzJJT1MwVWw5dVFCZ3ZkMm1jc2Fod2hxM2I1?=
 =?utf-8?B?U01FcldFZUJOaSs0eFp6YWU0SDF0TElJSGJBc2t4R2wvSGVKai9RVEhlVE9y?=
 =?utf-8?B?VHMvT0txbGV2QjhsSDdMYjRRVktEMi8rZnd3TW55RmxlQ05vOHdTbjdpWHkr?=
 =?utf-8?B?WndVYlAvdWdhbEo4T3JoN2VSNVBqaEJndUQrRGRaY0ZUZlRvK3Q5Y2ppWlRE?=
 =?utf-8?B?d0VjbENNWkNkRVl2aVZFSjVoUk1vdjlNSnc3QXY1R05RNlBWR0hzdUdNd3dz?=
 =?utf-8?B?R0RtSDJ5UmJ4dit3Vm5CV1kwci90OEZEQjNUUko5SFBGSEVQMkhBSmZ4bDVX?=
 =?utf-8?B?V0ZUR1NneXArYXArcnZOK2UvY2l4SVpITU9FUWdoV2pqYkRzaTNjMXJWVVpv?=
 =?utf-8?B?UkViSnM4WjhJWlBPWU9EbkFGT1VRVE8yWjQzOGdjTlBWR1ZWelVJTjh5NHRn?=
 =?utf-8?B?cWVJVWJtM2xPL1MyZnRtTnA3UndNMFpYak9XWkZvbVcwUGZidUQ1bVZmRnN5?=
 =?utf-8?B?MHMwcTRydFVSSUQrWTlFWW96bzBQRmFPNXJCd0Y4MXVhdEhrTndnKzkzdmhI?=
 =?utf-8?Q?JQpyGOxJCz9YSBD/uQQMSqYC/nCs3Xwm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVMxa29QeDJYa2VsWkdyYnZ2KzhmaWN4amM1R3c0SEk3aVZzdE9tcHdETlEw?=
 =?utf-8?B?MXRadVFHVSt1UWNkcnZ3TGlaOG5wdXlsQkk0L1RIOFdCdmlXanhRSjMveGFU?=
 =?utf-8?B?QWxFakdaZG9zSEtVVWhRRCtyNlJ6OWoyWi9mTkQ3WWl0am5NdzhybUpuck1I?=
 =?utf-8?B?UWIxdittNkJ0bThpQXEwbnBEYk81b3k0ZVMrczllQTZpajdBdmt2eEZlK3dW?=
 =?utf-8?B?ZHhET242UHhYdUFYYy9uWi9DcDV3b3VEL2pZNlFHRmxKYTByVUlocHR6aWlW?=
 =?utf-8?B?M21Ba3YzMHBOVTdCRHhHMVBqSXlaUFpNWGRRbVFNYVVlY0tEbkdBSGl4eHcy?=
 =?utf-8?B?a203NkdWVitUL2daY2VCUVM1ZldUdmMvQ3JJUGtvdDRkVVMzZkJuYlNzUVRW?=
 =?utf-8?B?akgrems1SEE2SUVyeWVkbFBpTGovajJYK1JIdDFuRmR4OGdJc1RCYUF2RlBt?=
 =?utf-8?B?OUxmK00rMUxOV29IUE5ndnM0UC82OGpEd25ManRGMFpYeGlHdHNrSzdkSnRw?=
 =?utf-8?B?cGtiZGp2Qjc5eVdDVVpNSEpteHpkcUI4Mk0zUDNDbjZFeWdiTlZzV2NrVXFo?=
 =?utf-8?B?Z28zVit1c0hEMDUxWXhvdVBrTHl3VWRSWXBLcEFVYitpWUxBWWtQb1ZDTTlt?=
 =?utf-8?B?Mk5lOUJqK0RtWlBBUWFOT21Yc0dWUExsVjRZTVJCOXNSbGUvTXJVUVNEcXJG?=
 =?utf-8?B?TW1zTmlrNXpDY0ZGRUhKaUV5cm9xSGpWTGNvbHMzUnE3eC9Fdjd2SXJIckJx?=
 =?utf-8?B?YkJERTlSUDl6SzRjTXkvYjFWNnc0aHY5OXVRbHkveFFiYzJpY3h3Wk1GMy9n?=
 =?utf-8?B?MVUybnhNSTNCSW1oNlZIa3B0aUFIR0ZhL28vUjh5Uml2ZkdRaGhOSU1RWjYz?=
 =?utf-8?B?b01OYnpHM3lQeHMvNXVncEpHd3dnbjBmTVFYQ29WSTFRNUMxbnVFbEY2M3BW?=
 =?utf-8?B?UGJiTlI5emt2ekpZL1VSakdLbXpZS0g0YXlFVlNjUFc2YSsvYk8vSU9zTk03?=
 =?utf-8?B?MWpqdW13SEM3TFhmUUlYSDJkRzQzeU1uaS9idkRKcFhnb01vVEhJaUo5MHR3?=
 =?utf-8?B?ekU4ZWtBbFZBWTZWc0hubEdDOTZJNDQ4TTc2QWVpZzJXK3ExNEdZR1Rqb2o2?=
 =?utf-8?B?Q29YelFEcnR1K3lQMVUvSUIvVXF3RXpyYmlEWnlzdWswMTl3aWZhWlN2VnBH?=
 =?utf-8?B?NEE4WnRpNnJIY3JTYStpMEN1SzdlS2toZmdYVmZnUUdqMGs3ak93dnQ3RVYy?=
 =?utf-8?B?cElKR2w4VVJGcFZYNU1KZGNWY1ZWeTd1bjZiSzdGRzRlS1FYTndlNWNtclFI?=
 =?utf-8?B?ZGc3Z0laS245dzFPVGVFZlAxLy8zVnZkd1BVd0crSGpMa3JXUHhSR3gzVXZv?=
 =?utf-8?B?bmtMMFkxSmJHMEF2ems1bzFQZGtkMmk0WUZ6U2ltUm9sSWNkSk9CYU1Ic0ZO?=
 =?utf-8?B?VWsxRFJ6ZnFzOS96Q1AvZmQwQ3NjbXo2YkVPVjFZSUlscDA3cjExMW40UWJ3?=
 =?utf-8?B?a2pCR3U4ZitRWmF4cTJBdk9rNGtxUTJLbjlDYVE3UHZwbWViQmRpak9RZTRD?=
 =?utf-8?B?cis5N0FDTEtDcGp3ZGVyTy9RelRyY21kdDlqbWZRZllNMUNrL2hYSHRiTXUv?=
 =?utf-8?B?eHdWY1hmMDI5ZWdOWkNMQWZBU2xmTG4zVHRZMVlRdUJGQ1dPREhqT3lVS2p3?=
 =?utf-8?B?c0RrWHM1N2FkT2hITU4vcUx3ZWxBUlFYWngwcit3aHdMZDIrOFUxMy9TWkM1?=
 =?utf-8?B?SlpPYUZTUW5GMUpnT1hZL2ZJRFlQd045ODVBa3ZOMG81Q0Q5L2M3TkZlbkJM?=
 =?utf-8?B?b3phNjQrVVE4U3hSZElaNlZveEZnRWVZdk02T2VIWnRKN3lNbWhHcTdhbDdt?=
 =?utf-8?B?TTVJUDVIaCtyQVJRWXFFQ1NJTTFlTjBMQVJhTnlrTEVFKzFabXhKRWZRUjY4?=
 =?utf-8?B?K1hjZmJmNFhMNWVyNTdVclhhanFLcEpOL0F4YVNhaGZNZ1hhVHl5UWRYenBX?=
 =?utf-8?B?S05RazBFRHVBNW82RFdrSHpjaXV3UlBVM1dnYSs1MmRPL1JYVlVEZjROZzdH?=
 =?utf-8?B?US9sK0dXMndncTZzaWpiSkVlU3AwVUxsSFFvZnViR051NXQydzlYZ2FPaExM?=
 =?utf-8?Q?Ll0y9S723SnNL546ReG2cM9iB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee8bf08-7604-4af5-e706-08de2723ed0f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 04:27:18.9733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfDsEh3iS0/1ExlDGowDsPAKyDzREG1ofAkUbHJTGuAHn3/kOF/zIFZa62+6ULLgWnY6I9b62NyfHEGoOv9ruA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5886



On 11/17/25 09:00, Ben Horgan wrote:
> Use the overflow status bit to track overflow on each bandwidth counter
> read and add the counter size to the correction when overflow is detected.
> 
> This assumes that only a single overflow has occurred since the last read
> of the counter. Overflow interrupts, on hardware that supports them could
> be used to remove this limitation.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua

