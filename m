Return-Path: <linux-acpi+bounces-21460-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JzhAaYNqmlbKQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21460-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:11:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534F219325
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AD6B0301A2C9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3557A3659E9;
	Thu,  5 Mar 2026 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lds+X2Jn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5793644CB;
	Thu,  5 Mar 2026 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752290; cv=fail; b=EBTcUgIAPGBd7aqJDfsuzl3wQswH6MF+j1gbm6pQbs5qLcmNWV1nO676Z6f0fjyprM98MWFx3Gu9hbpBeYWFLBlsnHfdRgNMmoGZUtJV2QGfKl2W76iiSmSgy1C+hWj+J7gJXhAP/KM5MHzaBTIQknrubjjfd3T2fYWUB8Pp30c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752290; c=relaxed/simple;
	bh=6qI8p/SM0BSSCKZexB0HFjOkvZQKa5aCJ2+ZsA0NBMc=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=ieBGPQRSWZNP3jC0zq0QN/goIF6FRgZe6OVTBDsAqB0FA7UL8Puel54Cifv2OUvT2E/vDFgKC/+VPYl6G5eOL6R3IhxPYZwpUyra3RiqHDsaboRQpBWB4yQl7Bz633fbpdlNtKUgq/5ILJ2BW8jk6WdEEaGEta1GgNhr/AGy6QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lds+X2Jn; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxJmipR8mWgIZvPqEckxpfn1UOvOaKMnwOnz6vvofjFogHiMkjGnBhhbup6L4Fi13G+M5+eMOm59kgLp2VhQuzeIZgm5hYJYmwv9EqZpXJWbnPtpk6iUCj7ZVvXP533sPK7borb5BAvPl1LO9/MY9DxhVXg7JzoEVRv0S7T0U283/CHdtmMzCK5H5pIohiiccOl1AJv7L9jfGNMbS2ci38DgrkCJuTfBHqxO1vck1+NA/QqnR1jAMHneikh5+AI9KbUCLXMIjsSq7jZaZFAJHGkGlJj2llPRrgJElCAqe9r/xo7oRRCdpsOMStVIU2pOAl3sqt/LjfJTmOizF/yFLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKkIZhJvZjIdM3iObxSkGqMlhKoaIiQAJ2hGaKb7VNE=;
 b=Cr6ybFOLd32Slms0G+sqpUsr9mrX+HgMQ92ibCivTyfOIeqIHNcyjPzuK/CoQRNg2rAxvaKfigjK4U96XF+T/DMLFyrbgQhqkdFd8F9W98woE4LZWgZ2AUtQvpWZ6llBzH6G1Za20958ZvleQ1k7VTaEmUBQR8FGTRCzSPyHlloEGBW0jQxsMSZNdPShBUsKvxak23sLNWN7LEI4qkjChyeLL6n6Xb96ShePEgIqcPfsYm9IwHsBkCux+wmrvOKV1MYJPpy1ZCvaAySo/FlBcN7WW/mK1nKfWOgpypfQ+4e/a3/JNpXgZap6/lq2DXKyCgMHxobgEc9JYz+Q0tZDUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKkIZhJvZjIdM3iObxSkGqMlhKoaIiQAJ2hGaKb7VNE=;
 b=Lds+X2JnFaFhcJ4WdEis5rQl/Af+dIP2Ub1JKoMFJJwiCpYJyhru3M1VTu+Ki6WHfTlDSZ9Y3XZbt8s+h6ICC7Wm2uYal9sUcuqk3qXfA3HPooCnlUsuOY/GRo+IPPb5chMD6avBzIEkP2ndq/7gIyXRn4tI8d8Wy5enEbXM0xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB9501.namprd12.prod.outlook.com (2603:10b6:8:250::17)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 23:11:25 +0000
Received: from DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96]) by DS7PR12MB9501.namprd12.prod.outlook.com
 ([fe80::4564:457c:524b:6b96%4]) with mapi id 15.20.9654.022; Thu, 5 Mar 2026
 23:11:25 +0000
Message-ID: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
Date: Thu, 5 Mar 2026 18:11:23 -0500
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: rafael@kernel.org
Cc: W_Armin@gmx.de, lenb@kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Bin Du <bin.du@amd.com>,
 benjamin.chan@amd.com, king.li@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
From: "Nirujogi, Pratap" <pnirujog@amd.com>
Subject: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit:
 02c057ddefef5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0251.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::19) To DS7PR12MB9501.namprd12.prod.outlook.com
 (2603:10b6:8:250::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9501:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 3197040d-dd57-4412-8f0d-08de7b0c8610
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	tuFbLPvwcP1oSW62WPBP+fIivbqZtsTBQuZFUcmHQPf48fXBB7cVgNUYpwhECI8/m9FJ+mxjhpo5SU29MiVIfnHYdTNnOGBx34D4TV2dyJ3D98oKybe4OC/e6ZOoFYNSts0DtK9jSZsT2jiemH7l6U0tgxDMJlHXfVfxz79EnMXd7W8S8xZ5Wm6eahpqVC2WVxBzjxQd6dteAUnJ3n0+D+pFLPmFakP9VEXV6opPiJ1D1mQM8cK7okGPldinP148W6BWnG4QQOMu20KU3mSr7uTfiapCIN2Ilj80i1pZg17Cp1+OO0Tfqi4iSEVFoBoPvOiTpmpsZhM7hFbiGogG35TvNjp8TAmuIQFo+0UEVG9Xllh5SPxIGLQCQA4IJiiT1EUxvwfobkJjlSVB55DPg7ka+61lC13VODzYJBRBTfrP+zGWoKwFTVd101Loyqinw0+y+yhBFCXP1yh3xrjOr3qhtQwt4StshvV9wV6ZZz+W4bYIvtG5pi05AXCYECiSWd32yWxZBLWiiCMWaGdTjn/SaficALNo5rO9xYxqt9lYcfEpRVRBvl2jyGqDTw3hKmKUtlURciICpGwWmdbzKti9tbze2YQPIWAwMuu48wgyLEbA9+2ptdAnuVPmCGzdvZDxVynbm1CjWBOdLRwkbVp5kKIj+zr9B8FquOXKGJYRMw+P7R7nXkJhT/Dmse0r
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9501.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXc2RkRjQkk3dWNGZWhCamt5ai9hcFI0dE9rQ2w0ajJRdEJYOS9jNDFxcjNw?=
 =?utf-8?B?NTBKNlErV2wrVXhwNjdxVTMrcTE0S24vVlVSSVV4MWwxNDFvemI5NTUrOGI2?=
 =?utf-8?B?Y1BKUGttZkZXZzczaEVEZ3Y2M0pwd0g0WHFiZk1vNXZiR0VPMC9OT2c4clJ3?=
 =?utf-8?B?TWpFVW42aXpmbXBYK3AxOXdZK0o1cGJsRnZZSFBNeExVQnBucURsNFFrZ1lI?=
 =?utf-8?B?ME1WU1VaaVplL3B5ZmZObjhGTGh5dUJXUnZhNWt2UGZ5ZjU2N25TZzdiY0lk?=
 =?utf-8?B?Z1VkYjBlclBWOS9DNWpRNGdlZlJaQ0RDcTR4YmVPeFMvNTh6WG5IZmN0REtj?=
 =?utf-8?B?Q2pZeTBkaUcwUmR1ZURya3FZdnE3OVhCZjNJUFkza1dHRjc4d283cXRaeGhU?=
 =?utf-8?B?Q1BNQzdROG0vdjRmRTRNeGs1REpWS0RNTlJEUlNpTXBiUDVnV0VNOGU1SDBk?=
 =?utf-8?B?OTUybDFyUXRlOTAvbFpOSlVFTjV2bHVtSDU0MFR2K050eTVmeDlxN3Erc2dF?=
 =?utf-8?B?d3F6MVMrZ3FTSVRQTFVSZ1BIZ0ZHU2VZM3oyS3B4SmgzNTlrUDlFOXFMbFQ1?=
 =?utf-8?B?UTRTNUZCa1pVQmpvV1dCMU1OMElJbndrWXhWRXdPU2tLYjRoTy9BS3ZndFdM?=
 =?utf-8?B?d1JZNERkc3hUSUNIRVVpc01rYWphcm5YeFI4a1FJYlhpNjgzdzEwMjF2RGxW?=
 =?utf-8?B?L0ZTQXlQdGszbzBvUUpXWjhLMVluZGxCNHZLbDBqZDNJdlN0dWFlTmw1dGt0?=
 =?utf-8?B?VEU0bFg1eHZia1phaWxQRzFWTVlDVkttd0QzdmIvd1JNTklqREJLaXhGOStR?=
 =?utf-8?B?VGhYL2pXRWxaSDQxMTJ5OEs0L1QyS1hkL3R3eGcrcTAwYjRPNEl1dE02ZFhI?=
 =?utf-8?B?ZDJ5RG1uMCtSZGdFaGRpZVU2YW5qYklTY1JpVzhyV1Q5N01lTlVObEdSM05F?=
 =?utf-8?B?UGRnS3BtU0tzSlJJcy9TeXJYQTd1SlhITHZkWmdtcy9rK3Z6cVJpVEd0bEY0?=
 =?utf-8?B?dkJhbHYrd3RKY0k1WWZ4MmN3Nk96NGtiUGkvUlE3Si9QSkVqYnV1SEZTelJp?=
 =?utf-8?B?cloyWmg4MVJmNmFKNGhwM082d01CU1NpZlFEQVQva0xUSEFzdmtDOWFiVzZT?=
 =?utf-8?B?Ykc0RVZycnRSbXVxZEZ2REpNeEpkekR4RXNmMnF3ZUczbFRWdVk0OEI5Z0E3?=
 =?utf-8?B?cnRaeVhZc0hJbjFmMmZhRlpsWFN1MDBtd2dsYXFWSnUzcElLbjFqRE05SkxO?=
 =?utf-8?B?ODBYUWtMQXF6S2xVZkRYSnVvMkNjL3RvWW04aTVpcWl4bElCTXVRNitLMHAr?=
 =?utf-8?B?U1VVTlZQTXlPc21JWHN2YzlDSklucGozT0JST0ZqZFJ4SlBicTdtUjY5Slpj?=
 =?utf-8?B?d3RYSkNXb2JEeWMzZWJPYUxWRHg4MXQ0c2F1eDdhb1gxSjNmaDc0amtGeC9T?=
 =?utf-8?B?QUNrVDJlbmQ2UTFaQVNESUxsRmpmWXlwMDhFQWk4SmxIYStyb3dvYm5Danlw?=
 =?utf-8?B?MUFDSG4vQWp6dFR4WEozc0pCNkJOaTZsRlc2T05rZVpIb3NhSERDb1hnNkNn?=
 =?utf-8?B?cnJKVjNjMmRhQTd5VDRMdFlnYmI4M1RYQkJlTXRsVVpSVS8zaHhaQmJHYUw2?=
 =?utf-8?B?cjlEZ3hSanpNdXpEUS96VzVmSlVYRUtRVUpYYmw2MHVaYmtwWmk1VjB4dkVh?=
 =?utf-8?B?Q1NTN0pkSlVQWGtYejlwb1RQWXUySCtWWDNacGNyc0hpZjJGY0xZOE81akZQ?=
 =?utf-8?B?WDlIMm1uRHJmZUI4MVlETjR6OEZ0bDdVRmRuM3B1WFhLdkpNdDRFd1BpRGpQ?=
 =?utf-8?B?SnRyazNTdXR3ajdhaldxeS93MTE4WjVLMFZiTDNhcFpZNDFZY0thWlNLNnpt?=
 =?utf-8?B?bFRvRjlaYXJRekw3eWVNZGpKQ1ltcFlsVUxtU0hPT0R4QUczUEtHVXRzcVJJ?=
 =?utf-8?B?RktYWXhiOUFBM1orbThRMTRTWXpGRGd3L2ttaGwwaDdCdTF6VlRRZ0xRS0Fu?=
 =?utf-8?B?TEJjNXVqaGczUEN4b2hrdFRvbmpndUxLZUR4cFZBYnEwaG5GOThpckRxandh?=
 =?utf-8?B?WmZoUVgramNNeS83OWVWN21SQzRBOStwTFJWclRZNmR4dnBKL2JkbXREVUZ4?=
 =?utf-8?B?azdKclhhOE5SV2k0bnZKVDg3aFFOUVl3bkFEcmhxaDMxNUJ2SUxGMWJZZW1J?=
 =?utf-8?B?QVJFTVFvNWU3SExaSWh3VUs5Wm81Y1BvREZLQWF2dUtkNVV3c0lWTytWQ3A5?=
 =?utf-8?B?YXJ1VlZLT2ZwUEVXR0F4emFDNWtUU0xOelY4WGJMVkdQcmJ0MVdNWEVTVnph?=
 =?utf-8?B?OTh3bUV2UTFuU3ZSVFA3aS93ZGxlSExrMHZMNGtlUlBZa0ZodEdKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3197040d-dd57-4412-8f0d-08de7b0c8610
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9501.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 23:11:25.3981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +eYF7fW01aIyHD+AWcoRrsXFYLZAOVL1NjQZzmTtFIjcTlYqhAJrSfNzDmPX58V6Tptm0Ty1+qW8op+Qxe5dxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
X-Rspamd-Queue-Id: 9534F219325
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21460-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pnirujog@amd.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid]
X-Rspamd-Action: no action

Hi Rafael,

In kernel version 7.0-rc2, the AMDISP device reports the following 
errors when created via mfd_add_hotplug_devices.

[    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: 
no  post: no)
[    5.236744] input: Video Bus as 
/devices/pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/input21
[    5.236779] acpi device:14: Error installing notify handler
[    5.236782] acpi device:15: Error installing notify handler
[    5.236783] acpi device:16: Error installing notify handler
[    5.236784] acpi device:17: Error installing notify handler
[    5.236785] acpi device:18: Error installing notify handler
[    5.236786] acpi device:19: Error installing notify handler
[    5.236786] acpi device:1a: Error installing notify handler
[    5.236787] acpi device:1b: Error installing notify handler
[    5.236788] acpi device:1c: Error installing notify handler

These failures indicate AMDISP device is incorrectly detected as ACPI 
Video device while it is not.

The seems like a regression caused by the change that converts the ACPI 
video device to a platform device (commit: 02c057ddefef5).

Issue is not observed in 6.19-rc6, and also when this change is reverted 
in 7.0-rc2.

I really appreciate your inputs on addressing this issue and helping us 
make progress on 7.0 rc2.

Steps followed to reproduce the issue:

1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to 
avoid kernel panic found in v7.0-rc2)
3. Build kernel with:
     - CONFIG_AMD_ISP_PLATFORM=y
     - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
5. Boot system to see the failures

[1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
[2] 
https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/isp_v4_1_1.c#L132

Thanks,
Pratap





