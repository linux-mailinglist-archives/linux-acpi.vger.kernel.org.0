Return-Path: <linux-acpi+bounces-10801-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4429A1A86A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 18:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F0F188D28A
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Jan 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA886156228;
	Thu, 23 Jan 2025 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k4txEjxT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2FCD140E5F;
	Thu, 23 Jan 2025 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651936; cv=fail; b=hb7NhS1IHPmJbyyiC/M4OxmsRJI7RKuMuw0nxazHKzbP49Ipmvzk5iz+RM9ZhNfnlYMo1D9ftryGO7XVQoDdTPCmb0GsazUpv1u38kMw5W6yioWfJifIR8vlC14mJmuAXb6KPpWbWmk9ywIUnmGneG0JkqpYFs4lLOuDGfjzTtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651936; c=relaxed/simple;
	bh=9m7GuHJjQTuuWUcpRxIZIJ8hKakYCFofTXNNvpOcvq4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fs9DjZmFulMPfHepA7WBkvtsyUCCmwVTLqMoHZHgIK0kKSvcszswDS8wcjKD5BfmRaty2SARJ1YptaCF3igcp3kBc5slNXoFSZXg+Hd5dA6ufokgNuzbKl2uE0DP+uspagAGxmTY40WYi2pDoPRpzkiyR+LSv833z2au9S/630g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k4txEjxT; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMvVaqVM86d2ce26ykpqxaMJeJRHklEYJ7/l4GQVs/thPLnTfS9ADn/QB+WjUuolkIplUgUFyCqwCPgpbAWRRmo8mNoStiJf2hYOmSpaMxCc8OkFyIsGqbu2DUNbJl8zu2MwX59H8Ldy3vKu4Tf9+hLXCbzzQTR0d6+1ziFHlIGeGF3oX103JnyL4r0/lQF823doS66hryvagpGK3DR3Beq0ENvJxmq+Uy4pYMvfhNBXu41xug8Xy6KQLXuu5ooo9SzxgCJs33uXmgT8a504wL6xT8bcLzBeTGLmxgFhbCgPc2ocXqYwcc7e+cg0VQK/OTw3cTqSzKf3FshqSWIErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yihf8DsGYFw0xLjBGq6wqjOe8wJ0G3Mzh6rp28Auegc=;
 b=acoFblcvMjEZjWszdklV+7A4w1H18bH1v4WCUh667DnmQugyPwEEUXeGnqUYBv9qaTDtMZNGl4O6oPboHj/toc44L8nO+/bwLsvE63SgdrMKpsZGsGqFTIXYesGMWbkxaW90XIUKCxtsxySkVd86JvO30aTVcLZf+t0ZFzsWceIVoRezn53i9nmCgC8/CNC6c2MUWMejT4/zOY0T+COGko/2/ixl5nVEVjNMaSN2sAFyEtC3YBOA7QUQ3KueKciFxOrLJotcBNKDD3gqujwXKfdjeVZxzf+ybttHmhyKpLOqkbXFh1CYC7ctMr0C/oeBwrqPQcBjz9y77pAbKfmnww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yihf8DsGYFw0xLjBGq6wqjOe8wJ0G3Mzh6rp28Auegc=;
 b=k4txEjxTkD8HFEf92D8daTLLIMFDOduAFom7soG45tl1Ag/PqTuZUYR7QHZxxgUO0mT8ASpNb4GLQa+94MrmJpzqpXhzrG3fwCPDtfB18HAKFN2ISRzGcsensrdOt/dEI9Sih166XRLpRMmIUbTLABcufsQKakXf8m7LZGl+OE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.16; Thu, 23 Jan
 2025 17:05:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 17:05:32 +0000
Message-ID: <9f5f8181-7d0e-415d-b473-0e3c6601ccc3@amd.com>
Date: Thu, 23 Jan 2025 11:05:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] cpufreq: CPPC: Support for autonomous selection in
 cppc_cpufreq
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "zhenglifeng (A)" <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Russell Haley <yumpusamongus@gmail.com>, rafael@kernel.org, lenb@kernel.org,
 robert.moore@intel.com, viresh.kumar@linaro.org
Cc: acpica-devel@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com,
 jonathan.cameron@huawei.com, gautham.shenoy@amd.com, ray.huang@amd.com,
 zhanjie9@hisilicon.com, lihuisong@huawei.com, hepeng68@huawei.com,
 fanghao11@huawei.com
References: <20250113122104.3870673-1-zhenglifeng1@huawei.com>
 <20250113122104.3870673-7-zhenglifeng1@huawei.com>
 <21654032-a394-4da9-8ee9-d7cb9df8c855@gmail.com>
 <6909eef3-20aa-4341-9177-a42323a0d5c6@huawei.com>
 <270a1cce-8afe-497a-b30b-56157d75a863@amd.com>
 <0705775a-1040-4564-b97b-2ed397803723@huawei.com>
 <256a7620-2d21-4474-b64d-b1e8effbc975@arm.com>
 <32d084f3-f114-420e-affa-2f7ba107de0d@amd.com>
 <eadd291e-c797-4d7d-b1f9-f8778fa58b23@huawei.com>
 <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <6267261b-4e4a-475f-b17d-5473d72b2c2a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0018.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::26) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 193ff4e6-ff26-4e97-e1b8-08dd3bd0258d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVR2UHB1VCt1cE5pdTU1OG8zbGdJNDVacXVKeFk4L0FPaEpKMjNhbGVIVDgw?=
 =?utf-8?B?MmdRS2cwU0kzQjI2TEVNaG4wZ2ZXM0VEaFdSTHRyOE80R3IrbGJueXFLdUhK?=
 =?utf-8?B?RTR0SXBvNVNOSXhYdWM1ZXJkM2RYL0s1azlwYWxBZUxqRDFuamRBVDBiWGtW?=
 =?utf-8?B?eEpYM3gwUk5XNUFGNUFGTG1FVnF2Ri9MM3dCblRtUzFBT2orQzNpWmd3WjRD?=
 =?utf-8?B?dFhyakJjSGFmZU9UQTZEZ3pzMkppTE0wUUN4cWtIMlJGQlBOZzU5OVpCK05v?=
 =?utf-8?B?c2o5YzU5TkcyaVNCZXJucnVmcXJ2SjRBVnEzTmJlZTJFSm0wODhhSE5FRDdl?=
 =?utf-8?B?U1hJdU1lSEhwbW5OdDU0eGhKYUJFV3JEZW9ySUs2NGh2RVBBQ1pESHozSmx6?=
 =?utf-8?B?RldDczVwVTRtZWdONWdZaG0xTGpYOVhkVGlVN1Zidk4ya2FEL01ZL3FFcEkx?=
 =?utf-8?B?R1FzVlZ2aEpKWEhuYWVrVG0ydy80eWNXeUF1N0g2NDVtNlp0WmRPN1JlMHlu?=
 =?utf-8?B?ZTVVVEJHNE5jNnZ4UThzR1Nadm5hRDJPWDZ1OEdZcklzQ3lKWnAzczJNanVy?=
 =?utf-8?B?bkwyRC9WRmx6U1RkdVJnVGJIKzZKMmh0Qy9XcEpCelNJZHY2dTFUVTVpMUMz?=
 =?utf-8?B?QWVzR01oUnVzU2lYcjNUOVBLYnk0Z3R6d0IxN0NQRzZHQW9SQzVnM3ErRCtP?=
 =?utf-8?B?Z2pUdGpIekRPeU9VV2xuMmozN1FhQmxYN1hJSlZxV1AxMThJejRpek9CU3Nt?=
 =?utf-8?B?N1NTRUtDKytrL0dZQlFoTTNabXBiOW40U0FPRlhwR0JPSUFwa3NPN0pqKy9R?=
 =?utf-8?B?UkJaV0haeURRb2FUWkJ0bFJPRG1tczdZZi9YbkpFM0xUNldNMWRHRXlaTG1V?=
 =?utf-8?B?dFRlZXZudGY5S0VBN1pFR01lWEFkQkg3VnRhdUgreFozTmN5K1lVVlNvdEF4?=
 =?utf-8?B?bVdLeGFIRXVHZXVvRVczWGsxaVo3WjlQTm1neHFPaU9MTzlsWWd3VVcwWUd3?=
 =?utf-8?B?Z2Y3K0VzNGl5Tm1aeTMvVDd6Z2w4L3M5NmsrYk50b1N4cG1iVVhqcldqamgz?=
 =?utf-8?B?anpwSDJ4eVRIWHJETE5sRDFEV3lFeHhORDQ5bG0yZXNnYVk1cmQ5bE9DSUZw?=
 =?utf-8?B?WGN5bXFteTlLcm5aZC9Zb0xjcHJScnFmeU14VEZUNEN2M1phcHR0T0dDYlFD?=
 =?utf-8?B?Y2FjSmdtRzhMekNxYzlQejI1b3VtS3hGWUZKWFVtZXFETGhoRzBlSmhzQ2Zz?=
 =?utf-8?B?ek83aHY5V2xNM3hWR1JHRFpjNGJYS0p4bXBOY1FlaE96OG1HTml3K1J4QnBW?=
 =?utf-8?B?NVlpc3dXeEMxSnFjQkVUMEg5d1JuY3FCV01WQ1ZjelJiSFBZYzBmcjNDSytz?=
 =?utf-8?B?VXdiWGVReGRwTGxlMGg2VWZKbDc3Z2lKaFcwMlZIc3RQcTZFbU5kZytxRCs1?=
 =?utf-8?B?cFRUSHFuaWozaFBOMWR0RzU1Y2dDUE5DS1R5WFV2SVBDYmZUVW9wcHpPVUU3?=
 =?utf-8?B?d2ZDdno2a1UwZFZTTm9rYk9TaHdBVG5YK3F1TW45UFU4UUdNMVVDVkRlRHdR?=
 =?utf-8?B?Ky9SN3owdTI1eFF1RnZoNlVKSjB6OTlGd0dGS3ZXcEx3VXVVbktCOGpGUFE1?=
 =?utf-8?B?R0VOU3lyOEdKbWVQdXJ3KzJXSFgwelBUSDMydWs0OVdSb2NUYmNpMlEzVkhV?=
 =?utf-8?B?WW55RCtWUFFHbmlZelhtc2xlUmgxMXRqNy9WcUdxSUdYN09xRnNyTEtuNkFa?=
 =?utf-8?B?YnBHMzl5Q2JsaHViRVBlSzE2b1NqejN1WEkreWdEanBDTVQ4WGExVCtNY2pj?=
 =?utf-8?B?QnFIelR1cDZvQXFVVnZxUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmp0a25KZE0zeWlPQTNwWU9vUTFFRkdTRGpXNnFkM05YVHp5V1RwRkZMLzdx?=
 =?utf-8?B?aEs4U2FWYlhaOWt4K2hzMkgzaU9OYVVERnl3a2UrU2JhQ1g4V1dqcFd4WFJx?=
 =?utf-8?B?RklXR0oyZzBHcHJJYVNKTUhaL005K29WWW9LNzdDVkgyRXNuOG9NK1ZHblBo?=
 =?utf-8?B?V01CK1ZXMVNVdzFmSkZJd0RHNTV6MlpHV2IxNG1tempaM2lmakk1T2hrbTBy?=
 =?utf-8?B?ZmdHYVR2bVFkdER1THViZisrS1VVT256R1d6QlUreXl6VGgyT0FsN0ZhaGc1?=
 =?utf-8?B?U3ZleDVsZDFIbzdJaC91STdqOEVsQllUUG93dkQ1dHlQdXJpNml4T1B3K2tM?=
 =?utf-8?B?aHkvZ25sdExCYUhvU3d6UVM3STdhS3FFUVlaSzB3YVNNZll5SmpwdnRGNm5N?=
 =?utf-8?B?bk5PbXpFaWVkcE1oNzlTZWJrVmVQTHliUHNFaSsrK0NyUUpDaVZFOXBFc2tk?=
 =?utf-8?B?VTg2UVp2ZXJyUjlueFNEK085YkJ5bS90R1JveUVwc1NsZ1hUcHgyTVB1MWNF?=
 =?utf-8?B?NUYrL2lsV1pCQnZsMytlYVNtNHN4dlBNeEg3MU5FdktNeTdNbDd6Y0QzeEh2?=
 =?utf-8?B?WUpNRTFZM0tvUUlqdXB3K1A3RTFYU0hFaTdFL1lrMDhaRmZmQlpKMTh0NnhL?=
 =?utf-8?B?ZVVwOEdaTy9lR2pMVjcxRXd6clZNQjJka1F6SW1CNEE1K3l2a0lvWkhEOXk4?=
 =?utf-8?B?YVNRY2JLK3F3b0FQTlNldjJVOTZrdmdDbXlIajUwNm84bHphR3lRL1FrTmti?=
 =?utf-8?B?WWhMZC9nNmdWT2VOREtXVjhVdVM4dDZQY3JlNmxvcWVxMGRnY1VnVEFRc3pT?=
 =?utf-8?B?WGQwVjRYR1Bkc1p6dlczRXdCblREemsxUkRxeVNBcHE5V08rODg4ZldyR1lS?=
 =?utf-8?B?TmJEWE1JOFFHWENGNU1SYjJwOFk5YTEyT2ordDE1STMvbUlBL3NIenlEcmpC?=
 =?utf-8?B?eS9aNi9oeU1lVGc4ZnhWYXJMU1Z1WnkxU2lnYWtCeFJnNVRrRUFqZ3d6bTVS?=
 =?utf-8?B?VXpBZkVOZm1odkF5dFRlaHFyNDRmSTZGcHBDbTdIVmRSSmJLbnB2MFlObzJI?=
 =?utf-8?B?cFlOcmNtUmtCM2oyVkxZZ292ZU9aZ2pxc3NhQWZuZThqU2NGSXZLWXlIdjZi?=
 =?utf-8?B?YzN5YmRjT0JXdEw3VG9Jc0IyeXNIMTBZRis4K2ltOHgvUGRDQ2ZCUzdCQ2lh?=
 =?utf-8?B?cGMzMnJEc1FDdGlGQ29EMTMwY1pGcVVJNG1TUE96M0xtWEhSMTJ3RXVLczRG?=
 =?utf-8?B?UU13TTVhN2dnNlVFUDNpYjdyeStWS1cvQkJjSmxIaE8wTTJjcGtpZ2lCOVJO?=
 =?utf-8?B?eDd3aU1HZ3NERTJzQk05S1g4c284ZWM1endKcDRVeXBXT0JrSU50ZENjY2Nm?=
 =?utf-8?B?aStGQ0Z3cjR5TGlZRkd5V0JmSlNFNXBOQ3c5MXBSSHJheDluOTUxSjJPemk1?=
 =?utf-8?B?aURmNElUUmJJRWdSR2ZORFhtZGJlSlh5SllabTJsWGlPL3JDdFAyWEdIZ0h2?=
 =?utf-8?B?QjIrYlRjSFY0RWcxQkFnQjdQNVhtUkdSQmtmS0hhaUpCUmh2am5ONE03TG96?=
 =?utf-8?B?OWJCUjF1Q0tPbXpmdEplWlFYb0ZjSk5mWDF2aTJjVWlZRmNtdTFrb3hiUXZG?=
 =?utf-8?B?QUZGVzVYcTk0ZHdINi9OMTlsZEpuTThSdGxYMzJDUlFtZDhaWDlBK3pZdnFC?=
 =?utf-8?B?eUpOcFRyNzdJbVlkS3JrVWdJZHFLU3BGa0Z6M0loZXUydTdsR2VKUGtLb3lQ?=
 =?utf-8?B?T0IrcFVrNGtnZTd6V0c3Qml6WGVvM0Y1T0s4K0gwMStlaTltUXdRdHNrV2dQ?=
 =?utf-8?B?czhVS3l0VktXcEZlbU1vYlZjQXRzcU5LMnpiL3BRRXlHbi9RazNQRmc2WFZR?=
 =?utf-8?B?MkdDRVdGQ0VOeVZUcDFBT0xHZTZCK1N3UEZKVTdaempWWGVwbUhaU2c5V3RL?=
 =?utf-8?B?andnekNEb2gzaEJPektuZjJpbzBqc2xNSWFTK21zK3dVdVdjNEt2QjQrVG5w?=
 =?utf-8?B?TDdZYnRmY0lqc2l1WVg0aE5zZkRGSVIxMzZLU0o0a01ad2pRRS95VWJVb0tV?=
 =?utf-8?B?NjBVV2RnUWZWaFFVdWpkK2JJcFF0RTdyWUg4cWJLbUtVY3dWR2psWnphL0Nn?=
 =?utf-8?Q?ZCleFReZ9WSg5F+C9pMiBeO90?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193ff4e6-ff26-4e97-e1b8-08dd3bd0258d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 17:05:32.7531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5irAAx5VDqxWSWssukJKfPM+NXPkZLz5GjTSqfJG1vP3qhpKNUUbuFEn6Hr1sP2IZ1WxzYy9Zhk7fsi3762kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

On 1/23/2025 10:46, Srinivas Pandruvada wrote:
> 
> On 1/20/25 18:42, zhenglifeng (A) wrote:
>> On 2025/1/21 1:44, Mario Limonciello wrote:
>>
>>> On 1/20/2025 08:49, Pierre Gondois wrote:
>>>>
>>>> On 1/20/25 04:15, zhenglifeng (A) wrote:
>>>>> On 2025/1/17 22:30, Mario Limonciello wrote:
>>>>>
>>>>>> On 1/16/2025 21:11, zhenglifeng (A) wrote:
>>>>>>> On 2025/1/16 19:39, Russell Haley wrote:
>>>>>>>
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> I noticed something here just as a user casually browsing the 
>>>>>>>> mailing list.
>>>>>>>>
>>>>>>>> On 1/13/25 6:21 AM, Lifeng Zheng wrote:
>>>>>>>>> Add sysfs interfaces for CPPC autonomous selection in the 
>>>>>>>>> cppc_cpufreq
>>>>>>>>> driver.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Lifeng Zheng <zhenglifeng1@huawei.com>
>>>>>>>>> ---
>>>>>>>>>     .../ABI/testing/sysfs-devices-system-cpu      |  54 +++++++++
>>>>>>>>>     drivers/cpufreq/cppc_cpufreq.c                | 109 +++++++ 
>>>>>>>>> ++++ +++++++
>>>>>>>>>     2 files changed, 163 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu 
>>>>>>>>> b/ Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> index 206079d3bd5b..3d87c3bb3fe2 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
>>>>>>>>> @@ -268,6 +268,60 @@ Description:    Discover CPUs in the same 
>>>>>>>>> CPU frequency coordination domain
>>>>>>>>>             This file is only present if the acpi-cpufreq or 
>>>>>>>>> the cppc-cpufreq
>>>>>>>>>             drivers are in use.
>>>>>>>> [...snip...]
>>>>>>>>
>>>>>>>>> +What:        /sys/devices/system/cpu/cpuX/cpufreq/energy_perf
>>>>>>>>> +Date:        October 2024
>>>>>>>>> +Contact:    linux-pm@vger.kernel.org
>>>>>>>>> +Description:    Energy performance preference
>>>>>>>>> +
>>>>>>>>> +        Read/write an 8-bit integer from/to this file. This file
>>>>>>>>> +        represents a range of values from 0 (performance 
>>>>>>>>> preference) to
>>>>>>>>> +        0xFF (energy efficiency preference) that influences 
>>>>>>>>> the rate of
>>>>>>>>> +        performance increase/decrease and the result of the 
>>>>>>>>> hardware's
>>>>>>>>> +        energy efficiency and performance optimization policies.
>>>>>>>>> +
>>>>>>>>> +        Writing to this file only has meaning when Autonomous 
>>>>>>>>> Selection is
>>>>>>>>> +        enabled.
>>>>>>>>> +
>>>>>>>>> +        This file only presents if the cppc-cpufreq driver is 
>>>>>>>>> in use.
>>>>>>>> In intel_pstate driver, there is file with near-identical 
>>>>>>>> semantics:
>>>>>>>>
>>>>>>>> /sys/devices/system/cpu/cpuX/cpufreq/energy_performance_preference
>>>>>>>>
>>>>>>>> It also accepts a few string arguments and converts them to 
>>>>>>>> integers.
>>>>>>>>
>>>>>>>> Perhaps the same name should be used, and the semantics made 
>>>>>>>> exactly
>>>>>>>> identical, and then it could be documented as present for either
>>>>>>>> cppc_cpufreq OR intel_pstate?
>>>>>>>>
>>>>>>>> I think would be more elegant if userspace tooling could Just 
>>>>>>>> Work with
>>>>>>>> either driver.
>>>>>>>>
>>>>>>>> One might object that the frequency selection behavior that 
>>>>>>>> results from
>>>>>>>> any particular value of the register itself might be different, 
>>>>>>>> but they
>>>>>>>> are *already* different between Intel's P and E-cores in the 
>>>>>>>> same CPU
>>>>>>>> package. (Ugh.)
>>>>>>> Yes, I should use the same name. Thanks.
>>>>>>>
>>>>>>> As for accepting string arguments and converting them to 
>>>>>>> integers, I don't
>>>>>>> think it is necessary. It'll be a litte confused if someone 
>>>>>>> writes a raw
>>>>>>> value and reads a string I think. I prefer to let users freely 
>>>>>>> set this
>>>>>>> value.
>>>>>>>
>>>>>>> In addition, there are many differences between the 
>>>>>>> implementations of
>>>>>>> energy_performance_preference in intel_pstate and cppc_cpufreq (and
>>>>>>> amd-pstate...). It is really difficult to explain all this 
>>>>>>> differences in
>>>>>>> this document. So I'll leave it to be documented as present for
>>>>>>> cppc_cpufreq only.
>>>>>> At least the interface to userspace I think we should do the best 
>>>>>> we can to be the same between all the drivers if possible.
>>>>>>
>>>>>> For example; I've got a patch that I may bring up in a future 
>>>>>> kernel cycle that adds raw integer writes to amd-pstates 
>>>>>> energy_performance_profile to behave the same way intel-pstate does.
>>>>> I agree that it's better to keep this interface consistent across 
>>>>> different
>>>>> drivers. But in my opinion, the implementation of intel_pstate
>>>>> energy_performance_preference is not really nice. Someone may write 
>>>>> a raw
>>>>> value but read a string, or read strings for some values and read raw
>>>>> values for some other values. It is inconsistent. It may be better 
>>>>> to use
>>>>> some other implementation, such as seperating the operations of r/w 
>>>>> strings
>>>>> and raw values into two files.
>>>> I agree it would be better to be sure of the type to expect when 
>>>> reading the
>>>> energy_performance_preference file. The epp values in the range 
>>>> 0-255 with 0
>>>> being the performance value for all interfaces.
>>>>
>>>> In the current epp strings, it seems there is a big gap between the 
>>>> PERFORMANCE
>>>> and the BALANCE_PERFORMANCE strings. Maybe it would be good to 
>>>> complete it:
>>>> EPP_PERFORMANCE        0x00
>>>> EPP_BALANCE_PERFORMANCE    0x40      // state value changed
>>>> EPP_BALANCE        0x80      // new state
>>>> EPP_BALANCE_POWERSAVE    0xC0
>>>> EPP_POWERSAVE        0xFF
>>>>
>>>> NIT: The mapping seems to be slightly different for intel_pstate and 
>>>> amd-pstate
>>>> currently:
>>>> drivers/cpufreq/amd-pstate.c
>>>> #define AMD_CPPC_EPP_PERFORMANCE        0x00
>>>> #define AMD_CPPC_EPP_BALANCE_PERFORMANCE    0x80
>>>> #define AMD_CPPC_EPP_BALANCE_POWERSAVE        0xBF
>>>> #define AMD_CPPC_EPP_POWERSAVE            0xFF
>>>>
>>>> arch/x86/include/asm/msr-index.h
>>>> #define HWP_EPP_PERFORMANCE        0x00
>>>> #define HWP_EPP_BALANCE_PERFORMANCE    0x80
>>>> #define HWP_EPP_BALANCE_POWERSAVE    0xC0   <------ Different from 
>>>> AMD_CPPC_EPP_BALANCE_POWERSAVE
>>>> #define HWP_EPP_POWERSAVE        0xFF
>>>>
>>>>> I think it's better to consult Rafael and Viresh about how this should
>>>>> evolve.
>>>> Yes indeed
>>> Maybe it's best to discuss what the goal of raw EPP number writes is 
>>> to decide what to do with it.
>>>
>>> IE in intel-pstate is it for userspace to be able to actually utilize 
>>> something besides the strings all the time?  Or is it just for 
>>> debugging to find better values for strings in the future?
>>>
>>> If the former maybe we're better off splitting to 
>>> 'energy_performance_preference' and 'energy_performance_preference_int'.
>>>
>>> If the latter maybe we're better off putting the integer writes and 
>>> reads into debugfs instead and making 'energy_performance_preference' 
>>> return -EINVAL while a non-predefined value is in use.
> 
> In Intel case EPP values can be different based on processor. In some 
> case they they end up sharing the same CPU model. So strings are not 
> suitable for all cases. Also there is different preference of EPP 
> between Chrome systems and non chrome distro. For example Chrome has 
> some resource manager which can change and same on Intel distros with LPMD.
> 

Thanks for confirming it is intentional and changing it would break 
existing userspace.

And FWIW even in Windows there are more than 4 situational values used 
like we have in Linux today.

As the status quo is there I personally feel that we should do the exact 
same for other implementation of energy_performance_preference.

> 
> Thanks,
> 
> Srinivas
> 
> 
>> I think it's the former.
>>
>> I added the author of the patch that allows raw energy performance
>> preference value in intel_pstate to ask about what the goal is and if 
>> this
>> would be ok to do the modification mentioned above.
>>
>> To see the patch from https://lore.kernel.org/ 
>> all/20200626183401.1495090-3-srinivas.pandruvada@linux.intel.com/
>>
>> Anyway, the purpose of this patch is to allow users write and read raw 
>> EPP
>> number. So maybe I can just rename the file to
>> 'energy_performance_preference_int'?
>>


