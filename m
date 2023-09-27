Return-Path: <linux-acpi+bounces-227-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095F27B0A31
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 18:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id AF4C6281596
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629538F99
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:32:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569861170B
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 15:32:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30822121;
	Wed, 27 Sep 2023 08:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PExOEHCmswwPZJqwrB/DYvGvDF8Q/LPBIqMGvZvL/uY0Ba/Km/tu0MmltfUl8rRsJoLxqAlDPp3JVwRPdYvktgsjkg0bA2ZSgreF/Z+pZgCUXmJ3TKbjQGzU6+OHlVr9ggJiLXnncRzMOJaHHE9ZZiW6yHe3QfA60AATjj5Rfwn0QV2MdRVBy9cZJoFWUXHbDHAgE4bVXwou6X6eSVSFM6MRMzNVX1V6H+8+ZABcuiVBMyT2hH5T2YZcy//GXI6mo2Eyzhlqez/p32A7MCeswfD+U65lVUZgy180uhP5nAk6mzdzbPZiaESgySfTLpw1SQ+3+/wuwD/lQ9YR0L3t6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mVq3TB3HuQPZIaH9NdWFT2c51SinVg96BjVTMiXpoo=;
 b=lgKGHOSyyzsaBaXge0Rom1lBYzpk8EpHjWg9k6k9Wzd2cjE26d3dqgQS/3RjiZxZmDKIE+1XTVzQK26IF11Fl00Fr53xY2osvj93hAMCikTkRKF7nds5ULpsAvg3v53MGx4XaJOZY7LS+iVQefSBEnFdiIOfJyV9yVIBm6CNAYvgMffrE/Te1G7FOh2Ij2O2VDXu2zfXzbCAj4hP4+rc1N9LKOSZiDmHJENfbM11v4h3Zd1VEEIpJEasaKHbzj/CbJT3A0M1AB5JsJB3S1ev7/Mc7R92HW8jq+jzBogeT/wflHWVmE9//GlnyI8wkZz3vJgl3zR9/M+xjnVf7WqS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mVq3TB3HuQPZIaH9NdWFT2c51SinVg96BjVTMiXpoo=;
 b=5H9atup54+xP4PWCkRMDi2Pu1Fdndlc5ivA6H/nCrJbi6wemb+05Nl8pDSFucm/bsXQQjTLLXDqDDUBKjaL/n11IqLXkjBexDCTxK20BU+SIDWEh1RZlj7GYmjcIXYNdvPXutZZxIgC9OUeIUKMnuPtxY0vUdt1xFXFNWRtJT/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by DS0PR12MB7972.namprd12.prod.outlook.com (2603:10b6:8:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.32; Wed, 27 Sep
 2023 15:32:06 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::6423:58db:9384:4031%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:32:06 +0000
Message-ID: <0a5f8d7c-7d2e-9c20-8b71-1a21948f1765@amd.com>
Date: Wed, 27 Sep 2023 10:32:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 2/3] ACPI, APEI, EINJ: Add CXL 1.1 EINJ error type
 support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, rafael@kernel.org,
 linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: bhelgaas@google.com, yazen.ghannam@amd.com
References: <20230925200127.504256-1-Benjamin.Cheatham@amd.com>
 <20230925200127.504256-3-Benjamin.Cheatham@amd.com>
 <65134ee675c1c_bf9129451@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65134ee675c1c_bf9129451@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|DS0PR12MB7972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3f1f3f-d2a3-43e8-4363-08dbbf6ee844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+a1xahKNTGuQa21x59tDQGVJvTksawXMT63hDEuoXBGEHoJXX76uz5sDbJZsWP5/urUInv9KwCNRYKmhKRkGXxvnmrdXClVrIhDGv3EaZ4Zs6LXaf1L/rzE7OejIub3bnTeYDCdIG1hZkq4yTR0zr0+ToX5w7hHg/c7W9uXZWk4GWsudMbAw6ZLQc3oOlZqNGD/6tjaMBpezppTGg8urmvd4ByXZEAj8EwwR9b4DxCuAptvfin96JOxBY6+rQOYLyJFxNh3U0dIqYCirwhR6DpMKR2V4U0jaY72qdGZAKPnNYY18x/OGpaq9wjJbrONydtRdmyJM+DH6RcRMzmNEVo+uKY8Sm6wBGjXV3ALaqy9RCChJcN+bz5dTQrm8SxRuvbvP3apFANvCTK5RqEHzAjGVmFBsyp9/cqsjbTup+gubtTWLBSLovu807Ah/YqejanfDUN03m1gIfMAZkN+wc+ldzoHZk8OOwCHNk5cOR1exIt1UtA4xxSgMz3Clqw7N70Ud/Vf8uY7Iy+6/MsvWe70QO9aysm91ZWPcnzS3v/QFZvyeOjyJV7oUQh69pjG4jU9eggMM/kC4GcaV+PrN01i6/cj1HqCrL9UsB3MhE+07ART0kalN324iVqyo+nX7ItVeCzrplt6EMoFAC56gyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(1800799009)(186009)(451199024)(66899024)(2906002)(86362001)(31696002)(36756003)(38100700002)(41300700001)(316002)(53546011)(66476007)(66556008)(66946007)(2616005)(26005)(8676002)(4326008)(8936002)(6486002)(966005)(478600001)(6512007)(6506007)(31686004)(83380400001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWtwWDF2UVdyeHBZYjVoeEZGVzRzTjFKZ25BVFNmWWZNSktseVVpRUJmM2RT?=
 =?utf-8?B?aklveHBkenVyTlAzVW1BQldrQ3dLdTAxSHAwa3dKN3U3REtqU0QwT1VpaXhJ?=
 =?utf-8?B?NjBJZ05neGwxRG1ZL1dCZXNJeFYwVGxaUEIrUEQwdnYyVTExanpNTVhoVEtT?=
 =?utf-8?B?ck5qUVNuRmNtNWhDYlBTWXhGaGpueDA5TDFpekRmSWdndkM0ajRpSi9BNEls?=
 =?utf-8?B?dlRMbTFEdncwUlFoUCsxN3pjQVdnREZ0cEgwajVyYjcyZEdpRFYvUC83T3JB?=
 =?utf-8?B?bUltZUpwVi9CeU5WZml4Y25aWnUwMmk3NzIyZ0U0VG1HdTdBME9MNnUwMjEw?=
 =?utf-8?B?VE50R1AyN2d4Z3k4ems3WXhnalZ0b2pKaVloMDB5SS93QUJ3Zm9KOTNsM0dJ?=
 =?utf-8?B?NGJ2TVNsYyswTWRYbmRQTTU3QUFFVEhmaVpHdkZXQjQxMzl3eVYzQTFNNkRK?=
 =?utf-8?B?SmU1L3hCcU9iK3dNVnNjTjg0R1l3K0l6a3FwWVpQZExIYnFyWFJZd0VuT2sv?=
 =?utf-8?B?TTBUeEsvNXRWbUltUXgyR3d3ZnZkZ1ZGaldFekpOYjNneC9uaWczOVFLeVhk?=
 =?utf-8?B?M29nZ3lIeEpYYnZtemZYNlZTdWpjT0drVU5HL3NJSkE5dVpxVkYrU1FFcHhp?=
 =?utf-8?B?MCtCTUlnajVyVWVTejlkekhOZElVS1Z4RDRIZTlyNHhEaTExYjYwWFpxRUUr?=
 =?utf-8?B?S1ZibkhCalNEb2xoL1dsaVBFc1ZZaGFUeHA5S1o5MUFZL3QyakRuck13OUxw?=
 =?utf-8?B?Qjdpa2VPLzJHdlZVcjlQOWt1ZkU1SlFiREVVN0F6Z3hPcSt0RFNwM0pmdGF0?=
 =?utf-8?B?SjY0cmZEaFloSE9rSEluSXZvWk1BODRKd2N6NmRvd093bjVHUFVoa0plK3RI?=
 =?utf-8?B?c1VXTW4yeWdFOFZlMVl2WnRXb0Fsby8yMlBHZUVhb0pNNHpudmFsZEdoQTN0?=
 =?utf-8?B?RjBtdWV0d0QxQ21yeUhWeGFxOXpOcUZXNDZVVTdhVm1qYzlvaVlFbVNCRzB0?=
 =?utf-8?B?K3JMbm56NFNZOXdIM2lwNk1hakVVS1FkZEZoQlhRa1dBS2d3bmphQmJWc2FE?=
 =?utf-8?B?blRoSGlmZFVVU0podGJJVkxVUjd0WEpybXM4S3ZTNjBMSmgybzZHNmlraUI3?=
 =?utf-8?B?Nm5xSHlqVVVvNi9HMUZXbFFBR1JaMEpMM3VhL3Z5R245KzNmVEFqb0d3aDRt?=
 =?utf-8?B?ME5RMG9yZXFJNXhob01qelZ3QnUyTkg2V0Y3Q3psUlN4Q1dINzZISnpoSkVj?=
 =?utf-8?B?bDhCRzFUcEdobmdyUjNxRjR2SDhWNnlsOFZtOWZSWDVOODZKRXY5UTk3cy8y?=
 =?utf-8?B?U21mcGxiUlNnRTZZZmdQcFB4NUxNTzJTM3M2Z1Zudm9TMENGenpwVVNMb1BM?=
 =?utf-8?B?NjBTNG5paWtnQUJxS2VlQ2orelZ4cDFOMkZMbEhxWTY2cWY4dzBoeTdoVnFq?=
 =?utf-8?B?WFZKL2JJbG5FWTRFNHoxby9Ed2JDU3ZIWXVYOWI5UE5wTWRFVFE0SGRGdXJ6?=
 =?utf-8?B?WVN4MDNHeXhlN0VQa0Y4dmhBMFdRemovZisvbEg5bTZYOFhCYmVOTXFVcEx3?=
 =?utf-8?B?cTF6bzhWcHJia2wrMTZUZlpndG11ODF3cnIwRjBpR0w4amJaL01mVGVMM21F?=
 =?utf-8?B?TCs0QnNoTEZ0ZFFrbW1LT3dVWGErVVpTR2Q1eGVnQWYxclZqRWtaZGVqdnhX?=
 =?utf-8?B?UG0wM2N6aVFGb3Z2cU5GSHpCYjZ0SWFqY1ZyYVZvRlEyRTVCUXhSc1FBU0VH?=
 =?utf-8?B?TDdUdVVvaExzNmZVMEVJcFlRYTN5YUdwdU9nM3AyTDBFZFhCcUt2ZUgvczNE?=
 =?utf-8?B?dHhEQm5HS2dsck1Ydzl2NU1kWUxwc0FTeWtKZkRiaDJEaHdIT0pPVXdwMVQx?=
 =?utf-8?B?ZHFrL041emFYYTJsbkltTndjZVhIME4zdlM1Y1duTDBLNW93Mm5MUGVQT1k1?=
 =?utf-8?B?OUxQRHFLY293OHd2MW5BVGo4NGs3cDFmNFpLYkNUaVRMZVkyZUNDWWZHYWpu?=
 =?utf-8?B?UFVCeHFXRHZIQmhTdnJsMElORUNNZlNqV2Nnai8ra2cxV29nYzB1N2Mxd3Ji?=
 =?utf-8?B?MG1DbnYxUjN0Tndjck9CZkFndzN6Z250cU5oNUhFYjdpbmJkS2ZzTjNmUDJm?=
 =?utf-8?Q?kNOey8oz8088Dql14s3p152OQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3f1f3f-d2a3-43e8-4363-08dbbf6ee844
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:32:06.8162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oe4zypDTEp3CB8qJnPREsM2SjM7KHfSzKB0VHI4nJqeIhYXJ6n7MKXmiGLHxOTgqPGMS/fd4BHab1+E4oZz/Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7972
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/23 4:36 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add support for CXL EINJ error types for CXL 1.1 hosts added in ACPI
>> v6.5. Because these error types target memory-mapped CXL 1.1 compliant
>> downstream ports and not physical (normal/persistent) memory, these
>> error types are not currently  allowed through the memory range
>> validation done by the EINJ driver.
>>
>> The MMIO address of a CXL 1.1 downstream port can be found in the
>> cxl_rcrb_addr file in the corresponding dport directory under
>> /sys/bus/cxl/devices/portX. CXL 1.1 error types follow the same
>> procedure as a memory error type, but with param1 set to the
>> downstream port MMIO address.
>>
>> Example usage:
>> $ cd /sys/kernel/debug/apei/einj
>> $ cat available_error_type
>>     0x00000008      Memory Correctable
>>     0x00000010      Memory Uncorrectable non-fatal
>>     0x00000020      Memory Uncorrectable fatal
>>     0x00000040      PCI Express Correctable
>>     0x00000080      PCI Express Uncorrectable non-fatal
>>     0x00000100      PCI Express Uncorrectable fatal
>>     0x00008000      CXL.mem Protocol Correctable
>>     0x00020000      CXL.mem Protocol Uncorrectable fatal
>> $ echo 0x8000 > error_type
>> $ echo 0xfffffffffffff000 > param2
>> $ echo 0x2 > flags
>> $ cat /sys/bus/cxl/devices/portX/dportY/cxl_rcrb_addr
>> 0xb2f00000
>> $ echo 0xb2f00000 > param1
>> $ echo 1 > error_inject
> 
> I have the same reaction to this as I did before:
> 
> http://lore.kernel.org/r/647817212bcf1_e067a2945@dwillia2-xfh.jf.intel.com.notmuch
> 
> Why is per-port error injection being driven from this legacy global
> interface where userspace needs to take information from sysfs and walk
> it over to this other interface? Especially since "rcrb" is an
> implementation detail that will be invalidated with CXL VH topologies?
> 

I get what you're saying, I did it this way because I saw this as primarily
an EINJ feature and wanted to keep it in that module. I agree with you though,
it's clunky and would be better inside the cxl module/debugfs.

> What I would like to see, since this is a new capability with no need to
> be beholden to legacy is to disaggregate the interface to be per-port.
> 
> For example:
> 
> /sys/kernel/debug/cxl/$mem/{inject,clear}_poison is already established
> for memory device poison injection. Why not add something like:
> 
> /sys/kernel/debug/cxl/$port/einj_{type,inject}
> 
> For triggering errors by the CXL subsystem device name, and unburden
> userspace from needing to deal in magic numbers.

I'll go ahead and move everything over to the cxl debugfs and do what you're
suggesting. Thanks for taking the time to take a look!

Thanks,
Ben

