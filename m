Return-Path: <linux-acpi+bounces-20059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 972EED03CA3
	for <lists+linux-acpi@lfdr.de>; Thu, 08 Jan 2026 16:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CBE9302017F
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Jan 2026 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEE73587B1;
	Thu,  8 Jan 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DCcdRIhw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2782E5B05;
	Thu,  8 Jan 2026 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767879134; cv=fail; b=S+kH/VY2wCqmi0kA3I3tmAPOZ81XbT772dU/7oVz4kDhl31KXGn4yKcGReMXrxJbBC4QCw+i54NC5X5ACp74lKUt9vtY12oSWpA3KKqCfnYsUQX/HvYOqNBViZzlhTh8RjbFcjA4ctbfK1i6FGEi1xzHDy4bIiDT9Qzp2+8WlyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767879134; c=relaxed/simple;
	bh=EbtKNc/reioTiSTwj+d4t3U8fslYLeRRuebAfr2dAvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmM3HDT0fvEhxeDDvHEkapcpYe3hzIyEHyTQc79BbfW/wNRE/+ONNXkqX1g1PsomPoDDtjIZnH0O5qi7LAsl0flN2hfvtoD2bLQ/quhUF2TbHtFi7fwzJM+gyzhhOHVAH+HkHth5X/m0+tLkyedqZwTReYfaWVr405Jwug2DdnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DCcdRIhw; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUkS2GBTy9WLAUWgCxMj5vs+P+fUtjP7QV7ADgx5zi52gT9JnwHKpdK6t98yXHvkzAPFyFuVKpSiLCnRDLaTtbkQ4jLJpHNs/ZmLyKvUIYeR5X999zdEXvbsMRTnibXU4IiP9Q0HsAMB4F7DBWFJJ9POktU99bJvdcvWzyzDdgjHx4Chv7rBOC6Xt+YcImLRwkaT3bxYejhWGofhoqEFXVC9Rw/iYxxZk1Psbp3pEVEi/y8zcAMRp8P3K1lh4yzQvfMOCI4wOxHIZ3BFU/rj7p+xKDoKtnKcYBBPeUxDmas7Gn6xA25LsP0k32GgCKfoaxeW2XW8onScHDwBUFnE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5nVDCefdXpBFijSBquGbEK8EA8kXyd8aEDh7UYFo6c=;
 b=b0ssd3l/9GBlnp00wLXRfNR5ZgzIVFGegbhPylUYdyxty4UcxA3B7vwqayLJCTFs318LDV6wKn9J0aHR1u5ETsLrtXQyOgSLBUZxg/UuBjLmXcOPYtBRnh5aYfkXZ8Uk1DNeFK3y7nP55vJ9CLx8YbjwZc9tsznIfVHqzsi903v18BReIucLJyKSFVT4pf14w0HtgulEEJk07E2G5gDT2fZ0EWAjsXvDK/MI9palL6I1l3NIorEohRsIWjrPT19MXb5FGKc0W55eDY/CpA8xpbrMGiJ7PN2Imd/7TxGJ18TTMn2gseiPHG3hxo+oP9jQW3ThBPDKhYpHtx+KucwhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5nVDCefdXpBFijSBquGbEK8EA8kXyd8aEDh7UYFo6c=;
 b=DCcdRIhw4cPZnRc1JiI70Yo4dd8rXuiGzL8/swFDbzpOmMmfy7LLdfudbll1NrmCyVvkDSLeYKN+1dR11+yEBf+T3xkXbf8SvZUUOHgbwnMdla5MxcXpA+PIDr7IYIfEQZ1gjmdexQwg9YhxlV+1kwz6+Hm67G91TVfHuvMbYERdARmXySzwsiBlcaSxv17WS8titgN5Joyn9aKZVUc2AVRW8X5aY4afIV7N2caY8z1rkaY+GMlJWafG6mKG4tkCwmXfiz6Bhh0eLZmTTW3H1lrTdnTSSw81y9dt6jMLSYn4Pnp1qjGkPEsabUfxgJbxIn1KDSreB92XjuEz2vxqmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by SN7PR12MB7156.namprd12.prod.outlook.com (2603:10b6:806:2a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:32:01 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::44e5:415d:e1a8:6e42%7]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:32:00 +0000
Message-ID: <bd2e287b-481e-48d8-8bfa-73dbf8758220@nvidia.com>
Date: Thu, 8 Jan 2026 19:01:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/11] cpufreq: CPPC: Add generic helpers for sysfs
 show/store
To: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, rafael@kernel.org,
 viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
 corbet@lwn.net, pierre.gondois@arm.com, rdunlap@infradead.org,
 ray.huang@amd.com, gautham.shenoy@amd.com, mario.limonciello@amd.com,
 perry.yuan@amd.com, ionela.voinescu@arm.com, zhanjie9@hisilicon.com,
 linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: linux-tegra@vger.kernel.org, treding@nvidia.com, jonathanh@nvidia.com,
 vsethi@nvidia.com, ksitaraman@nvidia.com, sanjayc@nvidia.com,
 nhartman@nvidia.com, bbasu@nvidia.com, sumitg@nvidia.com
References: <20251223121307.711773-1-sumitg@nvidia.com>
 <20251223121307.711773-2-sumitg@nvidia.com>
 <dbbbdb83-24d4-465e-99bb-689cd6e37460@huawei.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <dbbbdb83-24d4-465e-99bb-689cd6e37460@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::12) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|SN7PR12MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: d741497a-7216-4018-96c6-08de4eba4d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3M1c3U1YndERGZMeVlLTjk3cHhxK2tJVDQ0akxRZjZreE13Mkxac2doNjFR?=
 =?utf-8?B?Y2pISnNON21sU243dDhJMWpaUmNZMW93SUtEVDdlT2FwVGEyWHVpeGVmTDFk?=
 =?utf-8?B?azVZWmtlSVdRUTFLdTQ4SmlBdWFCeERsdEh5TTR6Zm1PeXFKQThvbU5ac3lB?=
 =?utf-8?B?ZHZYMUIrL0RtN3pzeG9CWHF3aWJocjhjL1d6aVpnQVFRNmVPY3J0ZkJwWWhT?=
 =?utf-8?B?ZDdxOW5kYW9KQU5vL3BNM1hXdzc4ejJnaDFjWlJYV1NGSXdlWXJ1c28yNkxy?=
 =?utf-8?B?bCt2MzNNWFErSDlheGp0dW0zV1NEcVhMOWdYanZPRDRtNHIyK255Tmd3N2wz?=
 =?utf-8?B?a3NZLzUzUmxpVStyaGg4MGV0bUM3Y0REcVdmd3V1UGZXcG9iaEtUcFFPYnZ3?=
 =?utf-8?B?VTM1emU4ZytvZElTbUhDTTBibEZaRTNKTjN4MC9KUFdjekR1TXFPd3ArV0xX?=
 =?utf-8?B?YXdQcCtLTFEvODErYjdDMWd4TlNlSFhjcnQ2ZjJRaWpiK1pLbGlVc3FsZlA3?=
 =?utf-8?B?a3Z5SDdWZnFjbEFYVEpkVGw5VGFvNjJLK2kzV1dLZkpMaWxVSitobkFRUURY?=
 =?utf-8?B?WDc5dE84ckdCUjVRYUpCb2QvbjlDOEp2ZTVnYitwNmVBNXhlTVVUcFFZeUNL?=
 =?utf-8?B?QjlsT2IwbnFvY0pLSGJDaEdzRVVpc1Zvek9tRk9NUFl5OTB1cnVOVC8vaGd0?=
 =?utf-8?B?Qi9BQUx0WTlOR3U2MW1HNEovU20zL1pGcXRRMmduQ1dNWkNVRE9MYWRsb2dB?=
 =?utf-8?B?M0NxcUk4YVlFK0llYW9CTkdDVmdQTHlDSC9XbFpaZ1lvRzNKU1Q4QmhXaElh?=
 =?utf-8?B?dytSZ3dpWEY3ZVNGTHh5MGdzM3d3cGtWVTZtZml5UkZRZHNKUnY1QXVLNk5H?=
 =?utf-8?B?TmVId1padXZxZUthTEV0WDdPdFBpUEc2b01WWjk2UCtaZHQzYkJSZm9FVlpB?=
 =?utf-8?B?bVFUdDFlalhnTnRvdmpaVURtRWlUNEYvYy8vZHNHMWN4RHpBZ3NNalpGQ2tH?=
 =?utf-8?B?cmFVaWlIVTJSUVFVejZrRVFuM0ZVcTc0Mk52ZnEvVm9qQXlXZWsyUDN6SXBP?=
 =?utf-8?B?Z1hsOXlKU3p0YlJuZ1B2UEtMZFY3ZVRhNlFnYktOTGNWRzZ1YjZyR0Q1L1Vv?=
 =?utf-8?B?bERmTGZtNkx6Z0JlbjVEejdkRUNRT3VmNGxNaDV0eXVqT29JWmZMSFNrdWFz?=
 =?utf-8?B?NmdvVTJnRURkSTR2MThCMUFDVXU1MEdZYjJzRFE5dkJnWHFyblF5TjRzUDB1?=
 =?utf-8?B?akNWanJ5NHFSZWJlaldVUVdlWXRiYUZ2NTVCWnVFM1RRKzVUZjhlUnBVdmdr?=
 =?utf-8?B?SWFkVzNIQ0NFZ1FwNCtzUkIzSkE1aUtIVlRqU3IzSVJ0MnZWZWV1S3Z6ajR3?=
 =?utf-8?B?UFhnWGRQUGxZTEFiQ1BJU2RhU3RYSlVjaHgzdFZ6NzlMQ3UwNDRxeFpNZEFu?=
 =?utf-8?B?Zk9YWjlPUFRoRlUxMlRxQ0JlMUI5eWhjdHBobTJsdDRaaGw2b3F1QW5KMk1N?=
 =?utf-8?B?Z2lDMmQrRDJvZE5SZDlkYTZNdkpkV3o0aTNzcGFaeUo0dVRkMzdyOHRYbkhk?=
 =?utf-8?B?cW15cmhyNVh4K016dkRjR0NVYy9xM1FPWkJxQVJpV1Fvd1pyRVRDNkNRckhp?=
 =?utf-8?B?V0YzVUNWK0h2Y0xDQ3FBZWtlazdka3YrZlh4MzFmS3N5R1ZHRDVLRitqVndK?=
 =?utf-8?B?eVBQNHJhb1RjWnRmMjI4ZEMza2RPV2IvYllYWnRWOWhwSVdnd1dHVElSenNP?=
 =?utf-8?B?L2l1ZWdneFRxZ1VBN3A1UWMrTm9pMkxZY0FndVUrYlR3Si82bHpXZFc0aGFh?=
 =?utf-8?B?Ym4yQUJOYm43ZGVUK1BJanVLNnIyYldmaElwTkpkY0JJdm54alp3cWl2Rzhk?=
 =?utf-8?B?SjNFSzlMSHVDYnRNMVBOOXBDbVVmOUpFYTBNeUU3TmtBYnNEWTB1ci9QWFE0?=
 =?utf-8?B?YlFLNWRROWJoOWxiTWdIdjhSNzMzWXIwdDhZTzQ1ZjVYVm5JNm5IUnN3ZzJz?=
 =?utf-8?Q?XcGMA5gxkIAZzSUi6p0IBeh/XmWOBQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDBCbXV0T3dpeCs5YVNnbjFmOWNuSHRjemR4VDhOWGhxbGF0TkJOeUxGaWxs?=
 =?utf-8?B?cXFLcUNkY2QwbkhWT0JWVjhBK2hXdnlUdm54QjdCczFOeVlFcVZXR2sxU2hB?=
 =?utf-8?B?a2t0TVlOV0puOS9kaCtxc3ZZZzNMOXhNV1pjelJhKzRRcU5BNTFvc2Y5bUMr?=
 =?utf-8?B?L0QvVjVoRUF3azErakV0SVlqUi8zNWlpamFWZ2JxRVI4emxwaDdHemZPVW15?=
 =?utf-8?B?b3FtZ2E0QWRVaUh0MmpNdTNZbmxrRlVBOTlmQjZXWDV0TDI4NVM2R042ZlI5?=
 =?utf-8?B?M3BnYVNjQUR6elVXdjc5UHBjbU1JWnJGaG9ZdzZKUTA2TUFZZ1V0cjF6YnhL?=
 =?utf-8?B?SWt4MTlia0NscHZtMDVjTkM4U1BRazloaUUwRnl1MDRoZzJxL2dQOVpsSHUr?=
 =?utf-8?B?RytQcjRwbEljMHduOCs0b0k1cG9uR1h5QnZ4Wmdmdm12dXhVU2tndzkvTGRq?=
 =?utf-8?B?TWlucW9tVDV1R0hwSWJ2WWUrZGp1UWNRTEhRMyttRlpNZUdFd0hWeVRDRE9K?=
 =?utf-8?B?MmxBWlkxUDU0Z0lOZGxMUk83RXJoSzl3ZldvaWtLVDBoc0dSUVA0VU5jZjJ1?=
 =?utf-8?B?NzY1b09QOU5YdTRYQlBiR2Q3MW9iUzJWV0wwNGY1ZnZEclpDMDA5b2xkdENn?=
 =?utf-8?B?VlRMVUp4bk5oR0E5K1o3MHlFdDhpcklQRWc2U052WkZzYkJQSXNsRTVpbENx?=
 =?utf-8?B?ZDhUcDkwa2NFQVZzNUpMZ2JxWjduWFZKN2RIc05Icmw3R2R4Qml5cVJMaFIz?=
 =?utf-8?B?b3dPTXFXeEQ5UHJoN2JlYVgzcG1nTTd0cGZhZjJvMlpiTFQweE5lYWRHcW82?=
 =?utf-8?B?UmFHQlNCSW1qZUZ4RVM1SlloellONkhTaHE3UDhnUUxoSWZBVzRNMTFzVzQ1?=
 =?utf-8?B?YVdSZHFSeXc5Q1Rad2JEWlNNSjFDQU5aRkQvcU1yN2tYV3Z2OG44VkVzczlS?=
 =?utf-8?B?WG9CNTk4ZkZvamI4SERiNytrdUU3S3prTzZHRXo2eUhOSXMyK0xiZVdnTUlW?=
 =?utf-8?B?SjN0d0RsM0NCeHAyREtGUzFvbXFRRDFIT3dkS3ZxbWVRcEJFckhRZEMybTY1?=
 =?utf-8?B?a0Q4MFhMQkgvWVZIZXpNUzlzR1c3M2E1SDRTa2M5QjlXQWFiREpzTlFnZ1Rm?=
 =?utf-8?B?K2E3WllXWVNWa0NaS0oxZG9sUWlBVlA1ckwzQzVtTE9MTk9tU0xkT09ycmVE?=
 =?utf-8?B?VFBuRU9OSHJreDk5ZUlPOWdROGxkOGhiMmJwMytGWXRBVzVJYmIvbkFadTZF?=
 =?utf-8?B?ZkVvUGxGd3NYRFFJOFZoS3RvZWRrakdLMUN2UDhHbXVhMkZFWFlxL3RUTVJ0?=
 =?utf-8?B?Vk53WHVRU21FaTdvN1NnamxpMit2d2xINXpMTGY3QW9pV2Z5cEl5MjAyQi9w?=
 =?utf-8?B?MytFaTZLZzBvcnBNeWcyaHExbnZyNmd5azkxdDRUU2xyam9rczdzdnVrcjRQ?=
 =?utf-8?B?L29BWVV1WG9vVGtoNU5IcWFlVmlWQytoK1ZZVlFhWkZGeEtNeGNabWtseUtS?=
 =?utf-8?B?Tk95S3NsQUs5OSs3TmxlZXk4Z08wbXZ3TGowMHZuMUoxNUgrTmdzSzdhQmhK?=
 =?utf-8?B?dnIzRUdCZG9SS3JjR1NONitDbTVVcGwrYmRaclg0U1A4eGhRQnFsalJNbWpn?=
 =?utf-8?B?eSsvVDJKWjR5ZlVmWFBWaDBqNnIvbys4eWpJTG5PUi9Tcy9GaWdmcnZtZFZ0?=
 =?utf-8?B?M0kwUHhLenEvTjJROEc0S3VNUnRGTGJqWGlhcVZjTzc2a0ZyVUc0ZXBzRDhM?=
 =?utf-8?B?Y2N5amFYVGtvblZ1K1o4R2QyajQ2R1BtamJSdnFMbkEvenZzYm9tc1FMWFFn?=
 =?utf-8?B?QjRIZjhvRm55RDJxc2tZQXpZNUhmQWFkdkx5azVoT3BEeWs3ZG5QTUxGRmVt?=
 =?utf-8?B?V0g0UVhKa05OakQvdm5YbHZpUXZtVnVucmFtcnFla25QQkdNODI0U3Bwd0x6?=
 =?utf-8?B?bnpJZWhGZGMzd1dKVTF3ajNkTlA1RnMrc2VqQmZkdVVWSGhrUXhHdFA5SEd5?=
 =?utf-8?B?czJkU3JVMDFBaThmdDlFVEJQaFNaRmRCcHdMeTBYVFpqTzI4aWd6ellRNzg5?=
 =?utf-8?B?YmsrQ0RkVjFFSFlKcmxGcEV1LzJOTEJycDg4YnRSRWM0QllHVFBGcEtweEc3?=
 =?utf-8?B?Rm9VdEM5a2U0eHZiWHhUaG14TXN0OEYwRUJtZUFMeWVzSjJBQkJRODlKYUlZ?=
 =?utf-8?B?cy9DTkI2R3JQZjY2MWVYbDZTRHR0ZjlwZm9NY20xTEZiVWtWSXFRb281M3Zk?=
 =?utf-8?B?UjBKYVNQSk1HTkRIT0thZDJHSFRVS0FiRlNpczc1dSsxSWEzOXB3eTd5N1Vs?=
 =?utf-8?Q?eYaCrk2dfG0bBM5Nib?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d741497a-7216-4018-96c6-08de4eba4d83
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:32:00.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kxB+0asOZBJWdvR9UKBIW5r5ZTa6DOi9dt6q3b2JbyudPj4cvX3mwACvPEauILHPsp1mBt8/LJlI2+wcZiSevQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7156


On 25/12/25 09:11, zhenglifeng (A) wrote:
> External email: Use caution opening links or attachments
>
>
> On 2025/12/23 20:12, Sumit Gupta wrote:
>> Add generic show/store helper functions for u64 sysfs attributes:
>> - cppc_cpufreq_sysfs_show_u64()
>> - cppc_cpufreq_sysfs_store_u64()
>>
>> Refactor auto_act_window and energy_performance_preference_val
>> attributes to use these helpers, eliminating code duplication.
> How about adding a macro to generate show_xxx and store_xxx in one line?
>
> Just a suggestion.

will add macro in v6.

Thank you,
Sumit Gupta


>> No functional changes.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
>>   drivers/cpufreq/cppc_cpufreq.c | 71 +++++++++++++++-------------------
>>   1 file changed, 31 insertions(+), 40 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 9eac77c4f294..7c26ce554e29 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -831,72 +831,63 @@ static ssize_t store_auto_select(struct cpufreq_policy *policy,
>>        return count;
>>   }
>>
>> -static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>> +static ssize_t cppc_cpufreq_sysfs_show_u64(unsigned int cpu,
>> +                                        int (*get_func)(int, u64 *),
>> +                                        char *buf)
>>   {
>>        u64 val;
>> -     int ret;
>> -
>> -     ret = cppc_get_auto_act_window(policy->cpu, &val);
>> +     int ret = get_func((int)cpu, &val);
>>
>> -     /* show "<unsupported>" when this register is not supported by cpc */
>>        if (ret == -EOPNOTSUPP)
>>                return sysfs_emit(buf, "<unsupported>\n");
>> -
>>        if (ret)
>>                return ret;
>>
>>        return sysfs_emit(buf, "%llu\n", val);
>>   }
>>
>> -static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>> -                                  const char *buf, size_t count)
>> +static ssize_t cppc_cpufreq_sysfs_store_u64(unsigned int cpu,
>> +                                         int (*set_func)(int, u64),
>> +                                         const char *buf, size_t count)
>>   {
>> -     u64 usec;
>> +     u64 val;
>>        int ret;
>>
>> -     ret = kstrtou64(buf, 0, &usec);
>> +     ret = kstrtou64(buf, 0, &val);
>>        if (ret)
>>                return ret;
>>
>> -     ret = cppc_set_auto_act_window(policy->cpu, usec);
>> -     if (ret)
>> -             return ret;
>> +     ret = set_func((int)cpu, val);
>>
>> -     return count;
>> +     return ret ? ret : count;
>>   }
>>
>> -static ssize_t show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
>> +static ssize_t show_auto_act_window(struct cpufreq_policy *policy, char *buf)
>>   {
>> -     u64 val;
>> -     int ret;
>> -
>> -     ret = cppc_get_epp_perf(policy->cpu, &val);
>> -
>> -     /* show "<unsupported>" when this register is not supported by cpc */
>> -     if (ret == -EOPNOTSUPP)
>> -             return sysfs_emit(buf, "<unsupported>\n");
>> -
>> -     if (ret)
>> -             return ret;
>> -
>> -     return sysfs_emit(buf, "%llu\n", val);
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu,
>> +                                        cppc_get_auto_act_window, buf);
>>   }
>>
>> -static ssize_t store_energy_performance_preference_val(struct cpufreq_policy *policy,
>> -                                                    const char *buf, size_t count)
>> +static ssize_t store_auto_act_window(struct cpufreq_policy *policy,
>> +                                  const char *buf, size_t count)
>>   {
>> -     u64 val;
>> -     int ret;
>> -
>> -     ret = kstrtou64(buf, 0, &val);
>> -     if (ret)
>> -             return ret;
>> +     return cppc_cpufreq_sysfs_store_u64(policy->cpu,
>> +                                         cppc_set_auto_act_window,
>> +                                         buf, count);
>> +}
>>
>> -     ret = cppc_set_epp(policy->cpu, val);
>> -     if (ret)
>> -             return ret;
>> +static ssize_t
>> +show_energy_performance_preference_val(struct cpufreq_policy *policy, char *buf)
>> +{
>> +     return cppc_cpufreq_sysfs_show_u64(policy->cpu, cppc_get_epp_perf, buf);
>> +}
>>
>> -     return count;
>> +static ssize_t
>> +store_energy_performance_preference_val(struct cpufreq_policy *policy,
>> +                                     const char *buf, size_t count)
>> +{
>> +     return cppc_cpufreq_sysfs_store_u64(policy->cpu, cppc_set_epp,
>> +                                         buf, count);
>>   }
>>
>>   cpufreq_freq_attr_ro(freqdomain_cpus);

