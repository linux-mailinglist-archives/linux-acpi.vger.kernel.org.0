Return-Path: <linux-acpi+bounces-12531-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB0A7503C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 19:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9483B9DED
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B961DE8BF;
	Fri, 28 Mar 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RgCSwkTX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418E81D86ED;
	Fri, 28 Mar 2025 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743185628; cv=fail; b=D9c/Metvk/tefHYzdp93Kdz0tln1uc/DoYqRiCk6wuxPqW+zxQVZHKgfZ92Q7SYwnl933g9ysBgIkm7tGTzrQw5u2r9BU2N6R5v21vfqEDEtmkCvbgyg7fcuMBeKZlU1UtRdpGnodiGlHodXIdcuzN73iGv57bXeL2xLYwejza4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743185628; c=relaxed/simple;
	bh=h7v/+wRl+7PKr5y4GTfRZLgxSlxV8dokVkZ+f4jLHdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s4SZS700zJ1F+HRpUP5BhquEVn+8ImvBxmzdhkJD6N3ruQMqNV6L2dmC/QK0i/4dfjR1uxwSLBuneB/p4qPn6v7600Uxb7SXpDT7IOriZcxXdmqpwEkZ0nDH1JsiSiYpbQwgoMkZp7scZXc9tGu5kjl05XQKkO3V66okTm/Tj64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RgCSwkTX; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMSxbL4R11VnBS6qDs/uQNsX74XoLTJ0woHRKzLE9Ck1gJOjvv/Q6Fmp80dnsmrNwhkJmXUMDZUEIArO6IOvbO9Aob5sR5QChGTOJVzOOzZK56+8tvzDg7VN8+SjRY1Go6qjDZxPDeUN8glLY9O2Q79cprhB1DYhOrwiPXQYJceocfuDoej0QoO1lj3Dyw2lkCLmpHkuWdDyGNBdYpcBbpv+dqL/2JOEBUHsWHQx6PIIOa0JLzNLL7ZejmGhgGhByif6+fs47puxebHlPFYJgoNGkWCAPq8ZkGUfnlYAl8xuZ6llZyMd508oUmkuwwqldNN4/mBnkA2cYxAgNVp/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoo6zXykTjqIV62pG6ZJsvkLHnvAHZuPdk+KX/qt9FM=;
 b=sp6b3SQKi8MvbqeyzTmgnGE3BoKG+zf086cM4Zm3srqMscp5kt3AsOTq2uiCxE1yEudJmMCKW4w9xN8NYkVlowfl1ATPwJ6D82V6d9tutNaGf1DQ630vttY9D76iNc8jaEtjEfsR1A6RXTDHA2wvvdul/glbVBcMfV1ALfG4je3xEP/KL6a6J9TWZanN0hQ9EIGjgIXpSs8LEihD/Xn6g3UUr6TzfloYMgOj/Mc+rrEMIzfkVxbLVXRjsvFXq3P4J4PuwRq+qBeUT4Yokt3RTjmeakHD/KQMM9shSOe9uQppzQeCF63wzRR+2qOkIxKXZqEU5aPo85KgUORp9CgaHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoo6zXykTjqIV62pG6ZJsvkLHnvAHZuPdk+KX/qt9FM=;
 b=RgCSwkTX8l6CFmUNoGETXNKINElIYjUngtoaNTsKDJXftQiKyGXCFRDPoVxZOu2d9XJvJZlD0lR4PZbsxz2hSaqUAqsZMeOHPM2BIAFteoum7NSfAsSlbxgyN73NwZjUlHYFzq8jaFtiFk/XYalcR6nQibQb3ei/5EOjn8icLy4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:13:44 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 18:13:43 +0000
Message-ID: <64bb7ed2-da3c-425a-91ec-983bea4fffa9@amd.com>
Date: Fri, 28 Mar 2025 13:13:41 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Gergo Koteles <soyer@irl.hu>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Hung <alex.hung@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
References: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
 <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
 <efae4aa5-29e4-4811-a91a-3f6182ccbe65@amd.com>
 <5f1cf1544eeeefaa8a3e48478e0c019f1a42304d.camel@irl.hu>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5f1cf1544eeeefaa8a3e48478e0c019f1a42304d.camel@irl.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:806:a7::25) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f7d315-7ec7-4f8d-f5c0-08dd6e24465c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHJZK2JvY1dIdmozN3UySXh0RzExdXI2QjRtZnVUanZzMEpmS0krZWZEcFZi?=
 =?utf-8?B?a2lnYmpUekVvSW9RbWE4dC9GYzhWRW83SlJxRjIzK3hpZ3c4ZDFlckdraTFJ?=
 =?utf-8?B?R3RyLytyZnBLeFQxQjhZT0NCMW1JamloaUdFelk2NU1IaHBqMG1MS2R5amQy?=
 =?utf-8?B?MHA0RjlUZjNZRHlhamZiV2ZpVWRrY3o0R2lTb210N0d6enpnN252QlhBSlNj?=
 =?utf-8?B?NE41R2FKUVN1RHBBVkJLQ1BzNmlSYkZXTTZCeWV6bVNpaGdWUEtzUzJ4Wk1F?=
 =?utf-8?B?Rk5sZGdTNWlXZDFQMkxya1EyUS8xdjZsWVRrS3FZZm5DV0RhNFlaTFpDeFd0?=
 =?utf-8?B?M2lIQ1hzNnRYV3dXSHhiMklnRDBieUZJUm9TalZZRW1TSXZQa2tZQlJJbVZ5?=
 =?utf-8?B?WWp4UXE0Z1lTU1RpVXBia0pnNnJnd3ZXSSszVmtNWVlUYnNmU0tMTG50eWRC?=
 =?utf-8?B?bU1WdW80T0FwWUhqYjBjRkdqZ2ZtcHIxTU9WNUZ1Yk1zMFRFRHhySGFpVHUr?=
 =?utf-8?B?Zkp3NHlTSDl1VnFNbFVPelY0cTBIQU85ZDFQRDZjTmdhU1lOLzJyQ0F0OTUz?=
 =?utf-8?B?M1lyTFVsc2tYdTB1bjErZGFhN3d3cHRoWGsvNHFRTFl0bVhtMXlOMDdkM3pj?=
 =?utf-8?B?Tis4MS9VdWZKekgrVzZTQVMxMWwwOHdWNjlGYXhMSi9RaXY5Y2hPNjRUUE5q?=
 =?utf-8?B?K3BrN2dFdnhLdzVpcFg1QUJrQ2FzeU45QU96dXl0MmlqTG53VUh5U3N6NGNO?=
 =?utf-8?B?WnlUVGxlSUNwYW9kcDd6eUZIQ1pFN1dweVhhYVN1L1cvZTlueXpQU21WV3NH?=
 =?utf-8?B?dUdtTDhoUmt1eDNHQXFlSFdrejMwWERaNVZXSGRrNjBvTkE4V0o0aFI4Yzg3?=
 =?utf-8?B?Nk82VEZOMk0xakRFdlpmeUIzdUF6VUhSN05OOFMwY25sV21ZamxJU2dEdDhE?=
 =?utf-8?B?TjJtd3k1cHA4RGh6akh2ZXFZODhTaWJyQlY2UG5JanF1Z2NtaWIwMlpGS1ll?=
 =?utf-8?B?NG42MjJPcmNYbEE4azFkR2tkZTVuQStaeDBUcHlINjFVUkdjV1ZXMDRmNmpV?=
 =?utf-8?B?VUVqcmF6QzU3T1M2Nis3WHpxY3FITVdkNEVTUDBRcmhzODA3R1VhNjc3UW5K?=
 =?utf-8?B?b3ZiV3FKVUVlYXQ4cGJIWUNKTmlVV05Tb3REUHdvLyt3anFGUVBsSW9pQkc2?=
 =?utf-8?B?Nkx6RnFTSmtiNlA1T0FKbXduT0ZOSWJqdEdNZEFZajVXWHpqMU1qZDNBS3No?=
 =?utf-8?B?eDNuaDlsd1RieEpYcHNSYlZUS0VYcm5HdG1Ld3VGRCtPNDV5ZjA1amVRVCs3?=
 =?utf-8?B?eWUxV0dEQmkyNzgzRVp3RzFCS0RCOWU0WnMwTUw2c29SSVREUkV1alVGWGNm?=
 =?utf-8?B?V1NwZFBFZjFNRWhwV2dWbC9yL2RBYXFvejhFOWp2R2lPSTR0ZVIzM01XTnpH?=
 =?utf-8?B?aitqRHdheEpONGErRGZlWmc2SWc1ZDhrVEw1UEMwNnpMVUpIYU9sYTZndlRh?=
 =?utf-8?B?Smd0VzlSRm9vT3V6bjFNUWU5eFpoMnMya0gxT2xPc1NUMkdGSTZVd0VIUHB2?=
 =?utf-8?B?bnVOVGhWWnZQME1xWVFNOUh1enFXN0hUR3k3VnVLL1pZam1zNjJXeXNnVE5E?=
 =?utf-8?B?cklrdTY3M3hTWjlrN2FSVUJFa1hVL1RKUnZJK01qTG9NMitCR0Y4SzFsN0M4?=
 =?utf-8?B?NHBZZ3BIY0ZEZlNJeExaR3hLajkzUTg2M3pJcXRKMkZ6N1gwcDA2a09LSW1o?=
 =?utf-8?B?S2hXRzVxaHBGVVJQQkJoWlJjaEFQVnliUUxJalo4eityODBRREpNVkgydzAz?=
 =?utf-8?Q?W1ML1Coa4aVSe8gdBjAY9d4m28FeWaGLb9QjU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajdFb2dxNzg5bElRYkJmZUViU05haFBqRUxXL08rMWNuNFZaQW1EK2V6bERE?=
 =?utf-8?B?MWdyRHowYmVtem9wRVJoL2xlOHZqSlVjV0haOTcybzdhbXZSekd5Y2dKVkZX?=
 =?utf-8?B?ZHdCa0RTMWlNUndKOXZZelJnY3F1YzNBaGUvKy82SllzZ2VmMzNCNWZFQkg1?=
 =?utf-8?B?MGpuQks0aUkxWUEvcEZWRjAxdDdHTDY4bWxGY3lLVkFzL2YraGl2eWxUOWVF?=
 =?utf-8?B?Z3UyTzFQVHBuM0RwWmhVSTRTaGZrVVZHZFJER1Zuam5uSXh5UU9nZnlwNlpu?=
 =?utf-8?B?SklSWDNTNDlscCtYZFJWNUZyRFhMK2Zjb0c2eitsM0hLajJ4OUh4REFKczZ3?=
 =?utf-8?B?c0RxMFFVd1hMc2pXZnhHTHpVdGIwZ3N4OC9SSWJvaC8rZFVWdTJuSHVxTmdw?=
 =?utf-8?B?SHJ5ZFkyN1duZFQ5R1VkNy9KRXI2M1BHeWd4akJXdTE5ZWRJSGtyNUR2YUw5?=
 =?utf-8?B?L2NmYnJ6WTJ3RWZUQjQ1SWpkem1rTURiUmJNOFVYdTFHWXhhTTRtWnRKY0R4?=
 =?utf-8?B?MHRvclFDWXkrQUpDMFRzTGpLSVJobkJGR0d5OWVXL3ZPSVhyTU00RUJSeVFQ?=
 =?utf-8?B?cGhwNXh6L1c0R3AwK3pQQmU2WVNGcDdCSTNiMUs1TWZ0OUVmZndVMk5YZlNJ?=
 =?utf-8?B?TVY3Q3ZiaFNySEx2d2JmQ3FoNzlBdG1BRHZlUnRxV2dia1VvVFNDZkY5dGZQ?=
 =?utf-8?B?b1ZiUnd3V1JHbHNHTjloUTBLa3lOTTNqd040VGpXaXNpano3TXlmQkt4djNG?=
 =?utf-8?B?YUlYVWJKdmFXUG5xT2tkNitrNlJIaGI5ai9xTVd5NmpubHhKaVNlSW5zN1VH?=
 =?utf-8?B?RCt6eGdybSsrbjNSVGlzNVNtbzlYaTJlVVMxczBvN3dhdWNmK0oyT1VSa2FZ?=
 =?utf-8?B?bkptYmhaU1hISTR6NFV3VGkrSTh5dVV1UUpSU1lyMVpzMndGeUV6bGxQSXNI?=
 =?utf-8?B?RzRXM2dMT3k3eTI0b0dWKzVXbW1yRTB1WXBSc0YwdkdjU2FGY2lGakhqN2xq?=
 =?utf-8?B?N0M5QXlsVldPWitaRlI3S002c0lkVDk2d2JrUlJZVjFidWovQ1pRY01Ma0lp?=
 =?utf-8?B?ek9WK0I5V20xSVNaTHpFVys0cDBicy9vSE54Wk5ybnMrUlJCeUoyek8rdnVS?=
 =?utf-8?B?a1R4TUtqSkxPWk1ueHh6QStoRHNUVHA5TWdaSHZ6SHlMMGxVSnVVbTBPanp5?=
 =?utf-8?B?cjR4Y3lBMGMxSU5Rb1VMTWlta295T21VVU95cnFjQkxiUGZYME9udktQbnI5?=
 =?utf-8?B?a0lCMk1vRG5mMzNRL3crRVg0SWx6aFA5RXhyR3lYNmc2QjRKdkp6c1Z2cHpV?=
 =?utf-8?B?R0VVbmg2RlpPcU9KTE9pNS96RXVJL0E3TWtNa3lENXRrRmFsdk1jWGZaSFNh?=
 =?utf-8?B?S3VEYzBjV3JvOVNtMjlaS1JlYnBUTHdWS2UrWDNaYXJ0Z1RaWTg0TXZvV2JW?=
 =?utf-8?B?b3EzeG1sSDRQSG9iUU1CN1dYcXA4dTVEQnV0WmxqN0dlNXBEa1hPVzRuTGVa?=
 =?utf-8?B?dFZwcFpoMSswTVZncUlQSmtGa203M1YvZUN2V0hXV3p2dGZNT2k5b0hhSE5Q?=
 =?utf-8?B?NnFJTEp2WWcyeElkNUdMaGJuVTB2YW9VeXVtUG95ZUs2ancybzdOckZHcmJG?=
 =?utf-8?B?MXdoQTdLdDVIbytVS0JiM2lFUzZ1TzZFYjlUbVhVQnpOVjIxek1DRmJBZXlv?=
 =?utf-8?B?YnkvV3NISEI4ck1VejJ2YU1Fako5OWY0QmFaL3A1akxZb0RkVTVQeTJTS2p0?=
 =?utf-8?B?YVFtdk40bDdHQmsrU2pXTlVJWmo3bEN1bTBsMGxDYTFBRlZhSk1zS3V2SDZX?=
 =?utf-8?B?N1hEK1cwQjR6VHNTMFRDM3dITFQ4UEdOY1ZyaVZXMy9iR1c4UmlwY0x0UmNI?=
 =?utf-8?B?cGZhSTNNSE5CdkowWGwyR1R6TTI0SGxwT2Z6cWhBcVNjbEJCQm1HUUplQzBX?=
 =?utf-8?B?cUd2Z0w3Sld5NnZZTlRMWlpZSnBwbmphSW1tOVh4MjBaR21JSy9qWUtjWHZv?=
 =?utf-8?B?cytFc08xVStKdXplNEZqSFQraHBsem9oNXJVNm9CZnQ1RmZ3NGVJT0Fwc0ho?=
 =?utf-8?B?NmxpY0VkSG14RG5YZWFPV0s3Z25RR0tGZ1FEcENOdFVaNFh4eUNTOFNnZEky?=
 =?utf-8?Q?PKY+Q9qAco57mLR1D43YSx10+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f7d315-7ec7-4f8d-f5c0-08dd6e24465c
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:13:43.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KvYaSWpF39lzavWBXsSAZetuh2tRf5X4b3L2Tl/ki+dQUBtYI2q+YdlXWIchJcR0LVU22OvQlRbd8naWSo/a4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209

On 3/28/2025 13:10, Gergo Koteles wrote:
> Hi Mario,
> 
> Thanks for the suggestions!
> 
> On Fri, 2025-03-28 at 08:42 -0500, Mario Limonciello wrote:
>> On 3/28/2025 06:12, Rafael J. Wysocki wrote:
>>> CC: Hans
>>>
>>> On Fri, Mar 28, 2025 at 3:51 AM Gergo Koteles <soyer@irl.hu> wrote:
>>>>
>>>> Some Lenovo laptops incorrectly return EDID as
>>>> buffer in ACPI package (instead of just a buffer)
>>>> when calling _DDC.
>>>>
>>>> Calling _DDC generates this ACPI Warning:
>>>> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
>>>> found Package, expected Integer/Buffer (20240827/nspredef-254)
>>>>
>>>> Use the first element of the package to get the EDID buffer.
>>>>
>>>> The DSDT:
>>>>
>>>> Name (AUOP, Package (0x01)
>>>> {
>>>>           Buffer (0x80)
>>>>           {
>>>>           ...
>>>>           }
>>>> })
>>>>
>>>> ...
>>>>
>>>> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
>>>> {
>>>>           If ((PAID == AUID))
>>>>           {
>>>>                   Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>>>>           }
>>>>           ElseIf ((PAID == IVID))
>>>>           {
>>>>                   Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>>>>           }
>>>>           ElseIf ((PAID == BOID))
>>>>           {
>>>>                   Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>>>>           }
>>>>           ElseIf ((PAID == SAID))
>>>>           {
>>>>                   Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>>>>           }
>>>>
>>>>           Return (Zero)
>>>> }
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if available for eDP")
>>>> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
>>>> Signed-off-by: Gergo Koteles <soyer@irl.hu>
>>
>> FWIW the ACPI spec is clear that this /should/ be an ACPI buffer.
>>
>> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extensions/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
>>
>> That being said this is production firmware and in the wild, I don't
>> personally see a problem with handling it this way.
>>
>> Some other improvement suggestion though below.
>>
>>>> ---
>>>>    drivers/acpi/acpi_video.c | 5 ++++-
>>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>>>> index efdadc74e3f4..65cf36796506 100644
>>>> --- a/drivers/acpi/acpi_video.c
>>>> +++ b/drivers/acpi/acpi_video.c
>>>> @@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>>>
>>>>           obj = buffer.pointer;
>>>>
>>>> +       if (obj && obj->type == ACPI_TYPE_PACKAGE && obj->package.count == 1)
>>>> +               obj = &obj->package.elements[0];
>>>> +
>>
>> As the ACPI spec indicates this should be a buffer, I think it's a good
>> idea to emit a FW_BUG message here so that this can be detected by users
>> and tools like FWTS and the firmware can be improved in the future.
>>
>> Something like this:
>>
>> if (condition) {
>> 	pr_info(FW_BUG "EDID was found in ACPI package instead of ACPI buffer");
>> 	obj = &obj->package.elements[0];
>> }
>>
> 
> An ACPI Warning is currently being generated:
> 
> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - found
> Package, expected Integer/Buffer (20240827/nspredef-254)
> 
> This is also noticed by FWTS in the form of KlogAcpiReturnTypeMismatch
> and may be noticed by users as well.
> 
> I think it is unnecessary to emit two warnings for the same problem.
> 
> However, some comments could make the code clearer. I will add some
> comments to V2.

Ah yes; if this warning is already being emitted no extra FW_BUG is needed.

Sounds good on comments for v2.

You might also reference the ACPI spec in your commit message in v2.

> 
> 
>>>>           if (obj && obj->type == ACPI_TYPE_BUFFER) {
>>>>                   *edid = kmemdup(obj->buffer.pointer, obj->buffer.length, GFP_KERNEL);
>>>>                   ret = *edid ? obj->buffer.length : -ENOMEM;
>>>> @@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *device, void **edid, int length
>>>>                   ret = -EFAULT;
>>>>           }
>>>>
>>>> -       kfree(obj);
>>>> +       kfree(buffer.pointer);
>>
>> Any reason for this change?  obj is assigned to buffer.pointer already.
>>
>>>
> 
> In the case of an ACPI package, obj points to the first element of the
> package. The buffer.pointer still points to the original location.

Got it thanks.

> 
> Thanks,
> Gergo
> 


