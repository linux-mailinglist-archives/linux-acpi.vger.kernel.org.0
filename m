Return-Path: <linux-acpi+bounces-9422-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B649C112A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 22:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57409282181
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 21:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A741E218319;
	Thu,  7 Nov 2024 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjkDd4CN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF069215F58;
	Thu,  7 Nov 2024 21:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015695; cv=fail; b=cMxoV4LeCw+Zk+ggCJRqYjXweu7qPPqcwZLVr7ofvjGHI/ytl8InF/jGSOFJXHS9Dv+lbNR1Kl2nCPCkTIJYFtVc3Cu7kUgjRJkNHxL/JIL4uHhEvflwXe5D9Ro01ejlsJPqR0NOzuPTFysVvGCJXL0kDZktvtz+mtOArYSaOk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015695; c=relaxed/simple;
	bh=zFTELcNJ12Qw7noUZ6EyfKgKIBiCqio7jDkTOpSH4TU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GRFOWOnhY2Dw1XL2/qaAEYGvMGsPzcjRbgB48ahi3D1/vX88Q4fi5AlXAyhbw4dTfUR7eobCWR3OAQ5FIreSlsaZ0RH3KDizIWPVE/p9PhtZ8MABTZ+i44BbSKDw2T/pIh3w2WYaIxO/oeMKWl31J7rqE7l9CjkpKHC5ojh9LJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjkDd4CN; arc=fail smtp.client-ip=40.107.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL4criepPXSS+DFZDQ0c4W6mAet94H9ma6IGuGBpuN5Bjb6Ij5mvbNJc4ogvTElPDDbmrWml3pMdTJMXqafa8wrZjhFN+6VivrdLNT8UK3P5lYY0OMRzwYBY55jD2UAy1sj8z38+NvaIPPoD30VK4u24NEBMZ2fHRyl+D7PgBz63+g/VKNKihnDS/90isy5iUgYC+zgysF+eXLzWzBt+16fBrV0i6bP4zTBvoDYrR5qEZkLmUdZZ+QcTzzgmBCTtSeoV/XJ6VAUfRqfKfxixIqIMX3/aCp4W2CGyivZk/fQ8B5WMMPZN8M+qK9VgBU3DMJtt4pSD/fTAGP/jt0xLmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJekxsb8LacgWwH4TIFA33rMid9cr0Yijv2Geyxm65w=;
 b=a/B2xgq9ZSwvqirLpZPXhW+6zN5D83bPVHMfgdq1R2UxdiKt/OfIuO/CO2OZUWHVE3mSeaz7zLbe5Wx97wk0NgWRypoE3KZR0ZvvutFD1+8hThbh1OZYNMqhKyV4UKQbGqxFkCyrJkwnWNySXLV+eEyyqY2dWdY5nbQe7Sk4EO/Bavdi5M8JQSTtN2m2NK4CmQfjUpQmWqy9xVCM0TTU3dqbXdRCk7fyQirC+C+7SxX+9t5vsB8rgJ3aHsBaGU96nchgYK+q3G35aY1HFmdvFUES4anW4QK2vn2RYqqsm7RmA91cr9H2fbuF8lQriQ1mKtSETToQaHlJ5KqKpcZCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJekxsb8LacgWwH4TIFA33rMid9cr0Yijv2Geyxm65w=;
 b=yjkDd4CNjfIk3gF2J4vgLMS7aOBL4Z4uotg9oAUHLLyAjuo+FTARfx0J94y8xZ5zM+WgIUe83N+GaTBT6fYfmPzmIXCSCjOC8Mku5QTQXV3OiLvgJMneHioDIdnjw5DwMIlcR87wsqIPztv7x06eRvWRvrV2MK6VipoQRuCVd2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 21:41:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 21:41:31 +0000
Message-ID: <3618b0df-460e-4647-ac12-8063542f40e5@amd.com>
Date: Thu, 7 Nov 2024 15:41:28 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/20] ACPI: platform_profile: Add profile attribute
 for class interface
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-13-mario.limonciello@amd.com>
 <f5967c2f-1a33-4f5d-bae7-1864d931301c@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f5967c2f-1a33-4f5d-bae7-1864d931301c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0149.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c2::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5995:EE_
X-MS-Office365-Filtering-Correlation-Id: 880e0278-cc4c-4c3d-8a1e-08dcff74f133
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VndubVp6a0JXVnhsWDNkS0tXekhvWkpxMmdkT3VwTy9PanRrSkJYTXlsWHBj?=
 =?utf-8?B?VFJEYktTOVUxamFOUjA2QTVRUkN3TEY0SzJOYzNEWGtaM1BoNUhJNzJubkF1?=
 =?utf-8?B?bW41UFRVOXpLSDVaeXltRzcxVXVNRFJhUnRzMXNJZDZJbVdxVHdYTUkzem5X?=
 =?utf-8?B?L2tHa2JoY09PQ3FERElBY2FrSWhDSHBIWFpKS1FYRmVNL2ZLUkdZUEFzVzJK?=
 =?utf-8?B?N0t0Z3dhYnVWc3dwTldpa0RRMDVqVXB4YVdkVDhPU2w4S0IzUStNVmNhWmNF?=
 =?utf-8?B?ck1vdTdaU0JOcDZuQ00vU1ViNFVZU0N3ZkQ1VElYOHdiYzl1a3BpRTg0Nyt2?=
 =?utf-8?B?NEp6QUFkdGxONDlrVjRVSngrV3E5ZTB6OEhHTXNRMkpJQ0VkMUxkZnN6aUxa?=
 =?utf-8?B?U1U4SmJ5OTkzNy81enI4c1dqc1JPOVNtTzR5QXljR0RybW8xeGZXdU9ZUG1E?=
 =?utf-8?B?TVpkWlEzQlpHeFgyeVI2MDJLVmtpcWxTM1UyL1hPaFBtWVpubFArYW94djRY?=
 =?utf-8?B?ZUJVZGhNM1lVNTlFUkFhYUl1dzNOb0FwRWU2bm80dTRmSGt4RWw0NFFnVFdv?=
 =?utf-8?B?OCtQczZaL0d4clhlKzdsSktseGRETncyaXhKVGNsNlJoUGsxQjFQTmlwZzBk?=
 =?utf-8?B?QXM0TkNkZ3g2dTR5cFJYUlNZWk82WU94NUpkdVk2Q3dLN0pGMHFrVXZVTk9L?=
 =?utf-8?B?ZzlkRlUwVEpaRTlVekN2dHJ5RHd6aGJ0cG9pSzRoOHpBcFlkcUl0Uit5Z0Rr?=
 =?utf-8?B?K01Od2dNdDZ2RUNVWnlHclJhNUd5S1hPdUlraEluWHJOakdCaVJJMEUxMlBa?=
 =?utf-8?B?bjU1YWdwV01FRnJBM3UvR093Q2MzSkd6ajAyQzlNejVNR2hRNGN2L1hPd1h5?=
 =?utf-8?B?bTZUUmxyelZRejF6ek9nOUtyKzF1eTNvVXFQK2VSL3NXcmhrWlFNajcyUlRz?=
 =?utf-8?B?eDlLNmlOaHp3R1lQcU84eDM0R1NLWHdsRkNjb1E1T2htTzJkRlo0N3NiSkY0?=
 =?utf-8?B?aVVsbVM2bXJQMnB0dDUxLzFIaDZVK2p3NWMrME83WmViVndVOFlVYXRKd29H?=
 =?utf-8?B?Znl4TzB3SlQzMWgvcjlianBHNktlWDR1UVMwMEo3bi9DaFcrcTNaRmJUelE4?=
 =?utf-8?B?ZDkyTW9HcUNtTVpJRFpqTlAvMVFpWE1BR29Cek5sQXBWWnMreGdscHJ2eU1G?=
 =?utf-8?B?UHlYRFNHUFFRZlhHWDNVcXdTRGd5SHFlYlIxZUtQYTZmbWpNT3FaMFlkckZl?=
 =?utf-8?B?Z2lTemN5YW4yaTFSQzNhbDR2elJSOVJLK25tb2FnTnVGZG1pUHhRNXJnQW05?=
 =?utf-8?B?OHNkaVFNTVJtK3dqVXBYY1ozN2Nuclg1OVI3SjJ4NlRWSWVNUUpCK3hsK3dO?=
 =?utf-8?B?Q1MwNG9rdHBYUHZkaG1WTjJpUXlKbEZGQk1oL2FVa0RrU2RLTzVsVGJ2S1BU?=
 =?utf-8?B?NUxUQ1lrbkRYOWhMdEhUWVRRQkljMDdVVFd3NU1pcFdSNExYK05WOXB5K3Y2?=
 =?utf-8?B?elZyTjZYdVNpWXJzYzFQZE5kRXg2MDZDM25DNmdQVXRxY1BGcHVCN1JtWWh1?=
 =?utf-8?B?Q0tuVjMrdVFITjF2Yjl6Nk5pZkZOekJkOGtSQ0JwcFRhdWJkZCtrVWd5TmU0?=
 =?utf-8?B?RUp6UkRHUFdlZEhmZEg1VnJLYytLYmJ4WElrQXBiQTlYd2hUVzI5SW91TXlP?=
 =?utf-8?B?dWNhR2hNUmR2emhOd0ZKMFpocmFlTDdZeXVoU3RKQWUyemV5MGR0RDg1aVNV?=
 =?utf-8?Q?OccrxrRShgCNs3f3ckh9ZfSpetfxQJ81n+cmgTu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXhpbmI0QzdYQ05yRmY4TWdXMkdaUm1ITE1KOHppNHhnZDZnam5yYUxxbFB2?=
 =?utf-8?B?Y1IzemI1TlRCc0Ewem05NE40VWQ3STU4N3lxWlFwU0xsRWY4Z1hkMndndDdu?=
 =?utf-8?B?UFFOc1FCRW9VYURvNUw4VlZhNGt4akV6UG5kKy9FQkRIOW9qaUpISzhBYUVu?=
 =?utf-8?B?S29XZTYxQ2psOW1BMkEwZ2pmdHdFdmphTE1VakZyZUJPcUo3ZklvUDlDUGl3?=
 =?utf-8?B?T3VpNDRxUEpUU1J0T2NDR0owQ1lVUk02TkltK3R2aW9rQ0kycVBJcnZ6T2lN?=
 =?utf-8?B?SytaWnJQdVQzTzVXa0ZwdWZ4K1hLYndoelJ3ZGdIQXdHNWU3cUFSZFZnRXFO?=
 =?utf-8?B?VlNBSFhkTTdjWi95NW5CcVNNWUMvSCtRaENxY1piZ0lKWHNiZkNqNlA3Sis0?=
 =?utf-8?B?aXZvbnRBVkhDTWl6M2VIbUJkUHVUbnI2aHM2SkE0cGp0VDd2Z0lBelJTd2pM?=
 =?utf-8?B?YVVjUngzWnpPMzk3ZkUvVXlqWHdKR3UrbjRLdVZUemZiUHdIdm5McWxUYjNx?=
 =?utf-8?B?MFVTSWl0ZitlMWgxRFRZS1l3YnErc1VDN3BjY0wyZVBNUXg4NXpVVVhyV0xk?=
 =?utf-8?B?bzhsWTBPanVSTVRRN3ZTZERMangvQ0t6bENiTE9XRU5EbHYrdHRTdHFnbFpp?=
 =?utf-8?B?dG9aZEZ0TEhESDYrUEFvVjZGamJxaXV5SlFNeGluMG1yUUViKzcvYWNKQzI2?=
 =?utf-8?B?VWVXMUFqK3d0UUNPMzRyV1oyZXN1bnJpak94dVdWZ1c2NUJ3VTBLRlMvRXk2?=
 =?utf-8?B?MmdmSStJL1ErODdQQllGODFRcjM4QUdrdTU4dy94cWFSSXpUNG1kdUNSeXIy?=
 =?utf-8?B?Y2tkeTM0MENLbU9RUElQaktXY1hOS2R6WGswbURkN1R0QTErM0NDY09WWnFh?=
 =?utf-8?B?cm1ZUlNqOTM5RENNbFBSVXkrQThoVEpjSTV0M0xsUTBiUzRmdkJNeTFZQ1hO?=
 =?utf-8?B?YzgwNk16ZU9NME42eFRUZ2NYeFdPMVI5N3V2ZGlTYUx0UU1rMW9BSkJIcmRP?=
 =?utf-8?B?Y3R5cFlhYkVIQkgwQktCYWV0UTc5QVdCZjl6MUVQNnJtaUFGNy92a0hZSXM4?=
 =?utf-8?B?S20yNytYaG5nR0N3aVlQdVNOdHlsZzBpTzFpU2kxQkk5S1lYSXZqQ2dHbU85?=
 =?utf-8?B?U0xiZ2NmbWhzbjJsRnJNWVlyT1QwME1XR0VXbjdzb2pqQjRkbk5uV3FNSDhX?=
 =?utf-8?B?WGRiYTl5eFNwTU8xa1N3aVpuYjlMT1VtdGt1SUltRk1PbnIxQlZXajRRRGkv?=
 =?utf-8?B?aUVxWU4rWWJSaENBaG5vdXF1WFJtZ1dwRUluUCtPMkR0dXRZQ29sNkJIQnhk?=
 =?utf-8?B?bHAvU2pHa3ZOU3NPcTJYSnJnSVJ5dm1JTXhrb2h2Q2lVYVZqa2dKanU1Z3lX?=
 =?utf-8?B?aWgwZitJNU0xYm8xcVVBRUNnZHhkdyt1NGhxSGY2T3pBRTlYRkR3YVBBN3g4?=
 =?utf-8?B?NG1qbFllTHJ0VTdiSVFVOUE2MHJoWVlJN0pUUWVVY1RZMFI4eng0d1pXVlU5?=
 =?utf-8?B?Q0FHdTRNWkFnUlVwSkJuRE8zSjJuTmdqSkFwaVZ0ZGl6eXJrUFZjZ1dtTTRB?=
 =?utf-8?B?Sm9sVFhVbjUwMXVIVDIvNGEzYTBvUVRpWFpEdjduTDB6bTVCTUliUVJjOERR?=
 =?utf-8?B?ZEVQdzRuVklkR01WWFZBTWI1d0ZCbFdZOFJMMFdNa0V1cURacnRheXdnS092?=
 =?utf-8?B?dUFMem5mMjhFSDZ5MHh5SWdFMDI4cnkrMlhtMXR4MWcyZExOUXdBK0NJRVJu?=
 =?utf-8?B?TDVNN3ZiNE1uTmk0K2tFSmRiMUlLZGFpbkhCR3F6UnFHeEd6SGNUbTB1MHBr?=
 =?utf-8?B?bkgyUUNFQ3ljbWF0QlE1VkhkSm10eVh1RUFuQktyb0gyZXlSNlNhcnI0dWIy?=
 =?utf-8?B?QXBBSEpOeFROZ1RCMmVxOHNLd3R5WHc0azVhY2d3d0JoWHA2QURBQmI4REsy?=
 =?utf-8?B?NndpZnFPbERieWR3ZU5xbUVsVFJsL1liR3ZjUExwYlhXN3U1VHBkSUhUY3VH?=
 =?utf-8?B?QlNYZGhzUE44ZDhpdDhRTWlCZFdpcTUvTUFoYWNEZXdHbmQzVFNnR2MzRkd1?=
 =?utf-8?B?alNFUjZXcjBXZTZPVW9ML2ZqRkI1T1VtM0JEbVVrcy80UWoyS00rdWlMbmJv?=
 =?utf-8?Q?lBVTnoH0h+6Rn7cGI5gKYkJHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880e0278-cc4c-4c3d-8a1e-08dcff74f133
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 21:41:30.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAc+bwoUbyKptcdJFxmSQXEIrIY50hMYIq+bEcJDAYTVZmchcf5rLN15dbNyQBA6yZYSg7sS3BVbwQ388QY6MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995

On 11/7/2024 02:34, Armin Wolf wrote:
> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
> 
>> Reading and writing the `profile` sysfs file will use the callbacks for
>> the platform profile handler to read or set the given profile.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v5:
>>   * Drop recovery flow
>>   * Don't get profile before setting (not needed)
>>   * Simplify casting for call to _store_class_profile()
>>   * Only notify legacy interface of changes
>>   * Adjust mutex use
>> ---
>>   drivers/acpi/platform_profile.c | 110 ++++++++++++++++++++++++++++++++
>>   1 file changed, 110 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index 5e0bb91c5f451..35e0e8f666072 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -65,6 +65,62 @@ static int _get_class_choices(struct device *dev, 
>> unsigned long *choices)
>>       return 0;
>>   }
>>
>> +/**
>> + * _store_class_profile - Set the profile for a class device
>> + * @dev: The class device
>> + * @data: The profile to set
>> + */
>> +static int _store_class_profile(struct device *dev, void *data)
>> +{
>> +    struct platform_profile_handler *handler;
>> +    unsigned long choices;
>> +    int *i = (int *)data;
>> +    int err;
>> +
>> +    err = _get_class_choices(dev, &choices);
>> +    if (err)
>> +        return err;
>> +
>> +    lockdep_assert_held(&profile_lock);
>> +    if (!test_bit(*i, &choices))
>> +        return -EOPNOTSUPP;
>> +
>> +    handler = dev_get_drvdata(dev);
>> +    err = handler->profile_set(handler, *i);
>> +    if (err)
>> +        return err;
>> +
>> +    return err ? err : 0;
> 
> Please just return 0 here.
> 
>> +}
>> +
>> +/**
>> + * get_class_profile - Show the current profile for a class device
>> + * @dev: The class device
>> + * @profile: The profile to return
>> + * Return: 0 on success, -errno on failure
>> + */
>> +static int get_class_profile(struct device *dev,
>> +                 enum platform_profile_option *profile)
>> +{
>> +    struct platform_profile_handler *handler;
>> +    enum platform_profile_option val;
>> +    int err;
>> +
>> +    lockdep_assert_held(&profile_lock);
>> +    handler = dev_get_drvdata(dev);
>> +    err = handler->profile_get(handler, &val);
>> +    if (err) {
>> +        pr_err("Failed to get profile for handler %s\n", handler->name);
>> +        return err;
>> +    }
>> +
>> +    if (WARN_ON(val >= PLATFORM_PROFILE_LAST))
>> +        return -EINVAL;
>> +    *profile = val;
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * name_show - Show the name of the profile handler
>>    * @dev: The device
>> @@ -106,12 +162,66 @@ static ssize_t choices_show(struct device *dev,
>>       return _commmon_choices_show(choices, buf);
>>   }
>>
>> +/**
>> + * profile_show - Show the current profile for a class device
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t profile_show(struct device *dev,
>> +                struct device_attribute *attr,
>> +                char *buf)
>> +{
>> +    enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> +    int err;
>> +
>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +        err = get_class_profile(dev, &profile);
>> +        if (err)
>> +            return err;
>> +    }
>> +
>> +    return sysfs_emit(buf, "%s\n", profile_names[profile]);
> 
> AFAIK we do not need to take the mutex here, since querying the current 
> platform profile
> should not change any state.

I think it's still needed, in case someone attempts to unload the driver
at the same time as it's being read.  It's not static information 
because it needs to use the function pointer into the driver to get it.

This will protect from that occurring.

That's the same reason I was thinking name needed protection too.

> 
> Thanks,
> Armin Wolf
> 
>> +}
>> +
>> +/**
>> + * profile_store - Set the profile for a class device
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to read from
>> + * @count: The number of bytes to read
>> + * Return: The number of bytes read
>> + */
>> +static ssize_t profile_store(struct device *dev,
>> +                 struct device_attribute *attr,
>> +                 const char *buf, size_t count)
>> +{
>> +    int i, ret;
>> +
>> +    i = sysfs_match_string(profile_names, buf);
>> +    if (i < 0)
>> +        return -EINVAL;
>> +
>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +        ret = _store_class_profile(dev, &i);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> +
>> +    return count;
>> +}
>> +
>>   static DEVICE_ATTR_RO(name);
>>   static DEVICE_ATTR_RO(choices);
>> +static DEVICE_ATTR_RW(profile);
>>
>>   static struct attribute *profile_attrs[] = {
>>       &dev_attr_name.attr,
>>       &dev_attr_choices.attr,
>> +    &dev_attr_profile.attr,
>>       NULL
>>   };
>>   ATTRIBUTE_GROUPS(profile);


