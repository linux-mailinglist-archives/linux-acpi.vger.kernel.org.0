Return-Path: <linux-acpi+bounces-9424-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A599C1178
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 23:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CB81F226C5
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Nov 2024 22:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA28B21830E;
	Thu,  7 Nov 2024 22:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EVi/IgJn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA1217465;
	Thu,  7 Nov 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017113; cv=fail; b=PG+VGqmNikmqjNbfyCbWHyrYrxGNLGNctnThdLFmkXpqRkmjVaQoHQaagxZlkm9DKKO34zJPAZUf+QzzMCa9yd05FlhvTOh6k51ct/ya0MqAgd4vsCq+QK4Pb55TIWvce8hDh51YmJCq7pvGyQw58XOd92LJFxzDEbwVGCWqu9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017113; c=relaxed/simple;
	bh=Db0gKfbB9k19Ak+Rr9HHkiLcS3asGdPur27Wg1JPx1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQVv3OpvHiPtgSV7LPENh4/+in8tc15m3s6hYx8X3YC+5FVpNaaowo4f2GXaDns6wG7CTmY2uU3zLkftUpO4CRGfQUtZSJguEezc8JvXdYt4RVox0oaQJ1qqx9LOZA7C5RS7UPB58H2iY5zaUPBMv8nBOO0335YX0fJK4HtnLCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EVi/IgJn; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqxN2NF9GG5b/saNVB9tJWk3S8E6fv5bhl1YPYPDxQ6//K9kuRwV0KuwAd9FGTn92OUMWowtqSKzo/uBLNguzT4t03yZhslnS2hbVGiOF4kYwoKJXuhzhmjeXUmGhbFapaeBTwhVzGErAHNqjyYc1gm+dStfSEfh0ushhx/sJwpAnmn1LElEosh2Hn+dbM6bq7nCzoO1svdZs8N7AR0MvTQci2TtxgwY/ORPvR//tW1Dk7S/m8GhXGjywle7tR9EKgNpFCnj8MJXf1U3ddZdgmkqfosVkMhc0s+eg+vgvo5QGG1Pswl4oDDIIYlsT9LRLfTJtzXYPRhC25Vh8IGaxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF35CYqioND6Ghm77pDrZ71mQAnPtXgJsHg0cWOS90E=;
 b=t9FkNkCaMkYxDeVcycZd0ioJaVHuRTl+6QCn+YLbd4RW/s5phG8wBdivyhyYtDzg/0i9C5cVEJgQYbaZAF+KNulgJfdhZX3jhDW698F6o5fuIOTLWoH9G7tshM3dh27Sk56L2my74BNsJl1Wtdn1fLkNXmwWwVchMJP98812UC8ETlMsNlM6T+RF7Iba2nAANdSDYAGlszzSL5pNxRR7v3FHV76diCjowucCYQugAY1NCpApmztF9VLEeF73zTPiG+aNBnaeSK+1l3Z4x6bn7VsBY/J2IKCCcD8K/Oy9FwzsyI+SE9m0L4iJvQbLnl+ViKUUAO+GD0GRyEy2TIwcRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF35CYqioND6Ghm77pDrZ71mQAnPtXgJsHg0cWOS90E=;
 b=EVi/IgJnurDCJgBFwxCuxem2hFwKshDRchbiArbtixhOYixjvapmQviwYXe4jXqP6RUGK1Hzth2S5pzwQ6dFdmHm/Aykk/7tu7m18TxVVA6JI5+VAUe3JxDpjLHplSmvrQesv+PtJNbAxN3ifs2Dxf1BOBRL9iiH9rrLkvWJzVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 22:05:08 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 22:05:08 +0000
Message-ID: <cbdc6ff5-627e-4237-a053-bbf2e77499da@amd.com>
Date: Thu, 7 Nov 2024 16:05:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/20] ACPI: platform_profile: Check all profile
 handler to calculate next
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
 <20241107060254.17615-18-mario.limonciello@amd.com>
 <989e7297-97f9-4d55-be28-78128572fed2@gmx.de>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <989e7297-97f9-4d55-be28-78128572fed2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN1PR12CA0052.namprd12.prod.outlook.com
 (2603:10b6:802:20::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca633c8-7c1f-40f6-8de0-08dcff783e3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkpDbGV4TWhQYjY3bkVvOCsrK3Y0N2lNUGVLUExDd0REdzlCOVBwQ0V0Vm1v?=
 =?utf-8?B?cE5hNURWWkxDRWlYTjZrVG9YRnFWNzBPak1pWGE1SThTdk9oTDVuT2RSNkVG?=
 =?utf-8?B?cVFFYzV2MktKT3Z0YklPeTI5ZjRzYk4vQVgyVXFjMkovQTVDZDVEZDlJNGZy?=
 =?utf-8?B?VEZBMXF6QThyNWZjWUV4emdVQXlaRFl0cVF4NnB4MmgvSE9BMXlPQ0lpT3Rs?=
 =?utf-8?B?MEVxcHh4V25PKzUyQlZYZUF6dVV5V2lYdjh6YUQ3aEdZdzNJelIxcm1DT0Q2?=
 =?utf-8?B?QzJMb1J6QWJUcUNWNmhGcUwzenZGYzVwUDRkcEg2d2wvajcvanRpaHp5ZDJi?=
 =?utf-8?B?U24yd21mYVRwd05IU0ViWmU2dHFoM1pwWllHUHkyT25lVVovRnVvTlEzUTNa?=
 =?utf-8?B?dC9qL2NsLytnWkNzenZQSllXTG9nS2ZjYzBnVHk4UGswZVpWRkNlb2gzRFFl?=
 =?utf-8?B?MnpZQzVpajl5S1MxMTBBOEFiWks0cGtBUzdjS284cGcvbEhpMldPUUdMVXRu?=
 =?utf-8?B?dzlaN2VYaDRiZHJja0c1a20wTHl3c3ZobTZKRDEycE14a3FOVHpWdVJ5SU5R?=
 =?utf-8?B?Z1NGR3VrMkhqNW1PT3ExUU11cnkwR255YmIvVjkrOWhha3JqSVoxMVQ3QVRL?=
 =?utf-8?B?S0tGZ0F6N2xmUEtWaW42SGNxMmNTNk9RRWhxRW1nc3NIZWxzVW9xWXBIcU1o?=
 =?utf-8?B?cWdXYXZnWE02WWJFaUFaWVRjUjRlai9OV3hlTFVVS2cxT3AwSm9BeGlLdUZ6?=
 =?utf-8?B?dmRZT0k5MFZvSTBVN0UwczA2b1d4K2F4VVQ0cStxTEhuMEpXendrRW4xallV?=
 =?utf-8?B?TjBuM05adXJTakdjR2ZtL2wrVzlFZUVZdmhBNUNMTmRua2Z0VUlHU3ZtSzdZ?=
 =?utf-8?B?YkppUGlsWFVRSzhIa0Rhb29lWVhmMG5MRnd3QkwvVWNocm9JMW9aRTA0cWtZ?=
 =?utf-8?B?WjN5ZlVCUmpRZUpvR1poZG9mWUtNVVhCcm5BdDQ4T1pCMmxXU1BqeUo1SVpT?=
 =?utf-8?B?V2ptWXZ0TlZTeXl5R29XZ1U1UWhkQ0Y3YURFdWNGVUNXT09YdG45eEJ0R0kr?=
 =?utf-8?B?bDBzeHUrc3J2MnYxbU16MEpBQndqaWUzaGNtd0FPcWx3WlN1SndNcW1INTcz?=
 =?utf-8?B?TmdYWlF3UE16bTE1emd1Q3J0WUdhRFpDNTFzZ2RvMkpIZVdmYUErT2hQNjZv?=
 =?utf-8?B?ZXAwUEZtMko3OTVZbmNjNEp1MEFWaFM4T0oyVDd5T0R5VEkxZzhDMDZQVXBI?=
 =?utf-8?B?RTV0bWluUEIzRHlqRS9HS2gwL0VDQkVpd04rWllqOHZhU2lqZEFJaGR0UERO?=
 =?utf-8?B?MUZPN3NzbVpSWEdCa1J4ajhQM3hvV0VlSU05QTZCMGZDbUwwdVEvdFNaenRh?=
 =?utf-8?B?Z1BJUzNrZjRiSU5aYnNaUmd5aVFkNXZOaW1PK0ZnOUFadmZ0SGpJcUVJUWhr?=
 =?utf-8?B?NXNQQ1k1UTBMTjJIRklZMHhnU29yUnFjYllZUVB1UERkV3FIalJLTVRwdHNw?=
 =?utf-8?B?TjR4SjBnRXdRdHcvVGRYQkc4eGtXNzI2WFdndjUvTktQUkFERkJrTUdFSXN5?=
 =?utf-8?B?bUFQWmIzYjZQLzhxdVdyRFZCUFFFZ2Z3TE1weXAwU2xPdjJIckdqbzI2UERS?=
 =?utf-8?B?MUdPMitwUVYvejNqNGRabXlVSDgwOXpWcDV5aDJLRm90Z3dacytuMm43MVdK?=
 =?utf-8?B?OFhTVkVaSDlVTzlYYzk0RWJEUGZWU1d0SmJOWEFlMUFxei8yVWNzekpXN2Y4?=
 =?utf-8?Q?WGvfCC1NdjcDpgL4v1Sk4IgiShYb85wV/GUpzUc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zi9hM05IN2FydXorODVvZFRYd01tWW9pSHA2R1dNdTBkKytENFJCbVc0N1dH?=
 =?utf-8?B?L21tMDBGSVhkd0hyRGFPaDY0T1llRFZRK1QydXFmSTZnNE03WldVL3dDR3py?=
 =?utf-8?B?VmQvWHN0QmRBMlgwMVFka2wxTkJiMGEvYTZGMk0yZS9iVVRDMHY4eWg0Vm9J?=
 =?utf-8?B?dU1zbW5KN0YrdDloQnhGYUc3aFIyTG13WVBqME53MkRYNk9vQmpCVEVrOHRD?=
 =?utf-8?B?dE5yOVB2T3d3QXl6SVpzOVEzaWFkYmFrWDNUejdJTUpZRWEzZklvZ2xVbGRl?=
 =?utf-8?B?OHIwcjJ0Q201VUtmQkVyNFJtRzhBN0pndlZGZmdHbmNWUGkyc2pHSS9FTDJt?=
 =?utf-8?B?ZUxiMGNBUHVGM0h4aGo1bksvZDl5YzFTcmdVNTdSbjc1RmtUaDZKamFuL09T?=
 =?utf-8?B?Tk5qZnMrZjZrVzBJSjE5bmFOK3B6Z0s0Si9hVDJaMXRGSml1QkU5dkNDckdF?=
 =?utf-8?B?bGtQVERReFBuVEZiN1gxWEJWTU9PbmxHU2s4dCs0V0xoU0FZM21PLzBvbmRT?=
 =?utf-8?B?dTF5dDNZOUt3Ynd3ck9DSHV3SmwvNEJJVUdWMWdMdVg5Sis5QXRDcDlFeGti?=
 =?utf-8?B?TDE0eTd3UVZ6eGUyaUZSQXdML3dXaENkZ3dsb3g4dGZWZEFBN0pON1hzWm5Z?=
 =?utf-8?B?cWYzZG5zZkJnOU5oK2djdHB1K2kvMW5MdVROZ3o2WFlTREZPSzJuV3IxVXhT?=
 =?utf-8?B?RUZ3TC9HREdjUU1oejV0ZnBIaWxuYk9hWGZ3akk2aFZMcGVPZlJ3YVNaNlV4?=
 =?utf-8?B?QlJaZkJ6U05vUktvQk1jdldrWDc3blRZNXE3dmppb1hEejJibUVQWDZDK0lF?=
 =?utf-8?B?TlB0Z2VGSjF2d2hkc0dWaGpwb0dmNTVjcGsybzVXZ0FMMTU5WUR6NmE1dnFI?=
 =?utf-8?B?V1FNQUxUbE9pOGgzU1hTYjFIaWhqUGRiMmt3OEoxQmlMcTdvUTFxRWxzMTZU?=
 =?utf-8?B?UVpRcUJyOVZwSU9IeG1JSy9CWEJCcDAxdEk4ZSt1Q1Iwa1orajdpVkh5VWtj?=
 =?utf-8?B?WmwwMEhEVWNMR21Ncy95WjFZMlVBRkI1K1VEcnFXdzM5ZXRvTldFdEJJWXVV?=
 =?utf-8?B?S1RMZmkvMEN2VFVjcVBKM2NVM0xpdXNrWitEa1ZHaVBRTTd1clcvSmtibGsx?=
 =?utf-8?B?dytjaFlPSkYyeFJLK2VJRlJtaXJYODhLMmQ1V2YvakxiWituRUFOWWt1cjZ0?=
 =?utf-8?B?LzhhQUxzc0RXUjIrdkY1dnl4Z2duUTNxSlVOK1hUbnEvRGt1eVpuTUNHUWFh?=
 =?utf-8?B?WFZJVVdwNU9CNEZRQ3N3VnpWWU1LMWdLVFl3WHkxRExkdEVlcGtUMWloY3hJ?=
 =?utf-8?B?aUMzTE1iaFkrZnpzVzR0aVY5N2IvelVjb040eUcwT1NjRVlTME5LSGk0Vno5?=
 =?utf-8?B?WHArK2wydkpodjlmQm9qK1JCL1RETkZtOGFhZkpIYWpQR3JGQ25adXBtME44?=
 =?utf-8?B?QWx5VWUvZit0T1I4amY2RU13T3Q3R01jMU0vYkNodEJCRlE3UVM2V2F6bWlD?=
 =?utf-8?B?WDRjN0I2Z0dsRS9uTDE1T3BEb0k4UW1WMkNJTDhLNi9aNXEvUnRkZmVyNkVk?=
 =?utf-8?B?dngyYzJ6SGdHeUcybkM2YlkrNVdWbjBzTEcvcm84ZWJrbkgvbVJTQ2VtN3Fx?=
 =?utf-8?B?bFNZejVjWUVxYTRzaDRsNldIeFkyTlU2TTRPY3R4QWZmakZPb0VTOFpRZU1P?=
 =?utf-8?B?azkxWXhMaXdtME00YnpOWnp0bjlLMi9VWHVweGZlQnB6L2pqYTROMzZwWU5O?=
 =?utf-8?B?aG1BZmIrOHptVElNT2NNQXhVY1NPdld4R1VFRG8vMFdFakUwNE1uZWxTeW1R?=
 =?utf-8?B?Q3JrQU1ndWgwTHlGek9Ydm9hZ29VZVBmdURxUkpzUjRxWlhNbndzLzFPdFFB?=
 =?utf-8?B?NVRkVEY2eDVGanlHNTFZSTlMRWF4TnlNQzRPNXl1S01wV0JRY0hMZHQzVXN6?=
 =?utf-8?B?MnZSM3dKVG5TOVh1ekxQRlpBcXVwV2p3TmRRTk44UTEyb2gwZ0dtN2RuM0dY?=
 =?utf-8?B?N0NGTklrdHRwZGxQSyttZnlucVlZVktTaEk0dU5XUDFYU3NybVlZZFV6MGtj?=
 =?utf-8?B?Y01aNjhVUFN0Q3R6UU9zbmRvbm5ENkNOMTNSOUFoNmhJYUgvZnUrUFQ0aHV1?=
 =?utf-8?Q?fPHsYKfY3GX3ZFcK3i0k51qtI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca633c8-7c1f-40f6-8de0-08dcff783e3a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 22:05:08.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRMqdOheXYl5IpMwSVCypFWS7kt22MUnWXsXmiSlq71PyyLAW50og25wh8Ti9ovh1Gm3IHI/iCsij5821ia3Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857

On 11/7/2024 02:58, Armin Wolf wrote:
> Am 07.11.24 um 07:02 schrieb Mario Limonciello:
> 
>> As multiple platform profile handlers might not all support the same
>> profile, cycling to the next profile could have a different result
>> depending on what handler are registered.
>>
>> Check what is active and supported by all handlers to decide what
>> to do.
>>
>> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v5:
>>   * Adjust mutex use
>> ---
>>   drivers/acpi/platform_profile.c | 23 ++++++++++++++---------
>>   1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/ 
>> platform_profile.c
>> index 7f302ac4d3779..2c466f2d16b42 100644
>> --- a/drivers/acpi/platform_profile.c
>> +++ b/drivers/acpi/platform_profile.c
>> @@ -411,34 +411,39 @@ EXPORT_SYMBOL_GPL(platform_profile_notify);
>>
>>   int platform_profile_cycle(void)
>>   {
>> +    enum platform_profile_option next = PLATFORM_PROFILE_LAST;
>>       enum platform_profile_option profile;
>> -    enum platform_profile_option next;
>> +    unsigned long choices;
>>       int err;
>>
>>       if (!class_is_registered(&platform_profile_class))
>>           return -ENODEV;
>>
>>       scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
>> -        if (!cur_profile)
>> -            return -ENODEV;
>> +        err = class_for_each_device(&platform_profile_class, NULL,
>> +                        &profile, _aggregate_profiles);
>> +        if (err)
>> +            return err;
>>
>> -        err = cur_profile->profile_get(cur_profile, &profile);
>> +        err = class_for_each_device(&platform_profile_class, NULL,
>> +                        &choices, _aggregate_choices);
>>           if (err)
>>               return err;
>>
>> -        next = find_next_bit_wrap(cur_profile->choices, 
>> PLATFORM_PROFILE_LAST,
>> +        next = find_next_bit_wrap(&choices,
>> +                      PLATFORM_PROFILE_LAST,
>>                         profile + 1);
> 
> Could it be that this would lead to be "custom" profile being selected 
> under some conditions?

Yeah, you're right.  If all drivers supported custom then this could 
happen.  I'll clear custom like this:

		choices &= ~BIT(PLATFORM_PROFILE_CUSTOM);

> Also _aggregate_profiles() expects profile to be initialized with 
> PLATFORM_PROFILE_LAST.

Will correct initialization in platform_profile_cycle() to this.

	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;

But this also raises a good point.  If _aggregate_profiles() returns
custom then this should be an error because next profile is undefined.
So I'll catch that like this.
		err = class_for_each_device()
		if (err)
			return err;
		if (profile == PLATFORM_PROFILE_CUSTOM)
			return -EINVAL;
> 
> Thanks,
> Armin Wolf
> 
>>
>> -        if (WARN_ON(next == PLATFORM_PROFILE_LAST))
>> -            return -EINVAL;
>> +        err = class_for_each_device(&platform_profile_class, NULL, 
>> &next,
>> +                        _store_class_profile);
>>
>> -        err = cur_profile->profile_set(cur_profile, next);
>>           if (err)
>>               return err;
>>       }
>>
>>       sysfs_notify(acpi_kobj, NULL, "platform_profile");
>> -    return 0;
>> +
>> +    return err;
>>   }
>>   EXPORT_SYMBOL_GPL(platform_profile_cycle);
>>


