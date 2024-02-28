Return-Path: <linux-acpi+bounces-3999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F195786B1BB
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 15:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E38288490
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Feb 2024 14:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C5515958D;
	Wed, 28 Feb 2024 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uyqoMfKU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E81159585;
	Wed, 28 Feb 2024 14:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709130540; cv=fail; b=V0lhfKII0DiRA1PUyuMyWF1BsTuFJZb4n1rdMqG7zajeYMo0Bslz5876T5a3yNN1McdARPbrE28xdtLZBgssAkPaGzYyi0pSCGFUOvXGu2lZVXEime2rkBw297jy6QKZaj9LkG3oN3Vp1+Bph0eP/P0vCF/dSXBzVJJRJ5JQoF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709130540; c=relaxed/simple;
	bh=Aw4/1N+glrOGrFmNuopC5Oq9rGD2jU7aYzuLiUEPijQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R0PhWuTNsxch6gF5C9woStSWPk5M1W7z7bBoiyZ75go6vwNimmKdk14lbL6t2NeOmL1rDtxNkKFR3LZhcBOqzLf9Fhsi9L2YODz1VS96EhYATbg5D0Rz229hTiVUH/R0vpt3F2CZuZZ6tqxoCAVKnxX2ShSv20e36flW8gvVMZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uyqoMfKU; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOXaBvc7lSZZYNikYjC8uyzNfaoP7QAwxnjnOwOhel3hcgwzj6M+BE1FmtJPeKFgE+HgtuJjd3/A2jPdwwk5xKL/sMqxvDjKlqNhrsqERlQxtdAR1Ro73PjcAL7de0VnDfCjQNRvKzJY/rtTSx/Qg7ojygXm7joCWc5xhOvPYIeY/7UBo+B8n2bTZoUb5VKXra8NLKyHkq8O2mDGLk8zXTzJwMOP7O5hzyiEpr1/yCUe2A4DKmW7Q/0vCreePztLZXgnDCGlOR4LvgcZRjnqITSZRi0nFEnRZHQs+yOPDyktDJdoxZqXp0GM2VM4dpzqgu5/ugWMgUcYzqOyOseRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xIWMGxl6misSVlcYMvUPNsRRLel6+y5NoZmw+sJ4QT8=;
 b=fVXM8Fe5dkVxG241XevZoPTzktRbMbQWCCaF/MhLQMKdkrl/HOW7GO8ps+rHFI0dpOZNLYhp0FNW3H+/Juw2d4A9htHR5Zhm7EjujKG0koOn0xa5r5LNNud2umMF3mBGSw4s+q+sfOG2GiAjE78VMIUTV2eMvgrgdpRmd7IvhS8OwV6/bTCwhF33nisB6pxEP09zBoLiLclMUd4j4iXxIny+dzT60C7FJEEm/zK25r7DNvorbIHqZW8pvB17qIOzE9CG8v6VTLy4rHCoM/HPa6YQlIg0NUwn/EhsRJ/0DER/H66/kLecj/C9TUeQHJYNspa2ZlsD+bDM1Z7DS03k/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xIWMGxl6misSVlcYMvUPNsRRLel6+y5NoZmw+sJ4QT8=;
 b=uyqoMfKUnd95zEFPFEaptb5Ae61CbGgIoAjcHAtYAsBSvsqm6O6LhRXtC3a/1oGGd5xULPKEbnyeEglh6Xj0bPM7npXxewe3wpopEX2tkmNEcHQTFYES2Tu9brN3BupoDAYyLdSSvdVrBdOeySX7oVNxSu9FliukmNI9W9z80nE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Wed, 28 Feb
 2024 14:28:55 +0000
Received: from CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06]) by CH3PR12MB8535.namprd12.prod.outlook.com
 ([fe80::5302:26cf:a913:7e06%5]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 14:28:55 +0000
Message-ID: <dd2ca1ca-de86-4276-9ab6-399faca87b72@amd.com>
Date: Wed, 28 Feb 2024 08:28:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
To: Dan Williams <dan.j.williams@intel.com>, jonathan.cameron@huawei.com,
 rafael@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de
Cc: dave@stogolabs.net, dave.jiang@intel.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
 <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
 <1e7673e9-8e30-4d66-a86c-bb768cb69f9d@amd.com>
 <65decbfc57824_3651e2946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <65decbfc57824_3651e2946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0662.namprd03.prod.outlook.com
 (2603:10b6:408:10e::7) To CH3PR12MB8535.namprd12.prod.outlook.com
 (2603:10b6:610:160::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8535:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 4503ea6c-3140-4cc9-7555-08dc3869981f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u4dbmr10aJ1oFEkfIxnV0xmnPjfjnsYuFnYkVO30+a1cWTLN+hPPeQjUvX96FRjgUTm3yNW8FxLX9uzFqtdZzUDUrSfJzxBcALqh5LkifMgVNnysF6t9QOtzvC+uDVY4R9LNi2SR9oFWje6l/67PcxoFo5gmHkxLMlegLMN3sI7T3k8nW+Z4PphBI6/DOByQJ+FaU3OpyxIEF53duwQEqROO6Qjqs/101cZJCXjuE5i9fWmwX/fQD7VRHBIfqo4oBn1ds0fUGuoZNQ3cD18tJBy5AcwTs7DHOTM5VdOuaTu/VVhnF3UhTXxzCRiJvA3guGDLviBc7T2KtSHLn5Vy0GYw/UFnsoGo4vy8MIvb3DjrXr9ZkvOg3r7ll+9w9Z//fCHOwTEuLMLzaNsE3LbiMOvjGduKNuIN6ehoQd3xlumMlIZrNFuvkNbb5tWfx+qcH1plvHd7vJDeZxX0H5qXAtqDNBe35nJEURjtduNB6pnTfNcUJ7i6C5blJB3lRu4gQtAjPPY8aOaectNnh3YEtlPr6x8lym3ll40LiNx8ep0ozZqpwnKzRKCPCO5qmkxlixLX7y1CYYYhXQc5p16KKDvO7UZ4+hsqBFReuIenKG+m9EPXdVeaKNxWy6UJ4H9v0jjdGYLD05KDfMLq1yQM8w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8535.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWFBUktFd2EyeS85NHo1bVQxRmRmaHlidjhGam9EMWt3S0lJb1ZtbkxMeCsw?=
 =?utf-8?B?WENqOWVIZTluKy9vdUF5M1BHS1ZpOU9WaEJLcDFhM1BSS3lhTExOaTZLY0J5?=
 =?utf-8?B?VUhYTlZnZlRnZ2gvOTlnU2JLaEFEL25VZGYraEMvNDBRUlVZbEZucGlYV0NO?=
 =?utf-8?B?Uks2U2RZMTgwOXJiTW4vK0dkM1JRREsreUpFZjVSNldMWkpWUEZqMkdiZ0gz?=
 =?utf-8?B?dHhBb2RQc0hoWThxWThSWElsaFBXeGFsMkVMVUdLNThESlBiL3lHNEJ6anZY?=
 =?utf-8?B?MDZFMGxIS1VsOVk2SDY4djJjYjFQcHVRZVJkdVI4ejlRcDZYVUZNTG8zTHJy?=
 =?utf-8?B?ZmhENXNXYjN0RW8rSWZpdzJnQll4QzltS2pzdXZjN2tqTlU5Y2pDQTJCSGVK?=
 =?utf-8?B?R3hxeGRBZWZlc3VSeFZ3REMyWTRpZUpQYXEvVjdHeFV3czFia3Mxc1BKZUR4?=
 =?utf-8?B?UGE0dGd2c2owQkx1Y2RVQXpnaCtlRWM4WWpleHRVOTVKTzd3NmMzaTc4dEMw?=
 =?utf-8?B?NndkdGFQeitVQmdtbFBtM2pYZnhIR1Z1N1gxQi9KczJKWG9QRFlKVmQzc3Uy?=
 =?utf-8?B?QzZpdmZrRnV2VmFrTGtma1A0L01rTHptUTVNUTZ6M2NUWlVwNUdiZFlLM3dq?=
 =?utf-8?B?QUdtdHgxRXlUOXRnYTN6K0ZiUXkvM3U5Sm12U3JqRW01SklPMEdvci91eGNS?=
 =?utf-8?B?NGJJYlJhT09KdTRQc2RGZzArUjBFd2RveEE4ZGFHMDJEbzZYd3RxSlR6SmNK?=
 =?utf-8?B?dVgwb2dId3dnQk1GL2tqSHRKVytudXJ6ZmRSb24zdllaU2JnUG9BdVY0WTVw?=
 =?utf-8?B?cHVyU2hPRTRUQkFaTW01N2NsOXp5MFJWM0J0a0xONk5aUlV4QkVPTHRFRlFP?=
 =?utf-8?B?cDNRak1uWkJzQU9ZVHAvQ2o1MUtOMDlTVmRzaFZSd0lxM3lxSXh1RFpZYUpQ?=
 =?utf-8?B?MXhaZFFUZFJ0OEFHbDNJUEprNGVnTHNMTEV2TUhmVForMTRrdElTL2NRNnU0?=
 =?utf-8?B?cmhHaXBWMEFOMG9QZFI3TmZGOVdJS2djNjVEZGpmUzRvVDdqWXpYdC9VZ1dm?=
 =?utf-8?B?b3JkNnBjQnI3U1dJbTZmcjMrS0JCZzFTbHppWVVyQzlFajh2bGI5WXZZR09i?=
 =?utf-8?B?RG55NFYzYkhJbkZjSVY0QUp0TVhqLzNYcHB2dFdYZTY0MzM0QjRuNGw5SjM0?=
 =?utf-8?B?ejkxN3RDb1d3U20rbTVFLzUrTTNQaTdQcU0rWWNZek8xOGRzWFZtd3dYQXJH?=
 =?utf-8?B?V1F1YkEwaEYxVERSMjQ1RmlURDE3bGVod3FLcTYxU1ZDTHFjcEt1NGpUdGhm?=
 =?utf-8?B?SlVTbkI5VDBnbS8vZHBmb3ZSeUpSdzBsTVI0SlBkblNTV1A4TG5oV2NmZ2Rv?=
 =?utf-8?B?ZzFld1h3eGFsQ3c1cEtWbktQd3JMODVneHpwbkZvT0QwNzJFampyUlo5Vy9N?=
 =?utf-8?B?Y1NYeWl4NStlbll5QlNyUHBVTFFnNUF6a2VIdm1SS0EzRklqUnhRanJSUy8r?=
 =?utf-8?B?WUFUbnN5clBNZ3VKZ0JYazJCcjJVR0lwNG5VSWcxaW5BWElsQ1dBelZGU3d2?=
 =?utf-8?B?NjFwc0RldFJ1UDN1RGFkYUZYVHA3VG80czFldGdkS2VIQ2lkWTJwSE92TFpL?=
 =?utf-8?B?WkdNSm1iMm5SOHNtYlpTQ3E2bm1qS0tmMnIyM0lDeThhZWJrbSs2MjhDZ3Rn?=
 =?utf-8?B?SjcwSXhBZjkwTE5idHJIa25jSmdBTldLVG1Wa0NJYVgvNFovTzNIa0UwRWdu?=
 =?utf-8?B?ZTRtREpmTzRiT1hBb3JSNUN5Z0pTYkJ1N09VYnJkY09rc1BURlRsOXErYnRI?=
 =?utf-8?B?WDd4bW41WW9NNVROQ1VteU1CWE9QVCsvbzVGYmNUSm9vOXdlWnpJQmZWdTJr?=
 =?utf-8?B?eXNDWmZrNDdrVXkvWmVUSU5ZRzVkdlp4UHdnMXE2NkVZWmFQYlB0YUdQRzJj?=
 =?utf-8?B?RVY4amxBS244QXBENCsxMEVjenBKWUJGNHBzUk1kd3lCTkVPd2FBaFVvMm03?=
 =?utf-8?B?ZzV2YTd0dHFiSmFHZ0pubE82Q3Z4SFdQYkRTUG1NU1hwMTMwK25mQ0o3bjUz?=
 =?utf-8?B?RkZuY2xUQytBc2M4b0ZqTDFBdnJWV2lqRXgzZTM2azdzOTJpOVVqdEJ2S0ZY?=
 =?utf-8?Q?FpYRCK2ESiAClhssu2ZsKNhqz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4503ea6c-3140-4cc9-7555-08dc3869981f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8535.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 14:28:55.5853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfntwW5HDAT1zQdg8xE1AZvxv7cLfqBd9gRxQB1xmbkJLcnd2TZNjAoRNYP8POpfD6zqkFgGyTp3/+FSNPxRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913



On 2/28/24 12:00 AM, Dan Williams wrote:
> Ben Cheatham wrote:
>> This patch had an outdated commit message, so here's the patch with an updated description.
>>
>> I also realized that I was wrong about letting CXL 2.0+ error types (discussed a revision
>> or two ago) and I wasn't actually letting them through. I've went ahead and added
>> the ability to inject CXL 2.0+ error through the legacy interface. This pretty
>> much amounts to returning an error for CXL 1.0/1.1 injection types in einj_error_inject()
>> and instead routing them through a new einj_cxl_rch_error_inject() function called
>> in einj-cxl.c
>>
>> If this change is too big I can send in another revision, I just wanted to avoid
>> spamming the list(s).
>>
>> From eea1cf991dc2a551f6db2e3bb9510ed43c86762d Mon Sep 17 00:00:00 2001
>> From: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> Date: Fri, 16 Feb 2024 11:12:51 -0600
>> Subject: [PATCH v14 2/4] EINJ: Add CXL error type support
>>
>> Move CXL protocol error types from einj.c (now einj-core.c) to einj-cxl.c.
>> einj-cxl.c implements the necessary handling for CXL protocol error
>> injection and exposes an API for the CXL core to use said functionality,
>> while also allowing the EINJ module to be built without CXL support.
>> Because CXL error types targeting CXL 1.0/1.1 ports require special
>> handling, only allow them to be injected through the new cxl debugfs
>> interface (next commit) and return an error when attempting to inject
>> through the legacy interface.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  MAINTAINERS                               |   1 +
>>  drivers/acpi/apei/Kconfig                 |  12 +++
>>  drivers/acpi/apei/Makefile                |   2 +
>>  drivers/acpi/apei/apei-internal.h         |  18 ++++
>>  drivers/acpi/apei/{einj.c => einj-core.c} |  85 +++++++++++----
>>  drivers/acpi/apei/einj-cxl.c              | 121 ++++++++++++++++++++++
>>  include/linux/einj-cxl.h                  |  40 +++++++
>>  7 files changed, 257 insertions(+), 22 deletions(-)
>>  rename drivers/acpi/apei/{einj.c => einj-core.c} (94%)
>>  create mode 100644 drivers/acpi/apei/einj-cxl.c
>>  create mode 100644 include/linux/einj-cxl.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2ecaaec6a6bf..90cf8403dd17 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -5289,6 +5289,7 @@ M:	Dan Williams <dan.j.williams@intel.com>
>>  L:	linux-cxl@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/cxl/
>> +F:	include/linux/cxl-einj.h
>>  F:	include/linux/cxl-event.h
>>  F:	include/uapi/linux/cxl_mem.h
>>  F:	tools/testing/cxl/
>> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
>> index 6b18f8bc7be3..f01afa2805be 100644
>> --- a/drivers/acpi/apei/Kconfig
>> +++ b/drivers/acpi/apei/Kconfig
>> @@ -60,6 +60,18 @@ config ACPI_APEI_EINJ
>>  	  mainly used for debugging and testing the other parts of
>>  	  APEI and some other RAS features.
>>  
>> +config ACPI_APEI_EINJ_CXL
>> +	bool "CXL Error INJection Support"
>> +	default ACPI_APEI_EINJ
>> +	depends on ACPI_APEI_EINJ && CXL_BUS <= ACPI_APEI_EINJ
>> +	help
>> +	  Support for CXL protocol Error INJection through debugfs/cxl.
>> +	  Availability and which errors are supported is dependent on
>> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
>> +	  EINJ documentation for more information.
>> +
>> +	  If unsure say 'n'
>> +
>>  config ACPI_APEI_ERST_DEBUG
>>  	tristate "APEI Error Record Serialization Table (ERST) Debug Support"
>>  	depends on ACPI_APEI
>> diff --git a/drivers/acpi/apei/Makefile b/drivers/acpi/apei/Makefile
>> index 4dfac2128737..2c474e6477e1 100644
>> --- a/drivers/acpi/apei/Makefile
>> +++ b/drivers/acpi/apei/Makefile
>> @@ -2,6 +2,8 @@
>>  obj-$(CONFIG_ACPI_APEI)		+= apei.o
>>  obj-$(CONFIG_ACPI_APEI_GHES)	+= ghes.o
>>  obj-$(CONFIG_ACPI_APEI_EINJ)	+= einj.o
>> +einj-y				:= einj-core.o
>> +einj-$(CONFIG_ACPI_APEI_EINJ_CXL) += einj-cxl.o
>>  obj-$(CONFIG_ACPI_APEI_ERST_DEBUG) += erst-dbg.o
>>  
>>  apei-y := apei-base.o hest.o erst.o bert.o
>> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
>> index 67c2c3b959e1..cd2766c69d78 100644
>> --- a/drivers/acpi/apei/apei-internal.h
>> +++ b/drivers/acpi/apei/apei-internal.h
>> @@ -130,4 +130,22 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>>  }
>>  
>>  int apei_osc_setup(void);
>> +
>> +int einj_get_available_error_type(u32 *type);
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4);
>> +int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> +			      u64 param3, u64 param4);
>> +bool einj_is_cxl_error_type(u64 type);
>> +int einj_validate_error_type(u64 type);
>> +
>> +#ifndef ACPI_EINJ_CXL_CACHE_CORRECTABLE
>> +#define ACPI_EINJ_CXL_CACHE_CORRECTABLE     BIT(12)
>> +#define ACPI_EINJ_CXL_CACHE_UNCORRECTABLE   BIT(13)
>> +#define ACPI_EINJ_CXL_CACHE_FATAL           BIT(14)
>> +#define ACPI_EINJ_CXL_MEM_CORRECTABLE       BIT(15)
>> +#define ACPI_EINJ_CXL_MEM_UNCORRECTABLE     BIT(16)
>> +#define ACPI_EINJ_CXL_MEM_FATAL             BIT(17)
>> +#endif
>> +
>>  #endif
>> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
>> similarity index 94%
>> rename from drivers/acpi/apei/einj.c
>> rename to drivers/acpi/apei/einj-core.c
>> index 937c69844dac..437c13949be7 100644
>> --- a/drivers/acpi/apei/einj.c
>> +++ b/drivers/acpi/apei/einj-core.c
>> @@ -37,6 +37,12 @@
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
>> @@ -141,7 +147,7 @@ static DEFINE_MUTEX(einj_mutex);
>>  /*
>>   * Exported APIs use this flag to exit early if einj_probe() failed.
>>   */
>> -static bool einj_initialized __ro_after_init;
>> +bool einj_initialized __ro_after_init;
>>  
>>  static void *einj_param;
>>  
>> @@ -166,7 +172,7 @@ static int __einj_get_available_error_type(u32 *type)
>>  }
>>  
>>  /* Get error injection capabilities of the platform */
>> -static int einj_get_available_error_type(u32 *type)
>> +int einj_get_available_error_type(u32 *type)
>>  {
>>  	int rc;
>>  
>> @@ -536,8 +542,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  }
>>  
>>  /* Inject the specified hardware error */
>> -static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>> -			     u64 param3, u64 param4)
>> +int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>> +		      u64 param4)
>>  {
>>  	int rc;
>>  	u64 base_addr, size;
>> @@ -560,8 +566,18 @@ static int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>>  	if (type & ACPI5_VENDOR_BIT) {
>>  		if (vendor_flags != SETWA_FLAGS_MEM)
>>  			goto inject;
>> -	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM))
>> +	} else if (!(type & MEM_ERROR_MASK) && !(flags & SETWA_FLAGS_MEM)) {
>>  		goto inject;
>> +	}
>> +
>> +	/*
>> +	 * Injections targeting a CXL 1.0/1.1 port have to be injected
>> +	 * from the CXL debugfs interface so that we can guarantee a
>> +	 * correct MMIO address.
>> +	 */
> 
> Given that the CXL debugfs is not present in this file I would update
> this comment to give a hints using local references. Something like:
> 
> 	/*
> 	 * Injections targeting a CXL 1.0/1.1 port have to be injected
> 	 * via the einj_cxl_rch_error_inject() path as that does proper
> 	 * input validation that passed address is an RCRB base address.
> 	 */
> 

I agree, I'll change it to something along those lines.

> ...that said, how does this work for the CXL 2.0 path? Does not
> einj_cxl_inject_error() need to use __einj_error_inject() rather than
> einj_error_inject() to get by this check?
> 

The way that the target port type (1.0 vs. 2.0+) is differentiated is whether
we are targeting a memory address, which is what SETWA_FLAGS_MEM indicates.
So for the CXL 2.0+ path, the check will pass. Although the error type
is a CXL error type, the flags variable will be set to SETWA_FLAGS_SBDF
(I'm 90% sure that's what it's called, but it's something along those lines).
Let me know if that doesn't answer your question!

