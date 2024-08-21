Return-Path: <linux-acpi+bounces-7754-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BAD95943C
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 07:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EDA1C210F6
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Aug 2024 05:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6681547D4;
	Wed, 21 Aug 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h0Iaey2W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A314085D;
	Wed, 21 Aug 2024 05:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724219289; cv=fail; b=HkA0dl+v0Xk+EaxeX7JzXbVZ4oOcAAzhB/c+kksmFe+k1XjvzezHazHTKaXCM+t/c9heebNxrWnpnrM05j5Ly4Hz34TSCwP8IVrMVW9i7RgKVn6IOVY/B4VKEQ94LURmjR6gjrBK/3JloKlms3DsDH2+pqgFdhk+gTQ9kSo+OVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724219289; c=relaxed/simple;
	bh=50RovwJKBmmP5AzsucfdEAsjCpstDDBh+h/P/iqI90c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmPKOdZ/krp7DDQNbWPbPM4AQh/auyKbIyWSYiD+aCKJILMqyr6fjS3cOYMQw4aVK1oM6sj/jUYbHWOFQgxR43nrvshLf+IsWG6+AimOD00DSxzjgJnb3mWj5DBfKF3tacVMx2J9RpHv9JfA9ktFasAWRT3gtFa8raeHhJ71XU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h0Iaey2W; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7UBTj4OaT9XygQ8LjFRT2c+9Sren3pFYQcBMWYlnsOBeB+F+00yLDso1/hzXrISgCgDj2CXjigoRgTwO57XRqsPhs5Hvo4ThiDUToFw8/I36WNE8dZHQYnpCCoQWrpJCRez/QGPqx4uXackMb1IeN5PLvJBTIVT33m2lQ+n/zeabywRzJNMMk5IqZeE9h/tsphwNo6L4llo1zKouKIs91PsXTXkhySGED4+cXV5Z1a3jOkyiI4rHkAybV5YhclFjx1VmHMjR3Mg66/0kOM/t/zBNQzQlEQ0AXaVjuVnkdx26pfid6zdPf+FiaBqmbbKEs8SoEtZuyquYDcQkT0+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ny6feXJhzjsDn6nbjFvAuQQUwpjeT5PgrAVFHCh9jsY=;
 b=bEbXxvMATyPecMyz8rEh10KRBbxPk5ptFxghGqfwgCO8rYZhIBWiAyuTo2XiU9vgTg9awextgtJLAzw0NqOvONsPJQlwjKQP5ttH3o2VUnba/OlWm7e2KonuTsOfU8P2fRjtnuVoedaFLx80MSzA7swAT0PSkzLRnTrnkuVTl8lHY85eqja93FNjMFx2xX800j8V1fVmFPm/OnseBMfJCI1i3RfAQ2WZ5OIwgzTq6r8p6wwTVjwPxB9QyYvXgla7QkDkX6EuMQYWkXsGmHnwuULFTZUV5s2k2LGdPkKEzL1jpOtTFsqnJWingE45YTJaA4PPECtzm7te1U7WotrpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ny6feXJhzjsDn6nbjFvAuQQUwpjeT5PgrAVFHCh9jsY=;
 b=h0Iaey2WmfLoT1cC1qU4owsQ2cliymS+AF9O3hVU8wuLIaLWPtYvZpzSARIptZv1dPqbBNiwLVQOKnlyEXWfg6e06bXeXF7TpwcoBptOZQ47pdeI7VRbNXI7AcvFr/GVgG1QEsPut0u9ftao0/gGHiIxwbMnrPfZL/1VZ3zYQIh4Kozav30eBhSv+WHeLKxcV3wskT7+RU6pqvXCaiGPu9mGzl2T89j1qh0UhDKdR1oy7ABmuUwmaXXVh46m5G86JGcWRB/1lIiHkWSdI3heyF6L1vqfLHm1bwU3rB4BeT71DsbQFaXJO0xx1WrDGA9L95UjzMYleWNAdMHwTdX5hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY8PR12MB8297.namprd12.prod.outlook.com (2603:10b6:930:79::18)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 05:48:04 +0000
Received: from CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4]) by CY8PR12MB8297.namprd12.prod.outlook.com
 ([fe80::b313:73f4:6e6b:74a4%5]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 05:48:04 +0000
Message-ID: <f6e581e1-2d24-4587-a193-bfeaf1a3cb1a@nvidia.com>
Date: Wed, 21 Aug 2024 13:48:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] acpi/prmt: find block with specific type
To: "Zhang, Rui" <rui.zhang@intel.com>, "mochs@nvidia.com"
 <mochs@nvidia.com>, "james.morse@arm.com" <james.morse@arm.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "erik.kaneda@intel.com" <erik.kaneda@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20240801014853.1594699-1-kobak@nvidia.com>
 <6cce5245bb569f30d73ac8ec1d217d70a11925e3.camel@intel.com>
 <678e2e3b-4c45-4c10-8af0-32e17c7b3bd4@nvidia.com>
 <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
Content-Language: en-US
From: Koba Ko <kobak@nvidia.com>
In-Reply-To: <a8aceb6abe91bd339ef4d90a84131701f8e8abbf.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0059.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::36) To CY8PR12MB8297.namprd12.prod.outlook.com
 (2603:10b6:930:79::18)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR12MB8297:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: 68f5a4a9-fec2-4f05-bda0-08dcc1a4d34c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak1VMnBTUVpOY01PdFFDQnU1NUs1R0Z6WXdqd0M4Y3lvWHJGWE1tQUNMZW5D?=
 =?utf-8?B?L3VRUHVUeHMraG1yU2ErbFR2T09TWTIxdkFnWmU3Y1M2QlF4NTdhMlJZdGZM?=
 =?utf-8?B?ZTI3ZkQrMVhqZVRoemUvWEhRdUVRalZ3MWtJSEZyNWVxbGJFWUM0dlZ4em9S?=
 =?utf-8?B?SUVwS2J1dVhyclkwN1gvWXBqWGRGM2NMQjg3UVcvRmtYZG1GNzNodENmeUpE?=
 =?utf-8?B?Wnl5UVExYjFQRFlRN1g1ZForNW1tdXU2MlErQkkzUHppV1hGdGVESlE2dWpq?=
 =?utf-8?B?N0xodkRyOUJmc0xacEU2MHlFSWtCR2ZadnIzK3lwbGNLZjl2NTRNTytEVWVv?=
 =?utf-8?B?Unc2QmpIb0dUVGpEZDRSQjNGQmxXdkpzV3hjRjBadkpLL3lBVzVEMTB1Sm1p?=
 =?utf-8?B?ZHNKNEg0eDhvdzVIaTk5dVFNOHBVVXJCV1VZNEpyWG5oV1cyakNIamliWGhq?=
 =?utf-8?B?NmJBeEVaaWFHNDJoQkxZOHRlUWNxcWNpSWlmbFgyby9rdUsxYlY2YVVVUjJ1?=
 =?utf-8?B?ek5OWnExVnJOMnRtK1JGR1Q3Vk1xeXZ5aWhRZ0RHdzVyT0FJczBSZzZyOXNH?=
 =?utf-8?B?MVd6RENvdHc4dk82WU5zTUlBRkJFZUlUUWYrMFhnbG1Hbm1tQnFhTGsySU9T?=
 =?utf-8?B?WUJhWmsxTXM4djhEVmQ3TmZza0VSNWtVRFgzRkF1MkhOVkppVm1vOXRqTkFi?=
 =?utf-8?B?TWg5VUdteGxaOVhIUzArN1VKOVo0bVpRTGZaRVo5M1JLMEsrNHhyREJLSzFy?=
 =?utf-8?B?SmFvNkpIV3V3enBObHp1VzhnL0hEb0I2N3VrbU1lMjgrVm9hd0N4cXNPd29S?=
 =?utf-8?B?djZzb01DK2FNV0JwdnhpQm9lcGtRVm9wbUhXMGRqRmlVTjhPd3lKNndrcG1s?=
 =?utf-8?B?YzlYZ2dsbXdYYXlTSUxrYlN0Tk1aMDFuYjFDVGttOFIvMzFobFhNQ0ZZS2lU?=
 =?utf-8?B?b2swV3llVUtyMnhsNkhuZDZxNFpZdEJUTUF2RENTWDk2TVpIWjFHSVN0OEpU?=
 =?utf-8?B?eldNdnhHVUswbUhISTdEMUxvSlhuM3lMRTJvRnNhMVgrWjkzU1pSS1BvS3Z3?=
 =?utf-8?B?V3NzakcrVC9ZbFA2UGRXaU1iYmplQ2pwdlU0aFlBekluUEE4N3pVcDNucnhV?=
 =?utf-8?B?NVRtVWtjbThaS3Ftc0JOcmdGd0wzMlNvWWl2OG9PcXd4bmxZamFLN0o0QzJk?=
 =?utf-8?B?L0lLMzlnbmlPUDhUYVdwNFZvNU5TK2tRSUp1am1ReWZOOGVVb1QvUGxGc1V6?=
 =?utf-8?B?eUhlWk40Y1JzNnNucXo3N3ZIOXM5OFVkWkJJdnh6Y3A5eXhibmNRYmJHOU9i?=
 =?utf-8?B?Z0RXR3Z4d3JGNGc5UWh4cG85NHJwYnQ5Vk5GMm5mV1IvOVdzQm9vbmdBNC8x?=
 =?utf-8?B?eFR4RmlNY1FnUitlWkl6MUNXTGFVRGxWQTI0d0FYYXZuMTFER0ZieU1YZmk2?=
 =?utf-8?B?cGtCay81Vk0vZk8xWFN5M0pNYkh4WC9YbTNqbHhYcVR3UkxDWGhWMHR2bXFi?=
 =?utf-8?B?eG90NkpOcnNnMkVldkNMdWM2N1J0Z2dPSC9aL01mSnB2M0tReDBUanI2S25W?=
 =?utf-8?B?Q29qYTZzQ3lMNWNTbTVNYmZUcFVLbko1VzIwWEZISGNtT3pTTkt0dU0vcjJP?=
 =?utf-8?B?andFZTMvMHVHZHcwdHVvMlhKa1E1ZENPS2dmdWRoWVVsSC9EQXdRQjFsUjdk?=
 =?utf-8?B?MldtNEt2TE5Kc3ZFZXVHMUw1ci9HQWJNRFlUN0hDZWJRak1TZlJuVHdTdkhE?=
 =?utf-8?B?Wm4wVHRqQ0NuSkxKeVJ3UE9ualRybVQzcHBvYmZmdFAxZWF1V2EyQVRHbGJp?=
 =?utf-8?Q?XebDT8oTJsAifLQJg8Yr+LnDcquuEMxEtm4bc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB8297.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9JcGo5bVBXWk50cEhRd1VhZktWWG1hK1kvNHk0elJVU1pMbUdkSG0yQUov?=
 =?utf-8?B?SzVHUGN0VkJxdEx4aEVhbXdqREJQRGZqY1F2VGpNZVRQZlJCalVibXlXcXoy?=
 =?utf-8?B?SVdhMXBUSFJXR3Z5cVg1UkpCRytuMVh3R0x4dWRUVndRZmgzZDZUR0FBQ3l0?=
 =?utf-8?B?YXFVbW8vZWJ1cG9wU1NOazRsa2R4TEJSelZObEYvV3ZGaUpJZ0dHYm1nUHA3?=
 =?utf-8?B?a08wWlVYNFdHRUt3N1FQVlZ6N2s0SEZweDNyS1dCZSsxUVhHYlFLSE54ZExZ?=
 =?utf-8?B?TktVak1wRlBtbmJLUzdJS2wrN0FxeTdsSXVaL2JiZy8yY3VqdGVaeWp0aFBL?=
 =?utf-8?B?V3h1Q1VLbGI1aDM3ejVzbHZnMGx4ZHBWVS9HRDdndVg0RHR0SlA1cHFlekdu?=
 =?utf-8?B?cGdlVzVJMHk2YUV4Z3Q1b21mQjhDZ2c0R1N6dWxPSVBWK0ROeFNPT3F3WGNS?=
 =?utf-8?B?bk1zMDNrMXBPakQxd0tUQkVwbEVwRDdGTVhZdC9UTUo5ZXBQMGRtUENDK2pI?=
 =?utf-8?B?UktCZ0NiRERFWXRISURuN0tlMjJOWFc3RGY2ODdlMkROZ0tiK2REdnoyRHh4?=
 =?utf-8?B?d2F2WHE2WEdKWDRlZlV5VHo5KytjdFZLdnh2MU9aaVlvTXFjUWlaM2NDa1FQ?=
 =?utf-8?B?NWc3L09qVWl2QlduY243OFduQkYyS1Z3Z256TDZyZTcxejZLcUk5N2RIeGx6?=
 =?utf-8?B?SHNiak1oeWZsVCs2ZXZ0YjdSRDRNVHBWOVdmanp0VXJsRDJPemc5K3RiR3h4?=
 =?utf-8?B?ZXJ3MUNKQURuWDhvYmo1aEM4czJvOWNPR3dJY2RJaG96dHZybGpYVXRpbUVw?=
 =?utf-8?B?UGs2MkpxeFJYWmVSWHZIelNOc2JRSlg1RlRDTTJiMlkyNlE1L2ZYSXNLVlI3?=
 =?utf-8?B?eXE5SWpyNlhaQ1B1TFJqM2FCV0xwTzV6VDRmUXNBRVRBblNmWTJuUE5zaGJx?=
 =?utf-8?B?c2svcXpwWHllM2lubjJqQTFZS01VdmUxaUtTMXJrdFlmV003bzlubGZDdnY5?=
 =?utf-8?B?d3BzZldYbXluaGdNZGxRZjFMYmdIK0o2NDd2WFRkQ1c4L0d2Ri9STUZFaXpM?=
 =?utf-8?B?TEVlS3hUTlA3WDBJVldrcFRTTC9kY0xZc25XdXRWVVozSnNUY2xzb3ZLei9q?=
 =?utf-8?B?ZE8vZ0NwcVFIcnJDNTFDQzdOK1hwM01XTEVZQ1lpcGkyMlorRDdsRVJvQUxp?=
 =?utf-8?B?WVFlVExlQm5GVituM012S0QxVWhiemhUZGNyNTN4cUNjRmVvZHZXaXpXRi9U?=
 =?utf-8?B?TmY0OUpYN2p2WHJYMmhadGRrSjRNK0ZWblhzQWV0cUczcHVYN2kzUVFINXMr?=
 =?utf-8?B?MHk5cW9mVVliUXVzUVgxa0tYS1I1WUdsWWVxZUhudzFVcXlwL0NVQi9lY1c4?=
 =?utf-8?B?ZVNRVzZ5U0FNdkJtbGJMOE9idGFLaEJCblRib2p4NlBmcUpEQkEzdW5ScWE1?=
 =?utf-8?B?UTJiVHA4VGhhUGZNMEg2eGVQeW13cEZDVGUwd1hHcnFaZy9jRkcyc2FvK2Q0?=
 =?utf-8?B?UWt4RTB3eHhENlVvNG83VENndEdvMWdpUVUzbTFGZjNqejVLbnJLWEtpMFQ2?=
 =?utf-8?B?TVp1STRQbWRDNjh4dWR1a0RDa0p6aW9SeTlXU0JjUmVVZ1R0YWlBOFcxeTRX?=
 =?utf-8?B?MERURkFUNnZWd1h1aUtoWm4xcGFwUkkweURob2ZVcXVhOHoxUVU3Rzc0bXUy?=
 =?utf-8?B?aWVJaHJ6QXAvTEZXK2NsdVZnTHlqd0ZXVHg2akxGaU9YM216VSt3Q3BIZ2xO?=
 =?utf-8?B?UmJ1VHVSckxoRDVHU21sK2FJdWRGUE53UlArMEF6L3hUSE1QdGV6aVlWM0RK?=
 =?utf-8?B?M01aZ1RLMmZxWVVtVlg3dEt4Vy82K3lua3FNSUkxQVdOcDR6c1VQRmNXV29i?=
 =?utf-8?B?bFhTZkFGSm1Semo2VGpodk9DZEhZT1M1ZFFQRWpvU09WUHlrUkVkVzhxd3VU?=
 =?utf-8?B?ZzB5MkdrTE9FeFFCNkdwb2xBckowR2RuckVvc1FydE5sQ3FMVDRCNjA3UXlr?=
 =?utf-8?B?eU5jMFhZVy9odnNNYXY3OTRRQUJnMFozcCtiQzNUa0o3VTFRSy9hQ2dOYzgv?=
 =?utf-8?B?TzhDRXdURGVQZ21NS0ZSRTJnbEliRm1Fa1UrSGZndENBNVphSTdIQS9oU1k3?=
 =?utf-8?Q?WbQlr9oar1zc68+aHIsbnF8mr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f5a4a9-fec2-4f05-bda0-08dcc1a4d34c
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB8297.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 05:48:04.4892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4A0hJaDTD+FZjaai5PPaiG2/BkI/4hqBKEKl5rM9o3dWOQiElWQVQPSx7D3Lh8fj812N1SpJsFvXXfCCzCaEGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609


On 8/21/24 12:55, Zhang, Rui wrote:
> External email: Use caution opening links or attachments
>
>
> On Wed, 2024-08-21 at 12:01 +0800, Koba Ko wrote:
>> On 8/21/24 11:20, Zhang, Rui wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Thu, 2024-08-01 at 09:48 +0800, KobaK wrote:
>>>> PRMT needs to find the correct type of block to
>>>> translate the PA-VA mapping for EFI runtime services.
>>>>
>>>> The issue arises because the PRMT is finding a block of type
>>>> EFI_CONVENTIONAL_MEMORY,
>>>> which is not appropriate for runtime services as described in
>>>> Section
>>>> 2.2.2 (Runtime
>>>> Services) of the UEFI Specification [1]. Since the PRM handler is
>>>> a
>>>> type of runtime
>>>> service, this causes an exception when the PRM handler is called.
>>>>
>>> Too many characters in one line.
>>> https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format
>> will fix this in the description.
>>>
>>>>       [Firmware Bug]: Unable to handle paging request in EFI
>>>> runtime
>>>> service
>>>>       WARNING: CPU: 22 PID: 4330 at drivers/firmware/efi/runtime-
>>>> wrappers.c:341 __efi_queue_work+0x11c/0x170
>>>>       Call trace:
>>>>         __efi_queue_work+0x11c/0x170
>>>>         efi_call_acpi_prm_handler+0x68/0xd0
>>>>         acpi_platformrt_space_handler+0x198/0x258
>>>>         acpi_ev_address_space_dispatch+0x144/0x388
>>>>         acpi_ex_access_region+0x9c/0x118
>>>>         acpi_ex_write_serial_bus+0xc4/0x218
>>>>         acpi_ex_write_data_to_field+0x168/0x218
>>>>         acpi_ex_store_object_to_node+0x1a8/0x258
>>>>         acpi_ex_store+0xec/0x330
>>>>         acpi_ex_opcode_1A_1T_1R+0x15c/0x618
>>>>         acpi_ds_exec_end_op+0x274/0x548
>>>>         acpi_ps_parse_loop+0x10c/0x6b8
>>>>         acpi_ps_parse_aml+0x140/0x3b0
>>>>         acpi_ps_execute_method+0x12c/0x2a0
>>>>         acpi_ns_evaluate+0x210/0x310
>>>>         acpi_evaluate_object+0x178/0x358
>>>>         acpi_proc_write+0x1a8/0x8a0 [acpi_call]
>>>>         proc_reg_write+0xcc/0x150
>>>>         vfs_write+0xd8/0x380
>>>>         ksys_write+0x70/0x120
>>>>         __arm64_sys_write+0x24/0x48
>>>>         invoke_syscall.constprop.0+0x80/0xf8
>>>>         do_el0_svc+0x50/0x110
>>>>         el0_svc+0x48/0x1d0
>>>>         el0t_64_sync_handler+0x15c/0x178
>>>>         el0t_64_sync+0x1a8/0x1b0
>>>>
>>>> Find a block with specific type to fix this.
>>>> prmt find a block with EFI_RUNTIME_SERVICES_DATA for prm handler.
>>>> prmt find a block with EFI_RUNTIME_SERVICES_CODE for prm context.
>>>> By using the correct memory types for runtime services,
>>>> we can ensure that the PRM handler and
>>>> its context are properly mapped in the virtual address space
>>>> during
>>>> runtime,
>>>> preventing the paging request error.
>>> some general rules to follow when writing a changelog
>>> https://docs.kernel.org/process/maintainer-tip.html 4.2.3.
>>> Changelog
>> will decorate this.
>>>> [1]
>>>> https://uefi.org/sites/default/files/resources/UEFI_Spec_2_10_Aug29.pdf
>>>>
>>>> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion
>>>> handler
>>>> for the PlatformRtMechanism subtype")
>>>> Signed-off-by: KobaK <kobak@nvidia.com>
>>>> Reviewed-by: Matthew R. Ochs <mochs@nvidia.com>
>>>> ---
>>>>    drivers/acpi/prmt.c | 46 ++++++++++++++++++++++++++++++--------
>>>> -----
>>>> --
>>>>    1 file changed, 31 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
>>>> index c78453c74ef5..e2f0bdd81013 100644
>>>> --- a/drivers/acpi/prmt.c
>>>> +++ b/drivers/acpi/prmt.c
>>>> @@ -72,17 +72,21 @@ struct prm_module_info {
>>>>           struct prm_handler_info handlers[]
>>>> __counted_by(handler_count);
>>>>    };
>>>>
>>>> -static u64 efi_pa_va_lookup(u64 pa)
>>>> +static u64 efi_pa_va_lookup(u64 pa, u32 type)
>>>>    {
>>>>           efi_memory_desc_t *md;
>>>>           u64 pa_offset = pa & ~PAGE_MASK;
>>>>           u64 page = pa & PAGE_MASK;
>>>>
>>>>           for_each_efi_memory_desc(md) {
>>>> -               if (md->phys_addr < pa && pa < md->phys_addr +
>>>> PAGE_SIZE * md->num_pages)
>>>> +               if ((md->type == type) &&
>>>> +                       (md->phys_addr < pa && pa < md->phys_addr
>>>> +
>>>> PAGE_SIZE * md->num_pages)) {
>>>>                           return pa_offset + md->virt_addr + page
>>>> - md-
>>>>> phys_addr;
>>>> +               }
>>>>           }
>>>>
>>>> +       pr_err("PRM: Failed to find a block for pa: %lx type
>>>> %u\n",
>>>> pa, type);
>>>> +
>>> If it is a pr_err, why not error out?
>>> or what is the proper handling for such failures?
>>>
> Not sure if you missed this one.
> It is not clear what is the expected behavior in this case. Better to
> describe this in the changelog as well.

Sorry, missed.
if get failure and return 0.
in acpi_platformrt_space_handler, it takes care to handle the null pointers.
```
+               if (!handler->handler_addr || 
!handler->static_data_buffer_addr ||
+                       !handler->acpi_param_buffer_addr) {
+                       buffer->prm_status = PRM_HANDLER_ERROR;
+                       goto error;
+               }
```
will also update in the description.

>>>>           return 0;
>>>>    }
>>>>
>>>> @@ -148,9 +152,12 @@ acpi_parse_prmt(union acpi_subtable_headers
>>>> *header, const unsigned long end)
>>>>                   th = &tm->handlers[cur_handler];
>>>>
>>>>                   guid_copy(&th->guid, (guid_t *)handler_info-
>>>>> handler_guid);
>>>> -               th->handler_addr = (void
>>>> *)efi_pa_va_lookup(handler_info->handler_address);
>>>> -               th->static_data_buffer_addr =
>>>> efi_pa_va_lookup(handler_info->static_data_buffer_address);
>>>> -               th->acpi_param_buffer_addr =
>>>> efi_pa_va_lookup(handler_info->acpi_param_buffer_address);
>>>> +               th->handler_addr =
>>>> +                       (void *)efi_pa_va_lookup(handler_info-
>>>>> handler_address, EFI_RUNTIME_SERVICES_CODE);
>>>> +               th->static_data_buffer_addr =
>>>> +                       efi_pa_va_lookup(handler_info-
>>>>> static_data_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>>>> +               th->acpi_param_buffer_addr =
>>>> +                       efi_pa_va_lookup(handler_info-
>>>>> acpi_param_buffer_address, EFI_RUNTIME_SERVICES_DATA);
>>>>           } while (++cur_handler < tm->handler_count &&
>>>> (handler_info =
>>>> get_next_handler(handler_info)));
>>>>
>>>>           return 0;
>>>> @@ -250,8 +257,16 @@ static acpi_status
>>>> acpi_platformrt_space_handler(u32 function,
>>>>
>>>>                   handler = find_prm_handler(&buffer-
>>>>> handler_guid);
>>>>                   module = find_prm_module(&buffer->handler_guid);
>>>> -               if (!handler || !module)
>>>> -                       goto invalid_guid;
>>>> +               if (!handler || !module) {
>>>> +                       buffer->prm_status =
>>>> PRM_HANDLER_GUID_NOT_FOUND;
>>>> +                       goto error;
>>> I think it is okay to return AE_OK directly, right?
>>>
>>> thanks,
>>> rui
>> I'm also good for this.
>> I followed the convention in this block.
>> If change to "return", i will change all "goto error".
>> How do you think?
> sounds good to me.
>
> -rui
>
>>>> +               }
>>>> +
>>>> +               if (!handler->handler_addr || !handler-
>>>>> static_data_buffer_addr ||
>>>> +                       !handler->acpi_param_buffer_addr) {
>>>> +                       buffer->prm_status = PRM_HANDLER_ERROR;
>>>> +                       goto error;
>>>> +               }
>>>>
>>>>                   ACPI_COPY_NAMESEG(context.signature, "PRMC");
>>>>                   context.revision = 0x0;
>>>> @@ -274,8 +289,10 @@ static acpi_status
>>>> acpi_platformrt_space_handler(u32 function,
>>>>           case PRM_CMD_START_TRANSACTION:
>>>>
>>>>                   module = find_prm_module(&buffer->handler_guid);
>>>> -               if (!module)
>>>> -                       goto invalid_guid;
>>>> +               if (!module) {
>>>> +                       buffer->prm_status =
>>>> PRM_HANDLER_GUID_NOT_FOUND;
>>>> +                       goto error;
>>>> +               }
>>>>
>>>>                   if (module->updatable)
>>>>                           module->updatable = false;
>>>> @@ -286,8 +303,10 @@ static acpi_status
>>>> acpi_platformrt_space_handler(u32 function,
>>>>           case PRM_CMD_END_TRANSACTION:
>>>>
>>>>                   module = find_prm_module(&buffer->handler_guid);
>>>> -               if (!module)
>>>> -                       goto invalid_guid;
>>>> +               if (!module) {
>>>> +                       buffer->prm_status =
>>>> PRM_HANDLER_GUID_NOT_FOUND;
>>>> +                       goto error;
>>>> +               }
>>>>
>>>>                   if (module->updatable)
>>>>                           buffer->prm_status =
>>>> UPDATE_UNLOCK_WITHOUT_LOCK;
>>>> @@ -301,10 +320,7 @@ static acpi_status
>>>> acpi_platformrt_space_handler(u32 function,
>>>>                   break;
>>>>           }
>>>>
>>>> -       return AE_OK;
>>>> -
>>>> -invalid_guid:
>>>> -       buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
>>>> +error:
>>>>           return AE_OK;
>>>>    }
>>>>

