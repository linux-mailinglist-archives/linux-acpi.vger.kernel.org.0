Return-Path: <linux-acpi+bounces-9425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B114F9C1184
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 23:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71AFF282F6D
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D4218927;
	Thu,  7 Nov 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ArmeWfc1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A7215C6D;
	Thu,  7 Nov 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017380; cv=fail; b=WHo+A/ER2jdzwgwArk6L93flrPJnYbekRJZIxMYHmyRxRI9ugr+gFLj0cY8TrgjfQyC0tCCml1k1NJN+y4OpXix6FOL9aeFf+INK2Rwb5NDqtLcKVb8aMZ1/yzYMeVms8ICBRW8zlG1bT/Dgd83xCK3coJgXi6LEpGjhrDvAqEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017380; c=relaxed/simple;
	bh=CMTVEzWcSsyLCLOHz6TkJeoBG88pCyfdlpOYMF009yc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a002ZVfrZOUxl3SDXynDe4U8TDqLRfmL7S/6a7XAro9IrEM9ay4v6tEF9yM1izw/gwPMo4lN7UKIoE5vuej2bzdyYnygd5fmL+QgO/nGydp2DsNKUN5dnU5bGdXBlgmjXG6Ux4Xk5osc5GN1hfmo65D12t+AZP6hl3B8kAU6ss4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ArmeWfc1; arc=fail smtp.client-ip=40.107.243.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHOARtBh1IQjVh0p/QJgX+XFv2OzcRyE05NutdUVqUTUs4pbCndquQ3+62Ep4POaeVkG5PhsUmRhCLRUzUJfO52IPfSQhRHmOmWu5NCYTFnpZVl9NUdedhNBTUyjhnCdUmsrvCHf4y0zgBjlFNVCDalUKXBqMtDHdt3Q201TpUBLtWmu+aha2w8JstlPwR5H/1nnF8HmOxY7iqM2B6BUtpn9+oMTtUvKp6ICd7QJlCbA0v5JbdkXivc7w9It0YWMUaHb09TsEm/YyrKne/SmHgrZwlmWJMHkAGPY0C40GMVUvFry+gNHWWHvpuLMA6EoFJ0ZDy/PltwdkQbQm8KPsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0Ey4LXFuMCJv3nx9V7cowAc/G7wyR3ysw5c5Wu69T4=;
 b=kmbQIfW5gKREeIvcjAIoUwYLodXSsxKag6oqMSOzWukgLGgv8ynE6HPm5Xm7Htu6eLOtSEwAsWYjEYFQja3lYdv3mau3mhVcziXdWEjK8YlebzEm8H6HQBLntz0RDnEMdyjd2XRdYarmHRzwE2oTH3hZkQX3Y36MGPx0Fno3+vFvNAhVtJ2vjGgOgpVMbpekiA6bo/0eWjp0rWFEEipinWbQbD1vGSjH65h0TuD6yni0aZNNNJh81zgI95x/tiiEtgeF84aK28DsGoM+tR4BV7YH6B6xZYlyewWjeQfPqUoVc4emgxQ7cUlffkUTdH7sM8HLbC6Xa2V12TSUy5BfMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0Ey4LXFuMCJv3nx9V7cowAc/G7wyR3ysw5c5Wu69T4=;
 b=ArmeWfc17YysOXlxWBL3N+8e2vSPEYqa0Hg/VZGHB3B5PIl3TiNfqKcicDPxQdVBx8oNgtpRvxRqMdbO7S5mH1T3aO/v6xzLNbzMdEYFdMjxK7FEbugva0XVtLfUAYN9+pH/nfliugNgoEMYj8BpuvkEwljyLQA8V6W5Af4RgyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CY5PR12MB6478.namprd12.prod.outlook.com (2603:10b6:930:35::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 22:09:34 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 22:09:34 +0000
Message-ID: <9dd1709c-de87-4aa3-aa33-8a520a305545@amd.com>
Date: Thu, 7 Nov 2024 16:09:31 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/20] ACPI: platform_profile: Add choices attribute
 for class interface
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
References: <20241107060254.17615-1-mario.limonciello@amd.com>
 <20241107060254.17615-12-mario.limonciello@amd.com>
 <7e302f04-cb4d-4ecd-b1a1-4b89f09e692b@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <7e302f04-cb4d-4ecd-b1a1-4b89f09e692b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR12CA0004.namprd12.prod.outlook.com
 (2603:10b6:806:6f::9) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CY5PR12MB6478:EE_
X-MS-Office365-Filtering-Correlation-Id: 57f5dc63-0bf5-4db2-9409-08dcff78dc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU1jVFdOanhpcnhadEF0QnN4Rk5oUk1qMmlPdSt6UXZ1dFZ0d2UrU0swTWJE?=
 =?utf-8?B?Rk82WjErU1NUQ1VKQ3B4M0xRd2xPcDVCYzJESUpRTUZIYk9JUTkwQndjeXZ0?=
 =?utf-8?B?cEhtdnRlOHBBRzRPTHFnVXFaaEEwNE1OSFdJMURuK001dlFOL2N6dHBRaFNU?=
 =?utf-8?B?WENoM25VTTloVmQ4cTMrR3FsbFFGS0E2SEQ1emc1VDRQYXlIM2NMck5iSXRE?=
 =?utf-8?B?ZDNYbDhBY0F5M2NkMjB2ZzZMODNIazIvRnl6UGN1UCsxK25odG1UdDBIUHor?=
 =?utf-8?B?NytCNWlNR1A3MkltdU45eDFLVjllVFB4U0VGY2pqYWp6NlYwZWRSdndtSTZs?=
 =?utf-8?B?ZXpJUkc5ZEVtQVd6VkI1dVVZTW84TmdWTjBGd0kzRThLVHdXd0N3bFRaK2sw?=
 =?utf-8?B?UTc4d0JreGNLN1A3MTE1bG1vOWR3aUhVN1lwZ1JTTHdVUFVuajYrRkxXUDF3?=
 =?utf-8?B?UkFLMFJLY0dzeVNLNlNpY0RQSHJ1RFZiYlhqeE5RQ3ZjNmFOd0QyaXZiTUly?=
 =?utf-8?B?QnN0Qkg2aHpDcGZnYUplQWxqUTlXVVk5RlJBbzNSNmJLZmh0VW9XY0FCaXQy?=
 =?utf-8?B?QjZ4dmZKck10aUs5akpQblpYRFhteXQ3VmtxU0N0Qy9HZG5xekhYeUtuNVZh?=
 =?utf-8?B?VVBGK09tNS9xLzVVeDgwdThVWjI5ZnEwWTRMVlBGbHZQeDduUmthV2Y1NVNz?=
 =?utf-8?B?eGRtTStHYVNDdzZYWi94azVNS0NyYkhMc0dWS0hpdldnaHB1NC8rZ0Jhamx6?=
 =?utf-8?B?TUlwSElWOW1wQ3RFM0w2eTJ3M0F5THJEdElYTG9LQmR1ZnZ5T1hjWlRGRmgz?=
 =?utf-8?B?Qk5MU1B5ckxrWFE2OExwR3p1ZytJR1lEcytWT2VPSHVnak5kVExMczNlOG5s?=
 =?utf-8?B?WEQyYWJ4UXp6dElFUi9LTzhtcDVCVTRaQVhyYWQyS0x1bnJTTUxuWGZSU0tN?=
 =?utf-8?B?eTdRenZsU2g3d3NGNVM4cHp0MGlvclpMaEp2TUtwaHRGWCs1V2RQOG8wd0VT?=
 =?utf-8?B?MU5IbTBUR2c3aFhobUF3NkNYTEhLMkZkTnc5eGZLMEtIcU51QjJ3UjYrT1Yr?=
 =?utf-8?B?aXV5aGovanM0YTNGaC84eitVL1IzVnl1Witoc3JaeGdsZXFmQmx1VVNvNmR3?=
 =?utf-8?B?UkRMb0doZVplU29jRDl2emZTWk9HNEJ0YzdGN1FnZmVzaU4weGtaaVZoa0NC?=
 =?utf-8?B?QnR0Rk1aayswZkxyU2xveVJ6WEhqQ2U0cmU4WkZsUXJoNUl0MG5xQjR1MWNq?=
 =?utf-8?B?RHpHZFc5Y1ZuaDg1Z3laN3IxVzNnWFA5anlCekhVWmdWdWNTcVpWSGdIZFZ4?=
 =?utf-8?B?eG9KejNXdXA4aWJsVnZRNEFZRmpiTUNhL2tIT3N5bnliSURybHhxanBKWWcv?=
 =?utf-8?B?Vy8xbHlsRVlHdUdBcitkSFFKM2dsZDd5RlhIUWFUWHZDK2UzWWhzdW82aEZQ?=
 =?utf-8?B?ejUrT2JDc2VOU3c1Q1BJM25oVDVibExQOHpSOGpnaE9XZGRDYVF5NzhPSkpv?=
 =?utf-8?B?YzI0aTg1NHlhMUkrbGUxMWN1YmxKdXZtK3NFMHZRbW4wS0JBaFFmWFNGSjJm?=
 =?utf-8?B?SEV2UElOUnZQMlBEZHp5bXJsTGU3TFZQR2JYTlR1SHRBSWVObU84UUJkK2xo?=
 =?utf-8?B?azF1UDdSalFoNkVLVWlvMU04a3docTAxSHl2T3pwYWZta2lpNGl3MDFCQXdw?=
 =?utf-8?B?KzVDRWVTd0lMdmFjaEszTURlY1dWTS8veEViMnA2V1c3ME4zaXBIS3N6WW5q?=
 =?utf-8?Q?IYJKyW9y5mkU4I6hc13MWZZaogxncvQVBxTe7kf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU1hSU1iUmI5NEZVKzY2UFhJN1RyaHY1MmY0K3dwbnV2Tk5zUDN3MDE5MTAx?=
 =?utf-8?B?ZmhjMDhBR0tGcjludFpMK1I3MGJENzlTOVBGV0pTejJaREtOSllhT2puVEtP?=
 =?utf-8?B?ZU93cXF2TlhnMkNFbmEyeWZhL0cxSmVXWURONGx4aE9aQzgwL1cwaEx2TVd4?=
 =?utf-8?B?TXFPQW9pVHRIb3pGYWMvQ0xxM09BVkpTQUdPQmhxcUUvMHlXb0I2citFd1dZ?=
 =?utf-8?B?YkcveTJ1aHhqNzdLZVpCYjFxMFlvSk9TSDFQanlhKzRVRUZEVnB2aE1EelUx?=
 =?utf-8?B?VVdXdDBhVDRoSysxZGx6aWFsOEgwRTZ3eVBiMzE2NkRpSTlhWU5OQ0lZcVVB?=
 =?utf-8?B?NlZEQjZ1RkF6ODBzRXIzbGRleFNPZ1VRZTA0cXBCQTZ4cWx2QUZxaGcwODJE?=
 =?utf-8?B?UFhTMHJ0dDdLWFduMFRrYUtUa1ZzcnBxcWxHbzVzZjBPMWRkcG00TnlOTG1Z?=
 =?utf-8?B?VnZjcUZYUzBDQkR2b0E5V3FFUGJueFVWTGNudlk4bUlMY093a3U4dEhmMXVa?=
 =?utf-8?B?YzVlUEZydTBNUTdDN2VxS2RBWUZHc1F3K3ZCdjZOOVhFUE9xMFlIdERQNGNX?=
 =?utf-8?B?SkNyMllJdjA1MkpKWHltQlRZR0tvbkFHUXpnQzhRaE9sREQwNm80V1N1OUR6?=
 =?utf-8?B?NTd6RjR5QjJHOXZsQjEzUE5GMmg4SDdJNGtmUGIxWFNIRmdzL2c3SHR4YVFH?=
 =?utf-8?B?SDNQUWloeXVZdEZhdFZIaWRyb3RLSXUyaVd3Tm1ubXc0WjJIQkNFaU9ZaHBF?=
 =?utf-8?B?K295Y1hkRWNpNUdmMk50dlJ4TmZuYlRYVkt0dnhwNkc1WGFYRmJZS1VtZ0dE?=
 =?utf-8?B?VG5WTlB6Um14TEo4TnBXUzQ5ZFJKMFB6MkNFd0IxZXc2Q1Q4YnV6UThKcmJh?=
 =?utf-8?B?UGFSNk9tTCtmQU9CSmNNaG1VdUZtMi9IV0FLZGJVYjltVjAxY3ljUm96NWZw?=
 =?utf-8?B?VXEyT2JsR3pBWEJlc1JrVXVjdXlPU0x2eEgyUVlmUHlNcTBQWW9FYi91VG51?=
 =?utf-8?B?dHBLZzhzcnJielBxMmxYcGRsMlkyanJqRGpCY0x4Wm83VGYyazMzb28zKzhN?=
 =?utf-8?B?RkRPTXZiZ3JVVVRiZktXQ2RnSmFEdGtEUkJnNi92WHY4WWZZV0dmaXU0eURE?=
 =?utf-8?B?ZnVaS2NVeEUrSjVQOWNMRE9jU1V0Q2plOFR6OFd0TldkUXVPR3k0MHpyTGVO?=
 =?utf-8?B?RlFWaWw4RU9KRGU5aDQ0VVpjVW5CbjRTVWZ4WU5nWWw3bXNObnU2bVJrRkxD?=
 =?utf-8?B?MGlzZlFjL1cyaDNybUh3REw5SUhBcm1PVUx0dzJKckV5QnUveFAxRVRPYlFR?=
 =?utf-8?B?akZpNWt3NGtVMkc2S3lXN3NPNGIxN2E0eDhDdlM3am1mSEFSWHJIUDJ4c1dl?=
 =?utf-8?B?aGVhYjA1MVZwL0xGWXBDMkExcG5rZUtrdHlaMzVZRm53NWNNYnhQWEJPUlVw?=
 =?utf-8?B?S3Z6RzlkSUFhTURVb244Mnk3U2crSngxL3MreVYzekRYZXVsc1o3Zm9ROG1Q?=
 =?utf-8?B?dDE5eDhnYS9ZYzZUQXM5eTZGdVdiOUVkZ2VwSkk4VWZoSHlVT2wyd3d4MnNa?=
 =?utf-8?B?LzFqbVlUZ2l6OUVlbE94eTVncUsxNjVNdHFCRHo0MXB2YVhML0N6cUJwODVj?=
 =?utf-8?B?NFlEd29XWnk2bXdBZ0NqUUsrcDgzVjYrMEF3R01YT3pncHlOdlRyeEY2enhF?=
 =?utf-8?B?emNaM2hqNHM0NTNwVk44Nko4d0NyUTZlWUZtaFNLY0lNOGdOZWpSSVA3Z1Z3?=
 =?utf-8?B?WE1kZlBrbnpaMDBwaXRlMHhSUmRnT29hRm5JejUzTTczb2RvTmVJR1pjMmI1?=
 =?utf-8?B?dlpLQmN1SHVlV0RUVkxBbU80S2VXN2w5dXdiby91S3ByNUtTQjRaNE54TEhl?=
 =?utf-8?B?MWFDQktrcGlGTlNERFJQSkhTanNtcE1xaXlLSFhQeHZtK2xMWUZEMi9PemhT?=
 =?utf-8?B?RkVJQStFRXdKdEJGdGRacEFrVWRVSVd4eVlWWDZOZmFMZVp6UEhTOUJGdkVH?=
 =?utf-8?B?SUFTdWZmOE1kbG5HWnNxR1NKalJnN1JBOTZzOEFnMVVtdmthNkJUNjljNDJQ?=
 =?utf-8?B?bUd3alRPemRHaTRUeGNML0U2cWVIZS9zQ3VNN3lSMFE4UXByRGpTdWs1V0JR?=
 =?utf-8?Q?he00c+qEzxTNcIP6FPB8z3qmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57f5dc63-0bf5-4db2-9409-08dcff78dc76
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:09:34.1342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Fwl033zhiTRDTvW3Pdvo62pEvcRMoKK3v6T45gNh9wU2SGgjMzBO/s27gwTUFLvqW+u5p7GUedGR9R66MgBVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6478

On 11/7/2024 02:28, Armin Wolf wrote:
> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
> 
>> The `choices` file will show all possible choices that a given platform
>> profile handler can support.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v5:
>>   * Fix kdoc
>>   * Add tag
>>   * Fix whitespace
>>   * Adjust mutex use
>> ---
>>   drivers/acpi/platform_profile.c | 65 +++++++++++++++++++++++++++++++++
>>   1 file changed, 65 insertions(+)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index f605c2bd35c68..5e0bb91c5f451 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -25,6 +25,46 @@ static_assert(ARRAY_SIZE(profile_names) == 
>> PLATFORM_PROFILE_LAST);
>>
>>   static DEFINE_IDA(platform_profile_ida);
>>
>> +/**
>> + * _commmon_choices_show - Show the available profile choices
>> + * @choices: The available profile choices
>> + * @buf: The buffer to write to
>> + * Return: The number of bytes written
>> + */
>> +static ssize_t _commmon_choices_show(unsigned long choices, char *buf)
>> +{
>> +    int i, len = 0;
>> +
>> +    for_each_set_bit(i, &choices, PLATFORM_PROFILE_LAST) {
>> +        if (len == 0)
>> +            len += sysfs_emit_at(buf, len, "%s", profile_names[i]);
>> +        else
>> +            len += sysfs_emit_at(buf, len, " %s", profile_names[i]);
>> +    }
>> +    len += sysfs_emit_at(buf, len, "\n");
>> +
>> +    return len;
>> +}
>> +
>> +/**
>> + * _get_class_choices - Get the available profile choices for a class 
>> device
>> + * @dev: The class device
>> + * @choices: Pointer to return the available profile choices
>> + * Return: The available profile choices
>> + */
>> +static int _get_class_choices(struct device *dev, unsigned long 
>> *choices)
>> +{
>> +    struct platform_profile_handler *handler;
>> +    int i;
>> +
>> +    lockdep_assert_held(&profile_lock);
>> +    handler = dev_get_drvdata(dev);
>> +    for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
>> +        *choices |= BIT(i);
> 
> Maybe just copying the bitmask would be enough here? In this case we 
> could also drop
> this function as well.

Right now this could work, but choices and the use of it has gone 
through great lengths to ensure that once there are too many profiles it 
automatically becomes a bigger variable.

	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];

So I would rather keep this as is.

> 
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * name_show - Show the name of the profile handler
>>    * @dev: The device
>> @@ -44,9 +84,34 @@ static ssize_t name_show(struct device *dev,
>>       return -ERESTARTSYS;
>>   }
>>
>> +/**
>> + * choices_show - Show the available profile choices
>> + * @dev: The device
>> + * @attr: The attribute
>> + * @buf: The buffer to write to
>> + */
>> +static ssize_t choices_show(struct device *dev,
>> +                struct device_attribute *attr,
>> +                char *buf)
>> +{
>> +    unsigned long choices = 0;
>> +    int err;
>> +
>> +    scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> +        err = _get_class_choices(dev, &choices);
>> +        if (err)
>> +            return err;
>> +    }
> 
> Please directly use the choices field here, no need for a mutex  since 
> the choices are static
> across the lifetime of the platform profile.

But similarly to my other message, the class could be unregistered and 
this needs to be protected.

> 
> Thanks,
> Armin Wolf
> 
>> +
>> +    return _commmon_choices_show(choices, buf);
>> +}
>> +
>>   static DEVICE_ATTR_RO(name);
>> +static DEVICE_ATTR_RO(choices);
>> +
>>   static struct attribute *profile_attrs[] = {
>>       &dev_attr_name.attr,
>> +    &dev_attr_choices.attr,
>>       NULL
>>   };
>>   ATTRIBUTE_GROUPS(profile);


