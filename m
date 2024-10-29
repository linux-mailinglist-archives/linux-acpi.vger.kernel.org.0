Return-Path: <linux-acpi+bounces-9081-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C339B4F59
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87FE21C20DD5
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075E1D5CCD;
	Tue, 29 Oct 2024 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ysoJkgY8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2045.outbound.protection.outlook.com [40.107.96.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5019CC36;
	Tue, 29 Oct 2024 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219523; cv=fail; b=lVs4LKMepsjrMCKD9RGmb4Xw6vnZQnPBnfKWoY6EPBdYK/WJNbZTovcjSxmU+li83PqLbuN58KaGz0caaEcyBOY2iedi/d6YFYXe2teiWBJUHjVaOKqz9FvnU+XmYKWJ6uGnwVcJPdUrQ5DQelHSJCu4/ZclW1/8f85CoALc+/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219523; c=relaxed/simple;
	bh=WTjJkt4lYFrJYyySxt9iQNm2rtX/75LyLkl2Vfr+BWA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ny0McHjwGpVUXJy8HgPF4TjE2Z1607fKeqh2wy0CgQol1m+5/B4cpWunM5WuElSyNiFjFXzam+YhgLwh9Ts8Cm3+NNbaTDiUGh/wDbGY18Fe99ibaLhb154HHcDQwY33H9hkAru5TybO7fNTDLPM87xOyn/4M+8TQGjCf0R0NGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ysoJkgY8; arc=fail smtp.client-ip=40.107.96.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKSiSr1psqrtNKzoUudkKaSujpHmJqihi46XuJFQ24x3C36U4xkQwV5gELcDNc0G82Al7MJ9yE+eCyEHz3xzTV3s7kcmLYvoI/La4wU1gUTOXS5/IHx4HHCy1SSkRzTPcI/v/c6sFTEgud8WlM1mwceVAXXnvCusTXAXmaitoXrw2K/z9L674T2eu0siM/83UJTy8BNIEoiOANfz42pOWyxKND0AVHz5QJwUr1ox/grVrem1ohzPVS17bukv+BIpzLMgeNY/9vfBYKVOdZT+ifz4ar7dRKh4tN2A1B5i/xYvOE6/gxAc+N4y9MUrnT9bzxc8fzDh35fh+kGGPHXS8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSihUxkB74rJaqzNTajs/i9qRvTGH5FxNwnucnBWREM=;
 b=ZMmH/ZiJywW7ELcw661glzOXHPOl6qM1pP0DGG5789ZshhyTiM/9BhIBStm6fXXNb3UtQM/lQsQqGnPkiX0JTzoqpquqws7UXrHsk/0Bs1MpGgoTzuvNVbex7IvcDm/2PiNFzx4EtVUWyTPNsWUlYkGVtmzsZLs9LO7ZSwanWyBBlQsC4k0Kn98yT05rf8/xdylhGrnlPSGQSm+hrIuj9TstS7pg3YNVawDc/kn+bRA61fRr9OqyHZkSW51oFHzIiKYOqepxtJYmOs07fMzkkU0BT0HgCbxFugO8Q1bawFDBqSXSqODzzgkMlYn0J4Nlo/mtMwk0jHWVsbwlYIGOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSihUxkB74rJaqzNTajs/i9qRvTGH5FxNwnucnBWREM=;
 b=ysoJkgY86fPZXi+cGHZb5+UEMn9eYJHCbaGGn/egY5aOan4GsJuM3ttc0NA/h9RQeIqtoSapZ6P6ja+YfVsgYfNdmk99wiFA7A87qmS9XzY68GdFIKAXjSNcNOCjeLwJcpGsIoZCvdAa+71Vn3VP3vXWS0rozkPEqejnyNQyfNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:31:58 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 16:31:58 +0000
Message-ID: <dc256241-2568-4b7c-b2ad-dc27a169ebb7@amd.com>
Date: Tue, 29 Oct 2024 11:31:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] ACPI: platform_profile: Move sanity check out of
 the mutex
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-6-mario.limonciello@amd.com>
 <911429e0-3807-255a-4ab5-d89c6d6ce0d7@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <911429e0-3807-255a-4ab5-d89c6d6ce0d7@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR01CA0019.prod.exchangelabs.com (2603:10b6:805:b6::32)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: e13b53b5-df1c-4bc0-1943-08dcf8373534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZVRzIvOENEd3R1Z2RVVU9tTzdUb3hEZXdWVTc4bFROY2M2TmlzM1NkUGEy?=
 =?utf-8?B?eDIvWXlEcDhVd2htbHdjNk5JaDRoZnNUcjZXQWoyTGI4QXY1QXVvbU9TbGNK?=
 =?utf-8?B?NWpHNGFFODVyNGJldGFDSWhJWVFYS1VLeWdjdkZkT1RtQmpFRG15UXl6dUZo?=
 =?utf-8?B?eitIczBKV0I1OTFTVlhzeWdBei93U1NVT0tnc0ZtUmhOeTRsZy84Z21nMy9a?=
 =?utf-8?B?V3Iyek9KTVpmazU2TjhOaEtzRDhvSS9IMjJaVTVYRFdNNVg0YytTRlRFT0xJ?=
 =?utf-8?B?RXRZeDFzSXRpTGVKVWljREEyTHV2Z3VoRGoxd2hpazJmWEdteWlMOG1LUGw2?=
 =?utf-8?B?YUNscTV5a1l4UFovMmRvUU1jbE1LeXlHS2prQjlWYWFHOGF2SzBQbVFNZThz?=
 =?utf-8?B?VW5mRlRTaUkybU9rbVh2NGlwZmc2QndlS0RNdSttQk4xZlVkcklmRVAxZ3BB?=
 =?utf-8?B?NUwwalpVT2pCODhYczlyTEM1eitTQ1ladHE5bURkT2Ercyt5NEZ1N25UejdM?=
 =?utf-8?B?TDFGVG16WWNEdWcvWXQveG1ZSTRmZjdaR0RjUVhIeFhudlB1Z0VxUFhVYWFp?=
 =?utf-8?B?ZFBNUDluQlpkNC9WU0tUMzFPQ1FvRDczTU9ONW0yVTU2R2h2dG9uMVJEbCtm?=
 =?utf-8?B?OE1ZWXV1SkY3dWxYYkdYVUFjY01EMW9TSENwRTFhZldKN2ZaLy9hcHpCMjND?=
 =?utf-8?B?UWNuTHJ0dUx4VjNHVHozMUQyNlVJS1hWekV0NjFtdjdSSnN4MmthcmZabGZj?=
 =?utf-8?B?eDlsTVZTejJndFJFcUdzNUE1T2tVaHRJeVVFR3NPUDY1djFnb1NHNG9RV05J?=
 =?utf-8?B?WFlVZjNycm5leVFha2pneUV1OVIvL1ozRXFzZUZRbjJRekVITmRSOGpONWpn?=
 =?utf-8?B?dU0waVpxcGNpcUQzOUxqLzlXUjZCbFR0am1YUk1qR2psWTFmZHZNTVdGV1Bw?=
 =?utf-8?B?bEJ6WVMrMHM5c0tYM0V1S0ZvdFZvLzJHdlZMZng1RXZURHJSUE8rYnYvSkkr?=
 =?utf-8?B?OTlob2NxZWswTWZrdjZwZXBwOTFEcTJPMTU3Qy9CaWltQTYrdXhTQkR2MExp?=
 =?utf-8?B?b05tdjNjK2Jwb0x3cVFDQTdCcXRHZS8rMkZyWnRRdUkvcEhJK2JWZ3VxUmUr?=
 =?utf-8?B?Z05PUUhVRzBJckR3TjA0TWU4QVhnYlppTnJjZjNMUG14TXdnOHlCdmE3RnhD?=
 =?utf-8?B?YnVjcFJhYjM2dkR5Wnc4TzlvMHh3R3VsQnlXTmRSMHBvb0YzcDVJWXRvMk1U?=
 =?utf-8?B?dmZmajVtQTcweENEZ21NSzdzbFB6Y09KMDViOGFhWHhpejJXZzNncWlhN1Ns?=
 =?utf-8?B?RXo5L0JHSWdKM0NiQmM4Q1g3MzZHYVRyVE9NTVFDZ1BZM2NWbU5QM2JpUWlG?=
 =?utf-8?B?aEk4YlpFbGRscVNzcGU4OWJtdHFlQlBVSDlsRU9WQWtENjU2eStPaEp5Y1Jo?=
 =?utf-8?B?N0pad0EyRTV6NXgvVW56dCtpL2R5Zm0rMXVzNVBPdmNsSS94Y3gwZmM4cWYr?=
 =?utf-8?B?STZScmVwS3lURzRsT29NRnZTRS9SdUE0ZFdGQWNBWTZPT1RsWGgrN3FwWjZQ?=
 =?utf-8?B?QjhUS05oSGtoZ0NqZWhXVUZ0ei91MytlZXZaaWF3WVlNL3lDZEszQW1abS9L?=
 =?utf-8?B?bmhSOW1RRVNzSEFYKzhGazFoWncra3pmNlk3L2hZdFVBZjdCZHA3T0FJeXNY?=
 =?utf-8?B?czR2TWJwOW1SQjg3TDVkZGx1U0UraHN4VlNLVlFWU2huczJORnVkREpLdm9v?=
 =?utf-8?Q?oXrSqnbUbrOKXOkAE+9V9Fle50GGs/a2J+tWH2c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZROEtwQWFncFVoRmhpd284UDlNUUQvYklCVjBwTkJDdCttdjVKa2hrQTBo?=
 =?utf-8?B?dFFlRE5QUHNHZFZML0FDQmo2VFJ0Ly9SYkZHQTU2MW82TkxBQmY3MW1XVWh3?=
 =?utf-8?B?Q1g1dXc3cE8zYjc4ZHMzdGNSUGhTSVNqdjFRK1FicVFaL25CcWx0UklRdklp?=
 =?utf-8?B?YWlJTno0cGpaZDNKNGk0UVNXOVg4d3I1bUZxNGkyaytFWlowWDV5Wld6T2dT?=
 =?utf-8?B?SkRISWplNWxYV3ltNWhjRlIwMG4vdlVNVFN6em1uNmtFeUQ3dHZvaTU1S2JS?=
 =?utf-8?B?TmxQWFRFOFB3NTE1enFwZFdqdWNPN29xNVJLWW1xSTB2Wi9QRnZMcFhGektG?=
 =?utf-8?B?cmxMTGVZTUhvSzh5L1paK3VRWERNN0Y0OGc5VnlyQStvUk5ZZjFuVC9xQ2Vn?=
 =?utf-8?B?WlhrZXVoMVF0OFNCMVJVa0RwK29aUXlGcVlJWFo2Q0d6dVF3eGJVTHczS0o0?=
 =?utf-8?B?TzRzUFFmbWxzTFZIWCtSbzRUVldxejRWcjQramd3YzljZ2hnRVdtaUtHbWtn?=
 =?utf-8?B?ZzUyODBRbEo1cmRiODVueTYvbldtbFBmelNrNENWUnBSRVFDQWwvaHRsU2hu?=
 =?utf-8?B?NWNETXQ0ajZVcEJqYktObFJMdExOM0JtWXRINjZBemRUNTRlOTI3WDJ5RVpY?=
 =?utf-8?B?M2Y3MHl5bEV2M2dNZTcyVHdjVXNsMnVlUk9nN1RHWGlFdENDbExIc3N2YlV4?=
 =?utf-8?B?dWFRNzJXRFNVcmFRaFFwMlFKVWxseEFPQ21EQ3JDaWVUOGdTb2djbGI5Q2NR?=
 =?utf-8?B?UW9iWEp0TnNLV1VqK1hRb2pIYWp1a0szZWR0UC8xTjZKOEF5Z2hWaTNpSGxm?=
 =?utf-8?B?dWFYNGNZcDhOOUNaLzg2Wjc5cTM4Ry8veG1qWW9SVWh5VTBXbWdna3h6Uks1?=
 =?utf-8?B?Vkh4ck11WnhEK1RGSmtzSDM3SHA0MWJjTW1aWUpob21ldFRPS3FoYkZBWVZm?=
 =?utf-8?B?d25OMVUxYW5oOXhiTnFQK1loZTBaejB5WVFDUDZyc1NlcjdlNVVuSCtlRWp4?=
 =?utf-8?B?aHFScE5KQWttL1dqcm5vcVBqREZpS0xSZHBwaG9nOFR5NTFPQWJUUytaSEtt?=
 =?utf-8?B?bklEWXlYWkQ4UnVEbUZFNUZDUC9tWGExSmRUUTErcE90dVd3QkJPWEpaOUlz?=
 =?utf-8?B?eVhzekt1WmNrc0tqdVNKMjZDT1ZMSUsvSWFCcmNtazdHZStKSkhEdldHSS90?=
 =?utf-8?B?ZGlOMzNIdTIwQmRjOVhoWnRGZEY3aG81N3RHSGI3d2lydWwrcnNMVUZaOXR4?=
 =?utf-8?B?SlJTdVl4cUgyLytqeG5uY25XS2pDNTY0ZVk5UUd3dXl3aXgwcEV0dkxrVkdt?=
 =?utf-8?B?UThWSWJ0b29IOWUxS0ZOZFdCVUxBR0FvWlE0bG9MbnpVRFFqcnRxQ0pTd3kr?=
 =?utf-8?B?S1VxYjZqM3dweVprTVpDZUtJVTJKazZSYzFnSXhXbmRsU25WbzNDRVFPaUtG?=
 =?utf-8?B?MzBEaHhoMGk2a1N6T2Rsc083KzloQ2xwWHJvVThRVkd2MWJoenNjbnpFM2la?=
 =?utf-8?B?R1d0TXpwaTAxajJaamphK0hkMmFGRkN0VGtvdXIzQjdSTWxkKzhzQzdzQWto?=
 =?utf-8?B?b2RMbDE2TVRwZzdTQUg0MzE4bEh3ZWdEbTVFdmZTTGdkbTdLa0ZqeGRwOUZB?=
 =?utf-8?B?akF5Rm1yV0hweW82TU0rN01pMXRsalA1dWJCMURqRG9QTkhJZ3htbjgvQXpZ?=
 =?utf-8?B?M1krd0xCQWtUbWhyM05oVmxpak4wZytRckJOb3ArRUQxMURNRUNMTy9mUXB2?=
 =?utf-8?B?dW5salBDS1djcmlzQU8vUmw1Y0VFbG5ESytNMzlQZHhiVW9HcWFKWk8yNGVE?=
 =?utf-8?B?U0NXU1ZkcExPeVV2Q2FuTFRaS2JtTElqa3RLa05CVWVPNDdRUVRndVoyL21J?=
 =?utf-8?B?S3d6UWF2OFFmL0F2MHBRUlNLY1Fzd2RTV2RBdWUvOXdicnFxUWxvK2txMnRP?=
 =?utf-8?B?VlpDdXBSVWRxQmh5V3dTNDVZbWJHMEJXY29yTEZkQlFXd3h2UThlSUowUWtO?=
 =?utf-8?B?QTNiTUhBeE1OV1NzRG1TRTN2U0tBMHRyWjNLcnA4enM0UDRJcDZtOTRCSW1m?=
 =?utf-8?B?YnFhRFZUbGFjdlUzbm9oQXNMb2dKZWVhdjVWa2dCR3IwUjhya0t0QjkwS05L?=
 =?utf-8?Q?BdQcb35CIS7qjRQuFPMVCHAW7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13b53b5-df1c-4bc0-1943-08dcf8373534
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:31:58.4745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2eCSH8D/brMSltw1+eMPG8GylN5b5pn1MGOhhcVSh0yF7TdLkg8egZlIoL0ExbsWcWKKqw7izYcgrPdbUFNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

On 10/29/2024 05:12, Ilpo Järvinen wrote:
> On Sun, 27 Oct 2024, Mario Limonciello wrote:
> 
>> The sanity check that the platform handler had choices set doesn't
>> need the mutex taken.  Move it to earlier in the registration.
>>
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index 0c60fc970b6e8..c20256bb39579 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -180,6 +180,12 @@ int platform_profile_register(struct platform_profile_handler *pprof)
>>   {
>>   	int err;
>>   
>> +	/* Sanity check the profile handler field are set */
>> +	if (!pprof || bitmap_empty(pprof->choices, PLATFORM_PROFILE_LAST) ||
>> +		!pprof->profile_set || !pprof->profile_get) {
> 
> While moving the line, please change the misleading indentation too
> (you'd have probably done it based on my comment on v1 too but since
> this series has changed things a bit, I'm noting it also against this
> patch).
> 

Ack, thanks!

