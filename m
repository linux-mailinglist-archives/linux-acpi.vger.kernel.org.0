Return-Path: <linux-acpi+bounces-9950-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 714DE9E58D2
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 15:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FBE287C1C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Dec 2024 14:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40221C9E1;
	Thu,  5 Dec 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="is1o102k"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438321A42A;
	Thu,  5 Dec 2024 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733410012; cv=fail; b=K31OZPsF5z9fooaXtgsVJJh2JuT43u999IUGfjGfEsXC3NFJ84GUH0Fy8Hob5dHQCD9qAjsrTsjK+5BvrVkENTVzTghyt+HcIODOjiwgZ5bRxRjcPY0tMJeouF7pJj8xhlRBdTwbZPglFc7g6EUEsHjmqMuEK/jSG4tg5NIx4sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733410012; c=relaxed/simple;
	bh=SW8qfs1drhJoPvB7FWaVohTM5POYbi1pe6Ku5RTc80A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bS5fTjam8WRXylYMa3VCZDPFCL0vzuQIitavWQs0PPU3iYBFiWsUfksSXCz9jnkgsardhqTWsQKTqfcg5OVM89lyZWbAj0RmG/6x4np/ZSsZo73+njiz1L4EnSuTl00aHZE1s0jJkoNWgv0JQDTPOt0hdOs0KmDC71Q7k3D7ahc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=is1o102k; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIt3vv+5Cnfo6V2i4DDwL3S6pzf9/TLWMSxLp+bcliMbvdV6LmZ/oWDldJBJQmgqHQ+OExpAjjmmtGRif5IFSLeaANrN9xcNFGjEqER8oeiJHoPlMn5/MiI0II3hektUoJXJaBytLWOprwgNF8fioD1tdIMFcrqhAs9oWy7yef+cgDQr/Jd3fbPwhJO9HyZXKz6udAVGcD4dG3rFm01cZR0uKeuTbVz1E0mv5KwyBunislR1LSaxBKP/2/lTjuHO9gSiP64FX//aBglmzG7OfM9cN1cTEmSuud/AB3zLksBSPYfTTevXbCEITsvaSJiD2wvE8zGZLYXPA/1qSpbLyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0agJ4afQW90x/JlkO/x4rZ39Hcl6p7QDO0H6A1Y+B0w=;
 b=EP8PG3HgVwOeO07LG6s0PjA0CL1/JPZhs8hdQWhvVTGwipoNs7EfFxrpdShbQNKxZXhtRojWda1BrjkRHjuVROAGA7zvUnLnZSkKpdvp/l/5TtyZvNbBI1cWGAFvPR3xSla66Hd7yqNHU4+mdGUsuok48vFTEpMzYExRJES7htlcqTbs5dFekszeOj/o8Cmu/biTcX0BUiV+a0cfdSAdmqBMyuMtmoxbAuiet3g7qRRbgAJTciayqH9rz+m5ASfjcYySo+txoge191nbwpGWAi7HJRREEKwYI8FyvKAIrOfHf5Gy7qw6F0IKavGOQ/WyjnglV0NtFnUvLTXUf3R4QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0agJ4afQW90x/JlkO/x4rZ39Hcl6p7QDO0H6A1Y+B0w=;
 b=is1o102kjUTveeGLJbmAtcRRIpyzjHad4KjZJx361kLjIxdHGykNEgCXc3a9PEnEDBkNsvy225378asNiMPNhVD9b/EG5Dqc848v8keP1nIEdHAvY6JqNbytv3efpd9xSzwpDe2AzrnQVNedW1WdEDvgToMBJqy/1vG6pG7qjlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Thu, 5 Dec
 2024 14:46:46 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 14:46:46 +0000
Message-ID: <bd079286-b7c9-4231-b8d1-1b0bcf937997@amd.com>
Date: Thu, 5 Dec 2024 08:46:41 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 18/22] ACPI: platform_profile: Check all profile
 handler to calculate next
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
 Matthew Schwartz <matthew.schwartz@linux.dev>, Armin Wolf <W_Armin@gmx.de>
References: <20241202055031.8038-1-mario.limonciello@amd.com>
 <20241202055031.8038-19-mario.limonciello@amd.com>
 <fc57acd9-396c-e047-12c1-14836e477d14@linux.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <fc57acd9-396c-e047-12c1-14836e477d14@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::28) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: d40b2cec-0231-4215-c7f7-08dd153ba4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aVRDM0twby9WbXpUV1I3b3Z1cHN0eUd5OHh2M2J4WFlhUFVpN1VSNlFTUFVW?=
 =?utf-8?B?Q3RCa25Sa0s3K0c5Z2VnMzFBQWtFM2lmWjFaNVJ3SUUvbFRhcTQxVUZteVJr?=
 =?utf-8?B?azJ4UHFUelNlSzVKNm1LMmhXellWUWxPclBpK3NxbkVEUklXb1JIWU14WXlj?=
 =?utf-8?B?YlM3dGdScHNLazBYTlljRE9xTE9pejNSUlhNTFhBSnRmckV1YzE0Vm5zVVF1?=
 =?utf-8?B?RUViQm5FaWY5ZGVabnVMYlF2QXlST3RhMzcrSlFhaVpOZWlUVEozd2dnd3dm?=
 =?utf-8?B?a1JBNXovcEZKL3JJYVE5bTdXckxUYXcxbm5YU1lEbk8yRHhCYzhjcVlVazIy?=
 =?utf-8?B?UEpsQWVuVk1MNFVvdzhLcmVjRWFLRTRiSjFCazBMaHBrNERSZHpqQ0psVHNQ?=
 =?utf-8?B?cXM2aUdRTnRsY25LbjVDWm8zRDhMdCtwbFJmNGxteFVjVDJnQklMZkpaSS91?=
 =?utf-8?B?MGpOdloxSC80NndmQlhERmdrVW1aZGZ4QWhhbUF3ZldVbStYOUxOb1QvR0Ft?=
 =?utf-8?B?NGhITlFGTUwzNGJ2QVRhWmc4MDJNV0dPb0phaGNWRTBsb3RwakhnTlBBWHkx?=
 =?utf-8?B?RGN6M2dMYXgvZm1yZW0zallCOVl5Q3UvcXVIOE4wMlZrUEU2bnFqa1lnWGRi?=
 =?utf-8?B?NmphR09sckNMdndmcDAyVFdTRDd2cFRoeitEenhMOCtib2JuajhwelE0L3JL?=
 =?utf-8?B?SGV1QVVXTC95REZUTEVJUDhwRU5DZlc0YncwSmhKR3piQm9BbkdlbSt5ZzFE?=
 =?utf-8?B?K0hCeEtOa0pRYlJxUEZEdHZZb2pmODZtSGgrSEVXODk2TFM2Q2ErUm1RMFhz?=
 =?utf-8?B?U2Y4bEo2Q3hRSTdSNGZKamtlMkpGVTU5TDdjV3Vic2h3KzJ4ZW5OeE1GSFl3?=
 =?utf-8?B?S0JnVEZmdzBKaEdPemcwZk5mY0V2RlBLbjRENktmT0ozOU5OWlVSaWlzVGFG?=
 =?utf-8?B?a0djMTNwZ0J4UUVLalhxQmpJckNkaUNuc05wYk1qbVJ5WEJWZUVObXdHRXhZ?=
 =?utf-8?B?WnRhVXVjSUdrN01kRVRqbkcwTjRZYzdwamMvNjlBdU85YWlISUpZYzVkQnZp?=
 =?utf-8?B?Yzd1Slh5SnVqZlhJVHJUcnJ1YkFxVDFLaE9US1IrT0xpU2dDZURZS3J1SGdC?=
 =?utf-8?B?SlhDL0J0RmNLczFQRjFmRFRnWHNKTno1QndwWGNHejNvTzRyVmY5ZWV5Sjc2?=
 =?utf-8?B?VTIzZC9yUXN1K2drREFBYXdNZFBrUjYvSyswSkVRYlg0TTgxSGdMUEVzSEt2?=
 =?utf-8?B?Vk81d0hVNHZXRHdIclM0K0YwOXFpVi8vbFJMeUxWd0RsTjZETEFtRUJIMDcz?=
 =?utf-8?B?cFFFMmZjYVhGZitnZ3d4cmZTMmh3ODVMbG1LSy9UdnJNYVhRa0lJQm5iRlJr?=
 =?utf-8?B?SDBGUEFiM29JMEJSQlJYd2k4R3F3UW5oNndTeVdFSStIRm9UbE53K2ZnbFdT?=
 =?utf-8?B?YTViZVJWN0ZhQ1AvcWxoVk51UHhhZXhnNExDNXZZL1d2VGUvbFczZlFNZHdD?=
 =?utf-8?B?Tys4YVh1VThuVkRPbmliVml1WFk3UEpDRXd1NGkyejcxaitLMitaWXZJMEVv?=
 =?utf-8?B?Rmtxbk4zdU5sT1FIRzdydDhONUZrQjFTRWdGdkZwa3RNVDlrcTd5WUh1Wlg0?=
 =?utf-8?B?MFpJV1A4T0tiT05WQXRERVEzZndmbWl6cmpjUVptRGlndE1venZ0MlJtSm9u?=
 =?utf-8?B?Z2Z6UmVTanIzaE1WdVhYeGJBVFZqa254M1FaN1gzZkJrVWxmalE5WkdDMzQr?=
 =?utf-8?B?TWJlOFlHT043TVZnR1dLdzA0NzQyMGpRbzZ5Z0VOTFJldS84ZTdoaEpJcHZr?=
 =?utf-8?B?TStoWXlHZjdJTUVBTnBrUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFRXZTJjNXdPVEZuLy9LTWhtZndtODJWTzBGcU5BODBqSmh6U0o0WlJFM0kr?=
 =?utf-8?B?VFcrcExqOElDdk52MndWcmZLWVZiNFJlMDM0NzJMTlRhUXpZVkIrK2N0eVNH?=
 =?utf-8?B?dTRWWUpnd2xXMCtIOTgyK0lxSHJhcU1zdnFhTmNBK2JpbHdKS1pWeTdOVHpV?=
 =?utf-8?B?aUhJWkc3Vk9wMUdDeFJ3SWF5bXY0YldJMTdDYlVMVndCVjJpWnJsUis4RjJI?=
 =?utf-8?B?WU5kUmppM244YkxTWUhHcWo0WUxqVWt3WjY3c05ZQWN0YysxVnZnZDNoczBQ?=
 =?utf-8?B?T2NpUnpEWmd6OC9qNGtYZ2FTa1NTcXhLSjZ2dHBJTHRFN0IrazNOWEhnMDMv?=
 =?utf-8?B?dlJ0M0hHb01VMXpocWIzQk5ZYmZkbU8zRllQaStkclNDd0w0TVUyd2ZVOW1X?=
 =?utf-8?B?ZUcwZnhEYVovd2pUT2hxbFlvdTNIbnVJWlNnNDdrT3dMWVF4ZStpTGpJRWZW?=
 =?utf-8?B?UkZ4OExrb213YzJ0bUQzMk12M1VUbitDb3N5V2IwRWtEdzFTN3dqZEsrMVpG?=
 =?utf-8?B?Z3Q2TFo3N0ZoOGhqZENIRWgvUzRNczhJblY0TFB5eDU5YkZzZllNWTNpRXVS?=
 =?utf-8?B?ZFJpUWJtcno1TllSaXQxeVVrRkxYN1hJaHhCelRjWkxZZFNFUXllZXBjakNa?=
 =?utf-8?B?THo5KzlsS2tNNkd5SnRDaThKM212T0hZVGE2Z1daVVRicEFZWE1YTklNb2Jq?=
 =?utf-8?B?VXl2L3V2bHdyODZBMjBYTGZuRGNwbjBPWklWMkhhaHFORy9iMjZqQXYrWFBY?=
 =?utf-8?B?YXZNd3BnMXg0NS90ZUloME5Fa2podnhMODRSTWlGNWx1b0dQZURnU2JLMmh5?=
 =?utf-8?B?Ync4a0hMektadk56bXhUOCtRMzdhSTZIQ0tSQUJnV1QrZEV0Q3hCekZKOG1z?=
 =?utf-8?B?aS81ZGpuam9reVZHWm1IcmN1MlhUTm9zNGpJN0NITUxWTzhQNnhaUFRYbkVz?=
 =?utf-8?B?d09wVEdXT1hNK2FvZVlDdUNqbkNlSU14WnkrVmNwWmZmVVhIajhsdnhKZXVt?=
 =?utf-8?B?VCtuemtxd0kwQnNoR2lPaklKQlhLWkdGdUVGUVl2dGViUFlCR1ltYUREazht?=
 =?utf-8?B?SW5wZmFGcklMY2pRRjYzb0U4Mi9lelZBbzdaVHp1VnR0VkZSWTliR1ZoRUp0?=
 =?utf-8?B?YmJVRnVXWTRDdkNaSllKTGd3REVhWVVxOUhjc3NFalJkckV0OHI3WWx2WTEy?=
 =?utf-8?B?MFZ1NE1jRDN4Q0loMUFmR29KdXVyQ3ZBMFNac0lZeE5uQWRIU2w0aExZejh4?=
 =?utf-8?B?VDc3SE8rU2owanhIUjV3RkxXRUhudTRRT3JHRDNrNjN4R0dwenpCdmRjK2hW?=
 =?utf-8?B?SHIveXlzeWhQdnNNOXpTMkcxcHp2Y2QwRERldzkvdVVmT3M5b1djRzdqNm4y?=
 =?utf-8?B?R3Vza3dvTTljWThta1hWZUhTTkt2WjNOS1hNcnVmZEtwOUZYQXhSUmMwZ3FI?=
 =?utf-8?B?K3JSNzloZVZFcU5nRjNaT1cwTTZzYVB5dm5DV29ZN2RaekgyWEtlN21CTnI0?=
 =?utf-8?B?WnM3SU5zNmE4SjBUSmJTREkrZ1hseW5PZml4VkYwRy9IV2RPZS9DMGs0QmVH?=
 =?utf-8?B?VFlmUURsNGR0S0lpdTFKdmE4WU8xZ04xVGZSY2FMRDBhV2daU3dRSFBTd2Jl?=
 =?utf-8?B?Q2JFTzhMdTZHQTVjTkNtekJ0cXExMndkeU43bWRtL2tsVGphd2dqUC9aaFJo?=
 =?utf-8?B?U2cvWE1DU0pJcjZlSEtqYkNQZWVqSFBQTlFzemNIbjNTZFdhYU1TYU40YmxX?=
 =?utf-8?B?UWY2RlF0alpqYXluK2hXc0ZWRWcvdFUwVHVOUjFlc091ZmVTOHJHWWRRM09U?=
 =?utf-8?B?a0pRQklkWWlXWmo2dzZPeEN4REg5amZLWUxic2N0Q1ZlWUI4ZDBMWDZyUlZM?=
 =?utf-8?B?ZHFxeHpSRjBRL29vWDhOZDJGNjN2RmtQbmtFcWx3RXVMSmhoZE1kTjFhWlFF?=
 =?utf-8?B?cERpVzd5VFo5Vjd4R1dET2dNOHoyK1FXSVJYM0xnWm1zd2dkL2N3cnJTbmFQ?=
 =?utf-8?B?c25ybFptdS9rMWR3VDdXOTUvSFVob2FNeWFEaVc5ZnVjOUc0L3NMY2g3dWpz?=
 =?utf-8?B?THZhMGxIQ2NvWGcveXU3MkpWK0RTS016bytjVHhlYVlXNjdpWS9pNGM0Qmdm?=
 =?utf-8?Q?/IHGpLtEsHaq17O8bI4BXKCyP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40b2cec-0231-4215-c7f7-08dd153ba4ad
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 14:46:46.7922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POMouADZmunki+WSKs4VN2lWTEBUjAXoMx2LZiZQsVb93402+3Y6U92DpEoDgcPUe4iQceC3XC7pQ8W8EUrGvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944

On 12/5/2024 08:22, Ilpo Järvinen wrote:
> On Sun, 1 Dec 2024, Mario Limonciello wrote:
> 
>> As multiple platform profile handlers might not all support the same
>> profile, cycling to the next profile could have a different result
>> depending on what handler are registered.
>>
>> Check what is active and supported by all handlers to decide what
>> to do.
>>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/acpi/platform_profile.c | 30 +++++++++++++++++++++---------
>>   1 file changed, 21 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
>> index d5f0679d59d50..16746d9b9aa7c 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -407,25 +407,37 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>   
>>   int platform_profile_cycle(void)
>>   {
>> -	enum platform_profile_option profile;
>> -	enum platform_profile_option next;
>> +	enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>> +	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
>> +	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
>>   	int err;
>>   
>> +	set_bit(PLATFORM_PROFILE_LAST, choices);
>>   	scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -		if (!cur_profile)
>> -			return -ENODEV;
>> +		err = class_for_each_device(&platform_profile_class, NULL,
>> +					    &profile, _aggregate_profiles);
>> +		if (err)
>> +			return err;
>>   
>> -		err = cur_profile->profile_get(cur_profile, &profile);
>> +		if (profile == PLATFORM_PROFILE_CUSTOM ||
>> +		    profile == PLATFORM_PROFILE_LAST)
>> +			return -EINVAL;
>> +
>> +		err = class_for_each_device(&platform_profile_class, NULL,
>> +					    choices, _aggregate_choices);
>>   		if (err)
>>   			return err;
>>   
>> -		next = find_next_bit_wrap(cur_profile->choices, PLATFORM_PROFILE_LAST,
>> +		/* never iterate into a custom if all drivers supported it */
>> +		clear_bit(PLATFORM_PROFILE_CUSTOM, choices);
> 
> I'm confused by the comment. I was under impression the custom "profile"
> is just a framework construct when the _framework_ couldn't find a
> consistent profile? How can a driver decide to "support it"? It sounds
> like a driver overstepping its intended domain of operation.
> 
> If the intention really is for the driver to "support" or "not support"
> custom profile, then you should adjust the commit message of the patch
> which introduced it.
> 

Yes I had envisioned that a driver could potentially set custom as well.

This idea was introduced by my RFC series that precluded doing the
multiple driver handlers.

The basic idea is that some drivers (for example asus-wmi and 
asus-armoury) have the ability for the user to change a sysfs file that 
represents sPPT or fPPT directly.

If this has been done they're "off the beating path" of a predfined
profile because they're picking and choosing individual knobs.

So if a user touches those a driver could set profile as "custom" and if 
a user chooses the platform profile the driver will override all of 
those and report a pre-defined profile.

So, yes I had that all in my mind but as you point out I definitely 
forgot to mention it in the commit messages.

Do you agree with it?  If so, I'll amend the next version where 
applicable (probably the patch that introduces custom and the 
documentation patch).

