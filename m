Return-Path: <linux-acpi+bounces-19994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB6CFD8F2
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 13:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBB530EBFE9
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7A238C3B;
	Wed,  7 Jan 2026 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ugt8aboV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95432F99AD;
	Wed,  7 Jan 2026 12:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767787442; cv=fail; b=nt8g+PHgTTKYkH9d/qegDBkSgstP5T+uhxOLgKoDoQHItDpHYnEIrncZCv0JT9D3vBKI6IxMRggwoHyToYeCgk9xpeOzq7Cw6+A5tyMh7SmFhqs8xeS9vqroKqf3Qk2UDNx2fkoUkP7Ji1THqxIWyfDF+XVh/FTMZRoLUcGFW1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767787442; c=relaxed/simple;
	bh=IYAjQTEZF7wij8KBCHPeseARH3mTW+9iYYe3o9kLRPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MZd2MGCP4qn863KdaTRDJVjnARU77F9Xaq+ba870YOfPeUJ+N1U59RAkqsMYx0X2dIv0IyvrU01hxb71ROvkfoJ/mJQ/WNKc7Xgy+vCwpatjd8LWttqj1lXxUh8DPT4ODPRuZZhn/ieYIevJ/LI3h2uN554b8b5GMesZKfrFbQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ugt8aboV; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTjzRZ0UJzZL4snzX4zvL7itIXum+AhiCwlg8hDaGcCxESTF2r8XLszLMxW3o+XbKoEdTTbUT8vebMXr62qrISztYiLlIJ8yNi80RtR/V8fEhCMHYxBEdvJc4qw90vYcZGtM/71bgUxZJdn2oBF6xccy2JzOhL2HnvdBxlJstK550ebAsQXZD7iIAgYEa8bbPuGly3qATFleglhw5kSPfPFu0rS2nK8a+5uuYtkIMSffunTqIiZoJFkuIrFpWvjZhTikdG4Jh0IgvpuTFaYxpLUHfz4m6zQBldlq47gL1wYnNecMi6XDtlsHHgintRQVWEvUeMWdxGIAol5tR0awRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLEouOoiAqEwFkWt8LqVUs/HzCCbw6HsrGZyaCxzk5I=;
 b=fmY+A7bjUi8shwP1qYvN0kHZtcVUhY2ZfTTE8CJx28R4HQQ94vVDXYN9S0h9NIevZNnXWh9yUVqGNq0aJfcMng7ALTDESzTLFw/93nu1y/Z1DzS3/gykKFAnu57BI3PDtnWPzVByGw6ZXZrsvffzlVyUyY6kL0xzIIbyXy9l+vVUqtG0KBrD22Z9iw0OzhYk6LPZrk41CaVdtufVSibgqUDuu9PNu6QqfuxRNa/242uxMsvV0UJRj3m20axeC0LtD5fEwzKs+ckccmAkiwhoqzB0T7m2+1tOtXJhSBMJimyM1X9+xD3mFkU8bB1iq/OQiWcWy/Ku488mTJs8zI6QQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLEouOoiAqEwFkWt8LqVUs/HzCCbw6HsrGZyaCxzk5I=;
 b=Ugt8aboVmy9pf6PVwxSaaOIpi+83jhDwOl5q4BW5tqupq4n3anmmwg8yAyn1PeuRWdU14QvxoYWjaBE2HmdiwJZMPwYYuuAhO8hMD+/ke2pHAx+Yq285kbxdCClpf/E0/7OiKKRNfqBork4TrT1fAtfRjx5I1rJYp5hGIW7V8JIac3dLCQWNT64HnZL/o97B3atEV+PT49Tjaf+gFHo56JDMqCPTT+Pp5IN5o/0bEdPV0wkmvHUIAt+7wneJWz29awYfvCkMGur3l/G8f4hCfH1T7mXqjiPzOiWoPNPlbGWqCYSnsl6JD45SyBsoX55m93r/LahauNLzqHVrh60AAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN0PR12MB5716.namprd12.prod.outlook.com (2603:10b6:208:373::14)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 12:03:55 +0000
Received: from MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76]) by MN0PR12MB5716.namprd12.prod.outlook.com
 ([fe80::bac8:2b43:2a64:4c76%6]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 12:03:54 +0000
Message-ID: <f659b13d-cc51-42be-a441-d1fcf3909837@nvidia.com>
Date: Wed, 7 Jan 2026 17:33:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: lenb@kernel.org, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
 jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260107062453.10893-1-kkartik@nvidia.com>
 <aV5GwEzOLtgIEnYp@kekkonen.localdomain>
Content-Language: en-US
From: Kartik Rajput <kkartik@nvidia.com>
In-Reply-To: <aV5GwEzOLtgIEnYp@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:174::16) To MN0PR12MB5716.namprd12.prod.outlook.com
 (2603:10b6:208:373::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5716:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: 15e6a7aa-2087-40e7-0984-08de4de4d43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NlVIelVDSkhoamc2elByRmYvRnZvaEtGc0tpTTQvdUdZellVSElsYWlWMmRj?=
 =?utf-8?B?TnBVRTFpcld0M1JMRDFpSVJ5MTIxRlp4ajI1TkM3L1poOVlpTngwd0xjRkN3?=
 =?utf-8?B?cnl3RndOc21JVEdNS3BhVTd3U3llRmc2YWdvZjcxUzEyVWk1bEJTYVNoWUVi?=
 =?utf-8?B?Z3o5d0NERjlwM3haQkFMamthZWIxbFdiK2lwTTNUcjdCV3F2dDk1eWJ1ZTNE?=
 =?utf-8?B?OUdlVXdlOFpPTFViM2hPSXJienY5VkFub0RkV2d5VE5ha1I4WE8rcWQ5SXZx?=
 =?utf-8?B?em05eFU2UHZ5Y3Vwa1p3OGZZYnpjL3d2c2pONmFLamcvRDMyTzljTnJYTmVW?=
 =?utf-8?B?TVR4WGhadms4eDNpRjZGRDl3K1ZNVDBLY1RLK21BS3hHRDJVc0xWNlBrcGQr?=
 =?utf-8?B?b1dOVVBKamQrQVlFTG56cTlHM1dIRUgxbWt6TllmNXY4RktQSnVCWFdqNmUr?=
 =?utf-8?B?cmt0Umx1S3hNUXlKMTBiUTNRODNwbUMrYTBTMkh1dlZxNFVDb1VaQkhQNlR1?=
 =?utf-8?B?NkhIMWJKcHZhTzlVUlpJdGkyeVZYOGRxZzdBcUMxZFlKaUl6RjZ3U1FqYUgx?=
 =?utf-8?B?MFdMV1kva25SWnZnRnlTUEZ3SkZVcWliZUhaelpCNlVjd1JUZnJ3K1BROTM3?=
 =?utf-8?B?S0lKb0s4SHV6Z1NjdHNOblI0ck9GbWZQOUYxdUxQVUxnUjJLQjNhSUt4THJ1?=
 =?utf-8?B?d3NaeTh5OSttQ3BNY0MyMmIzMVNJaTFwLzlSOUZMakVUaVllM2lSM2daTTF4?=
 =?utf-8?B?dlpTWUIvcGdtS01IM0ZNcU4wbmFzckN0WG9GSmNXMmxwV0E4cVRHRnh4Yy9Y?=
 =?utf-8?B?N05pWXdXZzNTeXM5QjloOHJoQ2d0T3JLck0xdUVqVk9IVmlUOVBXOUxjQVhY?=
 =?utf-8?B?MVNGNGhrbDY2cTJMNXpheXBXQXBYeGlCL002ZktoWXJvK29OeFdnbWNIUUZl?=
 =?utf-8?B?enI1R3dTRHh0U1FCd01MOXh5Rmsvbmg2ZDlwZnF5SWpZMkpubDhOczdPZWkv?=
 =?utf-8?B?aTdtbVYzUTFkcTM3c3dsYmhaZFE5N09pRzg5N0VGaXExN2tnYmtSZ3RzRE44?=
 =?utf-8?B?cXNkRDNvNDlrVUdUVU1MTXFtTm82RU9DSWhpMytxbjRhZkg3TmpISnF6dzBr?=
 =?utf-8?B?ZXNKMTRJUTgzaHBGT1IyckFyWEJvcHlUL0dHRENFc3E5YUVYWk56alVuL0NC?=
 =?utf-8?B?RUYyUHpOKzh5TDdaWm5MWlpEeFFreDltb056OHo0ckJ6R21GWnFvNDhEL2dj?=
 =?utf-8?B?aHVkd01DZHYxSlJFcHoyckZzaDFvcnFvS1hTMVlGUTVKTlAyV1B1UHFYN2tE?=
 =?utf-8?B?NnRkTm5VUm1yNlB6R3lTK1o0OEZrT3ZHZ3JTdGJscFNPd1NKR0EyTHgyWTJv?=
 =?utf-8?B?THJRbkZXZkZkS1pTdkM2ZTRFQVhjMng3OGhhMktNcmt2VitlcVFsVEExcDZD?=
 =?utf-8?B?SjhpNEF4RVNLSTlZVzhQTzFydXhwZnI2cytHQmtKK3ZmSDh5cXRuQTdETHJU?=
 =?utf-8?B?V1JrOWdha2Z6SVZmWnB4czBHSlYrYXRpa3RaRVpCTzE0YXJha1FuLzFUdFoz?=
 =?utf-8?B?MVNMUEZOWjR0dFpqMkdLTGpzMWdTaDFuRHp5Z1lER1NUMkc4NC9vOFZPdnAv?=
 =?utf-8?B?S0wrbDVweHU3RUtDd0lzQyt5d3ptdVhxSUd3K2cxNmJzMTE2RmFkdU9OQlNI?=
 =?utf-8?B?VUZDYksxNlBNdTIxRmNBLzdBOGNDUEVabUZMRVhTNXZwREgrMjRDMUxHUTJh?=
 =?utf-8?B?RmFjU1FxemN5VUh1L0M1MHpPOFNFMkhtTEdkcTMvRHNJN0VqR29iZnV6NVcy?=
 =?utf-8?B?cUNleHBucDJlSlRKL1RCckwwNVVLZko0YitkOHN4VWlPdEtRZUZMaTRQemVN?=
 =?utf-8?B?TG9Ic1RTWW1CeGxmTU8va0haL2hMSS9rZkVzcGlxb1ZjY0lqMjROZlZBcUdW?=
 =?utf-8?Q?m52qLjOPrYRJhWAp1yXEQImHo3K6aC3m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5716.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M0NvSklHUzB2d3pyNVlwRlRJUUpoRFJYbjZQdUFUZHgzWE1LZCtxelUvTzlY?=
 =?utf-8?B?c0wyYVlvMUt0VDgxTHBaTkV1Ri9leVVjdkxjWSt6Z3dwa1VQUlNpU0R0K3du?=
 =?utf-8?B?d1JnUm5ydTdyMk8vaEFBUWlPMHYyQ2tYQ2ZFTThNUXFWWVQxViswQ2diOGpI?=
 =?utf-8?B?a09HN210Snl3aHNNYnRCb0YxL0Y0Q3Jkc0s0aHBkUWc3MHpiZVRLSEVBK0FO?=
 =?utf-8?B?UWYwdzNySTl2eTlBaVJLTys1ZDRNUVREQU4xUG9DWGxPTGdJRHZSb1Z6NUFL?=
 =?utf-8?B?blg3NmlsMVZqbjhuQkpzTHhKcU0zeUdmZ2dLMVBDOU9LTUxuNTA4b2xCcWtR?=
 =?utf-8?B?OFdEenBuMjhpczRaeFAzK1p0TWg1OFRLOVg3RFRhdE9STDN3TDRTMVhmUC9y?=
 =?utf-8?B?Mk05UkwxR1grc0hIQktXdGdSUFFJRGdBODBITFFyRjhiQ0VUMVJHTHJ4dFdI?=
 =?utf-8?B?L1lvNnVjOXRIVG5TeXFDVExXL0NyRGNwSEhxT1BSZUZOOG1lbElQcU0wUEtP?=
 =?utf-8?B?RTVNWm9sT0N2a2xmRitKMW91MFdjWStBWXAzNmYwQ1kwclBkd1cwYXpmUlpE?=
 =?utf-8?B?QkMyeG1URUsyT2FYUXEvSEpSQjRUemk3OG9RaTkyRWl1TldxYW9JL0tpNmNV?=
 =?utf-8?B?YUlTd1ZKRFY0aVdZTzFxamJwYWxsQVo3NEVObll3L0xndDFrQ3R4Z1c1TDJm?=
 =?utf-8?B?bDBoOG15QlBNUTNKMzRmQXFCamg3cXZnR3hUQWM0VWhCcXlvLzc1MDhuTE80?=
 =?utf-8?B?cjFxUnpYUVhLWG5GZ0VLUlo5WGNVQ2p6cE1OTUZ3VlpHYXk0Vmo5bFhGSnhJ?=
 =?utf-8?B?VDFhOGlaTS9Ha2xSNUxZSG9vVzV3UlBoVVJ1NjBzaEx5bXFNdUhBdjROTFpm?=
 =?utf-8?B?VUo2ZGMrRFpLUU1LWm9GTGJiaW5HcjFqVEFjaTdUVGYyNjJGS01Qd0lMVGZN?=
 =?utf-8?B?OXZXdENtTXB2LzFNdUY1SXlQZDJtVjZWWVpZZk9idTJKQzdhZTJLcDJvVkdo?=
 =?utf-8?B?ZVkrbEU1bHFKNGZjdzJ2RHpuUDRBM1N6eWJMUkFrQmxod1BrOGZJSk5OMnRv?=
 =?utf-8?B?U3JXN2x4R21YOXgzdjk0K2FIdjlNSDVHYTIwNC9QRFlYK1V5MkFNcmVLQzdi?=
 =?utf-8?B?SkxEd1dPQVFXWWJhdlRvTW95akx0L3dvLzVmelhUVTU1dWo1WWZzWXVDL05r?=
 =?utf-8?B?S2UvVGVxZkpyODB3Mmo3SkdTUjhhZmlIZ05XZWxHbkM2dXlFR3ZTa2NSN3Rq?=
 =?utf-8?B?YWNubzZtdkhZak5DRkIyZ0Zua3B0ZFdJK1dGTHkwSW0zY1JERkUrNy90NDFW?=
 =?utf-8?B?K0NGczVkY05nU3VRV2d6RDFQSFJQNXVhSFkyVFRBSUpyQ2xWNTFRbXhOeGxX?=
 =?utf-8?B?YjRjNldlUlVIcmszYVI1OUtMdEM4RWU4ZjBITmVBb1ZROVVuODdOM2FWR1JL?=
 =?utf-8?B?QXNtNmtibktVTHorSjF5RVR0SWM1K3gzRC9mbVhrbTFKVWpqSmNNNDlQbUN3?=
 =?utf-8?B?KzZuV0NDR1B2YXZpK28zYTgyRGJpK2xkNG1xWVo5cXp6SjYwVndRTkFEeUJp?=
 =?utf-8?B?UTQrOElCbmorT2JFQlAveXV5Z05TVkcxUlEvSEN4NlU4YmlNaldUdWpqbnFs?=
 =?utf-8?B?VDlPQmFWWDZxN3kyYjVodnkwME9tZEIwTkgzYzM2dDdTWTdTdisyU3pDVEpr?=
 =?utf-8?B?eGpkK2g3Ukp2UlNMUVpYbEp6dURsVjBaV0Y2Mkt4d29QSXlLYjY1VmJqWFNI?=
 =?utf-8?B?RFhhaWkvWmxnbmR0ckFrc2RRcVZhelJtM205Rmp3czRMOFdTNFBlMU5LYjZD?=
 =?utf-8?B?eXZmMG9XUTN4MTFCcnlraElsK3h5Zi9ETHJ1TXJUbVVDQ3g3TzdCejB2eXZx?=
 =?utf-8?B?T1phR3dVN0orNTBSeGU2VmMwL1VXQ09odDlQUE5hRFh4M1BiQXBHcUgvOW05?=
 =?utf-8?B?bVlyckxhQUtFMHp3NFdyZzB0L0xUQU5lcjBTa0NTUERydS84UmtiaUlvN08z?=
 =?utf-8?B?WFlWeGVBRmlJZHZ0Uld0RjVGOWUzZWFiYzQ4ek51Rk9MMVF0NG44RDlSditE?=
 =?utf-8?B?MWhhOGJnc1ZNUDJUeWJVOFRLOWMzaFkycms1NTRaOHlyQmkzSUxLNFFNaWla?=
 =?utf-8?B?cDdRMzNSbkQ1QXdVYlI3OVhxb29IeFFxZS9tTzNmeENZRldvdm5MQlV3ekxY?=
 =?utf-8?B?RHJYTTlJRmZoaHNmQjM0ZW9oUDNvM1N5dE93UHJGc3YxSVcrME1zdjB5Zllw?=
 =?utf-8?B?ZDVMV0l5WHhWck8xb1ZxN2I0V0xFdWlUU2g1VmZhR3FRSCt1V0NMVG1vUzN5?=
 =?utf-8?B?NHlZaml2RzBHdXdVR3F0SklJd2d1R0RWMHlqU1pROXZYb3kyZDFVQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15e6a7aa-2087-40e7-0984-08de4de4d43f
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5716.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 12:03:54.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4JSOdPBGSje3oP+Yap1ibrjeF2wVoy75nweMGPI41hEWNvhmKMOfL4WXRErrWPOXYuZH9S4jDtV1SIjbodXHLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

On 07/01/26 17:12, Sakari Ailus wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hi Kartik,
> 
> On Wed, Jan 07, 2026 at 11:54:52AM +0530, Kartik Rajput wrote:
>> When a device is matched via PRP0001, the driver's OF (DT) match table
>> must be used to obtain the device match data. If a driver provides both
>> an acpi_match_table and an of_match_table, the current
>> acpi_device_get_match_data() path consults the driver's acpi_match_table
>> and returns NULL (no ACPI ID matches).
>>
>> Explicitly detect PRP0001 and fetch match data from the driver's
>> of_match_table via acpi_of_device_get_match_data().
>>
>> Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device match data")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
>> ---
>>   drivers/acpi/bus.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index 5e110badac7b..4cd425fffa97 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct device *dev)
>>   {
>>        const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>>        const struct acpi_device_id *match;
>> +     struct acpi_device = ACPI_COMPANION(dev);
> 
> Oops!
> 

Apologies for this. Should've been "struct acpi_device *adev = ACPI_COMPANION(dev);"

I have posted the updated patch for review.

Thanks,
Kartik

