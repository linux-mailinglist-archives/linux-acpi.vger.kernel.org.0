Return-Path: <linux-acpi+bounces-7897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE79616C8
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 20:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB4BE1F26D20
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D491D362C;
	Tue, 27 Aug 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xgXf6ZNm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B11D2F59;
	Tue, 27 Aug 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782733; cv=fail; b=pXoHGJu0EtnyHWnXpDUKiXSeUHcp7+4TV/ZbJ9Ytoq4hx+Xp1VMT9RzJaArSlAJZM+MxamqUa3A0mzJY5yGlxkwIAHdbGsaStSOq63lEhiWAHQzUry1mElQd+5qC7rmDFqicLXoKGRO+dHBUwzkBshfsiec0EyktRv4q/PBO/fA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782733; c=relaxed/simple;
	bh=3hrpjVkDQwTrsY/mwsxZSezWBVqkbXwfpi6c1cQ2bWI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bv9OrUlGbp7fzg6PVu8JC1Vye+ZZX8AbkdaO7vztKmdvmqv5mljOaMRFG04yA2Qa90NHF6MsRIY3Lw6ssb+kXEN1ye5XihXvFOXedeZezXo8Ckqu2Mrq9sWnNjGVqVZQ4Bq6yQ5m/20iFPFh01lS/LcBRXW8NEw3gjMIMjHD0sM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xgXf6ZNm; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WNWWmb7+1CT9truxnGfHTbu/KgE+szBOZKC+BgXQQE0r66udqXvV9ceNLgKaFVihZEWZ4ikPsSBMzQeg7ij6avHP4MMygxwxGvaeBeTwdLvriIMh435d/wqAz+Y5BzRnH/rZnxnrc3VM/0x7OX0IRRYwBplpgl87tdnt5rnZMDMFBmd5V1p4nrPYwAmuHN0qKuszZBkc0nlnHdz7W7qntQgO4rgADSQZfQGc2bvuW/hecQhDuLmhrFZBH1ZZKLgqdijaL/ew7HPDz5j9Mp9xyTZcxEH9iIyZJsPVa0u5CbQvAcRpcRGYZATJmy9uPksxaL37Ej/JcSZ5ddTFct3INA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVmd/v6a52o3NsIZbdATKZxGSqUBPX3gVSE50lTsWIM=;
 b=IwOLo3Puyfjy0Kb/AmIkJpZ536tNrJNhb99Iw8A+PX8fJE03eHpehB9pLWZV6g5I/U5anMMqtbHdNzD0oE4bwe0d58ukT/EMn0zH6Teng2P0B/vXGhGLUwwqyv6X8I1WbLvJM4cvHXRZBpuOJsdXnOt4PX49fE87MD+xIZ8s0Baa1WeVwrc+jNbYWYLJo7DYpG8du7vOgDlnSBaBg+OCqEU6H/zeJO595Vj9K7P8oM9lu306PbwNRRUpzJ6jZ6BFn74l1VNuxKie9Jfnnv+qjEi+mzRxiOLVNIiwSuCllU+bey7EozDrzUtyJkQ4WzULWPAsgQxaawtn67NIp0LWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVmd/v6a52o3NsIZbdATKZxGSqUBPX3gVSE50lTsWIM=;
 b=xgXf6ZNmfZg6pdIdHK69V9MfhEC8Pudd1vkgQ0gxrIm5yZCtvafXhU4XwmiheFZvR8ZU1LGXVMxkiPRokDMjSfFmfMyw+ymugYWVUSjZI/AeeeeW9os1bs/TJTI/yucJW3/8Pq6gWp83IniUX94ukfhQhZtDplKeJJ09G6lz20g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB7984.namprd12.prod.outlook.com (2603:10b6:510:26f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 18:18:48 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7875.016; Tue, 27 Aug 2024
 18:18:48 +0000
Message-ID: <3a8a2d6e-c9a7-42b4-9619-d1f86f9f3135@amd.com>
Date: Tue, 27 Aug 2024 13:18:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] x86/amd: Rename amd_get_highest_perf() to
 amd_get_boost_ratio_numerator()
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
 <20240826211358.2694603-3-superm1@kernel.org>
 <Zs3l6mry4qMavofM@BLRRASHENOY1.amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zs3l6mry4qMavofM@BLRRASHENOY1.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:806:123::33) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: b4977cc2-feee-4bd5-9c95-08dcc6c4b23c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUphdmVCTzJsVXhSbk5tWmdVdElYZExCWHl1bnhGd2wwY0pOODVIVXBrSDd3?=
 =?utf-8?B?Wnh3TTN6bVJJWFV3cktwVzhJQUhaeVd5dUlYTFpDTEF1Njd0dWZnaHhoL00w?=
 =?utf-8?B?VHdNck95a0tZeFNCd3pjbmtzS0Y5cDlUYWJtSFR1YWM3TUlRaElBS0RHYWpP?=
 =?utf-8?B?Z2NkenR1Vi81enNidGdPZFZZbjBSTEpWNXB3bllFMGVIWnJGbUl5WUVhaldn?=
 =?utf-8?B?RVQydDFVM0kvbzQxK0lONnl1T2drT1lsZk5nZENQdTZLekNkTkFZcUVwTXBo?=
 =?utf-8?B?M0VzZ1NiSThYOXY0TXcwWkFZclRuK2wzanUwQ2tIeFZmVWp1TVQ4NHhVemJv?=
 =?utf-8?B?WE1ybUhEWFcrSjNVUUFZY3F5ODhtOEdPYlNqWUZYamlmNzJUNHNBcVNJaWlH?=
 =?utf-8?B?YkdBM3pacnA2WHdwWDduUUlVbWhPcklWNFpSeFVRMzNZbTFZQ2p3UDd1N3RN?=
 =?utf-8?B?UkxPZmlVcGNUZVZwdlI4LzU4MklyYUVCN1hYem54SUJQYTJkK0FXZW1GcHc3?=
 =?utf-8?B?OXE1S3VPVU5YenlWN0VQNUNQRFRlcXdhTTdWeGlEYnYycU93YmZ6K0U4cGNK?=
 =?utf-8?B?ZmQ5M0xqd1BSclRIREgvKytHbmFTSVpRSDJ6SUdvYmRnb3p3SHZ3VEIxWDJ2?=
 =?utf-8?B?cmZMTGtScDF3N2QrYldUUnhoWXhSNmxhZG1HaVhlYmpFZGJpVElSYldzRFJC?=
 =?utf-8?B?SlNvNFNabDVYZTVQUnByMjFNRStkSE9HR25wNzVuYk5JeVp3TkVmSTg5eXdF?=
 =?utf-8?B?WEdhdlZtblBnd1Erdlk1ajA1d2lUWDA2dlVIWTJLRW9wU3ZGVWhjdlJtd2k2?=
 =?utf-8?B?RmFmRUo1Q21Kelc2VHh3eEg1emFVWld1T2UzSDBxa0sxWTNqeWltWnI3NjZS?=
 =?utf-8?B?QVNUR1N0em1lMXo5blhWNFZxb25qMkhoRXFjOW5kOFNXSjI4QkFYZW8rcUpD?=
 =?utf-8?B?WTlGWWY0Smh2bnNsUjEzT3UxY3BzWEZSRDllS1FWMnR4cGZaSzc2UTdGa1FX?=
 =?utf-8?B?cjE4c1A2b2pmS0R2RVdWLzl1NDV5cVpYRm04RjREYVMrZnNzQVNsNXZPNmF0?=
 =?utf-8?B?eXRDNndSTkJiMlpoRFo4amRvVzl0Q0hIYk1MNmVNM2JnVFhyMk9La3FyVVBq?=
 =?utf-8?B?MGFCdXBKQURiVHRRVmRiU0Ywblc2bVBjMVhvU1Y5NUlTQ2N2TDArS1oyTFBR?=
 =?utf-8?B?c0E1Q0tlMlcrem4xeU9VVXU2RmJsd0FJcG9yVzF5UlU2RmVPVENsWnlmbnJi?=
 =?utf-8?B?cmJIdjlpU0toeDViRWZ5L0dxMjBSODFMNTBaUmZrbEFBeC9RUkZlYnAzb2d4?=
 =?utf-8?B?Um9VTEx4dUliODNiQm5JSHBVaTJTTHFKOWdHWmJ2YTBDd045WGlnZ3M2NWdO?=
 =?utf-8?B?MjJMdG9OV1dVS3pxWE11MGttVzk0SUM0WnMyRWhUZ0xHQ0hRTUNqVFByVWdT?=
 =?utf-8?B?V0NhSEQ2R3VYWGtHNXNYdnlPQVowUDVUMjF3WS9FajVaYUNRejJLSjJ3dTJt?=
 =?utf-8?B?NHowY0ZvNU96STlNaTIxOW52aFljSk4vamNYM1FicG5mSXhsbHVkbjlYNEkz?=
 =?utf-8?B?cDI5NkFuaEJ6Y21OU0JLMngya2w4UXk5OVVqRFdlMU16RUgwdWFFeHBucmp2?=
 =?utf-8?B?QmJSTUJpY1BTa1BhNGhpZW1rQmxrcksvNzFSSk14OUdpYTRveXcrUlRqdFMr?=
 =?utf-8?B?ck5UbHZaTjlrclVRa0NWZURqbDR1RUQ4cU9SbmQyT2lWYUFneDJXYTd4aVNE?=
 =?utf-8?B?N1ZudnNiTE5DeUdlL1VkemVkNFc2MlB2K3orTGVnUyt5TzR1SlhyRlU5d1RK?=
 =?utf-8?B?VStxSDN6N0JYanVhTkpSUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlNaRzFBZzgzUm0yVzJHWmNYcExKYW1KK1BYc2FOOElzQmxCOS9kaDRUa0JU?=
 =?utf-8?B?dGVrOWtyckRpYTBBZXlSMkROd2l2UDlSaktmL0s0TmNXdThab3JnQWtpbFRV?=
 =?utf-8?B?d1Q5a0ZjQ2UzUUd6OUtlYVc3UFEzdm5GZ3l0c1JzaElwTktqVmdkbjFXemxS?=
 =?utf-8?B?aWdrTzhxUExFSCt4b3JveHNMelhjdWNKekhkWDBJeGJIMGFmZkFRZ1RQRDc2?=
 =?utf-8?B?KzVRdWZhblcwMGIzRTkyMW8yYkRVR2dIUXR4TUt6VXV1c2MyZTJKUjlBZXRU?=
 =?utf-8?B?bXF3Qmw4QjQrTTZQOTR2c3JUQTBtMnZlb3M4UzR0L2lpblFtUmhPOElvOWt6?=
 =?utf-8?B?MXlMaUs2cEJLZlY0VmtGMm9uS1pxWGU5ODV2dVBZQmN0QnlFekhBNDZwNTJr?=
 =?utf-8?B?SllmZmZvbmJCYzY3YndKNXkxVmpYdzBBSkVkb0FHeE9FUkpIQmVrcTlrelBJ?=
 =?utf-8?B?ZnJBYU9NcHJ6dEd6NGNpWC9XM3Z2NXVuSVNMV21pR255d0g4RDVuMG9PaHZI?=
 =?utf-8?B?TlZMUk9zaUtEMC9ub3puM3RqdXptL2kvNEp5ZkVZR3o1cENzbFZTTEdqaXIx?=
 =?utf-8?B?dlZwS0tCTjVOMjl6S0ovYVIxdWdoZzNlOVhQM1JIdm9xVGZOamY5bU9XT3dC?=
 =?utf-8?B?UnAvUzEzUUU2RTcxVXlLVDdVakVWamlPbDkyNTFJQnhRZmJwK2FiWlhXSU5L?=
 =?utf-8?B?b2tiZ2c5Ry9YTXZRSGdJTUxDc0ZwSSs3VFB5QXhWcm9FczdqemhWeVVBY2Ur?=
 =?utf-8?B?N0JzbU95K2owenp1ZUY1MkhIRkJKb2NHc09yYmhIMEY3OXRBNkhRMWFkcFht?=
 =?utf-8?B?ZHNsekF6clBEaGdUTGdYbjhIRW51M1N6TUc1a1pBbEZ2UWZiaFhLdU91STJ2?=
 =?utf-8?B?SFhXdktISUQzWVJtMkc3Q29NWFRhL0x2VFgyc0Nac002eVhTVklhT1B5bnVC?=
 =?utf-8?B?dUJKZjk0Y0NieXhtN3dsMGRxMkZTOW1JbzFkTUFoQXN0MllmK2Q3S1V0Mi9R?=
 =?utf-8?B?QWlMclRrNFh6bllwNVBMZDZvc1VUU2d3aWRWazFWdUhGZWk4TUgzdVRkdDBZ?=
 =?utf-8?B?M3BQdEZkV1hSNllBY2lzSllPMHpjOFFVbnhCbFEvOE1Wb1AvYmpmdFAreGhN?=
 =?utf-8?B?Q3A1V1JwcnYyT05BUDJyVGE5OTAvV1dMUm54b2FhNlh4c21qTXBzVFFmcXF6?=
 =?utf-8?B?aHJkYmR3eWpZS0hTQVJiY2c4WHJQZGl6N1NEVXNEM1JTbXJBNWpPczFaZURF?=
 =?utf-8?B?NWs4VDhIREo5V2VFdWpMalM2NnFoUllPYzBwVnhBTnhmbEFTNGpRUWRpV1Vr?=
 =?utf-8?B?NlJDWTRnYXRFNkh2YnJZL2lkRnFnMTlaeXd1UkplSUZRYnUzL1c1S0ZjekRS?=
 =?utf-8?B?bW9OOUQ5Uytla3NhVk5QS3BSakNLaFV4WXVaRDdsckRVekpYYmNBTVZNMUdD?=
 =?utf-8?B?VDRaVEkraW1XdEtuWXZyUVczZVJjRTBlUUhkNjUwTG5jOUJLK2VPZWljSCtt?=
 =?utf-8?B?c3dTZkMrcTVnaGZObGhuNWV6WGk2YzV5Ni82U1lIVlR4NGl0SW9FdzQ2bmZG?=
 =?utf-8?B?eFZsWS8wbjlOb2RkS1EzcERpMkNYUUI3UVBlK0hqVTMzQ2FEYnZBNWZhak94?=
 =?utf-8?B?WVhMVE1ZSHo3R3o3dUw0SVYvWjdPb2o1cEd4R1N1TUQrQXdvT3NjOWpLa0Rp?=
 =?utf-8?B?NUFLSkVjdnVwaWduRnd0N1gxZHZWbEV0ZHA0eXB0WjNXVE16WUhVUG52UXMz?=
 =?utf-8?B?eTI5K1M2NlMwTU91Q3dxUlJBSDh5bXJ4K0tJNzFIZVYyU1I4SmJsOEdPUWJx?=
 =?utf-8?B?eGhRaHhNbzQ1MXAyZEM3bVl3ZEdSYlBpWkR4aFhnNVNsZkNNUHFmdjBKSGt1?=
 =?utf-8?B?LzZLc3V5dHkvRldhQXptWGNhYW1oVzg4b0UzVXJVSE00QTVHMzVMNGcvbjB2?=
 =?utf-8?B?S2tSN0ZnU1VhY3V6YmRMS0JzRy9WWHB6dE5sb0RPRE5UU2ZVd0pGRUl2TFM4?=
 =?utf-8?B?NzRKemdVRExJbysxeW5LbUhwRnczdjA5OWR1Mm96RWtUaDJYbWZTa1dqeDZx?=
 =?utf-8?B?aGZQMTNDeUZ3SmxiVmxaT05WTW0rem1ZMVlQOVA1cXZBcldnQmpOTXk1Y1Nj?=
 =?utf-8?Q?08OyLX+D3Ijrt5lHLIT9Lovr9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4977cc2-feee-4bd5-9c95-08dcc6c4b23c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 18:18:48.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCIGrIEwoHelCcLGQEmHTauh4yIgro5b5DiiwdGirnq58tHn0b8k1Kl+PAL3/2onp48RJe9USoT8NcJDPo/gVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7984

On 8/27/2024 09:42, Gautham R. Shenoy wrote:
> Hello Mario,
> 
> On Mon, Aug 26, 2024 at 04:13:52PM -0500, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> The function name is ambiguous because it returns an intermediate value
>> for calculating maximum frequency rather than the CPPC 'Highest Perf'
>> register.
>>
>> Rename the function to clarify its use and allow the function to return
>> errors. Adjust the consumer in acpi-cpufreq to catch errors.
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> [..snip..]
> 
>> --- a/arch/x86/kernel/acpi/cppc.c
>> +++ b/arch/x86/kernel/acpi/cppc.c
>> @@ -79,11 +79,13 @@ static void amd_set_max_freq_ratio(void)
>>   		return;
>>   	}
>>   
>> -	highest_perf = amd_get_highest_perf();
>> +	rc = amd_get_boost_ratio_numerator(0, &highest_perf);
> 
> The variable is still named highest_perf, here! I suppose that will
> change in a subsequent patch?
> 
> 
> 
>> +	if (rc)
>> +		pr_debug("Could not retrieve highest performance\n");
> 
> I understand that amd_get_boost_ratio_numerator() always returns a 0
> in this patch and thus rc == 0, which means we never enter this "if"
> condition.
> 
> However, when rc is non-zero, shouldn't this function return after
> printing the debug message?

Both good points.  Will fix for v2.

> 
> --
> Thanks and Regards
> gautham.
> 
> 
> 
> 
>>   	nominal_perf = perf_caps.nominal_perf;
>>   
>> -	if (!highest_perf || !nominal_perf) {
>> -		pr_debug("Could not retrieve highest or nominal performance\n");
>> +	if (!nominal_perf) {
>> +		pr_debug("Could not retrieve nominal performance\n");
>>   		return;
>>   	}
>>   
>> @@ -117,18 +119,34 @@ void init_freq_invariance_cppc(void)
>>   	mutex_unlock(&freq_invariance_lock);
>>   }
>>   
>> -u32 amd_get_highest_perf(void)
>> +/**
>> + * amd_get_boost_ratio_numerator: Get the numerator to use for boost ratio calculation
>> + * @cpu: CPU to get numerator for.
>> + * @numerator: Output variable for numerator.
>> + *
>> + * Determine the numerator to use for calculating the boost ratio on
>> + * a CPU. On systems that support preferred cores, this will be a hardcoded
>> + * value. On other systems this will the highest performance register value.
>> + *
>> + * Return: 0 for success, negative error code otherwise.
>> + */
>> +int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator)
>>   {
>>   	struct cpuinfo_x86 *c = &boot_cpu_data;
>>   
>>   	if (c->x86 == 0x17 && ((c->x86_model >= 0x30 && c->x86_model < 0x40) ||
>> -			       (c->x86_model >= 0x70 && c->x86_model < 0x80)))
>> -		return 166;
>> +			       (c->x86_model >= 0x70 && c->x86_model < 0x80))) {
>> +		*numerator = 166;
>> +		return 0;
>> +	}
>>   
>>   	if (c->x86 == 0x19 && ((c->x86_model >= 0x20 && c->x86_model < 0x30) ||
>> -			       (c->x86_model >= 0x40 && c->x86_model < 0x70)))
>> -		return 166;
>> +			       (c->x86_model >= 0x40 && c->x86_model < 0x70))) {
>> +		*numerator = 166;
>> +		return 0;
>> +	}
>> +	*numerator = 255;
>>   
>> -	return 255;
>> +	return 0;
>>   }
>> -EXPORT_SYMBOL_GPL(amd_get_highest_perf);
>> +EXPORT_SYMBOL_GPL(amd_get_boost_ratio_numerator);
>> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
>> index a8ca625a98b89..0f04feb6cafaf 100644
>> --- a/drivers/cpufreq/acpi-cpufreq.c
>> +++ b/drivers/cpufreq/acpi-cpufreq.c
>> @@ -642,10 +642,16 @@ static u64 get_max_boost_ratio(unsigned int cpu)
>>   		return 0;
>>   	}
>>   
>> -	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> -		highest_perf = amd_get_highest_perf();
>> -	else
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>> +		ret = amd_get_boost_ratio_numerator(cpu, &highest_perf);
>> +		if (ret) {
>> +			pr_debug("CPU%d: Unable to get boost ratio numerator (%d)\n",
>> +				 cpu, ret);
>> +			return 0;
>> +		}
>> +	} else {
>>   		highest_perf = perf_caps.highest_perf;
>> +	}
>>   
>>   	nominal_perf = perf_caps.nominal_perf;
>>   
>> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h
>> index 930b6afba6f4d..f25a881cd46dd 100644
>> --- a/include/acpi/cppc_acpi.h
>> +++ b/include/acpi/cppc_acpi.h
>> @@ -136,6 +136,12 @@ struct cppc_cpudata {
>>   	cpumask_var_t shared_cpu_map;
>>   };
>>   
>> +#ifdef CONFIG_CPU_SUP_AMD
>> +extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator);
>> +#else /* !CONFIG_CPU_SUP_AMD */
>> +static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64 *numerator) { return -ENODEV; }
>> +#endif /* !CONFIG_CPU_SUP_AMD */
>> +
>>   #ifdef CONFIG_ACPI_CPPC_LIB
>>   extern int cppc_get_desired_perf(int cpunum, u64 *desired_perf);
>>   extern int cppc_get_nominal_perf(int cpunum, u64 *nominal_perf);
>> -- 
>> 2.43.0
>>


