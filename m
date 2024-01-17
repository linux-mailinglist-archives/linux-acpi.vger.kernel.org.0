Return-Path: <linux-acpi+bounces-2913-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA1830ABF
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 17:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3321C265C5
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Jan 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F72232F;
	Wed, 17 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lES53xMh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D222301;
	Wed, 17 Jan 2024 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508108; cv=fail; b=osp/bYkpEPkLlqN9J+R8z8NeNtZTpP32fnOMVVlLWk4cGNlWLKBNGKJvZ+MLChf7t3kq64eakc5PuiXpi+xF6G411KV8o9Os/sz6GXVJLkHn8ZRXQjMdLrnieQJAD4K3HE6uBpKM1r/KbVTqzB6e/vSCUx31FhsvS7wT71f4Djk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508108; c=relaxed/simple;
	bh=9J4qEEI+Qhr02E05ClzgoEwYjV6dM34aS8ynBPNkzrk=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Xv+hgS5NqwidPWJqofvYE8MU1FcE5XGWQYn1b3Y95LcbT3o1FvFo+rAguCGWtNTDK1FqQISIZGusYi1bN55rsZ4aG26cT8RkBBnIFvVGK6kxYXRCMQbuNCQqnlOe51WmPgxyoO1I/BRs8NddZKAGiQIgnH0DXT3lbKEJBPVS2nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lES53xMh; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiPxntriM28NFUAtwVjQ3xpxSTzmXtihnwoYM35LdZgeR2QuQYFQnj47mkqslJw/++m7032AiL4BgyBeiwU5rVR2q+X1vFGFHO6cMFQ/igHdcL6Of2zaoV/NCIN1ChqsTPtY9eixY/8p6uq1PYferkFC7j51N4NxpFEpBjqTB9Sf7gAX/+L9NqTOONPDxzOPS87Fb/ikL+WhEWg4FUYFTszdw1JGpT3UCDt93Ej56ADIRapXviH0kfws97hoR23zoBxY7E8mSPOZVi/+ZOuR7gKtYivq0FKwrOfYhEQ6t1D3PjBRClvJI45CxbnJ69Mp6sXK9RJpzeVVMOfLOJLclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N40WjpVI3Nksyr/V7GKP/l2nNZ0MYx2HmmaapaWuySA=;
 b=BL6DWkZnUgAqY15LyklApQcb6sOFAdft9NrcFq3DflPLfcCb1oNhtHmznvgaW9C2paO4PBbaCOwwlUdGNu0ir01FGp46EpBmgdL0TJlIxS2H0FFw2hoCsU+sBqCezXbAUdIar3lttIP0p7vvypNHUuOt93JAnMNFH0d74Mq64NExf3J4xL5U1UvFVWyIUZYjzUb4iIm3o/CnaiFQ1Gte6XrTCw33DAfMeWONS2UMQqcAZLZWpwaVIJy3shORPKU7XGhkG0nR6SHgwrNsyYoF4TTFz+02tjcTaJkkBzxt26gyQm3ICm8YSFY5viWuyk+2fE+S7UhWAh84AtHVZJLRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N40WjpVI3Nksyr/V7GKP/l2nNZ0MYx2HmmaapaWuySA=;
 b=lES53xMhwOxtVT3QoLuSCOGFjeIWmJk5z4Xhgnx+0T/9XTy6oFODYiuQEA3B5x4JyF3T6PK4UtHD2tgRhP/dV0Gbim6tMoTYV2tJm+LojKlLXSwpelW7jllZlBwe4l8ddFsBSFFnYDWShFHCXNXBiTzeQdM+sWB8OSf8aPpCTY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by CH3PR12MB8512.namprd12.prod.outlook.com (2603:10b6:610:158::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 17 Jan
 2024 16:15:04 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::b21f:aced:8bae:a73d%7]) with mapi id 15.20.7181.019; Wed, 17 Jan 2024
 16:15:04 +0000
Message-ID: <b0f1a600-f5cc-48a2-a6e8-4f05f872b511@amd.com>
Date: Wed, 17 Jan 2024 10:14:57 -0600
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
 <65a7181ca92a9_3b8e29419@dwillia2-xfh.jf.intel.com.notmuch>
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65a7181ca92a9_3b8e29419@dwillia2-xfh.jf.intel.com.notmuch>
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
X-MS-Office365-Filtering-Correlation-Id: cb114904-569d-43ac-065d-08dc177776e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z3jVhjIT9JkfLWNFVKpVD8UXl3So1qqCdeY5wotBtStxovwYCjcGmjWO5gHOhGuxIBytRtl8D9jPlPrP6Il0+HUzP3bJOP7VdO4r5a3D7HBBtHMhazA2If+D49ENL4YtllUToCptJc1WRoIQaWi6weHvuy82HUgBoBjen9P+AYufPsdOdMoHoQ+TA2sbmcsWjFBMaDgzLJbAP5//jFOE1FJ5UjGxGAHrV+BRP67LifelEvYa0IgLmV8feVuopVHPYJ+LEe7VJITTo6SUmJL8B7qpOyRosi9FLEjd6elR32QNmaqdK3AMqOVYoaxgHBPixn/nNFSEPKKIkX+KT94sWblrFYd+dtmiDW+kd1Bb1go88XoE6wUVr9VYQDC/sxlWEIZVDjB4RaRj8WYYAm/WFEnL4dFHjrc2Zx3AQnxcmryx9Vpae4J5nUtV9/H0DlnvQ6Ndsy01QhPPBVJVQ30XrKvW6TFbhhU3BO37YkPWKNGCBsvGPIEyHc7ibHRrsgemoRGFN2YkkRRHV6+DcHy/K805HN0l2dgxg64c8OjVxNgmJuqUaZkOhOqomyOfhkDtm9s33NpmwlGBSBl86vBrzy67GLZrCs9A2FsIWy/a5JfyYImsGC3Y4sefCRD2V3A3P6idmpVtVA/KMvMlbZ6Gvjw/23Gij0mA6t7UwJO4OOaVXBuys7EgoRk93HRU9Zvj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(31686004)(83380400001)(478600001)(5660300002)(7416002)(4326008)(8936002)(66946007)(316002)(6506007)(6666004)(6486002)(66556008)(66476007)(8676002)(6512007)(26005)(2616005)(38100700002)(2906002)(53546011)(41300700001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDRkOGJOekJUd00vUWJzczR3aUk5ZWRzTU9keVFGZWJyeXBMYU53aFErZ1dP?=
 =?utf-8?B?R1lsVExBZnZ2LzhBYkxYWXZiaVZTeVl1M0t5MFJqUkR2UjEzZHJCUmhGZGdr?=
 =?utf-8?B?N1E4UlRlTk0xMDhNNktoVVlSNnJCYTBvOERQSUR0VGR4RWhtbThROFYrb2Uz?=
 =?utf-8?B?em1uTmxOSkFLOWFTMU5xcWt3ckk2aVlFK3FNUnpHTDBvWFA1YlM4cDBzRlY4?=
 =?utf-8?B?VUZ0QUdKWmxicUo0Y2p3Z3M0M3JKaE5jWkJkVEF4WitvanFMWmg3dHl2UFZr?=
 =?utf-8?B?Wi9DSUFCaFIvME1jSE5TcW1NOXN3cE1tdWRQR0xXbWhhVmFXd0ZyK3pETHpD?=
 =?utf-8?B?dmRrWVV3eUhSN1QxYXMvYkxWc3pyUUg2bHZ3cjdJQVppSUZBdFhhZUQzVzA0?=
 =?utf-8?B?MEVMcnJLcWtKSTBMQW1tNmFBUjBjcWcrZmo2QUFwamtMWEVyamNyL3pQV0d4?=
 =?utf-8?B?ckZVUlA3RkJNRTNzT0JxU1JST3plV1hmZTZ3d1JIN3ZjZnNLRUtSdUc3UjJ3?=
 =?utf-8?B?TlppTTYzSm1jM01SSEdSTHVQMFRFb0tXSDdNdTFjbEp5RmpFM0krbzNVdHB6?=
 =?utf-8?B?dk94WklkeDMvSnJvbklYbTUrOE9RbGJqZ0lBdHRRTGh1WkJGeGxWbUVzOUsw?=
 =?utf-8?B?VC9yQlZtbHMzS0xqMUNMbjFpQ2EwQzhOK1hsRVpkVTFIZm4yQ1FrRUNFSzZx?=
 =?utf-8?B?eXBBWTM0c0F3YVZxbWNMWjZWdmZaYkJ1OGJleUVnQmRxQm1MNjV3Mnd3Lzkr?=
 =?utf-8?B?bUp5cGFKcS9Scy9ZSHpBSzI5NnN6UU55TkFDcVU2S0ZYTnBxVC9DY09YYVJW?=
 =?utf-8?B?NzdzOVVRSGhUUGNoVWtEZDdVR21XV1dOT2xuQisvby95MStENS9RbnM0Vmxu?=
 =?utf-8?B?bEFUTjljT0YvM3grNGwwT0NWcmUraU9GcEVaVG55VFFJTzFYaXhHWjZOWGE4?=
 =?utf-8?B?RUxwVEFKV2xDL2VIS2pOLzFvRDNwSUh1ajc1T3dBZTRvOE96SmZxaWc0cnZy?=
 =?utf-8?B?R0I3WTJYNWt2eFRzTkhISVk5UTRMRU92WXhONVdBYkkvU2YzZk1Bdjk3L1hr?=
 =?utf-8?B?SzQ3UWszZGZZT3NEdnJWdW1ZT1hWT0VRalIvWHhWcnNJemtjTEc1M3NVdFg3?=
 =?utf-8?B?MVVQQWxqdCt0WHhoWFZGZmlPSmt1eEpnUmFlNHR5NWxCK2Z6ZFVuU2ZUbE9i?=
 =?utf-8?B?QXkwT2ZQcENtb1BQV3RqZEVYekhZUU5FL2QzcGVGZCtEWHl0VGwwL2JsM2JB?=
 =?utf-8?B?NzdhS3ZEWVFDNHF6YW9VVDRpWTVYclEvNFBnWjAzMDlBcFVKNEUyUGVOZXZX?=
 =?utf-8?B?OHZkcFlIVDdoMzVMN2preFNLc1JnTFZ4dUNPVnFtR25sUmxFdFlDZklZdWd4?=
 =?utf-8?B?Tyt4aE5HL3ZyWWkvMFNzdC80ZE5KOXR4b2lIRU1KSkFMZ2R0WG8xMnh3akky?=
 =?utf-8?B?TWhNNEhCN0tUVXBHVGxFRFkvOHJySXNMc2hRWjdnL1pxdHA0UElPdFJOcWo5?=
 =?utf-8?B?M0tJakYvOWFFOWJ4K0dJR2dvbXQ2eWZmOG5sTk4xZm42cWExYnNUQXkwTE5K?=
 =?utf-8?B?MXNVN1JPUk14KzQ3SFRKcXhMQUJzWEtmVnZKZzJqWEV3NENjTWVLbzZveTFW?=
 =?utf-8?B?ZzdwK0pFZ0ZZakNLR3prVHJUTldrYUdPbWRZY1ZHZ2l4bGtQTmpPZlNFUjEr?=
 =?utf-8?B?eDQxcC91L1BXMHNiYVVwYkhWQzI0RWFITW1mQXFXYUNKUXRCeHJNem5HdW5q?=
 =?utf-8?B?L1ZXSE9xN1l0eHduZCt3SW9XLzZRWCswMTk2VHNyRGRJRElBenhUUElHMDdr?=
 =?utf-8?B?bHFMaUw4YUtlZTIwNHlLVjhKTlZtbGRlNGllYjhrZ1d2UUZiUUlHeXF4Wnk5?=
 =?utf-8?B?cE5VSUF1MDVka1poMWV1UU9iRDZFYTlyL3czU1dVTEZXQXdpU3E2Ymp0SkUy?=
 =?utf-8?B?TFJCeTdzVHN2UFRZelU3NHM0d1VMOUo2TnNFRW1RMk4yMGt0NnVZWUdWMSto?=
 =?utf-8?B?eHh3UFM5RmFVWXFsZ00zN1hxY3loZE1DQ2k1VjFvQ3Y5dUVON09ock8yUTQx?=
 =?utf-8?B?WWFxZHhDSXBORGtMWkFKZWpLZllCRjFBWFlueis0L2V1ekliRDVWeXplb00w?=
 =?utf-8?Q?9Rkp8NT1tonh/I+Jq1Y9Uh7GX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb114904-569d-43ac-065d-08dc177776e6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 16:15:04.4364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTIi6fegco+bdVgq190rl3P+uRfcTD0xcAD9ckqkEydXXSS1Pe3LPWZ/PEytZFrjU377FPg01gyBXefs9N3SxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8512



On 1/16/24 5:58 PM, Dan Williams wrote:
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
> 
> Checkpatch notes that this file likely wants to be accounted for in
> MAINTAINERS. Just add it to the CXL subsystem file list.

Ahh my bad. I had this checkpatch warning filtered since it was triggering in
the past versions where this header was still under drivers/cxl, which is
already in MAINTAINERS. I'll add it to the file list.

