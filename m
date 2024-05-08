Return-Path: <linux-acpi+bounces-5664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D6F8C033C
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A99281237
	for <lists+linux-acpi@lfdr.de>; Wed,  8 May 2024 17:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC58C10A25;
	Wed,  8 May 2024 17:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DuUBZqIF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A958E57F
	for <linux-acpi@vger.kernel.org>; Wed,  8 May 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189746; cv=fail; b=PubezzbkeQHl/Wb1hMpY3TrjtvJKRM0LdVFuE3hyG3bP0jOacGwq8ONENJDOD7O+YGJ8cMRiv0Lr0SRrDk82RenbkdAZFQl1op7g+0GfpNXBEtyXsP+daEnuI4OCQ3YDjO9SjFqEAln54+VpJqGFvXoBn8Ws+HzEGrOq22h7WSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189746; c=relaxed/simple;
	bh=JalSBTZteeciDLbzY8Lp0D+iJQR5bmK9myruMJPARTY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=J/T08CKjpt/es7njZxmjuMKfwhxU0LYJL5Ar+mOJG7Z27e2pYOvLqex+ydfHZH1Ibz0UTrm1VeZV/CPjkzEsU5qcqqHlGBkD/cr62LxKuJd8Id/Dq3xBKRdytteesJnxpnXRevc1PXPBJnPB5gj6BoddeEL6Hpb2ChxEXRAP1C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DuUBZqIF; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoeNYf9vg1CadH6XqItH0U9dpMpd0mNUDVO6p4h+WOY8xssKhFfR0a0S5lD9BedUMz4eQRa7veUYSwEhNdNGNUhAUnKMUYNhIT0NsqLxHhIZ1saY32s6AZF9MzV+X5kSkCcENb4EQ6K8aNsiC16s9Kg2WVeJGzfybr6KCAmw/+56Wra1s/nJ4damXBqWPQi6Okp4Xe7J7n71299LhvJi+KnAiyNZmHukoPQ8BbBIUjwrnjiiNeNCVW7us7cDMb/LCXSz7XfuUQLQyxIegB9S4EVdFKBwJWUvftjnYE6WcKnqaFOz5n31mXefl7+APNw7SusqdRRdswlqVucGh2l1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGMfcTjqKupz+sUzdyG/PqkzRJ9kCFfI0qIaND7h/Bk=;
 b=maMsiLUWroddrBTGTasqBsscvMtLOH4AK3/+5oS+BwkrxpGDdfi9uJZBMohh6KKhOGiAeO6Y3wSPAOQDX+PDVRbcxkGlGZUAn+uajz9qaU2wdFHmoOQGmHJ88wETAvodyp4Iy8tKB1xGibnxwhkY86FREcFDDYLixk2uoTRcLzWJoHiRkQI1GnIE6J7FexuhY7RifkEHEfqfhGl4bsuIWdH5I6P43AD4vEV+xiBsvYvXi5/IZEWPZBMT+MyiKuRvxAOs9M4CLjD0x6goouQUyB//Ruf9KQIaJ4RcjowatC+kJvXE0QdiomDjFBVi7bg6XngNW14/++a5K2F/Izf7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGMfcTjqKupz+sUzdyG/PqkzRJ9kCFfI0qIaND7h/Bk=;
 b=DuUBZqIF0z98P3weIzqkhf4cdp+jyh88irWH6RIBIC0fHXrZsb96fobbnPOT8GZ8eCCiISLKk3rG4cwsVHIGfupCMtZq0IL498hjiHs0V0Umm3pGgWbhk2F3fMjYqxBvY8Ks+LKqfPvAFP1GnE+VIfxaV9E9LyxyCzN9P+FnfrU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6095.namprd12.prod.outlook.com (2603:10b6:8:9c::19) by
 PH0PR12MB8150.namprd12.prod.outlook.com (2603:10b6:510:293::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 17:35:36 +0000
Received: from DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f89f:6d2f:47d1:3893]) by DS7PR12MB6095.namprd12.prod.outlook.com
 ([fe80::f89f:6d2f:47d1:3893%5]) with mapi id 15.20.7544.045; Wed, 8 May 2024
 17:35:36 +0000
Message-ID: <3ebae911-a9aa-4bc1-b0bf-2347b0d27b92@amd.com>
Date: Wed, 8 May 2024 12:35:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Hans de Goede <hdegoede@redhat.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5781917.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:5:40::25) To DS7PR12MB6095.namprd12.prod.outlook.com
 (2603:10b6:8:9c::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6095:EE_|PH0PR12MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: ba459231-dcf5-4267-e580-08dc6f854567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THFxT29RZmI0MmFwVHJzNUh0WHhIWlk2RitJNXFNamM2YmZUc3crOXdOTVNr?=
 =?utf-8?B?eTVBUE1qYnRKc3hueWVHamZZL1dzZzNSa0xodEpLbkNxL24zeWJrUVFxenBn?=
 =?utf-8?B?bmUxdEhsdE02Qk81ZEFLak9YNzhHZDBEdFJ5R29wRVE2dHlFd2FrQ2hzRGRV?=
 =?utf-8?B?ejZYQWhPRVB5a0xHd0M5dEVZZFZFd0F2UHd2M2RLZi9wSlp2cmxaZ2VwWTAz?=
 =?utf-8?B?eW8yWmZsOWlIcUx6ejhvZHB5Qlo0c09IN09GUFBxMFZMWVNadnBVc2hBYnlP?=
 =?utf-8?B?c3VWamE0RTZpUXNra2NzUm5UTlBzQWxjT0FBUnNteE5DbUFodW9PellNbXEv?=
 =?utf-8?B?MDRWNkQweXNWcTB1VmgyN2hraDcvNk9xZERCdFNXZGIvN0JUSTBpSmJwQzBF?=
 =?utf-8?B?MGVkY2hQUkRlYkF2cWZUS3l2R3NnclcxMUJTTnMzRUpQSnN6Y01uNDBveW9U?=
 =?utf-8?B?UFdDYXVzZ1F5OUVhNS9GckxiaW1yazVNZkVPOG4vMXJSQmhseXNqL0V0Umcx?=
 =?utf-8?B?d3k4clNiTno5bHoxSUxVWHFhTGc2aGxaMWFDOXRLM1MxWk9BMHo0aDdtM1la?=
 =?utf-8?B?SlRBT205bFlFMUtXVEF1QmtjU0dhNkpUT1kvYkNHSi9jbnBEbW5lU2lMRWhE?=
 =?utf-8?B?bGJCVkZUNXJIRjkxOUxHTGhKREJxc3YzSVg4Rm5nUjc0RkplUEV2cGRhU2NT?=
 =?utf-8?B?ZFZDNER3cXZTQnFsN0FnR1hsNkpmWUg4ZkxhdVl6Zjc4NFNkcWVKNXhMUnVH?=
 =?utf-8?B?NUE4dmhyMzdjWW1wUEVoYU4xbHJFcWJ5RHcvRkRoWjJwQTNyRHo2YWlpNVU3?=
 =?utf-8?B?NzcySTFLYzFnYWV3ZURnSDhDMWFrdHRyQy9kM2RpYTJUQUNEZG5QWnFmb2xZ?=
 =?utf-8?B?ZWhpKzZFam1xc2pXNU1jR3liSFI0REd6Z3kybHVZWjc0UVNjbWlmUkNkN2dH?=
 =?utf-8?B?ZVRMTGRBVWVJVWFzOG1qVXgxU1NJbWcwRGdjRWd4QU1CUFVpRmRDQllselVE?=
 =?utf-8?B?bXltT0RaT2ViRERXMVQrSG5tZ01Cb0M1ZnFmQXNvNmVndUpmbmFnRFAyUFIx?=
 =?utf-8?B?UXprVlRHaSs0YnJpais5WWdmSjlFM1hRWFllWnlqSm4ya1paSFk4VUtIRkl0?=
 =?utf-8?B?UHZQWnRoL09FRCtSNEh6WjRMY1B3L21iUi9yV3NDMXdnc2ZOMERnMW9JMnpr?=
 =?utf-8?B?MGtnM1FhKzl3dTNqemRWcHo2bXBoN2trMC8vL2l3Y1hsSFJ1K1J5T2NXZ2Vt?=
 =?utf-8?B?ZnA5TG44RW5SQ0NTZ1dhQUtYNWNDclpTd2txcjRpWmpIanArTXZQdlBFVko0?=
 =?utf-8?B?WmpsQWQrLzVHcWpneTZHL1NzQlZpZFdjdGUxOVozOHJlWndBNVpmV0w1QU50?=
 =?utf-8?B?ZllZcGd1dEVIZWpOa1JYTnErSjRmMVI4TkhyYUIydnVtNTh0bFM2dFFmM3Ur?=
 =?utf-8?B?bWNFSmlPTFcyMWI5dXMyRGptQ1BiaUZSRzM4cVNHQUhsODZsUEYzSEx2Qnoy?=
 =?utf-8?B?aU1vbXpQNmkwaTY3RXRnV3V5UVA5QmQwSVRJTWY3NlNkVEVySHh6eTI0eUVP?=
 =?utf-8?B?R2dVRFZnLzdWV1R6SE0yWWwwQ0dycE1FcDV6djhwZy9tV1AxRml3Tkd1NDJy?=
 =?utf-8?B?bUdFTjR4WlVpZk9xMUxSSXVQa0R4MGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6095.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlBSbEFjdU9ybTIyazRnVE1sMUw0dEFsSG51ZUlHZElqZzNualZEWCtTdlhL?=
 =?utf-8?B?cGJkcnU0RS9yaTdxS3ZEOG80VVRxNDZxQktLL2EvQWxTditseGNOQkhtZVdF?=
 =?utf-8?B?STdYRkVXOW5Sb0RTb2tiUUpVSlBSQ1RvQjVRMnNDRUlPVTJSZjFCcWV6TDd5?=
 =?utf-8?B?TVRxRVNPdDQ4NjN1OTZkYWdjd0JraDZ3SDJqa21GY3ZQc2pQaWJUaytUS3Yw?=
 =?utf-8?B?WElhajl3aDRmbHZrVVk1OFBNY2ZjS0RNcjgwbGc5VmozNXdpZFVBS0xObWs4?=
 =?utf-8?B?TE9sa05sL0lvcDVOb2hMaUUydTcvMElyTkczdHEzb3B3N2JYRFZwM2NmRTA3?=
 =?utf-8?B?d1Y2SEk1SGY5OXBWcmpJajRYdnBObyt5TW1tZUpPOVlRdHVuRTF1cHNacnpO?=
 =?utf-8?B?WFcvN0RqM2RyNFdQdEtNRk5JTzBmV0h1dlpQZTd5S2dEYUdyWEpGWUZBQ0hQ?=
 =?utf-8?B?bXp3eW9CSmtvdktvN0huYndmODQ3OEtEMGcwS3NhcDZSUUNlQ0tiV1FEMldl?=
 =?utf-8?B?YzU3Z2JWbFhMUkhISW5kZW55VjRrbnBFSkNDc0hQVkVIZVc3Y1hQVFNnRUV3?=
 =?utf-8?B?Y0UveEVUREJNc0VrNE9UaWh3Zmk3UlhPREdFOENTNUJ4Q2t3QkFtN1BocjMr?=
 =?utf-8?B?aVJxZU1CM05RUzJsTEV3NkpRUU56NXZtSUxweFR2QUp5VCt5ODVYeVRhcllC?=
 =?utf-8?B?bDJXVHczTUt4b1IzVVI3cFFhalN4eXdMa0F1S1UxNFFrSXFnYkhxNWJ2NWxo?=
 =?utf-8?B?Ums3cUY0SDNlTXd4SktoVDNTSWNDa3ZLTUYwVCs4a2JNT2d2QzNoallMb0Zn?=
 =?utf-8?B?bWpkSVY2V3pzbE94U3VqbUZtR0dWWEtCcFFwUml5WXduWnBTeDFoVjZGRld5?=
 =?utf-8?B?cFppRHhQOHMxemVYUnRocVprOUJqNENrY05Ja3QyNGFyYzlab3FlRTd6Q0Jr?=
 =?utf-8?B?QWdkTDh4bzBIUzZBeDhhNmFJUjF1aWpzcHdyczFFVW9CUW5HYzFyMC8zUlYv?=
 =?utf-8?B?OFpCUWsvWCs3bE5WSTBSWTUyWHFibHNNNjFwUE1OS3cxRUhNUmRqRExUTWVa?=
 =?utf-8?B?N3RaK3RZSzhrU3kyL1RZczJ0ZXMxWE9lN05JK1VZeWZmMUpzVlJpbC9IaDRM?=
 =?utf-8?B?SjNnay9TZmVqbHJTSWpiRTR2USs4N0Jzam1xK3EzczdaZmJBUmRaem1xeWV6?=
 =?utf-8?B?K1JneTBHNkkxb3BJNFdoeGIvZzZTa01hdFlrZCtTYXAvWVFhK28xNThKNWVj?=
 =?utf-8?B?NHY2UW1mb2FiWFhvQzBzTVNJTTZkYjJ1Zmxwd1hkR1JMZlpxWG9JVlMyT0dK?=
 =?utf-8?B?Ui9PcEttcDFTK0c2Uit4V2c4VTdjM1FCeVBpMGR0OFVHYjN3Zlp2Y3A3KytD?=
 =?utf-8?B?TW5UbFdJUmJYZ3FlWW5heEJ2MitrRWpGN0xxQlM4Qm5iZXBLMDFYVDExVzh0?=
 =?utf-8?B?NDlJampPamtwaExqTm1pSXhDZ3VmcGl1WDI0ME16cFFBWXpsQXVLOFEyODNV?=
 =?utf-8?B?b0hlbkpTN1h3RXI4MFJOOGpXRnBuK1ZPNDVhMkthVVdtUldIaU5uRFFOMkRU?=
 =?utf-8?B?WWNUK2QwNzdaWDdGeFpIZGRPYnI5NXp4dHJqUFNSeGNNL3RyK3RUWWZUYnVD?=
 =?utf-8?B?T2kwcHhJTnQ2K25MM0pFamNJNER5NEw3ZytEemtWUDRUcVd5T0UxWGtlUEds?=
 =?utf-8?B?cUtLMktpNVc1clZEeW9TMkIrY0h3c2RxcWU4UFpWQlAyWWFoYlY0ZTV0L054?=
 =?utf-8?B?OFNSUWRMajRhRlN5YUN3SElPUXRvZGJaSHp3cGVVcngxRWlUTzhET0ZYOXN6?=
 =?utf-8?B?dXFVcEJZYzRjdnZNWnpld0hBUFVwK25xdUtSU0lqbDhOaitZMUtWeXd4NlZj?=
 =?utf-8?B?YmFLRUJoWGdGS3ZZb3hqQUVIdlMrc2RPdm1JVy9GdTZGcHJnbDQ2Y1liMFRJ?=
 =?utf-8?B?Um1tOGtnVFFabGF1MXVzQTcvVS8wbGhubExQdFNzRTJmUGNFNk9hL0IycERm?=
 =?utf-8?B?cWNvZmZhb2s2eFp3Q0ZwWDN0MTJxTitVY0lydFFCcUdKeFVwZWgxS1AvMzcx?=
 =?utf-8?B?UGpRSkJ6d3ZFSlZueWY3Z0lTNzBnTWoxQk1ab1IvNEZ5RTEyekpQdHhXdmxJ?=
 =?utf-8?Q?sx6HHAgt2ul5HVQJpg9tRa9Kt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba459231-dcf5-4267-e580-08dc6f854567
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6095.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:35:36.6527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf1DYidox3jTAdMld8nu0p0Qx9KoE8e1f6aubIpT4GCnvcz8YCW6smEoNBJf4ZMsEQ18TT6ytmj40gijEsMRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8150

On 5/8/2024 07:50, Rafael J. Wysocki wrote:
> [Resending because it appears to have got lost, sorry for duplicates.]
> 
> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
>> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> On Mon, Apr 29, 2024 at 4:55 PM Heikki Krogerus
>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>
>>>> Hi,
>>>>
>>>> There's a bug that is caused by an EmbeddedControl OpRegion which is
>>>> declared inside the scope of a specific USB Type-C device (PNP0CA0):
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218789
>>>
>>> And in this bug you are essentially proposing to install the EC
>>> OpRegion handler at the namespace root instead of the EC device.
>>>
>>> This sounds reasonable, although AFAICS this is a matter of modifying
>>> the EC driver (before the EC OpRegion handler is installed by the EC
>>> drvier, ACPICA has no way to handle EC address space accesses anyway).
>>>
>>>> It looks like that's not the only case where that OpRegion ID is used
>>>> outside of the EC device scope. There is at least one driver in Linux
>>>> Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
>>>> for the EmbeddedControl OpRegion, and based on a quick search, the
>>>> problem "Region EmbeddedControl (ID=3) has no handler" has happened
>>>> with some other devices too.
>>>
>>> AFAICS, installing the EC address space handler at the EC device
>>> object itself is not based on any sound technical arguments, it's just
>>> been always done this way in Linux.  It's quite possible that the EC
>>> address space handler should have been installed at the namespace root
>>> from the outset.
>>
>> Okay, thank you for the explanation. So can we simply change it like
>> this (I may have still misunderstood something)?
> 
> Roughly speaking, yes, but it is missing an analogous change around
> the removal.
> 
> Please see the appended patch (which I have created independently in
> the meantime).  It doesn't break stuff for me and Andy points out that
> there are examples of EmbeddedControl OpRegions outside the EC device
> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
> 
> So I think that this change can be made relatively safely (but adding Hans and
> Mario to the CC in case they know something that might be broken by it).

Nothing jumps out at me, it looks like a good way to handle this issue.

> 
> 
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index 02255795b800..6b9dd27171ee 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>   
>>          if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>                  acpi_ec_enter_noirq(ec);
>> -               status = acpi_install_address_space_handler_no_reg(ec->handle,
>> +               status = acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
>>                                                                     ACPI_ADR_SPACE_EC,
>>                                                                     &acpi_ec_space_handler,
>>                                                                     NULL, ec);
>> @@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *ec, struct acpi_device *device,
>>                          return -ENODEV;
>>                  }
>>                  set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>> -               ec->address_space_handler_holder = ec->handle;
>> +               ec->address_space_handler_holder = ACPI_ROOT_OBJECT;
>>          }
>>   
>>          if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>>
> 
> ---
>   drivers/acpi/ec.c       |   10 +++++-----
>   drivers/acpi/internal.h |    1 -
>   2 files changed, 5 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
>   
>   	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		acpi_ec_enter_noirq(ec);
> -		status = acpi_install_address_space_handler_no_reg(ec->handle,
> +		status = acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJECT,
>   								   ACPI_ADR_SPACE_EC,
>   								   &acpi_ec_space_handler,
>   								   NULL, ec);
> @@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
>   			return -ENODEV;
>   		}
>   		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
> -		ec->address_space_handler_holder = ec->handle;
>   	}
>   
>   	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
> -		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
> +		acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE_EC);
>   		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>   	}
>   
> @@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
>   {
>   	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>   		if (ACPI_FAILURE(acpi_remove_address_space_handler(
> -					ec->address_space_handler_holder,
> -					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
> +						ACPI_ROOT_OBJECT,
> +						ACPI_ADR_SPACE_EC,
> +						&acpi_ec_space_handler)))
>   			pr_err("failed to remove space handler\n");
>   		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>   	}
> Index: linux-pm/drivers/acpi/internal.h
> ===================================================================
> --- linux-pm.orig/drivers/acpi/internal.h
> +++ linux-pm/drivers/acpi/internal.h
> @@ -186,7 +186,6 @@ enum acpi_ec_event_state {
>   
>   struct acpi_ec {
>   	acpi_handle handle;
> -	acpi_handle address_space_handler_holder;
>   	int gpe;
>   	int irq;
>   	unsigned long command_addr;
> 
> 


