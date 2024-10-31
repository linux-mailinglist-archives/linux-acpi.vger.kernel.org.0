Return-Path: <linux-acpi+bounces-9199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B628E9B7D1C
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 15:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464931F2106F
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 14:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70511A08CC;
	Thu, 31 Oct 2024 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Jpp/8cRb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D742AA5;
	Thu, 31 Oct 2024 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730385642; cv=fail; b=TlbA9XTjQi60yJnZHty3njFFOJ9KWWeYkrwdWQLaQ3p9e6luMIrFwJbwZu/S4VXHpuro0yoq9RMml+eF0zaj7GW3THlrZ0wbt42J+JfE0e/GbV+smowLdF7Q3c1lsqUh6w9gu5FLMCqzpW5Ixpo3A6ON2cFEqvm3AnjM64vvJx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730385642; c=relaxed/simple;
	bh=sPR5d7J70XER66WF/g8aRNH+By91NkTLxlWXDHP+Nd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DecIT9iLfM4+HL2N6d7NDqe+T86iuj1EUg4t35XCiXenkUwDrfcwJv/PM7VfzB/FHMOfB/DdPunBbAvHNQXQCRtBtoZuNJOQABHECPqfKuTeUpLt4lm6TUF25lpIXblITFl4AGo7xNap1qlgAJsrTdddLW2Mu3PpBw+GGD3vnWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Jpp/8cRb; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3jXdRDgmjd52NOErGb1/j6T7zkf8pY8P57IdN9ZtDHhUIiEIcDuFJ9PquiXXQv9AOmL8Ycw7ZVk0jQktFrT/ziq/uSTsmLcVSso/4UcW49gWFHxpPqxjBXwAmLsIirjo0KsghKV8kkN8d4VUdQAAeRFk7BmlH3dqWO1PyAkqi0ArLCp6fSH+31S0lot6MLn/PGjtXcmA+grZF3lZyLWl//S8jV3M8fOj/eA1gaHbks1Io7dYZxgRctQ5FpV4d+o68Wk6gHl98QNj7+tsKU3TnfKYxvcm9hes9ychNgTw332u4/7Z9pGSY2rpm/bpyUWKO4nviNyvJtgq43fConS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gmm8RBLGZWf67gr0l/NsWwx1BxGfQ7XN+mrjbN662fo=;
 b=HucYvQRppJQ4R28uZoQGGOi2+pqRPBWJCYBOgNQGvjocUa99gG4vxtgeFrohLwlj+iVvvmsZHA/jq9RgziURZYZZ2tgHCqq9czRYj33GPn/ry9J5nhl3pQqMjPAXKYsf86V8VdilDSOWTqa74jRogWcuo9Ao3nR+oiTcejdm3/SOpjMqw65T7p5g+A3heb9rKbYTk1e/bggx18ZpiHWRRBN2cCJcDf1Lwh9LT/VbmCY+uixxoneVKnMVXwYvAPGJmbzHgxsUCfDq95P4PtmMDejKe/r2k9mw3v0GydNBvJA6YJ/F60pGyM1Hzp++RGcyqmJZwQU3prs82RTDjgBp9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gmm8RBLGZWf67gr0l/NsWwx1BxGfQ7XN+mrjbN662fo=;
 b=Jpp/8cRbD/CJrO2fke5Ch70kSlN41coaWZckJC+q82Y1NnjLsZMfjf0hqKeZmGadbJDzJTtla86g+PldyA9XbsGoiXCVE2uiaixqhke0o+Oo1l+F9kGrZVG1xyXcYiKrNlxG3PKvcBiGBtR+PIznGY7LAMWW4hvVYb9+yYiA0IU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 31 Oct
 2024 14:40:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 14:40:32 +0000
Message-ID: <8cc4c85c-d0c5-431c-9e11-29453048c6d9@amd.com>
Date: Thu, 31 Oct 2024 09:40:28 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/22] ACPI: platform_profile: Set profile for all
 registered handlers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241031040952.109057-1-mario.limonciello@amd.com>
 <20241031040952.109057-17-mario.limonciello@amd.com>
 <7e2c26ab-9172-fa82-cd96-7f725d6c7687@linux.intel.com>
 <362d8939-20ed-40c2-95b4-f687dc20f6cc@amd.com>
 <0fd4c5ec-3645-300e-baee-cb6468039f75@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <0fd4c5ec-3645-300e-baee-cb6468039f75@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0144.namprd11.prod.outlook.com
 (2603:10b6:806:131::29) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: bef4e49f-d9ff-4147-12ee-08dcf9b9f92d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2J0akhYaWhjWXpnSERzdytheU1hSVVVRW9aamFQMXRRMDYvdUhwVmdLU0Zn?=
 =?utf-8?B?QVNYdTRTWk83YllYMEhOSjAwTXhZWXVORzEyTy8yMjRNT09qV2wxWjRCRWVD?=
 =?utf-8?B?RHRDM3RJaytQMjdZVkwzWEwybXN4YXZWNEZ6aDdxRThnTlR5T1FWUFZyS2Nh?=
 =?utf-8?B?MlVXQkxoOGRDWTRQVWg0WWZMNUltSHV5VHpyaVhYY1NVRlhBbFhzdjNmYXlW?=
 =?utf-8?B?NmRjU2FaaTNLTERkMWMvUGRtaDBONjlCUlpHWEU2QnYzNGNYRFJqSDJrNktj?=
 =?utf-8?B?NDZnQS82dXJHZWdpVHVZYkhZZHd0eG11UXJIcXhzVENMZWw5V2lya29tQ0Rs?=
 =?utf-8?B?RU8ydlFKWm5NZCtuRDBUaVViME1XZEo3MVlYOHdjejluSExwU1hMTmJSUzBW?=
 =?utf-8?B?akx1ck5tMUczTStkRnA4Rmw3UmFPeDlQK1FyaVhaRVpFQzBEdWpHdE5BWFdC?=
 =?utf-8?B?ZXpWZVpRQ21kei8rRjJNV0xzbzNCcXRncDRpcEhQakE4RkNIQ1lyNW0rajJV?=
 =?utf-8?B?MWJiS09BWUV5RFpwbmplMmFWME1pQjVYU0FQemZrL0tJN3JCenB5MzRPOTNP?=
 =?utf-8?B?Y2c5WFkwV1VxZUxwUHRiU1k4bjN4WVpXWGw5QnRYampxSkNJMjBQT0p6YVAz?=
 =?utf-8?B?WVhYRndxTEJDUEtIS05CQU96YTVRSEo0OFpzVGRIVTM5UmtxWXdyTmluTy9S?=
 =?utf-8?B?eFpwTmoxeXc3dFBnTHN4RU5UaFIvSGlZa00yN0prdm1qcGIybnFoOUdlSnRP?=
 =?utf-8?B?R0NvSHlhOFlUanFzU2I0dHpjR2JSTGhaVkl5TGsvc0ZvRXJROG1JY0NERE1Q?=
 =?utf-8?B?S05FRUE0eWNrN2I4NUNrV29ISzd2RnMwc1hITG1KOHFCOTBlSHVlU2dRRlhZ?=
 =?utf-8?B?dis1Wm9mZkdMNmxwenBzSmp3dE05ejRaejNXdG15akZoMFB1aDBTM3RhUmlQ?=
 =?utf-8?B?TmtPbE5ObEpFL0xlT1N0VHA2aXhYSFM5V1JyWUg1V2FiQW1NcEgzREFLZzBQ?=
 =?utf-8?B?VEgwRTk3ZDRiYi9GRG5lYk5XNEZDY0hlY3dIY096NmhsNUV2KzdqUXpyS3RK?=
 =?utf-8?B?cFgvSUVsV1Rkc1NqSkdmTTcvR2hsMlBqWkJQQ0hnRmEzSk9uTU5oZFhlUmpH?=
 =?utf-8?B?Q0tyZ3ArSUxDcEhIWm5ES2xNV04ycmdJVjJ6MSsrbDcxM2NCdU1mZEtTbmdl?=
 =?utf-8?B?M2dFeGJCVHFIWkZjV2NoSWttT1lXY3ovN0tRNzZRMExIeVZtUThzS3hDMi9V?=
 =?utf-8?B?RkVaMWYvUC92UDRTdEUxYy8zMlA3bURrUzlvRlJiMitraDJQT0crK1pSOHhE?=
 =?utf-8?B?VUpBbU1qanlselZFd0hOaktEcVQ0Z1FNVktwbVIrSEdIckpLYzI4QlJ2MlE4?=
 =?utf-8?B?UmRJYW51VFV2Zis1bVdpYkx2bGFYdmNySXBmeDJkMFZiWE9DM0lXaFVMeWVK?=
 =?utf-8?B?RE1IMFRoaDJyK1pGeWptaTY4WGxmcmtJaC9NM1ZEa3NqajIwYXlvSTgwYmxX?=
 =?utf-8?B?K0dWNlV0ajg5OHdOL0paZEhCWWs3WDZOaVkvb1llb0lCN3NobFpTeUFEQzBh?=
 =?utf-8?B?OEFRQ1ZSUk5wbWlmc1hIa2lKWXpWZG8rcllWaTJ5amdkaTVRWTVhaUp5QVU5?=
 =?utf-8?B?ZGxGWnU0bHBlUVhQRUs2dEowZ24yVU5tN1ZENzdXdXZ3c21OYU5ZT0hDUGFn?=
 =?utf-8?B?QWlQZTVHZ2JIcHFJeGVqK1FiaTJwQkE4NXB2Y1orN2NZdTlxbFRkeXFWRzBT?=
 =?utf-8?Q?qiPqiUZs8p2HxIuHz//aKp1X3KvEQWjl0CLbwyA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZ2MTUzUG9CUEU3eTQyVDhlaUo1V20rOFRJaXQ5Z3Z1K2ZWeHI1YXZld2x2?=
 =?utf-8?B?Y1RzZVZjbGduZldoTVFQOG5jaEd2eCtxYWxXRjMvRDljSzJSSk1RdS9ETjhs?=
 =?utf-8?B?N2VnWnZldlZIeXBuODB4UE02eFMwc2MvRWJqMWdNZXRCUCs5c0JacUxnZDNP?=
 =?utf-8?B?aG4yN1kwTldKTElUcWpud0orYnVsVW1qOXZnRTlhTVFKQWdYUEQyZTJ2OEk3?=
 =?utf-8?B?bGtzQUVGOXp0Qm41YW9iNkwzVXB1TStsbE5EelVodjdhUG9JUGZhYVJWQnR5?=
 =?utf-8?B?bUZIcFRMM01wMllIbGdPMURmdVlXenE1TTVCQUVFOXlnQ2I0eEFQdFZjeGdp?=
 =?utf-8?B?ZlEvaHpHbHM1amYyZnVTckxUNUtXVCtXQ2xBN3pHeVRhcWk3V3NPUEpZb2VP?=
 =?utf-8?B?RXFsWlQrZmZWSmFFb29qYnBqdUxaRnF2QS9leE5UMkZlRnpDTkJzOUdnaEJr?=
 =?utf-8?B?SjQrYTRxVHpPSGQyYnZzM2t4ZTRWeDBERUNDZHNzbmpVT05nUmV3cFZFajlK?=
 =?utf-8?B?WVFlWnFuV1ZqQUkyOFdtemZuYkpjL1dKK0RXb0xPd292SUdrZDA5eUhzTkFu?=
 =?utf-8?B?QUdpcWdMeGo2emFpZUYwdmV1Z2I0M2xUdHRaL1pDNWZieTUxU0ZOZkhFNFFO?=
 =?utf-8?B?Q291SWlZV0lnc3NBazRhaWNWRDFPWDNKS2lkVVZQZU9oUzRhV0tFMHdEMW1T?=
 =?utf-8?B?WnF5bmVQVUh6VElWbC8rVWNXYml2TlZacExXU0d0bllhaUZCbzdrWEE2aExL?=
 =?utf-8?B?dmw1Y2t6NUhKZFZOaXcyam45akRXenM0NlB4VjZyaUFDVGt5YzJ6OWM2TkZo?=
 =?utf-8?B?R21GVlFCa3lEMDJPSGl3SzRJOTBpTnY1cnFnNUluRmk0QXBhNGNhUW10Ym1t?=
 =?utf-8?B?SDlCLzhORXpnTDlZVWVWV20vK2tGYm9VMmtJWURmd2o4R0hwRno0NkVwK1Vh?=
 =?utf-8?B?TUpXbWhScllQSi9NbzZPOFpHSnRNRVlMbFpLOVlZZjI5UWJRTU55VlZ2ZnRV?=
 =?utf-8?B?UkhpMEtaaFFsN3NNcHlHT3J6QzZvcmtaSFFvKzZMb25FVTNtRTRVT3g3cEZJ?=
 =?utf-8?B?WVQ1R2hHTDRQcS9MeUIvcytRNkJ5WTVEdHlHM0VFcTQ3djRTQWE1OW9LZEcx?=
 =?utf-8?B?K3d3K0NyQmJHK3FpUSt6SmRLSE94MDQzeU1kNmZUdDN3NVdNdm11U2pLc0ti?=
 =?utf-8?B?MHV1c1A0Qk0vL1ozaWR1Z2p5eFlYd3pOaGtNOUg5dTNmdnQ4UWRYcXg2MUdE?=
 =?utf-8?B?anVxY0sxTXhFRkpPL0xJd3U4cmRiZGQwWFNoYkhIUnR3QWtaZzh4NkpxaHc2?=
 =?utf-8?B?Mlc0NkF1M2hubWR6S3o4Z0VodUFSTmVKbnZnZ2cyZFhINXJXcDAxQkF6RXNo?=
 =?utf-8?B?YkwwYXQvM0NKSlNYeDdqamkxWWk4d0l5Y2tiTytDaDVJU3A5YWR6VUVJdFdu?=
 =?utf-8?B?dWYwdlN5anZFWDlaSVM5SjFkMGpmQnM3Q1NOZzcwVEVmaWFTY0V5TUhrWmNB?=
 =?utf-8?B?blR6KzJxNjBQSDJJZ3hrdVRjMmNHeFlIMG05N0FkZlZDZmkvSERwaXlnQ3Zk?=
 =?utf-8?B?aGlIYUpVaWswQ29pMFJjNUtPSnIwYVIyY2IxT2RsRlRVcHc4SmtNV2pEYjRR?=
 =?utf-8?B?cjlLVnpKekFxTVZ4TW1ETmg2aDhnOStyRThqNStBczBCUDQ4ZDFxcFpxZU1F?=
 =?utf-8?B?ejlxTkNyVEVDUWovUXFNKzgvT3preDk4TWdhMEU2STZIb0gyUU92eHRUQ3pR?=
 =?utf-8?B?akdsRzVSaTZVbEhRdytzY21pZU1OZkdreWRRS0dLTy82alhaSzYyeHBTZURm?=
 =?utf-8?B?eXcyZUhxVTIvR1dLSm0wSUtXeGFTeURqOW9nWWVKSHRkQTVPR3ZmUHYvY3g1?=
 =?utf-8?B?U0xENTVtbi9od0p4ZnFaWmZQMGNnUm05UXhRTmNKUlAveWxSRStjNjUwcTlY?=
 =?utf-8?B?QlEwclJ5dmRCbklVdExubGltemYrTndPVHBpTXBEM1YrOWFxNWJvNFcvN3Na?=
 =?utf-8?B?MEp5MU1xNXAwMVJ2NXNsNk9oOWJPRkQ0VW5nM2VpUHlZeGk4cGx0VzJsSno5?=
 =?utf-8?B?WFJRVlBUTXUwRzAzMTVvU1NvK0IvYXc2RzFReTVYMHBvN09LaWQ1RjJCVGZO?=
 =?utf-8?Q?Z00cMjWCinUp2dNQ6tTWg/CLW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef4e49f-d9ff-4147-12ee-08dcf9b9f92d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 14:40:32.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ida33pKA0cTOBfPujcdchfUXxwiXYRWfuvuoNqNi7B1TKrWn3htfzrh7pLywJ54Z7kIaYXOsBycphBnB+XVOxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637

On 10/31/2024 09:37, Ilpo Järvinen wrote:
> On Thu, 31 Oct 2024, Mario Limonciello wrote:
> 
>> On 10/31/2024 05:25, Ilpo Järvinen wrote:
>>> On Wed, 30 Oct 2024, Mario Limonciello wrote:
>>>
>>>> If multiple platform profile handlers have been registered then when
>>>> setting a profile verify that all profile handlers support the requested
>>>> profile and set it to each handler.
>>>>
>>>> If this fails for any given handler, revert all profile handlers back to
>>>> balanced and log an error into the kernel ring buffer.
>>>>
>>>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/acpi/platform_profile.c | 25 ++++++++++++++++++++-----
>>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/platform_profile.c
>>>> b/drivers/acpi/platform_profile.c
>>>> index 90cbc0de4d5bc..c2bb325ba531c 100644
>>>> --- a/drivers/acpi/platform_profile.c
>>>> +++ b/drivers/acpi/platform_profile.c
>>>> @@ -99,6 +99,8 @@ static ssize_t platform_profile_store(struct device
>>>> *dev,
>>>>    			    struct device_attribute *attr,
>>>>    			    const char *buf, size_t count)
>>>>    {
>>>> +	struct platform_profile_handler *handler;
>>>> +	unsigned long choices;
>>>>    	int err, i;
>>>>      	/* Scan for a matching profile */
>>>> @@ -107,16 +109,29 @@ static ssize_t platform_profile_store(struct device
>>>> *dev,
>>>>    		return -EINVAL;
>>>>      	scoped_cond_guard(mutex_intr, return -ERESTARTSYS,
>>>> &profile_lock) {
>>>> -		if (!cur_profile)
>>>> +		if (!platform_profile_is_registered())
>>>>    			return -ENODEV;
>>>>    -		/* Check that platform supports this profile choice */
>>>> -		if (!test_bit(i, cur_profile->choices))
>>>> +		/* Check that all handlers support this profile choice */
>>>> +		choices = platform_profile_get_choices();
>>>> +		if (!test_bit(i, &choices))
>>>>    			return -EOPNOTSUPP;
>>>>    -		err = cur_profile->profile_set(cur_profile, i);
>>>> -		if (err)
>>>> +		list_for_each_entry(handler, &platform_profile_handler_list,
>>>> list) {
>>>> +			err = handler->profile_set(handler, i);
>>>> +			if (err) {
>>>> +				pr_err("Failed to set profile for handler
>>>> %s\n", handler->name);
>>>> +				break;
>>>> +			}
>>>> +		}
>>>> +		if (err) {
>>>> +			list_for_each_entry_continue_reverse(handler,
>>>> &platform_profile_handler_list, list) {
>>>
>>> Too long line.
>>>
>>> This looks an error rollback though so instead of break inside the loop
>>> you could goto into a label at the end of the function and have much less
>>> indentation to begin with.
>>
>> How does the scoped_cond_guard interact with a goto?  With the jump I had
>> guessed it goes out of scope, but I wasn't really sure what the compiler does.
>>
>> I guess in the goto label I'll need another scoped_cond_guard()?
> 
> Ah, the scope problem is a good point.
> 
> Perhaps you could instead add e.g. platform_profile_reset_default() and
> call that before break, both patches that had the rollback did the same
> thing anyway so it can be reused too.
> 

Sounds like a good idea, thanks.

