Return-Path: <linux-acpi+bounces-9207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF209B848C
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 21:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BEC428224A
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 20:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C04C1CC17C;
	Thu, 31 Oct 2024 20:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f+f/LVbM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DD7149C55;
	Thu, 31 Oct 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407434; cv=fail; b=EjDZac9LZGQvu4OGOUYg9RcXAcKM/TN96QfTb6iauSqvEEdTCfKqd9Dz+qtVTQiswtAxCDFkXa4qoC/jVNqxisMUXRbjEPPc05U9apwwXVUSgoSc+V0p9TXum+UY4oWxbH3leIyCbw0he8J9rQYbf/qxOK1XD90XBEHc2ntamyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407434; c=relaxed/simple;
	bh=Sq/9+t0zpEsrD92csNIOLu51KWfgJ3G0DBjVn948wr8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r9q4WL1CCsSJLNJgYIKHZKjzKiOvdBRD5nilNBuLOJhn6XP69zq6euY6YnUZT/ikx43edDcW48aVko/GH/GUcqvkvrAbMvNnNrYK5c5dVxLZlmKVo5peUjmSG1VtZL3vUMlSfOI8tprYeSNROcmHavYqHRmmyWhrzvIyjO1pCuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f+f/LVbM; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJ4UUSarzpKUZqzudMJjVBHKPyWL6jBU5sfOX+R87as45YYu5HhY6jyzfstvZqR6oBE1e7F4uEXKweUi99pHq6UDM9XHdDQgPpleYce6MSHuC8s7sJP/UACEWW/Tk2adgGbi9hN8L+Xr0+70vp8huRla+icRcx3ljnjuf82KA5mn67GyTtCsI5IOdIGG8lc7wqdsC+sf6CTlju6kOU/oHr6U89RVl1QX4NVKyFGzplCgUCr/KVVmQVbkhPEcV4gVbA11Tdr7SxoXMVFWUcTxvlBtJv9d86TgkWmD+TiaCfY/w9dgNpz7PnZljGQwjwVQ0SQFlrO05Pdjm168hoxfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MtlSrW+1FbfuPlq/EFBUXbJyXroVlkAe88Nx71/kX4=;
 b=bqmPZsXJTahoDrlu4j6uV53eeQWzUERBj8a+5JCZm0QKFBsyhfzbG8F7bKraK1idowsisNlTiaieAF7bKh/qCe3STcYsJ/No84aZ6/aPb24R8fliGOLoRewVGyPfYb8abKDDFIDZEz3amb05Z6mL2qH2VhQxdjlMIRYorYPObRvShO2QrhmEdmPU79JTPZDUsId38vNjrCDsc4unRKpGoMpDiwX5qHkZrrzqPlQjAGFl45/b4b8c1deGKTKaOLjSW5NRB0T08Xju3C42+xMqskOwQo12KZWr31BvgQD6Yur5XvfK7YKoxqEpstF2TGPpr/SuekFl25YY6+t1/qBaGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MtlSrW+1FbfuPlq/EFBUXbJyXroVlkAe88Nx71/kX4=;
 b=f+f/LVbMSsIJitb7VkxUFfgNt/DOXYPUBtY4AkVvjH2G0oc7ffrXZANtK7z4Q/3el/DeuaASaQMHevI1RVeEFDk6+o4AZnn1anEo4BFNAXRuilhjWyizxcNqWkW8ckfKGzeMjlEqKqcyQVx50ysVRylkTJn0QyfueQ1Fq3vU1zg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ2PR12MB8035.namprd12.prod.outlook.com (2603:10b6:a03:4d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Thu, 31 Oct
 2024 20:43:49 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 20:43:49 +0000
Message-ID: <a95ed9c4-a112-4087-aca9-8323902273b2@amd.com>
Date: Thu, 31 Oct 2024 15:43:45 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/22] ACPI: platform_profile: Require handlers to
 support balanced profile
To: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
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
 <20241031040952.109057-14-mario.limonciello@amd.com>
 <40b52d41-e3d6-4223-b9e9-0db6b2a19265@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <40b52d41-e3d6-4223-b9e9-0db6b2a19265@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0069.namprd11.prod.outlook.com
 (2603:10b6:806:d2::14) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ2PR12MB8035:EE_
X-MS-Office365-Filtering-Correlation-Id: ee842228-b655-467e-c881-08dcf9ecb8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEd2YzQxVVFsL0RIVWx1NnJQbXJRT0JqbTBURDNEUnU1TFJaVmpqc2MxZ2Rl?=
 =?utf-8?B?QStVSFY5M0ZnVEVXckNrSzkzOFVwdmNqNlhJMkR6dC9sWEVCbVVjRkNGbGdP?=
 =?utf-8?B?eHlwNXV2MFpuSlFSVUtqdjJYSkFvZWFJaE91NGZONHFaZk02Y3VlcDZHNFdm?=
 =?utf-8?B?TUdacE4rdXNGQlZ5bFBjZUhvQVZPSW9rMWVxekZUTmhrZHgwaXVucnpNV0hZ?=
 =?utf-8?B?ZkEwUnBOSGhDSDNRcU8wM3llZmxXYVZFYlp1d3ZkZ2gzdXlRbWNrYTdXa0ln?=
 =?utf-8?B?S003dk5IM2JRNXhjcUlpUEJBMk1ZRjEyUnc2UWFuUm1zZTNHK0g2dDFZK3ZM?=
 =?utf-8?B?anpldE1uMlhRcXh5dnkxZ0J4VUNBUWN3Qm1ZcDh5Ny9rNWptczBwc25yWTVn?=
 =?utf-8?B?WlY0dHU0NXJGN2pQakxERGhxWi8vT2NvNElNZy9wV3FLSjczdGVZWWd3dnRR?=
 =?utf-8?B?amZqSjd5OG5ycGRjTmg1OFlKZ2NKN1lmdlBlU0Q4V2E4UGVHQkJwaThQSE1r?=
 =?utf-8?B?aUdnMGtLMThXM0twNm5GKytxM3Vld0JJdWZXRk5JTHJDRkhoRTVwNGU4bk5o?=
 =?utf-8?B?Sm0yUENESU52RmRjUkdOUjJaZDdBNWs3THlSN3FKOGkvVGFKK1VNeitkTVRl?=
 =?utf-8?B?SVpoMGhVMWUxc1RmY3Robk9DQUhSMUVQTnVHamRwRmNLYVJhL2txMEtnczll?=
 =?utf-8?B?WkEvSDVSNU03Zldvb0dBb2tCUUl6UFlPNzhBZEQ2L1RBNW9kRys2Rk5TSjJt?=
 =?utf-8?B?UzllT2l2cUtvbkhMbmw5dCsvVjdPWTh5RGFxS0Y2WnRicEV4M2Y1WGtiZXIy?=
 =?utf-8?B?a1lwaTgyMHoybVZiM0NOWVorSFI0dlJzY2VXRGdNcUpROGlxQkd5bmdiSnZP?=
 =?utf-8?B?RjNZczlmUEJTTk5VODVsVWdvTnduY1V6UW9HSS91RnFWRXhuTTk3WlpqOE1C?=
 =?utf-8?B?Y3o3dzdYaWsxeEowYnZzU3F2VUtXbEhLK2NoVjVLenM4L2RkLzFmMTZ1eGx4?=
 =?utf-8?B?a1NxTkZuZWFWSGdOY2dHellxVDVrWDBrYmJEVDk3a0JpQ3lIK1o2NmZjRFo5?=
 =?utf-8?B?RkVhQWxBeEFVVUxNU01PQVM3MXFqRmR1OXp6WkpJekloN1h2UWJ3dVlmNVRR?=
 =?utf-8?B?QzZxQm5xc1AzSTk4YWV3YVdXMEh6WDhvaXZPcHFYdzZmblVYYjJqNU5IaDBM?=
 =?utf-8?B?d09Qc3B1cVI0L2NqV1MzODViZVM4WEp5TFk0dmJZZ0ZGOWdXNWNwRTU5MFZV?=
 =?utf-8?B?VDJLNFV0QWZyN1NjZUg1YWJHWlo0UjQ5VTRyY2s5cjFweXNWN2xCZTNGYlli?=
 =?utf-8?B?ZjN3VERMeGgrVTRIbEVWb3JLclQrYkpjLzhmazdLU01GZXp3YWFFZVJSZjRi?=
 =?utf-8?B?QVZlNnc1MUdkb0o2cDRoQlFGdHp0akl4TVhlQk8zQytUUnM1TE9VZ3k0c1FE?=
 =?utf-8?B?QzNWTWNaTVgvRmZNZFhTVk13dlNaaVFNNUdSbk9MMngzSU4xQk9odjRkWEY1?=
 =?utf-8?B?V1R1aWlxTThtSTgveVdEWGNJNmF6eEg5eFZjOEsrY2t3d0luS0hROFdGSTB1?=
 =?utf-8?B?M2UyblVFYkNzZW11Ui9SWG5lZklsazR3aEVrTm15eDBhZm4vWjdaQWp4NVdV?=
 =?utf-8?B?N0lEdEhTRmVHci9PazdzbU1BYWJWbjFRLzdoQmgydXlwQjFQNW9hclduOW1H?=
 =?utf-8?B?MGhCWEFabmoxbklkUUFzWVpOaVNvSTR6dEQzKzZUaFU5bGp2OTVKbWc2Wm1k?=
 =?utf-8?Q?XWbY+fFigYEqu4+4ag=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWhPSm14V1hTUytiVVpIQnJHM1M4Q0tta081RmNqaGYzT1htcVR6Mk1CbFla?=
 =?utf-8?B?WjZLV3VwTUpQVWF4eFRhVGswR3NtQSsvRENFSlQrMVJWZEVCblhWUlozT241?=
 =?utf-8?B?RkpnRHlGYkZwelJpRUlUNDNhVTh3dVVEcHg4dDV6by9iQVcvL2FlaVhZbDdG?=
 =?utf-8?B?ekJWTTUrNmh3MkZJRWIxWXNVZnhuOVZxelE2U0lEUFZhdFgzMnVoYTVKRXlk?=
 =?utf-8?B?dHVMMWhURG1tVnMwcFgxVDY5UDJDd2NXWnNPRDI0dTlWMU12dWIyU0F3RkJ5?=
 =?utf-8?B?YjdyYUk4amlqeXdxdDJZUk0vVXVhTXBMQ3JnZGFxQWNhbnhTSWRhWXhBUFVW?=
 =?utf-8?B?TlF3Z0NHZndTdTdWdmhaTHFtTHh6eVNNOFI4dHVmRTl5N3lhamd1QWtYTk5Z?=
 =?utf-8?B?WlRqRkZpQ3BKK014Y05oME5XOVJZbzVLb094S05iZXhEbHg1bEpzdVlQWm9p?=
 =?utf-8?B?cnRsMngwaVp2emdiL3RiNlVNTVhOdDVwaWhxRDFlemg0czVGTlFlK1R6L0lQ?=
 =?utf-8?B?dHRnTlBoZHJDTW9nWXNoUHJZQTNETURIZ2pyRFh4dHdBekNYSE01OEF2Yk96?=
 =?utf-8?B?dmVRZm0rY1Y1YW1rK292TWRBTGhNUU5BN0JLU0czd3pPNEszYVFrWmRsU2xs?=
 =?utf-8?B?U2hwR3BsOEVlQjJwL01wMGxnR2RnQnhoRGFubU00Zjl4eUlTUUVleHRaL2Vj?=
 =?utf-8?B?dGQ0c0RiMmY1bzlkWktrcUxXRTBXRGZaR3hLeU1EekdXZnpoN3VSVk9OMCtW?=
 =?utf-8?B?dTlPNUZtRGVLNDErMGhXQnFsZm9xdXVwd01nRjJQR1dNclFsSWNWZyswUzJK?=
 =?utf-8?B?VUQ1Nkg1MUhOMFVqWGxFdEc1SXp5K3JlRHZCdVBmbC8vZmNrMCtQTk5jRERo?=
 =?utf-8?B?aE53emc2R2h5NmRyaVQxZXZnUmVLczdRc28vQW5EeHNJa3hzQWpUL1VPSkZ4?=
 =?utf-8?B?bXlrZFFPYk5wdEpmMEZ5dzZMVlUwd1BJTW9GZWVnTzNKRHkwY01MS2g5cHAr?=
 =?utf-8?B?b0gyMCtCby8rY1hjWXFFOEFrL0NQNVZrSy8xSFZtcGErU1lySzVXanc1VDAx?=
 =?utf-8?B?Y1l1RHFmdEhwT0pVVFdHeFVaTE5nUjdjdFNIcjJTRjJIcDNJampZdWdCekE3?=
 =?utf-8?B?b0d6Um9hNjVEaS9ESVJjQjV6aXpYWktuYWlRdi9FemdyTEhnaWFlOGZTV25z?=
 =?utf-8?B?WEUraWlSeXkyaFA2d3FaTmtweUZ3L1RYZkdUZ2JiUUJoKzFJdTQvdkFENFMv?=
 =?utf-8?B?aVIxT09QK21MTjhTMTZBaHpycUZKY2EvR1A3MVVKTzRKc3N5YWpESWRqcWJ4?=
 =?utf-8?B?Qk9CTEJUdTB4cE95YU1UdDJEQU8xTVg4SWZFZUJDVys5YjNWRFFnL29yek03?=
 =?utf-8?B?Uk9YR0RDN0ZTL0ZIZnpOaC9KWVRVNDhyVEZSV3dwemFPV29hNU1PTDArM3Z3?=
 =?utf-8?B?aHNlWmY2d3VYdzVCazZCZmY2UXVPWm56MktaNExqNkRSWXlqbTA0Y0NtT1BY?=
 =?utf-8?B?SFBMcU9kZHlVQkNJOUhJMkU5UW5vUzlFc2RMeGtUMTdFb25hK0VPMHBhVWZs?=
 =?utf-8?B?ZU5jbDMyTGR4clZqTTBCR0tMdTZrQzZzRU9laWIwZzluN2t1eW05WVBxbGxv?=
 =?utf-8?B?aEV0YS8zeU8xOCs5RllFdjNKQXplZGp3TkhiOWNEcUE4eHF2S1JaTGRidWtl?=
 =?utf-8?B?a2VKZHZNVDVQTEwxWUMxdlVPTEpVbllWN1NqVkZwMkUybGFPQUVCanFoejRR?=
 =?utf-8?B?VXBGQW5nUXJDOGpxTTlFZUd6NFJTeFlwQnFDZXlVQmZLOFVGaDMzSWhPa25T?=
 =?utf-8?B?UFdIT2xIYlZmMnh6anQvZzFqMThOdWR0NTRncWhjUHI3KzUyTWVrNis0Zld5?=
 =?utf-8?B?a21VbE02NnIyU0REekRraDFiSURoRTZkNkQvVm82Mno5T29MNHl6MEpxMUNN?=
 =?utf-8?B?bGk4VDFNczA0Uzc2QW9hY0x5N3VMTEVoT1Z1cHpsa3NVeFljTGpVdXZBVyti?=
 =?utf-8?B?ZHhoWHhpbHQrOERjMHkyWFh2V20xZE4wYkNCNFlxTXdPWXdLKy8xNVV3bEJt?=
 =?utf-8?B?U1lqQ0Z6N2ZNNDJvV1RZZEZ1MXNqNnRzUVkxTUY4Mzg3cDllSDNSTG5xZ0RR?=
 =?utf-8?Q?aa9FhcNBiONVJRXNWnamYpmhv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee842228-b655-467e-c881-08dcf9ecb8d8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 20:43:48.9914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m0zHTKc6pGa3CA4r1ef/P7cybZJWT3Xa4UpPwfyU2dXtgSffUPAhhYIr3tHOvAghPgMCwAZuGPnt54eYv4Ymw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8035

On 10/31/2024 15:39, Armin Wolf wrote:
> Am 31.10.24 um 05:09 schrieb Mario Limonciello:
> 
>> As support for multiple simultaneous platform handers is introduced it's
>> important they have at least the balanced profile in common.
>>
>> This will be used as a fallback in case setting the profile across one 
>> of the
>> handlers happens to fail.
> 
> Do we actually need this patch anymore now that we have the "custom" 
> platform profile?
> If setting the platform profile fails for some handlers, then we simply 
> display the current
> platform profile as "custom".

Yes; it's still needed because 'balanced' is used as the fallback of 
something failed.  If you fail to write to a handler it gets you back to 
a known place for all GPUs.

Now I suppose it's up for discussion if that's really the right thing to do.

Maybe because of custom we don't even need that.

If I have 3 profile handlers in
low-power
balanced
balanced

IE I'm already in 'custom'.

If I try to write performance and the first two succeed but the third 
fails what's better:

performance
performance
balanced

Or

balanced
balanced
balanced


> 
> Thanks,
> Armin Wolf
> 
>> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Suggested-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index b70ceb11947d0..57c66d7dbf827 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -164,6 +164,10 @@ int platform_profile_register(struct 
>> platform_profile_handler *pprof)
>>           pr_err("platform_profile: handler is invalid\n");
>>           return -EINVAL;
>>       }
>> +    if (!test_bit(PLATFORM_PROFILE_BALANCED, pprof->choices)) {
>> +        pr_err("platform_profile: handler does not support balanced 
>> profile\n");
>> +        return -EINVAL;
>> +    }
>>       if (!pprof->dev) {
>>           pr_err("platform_profile: handler device is not set\n");
>>           return -EINVAL;


