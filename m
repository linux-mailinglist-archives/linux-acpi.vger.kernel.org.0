Return-Path: <linux-acpi+bounces-2234-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFE380A938
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 17:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFC91F20F09
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A805F38DE6
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M1ZGAHKv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E958123;
	Fri,  8 Dec 2023 08:22:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BodccBeqAH28iqlWsU2sjj5eNbAmzZ7UDFYgkTEd0v8AUn9C55ZbNk3n2oByitUL3L2NcV37H67ZZSWMVqpIwCDE9B7IU2dNGHELZbZ/x0edeNeCwxyk9YpUkPSJXNZWLwpblg++sQv4X+8UV/G/2IFl6TLyeWdEkxSGKPl06L25qAYGOUdptnQBuYGQV2pGNhBkP90naLNcY1t5vB00QMQgToUWoIfhUQlES3MuKIah5FPs4VYa+J/OQ10eNJBlL5HRYNCkl/Owus1+T9ovWGuH1uA5gbmLDHR+v26TGFyTZzzHH6QmaplOFVEeSVsy4EVEH+3DHNJ7gdicx1Nvrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vk3mBh9BdWe6r126zEs/5SwjFDjk3AMq29LThutm82I=;
 b=Mr24J9I8niA+EASHbkAkBScPvjjUWAylZLCa/tdowOqJkm5q90Ie49HdG9R+58kQYW7X7wN+UGmRiuJrHFTYZFZty+ENtFcULyQIZrGssXoy3JyZDjZ8KeYns+kRO6o6Y56S6IumpnVJ8HtxzARQPRk8TaJ7T4uI5bcz07sMdCoqxvB7ExUkrvFhsUmK6M5+jowSBMx4m7u/31PkTvVk9V2qby8SkbGiRmlZHCyAyU1Ax0u2LNL395TDT1alWNyjrDVjHG8gYdyrFe40l1hI81e/Nv6doD4E/vaMcdJj+lWjuyNPHNTmPMbqbgjrvIbAXfYF5i5VxN3FnNFSrBI9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vk3mBh9BdWe6r126zEs/5SwjFDjk3AMq29LThutm82I=;
 b=M1ZGAHKvEsUUgX37PFSGwvrMMjF0YkCJpnv/KhYde5/q90Lz0RDQ9MT8OAgJtBI9M6vhcjRDG4PVDDJaC4qnAYNRf6Jud6+rlQTAufKnsGxAFBmGYc6rM3vkuM2QeysUUquWT6P3aBG/tRKLa9MoEl8CkgBeAkUF0cGDAaFeeAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3268.namprd12.prod.outlook.com (2603:10b6:408:6c::18)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 16:22:27 +0000
Received: from BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf]) by BN8PR12MB3268.namprd12.prod.outlook.com
 ([fe80::ff1a:dd7c:4c93:d8bf%7]) with mapi id 15.20.7068.028; Fri, 8 Dec 2023
 16:22:27 +0000
Message-ID: <359bacbf-94d9-47b8-915f-dbf321cf0a9e@amd.com>
Date: Fri, 8 Dec 2023 10:22:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/5] cxl/port: Add EINJ debugfs files and callback
 support
To: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: yazen.ghannam@amd.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20231128160656.166609-1-Benjamin.Cheatham@amd.com>
 <20231128160656.166609-2-Benjamin.Cheatham@amd.com>
 <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <657251b0517bc_45e0129418@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0068.namprd04.prod.outlook.com
 (2603:10b6:408:ea::13) To BN8PR12MB3268.namprd12.prod.outlook.com
 (2603:10b6:408:6c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3268:EE_|SA0PR12MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6359652d-7253-4724-78e3-08dbf809de77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SgUZjTo39xE7mXMkeoECyV+V6vhWPEQ9P4XUA0lfFDuDBjXbBumrQbRjraFVVs0cicMymgFdjHXJP6BRiHwWhivVtfpg74byCKmcD41GGyhjY+l3fJN9NJQBNLtuqPmK5HkKwxh0M73remnxfb63un5xsopbV3WDWbdDoEgRXVCMKZccji59PiVwdCaD+NKCvOYENtC4P4mlnIfPYSGS6IrXwesCLwQDVECV6JQRUapAioLg3VnlRv0db1QLMJ59TuvvDkxEUOf1LPlrjV8w9CC3cWx9H0j53xt0LzXb+FPNCc7Ju2+5uqrCHJ6X8n7Qy+qFWQJsjTqFFOkmZNiWUh/RuS/r2RgLtfUFJ233U+3VSbJ7aWupXJWpY624xQjXC+3wNFw+xt/n8aNeK40U5o+3feTwM42H/abkAvIfAh8UzfiTzIYrvZCEiW28n5PECrFIM0Ur+qU/17HumD40jcQDQLO67M6eea8OocSJyNzwxqmB8ZKGz+gMxZyABK9K+QuR16k9l8HuVLDnzxofr5fmmSvjkBi6cUvGlUrBWRDlt4bGEUkPEMerlR83BDaqmu4QLL14z7IrTmwJqO2vj7jkij/l0QSqz4C2MDe4oZxqrbkyAPaZd8aZ+RPjVk08X+fB5swJESDJxCB3WrKbFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3268.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(31686004)(26005)(6506007)(6512007)(53546011)(2616005)(38100700002)(86362001)(31696002)(36756003)(30864003)(2906002)(8936002)(478600001)(7416002)(5660300002)(41300700001)(8676002)(4326008)(83380400001)(6486002)(966005)(66946007)(66476007)(316002)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25UKytpTlpMNEg2MG1oaktmc0hJQ3M4M2MwWFZpNTNUQjd1N1ppZjY1bzNY?=
 =?utf-8?B?LzJzbTZhQVJ1Q3VualFSL3g1NkVOa3FINlhmejdLUjAxQUZxWC9CQUtobHRz?=
 =?utf-8?B?NmRnL1Z2ZjQ1TE9YU1FKdFU1MkswMURKR3dzRlVTSmRseTNNdDBESXZyWHR4?=
 =?utf-8?B?QmxWTUpXeWN5eDZzd3lIemYvM05mL2hmRnh0MEM1dllJY2VIY0JISklCV3du?=
 =?utf-8?B?amhtbEQ0eHJkVkFMY1B2anpOQ0lXYkg0UC94VUlvRzNpY3JNbTV3QjBBUXpo?=
 =?utf-8?B?TVZHRVF0OUZqYy9NcUVPeVFBaXVCVlZiNTRDY3hydC9IWnBtOGpya0ZZa1FF?=
 =?utf-8?B?eEt1Z3pBYW01blRIZkNzdkFkWWRyZmpVRStWa1Y2OXV2dU1yNnNIMGluRHJn?=
 =?utf-8?B?NVpLWVFDaE1UOHZqOFIrbVNyQXV1cldJRURDNEw0eEdkVDdqWjJzQ3ZuNGNM?=
 =?utf-8?B?OTMzNTJOclM0dEdSN2RzOHdQS2dLdlhaU2F1RGR5ZExnTFhheWZtdkFWN3A4?=
 =?utf-8?B?OHp1N3pTMzJHSS9YM2ZQV2t1bnFxOTZoOXRtYnptMGIrclhiMnoyVXZwa2oy?=
 =?utf-8?B?aCszanpCMHFPOVAxTjkxZ3pxVjZtaGkyNmxYU2R4WDdyWmZ1cjhEZ1NpQStx?=
 =?utf-8?B?U0lyZUwxTVJLNGY3S3FhalZBdVhOQWlyb3JlM2ErOE5PVTA4NmZKVFJYSG9y?=
 =?utf-8?B?RDZwRW1MTjBXS0NpMjBZTkUwTEQwWGVJb0YvVGEydGg2R3lqbnZwYzA5Uk5N?=
 =?utf-8?B?L2xJUFZtK1NPS2VaNllPK2JFcS92VnArcFlXUGczSElOV21KQzBOMGF3U2ov?=
 =?utf-8?B?d1M1KzFPQU5Ua2djUVZPbmgxbkpHakpGSVZQVEdsdC9kNlpZWXRsYzVSS3JR?=
 =?utf-8?B?TVZEMkl6SWtGU0FReU9FM28rTGFYODhnaVRKaE9ZcnA1WlUrNkZ5SG03YXoz?=
 =?utf-8?B?OVBHZnRJVGdKRklHSUlNWmdaRmJzOHV4L3F4WDNMUDlpSVlLUWRHQUtjVVpa?=
 =?utf-8?B?Y25hSFFHTXBvUDcxNXQrb3Z2OUIvTlNHMWRxT2U4NVJxTTRNdXZ6dGl3eWYy?=
 =?utf-8?B?am4wVDdYU29DY2JPdDdOcFhKelVsMjNKcnFlcXFUay9kdzVqMXNselJDRld1?=
 =?utf-8?B?Q2NhckU2YTJ2ZU1sVmtRMkhIdFk5OXJDUmZUSVVGdDZkVG55aXk1NUo3OWpF?=
 =?utf-8?B?YWtUNmRReGQ0WWhGSzVIQng5cFI5VU9QOXBKY0ZoSDR3cWM0VEYzTm1wTHpu?=
 =?utf-8?B?QU5WZVIwcVY3cWlVVDdBeU5XV1MveHFyWjhhNzRESmNOTVZKYnFzQ2NsMllu?=
 =?utf-8?B?VzZ3cnBvUTdwQS96VnNlLzJnTWI5aFVMWjladjUyUWxZbVlpZC9PbDZIRnZO?=
 =?utf-8?B?Z2lNeVdqYjhwUmFVbXZUSmUzdGtUK0ZPLzlUM2Vtb1dkcllhelN5QjFKMXNr?=
 =?utf-8?B?L3owcjVzN21CUERZUEM5cWkvckFVMk1KRDhZYkE5cVBGN2NzY1F2TnRoRGsx?=
 =?utf-8?B?M3lwVTBTQUNaSnFOQUdmREREejdMUFpTV0xoQVhBdEZTdW1xRldjejVZNkNL?=
 =?utf-8?B?QklEUy9aRGZtU0RSanlKcDlxb0k4SGthTjczS2djeFBRaFNNRnhKNnl1cmhQ?=
 =?utf-8?B?d2M1dDI1R21ramphNmQrN21WMEUrVzRxWVh5Sk84eUcyS1ozUnBRMWpNL0Fv?=
 =?utf-8?B?dlM4Q0puL05RSUlJdFFqQ2VQQ1dXL1ViSGhaQXhWbklEODRxOUhYWWZhZ0k1?=
 =?utf-8?B?YzZyMEcwbzdLWkpkUjc5SXNTRDZHbDB0WnRFL3paQ1R5dG9QdW5HeG0zY1JE?=
 =?utf-8?B?clVYeHdwK2lwU3ZRS2p3ZGRrOXBWNkRmYjEwSW5DalY5UVI3cTZsWGtxelRR?=
 =?utf-8?B?aVkvbWhBL1NKODNoa0hGNEUyMEdFMG1nOWo4dFhqK2prL1VoOWFoYU9qOTJN?=
 =?utf-8?B?MWxmd3hpUXNLTC9idHR6UGRYcnRCODJWQ0c3TC80dnMzRnZTRmpnS3lrV1FB?=
 =?utf-8?B?Um9DeVdNS2hGN25uYmY0b0Qydkl3R2ZhMlh6TTJiN2RwS21iajFkN0lIaHZZ?=
 =?utf-8?B?ODJLZEJkYlpKb3dmVXNTMjU5SXZnTjhWMlpvMlArTVZxYk8zanRsY1FaSG1U?=
 =?utf-8?Q?gR5KV9xtnm8zrF0WHRd0DZw3m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6359652d-7253-4724-78e3-08dbf809de77
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3268.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 16:22:27.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEBk5GYw/uXDfLePIAbgtf9ZKqSpjPIjzdN57BBFlp4jBnBmnel9OxtcQTMYgCpyPoc7pdhLQS/xfLPZFyaZmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525

Thanks for taking a look Dan! Replies inline.

On 12/7/23 5:13 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Add creation of debugfs directories for ports and dports under
>> /sys/kernel/debug/cxl when EINJ support is enabled. The dport
>> directories will contain files for injecting CXL protocol errors.
>> These files are only usable once the EINJ module has loaded and
>> registered callback functions with the CXL core module, before that
>> occurs (or if the EINJ module isn't loaded) the files will do nothing
>> and return an ENODEV error.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  Documentation/ABI/testing/debugfs-cxl | 27 +++++++++
>>  drivers/cxl/core/port.c               | 84 +++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h                     | 10 ++++
>>  3 files changed, 121 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> index fe61d372e3fa..782a1bb78884 100644
>> --- a/Documentation/ABI/testing/debugfs-cxl
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -33,3 +33,30 @@ Description:
>>  		device cannot clear poison from the address, -ENXIO is returned.
>>  		The clear_poison attribute is only visible for devices
>>  		supporting the capability.
>> +
>> +What:		/sys/kernel/debug/cxl/portX/dportY/einj_types
> 
> Given this file is identical contents for all dports it only needs to
> exist in one common location
> 
> /sys/kernel/debug/cxl/einj_types
> 

Good point, I'll make that change.

> 
>> +Date:		November, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Prints the CXL protocol error types made available by
>> +		the platform in the format "0x<error number>	<error type>".
>> +		The <error number> can be written to einj_inject to inject
>> +		<error type> into dportY. This file is only visible if
>> +		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
>> +		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
>> +		modules to be functional.
> 
> This can be simplified. Have something like:
> 
> config CXL_EINJ
> 	default CXL_BUS
> 	depends on ACPI_APEI_EINJ && ACPI_APEI_EINJ=CXL_BUS
> 	...
> 
> Then the documentation moves to Kconfig for how to enable this and the
> CXL code can directly call into the EINJ module without worry.
> 
> It would of course need stubs like these in a shared header:
> 
> #ifdef CONFIG_CXL_EINJ
> int cxl_einj_available_error_type(struct seq_file *m, void *v);
> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type);
> #else
> static inline int cxl_einj_available_error_type(struct seq_file *m, void *v)
> {
> 	return -ENXIO;
> }
> 
> int cxl_einj_inject_error(struct cxl_dport *dport, u64 type)
> {
> 	return -ENXIO;
> }
> #endif
> 

I had to go back and take a look, but I had a shared header in v5 (link: https://lore.kernel.org/linux-cxl/20230926120418.0000575d@Huawei.com/). 
Jonathan recommended that I instead include cxl.h directly, but that was pretty much a completely different patch set
at the time (and the header was under include/linux/). That being said, I agree that a header under drivers/cxl would
make much more sense here.

>> +
>> +What:		/sys/kernel/debug/cxl/portX/dportY/einj_inject
> 
> See my comments on cxl_debugfs_create_dport_dir() later on, but I think
> the "portX" directory can be eliminated.
> 
>> +Date:		November, 2023
>> +KernelVersion:	v6.8
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Writing an integer to this file injects the corresponding
>> +		CXL protocol error into dportY (integer to type mapping is
>> +		available by reading from einj_types). If the dport was
>> +		enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>> +		a CXL 2.0 error is injected. This file is only visible if
>> +		CONFIG_ACPI_APEI_EINJ is enabled, and the EINJ module must
>> +		be able to reach one (or both) of the CXL_ACPI or CXL_PORT
>> +		modules to be functional.
> 
> Similar comments about dropping these details that can just be solved in
> Kconfig.
> 
> This is next comment is on EINJ ABI, but you can skip it just to
> maintain momentum with the status quo. Why require the user to do the
> string to integer conversion? Seems like a small matter of programming
> to allow:
> 
> echo "CXL.cache Protocol Correctable" > einj_inject
> 
> ...to do the right thing. That probably makes scripts more readable as
> well.
> 

That's a good point. I can do that, but I think it may be better to keep the
consistency with the EINJ module to simplify things for end users. If you feel
that isn't a big enough concern I can go ahead and modify it.

>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 38441634e4c6..acf10415a174 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -783,6 +783,72 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>  	return rc;
>>  }
>>  
>> +static struct cxl_einj_ops einj_ops;
>> +void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops)
>> +{
>> +	if (!IS_REACHABLE(CONFIG_ACPI_APEI_EINJ) || !ops)
>> +		return;
>> +
>> +	einj_ops = *ops;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_einj_set_ops_cbs, CXL);
> 
> einj_ops goes away when the CXL code can just call the EINJ module
> directly.
> 
>> +
>> +static int cxl_einj_type_show(struct seq_file *f, void *data)
>> +{
>> +	if (!einj_ops.einj_type)
>> +		return -ENODEV;
>> +
>> +	return einj_ops.einj_type(f, data);
>> +}
>> +
>> +static int cxl_einj_inject(void *data, u64 type)
>> +{
>> +	struct cxl_dport *dport = data;
>> +
>> +	if (!einj_ops.einj_inject)
>> +		return -ENODEV;
>> +
>> +	return einj_ops.einj_inject(dport, type);
>> +}
>> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
> 
> The wrappers go away and DEFINE_DEBUGFS_ATTRIBUTE() can reference the
> EINJ symbols directly.
> 
>> +
>> +static int cxl_debugfs_create_dport_dir(struct dentry *port_dir,
>> +						   struct cxl_dport *dport)
>> +{
>> +	struct dentry *dir;
>> +	char dir_name[32];
>> +
>> +	snprintf(dir_name, 31, "dport%d", dport->port_id);
> 
> How about dev_name(dport->dport_dev) rather than the dynamic name?
> 
> The other benefit of this is that the dport_dev names are unique, so you
> can move the einj_inject file to:
> 
> /sys/kernel/debug/cxl/$dport_dev/einj_inject
> 

I didn't realize the dport names were also unique. I'll go ahead and do that instead.

>> +	dir = debugfs_create_dir(dir_name, port_dir);
>> +	if (IS_ERR(dir))
>> +		return PTR_ERR(dir);
>> +
>> +	debugfs_create_devm_seqfile(dport->dport_dev, "einj_types", dir,
>> +				    cxl_einj_type_show);
> 
> Per above, move this to be a top-level file.
> 

Will do.

>> +
>> +	debugfs_create_file("einj_inject", 0200, dir, dport,
>> +			    &cxl_einj_inject_fops);
>> +	return 0;
> 
> debugfs is good about failing gracefully when pre-requisites are not
> present. This is why none of the debugfs creation helpers have return
> codes because failing to setup debugfs is never fatal.
> 
> In other words, it is ok to take the output of debugfs_create_dir()
> without checking, and this function should not be returning an error.
> 

Will do.

>> +}
>> +
>> +static struct dentry *cxl_debugfs_create_port_dir(struct cxl_port *port)
>> +{
>> +	const char *dir_name = dev_name(&port->dev);
>> +	struct dentry *dir;
>> +
>> +	if (!IS_ENABLED(CONFIG_ACPI_APEI_EINJ))
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	dir = cxl_debugfs_create_dir(dir_name);
>> +	if (IS_ERR(dir)) {
>> +		dev_dbg(&port->dev, "Failed to create port debugfs dir: %ld\n",
>> +			PTR_ERR(dir));
>> +		return dir;
>> +	}
>> +
>> +	return dir;
>> +}
>> +
>>  static struct cxl_port *__devm_cxl_add_port(struct device *host,
>>  					    struct device *uport_dev,
>>  					    resource_size_t component_reg_phys,
>> @@ -861,6 +927,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  				   struct cxl_dport *parent_dport)
>>  {
>>  	struct cxl_port *port, *parent_port;
>> +	struct dentry *dir;
>>  
>>  	port = __devm_cxl_add_port(host, uport_dev, component_reg_phys,
>>  				   parent_dport);
>> @@ -878,6 +945,10 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
>>  			parent_port ? " to " : "",
>>  			parent_port ? dev_name(&parent_port->dev) : "",
>>  			parent_port ? "" : " (root port)");
>> +
>> +		dir = cxl_debugfs_create_port_dir(port);
>> +		if (!IS_ERR(dir))
>> +			port->debug_dir = dir;
>>  	}
>>  
>>  	return port;
>> @@ -1127,6 +1198,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>>  				     resource_size_t component_reg_phys)
>>  {
>>  	struct cxl_dport *dport;
>> +	int rc;
>>  
>>  	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
>>  				     component_reg_phys, CXL_RESOURCE_NONE);
>> @@ -1136,6 +1208,11 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>>  	} else {
>>  		dev_dbg(dport_dev, "dport added to %s\n",
>>  			dev_name(&port->dev));
>> +
>> +		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
>> +		if (rc)
>> +			dev_dbg(dport_dev,
>> +				"Failed to create dport debugfs dir: %d\n", rc);
> 
> Drop the debug messages about failing to setup debugfs. This follows the
> lead of other debugfs setup in CXL.
> 

Will do.

>>  	}
>>  
>>  	return dport;
>> @@ -1156,6 +1233,7 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  					 resource_size_t rcrb)
>>  {
>>  	struct cxl_dport *dport;
>> +	int rc;
>>  
>>  	if (rcrb == CXL_RESOURCE_NONE) {
>>  		dev_dbg(&port->dev, "failed to add RCH dport, missing RCRB\n");
>> @@ -1170,6 +1248,12 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>>  	} else {
>>  		dev_dbg(dport_dev, "RCH dport added to %s\n",
>>  			dev_name(&port->dev));
>> +
>> +		rc = cxl_debugfs_create_dport_dir(port->debug_dir, dport);
>> +		if (rc)
>> +			dev_dbg(dport_dev,
>> +				"Failed to create rch dport debugfs dir: %d\n",
>> +				rc);
>>  	}
>>  
>>  	return dport;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 687043ece101..3c7744fc3106 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -590,6 +590,7 @@ struct cxl_dax_region {
>>   * @depth: How deep this port is relative to the root. depth 0 is the root.
>>   * @cdat: Cached CDAT data
>>   * @cdat_available: Should a CDAT attribute be available in sysfs
>> + * @debug_dir: dentry for port in cxl debugfs (optional)
>>   */
>>  struct cxl_port {
>>  	struct device dev;
>> @@ -612,6 +613,7 @@ struct cxl_port {
>>  		size_t length;
>>  	} cdat;
>>  	bool cdat_available;
>> +	struct dentry *debug_dir;
> 
> Part of why I asked for the debugfs file rename was to eliminate this
> wart on the data structure.
> 

Yeah I wasn't that happy about adding it, so I'd be happy to remove it!

>>  };
>>  
>>  static inline struct cxl_dport *
>> @@ -813,6 +815,14 @@ bool is_cxl_nvdimm_bridge(struct device *dev);
>>  int devm_cxl_add_nvdimm(struct cxl_memdev *cxlmd);
>>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
>>  
>> +struct cxl_einj_ops {
>> +	int (*einj_type)(struct seq_file *f, void *data);
>> +	int (*einj_inject)(struct cxl_dport *dport, u64 type);
>> +};
>> +
>> +void cxl_einj_set_ops_cbs(struct cxl_einj_ops *ops);
>> +
>> +
>>  #ifdef CONFIG_CXL_REGION
>>  bool is_cxl_pmem_region(struct device *dev);
>>  struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
>> -- 
>> 2.34.1
>>
>>
> 
> 
> 

