Return-Path: <linux-acpi+bounces-8436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA440987176
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 12:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971C32839C9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 10:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC171ACE19;
	Thu, 26 Sep 2024 10:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xJYsR13B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9710F1ABEBC;
	Thu, 26 Sep 2024 10:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727346349; cv=fail; b=RUUeGYPCrzjOtH2kSZcURNtqWl0T4uPi1DdR1QFndSl4X1jQCB0M7CzScDDFuLRe25kp7L7bKfK/hDWF+ElvKG3z7pOKfLdJW6rRp4ObqIz4BFrgNu/SPFYQrlJZhvgOHfIeZYzUUsZbOYcX7FAG9ayhBhcFwtHZ8lCo6SYF358=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727346349; c=relaxed/simple;
	bh=G7k6scg3aoTJeIBCL14NUYl3LwVwh8w41wyh5etzQM8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OM/XTVP/rUFd0OwertYAMl6mIh4n0LS3fzPHQmvlE+r2Oa/t4cAjQPX7U38j/JqE8EUtvhec+e7TWHzX/KF+LkEaA2EfL9VvzkgOM1smi8egUOzuzsFvsz09CrPgBEL6DF7M+GKEDoRhJmAZQJikPCnLWM8cYa26uAu8zJ26oZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xJYsR13B; arc=fail smtp.client-ip=40.107.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yLfppv60q3FFWkPHp7xJqfe7B1PNrvEsYH+Hc1LWAUAtVv75WcsXOl2lca0HuXWp5EwEptOe0JVp+QDIhG1bjwLyTMbarYZTgFGQKbeWsQN+NseqXeYGA2uoKKUbwW31o/Op0qnO64DBdb2D7jZNKwlezKnEwbzrKLgj6uSIlAnnAk+az3nwUiOSqNcQh9BuoT+wlC9yh6ZzQMeNPbAR/muFEb1Bg6GfQ6EyDQDVHAOPYvSjbWB4WurykwgKjUKdMeegBYkB54HSQGxosDSQiDo5IAg+2Tnj8TEZQ5HZpk5GI17T3fBwUeKQZB0P6vBFQc8o7eW7SIaA509d+zdhYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlqbRjB/wibfcvQg5+MP1UVjq5rFwcklKzvJLigozYo=;
 b=QZwHE0vytNrWvtCY36XUIEK1Vf2zvj4/l4PvM9TpWMhnGdbzUqdFk3bxZZnh0VbHv4/AM0Xbols0SFXI47m/o4/xi9MHJwlB/rAHEH3EnX3xzKgTUHoLxUK5Yv0s78AcAvM95/JAeXzwSzfCfT9hP+64678rN/AeQ4VzszVdJfGrzgxMaXxQ+L/IcUDNUlOw+uUeBpJq0cZZKxNXluybFpNss3b42p7/Qhpnn8g38eLEZXb+D2GfWp7nd3Ok6eKjnkp3zloISeFRqfTXQgZ1918jTlxDB9tjIiRhW7F0UZH3jmNPMTcRr5ySwApARuUWwxFVzndkb/14QZZtkypUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlqbRjB/wibfcvQg5+MP1UVjq5rFwcklKzvJLigozYo=;
 b=xJYsR13BptpeX723/0Cfe8oOA0UVkrWuBJkt+gXRVwWFnwkZe+h8I1VDUR4Ldm532UxuAgNj8MThJkxyQJ69PFYKcVbxDxAkBj+Oh0Z/OJ7PGXHFslPKaJgcbS0ahectG9O2AaDUwKpfE3EZ8Sj9yxhM/pBNbsv3rlAoCxqpMmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by BY5PR12MB4113.namprd12.prod.outlook.com (2603:10b6:a03:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Thu, 26 Sep
 2024 10:25:43 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%3]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 10:25:41 +0000
Message-ID: <5a75b73f-dcb1-4a45-9526-194a3451b5c6@amd.com>
Date: Thu, 26 Sep 2024 15:55:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20240926025955.1728766-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXP287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::36) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|BY5PR12MB4113:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b6089c-05ef-4a5f-4cd4-08dcde159290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW1pV05Ib3pEbHMrMzZ5TXVSUVZZS1RkTi9NWXdpNVRxYjVQc0FHamptNUdM?=
 =?utf-8?B?K1ZVd0hySHlueWppbGhYcGZrZCsrcTJ2ZjlSNG84dGUvL2dtYWU3TnFBN0xW?=
 =?utf-8?B?NGdIei9sMFlBNGdPZ1Q2V2xzckpzTWdaeGhWR0Z2WllCZnM4VmdtdDBjL2Vv?=
 =?utf-8?B?UkMrbGhVaEFtNjJ5ZGVuK1JYb3UyeTRMSk5wdWhGNFJpZUZPSjd2L2EvWVRD?=
 =?utf-8?B?NksxK0lKeU92OHFwOWFHVi8zRXBsTTFCb01xMCtMaVdPNWZmUEFqdzlTaU5V?=
 =?utf-8?B?dGV2RWJrTWxRS2QrRGhFZW5MaFFYN1l6VzZPZjhuejU5aVltREVKcXFQWjJ3?=
 =?utf-8?B?WDNranVGc2VCWGhrejhPZnA5MDNiOVlvdCtLbmJncUdJZHFIdlNuMGIwZldL?=
 =?utf-8?B?Mk5HV0lZSEwvSDFqR1NmTis5NTUwYmZlQ2F4WlFmdVJvK016eXM4QmFXM2dG?=
 =?utf-8?B?Z0xNT0IyNDhSRzJZSnJHSURJajdJL3BWbnNlWVl0SkdRd0V5dzhDVlBJWk40?=
 =?utf-8?B?WjQ1VVNPb2ZNaVdlRkgrYTRJalBGSTkwR05mQ3o5TER5a3JCQS9LZDZvd21E?=
 =?utf-8?B?aCtBdkJnZWJYd240MHY5Yko5N3VVVjNWbHdhd25MWG1aTzFGd1FqRHdlQkFy?=
 =?utf-8?B?bHdiVkZWbWd1MWF4c1orb0ZsNEprNkZEZHVEUkdFS1dSejJyZkhhM1FVMGNH?=
 =?utf-8?B?eUJLWFJ0cGtyN0Zqbkh2Y3NMWCtGOTVlT1J6eVNkcWxoRWZFOVpiY3Iwdmdq?=
 =?utf-8?B?bC8rVUxUUGhGV1hPSU1oR2FFK3JYa08zcDlYbHFEWExYa2tQaTBLYUFGWTFS?=
 =?utf-8?B?dGtPdEVVSHpFOGZnV2gzMzI2SWVMa09VWVZER2Vsbk1zWEZza1FpVFVPZ0dH?=
 =?utf-8?B?ZkNzT0pXRVNFSnlPU041ZzRub0ZEdmV4aWliaGxhMHgxWmVqVkFMWFpYUnhn?=
 =?utf-8?B?V210VXgvUHlMRVAwNDl6S250MUhKdWZlNkdiYm4zaHBxTGlTQ1QzM0ZuakZB?=
 =?utf-8?B?V2xXa2pYRFRTYlk2MWtERmFlZkVZUWViUlBybEd1UE41VElZSlNwV0RDRlQv?=
 =?utf-8?B?TFJuOFBKUGZBN1A1VURVWk9TdDhKNzNaYzJYZ3lBbnB4MFNYNnpLVnNMVXRZ?=
 =?utf-8?B?eFNYd0p4WXRseEczQTJPMCtqZkxZdm5VcFBWWFd2dCtkNmxqOGRzU0VWblo2?=
 =?utf-8?B?K210bUlZbncrM210ODNUeDJrSEZNZ3JZM1ZhN1IvdXh0OWJwd0RmWUc4dEc1?=
 =?utf-8?B?RkZyQkNPa2padVJIaE9OOXRTcjRJMlpSTWlhVzY2WnIyQ3loYXFhSFdpNmpD?=
 =?utf-8?B?Q04rN1hFWjNCS3BkNm80YnZveHlzM3c0QVpqSHRVMDIwdlpCclMzZXRlNjRC?=
 =?utf-8?B?dkZuSFBxNlIvN2xQN0F5Ty9odVlwekZjYnJkbkk0QXZNbWdXTGd6T0dQaGNi?=
 =?utf-8?B?N0pLYTRrajFJSmVlN1VteStCd05INGJ4VkpBaVpWYXRWeHBEVTFlMDZqMDlk?=
 =?utf-8?B?QkVEZmk3R3JHMHlETXQ2Rzlaa21tZWswbTgvU25tVy9uNE8zMy9GVlcyODRX?=
 =?utf-8?B?RkFqMXlwejIxUFVzSDBEUUNuM3FrUTJRdXdBWDQ0RVAyZmhmRVRjTVQ2VnpE?=
 =?utf-8?Q?LRX09TtHIKjZnPoKCLqcMjhp+p39FmcteGKUUjZXlKh4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVBWWWRKMU5vOWxiR29CMGxLY3c5MnZXcXVTQjhvVWs2V1ZpQy9wSUptWWJ3?=
 =?utf-8?B?ZExTS3JFT0VWWi95WWJyYkgzR3hrV1JyZURva01rSWN2R3IvZWFhNWgvbVZS?=
 =?utf-8?B?QmdYZGwrZzZvbExOMTd6b0VYeXc4dTdOVzJ0c3lyOW0rU1FLbXNQeldPaUI5?=
 =?utf-8?B?Rk5qaEhVQ0dsTXNpaXBGZ0VFTlBMTnhsb3ZSei9GSGhBQVlPaW9saFJJak1s?=
 =?utf-8?B?R3Jlei92NllkNVVVV2xubUpScHFJME0zeDNRMFlRWGVFUE5DR2tOM1pQZFVS?=
 =?utf-8?B?Z1h5SGNoUEpiMVdjU0FkTWNYaU9SMDZVUDZkQy96NGl5aXNtR0ZFT2tCUktE?=
 =?utf-8?B?NFpKN0lLcnVjQVp5N0ZjdUx2ZnU2MzFjRWdsSGdHL0lVd2ZnUE93dzdWdWVz?=
 =?utf-8?B?VWhQZkVoWlZEZ3RxOE5tZzhrTUtseGhQeHA0U3czTkVCbGsraDNDRFh2M2pl?=
 =?utf-8?B?R0JIeDI0NTBxdFAzODdOR0FNL3BHbmRUSU4xM3Z2QmtpeVRmUmJzMS84VVNz?=
 =?utf-8?B?SFBSWEFhQURaTGllR2djeEJsRkd2OVl3YmJpQWxCSndRN2lDY3RyK0tzWlB3?=
 =?utf-8?B?NlBNdmtFZFc2dVh1aDNzNEVuWGVCbVcvWFNmQW9xYUZzaGpaSmFyV0ZVdkY2?=
 =?utf-8?B?YmJNbTdQV0FseDFMeEM4MUMybExabmRWNzE3RXhqVFNIT2d0eFVnSWVLa0Z5?=
 =?utf-8?B?MEpxNlhNbitDWGltU0h0QmMwTi9BT3ppZjJnRkZJUU84RDBKanlBK2Zwa1hI?=
 =?utf-8?B?dG9jdjROUmdReERxdmZ3ZU5GMlQ4amxzckJTN05WRHQxcm0ycTIwdVE2SU9t?=
 =?utf-8?B?K2JXZEZtOTQrT2dNVEw1bmpIZThudkI0K200TzJMTjFOK0ZRUlJUWm5RM2hN?=
 =?utf-8?B?dnBVWld5cGluZ2J1bGVOZ3BtYnNoS2xXWnJxWUdrNkROOGhNOC9wSmRnd3Z5?=
 =?utf-8?B?Zk1uSllWV3F6cjhLN08xckdSMHI1MW5xbUhqVUszWnRvaFZFTmllOXRtbERi?=
 =?utf-8?B?UjVlSm5MTEpBRFE4a01TTFVLbWt3c2Q4eFU4eEpOYkcxSFcvNGxBeTB0OUsz?=
 =?utf-8?B?R3JDb2J4NTcvNS9kWUk2TklOeTIrL2dadTRjTzBXS29iWjJ0c25NS0tyTVZa?=
 =?utf-8?B?QitGQkZOS1F1cE0rcEgxZVVQQzhFSjc5dmd5cHNUbEg5RGFSRW81U2JtYjZa?=
 =?utf-8?B?U1B3cW1mY1ZYQmJsd3BpZ1E1N0dFcmE4ZTEybHl3WDNEdXkzeXhZS3ozbjZL?=
 =?utf-8?B?MWlrcEo2ME5hbjIzL1k0R1hKTFJSeFJJQkFWbTJ0Q3lCQXhNaXczYnpWTEFL?=
 =?utf-8?B?cGhHQUFDdnJpb2kzUFUzNEdZcDlTYURmODdGTThRQk5waFI4WkR3TEhTWGlQ?=
 =?utf-8?B?aTJQT2ZYTms2bTVDTnJlaTVaMFlWYVIydEdHeDJPdmgxMS9ZT0wxcFV2akRx?=
 =?utf-8?B?VS9IZTBYRFhFRXRPbTVTc0hVdzhNbjA5QjF4ZXJja013WWVOYUFoUi9pSDR1?=
 =?utf-8?B?eGJXckV3dzlNUDN2Tk9LL2Zob1I5OUJyWWlCOVJHY3JTQVVjYlhyMEZDRzdi?=
 =?utf-8?B?OERqOTA4cjEzNlhGZHEvcXRPcDdPQkpla1pxTXQ2Nno4RVJJaFZDR0wvMGNP?=
 =?utf-8?B?WEM4V3cyTXpvQnoxZHZRNUs1LytMWXBoV1lmNzVWYXcvZ3ozNWhHTXprMm5y?=
 =?utf-8?B?TkdEMEZmSlZUaW5vWGtzalIrRFVQWnNLdjhoYSt0UnNtQUlsSTFJYXl4VFVm?=
 =?utf-8?B?Mk14Z2FtWVoyUFB5YzFKSTVtZ0V4RnBvZ2hIN3V1WURnWTBzMmdybEoxd2x5?=
 =?utf-8?B?Ritsb2RxMG9sTkxvV2E1NGZ6OTNvcGNUcXdSbjkvRWhuckJ5c1hSaklOSTJO?=
 =?utf-8?B?VVBpR0VxNEpqU0dIdE9vN3d0UGNrTTRmVzN4ZDZNT2lDWnEwcGlQU3BjWjdF?=
 =?utf-8?B?cDBnbnJwLy85ajBxTDFKK0F6cVF1QktDVEsyT05sekVncVNtZzdMdWljQ2FP?=
 =?utf-8?B?RUZobVVmK0dva1JLMG96cWJzOW1maDhuTUVEaVZxOWZHTVl6LzJEajAydHE4?=
 =?utf-8?B?SWZydzJSaElUL3pwRG9ZVVIremtGWGo0ckFkNDZhc0ZFaTU4TlRIZXo3TFpr?=
 =?utf-8?Q?Yi0jKOuN29srfXsB/tHXgqfgw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b6089c-05ef-4a5f-4cd4-08dcde159290
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 10:25:41.8182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CmxqHQLb7RmxejIut2gME/O6TmWjd4RTd8GGIxYeLxrM6TYy/COSV5bmsMGK/tezlFM/ok4uvWTCvKf3RjGBdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4113



On 9/26/2024 08:29, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> A number of users resort to using reverse engineered software like
> ryzenadj to manipulate debugging interfaces for modifying APU settings.
> 
> At a glance these tools are useful, but the problem is they break
> state machines in other software such as the PMF driver or the OEM
> EC.
> 
> Offer a knob for PMF to allow 'manual control' which will users can
> directly change things like fPPT and sPPT. As this can be harmful for
> a system to try to push limits outside of a thermal design, taint the
> kernel and show a critical message when in use.

I appreciate the proposal, but giving users this control seems similar
to using tools like Ryzenadj or Ryzen Master, which are primarily for
overclocking. Atleast Ryzen Master has a dedicated mailbox with PMFW.

While some existing PMF mailboxes are being deprecated, and SPL has
been removed starting with Strix[1] due to the APTS method.

It's important to use some settings together rather than individually
(which the users might not be aware of). For instance, updating SPL
requires corresponding updates to STT limits to avoid negative outcomes.

Additionally, altering these parameters can exceed thermal limits and
potentially void warranties.

Considering CnQF, why not let OEMs opt-in and allow the algorithm to
manage power budgets, rather than providing these controls to users
from the kernel when userspace tools already exist?

Please note that on systems with Smart PC enabled, if users manually
adjust the system thermals, it can lead to the thermal controls
becoming unmanageable.

Please consider this perspective.

[1]
https://github.com/torvalds/linux/blob/master/drivers/platform/x86/amd/pmf/sps.c#L193

IMHO, having a 'custom' platform-profile node is fine, but tieing that
to PMF static slider would be a NO from my side, because of the above
said reasons.

Thanks,
Shyam

> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-amd-pmf | 10 +++
>  drivers/platform/x86/amd/pmf/Makefile   |  1 +
>  drivers/platform/x86/amd/pmf/core.c     |  9 +++
>  drivers/platform/x86/amd/pmf/manual.c   | 88 +++++++++++++++++++++++++
>  drivers/platform/x86/amd/pmf/pmf.h      |  5 ++
>  drivers/platform/x86/amd/pmf/sps.c      |  4 ++
>  6 files changed, 117 insertions(+)
>  create mode 100644 drivers/platform/x86/amd/pmf/manual.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-amd-pmf b/Documentation/ABI/testing/sysfs-amd-pmf
> index 7fc0e1c2b76b..6f3d5cbf443f 100644
> --- a/Documentation/ABI/testing/sysfs-amd-pmf
> +++ b/Documentation/ABI/testing/sysfs-amd-pmf
> @@ -11,3 +11,13 @@ Description:	Reading this file tells if the AMD Platform Management(PMF)
>  		To turn off CnQF user can write "off" to the sysfs node.
>  		Note: Systems that support auto mode will not have this sysfs file
>  		available.
> +
> +What:		/sys/devices/platform/*/{spl, fppt, sppt, sppt_apu_only, stt_min, stt_limit_apu, stt_skip_temp}
> +Date:		December 2024
> +Contact:	Mario Limonciello <mario.limonciello@amd.com>
> +Description:	Manual control of AMD PMF APU coefficients
> +		.
> +		These files are used to manually control the APU coefficients.
> +		In order to write to these files the module most be
> +		loaded with manual_control=1 and the user must write "custom"
> +		to the ACPI platform profile.
> diff --git a/drivers/platform/x86/amd/pmf/Makefile b/drivers/platform/x86/amd/pmf/Makefile
> index 7d6079b02589..81444d6f4428 100644
> --- a/drivers/platform/x86/amd/pmf/Makefile
> +++ b/drivers/platform/x86/amd/pmf/Makefile
> @@ -7,4 +7,5 @@
>  obj-$(CONFIG_AMD_PMF) += amd-pmf.o
>  amd-pmf-objs := core.o acpi.o sps.o \
>  		auto-mode.o cnqf.o \
> +		manual.o \
>  		tee-if.o spc.o pmf-quirks.o
> diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
> index d6af0ca036f1..52a68ca094be 100644
> --- a/drivers/platform/x86/amd/pmf/core.c
> +++ b/drivers/platform/x86/amd/pmf/core.c
> @@ -53,6 +53,10 @@ static bool force_load;
>  module_param(force_load, bool, 0444);
>  MODULE_PARM_DESC(force_load, "Force load this driver on supported older platforms (experimental)");
>  
> +bool pmf_manual_control;
> +module_param_named(manual_control, pmf_manual_control, bool, 0444);
> +MODULE_PARM_DESC(manual_control, "Expose manual control knobs (experimental)");
> +
>  static int amd_pmf_pwr_src_notify_call(struct notifier_block *nb, unsigned long event, void *data)
>  {
>  	struct amd_pmf_dev *pmf = container_of(nb, struct amd_pmf_dev, pwr_src_notifier);
> @@ -349,6 +353,10 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
>  		dev_dbg(dev->dev, "SPS enabled and Platform Profiles registered\n");
>  	}
>  
> +	if (pmf_manual_control) {
> +		amd_pmf_init_manual_control(dev);
> +		return;
> +	}
>  	amd_pmf_init_smart_pc(dev);
>  	if (dev->smart_pc_enabled) {
>  		dev_dbg(dev->dev, "Smart PC Solution Enabled\n");
> @@ -485,6 +493,7 @@ static void amd_pmf_remove(struct platform_device *pdev)
>  
>  static const struct attribute_group *amd_pmf_driver_groups[] = {
>  	&cnqf_feature_attribute_group,
> +	&manual_attribute_group,
>  	NULL,
>  };
>  
> diff --git a/drivers/platform/x86/amd/pmf/manual.c b/drivers/platform/x86/amd/pmf/manual.c
> new file mode 100644
> index 000000000000..b33fc3cd8d61
> --- /dev/null
> +++ b/drivers/platform/x86/amd/pmf/manual.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * AMD Platform Management Framework Driver
> + *
> + * Copyright (c) 2024, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Mario Limonciello <mario.limonciello@amd.com>
> + */
> +
> +#include "pmf.h"
> +
> +#define pmf_manual_attribute(_name, _set_command, _get_command)		\
> +static ssize_t _name##_store(struct device *d,				\
> +			     struct device_attribute *attr,		\
> +			     const char *buf, size_t count)		\
> +{									\
> +	struct amd_pmf_dev *dev = dev_get_drvdata(d);			\
> +	uint val;							\
> +									\
> +	if (dev->current_profile != PLATFORM_PROFILE_CUSTOM) {		\
> +		dev_warn_once(dev->dev,					\
> +			      "Manual control is disabled, please set "	\
> +			      "platform profile to custom.\n");		\
> +		return -EINVAL;						\
> +	}								\
> +									\
> +	if (kstrtouint(buf, 10, &val) < 0)				\
> +		return -EINVAL;						\
> +									\
> +	amd_pmf_send_cmd(dev, _set_command, false, val, NULL);		\
> +									\
> +	return count;							\
> +}									\
> +static ssize_t _name##_show(struct device *d,				\
> +			   struct device_attribute *attr,		\
> +			   char *buf)					\
> +{									\
> +	struct amd_pmf_dev *dev = dev_get_drvdata(d);			\
> +	uint val;							\
> +									\
> +	amd_pmf_send_cmd(dev, _get_command, true, ARG_NONE, &val);	\
> +									\
> +	return sysfs_emit(buf, "%u\n", val);				\
> +}
> +
> +pmf_manual_attribute(spl, SET_SPL, GET_SPL);
> +static DEVICE_ATTR_RW(spl);
> +pmf_manual_attribute(fppt, SET_FPPT, GET_FPPT);
> +static DEVICE_ATTR_RW(fppt);
> +pmf_manual_attribute(sppt, SET_SPPT, GET_SPPT);
> +static DEVICE_ATTR_RW(sppt);
> +pmf_manual_attribute(sppt_apu_only, SET_SPPT_APU_ONLY, GET_SPPT_APU_ONLY);
> +static DEVICE_ATTR_RW(sppt_apu_only);
> +pmf_manual_attribute(stt_min, SET_STT_MIN_LIMIT, GET_STT_MIN_LIMIT);
> +static DEVICE_ATTR_RW(stt_min);
> +pmf_manual_attribute(stt_limit_apu, SET_STT_LIMIT_APU, GET_STT_LIMIT_APU);
> +static DEVICE_ATTR_RW(stt_limit_apu);
> +pmf_manual_attribute(stt_skin_temp, SET_STT_LIMIT_HS2, GET_STT_LIMIT_HS2);
> +static DEVICE_ATTR_RW(stt_skin_temp);
> +
> +static umode_t manual_attr_is_visible(struct kobject *kobj, struct attribute *attr, int idx)
> +{
> +	return pmf_manual_control ? 0660 : 0;
> +}
> +
> +static struct attribute *manual_attrs[] = {
> +	&dev_attr_spl.attr,
> +	&dev_attr_fppt.attr,
> +	&dev_attr_sppt.attr,
> +	&dev_attr_sppt_apu_only.attr,
> +	&dev_attr_stt_min.attr,
> +	&dev_attr_stt_limit_apu.attr,
> +	&dev_attr_stt_skin_temp.attr,
> +	NULL,
> +};
> +
> +const struct attribute_group manual_attribute_group = {
> +	.attrs = manual_attrs,
> +	.is_visible = manual_attr_is_visible,
> +};
> +
> +void amd_pmf_init_manual_control(struct amd_pmf_dev *dev)
> +{
> +	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +	pr_crit("Manual PMF control is enabled, please disable it before "
> +		"reporting any bugs unrelated to PMF.\n");
> +}
> diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd/pmf/pmf.h
> index 8ce8816da9c1..ca3df63cf190 100644
> --- a/drivers/platform/x86/amd/pmf/pmf.h
> +++ b/drivers/platform/x86/amd/pmf/pmf.h
> @@ -798,4 +798,9 @@ void amd_pmf_dump_ta_inputs(struct amd_pmf_dev *dev, struct ta_pmf_enact_table *
>  /* Quirk infrastructure */
>  void amd_pmf_quirks_init(struct amd_pmf_dev *dev);
>  
> +/* Manual configuration */
> +extern bool pmf_manual_control;
> +extern const struct attribute_group manual_attribute_group;
> +void amd_pmf_init_manual_control(struct amd_pmf_dev *dev);
> +
>  #endif /* PMF_H */
> diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
> index 92f7fb22277d..6db88e523a86 100644
> --- a/drivers/platform/x86/amd/pmf/sps.c
> +++ b/drivers/platform/x86/amd/pmf/sps.c
> @@ -305,6 +305,8 @@ int amd_pmf_get_pprof_modes(struct amd_pmf_dev *pmf)
>  	case PLATFORM_PROFILE_LOW_POWER:
>  		mode = POWER_MODE_POWER_SAVER;
>  		break;
> +	case PLATFORM_PROFILE_CUSTOM:
> +		return 0;
>  	default:
>  		dev_err(pmf->dev, "Unknown Platform Profile.\n");
>  		return -EOPNOTSUPP;
> @@ -412,6 +414,8 @@ int amd_pmf_init_sps(struct amd_pmf_dev *dev)
>  	set_bit(PLATFORM_PROFILE_LOW_POWER, dev->pprof.choices);
>  	set_bit(PLATFORM_PROFILE_BALANCED, dev->pprof.choices);
>  	set_bit(PLATFORM_PROFILE_PERFORMANCE, dev->pprof.choices);
> +	if (pmf_manual_control)
> +		set_bit(PLATFORM_PROFILE_CUSTOM, dev->pprof.choices);
>  
>  	/* Create platform_profile structure and register */
>  	err = platform_profile_register(&dev->pprof);

