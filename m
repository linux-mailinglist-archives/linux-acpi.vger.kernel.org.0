Return-Path: <linux-acpi+bounces-13646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2440AB01EC
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 19:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56FC44A0EC0
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 17:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095112868B9;
	Thu,  8 May 2025 17:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FRfWULLA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020094.outbound.protection.outlook.com [52.101.46.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE172253B2;
	Thu,  8 May 2025 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746727092; cv=fail; b=rxf+26/R8v/kldrHD+Vq2/RmpvjfryqkS0H5eDT+P0CXwWU2Bzoi89qre9cbBNq66KSA1K5jiSvGErng+Q89qmmygQIkNwDiEO45+OgXWHO/jgt9iqijxR6XYEY3tkWqfjNxrhVZYesw9o8QkwyvmTg/O4KWyct418kC6eOI+wA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746727092; c=relaxed/simple;
	bh=WcsopY6tkWuoePm19XIXYhA8Jd9SbrRq0PkRhT8NlSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OfPMPDzPW+Tu3NT2cHdqp4vTH6moDkmWYlq0/v1S/gUJUEvesOUYA+C+sAS8YuoeDPZW0acafhuRd8a+KRlSMQQd+KxQGaAVIroSetiFs5p9zOr4wWUEJnQFi/YtjRO8b0MGZlFiYBiN2336X3CzPGpx3029ZHhLEyR+f+nvluY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FRfWULLA; arc=fail smtp.client-ip=52.101.46.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LI5n5dFXxkuNAdVjx6kxN72eQx0ET/i4/5bGw7Rj4xcdCrNRgWlwH/UPMtWTfE4iY/Q2E7y7+VlKeVBDGGbhy4ohLPu7Keskc1ZvGWUvuXdE8owDbSCRtoR3Tybh/F4YrRI5bn5Gj7wQyzcSNyQ5xUtaRAbRTFuPMBG64Jsbj1Dy2c/wgNehzN0v6LPeD67kOtloVBmA/pVr9jHvEERC0V41ts8pTt13wXriW+ef2oTJ2YkdnlcGQhOaa1uxbKLfviawa6FV9rZua+87lNtKNmcFN884Ep2I6ptqItVhsFW7eAJkejT9qNraCMpMHnAttd20947d/mWYjzKGbMnsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJL4qmZTj1ej00oK+1Axc8b7pBwoGSbhCoaI2cSPjm4=;
 b=iSHePr+nfk5xs+YEsQ5o+l1WMS7TGXR5lzcvjdUyUs9Z2k88gkqeybMkbsdrWQ3Vn+4C2mqNhdKFY8NeYyOKLXUrBobObfDZ2aReMp/hmuaPcQxy8eTndRdhiGOHGw0MPPIjp+SqCYGo8E66yhk/pMmSn5h1Dwtb9wGS5bC9prCwSKgEOdqxdmcxScG5CxiHKP+kd7zVFN0Td3Yi6iQZ8ftT2gyIcqZwy6Y8BUemOcqQuqwZB97uqUZszTTT3YlGQ4wWF+7TPmBqgvlqVlrLgV6T+/NzACNIuBFw/6IM6fT9ewjQfvIB2EDnW2BRmiKQ8bxw13Q+drmDX83v4xMJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJL4qmZTj1ej00oK+1Axc8b7pBwoGSbhCoaI2cSPjm4=;
 b=FRfWULLAUAZLSyYSzbWt4kmrLWKBMBPJmmSQ8sPauDMCv4lVEO3AzA6Bu1KJF/vDVVRBuUA3f+i4huqMyU17VPytPkXn5726RFD/WOXy7ljS/MXxzxihq8X0zNWUmyHXROePDAkdb4Q4tTE12B4lqNXh1BBiz60vIa8aheFLBak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN7PR01MB7903.prod.exchangelabs.com (2603:10b6:806:34f::17) by
 BY1PR01MB8948.prod.exchangelabs.com (2603:10b6:a03:5b7::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Thu, 8 May 2025 17:58:01 +0000
Received: from SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f]) by SN7PR01MB7903.prod.exchangelabs.com
 ([fe80::cf45:9855:a64e:382f%6]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:58:00 +0000
Date: Thu, 8 May 2025 10:57:57 -0700
From: Zaid Alali <zaidal@os.amperecomputing.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 4/9] ACPI: APEI: EINJ: Remove redundant calls to
 einj_get_available_error_type
Message-ID: <aBzwpS6t3V4zwrxn@zaid-VirtualBox>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-5-zaidal@os.amperecomputing.com>
 <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
X-ClientProxiedBy: MW4PR04CA0277.namprd04.prod.outlook.com
 (2603:10b6:303:89::12) To SN7PR01MB7903.prod.exchangelabs.com
 (2603:10b6:806:34f::17)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR01MB7903:EE_|BY1PR01MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: df7777ce-5e6d-45e4-b17e-08dd8e59defd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1IwWDV2LzczT2I5aXhhTlMvVWFFR3cxUTNDOTlZTzRyclVmMVVmTXQxZ1hV?=
 =?utf-8?B?bk9YUzFNcHp2YWlCTFp5QTBtNmk1eDBLODN2NEVVMFdCR09xTVhlZlJGYlUz?=
 =?utf-8?B?YXUvM0NENUJHYk5YcnVZRStDSkZaRmdKRy9QdDlhWGpIU1RhUkVncXhZNFB2?=
 =?utf-8?B?bVYrTUp2cVZUZGY5ckZnS2xQT25waGxsTHpJeTFmcFlWOEEyZFpLazI1dGhx?=
 =?utf-8?B?SXJPWGk4dkR5cGttUTA0RHJvSjdKQVo3Yzk5M2xrRXlYMkdRc09nVnV5eExD?=
 =?utf-8?B?RFI3RGZrSEFoUDB1WFVOdFNvUDVPdXAvWFlqeVAyZ0p3ckVENVp0OGlGZ3lM?=
 =?utf-8?B?cVFvNGdXZlArS0pBcmw1REYrSTYvSjJYWDQ2c0hXdVFSNUhsL0IvNmxJMWFJ?=
 =?utf-8?B?TGJ2TFIrTlFkTis3c2k5MWRHdE82NjRCeG0vVzZzRUJKYWhjYktESkk4TlhD?=
 =?utf-8?B?aysrdFVnNjVBSmdYVXQxRC95NVZlTWRWN0x2Y0s1SVRUZkQ1bkNmSnZmSXRU?=
 =?utf-8?B?MmJ0dW9VR282Z0hHQ3hrblRKUkFrNFFpclloQW9Ycm9FREN3eCtTT1pueGdm?=
 =?utf-8?B?L1lkaDcveSt0TldwbjYrb0lvZlNhWFdlZGVzOUlNOEF0Tmd4dVpyZVJ2MUtC?=
 =?utf-8?B?VHI5b2FKZ2FDNWN3T3dNRC9VNGF3aEc1bitpV1NEcGFnLzVwem1YOHl4bEgy?=
 =?utf-8?B?U2cvb0xNc1NDNkhiZmNHT2tXRUdEby9rbmtnWVFFZWJBU3NIeGdnOFZYbzF4?=
 =?utf-8?B?ZEQ0bWlITnl2b3hoS0F1dE5MZHk2VTN6UUNTWU1yak9uNmZCeG4yTENxQkNB?=
 =?utf-8?B?eVY2MlZEK0ZlT2dheDRFdU1KT1JxQ0RzNi8vQVEyeXlLSkp5ZWppQkFMWEQz?=
 =?utf-8?B?c0pqSmxFYlh5LzNBQW82YmFkRVNKSzBhb3htQlNNbXh4U0dmY0NjaE1HaFhx?=
 =?utf-8?B?Um9rQ2NvMHE1blI5SndjNHlKTFFjaVpuSTdNOW45SXE1VGx2VjE3ajlXUnNC?=
 =?utf-8?B?em5YV3RQTHVzaTloQThJSFZmR1ovU09HVGpqQ3Evd1RneWZsWmlQL283OFJi?=
 =?utf-8?B?Mm5JUnlPdkpxNE5mNGErakVldzRsSEpqUXpMQXV0TFcvZ1NIZGoyTStxd0c4?=
 =?utf-8?B?bE1pM3pKbExqc2pmWFAweFFtUTlMWGxWOHpoR1BsQWt6WWhZSlgyYTJYQVFC?=
 =?utf-8?B?TVh4aHV3S3c3SXNzQk1seUFaL2h6YmM4bFN2ZVFjV2FPa1F3aTFFVXd2ZUtl?=
 =?utf-8?B?aEVxOXBtdmVHR1k5VzBuVkkzcXM1Qkl6NFNndWNDSzVpeTFwbXdEMEpFVmhE?=
 =?utf-8?B?Qi9HK3IyeEw2K0FaVkxSNmx6S24xWSt2RlcvajlseVhWQUpBaEt0VnRkbWJJ?=
 =?utf-8?B?VW8zdmcxZWR0SUlsOFNlMEFKcVZFSUhFVm9IeStYeEoyNGNPczAyTW5WZXBP?=
 =?utf-8?B?ZG43YjhFV0tnd1hhWHNNOStFYmlydVFFeTBHc0taOFk4OTZFaFNiY0tnNURZ?=
 =?utf-8?B?M25Ua05vN21iMnZ3VUd4U0RKL09PeTRTSkpsMGltd2N4MlVIVVFCb0Vmb1Vs?=
 =?utf-8?B?Yk9TcWt2OTRNTzZiNXpoR2pnbnVZYUVHVit3M1IzZndFS0preE5HMTRTZVg1?=
 =?utf-8?B?MUdScmdmNTBrcTc0NGt5NERCaGU5Z2pWb2pqdWpEc1NoRllxVkFzYXcyT3RB?=
 =?utf-8?B?YnB1bjdXWXFpc2FlaVFqaHRDMVlaM1dtUVlaS2p4a0lkQUlLMHhLSy9sZUw5?=
 =?utf-8?B?alJ3b0czOU9Rdm0rNnVtcWZFSUNpZ0txOXlJUjl6c2JSdUN2MjF6cWJRRmxo?=
 =?utf-8?B?V3pGZFNjNnh5cHVFYkxGVUxQdTg2bndjNW1IanlLWTZYTVBRejd5MHFoUHo5?=
 =?utf-8?B?cEo2bUpJYjl1MVNFRkZyUkE1K0M4NEZlV09tRWovZ3d5d2h6clRiR1BlQjEr?=
 =?utf-8?B?aDJFNFVsbVVGekFrU1RQNTJEWVlSb2xwNnNOR29kb21HOTQ3NVZpUnJMUVZF?=
 =?utf-8?B?VE5rV1BWU2J3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR01MB7903.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXBWNjlmVnpBWEsxQWdOOHBRU3AxRW4rN1Fybmg1M3dHTlJxUTlCK1lRWk5r?=
 =?utf-8?B?K29oUGRBdDFWMXBFRGdWcnpLY1pWWE0vYWdRUE1Qa2JFTktLSjVYZ1hxbUJI?=
 =?utf-8?B?ZnVWQmlScGh0ZTdBdzlmL09mcW1GYWlDNEJxK25QM3QxMFJYdWF5UG5YOU5O?=
 =?utf-8?B?amxYR3AyL0MzUm5EZ3YrNkpMVHBZZ3ZHYXN5czY1TXZCVGpHQlRzdzhxVVNv?=
 =?utf-8?B?MTNPdkxoc3ZvYUVFTThYTmpwbVRjOFFaSnlpM09wMDJScFROQ2w2RkUyU1hx?=
 =?utf-8?B?TTZXWTlRZEtDKzZwS0hRdnlaNVVLdjBIYWt5cWZXdmJzVWxoY2wvRHJaTDdB?=
 =?utf-8?B?NnlKT2piT0tPU1ZEekQycXRZWDVrMGUzd0I4cGdsazhJMm1nOFBPTmZWbGky?=
 =?utf-8?B?b1YrMWpUL0REN0ZJNmVsMnZWazgxTHBmZTlvMk9RQitxcUxvUFZ1cktLdm13?=
 =?utf-8?B?SmtueUY2ZFNERFBaQm1mVlRCVUdJeVBQVEFxSGpNamE0ckROUmZjTkhDc1pt?=
 =?utf-8?B?eFlydENBUUpVazZNRldrU2JrN2g0YkkvWUtxUDVEMytqNmphZkxMSXVKejlE?=
 =?utf-8?B?UjRRR1dCNmJIK0Z5Wk9Cd2VDRHlmRUpJYXBPazZRRm92ZjFlaUtwL0RUdXJx?=
 =?utf-8?B?R2Zydmt1Q1lBN1dzYXJPUXFhUDl4Nkk5Tm1UeURYNFpZeDExQWJvMm05dnJw?=
 =?utf-8?B?TkdJbHlwNGdWakVROXp3OWxlbUs1djRmSVRSdVppbVptdjh4WmE4NlphMXly?=
 =?utf-8?B?bFNOTGIrdzRTNEhNV2FVem5UVGsvaTg1WXg3VVR5enBNM0lzWEFteUtoZ0pG?=
 =?utf-8?B?em9vbnJ0OFhPSGNQSDdDeGpqYVBpK0grRFN2eW1uT0hDNFNSdjVuRDJlOWRJ?=
 =?utf-8?B?R3pSbXBIcXRQV3NTU2o3R0Z0WFFCa2dFY0JGck00cTNQQXRRczBWS0h4UEZO?=
 =?utf-8?B?V1E3WVhHcDZ0L3RpWU1zVS90ZTBVM2JtR3NGY1dBWHUyeFlGV0xuV1ErRXJD?=
 =?utf-8?B?TCtJY2d3K0w0ZVJVWW94RFYyemhSTzRPNUthWUxkWWlQN1ZUVW9Pb2hEbmV1?=
 =?utf-8?B?S3FiVHgxVVFRK0x2RmlsMkhlY2JScUY1QWswYjM0ZU5kTS9Gc2xXdndvSUsx?=
 =?utf-8?B?YXlIUmpuQXAvbkFLTXNIUDJEQWd1OXZFcGtmVi90ZkxORDhUVjI0aC8zTG1P?=
 =?utf-8?B?UWZnQ2NmeE9mNmkxODJYTGMrZ2dYOURZaVd4L25Dd2xlMSswZlRUd1ZacTc3?=
 =?utf-8?B?cmVVNUNCYjJCckoyK1htLzBPaVRrWWltMWJrblVzWkEwQ1ZaYXRKL2xOc3pC?=
 =?utf-8?B?bDBBVFA0WXJCTk81OVNaMzVkcUI4ZUlkOVkvZUtUV1FNZGhKRHFndHgwdlBh?=
 =?utf-8?B?WnZ3dWF4YkJxRDczbDdIejJrRk55TS9OMURPaW1TcUZ0ZTNiNFJmSTdGcm5H?=
 =?utf-8?B?aEZIQ1poNm1NRndWTHBPQ3pZdmpKZ2U3RCtTQ08xNTZUelVzam1FQ21jeUpq?=
 =?utf-8?B?YVJucnRBUWZneGhMcDE1YWxWMHVCWlJ6N0dWemV0TnRQaXc2bHVwSEJxMXlQ?=
 =?utf-8?B?b3E3QytOczlkSkRBQnBvU1VZbElvZzZKTkEzeGZlRU9NL0t1cWJ5TW9tRkNQ?=
 =?utf-8?B?V2hIcXM2bDdKWURNdHZJbXJhQmdjVzNEQitaOHd4N1piSTdoT01CYkJzby9K?=
 =?utf-8?B?WURndVpSd3l6YnFGRlJNL2JZcnRqQ09XeDF2dXlQSUp0SmZ4aDZBdFRXcGR0?=
 =?utf-8?B?S3haeS9lU0V1cklkazhuMG1EcGhqcmdwOFVPYm55VDJpTysvUHpraFFCbkZT?=
 =?utf-8?B?aHJDWklsTEVsM3pydHIrUXU3Y2JQQ1plZFA5SldRRXUxVE9iZUh4VmN3aTdx?=
 =?utf-8?B?NlZLVlA2WDUydEkxR0NuTU4rNFdxZUlpOVJBeVkrVldZR0hQWU1UU2orUEI4?=
 =?utf-8?B?dGl3cXY2MERnT0sxUStQakJ6TUt5dnVjQVZDc0pEc3ppdTN6ajE2RlVBTXBj?=
 =?utf-8?B?NUNkMm5xcnhYWnlScEVtUEJZN0p4cUMrcXE1emVQN2dscnNabUtTYzdGeEdT?=
 =?utf-8?B?SHcwSW52TlMveEZiVFltQkl0ZW5SUnRnZGJEc0MyZWp4ZGxnVkJkTCs4QmJG?=
 =?utf-8?B?cUNHdGk3UzRJTUlQMktIUVkzdTdKeEt5UEVTVngvWWZtOUFIV0haSEcybkRW?=
 =?utf-8?Q?uoGFiM9VFCi5ZkRRU/k7jW4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df7777ce-5e6d-45e4-b17e-08dd8e59defd
X-MS-Exchange-CrossTenant-AuthSource: SN7PR01MB7903.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:58:00.6004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: adhIS7RrNqpHHXG4zmCVaWu1MU+QuLwR5px0R6Fl0RX14t5O+Ed81WsaDL0AfTscVh1xcXyZ6N3zbtGjGFDZxrzbYak+qc9y7a660YmJIIz1LmzlmQf9w0lkSNEkKQ3l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR01MB8948

On Wed, May 07, 2025 at 01:34:35PM +0200, Rafael J. Wysocki wrote:
> On Tue, May 6, 2025 at 11:38 PM Zaid Alali
> <zaidal@os.amperecomputing.com> wrote:
> >
> > A single call to einj_get_available_error_type in init function is
> > sufficient to save the return value in a global variable to be used
> > later in various places in the code. This commit does not introduce
> > any functional changes, but only removing unnecessary redundant
> > function calls.
> >
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> 
> Does this patch depend on patches [1-3/7]?  If not, I can pick it up
> as an optimization.
Hi Rafael,

No, this patch is does not depend on 1-3 patches. You can pick it up!

-Zaid 

> 
> > ---
> >  drivers/acpi/apei/einj-core.c | 22 +++++++++-------------
> >  1 file changed, 9 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> > index 47abd9317fef..ada1d7026af5 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -83,6 +83,8 @@ static struct debugfs_blob_wrapper vendor_blob;
> >  static struct debugfs_blob_wrapper vendor_errors;
> >  static char vendor_dev[64];
> >
> > +static u32 available_error_type;
> > +
> >  /*
> >   * Some BIOSes allow parameters to the SET_ERROR_TYPE entries in the
> >   * EINJ table through an unpublished extension. Use with caution as
> > @@ -662,14 +664,9 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
> >
> >  static int available_error_type_show(struct seq_file *m, void *v)
> >  {
> > -       int rc;
> > -       u32 error_type = 0;
> >
> > -       rc = einj_get_available_error_type(&error_type);
> > -       if (rc)
> > -               return rc;
> >         for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
> > -               if (error_type & einj_error_type_string[pos].mask)
> > +               if (available_error_type & einj_error_type_string[pos].mask)
> >                         seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> >                                    einj_error_type_string[pos].str);
> >
> > @@ -692,8 +689,7 @@ bool einj_is_cxl_error_type(u64 type)
> >
> >  int einj_validate_error_type(u64 type)
> >  {
> > -       u32 tval, vendor, available_error_type = 0;
> > -       int rc;
> > +       u32 tval, vendor;
> >
> >         /* Only low 32 bits for error type are valid */
> >         if (type & GENMASK_ULL(63, 32))
> > @@ -709,13 +705,9 @@ int einj_validate_error_type(u64 type)
> >         /* Only one error type can be specified */
> >         if (tval & (tval - 1))
> >                 return -EINVAL;
> > -       if (!vendor) {
> > -               rc = einj_get_available_error_type(&available_error_type);
> > -               if (rc)
> > -                       return rc;
> > +       if (!vendor)
> >                 if (!(type & available_error_type))
> >                         return -EINVAL;
> > -       }
> >
> >         return 0;
> >  }
> > @@ -791,6 +783,10 @@ static int __init einj_probe(struct platform_device *pdev)
> >                 goto err_put_table;
> >         }
> >
> > +       rc = einj_get_available_error_type(&available_error_type);
> > +       if (rc)
> > +               return rc;
> > +
> >         rc = -ENOMEM;
> >         einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
> >
> > --
> > 2.43.0
> >

