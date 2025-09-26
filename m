Return-Path: <linux-acpi+bounces-17324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D273BA236B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 04:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65FE4C2EAB
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 02:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E9E15B0FE;
	Fri, 26 Sep 2025 02:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTYLONb+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF22D27E;
	Fri, 26 Sep 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758853925; cv=fail; b=Kstx57FirGTDeIVZ/yw5VbSsw2mObFnpPBsV4wIZMRgv4fcAtdFZYOSHh9u85gSqIGYR5iKL5g912SW8d+hCC1/SyGuVafIreENzG1txio+tMrzKhSq9mOXMwnZYoQ2c0l7aUW78xQz6SwDi2jcSzvPnnbntL8/bvhWkyRiGOqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758853925; c=relaxed/simple;
	bh=aDdLBBf9bkDdIGrvF5AIfdM1j5oETrhl/XH8VOpN1wk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyhu8GTTn7bFk3IYKCJhfpkqdD3XnJPITG48tHdSSMgvu26xG//NyyG3rs2R88jCRvGFgNtCODdpBxSbR2VZzyJEmhZltCGnoSo9+U3D43t5AQhV9HdiRIYg9Lm85U4yKeSMDXBPfdgtP2CGnlf3fdw4BZILA8Ig7O4rjSp+mxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTYLONb+; arc=fail smtp.client-ip=52.101.53.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=funjkInEWXqXWRcC8j3hMCQ8RcFuKrAJtepYA1IHu3BwwJ/EeAdTx51OyCeQ7EDcCAd6BJqGGmjUftSdCzgb7NDkU+JQ9OWaGErzjv7VJEfLBTzboFxC5Djsxz+Lx3AZgRAMaRVENA9jsv1sL8+kHNLDrtY12VUfnUEejPkFnYovI0zKRZDi1SwruMWK/sn/XH9zpIbB4cfR3ds0ocH/tydavpEKwdaXw+ckIwC68ikbXVlclGKtW/0sYqmNxy/ef+PZVvNGYU8Ukz2bjBrKJjcKtttL20HcEni8DmqrEi3ALebi6mVeHH3lVj1YbHzgMPerL8rV1Hgi2Z0SQ4nS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDdLBBf9bkDdIGrvF5AIfdM1j5oETrhl/XH8VOpN1wk=;
 b=GTi3hvqa42LTmJm7NvxKwDBgAtMrd5YWLcBJiIbghyW9dX0QP/PI7Yu9Q9ZvMUr028GIPMcQnlMDw19PdYeNRD9zSNDwmT00Pj9i09fOPhC+T1d4UJY6wgGAsLc9ArESs5aXjpuq6DJ+7F9cF3QvuXh9DlchkLV9ZLQeDbtH74YkY9E2RA+nl1M45zgrhGUA3P7F+y1BRIDBGAoBZQtxvpqtNWMcCZ/97unRFx+VjZZzaF7YDp22GVxino4WFq6OH9RlAJqd+TLmohdetIvzmZQdQ6kEeQEdyxvBNQW3pKvIZuMtpItNDdHuMVhcihjKPsuDk7S3N3eWxyQK8Z278Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDdLBBf9bkDdIGrvF5AIfdM1j5oETrhl/XH8VOpN1wk=;
 b=BTYLONb+0cA6A89O3frlup/8Ee7cFQ4oQu7Sej/jSVVYPZGwHfpik3AAUVz9midReKCugw/9CrLjJDS39MTizGLp9RPegnkeKO/VD0JHdmN5j55eBuQuBsjmTuUC5LPlLR7Iwf+DlsSNWY4qW0uF7Y86rIdxRZKOX0OJ2Ancd030nxVJsVI57ZOCbELwzHXJjM+f+WARiWN+RYWlUgW2fUr4OX44lJZjYyO3boF8wX8KMsY9jP63pfFIhYEkk5XUZcupt0IOdfVg+Al2u4ugvNHhsRLmHK6HtyqioIuzi0V3JXQI4RTnAD0L4ZCkn3e0XS+ntP1ytgkmX57Ogo5Riw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 SJ2PR12MB9137.namprd12.prod.outlook.com (2603:10b6:a03:562::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Fri, 26 Sep
 2025 02:31:58 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9137.015; Fri, 26 Sep 2025
 02:31:58 +0000
Message-ID: <6acfa275-93ea-4bbe-843c-62911280d950@nvidia.com>
Date: Thu, 25 Sep 2025 19:31:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/29] arm_mpam: Use a static key to indicate when mpam
 is enabled
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
 <20250910204309.20751-20-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250910204309.20751-20-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0247.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::12) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|SJ2PR12MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a38127-99e4-4918-35ff-08ddfca4dd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djI2NG1Bbk93SkZ5d1lKWGszbjh2VWlvQkpNeE9LUnhNdTBKNHd3MFZHakhI?=
 =?utf-8?B?dERIR3ErSWJLL2NpM20yaVQrdFgvcW9GNEE2TklhWFVFOUx2N0pYdzk5TUk2?=
 =?utf-8?B?SGVtN1N3a2pDMjZib3JxbzhjSlBOYXhLSFBDMzQxUXhDbGFMQnljVEd6Yk9r?=
 =?utf-8?B?NnZEemFPUWhLa0gwbDYwZjZ5TXFDVmlvZDJWT2ljbHArS3kzY2l2N3AwaUNl?=
 =?utf-8?B?VTNwd1BmVFp0VllQNnJwRElPZHppcmFIRkFyQXF3MDlPQzBHRHc2TGxuZjdN?=
 =?utf-8?B?cmQyVGJEeWRsUkdtb1lzcVRpZ1NsdVFXdHBjek9KRGRud3NKdmxxVE5tc1Vv?=
 =?utf-8?B?ZjBIUlNZNkdUWmN3WWZ0Nm5uVE14QjFURjExOWZvUFpwV1RveG8xM0xROHgz?=
 =?utf-8?B?czVwYzNiTXlXQ3U2Wmk0emcvMXB0WlRsM1BIRkF2bHppS0ZDRlVad0p5eitS?=
 =?utf-8?B?K1pZN2xkSWg2VmU3RUNCaVV1UzlpT1JHV1lBWXlhb0h6YWIxcWJIVVR2QjV3?=
 =?utf-8?B?WURVdnVyKzBWSW1rRGQ1blNyY0FiZGJlK01oaFJtQW5UWWlPTGszSnJ4RkNi?=
 =?utf-8?B?aGZlaDhDcmZzc3ozMFd5OWNteGFvQnZGQWdTSGpQL0ZPbG5OZGg1STlZcUlr?=
 =?utf-8?B?bzlMak02enlOWlFER1dKQlE1dDY4ME0waWJ0NXBoSWRGV2JSSE1ycGl5MEdT?=
 =?utf-8?B?NnVCVVRibXhNMFRhWW5KeUxkRFNZeEJPUDM2TDcxV21ndDM4RkhCWDZmR3hM?=
 =?utf-8?B?Y05xa2ttMngxcEgxNXpuQ2g5R2thdm9jbXp1dmZOeUNuSUFxWEJWSGFzZDVZ?=
 =?utf-8?B?dk1IN3JTRFJoVUlBaFhuYVFYNUdtSXd3MHBsanNHb3FaZFBib3p6NmFBYXNv?=
 =?utf-8?B?dFAwdU1oamxncGRIYlcyQmZleDN0UExRQ0xhN2F3MUgybE9mcWVRQ2habnY3?=
 =?utf-8?B?WjE2bVVZcTBjd0lzT3R5bTVpMjFEcHdacXZnaHgya01NOVpFeDRLOVR1R1Bi?=
 =?utf-8?B?N01aVEd5TDE5dksxVHVVUUJDS3BuVkJob1hnS3JmVGR4RTRrNFZsQTc2MzYz?=
 =?utf-8?B?UDE0dDJ5VFZhYUZPS0QyTGxDWGVweUhrcnFKWGZabUFYN3FjMjJXTWVHUHZt?=
 =?utf-8?B?YURyeC9FSi8yVGNHOWxqaUhXOXAxQk5PUWdiRDlqd3dEWmFRSWJmL0g1Tnhz?=
 =?utf-8?B?VTdTNHFqS2laZ0hVMU00RG1BZldoblIvOVZydTFpMjNDb0NiWTlxblBFYXAr?=
 =?utf-8?B?Nm4zQkc2MHJxU2k3VXJLc3Z1dERGQmNYMzRzeEJXaDJtc2plS1JTSHRFOW5G?=
 =?utf-8?B?SkpCSnA0SnJHcUI2WUZ5YS94UlhwSUtpTU5kcWI0dzJod0RVVDZzdGpWM09i?=
 =?utf-8?B?a2VBWk5JRUJXNExTOTJwTDlwV1FBMmtHSUFxbS9zU1RQaHpzbGpOUVVRczgx?=
 =?utf-8?B?aFpZamRvNnFSNkNtWUhFTDRtdiszSzZSNmJ5cU1lcmxaUENpbW05OU5hUm8z?=
 =?utf-8?B?TmIxVzlPSzRtNk5kSFBncFZSMisvQ2k0V2JJM0I4S1NkWFVVbGtmbEx3Y0Q1?=
 =?utf-8?B?aXp0R3lJL1lvM2ErTUlHS2EzZ3BIY0dzcUxlMllFL0hqVUYxYjB4djVYZHUw?=
 =?utf-8?B?cm41cllUd3ZNbk1SMTlyaVo4c0NjR1NhazlhR1BwNEMrUitzVTg1RVlFemRO?=
 =?utf-8?B?L0VSOHNPL2ZINi9sTEdheWtHT0U4RVFEeFpMcUdtSTBSdUorT0VqZUxUU3NX?=
 =?utf-8?B?clNZMHZteEdSUDF5VlJQenZoL0s0cDR3VXBJS3A0ZjUrK0ZwSDY0K0tsTlB1?=
 =?utf-8?B?MkhwQ1VFSE1JSjNrY2tkRFBqVEJuak5UR0ttWWtaSzhaVUtFTjhUR0s0ZW5a?=
 =?utf-8?B?YTNQS0N6V3ZkKzlNK3lsWlpsWFY1TzlMR1dUcTZxbVBlRUFqTUFvT0xUMW9h?=
 =?utf-8?Q?McxB0zr4629VRb6MRebl2TVZ27KmTAod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2ZYeGJ6eUpDMVJNR3lkRjdqd1p1RzdpUHplT1gya2kraDRnOXlqWkg3WEw1?=
 =?utf-8?B?RFZ4TGt0UHJuajIvdlZsV2c1aGNobFFnTWVYMGZtK0hmeFlUSjgvbk1vQlZ5?=
 =?utf-8?B?K2lIM3BuMmhudlVTWk1NMHBsMHdlVllEdm5jRFJERE8wMGd5T1g5a3pYTS81?=
 =?utf-8?B?NTBPNkFpL29FcWRxSTdsbUVZSTFKdVRTeXdONXJwR2tydEhHdG1zRCtBSW9r?=
 =?utf-8?B?eEgvbkdTc3VDWVBXYTBBOEUvejE2TUk2ZkdRQ0FjOWlsdmplWGlmejZzTGx6?=
 =?utf-8?B?WEpwcDV6WGcvRmhodVpSUWNFallOYmZlTWJDQUxKRk1OK2hQMmhBZjFlWUlt?=
 =?utf-8?B?Y2J1OVJid3FXaVpaUGpMQlMzZUFneWZ1a244SE5sZzNjWjlLNmg3SU5PZzB0?=
 =?utf-8?B?ZnlSOCtVN3dXOWJRbmhsYVJwcEhBK0xiM2FOM2dTRXh2cGw2UitGWTRjVGJs?=
 =?utf-8?B?emtVOTlkMGM3aTdnUjVMVFQ3ZjdPNmYxRUdSM05VWjBEUENmUU5LaHNRMFV6?=
 =?utf-8?B?MkZsVHV6SFFJQUsvVEVlUkdZWTZJNE0rdm9zNTRCWGYrRmxMSCsvU1JxTGdI?=
 =?utf-8?B?RFVER0Y2cVU1NlRoVndUaEV1RFYySGgzUFB6RkN3N2ZEVG5heitmcVNCd055?=
 =?utf-8?B?a2ErekltUExNanJtd2ZULzVPcWQ1Q0VKd1gzVGZuc0Rtd1BZMHZDUlhnMGhX?=
 =?utf-8?B?anpCNHVLa1FhVm5MRUF5RU1LNjNJODdBTVZqR1g2ckR1VCsrdHhhTXJGTGFt?=
 =?utf-8?B?ZVVjd21hQTg5eDBsdHdLSUtyLy9yU2ZwRXV1Qm91VzhqdHhSTWphR0xJSEZp?=
 =?utf-8?B?Znh6eUd3alhadTFwUUVkbW5LNWMvMlVpSlkvV0hZTzQvdHVZcUJGcWZYaUFt?=
 =?utf-8?B?cnFKUnR2T3NNOGNQL2YvUVJUQm9LdGxYRlFoaVk1Ym4yWWh0c09QbDBFUVdK?=
 =?utf-8?B?alBjN253Y3M2aWFRVHdSSzA4ejByN1FPOERlRHpTRFVPMHZKTnkvRGQzOE9j?=
 =?utf-8?B?S0pWaVlveVJRMnZ2eVFadXJ4UTZHT293cUdwaGlVSG9GV3RqU0pVT2dJV2N0?=
 =?utf-8?B?OHRIV0VPU3N6QkFSU3l4bE1TbXNad09aMXc4c21QVjhpdU4yZldWWU44OTBC?=
 =?utf-8?B?MUtjdmI3N1A1ZjZzbDR4UC9JTVpzM09TTFFpV0ZaTE5zbHNJLzlXMjhPR1c0?=
 =?utf-8?B?QnJNSEIvVGwvbThDczF1cko3ZWEvY2JUbG1jcVo1Rk9Ob0dQRytmRmppamZw?=
 =?utf-8?B?cVIyWlY1TGd6blUrM2MyZGZFZUlYUlRtRjY0dHE0MnFrbU9zQ2hNVCs1ZEty?=
 =?utf-8?B?aE5CMjRib3BjUDhFcFplMWlYbzVOeFFLQ1JCeUR0NDc5TTRWclg5MVNzT3ow?=
 =?utf-8?B?d0lsNThqTzNMK29PTlNXSGxIVFBWcEF2TUhOalFkcjJGZG9YL0k5cW5hYzlR?=
 =?utf-8?B?SXhoU2xJZWJjOW0zV040dWFMcmU3RUR0SWlnY3RBcHRiQlpCMG5wRzFXNEtU?=
 =?utf-8?B?OW5QUVFuU21DcnUva1Y3TzJBTzBJcFpEZjY0T2JXWEtZR0JlcnY1SUxETFM4?=
 =?utf-8?B?dkJFRlNpaGlYbUpDZ0dCVnl1L2UydVVxc2Z2WCtqYU9rUW1WSkhLWGR5Q0lH?=
 =?utf-8?B?M0dnMzlDbGRqaVJjYnk4MG9JdkZVVTZjeVdRZkJ2SW40Z3pZb2g0SndxS3Zw?=
 =?utf-8?B?M0ZHOElYV0M0OTMvU0w4L29SZ3ppVHBwQ0ZZVEhtY1pJTWdRYStEdCtBUG53?=
 =?utf-8?B?NXFGRDV4TU1HM0tjZktmc2F4bk13VUcwYUJOQUtPVFhTYlNhTU9XcEQ2aStk?=
 =?utf-8?B?dC9XdWM2MUUwaitlUGdrb2xLeFg0SUJEalVqSVJ0dWFQNFRaUUlCcFY5UlFv?=
 =?utf-8?B?YnlsdWd2b1J5S0VJLzZHbnM1aTR3ajJHWUxkWFgxYThlMmQraDFReEJMWnhV?=
 =?utf-8?B?Qjhnb044bnVjRnJkSjdmTldvWGprdlVsekh5TExoRzF5MnkrZDd2TTBKWjI3?=
 =?utf-8?B?ZlJxU0JzaHdhajV0TjNBZWRDK01YRWFWQVRNaWZCMVZGQjMrbVhtMlF1dVZB?=
 =?utf-8?B?MnJBUTJLS2JURE11WHVJQWorK1VrMEsyRWlYZ2IyYkVLVWFJRkxRVENkc3Bx?=
 =?utf-8?Q?P8WOiBJLoFaintxtXe3GN7MmG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a38127-99e4-4918-35ff-08ddfca4dd63
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 02:31:57.9582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXf8D0MWEUxaj2lZSR9SzF5L1vnPMvsRroo0UTrSuTi2nXE0GFChQ6Ff61ovE4/x6kNU+ez2koI7CDABZUxz7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9137


On 9/10/25 13:42, James Morse wrote:
> Once all the MSC have been probed, the system wide usable number of
> PARTID is known and the configuration arrays can be allocated.
>
> After this point, checking all the MSC have been probed is pointless,
> and the cpuhp callbacks should restore the configuration, instead of
> just resetting the MSC.
>
> Add a static key to enable this behaviour. This will also allow MPAM
> to be disabled in repsonse to an error, and the architecture code to
nit...s/repsonse/response/
> enable/disable the context switch of the MPAM system registers.
>
> Signed-off-by: James Morse <james.morse@arm.com>

Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>

Thanks.

-Fenghua


