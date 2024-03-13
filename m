Return-Path: <linux-acpi+bounces-4316-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5982387A839
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 14:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA811C21125
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Mar 2024 13:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8226405FB;
	Wed, 13 Mar 2024 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zVgDOMge"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1153FB96;
	Wed, 13 Mar 2024 13:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710336274; cv=fail; b=NZk+78DKfUh78xVK1hIJ1kFlt8xFiIeqTJ5dTEqjNL5Sz8vHqeKmJFjh7BsUww3VFjkIAnpSCzNfWTdDM4EDn05V5rRezNJWskTJnrbyKnRNEH5ddO7btGWCCFgePUCOagWcGXomFM8yoB+oLkffNbxkMOV3xXtwliwa6JrCAHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710336274; c=relaxed/simple;
	bh=itt/SIOkCt/aHrEuWea2LJglB12A/s1E/JUAaSs3EME=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FWXp65AVliUVtvmUtE2f2qdgahSyhsTXeEW4pB2rezLdRqgl6v6CzLPA+VRWcPf2o0bMm5oQKG6/heiyuDmthSeisUiFiZhejwjw3P9wVyHYSH+HCZxIVQRLM4UfXgwwtVHZepmbhK0xL+d5etx+x/yeIiTraNQ2fBOu8dUgqvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zVgDOMge; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUF+h+wRIK6K2QClDgnSoAQRKMryqwldWzM+IjnQiGyXKJ6XWIfUHRkh8zV0l6FbkTSBlf4mKljd3+ojl4h547dq6w7YcluqOjsMcipYtvL6ZLVfBbbLtLFPMI6q9qxWB6KV4Z43KEC2JdtQ4gjnBK4r8A6Y2Ys8tSs00VrQT4ch6/NRoADY8I9zH0mRldgDf06qdBT9bJX3O7GMoSws3G6NmIVxpyOsRPtCHoKL/p59wcfk4kRLvNaQBpeZLG9XcQ/UeTFdgaX45Pw42wmwHX2G5Yj1C67Z3ge8Fce5qmsc3ujG9EY/HCmA5K5O5L0XwWok+GnvTRsdXTumcjFeTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqRX2wGZudTmQVo6rwylbjlghvbsrYzKQ9U0p1U93Ik=;
 b=QphZG2mv6lPo6lfJz97n0khUyayzPQFhmKxENKxgTAUAgBLVdp1utqZnLHJpyshcpuP3V66koO1iu0CBBni09GRdiqigYzFLO3Tsv7ZgaNJSgX5aMAnT0paOjDfYnF+DZgWbe+alo/G8DGbwQUvEHkXvPRDCDCiW7y4pkPBjKi59Cbc/bHxZICzWiZ9Z/3BvEYATQo6vQn3YVKL3XPLcUAkT3iD7NP9zToZEl+5+5D9xShG/gMmfkFJsCiPotYzkfG2I8W7TvDxh2XUcBU4jOarXSrxv4XTHiSxDyYL0nHqQMxlSYedvrGobdWZUKpyyIUIjFLNv4khJqb4Sxbi0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqRX2wGZudTmQVo6rwylbjlghvbsrYzKQ9U0p1U93Ik=;
 b=zVgDOMgeeCFkxuzDH6FkJHxeZ/cta9H535Rxg/knlH3lYa1L53LO0gIfXWnhITjYpVvG6d2mLgAKmT2wHgpx9k/sUt4vYlgL2WDSIWPhYeEVPMfEDV8qEuYXyDAOPM4Y5o0PV/8/5xOEp558C5B6M7boHWuHrDp7nrYxglD5lBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 13:24:31 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 13:24:31 +0000
Message-ID: <8a78ef59-d145-4ee3-a8e0-702a2b084356@amd.com>
Date: Wed, 13 Mar 2024 08:24:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/4] cxl/core: Add CXL EINJ debugfs files
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240311142508.31717-1-Benjamin.Cheatham@amd.com>
 <20240311142508.31717-4-Benjamin.Cheatham@amd.com>
 <65f1411a184fe_a9b42948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65f1411a184fe_a9b42948c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::33) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 0126eee0-af7c-4ca4-df21-08dc4360eaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KTZsiMXisZa89EnoZTp0kSxusOlKUpr4znR+Ih9JLSpm92P+zrYgBfAbgxzmfRoj08cYg0W1H2+F//2fAs8DlGGJDwHwzp9ICZ0FK9xWXtKZeVHfjb+CaW0hKFdVzvsPu6V/bbMbLITyxvY/k9MZOhRcqKcuO431E/k8SIGpnPbIjh/OT1eK6Hj8MZ/imimFKxnFQX5NOxCVkkP7DOpmrZxBoWKkmC0p08bNnr5lo0O0xDxed4pAHgjOpGI5CWwl9A3xM1XDbcatMyJrNpWTc4wFIed9uigJMnvvi86vzhU9kt0x/3nAzGd4uMgRvn2Zu40vsjz6aWHMAGCbqDYMYAXaGV+Jwo7xT5y3THe5RpROgVSPFkoJfAClSbqBBfGC+DBrdljTPp+PCgAvUWI7+0xSqYIlvncEmB/5Y5U9hgSXY6tfPF47wN0w7+fusqHN8uSKkfx6n5ZZYKUMfyfYOJN3w2uFaUG9dmZ/1Mal3jgcPAkpNcveoAkIb9U0HSIhR7c6aIZg+eAfTNZsMAkHzsqGnzIXMOXEI5DBw5q+Xkj2A6bjFL5sOMHrOdipzYF7iLeRPCR2YpN8QLYAZABrdn/6ZCRIEL8jINO6vytzEUMEzqapX1uzD53CbIGj9j8+ZzlJ+6IhLfp1t0fqBrVembv8gEsUlB9J7EBRViI1pQ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDhzOUZmNlhCUXJkaHZoU3lDQ21xbW5DSUJQMWRYbUl2TDFIMnRxckFmamtw?=
 =?utf-8?B?aUNtSE92S2lyeFk3R3FYalltVGhCUDJzcGtlcEVNcDNNWllBSW0ybVkwOW96?=
 =?utf-8?B?SGdYaC9iR0M5b3Rua3VOZnhKaGt2U2JrbEtaL0RBUkxWZ0g5a0RyUmNielFs?=
 =?utf-8?B?KzBQQzc2ZUo3dkhXWm42ME4yblV5M2dpdWVlZ1B4aXE5WUdOTnFKbGliK0Qv?=
 =?utf-8?B?dDJMQUNwMmlDMzdYaE1OMkxpS3NXVUtZL2dKTm9nb2VMWFdqeFdiQ2Zid0VY?=
 =?utf-8?B?R2ZYTEFrZGxPeFlrLzVJVjNQbjd2bkN3VlhZSkNjekYxYllpZzdGcy9DS1F0?=
 =?utf-8?B?MHpvSnR3d25Ua05CRGY5THh0NjlRMmh0bTAvS2xSdTVBMWlHZW1tSnZMMFFy?=
 =?utf-8?B?bjBRN0d1ZElYZnhXSldjcmxyNitwTHljRXhXdkJON1BPUzRzc3FZemxHRHZO?=
 =?utf-8?B?VHBVYjNhTmFXZUl4anVKL1QxNTFxNnFOVnV3Ymxtb0hOSWg2ZlB5dVJIUkNh?=
 =?utf-8?B?endYS05EWDdxVVpvRTloemNMcUcrd2UwTWhDVGRyZHNIVFAvN2pKZlpXS0lI?=
 =?utf-8?B?YVJITUJObzh1QjlzdjRLbXJtdnlRZ2JKNGFnMXNLcGF0MUxlSUVKU3UvMDZR?=
 =?utf-8?B?b1Bub253bW44MUxJeGVydFZ0U2hMMzVzbXBFZXhEYlZRTkd6U2RhQ2hNVGpa?=
 =?utf-8?B?OStyaGRqbzhpSFNiRjFJZDZaVy92NndxN1g1RTk4aFRMT0YvYWlCRVRwV054?=
 =?utf-8?B?Ti81OXhpbVd3ZU5qMyt4Qzhac0UydmZoOU5RNDFYR3FXb3YyQzB0bHhnSWZG?=
 =?utf-8?B?UHA3Smw3ajYvQ3FOQUFDZDREUnlEQlNQTGZ2Z1l3dFpjYjVLVWJPazh1cjFB?=
 =?utf-8?B?M2tGY0REVTNpUFRWYWZ0dXRXYS9vTmNzaThoSXIzczNPbktmcExVV2pTa3ZZ?=
 =?utf-8?B?NVNpdkozRmVTMGgwTWNBMTY1ZmZmYUVTeGdiM3dJWkFBUmh5K0g1UzZra3Zo?=
 =?utf-8?B?OUllMjBqOVpldFllZy9VUDQ2cGpPZW5oNmg1akUvdFhXZHVBZ1RxWHJ5bFFL?=
 =?utf-8?B?Z0daSE5mODdrODg2OHpSK0s2WWNLWHpHS1pubDl1Z0NDT2UyQVVGZmVnQ3I1?=
 =?utf-8?B?OFZoQlpDbnV3ZkFzQjBxRVQwNE1VTklkKy8wbkFMRGU1S29HcVZuc0Zybkpx?=
 =?utf-8?B?OHNTNG95bzBKUGtiQWplWmNmcDk4MHBkUnhTUThLbUNHWk1CS2hhMmlZYWx6?=
 =?utf-8?B?ZnJ0MkpCZmxJZXhxZDFadTBYcUpTWWlKaUtxSVAxTm50Rk1TQnREK2JXTUxI?=
 =?utf-8?B?K0o4eVh6STJtUmw5NVBHN1kyWTVkL1NTdGdSSzFqK1Q4aTYvSWF0MU8wRGs0?=
 =?utf-8?B?Y2I4QkpHcEZiVy9iMnhVM0VXeVN3WmFaWlZhdFkzZmphVHdMSjNzWUdMbXYw?=
 =?utf-8?B?ZTJwY01LeFFUV1oyVHlRaUNmb1JUUzFRUm5ucXpVRmV3L3RCbytpMVdXdDZU?=
 =?utf-8?B?QUlZSW1hbFViaXhTQjJSWTBGK0l3ZmhlL3Q2WWJtV1hlUDd3bUtTbzdTU3BI?=
 =?utf-8?B?b2xhcm1Ybm9tQnRLbDZqajZ2QWN1SDJ2TENiaWxnVEl2V0l4MUw1YlduaW5i?=
 =?utf-8?B?OWlIOElib3dHY0VaT084bTJzRHh5RDM1RzRYdHYrNUMyQlF2OXpXWmEyLy9n?=
 =?utf-8?B?aWZEVnlyZmtvb2xpbGxGZUpqR2FSZXdTd2diVWRNRDlBU1JPNEhObkNiMzRu?=
 =?utf-8?B?YmE5RkY1bjhEdWJzOG52TU1yZWcyOW1KTlBISTVNcVp1ZlA5NVF1djVFZkpt?=
 =?utf-8?B?RXUzWGRCbDJ2WXAxMktOZFhWcTVEdm9CY0g0MHVMNTJ4TFRKazZGQkppUm5W?=
 =?utf-8?B?eHd5MnZvU0p4b0Y4KzhHLytxR0ZmdUJuQUhvRU5jdGt1Wk9nUnc3OUtPUFZU?=
 =?utf-8?B?L3ZLMCtEMmI5MzA0L3FUUzZ0cUdEVUthblRkNXluUmdjc0NzOHQzR2NDbHZ3?=
 =?utf-8?B?RWFFWnUyYitCREh1Qy91d2tYUGN1WVZUaWZsZk1MRzRlTy9yQ0FvQkVxaGd3?=
 =?utf-8?B?SnJOSXpEY0o0N1FTWnVzbVVxRkF2ZGk5SnhpMERiRkVJczA1dGQwejJSbE1G?=
 =?utf-8?Q?R7V0wGiHa3I+IqSAWuR6KOQaS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0126eee0-af7c-4ca4-df21-08dc4360eaa6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 13:24:31.3820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeHxJGjlFvth0v2QoYEeU8dYpltjV5ittRMBdvOlexOeGXNSN26jDTow/BwZ2fVVtsj/TGYTuxdXZc4sbs7RIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320



On 3/13/24 1:00 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Export CXL helper functions in einj-cxl.c for getting/injecting
>> available CXL protocol error types to sysfs under kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the einj module. The
>> kernel/debug/cxl/$dport_dev/einj_inject file is functionally the same
>> as the error_type and error_inject files provided by the EINJ module,
>> i.e.: writing an error type into $dport_dev/einj_inject will inject
>> said error type into the CXL dport represented by $dport_dev.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> [..]
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index e59d9d37aa65..eeeb6e53fdc4 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
> [..]
>> @@ -2221,6 +2258,11 @@ static __init int cxl_core_init(void)
>>  
>>  	cxl_debugfs = debugfs_create_dir("cxl", NULL);
>>  
>> +	if (einj_cxl_is_initialized()) {
>> +		debugfs_create_file("einj_types", 0400, cxl_debugfs, NULL,
>> +				    &einj_cxl_available_error_type_fops);
>> +	}
> 
> Checkpatch was ok with this, but went ahead and cleaned up these
> unnecessary braces as well.

Probably a remnant of debugging, sounds good to me.

Thanks,
Ben

