Return-Path: <linux-acpi+bounces-4000-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF386B1BC
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 15:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631AD28904F
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 14:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F94B1586EF;
	Wed, 28 Feb 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XRymuLhx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779F01586E9;
	Wed, 28 Feb 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130547; cv=fail; b=lgOQirkacH+o3ueoxdrLI/vEsyzpMG40NDV4n+TEIqdGLKcWamZQpNMuFXnDK/tZS5hSUL+OJCWdV33AdJRUK7RQsuU3cKVKpfrxGZH2/avRr4ccAnJim5hvYTtCvfT2+rcyvqjzEX4jIZvjA4P4ue4UuMSwQS5Z/FBFeahf5cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130547; c=relaxed/simple;
	bh=hArlDOfReyoMTkj7nB+U4abS3LUNU0gT/plVHoLVaaE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B7+eQQnZPNsODOT6lmeaDbdoE0ACvI5z+GGZ/Xs9n6ESgfRUMTkKL6/F+Fgfkp/ycG9SeFkwSsGEAcDbL1zeF9UUodXFf73y/1Qaa0ETom2meeaYvv0CV2ipQxmo3Pd0Qa/wZMhIufxoNN9SrHFeQQgjvYCbRgPfRVSPvRZg4ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XRymuLhx; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1/GUbxTP/pnML2tZhZwbCpkLEEiYkeFcdmR/JMtoMymNRoIUDu+m6ThL+cbrpsajf8XsCB2rBnrtiXksGyQJbiVNDS1Ym9hOF0EGKWEP/2kWRwVt+BTqy/Fq/IVfAjXmQ2RHBracP9ROH08fFrDm//IV94aO7QRcKF0vjCx5zLj2Bh96gGTiKutd3GEY6b1jURY+9j1sLuqcEz5+YVvToNqa0JPE0LD2AARUf+J2iNSxyHa1lQ2jzvHhZMmI19IJnn7VCX+ewlO18WH9AZbf7xq7YEr/wsTxoz4jvro66l/UJh3yyjOSA2fSpEr1lia04n0pHKB69MMizsKjxplpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcv94JxpeA8/h+otc75zixMzk1vukZqsvN/OvxUSk4g=;
 b=YChMupjcTY/cp/UaCjvWwi/z4R4fRIWJrmXxvoH/OA6W//zK3fzs/Fi3T7c/hu5nHAW/BG/ngNTpd0uYU3NQMg0uFGNEaOwdgJxVDe68lw+RqTdCZ03F7o1pyj4lY1y4VTmHFe6wAK7s3Yeq41yHsNVO2ekwFEQfQSGiVOEc128isFwvm9hNXrQXMbQ76/CD2GUXBo8X3Sm17xts+5RA4Bn03w/QILPQ5zh3FsKPTPLyu9M5suu/VGGMrcK6EJ6IK7sbw+Uj9awKuPVCd42uZ3hSfYEY3QD7kgPzcwxEcgz6Q2L3w5Rthy6HFMQpElYyJnm08CKwZFIGgrpY5k6mow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcv94JxpeA8/h+otc75zixMzk1vukZqsvN/OvxUSk4g=;
 b=XRymuLhxu9zl6LqieOwpUMCEZdJbGGh4fA9XJuifdY0ytcgbQkejv9enPSIPdQpkn5sBSw8cxekga/H7V3irhusjfjXxZig2LHVjxOgtk0l86/pO4CjPkBr3PTrk7Nv+MIQUDozdl/gSE6xGIrOzm8Btzz9hD1tEOV2ezRpgFhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 14:29:03 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 14:29:03 +0000
Message-ID: <0dd41494-e577-4d5c-b1e3-a6d079fed12c@amd.com>
Date: Wed, 28 Feb 2024 08:28:58 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
 <65deccdba845c_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65deccdba845c_3651e294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0662.namprd03.prod.outlook.com
 (2603:10b6:408:10e::7) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: ca520077-565f-41f3-9faf-08dc38699cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EVF+cFsH9aeVOcfKr2WksuQQiGTIkwNc3kGH+C2aWf/kgGVtvQ+dIeU0+JQaTonNJRFxPj2t7w5E4shiNpG/+NMJHbW9tL3XWmGVkOE2eBIwA9UBlslOLexeNOgX8Y5tYQ96ywETQPXdQlMjav58nfX+aNkrCFM2tPSzP1RobqWPcBFK2fY5AhxAhH3GYadwSSCiZ8ges5TpL8MRwTBtNkL3l7ZUm8C/Jfxk8J915Rs8EJvbgOBieMWiihHGMTZ57j+71ucVxVNzuG6C6j8jK33dC2Evc5u9/96SEJCvJ2lUKhgti0ajr6F51h52FQn+jlf9+U2RmZ4bbfbOaReVn5UNEDYgKSPEay4tRsGsdgIz91at8fX4HMriG0wYjWGphcElwF/ooMfooq60F2s3XJqKmaq8ri2yFdHkqAOtwacY2ZUMRLZoDJ5D961/PVaKwdU4+6IdUfkrkXvgcLg/6jDDeWKyRQm1kMcIC/VoiWk/hTaoIKG6HhC0RRS+nUV8p4hDPZeVXqwEmx8kPXoUsRacEWZ8AdTwI3R01sVW+dGXoSShoUIrnIkEJ9ssGJq+sfkB8hSGcZqOdXB37GVta2Q44nWgww4j6m+U8YPGWroGk4whRQP5ZcedTUuNCfXbMkemxvFnztAo6CFxoH2ydg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFdtR054bllIUTl2eDUzb2dSUDNDZS9tZ3hTSFFUbnYxK3pZTXE2cmZlakxh?=
 =?utf-8?B?UWJZeC9Ra2NwOTN2bno5bDgrVU5Qb0sxK2Y3M2hTTHlicmdpWDYvQWRFZXB0?=
 =?utf-8?B?b3dJYU5NZUZDMlc5ZVhOeDUycGNtZzBwb3pvU3VZWkN2d2Rad1k4YlJqeFpk?=
 =?utf-8?B?ZTlqOG5uL0o1MUQ0NXRpaHh6eitEUHVVbmhTREY1RmpJRkJkTzFYQldTbHd1?=
 =?utf-8?B?UlgxK1lVanVObk4wRXJ5WGZlUy9lQ0tkb1ZTYzJmd1FCTUgvMmdLdFU1QVdS?=
 =?utf-8?B?SDVqbFVGMUdqdFhaRHFWNlZSZTlnem9IQTZpUWYvdFA4L0dUOStXK1JuYUNi?=
 =?utf-8?B?ZmU4Y2k0c0o4RFdYbjlFRE12RnZJeHVJUE5OUkU2Y0JZN2E2NEpVOWl2aUw2?=
 =?utf-8?B?SWxxVFJsdmJHazJJQ3M5bGVvcFI3NDdvNHIzcjRjeXNVUWd6SzV4b2lxMXNU?=
 =?utf-8?B?ZDRIU1lEZU5QbG5qdEJXWGFmSXdkSzNqMkg0ekhhelFzeXhCWm5ROFgzUDVF?=
 =?utf-8?B?OGhrZTlONXpoQjNVK21VZy9TODcrd0NxbytoOU1ZTUtYZDlXTnhCRkVtbmpL?=
 =?utf-8?B?L2ViN29YMncvSk51Um9reERGRkNZMjEvS1phK1VjQkJXc1pFR1R0dUVEUGw0?=
 =?utf-8?B?bS8yUDRJYk9OelVxUElHTEd4aVJvMVNsWmdLbldEUUpiOFh3bThsRFAvTEZj?=
 =?utf-8?B?UjdKZ0ZuaHlkaFM5dUo2TnlRanMvVjBROVJITkZ3QThkcnBPQW5QcnJWRCtj?=
 =?utf-8?B?eERpMVlrMmd3RFJCeHhka2tPNnRjT0xBb2ZZWU9xNHNzbEdhV05kTG9yRHlP?=
 =?utf-8?B?cjVock96eGhVVU5HQThsOHVJVkJHcXhGWSsvQ2lFRy9KS2NUcEZyL1Vob3g0?=
 =?utf-8?B?SlFpZENFY3FNRGF0b1J6OFo2T3dWZ051czlNSitUZnlNZnVjcDh5MjA1SUpv?=
 =?utf-8?B?dHRUcVNRSmVDWjJxQ1VlaU1OQlVzTFdZdkJFcTdubW5PZlc1UzdLV0pyR29u?=
 =?utf-8?B?SWw2cUN2QXZLY3JBVEh5cVV1TWwrcEFTRGgyS3ROaGtmWWpoQkhFY3hNK0I2?=
 =?utf-8?B?SEgvQWNYSGdOVDY5anZWVXBBdjZsWVB6enFYNDFtc1U5ZlhaUkZOTlYyQU9x?=
 =?utf-8?B?THRDUXdHL0Mra001eXEvckZaMG0zdEgwZSsrYlV3akhYOW1WQ0ZxY1VFYnk5?=
 =?utf-8?B?WkVKb0hyQTFPUllZRDB5azhEMlNmMG05MTFvY0VadjVaZi9lelRjcHV3dUdT?=
 =?utf-8?B?UVNXVDJOTUlwcnFuVzFrUU8xSE5KYXpVNFhuQ2d3ME9HdW84aXBnS05VVHdS?=
 =?utf-8?B?alRLazZ5S2lLdXo2OW9meXozcUpBVzVpL1pXQjNya1QzR3pkUURFb3R1ckYy?=
 =?utf-8?B?UXROeFRLZDVKeXRkRHhCUkdrendXZVE3REN4bmJNSEg2dmEvT3lvTXdTNlUy?=
 =?utf-8?B?Y0tYckZzc0FIUE5qOCs5L28wVnZWN0xNK1hzZnhYYlA2R2VObGlHQ1A0dHhk?=
 =?utf-8?B?eitnQW5pSGRtSEFpcit1dXU0OVRFNHAxWE55aHZtdEFHb0xjemVhOG95QjNI?=
 =?utf-8?B?eWRyczVwc3lFbi93NDNFb1pBTE1mU1k4QjN1a0JTSDdWMWRqbWorTGwwRDRa?=
 =?utf-8?B?T0hieWhZT0IzRlhrMkNvQTh0eTJ4TEQ1bXZqU2psbUFhSEFhdmJ0ejhqNm1x?=
 =?utf-8?B?Q2I1N216UXA0RXlJb3J1dzJHd3liV005WEFmdkNhMk1MdWJBbGNxUk95d0g3?=
 =?utf-8?B?VGNzM2tUQ1FRUWdIL2tUSlFkYXB1TUhDdE5pNlIrTTgyZlhRM3ZlQmpWOHh1?=
 =?utf-8?B?d1M5RmdSSzVicUFnRmlBc3RDSXcxam1yQ1hwUTNzeUhIZkV4ZDdjWUY2UFQ2?=
 =?utf-8?B?MzU0UU4vRXJreFRLWnV6ak9qcHpGL21lQ0NKV2pCWGg2R3JMaHRrOW0xUndw?=
 =?utf-8?B?aER3SGhJNXpZT3Zvd3VMSVcwR1NsMjJ4RmNyZ0x4R2hVa0FCWDhtM2FIMVcz?=
 =?utf-8?B?ZmdqWFd6YnFRRG1jS0xQRE1UQXlHSkZFTnZRRTVDVnNRZHM0a2QwcENKQlF4?=
 =?utf-8?B?QnF2YVErVmw5N2ZVckVlSzJvek1GdFlPMEcxMTZhclUwc3F2ZDQvZnJKNnRT?=
 =?utf-8?Q?kSBtJBG3+NU/N3b0euSf7j4A+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca520077-565f-41f3-9faf-08dc38699cc7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:29:03.4007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEfoO26J9PKXWWo4pj3mFyXrcK+Oi3AtolPBakS7zt3KOz97K8veJf4eNM6na4DeqMalFm6WO8b3NJjSuQpWAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913



On 2/28/24 12:04 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> This patch had an outdated commit message, so here's the patch with an updated description.
>>
>> I also realized that I was wrong about letting CXL 2.0+ error types (discussed a revision
>> or two ago) and I wasn't actually letting them through. I've went ahead and added
>> the ability to inject CXL 2.0+ error through the legacy interface. This pretty
>> much amounts to returning an error for CXL 1.0/1.1 injection types in einj_error_inject()
>> and instead routing them through a new einj_cxl_rch_error_inject() function called
>> in einj-cxl.c
>>
>> If this change is too big I can send in another revision, I just wanted to avoid
>> spamming the list(s).
> 
> The thing to avoid is sending too many versions too quickly, and making
> sure that upstream can reassemble the set with minimal effort. In this
> case now that I have a few review comments and the fact that b4 likely
> has no chance at assembling this correctly I would go ahead and fixup
> those comments for a v15.

Alright that makes sense. I'll put together a v15 and send it out later this week/early
next week.

Thanks,
Ben

