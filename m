Return-Path: <linux-acpi+bounces-2914-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA73830AC5
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 17:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9BAB24F56
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 16:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA80225D0;
	Wed, 17 Jan 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wh40uxbW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA802233C;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508110; cv=fail; b=LaApkWhn4nH3j4pprckEJYGp8WmQ7CF7xRDsEWo0TYTL2XEIr4O1s+lpb/p/C3izMnHLitH1zWRUfBpqwF5Npaw8J6sF+fmOXoNRqp0EAOTiqIwFQARhIKRYevLHx6fXBo7Jtv4QBEQ+azB0sCuLlct+F2sIsvTGgynAF43Dir4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508110; c=relaxed/simple;
	bh=tHXtDyfOyfQ5fiXmaXZBMG0cIIDQpFd+joKXIKMtgs0=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=LT6QhV3lKjolsdPofKjuyza2zWvFrCTOY245b0speQ1WhGFFS0xdErx4OCQQ7cMOdxmhKZgS+3oNZEcnSM9NGc4ed9s9t+7Rs1yOP/3KtjU7rnT+NzG7NcFiZSTIHA/6tbWeoic7gBOiiB9y52U6rmLqYAdVu2MOBSijUFrD70A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wh40uxbW; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0k92JPadI4y+PEHJX5LQhlbhSkseK1WpuZh+Blxb0RAj7L5En5FbO8iWDjNthHED18i9FuWC/2W6Usp2P1oQwvNMWiXFfBBEm4QPhLKvYeNhKJq7T7i3HSGG1J0VG77h2Gf16xFiv4r+qjC/vFIDVHmRdqAKy3MoWTSayHvsaNxrV+1mFz2uEiOSWlUbFWfLGJjJ9Pf7vBDsUo16HFmnDO32JHlpIYzWQAnkMKsDNgOO/SjdYc3Cho0+FongIFmH2fNAxBQbgo9b65H7QDHqJBVYITX5YcLvjxw1cv/4+euLYlVCqNO6nxWMUVfx3OgnII2bzGw4/COvKRYYpATkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2d2RGmPLK1bthmnsDzwAwNx/QxfufqBkqctBsjlrFw=;
 b=WoCSSy1NUt5yX0hvS9/X6wUsHCCpF/WvI2Hpo9raRWDcXt4mmKI/9ITlQu4KIS55nm2d6zb0aq6TmX1AH05CHp3OqRU0NfMs5h2SBOsbzjxRyPrFC0XMl4uJ+aFZza6lCpELYLGdhCc1dq0+hW6QLxm8aQjSHhVmItcMzNHnvV3CdCpIzIPYJmOlofOO6zk2CRYRkyYsg3v6nuVkK6I55C04GdkVsfKoXe2zyZnwo9HwaUBlT8gslmdCPJbYc0q2DgNJt/zClgBt3z4IaLgCYCsSCi2gXoK4Ae3P/pDmBi9A/y0HnIgz6hbtGpKwztCiTCJrnxjmad+LIhxqt8vhjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2d2RGmPLK1bthmnsDzwAwNx/QxfufqBkqctBsjlrFw=;
 b=Wh40uxbWax+BJmToeVA4lJfT/AZrUbUe0U2w5vxThVPrb0elV5O17Y5D0oUtffuGWA4YWRu2mzdLim81N5HHvGOAiDjiC98comyaBkSHHxX1cKcN9IvbmZK72Z5FU0i+t5e11fJU6V0oZDTESLXQ4VcrGQS2rIYYgJevOzxG2oA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 16:15:05 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 16:15:05 +0000
Message-ID: <e12f439d-695f-4c27-9579-1c0fd8e87c7a@amd.com>
Date: Wed, 17 Jan 2024 10:15:01 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] cxl/core, EINJ: Add EINJ CXL debugfs files and
 EINJ helper functions
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave@stogolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20240115172007.309547-1-Benjamin.Cheatham@amd.com>
 <20240115172007.309547-5-Benjamin.Cheatham@amd.com>
 <65a71a00544b2_3b8e2945e@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65a71a00544b2_3b8e2945e@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0229.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::35) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|CH3PR12MB8512:EE_
X-MS-Office365-Filtering-Correlation-Id: 1352fddf-6e8a-4f69-b03e-08dc177777b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JPQkwEg8QEpQEepJBZFltxyync7wdON90kps9PAvRb8BLNyFKt2eD+EqIsWEccuDif5Nmn7GGg//Cepcyfx2fhRBNHwdg8pJ1cDfYH3J9Z5DQV9sTG2dD/SHEVbPGm13uxxv6grfpLJgtuvNRX633nbnMAvLDCPGHPRf4vO3BoXaUh4MAAF8yXUQ6eVqWc2mbTyv6hLLrmnU6jDK5m4zskM7OmyXBctSEpAsWHrRrkcNDzfP9btPOiSj5NNHKQZSVZ/iIUIZVZK2rbDYbQ8zbbri2lsVELSrswdjen/kuiXMZeJodnJ5Nli5LtRrhKvNHv7WoDY3qmkq+lRmCYnWVUa9H3rgB6SHxg1JOALqpU9NPx9998CkSP/6xYMrpPov1jIiyPHg5zUXsy2W5FgrBRHkoQBIyYmHv/ms+2O4bsLz+ZXSufm1NZnwEzekLgwO4Dthh9UhxoEvuDkGdgQFUbXnIySdlqWVvnPqspLmmETkKyQ3JBUlqEmdoUYtQ7nsgvfnCeE1shxVRX7b1Oq6v7DnogP0bhjqxbnu2FF4EOKIDAhxQycx0GIfUgY8EsTSl33frdbKKZpO/+1LVhjItn2oNnEbdfXosneeIG8WficNiIDQBHPccEfAkOqSAZslXhSuqp7zm+e5b7++cohkww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(478600001)(5660300002)(7416002)(4326008)(8936002)(66946007)(316002)(6506007)(6666004)(6486002)(66556008)(66476007)(8676002)(6512007)(26005)(2616005)(38100700002)(2906002)(53546011)(41300700001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cG02TGhUSGpRTTljUUdzSW9OZkZVUlFKV1hiUHVrSWZ0NG9GeWZNS0FDZXdj?=
 =?utf-8?B?WkdnVWFCMkFrSFZwaGgwNFEvN0NIOFB4RHFDZm1QSDM4UnNvQi9SQUV3aUZl?=
 =?utf-8?B?L1lkWU56NHQ0TXpoU3o0bFd1aitsdFNncEVDRVZXVjBscWtwR3JtV3RkM3o5?=
 =?utf-8?B?dmtCbFA1eERrZzNCNkgyamxHTENzQWN5djYySENibTZ5bkxtOExMSitqajg1?=
 =?utf-8?B?TmYweDloSWxOaUhUREo0clRzZ2JyN3RMcGxucmthTElmakFPcXdXT0Y3UTE4?=
 =?utf-8?B?eTVIL3BGZm1NOE9QOE91ZWdBSkhDN3MzQjlycHNwSmxHOVpFTTBaZ0FzM2ln?=
 =?utf-8?B?MWw0VFUrZ0dITVVvL2h0dTdnbUp6RnpIc2R6SUFTdmM1UzFZMVNTZExPZnRk?=
 =?utf-8?B?WkVFSkpNUmExWEtlU0x4dVhlbllhRXBYQXQ5ZFZ3amVpWDdVTk4zUjZ5Qity?=
 =?utf-8?B?WCtnUDFWWE55QWdTeGFoR2x0M2t3Wi9wQTBIaXpOMzc5bWVJN2hpb245bVQw?=
 =?utf-8?B?ZTJGREcrRWF4WkU0SlFHNjA3anZvYTk3cDZta3NJOWxDR0tCL0hjWVNvQ0Vz?=
 =?utf-8?B?UWZzQVlPak9hVlZ6UTR0N1VhS0RyVHQyWWtOdW9sVjRIUzZnY09XUmJ6dGxm?=
 =?utf-8?B?a0Z0TzhqaDlMU0NZNjh6eC9pcDNPSDdBS3AzYklwWnhJTHNJOEQyMytKUjVC?=
 =?utf-8?B?bzhoS1RJemtDQXdnYWNhU2NDQmRYODliMzlFbXR5am5JUHdtS2h3UWxDVlgr?=
 =?utf-8?B?cjhmalFDWHB6aTZOMnV0K210UnFBcTI3ZXQyYmNJRFJtSGJ2OTNOVHM0K2VD?=
 =?utf-8?B?OVJuTlRweWxkMzB6Ni93Rld2VlpFQW5CVEVzYmlTTEJGNW9WQkFXbjdXLzV6?=
 =?utf-8?B?NE5PSTdHUThwb0pBT2d2MWdoZmVHcStuSmN5Zm5hMC83ZUZWMXA5cmpoVHQ5?=
 =?utf-8?B?d29LdXVPdzNNWHlYS2hsOVRaOTZPZWQxU0VlM0tZajU5ZDRTZU1MbndacFdK?=
 =?utf-8?B?Q01yRkFrSG8vODB4TU9JR0VIQTB6N2t1KzhzbjNVQTQ2aklFeFlOendUUVF1?=
 =?utf-8?B?anF6QTRVc01BdEtvQWFOMjdjSGc5OW5pQ21samZ6RlFQVkgxb3g4UjJrQ3Jq?=
 =?utf-8?B?K0d5SGxiWXlzai9Xd1BHd2o1Smp1bWJ3YTVEbUlOMkFDVCs3d0JGVjRFZGpa?=
 =?utf-8?B?WG4wMTZBZ1RXdklkem5hRnZLVVBhNFY4dkt1ZDVZR1NPejR3SEN6U1pMUFVO?=
 =?utf-8?B?LzhGdDRWeW5yR3laa0NJTnlqeExoekNwTy82Sk9qZHMvcXAyc1FGTHcwRUhl?=
 =?utf-8?B?UUVWUFBPWmZTM2Z3aHZmTmcrbE04VG1qUEg5MExDSE9KeitTSGkyT290QVNC?=
 =?utf-8?B?N3E0eFZONjQ5c1dIWjhFV282YWlzajBTcExHWEJ5MGMwTUI4bmljd2ZKd1gw?=
 =?utf-8?B?Sjh1cGM3SjV6dWNBZnVDNWExMjBxMUZxV3VyZ3RzTUV3NjRwR2MyZEJ4d0dD?=
 =?utf-8?B?MGxzclFtY1dyTUVjOGJ2cmUvS3RlbXh2M0UxSVFZS3FtVVN5UG91TURZQWZn?=
 =?utf-8?B?dVBNcU13S2tpd2dXTFk1WkVTZHZxTkVqK09sWkU1RE1wd1dhZEZVb3JCSldX?=
 =?utf-8?B?eElHbGlPa0tMWHNFMWkxUFZrQVNzWlRrdTJzNitFMnA2d05maDk4b2pHbGlq?=
 =?utf-8?B?cDdySEE1YlorOXJtakZGNlJNbDkvcithMHBHVmkyTVU3RVBQRUlkdTh1TFJP?=
 =?utf-8?B?d0dmOERJZnF2aHV5M09pUnhqb2VoSUh1MFlPTWFVMVZVeEl0RlpkYWo1alUy?=
 =?utf-8?B?ajBNTVlGaTMyenRiNmF2MUFPbnVTY0tCSWNRSGd1NzNsT1J4VzY5OVdFSG03?=
 =?utf-8?B?Qi84eHRLbVltV2FXb1hSY2VXRmhqWXdONGw4NzViVlBuVWowUStsVTVwRFhn?=
 =?utf-8?B?ZUtuTXZGd3o3Y3JIWUUvbytQZnFOamFTbUxGSy8zUEtwbHV5MFJrVUk5QlFK?=
 =?utf-8?B?UDVxRjhvZjlSZXprUTF6MmlvMzg3V00wcktXUE8xYXZhaW81UGVxemYwaGE4?=
 =?utf-8?B?OXZyLytkNUdGNmJwd1orS21NZHRXMDhaREh1TVRFbVg0cEVIRFFDS0ZjTC9Y?=
 =?utf-8?Q?LDtaa6GIIaHx8Fr26J/7MyzDJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1352fddf-6e8a-4f69-b03e-08dc177777b4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:15:05.8205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZcQ8zcibKvNwjMXRj1w5I7h9sdGz5Zs4UeIF6oKi6eLwvYZRJjYxJJLvvHUMHjj2TCaOWTf+T4vt2RNqGthCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512



On 1/16/24 6:06 PM, Dan Williams wrote:
> Ben Cheatham wrote:
>> Implement CXL helper functions in the EINJ module for getting/injecting
>> available CXL protocol error types and export them to sysfs under
>> kernel/debug/cxl.
>>
>> The kernel/debug/cxl/einj_types file will print the available CXL
>> protocol errors in the same format as the available_error_types
>> file provided by the EINJ module. The
>> kernel/debug/cxl/$dport_dev/einj_inject is functionally the same as the
>> error_type and error_inject files provided by the EINJ module, i.e.:
>> writing an error type into $dport_dev/einj_inject will inject said error
>> type into the CXL dport represented by $dport_dev.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  Documentation/ABI/testing/debugfs-cxl |  22 ++++
>>  drivers/acpi/apei/einj.c              | 144 ++++++++++++++++++++++++--
>>  drivers/cxl/core/port.c               |  39 +++++++
>>  include/linux/einj-cxl.h              |  42 ++++++++
>>  4 files changed, 237 insertions(+), 10 deletions(-)
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> diff --git a/Documentation/ABI/testing/debugfs-cxl b/Documentation/ABI/testing/debugfs-cxl
>> index fe61d372e3fa..bcd985cca66a 100644
>> --- a/Documentation/ABI/testing/debugfs-cxl
>> +++ b/Documentation/ABI/testing/debugfs-cxl
>> @@ -33,3 +33,25 @@ Description:
>>  		device cannot clear poison from the address, -ENXIO is returned.
>>  		The clear_poison attribute is only visible for devices
>>  		supporting the capability.
>> +
>> +What:		/sys/kernel/debug/cxl/einj_types
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) Prints the CXL protocol error types made available by
>> +		the platform in the format "0x<error number>	<error type>".
>> +		The <error number> can be written to einj_inject to inject
>> +		<error type> into a chosen dport.
>> +
>> +What:		/sys/kernel/debug/cxl/$dport_dev/einj_inject
>> +Date:		January, 2024
>> +KernelVersion:	v6.9
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(WO) Writing an integer to this file injects the corresponding
>> +		CXL protocol error into $dport_dev ($dport_dev will be a device
>> +		name from /sys/bus/pci/devices). The integer to type mapping for
>> +		injection can be found by reading from einj_types. If the dport
>> +		was enumerated in RCH mode, a CXL 1.1 error is injected, otherwise
>> +		a CXL 2.0 error is injected.
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
>> index 10d51cd73fa4..c3ec03583946 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj.c
>> @@ -21,6 +21,7 @@
>>  #include <linux/nmi.h>
>>  #include <linux/delay.h>
>>  #include <linux/mm.h>
>> +#include <linux/einj-cxl.h>
>>  #include <linux/platform_device.h>
>>  #include <asm/unaligned.h>
>>  
>> @@ -37,6 +38,12 @@
>>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_UNCORRECTABLE | \
>>  				ACPI_EINJ_MEMORY_FATAL)
>> +#define CXL_ERROR_MASK		(ACPI_EINJ_CXL_CACHE_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_CACHE_FATAL | \
>> +				ACPI_EINJ_CXL_MEM_CORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_UNCORRECTABLE | \
>> +				ACPI_EINJ_CXL_MEM_FATAL)
>>  
>>  /*
>>   * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
>> @@ -544,8 +551,11 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	} else if ((type & CXL_ERROR_MASK) && (flags & SETWA_FLAGS_MEM)) {
>> +		goto inject;
>> +	}
>>  
>>  	/*
>>  	 * Disallow crazy address masks that give BIOS leeway to pick
>> @@ -597,6 +607,9 @@ static const char * const einj_error_type_string[] = {
>>  	"0x00000200\tPlatform Correctable\n",
>>  	"0x00000400\tPlatform Uncorrectable non-fatal\n",
>>  	"0x00000800\tPlatform Uncorrectable fatal\n",
>> +};
>> +
>> +static const char * const einj_cxl_error_type_string[] = {
>>  	"0x00001000\tCXL.cache Protocol Correctable\n",
>>  	"0x00002000\tCXL.cache Protocol Uncorrectable non-fatal\n",
>>  	"0x00004000\tCXL.cache Protocol Uncorrectable fatal\n",
>> @@ -622,29 +635,44 @@ static int available_error_type_show(struct seq_file *m, void *v)
>>  
>>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>>  
>> -static int error_type_get(void *data, u64 *val)
>> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
>>  {
>> -	*val = error_type;
>> +	int cxl_err, rc;
>> +	u32 available_error_type = 0;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	rc = einj_get_available_error_type(&available_error_type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
>> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
>> +
>> +		if (available_error_type & cxl_err)
>> +			seq_puts(m, einj_cxl_error_type_string[pos]);
>> +	}
>>  
>>  	return 0;
>>  }
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);
>>  
>> -static int error_type_set(void *data, u64 val)
>> +static int validate_error_type(u64 type)
>>  {
>> +	u32 tval, vendor, available_error_type = 0;
>>  	int rc;
>> -	u32 available_error_type = 0;
>> -	u32 tval, vendor;
>>  
>>  	/* Only low 32 bits for error type are valid */
>> -	if (val & GENMASK_ULL(63, 32))
>> +	if (type & GENMASK_ULL(63, 32))
>>  		return -EINVAL;
>>  
>>  	/*
>>  	 * Vendor defined types have 0x80000000 bit set, and
>>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>>  	 */
>> -	vendor = val & ACPI5_VENDOR_BIT;
>> -	tval = val & 0x7fffffff;
>> +	vendor = type & ACPI5_VENDOR_BIT;
>> +	tval = type & 0x7fffffff;
>>  
>>  	/* Only one error type can be specified */
>>  	if (tval & (tval - 1))
>> @@ -653,9 +681,105 @@ static int error_type_set(void *data, u64 val)
>>  		rc = einj_get_available_error_type(&available_error_type);
>>  		if (rc)
>>  			return rc;
>> -		if (!(val & available_error_type))
>> +		if (!(type & available_error_type))
>>  			return -EINVAL;
>>  	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int cxl_dport_get_sbdf(struct pci_dev *dport_dev, u64 *sbdf)
>> +{
>> +	struct pci_bus *pbus;
>> +	struct pci_host_bridge *bridge;
>> +	u64 seg = 0, bus;
>> +
>> +	pbus = dport_dev->bus;
>> +	bridge = pci_find_host_bridge(pbus);
>> +
>> +	if (!bridge)
>> +		return -ENODEV;
>> +
>> +	if (bridge->domain_nr != PCI_DOMAIN_NR_NOT_SET)
>> +		seg = bridge->domain_nr << 24;
>> +
>> +	bus = pbus->number << 16;
>> +	*sbdf = seg | bus | dport_dev->devfn;
>> +
>> +	return 0;
>> +}
>> +
>> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
>> +{
>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>> +	u32 flags;
>> +	int rc;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	param1 = (u64) rcrb;
>> +	param2 = 0xfffffffffffff000;
>> +	flags = 0x2;
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_rch_error, CXL);
>> +
>> +int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
>> +{
>> +	u64 param1 = 0, param2 = 0, param4 = 0;
>> +	u32 flags;
>> +	int rc;
>> +
>> +	if (!einj_initialized)
>> +		return -ENXIO;
>> +
>> +	/* Only CXL error types can be specified */
>> +	if (type & ~CXL_ERROR_MASK || (type & ACPI5_VENDOR_BIT))
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(type);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = cxl_dport_get_sbdf(dport, &param4);
>> +	if (rc)
>> +		return rc;
>> +
>> +	flags = 0x4;
>> +
>> +	return einj_error_inject(type, flags, param1, param2, 0, param4);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, CXL);
>> +
>> +static int error_type_get(void *data, u64 *val)
>> +{
>> +	*val = error_type;
>> +
>> +	return 0;
>> +}
>> +
>> +static int error_type_set(void *data, u64 val)
>> +{
>> +	int rc;
>> +
>> +	/* CXL error types have to be injected from cxl debugfs */
>> +	if (val & CXL_ERROR_MASK && !(val & ACPI5_VENDOR_BIT))
>> +		return -EINVAL;
>> +
>> +	rc = validate_error_type(val);
>> +	if (rc)
>> +		return rc;
>> +
>>  	error_type = val;
>>  
>>  	return 0;
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 8c00fd6be730..a41618ce380b 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -3,6 +3,7 @@
>>  #include <linux/platform_device.h>
>>  #include <linux/memregion.h>
>>  #include <linux/workqueue.h>
>> +#include <linux/einj-cxl.h>
>>  #include <linux/debugfs.h>
>>  #include <linux/device.h>
>>  #include <linux/module.h>
>> @@ -797,6 +798,37 @@ static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>>  	return rc;
>>  }
>>  
>> +DEFINE_SHOW_ATTRIBUTE(einj_cxl_available_error_type);
>> +
>> +static int cxl_einj_inject(void *data, u64 type)
>> +{
>> +	struct cxl_dport *dport = data;
>> +
>> +	if (dport->rch)
>> +		return einj_cxl_inject_rch_error(dport->rcrb.base, type);
>> +
>> +	return einj_cxl_inject_error(to_pci_dev(dport->dport_dev), type);
>> +}
>> +DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject, "%llx\n");
>> +
>> +static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
>> +{
>> +	struct dentry *dir;
>> +
>> +	/*
>> +	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
>> +	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
>> +	 */
>> +	if (!IS_ENABLED(CONFIG_CXL_EINJ) ||
>> +	    (!dport->rch && !dev_is_pci(dport->dport_dev)))
>> +		return;
> 
> Perhaps this IS_ENABLED(CONFIG_CXL_EINJ) and the one below should be
> replace with a helper that also queries einj_initialized? Such a helper
> would naturally have a static inline stub that fails in the
> CONFIG_CXL_EINJ=n case, and it otherwise behaves the same as the base
> ACPI case where the debugfs files do not appear if init fails.

Ok, I'll add that in.

