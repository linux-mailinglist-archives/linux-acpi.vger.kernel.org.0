Return-Path: <linux-acpi+bounces-21518-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIYmByFErmnVBQIAu9opvQ
	(envelope-from <linux-acpi+bounces-21518-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 04:53:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64A23395C
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 04:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C374A300EA92
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 03:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6977027816C;
	Mon,  9 Mar 2026 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E8wcyqBm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E832F254B18;
	Mon,  9 Mar 2026 03:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773028382; cv=fail; b=VLFayjWlWFLAaG7Kr3ZdYnTH/cVTz2xxVBQW6L3hIv80kiMEibRL/lz2qDFfuM59o6DWU7XQ5EfpHYjkyej7NBXdYDQdTPwW2CKzayJJREkWF8WD4FeZnfth+JsMFGx04d6nphN4d9lxHTpKFACGtHr6+Gg5a2oNpAIC7eyq+1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773028382; c=relaxed/simple;
	bh=7Dk+pQw89QcETjKStNbPkydnhmxiV0E+Co5Lm2bI8U0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B+NH6/fz5D8kQCwtTKvy5eIW3cszUeZvL9tJhxO5d3ScqPGiZT6hMLhZNmIF6tU8PbaK93f2bCX+DF2+ZsRP/rEqD5UY7i8jCJQ7625pvcyjcnh29aF7QNuJokaIU+L/G1APIsU7peBXm3nRBY3N9DcpFPMaTqM7i1zrRbLO9Qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E8wcyqBm; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CMhn1uKxy9g40N2twg81cxL49HHEUAwkTMCf19VuIroVYS0L+aL6nRFkj7hueJr0gs5Y7VDxgKD0MjHek1/VEAhnEOMZvwjwYiVxfbOSCLoepRN8t2uiau2NbPNRV+W9K+0JWL45zTiWj0bsdeKiH2K+FDaDA/CKEXxsZ/11yF6IrWpPkZtFULDSCuOEz1BJol1jSHFjZWJXa2oXroxzDeWeTidOb0o6CRAPdgup2JJ1IIh2hhFHo9kPwCIBiazfrfWN1hmTm4L+i0aHXxJKJdkHbRJzSANx4gU+Mw/iRyU4wou8XVdetFy/Wp05G6hW9u4u3JIwnmmPu+v486KCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBUvkBKFbMCyGvOsl1hGC6CJkGDJMOeR8cZH4fcNEQo=;
 b=PHPdMSReII7HUrRYSjPIoUI6fRABkbFqyUJ3cTHXiOVMGayPTtzvItUK/vOuu+R/ILCLV/7qjgCbQ6H37wEx41jIi1eZVy4Zf1MBHNpLXzzvzoVKKuDWkNWqDLVmtn/G/GNPQrI+Sf97pyfjUjxnN/yHt0JTIdM8NhqWkBC8QV4aQWDE7iOGADSSAeKVJDuSOw0g2KZRLzi7pVR5dqiv/+sQCSv4lb/dMCJXzPVXiHd3VBbSEYpRFZjwYGbCqGAvKnQryMlbkb37P6szCxQqSsfHboXAVaxBjV4aFaSKi69FfS9Lb/HvM5SlfHQRR0JY8cLTILLNFmWRHatWk9MSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBUvkBKFbMCyGvOsl1hGC6CJkGDJMOeR8cZH4fcNEQo=;
 b=E8wcyqBmlroeoFuCjG9xzC36CnyKIzhlaSN/ggohHs+QRS6Dx6Oix8nc+6F0CU1ydy94Y7sUXqlhyRVnjPyjoCz3lgktoNbQSQTEzYBgzCCe9hxmK6TuYopYgJgrd7y/K4Pt4en7Rdo+aiIjJXD3lGnMSBRLkSjdJsGiN3UI00o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7)
 by CY8PR12MB7292.namprd12.prod.outlook.com (2603:10b6:930:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 03:52:57 +0000
Received: from SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d]) by SA1PR12MB9492.namprd12.prod.outlook.com
 ([fe80::a866:904d:73a1:d65d%5]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 03:52:57 +0000
Message-ID: <44b0ec66-59d0-4c73-807a-790817f22409@amd.com>
Date: Sun, 8 Mar 2026 23:52:53 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit:
 02c057ddefef5
Content-Language: en-GB
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: W_Armin@gmx.de, lenb@kernel.org, Bin Du <bin.du@amd.com>,
 benjamin.chan@amd.com, king.li@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
 <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
 <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
 <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
From: "Nirujogi, Pratap" <pnirujog@amd.com>
In-Reply-To: <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:610:4e::11) To SA1PR12MB9492.namprd12.prod.outlook.com
 (2603:10b6:806:459::7)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB9492:EE_|CY8PR12MB7292:EE_
X-MS-Office365-Filtering-Correlation-Id: 5056e4e8-0383-49f9-1894-08de7d8f5994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	XTc0cRXjtTd7ntaa8u3X0/91c4kJCimXi50pSSckk83nmltHadMX9U3C+y2GQPd9ZLx1yc8D4st3Zb2+uNhWUxK3APNszjrOJEoBMTTCKGL8H19wKOMcCBMfemVcrVjQqbQD1S2VeIsyW80FiZtQGumGcRALrlTXW3k36Uwb4zfIlAefn0DtMaIB8/OoI22SXJsz5moCTkXN1yYxALt8p7Xgje44g7vchtS0a6P6RP6qMQUaHeXHzhUj6Vy1C90H2U369AQMDRx/0/vL4sbd8YL2wTxW8DqQcwb94F43gozHYfHS66diCIs6nvb/yR3LfJ4mjDMmZIFHBJgqK/ZK1SOYVHVZZJc0KiB78rEBXgcVWfkP+3kGRcInPKpO/m/cY0SgvSWr0xkcua/Ztpg2i0YHXxq02psBPC/9F3BgDEVTUJsB/yiOmlhX9//RO0vswFXim2LFri8PJcEAoDCrhwx2tkS5i6xd8G7ITOCxcOjZEeVElORgktTicd4MBmfouqAYJg1F2z3Ic/kpJhUSKO3LxrYmRwPkWwHxXOrBJtRISzfxJ1E6+LwtpS292CJu9aMJXaEttfdhjkAFiTcgKGHuDxLsI8PrnbK3FExzxk7lpF0utBTIhG58YtgADXjfGXE7N31RPL4NuKtkSQQ3Sawq57ILtWzC1DDxsopw1YDhYxmssf+Ncy5rupSeyPQKFcO3zygPIhHRm/toCRkYlQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB9492.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUdFY1c5UGZSVTd2Z09tZnJKUGZWa0hLUnp5dGFXbkd1ejh2eXNNZmZ1OXRM?=
 =?utf-8?B?aWFnYm5FbEFSVlJ1YWo5bENjN2FGSkZBOUxYbi9nWjQ4ZWF1YWNHOGhyc2k4?=
 =?utf-8?B?K0tiUFpkdEZPL1NRVi82RXh2N1RKZkNJdUtwcE00Rncwa0VrLzk1bXI4WXlZ?=
 =?utf-8?B?MFJkcnA0ZTdlU0tmZHdLNUpoSlpUeHBnd3ZzRTRwSEdyellTNkZxb0ZYUWlW?=
 =?utf-8?B?WEl5cWNUb2d5TFZMbUFrTzBmczl5ejlycmVTYjR0cnlEU1gwL3hQYjJCSGhr?=
 =?utf-8?B?QTZrcmh4S2wwaTNGb3pCMHZVVmcwYk5xMk5lYXZNRDhac0lRY0dhYnJ3NFIy?=
 =?utf-8?B?c24xN0k0WHpNcWd0RjdCOSt0Wm11QWh3MzZtV2hJM0x0YXREZXUxL2NRWWdp?=
 =?utf-8?B?dC9RckRGVXQxK3l5TlJLSWJZZ2xOQlhMMXJCOFNVUUJXa0RhakdiaFRUWXF3?=
 =?utf-8?B?UjZ4bmFNZnV2dk5HUEFieCsyNXBuQ2FFL1Y5RzVQc2xHa3ArMlIrQ29wS1l2?=
 =?utf-8?B?YzNGUWJlSHpSUVFrRUVhYWdEd0RWMk5qbDkvRjdnNjA2SzBJYXc0WTRHb2hO?=
 =?utf-8?B?ZWY1NEpkQ0paNzhhVW9NeWlXK3NQVUpYSEpwdVpnZkt5WVVFL0k5cExMbTNr?=
 =?utf-8?B?V0tjNkNWMFFMZ3NKN2ZXcVFiSndncExjekNmMDB3dGtoanphdnVaUWlWYkZk?=
 =?utf-8?B?M3ArVnJ3ZUtBd2gwZmp4NVVVK3MvVFdkZFNoWXZqRzh4R1ZhMThCSy9lekZC?=
 =?utf-8?B?U1FqVXl0b1drdWdiUVF6QVBuSHVqVVFOTkNuUGp6cnFOMXhTQ282eHh4aFBm?=
 =?utf-8?B?cExZWTlFNGdqWE9DcnI0SE90M0NUM2xrUHZMYlFJeUszM2V0dU1teGRyQzFr?=
 =?utf-8?B?L3dPVjdWanVFSElvNmFuajZqbVIzU3ZXdDUxZlE5QndwbTRVVnpFVTVuSHUw?=
 =?utf-8?B?bEc2bjFGNWxDb1loK2hhWWZMWlBZdDJtTzZaZUwrWDZSMWgzQUgvOWJUcVJz?=
 =?utf-8?B?eXYvWFNQenBPclNBaCtnakk1MVZKM0ZDZjJORVZpQy94NlZLNXlFT2ZoK0Iw?=
 =?utf-8?B?Um9qM214aDdmaVUrSmgvcVlmTzZTM2FYRVpGdldUb2FkT1J1UldINzFYQ05i?=
 =?utf-8?B?SEV2cmU1N2svYUpLT2pQb0xaR3VpRDVFeStwb0VmZTFrTTJzNVNFcklKandW?=
 =?utf-8?B?bGhTR29ET0VpQ2o0dlBmZnlCL1Z0K2NKdWd2dHczKzJLM0RrQXh0SEFSVzRK?=
 =?utf-8?B?aENpOXIzZ1dLUTZQVndLUEc3NHEyQ2taSTVyKzRtQW02NWUxZ081OVNqNms5?=
 =?utf-8?B?eHA2bVB0Vnk3b3loVUU2M0k5NHMvY3cxYTVmMExTQ2ZoOFVWQWNxZkw2b1VB?=
 =?utf-8?B?NDlxWFh3NWxLaUhiUVpCbE14NEdvY2NpUGFuQy9TdzhtTzRoTmdEbWtnWmdV?=
 =?utf-8?B?WEMzRUpuVUtlUmZ0OXFXTXg3YzBlaDF4dUhOeFp5d0FDK016UU1kQ2tROVIy?=
 =?utf-8?B?eXpGckMvOUNkUEY4TW16cHBSR2pEdVI2NWN5ZnhLVnZuTXllU0MrREkrelFT?=
 =?utf-8?B?cmE4QlBFRml0UnVta2JjakoybVEwRlhjYk8wWmoySmJZajlGSVF6a0V1TldW?=
 =?utf-8?B?RmRjd0k5bFVsdzlacFNMS2JzcFJwUW5NaGZObGhnZm5XaHJsVjNvanoxbnl4?=
 =?utf-8?B?QnlKdnN5S1hzVkVOc3VwZW1DUVd3UHZtYWQ5TkNWVG03UHlDalJ0Mnhud09q?=
 =?utf-8?B?MWdNb2IrbGY1NlNsRm9UbEpaQmUxSkcvcHZOWW94bUFVeDI5MzJ5b2RQQi9W?=
 =?utf-8?B?akJ5V2ZUdEpYODZLMGd5enoyUGdvRGR2Q3pNWmFSQy8vRk13MytCK2xoSXNa?=
 =?utf-8?B?a3F3Y0ROaGZWRXVSa2hkWmt1WE9xYnRUc1IzMEN2Y2RqNVJLNlJHdXJiK1hs?=
 =?utf-8?B?ekYzWkorVVZRSDBKVCtzZUZjbnd6YTdGM3VvZmhUeFFDeElQa3pCZEw4ZEM2?=
 =?utf-8?B?UmJQWUFCVE5KdWRmN2JDMUY3amdzMXNGeWVxQzU4K2RIQW1LL3dSZ1habjNJ?=
 =?utf-8?B?RGZJS0lmS1NNL3VRVnJFQm1WNlpwaEswUnIrT3pDb0FXMCtMbENEQkNiTkRT?=
 =?utf-8?B?QTVPd3JEWkhxSmpuMUtaaWl6WGV6R3BlbVl1SjVHRmZOWmJocU11dlJKQ2hG?=
 =?utf-8?B?d1QwRjRIU0FWRnprSmtOclpubmpESGZrSXU5L1pxVGxjRW5aK1g2TlZ1ODFa?=
 =?utf-8?B?TnZqK3A2cVdUdFNwYnI1Z2J0QzN4enJiWmc3Um40K2ozYTNXY2FqRXBlM3dn?=
 =?utf-8?B?NUxUVng4d0lzc2NYMlJCUlc1dkxjNHFUcmY4L1FMNzFqSVhVV3pFQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5056e4e8-0383-49f9-1894-08de7d8f5994
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB9492.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 03:52:57.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Jr4zBXEY7dcpfagYHGLAZMjZO5OozaBPyUJBFQ10ugCIb3VTUvq5JA+Eybk+p/Be16IN4XTSSCzT0oa6yjOBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7292
X-Rspamd-Queue-Id: 6A64A23395C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21518-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pnirujog@amd.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:dkim,amd.com:mid]
X-Rspamd-Action: no action



On 3/6/2026 7:45 AM, Mario Limonciello wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
>> On Fri, Mar 6, 2026 at 1:35 AM Mario Limonciello (AMD) (kernel.org)
>> <superm1@kernel.org> wrote:
>>>
>>>
>>>
>>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
>>>> Hi Rafael,
>>>>
>>>> In kernel version 7.0-rc2, the AMDISP device reports the following
>>>> errors when created via mfd_add_hotplug_devices.
>>>>
>>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
>>>> no  post: no)
>>>> [    5.236744] input: Video Bus as /devices/
>>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/ 
>>>> input21
>>>> [    5.236779] acpi device:14: Error installing notify handler
>>>> [    5.236782] acpi device:15: Error installing notify handler
>>>> [    5.236783] acpi device:16: Error installing notify handler
>>>> [    5.236784] acpi device:17: Error installing notify handler
>>>> [    5.236785] acpi device:18: Error installing notify handler
>>>> [    5.236786] acpi device:19: Error installing notify handler
>>>> [    5.236786] acpi device:1a: Error installing notify handler
>>>> [    5.236787] acpi device:1b: Error installing notify handler
>>>> [    5.236788] acpi device:1c: Error installing notify handler
>>>>
>>>> These failures indicate AMDISP device is incorrectly detected as ACPI
>>>> Video device while it is not.
>>>>
>>>> The seems like a regression caused by the change that converts the ACPI
>>>> video device to a platform device (commit: 02c057ddefef5).
>>>>
>>>> Issue is not observed in 6.19-rc6, and also when this change is 
>>>> reverted
>>>> in 7.0-rc2.
>>>>
>>>> I really appreciate your inputs on addressing this issue and helping us
>>>> make progress on 7.0 rc2.
>>>>
>>>> Steps followed to reproduce the issue:
>>>>
>>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
>>>> 2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to
>>>> avoid kernel panic found in v7.0-rc2)
>>>> 3. Build kernel with:
>>>>       - CONFIG_AMD_ISP_PLATFORM=y
>>>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
>>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
>>>> 5. Boot system to see the failures
>>>>
>>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
>>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
>>>> amdgpu/isp_v4_1_1.c#L132
>>>>
>>>> Thanks,
>>>> Pratap
>>>>
>>>>
>>>>
>>>
>>> It's a bit weird to see it even probe in this path in the first place.
>>> acpi_video_bus_probe() getting called with the mfd device doesn't seem
>>> right to me.
>>>
>>> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO
>>> ends up matching).
>>>
>>> Would a sensible solution be to reject mfd device types in
>>> acpi_video_bus_probe()?
>>
>> Every platform device with LNXVIDEO in the device ID list will be
>> matched and so probed.
>>
>> I'm wondering how those devices get that ID though.
> 
> Yeah me too.  I was surprised an MFD device got it.
> 
> Pratap - can you figure this out before we go too far in this path?
> 
yes, MFD child devices in this case have the device ID as that of parent 
(GPU) i.e. LNXVIDEO. Its because when no acpi_match is specified, the 
MFD child devices are inheriting the parent's ACPI companion device and 
this is resulting in having the same parent's ACPI device ID.

device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91

> If they really shouldn't have LNXVIDEO fixing that may be a better 
> solution.
> 
AMD ISP related MFD devices are using the same LNXVIDEO device ID even 
on 6.19-rc4, no issues observed earlier. I can confirm automatic AMD ISP 
device probe works and also camera works on 7.0-rc2 if I avoid 
inheriting ACPI companion of the parent (GPU) in the mfd-core.c

// device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
https://github.com/torvalds/linux/blob/master/drivers/mfd/mfd-core.c#L91

But why this is an issue on 7.0-rc2 while it works on 6.19-rc4 needs to 
be root caused.

>>
>> Also, is this really a mainline regression?  AMDISP patches are not in
>> the mainline, no?
> 
> The amdgpu half of it is mainline, the other half is still on the lists.


