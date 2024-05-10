Return-Path: <linux-acpi+bounces-5749-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7C18C296D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00880287B9D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C20D1BDE6;
	Fri, 10 May 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ODEhD/Vt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63918654;
	Fri, 10 May 2024 17:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362814; cv=fail; b=YHxAMpue49TZ48tPxvGR28RBmBJEj28+Z9pt5vrjKjVH7Gu2plwH+7loksoo/f/KKe+Jn4F0oLXuzNysg7ONeZ1Gaz5HJGuNDKvNsIoiB18yTSSdm8Ma28oFg2viEAtusY/sJNKHpH1zxauQrTMMwtON9Dpg4qmgvafN5K4cz08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362814; c=relaxed/simple;
	bh=Xmyzy/xr0KNSmapfcHIL7bNnHxfvYEbp9bB1YYiCc0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V8i2kske+BvCeKj1FT9BOZLKSY2JGOfPFq0Nncjvcc/oxx8UPl/BpOoBvlOyOY8K277Dhl+4WRmst8wqjYudiSKPAKib6qWDTx987Y5mMOX0WX+ub1niiqH26jsnw29i/pQu6+rC7A4Vk0quj56Vg/RVefpyUpgYJ+RFGOoGFD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ODEhD/Vt; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=np47MNZ9Mwwv2cfZHhzoC1E7JTsuN/gEchTD8heVl5jPuTuQgQs6Xdz42Any0K3+l3FCbjaZk4XOG9xS2dEfoLCZQc+eCwN+armH+GRCyfZgTXKt/RgVpLZ6zB7iYIzYmWjbdVgWqX3TzD6wwGrIehionXl2moiLdv0Qh4PP7MsA/0i/w0n3308LUuXqRMsX3D/GdCOZhxtvwo0ff943hfx9G9pN6wCBl4NYkdIm3IOLruTYM3yf7NSmZQB8XEaYXZsWdsHVDB50Wsb/SuT6Jb541P14ukFxoPGiAJS28VrkgT1Qnj2o5fyjrP5J/ZTfv9m4aD4ZYkevPIjC2OyjbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ML+Hzn1IhTbvxYtbSjlmWzReEJ/s4IOD44MV+td42Os=;
 b=aFpUfikh2uTuG9ru+1fLmZmjbdC+6WOQhBVkNjfh8UZK7TqgdYPVekCzHyNm2UEbKWAddwpyxVvi7OuOHRhGHRLPmq6uLsox4sFvoiYZnImL9xpt1H1MwaEmFqFFbMeJyN1S0vwjqCXFc1m1e8wvcX3QqnCup/AeuFOc4fdN+94nKwEVB1sqglDkYj/ZaYlg3V/VIW+IDjfIVHCus2YDV3lE3jPNIofteyXDYKno7TCETevj7Xegaf/79tCImDhbDSp1umbCWoG0+SPR902OI6Prz/t3z5L+uZbMHy2ZLkg0KUCmJuTNpl4cM1rNSow4EDpU70UjHCV+owQAsz8/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ML+Hzn1IhTbvxYtbSjlmWzReEJ/s4IOD44MV+td42Os=;
 b=ODEhD/VtwT85yrqY/jrxxWuk/SGQpdXi1VPYznDyNYVjeZ9xIuKS78nElwdQD1I3WMxYaVbEYsMtT3fuzNmClbHyvKk1Pi2BSB/LUWTesKxVXKdrU/enwaqpoNVvmCVveivNNMej43LLwGdfY7etvfyXtklb9RbllseTEt6JOXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN0PR12MB6127.namprd12.prod.outlook.com (2603:10b6:208:3c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 17:40:07 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.7544.046; Fri, 10 May 2024
 17:40:07 +0000
Message-ID: <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
Date: Fri, 10 May 2024 12:40:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0063.namprd13.prod.outlook.com
 (2603:10b6:806:23::8) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MN0PR12MB6127:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ef309e5-2eb8-4dd6-c855-08dc71183bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mkk3Qk1McERldGtLMDM3L2lYVVU0N0FLK1FjVmhzcXdTcmtHQ1BrNzdnaHZz?=
 =?utf-8?B?V3NJbXdWUm1Mb28vY1JBZjM2bk1MdDdROGpnR0hIS0Vodkh3d1hySS9Qd3FC?=
 =?utf-8?B?LzdXanZiN28wZXViaHFDK1k1RUl3L1RocldEaGkwckNEQTEyUHZPM2dmSGVi?=
 =?utf-8?B?bWVTRUlpVFJkaTYrZWlwaXg5c3NndGtXVG85aDJMMzdjTVJkSHM1NURNUGJm?=
 =?utf-8?B?QTlzUW9MUEU2M01jZGNzME5ScGJ6VUpibzUwY0tZb2k3aGlGdmsydFM5NFFY?=
 =?utf-8?B?UFFaZTQzSHUzZW9ibkJGMmF0Vk0waDFqUmdPVDNGRFJKTFluVWVTaGtjRktS?=
 =?utf-8?B?SVVRMG82V1I4eGdnY3FlZDk5cnRvVS9mNG5wQkd6QzZXR01Xa2plRjNKUE56?=
 =?utf-8?B?dlZ2ZlZiMWs3NjErMVVSSzRxWk8vZ0RWSHgvSXFZZ1J1MDdwbGZKMTA2dkxy?=
 =?utf-8?B?S0Z4V2JhRUdYSlRKTklGWi9uS0pSckgvcVdOaTNBdmNEbWRlUFpPN1lkWFVT?=
 =?utf-8?B?RVBxNXZwRWRFUUtRYmpWczA3MmJZZUtHZHh2L241eE5iaFUvL0JqRU94WGh4?=
 =?utf-8?B?Q1RDNG5ZZGdzUld3Ym1rdHJDdmg4YXJyOE9GRkk3bHIvb0FJY0E1WFp5ek93?=
 =?utf-8?B?Si84SS9jOUYwcFV0MDgwWklXeWE1M0h6MFNnd0Yzb2dQNmxmNGJqZTgvbmw2?=
 =?utf-8?B?L2ZNNDVXSTJPYlZxL3dOeU12aVdmSkZiam05TXhFaVBvb2VSa0RRc281Q2ph?=
 =?utf-8?B?cHZyTFEvK213OGozY010Nm1PNVZvNlI3MUtxTlNUYlpIQlpNTnljTDA4NitI?=
 =?utf-8?B?RU5vSlEzcVdueng4Mko4M1BaV094eTRwL25QRHF2ZFlNaDV2ZXVTdVB2enZj?=
 =?utf-8?B?YmxEZUt2UXFxbVlPSmhDUG96aisyMFluOVFnSmM4K0pEK0YxaW5SV0Z3UWNF?=
 =?utf-8?B?YnU1cW9tNXhVTVBHQVREWlRmQmxRWHZqQWQ3L2tkeko1QVBLdUx2dHExZEJu?=
 =?utf-8?B?WDhPc243OXFnVnJodjdYZnFPdlpiQUEwVWoxY0VWdHVSMGVubUUzZ3hPejhV?=
 =?utf-8?B?bE0vdEpXVmtoalhCZXZWNmNyS0RSMzNoUlJ6UFZoQkNiSWpwOURybWUyaW1o?=
 =?utf-8?B?Y0ZkbFdWaG9GRzVJRmlDR0dRd2dTUk1UaUZmS1gyZUJTVUJVb2syTkVYWStE?=
 =?utf-8?B?RWZrOGdhekVINUtPSXZRbm41bUxOVFN4K1BqZ3VucG00ekpEbVdRazNtdkJW?=
 =?utf-8?B?elZHSm9pRUhIRkovS25nSTNTWFIrUmczQmZOUHA3UFp3SjNmOHNYQ29GZ3Bo?=
 =?utf-8?B?OW9wNXBpenFnaHRHcWNlR3p3TlcweHQ0VXMzdHFkRHBqTWNHNzlibHRvRGcz?=
 =?utf-8?B?OVkzRVBMQUxDaGovOVcxZ1kzNGlCK2tkdlFOWVJIWFFHdmtaYk8rdm9nVm5k?=
 =?utf-8?B?VWRyT3drbWNyS2laU0doMlZsak5zZVV2bUhiK2hUWTFDcmEzclpHeVJ2UUIv?=
 =?utf-8?B?WVVzVXZZczB2eCtCUXBxOHY0bEwyNFI0eEZ1cVBabFRxZGNsdVVTWndISzY4?=
 =?utf-8?B?SjJoV0VNUjdrM2c3RjhGZ3dDOXU1Z1lZaEs3WXk3Sm5kWGg2S0RObjBqNUVC?=
 =?utf-8?B?cnpHQ29UMFZna2Zsd1BpaXNNZzZDVExnQUs3dGlTc1M5SVcxRXVEbFJLeG5J?=
 =?utf-8?B?Q095MTlySFMyV2daVGY1Nm5DdHgzenNXdWhLcXFMTnpvYzc1YVV6WWxnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1BKbkljNTNBcllYSmxOZkRFWTZwV2hRcUhZbHU2cVpwRnVteHNiZWE1MThX?=
 =?utf-8?B?c0JvbGlnRVJJNmxNUHR0aDlRZGVLK2w3VE80aXRPMXNSblgwcWpSL2YyRE9W?=
 =?utf-8?B?aUpJMkFuNXk5TVVQMkc3aTUrWVFVM1liTTc2TTlCd1FQVWIyVG5WVEo4N3Ux?=
 =?utf-8?B?MkozWXQvV0wxUGg0R2UwbGh5ZG03cGxLam5qdW9LM3BrSWhDRXlZWlhhNFRZ?=
 =?utf-8?B?dzRsU3IwMUFWa3JDL3JFbUhLcmhldFlyWUhDeUlhTlZsZmRNL0xNUzMxNFhp?=
 =?utf-8?B?RlhCblk4UExaTzhYSkcwR1gwWEF6NW82ZmJUeDZYNVd3NkxlTXBzVDBqbnFU?=
 =?utf-8?B?c2I5aFRGbzJqYVpVd3h2dnRselRIbnh1YndvbnV0RzZOWkt2bjh4dzErMDNk?=
 =?utf-8?B?RTZaSjNpM2JCZ012UGZTZ2xtUWRkS29ucml5L2UvUzdlWXJ4TDNDNFlIY0tH?=
 =?utf-8?B?WkJXZCtxdE5tNEMvNlJSbGtMMnN0OExMMEpBeUx2dVh5aWtBYW1DTVJoWHhn?=
 =?utf-8?B?dFJwbkFpbTJZZGhDYmdsMWdrYnlBQm40UWZnSkw0TTRSbFhEY2dadGpGdTRW?=
 =?utf-8?B?RkNNRW5lNWhXUWYraTZGSmxJVTVEKzU3Rjk3STFSVWZIdjVNWGhPOFY3NFB3?=
 =?utf-8?B?RXFrWE9zSlJMb3VERS9uaExINXJkWGxmMXhPejZFOXM3UU9jSjg2c1FCa29I?=
 =?utf-8?B?V2ZpWi9MTFppZC84RGRicDhmMUhiQitXOHlsUmQ3U2NVWkdkNUlkcmFsbHU5?=
 =?utf-8?B?aWJGTElsZVlpR1N4M2VBZytoaTFpUXduQWQzc2FnMkZFek9hZDh5MlVKV0F2?=
 =?utf-8?B?em8zNlBYa0g5WWdyejBzWUNZSkE4Rm14cEFVSTFDOHp5Zjh6dmpnUTZxYUIv?=
 =?utf-8?B?SWQ4dWdKdFIzUnZZUTFYNmtyN0dWVzZrSE1ZeUdrUFVJNDRERDhVSlJqRDgx?=
 =?utf-8?B?Q2FQdzkyeVkzQWN1SXZQSmNRNFZkcFBkOUQzU29JSUEwb3E5QjdlYkVMSHFB?=
 =?utf-8?B?d2N3TVJoM01obzYrWEFxeEl1WVgvNGJyMjJwU21wZjBEeGdRNXZUNlFCbi9T?=
 =?utf-8?B?dytaeWdLL2w4RGl4eGphYzVwV0tialJLSVdDVXV3cUdrR3lDNG9HbG81SDFZ?=
 =?utf-8?B?UUlJdE5Kd2FsQW80NEk4eXNzZFBuNk94Z2FJKzVIRGdxOXF0dWdGOWxuMHZt?=
 =?utf-8?B?Z1pCcjVvWXdwSFRyQ0htalZpU3MvRTVjYWF4UC84QVpITmJwUUxkZnIvL1gv?=
 =?utf-8?B?UXhuMzVOUG5ScmxJTGdPYzNvN0lXbXdPMXl5aUw5UUo0ZWpUcUVGMzFLSndR?=
 =?utf-8?B?MzZ6bzRkSkJMWWJCUlkzTUlmeEY0OTFaK2lpUWd4UGFONVBtUy84QWo5Znhk?=
 =?utf-8?B?ZVlmSzFVMEh4QUJiUTRmSkpoa2RsRXdQUWZHajB2ZkJtMFRLTk1nS0JMY1NR?=
 =?utf-8?B?aEQ2UHZ1czNORmhXL3dKT3d0SEFQaTE5OWI1blpiaU5xazZTUHdOOWJ3S0JS?=
 =?utf-8?B?MDJlOE9pS0UvVDUvNHVIdlRVM2lqQVo3VnNVanFKb3IxOEt5VGtVdk9ZRTRB?=
 =?utf-8?B?dmtYNjAvdjNQY3JZa0FTY01oQUFjaVZ5NExvN1BacjNVdFpFWHR5aEwwenl4?=
 =?utf-8?B?aWtkUHh3QUd6akdzODJURkRiN3ZRV3dPN0lrYmRQNG16NVQ2SmZMV0QzY1kx?=
 =?utf-8?B?Q0xpeURnZzZmcnlIOEUzWDVsZ1pzdGVtMTVsRDIyQjZKYjJaTjZPVjNQT3BX?=
 =?utf-8?B?UW1ZUzg1ZXJuK21TUTVrc3VCT2FicDZFcS82MGQwdDl5dGs1MmFEc0FCNVdx?=
 =?utf-8?B?UjdVOWJnRlQ2MmlOSTlmcTNlWjY2T2ZSaHFWaENqV0VlamdPd2pFYlplQVFQ?=
 =?utf-8?B?Z0kydVpGTTVpQnZ6QTl3V2pxbEp6RVVCZUYrVlFtdEhBcmNqYkxzR05lMWY0?=
 =?utf-8?B?TFNrZGNobm1NRWZIV29ldmtSaXRTRUNkZ2o4OGhyZ3Z3ZjBPTndhd0xhQi9C?=
 =?utf-8?B?a25BWEZDbStaQzJSL3I5eFhaTXkwUHFJTFR2OTRCVisvOXFNcWcya0crYzBN?=
 =?utf-8?B?ZGowY0hrZ3hZTENMM2FFa2NwUkZkaitZUlpmbzdFYmg1WlZTQWt3YnFWUjBx?=
 =?utf-8?Q?B/qR0rI5NpnodSAtMnpCy+xfG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef309e5-2eb8-4dd6-c855-08dc71183bce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:40:07.7728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VxOmnMbpcO4F1TG/MeLoGivrIK4w6WfJVlMbEigK48Z9+fnwrDsw6E5Fy/RvBso4pWA//jX83PV1NgaMC3qFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6127

On 5/10/2024 12:29, Andy Shevchenko wrote:
> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>>> On Fri, May 10, 2024 at 6:10 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenovo
>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC address
>>>>> space:
>>>>>
>>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [EmbeddedControl] (20230628/evregion-130)
>>>>>
>>>>> This happens because the EC driver only registers the EC address space
>>>>> handler for operation regions defined in the EC device scope of the
>>>>> ACPI namespace while the operation region being accessed by the _DSM
>>>>> in question is located beyond that scope.
>>>>>
>>>>> To address this, modify the ACPI EC driver to install the EC address
>>>>> space handler at the root of the ACPI namespace.
>>>>>
>>>>> Note that this change is consistent with some examples in the ACPI
>>>>> specification in which EC operation regions located outside the EC
>>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
>>>>> so the current behavior of the EC driver is arguably questionable.
>>>> Hi,
>>>>
>>>> the patch itself looks good to me, but i wonder what happens if multiple
>>>> ACPI EC devices are present. How would we handle such a situation?
>>> I'm wondering if this is a theoretical question or do you have any
>>> existing or planned systems in mind?
>>>
>>> ec_read(), ec_write() and ec_transaction() use only the first EC that
>>> has been found anyway.
>>
>> Its a theoretical question, i do not know of any systems which have more than
>> one ACPI EC device.
> 
> The specification is clear about this case in the "ACPI Embedded Controller
> Interface Specification":
> 
>   "The ACPI standard supports multiple embedded controllers in a system,
>    each with its own resources. Each embedded controller has a flat
>    byte-addressable I/O space, currently defined as 256 bytes."
> 
> However, I haven't checked deeper, so it might be a leftover in the documentation.
> 
> The OperationRegion() has no reference to the EC (or in general, device) which
> we need to speak to. The only possibility to declare OpRegion() for the second+
> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specification
> supports 2+ ECs, it doesn't support OpRegion():s for them under the same
> RegionSpace.
> 
> That said, the commit message might be extended to summarize this, but at
> the same time I see no way how this series can break anything even in 2+ ECs
> environments.

It's deviating from the patch, but in practice /why/ would you even want 
to have a design with two ECs?  In general that is going to mean a much 
more complex state machine with synchronizing the interaction between 
both of them and the host.

Understanding the benefit of such a design might make it easier to 
hypothesize impacts.

> 
>> This patch would prevent any ACPI ECs other than the first one from probing,
>> since they would fail to register their address space handler.
>> I am just curious if/how we want to handle such situations.
> 


