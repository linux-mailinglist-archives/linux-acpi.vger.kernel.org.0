Return-Path: <linux-acpi+bounces-8927-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC89ABB45
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 04:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BDC284698
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 02:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F051CA81;
	Wed, 23 Oct 2024 02:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hg++ZXkm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69B8467
	for <linux-acpi@vger.kernel.org>; Wed, 23 Oct 2024 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729648979; cv=fail; b=nww0wn7NuaBX0gGDzLhzxb3qGEF6j8POQWr0IaEXjKa5hfyOu7TlvJPuJbyGRVlVNTbHd1pSjkwBu84sp80O3SOi5pK78Uao0Idwmu0eSCtKvHo4n+5qwy36Sbr9fIr2CJi83rxM+ATN88/0ByGJl6ejbJzilRod7QRPnfUv1Ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729648979; c=relaxed/simple;
	bh=fgy/tWJmkpp4YjT3X9kC7wlX9Q4A6/UalWn+Kmignv8=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QuM+R9+xlN0atKEk/Ydr3GtIJQzyDvz4w2CGdaUHZC8x1PG7D4MTtkLkcTUM6++daRpTVdlk5F+oito2mqDEZkJ3xBs21vg2QYrkGmXx2KcieBZM1RNswVuvBzZB79L2PPqxVw4k2n2dpoEqikIEBTlxg/gKUxTxeuUWW6Bbkqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hg++ZXkm; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMKz/m5cv6WJUWrLZmeWUYN/ms7BWS1srsfoNhVOsWO8kYQfKpEJG5rO4tS5xSaB6yRo6BiI4CU15e0I+FXHQffL570P18bVcWvFxkSP68ScpfOGnOwp08afu8u1w+yQbKmTY2t8RvK2SHeL5CyKj9WMPrR2fzcaXzEFEmBrSvqTIZ+/8dvPIBDgxolpyVSv2anOR8xssGmOp3VN4HSh1usJz863y5otWp7Gqd2ximbXRre+hIhpuPOwxrZb1EOS88MdEj75jpqs0DsyLcoz38kwQgpKJ05bPTU4+vnAMVAg2zB1TLjXbgiOagb/oG/2no+HLF79JuctGQwGtPJnuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g7OmsBT7a+mn1KfO72AsheJNWThXecSQC5BAt/PokA=;
 b=k9Kbr4pXhsOBR7YKaug2KM6l4d56+LbAtSodiiDOXf+3ddPViHRCU2AGHxT/VwlP3njMZLqWxMtSYYWkDNGZH3+o15SKTjbwispJT07hMr2Nihark2yodxjVlaQ4fmFb6tYYe43NqwWOmjGiuS1ScqpKRqwnPqiX9L0dZInHOLt2LiDjDhHhRyznDJH1+4RQrBg5rYLumctZLXcdf043SZKXVwVtTsmc2a1AZQpcEsDO4ICaaYCdJgTyZItjW9OcHXHFgM+pL8pWs2yb25pu6Ck/0sbOfNGt6+UD45hJu3Gjd3+xyIEi7MW0uZ3QeRS+YSAgAsjWHNvpX/aS8rNmPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g7OmsBT7a+mn1KfO72AsheJNWThXecSQC5BAt/PokA=;
 b=hg++ZXkmyoAzsONqoyhHJAjlRLpAMrOEcNcmHy7lKFBwWKwgm6uU9UVrEGQgu9gPIBmbsiH97xTHQBFuGKLqUOD40yXyx5wDBAxB/92HzpKupQRPGsC0UZYuWlkvsmy0MBuDHLttEXFBN5sB5EXUkHTvZoHMI6K/XgM+a7scwRhGMXyMuYQAEy2ssfaQoQmq5Lh4DKmD3e6wG6JHpF9jxG263U5TkCNaSEAQd+SKOuCyBymM5g7f9YyUnChqWEwlyyKbgp+M48N9FVHJDI5r+ivJI/mRqpfvsgrFvu7yJaXTtVJagzXSRIw6uxko0bIHLPu1FGYLzVoAnj12lCfxCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7914.namprd12.prod.outlook.com (2603:10b6:510:27d::13)
 by SJ2PR12MB8036.namprd12.prod.outlook.com (2603:10b6:a03:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 02:02:52 +0000
Received: from PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378]) by PH7PR12MB7914.namprd12.prod.outlook.com
 ([fe80::8998:fe5c:833c:f378%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 02:02:51 +0000
Message-ID: <48ee2dde-de1b-4af4-91c8-eebb4e15e191@nvidia.com>
Date: Wed, 23 Oct 2024 10:02:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI/HMAT: Move HMAT messages to pr_debug()
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: Priya Autee <priya.v.autee@intel.com>, linux-acpi@vger.kernel.org
References: <170668982094.318782.2963631284830500182.stgit@dwillia2-xfh.jf.intel.com>
 <CAJZ5v0gTc_FzwkSxPEa7izbDYz6BWqx72TzEXxHGd3MRR8EUFQ@mail.gmail.com>
 <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
Content-Language: en-US
In-Reply-To: <0ca3dbc4-e791-404c-8058-2b2c24051f5e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0010.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::19) To PH7PR12MB7914.namprd12.prod.outlook.com
 (2603:10b6:510:27d::13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7914:EE_|SJ2PR12MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: ebeec981-e0f2-4d08-5ded-08dcf306cccd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFVjWlVnQ2hyY0s5OElBSGlVeEVMWXYrS2Jqb21LUXpZVVNRTks4NkVIaEUr?=
 =?utf-8?B?SElobnh1KytHR21INHptT0crVGt0c25wK3FJUWErNWM3bHFXRU5NSzBWMldJ?=
 =?utf-8?B?cGR1dVBrUzI5cmF3S3ljNGVBaStwbkErS1VMRklXL2RSNW1hS1l0bitoNWp1?=
 =?utf-8?B?bVYvMnBHSG9lWjlyNkZnbU8xVUNMWU5FUlJ4c29ySWw2bmoybk4wVFV3c0ZU?=
 =?utf-8?B?cGE5MnkyNkQrMmtlQzB4V2h6ZWJnTXdMNGMvaFZybkxrOHJwSUJXZ3NzcDN4?=
 =?utf-8?B?T0w1Y2U3cjF0aW9WejFqcVhPMDQ4eTNYWXZ6dnY1NXY3RytnVWRYVzBVbnd2?=
 =?utf-8?B?WG5ROWF1ckxaRGtCcGhIcFlwVFVFajJ6cVNySjJzSnc0S2J1dXBRZWMzaHFO?=
 =?utf-8?B?ZXE4UDhmQm5JOFpWcExyTjJ3MFFWVjZER0ZWSDJLRVR2enhPbEgwRkhIVDR1?=
 =?utf-8?B?aUVla3hUeDc5QitKaU5qbElXZkRzM0ttV0tpM0lZS3FnMFRPL2hnNnVnRGw5?=
 =?utf-8?B?Mlh0YU5xQUNvV1FRUkcxMHZrTDFlSWdvaHhVTkp5Ykg4NUJ3cGh1UVExVkVP?=
 =?utf-8?B?YWRuR1N4TEh1UG5GKytDcktuV21VdEVlUmYwbGdTcitwQ25DZkVFWnErK01G?=
 =?utf-8?B?d2RUbnlOVHhMNW95Y1RtcG5iRXQrSjcrRTZoYkFEdFNmNXY3eTZGL2dnd1lt?=
 =?utf-8?B?b0gxSy85T3R1eVVHUHhEQThqLzF6Z2dUOFArbTU5V3JUVHIyVXpXZzB3NGRX?=
 =?utf-8?B?K3J0Wm0wSmhHS3ZYQWZkd2lJZHVrR1FKTlF0R3duTzVFQUF5aytlQ2ZJTUFj?=
 =?utf-8?B?MlgrL2F1aFpUWHpNanE4TVJIUFB6ZEthdmo4UjNrNVV0OWhadllLaXlkUEpx?=
 =?utf-8?B?VVU2a1Bwb1RRVllkOEpxY0NmZ2hMVCtZeTNBcHZiQTlVNWlkenFYc3pDZG1w?=
 =?utf-8?B?akpHYjFld00xeS9hTFc1eW04Yk9HYmZRUzRGZ0EwQm9MMmllSEs0NzNSTkpT?=
 =?utf-8?B?M1BLc29ISXN6Slc0VStXQXdJRFpGcTR0N1JsYURGdHJPTnFYQ1dLQUJZTUFq?=
 =?utf-8?B?WnRabG5laDRhNlZHNWpYVzJVdVlqMDZ0SnZwY2lDdUQrL292V1llQTlhbzN1?=
 =?utf-8?B?RjlIKzRQZUtuY21iaWZoS21CM3NIRE81WkJLTm0waVI1YXJjazd5dUJKZEFo?=
 =?utf-8?B?dDY3OGVhUEFUdzRETldmMCtEUnI3ZHRKYXVuZXdOa1A4ME1MdTdUczJ2QlVz?=
 =?utf-8?B?bitUQ2FmdUQ4cmhMYzczUXBvVWU2dE5mcUhpOEFacmRJZExPNkpmOWF3MTBV?=
 =?utf-8?B?UzJtUStqU1JMK2Y2dDdhcU9Ic3g2NUFhcDZ1MFBncDAxcWE5MjcwcUR1WUw5?=
 =?utf-8?B?VmF5QWZvTDBIeVdOZWx0M2dzeHpMYlFhQmR1MzZOZHFTUW52NWI1ckFoandZ?=
 =?utf-8?B?YWdHRFBTUTNLV3YwMklTREE0Tlk0YzZIbGtXQm9tSGdMVlNxWUE1cStXSjlr?=
 =?utf-8?B?UmQ3WVJrSnFQaFRtUGxramxZRzRwd2dmdUpmb1F5a2VJdFhHWDl0VWhNSWt0?=
 =?utf-8?B?TFBQL2JRK1kvQVdCZlF1Tm5DU0ZDSXUzdkFaSjNxL2FzREpGcFIrbENiRnlx?=
 =?utf-8?B?NDdPM1hwU3JaUk9ZMXBoM1hrK0NWZ1FERVZOV3RLOHRQbnllbjhJcjdCb2k0?=
 =?utf-8?B?TTVnOTNUUm1KTTQ3YkREMXY0RXRHTHBiM1BibmJaNWpSV1Z4YzhYelFMam11?=
 =?utf-8?Q?gifuUz7U6WDjV5jxzcsIAu44YNgdA8BXpWxLKaU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGtzT1l3a1NtVHBXSFVIdStqd0Z6eDJyT2w2VFBCMnpOdHVGTTVFSCtFeEgr?=
 =?utf-8?B?RXNseFhsbDdlVzFObEZ2NzdXN2dpOHdPOWRVMndtUnFqZW41cTJidndiRHVk?=
 =?utf-8?B?Y2xocE9GZlV6QkZQVmp1eG1oV3JhK1RQRmFMcFJkTnh6MzJZTHkzZEdLUUpX?=
 =?utf-8?B?VndiVGoyL3VnZHV0NWNrbW00VVJJc1NWTkVoT1cyRDd2Q3M0V1R4VExnN3pa?=
 =?utf-8?B?K040VVRmR0N1cVpVRkVuVXh2RjFFM0xPMDZkdURjTHRPNlZlcmFDTEN5UkRk?=
 =?utf-8?B?RTYzZlBqUE0vL0JCUSt2enQzMG8zYWUveWtLbGpWUkxxNzJPNzR0YUM4S1FT?=
 =?utf-8?B?Rm9SRnBGOUNBUWxFb1Z2ZmpzT2E4dytkbGdnRE1XU3JOQW5qcmdNWkdBcDBp?=
 =?utf-8?B?ZU4yQmk4REwrYVJGcElvSGRDUlkrU3RSbTMzbXhMK016YThVWVlaUXhnL2RK?=
 =?utf-8?B?dFZqTEVuZHhDYVJ2Mi9QNXI5QWJGRjloeWZnNzgySklCcG1MNmt0UVd1OXEw?=
 =?utf-8?B?Z2ozbmg0U1poYUxxVU1HVmRkTlk0SkZES0RxZ1BxMnZVNVF2ajZBSm1tK0Zt?=
 =?utf-8?B?cE9RRGgyL3VQbFRJSGNOY1MwWFgwWCtiSWxac2RCc29kK29GcHZOUGtnM2hs?=
 =?utf-8?B?azFlbDJqRktMQ1Y3YjVHZEpTRUF5MTdwMkJEYnBtTzMrdjlUQ2pBSmJFbUtq?=
 =?utf-8?B?Y2dBMmY1eG51b2NReHlzR05tUmRPWkpTVDlWOWZmSTRXV3ZnMnhRaWNhSjVk?=
 =?utf-8?B?cmxMZjJEWmU5Uy96cWdaUVZKK0xPTW4rbmhVYWNVcTF3VFVmWnIya1Z0NXR6?=
 =?utf-8?B?MURDZGF2dnFkZnZReUtqVGUrUVlGT01ldnFoRU5lWXVQOVpiM3cxblVkYjhP?=
 =?utf-8?B?a2pnZU1Dc2VucC9GUWg5UVp0ZEEwK2lHekdkMmxJVm9VdUl6MWlZcEZWaVlr?=
 =?utf-8?B?cWJyZ254akhXYW45OUh2ZjY3ME8wQzhMb0JEQmIrTHJnblAzSG8vNzRaUURj?=
 =?utf-8?B?Znl1am9DRjRQZW5PM0ZrUHZFWUpkTXRPV2xWalJJM3dpUzQ2NW1qRjdpYVRn?=
 =?utf-8?B?c1A2ajR2WDhDQXU0K09yekVVQ2o5V250TXBBbTMvOFR0VU5zN2pJeUhRUkRJ?=
 =?utf-8?B?ODVybXkrcUI1RUIxemU1VUdRYmgwYVorSk9Ka0lPZTRyc1VMZkZiN3hTejMw?=
 =?utf-8?B?YnhwQ1UrN2FtZUtGY05od2dwTnRFci9hQ3ZnQWFVVHM1SGJUMlUrMkY5VWo2?=
 =?utf-8?B?anBONmRtVXgybDkwWWpValorNjRkcmRWaUl1K0FpVGVuSWNySGU0blZLZXBY?=
 =?utf-8?B?eVo5MlBqSkRDMWlRZ0pyQml1QW9RQm9uOExyRmtMMkdXdlhqaU9YWGozbGR5?=
 =?utf-8?B?bEFONHB3UHNkQklSSDNHQTFKL2QrQVBLSE5TdWNiMGVMVDJFZjZJL2U1cE5n?=
 =?utf-8?B?ejZHWWdMUGNYT0V5d1FRK2VQVnhmbmkwaWNyVlBOMGJJQmNFUUIyTXdPK2Zx?=
 =?utf-8?B?bWUwaWREYld1M2FKcXJlN0toRlVYS2hqUVR4Q2RjSUliQmMybUNoVmw0QzBP?=
 =?utf-8?B?VW5XVlp2T2hCcHZ3YVVYSmFVdjI2WXMvaEd4UkFBSytFY0xZVDdWazdlZlVj?=
 =?utf-8?B?cXVoT2l2SnZqVStPckJJN0U5Qm1ZS1JIUS9UVUpZaTYxR3ljUWIrK3R1TEtO?=
 =?utf-8?B?Q1NacDNEajNOOXJsOTRVK2tTWVZZaTdpNkYxOTJ1MzQxRkF3OTdaampacmxX?=
 =?utf-8?B?UnJqQXBEU0FySDR4bnhHUjc0VnAxYzdSdWx0RCs4eW1HRkViQlg0dWFNTUda?=
 =?utf-8?B?TjRjeXlPYzJuYkw3UmtNMHFZN1hqUWtNbW9XSUNSU0VRNGdqMWI1QVdKYm5u?=
 =?utf-8?B?OUFpRGExS3BXVnZBM016ZE54TldSSjNXTmNuc2ZTbmQ1eUYzYkhXSGx5bXZU?=
 =?utf-8?B?dTFEVU0wK1FQaFExalNBT0d3MmdoZGhxMVJlK3NTd1hoN290V053dHk0WHBP?=
 =?utf-8?B?SGorZlZvak5UWXV4aUFXcGN5bEQzUTA5WWZKNThzZ0tVY2puSTRrUGg0MWRk?=
 =?utf-8?B?a1dOZjFFbHQvSVlZai9XK1h6dFhKMkl5cUhvem1kTXhnZ0FtUWNXdXlGc3V3?=
 =?utf-8?Q?0k8vqPq7iZA791ELH9y4o0vzN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebeec981-e0f2-4d08-5ded-08dcf306cccd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:02:51.2665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0ip/pWMMRjvDgL3XESWH3XBLQU0hjVHBbrorW/Wyg+To5wttrXqC1XOCZ+Yz3gyFfeOo88qlI0zNF4Lf5dRNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8036



On 2024/10/7 11:03 AM, Kai-Heng Feng wrote:
> Hi Rafael,
> 
> On 2024/1/31 7:54 PM, Rafael J. Wysocki wrote:
>> On Wed, Jan 31, 2024 at 9:30 AM Dan Williams <dan.j.williams@intel.com> wrote:
>>>
>>> The HMAT messages printed at boot, beyond being noisy, can also print
>>> details for nodes that are not yet enabled. The primary method to
>>> consume HMAT details is via sysfs, and the sysfs interface gates what is
>>> emitted by whether the node is online or not. Hide the messages by
>>> default by moving them from "info" to "debug" log level.
>>>
>>> Otherwise, these prints are just a pretty-print way to dump the ACPI
>>> HMAT table. It has always been the case that post-analysis was required
>>> for these messages to map proximity-domains to Linux NUMA nodes, and as
>>> Priya points out that analysis also needs to consider whether the
>>> proximity domain is marked "enabled" in the SRAT.
>>>
>>> Reported-by: Priya Autee <priya.v.autee@intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> This patch doesn't seem to be included in the tree.
> 
> Is it possible to pick this up in the your tree? Thanks!

A gentle ping...

> 
> Kai-Heng
> 
>>
>>> ---
>>>   drivers/acpi/numa/hmat.c |   24 ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>>> index d6b85f0f6082..5331abc7c956 100644
>>> --- a/drivers/acpi/numa/hmat.c
>>> +++ b/drivers/acpi/numa/hmat.c
>>> @@ -409,9 +409,9 @@ static __init int hmat_parse_locality(union 
>>> acpi_subtable_headers *header,
>>>                  return -EINVAL;
>>>          }
>>>
>>> -       pr_info("Locality: Flags:%02x Type:%s Initiator Domains:%u Target 
>>> Domains:%u Base:%lld\n",
>>> -               hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>>> -               hmat_loc->entry_base_unit);
>>> +       pr_debug("Locality: Flags:%02x Type:%s Initiator Domains:%u Target 
>>> Domains:%u Base:%lld\n",
>>> +                hmat_loc->flags, hmat_data_type(type), ipds, tpds,
>>> +                hmat_loc->entry_base_unit);
>>>
>>>          inits = (u32 *)(hmat_loc + 1);
>>>          targs = inits + ipds;
>>> @@ -422,9 +422,9 @@ static __init int hmat_parse_locality(union 
>>> acpi_subtable_headers *header,
>>>                          value = hmat_normalize(entries[init * tpds + targ],
>>>                                                 hmat_loc->entry_base_unit,
>>>                                                 type);
>>> -                       pr_info("  Initiator-Target[%u-%u]:%u%s\n",
>>> -                               inits[init], targs[targ], value,
>>> -                               hmat_data_type_suffix(type));
>>> +                       pr_debug("  Initiator-Target[%u-%u]:%u%s\n",
>>> +                                inits[init], targs[targ], value,
>>> +                                hmat_data_type_suffix(type));
>>>
>>>                          hmat_update_target(targs[targ], inits[init],
>>>                                             mem_hier, type, value);
>>> @@ -452,9 +452,9 @@ static __init int hmat_parse_cache(union 
>>> acpi_subtable_headers *header,
>>>          }
>>>
>>>          attrs = cache->cache_attributes;
>>> -       pr_info("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>>> -               cache->memory_PD, cache->cache_size, attrs,
>>> -               cache->number_of_SMBIOShandles);
>>> +       pr_debug("Cache: Domain:%u Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
>>> +                cache->memory_PD, cache->cache_size, attrs,
>>> +                cache->number_of_SMBIOShandles);
>>>
>>>          target = find_mem_target(cache->memory_PD);
>>>          if (!target)
>>> @@ -513,9 +513,9 @@ static int __init hmat_parse_proximity_domain(union 
>>> acpi_subtable_headers *heade
>>>          }
>>>
>>>          if (hmat_revision == 1)
>>> -               pr_info("Memory (%#llx length %#llx) Flags:%04x Processor 
>>> Domain:%u Memory Domain:%u\n",
>>> -                       p->reserved3, p->reserved4, p->flags, p->processor_PD,
>>> -                       p->memory_PD);
>>> +               pr_debug("Memory (%#llx length %#llx) Flags:%04x Processor 
>>> Domain:%u Memory Domain:%u\n",
>>> +                        p->reserved3, p->reserved4, p->flags, p->processor_PD,
>>> +                        p->memory_PD);
>>>          else
>>>                  pr_info("Memory Flags:%04x Processor Domain:%u Memory 
>>> Domain:%u\n",
>>>                          p->flags, p->processor_PD, p->memory_PD);
>>>
> 


