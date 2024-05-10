Return-Path: <linux-acpi+bounces-5733-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB98C2680
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 16:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4A01F22373
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA7B1311B9;
	Fri, 10 May 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ayoNhS7w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEB12D75A;
	Fri, 10 May 2024 14:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715350509; cv=fail; b=oYGt0ssQRrV0vlNCzjY5g0fZMdXfOFNdGrpQQmiK+5FwCnpijuwikmbL4SOZ6X37rF51iz2FbvO/Q+tmDruGccMJc1w3SzSLs0snZZ3rW0pLqkJodGHYla9LmFk/u2la8IbP+Yfa37nsOuyqoFdB0d+Zi0NKqkGFq0xu2a2qXVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715350509; c=relaxed/simple;
	bh=GPjlDGTcJmXeAWIa2DOs59gB3sjtrFn1QvzviFdhiNE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KJ1PnAYkYS/rce+WtMSAKsDeFlDe17NJgkDsxmKGho9dP3mu6YGaVBQCBtcCvwsQsMRxRm8Nb5TdEILCghw2x3mXooRLxof5mC+2N3M4ZM0qLKMID7qAh+Gkbah8Gb0t2oov6S7+HiQ6bk+TMF6hh9Wj+oja50MHfHpwNyRTpSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ayoNhS7w; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzYvMV2uQmUQtZzKNwLfrnJVduhBmezVLfBAv2EV7iuySIwz9R7WBvPoiXfwQgW/KNs0juanEeQ3Bip1Ok2OQqd95QdX0eDCZc4/2dXvGs7jj7xuSy+MO/NWcJrfKAfkepNybsev9cGMZ2D2fbHVIy648+6gwiLMkXwPjkvKhmOkffKZpoQQwcanOsVe92WLyGsoBml3+n4EuOHnbfG7Sz2jiRjdvTvOUaY4yi1Pzg4thIH0aDnRkJV3cTLkwViAevQ7b+6+arTaUOl+bP4Rilhz4DR6MEhcyAJ4dYWXuOZ0ZZ41FkT+VOD/jnvLBYaIqdm8YPMqvAhumnCh83DrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPp468UdyEjD4OKjIBOWmrQ9EKOW/hs63DIaaTHb0Wk=;
 b=JCP9I74elIkQ9Q2hbOhf3G7mO2siOj2M0xvDaajZYqsBhqcekUW5lsdQjRUSpbf7RAvEt0aK3eam56L9+tJcAjYW+NMSBd/3GX95ciJK9nVWOyF2xvArL7DCvix28lPMVgHmNj837tOaiyEMt9ZLXnaTGSQQK+CGV11CxTnqSuYZ4d4DwnMP+LAC4LRE+NMTwxDyML34vP6/7YjW9bxxSkBqGzC+SFvONdE/E/2GG3BXOkX2vrFA7PxRT+a3wLZ2RY99RTtn6ZDDiSDbdILXeA/mN9CsQNT40OB6cZzYnz0YrxGXKp66fQ6VO+9TuxtZg1FxxKsVeS0JnDUzRToetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPp468UdyEjD4OKjIBOWmrQ9EKOW/hs63DIaaTHb0Wk=;
 b=ayoNhS7wzjhQrusQAf4LZ9Ta67WU/ONOoxBlY5TsEAc0wVJFs7vTGR59BX5DqhyWJ+7QW6vsI1O/1TmOhuee66+RIMjRlRMEq0clFwuzDhZa27LS8GD3nP5Q6lOkEpwI73dzQqMfu0j4OjDfKG146fmrPUWuhhio8/7FN+8vP1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 14:15:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 14:15:02 +0000
Message-ID: <98462246-106b-4b6d-9401-c5fc7fe68bb9@amd.com>
Date: Fri, 10 May 2024 09:15:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Armin Wolf <w_armin@gmx.de>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5787281.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0029.namprd05.prod.outlook.com
 (2603:10b6:803:40::42) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dcb40d5-bd1d-43bd-b708-08dc70fb9561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEhQdmVDV1BDZzk3TFh4QXV3MHI3QitxdHBsZWphZzdtMVUrcmJtNWx0VG5R?=
 =?utf-8?B?OEg0dFkvTHBKYWo2NkUrMnZXRi9TTDhhc2FrK2F0bGY1NWROcGhNOEN4Ty9N?=
 =?utf-8?B?ZS9TSkV0TDZkWnNqb2hLeEp3S2xzMmlYa0NnaGlGeExLZnU4R1psM1BHVjBI?=
 =?utf-8?B?Vyt6QkJGYU5NRURLYmZETkJLUDIzV2FSem00SWpwQVFYc2lRZ2d6V1F3bUdz?=
 =?utf-8?B?N29LSzZqTGlueERkYWlnbWhoZ0NwRTE2L0FEVWtyaEd6M0JGNFYyMUM0Mmpa?=
 =?utf-8?B?ekpBSXB4UkZ4eUxxejJiTDFvVTZSSXJJNWVkejh1ZUxUYTNUY3I3YTZNSDRr?=
 =?utf-8?B?MWVUVjJxOVF2dDdQcnVVRjI0ZGtzaGZJWEFaKzdEMWVNaEFGb0FjV0I4aFlD?=
 =?utf-8?B?MDVpMkQzbnVReFhzbmtnT21uSkxaRkNEeU5sM2haK1hKdUxTTGdVY2tHLy9p?=
 =?utf-8?B?YThlVWZVUGNuZitnb0lRUG9zM1A0aGJPbkFCV3Y5YThKRmorN1hlUEJxOXpJ?=
 =?utf-8?B?dkVrREVZM1owdDAwQ1Z5OE5wWDZ6THZmN0NSak56eG1mMGZodzBtUXVQUVY2?=
 =?utf-8?B?NlQyOVMvSVBHU05mM3hqcFZZNENQSGR0SEhEbTBsYW4za1hPRy9ER0wyanJz?=
 =?utf-8?B?b2dTUmFyZjM4NUJPaWZOQXBvem9HTXYzV2kzNGYyVHZBdERlamdZRDJWZGl5?=
 =?utf-8?B?TW9kLzV0UXhJOVJxWVprb2NxeHJ2SWRUMjBQUndUL3ZpMk9RWFY3QzNpdTZw?=
 =?utf-8?B?KyttLzc3Ym9tNU92NnB5a25Gc3VSUmp1UkIwdSs5a0ExQnBJU0lHV20xUUta?=
 =?utf-8?B?VDhCUWNiOE9SOFJXWE9zZXBGOWVTRlhlaFp4RFhCY25qZHlzTU5VVXlsNFVo?=
 =?utf-8?B?RFk2T2Z6eFZqY3hwZGluTGo5UldkcVEyREt4a1ovMlFmbnNRZUN0OTVkeDF2?=
 =?utf-8?B?M1dMVjE2M1BFYkR6cnRhcWhYOW9WNk5laTlRb3FoTDMxZHVVblJaVi82UXdr?=
 =?utf-8?B?Y3N2VExnM29TYnVXQmFiTUVTZXQ1YTM3RjFhZTJiOG44a1VuWGs4VDZoNDRa?=
 =?utf-8?B?ckpPRUJSRHd5dVNGWDlrOGNrU2VCTFFWdXR4ZUVBVVducGV6UDRQZW1Cd2pC?=
 =?utf-8?B?cHl0LzhZbllMc3ZQZWJyL1RuVU11Z3FBN0txNW1XNkVjS0lCYTBleGl3bTh2?=
 =?utf-8?B?SFV2b3N6SWc3MEJtK0E0SFk4b2VjdUs4eG1ZQWJFOFdrVy84N0kxcEt5Y0Zh?=
 =?utf-8?B?dUMvc3Z0YkxVRjZhSHYyWmJ4ZVk5bTZ3YXFPQk1FWi8wcmwxQUNTS29raUxu?=
 =?utf-8?B?c0FNTDBLUnU2NzJ5aHI0SUg1aDlySWNlUEFoOVdUMCtTenY4SlJoUkRZTEtu?=
 =?utf-8?B?UlFWbzZWNUlUL2FBT0RKOWIwQ3dUVFZwNU0vRHBPLzBqK0g1TkNZSW4rMmdz?=
 =?utf-8?B?Mmh6aHJRMmpQalZJdWVTbXViV096RHp3b29HYThpWEprbDFtTGJGWFZmeGRz?=
 =?utf-8?B?N1dWanI4UVVHU3Ard2NhUnV2QWNlaitjREZOaEp0VjZMR1NBVWxFQVZEbXNL?=
 =?utf-8?B?QzU4L251OHFtRUZpVVVYQmVaMndrYVpNRktBRUlMS1ozOTNSVEUwMEF6UEs3?=
 =?utf-8?B?djdxbnM2bWxMTzVsZ3JJcFVUMjVmcnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SU91SGhQUm5hQjFNeUFtbXZWWmYxNmgveFdvZXh1dG5nSVNqZ0M4NG5Kazhn?=
 =?utf-8?B?RnV0aTYwZ2NpVjRZYmEyK2FCeDFPMUFoUllZeHh6RWxDL25tVWYzREhlK0lG?=
 =?utf-8?B?cUF3dTNJeDhFOHhQUUhDNVFZYjBXMnArVk40c29CVzlIVUIxa0NKckUxVlAy?=
 =?utf-8?B?bUF2Q0phRDJnWG1CTkpVdCs4cWNqMXJaTHFobnBsZmdDYVhvdW5lU2NmWkJT?=
 =?utf-8?B?cXZyT2lmazVkTG1JUXorYndvZFNZM1hTc2dZR0V4T0xtWmxiTWl6cXpKVld1?=
 =?utf-8?B?cWk1VUsxS3ltNVhWRmU1dkdtbmswbmMycXhUanViUjZkQnBKNkYxanc1K2JT?=
 =?utf-8?B?YlRPajMvbjFWcEVrSmYxSFFmVEhoeDdpR3VvNVBPcDhIb2hkcEc2eTVtTFZR?=
 =?utf-8?B?ZThBMnM4dUl5VHdDdW5FOXdDYWRZNld0dXlPSHVTbnZrbmY3VjJOdkFGNW9S?=
 =?utf-8?B?KzBYRnU2a0tBbVdyUlhWMk5VdU1Mc1Zpa0ZFblk2T29GOVdLbzA4T0Z2NXpy?=
 =?utf-8?B?UU1qRFQ2OXora0NFdGxWeTI3TllRUkp2SFN1QnZTMTdPNy9seXJCVy9ZcGRm?=
 =?utf-8?B?dUVtUmw1MlFXMlBIZnM1bUtScXN2Wi9McTFEQ1N5SkhUeWh5N25NeGhQeVMv?=
 =?utf-8?B?WHlsZkt5YzdGN1RxVFhManhyNXhuNGphcmRWQ0xtMU00ZzdUL29yK0tiVlds?=
 =?utf-8?B?WmdyWUVYck8rK2JYSm96T1ZyS1NRS0N1VlNIaVB6TlJpYmx5UitZSkFweWhM?=
 =?utf-8?B?andPRktZUmY1dlFaU2ZRRXdGaDZ0R01QV2xwVlZYY1pkT2gyMkhyVHhkZHRO?=
 =?utf-8?B?SThYSzR0MEo1bXlZLzhMRm1PQ3JOb3U1VjY2dFBJbVA1WjEvVXVTdXpKRUI4?=
 =?utf-8?B?aGR5bzhvaFlyR1NTUmRXQ09VcURYakJhMlB6OTR6TVNxVE1pcjZjc09rT0t1?=
 =?utf-8?B?ZHF1NGlFazZVY2w1a1h4ZGVqakFjbWU5Tjh5RkpleFRzQTY4RDFRTVEzMDl6?=
 =?utf-8?B?T0Ztb2lnTDI2cHZpd1E1OUppNTNEdGlTQW9NYXZBQlByZkpCd3N3RnZlUlZ0?=
 =?utf-8?B?cnJ3Vkp4Nk5CNForR2o5SkJBdzV3NTdTL1haVW9lZ3FYejh1SDFGUnhNYXZF?=
 =?utf-8?B?cTR5M3JGUC9NdHdjV1ZKdnliODFYMm53VDlBR0JDa20wSTJJWFhRVXZORTBV?=
 =?utf-8?B?TWtJMjBQcDlQeGF1c2lKZEh6dGpmdlJTL1JFZW9WUEk5MkRXNmhBSTBRd2g4?=
 =?utf-8?B?ZmlxdnZSdEEvVmJsWVJFbWE2YXFYZmFuRjBPTGQ4WTByWVNTSkJqcHZ3OWM2?=
 =?utf-8?B?cFdpZWdKWjA1SnJDNXBDcmVPTC9XOCt5THNVOWx0WCtuTnJ4TXZOMU8xU0kv?=
 =?utf-8?B?R3orNjJXRjl6U2ZRRklwRXdzSjdJREJWdmhwMjZaMU0raVJyaWtSci8ySVFM?=
 =?utf-8?B?QzBycTdDNnJYSDdnZlpjRmh4ZzlkVTk4Nno4cmtTL0xXUVdBTm8rQ05wNnMz?=
 =?utf-8?B?eHJQSGhTMVNrU3ovT25pSERpd25aaU85bVZqWTFqd0pxak5MWTNkR2kxNUtF?=
 =?utf-8?B?RjZNSHc4V09vQ3RjeGVXUVlYRUZ1d1ZsUG1WcXZpWnJnVHVUczBRSW1tdVpw?=
 =?utf-8?B?YVJTS2wvUGc1MHBIUVlhVmVrMkQ2OXdlNXdwbUdBTmpYbGVLamVYK1drQVRw?=
 =?utf-8?B?Y0hKNHh2WDkwWmNFSUZ5M2htazRXUHduRDJkeVdjZWNXdkVsbk1UVTB1NzRi?=
 =?utf-8?B?YkhqVk81ZmJUZ2ZSZ1ZxdGFsS2lUalI1MXhoT1BFa3ZBbVllbWdwb3hjcUYv?=
 =?utf-8?B?cEIrU3ptTkxNUys5QVdESzFRZThsdG1zTHFrUnY3QWFxSGMrNmM4M3pRVjh0?=
 =?utf-8?B?a1luYjRBTXpDTGNrWFVXc2IzSStCMTNPdU1vYmsraWJwSUlRRXdWRmh2Smox?=
 =?utf-8?B?VGJvVDVlalZzeUpLZndLdkZvRkZ4TmRHN005UlJUNUVaRGtUMDFYYk42Q0Zv?=
 =?utf-8?B?RHgrNUtDb1hubHExcXMyQ0hzUGUramNCd0JsZVVsa0NQRHZxNG1ZZGpuT0xS?=
 =?utf-8?B?ejZLZkdoclY0K3JSZmg2N3hGN1NCNkl4ZWNEZ2NkdUVUVExnSS9HZjFoUEdn?=
 =?utf-8?Q?OnQCQch1s2meYreCPA8SmfYQF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dcb40d5-bd1d-43bd-b708-08dc70fb9561
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 14:15:02.7345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+hESceUVNPDJ4mb9euxLBLOlR1N37uaHjrlTbEXjX2B3B2s2JosZ+cpoDhSC7Dzmu66w2ah3y5kN+PgeYdjRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790

On 5/10/2024 09:01, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This is a follow up for the discussion in:
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRTj7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> 
> Patch [1/2] is a resend of the patch posted in the thread above and patch [2/2]
> removes the custom EC address space handler from the WMI driver as it should
> not be necessary any more.
> 
> Thanks!
> 
> 
> 

For the series:

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

