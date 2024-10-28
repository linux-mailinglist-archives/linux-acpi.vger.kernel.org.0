Return-Path: <linux-acpi+bounces-9031-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2289B239D
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 04:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2A61C20F91
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 03:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679E188906;
	Mon, 28 Oct 2024 03:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhshJbJs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467F1422AB;
	Mon, 28 Oct 2024 03:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730087370; cv=fail; b=X8GytPdA6l8WpiU80aqNCXkwCyixaVj9LeRkPcuaGWqVCFUGIr2sM9FRDqfhv4Lgyoy/JLenITX1R7ieKc/lxNP5aLLJ6wkSbwrJFeCtDBgHBJAfJFWVVP6g9yU+1gL80LNH633ZNRFTaVwpMTB/fj5mY7UvUcC68Xwlo1d3ypI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730087370; c=relaxed/simple;
	bh=TsAexFjPB+V8+dOS5d8ZWRp/mkS1rDKaGTx4d7ITDr4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RtW4eWiZOauYx0QWZ66mLKOqUgHJOZjC/qh03ctqs6Eol8T2FLO/Yk54UgI46UTjckm66ocyvOY4RFyVI3y51rHU/jYRcetxFZxbN1mClPIPW1LFyMSHlpwoW+DXp4P98s1G8gdFpFLZIzE0C9s78IYC7H+p0zs6FivVVrSjSxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhshJbJs; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFYHKx7MPKA4B/iQZZ940sWtkRYOIa9jsi6TWbPSpqdQEbCyfeiJetLueh1641rBt6aArSicKYbzfC0DkVgkELIIrSXGDUI+6rk/B/CbeJ0+G1VTtIXye6JFUs4PwRsWcTpP7NB8C5uviQiUYu1qZQQzx3AKTHXGcrpfOdRuIIryQR74diFZ4C+V853JqxCRVstTi6lYh7icxnwqenhN2wEcBR+27uX+14QD1v1wmNm7Ps+y7UEE4pVHBB1Z9gA47x6I2PRA/3qKXeO7/HsHZKfrobOQZ2GmF+TQd5ghR8qFsYBuM+ytyYnrEDheOjTvA8aojouoA7VNi98SQLgSWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRAroteoRTROGdko4p2sTxD4QCrNPHUvLR1uPtpvdRg=;
 b=eVAUwMkDHqrvEqYeMog3BbSlVLxpdeYG9DpKnCW0Fp5bRII9scDDzCJUtjLrOqUXhYzzl9ifqMZLWxNM6199mNm6tdhRGmUqMfTysvhQ3aPP9NIQfEd2xLq/Wv9WqfTTE2zy3GI30e2kBDI/d8XHb1xOPtHcq8O71SAhvhERlMwUrwtelU0jF91Jrsk1D5oUbT1bleBO2imgrOEjlk+b0BgrVOidX2zlEdIacAVpj2bDcL/JFPkGTsNY16RQMABbeR6MXN+zy11TvHNtT5WeKf+bfADdRtXWe75cgL60RkrK5WW/VYDI4k3AzBeB+ABA3NWtqIhlHgtPZcgMXcx09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRAroteoRTROGdko4p2sTxD4QCrNPHUvLR1uPtpvdRg=;
 b=PhshJbJs89iFLTm++lmL3uRh+645oQ/77DJTXOva+u65DNMwYfxqKp/C47uooV2HgrvJh3iazvaMo5YURQ7jfv27gxzafDThMk5VB48DTUg872IoV4Xy63Y0Am8bmVW488bJeXm5lzM1iXWxDHNKbOdfuI7aI5758WXLs2ikfeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by CY8PR12MB7489.namprd12.prod.outlook.com (2603:10b6:930:90::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 03:49:26 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 03:49:25 +0000
Message-ID: <20e11ae0-988d-40ec-862c-fdef2dcfcfb9@amd.com>
Date: Mon, 28 Oct 2024 09:19:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] platform/x86/amd: pmf: Drop all quirks
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>,
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
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-16-mario.limonciello@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241028020131.8031-16-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0035.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::8) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|CY8PR12MB7489:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db911f9-0ca4-4bb0-cbed-08dcf703843f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTI5VTBQSlFXOGxPM1MybENFOHdQdnhsOFF6ZkhhWFJHem5OczYrRUF1MXZq?=
 =?utf-8?B?RkVWalhrNHg3amxhUGRTUE1LcElsMmw4T05YeWVGc2JMcE9YS1RjM3dDSWE1?=
 =?utf-8?B?RDA3Q1lYbW9FeFRXK0JrNEVPWDRMYjcveEpwbWoxVGRNM05aRDF0cDFMa3li?=
 =?utf-8?B?M3lWMlJUVzNSMHNtQjZoeUFRZDRTTi9iNDFYTkk1MjJXY0JPZWpHb3Z0QzVZ?=
 =?utf-8?B?RFR1eHZsZ2lubDlveWdkVVJ5QWc5QjBUejhSNDZxOGJaWC9iR3IzVkJzdUNP?=
 =?utf-8?B?YmJRUW1MeUtaODB1VFZJaURhQ0txT3VjSkRJeVdFWUpwL3FyT0taTWZxd0Y5?=
 =?utf-8?B?RXY1eXh5VVAxcno4K2xja0JvaE0vOFV2VUJKbVJVMVQrbHNtdnF4eTM1dmty?=
 =?utf-8?B?bzR0T2FqbW5PVFVKS1YrcEhrOWlaWDR5Z2JHVVA3dDBkMW1uYzJZcHBCaWtE?=
 =?utf-8?B?a2ZPbGFYcWd3M3hBK2V1SFlHUmw3bGp0LzF6Zm9ZK3dWQzRrYzk5NnAzcVl2?=
 =?utf-8?B?Y0Y4MFhXaHEzaXRjeFMyOEx6KzdOdjlseUcvUGZyMlBBRUdKMWIwQ0ZaaVNq?=
 =?utf-8?B?Y2VOSHJBZUl3WlpET1pRcnoxRWd6RWVKWTVpQ2NHWVhWM3BNd05jTU5JYzVF?=
 =?utf-8?B?bUhDWlJjOU9XUUlZMVhOYUFMdC9IU2VmeVVqcUJLc0wra1JtOVVaclFoRzJI?=
 =?utf-8?B?a0xHQUpZcVNjZ0psaXZaUHdaMVRrVE52dW9xUWRzUWhjMm94cFNwV0dBQzRI?=
 =?utf-8?B?SGlnSGYvRm84Y08yVUlsb05UK0dmRFkyalFIekt3T2xDRWZMVjZ5ejlqVlZE?=
 =?utf-8?B?NGpXWGhMZG43VjY4aTEwV1BrSE1yMXJjTUJES3ZuS2lSQVhrT2hST0RoYkh0?=
 =?utf-8?B?bFoybmUvTVNwU2dIN0ZIQXNTZHBzSWlvRzU3UGJ0aW1WMEc3ZzV2cno1ckFq?=
 =?utf-8?B?TFpiS29qdGFmT1NvODhjd0o2Qk9Rc2sxV2tjNWtCTzY3UUdnaFRpa3E3cGZL?=
 =?utf-8?B?Y3l3U29zUGFESCsvazN0M3JZVEh2VVlXa0xXSVd6c3cvY1hGc0UzZ21yd2tP?=
 =?utf-8?B?SElYeGp0c2NFWk9BZXpyL1BZNE1KSmRRR1J0NzlnNUx2WEhGV1ZkODhoWDVw?=
 =?utf-8?B?V0NXSS9nZ2N0ZndkQ2ZLcVNMcWpVNjJwUDdxV3VwL3RCUy9kZVJLeFRqdVNV?=
 =?utf-8?B?NDJhRzhST2pIdGRjTmJkTXZXR1NreFJZMGlsb1dZTHF0WHhIbThDUDM0dk1P?=
 =?utf-8?B?RjdLckl5SlFQMEZ0RnFBMnN4b1o1VXJ3dDdvS1VwWXUzUndYVURSWkVEWXp4?=
 =?utf-8?B?SC9tRXFXUjBoQ1gxS1p6ZmVkTVY3Q0ZZZC9PMlhyUUQ0VGhSRjBHWlNnNWJB?=
 =?utf-8?B?M2hTeThaZHp5bHk3cDBTbEw5cTJOWWJQSmt5QzVOZGtJN29DbjNJM1ZhQ0JF?=
 =?utf-8?B?TlpWMlBlYmRUbHZPQUdZdlhtTU5KTXFJM3Z0VUYxUjFsdlBGYzBMRFpmTjlP?=
 =?utf-8?B?Yzd6L01Wbm9nYTBDUTlJTkwrS1pZQXQ3TGFKckczSFJTMWdHQ2puSlV2bzNp?=
 =?utf-8?B?VkhzandyUW9kT3F1bTQ0K3haYkwyd1VpQUx3OGhCTllBZEdlSGhFRTk3LzFN?=
 =?utf-8?B?dXFXQ3hnUWIzWlY5TFR0b3YwaUg5bU9hdUVFWEU4a3hkTU11SDYreUd5RzlZ?=
 =?utf-8?B?T242N3lZd1RISy9WeVk4d3hXQVhVS2g0MlhHSmlFaWkrOVlZbkNNUnhxVVZm?=
 =?utf-8?Q?Ko/bpbV6kjrvW3nXVZIs0zk3J6Qn2hWX+k7AJ4P?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDBBaXY3U0ZyektDdFdJZEpKMmhNVmVWejArN3FXakJEdzJ6QVJLbCt4STlI?=
 =?utf-8?B?aWtodm5ONUtSWkZaZjdjSjJXUzJpOU1XTzY0a0hON0hzbkdpam13TFFMUUdh?=
 =?utf-8?B?UU8vQWpaN3h3QXF4d2RhaDYraTg1c1dHeGMwWm1weDVJem9Pb1lUV3NENDIw?=
 =?utf-8?B?TzRwYVBaU3JFNWJRYlJqZnF5TnVGSWVlcm8va0dIcVJHK25MYTMrL3B1NU1Z?=
 =?utf-8?B?RXZaSks3Tlo0RHA0KzJyK21TN0doOE5VUkdBNXVYL2xOblFUaERHc2EyMVJZ?=
 =?utf-8?B?R2loY0wzMHpCdlBiUk9MWXQ1ZXp3eitKOWpQakZBY0JpOTlhL3VhTG5jVVdH?=
 =?utf-8?B?TjlRR3B0czIyNGIvOVp2dUI4WjJUekNOSDA2dzhTNVhDMk85ZWdWcUhTdzBq?=
 =?utf-8?B?akJqRmV5OVlrTUt5UEdWMXhNMGNDQlZFajhmU0tmNVFwU054S2J6TXgvU3F0?=
 =?utf-8?B?bDJadnRZZVRvcjZhdEtaM3RNMzlveHFobGp2Wk1kRTAzbThQZjNFSmgvWlVh?=
 =?utf-8?B?MkxQdWRBb2ZBb0QwOHhBWG9WQ3k5SExwYTRKdVZhRjNHM0F0VlpzK1lRRStP?=
 =?utf-8?B?TkRqOExvakx2dE04Sk5nVHhUa3Z6OTB2ZUNJVVNZQlYrNXlkSU5UQkdScTZ1?=
 =?utf-8?B?b0JpSVZDWFY5dXY0Y0c2L2FQbm14QnVoeS9JL1l0R1lHY1pOcXhTdFBETnZP?=
 =?utf-8?B?bWtNTHhUY0cwRHdlZzQzUXdrTEFtZklacldjSllqVmE5NEY3NElRZmxpRDFr?=
 =?utf-8?B?ZDY2Z0h0eXArbVpkQ0V6S3J0T2dSYkRubG5QbnhmLzR3OTJVQzlOaFpLaXJp?=
 =?utf-8?B?OEJnZG4rQUFtODcxOGZRM0tpN05yb3F5bStLRVcvK1QrSjVEd3RtK1JzTzJI?=
 =?utf-8?B?cExubjRUeEliU3N1Vkc4S3ozdmRXbHNnU3NkQ01vMWFzaUQxWmh1Z3o1ei9E?=
 =?utf-8?B?TWtUVGxLRzlGT1JoQ3Y4L2dVZU1SendQSXNSVG9IRWttdHlMWlhrMStDUzVm?=
 =?utf-8?B?N2oxaFduVlhSVHRFT0ROcTIrYzdid01oNzhqRTY2V1cvSklWV1VWbXJSRXpI?=
 =?utf-8?B?dzdXV2NQRDRpRHFDdEk0SGRNTU1FTHlYaGdIWkMyWXZqYis0aDdrcVJGZ3la?=
 =?utf-8?B?SE5EaWZVTm9UMmpxa0tPRExWQnFwZG44dWNUbnVvWmdBZGZ6dmNBenN3WjVp?=
 =?utf-8?B?OHJQb3plS1hpSW5oQ0hvejA2L294RlEwWVBrNXRwc1kxRENyb1h6UzdSdTBS?=
 =?utf-8?B?NXVNQkhIc2lZMUFLRUp5YlNmbXJSazRIeHpXVWlqajd1WjdhY2VZOVJIamFN?=
 =?utf-8?B?TnYvMTlUU2gwamxDM2FZSlVlVjUvWU8xdDN6YmFzSG5EeFVHN1JIeEg0cUto?=
 =?utf-8?B?ODFEYWVNR01aeVZjNWhBTnNOYllIa3hQWHo1dFV4S2VVYS8zK0lQZC9HMGF5?=
 =?utf-8?B?cy9ZVFMyaHNuc0xYOFZ6R01tN0hTZTVoSWVzMVkrMTdwZ0FtSXhsY2RvaGgr?=
 =?utf-8?B?S2VoNTZRWlFPdk1HcWE2S0Z5QkQ1NVFTVlhPZjYwZUlPVU5TazFXV0NsYk83?=
 =?utf-8?B?N0pRQzY4ajE2b2Z6c0VGd0hVU0JtOUp6RnFlblZpV25idEtscWxQYWJqSnlR?=
 =?utf-8?B?UlQzdHQ1Z2JiVzBKZ2wwbXVvbDlveWptdGNzRTVlUVBicGg3NEZjMDJOb3Az?=
 =?utf-8?B?U295V3RoZWRlSEFTdU81eEFSREdoTVFBdVNGVXFJYWljdXlBMmZYNzVCZUoy?=
 =?utf-8?B?b1I0SFlUU2VOaXNjaG9MakQ3a05mWTNadnUyTEMyZWFNNkpWd1cxVThNRnUz?=
 =?utf-8?B?TU1IdElnay81N0p6cWNUNGNVeVB1a3FBZXA2V0tYbkI5TjcvcUl1L3E0bVBK?=
 =?utf-8?B?ZlREZnpCdWJneU9NTWswSk5PeEtTZXRNYVdGYmZFS3BPYzgyWVhaZmRJbWZa?=
 =?utf-8?B?aFNJeWRTbkEwQ25KSkhJUnZrYllralQ5L2ZGUUdkSThCcjFIQUpVRm9LcGp5?=
 =?utf-8?B?V01xNXpyVytCRzZVcDdRcWxlYTVnYnc2aFo3dk1ycVdVaUZzWDZTNDFhTkdP?=
 =?utf-8?B?cFhKMjdvSnlIY2lJK3dyYUN3aEtrOHU2UUVaM1F5aXFFNHpSVmN0YldQRnd1?=
 =?utf-8?Q?AacUiOGEp/6BpJiRR5H1BFfGZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db911f9-0ca4-4bb0-cbed-08dcf703843f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 03:49:25.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rRvunxp4HsJJe+QMlKJ2FX1O+kBwq4E7yA4ltARtDrG2l30C6bTQNaZQWH4BmFu7aPAsH4zQd6vyg2H4ARq9Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7489



On 10/28/2024 07:31, Mario Limonciello wrote:
> As multiple platform profile handlers can now be registered, the quirks
> to avoid registering amd-pmf as a handler are no longer necessary.
> Drop them.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> ---
>  drivers/platform/x86/amd/pmf/Makefile     |  2 +-
>  drivers/platform/x86/amd/pmf/core.c       |  1 -
>  drivers/platform/x86/amd/pmf/pmf-quirks.c | 66 -----------------------
>  drivers/platform/x86/amd/pmf/pmf.h        |  3 --
>  4 files changed, 1 insertion(+), 71 deletions(-)
>  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c
> 
> diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
> index 7d6079b02589c..6b26e48ce8ad2 100644
> --- a/drivers/platform/x86/amd/pmf/Makefile
> +++ b/drivers/platform/x86/amd/pmf/Makefile
> @@ -7,4 +7,4 @@
>  obj-$(CONFIG_AMD_PMF) += amd-pmf.o
>  amd-pmf-objs := core.o acpi.o sps.o \
>  		auto-mode.o cnqf.o \
> -		tee-if.o spc.o pmf-quirks.o
> +		tee-if.o spc.o
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index 47126abd13ca0..6ad00b3d472fe 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -455,7 +455,6 @@ static int amd_pmf_probe(struct platform_device *pdev)
>  	mutex_init(&dev->lock);
>  	mutex_init(&dev->update_mutex);
>  
> -	amd_pmf_quirks_init(dev);
>  	apmf_acpi_init(dev);
>  	platform_set_drvdata(pdev, dev);
>  	amd_pmf_dbgfs_register(dev);
> diff --git a/drivers/platform/x86/amd/pmf/pmf-quirks.c b/drivers/platform/x86/amd/pmf/pmf-quirks.c
> deleted file mode 100644
> index 7cde5733b9cac..0000000000000
> --- a/drivers/platform/x86/amd/pmf/pmf-quirks.c
> +++ /dev/null
> @@ -1,66 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * AMD Platform Management Framework Driver Quirks
> - *
> - * Copyright (c) 2024, Advanced Micro Devices, Inc.
> - * All Rights Reserved.
> - *
> - * Author: Mario Limonciello <mario.limonciello@amd.com>
> - */
> -
> -#include <linux/dmi.h>
> -
> -#include "pmf.h"
> -
> -struct quirk_entry {
> -	u32 supported_func;
> -};
> -
> -static struct quirk_entry quirk_no_sps_bug = {
> -	.supported_func = 0x4003,
> -};
> -
> -static const struct dmi_system_id fwbug_list[] = {
> -	{
> -		.ident = "ROG Zephyrus G14",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "GA403U"),
> -		},
> -		.driver_data = &quirk_no_sps_bug,
> -	},
> -	{
> -		.ident = "ROG Ally X",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "RC72LA"),
> -		},
> -		.driver_data = &quirk_no_sps_bug,
> -	},
> -	{
> -		.ident = "ASUS TUF Gaming A14",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "FA401W"),
> -		},
> -		.driver_data = &quirk_no_sps_bug,
> -	},
> -	{}
> -};
> -
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev)
> -{
> -	const struct dmi_system_id *dmi_id;
> -	struct quirk_entry *quirks;
> -
> -	dmi_id = dmi_first_match(fwbug_list);
> -	if (!dmi_id)
> -		return;
> -
> -	quirks = dmi_id->driver_data;
> -	if (quirks->supported_func) {
> -		dev->supported_func = quirks->supported_func;
> -		pr_info("Using supported funcs quirk to avoid %s platform firmware bug\n",
> -			dmi_id->ident);
> -	}
> -}
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 8ce8816da9c16..b89aa38434faa 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -795,7 +795,4 @@ int amd_pmf_smartpc_apply_bios_output(struct amd_pmf_dev *dev, u32 val, u32 preq
>  void amd_pmf_populate_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
>  void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *in);
>  
> -/* Quirk infrastructure */
> -void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
> -
>  #endif /* PMF_H */

