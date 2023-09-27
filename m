Return-Path: <linux-acpi+bounces-225-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DF7B0A2F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ABB8C281CDF
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E783C692
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418271170B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:31:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A2B126;
	Wed, 27 Sep 2023 08:31:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRMi258emgYnz3oq19cCnpKJLDwD98Tpkf5GHx2scXxgg3bkdRdhhRdPM3gMFj2vHgi7KAoNIk3br1jBy9FJsZRrYeL/YZ18WXVG5ibnC6tVuuvAVcC1Ftchl9wJBFKTo0RtjANYfIIdh3qM3D47W23CHupemyInP+CCQmzeNzhBR/p5hVlCyvYzjR8A7ho2Nakhh5J2mMDaF605j42jonDu0uYyl3AnJvJ3S+aKIxQdr+VgeMIp4hYn/KqM6q268XDvSgF2fJWqntp1FwkH3GXcRUS8+G73F7vkrB4LOkTsf+I+xN+55upkH3mYRUcAO/8lULxSlyWJb9jAQgWLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcKLMtM2a5Gw9Gae1FeHMN+sUsQyWVhwp3vlUV/Q9O4=;
 b=i5AcqY1YCklqZ+FM7vnsqqV80/XShrnfSca/DA+SSdfm/vIf7HUTxrLwOLfTDC7zUCgrAtT7k0/SaPSSXtw6PU92cmnE9VdrnCTWlkHh8iCCcYfF9LQBClYgUd0lh3p0I6jVdY4R5jAbL+Fu5oXVOIyUAUyl2v6cemcaW3adMG7WVli27Afyobw3hTlJzx49Zj/AX+4TVansatfMcnUQhYBplJHSumsoGfxCYh5FLRdQvZebNfa6skmZqZKdV7CCwoWd+B2GKhtD6n24G+nNGfraizsvJ+F/zbVYiK4HqhjZ62S0cSORcrPzj7JgGiu4/feubnZ40PmnF05DiYWIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcKLMtM2a5Gw9Gae1FeHMN+sUsQyWVhwp3vlUV/Q9O4=;
 b=MIHUmAw4iuzh1ZM1gAoIsNcahjisuDGC57vC/SpbLRnxuEveI8CL/1unZvWNk3hxSMt3W5imRbd7LO+X2uoE6z6mIuPgwiisxWbE07ks8S7B2CQd23XxmUaN2HSQ5QY5JedE5LfzUE/4GzeQuQzhVz9LHLxLEwZocGuznVhJ/OE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SN7PR12MB7417.namprd12.prod.outlook.com (2603:10b6:806:2a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:31:35 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:31:35 +0000
Message-ID: <89b7ef6a-5147-b22a-4e5e-d7d632d909dd@amd.com>
Date: Wed, 27 Sep 2023 10:31:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 3/3] ACPI, APEI, EINJ: Update EINJ documentation
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: rafael@kernel.org, dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org, bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230926202454.GA420013@bhelgaas>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20230926202454.GA420013@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:5:190::35) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SN7PR12MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dc6fe5-ccdf-406d-3664-08dbbf6ed585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JItitl4UKQ/Khc3P244PUw5ALOpkbB/Z6xz/Xo/xLdRrA2P+iWNfO6t6KnKaZZ999U+z1XUvsrO/NHDQCey5wdjhAVNvSp5lFDioArxamdV2bUq3aKBB3SIhq5GMPIfN8N48X9v6jHjyDRTh3b2HeoBckI7krDOjCu4udvxy2t9hUJofsKN3pPr1Ze4zPJo7nIHebo2GO0BHfXqEB7c76a8VZBQckc6f1mohvnGEKdde0Vn6gq/M82byyMa4s7rbnetTbIInr9hyjhNgVLSLWtkHnCNpdX2Bd+c1XB3BpMVYsKYlc8iYy/ApQzm1t+fda5iBjSAEv50RlNKKrHfmqScXChX0U3TZa6NfrPpKzCAI+ZXekPm+QJ9OjDP73+qTa3nS4m+TF39roBYQhzX96VE21FGnlM3a3gSBrCnhXLT8GEP/hmVIElFesBLIau6sclhURc+J0qXIjAPZx9d0SBBu84KALpAJ4nX989B2NDaiwveCRE3MAK/prxSDzBM17fV2T9yf+vgt4Y6moSKk0el0iQVGW8SAjorEwbnW9BNpNc44P8z+UPpCxcC+7CTQY3tpoxb7TjEs/Qo2cCriDCYdReRBIOENK6KmkIRS5M6vMH3NFYfDyvLi9PBaSkqviSaWc9/tXn58hyEkVMuDpg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799009)(451199024)(316002)(5660300002)(8936002)(4326008)(41300700001)(8676002)(66476007)(66556008)(6916009)(15650500001)(31686004)(66946007)(2906002)(31696002)(53546011)(2616005)(6512007)(6506007)(36756003)(478600001)(6486002)(83380400001)(86362001)(26005)(38100700002)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG1pMUFYc01wZi95QTdqbDJHQTJaNU8rTGxORmpoNnZzdHN5UjdVb2xUeldL?=
 =?utf-8?B?Z0V5M1JKSXJNTTBNbk1VZDdxUHN1MUUreUdjbjNkRzh0bllxNWZHa1RTUU9h?=
 =?utf-8?B?ejVrd1BDM2luQUZhOW5wOWk5UHJseENiYlhKMWVkcnNFcEVVODJ4Qm1tWlZU?=
 =?utf-8?B?RW1kcWYrK2VJZzZndzc3d2RFZzNvK0lJazV5QkQwc0tmNUZtVytjUHpiaERL?=
 =?utf-8?B?REJQb3IzTzV6d0x5ZE1IeGRkdE9TMHdTZDduZUNFTDhIdml4RmZvOUhjNFZp?=
 =?utf-8?B?VytIVi9wbVFwUzNNaDNELzF2M1VFdTRKaGlacXVSM1NzYndJcWRUcCtkMXMv?=
 =?utf-8?B?UVUxNnNsZUoybFJzSmZvZktSYnBsNldRb3hwZlFFQWRvYWMzNCtEWEk2YkYz?=
 =?utf-8?B?aTQxbFlnK01NM25xL3ZpVjNKRTI4SEdoZDgvWVFhV2NtNTdDRmJXWGNrNUY0?=
 =?utf-8?B?WitQbWJycWV1dTkzVi9MK2NZUHJCdlJIWXF1Uy9CK3RKclhXMVRoVDRkbGJM?=
 =?utf-8?B?dlVVcTdlbkx0aGQrWExsdk9rUHZOejJwZlZobkdCcFdsdHNJRlRYSC9SOGZi?=
 =?utf-8?B?TUdONVdoekdHVGVST3VsaHdCOTczUmZhNkhlWllEbjdZQjY4SHNlY3l0OUc0?=
 =?utf-8?B?MmdoNXFyYmp0OElLdnh2YkMzdEIvQXBLa2dqU2RlKzVZSFpMM1VPWGxWY1ZI?=
 =?utf-8?B?UEIzTWJxYnZ6ekgvODFJaS9ZYmpva0x2Q0xOU1FPQUVQcEtOditOVHVFY3BJ?=
 =?utf-8?B?bFBPSk1PNHNkcTd3YXI5RGhjeTNIWjRXTkpqUGI2V2xhb29UL2I3UXRCWEJv?=
 =?utf-8?B?ZmZWZTcxVlJDTDIwbVR0Z3VSRUpmeEx3aTdTV29vRnNJREI0TlFWa1F1RjZ2?=
 =?utf-8?B?enUvVC9aNDhuUDBueDRQai9OczBDY3Jlajk0Z083b2FsV0JoZERTekhhTTh6?=
 =?utf-8?B?ZEt4TDc5V1VxYUlselROTjM3WitFZFZlQXF4d3lFL3RZZHIzMmxkVUR2NXBl?=
 =?utf-8?B?Ty9FdDhYKzNhVlFWeTNSRlU2QW5NZlN4ZHc1UDZFMURqbU1KKzdXMlh1TlZu?=
 =?utf-8?B?R2NLMFZ3TkhUREl4dFdjdWdBa1I5ZmRSeG52cmxmd3ZoQTJobTJQcTdQRDZF?=
 =?utf-8?B?K0pxQ3VEN0pjUzJZYTRteUtvQWFvNENRa3laUGZWbzQralhjaldmWjgzcjlX?=
 =?utf-8?B?M2Nqa01rVHBuNXVFbEVocVh4TkU5V2VGLzRpMmFacTdIeVZWUlVRUml5U0xV?=
 =?utf-8?B?TW5NUXBia1FINWt1dEN2MmdaWlZWeVZuRkJSdlJUdUpZNUJIU1VBK3RJenpr?=
 =?utf-8?B?MFNBZ3VTZnRwMGIrU3lPL1BERTJEb2tvSzNCSUJ0RG5ra0JuVWQ3OWE5aUpy?=
 =?utf-8?B?aENBL3FtSGRZUzkzZFdjbFZJRVg4UHh5UE9wQkhMUFlXbzVRbnIxUU1ZSzVt?=
 =?utf-8?B?S3pxT3N4dTg1aThsb0hZaXdNNlJqckRKa2hOeWVCNWxUdjJ0aGVSbExJdlY0?=
 =?utf-8?B?Z2VqeU9ldVdsRGo1SXF5eE1aaGpaODdIRStZT2g3Vm9YZFJpVVVqbFdWR1hv?=
 =?utf-8?B?N0NJWThtbSswck9tcnlQOERBR3R2SDhYZXpLdmV5YWx3OFdzOTN6NEdhWUhk?=
 =?utf-8?B?SWE5V0R3cXArSmJDVWZlRFNOd2xHYXhzVUJVYmN6djNJdngzZVpDVFM5dlVu?=
 =?utf-8?B?NTJ3NGcyR1duNyt2cFNhYXhjMW5tL2dnQnZrTldRbFhpcittZHdZMExiOEJw?=
 =?utf-8?B?aU5wSUFDdmVwUlJkV05LSUpLaUtVZEE4cThiVXlnMGFlK2tJQ1lWK3ROTjB2?=
 =?utf-8?B?V3ZJdXpITm9EaDB4N3AwWWtwbjV2VEVmRkc4b2thWkY4Z2dkYm1OSTF0R283?=
 =?utf-8?B?cnY1UVNPeklTZUJ0NktEYjVEWHRpdit0NkJ2QitzRTJDVk5vK29PSHB1cjVD?=
 =?utf-8?B?VERlYjJJTHVWY3FUV1hxY1FJYlJRUDJVUWh6LzNjT1VoMWxsdVBFZWFpUkU4?=
 =?utf-8?B?bkVDbHpRMnFUUHk2em00dmxubWZ4MjBvTXhNRFEwMmE3ZVR0YnRwZ3kyeU1z?=
 =?utf-8?B?TUdmVW1IMXdqeXQwNDNFOEl3ZEkyeU8yb3RQajM5MlZNV2wwc0FuQTU1bVBM?=
 =?utf-8?Q?Odz9L/VjNEtusfe+9C3h34/Tw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc6fe5-ccdf-406d-3664-08dbbf6ed585
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:31:35.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+9EjHoWwL2UdDJDogk7DYCGejG/1bO0t+OC++gyvjzwr9GIOGy74wQcbY8pF3ICAAjtKjEahZsTyxiO8tI5yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7417
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/23 3:24 PM, Bjorn Helgaas wrote:
> On Mon, Sep 25, 2023 at 03:01:27PM -0500, Ben Cheatham wrote:
>> Update EINJ documentation to include CXL errors in available_error_types
>> table and usage of the types.
>>
>> Also fix a formatting error in the param4 file description that caused
>> the description to be on the same line as the bullet point.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  .../firmware-guide/acpi/apei/einj.rst         | 25 ++++++++++++++++---
>>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> I always feel like the documentation update should be in the same
> patch as the new functionality so it's easy to match up with the code
> and keep things together when backporting.  But I know that sentiment
> is not universal and maybe there's good reason to keep them separate.
> 

I put it into a separate patch since the documentation change was substantial,
but if it gets shorter in v6 I'll put it into the previous patch.

Thanks,
Ben

>> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
>> index d6b61d22f525..c6f28118c48b 100644
>> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
>> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
>> @@ -32,6 +32,9 @@ configuration::
>>    CONFIG_ACPI_APEI
>>    CONFIG_ACPI_APEI_EINJ
>>  
>> +To use CXL error types ``CONFIG_CXL_ACPI`` needs to be set to the same
>> +value as ``CONFIG_ACPI_APEI_EINJ`` (either "y" or "m").
>> ...

