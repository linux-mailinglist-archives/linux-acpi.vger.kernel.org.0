Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C7739F8D8
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jun 2021 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbhFHOUx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 10:20:53 -0400
Received: from mail-bn7nam10on2057.outbound.protection.outlook.com ([40.107.92.57]:46305
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233308AbhFHOUw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 10:20:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBz0uGxBGH2XK41/OpYaWmMhzq5R5BJC0TWtPi+dm9E35tKANupCfUIGegPdWwRZqP+Ub/YRcZ2udhbL4BFPn3VEY5d0b2El8bI6DS6QAw/BxJWIptqsyShuawrSp1A/saXtNr+k5szEr+hSpGRZK5guN9ZGSYiL2yjVSPHSySq8cwWCRvtcFAC1+3OmUSfYfeewVH2xM4Ljz2itwrwkq7AKpDBKCALq/yNnVka7W+UC0rfavPXIgwjrOfG584PHWHjirTpT1ewwaUdsWaJcG7qTVNg4ssPcLeGlHxBvdq+kTlJ5DYJszYOiChIZCM3JEw7jDbYV7QJnX4VcgN6s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVUWzjUdHxm55/s6mwlsGro4K2c6C69PQKRPu3W7mQg=;
 b=hxaBp0qNXk7nfnsQObasQsC2pDUOT3fOsyDbDW1uItxmhdCAw2MdjWu0isbswQRRzWKxvLbzYRnECNNf6USZBUKCurnDTukZCs5BHxzOeL24NCn8SK/+c3LTEwxN5aVGCWBbS8ilwiASRfd5dtF0P6sUSs88eskiwtT2g5kM7fUC+Ij8vN1RHgzV8pS8IagEMJIeF5PD3J/2lO/l43Gmd0ITBIxPwy5xR9iyS6YMTzMeAPyj4vD+chEdaLocT0/519ZOz+lBG+FEIXxr2+XhYrvEygwGxSLPxOCZ6k5tS7/C3kKHsYEAA0YTVZ3M5LrmX1ypn+keDnpNccQxsPYfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVUWzjUdHxm55/s6mwlsGro4K2c6C69PQKRPu3W7mQg=;
 b=SRlOdsqTNzQB7E+QCI0+VMPzW6tI69zgnlC+rUdmA+EJFGi66U6grI7C1TIbXfnxFZOAJd/cRqIromwKxeVzyQKG5zSvWYsxQkoF9Tf1CrnB9s5pfhqSGKdeLD57uai9NcaYISq6+5tPyiMipZ/K+aCXv2WCBZgnvmMXfrEx1yM=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8)
 by SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 14:18:56 +0000
Received: from SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671]) by SA0PR12MB4510.namprd12.prod.outlook.com
 ([fe80::d51c:6137:77f2:5671%4]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 14:18:56 +0000
Subject: Re: [PATCH v6 1/2] ACPI: Move check for _DSD StorageD3Enable property
 to acpi
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        rrangel@chromium.org, David Box <david.e.box@linux.intel.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Nehal-bakulchandra.Shah@amd.com,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Prike Liang <prike.liang@amd.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20210607173156.5548-1-mario.limonciello@amd.com>
 <20210608053546.GA14116@lst.de>
 <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
Message-ID: <556a22c7-58af-b9d4-d50c-25d7d16bd344@amd.com>
Date:   Tue, 8 Jun 2021 09:18:53 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CAJZ5v0gMgwJ9kq_mo_dYoTUAqQzhXmrgp9wnY4TRPU1pJp=TyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2600:1700:70:f700:8580:469e:fce2:80b3]
X-ClientProxiedBy: MN2PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:208:23a::34) To SA0PR12MB4510.namprd12.prod.outlook.com
 (2603:10b6:806:94::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2600:1700:70:f700:8580:469e:fce2:80b3] (2600:1700:70:f700:8580:469e:fce2:80b3) by MN2PR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:23a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Tue, 8 Jun 2021 14:18:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0961dd8b-3f3f-4d23-82f5-08d92a8859f8
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4382F54B6DA1A5C1BA760F8BE2379@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2MYkEl4mTb6vQOajDr0MsHxYyYHdfghAGmShMqUE/N6fwsPhleMtYrpYLTKjtT7zwQ6iauIkJQ6oR/vjoMN0NEi7JHPn+qf+CWk8D4FmGYqlTKElCdk/MULvOH59t/tKg3OgRC0ZKj/DQ/3+H89UTAJvBDshVGZBoaL+n9a5aVxYLsKtTUY5wgcMtFvaPhGTVvK2jOTog5iAQ/33wwi68zRdbDkAaCdwBsAndNt+dY54DdCiyop1SZZCFj1RDa/Ap6pj7WdJXX564iC0b4U+66p55zXWuYlvLrtjbs11T6Up7EYu7BNifuARkRhzYUvALTFP5LiC6y12FyYODrvla2S8WU1wWMqQzrVEYTpZ3YA4YGGvHacRrb0jUg7TSoefHFRaACeY8ajbrhvYS7k/nvGKwe32vOhSP/AIBJg2q/M9//OYM+awWvbdO2rI/SbLDmtGj8c9nFO+wvtPU33sZ4QyrpQaFgqZRyvf76aQplKEPC3wOpyk2Vp7q+JVlxEOBGfUmVh7tLuTv6Aou/BgaZKwXsowU80edfmPW1C5fau4KCyJmxoWBx/xtisyvFLibLVwZ6Q3Br/Jt9Xx5JJsP5fUk1d0vHGh85k6UhcKzpF6CdKGNiAyQbwtMhHasSE89eiVF3SQY7XMqN7wy/KKSe/A/8xgqzPhDy3z2jREzpJjXVYhOL2bDiczGoNGHm6y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4510.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(110136005)(54906003)(86362001)(2616005)(2906002)(66556008)(6486002)(36756003)(186003)(16526019)(478600001)(31696002)(45080400002)(83380400001)(66476007)(66946007)(8936002)(8676002)(316002)(5660300002)(38100700002)(7416002)(53546011)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmNsQ0lNcjk3YmlVak5ucEtsd1V2bHJPT2M3Z3d4cksydXNXR3MvVktwSUt2?=
 =?utf-8?B?TXhxaTliN1FFK1JNaGVqL3V3TUh1Q2QzcGNES25MOVlRYUFvdDd4MmFZUmw2?=
 =?utf-8?B?eEJUQkQxcjRoZytNaS9NM1dsVjZsVE1ZMTd3QmtDdHYwNmhjaC9FNnFhSlVn?=
 =?utf-8?B?WnFYaDNaeDErVkNiM2p2VFRQQ25oSWU2ZmJIT2I3TVpyeG56Qkk0MHFmYld2?=
 =?utf-8?B?Slc2dSszRlpNdUZIYmFYbTc2elhYVUhLSUU4SUdrbXc4b05uem1TU2tpK2Ix?=
 =?utf-8?B?M1FjclkxUFg1WHFtdFIxUytNQnVBbEN0Z0JLQUlRczBzb1RzUlJEd3dNajg1?=
 =?utf-8?B?dVB3akVQazZYemx6dHhWeDdCSWZmbld5ZlVrQ21HemtyV3VFZndlYjJSbWVH?=
 =?utf-8?B?bjhLM25hUHNGTDRkaFlFT0dtcGloZlpnVXpZQlNJcm5GanJ0SEJvR1BHRjVS?=
 =?utf-8?B?dWIxNVVNVmJWcmtMVG1IUEVKR3NTOEhoeEZ2UnVPVDloL0ljS2lYc01tZTVO?=
 =?utf-8?B?d0w2OThLK2JZL2lOdnh4NG1sRXZKOTJnWUlDZklXTGJZaVd0ZHc0QXNxaWEv?=
 =?utf-8?B?U3BWVnl2UWFIQVVoUkhqOHpaNDc4ZFEvbnVpOWpkVjE4bEt2UVFPdzZ5RHUw?=
 =?utf-8?B?V0VNUzFMSnV5dnVIcHRKMWlCT01jckp1SmdIL01JVS9pYXpoTHhmMlk5T0Fi?=
 =?utf-8?B?cHFyeWwrck1VWlFpR1lrd3BRa1Qzbk5ZSjJxdTRCS1hkN2NMb1piOUhHc2U2?=
 =?utf-8?B?R3didzdsQndLdmdkQnVlYWc5NjY3RWJoMkFqQzJyZHpzdzBBR0pwNEh3Ly94?=
 =?utf-8?B?TnNSK0ZwaXcwMlBobEFXWnQ0QXhaUVhqeGcreldEUWJrLzFvN2g0RTN0VnY5?=
 =?utf-8?B?RmovTENKd05nU2Roci9vWTBWSDdZQ1BzcEk5TktJZ3BpMDVjT1Zxa0dHWFNC?=
 =?utf-8?B?diszWHRYNlhQYzF6MWlHM1NxOTVtU3JzeC90Z3YzU0RaMlNZRmZqREVLNVVr?=
 =?utf-8?B?ME9JTGhYVTJ1dUw0MGVmWUZObyttTUZQYk5ERVgrZDhLVmd5R3BOV3NNdThj?=
 =?utf-8?B?Q0hHZ3RLakNZQVdkTnFwdDJVY2Zjc3NoZ1IzMmt4Q0pmajNpcGhpSy9wQy9w?=
 =?utf-8?B?M2xwd3RCNWViV1M2SUo4Q1FqSXpZUDZIdCs4cjJWUGhuT2dYd212Nld3cnZ2?=
 =?utf-8?B?aFJzY0dPZWhWQnh2eTVhTnZiK0NOMCtkQ1Y5bUlHbE9iVFNrcFZjZVBGVVc1?=
 =?utf-8?B?cmxCL1JicUpva1piYVlBTVFJdWVYUkpoN085ZjI5SmtxRHNRaERqNnFmbkxv?=
 =?utf-8?B?NUZ4WGRhaHFzTTFrNGRuTUIrY1FJM1ovYS8xcnJMa2tnMFA5OXBHbis0RFhZ?=
 =?utf-8?B?QXBiVWpuenEvVHlEaExBKy9pSDU1M2VEVXlGd1RJdFVzQmUyMUhWQTUwcWNo?=
 =?utf-8?B?cW41WGZFREV5YW5HenJqRHphUkhXOHhRL0dnOUp5NHhNaXRTbU1TODdabGM2?=
 =?utf-8?B?Mk1lRjR1WW5JQXNVQmdFdEpsVEM2NjdqeXdwemlxaWEvZ0pMZXY3NmtjTlFw?=
 =?utf-8?B?dFdIT3k2RGpXUlRoVDd1TmVHZTBWOVhGUjJUMkpFWVNKeU1XdWxXWFN2dEx1?=
 =?utf-8?B?bmJlTXl3Vng0UC9PNTVaOXcyVHNncHoyNGhvWEo3V3N0VFB5aElsTE1XRlJa?=
 =?utf-8?B?SzdVS1V0NXRvWS9yT2pxRW5Xcmd2MmtqdjJMUngrWE82V21EcktDQ0FvUFZq?=
 =?utf-8?B?a2htcWNQZXh6QVlsL3MzcWtORk1lRkRwUlpHYzExV21Qck5aMnhMalJZNVNh?=
 =?utf-8?B?dkRGcWlpSTd6SFlqcWhhTVhQSXJ4S0hWWXRVVExtZ2dKZVdRMVhYR3QyRCtr?=
 =?utf-8?Q?z68JX1SMruC+m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0961dd8b-3f3f-4d23-82f5-08d92a8859f8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4510.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 14:18:56.5054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aPoAKKlQm3afScSQr273fulpZSM3MnA3YISTJjh0KPttVtk+uHfkyIV0Ytbpb+hl2GN51I6Bg/k+b5RfWQfvVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 6/8/2021 06:20, Rafael J. Wysocki wrote:
> On Tue, Jun 8, 2021 at 7:35 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> On Mon, Jun 07, 2021 at 12:31:55PM -0500, Mario Limonciello wrote:
>>> +/**
>>> + * acpi_storage_d3 - Check if a storage device should use D3.
> 
> Let's be specific about what D3 means here in the first place and
> that's D3hot AFAICS.
> 
> And the comment should be something like "Check whether or not to use
> D3hot in the suspend path".

Actually it can be D3hot or D3cold.  Microsoft's documentation doesn't 
indicate it's D3hot.  On the AMD platforms that prompted some of these 
changes it's D3cold.

> 
>>> + * @dev: Device to check
>>> + *
>>> + * Returns %true if @dev should be put into D3 when the ->suspend method is
>>> + * called, else %false.  The name of this function is somewhat misleading
>>> + * as it has nothing to do with storage except for the name of the ACPI
>>> + * property.  On some platforms resume will not work if this hint is ignored.
> 
> I would write it this way:
> 
> "Return %true if the platform firmware wants @dev to be programmed
> into D3hot in the suspend path, or %false when there is no specific
> preference. On some platforms, if this hint is ignored, @dev may
> remain unresponsive after suspending the platform as a whole."
> 
> And I'm not sure if it is necessary to mention "storage" in this comment at all.
> 

Is your thought here in not mentioning "storage" that this symbol may be 
overloaded in the future to look at more than just the StorageD3Enable 
property and used for other things too?

>>> + *
>>> + */
>>
>> I still do not like this comment.  There is nothing about only using this
>> for storage devices.  It is specific to a PCIe slot, and if I plug
>> something that is not a storage device into it the same restrictions
>> still apply.
> 
> Originally, it was about storage devices IIUC (and that's why the
> property name is what it is).
>  > IIRC PCIe link management was broken in some NVMe drives and putting
> them into D3hot would allow the link to go down later and it would
> never go up again.  So you-know-who decided to avoid using D3hot for
> all NVMe drives and they were generally characterized as "storage".
> Alas, that turned out to break other things depending on the devices
> being put into D3hot (like PS_ON) so the property was invented to
> allow OEMs to mark the configurations including the devices that
> actually worked (and Linux was/is on the receiving end). And
> originally the property applied to the endpoint device under the root
> port it was present for (my personal opinion about this doesn't really
> matter, so let me avoid wasting time on expressing it).
> 
> Now, it evidently has been re-purposed to mark PCIe root ports that
> require devices under them to be put into D3hot in the suspend path
> (and it now means any device under the root port with this property,
> at least in some cases).
> 
>> Also no need for the empty-ish line at the end.
> 
> Right.
> 

