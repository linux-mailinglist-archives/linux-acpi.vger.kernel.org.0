Return-Path: <linux-acpi+bounces-7899-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498E396173E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 20:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B14A1C234B4
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8611D2F72;
	Tue, 27 Aug 2024 18:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ogXNj1uo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3D1A08AD;
	Tue, 27 Aug 2024 18:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784532; cv=fail; b=q9U6CyxPT5DCvWQiLRrVki1xT2PbotdHpxCNXXkQcmLvnQ/7o+aq4kb6WIyB03rPPPEoyq0YoLepDF0cKkXCwPxv27kr/axn5f8nhfoMv2fK2q5rmO4B3LKpxlIr0vurS8FQb4cdQj2w8WCz6RzoW6rIr06Xqb8ULNWRNQ0Z7ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784532; c=relaxed/simple;
	bh=mOOaBei/FRqz3ZxO3QeENnckux2DFiI5trrO7qzoF5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cjzWFgTGUc8QPNhV7zMj1wVUAmdOlDAk0iK4UQmEDtf1wUubW/Xa9QOi6k06ayykqmHYf/WlNRBBJB8roNwKz9GpmHOXW5mzLcyd0OR+D8xCO7Eb0U0tEhdsEm8D2XBV1srpzAziT8g9VcIV/SSKVr4a/gRH0pmNuiajz/4Ax+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ogXNj1uo; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgW6WJEbHUYCkHHBM631NuSUwsH/cqi5ot6xPiEtC3F8b8xF1+ognMdAq8BGcg3WgziW8gU9qsq51gFViVCh69fzCDeIQZxObIFjS/qtHHN9UV5lSHSFmsVR/qPZn3fj1BtErxOZsZMaC8sEeue53XNIUX/X0S2ULre+v30aGUWuhsBNOpGdXI/tJE+ZN4JUrZv7i9sEstNThMU6jTWhDKbECR+0oiUS/6fUtLNZ8TOtQregmRuhyLkicBsHWYS45T0LoHkd4ccyzlROL3uHNSRdheKMBibEVOzqs/4zs7hXZXskZIN/njBQeGdvKVWfvmBeWBNi0a9NSkpKW9rp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AI6o57CwPuMwqEzfHazVeSua/qBxIw1Sz/6d+Chlhs=;
 b=DC+ePIKXwtvQhtmlCMwZpkeC9Nm4IejcwkwACRN2V8eFRWE9RpjVeMP8GpojCBAvdaWqn5XRhamvbtx0KzRiEONJHJOKzsC3PkGhu/Ls6ZMjjkRTRRb6YxcZFmPLdp13BwovFcZSyf96MqdD5b2YXVeFu75m+gQNxwozc1RYc0qdlbaNf4BbnphpQj1zj/PuNs/jmgZHG4RfYh6vtu/4E+qDuhf8JqFb/NEdAMw+6ny6OVuR8sL0c/5j8A9+r6arqUIDbXXeS5ltPImxXFNszqc7CQmXz19PA828WOZdlhVv4eGhEC5TlZdYQjzcrAselOKBen9J8LY1Vj7+kvlswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AI6o57CwPuMwqEzfHazVeSua/qBxIw1Sz/6d+Chlhs=;
 b=ogXNj1uoUQ3LLoM7wFI01NccYKs2T7oeI2VnyFG/FNCJSk/ORwJl6qhY/d1xvswDarKb3TzZi8u9APp6BRWDy+7WRM+qxGbDbxAUJNNqcSM7iFyy9uMGgmGpKPMY+KUqDA5iYn+o3TRcVscVcWATJ94z9l6pi9nSW+dBxWJ9LrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SN7PR12MB7371.namprd12.prod.outlook.com (2603:10b6:806:29a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Tue, 27 Aug
 2024 18:48:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 18:48:48 +0000
Message-ID: <d1222c30-114b-4f56-8805-600236b2684c@amd.com>
Date: Tue, 27 Aug 2024 13:48:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn
To: "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Perry Yuan <perry.yuan@amd.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>, "open list:ACPI"
 <linux-acpi@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-4-superm1@kernel.org>
 <Zs3np8AeARzbMVSB@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs3np8AeARzbMVSB@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SN7PR12MB7371:EE_
X-MS-Office365-Filtering-Correlation-Id: bd328bbd-3d16-4343-dc9c-08dcc6c8e338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b0luaEZUcHJwTWNNeW9jSjZPV25wZ2FNSnFxZWFDM1FkRHZwT0doYnpXVWZv?=
 =?utf-8?B?anQ2SER3bndDenUxd09XaDhJdjFvbnZ3cUpRZjRxektoUVRXd2tiWDk4QlJT?=
 =?utf-8?B?NzhoYzN4RXVGQ1lDeXQ2dTBHUEhsaHNSUDA2Z3I0OHp5TjUzRGtvcmVCeVNa?=
 =?utf-8?B?YzFrUlZBakRkN20rMVlaL2EwU3ZyeHJHWXdub09ZZ2NTRVJSbHh6K2l6Y252?=
 =?utf-8?B?NWhBTzhIb0JGd0JCa3ZQeFEvWnliVTZTYUJzQjcyek5hMzl0UUdSdGJ5MkpD?=
 =?utf-8?B?THlDbU9UMEhkQXJGRnpvb3ZyeVFQSDRFbWFZNkFza3ZkYWZzbGZmcDdQNHhR?=
 =?utf-8?B?anh6NlVIcUlsTkFQWFR2WVZTM0pzUzNVdEladmQyaXlNNTRla0NLajN5RndO?=
 =?utf-8?B?QVpTdkVLNGZ5RW5tcXpGbHF3UUc1elRsTnlON0l1YzBQU0Zsck1VTWRPd3p0?=
 =?utf-8?B?VThsUnloNG00cGJUWk5hTHdRblVQTUFaMFkvbUg5Z1JGd2RUY2J0a2xYQk9m?=
 =?utf-8?B?dVArL3NVNHF2cThTNTlRVk9oUHJ3OUJQM1hIbzRPaStBeVZGZ0JzeHZIUEE1?=
 =?utf-8?B?WXBxWnlRZExGSHphVFBMeWtqMEJmamw0RHZxVUZLT3RUU0MweS94N0VnZjQ5?=
 =?utf-8?B?cWlkU0Z5UlpBazkwOE96cEhCVkdHUENaUFEvT3F2NVVFa05RRlBXOFVWanp2?=
 =?utf-8?B?N21NdWpuWDN1b1h0U2tET0tVOHZxcHZsNmJobzExNmhxVHRjSXBya1FHSzc5?=
 =?utf-8?B?SXdaNHk4NHNWWEZyR1UxdU9tNXo1S2RZcTgzR040WElWcjJGM241R1BqbW1Q?=
 =?utf-8?B?V1RpWENLc2h0dkw5OWdBcGhwcEhabDZ6OFp5VnNkVm1OMG5iUmR2c01uMlJk?=
 =?utf-8?B?ZGVuQWRJejVnS3RQVVFJeE5PWEh5NmJQSVg0TWJ1TEZmM2RkU2hHWmhmOFhQ?=
 =?utf-8?B?ZVpXZ0hGWGdKOTNtRjhLTVU0VFhGUkZOTHlBRm9ML291NzhoVDF5eXQ0cnkx?=
 =?utf-8?B?ZnA5eDl0NHZlUzR2MURZa21QTG5odngxOGc0WERWWE51OXBGOUFGNEtYV08r?=
 =?utf-8?B?OVJyZFVsekZDbmtjTngxeHV1Q0NtZUJFeE4zcWZpTjk0ZVdjRDJWcC9kQjJG?=
 =?utf-8?B?Sng0Yk9kMGt6Wng3aTI4d2ZGaXExYnEvMVhnSlFNNjNHWG5GUWRHSVRpNTVO?=
 =?utf-8?B?M3FVWXEwSGdReUFPNm9RcjVyN3NMVk1DSVdVdGN0eHBxclo2VTl5Ylhydm9S?=
 =?utf-8?B?NGNoM3JZcWJKL1YwdWUwa1pZaVJ6RG1la1AyWWs3VXJFMWYvaEFLanJJK0tv?=
 =?utf-8?B?SUc5OEE4cjdKY3N2L0hGUUM2Yy9SQ25iZzY2YUsyUDBuQjlVWUs5dTNoa1pB?=
 =?utf-8?B?cnBpNGlXOVVBT096YklvNVVUcTN6RVREOFJUaEp0NW5ZZkd1aDdjQWNXY3Iy?=
 =?utf-8?B?OTRKTVU1cVdRRW1UcUFOaUpKTmNtTktPYmdhcXpyNmFJZVBTdnFCM25vaDRY?=
 =?utf-8?B?SlplQllXcHdTR1lLbEVCdlhyQ1FxeGlsT1BLUXNBK2ZvY1BlSGNCemN5QlN4?=
 =?utf-8?B?Ukhvd1JvUWlPUVl2ZDB4WDZFT3RJd1cxVmxOV0hRVG1wQlpoYklRajZXdEdW?=
 =?utf-8?B?bEkwbU1idkYvOHg2dEsvZnlCVkJxSXgxMXQyNjhNRm9FeERZekNIdXlBSnpm?=
 =?utf-8?B?YTU0c1dSdzdGMjdqd0NuMmxDZVNUa0JyZWVkZzlsZVhTM1FjSXR4a0RtSlJD?=
 =?utf-8?B?SmpXd1NpUjZkUk9QcllWRUhPN1Y4eEFPWnRnQ296aDR5SjMrajk3eVVUNmlC?=
 =?utf-8?B?T0U2clEydUhFY2hhcUJKQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk1VVmRvcVl0QWZ2bEZob3VrdEFHY1ovbkx0Vjh1ekVLcktGaEF6SVN5Zy84?=
 =?utf-8?B?ZmZiUE5VT2xta0tHVG9ONllkTlB3Um5Bb2RaOXJyMDdOeTQzZlJseHF6SmE1?=
 =?utf-8?B?aW5WY0d3Si9zamNSTkFSWDVBbjhta2RhMkZ0TzJxemEzZjN4Z3hhZFBhaVlj?=
 =?utf-8?B?MGtYRURLT1Zyd3NHb3dmMm5wc1MwbithOWxPVHVaWE9OaWNsS3VHcU55NHp0?=
 =?utf-8?B?anhJTmxqZTgrV2FKTHA0UDhmd2lJckJFOTduOUcwSWpIVFBIZU1BcnNYRlhI?=
 =?utf-8?B?YjIvWEc4eFp5RlI4UUFCd2lQRTBlSXhMRlRnaTl5b29tVlZBOEhHSmt3U2FT?=
 =?utf-8?B?TEFKTnZjMDRUSXBBaFU2SlQ0WWdrc1FsRnREUDVaSGlacUF2WG4yZmpQRHN2?=
 =?utf-8?B?a0lEWVF2NkhTSlZRQythUG9RT1V0bGxEUDgvTGllMWtXdVlkbm0zZm1ZZGN0?=
 =?utf-8?B?LytuUzljb3hOSXYvV00wRWUwSDhkOU5XMmJSNk5MU0VUM2hWdEw4Y1VuYk9h?=
 =?utf-8?B?OEpRU2pDbU9nd1UwNC9zenRrM0wzSHk2dVdjQUF2WFMwZDZaZDlUZmkrekxP?=
 =?utf-8?B?Zy9nNW5vNDhtZHMrZUo1SmI2R00xN2RMMTFIUjlJZDdINy9pczZpTnJEbFM0?=
 =?utf-8?B?RVNraWxRM3BjYUg3NlZtbE5mcFArWWg3bFVtOHJXWlI0OExHMVBqTXNsUUtn?=
 =?utf-8?B?bG5OeGZrR25LQWhMOWM4OGdxM3FXK3ZVNGtmQ01NR0c2Y1Y4a2RIczFkOWZQ?=
 =?utf-8?B?Z1NxU09LejZIOWdBVnlNWXQrWWVveEZtOEQwMThiMnVQMzlRcUhORkVPQ2E2?=
 =?utf-8?B?UmtLOFhGb2lzWlVyci9vVGprQmt1Qld5U2RzdU5NbHdBR0hhOEIwZXltUEt1?=
 =?utf-8?B?RytJaVVYUVVkZk5tNE92b3JyTkxqell6ZXpWcU5VMEhwUmxnTVVxZVNHNGh3?=
 =?utf-8?B?T3RBV1VtZnIzcVhSZjhObUpVSUdDMXNXa3NXdzcvcFhuSTVEWmtaQXVPMTA3?=
 =?utf-8?B?UkdBM0hhNXpVcy9hSTJ4N2hFTFZrQ21Da2tEZjBIZnJ1YTNPdCtSQnJLTVkw?=
 =?utf-8?B?RisxcnFSUTZITEIzQ251NTk2eE1MbFJTMCtldjB5UDhjcWxKU1piK2pHcTVk?=
 =?utf-8?B?Y0hFWVhpNHIzM3N2Q0JWbUJvQzFuSVMxaTZwWThlcERYcmx3QUJ5U0FiMG5p?=
 =?utf-8?B?Y3ZEL2crcHpwZDhBWWtaUmo4d3NzWVhuVm1FeXRSZ1lyTHZqZGxBalFRWHZH?=
 =?utf-8?B?UUxaU3BqZW1kZWJPdUVIWE9FRXkva1RQYlZQMDh4ZzJua3ltNUx3Y3dCY2tH?=
 =?utf-8?B?VWVUYXpmWjF5S2I5MVdlS1pWbEhsakdKOHQ2V3VNeTlMY3d0Q0RoVTdVdDBp?=
 =?utf-8?B?NENoS0poMHpOcDVZVkgxb3NIVFBuMk4zUlZBRTBqZk9JNHJ1SlY2RWZOL3l3?=
 =?utf-8?B?bVZ3STAvVW5DZ0xnM3lPNHg0NWN6d0xqRlg1YSsrZnV4d3p5b0FydjljYTNQ?=
 =?utf-8?B?cnBVNmNXNEFMNEhXcThsNUQxaXd0a3l5MUxud3FzME4zM040SVBUM3lIWUVH?=
 =?utf-8?B?MTV4eVI3QWY4cW5zYjVaMXJFaDRHY0txL0o3eCs2SVFYNlRWWk9kTldKdTFz?=
 =?utf-8?B?M1U1WGdNRExoMFdqdnJaNWd2WXo2RWt1YkxsbUNEbCtVNHE0UXYyTERaOC9K?=
 =?utf-8?B?SmVieWR4dzBDN0hrdXdJbVFLZERuOVdmYks2YWRGSFhsbXQ0WTZpNWdyVnl4?=
 =?utf-8?B?N21kOUEvQkwyUkh4N2pEV254dmJwOVJwaWx5Q3pQZ3YxMlc5VGk4REhzdHZ6?=
 =?utf-8?B?Nk94RjRpY2lwM25YVDYzdC9NZUZsLzRIRXVqbnU4eGFOMElhVnNBWEtSV3dq?=
 =?utf-8?B?b21kMjEvakJVWkZxbjNUMmJXVmp1VEl1cDVEblBVeXpJa2dtVFdHOWN1NW10?=
 =?utf-8?B?Qi8vL0RMMnhNdEJsUmQvMWNUaU1Pdm16dFk2VmdwdFh2MzlKL1UyMFBHRjBm?=
 =?utf-8?B?cGd6NjhJUFBySjFoMTZXcEdIQXkvb1A1eGtGVEQzRmpLMHRNNVQ4cHJiV1VN?=
 =?utf-8?B?dzNGKy9jZ0VJUmRFOERyQU91eTQ3QWw3OEw4cFNMWTNpRWNKdExXa0JBcW81?=
 =?utf-8?Q?lDXXQa0j4vaQMeknQ6HZXApbT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd328bbd-3d16-4343-dc9c-08dcc6c8e338
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:48:48.9012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nh8o8f3mRUnwRWxcU2vLp1vxqS86nfPIbh1QflRauAAWGZEnwDw1GNd4Yn7K7rn7o4gUeRIRi+EGDK0sW30aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7371

On 8/27/2024 09:50, Gautham R. Shenoy wrote:
> On Mon, Aug 26, 2024 at 04:13:53PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> If the boost ratio isn't calculated properly for the system for any
>> reason this can cause other problems that are non-obvious.
>>
>> Raise all messages to warn instead.
>>
>> Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   arch/x86/kernel/acpi/cppc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
>> index 1d631ac5ec328..e94507110ca24 100644
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -75,17 +75,17 @@ static void amd_set_max_freq_ratio(void)
>>   
>>   	rc = cppc_get_perf_caps(0, &perf_caps);
>>   	if (rc) {
>> -		pr_debug("Could not retrieve perf counters (%d)\n", rc);
>> +		pr_warn("Could not retrieve perf counters (%d)\n", rc);
>>   		return;
>>   	}
>>   
>>   	rc = amd_get_boost_ratio_numerator(0, &highest_perf);
>>   	if (rc)
>> -		pr_debug("Could not retrieve highest performance\n");
>> +		pr_warn("Could not retrieve highest performance\n");
>>   	nominal_perf = perf_caps.nominal_perf;
>>   
>>   	if (!nominal_perf) {
>> -		pr_debug("Could not retrieve nominal performance\n");
>> +		pr_warn("Could not retrieve nominal performance\n");
>>   		return;
>>   	}
>>   
>> @@ -93,7 +93,7 @@ static void amd_set_max_freq_ratio(void)
>>   	/* midpoint between max_boost and max_P */
>>   	perf_ratio = (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
>>   	if (!perf_ratio) {
>> -		pr_debug("Non-zero highest/nominal perf values led to a 0 ratio\n");
>> +		pr_warn("Non-zero highest/nominal perf values led to a 0 ratio\n");
>>   		return;
> 
> Aside:
> perf_ratio is a u64, and SCHED_CAPACITY_SCALE is (1L << 10). Thus, is
> it even possible to have !perf_ratio?
> 
> Otherwise, I am ok with this promotion of pr_debug to pr_warn.

You're right; I don't see this is possible.  I'll tear it out in a 
prerequisite patch in v2.

> 
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> 
> --
> Thanks and Regards
> gautham.


