Return-Path: <linux-acpi+bounces-17886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D9906BEB0AC
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 19:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 92F334E2C92
	for <lists+linux-acpi@lfdr.de>; Fri, 17 Oct 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB353002C9;
	Fri, 17 Oct 2025 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="WFrXRxec"
X-Original-To: linux-acpi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023127.outbound.protection.outlook.com [40.93.196.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790F82FA0F2;
	Fri, 17 Oct 2025 17:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721413; cv=fail; b=Mp7YNaGUy/udYOlvbyRBts6jZZveL5XfjVYsYXWKMs6qgjCn1tEbBzUz0PlHxpO658+DWMq8IyNPZbqxiISvaEXQ9H24lFO0g+8XwJVLgcfUNoNhYN3/PVPAPi5Eq0M1PrmTc96wQcqG/Xi1s043QVU+845AKDlpHplShtJQmEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721413; c=relaxed/simple;
	bh=QUBYgTFgqbdGmb1NCxEaFaHQjHA6fcA2OhpCQ4MZG2k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hJ9opSKyKX9ftYtxMry1K2tgj25gTYhdKDSs3NNgqmJe/nXP474c3SIO4n12hSl7MSkBbWZUITnesEnxay0+rHSz5RwD/eI17QGE4Jzz/J4QtGTSCdln5Mx5fcPuXwb5jAyhrkGCb0Y0gC86eQ+huXfo0RqLhzkMD3jX4lxI9C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=WFrXRxec reason="key not found in DNS"; arc=fail smtp.client-ip=40.93.196.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GrpJ3RP/ikpVkOxZVzNERqYq5rLnz6njxXCH4kGRYzss9p1jrKB8epwZO5fBrHtTw6Jgj9XGdiPNZ3ir492mDviKScMl09D/aVVHOFUfN1GlAMRZz/33/Q+IIubYTAZhQvcIEydNZ6J1WfuCwvS4DL/B6vEcDmWQX2tDYuBG9JfmyWFmrodeRaSto3e1s3P6wNgy6QWY9hFlyfEg/97qSjgEORx10J7aKlaYf1IOfO6Es91pGEN3cHfT7C+pTQq3f96BKwLNU9F8Xk3LnPXGZbC4ESfIKpIVTgwMDOw40jIqa4Bl6XR6Kvy2CDPQqHDENCxgnRFa/bbWafGuj4JTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOnDx9kNUIIT2dDFH+dKdNEdVnpsYKqXJGJviWdzW/g=;
 b=DWxHYrnTeGaEtIVshPGOr3Y9p5hzAwbwuP0lXLJEBuVHrkhHCIfQswTV5wST5Sa2UVSG9P0HC4/yiudy47UGsHv37RsRrv8uvHzIA1bVGvtbhGY0SlhVFd+pWaTjgqAuXNOlG5Lf1Y6DzDlbUW43sVy11Ztgr6wVGdgSWb+Vby1+j66C/fMILeza9jUDdHfAUR/j+94EuPQ4D20wnLzF9+Xdakjk6gp3eXO/TsNjLMW3AuKDllvqPvfMA7dxHj8vhHN2oJeBkZDcvi26po/DoXPyixw8kS6JGXgrlDw6BSJCAlH+ZOMYzafy8bD+U4QplADnmc8Haqa3BLmjK2SAEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOnDx9kNUIIT2dDFH+dKdNEdVnpsYKqXJGJviWdzW/g=;
 b=WFrXRxecwl8pM+0rW2Q/vAdDp+lV81FHNoBnv8f5u3thBH73JiDmPSX+MAr6znntdWCAjda+DgVxlWOg1ECwOB7DY6+RH9F+cijRbMDzvtOKDUoXEntE+obwPkltprKCdhzrFuilpR5XbXS4uPBj0/3m9NB0dovQsyWdO65otsY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 PH0PR01MB6523.prod.exchangelabs.com (2603:10b6:510:a1::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 17:16:47 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%3]) with mapi id 15.20.9228.009; Fri, 17 Oct 2025
 17:16:47 +0000
Message-ID: <94ca016f-7c29-4339-9d52-7ca0a54ab6f2@amperemail.onmicrosoft.com>
Date: Fri, 17 Oct 2025 13:16:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mailbox: pcc: Set txdone_irq/txdone_poll based on
 PCCT flags
To: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Adam Young <admiyo@os.amperecomputing.com>,
 Robbie King <robbiek@xsightlabs.com>, Huisong Li <lihuisong@huawei.com>,
 Jassi Brar <jassisinghbrar@gmail.com>,
 Cristian Marussi <cristian.marussi@arm.com>
References: <20251016-pcc_mb_updates-v1-0-0fba69616f69@arm.com>
 <20251016-pcc_mb_updates-v1-3-0fba69616f69@arm.com>
Content-Language: en-US
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
In-Reply-To: <20251016-pcc_mb_updates-v1-3-0fba69616f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5PR13CA0050.namprd13.prod.outlook.com
 (2603:10b6:930:11::22) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|PH0PR01MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a1b7efb-bb0c-45af-0056-08de0da0f3fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V1k0VkxpWGg0NS9CRnJJMlVycVVVUUVmUEVSMkRtSFFSY1Nob1ZlY3ZtNk1S?=
 =?utf-8?B?RTRzSUZha1l2a2pwMkgvY29ZQ0ZGKzlDOXFwRGRaejZ0QTBBSElMb2VMUmlx?=
 =?utf-8?B?R0NYQ3JxblR3ZTJUa3h5cTR4Z1NlRFNwOFJUVEd5RFZleSsvSkRMdEdjOEYy?=
 =?utf-8?B?OURYMDE4TEJ3MDRtQ1BlVHZPVjZjaUY2VlVhYlBmZ2IzTzRhaytIZnp4alBV?=
 =?utf-8?B?cEhjd3BoS0hEcU1FcER4a0U5b1dFUC93SEhGb050VE0xTEdWd080TEQ5dlln?=
 =?utf-8?B?Rng1SG5nWXFWMVo4VVZPMmFFZkxkWUJUVTI0eUsvRXdUKzBPdTdNT1I5SVEz?=
 =?utf-8?B?bktXTEExU3pxNUJSNnFqMHUzeGM1UGY5QkNkeUZDSUdqUDl2dWtWd2pZdzRa?=
 =?utf-8?B?Wm4zRVVaSmVlZFZ3ZkhuZ1plRjk0bnc2WDJIcE9FSlBSNXNNUHFNZHJIaFJU?=
 =?utf-8?B?aW9SNnA0a1JuanZnQVFnLzlNaGpGTnE2OVZzcHFlbFhnKzZFd2xhY3RVaENY?=
 =?utf-8?B?aEpzb0tuYitjeHZWK09uK0UrQllTUFEvcmRxZ1o0bFBTY0xvdDBFMDUvbnFD?=
 =?utf-8?B?aG9qYWl6Rk5TT2J6Ym10aHRZcTM4Wll5TnY4dW5TTWZMcTMwUFZNQTJhQXlX?=
 =?utf-8?B?ck90TXg1RGFmSTMzOThGb1F2cHpoRDdudkNsS0xJdTRIdTZ4Mjc4Qm1IM0Uv?=
 =?utf-8?B?T2FMZE1JUHBzUjFIbis1OGxOK2FGWFM4eUVxZWVyWG9zZ04xVGdBUTZUWFJO?=
 =?utf-8?B?Ym4yV3ptcnQ2S2dUSzN2a2FnQW1HUXNwZ0lIeXFIK1ZBR2JJQnZWd2JjbE5W?=
 =?utf-8?B?VmlGSkdid21YV2JSb0J3eXFyQW5EaVdnZ3F1RW9rcnNhQ090blYxT0ZON0NF?=
 =?utf-8?B?ZHNMb20xNHorM2xjUHFveTU0QXBQMWtXQW9hdklybFp4NVJHU284d3Yxektz?=
 =?utf-8?B?OUc4RG5RVDUxZVZrMGRQdW9oOU9xQ2x3cjU5b0poQ0IyVmhqdlFISExFRTFS?=
 =?utf-8?B?WldraWc3eHNiYzRoSENmTUxFRnhLOEU4dDgyZXF3bks4WldjTFlhYS96ejRo?=
 =?utf-8?B?QXh6ZXZHR2xVK3FnRHJVbnptc3VndFEzR3ZoQ2R1RHpmaXJXOEpOdDVITzlB?=
 =?utf-8?B?MU91MkZxU3dVQVZmVldRc085dDBUZHJhdHM5amlENlBKNXhVUmdxMnNhbGJR?=
 =?utf-8?B?WGQ5VHNYdGRoZmtGTGNpYm8wSExXb1g5UHErQ055OXA4LzNWMHQ5Ym1pR2J0?=
 =?utf-8?B?d29scWljVUlkNDhQODVPSWlxN1pML1dRU3k1MVVlVG1qYXNMTE84VW1xK0Fp?=
 =?utf-8?B?OWNyRUtlVVhPcUt4VFBMcXZCQ2wrZUljOERRdEh2MHhVTk1qZHoyL0s0SWli?=
 =?utf-8?B?VmpxeXhYWVlFZjFnaExpQXNxckZUanVyVXZ6MXFobVRkeklXUG1kL0ZWZTIy?=
 =?utf-8?B?aUxPdzRQZGt4QzRDZ3l4SlhuL1J6REZPb2NmTWNkZE5qbjU3c0NTb2RlUnpS?=
 =?utf-8?B?MEhnUkJpaUZQMTdnTVJlcmFLMXE2SGNYcFJtc2FoNEQ1RnQwbXRNdGpmY1NE?=
 =?utf-8?B?UHkwUWhCeVpWZExhNmNnZDJ6di9jdzIwKzQwTUs1ckNlTUU0elQwUkJMaU44?=
 =?utf-8?B?dTQ0TWg2VVR6ZEsvaUgweHk5YUxTRDVoUjh2ZXJhZnNwUmdBQWRkdGxjVzJW?=
 =?utf-8?B?S1NnOFdZcXhPaWdUajdBR2hKNkZxWUhuc1d2TnNqcXpXUUVSbnBjOEZxdVZj?=
 =?utf-8?B?cGF1SzFjOEx1aE9neTNtcmtZcndIM2VBODBKaWlGeFhqV2JBT21TUjVaQSt1?=
 =?utf-8?B?UjB1OWVhbnBKV0c0UVF5UGhDTm40SnBidWE2a0dFY0V1MVlLSkg4ZFZYRVo3?=
 =?utf-8?B?Z3BSRk9KTCtOdVR6VjRhSFVwWTllUFFUc2JXN1VESnp1NW5yRzZ5N28wV0Zx?=
 =?utf-8?Q?FHe82Up5yFrRjj/XZtdjMxLjBs4cg+IR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNaSVdwYVlIOU13RDI4S1FxUW1zbWdpbUFLZk1oSDV4OGd1eC9hWlh4d3k5?=
 =?utf-8?B?M0hVRUs0OFJselpwWi9uaGova0Q4N1RCemgvQzlWM3dDRGU3bi8vdk96NnZZ?=
 =?utf-8?B?VkxFb3JqcnZ2Qis5RFR6Snk3WVlTZmI0N0QyOGFxYU9lZzhFNVY2V3dKSUV6?=
 =?utf-8?B?ZlFTZmtTUGtqaTJGTnBRQzNwZEtoVWdvZkcwM0FxTzFxV3ZWU1Z1bE11cDNP?=
 =?utf-8?B?dnR0TDJaTCsza3RjVEtTdUlQYUlPaEtzRVB3ZHNhUkxLd1FaeGJsNEVyNStH?=
 =?utf-8?B?ZGs5bjBPS3BKTEw0RjFJNngwcytURTFZNDBlaVFxVWJ3Q0UvMUpyVWV6QjNL?=
 =?utf-8?B?UFlHK01UUm56M0s0QTNpL21yVW9aL1dkUzVWbHdRNkxFVGh4OXBYYnFidXFt?=
 =?utf-8?B?REtZdWU5RC9IYktsVzdMUS9Xemh2UFltci83S1pkUnJJRlI4YWZOVEF4NXN2?=
 =?utf-8?B?eFh5cVgzWnhrbWRtVmVGS1d2a015RnQwM0JnRXZ1cVpRQzV0SGlTRkIzcUFq?=
 =?utf-8?B?ZE1YVmd2RDg1YUhaZ0RQQVJiWURhbEduZ2JjOTFIUGM1bStqUFQ4V3BHaGlM?=
 =?utf-8?B?K3l3YXRsL3hKNlh6L2E3NXY3QkNZZWIzUDM2RE9iQVFYUVNNT3hwdTdiUWFX?=
 =?utf-8?B?MktJb2ZpenV2U0xFSDl5RmJyVDVONkJONEdmRGRlcldDbWhpV3RmYWZ0KzB5?=
 =?utf-8?B?b29BMERaeVg2bTJud3lzS294RHRsT05TcFByRGJFZWhHcGQ0b3RZVkc1NUZ4?=
 =?utf-8?B?cFlPcFVrVTVhK3FEaForMWp5V09pRkF0WFFYdFBieUVlK3hlY0grc1ZFekwr?=
 =?utf-8?B?Ui9xVHo5YkYvbTc2WVViZ1BrQTk2bjlPOTRBYXNIbWlBMEVlOU9mZXhoRG1H?=
 =?utf-8?B?Y2V0VUx1bkxqalBTNlQwUlFsMGNDclFJM0tnY1JSdHpQNnBSdE0xMUwzL1Bs?=
 =?utf-8?B?VTJvS1k3LzVxQ2VuSUVzVzJuTWVVblF6RlZNNzQ4YWdTNmhBNVpDOEtVZ2Ur?=
 =?utf-8?B?TnFBSjZOL1czYldEM3ljcUNFcG81dHl2VnFlVGw2RjNwdkNVUlJDMWVQNjdO?=
 =?utf-8?B?djh2SmhNdnZEbWJHQi9UY1oxTG12Z2NJdWxleU0waG5EQ2VwQWxSWFc2elFL?=
 =?utf-8?B?dWNQeUxhUmhZSW9QbXBtdkZ2NDJRenR1alY2TWZCU0dubVBvQ1lrcVhjZXpp?=
 =?utf-8?B?enNXenhlZS9RZEF6c2phcjNJcWMrZDcyS203WlVaaGMxMzAyQjVVRkNkMzJn?=
 =?utf-8?B?YTBHMXVUenJDeU9VaWZkWHoxSGFaMFRMYnhLYTgxUWsrSVdoYjhlVHpTR2pW?=
 =?utf-8?B?UjFSVWt0SGpYNGdWZFU0VGFFZ0pYSEJ0MUFEazNFNFhVcGs4enA2dDZGQzFx?=
 =?utf-8?B?NzFsUzJOSTY5Tk1VYi9nN1ZGMnF6QWR1bnRlUEZMR1JRNzVQTC9aaTMyY3ZS?=
 =?utf-8?B?Nm5XTXFDTFJQT2sxeGY5OFEvdjk5SWpRL1VzOGltamxKUmNRSzVMQWVSNm5z?=
 =?utf-8?B?bEJkNHZFT3NzQ2w4SnFhVWZ5aTdkS09yUnBBd0hOc3dpd2U2Tjk4cVUvc2lp?=
 =?utf-8?B?cWloYmpYNFhQNkdzMGUzZ2NLMXRVaWxUbGJ4MHIzRmp3ZDVOY2xuaDVKZExE?=
 =?utf-8?B?WVY0MHVxYytlaDR2T2FNdkJwaUNoY3NGdnR3WDdlQ1JjUFFIeW9KNUk2emlu?=
 =?utf-8?B?UkF2aWJZVzFWeFhUVDZQQXZZNGtZdDRyemd1aGdudzJIOWh2enFORE8yWVJU?=
 =?utf-8?B?RGRpVkhPNi9Vc1J4VzBldis4a3QzbHFjTmQzRkc0Z3dVdWtROG9WRmc1cHMy?=
 =?utf-8?B?ZkhxZlpWVkZjY1k0WUMvL1RWdVJZZTJvVmNveHpIdjR3VjVVMExrUGRYbFE2?=
 =?utf-8?B?VTljUVp2TWpEZzdrS3RrbmtJM2cyekkvSDZKZHRUYjBIUjlQakxwZ0pOUGJq?=
 =?utf-8?B?eFFZUXZJUnVLUDZXOWRhaDlTaTNFbVR6R09RQ2dCYW9EUWVNY3krRGU3T2pG?=
 =?utf-8?B?K01rbXVvbmpXNi9XY1pDajRTVEZ6M0JkL3pvZ0xTTHpYQUhRS3hlNVVlaDBv?=
 =?utf-8?B?RTFsTkFyb0Q0Q2hxMitJSWZSTU1FM25IVUttVnprQkFKNVgxS2RhekUxcS9u?=
 =?utf-8?B?Wjl2MkRVaVgxblBrbGUrQVUvVnJFRGpDNzFvSnpZeHFIT0xGakk4VlNLc3Iv?=
 =?utf-8?B?WGJNSXkvK2IxWTgxTFFha04rbkJHc0xXM3doK0VNeDBVcEtUU2x5YXJtYmo1?=
 =?utf-8?Q?VIOio7h/xZWw00DQwcXdNUtEaIvN9bxBTvqaA92uc8=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1b7efb-bb0c-45af-0056-08de0da0f3fc
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 17:16:47.4084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3elZrUGS7FJhKDc6cVMvvhFMVrTE67T52Nq+ASEBopYB/R8JAYAvTDm3HOnvOU9RilmEzqS9uooqizZvnZbbMRT/gVQV+Dbh9uEHUOmmb/hwl/PBc6Ld474ZPpLpNPlI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6523

Tested-by: Adam Young <admiyo@os.amperecomputing.com>

On 10/16/25 15:08, Sudeep Holla wrote:
> The PCC controller currently enables txdone via IRQ if the PCCT exposes
> platform capability to generate command completion interrupt, but it
> leaves txdone_poll unchanged. Make the behaviour explicit:
>
>    - If ACPI_PCCT_DOORBELL is present, use txdone_irq and disable polling.
>    - Otherwise, disable txdone_irq and fall back to txdone_poll.
>
> Configure the PCC mailbox to use interrupt-based completion for PCC types
> that signal completion via IRQ using TXDONE_BY_IRQ, and fall back to
> polling for others using TXDONE_BY_POLL.
>
> This ensures the PCC driver uses the appropriate completion mechanism
> according to the PCCT table definition and makes the completion mode
> unambiguous avoiding mixed signalling when the platform lacks a doorbell
> flag set.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 2b690c268cf0..327e022973db 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -791,8 +791,13 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>   		(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));
>   
>   	acpi_pcct_tbl = (struct acpi_table_pcct *) pcct_tbl;
> -	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL)
> +	if (acpi_pcct_tbl->flags & ACPI_PCCT_DOORBELL) {
>   		pcc_mbox_ctrl->txdone_irq = true;
> +		pcc_mbox_ctrl->txdone_poll = false;
> +	} else {
> +		pcc_mbox_ctrl->txdone_irq = false;
> +		pcc_mbox_ctrl->txdone_poll = true;
> +	}
>   
>   	for (i = 0; i < count; i++) {
>   		struct pcc_chan_info *pchan = chan_info + i;
>

