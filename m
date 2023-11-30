Return-Path: <linux-acpi+bounces-2041-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F37FFCCA
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 21:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE5D281762
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E865A0E5
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Nov 2023 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EqGrsYhU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6003A19B1;
	Thu, 30 Nov 2023 12:31:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmNKDZCsEcQBeS3524ga/ujrKA8Xx2uYw/aTzsHrBocmzyTec00c/go0VNaxvbiDeFPzjMTzf3pwjQu4J2Y62KwDQi+lNiSWNidwK5wDeExynToqqYokdCVwlOsao9qSJEh5R4KZh7IXmkZJbwV+I174Zxv2NQWOQYcgw+ILaRtwoocf2fnZtqu/CVzIV7+WEsJpDrxDD113zwun0L8wqUdGfmA2a4ITTH07gz4ncZbLe7LTiEgJf0rM53AofLqbSB31NcMmaO+qYOo9YuZk4WelFfbLBk51BjXUxUjXX+kONAWwiTGtLnN9AuvvahslBumAP+4d6H7M3Qeh6r4cJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ITSOlfXBUuXR+GLnLv8rwy4XV7dMyDT/OtN/ZBtYGG8=;
 b=G/sMcywjeitxwa96LF8RYOV9LUx518WWugjW3peCCzKpWZ8BikxQlk/4L1Q1POMSRhlY2lHbUkp13ZRNBi9ZZQ3dmppRe8ToLdWcsMh9l6HeSKr03UI5Rd39L7SpM0sx07yv8+pb28yG7TWnrkhq+K+8E1DkVisA9ZRcxc9c9rxmoTndn1PWGZbbYjucy1KMJxrG1IqpAuHueFO9ZU4PKhqXIAvPq9E8F+NV4ZGAYi+LmQAyFrLViUaZRkroBkn5KSskIQlKwDnERm5Juyr3nM6TeQVLLFBmdeobDLx95XyYQfQxNXbM32mjpdUvBQtvAwIHNCEtQ49zH5p17T1esQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITSOlfXBUuXR+GLnLv8rwy4XV7dMyDT/OtN/ZBtYGG8=;
 b=EqGrsYhUIYAd0bqmj6YFJSfse7xZfnqKVTg7BKxeyxeHWkDyma46SXEmfnUYE6wK5ahN4eceV7S0CVjMvZvXhVUa31j2dSb3yRbn490Wp0aSpfbY0tpXaycPnHvqohvXvg9tgR01WtcRcYq4H5Vvlo2vZqY/GQAmSm0BKbyECQU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY8PR12MB7218.namprd12.prod.outlook.com (2603:10b6:930:5a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 20:31:05 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::e2:9f06:b82e:9a0f%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 20:31:05 +0000
Message-ID: <b58c799c-8d3f-4fd8-9ddb-ebb06ef005d5@amd.com>
Date: Thu, 30 Nov 2023 14:31:02 -0600
User-Agent: Mozilla Thunderbird
Subject: [RESEND v2] ACPI: APEI: Skip initialization of GHES_ASSIST structures
 for Machine Check Architecture
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "james.morse@arm.com" <james.morse@arm.com>,
 "bp@alien8.de" <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20231106201340.434878-1-avadhut.naik@amd.com>
 <c09243d9-b725-49b0-a6ac-163d015ff441@amd.com>
 <ZWeId332wmrdLycH@agluck-desk3>
 <fbfe27c0-1635-434f-a1ab-71a10c9d6f38@amd.com>
 <SJ1PR11MB60839D04A329087D11933B6CFC82A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: Avadhut Naik <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB60839D04A329087D11933B6CFC82A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0164.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::29) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY8PR12MB7218:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dc89f4-b38b-4a0c-ecf0-08dbf1e346e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mleUalBCdUiDIel7be/SJxDqjQ/NJz7FVOIbMGF6KVThOUMXwl5w7dE//FGyuApJGWzIPV68Tiq7Lpr/dtjJiR6g6Ug5Yt4ooDZYfakPgdn/8dui/pT6zMrqRqrieX+2YShoEYQ0rizDv4wL0FGWv5om2/BhiMcznAJZqXavDKZzY9lJMr7GXpx0F5OPNxruj9a0WPhKTWWc1xxU4VekBZtSU1Nols9skanwmkqKroN5tP5c85tRnP6FGehr6JuhfXcd1jHynaUYQrLGnBIUaqd0GQRsxMXu1BTUwS03AFQiehueToa/3mb2BS6Q7WxvGtoP+ja0mwU1/1uSYsAge2KILRQG0HMuuFYmdrSTlhQ2wv+FKZv+QFS/hrPQy1kcRcwI2vRIl864M63WzCkhvXYNRvtOgzI3TsqCGHQB+b82Iyxtgo7IyZ2rVAQfwvfRWfjTgCK48gtnFt7tDWWGUg4V4aH7ShVpkghTT2/zBC7QOmuru2c/tJE2iiXoBYal+hMQaZJoHN4ocxPZywFoTQcsFy+Q3aqJthEVW4FXweGEargBENnrKn1DXTCjGieViIT+zBv771wZpxSVFFSzmCx2sl+VIzmER8assIh8fLkvg5vd55Ih1ElIAYOiy6s64e6YrEsQPqHVpAjTfGnuJA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6506007)(26005)(53546011)(6666004)(2616005)(6512007)(83380400001)(5660300002)(4326008)(8936002)(41300700001)(2906002)(8676002)(6486002)(66556008)(478600001)(316002)(66476007)(54906003)(6916009)(66946007)(31696002)(36756003)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OU1IeUJUeHRYUWdzdjhCWGlXYTFJZEdDWlFnQWFBNGxjMTVkZXBaNUptRERw?=
 =?utf-8?B?QUtUOTRTNkVtV3BIUEZYTXM3NTlkN0xZYkpHTmhMcVEwd0orbXR4TEFJN1h3?=
 =?utf-8?B?NE5wQVpNY1JMMTFmVWJReUwzOFVLZGxKK2xEcVdwVitmWkRUNjh4U2hYampy?=
 =?utf-8?B?b2wxQlF4clI4RlJvV3dGM1NJcGN5TDBhUzFBM3RrK21LZ2Y5cmtsd3JEcTJF?=
 =?utf-8?B?c29FNlIzaHRCMjlSVU4waXk1ZWc5eHNZYlJscDhocUVmblc2U1pDaVpCRTBI?=
 =?utf-8?B?MHBsNjNlQkNpTWx3VXRuTVFrbWVIWlZEdGFRcHFDR1Z2Z3ZHQ2hKYS9UYnR4?=
 =?utf-8?B?ektWTUozbHlDTVhzeUNWTitFamt1L2hWQnRzeVFSR2ZPc1dHOS8vSk9HWlov?=
 =?utf-8?B?N25Vb3RrcDdnWTFveGdEUmhmdHZHR3N3YjVRYytVVVVCWjZob0NoZkNaVC93?=
 =?utf-8?B?dVVNc2VjZGx0L2hnZWdPZFNoangzRlRuSGJwaHRFRkYzNENjSTIzTW1jd1V2?=
 =?utf-8?B?ekZOTWJ0L1hwTDhIZDZWTUpFclhEWHFaeEJyWG5yMUFiMmZ3d09tc09sUVJp?=
 =?utf-8?B?SGRqb3FSY0ppMDBUYlFkNFVuVEZmZTYzdnhpL0FsaWo4cFExdFpTZHhwZ2FU?=
 =?utf-8?B?NnhNTFJqWC8rSFZUblRJYlJXa285TkFxUmx1SXBkbDhLUHlyaEpZclF3bVd2?=
 =?utf-8?B?empJOGV1RFozbyt5emVENGlJcTB2ZlFwZ21LU05TUUtMZkJXMW42Smw2cGto?=
 =?utf-8?B?anpjTjhhOEtWaGI2VkhMbVNTRlNoYko2QU5BR0ZnUFVJWDJXMlZLRmFUU1Fz?=
 =?utf-8?B?QjJUUnNUa2FvdmJUdjZ5SXhram9UdEVMQk5pTkpJY2pnajFiYlZHVXRoVFF0?=
 =?utf-8?B?NlhBWFVLeFU3bVVFU0ZiVjB2VnNqaXczV2Y3bFZPQy9WTXQ5Ly9PTmptQlN3?=
 =?utf-8?B?ODZKc3k5aUptK29CSFBRSzQvYi9yWEV2RGVyOTRNaDRUWHFFeGhmbzJPV0Vp?=
 =?utf-8?B?ZkNLTkpHSXJsaVV2YXo2bk13QmdLeVNFU1pTL1ZlTmhvdzR3WC8rdCtwMDc3?=
 =?utf-8?B?UVhnSmVFaFM0aG16Nks4eGpNdkdNVFlNSjc4czNqdHowK2JtOG8yYWRZZjUx?=
 =?utf-8?B?RVc2WEF0N1JOWmRNVmd5b1hmV3RDSWJqRU12Z0ZSRzJRQ2FRUjM2VUNPc0Rq?=
 =?utf-8?B?VUE2UmhvTTJKNnJ0b1RjQVNMQy9HTllLZWpSOTQ1Wk5tQnR6aFhkRExZbmxE?=
 =?utf-8?B?YkN0anBLSlA5M3hDRzVrQ0c3cjNrNHd1d0YxTm9BeEd2L1N4cnFERHh3SERz?=
 =?utf-8?B?WTJGd1QxeXk3R1NNb1FDc2F6ekpNK2Y3WEtqME5GRnFhb0p6VFZYazE4YWlh?=
 =?utf-8?B?R0U5S0xpeFVMa0VwQVo1YkdjUjV1djQ1M0tpYzFBNkN5ci8vTVBrT2M3OVdh?=
 =?utf-8?B?TEJqSDZObCtiYy9qUkpHWlJnZ3FqOVN2b1d0U3FmS2d4UWNUbEFXS0dyV2xN?=
 =?utf-8?B?Rm5TMkxBSFNsdldYMmhFemZGeEp3dXdIQ0pZZnBsZ3FRa1FCU1R4OVBMWURP?=
 =?utf-8?B?RmtBWXExSEcreU9adkI5Q2E1THJLbHJUTkNTSXc2U1MwdUdCbDNHaXJnaFhq?=
 =?utf-8?B?T0dmWEY4QXRpQldtS096VGQ0N2hPM0RaUFBGbTRMVVB4YVlLSEs0T0M4NDRM?=
 =?utf-8?B?NmQ1YUhPOUh1bDNTTE10dVNwT1BvSkRwSUtNNTl1cTFOUjA3cXFqNkthOVZP?=
 =?utf-8?B?Z0EzMmtRdUNSVjYzdW9sS1Riai9iVlRld245RTFyQ0JTNi9qNG9CSWw5YXNx?=
 =?utf-8?B?L3p3ZnpJbVJrZkRQNnZjZmdLZ2dyMW9UWUhyS0VNakhJOVB4L0JITVY1ZTQz?=
 =?utf-8?B?dm9rSXdmWVJlQUszZllQUWphc0Q2dms2d2NQR21XbGZLR0NtVTJmMzB6K2Zx?=
 =?utf-8?B?RnY2bHhMYzYvYXJKTjJHNmpSUDhSQTFLOS9uajNFZmVkM2VFd29hTis5VEhF?=
 =?utf-8?B?Umk4WithZFptbGtvaHFtK0NkN3h2KzkvM3Y1UUdaZEtXRDlkK3d3ZGxuT0Nj?=
 =?utf-8?B?azcybFE3UXBkTE05azVhbXp2SjdBTU5kemNZNFQ5WXQweWFZMzI2V05MaGFx?=
 =?utf-8?Q?26Z+jwRjBYWhg1uTyZTrh/ELW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dc89f4-b38b-4a0c-ecf0-08dbf1e346e1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 20:31:05.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eT9QfhCaobOD8oaSVnCew5sKZ1nzVUSBD/OiWCYqHfNF2h9Oo6hkybk6RDQOcJ4n/UpbIZThjp9P7qu4B26+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7218

Hi,

On 11/30/2023 14:03, Luck, Tony wrote:
>> Actually, caching of values from an earlier structure to be compared against values
>> in a later structure is what we intend to do here i.e. comparing cached source_id
>> from an earlier structure with related_source_id in a later structure. To hint
>> towards the same, I had added the below comment on top of the static structure's
>> declaration:
>>
>>>>> + * Since GHES_ASSIST is not supported, skip initialization
>>>>> + * of GHES_ASSIST structures for MCA.
>>>>> + * During HEST parsing, detected MCA error sources are cached.
>>>>> + * Flags and Source Id fields from these cached values are
>>>>> + * then referred to determine if the encountered GHES_ASSIST
>>>>> + * structure should be initialized.
>>>>> + */
>>
>> Is this not good enough? Should I make it more explicit?
> 
> I understand now, but missed that the caching and use are across
> different entries in the HEST table.
> 
> Maybe something like this:
> 
>  * Since GHES_ASSIST is not supported, skip initialization of GHES_ASSIST
>  * structures for MCA.  During HEST parsing, detected MCA error sources
>  * are cached from early table entries so that Flags and Source Id
>  * fields from these cached values are then referred to in later table
>  * entries to determine if the encountered GHES_ASSIST structure should
>  * be initialized.
> 
Sounds good! Thank you for this. Will update accordingly and resubmit.

> -Tony

-- 
Thanks,
Avadhut Naik

