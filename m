Return-Path: <linux-acpi+bounces-12925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39224A82F91
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAD758A273E
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283AF278178;
	Wed,  9 Apr 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gnN3R2ux"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300C415624B;
	Wed,  9 Apr 2025 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224815; cv=fail; b=eWbtEl5GLnkmi6KnWI4hZ6bdHmla+YQZf5XgiFRLZGFPkxObnx48INx854RgDV0w8/cPRy/6CgervRMWoT1jwRBOB5cjbnGp3aQDIg4r/Xg6kVnBnOn5+tOGZdBmf3zx252B/GrKGkBu8LlURlNEKEsRmiUoXJNd6zNcr7mgbLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224815; c=relaxed/simple;
	bh=yV6yLS8nv4E82rhFjHjBp7rb3J/Ddni8ErFOBO8McnY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cWH10Sk8km5LaPwSHDCjBDYEoKcTMjE6VSpdvyoQt3yBT088AvuKWnmbXmEOekpRRxu5L3sf5Cz7jrb8VR0hGds29ifq3J0/NBrtUTwH95ZvQqcwQSVVuNo+Acrz3ZUBzlFaysGTvdP+0l+hz0sHLhe1r9tfjM+dqOZiL2UG7cg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gnN3R2ux; arc=fail smtp.client-ip=40.107.92.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B7Uyq83OkNY/RBwtIdvirdWXemUFVzN0nIHQWZ1q3DOy5GvS4zIshmnCk5bBBq7H8rJLgNA0372YaEwR/5CaeCq4lxi3SvgeOhDRFiTFpA8L4IenRnamxXsol6inafxeDdv7nw2o+xQ+fJEE1BnfUB2NsI72bw2y3PVCBq8JONj2mi8zneyThcgYikNKLoig2l0NsgttWqk1pJR8M4QGAX3E3dBX6uYpKJo05X6fVX/c7N1VqPbdlSSMX+WXtMTE3aNEc4+GYEsP8irOp+FazfE8vj8/KORuZgPPVxwPNZ4ZLXqTYm18wEf+y1qxEQ4BToEmPG22NsQiwMHZz9J/CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Owhs+ScX/5yEGVBI6IEWuWt0ftxcuDYqa3S7MFVfQ5M=;
 b=Or8O5oUlauq4vyZDujt4Wh5cXwGydANE2NmnyvRRks9NwzJZx58Ml5Nh9wiMFkiZ9o/5BjovkvQisucN0tc579kI+2eecIIfYWthQJj1RGlgR2ZuImedfhZWGTAKufIr0HCJkTfBlqvXWEFMBlmAQLsdPjLJgc4MPEEcL6I+l7Go//i9jH/V3ids5RLttH+PfoQyxSz+qS0GdJxtujqPaPztD/tIu9kASOT06Ty3GKguFgdnSyoTO6Q9eLlseoJOhJV7u71U+fcgd05JzGdtmbjjgQfiAurvHPgL7WpRMIf6EuaNHKt8mhOk0CPO957uOARt+kVqzT3LDkut02BGgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Owhs+ScX/5yEGVBI6IEWuWt0ftxcuDYqa3S7MFVfQ5M=;
 b=gnN3R2uxW1HCyehG9pMfuVvJOm5AgG1V/flgdJs/EnS4yCJga0G1w+Wq8kcb0B5lP5erwIZZMNF4NfHbi92rqO5MgZ5Q0ffb+JdJIzygyo57wBFiE82ztNI1pgcmiVf7Yqdg3NRoMC/2qqizH7fFOk0OvjTgZ0EQWwaVEwEAhwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH1PPF0B4A257F6.namprd12.prod.outlook.com (2603:10b6:61f:fc00::605) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Wed, 9 Apr
 2025 18:53:30 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 18:53:29 +0000
Message-ID: <7a3bda35-05a0-49ad-b014-1834a176a906@amd.com>
Date: Wed, 9 Apr 2025 13:53:25 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] ACPI: CPPC: Add IS_OPTIONAL_CPC_REG macro to judge
 if a cpc_reg is optional
To: Lifeng Zheng <zhenglifeng1@huawei.com>, rafael@kernel.org,
 lenb@kernel.org, robert.moore@intel.com, viresh.kumar@linaro.org,
 gautham.shenoy@amd.com, ray.huang@amd.com, perry.yuan@amd.com,
 pierre.gondois@arm.com
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, lihuisong@huawei.com,
 cenxinghai@h-partners.com, hepeng68@huawei.com
References: <20250409065703.1461867-1-zhenglifeng1@huawei.com>
 <20250409065703.1461867-2-zhenglifeng1@huawei.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250409065703.1461867-2-zhenglifeng1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH1PPF0B4A257F6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1f86d7-228b-43dd-f55d-08dd7797d147
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG9admIxVzlKcWVQem5Ic05oVGprRzZ5cXk4OXM1RzBCbk1NWi9FSDRBb3ZZ?=
 =?utf-8?B?NmsydlUyY0FBaWN5SkVlVUZtdDExVHdwaHpuNzNWQ3JHL2VDWkVvSnpReWx5?=
 =?utf-8?B?WU40dWZZMlFMZS9UUXQ2Snk5dkpROGZhMitvQkdHd2ZRNU5ISHBpK1dTSFFW?=
 =?utf-8?B?dGlzV3V6dG9BR1lCeUlDSE5waDdFMDBNc01mL2t4RHplU0cvVHcwWUVMc1BN?=
 =?utf-8?B?MkFDVDltcTBwZkR3eEVNWnloUS9VdVA0N292dGpYSm1NMW1RWWxOVGlodUdv?=
 =?utf-8?B?ZDhJK3BsTGJrZDBnZWFBTHI1c2trYUthMXZTZlZIWWNTd3NnN2hOZ00yRWxU?=
 =?utf-8?B?YnVVR3htM1VkK1ZEM2FQSnFxaFZGT25UQWtIQTQyVjgybUZENDlaOW81d0o1?=
 =?utf-8?B?QkdMVElqS0JLWFNYdXhIQVJybHk1cy81WEVEQzFzVEpiczkvdU9zczhsQity?=
 =?utf-8?B?Qk1FQzQ2ZFRYZkJ2azJqQm0yUE9JRXhrODV4NFNEQjZXcHJPZElCOCt4MHMw?=
 =?utf-8?B?dkF0eGtESEJYMG05eVhCTUVzaDZDUUdlY2NRVXMyOVQ2UGdnOS9FY2RXclZG?=
 =?utf-8?B?eWJGR0g3M3A2THZ4OVR1cDMzRHFkbUhHY2hPY1RWUUtLajloclBLQjRHa1ZF?=
 =?utf-8?B?VGpmUCtIa0g4MEFHVUIzY0FXakh2ZU9JR3cxMURReENZRUtMTmpNY1p0R0Ft?=
 =?utf-8?B?a21sUWptcjllUG9WN3d5aW4zYmpHRTM1YnR3UW1jUjFIQlV2eTMxN1daWW5D?=
 =?utf-8?B?TWVJUjVWWVRQZDZpZjUvWWxmSWJJSC9FZGpEakI5Q1RaOEY4NFZ5ak1JaTVv?=
 =?utf-8?B?eVlMcnBGTTJidXc2R05tTWFJU05Rd053UnY1UGVSL2JleWxyR2JwckZrUVp2?=
 =?utf-8?B?T3VjNzB2bnNjWUJLeTFGZFM4Y2xtb21GcEc5QmxMU2ozanN2SVpOY2YrVTg1?=
 =?utf-8?B?N0JnVDdjaG9pNTlOMHk1K01RZlZKdmxjajRSUEh6T0w3M3RObTAvMDZ4RHA4?=
 =?utf-8?B?NjZnMEc2YlRLQWxHbGJBU0dadW9VQ05TUDZlcFN2cnRQNmVKSk5HQlVrNUdM?=
 =?utf-8?B?OTZNU0VoNWFRYkEzLzBlS2tzQ3R1eHVhSW50V2gwS05LVG52Z3JzYkRyMFpx?=
 =?utf-8?B?UGtOcUd0Uis4MHFWNlBEay9XdmRoV2pvWGxESFBwQXhGR2ozckJrVytaY0Zp?=
 =?utf-8?B?UU9kSnZ3OXVnWnlYdXROcnhqTmU4VWR1UElMUTgwb1VTTWt0K3BxeFZ5NzNa?=
 =?utf-8?B?cGtmVWE2RjhaVVl1WW5vNlhGb1dSQTB6dUV5VFlGbzJ5WHltczVoRFlNd2FE?=
 =?utf-8?B?aTdRSGE4VkNmYTBCS0dKVno3ZUVoT05SbnJGRjgxWUkrQ2ZjMURhWGxOYVB0?=
 =?utf-8?B?eFVTeElNazJtRGlSV2czcFBsUHdCMkhkOHM0ekJqT0hJL1FPVFZiMW1sU3VP?=
 =?utf-8?B?OVVkZks2TDBSR0czQWE5S08xR00wUWdiNG5FMXBjNHlzRkFBcU5vZWVvRkRV?=
 =?utf-8?B?Z3lrT0QrNk4zbmsraWx6NGk3VnFPdUtTaUFrbFhiNy9RcXZmZDRrV2dPRElx?=
 =?utf-8?B?RlhwbklvVHRoeis5TU5KOXo2OU9aS3RENjhOUU10V1kxQkVUQklUTTJxcDZY?=
 =?utf-8?B?VjhBMCtvQm13ZHorMGlxUi80RTFEL2RrQjlHMndYZkN6MVZLZHdOaUp0U01v?=
 =?utf-8?B?T2h6clFrS0RIMjkvTnNKd2hocStZVm5taDRXK0FlaFNheERQU1dDWVprMEhy?=
 =?utf-8?B?T3NiNmR6UzZuQ0lFbjExZUJkZS8wazhZTmFJdUNqRmV3Yy9mU2g2R2plUDJM?=
 =?utf-8?B?ZTAzeUVtQnYyOHh2NHpKSmMvNllKd2o2dnY5RjJVUUdPa0RncHFlOUFHRkQz?=
 =?utf-8?Q?YHfEVfBhyesrG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWlVaDRtUk9YQjFkYlRaOExJeGQzaG11ckd2cXhPdDd5UlRLWno4VGJ2aFpj?=
 =?utf-8?B?MVFCNVBtQ3AzSVVXcUlTcTZscmpEQzdyMkFZU0p0Y1c4NG5Vc2FpeithazUv?=
 =?utf-8?B?MHpUZk9Zbng2ZnI3Z014ZnRVVllRK1VGcmlyaHBVZFhDYWRFK3kwcHovbXov?=
 =?utf-8?B?UHgvNVpIbnBYVVVoeDNoN2lCZlpGWEdJZ0Y1T0xtSDBCSERLcDQ0cFNDSGNI?=
 =?utf-8?B?RGIweWlDL2wvYnhSaTZtMUhPQTRiT2swOGZNL2FjVXljM2QvVnNHcndkbzZP?=
 =?utf-8?B?M09FM2w4Zk1INUQ4Y2wrY1I2TWdiaUM5bWtNVTBLaTBJQ2NBVStPczZ3Z2NT?=
 =?utf-8?B?cG9TRmNBVEd6UjNTVi9aY3d4Y3NwQ2QveHkyZVRyUlduRFJWWHZWbkFxMDI1?=
 =?utf-8?B?Z01hRiswTDMzOHhFL2hyVHNLbWM5cncrbGNrcHF3bEdBUzRMbk9RUmZJWHFM?=
 =?utf-8?B?ZkRnNmRKazNaYzE4U2V5MGgzajY3czFEM0I4WTFHbHcxRURKellyTnhvSXlZ?=
 =?utf-8?B?NjJoalluL2lnd0sySVFmVlVrOGY1VjRJNmJoR1gvcEx4YXJ3bmwwYy9DTzh1?=
 =?utf-8?B?bXdQNGhuVVlYVUk2TlhWWWtZdkU4aFFuRXJYNlM1VFFhZ3V4Rng0TTFIaENP?=
 =?utf-8?B?cW1GWlVObUYwL1hISGMrZXhYUk5JZlQwT0N1MnJvYU9ocFBoUjNwMytIWHlY?=
 =?utf-8?B?Y1VUVERtZDFUVlBqeFUzZVh4bzJPbnFPc1dpQUlPWm5oU3BOMm0wTVdETzl1?=
 =?utf-8?B?NW81SklORC9VTkRxZFhEQ3E4RnlCdXR0dXZCa3p1azN3dk5QbjVocEw0bFFV?=
 =?utf-8?B?RFpsS0t3M3dTV0dDQ3FXQW1EZnNQa0lHSWVRbmE4L3V0dzV3M0pyZzdGdWRO?=
 =?utf-8?B?MzQxVWh6NlRTVUFUYW5YYmN5VFB6Sk5uWjJQaldiMFZoZFVoOSs0WWFqaGQ5?=
 =?utf-8?B?OFBXMWVzU3NNU3Y1bjZEQ1dKcHBtNnhTWHlSOWozRzFSTS9KKzZLTGxrVHJM?=
 =?utf-8?B?K2c1eVo0TWR1bUZuVnk5UW8yT0ZDOHJ5TnQzaGJoYjd3c2c5emVQRmVtZklV?=
 =?utf-8?B?aG14NWJTODlWcEZFeVBScnJKSGpJaWxWZmtyMDQxUzBzWGc3cW54QlBEWlBV?=
 =?utf-8?B?TEVCSVRLd3IySHpyM01MNXg3SFpGbHRhVWVFenhyV21xWTFXMDBiZGhrS1Y5?=
 =?utf-8?B?VWpnUmxoVy9EYU5CWFpCRk13bFQ4USs5WkE2azJEQUFURjBxRTYvREdVdmcr?=
 =?utf-8?B?Q2xVMzlvbmRhc0UyZ3JHOW82UTBnbGRlN3FHUHhoMVhIVzBBb0t3QTJpYnJv?=
 =?utf-8?B?ZmwrWHBRMWRiVWRjRzUxVXUrZUJlZFBBUlJsZFVhUDRvQVBNQzd5MVJ1UFdI?=
 =?utf-8?B?SmM2TVEveEdPdDFNTkwwN2NFV1NUdXZ4bE96bGtvQUFnbkJnTm9vRFVxVjhp?=
 =?utf-8?B?Y1RCL1kyc1ZFa0pySDc4N0xuT0J4K3djQ1VqNHloYUozdFZ1WW9DdnJxeWw5?=
 =?utf-8?B?bGtVY1g2d1FMTm44SmJZNmx2MzlFandvUGlFbnVjbnI5ZmJoV0pjMkNBZnJu?=
 =?utf-8?B?eTJsR0ptZ3kxQVBlNS9LaldMSlBJd1pURUtkRkk5anZyOGhWdTNDVUplUlFN?=
 =?utf-8?B?cGpVQTVUZXpQaUZFN3dzV1o1OU1hN0NYZytDMHFyRW5qeEtoQ1hwVnBuVlN3?=
 =?utf-8?B?K3Z4RXZQQUxqVW4rdUR6em5OZkZiN0FNNnNTYXJsOFBWQzJSajY4Tm1hcnM1?=
 =?utf-8?B?UjZ4d01md2ROZGgvejRmbGNEOS9mMEJiOXpHc0gxbk1UbFJzL0MvRGpqUlJi?=
 =?utf-8?B?UFdrNGJUR01DYUgwS0JtTURDbjR5MCtYZTJWQTRvdDNlK0tVRFhzaFJLOTI1?=
 =?utf-8?B?SUdYcmJsNkY4cGhpalZKSTNEZnpzckVGQTByYy9mMnpBWFZNTDZMbWFVT2o1?=
 =?utf-8?B?bmhGWnFtTi9NMlpybC8wMUFPS0RSeHVVSzVUd2pQaGRldHI5MVNkaDc1L0Fr?=
 =?utf-8?B?RWlOMkxaWElnbmZ3OWtXL0tOK0ZWbmltc1FmOVpUekxNNVJON1IvM0NOY3lu?=
 =?utf-8?B?SWliNllQUzAzN2VWWkYrc0ROK2J4QnRCVlliL3E1T0pwR1BiRzNpS1Nod0g2?=
 =?utf-8?Q?srud+WleHvAD3nazwVo0Y0TII?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1f86d7-228b-43dd-f55d-08dd7797d147
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 18:53:29.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVmD+ho7BduSRHtvsd8lBimpfgcWGGzNJNXMZSwgNoLAJJ7X8dLSe13BFd4Yqx92YTjJewbo/vdbb2FpZnaKnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0B4A257F6

On 4/9/2025 1:56 AM, Lifeng Zheng wrote:
> In ACPI 6.5, s8.4.6.1 _CPC (Continuous Performance Control), whether each
> of the per-cpu cpc_regs[] is mendatory or optional is defined. Since the
mandatory
> CPC_SUPPORTED() check is only for optional cpc field, another macro to
> check if the field is optional is needed.
> 
> Reviewed-by: Pierre Gondois <pierre.gondois@arm.com>
> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
> ---
>   drivers/acpi/cppc_acpi.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index f193e713825a..39f019e265da 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -129,6 +129,20 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>   #define CPC_SUPPORTED(cpc) ((cpc)->type == ACPI_TYPE_INTEGER ?		\
>   				!!(cpc)->cpc_entry.int_value :		\
>   				!IS_NULL_REG(&(cpc)->cpc_entry.reg))
> +
> +/*
> + * Each bit indicates the optionality of the register in per-cpu
> + * cpc_regs[] with the corresponding index. 0 means mandatory and 1
> + * means optional.
> + */
> +#define REG_OPTIONAL (0x1FC7D0)
> +
> +/*
> + * Use the index of the register in per-cpu cpc_regs[] to check if
> + * it's an optional one.
> + */
> +#define IS_OPTIONAL_CPC_REG(reg_idx) (REG_OPTIONAL & (1U << (reg_idx)))
> +
>   /*
>    * Arbitrary Retries in case the remote processor is slow to respond
>    * to PCC commands. Keeping it high enough to cover emulators where


