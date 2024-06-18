Return-Path: <linux-acpi+bounces-6502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B41E90DC64
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 21:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1916286742
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Jun 2024 19:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631AE161900;
	Tue, 18 Jun 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lQ16Y5PZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65CE15747F;
	Tue, 18 Jun 2024 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718738885; cv=fail; b=AFv88U+gaak/nqMHL/02IJw5G7RxyoTI4WIDEzcK/3gw5uKzmDACaHUFakjkHCB9pIAGYRy6dDo5EddzsrLOGCJh/E5gzorkswJfYQdEpwCTd1DuT40z9xeh/NWbh/dCKnsaPjnxxN6tRJsXu0titsolJrqN6BWEov6pg+gvCyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718738885; c=relaxed/simple;
	bh=iB8S/0ClHCfJbYqwaUR5xWq/TOFxUBzMGa5CPNqPuSw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M7nQYbqIfNBPq6/al/ZNqrY/BGX9Zd1Y4XKBE2dYclN+d6il2NYyfuyNlf8d44R43ZorENJVTkCaob8srp7V0KOt5LGoe0KzZK90/07B+9/U55MjjSREvpMtkdgQM6jVEVuGyc8F6ns4iaaeFRn18PMGmfUDloNcHH8StZneg8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lQ16Y5PZ; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+Uo/5VrLcN7ZiWOlO4q6EMdBwp3llKCDVV8aPyzdpQpkvWneLaaorbVH9IgKGUfueKHd27cFZMq/2B2k8TYrB7kUTKdxmaNE8AuRya/aXjoib2eLrPOAYlthiudmhNnyO1On1WSghWj7lw7JUs3PYefYm4Gun+XOjP2eFrVck1pYJwoetQQrkfTFLL26Yla5PkccHAuqz5KBGjo6dNkshLs/poMMih8IAmoRod5ntLrWxVSnDFEYNHtJ3x/HiuUWsRBv/m9pjWu5upJ1HjaWLqHn1MWA+TLowSj7+ChtiNx8ba7a0LFwSnaTPMC2269FbXZLv9a0gjAZDS6LAiHdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YmtWgK0MWLTnwT4g8fKbW6gE8Eg23buoebWHqVnQON0=;
 b=OV3gAD5NDwH2mu+ihpcKjK+JBNTFEbcdlTV7274s3pSI+e+SetgTkQvHokKyxUMOsptyguXcBaAxaFjEQtpsfGKQnGkKG8TYSkvF875WRZ6ouzJBxWz0RcYhxomugASOExSsM68Kx3v8xvRYnxI842YBfL/WiEEm7/xrVf3bERbeligL2tv/1D5wyxdrPE2yQLnZH5f9lPYtfDWzYZKm/oCltXX8PbUS9pxQ6DZzykRJlWEWoAGcyvaNjzUdLuzA7hHd7eGMLIEF3RtJjyj73cAnzQLPdB5K31dhrjYjCpTCDQCfL/y6yvPdSpj6oJ1wkWY8WsPtTP0F3yALVjgcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YmtWgK0MWLTnwT4g8fKbW6gE8Eg23buoebWHqVnQON0=;
 b=lQ16Y5PZlDbxhm6hHAyU1K7t+68NbusCSEvdhIvCqk/+voW/ZQ+SH51eIjinsIVVY4wCJjijYjwZG5lvAUIpSYGhoV+R46ywx4xvJmPY9vK0r6BArViVh/k0df7tHfYGohtJ4brusdqhVLJlhWIeoo3FE6V6QdwIWKJ1uyXI38U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB8888.namprd12.prod.outlook.com (2603:10b6:806:38a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 19:28:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 19:28:00 +0000
Message-ID: <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
Date: Tue, 18 Jun 2024 14:27:57 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, mmikowski@kfocus.org, Perry.Yuan@amd.com
References: <ZnD22b3Br1ng7alf@kf-XE>
 <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com> <ZnHSKiaYf2tIQo58@kf-XE>
 <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com> <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com> <ZnHfNbLTgY1op3Zv@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnHfNbLTgY1op3Zv@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0046.namprd04.prod.outlook.com
 (2603:10b6:806:120::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB8888:EE_
X-MS-Office365-Filtering-Correlation-Id: 966d10ac-2dbc-404d-de6a-08dc8fccc3ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTVXbVdTMDRqMmpFbXUrSktmZmd6Um92V2lOcjBteis0ZCtrR1Rya29KWE54?=
 =?utf-8?B?b3pUUWIzbmRuaURYSzN6bzVnYmJIa3d3Z3ByR2ZsRHc4T0tDZTNWZ1Z0ZGZi?=
 =?utf-8?B?NDFUVzEwZXU2WGVPVnkwVU1EcFExTWpaUDFpNEo2M015RDRsekk3TnFwUk55?=
 =?utf-8?B?VU54VUNDT0JVTmtWVG9MYXNyS09ETkUrS0hhWS9HR3VlaTJoTDR2QmFyMldq?=
 =?utf-8?B?d2V2ZU1IVXlWK1c3UW5Zc25rWWZMTHk1djc5OEtEUisyM1VTNTlKeWl2Y1M1?=
 =?utf-8?B?Nk9ydVlIdE45YW5BNzVEMmw3OEI4OFhQY0pibndxTkFLWEVYc1FSVUFrQXpJ?=
 =?utf-8?B?QXhoUnBYdjlwbVROTmN6T0tHSnRyNXB2UEZYTno4bTdLaUFYUmpOT3VXQVFH?=
 =?utf-8?B?d2FiNjJHWUxZaVRwbUNMWll0SjBvWkdJTm9BaXdMU0tsOXRXQUFWVHpZSU1G?=
 =?utf-8?B?U2Zpb0JpWDJpUFFwZG1idXc5SDRPNnFQVC9MaUI2cFM3bHRMWnRPNmlEZ2hP?=
 =?utf-8?B?am90c1BOWW1zTmI0SzB6OW1mOWdmRDljdU5XSTE4K3ZQelhiV21RYkQyVmZB?=
 =?utf-8?B?Wm9WOHNESnIxeGVXaHVLVEFXZUZ6M1JHZHZteTFLeGN3eUdwUlE5WXlRWXh4?=
 =?utf-8?B?S2xiYzJaaDBGZkkyOFVYZlI0NnJzcnV0Y2ErREUrY1lHVXlLRXlLTmhCenhq?=
 =?utf-8?B?Z2dJVkZXbWVVTW5PZTlQU21LSDFFN20wc0laM2lNalkxdHJvcEN0WkpkakI0?=
 =?utf-8?B?Wk10NFNFcHBCZjJaOXRObzBhVk5YZTNyNldlaGZob3hVVm1wL0xZVmdkajFx?=
 =?utf-8?B?d3czdGpDM0hybjhYdmtya21GamdRMEpFY0VzRUNUUFI1UFhqanE4Q1RHVDNG?=
 =?utf-8?B?YldtQ0didGZ3dEFDR0NpMWlXcVFyb3A5NEFuSmt1ZUFIMVhMKzROajVkNC9C?=
 =?utf-8?B?enhLTHpITjRxblF0bUtEWFVxbW44YkNIbk41SXhuSVVOR3gzUlhtdVplaTNO?=
 =?utf-8?B?ZndsemxlOWovQ2crb1BGK1hxL3pTa0R5T0t6QitJRjluMTd5ckRhRlh1VjRB?=
 =?utf-8?B?SGNJQWp1S0M1WDNDRG1GNWZZOHB5QytMd0NtTjE0MVZJdFlDKzRiQVZaVThS?=
 =?utf-8?B?Z2U2c3V6SkJIMllwUGxGRVMxWnlJZ2JWZFhBZEEyUkY5Rzl6NjQ3MytVZ2ZH?=
 =?utf-8?B?S0s3RW9hSnNZVE1tTVFJdktiWS9FNHJXZXJWSW1Cc1ZlTGxOYzJVZjVEWmtW?=
 =?utf-8?B?VGZjVmVjNnlnVEx0VU5sVjZpUloxRDhTY2l3dTAyVHczdDAvb3R1RWlHdTZV?=
 =?utf-8?B?MnF0ekw5NHhNZHJ3c2ZCeDRSQXBOY3p2WVE5bXU5eWR3enl6U3UyRnBYMjkv?=
 =?utf-8?B?aFFYWll4N0ZDb0pIeUZUV0NxOHFTOGliUTRoUmhiTk1jUzFYMVNudk1aMHlC?=
 =?utf-8?B?ZitzVW9OU2loV3FDK3oraTVyYzUreU1ScVBxQ0NZK1VGeGtSbE10Z1lYUmNZ?=
 =?utf-8?B?enprS21XQnk4QjdYTFA1UElxVkVoVlRtNUIrbFd4R0lWai90SnZlay9sZVhT?=
 =?utf-8?B?YVJOWjlVMUEvRFZVQ1FLOVRiZ2o3cmwvWGM2QkpnaUhBT0tUaWxvSWcySmpX?=
 =?utf-8?B?M1pqSDBOZWcvTml4VXF2U1RnS2Q0UC9uUkhlenhhVnRncDRWVkdNNTU2WU1J?=
 =?utf-8?Q?H3HZaVJNwSaTJnNzQQCQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmNpcUxXd0JVT052NnowSGlNSWZqOEt3c1F2djlJbGVTTHZTRWhzRkZOTjlt?=
 =?utf-8?B?U3dLd0xiaEYzdVd2bnBveXdGTzNsRnNFY1hMa0E4alZaQ3lxOUQ1MDNtTnZj?=
 =?utf-8?B?SE1xaytHaVVaa2ZBNTFEUkJTSWRvU3JlNmFOeEc2ZzVqQVpqaS9yd1NuOGxv?=
 =?utf-8?B?VjF5VWduVldDZThQanhZcXcwZmFQaHFhanBIeU92SC9IdHNlWngzWVM1QU5N?=
 =?utf-8?B?ZS9aMHg4ZkEreENMRnVNT09vM3o3aFNuK1gzeGNzYmswQXBZbExjd3lsMWFo?=
 =?utf-8?B?K1MwcWlkMFE2NnZSWmpXRmJ2TTVTWVRYeVJnWStNdmk5NDBJMFlCTC9Qa0c1?=
 =?utf-8?B?M2d2Yndka29QdFRvNEF0UTFBRTdCckg2WVhTMjVQVld5WElhSW9IU2pJTk5W?=
 =?utf-8?B?TWJVZmRNWnBIWVVuMmpONTNxNFpPaFFoT1Y3ZEo5ZE9KVUFJK3JtUHg4TnVu?=
 =?utf-8?B?cGFqQWxZOVpXQVd0SFdlWkwzbi9UbzlzN2JSVktlbjNqSGxSMXkwUm5MRzBL?=
 =?utf-8?B?UTJkS1M2QVBHT0V5WWxXdWkvMXo5ZGRDc3BpZ3FrMTkvL2xhVkFMbHR2TE5u?=
 =?utf-8?B?ZXk3eFVoek95YXVNTWpVYzEzNzNzbzNkNXhzcHdRbHhaamlCL3d0dnFtNXgx?=
 =?utf-8?B?Z3Awb1RScFpDSyt3cmhXUVFXVEVKY2l2VzJPSFg2YXl4amdKU3c0aStFQXln?=
 =?utf-8?B?KytuM3d3L2pLOG5XbUdhY3BmcUpObW0vK3NCU2I1VVowQmJFTVdHVzBZQzVI?=
 =?utf-8?B?MFdCbDlmVzhBYms2WCtSZjZQUVBIZHBPRVNranZhQlRmSnhUOXAyMFM2S0Rp?=
 =?utf-8?B?RWV6MmZvMlVsUXM0b3pqQWw1Q1Nuem13RlEyUE9OR2lhSjlWZmZ5TFkzQk5O?=
 =?utf-8?B?eTNSNUM5Y1JzZW1PRUEza1dlWkN6WDNzQmNaTEd0Mm0zUytVb1d2b3hoUkw1?=
 =?utf-8?B?N0hLUWROaGp4UmFyRmpCdWNRc1cxQWp3TEM0bG1kRWxyQlR1c2JGeUV1dUk4?=
 =?utf-8?B?Qnl6YzhkMUJNdG5NQ1pPQXROWEhVbmcybHphZElCSFpvZlRuSkZRSGJqbmgv?=
 =?utf-8?B?SEpyN1F1TTVyTzNFbnNLT2dUb082Sy9la2NhWHdMbitFU2VoQk1oRHZ2SEda?=
 =?utf-8?B?elBRSFc0M1BZOEE0YlBXb1FmVHZLSzlDRVR0bm5xYkJVZk5ISWtsVFFWMTlu?=
 =?utf-8?B?S1JIV3FmR1l5LzNyNVVkRFJCTXFvUHQ4Q2RaN3RtdytLbTA2Q0d3d3RkZndB?=
 =?utf-8?B?M1ROdG5ZSG9ERGpXSGI4anUwcVNRUEZ6azArMmxJZVdDd0lmRFVmNGpWd2xr?=
 =?utf-8?B?NDQ5OXZURkFmNy9hZ2VENnAxTUFQS1M0azljM3EwOGo0VWZvMWpHdHY1RFZo?=
 =?utf-8?B?VjJIVFNwRWZ0UGxYdzlRb3Y3dkxVbE9TV2ZHR0RJL2crdjlXTnd2cklwOEl1?=
 =?utf-8?B?NXFQempDd0JlVE5FWHpPT0NkOWVkczRkSlRqTVhXeXF4MTdCM0xLYjY2b3JF?=
 =?utf-8?B?QmVOUlBoQTRnZEJxUzZyRitCTkpvMUZXZERjQ1pxWTh2OHNscDZLSVUwTFps?=
 =?utf-8?B?Sy8vTmRMeE9GdlNrZ3pHR2NRaEpFZDE1M29UN1hlMUthaHJ0VFlDTTcxTVpm?=
 =?utf-8?B?cGZsdEdadmY5SmJXRHBPek00TzV6c0JsMU0vYnZERGx2RUNNKzVhL1BVdDFy?=
 =?utf-8?B?bm1udjd2S0MzbXIrMFAyc0tGai92NW9NRnZycU5yVndDUGFxS0Z5VVIrWE1W?=
 =?utf-8?B?WEFiKzA4bVB6d2xTTVFBRzVsN1JtQ1VMNk1yUlJqRmpXUmFuUVdrQjVsUUVP?=
 =?utf-8?B?VndsUGdWVTY0ZGZrYXF1MTl6bFFUQjNGQzkxWG14WnRYU1dHdXdIU0w4L21P?=
 =?utf-8?B?L3hpc0FVV2cwUE90c0p1bGhVTElXZXMzM2lpeDgwZ0hzaFNSZTBnQUZLeXFs?=
 =?utf-8?B?M0p1OFpYL2xIcnc3RW9SUzNvL3lNbVhUanVzMHF0NTRDOHNEakp2dTVXRTVK?=
 =?utf-8?B?V2QzOTBCamxZOHh0RnhQcUZDSkZLSVFDa0tROE5YNW1nbC9iL1RkQ1pkZ0cw?=
 =?utf-8?B?NDNSYktsNE5adGhJTTY1WGxON0FEYVdWV0tFOWZEMVdORithMjl1cXQxN1l5?=
 =?utf-8?Q?FQBNVKJU21QioZI6N8WwtP4D4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 966d10ac-2dbc-404d-de6a-08dc8fccc3ef
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 19:28:00.5819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DYLZ2ZZcU4S9iWB6YjmlP/BA09wJHyRiI6OmDVDvQ5Nmxk3c9Nmuoqa/XuIqR1O/PriZC7tyKCMwKSFO87JVtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8888

On 6/18/2024 14:25, Aaron Rainbolt wrote:
> On Tue, Jun 18, 2024 at 01:58:07PM -0500, Mario Limonciello wrote:
>> On 6/18/2024 13:52, Aaron Rainbolt wrote:
>>> On Tue, Jun 18, 2024 at 01:35:57PM -0500, Mario Limonciello wrote:
>>>> On 6/18/2024 13:30, Aaron Rainbolt wrote:
>>>>> On Tue, Jun 18, 2024 at 12:09:19PM -0500, Mario Limonciello wrote:
>>>>>> On 6/17/2024 21:54, Aaron Rainbolt wrote:
>>>>>>> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
>>>>>>>
>>>>>>> The _OSC is supposed to contain a bit indicating whether the hardware
>>>>>>> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
>>>>>>> be considered absent. This results in severe single-core performance
>>>>>>> issues with the EEVDF scheduler.
>>>>>>>
>>>>>>> To work around this, provide a new kernel parameter,
>>>>>>> "processor.ignore_osc_cppc_bit", which may be used to ignore the _OSC
>>>>>>> CPPC v2 bit and act as if the bit was enabled. This allows CPPC to be
>>>>>>> properly detected even if not "enabled" by _OSC, allowing users with
>>>>>>> problematic hardware to obtain decent single-core performance.
>>>>>>>
>>>>>>> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
>>>>>>> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>
>>>>>>
>>>>>> This sounds like a platform bug and if we do accept a patch like this I
>>>>>> think we need a lot more documentation about the situation.
>>>>>
>>>>> It is a platform bug, yes. See my previous email,
>>>>> https://lore.kernel.org/linux-acpi/d01b0a1f-bd33-47fe-ab41-43843d8a374f@kfocus.org/T/#u
>>>>> (I meant to send this email as a reply to that one, but failed to do so.)
>>>>>
>>>>>> Can you please share more information about your hardware:
>>>>>> 1) Manufacturer?
>>>>>
>>>>> Carbon Systems, models Iridium 14 and Iridium 16.
>>>>>
>>>>>> 2) CPU?
>>>>>
>>>>> Intel Core i5-13500H.
>>>>>
>>>>>> 3) Manufacturer firmware version?
>>>>>
>>>>> The systems use an AMI BIOS with version N.1.10CAR01 according to
>>>>> dmidecode. This is the latest BIOS available from the manufacturer.
>>>>>
>>>>>> 4) If it's AMD what's the AGESA version?
>>>>>
>>>>> Both affected systems are Intel-based and use heterogenous cores, not AMD.
>>>>>
>>>>>> And most importantly do you have the latest system firmware version from
>>>>>> your manufacturer?  If not; please upgrade that first.
>>>>>
>>>>> We are using the latest firmware. (We're trying to work with the ODM to
>>>>> potentially get a firmware update, but since this affects more than just
>>>>> us and a firmware update may not be possible for everyone, this would
>>>>> likely be worth providing a kernel-level workaround for.)
>>>>>
>>>>> I can easily provide more detailed information - would the full output of
>>>>> 'dmidecode' and 'acpidump' be useful?
>>>>
>>>> Does your BIOS offer any options for these?
>>>>
>>>> Intel(R) SpeedStep(TM)
>>>> Intel Speed Shift Technology(TM)
>>>>
>>>> I believe you need those enabled for this to work properly.
>>>
>>> Neither option is available in the BIOS settings UI, however our ODM
>>> confirmed that both Intel Speed Shift Technology and Intel Turbo Boost Max
>>> Technology 3.0 are enabled by default. They did not mention SpeedStep,
>>> but I assume SpeedStep is working since frequency scaling in general
>>> works and the kernel patch fixes the issue.
>>
>> Got it.  If those are enabled I think it would be good to get comments from
>> Rafael and Srinivas about your specific situation then.
>>
>> But regarding the patch, if they are agreeable to this "kind" of knob for
>> debugging I personally think it's better to have cpc_supported_by_cpu() look
>> at the kernel command line than plumb arguments from the module down through
>> every function.
> 
> Just to be clear since I'm not all too familiar with how kernel params work,
> should core_param be used here? Or is there a variable that allows
> accessing the entire command line to look through it? I don't think I can
> use module_param in 'arch/x86/kernel/acpi/cppc.c', core_param has a
> comment over it describing it as "historical" so I don't think I should
> use it, and early_param looks like something one is only supposed to use
> in code that runs very early at kernel startup. I can probably figure it
> out on my own, but a quick pointer would be helpful.

early_param is how I would do it.

You can save it to a static boolean global variable in that file.  Make 
sure that you update documentation about the new early_param though too.

