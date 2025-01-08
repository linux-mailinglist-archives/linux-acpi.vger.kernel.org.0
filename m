Return-Path: <linux-acpi+bounces-10431-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE06A05FAD
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 16:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58CF8166487
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Jan 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5571FCFF2;
	Wed,  8 Jan 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iPqRXEDg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D81FC7F1;
	Wed,  8 Jan 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736349051; cv=fail; b=at6USyDnrVrP/MZeRbcB7ziVuzoQWNEcnOBydhnLASqWSFSoruspjXXpK3FzqLfuzEsnuCShHohHygnjvuXiTSOVG+z76NtMXNkNXGwwN3vSE80dz5goHpxuyhy9SeqG1rA0Gxiimq68XkBdhsSfFrI4mKWQT8D3q4s5kaG75ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736349051; c=relaxed/simple;
	bh=0DFxD10dX0oK8bI0d4ohgeDap6vF41uPoem6QK6XxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A45LZ3COTVTTejPeOZFOiZr/oyPCIp0Z+yHFu7P1glC24BRgPxwwuR9MBcJfnpSIH1CbC1/i5kD7CBc5VBmvKo3lo/om5wis84ytXeoZGHjFUA28bQITlc+5KjDZmPlc6g8D8w2UaG5wFTcUJx7G24d0SUMy8EEA3rkDdQCsvsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iPqRXEDg; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxVUe7Iq0ebPvIBoK6/R6QnpA+QJ6ru/6KHTKPCZvrlV7wbqR5IUaYTmIyPhsyRcEc+s6uBdBNc7QA93N0FOzNZcoQ/BTiLMEzeGOCH9hcm2xrHy51UB6YnNh1tM9edW98AJdAf0ikRga681+AQ5KMIGsrC42hOue7Hx1eV3olOtLIVI2nRDBUHFf5rfwLezKmgmfTOqBrmY0EnANVjAaGi10ePpRJ9Ls1Le28yM14ejwzkvcI+FQog/uthsWb62jaYGXhSOSorPhO1UN6KVJou4GRHUq4cbBnECZP3SYz7otMZE6OCegaCeEKNCXE/i6UO5OPIJRTultfPx/67kyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuwVl87SboOIXk//eLVds9n+OK1zQuOkxp82q/4TzoQ=;
 b=Sjzjg2FG8zlNmjz8v5IQjW+GjKmM/L4Noh/OV1aajc3vGllY/pNRObKncxEC6WAGcMUK8BoKBcbvbC4FgSu3T6usn+E2tWRyTjWEnmTyswNe1FU9IPBDel9UH8hIKZCcXxY1KqCxeRUy9dIW+F8S63b/lOOOtFTYnrb0Epgv8qyMZyRepc8Y5ywwwm2mo2NtexCCLqhER1b0l6R7fTL51aTf4HCwlR2HutInRsjUMuzJkSoW2EKB5ZUinNntFDG3wbZa2Z9Ea9K7EQmYy6kb3qnwOM2lBi6zGsqGbl3qcM0QMMjJiv/9/DT2MyBX4HLyLRUYE+OlYbnHpAgRe6Pb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuwVl87SboOIXk//eLVds9n+OK1zQuOkxp82q/4TzoQ=;
 b=iPqRXEDgdM4JqflWPaI3Cc/19rAjKgA9Yw2iJVWobVq5DnSFiA7CyP/RusNydAu9hjBJqDxRb+uzB6/c0r/RziFnDxd+3ZGgmHaBN3kSYo8kiGfaAZTyABuULpgPmp7UtNVFJsw7JGpo927ag+LxG1TAQrEK2ZYr+y28/9C5sPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 IA0PR12MB8304.namprd12.prod.outlook.com (2603:10b6:208:3dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Wed, 8 Jan
 2025 15:10:47 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 15:10:47 +0000
Date: Wed, 8 Jan 2025 10:10:37 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Robert Richter <rrichter@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	John Allen <john.allen@amd.com>, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI: PRM: Fix missing guid_t declaration in linux/prmt.h
Message-ID: <20250108151037.GA1221136@yaz-khff2.amd.com>
References: <20250107161923.3387552-1-rrichter@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250107161923.3387552-1-rrichter@amd.com>
X-ClientProxiedBy: BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::21) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|IA0PR12MB8304:EE_
X-MS-Office365-Filtering-Correlation-Id: 882df1ea-e4d0-454f-546e-08dd2ff6a137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGRGSzB2alFZZDg4dnV2Y1psS3lGaTJLTTVaM3E5RUZZSTY5UkNjUmNMMnJu?=
 =?utf-8?B?RjR2Qno4d1Y2UzdJVlBJWVdySGpjeEQ4ZDNlbUw3TE5SbnA0bkMwR2ZPMkFS?=
 =?utf-8?B?c29VQWcyTFhGQ2c1czNITmZwQmsvMS9WdUs0bXZZZE1pbHVENnRNK3F5Vmht?=
 =?utf-8?B?TE9YMmxma1EyTDkrR2ZTbk5ERXJiZVlla1VaWWExRjNaSGVpV2IrL2s2eGtq?=
 =?utf-8?B?ZXZtMlF1bk1jY0tnZ01YSTNWSnNxR21xV0FhZXJJNnJuU2pZNk9iWXQ2eU5q?=
 =?utf-8?B?b3gwNFdFcGxCMk5RUCtuWXYrb1VDd0JDN09WY0x0SlpRM2lHUENvZlRLRDJt?=
 =?utf-8?B?Sm5ZS0xpY3d2ekViRWlidFFxZG04QWxUQWZpZFpUSGhaRjhSVnlMZGVCZ3dy?=
 =?utf-8?B?OS9EWUtLLzlnOWxqdmNGeDVFTDZ5WDBhd296eVhCc01qZ3VkWkpheTVZYmRH?=
 =?utf-8?B?ZnVFbnRaWW9iNzBlTHY0enB5WDRQZWhGUnpJVklMekVIZi9JbFV2SGpCc3BG?=
 =?utf-8?B?VWt4a1gyM09tUlVVcVNMajZhSFFyWS9zSURKcW5hYW1DcUl4Y2RVWUk2dXdI?=
 =?utf-8?B?aHVMcHhmOWdYeFBlOVY0MEhzQTVXY215UmxRTHVpem1RQmZaNkJheHZvUmFy?=
 =?utf-8?B?czlDTXZLbXUwZllSUHgyNVowb3FqVG5WWnJweHVWWFg4TkZaSEs0VS9uV3Ir?=
 =?utf-8?B?em1MWGhKdy80c0VTbXE1aTNaMGNJSVBhT0g4TGRXM1N5ckEzMzZjLzdqNHNC?=
 =?utf-8?B?YXgveVBCRVpDZTE0QTU2NFp5RlZxaVpOd09xVzVqcWdxanozNDNmMExhbE9x?=
 =?utf-8?B?RzhKNnl0aktxRkMwNmhnY3Y5cjhUTFdmbFpEcXhYMGdOblVkalhpTGlKRXdX?=
 =?utf-8?B?elJGUjdiUXcrZEhPa0hUUEs2N09UUHAyRFRlcnZqdXhPckxhcVZlTzdwUktH?=
 =?utf-8?B?eVFGc0p0YlFtcWQ4WVdjdDIrc0trWGZuSXhoc0xRNEpPb0E5TEtESVBzTnM0?=
 =?utf-8?B?WUhrRDZ4T2Vlc3hvSjZXMENIQzdSdmczcjZiMHNmZ3lOM1VDOU1neEwvSk9z?=
 =?utf-8?B?NWlKL2Z3TGNkZFI4b05SY056OVZlMDZCUE50L2p6Y0hWdmgrVDlQTmp0NVdU?=
 =?utf-8?B?WjgwWlpQZFRxelF2U2VQU21FTjFjcDhBRFNuNlJWajJOUTdWbEwxSzdXdWVE?=
 =?utf-8?B?U3h5WW5BZUFCZVk4NFB0UGxyOUxyRGdxK0pBN09oRko4eXFJa2tPbllQdjFq?=
 =?utf-8?B?b3dIMzR1R1RiT01QVUJvSzJITDJzQkE5NXNHRDBFM2o5S2Z6WmMxNkQ1Qyth?=
 =?utf-8?B?SGdLdDd6alQ1ektNcWhmaUpWcHExMTFtK1dZTXk5cHZrYk5Pd1ROVXBYR3BO?=
 =?utf-8?B?bkFlTG1td0QyYVN0ZlB0QXUyQUdyNnBOTWYveXp4bDgrdUk2b3JYOHFZNnI5?=
 =?utf-8?B?Y1F3enJ6T2g3UVdPNXp2T3lyaEhFdUlsS1NSWk9yMlI2c2hwZ21lUUYyZ1p1?=
 =?utf-8?B?ZXNjNFBUR1VxNFN6eS9GcHhKM2NDM0pJMHpEUWJYajBaTjkzeGovbjFpdFBl?=
 =?utf-8?B?dkNEK1lJckxKbXIyakJsSXF0VDMxT1FIenJ4WFhhQi9xTHU1VnN6c1ZQdkFB?=
 =?utf-8?B?dnJndWpndmlUd2VxS1NqK0V1SkFzT0VnbXNqdldkc1ZocTB3eldhcTRzMW1O?=
 =?utf-8?B?WmpoZ3F4dHVaRzN4SG1ZNnE1ZFhHT3NxanI2T2NRbGVsQ3BuTUdDZ1IwL0hp?=
 =?utf-8?B?VEIxUEZsbE9GUFJsVVcxOHlGcVBKWkVNbVRQeUswZHlEbDEyQ090aEpLZXgr?=
 =?utf-8?B?UjlxdUROcDFabllXVUQyNGk3VmVLTmo5UFdJQjdzYXIrWG1FV2ZxUnBhemwx?=
 =?utf-8?Q?EVjROhxJbT4/C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2lCUzcybnltbGdiYmVCVkYvTzQ5ejJmQ2RuUDEwWlk3QVh5UlF4M1FjSmdK?=
 =?utf-8?B?R0NJSEdYNE5PUmw1SkJQTFFJcC9PYXBqSEhMRGlSWExTbFBEZnAxV1BpMm0r?=
 =?utf-8?B?b0p5M01UcWZmVndCQi9nN1J0d05vQkFxT2pUaGYwWEYzaS9uL3RHSFNzaEE2?=
 =?utf-8?B?NU05K0RvQ0k0MklxdXR5Y1RFajBZcnpnUHdTbTJDcjE3SjN3L2hSR2RabEtU?=
 =?utf-8?B?bnF2YVhjUkdtM2g1RXdHcXNqakM4VlQ3d3VZb3BiVlJOZzVzWHMzZmJnTTJw?=
 =?utf-8?B?YWVwVFc4ajRyRE5lYVRPS0h4NFQxa3BjY0ViL1FSWkRRdGMvRjhWNE9Cc29E?=
 =?utf-8?B?SnZ0SzE1dmoreW1TN3ZyekNjT0JpVjIxS0tIc1orYlk2R3lRUU9NbXNwRXNy?=
 =?utf-8?B?K1JBOG5XWERoZVJMMHI4bTJnMnAxY292R2pVQ3hlSndMK3FyWkxnTTJHWkVa?=
 =?utf-8?B?Q0JXS0dMWkFrTDhZa01CbEE1aTFhbUpCS0xoUjRrZkpTK0FQYmY3TUhiQXQv?=
 =?utf-8?B?akw5cFpTUnZreFhGeGJRYUY1cnd6VWR0S0diakJXL3pQTU1HcC9nZk9laHZU?=
 =?utf-8?B?ZHd2Q3ZaKzgyMW1WY1oxSnVPbG0yNUZtYWNkdEd2QmYrbUViQjdac29RNTdZ?=
 =?utf-8?B?QTFBb09ab2Z5eVVZSjkwZkJNeXc1Qzl3K2E0dzZXQys2OWdsTkVOaEtUV0pu?=
 =?utf-8?B?Y0FuMURyNjBJcHRjWXMzY0psQ1pIRzVkWEMvMlBYVHFZRlE1M2RjT1ltK1o1?=
 =?utf-8?B?eHQvVmxnTHpaNUQ5VzJ6ZFpQajJDeWl5WVo4RFNpNTF0eHBlRW8rdDdLTE9v?=
 =?utf-8?B?eTZTbERpNW91THk2ZVdSRlpVWGZ6OGtTd1c5QTJuNXZOUUF6Y3hlcXFkOVdk?=
 =?utf-8?B?ZHJnWjVZRXA5amFmcGZXTU5jaWE2VXFYc3NXWk1Nb0VURnk4eG45V2tVenRD?=
 =?utf-8?B?S3orZnBVc3dUMnBNa291a2FMQXZzaHhIMlhaU1F4eWNVZDR6NUNMSkNwMTFG?=
 =?utf-8?B?U2xnV00rcjRHZlpPUU1HRmRiRm1QaDFpTG4vQnJjT1FxZUJJUS9HZlM3aU9p?=
 =?utf-8?B?WTNCb1cxampZemVPOWRQMkttK1NmSC9Dd3ZmS0ZwZ1psMFJXdzRKdzZSamJB?=
 =?utf-8?B?dCt5aFhPQXpWZ2F2N2dTZ3AxQkxzMlpxSjN3QXRsWDZNK2QwQnBmYmpOcW9O?=
 =?utf-8?B?RFN2akV4RXp3WWZmV3QreFdFNWZzbnFqeU9VcUIxNHBWMDNoeDhHN20vMlVi?=
 =?utf-8?B?NmwrNW1GQkJqQXljcWYvY3JKbEU1cDNQdW5kVzI1MzlFVUVUUGVQMTNCQXpY?=
 =?utf-8?B?V29SUW9hQ2x3a0VJVUp1RUVGRTdmZDJpdkQrcnptV1FlMGhxb0h0RzArWE52?=
 =?utf-8?B?ZXowMGllUHMrOGxmc2trRVZURGhNL09SUnBpUGl3bDVPWmpDQU5MWnJkM2VC?=
 =?utf-8?B?Z3BPajJsSlpoM2FVSnAvbWl0SGQrMnJ2cVcvYmdVOTQxa290RWhvU0hyUjdj?=
 =?utf-8?B?K2NPbGhEb3ZzUlRiYlNvREE0MHNrTkpyWTFVMlU5aTA1cVp4cjRWc2hSbXRt?=
 =?utf-8?B?NklDVVozRUJBYTUvY1hsWWpGbGQ1Rkl0bnVLdDNxMUppNUgrbGFTMnJPWFdR?=
 =?utf-8?B?NlpaeXJGL3BYQUprNkFodEg4LzdjRU9EclNuSHJQc2JNdWRRSFY5U1BUZ1Vm?=
 =?utf-8?B?VExDeUQ1TWtxaElkYVlJSUg3dy9ldnF6Q25mVXhDbVkvRWZZbkZaMk1CQkdM?=
 =?utf-8?B?ZzVsbm9VY0M1TzlkTWtrbmNOTHQzcUt1QUtldkJQeHl2Z3h2OEdQYnVJVG8r?=
 =?utf-8?B?UVFzbDdoUHFycnIxUlJ5SUlXblhYWGUzSkhNWTVGbnZydFhLc2d1WG44ckZm?=
 =?utf-8?B?TkRqem8zQW1NSmlsNnl5VmUvNjgrVkJlN2k4TElNNHVYK1p3Y1NCckVQaG0z?=
 =?utf-8?B?elIrcDhsMXB4TlVsQ0hNWXZpWndtbk9tR1pmL0RxZDlGd0wwK2drSDJDTXNB?=
 =?utf-8?B?MFhHVDdoR3FPblJXUVJVQjE2WUtxaHovRjI4aEZ4Tmc4RktTU1lhWGN5d1g4?=
 =?utf-8?B?VGdTVGJ3Vyt5N2t0bG1VaUFZQ0ZvVnN0ekdJQmlZTU9pRVR4UkVhY3l4SHh2?=
 =?utf-8?Q?GlrKiTJgexw8XyU7IsLVWDQMI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 882df1ea-e4d0-454f-546e-08dd2ff6a137
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 15:10:47.1959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eEUl2WuscJjWYJPt+n6W9mgwySVT5hhXM/9Yi6OasI29ql0cVUPx402NfWWyuOBG8Vm2SkqMmVu9fqot0MyOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8304

On Tue, Jan 07, 2025 at 05:19:22PM +0100, Robert Richter wrote:
> Seen the following build error:
> 
>  ./include/linux/prmt.h:5:27: error: unknown type name ‘guid_t’
>      5 | int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
>        |                           ^~~~~~
> 
> The include file uses guid_t but it is not declared. Include
> linux/uuid.h to fix this.
> 
> Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: Borislav Petkov (AMD) <bp@alien8.de>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  include/linux/prmt.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/prmt.h b/include/linux/prmt.h
> index 9c094294403f..c53ab287e932 100644
> --- a/include/linux/prmt.h
> +++ b/include/linux/prmt.h
> @@ -1,5 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  
> +#include <linux/uuid.h>
> +
>  #ifdef CONFIG_ACPI_PRMT
>  void init_prmt(void);
>  int acpi_call_prm_handler(guid_t handler_guid, void *param_buffer);
> -- 

Hi Robert,

This looks correct. But can you please share how you've encountered the
issue?

Thanks,
Yazen

