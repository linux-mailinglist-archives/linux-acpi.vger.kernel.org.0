Return-Path: <linux-acpi+bounces-3489-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C963D8550DD
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 18:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FB25282D96
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 17:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E531272BE;
	Wed, 14 Feb 2024 17:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MSoKU6ex"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC277D418;
	Wed, 14 Feb 2024 17:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933267; cv=fail; b=VXJjJqrbqwkJrXgGAmyv8XavMO0xBY2HSXlptlJ1hR0Z78Yd7YmOfst6rZSeRPL0P5+Fhm8sysT85GOZY6YORzk8VYth/YNPj75cC1bBxw4hTOklFoCyu7yaych3Qa0qN6zMTIQgPjHt6V1i45W6RVfdopH1K6gTjm66gBa3Sek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933267; c=relaxed/simple;
	bh=JgVHY5j4nK11vnNpo51MFT+oPvaEidL2jc2oAI9ho/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=k1DB43tFL8WGpjFzXlu4UA13STO2hK0fUqq6H5NCUtFDNRE8fqReYnIHpIR26hPInZtuVHKZUewUSX1hdDqH3uBrXEfCvDb5uPspQPsZpCRmI/Xo9wPu+C4uMuKAhCpIJJyxBBWrBcAm5pzOe8g2GcfLWIT7iaHqb9doJWgDUhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MSoKU6ex; arc=fail smtp.client-ip=40.107.243.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQNQ/gYrur2u/32HzX09xLyiZyrUjNkHu12OWij6TUcN42ZARIEtl0B7V+AJF9uwIStUlFpmMoB9WDYmXZloBBpYm+AhZypfipfsJu9mquJE15NNZ+Vlz4/7jDmALNaMQjXgyWL3J2Wcuj61X9E5ltjr33NYxDORHqSuKXba3NaYeJP5V3DR50K9qRZ+ipP2Iz2kzrYZk2Yh1BiaE++0EbpGTuenVbXzv2shq9F5EZrf28G0drVygbvrasSiZPE2tAgxycguMxaKWW9FYrqWLSEeLxexjg1a0S8Xlz8pNVuHcFrKhCRW/RFMZ0mdLhTIDVrKMqKC0D/0Xz/gVanA8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRkb/qKyDm3+1I2coTVZtk2X1Pp6hR9gxK4geZJ6HjE=;
 b=T5GuyH/nLbCf8YZsJoKS/s0f4J9nOkbJ7bD2nBEyy0qLl1aZd5rGmR+u95b7vQfjbpymyook3MXVP/ZEIr/WkxWwFhXgecwNpROrGqzZ0+nHW5yI/9rnoJiwQK4KS8jOr+v7a7YdWSV34eKeaV+lpJbWNK4ajDrW3Pdiy7hFmvObNQuHr/KoFy7fJ0H0aG1RzreFbywPVMvEddZIAORwYZlW3FzJJ4Hmu89sJM+XLiLSZIJKCWiHZiBACNBmzZe4PQCaO8RK5dee+nmYTOg3+MV2N62m/zOxRKg2gosUwLQrGSxXm2gUyX5TkbKawAaxOD0rC01Hi13Xwxa0HGXnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRkb/qKyDm3+1I2coTVZtk2X1Pp6hR9gxK4geZJ6HjE=;
 b=MSoKU6exRRpyHaawckV43tKjTZdReE5FvGpn2GfJFL0684DkUN6XeZUC4AGzyA7dqWCJjm51WlY5+SVMGIIrgMF6I4GQaKfF7RtvvCq+Uuq9s5/zCsIA58MSfuPTZ6RnjcJFJy1kcCUwh3qzez5Zfg8OFwrM0qi5CeCo1lwk8GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 17:54:21 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7292.018; Wed, 14 Feb 2024
 17:54:21 +0000
Message-ID: <c4d27534-50ab-491d-ac6e-916f517e8143@amd.com>
Date: Wed, 14 Feb 2024 11:54:15 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/4] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, dave@stogolabs.net, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
 <20240208200042.432958-4-Benjamin.Cheatham@amd.com>
 <20240214152759.000076ec@Huawei.com>
 <dd996549-dd52-4181-ba62-a1a8a2a18a35@amd.com>
 <20240214174643.00004caf@Huawei.com>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20240214174643.00004caf@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:4:ad::28) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bd0409-0adb-4b66-8e88-08dc2d85f8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h/vvDwUZTiHDzsDl8Xc5JgekCvPQhY/9EJqOLd1rvqh4TrQdxLyQCP/NfoYLeWG217sRraq9SDMyDqCYjm+7mKODMRvOmB/e8FD8x7kcxs3X+i22XkMx6riRzbFT2wP0YejXCF0KegatT9sqHxvwom7Dcp9rVGiLEiPyyARVZY7iyiz+wEpuGYmLqrw61C9/U5/y+l0Ujh8EHyokqswZGqS894jSZDmVRQKHYF+qzsbkV5+LANwJZ0ZBNlY90G7KErlYWNM7VwlFR2uYSx3OXD6qNvPe0T90YaZ+mrz3b6BXBoIZ1beo7YiOGoWioJPEjSrFiBRGU/o55NFJJCSGEsTqkKZkGTL3QsIkxkL07ElpVQIvZrtgBJiGzSmL+M1PHlVlww8eiqV1OdMYTOUVjgWcI9cFAwD2RNW1YlTka7iGvN3XFHU3wYiMxv1ofetXZZsuPWt2eO9OVY4t7CQY+vgZNBk8CR9dYAOSEdbOtMWEQQ+y8RLjlVlVUjkbPoWCxUL0bmUTBqgUaOHOUxJ3gSbAjdcQ653o803cXlpdFtWgME4scT/4+KIG5Rh9rB4a
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(396003)(39860400002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2906002)(66946007)(5660300002)(7416002)(38100700002)(6506007)(86362001)(31696002)(6666004)(53546011)(6512007)(83380400001)(6916009)(26005)(36756003)(66476007)(316002)(4326008)(66556008)(8676002)(8936002)(2616005)(6486002)(478600001)(41300700001)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0R1ekJkSXc2Zzk4VElDRGtkMlRhQjRZazB2ZjhIeUFYeS9TZElEVXFLbWlq?=
 =?utf-8?B?UDQ5dndRSDFyWXFyb1NLZklNQmZ4dVVHSTdFRUZUZVBacnJKRkk4WlRDcnhM?=
 =?utf-8?B?bHlSZUpoV0hObTdob1hxeUxObEExeEsybjdkbk5YZHIrZlRCbERLdWRsbkZa?=
 =?utf-8?B?dkZ0ZCtpRGp6MGFVenVETDlDS0FBT2FDUEVjWC9pZWtQQUFlTkxaZGlpV1JB?=
 =?utf-8?B?RXBIUVIxMm0yTFNkYnJVRWNtMm95bW9RZ0xRNlFRemdMSHRtTkFTUTZDZVB0?=
 =?utf-8?B?c1JSaWxSZGt2YU1uSlJOOFVTMEx3RjZ0anJ0VktZY0RWN3VCUmpEZ3VxSUkw?=
 =?utf-8?B?ZGhxMnc1LzFKQy9OaFpISGowejRiYURLTGpndXJxWnZTWTdTalF4WFlQRW1U?=
 =?utf-8?B?WWZJZklkS2xicy9RMmJpOCtjeTBMaEw3NDlpZkVheEpkNnZocXNPMFoxZldo?=
 =?utf-8?B?YllrUWE1bmZFb0Q3cGxvTE9OR2R5L3B0WXM0aFpSM2hqMnlPdlBTTFZXQzZK?=
 =?utf-8?B?RERGNEpmc3RIWDRRRElyanAvbUZYS1lHOHBrQjNtUW5SbGZCNzdQbmlXaVZi?=
 =?utf-8?B?QS9UV1BUTkNNWmxTVkpxZ0hiZ2JJdW56VzdiZW5lek4wSXQzNXVybDlWcEVX?=
 =?utf-8?B?SVlRSDViM2xyNzBvZ0ROMXVFKzZkZ29jSkQ5bzFqWFFBeFR1azBIMkNXTHNR?=
 =?utf-8?B?SEcrMG5Wdk1XY09lelBZUnlGaUk2ZFVId2RiVWNBeWZ3WnB5MFh4QkRmUHly?=
 =?utf-8?B?YUYwZkJMZ0lpZ0FDWHhrc29Od3dKdDJndzlJVXpvRVZqa1JVTW9HYmJGYXpU?=
 =?utf-8?B?am0wcm5YUXA2aVRMejQxOHQxb2dhbzArMGFUcW5IMzVzZklHOEdtZEJackxT?=
 =?utf-8?B?SURpcG8yeWZHYWl0YXFUUnpONDA1TUxZdEVuUDhUMnhHRm1Tc1dzNW1YTjdQ?=
 =?utf-8?B?TzhwbURZb2JLS2x2RjF4UDFndXpsTEp6Y2EzUm9oOTVVTUQ2a2ZaKzR4OTBO?=
 =?utf-8?B?YTJ5Y3RxRVZpRWF5NlBPeStMSHlNNmhmTjF0eDQ3dXRycDZIdHEvTzB6Y1gr?=
 =?utf-8?B?bE00MFdzOGNkYk1zamY3Q3hWT1p0QlYxNEdMSGV1NmVWc0dTYk51dFpZZkg1?=
 =?utf-8?B?Y25mU2tiL1RMVmlSNVAyaTRrQ3p3aHNEeTh4Qlp4SzdGNW1VY1dmMFV6dUtG?=
 =?utf-8?B?RXM4dXp1UlRYaTBSUVA2d3hYcnFWaTFJWDhMdWs3VzZZUmxVTVIxRHhQVjZ0?=
 =?utf-8?B?MDNUM09OeU9qRmRxc0hwVHRFS1RWd0xYZERRN2V2am9VUnNRc0Jwb21kY0Rz?=
 =?utf-8?B?SklyWGtwV0o2TDRLVWkzRkpHaXpNek1zeUlva2lyN2VCL2NXcWw0R245bE9J?=
 =?utf-8?B?ZlEvNXdZbXdpQnhWbDJmRVFWSE9XWTlQYnhqQUZScjJqS0FoWDdTM1QvUGZm?=
 =?utf-8?B?THZRemM1N0FLVkFTMWNrZzhVUTFiVGxIN2FEdjZwd2RmUzBySmZOUlRFcURQ?=
 =?utf-8?B?SVdhSDE0bnE2ZS9BeW84TUlxUDJoZG50VWFCMmRnRHl0clFWQkJOZHRESDdT?=
 =?utf-8?B?MDBkazdvUVZnY1JyRmROT3huankyak00cXg0TVFBbUtQRWQva0gxSzljYkpa?=
 =?utf-8?B?bE9XbXZmOGFDYXVjTTU4bUJEMFNWWWU2M3Y5NXpBbmtoQmZ5enJJWjVzMTcx?=
 =?utf-8?B?SjRkSDA2RXhZR2hGWEdULzA0TjdRR3FxSW5sT1czbjVrR2ZXNXVFckxkeVdm?=
 =?utf-8?B?SkR0MUp2T3lYU1JXLzg3ZkUvdndvdDE5QzZjbTVjWE8zMVhneTVqL28rNG5N?=
 =?utf-8?B?aC9UMGVHNkVrMHhlQkc4bUFQZ25qQWl2TXJDWER1c0VpV05Gc1J2U0w3Q3Fl?=
 =?utf-8?B?MzN4T3dZV2RQMVhDZ0tidmx3L3RCWS9rdGpNRnBMNzRHWWsrTk5MeWJ5UDIr?=
 =?utf-8?B?VGxTL3FLc1BEb3dLd0RLTlMyZkEvYVR5M3ZiL3pvL0tLc0s5WUNqcFdOdWNV?=
 =?utf-8?B?blhPSjh3K2xqeEFEQ0U4eFkyQlEzdTB5K1FUOFdXR2U2NXY2SUNVWVVTWDFG?=
 =?utf-8?B?cEVSa3RoNFFHaHJ5akJuYWlHK0NiU0NYSUJ5eGFrZHI5OVpBcUlPdFJQNWY0?=
 =?utf-8?Q?9FgrMnkP0FSdBKHYUNdw4eKOK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bd0409-0adb-4b66-8e88-08dc2d85f8c7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:54:20.8772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eTZ3gSL61nAgtpNDekxxsY7h6qHyKOyEn6gqXbiGjOsGhU1ukAliBihMYpIBTd8UsOQkNoUmuaazpLDRRHMhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523



On 2/14/24 11:46 AM, Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 10:41:00 -0600
> Ben Cheatham <benjamin.cheatham@amd.com> wrote:
> 
>> On 2/14/24 9:27 AM, Jonathan Cameron wrote:
>>> On Thu, 8 Feb 2024 14:00:41 -0600
>>> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
>>>   
>>>> Implement CXL helper functions in the EINJ module for getting/injecting
>>>> available CXL protocol error types and export them to sysfs under
>>>> kernel/debug/cxl.
>>>>
>>>> The kernel/debug/cxl/einj_types file will print the available CXL
>>>> protocol errors in the same format as the available_error_types
>>>> file provided by the EINJ module. The
>>>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>>>> error_type and error_inject files provided by the EINJ module, i.e.:
>>>> writing an error type into $dport_dev/einj_inject will inject said error
>>>> type into the CXL dport represented by $dport_dev.
>>>>
>>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>  
>>> Hi Ben,
>>>
>>> Sorry I've not looked at this sooner.
>>>
>>> Anyhow, some comments inline. Mostly looks good to me.
>>>
>>> Jonathan
>>>   
>>>> ---
>>>>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>>>>  MAINTAINERS                           |   1 +
>>>>  drivers/acpi/apei/einj.c              | 158 ++++++++++++++++++++++++--
>>>>  drivers/cxl/core/port.c               |  39 +++++++
>>>>  include/linux/einj-cxl.h              |  45 ++++++++
>>>>  5 files changed, 255 insertions(+), 10 deletions(-)
>>>>  create mode 100644 include/linux/einj-cxl.h
>>>>
>>>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>>>> index fe61d372e3fa..bcd985cca66a 100644
>>>> --- a/Documentation/ABI/testing/debugfs-cxl
>>>> +++ b/Documentation/ABI/testing/debugfs-cxl
>>>> @@ -33,3 +33,25 @@ Description:
>>>>  		device cannot clear poison from the address, -ENXIO is returned.
>>>>  		The clear_poison attribute is only visible for devices
>>>>  		supporting the capability.
>>>> +
>>>> +What:		/sys/kernel/debug/cxl/einj_types
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-cxl@vger.kernel.org
>>>> +Description:
>>>> +		(RO) Prints the CXL protocol error types made available by
>>>> +		the platform in the format "0x<error number>	<error type>".
>>>> +		The <error number> can be written to einj_inject to inject
>>>> +		<error type> into a chosen dport.  
>>>
>>> I think it's a limited set, so docs could include what the error_type values can
>>> be?  From this description it's not obvious they are human readable strings.
>>>   
>>
>> It is a limited set, but that set has 6 variants. It may make the description
>> a bit long to include all of them, but I could include an example string instead?
>> If length isn't an issue then I can add them all in.
> 
> Example works.
> 

I tried adding them all in and it didn't make the description too long, so I went
ahead and did that instead of an example.

>>
>>>> +
>>>> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
>>>> +Date:		January, 2024
>>>> +KernelVersion:	v6.9
>>>> +Contact:	linux-cxl@vger.kernel.org
>>>> +Description:
>>>> +		(WO) Writing an integer to this file injects the corresponding
>>>> +		CXL protocol error into $dport_dev ($dport_dev will be a device
>>>> +		name from /sys/bus/pci/devices). The integer to type mapping for
>>>> +		injection can be found by reading from einj_types. If the dport
>>>> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>>>> +		a CXL 2.0 error is injected.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 9104430e148e..02d7feb2ed1f 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -5246,6 +5246,7 @@ L:	linux-cxl@vger.kernel.org
>>>>  S:	Maintained
>>>>  F:	drivers/cxl/
>>>>  F:	include/uapi/linux/cxl_mem.h
>>>> +F:  include/linux/einj-cxl.h
>>>>  F:	tools/testing/cxl/
>>>>  
>>>>  COMPUTE EXPRESS LINK PMU (CPMU)
>>>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>>>> index 73dde21d3e89..9137cc01f791 100644
>>>> --- a/drivers/acpi/apei/einj.c
>>>> +++ b/drivers/acpi/apei/einj.c
>>>> @@ -21,6 +21,7 @@
>>>>  #include <linux/nmi.h>
>>>>  #include <linux/delay.h>
>>>>  #include <linux/mm.h>
>>>> +#include <linux/einj-cxl.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <asm/unaligned.h>
>>>>  
>>>> @@ -37,6 +38,20 @@
>>>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>>>  				ACPI_EINJ_MEMORY_FATAL)
>>>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>>>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>>>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>>>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>>>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>>>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>>>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>>>> +#endif
>>>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>>>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>>>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>>>  
>>>>  /*
>>>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>>>> @@ -543,8 +558,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>>>  	if (type & ACPI5_VENDOR_BIT) {
>>>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>>>  			goto inject;
>>>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>>>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>>>  		goto inject;
>>>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>>>> +		goto inject;
>>>> +	}
>>>>  
>>>>  	/*
>>>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>>>> @@ -596,6 +614,9 @@ static const char * const einj_error_type_string[] = {
>>>>  	"0x00000200\tPlatform Correctable\n",
>>>>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>>>>  	"0x00000800\tPlatform Uncorrectable fatal\n",
>>>> +};
>>>> +
>>>> +static const char * const einj_cxl_error_type_string[] = {
>>>>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>>>>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>>>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>>>> @@ -621,29 +642,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>>>  
>>>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>>>  
>>>> -static int error_type_get(void *data, u64 *val)
>>>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>>>  {
>>>> -	*val = error_type;
>>>> +	int cxl_err, rc;
>>>> +	u32 available_error_type = 0;
>>>> +
>>>> +	if (!einj_initialized)
>>>> +		return -ENXIO;
>>>> +
>>>> +	rc = einj_get_available_error_type(&available_error_type);
>>>> +	if (rc)
>>>> +		return rc;
>>>> +
>>>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {  
>>>
>>> Trivial so feel free to ignore but, I'd stick to local styles and have pos
>>> declared in more traditional c style.
>>>   
>>
>> Will do.
>>
>>>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;  
>>>
>>> Maybe clearer as
>>> 		cxl_err = FIELD_PREP(CXL_ERROR_MASK, BIT(pos));
>>>   
>>
>> I'll think about it. I think I agree with you, but I've seen a good amount of
>> people who aren't familiar with the FIELD_* macros in which case it isn't much clearer.
> 
> Lets teach them ;)
> 

Sounds good!

Thanks,
Ben


