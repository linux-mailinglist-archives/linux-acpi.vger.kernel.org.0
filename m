Return-Path: <linux-acpi+bounces-10478-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80620A07DC3
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 17:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423341887C88
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Jan 2025 16:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311312236F8;
	Thu,  9 Jan 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NF0hSt+Q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87999223304;
	Thu,  9 Jan 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736440589; cv=fail; b=T95PtioaVcKRK3t7fuWfLlNn4DbrE6mEsef1OU8uyg7/1Qz1YlEgwtyOgfBZR6409JaKUFGcQJC/JXnOGGPtQXMzV68LpUQEktF/5vvON2uKI///JqmMwpgk1KIR7nUdlxdYTgJh8RdxsskPUC9Nt9H/fehj/EsGD2bzSm8nzQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736440589; c=relaxed/simple;
	bh=r16kT/s5Q/ZermujBOj0+TMYcGNg8Gso3zKQ+WuUvFY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rp/7W5+0Bc0arsrwismKykCI3fkP76F0RRZUxv9E4Ou/tHoA6KEDacGcpyt3VIoPfqsti9tmQ+1/v1rfWwG+tgtCa4Wq8EEtAOtu4janH6p1aZK9uo+ZdRSrMViQPefXZM/nb+M4wH/suFJNi2BLGJy17br2aDLOONoEQWWNzrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NF0hSt+Q; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cX4iWuv57/0RiEKb/GZ29YY6y8K/6/tghel/hvhY+L6PyJp43ZdITp3t2aiNp30vtIRJXCeuTF4MCuJth1+7hdjr+ZxkcPAKhAMqJeJ8W/CpXapgc5iJqrd6KyvXEudwfXD5qHrv7sqvLnR0noZu/JFTTGcEbaUbxvjyBurz0PTkZChpm54Bc/2vam/mjNr7yAHczrHMRMu8bgswfOyQRQx7xKaxvdi0bNfLfQS7eliSZ/EWvH3VNgV25yTPttLu07/v/5WjxDs3lV2otervuZ8Vu3zP8XU26DMAeCHYDItoFQLYmZipt15l1xjTawav662FMkjQCijAolispghY3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eT7bavgl9LjwnHWwQRB+8p7FqYBIV9CZP9m8k+QX2+g=;
 b=d+4W3pT4/VzylWMEU5nGnkbQCPGybpTjmDWQHDhTMOqcQ1P3+BdmyigW5ICOWzA2EHcPdi1lhZPKELRg0/PduXhT4keAu/YQos59BhpijmEzDdg62ZdWotb3qP8w36CbM5OTaI2lsQrWmozGIudpdGGQ9yWipUTE4TxnADy8sh8L4841XYVegQHjKujKQkzZ8mWlNOryUIjfTvMbouZ4gLXW/Hjy4YrjI4/U6jSR0iSoBwx7I2dkwt3+pPGrZnq3/U0ZBGYz4TQcb1HceJitNJ6AiA1nk/9SC6AlrXPjFh59bnpyTQpz6E84N//Pq3UuiWhqlp+nDRIEOhazsZ+zIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eT7bavgl9LjwnHWwQRB+8p7FqYBIV9CZP9m8k+QX2+g=;
 b=NF0hSt+QSSzdkxHyc/XbuGD6GqEB9e4DfquRs3NJ3j0PJ8jHn1dqUwdEbC2bYeFBagucSQiNSLIFVzDRsw8wjNlsdK2qCQ5mqkLfyBjvTg6JQ9ZPyQeXengbQUVJw1LWERGvmQG8Ml2nxq5SdUExYwjZdibfY2sOLP9Mq1jnFzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by LV3PR12MB9353.namprd12.prod.outlook.com (2603:10b6:408:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:36:23 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8335.012; Thu, 9 Jan 2025
 16:36:23 +0000
Message-ID: <073e0d63-2d58-4977-8604-d22c712388c8@amd.com>
Date: Thu, 9 Jan 2025 10:36:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/18] platform/x86: acer-wmi: Use
 devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Armin Wolf <W_Armin@gmx.de>, Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, Maximilian Luz
 <luzmaximilian@gmail.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Colin Ian King <colin.i.king@gmail.com>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Gergo Koteles <soyer@irl.hu>,
 Dell.Client.Kernel@dell.com, ibm-acpi-devel@lists.sourceforge.net
References: <20250109150731.110799-1-kuurtb@gmail.com>
 <20250109150731.110799-7-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250109150731.110799-7-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0104.namprd05.prod.outlook.com
 (2603:10b6:803:42::21) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|LV3PR12MB9353:EE_
X-MS-Office365-Filtering-Correlation-Id: 35641777-0681-424b-aa29-08dd30cbc154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGZQZFdWUXpRcWZUY0t2ODFvN25QdFQ5eDFENmx2Tk1qRkR0bExWaDlWZDlx?=
 =?utf-8?B?ODBoTVh5cFJJdHRLOHN6RFpHdUtvQy9zVHJVRXFvdVNvOTZRUTRmM2R1TUJB?=
 =?utf-8?B?VlcrdmhRYk9MQ25XeWtZUnlvL1lZR2U4NHY3YjNqM0NVVFhWQnErU0FwYW1W?=
 =?utf-8?B?UFYxZDRKQllSTUZBWlRFaHpmRmxtejRNZ0dGTnFYNUMxa0VKemRZVkw2SVhr?=
 =?utf-8?B?clJla04zazBFUWREc00yc21SemNZYmpBQ0dXc21peTVOVitGb3BGSm02WUhj?=
 =?utf-8?B?bUhPbFdMS3FuTUxqWkVSLytpVUhuRWl3Y050WVVZK2hOSXdnTEpPb1RyTkpE?=
 =?utf-8?B?S00zTlpQclpTODdWaGlxeVdpTE12bTRDZGh2UEc2RFpIdnF3TUlQcXA5aXFR?=
 =?utf-8?B?T25vZVh3eGtmcUQ3eWdpS1ZMOFFrS0pvdVl3SWRSTnpoU1BreTBySzR2SjFF?=
 =?utf-8?B?akYwbkJnYVNtbndvVXdyZUFZMTg0SnFNVGVTSTl5dlV4WFZSaFdkbVZTKzBL?=
 =?utf-8?B?VnNya3lSNCt4d3F2a2JYM2pXclRmZFhrMGt3cWEvcWhrREljRXVJV1J3d0tt?=
 =?utf-8?B?Qys3aTBNRDlnU1NvVXNPZHNIWkhSRzc3ajJmSXk3ZkNhdTZxTGRsc2IvRVow?=
 =?utf-8?B?eU56Q21oMDJMWUlCdkYwYXV4VjhZYU1LZGdIdHp1aDdQUDJURS9aamdEQ0V3?=
 =?utf-8?B?eitWdS80NzF4cC8xVUh4clZIL2FZZG5NTWdlY2l6V05NT1owRVk5NXBja2ll?=
 =?utf-8?B?dU5vMUNZOXgwR28vRlNPQ0ExeFc1cjdxY2ROMGhObFAxRTI3QzBDS1FqbVJx?=
 =?utf-8?B?dk5GeXQ5ZzZWR0MwOHBiL0t1SFY1RjVFY2FEaHZ6RUFVUGh5NUk1WWRqdVJu?=
 =?utf-8?B?clFadUcvNkhQWkJDdTI1RUZ6dG5XdEV3TnRHdkVsdEt5ZjQ1UVFnSnFzbnZR?=
 =?utf-8?B?dlJoTGlZVzkxZDZNRWswdFFXSHJHM2h5T1lIa0ROM1Q2RGdoOGZZWDU2Q1RP?=
 =?utf-8?B?ZlpHV0pLdEhzaWc4Z1ViK29NZzFBNGRUMGQrVCtpeW1sd3VjeE9lU0FnNlM1?=
 =?utf-8?B?bjlPdjR3cjlNWWhMaHdmMS9KV0tMSkJOSXc4WlUvNEJ5QjRScUVodkxpVGJ3?=
 =?utf-8?B?ZTdaQkp1RkZ4S0QxSFpqMUhucWNPRjByYTkvUXp6NjgwcllNWHIrbjc0MEU4?=
 =?utf-8?B?ZjM4S1N3Q1BNZW0rWHpScmVFcy9DZWVMeGVRMlpQQXdZUDNoWjZ6N3U3UFhB?=
 =?utf-8?B?RG9FaDVQdnRENWlvUW5NQlNaSmxuNHVGYkl4YklmTGRiOFhHNE5DcHVFL054?=
 =?utf-8?B?bmswY2g0SXNzVWROQWRwZkpCS0lhcHVtUTdQVDVLNmY0c2V6cmNKL2pCSGhG?=
 =?utf-8?B?K1NLQ0tucXowb01mbW9DQUwzQXJVWUd4NEVHNFNSMzlQZ2I4dWI0UkJXT0xX?=
 =?utf-8?B?amFIU3pwajNIc2ExakJ3a2hpQnZjQnlIRG0wQ2lJZjViNS9mUnVJQnVqeWlY?=
 =?utf-8?B?WGF6TzMzTVcvVTZkemdYQXBZeEYya0Nad2hzR3g0R3FXVFJ4SFdqRVBiaUo1?=
 =?utf-8?B?OWp5Q0N4Q3BGQ1c4UVhTNWpuWWFBdmlHVkkrU2tkVDBCcEt4alRINjhpbG5i?=
 =?utf-8?B?K3Fua2R4cGV1OWdxYVFEbzdYenhMQ21tSTF3a0JJVDJWcWhhd201UEIyTDRI?=
 =?utf-8?B?eXZENmpkeEJPVThxMngyRXBaNjY0WndLVG5MYXp0NTNhS2VTY1Z1QXQ4dDlt?=
 =?utf-8?B?S0g3SjRMalUvR3BSUXlkckwycXowVFdaMU1OK2FnSjljbkxCTnhGam1ja2lO?=
 =?utf-8?B?R3JvT1ROTEFZTEROL3FyZkgrWE5zSWVCZmZvQU40RGtQOUk4T0ZVUjRqbExE?=
 =?utf-8?Q?ymcrXRGd9V/UT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnIvS3hEU0Q0eFYrc1MySFBUU0xtYyt1bVlaVFgyZFRtMHBZSXhEWktkc2Iy?=
 =?utf-8?B?Tk9oNlp0TnhCNlRqaWo5TmZiZnAxVmhGRm9vamhCTGh1MzRndlFNelhTLzVv?=
 =?utf-8?B?UDU1YXUrOE1VZm8rVGVoYThoNExlL3RRYU94TUkyNlBSYlRCMVJRSHhJbnEv?=
 =?utf-8?B?ODFtSjRaaWQrMGU3L0lHekQ4QnM0cEFzUTBUdmN2TGlEZGZxNVV4cDJzaXFC?=
 =?utf-8?B?R08wZllvb1FndXh6TDc4QlhXcEFhem5tdDBpajBocnozNnZIUGlkWlBDRzc4?=
 =?utf-8?B?b2QzbW5tZWw3VWpaS2lzUWN5SFlNb0k4SzhoNzBrQ25iR1ZQeUJLQWtyWGkv?=
 =?utf-8?B?QksvVUdxV2h2U2orSnFjTkNhZHhzKzc2MTd5Z2R0LzlDb05YK3J0NmF3TTlY?=
 =?utf-8?B?V3VzdVdhRmhIUEVJSmtCbGFVR05KY3IvUjNSci9wVm1qNTNMUE1iR0NDdzIz?=
 =?utf-8?B?YkU3Y3BhT1VCNUkyUmM2bW5xT0F5RlBlRjRuREtxaXFlRTkwbDhzcTA1SW1n?=
 =?utf-8?B?VTZWQXJUWDhiRXVWYnVPRWtjbHJzSDdlWERzNmwrd1hWTFZzYlNGS21WZ3BG?=
 =?utf-8?B?MEJScnY2MVVtRk81eGlsTmhJU1RoNERNeXV4ZitGVzlSajdrMEdUNThkZ2E0?=
 =?utf-8?B?bXNYTmRTZDd2dDJidzNHWkZ4bS8yQVByWk4zR01JZ2xJaW85bGVEL0ttSmcw?=
 =?utf-8?B?ek5NWWVGbkNGaSszRDArcmdNcmJzbVNaVExQVFpXQVJlcjhUOHVUeVZHNmV3?=
 =?utf-8?B?SEhISEJTQ0dCZ01SOExBWXpkU3hHOXZxODZOWWhRc0JVSnhKOWJzYVdncklZ?=
 =?utf-8?B?S29pNDU1UnIvOUlEc09sVVJDeDVMWFFGam8wSUdCRjdrNDdXSElTYXFNeU8v?=
 =?utf-8?B?MXk0WE9FbTdzL3I0UUU0aWZ5MldodFFZQ0l5eVJwZVM1enJuME8xQjJmVzZX?=
 =?utf-8?B?YXBIODV5VjZJOUVLdDZ1Y0ZOekxsMG1HN2xuMWRzZGxNZVBPcnVibmZtcmNI?=
 =?utf-8?B?bzZkZFpsYlhHMGZyOXRRRWFKRU1rWWpoQnZYK3BXajlSL05IZXk3MnhZcERY?=
 =?utf-8?B?WFo3ZURRRmsybTV1em00NitzMDR4RXNjSUovRXdKakY0UEhkNzlvK3U4ZmVh?=
 =?utf-8?B?MVpNNU9wc2NUT1MrQ0N5Y3N1K2x3NUp3QzJmM2UwanhZaHlQakR4Zlc4Sm16?=
 =?utf-8?B?bVEydWRST08yUEVhajBKUWxGa0M5eERDa0hKUlk2Z3FQUUxqOGVpTTBneEx1?=
 =?utf-8?B?NkgxM0ZQaTN2VFhjckJ3blk2ZU8wNHFBZEdteGNCQWNOUFBBV0VETmVleTVC?=
 =?utf-8?B?OUQ1TEVUWnBMZ25sTU5ycEhabGdxRy9kQWVWTWl6WW4wQzA2OVk2eld3RUFy?=
 =?utf-8?B?SENoUFRrVVNMb1lZbkhSMG16Z0wwZy9TSG4yeFFuVVZkYTRTdVNhRUc2R0ha?=
 =?utf-8?B?V1ZuQ0NEQzRFekhwZzZGcVR1VzlOSGM4OTdYWkpSWDk5bURJUnplVHNic21k?=
 =?utf-8?B?N1h2MDBzOUJIcDdxRnkyNE1NSGJ3YjBVcTIzbHFBdlBOVGVlanVYM2x4Z2ZW?=
 =?utf-8?B?T3JEVk11S2Jpc1lIRW4zdHduckFDcmxnOWdwT0FLeTRCTkpGcDZLRHdSOTFy?=
 =?utf-8?B?QWIzVmg2QzEyK1VsT012Y2UydGo3TDVYMktmRTFhZ2NzVTlHV2g0cE5KcktX?=
 =?utf-8?B?Tk4wWFN2WVh3NFdJYVpjd1h4ajh3U1BOV0FXV3Y3Uk8wR0RBWkZZcHBLdlVy?=
 =?utf-8?B?WjFabi9heFBmNXZHK1ZITDZFMUxQc01Bck5oQzNOVTBKOThpOEZnUWJOQ3kx?=
 =?utf-8?B?M0lrVXFoKzdNaThKTDRlVXNaK0Fhb1NpODZ1a2xvYWFPTnYzVGtPQlhlMjNK?=
 =?utf-8?B?MHNPdFI1T3RIYlo3ODd3bnZBSmErTzdMamo5SG1TY1BDUCsxckpNWTh3dHZL?=
 =?utf-8?B?dG0xMyt5VmVTUXRCcDVLYm9HZjVWOXpZcHVMbzRkQXVVMk96eFBRbWJWN2V1?=
 =?utf-8?B?UVZIaG5tT2lPQ1ZvVU5oSmxNQjVVZHVFMG9jeVcwWkorak5vemhqc21UVVZx?=
 =?utf-8?B?VUFqTExKNzVWTGl1MWlnQWh5TWErWTVqaE02OEk1YVpxdHUxUzFhaHVYTTdj?=
 =?utf-8?Q?5CxHz2rsC8RtMjc8k1r1pPn5o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35641777-0681-424b-aa29-08dd30cbc154
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:36:23.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJEkMHYyFiqFAJqjv06fuEBAQQBPRQqLSLy36QVy6fOu8ipyL4Uiu9ezkZRa9spGDaplNWy4hXXjJgwr4PdRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9353

On 1/9/2025 09:06, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/platform/x86/acer-wmi.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 585d54d8d80c..70ec667e0cbf 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1928,7 +1928,7 @@ static int acer_platform_profile_setup(struct platform_device *device)
>   		platform_profile_handler.ops =
>   			&acer_predator_v4_platform_profile_ops;
>   
> -		err = platform_profile_register(&platform_profile_handler, NULL);
> +		err = devm_platform_profile_register(&platform_profile_handler, NULL);
>   		if (err)
>   			return err;
>   
> @@ -2575,8 +2575,6 @@ static int acer_platform_probe(struct platform_device *device)
>   	return 0;
>   
>   error_hwmon:
> -	if (platform_profile_support)
> -		platform_profile_remove(&platform_profile_handler);
>   error_platform_profile:
>   	acer_rfkill_exit();
>   error_rfkill:
> @@ -2597,9 +2595,6 @@ static void acer_platform_remove(struct platform_device *device)
>   		acer_backlight_exit();
>   
>   	acer_rfkill_exit();
> -
> -	if (platform_profile_support)
> -		platform_profile_remove(&platform_profile_handler);
>   }
>   
>   #ifdef CONFIG_PM_SLEEP


