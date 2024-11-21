Return-Path: <linux-acpi+bounces-9726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DD49D5571
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 23:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC2E9283E1B
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D9C1DC05D;
	Thu, 21 Nov 2024 22:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V57iqUwO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAFB1CEAB8;
	Thu, 21 Nov 2024 22:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228053; cv=fail; b=NCc+2rzyii/xoTpiuIptly0esfQ76kofMnT8HOGQy1/3tX1DJepOoyVsJrngo7trIqhBAij8WN800QauJKOtvR+yBgqsAXtQaRjt3I2m7lkm/tFn2cipO9KC7xigZk/Grk4b2NirWtjJjUzocPt2NGr4olsNiwc30VjwFdvpbzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228053; c=relaxed/simple;
	bh=GDk+yXC5PrgsK/yur8P9hzdNZtbb4G1ZQBi0h6Rb8Uc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mtu+NwDreWcPjaE+YPEHSe2n7Hykj3+sT2CDqeZY6D/Svi0f1zxM2ZqSjoNwunCIoX8VBi+e3/Kn/OBdAw0XyiSLNP7WXkt8MqYtNR6UXLmEmIF+8iQcm6uO/Tb7p4H3OoWecJUg1VgFrYV4QQrvar9R6jP33Khrg1k57v48D1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V57iqUwO; arc=fail smtp.client-ip=40.107.102.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PYfR/iTOz6Lh/HazLXSTVrkno7S4OElNaWn8IzuU77PRJvLAnXuZP+v8FEmGnEkVh7Mc6VqtJk2NfKEDwG2A89IlYDPP8l6pBRth2eORjKEY+Pdrxxs9wVl9EA1EW8pWT7qrCyk6u7dfr+L8T9Bg2r/5fjwTXHJXHQE3cg5OZ4yMUiSeMm4EhuCTht08mvoAU5Hy0nXP5bUkHvf2UoVUXX6Jj1F1u8+X58duikS3dVJyrXx98ch0iTxyKTyscYW716aNFqP3F/x7lbhfl5fLAd4Zj5cCIFWt9IdwAj0S80jgH9LTThBrj4hMnIAbQauvQheZ5NUza/X05l7IhrKarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STs/C4EzTaM+L1iacuF0s0u/vUCK42v5AzMJm+5QMV8=;
 b=F3zDJvpotIaDPXIoDSbb26TvcrtNTUc1GdaGRZW7DrpNukECIattdbBrjv0DLpSm2idX7H5mRlcy7sFwFV2q5pI5gdpG2QWLevwpK3pfmRjLAGIKcV2v03bN4rh21HQWAX2BkWENpf2h9goMaajN72fXxp5nYiaBVUc6moaMwkh9lAwsvrMC51YMYAsIODCuGyboOefTYtFRru+b/h6vwyM/4iiyjQmb5DKCiL+ko6i3FUovkNBqD/lCeHhKXzTfhN3WfXW51z3vzytLJ6SvBYoHFz32L+/EmjsOKLiQcjMz58TPsBJ/pK3gxGHZap+VD4RM/m1cqQyW/hXvV8w3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=STs/C4EzTaM+L1iacuF0s0u/vUCK42v5AzMJm+5QMV8=;
 b=V57iqUwOfAJHhdk0FEV/IfSYT0B6M5k1mqAJf48rpsyzH7+C7/1FkIo/XlnIpj7qyAZtNk/Ut3DtoXRNp0oQK3ZO0vqhvDPYGGAfAzAhAfBDaXmixo6OXNiIliqFXeASpe5q5K9/O7tTEi2kOUWxWmi4C6P9IuaXWw52ZABjjpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 22:27:28 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8158.019; Thu, 21 Nov 2024
 22:27:28 +0000
Message-ID: <e7ac7561-f9ff-406a-b2d7-6d9e31ed6e98@amd.com>
Date: Thu, 21 Nov 2024 16:27:26 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC/RFT][PATCH v0.1] ACPI: OSL: Use usleep_range() in
 acpi_os_sleep()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Len Brown <len.brown@intel.com>, Arjan van de Ven <arjan@linux.intel.com>,
 Pierre Gondois <pierre.gondois@arm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>
References: <5839859.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5839859.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:806:120::11) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 181a519f-e4c4-48d2-5626-08dd0a7bae9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjJzN2pmME5MNjIyRTBCZGdQYUVheDYxWmRhTlJ4OXk1Y3lwL0QwcUpmcmZh?=
 =?utf-8?B?Mm9iSlU0bFZiL2hmL25uL1VnM21Oc2svWmVaVW5rM2hVZU4wQ290c2pvbEZB?=
 =?utf-8?B?T0ZpbUgzVlRtYUFrNmRnMEkrS25oTlZjTkU0bVpmSWI4ek9PZEM1WG82MGNB?=
 =?utf-8?B?SVBiWElGOFRDZXdtSlZJUGFpSVkzR3JRVndURm80ZGtrTW8reWNNV09JTllL?=
 =?utf-8?B?MzlGdUpHd0ZKMmRQVjcwTEhtZHRGM2tkUmhDYjJDK2kwRjBZa2JpZE9ydXVa?=
 =?utf-8?B?MnNuN0dKWCt1TUdjRmhUTDl5NlpVOU02eUFvdVRCWGJZOFY2OGxidXdsTjk2?=
 =?utf-8?B?eDVMcWJueFdkWDNlZllPL3VOU3dXQ3FGbktFOXdDTDdkQzVRWXl5clp0TjRq?=
 =?utf-8?B?TGM0djFySXlxV3BXRDRETFh1a3F3ZmtkTmdIQkp4YU05ZkJkSi93TktZV2hY?=
 =?utf-8?B?L29FMkwwZ2VhTFZnSFNTeFN6RHZvaFRvbjV3aGhXNHdiQlF6UXZHMG5XajN6?=
 =?utf-8?B?czh1R1NhTk1CWUtIZE0rWDRqMytMaWVuWExjNFpHOEFLZWVQUEsxcERxdk5p?=
 =?utf-8?B?Sjg2bmFySC9JVlpWZ3JsR2djL1diWDFrYWIzQUZvbk1SNk9rU3F2KzVSK0Nx?=
 =?utf-8?B?NzZvdnczQ01acjVmcWw3ZWEyRjVyZHNjR0lSQ1Y1QzVCZ3hyREVWTWFrc3ZK?=
 =?utf-8?B?K2VjTzlNRGg3K1V4RVdNSWpJaXN4RC9SdnNHT25OOVg3eTR1clZpWTVsMG9R?=
 =?utf-8?B?UHdpSG9wQTN0ZThYbFRLd0JuZkdKMXF6SHcwRDQyWDdlcEdPYzNsSUxvK3h4?=
 =?utf-8?B?QWMvLzVSWUM5aVk5NFc5OG52Qk5COUg1Mjh1dThyTTd6TmM3OHFXbEV5ZUdu?=
 =?utf-8?B?VWEvL0NuOWxhQWdNRzRuZGM4QkZCRGlSYlppeHh6a3dGekNWeTZqKzV1RGlR?=
 =?utf-8?B?c01ZN0hMSFhmR1VxeW9WVXNkM0ozWFFWcDdoQm9qNXJVTGZhVjI2UUR1b0lm?=
 =?utf-8?B?T1ZoR0VpeUZscm90SEw3N08yNXdLd0haZjZhamx6WmJtL0pMbXZLczRIQjdR?=
 =?utf-8?B?di9CcXMzRDlEY25CMjZKZERZTlZqRU5TSnN5U3p0MHY1Ny8weWJucWxSQURh?=
 =?utf-8?B?cnBDSTVlNVU5ei9iRktVbjNRdmRyWU5SZEdjZ013em1QSWlxUGtWeTVIQ1RV?=
 =?utf-8?B?TXhwaUN3ek5wMmF3Z2Rqb0xLQitkTzZVR2Q1NHNpTC9DclJabno1WFdtcWV3?=
 =?utf-8?B?WXY4Q2I2VXdkQkdYeENPbmVaNm9KR0pPd3hMdmJBN3pCRk1vZFl3WWl3akx5?=
 =?utf-8?B?cG9LK2gwSENJZ0xIVzByWmRWNTNMZ05qMUUyUnlXYUFjVWtkUGhLODVFdE5V?=
 =?utf-8?B?T2hhUGF1MStyTXBjWXdFQ2ZQWFNndU9xaVBsN1FMbkVWM1JuWjgwMGNYWUhw?=
 =?utf-8?B?aVFvQ1JNRlNLZ1BhSjh0d0F1cDVFVEVGc2QzSGhTYlBXbGRELzg3MVdIVFlo?=
 =?utf-8?B?aFBHVks4MTdaU0diNGxnQVFueFdSaExJbzZiRktocXh6cytLcDNocHlJSnRM?=
 =?utf-8?B?L1daSEZKazVWY0N0ejUwdGZydUNKajk2Tzd1Njh5OERPNXdCdEx3VHBsZnEx?=
 =?utf-8?B?TGFkSzdPMzZuN3BHSjB4bkxxQ1hXWng4eVFUTHg1aHpDZFAvUEI3dTdmTHhV?=
 =?utf-8?B?M3lYYkozV2FKcjR5dEwxYzFMNEkzOFV0ZVFDTTY2eU1Md1BqVkl0eHFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzEwdUJuUWtFenExUXBSaXVsYTlUdmN5UEsvRC9ucXBMRUpLREt1VmJFZEJz?=
 =?utf-8?B?NFJ4WEZObWsyaG9qYk9RWkdSTW9oSjF0b3IweU94YXFqMUdXclQzMHpPYk5U?=
 =?utf-8?B?eDY5Mm9OWGJyTkRUYmJ4eW1HZlFZM3hZaGMwZU9ZZ1kzWTdMaTN6SmEzTC85?=
 =?utf-8?B?SGlhdE8zWWFvMU5MV2ZISFArdU1vVXFvV0wxRExtRElEUGc4eHhkTkNTL3d1?=
 =?utf-8?B?YnR0TjZGUHVodUk3a3BuUUc0YVp1djJCVlpSOXZ2OENyc1JKNW80a3hreHdS?=
 =?utf-8?B?R1NEM1BkeGFHVFJJanpPOExPdHBXNXYrekhYVjhZcmdtSnhhN1lyVnhmUTho?=
 =?utf-8?B?TnVZdHhLM2JNNyt3YXFneFZGVjRTTXJRdWgrYzI0eE9waFpvQUdtamkvb1Fl?=
 =?utf-8?B?SVRuZHhpZ2NHWmxFUktSKzRWK3pseFVOZm9SckFLZU9DQUZlc0hUZzdnN010?=
 =?utf-8?B?Q3VGTkxBUkZLd1lKU2JkcEljQ3F3MWdHcUZhelBxeURXSnlPbHRvWFdWZEdE?=
 =?utf-8?B?TDhuNFJVR0szVFdnNGs5dkVQWFd1NVpMUnpmWEc2S0lqR2tsSmEyRzQ1NmUy?=
 =?utf-8?B?ditXaWVlMDFTcU5SWSszd0wvUFN0Sk9abWtHS3JFRmE2NTFwaEZiK0NBSEs2?=
 =?utf-8?B?Ykd4K1RRL2ZWdFZlRVFtMEx0Ly9IMnhYWnZVN01BNmxmbEpqd0xSS0lYTEdU?=
 =?utf-8?B?WlgxWHZwZENQZnBKSHZ0Uy9jNk90clZmQ2pnOGVPbFZKUW1GVXN3NEw0WWxX?=
 =?utf-8?B?dFJWV0gya2J0Umxkb2RxeEdka1FBd1hvV0labDZhdk53Y2pua1E0dDZHbFZ1?=
 =?utf-8?B?R1phZGlzcGFEYWtTVWU0TlBYZllXWkp0ak9rMG1hUVZYTUYvTC9hNXpQeVMr?=
 =?utf-8?B?U0Y1d0o0cWxlRExPVW1nOUpOTWY5aktEL05GS25OaUNXYzRETDNjcEhmUnk0?=
 =?utf-8?B?U1hkeFNtQk4ydTVSZnN4RFRKbXhKaTVHVzhYengvQnBOV3MxcWtmMnluUDRJ?=
 =?utf-8?B?cmNyZlYrTjdhV1VIdnYrNFJpZ2svZkRZREIyTjdjRC9xam1helVZcFlXblRm?=
 =?utf-8?B?RVBJTEttWWJka3FUQ2VPMmFNT09xSzhpM3J0V2NBT2NhNWNSTFgyZmN1Yk5K?=
 =?utf-8?B?cVIwT3Z3Uk5nc3FjdWpGQ2VucnNrd3g2ZTlyeVpoTE5QRVVFbGRkc2JqdTdr?=
 =?utf-8?B?V0U0aU5tem02bnBSM0tPOEFUZHRYWGtGejhJRGhnczJRQ0NiR2VIS2tkSGp1?=
 =?utf-8?B?WjNHa2tZT29KZW53MEdUbkFjTGl5cHFPaTNwcDRxUkNaNElieC9sSmhCMEhN?=
 =?utf-8?B?anJQYVlNeG9TYlJMbmNNaUJ0UVcyTFZrbStvWmRaSmVKMjcvaFNtbXBLZkox?=
 =?utf-8?B?SENVSi9CdWRlS2FhcnR4TGpzY25Sb1pBYklyVTNTQ20vWDhlbGNEeEFybndU?=
 =?utf-8?B?QVBMQ1lKZGF4OEsxTXo1eExOY0ExblUwMWlUbTFPdFNJWkIwdjJsZjNmODhT?=
 =?utf-8?B?b3F0eTVTR1owT3R5MEgxZnRENDVPdHh4eWVlOHhZTk43YlNJUmR6WCtkTHVM?=
 =?utf-8?B?VUkyeUhBVkl3YmtZeE1PSWh1eGpIK2QyQndiRnEzZStWMHlFT20rQ3g1K2VP?=
 =?utf-8?B?dkdhdlF1aHB1RnZDcFFpckY0SW8waW1VMnVzb3FPWTlJempxcFhXVDVPTXlN?=
 =?utf-8?B?VTA1dzZJcktkMmd6RFg5QSt6M21sVGRSbytaVXdTeUM2TWxlSHphVTB0ZVc5?=
 =?utf-8?B?c1paYnJjM2ppQ1hGdWN6MXluZmpqU1lFMUxjbTc2UkljUDQ5WnZrT0I3bC80?=
 =?utf-8?B?QzBTbVFNK0ZtRXVjUkZycGd6MTdBdm05Y1Bzd3gyL3FkbzNJMWJ3Nk13UFR1?=
 =?utf-8?B?NkpyVlZsRHlzVnlVUU9QdmQvaXFMNnk4ZGdkSFg1eXg2T1BiYTRudVowaDFk?=
 =?utf-8?B?d0ZkQndvQWlpeVd6MVZ5a3FhTWg0bmh1WnQ2WlYrN2FLdVNUQkxYREgyY1lM?=
 =?utf-8?B?dGxJRFRnamoxdm5yTDEvVDJ2UGtIcnBVdDhQMjRmWDJZQ21mbExvcjlxcDdR?=
 =?utf-8?B?Zmo3MkhabS9mZG9Scm9wQ29IUjBBOEdiVUMweWNJM3BhWE9ZVFdJblc1Vzc3?=
 =?utf-8?Q?3pVQxf5LIcNFEtnHjzrAXCCVP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181a519f-e4c4-48d2-5626-08dd0a7bae9b
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 22:27:28.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NikPibAU76R8SJx/7eQtOTN02NwYm4UKXzsLqv2u35DcfpIOsckpPcPBWyVWjBlcdIsXZRukia6LuUioSz2+Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906

On 11/21/2024 07:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> As stated by Len in [1], the extra delay added by msleep() to the
> sleep time value passed to it can be significant, roughly between
> 1.5 ns on systems with HZ = 1000 and as much as 15 ms on systems with
> HZ = 100, which is hardly acceptable, at least for small sleep time
> values.
> 
> Address this by using usleep_range() in acpi_os_sleep() instead of
> msleep().  For short sleep times this is a no-brainer, but even for
> long sleeps usleep_range() should be preferred because timer wheel
> timers are optimized for cancellation before they expire and this
> particular timer is not going to be canceled.
> 
> Add at least 50 us on top of the requested sleep time in case the
> timer can be subject to coalescing, which is consistent with what's
> done in user space in this context [2], but for sleeps longer than 5 ms
> use 1% of the requested sleep time for this purpose.
> 
> The rationale here is that longer sleeps don't need that much of a timer
> precision as a rule and making the timer a more likely candidate for
> coalescing in these cases is generally desirable.  It starts at 5 ms so
> that the delta between the requested sleep time and the effective
> deadline is a contiuous function of the former.
> 
> Link: https://lore.kernel.org/linux-pm/c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com/ [1]
> Link: https://lore.kernel.org/linux-pm/CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com/ [2]
> Reported-by: Len Brown <lenb@kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

You probably should also pick up this tag from the earlier version.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216263

> ---
> 
> This is a follow-up to the discussion started by [1] above and since
> the beginning of it I have changed my mind a bit, as you can see.
> 
> Given Arjan's feedback, I've concluded that using usleep_range() for
> all sleep values is the right choice and that some slack should be
> used there.  I've taken 50 us as the minimum value of it because that's
> what is used in user space FWICT and I'm not convinced that shorter
> values would be suitable here.
> 
> The other part, using 1% of the sleep time as the slack for longer
> sleeps, is likely more controversial.  It is roughly based on the
> observation that if one timer interrupt is sufficient for something,
> then using two of them will be wasteful even if this is just somewhat.
> 
> Anyway, please let me know what you think.  I'd rather do whatever
> the majority of you are comfortable with.

Generally I'm fine with this.

I'm about to head on US holiday, but I will forward this to folks that 
aren't and get some testing input on it to bring back later when I'm back.

> 
> ---
>   drivers/acpi/osl.c |   22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/acpi/osl.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
> @@ -607,7 +607,27 @@ acpi_status acpi_os_remove_interrupt_han
>   
>   void acpi_os_sleep(u64 ms)
>   {
> -	msleep(ms);
> +	u64 usec = ms * USEC_PER_MSEC, delta_us = 50;
> +
> +	/*
> +	 * Use a hrtimer because the timer wheel timers are optimized for
> +	 * cancellation before they expire and this timer is not going to be
> +	 * canceled.
> +	 *
> +	 * Set the delta between the requested sleep time and the effective
> +	 * deadline to at least 50 us in case there is an opportunity for timer
> +	 * coalescing.
> +	 *
> +	 * Moreover, longer sleeps can be assumed to need somewhat less timer
> +	 * precision, so sacrifice some of it for making the timer a more likely
> +	 * candidate for coalescing by setting the delta to 1% of the sleep time
> +	 * if it is above 5 ms (this value is chosen so that the delta is a
> +	 * continuous function of the sleep time).
> +	 */
> +	if (ms > 5)
> +		delta_us = (USEC_PER_MSEC / 100) * ms;
> +
> +	usleep_range(usec, usec + delta_us);
>   }
>   
>   void acpi_os_stall(u32 us)
> 
> 
> 


