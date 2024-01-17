Return-Path: <linux-acpi+bounces-2915-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EAA830ACC
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 17:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216AF1F27526
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 16:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE532231B;
	Wed, 17 Jan 2024 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zbNQPt0a"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4E223741;
	Wed, 17 Jan 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508114; cv=fail; b=nNKV4HO55es2peeQnj3R86bg2D04epTEvxKFO1r5M75yonrYLlYHLbiCOWe2GNaUmRN7YHBVR191oRUSET8j90gafzWWvBk5FpI9u7TRaBREgoen/SDzi9cVrQlr5fnjb39uA2GK9NhjMy5hGKAAKjQQNb2M00TH+g/zT+hfWA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508114; c=relaxed/simple;
	bh=T0rUgQ8QYPRaR+Ao2ZrX56d9hZOcN1OUbA8mn/8VDLc=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Message-ID:Date:User-Agent:Subject:
	 Content-Language:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=tgXbLLlp1MqrQrc/a6NXBz1AT2/a59Z6AdN3Fp14Jv1gpIl7qEV2LQwBd16avDLOiTAIK+wesm/0HKvpEncetoTr28Oyf1JDbZycPnaifqaXeZdaJmW7hpHa6NW/Z4/bdquNRH8QZUedzNEEiObzZnTIFNBbiCmAAUXlJNwSGbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zbNQPt0a; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6wPm3BscUNgfyPBYUnyL5XnDBCvzTzV/libmw3aXdr3a4Kek1pgQ2QKG8MHuvdSv/B4F2yq2SoXXQG/923YuyxhoCiXnY9OyDKp0hdbLoyG9L3C6odoWQOS4kEMDKCLUQIoO0/ue5tcA7TMhwhfWCPn2tFKjulBJ4HDSItSOvXukqPyydu4uTILXY4E6U1hbPCBJD/lQzXKXh9p88yH14qxDoLCjGGZla1VbR6sMCPaX6yBPeH0V1jsSzZLMQwtBVgxQU6e41lcUwGKjYTMAu+dJoPcGgk3c5ppPiYQHbI46kjVQb3g+cL3c/uX1sTAK9VEq3Gj5ykrj4SaRvqhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVvU0kyovdTvgRIX4Uu7jacF9acApEePJeFmMoE/KS4=;
 b=Tp2CY+Vinfvl33pjwTF/BZ0q/DMPqmdtzItvayHNXiUcWpbL9HDfGBeBJcANAQmGsSsKiNPCeeedzGk2sd8pL30ZStjV5sYLXLlnILBgWkoiQ9k0z1Zua/RNG44WhDvJiRav2cFrLlld7SXt/Zi5kwIfcigxtn5844VrSIgS0rMJZ5yQJ0yXJqePCuhkRJYxti0YuzXZQEGks+nN2Oac4kHhe2veEr2FsE0wymn3CX9YNwXLrMJFhG3Dj2UmDJFGBLChzKWgcytcyfv7N5y53nnrpcUtoCxVZokrEqkA4XWoxljsJzrFMq3zf9dvOIzrBxKGxjKXymN8Cb9OUk694Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVvU0kyovdTvgRIX4Uu7jacF9acApEePJeFmMoE/KS4=;
 b=zbNQPt0aWkNuYd9XQJLxfYkS0rxbscXgK4HaX/fehvKjZ2/RsBQwnzYHaeDTKDSUIgU+2jG452hYs2aPoGuXTcoF1RHRxqnQaLG3bqxWhDTPl5THcLkseBS0U7BGgTN664F2z/N6OnOCs4VO7ANUAknuCFsvF3aOXodys/Qqr9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 16:15:10 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 16:15:08 +0000
Message-ID: <fda7e3d8-c5d7-48c8-bf75-bc11af9455a8@amd.com>
Date: Wed, 17 Jan 2024 10:15:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/5] EINJ, Documentation: Update EINJ kernel doc
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-6-Benjamin.Cheatham@amd.com>
 <65a717cf9d6cb_3b8e294ec@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65a717cf9d6cb_3b8e294ec@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0246.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::27) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6491a3ac-1444-4a40-3cae-08dc17777949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	stCG/Jk9Ji2fLzlPjX3I5hTtZbdUEEtRDOFPaMOWsXgMqMpT7HA1Z+Sophir9MTxim8cpyNR0A6r64DMc+bPSl+r895/qzt+kDZRjI7PmN/kwU/bTUpW9FqgmS+etief2n0l37zm8LFdp2uTiPrWqPxyoOXkwmB8uabNg3DF1kZ1G82MhEvlnAkTte+9gkKWaX8aMwI1QluORutJmRU4HGHufd+84i+2b2IYW1uo1fdkTXuR5cymMAbcGMwOGjzud2WbrYNOlj2Bjbuvw2DZdc705dV/lCz56pBnrKjRTyhC/5Ud2B4px4psvZkzD3q8cJnAgKe0z04wDrF8aA5ykIaKx9BSAiYH8YYlI0xPBU5ndc2mjPWAd1h+Hzdd/gs5qYwmWuC2C+61bcKmfiMa5LWcWc0q/SzCg6UOC7ps1RCuTDl6HzribyfJhJ5YVOUGzK4XL1BDh02sykfxu8fLEzbYFMbhGpK52yKp2LtbDeRK1XhkBypEIlSF+mc9Pl+un0R4M8ITvoSTx0j8EmXhsQr266ZMDd4ouVau3xaLq/fTfuLNzevq/5IepdEKLGaXk+zB/1F2hUaNYYKADC/DQC9zgdNLaxBkbxvbNaEfC9DBKtZ3hqgSxnSG9n+DnxEgC39Pfk03fE2DKubQnWEy+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(478600001)(5660300002)(15650500001)(7416002)(4326008)(8936002)(66946007)(316002)(6506007)(6666004)(6486002)(19627235002)(66556008)(66476007)(8676002)(6512007)(26005)(2616005)(38100700002)(2906002)(53546011)(41300700001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JLMUdEOS9WZzFaWjdCYkQzQjFTYzBFck5RcENmY0crdFpZOVZvNUhpREdk?=
 =?utf-8?B?R1BBNU95WW9TclN4VVlYQUZweVVNdUsyQ0g2U2JFdy9zTlVGTytyMXlzZkxX?=
 =?utf-8?B?TnBWU2x1MXJ6NFhaczVaNzV2aTJTZzV3V3FoMUsvSGRjdlFYUG4xTU9OdEp5?=
 =?utf-8?B?NmZnOUNlbm5XL3BkbCtmaXpnSW9jOGpvd29aeHp6QzdXOEVZQTg4bGtPR3lk?=
 =?utf-8?B?dnhIeVNxc3pIdWRDc25JczFJaGQ1dEQ1UGdCdlVKSDFJT3RkNTFCRjJBVDFl?=
 =?utf-8?B?TW9sSU1GRW9uMU1OYXpyNkZicFp0ZUxjUzhrNTE2Sm1QMzBlelRZNHdmRnV6?=
 =?utf-8?B?QjJrY1JyQW1uOC8xYmFEUDNqZURDZXB1dmp4VExFT0hydDNtR1lkUStTU2hB?=
 =?utf-8?B?RjlBMWlRWlZFc1VaaVNGMlhYeXVLQm52UThqdUZDdjA5OG1IVGR5bWtZdFJQ?=
 =?utf-8?B?UVZWSENlNU13dGFycDBwdmJvNkY2cjA5T2NWRUdpRUt1RGxEcUtET2EweDFV?=
 =?utf-8?B?NTlabGtoZWJkamdOcytEOUYwV1A4OVhzVHhmb3hFTEtZbVJkQXNzWkRUdE9p?=
 =?utf-8?B?SWE5eFZFN25tdE1QY2ZVcGJ0RmEvNG5xMzliL3IzRG1KOHhud3dNc00raWs0?=
 =?utf-8?B?Ylp6RVM5NFVuTGgxV2YxVWFGQ1NLZld4U1IrVldrVGd3TjBubjN2RVJQUGx0?=
 =?utf-8?B?azh4bzg5ZWIyVXhZNEhNZWZBbHBzdFpHMHZ3RWJVRzZpOGZDak1ub29KcmpO?=
 =?utf-8?B?NDM4SnJYeDNUSnk5R0dFeFlIUVd2NmhUcUY1WDNWWCtqeDgvT3pIMXhFbTFi?=
 =?utf-8?B?YTFreTR0MXQvMFJYSWpldnVuQU5LSU83T1JIMUdzTFFyck9jd3lCdWRIYnhI?=
 =?utf-8?B?OVZ5dHJrZkFJeUcwMWhpM3pQV3M1ZDNLWjIyQWx3d0ZWakhjUXE2eVd4YUh6?=
 =?utf-8?B?d0tNUUhJbWFyTktDcmxobXZGOW5xY2Q3WWliSXZWaTdENnBxTEMvNjVRSmor?=
 =?utf-8?B?ZnJYODVtb3BtUVRHNjBqdlI5ckVRUzB5bHBHdXlaYXZ2WXd0L2lHd3hWREVq?=
 =?utf-8?B?ejRsOVh2Tm5MeG5NVkNOcThKV0FUQythZmlicDFIQVNndUVEK3VrMEZVVE85?=
 =?utf-8?B?YW1jN0hXT0d3Zi9iR0tJL3VNdktWMHd2Y0daSmRPcHZNMXFiclVWOXkydXQx?=
 =?utf-8?B?b2MzVllLS0pZdzRqUWZqOHF4azNaV2t4Ti9XakdLZXpsRGZnZXBaYVVJSXQy?=
 =?utf-8?B?UVQ2dDVXN3ZLWmh6Tm1MMXJTUjNmMzRLVkJRRWQ4dE5zcTlDT0lzTTViU2E3?=
 =?utf-8?B?Yk9VdEt0ZXczVHpqTmFyZ3crV2FOVUgvRnJiWWJhQThaYXZYN3JKazVaTkph?=
 =?utf-8?B?V01BYTVYMy82YmdJdmxJR2JuQTlscC9MK3RFRFFob0FEem5YVXRqZS9JTkVI?=
 =?utf-8?B?NjhhKzRURkhrdUpzVEluK1NDV1dXWXkyZThuaUNsNjQ2d0FsRER0SW5GQUY4?=
 =?utf-8?B?SEhwek9yMEVQUTc0UWp5WVVZUWE5OW11RkJuUmxhZlVONlg1dnBuRkExc0tn?=
 =?utf-8?B?N0lNY1o0enFtcjRUUTgxUEoxWEtVa25iVVhNd3RRNytVaGJZQXNGQ1ZJYWh2?=
 =?utf-8?B?b1VzZ0phNjZJRko1NENYUWZxaml6SVpvTnBFSm8vNE96UDVRL2dkZVovN0Jt?=
 =?utf-8?B?VkFJd2xOVWF3K3JWN3NMOHVsVGZURmRsME9hQ3NaZXVieFJ1QWV1cHptVlVw?=
 =?utf-8?B?dXErYzNhT2Z1RnV2NjJGUUl6OVg1ZDI4MnV1YlZVazY4N1NaWHZoMUV4bUpR?=
 =?utf-8?B?dTJwckZYMjFzUC9aVjFQM3lpRXgwaVJVSldjZ0REWjVrUUcwdC9iVEo4cGxt?=
 =?utf-8?B?QmM2UHBFWWV2bkRvLzZUZTYrOVV6ejZscDBTQldWbUtsMythZlhTSkg0Mm1E?=
 =?utf-8?B?bEMyaVNGdkFaZWVOZm1lNnpFMUpVT1N0T1pMVDV1SlNNZUVBeGRLUDN3cHpK?=
 =?utf-8?B?Y25mSm4vNWw1WXlPSWJXOFdoNm0xQ0ZodUFsVHFOQVd6dlRCR1VEZXJrOG93?=
 =?utf-8?B?bWJhblZ3V09CZnhBSUxWSEU2THNkbmJtOERic0lxd3FEOHdRRVFsNG0wSEU3?=
 =?utf-8?Q?nngP+larOIs8HEoKBkSrc1KrU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6491a3ac-1444-4a40-3cae-08dc17777949
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:15:08.4453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lXMF9OI4m7Prtguy1wlyu2mP8uJdNgjWU7H+I8m6S9zKERoi7UXcntUegfUhQsu6/bodaaZC5mx0JUC7pE/Z1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512



On 1/16/24 5:57 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Update EINJ kernel document to include how to inject CXL protocol error
>> types, build the kernel to include CXL error types, and give an example
>> injection.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  .../firmware-guide/acpi/apei/einj.rst         | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/firmware-guide/acpi/apei/einj.rst b/Documentation/firmware-guide/acpi/apei/einj.rst
>> index d6b61d22f525..a8f26845682a 100644
>> --- a/Documentation/firmware-guide/acpi/apei/einj.rst
>> +++ b/Documentation/firmware-guide/acpi/apei/einj.rst
>> @@ -181,6 +181,25 @@ You should see something like this in dmesg::
>>    [22715.834759] EDAC sbridge MC3: PROCESSOR 0:306e7 TIME 1422553404 SOCKET 0 APIC 0
>>    [22716.616173] EDAC MC3: 1 CE memory read error on CPU_SrcID#0_Channel#0_DIMM#0 (channel:0 slot:0 page:0x12345 offset:0x0 grain:32 syndrome:0x0 -  area:DRAM err_code:0001:0090 socket:0 channel_mask:1 rank:0)
>>  
>> +CXL error types are supported from ACPI 6.5 onwards. These error types
>> +are not available in the legacy interface at /sys/kernel/debug/apei/einj,
>> +and are instead at /sys/kernel/debug/cxl/. There is a file under debug/cxl
>> +called "einj_type" that is analagous to available_error_type under debug/cxl.
> 
> s/analagous/analogous/
> 
> Other than that, looks good.

Thanks for pointing that out!

Thanks,
Ben

