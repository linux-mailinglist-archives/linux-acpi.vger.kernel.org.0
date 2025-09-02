Return-Path: <linux-acpi+bounces-16288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 001EDB40B5B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 18:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A21E1B6092D
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Sep 2025 16:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD733CEB7;
	Tue,  2 Sep 2025 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z2uPDhGq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10D52E975F;
	Tue,  2 Sep 2025 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832357; cv=fail; b=Rw0i+V/9h0ifcAtDg7gMYo9WynIsDRpm6zKQrP2GIxjQchA7G6zCOon8b5O0DdJP24t7rGzUE9w+sUVI3KRTmfNl1D88wA4OF9rnGQXqzPn0mJt7eMwLvUtrJr3SmTTJTbXh0+4ATfywn4c9dRcnA7mVeRqjtXRg3bqGvBLNoFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832357; c=relaxed/simple;
	bh=t+OLSIKF1MF0VxaX46Vp5KG1AL3z1pWfQ7RE/zjlkIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T1hDtwHWIpKbslC1HgMocBaCPdqNRxrPIqUkdOjQ8LKTUy8440MCfZ8H3MgF0AKL6mLWxcwFCqaw0v+wuubkobx63vGoiUaxncAXTDOyW6iVuICBY/vEh8oDKf9hqWcNuFW2dnTqsY0gRh6Jno19qdmazj4kIeAR7NQ8bVZtMiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z2uPDhGq; arc=fail smtp.client-ip=40.107.92.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpoRBciZRdxtZA2ycNQnALVkbx0If+nn871WThUPUSXX26LscfG2Qpeh8ZXyRRebRrQq+G8XvVXUEE9BZ7UGddcrxxxN+aSdZ3gNlW7e7xxHAjtf99eoKI9NHzOPZ/w1f44y9u3V5opanMCAMEB2QOXoX55Qhi5FmI51ZhWI2NpPk4bKZ8fDPkKNtj4Hq07fK0HM1JpYPdt/v9F0u89wv+oj888se9lf/Qm1MMP3JBpqPDJHvG8WNojqKoWpVjdhgKesUkFCUaY0YWD5tOdUW8gwd2KLMx1PFW4Q+cIAdl9dEcs4A0GffqjHORgbS4dtCB/nlEIlTGES8blBhOvhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uG56eHVLxG42bhiFbgzwGjys0IWCGK6mmXIWGc+TJcg=;
 b=cqDzEVLseq8rrLlPzonf7l6GEKe5GMfme3PrX6Kbb1GfQDSICQ6dsflxslTErxfpBI/xvdtVDr4J/ChZ3IVrClDMbsY+bDLE6CwMaHNo4V9vIdJVSzSc3JUwAkeG3W4QGXlbdhCLq6mrwHyE0Kcc/zMD/zsBT+gv9lu87QnzdN/C6t2A2W5yoDoTICW5Cim3DybTZTMPAuICD4GXFfxJFVti+kgIeHc+3Ph9i6e9q2hfzZvROVFD4VUaJIIqU3wWZcixl3At74ZzzOtyUuBd3t3UTDO3p38N72caKrLTwNxkjgJQxbjs97+4DoE9Qmy+wtclY4tnJyv71z/y/BBU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uG56eHVLxG42bhiFbgzwGjys0IWCGK6mmXIWGc+TJcg=;
 b=Z2uPDhGqYXCo5NeH85Tx7d/uNvEuAB/YSr+a1cnlP1beyprOX9oSyJZny5ybCcLZmbzICS0HbFfb7j+ppGLVHAvDYUEei/b72Og3RzOkvG6a20y9SQlHBoszchicPpGAQIzks5oHJK38NPDNRpe553S6DOuVyBETNx89GDGugcGX/bNqvo4GK8kHrbMmUR05szvI9zToLuwcmzV559LQ+QflxcCwYDsrYe3RtaGBetx06rHIdHJiVfhQgbexmIISu+oyvspwoh+CguqvP1iFn+qkDiNmeC6Eaagrq+riwt+82JvP2t5jNRzTOrgD8zdbdGeLIj05rt2sCX5+5hOaRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 DS7PR12MB5837.namprd12.prod.outlook.com (2603:10b6:8:78::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Tue, 2 Sep 2025 16:59:05 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%3]) with mapi id 15.20.9094.016; Tue, 2 Sep 2025
 16:59:04 +0000
Message-ID: <d845ce62-9a6d-45ca-a6a4-4d88daeeac41@nvidia.com>
Date: Tue, 2 Sep 2025 09:59:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 33/33] arm_mpam: Add kunit tests for props_mismatch()
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-68-james.morse@arm.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20250822153048.2287-68-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|DS7PR12MB5837:EE_
X-MS-Office365-Filtering-Correlation-Id: 11fe9da1-8034-45e7-0007-08ddea4205fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUsrekNmT3NjOEVVQWpDdDZXNTZRTDFuUjBtcDRRZmZEdEpPaXFYS2d5S1M2?=
 =?utf-8?B?V1dQWnJucUdCWUlLaDQwM3FGdTBJc1FlbnFzQWQyM3pWd2FjR2ZyMUJwaXpk?=
 =?utf-8?B?Z2VWYUNFSmV1aDhMdWZZcWtjVjNEM1lRQkpGQUxFK3FuL2pZNG5GcUVwRHo5?=
 =?utf-8?B?cnFPdE9SRkpTbVIyNVh1b01ZSjBMTzQrNnZ5MnFMR3g3K05hRTJDOVhkdmcz?=
 =?utf-8?B?YW5jL2hyM1hqMVM2cFl3elRHVjlKVkc2ZG9CVklGMWdESWF0L1hpMW5RL3Jz?=
 =?utf-8?B?QjN2Tk5mZFFSVjFoQlU0SlFWMnk5ZHVGMEs1YjRyUjhGOUFmSkswcmJnWjBI?=
 =?utf-8?B?WkdybXVqYzJzTFpVNlZJdHJ1alJGbkY4aXN0VWl3U2FLb2o4WHZmeDlyNXF3?=
 =?utf-8?B?d1FHVms2RG5sc3d2MExEeTZReG9wS3Y0Z1d4QWlmVlQrdE0rNlJjbkYyai9O?=
 =?utf-8?B?MlRQUFk1TVFhVXA5Z3FVYVZKUWk0dmxTcTd2bkd4LytDZWV0ZFI0MG4xRndF?=
 =?utf-8?B?OC9Cbm1aZzJBSVhNSDZrVkRHOUY5VklrTXpwcVZ5NjlzQi9odHVxVmZ0bEUr?=
 =?utf-8?B?R3dhdjFHUnNaL2VJczRxSDFuNTRtSkprd2JxMk9vVUQ3aWVLQU1oa0xFZ2Nn?=
 =?utf-8?B?SGxYSHA5M1pqUGRMeE9Wd3d0UDhCZ3h0UU12QXMxT1QremRZUExKcks5N3p1?=
 =?utf-8?B?R0EvL3VpN0lXYmhQcDZiOXZnUUlYZHIrNXZXUHN3eG9PSzVGcGtHKzZjMk41?=
 =?utf-8?B?TUtEdHJxUnYxS2VoY0UwTHNJak1WWGU5ZTYvQWszcWc3dEV5QlhxdDI3NytU?=
 =?utf-8?B?SzNWNk1zano3Z3BQc05aQjA2TmYwa3drVUIyWDV3TndBblM4NEZFaUxTRStR?=
 =?utf-8?B?dkxSUVBxOGw1OXJaK0VsU3dyUmg2OXFvTHhRc2VFMXdvWFl1UEIwUmR2SnBu?=
 =?utf-8?B?NE5hVXFtTHlrMElPWndnY2dWVkJjQzk5WHlPSkZRN2diZkVTZlY4cmpTSWdr?=
 =?utf-8?B?NHljRzIyV0llbi9uRGZjUmZCT1h6S25lUWlyY29VeElkekt3bDVMRFJyK2VG?=
 =?utf-8?B?UkRKaUZ2Ky85eENQbjV1d2ZncFJ3ZUczZHBweUVFdno5ZnE1QnBWT3JVWVYx?=
 =?utf-8?B?RFVDL2pDS3I5dWxXblY5T2tvclJkbDBNR0ttVjVxVnJuaGRjYWFIUTVyUjZj?=
 =?utf-8?B?UEM3dStxWGl3VDUwUkFSVDhqUWsrVHE0QmNDQWswWVhobnk4dGhmUzRDWlk5?=
 =?utf-8?B?ZXFJaWp6a3Vxd3BvcmppNldTSUdzdy81VXNDRklxVUFFQW56dTFQakVrTG5O?=
 =?utf-8?B?amFlVnpQNjNJY2ZhQW8raXBJK1lnWDh1dk5DUklJWVJJQkZRamFsTU9JRVdB?=
 =?utf-8?B?MXV3Q0l6aXY1M2xzUUQra1JNUUJzM3AzTjMrRUFhd3M4dzZNYXNuWVpXSTJI?=
 =?utf-8?B?RnVIdDAxVHdhdTI0N3N5cm9QV0VxT2haRnVQYTd1bjhXSUpZQlJtdXI1SG1H?=
 =?utf-8?B?OFJPVlhOUFVOMkRqUGN3QmlSU1g0V2d6U1JWS3VzNUpRc09HNEo3S3FieHF0?=
 =?utf-8?B?L2JYMWZoaGh4NFdHbnRRMjFDYjBiYUdIU2ZZUmNneDR2SEd5NklHNEd0dU5O?=
 =?utf-8?B?KzRvWldnRWd0U25DZVdjbWdtN21DQjFOUUI1NlQrOWtBMVVtRmZrQ2oxY3ZD?=
 =?utf-8?B?NVBkd2JybUJPQjcwMWpmSTRpRmx1SVRmYlRyeEYrZlVKcWc4WnlFc2xNOWdE?=
 =?utf-8?B?QlVXeXhHL3R4R05vRTc0Y2oyYWlaOTczS2JqdHZCT1oxanJrOGpCR3FzaWpw?=
 =?utf-8?B?OW9CSWhCNWU1dStmRWNzZUZpU21pNGdsYlFncWV5cHdHaEpSQ2ZlZFV0bE9T?=
 =?utf-8?B?RXk0N2Q2S0RoeStVb3pmaUNacWc1NFJkbnNpcU5hSEJkWjlzMFRBVk5UUWF0?=
 =?utf-8?Q?qVr54a/tLWc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MS8xR09icUdFSUFqL1JXWjBrWVlHcEw4cVVheWhEbG9nS1kyYllrSnRXYWZa?=
 =?utf-8?B?TjF3ODh5SENrcno5ejlZVDQxQk5qdnA5cjZwMmdlSjlOMnhYREZXTXBBUDR5?=
 =?utf-8?B?dDVJM1ZzZW14Rm00L25GMWpkbTlCMTAydFgzS3dCc2cwbmloS281UytsZFgz?=
 =?utf-8?B?VHJNeENpdFhENzFGa3Q0cVcwdnJtZnJkYy82bEY5WEhGQU5Bd2NrcC9DdnRk?=
 =?utf-8?B?K2pGMW1RYndsNkFPa3JrSWtIejN1WmorQlJFZ0t2T3hOOFV2bENqd1JUV09I?=
 =?utf-8?B?N1g4MkFrblBaZU1zQnZhQ2NTRWhiNHN4bzhiNTlrNHVHckdQTjNBRG9TWjNn?=
 =?utf-8?B?Z3ZtbjNjT3J4VWNoNVNVMkhpM3JiVytLL1FwUS96MVhoQW5SaExDL3ArdFdN?=
 =?utf-8?B?OXZWSUFidHM3SklFNzRLRUJIV2VOTzNCdHIvcm1KdGpDT1hUNHBKTW9rQVFp?=
 =?utf-8?B?dER5cUgvbzN2dnJuSktlSW16Z0EydTUzZXIxeEpwTWhQK09KYjhGa1lWU2Jq?=
 =?utf-8?B?RjZWWTFRbG5DMUc1cTFWSUs2empUdXhobi92UWQvN0YwbVdXYnNxenlLUFZZ?=
 =?utf-8?B?emVGT0NiSFBmZm5JWTcvTk13cXVWQjlUMmx3TWVTUFZrUVpuaFJiSk9MZlFM?=
 =?utf-8?B?Nm5aTTNDaEQ3UUowWVJ4VWF6WXlKWjc3RDVBb3dXSldsTFFVQ25ERnM0Rk1P?=
 =?utf-8?B?SXRFSEFFbjBOY1NOVnZNYVFLR1VhbVBPc0QwbGM4Rit3Unl2R0R4ZDVrV1A4?=
 =?utf-8?B?QzU1R1dNQklVS05wY2JKR3gzQ2RaN1RzZXRXRFF6NXFuVzhmUzZvRFlldWNJ?=
 =?utf-8?B?eDR5RGcvNW16dFYxM3VQMDZRVEt3R1JUVHp1bFpOY2FPVUozZk1vc2hTN2NZ?=
 =?utf-8?B?NnpNcTEyazhWWVdZZzQwa2hyYkZGUnVDZDBaaURqUEsvMW1rSHdvdkx4R296?=
 =?utf-8?B?THZMZDhNMUpGeE1WcU90T28vN2JGTEtYRnBWdmV6b1J2bTdvZUZSelFtUzhr?=
 =?utf-8?B?K3dCQVRCZFBkLzAwc0lSSHFMZ0d1ZHdBWTBrWlArK3o5dkg4NW1tV1J2LzZT?=
 =?utf-8?B?TnZtTzMvd281Nm1SZ0d6WFl0aW1veldNUit3WWFJOHJLUWwyTFh3bDVCNW5U?=
 =?utf-8?B?OWtkSVRDSlgzK0tiRVpqSDZVNWxpeUE3T3pQeE1SYmNnS1huMEpwK3o1Sm5D?=
 =?utf-8?B?Q2h4bDRNb2JqRlRhblgweEVPNzJqcWFjVnAyWW51ajBnWUxUWlczeU8wWUd1?=
 =?utf-8?B?cE92RVJSUkpKNDl3Q094VHpYRDdrb2pXeCttbE00YWlHOGZGWGYzOXdnajZo?=
 =?utf-8?B?RzEwaHdrNTlPSTBuZjVlUzFsMDQycXR6bVMvZER5VHVGbHorMG1hM1JUbEd3?=
 =?utf-8?B?cHNmL0xlNmE0RXVlVWJKckJOUWgwWVNOL3BLaHRCMGVsai92ZmVieVZMNEdX?=
 =?utf-8?B?cUlEb1hzbEhNZVY1Y3dGTy93SnJnS3pPSU1FL09sNzQwdkJvVy8wTTlYcjNj?=
 =?utf-8?B?QUVVVXk1T2l3Wkx0Uy9wd2pmbzd2UWZvOS9aT2F2QzErTVBpR05jNXRzTG1H?=
 =?utf-8?B?SGJUSXZEdllGTGdqMkpuR2VGdGNHVGtVN2ZOQStjdEJLdjJOMG9Wa2dFNTIx?=
 =?utf-8?B?R0E4L1VGSUFOTkpWY01uVTI2RHZNblRPV01TMlpUdjZqWnUvMHdiZmtFMDB0?=
 =?utf-8?B?ekxhalR4bmt3KzJGOTlJWkRSeFFsOEp3WE5zZGxoRGdPcjU3ZUwrbWhEcGp2?=
 =?utf-8?B?ZjZlYkR4dEFDNWVRSFNkdWJ2a29UL0J1dUNKUy9xY0NIaUIyWHlFVVhnUHZR?=
 =?utf-8?B?UmRHaTBjK01YL0pxcXVsQ1YrbXNoVENXbEplcDFCS0Z6bmRyL1E4Mk83Zyt1?=
 =?utf-8?B?czRiMHhNUnVGT25PV0NMM3RncHk3UytHV2YxRjJUOU5QRlNuQlZ6M3IrdGNE?=
 =?utf-8?B?WENybkhzd0dNQTI1MmVSN3hMREMyQ1NCQkhyWlNSdk41cUlyZzFUczJPUk5k?=
 =?utf-8?B?ZHJHckZsT2xLbHl1NmIxMDBNQnpyNXdobjFEUTZqTkVrTmY5UzlwOFF6alQ2?=
 =?utf-8?B?Y045elNUVVoza1JKU05MSVNxbGRLRnYrL2kwLzgyMjQrKzN0TmEvbERUbnNv?=
 =?utf-8?Q?fXkdX0r3OTeh1uhNQRG5bx/wk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11fe9da1-8034-45e7-0007-08ddea4205fd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 16:59:04.8634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYAzgb7SnmXglHkrmgMjGOd5TKxHL2d1iOQmOvYWBdXycPJJ2zOWfE4k26Kz5OcM1bQGZU8x1AC0xk+YVRLv8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5837

Hi, James,

On 8/22/25 08:30, James Morse wrote:
> When features are mismatched between MSC the way features are combined
> to the class determines whether resctrl can support this SoC.
>
> Add some tests to illustrate the sort of thing that is expected to
> work, and those that must be removed.
>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/resctrl/mpam_internal.h     |   8 +-
>   drivers/resctrl/test_mpam_devices.c | 322 ++++++++++++++++++++++++++++
>   2 files changed, 329 insertions(+), 1 deletion(-)
[SNIP]
> diff --git a/drivers/resctrl/test_mpam_devices.c b/drivers/resctrl/test_mpam_devices.c
> index 8e9d6c88171c..ef39696e7ff8 100644
> --- a/drivers/resctrl/test_mpam_devices.c
> +++ b/drivers/resctrl/test_mpam_devices.c
> @@ -4,6 +4,326 @@
>   
>   #include <kunit/test.h>
>   
> +/*
> + * This test catches fields that aren't being sanitised - but can't tell you
> + * which one...
> + */
> +static void test__props_mismatch(struct kunit *test)
> +{
> +	struct mpam_props parent = { 0 };
> +	struct mpam_props child;
> +
> +	memset(&child, 0xff, sizeof(child));
> +	__props_mismatch(&parent, &child, false);
> +
> +	memset(&child, 0, sizeof(child));
> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
> +
> +	memset(&child, 0xff, sizeof(child));
> +	__props_mismatch(&parent, &child, true);
> +
> +	KUNIT_EXPECT_EQ(test, memcmp(&parent, &child, sizeof(child)), 0);
> +}
> +
> +static void test_mpam_enable_merge_features(struct kunit *test)
> +{
> +	/* o/` How deep is your stack? o/` */
> +	struct list_head fake_classes_list;
> +	struct mpam_class fake_class = { 0 };
> +	struct mpam_component fake_comp1 = { 0 };
> +	struct mpam_component fake_comp2 = { 0 };
> +	struct mpam_vmsc fake_vmsc1 = { 0 };
> +	struct mpam_vmsc fake_vmsc2 = { 0 };
> +	struct mpam_msc fake_msc1 = { 0 };
> +	struct mpam_msc fake_msc2 = { 0 };
> +	struct mpam_msc_ris fake_ris1 = { 0 };
> +	struct mpam_msc_ris fake_ris2 = { 0 };
> +	struct platform_device fake_pdev = { 0 };
> +
> +#define RESET_FAKE_HIEARCHY()	do {				\
> +	INIT_LIST_HEAD(&fake_classes_list);			\
> +								\
> +	memset(&fake_class, 0, sizeof(fake_class));		\
> +	fake_class.level = 3;					\
> +	fake_class.type = MPAM_CLASS_CACHE;			\
> +	INIT_LIST_HEAD_RCU(&fake_class.components);		\
> +	INIT_LIST_HEAD(&fake_class.classes_list);		\
> +								\
> +	memset(&fake_comp1, 0, sizeof(fake_comp1));		\
> +	memset(&fake_comp2, 0, sizeof(fake_comp2));		\
> +	fake_comp1.comp_id = 1;					\
> +	fake_comp2.comp_id = 2;					\
> +	INIT_LIST_HEAD(&fake_comp1.vmsc);			\
> +	INIT_LIST_HEAD(&fake_comp1.class_list);			\
> +	INIT_LIST_HEAD(&fake_comp2.vmsc);			\
> +	INIT_LIST_HEAD(&fake_comp2.class_list);			\
> +								\
> +	memset(&fake_vmsc1, 0, sizeof(fake_vmsc1));		\
> +	memset(&fake_vmsc2, 0, sizeof(fake_vmsc2));		\
> +	INIT_LIST_HEAD(&fake_vmsc1.ris);			\
> +	INIT_LIST_HEAD(&fake_vmsc1.comp_list);			\
> +	fake_vmsc1.msc = &fake_msc1;				\
> +	INIT_LIST_HEAD(&fake_vmsc2.ris);			\
> +	INIT_LIST_HEAD(&fake_vmsc2.comp_list);			\
> +	fake_vmsc2.msc = &fake_msc2;				\
> +								\
> +	memset(&fake_ris1, 0, sizeof(fake_ris1));		\
> +	memset(&fake_ris2, 0, sizeof(fake_ris2));		\
> +	fake_ris1.ris_idx = 1;					\
> +	INIT_LIST_HEAD(&fake_ris1.msc_list);			\
> +	fake_ris2.ris_idx = 2;					\
> +	INIT_LIST_HEAD(&fake_ris2.msc_list);			\
> +								\
> +	fake_msc1.pdev = &fake_pdev;				\
> +	fake_msc2.pdev = &fake_pdev;				\
> +								\
> +	list_add(&fake_class.classes_list, &fake_classes_list);	\
> +} while (0)
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	mutex_lock(&mpam_list_lock);
> +
> +	/* One Class+Comp, two RIS in one vMSC with common features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = NULL;
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc1.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cpbm_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class+Comp, two RIS in one vMSC with non-overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = NULL;
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc1.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cmax_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	/* Multiple RIS within one MSC controlling the same resource can be mismatched */
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_vmsc1.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
> +	KUNIT_EXPECT_EQ(test, fake_vmsc1.props.cmax_wd, 4);
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 4);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class+Comp, two MSC with overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp1;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cpbm_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class+Comp, two MSC with non-overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp1;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cmax_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	/*
> +	 * Multiple RIS in different MSC can't the same resource, mismatched
> +	 * features can not be supported.
> +	 */
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 0);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class+Comp, two MSC with incompatible overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp1;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
> +	mpam_set_feature(mpam_feat_mbw_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_mbw_part, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 5;
> +	fake_ris2.props.cpbm_wd = 3;
> +	fake_ris1.props.mbw_pbm_bits = 5;
> +	fake_ris2.props.mbw_pbm_bits = 3;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	/*
> +	 * Multiple RIS in different MSC can't the same resource, mismatched
> +	 * features can not be supported.
> +	 */
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_mbw_part, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
> +	KUNIT_EXPECT_EQ(test, fake_class.props.mbw_pbm_bits, 0);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class+Comp, two MSC with overlapping features that need tweaking */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = NULL;
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp1;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp1.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_mbw_min, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_mbw_min, &fake_ris2.props);
> +	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cmax_cmax, &fake_ris2.props);
> +	fake_ris1.props.bwa_wd = 5;
> +	fake_ris2.props.bwa_wd = 3;
> +	fake_ris1.props.cmax_wd = 5;
> +	fake_ris2.props.cmax_wd = 3;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	/*
> +	 * Multiple RIS in different MSC can't the same resource, mismatched
> +	 * features can not be supported.
> +	 */
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_mbw_min, &fake_class.props));
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cmax_cmax, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.bwa_wd, 3);
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 3);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class Two Comp with overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = &fake_class;
> +	list_add(&fake_comp2.class_list, &fake_class.components);
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp2;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp2.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cpbm_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	KUNIT_EXPECT_TRUE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 4);
> +
> +	RESET_FAKE_HIEARCHY();
> +
> +	/* One Class Two Comp with non-overlapping features */
> +	fake_comp1.class = &fake_class;
> +	list_add(&fake_comp1.class_list, &fake_class.components);
> +	fake_comp2.class = &fake_class;
> +	list_add(&fake_comp2.class_list, &fake_class.components);
> +	fake_vmsc1.comp = &fake_comp1;
> +	list_add(&fake_vmsc1.comp_list, &fake_comp1.vmsc);
> +	fake_vmsc2.comp = &fake_comp2;
> +	list_add(&fake_vmsc2.comp_list, &fake_comp2.vmsc);
> +	fake_ris1.vmsc = &fake_vmsc1;
> +	list_add(&fake_ris1.vmsc_list, &fake_vmsc1.ris);
> +	fake_ris2.vmsc = &fake_vmsc2;
> +	list_add(&fake_ris2.vmsc_list, &fake_vmsc2.ris);
> +
> +	mpam_set_feature(mpam_feat_cpor_part, &fake_ris1.props);
> +	mpam_set_feature(mpam_feat_cmax_cmin, &fake_ris2.props);
> +	fake_ris1.props.cpbm_wd = 4;
> +	fake_ris2.props.cmax_wd = 4;
> +
> +	mpam_enable_merge_features(&fake_classes_list);
> +
> +	/*
> +	 * Multiple components can't control the same resource, mismatched features can
> +	 * not be supported.
> +	 */
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cpor_part, &fake_class.props));
> +	KUNIT_EXPECT_FALSE(test, mpam_has_feature(mpam_feat_cmax_cmin, &fake_class.props));
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cpbm_wd, 0);
> +	KUNIT_EXPECT_EQ(test, fake_class.props.cmax_wd, 0);
> +
> +	mutex_unlock(&mpam_list_lock);
> +
> +#undef RESET_FAKE_HIEARCHY
> +}
> +
In file included from drivers/resctrl/mpam_devices.c:2908:
drivers/resctrl/test_mpam_devices.c: In function 
‘test_mpam_enable_merge_features’:
drivers/resctrl/test_mpam_devices.c:325:1: error: the frame size of 5520 
bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
   325 | }
       | ^

It's better to split the big function into a few sub-tests. Each 
sub-test defines and uses less variables to avoid big frame size issue.

[SNIP]

Thanks.

-Fenghua


