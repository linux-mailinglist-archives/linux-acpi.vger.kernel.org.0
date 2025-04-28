Return-Path: <linux-acpi+bounces-13339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28142A9F937
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 21:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872F24648A6
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Apr 2025 19:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8C32973A4;
	Mon, 28 Apr 2025 19:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gY3N7xz1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9BC8C1E;
	Mon, 28 Apr 2025 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867466; cv=fail; b=rgW1zjj7kjhNWyIWRkbTG6yfA6/8jdz6CGqknkL9el8T9NlgW13BAyt0kr2QVqjpHbjEtYa9xJec8XFYFVg08cdRhduiqVrpX3ra5VYpqoTk/GLz3rVrIwmAJD7SxGqhkYOuPqYUJzLTc9nkbWgJQKkra3HCjpMP4Koz34w4RR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867466; c=relaxed/simple;
	bh=tiLv9+NLFGhdFNOgdo9/X5SQ8UxZCRc5ITYlvWSrrxM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7mHCQt3s56Y8kdK56Tp2xd7gPVMezWqWWUmXwPcAVRfZ2ZHsmEBMF8lxuKnAPyB4NHer6IysmvvcQ/6NOUoosLb+cWrNIu5/S/pobgb034J++zUeZmT3giz5pxrkfqZ2f1dxP9zEeU4If+EGGBWWrmvY33Sr0Fa8dCK1arE/lU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gY3N7xz1; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOtHUcLijbEiGw3Cs52lv8SR/GMG1MUS27TlZY78q9tJOKwpSBErvWDCagdvDrL+I0a2H0NYSZwKQRa0SK8MPM3X9NhjpUcZD/JKcERWnPmHzA4Cszf+9GWJ9bRMJcty1vi9BHHoQfK58UpHIZROw0ZbJKSzPz9NJ7wUi/OwQlqHINbmu+yMPOcpmKsgM5MSvZRXyU0eNFVlvupkbQt4dbJVBLzUDhnwqD1Hevwui4gCis9Ut7Pt+Hw0OlP91cqGxPV3abXAxfy8/3sFKZOfB0JRkY0xAe2BR5E/HUHJPFXXHqt6eM42bGGebHm0eiyCwooLfQ0RcCmhjCZt/MbUng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FAfob/+2v17uI/YxmVKQwPl2KA7SHy1gcuqLD8xwE0=;
 b=ySDtkAoUg4feDL7qBLUcQWMQxq209zfTUPy2FSoBwexLWCrA+m0j0lKUmQxGyNblWCV/uJ0q5SLYYEKVCDz3CYJCKt2VCTW4iRYd7kvCUeBDSxIvqK7rsVocezjBfQUuMnPhhNhK0ozWzZjXu4nukJdBV4Sl+TiVz3FWD0AlfeTrcr4cw21is0A74y2Hnp0fIWLcQaapLCTTXeaYpPwNARh8xUlpoVM+dtMFGcIsYq+wtxgw45gV57dPbxA8MfnLjSHHpfzIN3Omn+l4DAo92tfq0/H+HM1XS9w8XEKs0JsojADj4E/FEyw1A6GA7wQNQv5Aufs1sJSJHPOgxfemNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FAfob/+2v17uI/YxmVKQwPl2KA7SHy1gcuqLD8xwE0=;
 b=gY3N7xz1wB7qhp8T+YylrUw9ikPJpv7FxLztMKEKtJ3B6v64Zzldswk/M/fgGNmGnB4vCNFFzukB1A+rps8CH2XZiH5bVKMOfM3+qcPX7R1NegiTj7TCMRj0p1Ff9CNDx6dXKg0rX5ZYUpXYIL332ZM2j0b9iUV8ozCJ4uWa5b8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DS7PR12MB6069.namprd12.prod.outlook.com (2603:10b6:8:9f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 28 Apr
 2025 19:11:01 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 19:11:01 +0000
Message-ID: <369d0a74-4d5d-40e9-aa87-86c7563cf019@amd.com>
Date: Mon, 28 Apr 2025 14:10:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Fix CPU frequency limitation on AMD platforms
 after suspend/resume
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marcus Bergo <marcusbergo@gmail.com>, mark.pearson@lenovo.com,
 linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 lenb@kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <f5dd019ad4506.2100bf0f83374@gmail.com>
 <445f6320-698f-4d29-8556-665366668e4d@gmail.com>
 <b6fc4e66-b35a-41ce-a633-db3d660b88a2@amd.com>
 <106bd256-2c08-463f-8498-b68f2d5ccaca@amd.com>
 <9de18953-3f6d-447a-8274-c953bae64039@gmail.com>
 <a2747306-447c-432a-a926-e9d0473d9a0e@amd.com>
 <CAJOrcgV-5tr66YbDd_mCL00YHg7nPVdJUon9Az7pZQXpNtwUoA@mail.gmail.com>
 <e8129e3c-aba9-427e-ad63-bc1ea1bdf0f5@amd.com>
 <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAJZ5v0jS+gdHqW3pB1awZ7LHHWsFBQMp86tNwPMVBzOfot-sZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1PR02CA0020.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: d71a37ef-8b02-4a61-3277-08dd868869fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjY3QXd0YzlJRDhsWXd0eHZybXJmWHlMTEtNa1NrNVdSU01YczVIVXdKMnh3?=
 =?utf-8?B?bU9TWlhHczR2VUhiMVpGbVRHMWtpZVJKaHplRXNjUmFycVVXdFpsNW0xeUtU?=
 =?utf-8?B?aUR4WlVlbnZXUVhHbmZOL1MvR2RJYW1hSGRxOS9WQ0tEZGZYVDBRN25ZTFFn?=
 =?utf-8?B?Wk80UGl2NEcxLzlZdWFTVlI3dEQ4RWhUU3p1aUhBcWFFUktOdFN3YXFkUkF0?=
 =?utf-8?B?YTJseWx6V1pxSFVxVmZwQko2eW1UU3Ftd3JkVUR6REdPa2x5cHhzeTRxVkpm?=
 =?utf-8?B?SmlIck9KenIvd0NaazdxM3FMVG80cUl2WjRNTE1JamZ1K1BTK3BtTmRTMjZl?=
 =?utf-8?B?dmFraEdObkJWWHdFZ0NIR3Nkczk3WE1mV2FmY2w1V2xRVjdsZjRqeU5LZElT?=
 =?utf-8?B?cThkRlRKSDRpKzRwNzczcTJTaXkvcGUzZUdRTjdBODBFbnV0UjJ1MlhhUVFy?=
 =?utf-8?B?eXlXbmVGVmdhTkdTRFRxRFlPalNpNjNMb0k3d3dRZTh6N24zaUwxajA1VHgz?=
 =?utf-8?B?eVZhdEQ4anRraElscEhWZU9SMHVEcExJTFAvZUs5L2E2a3VVZGg5T24vWWdU?=
 =?utf-8?B?RXVxRWhNMjRhN2Y1anVlOXhCMEZBckdVTWdIY1BWNnF6WkhSck51UGlIVXo0?=
 =?utf-8?B?K05YR3Rsd2hTa052aHdxRG5oSnExaUZYUEN1K3NqRS9BMnkxREp0L2p0TDJs?=
 =?utf-8?B?ZUNQVlp3RitTQ3NRZUxwM1hPZ3JGL3hIRVoyemcxUG0wM3RlUitSZGwvdVhj?=
 =?utf-8?B?TlBsN00xMnpUZ2UyL3hrbmEweUVBNmNWREw3czFOdmdYMk1FbWgrcDJyWERX?=
 =?utf-8?B?azYyOGxNcWpIbk1wQ0JOVXpVdEk3NFVvL0lDczVSUWh2K2hIakZOQjd5MHBj?=
 =?utf-8?B?OG5Hc25DZmtLbExWQjV0MFdPWVBzWjZyWGNjOVRoMU5IclE5NXNaS0VTTFRy?=
 =?utf-8?B?bm9kL3NGUERKU1RWcGJtbnpJT0drQm05UnBSRjdsejJMZG1nbk1wRTJTRFlp?=
 =?utf-8?B?UDc4M3ZKRldrQ05uM1NDQzZwcngwN09nREJXUHM2YzdDbEVPVENua21iZXBV?=
 =?utf-8?B?Wm5XRWRST0hVWUtTdjEraVc5VVJVb1k0VnhYR056T0srdGxvNng0STU5d1pa?=
 =?utf-8?B?cFpDbitvbkJKM3Y2ZmJsclRjdEZpeHNadXh6WFExTVlGUGJwRkJsSmJBcmQw?=
 =?utf-8?B?VE0wb2VOOWJLRHVVY0dRZjZsdzFkY0RqOEtaNVo3bjQ3WlFQa0dSMVlMWUhr?=
 =?utf-8?B?bUtoU1BPdk9XQ2lRb1F2ZlJQdHBQaWxGSE1RdnJBMzhsUDBFVU50WnVlU0t2?=
 =?utf-8?B?dUVENWhqbTZLNFJXK202aythRXRYZ0puNTUzTUgxSDhVSEY4bmVldXlJTWh0?=
 =?utf-8?B?RFE2QzdtaFBWWGdlYzEvamtIbFlVY3RjYWp0VkxGUzlwZ1k0dHFmQzdtWlZt?=
 =?utf-8?B?MVpWVGJMb0d5eHh1VnZCRUJIY0l1RDNUMlFMLzNUV0QvUHRVMTN1U3VqeUZK?=
 =?utf-8?B?QldPREtJSXNEblNLOFg2NjROUEhDaE9zT1BSTFI3UTZkTjJkR2ltakFFeWZv?=
 =?utf-8?B?bnQrLzNoMGZwNXNsc1JjNVFQV1oxNzdndmZGZjN0bC9lN1EwdVlrdUFjK3lk?=
 =?utf-8?B?TkNGSkJoaDFQNHpCbFd5K3Vpd0F0WWt3cTd5NUpGcXJHanBJamZIc1BlMWZy?=
 =?utf-8?B?NnYrZGN0TEMxaHJPa1pZU2NJdHFTZ1RDVGdUMy9aSzFJQVFycDExc2xkbG5C?=
 =?utf-8?B?VXNrU000b0lrbXg5aU9kQVlPRmpIY0phR04weVRjV1pBQ1RSeVp4RGFpV0wr?=
 =?utf-8?B?cWEvUWY1MVVvRXpGaHQ1RFgyTlJ6OExLMUUxVXhGVHhkWW1IOU00SDZrZVhY?=
 =?utf-8?B?V1NmdjZ1bHY1cjk0QUsxRzJhemZJU2lYc21UQmNtSE14emtZNWxiWVJJdTVt?=
 =?utf-8?Q?ntq4FZFnevA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q01YUVVHczdTbmJhdnQ3VThsUlliRG1pa1ZqeWw1R2pOQWtZNHVxK3VGQk52?=
 =?utf-8?B?amlxR1p6NWZLREEwUlBqNWY1clZSclI1TVdDdmlJcHRKU2xyNGxiR1RPeUN5?=
 =?utf-8?B?M2pybUtwRUpaNFg2QXk3VEZaUWw0SFdoKzRzbzNRdDZGNEk0RzRIVENlSTJS?=
 =?utf-8?B?cE9hSmd2d3dQZlcxL2lvWGRGTllHcG1FQ2JLSHZ0WHoxNUVxQzkvaXA4Y3F3?=
 =?utf-8?B?MHRqbW14M2xWTHE1aWN1Q21VcGxGWHNyeGRGL1h5VjdBaXdLZWxZT29mc2tU?=
 =?utf-8?B?UUdxSWZacU01ZFY5Y1U4b25qTmlMNHNBdndEZncrcUR6aEJUZmRJWHdRYUZU?=
 =?utf-8?B?WlB3NC9wWnJnaWppY3YxUms0MnhrbWxIczFqYUxmNndzQlkvbzdZbTNYbjBw?=
 =?utf-8?B?b05FcU5TbW9MNFZsOTRtOGw2TnhKODF4Nm5EQzE2QlJGTURxUUp6WGVRaG5j?=
 =?utf-8?B?aTdxektxN0NsTi9IdEdaUXM5KzUyamZldFd5ekZISm9HbzhEdkFhOWdiWDVT?=
 =?utf-8?B?V2tYaDEwS3ZWQW52eEFUVk5Oamo3bm5aUTloQUZqakVBTU9VbnFzR2QyVWZo?=
 =?utf-8?B?SVZaRE9hc3NzTHdSLzlSZmpUaUpYR0Q0TWx0eG5SNy8xd3IrbG5uU08yVHFM?=
 =?utf-8?B?QlJHdlFFTGorVkNrZkU2QU1saFJ4ZmdROE9PUkVUMmU3Ym4wUmZCbjF6OWEx?=
 =?utf-8?B?d2ZNbll2UnJUVWFvUWpabEdOOVdFRkpRZzlodHNBaStlZ0RBUzJuTzl1dWsz?=
 =?utf-8?B?ejZ2a2M0TXBOazdnblZjd1lyWnVJNUJuSDVtK1NYeVlMOFJBUDd3aU1NOEdZ?=
 =?utf-8?B?dVNJUGNzeWZLUXg5azJBb3hiVTFqZWNjNnAyeEtiL2lxdDJrSWQvVGdsbnUy?=
 =?utf-8?B?bk9wNVZ4ZUJTenk4eE9qSjlXYmdTcEtzZDdNSDk0Q3AySklWaVpxblRNeFJV?=
 =?utf-8?B?QURkWklyZkgrbXZBd0hqMGZ6czlXcDZJdzBOV3JidzhGRFVyQzAwN3B6VjIv?=
 =?utf-8?B?Z2hHdm9MZEs2cWFxUWlpTXd2bjVXSGNka0llRlM0MGtZOTNzRmJPL3AwRlZS?=
 =?utf-8?B?b3FMb2RtUEVkMnAzbFJOVFZ4NkhNWXBMMEd5OVNhQjgvbkRiaWRheDFnYW16?=
 =?utf-8?B?YWlEV0dzRmpJcEhwMVdXekFCZVBiQnlhQVlrU2JiVWRTOXVWR2FCQzhDR1Jy?=
 =?utf-8?B?V2VNWU44bGZVTTdlaFJzNDRtaU5JQXk0ZExwaHJyTFhVR1hYTWlZVllIdVBC?=
 =?utf-8?B?M01wazdSSmtPZXAvaEpQSTFkT1NLV2kzSlhHc1FMb3pwR2k2VS9oMXdPdXhv?=
 =?utf-8?B?bHZJMzJFYnAydnNrdGtISk9ockdTRFlVSGJIYWY5TE9Nd3QxdnNjemdnN1VX?=
 =?utf-8?B?VjlndjNXcTlmVTA3U015aGhnL0Q3TUVTZmNuNVc5Y3EwdWs0aVhnQXpIT2FW?=
 =?utf-8?B?aFM5NFVObkhwSS9ZWk9zcnU3R05PRzJWQlVJK0tXOUx6K0xKUW9MSG80QmlM?=
 =?utf-8?B?QS9KSTVLWTFoSFZSU0J1SlN4SzJyem1XNnZZM3VSS1RJMVlnWUEvRU83ZmhJ?=
 =?utf-8?B?ZmxyV1IrTGVManJGY1RaaEJNdjRoKy9iSlpUTGNCMUlJQ2J4NzR6NXJxanRa?=
 =?utf-8?B?aDdTZmRSWXlNcUlQanFQNDk1YjNrd3lacDZxWjg3TU4zZU1yd0hTV1lHWlFB?=
 =?utf-8?B?aWZ1ODlzS00wdFNFbXowTFFSVzRRNzloMGtsNEVOVnREcEp2K3dFbFhIMEpn?=
 =?utf-8?B?SEs4R3YwMjFBdmNoZnVtVk9TWm5WdE16eGIwb29TTE9xcmVtM3U1RGVCclZi?=
 =?utf-8?B?YjFwejRyQXVobzl1bzU1MVFybC95bUp6TUFqcU9yTmxvcU1QWUpCMnFMVFls?=
 =?utf-8?B?cWlRek0ydW9aK1Q3d3dMbHY5cVoxMG1jTWR6UURVVENhcjEwclZPUHo5L1k4?=
 =?utf-8?B?dGdHVVY3SE1jMW5vczZ0VE5QY0NhMTBRS2VhRWo3cGx1MzVyclR6b05DTytQ?=
 =?utf-8?B?R1IybDMvak9FWVdva25xY1JtOXlqTDdxaFJjU1FLY0xJaVBvT2h3WEhkN2tU?=
 =?utf-8?B?MldLcm1RTFdZMkFwRTJIcGhDYXRBNmVnRVhWQWFMM29jUzl1WlhjM2FqNVBX?=
 =?utf-8?Q?L7Opqel1LWclukpz90uU2IVMe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71a37ef-8b02-4a61-3277-08dd868869fc
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:11:01.1291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7ZiM/kDyqplJ7+3XN9e65HzqgLJPcu/81CDaQyFVr97FYrLv8JWKs5eVK7I6a+sI5Rtb6IH2U/PA4lJXszq3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069

On 4/28/2025 2:02 PM, Rafael J. Wysocki wrote:
> On Mon, Apr 28, 2025 at 8:23 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>>
>> On 4/28/2025 4:51 AM, Marcus Bergo wrote:
>>> Yes, it does.
>>>
>>
>> OK thanks for confirming.  Considering your finding with this patch
>> you've shared and knowing there is a timing dependency that delaying the
>> next s2idle cycle helps I do wonder if we should keep exploring.
>>
>> Rafael, do you have thoughts here?  Specifically do you think it's worth
>> revisiting if b5539eb5ee70 was the correct move.
> 
> Well, it was done for a reason that is explained in its changelog.  I
> think that the problem addressed by it is genuine, isn't it?
> 
I mean yes - of course.  My inquiry was whether this should be the 
default behavior or if it should have been a quirked behavior.

I don't have a good sense for the rest of the ecosystem what the impacts 
would really be at flipping it.  Would it be worth adding a module 
parameter debug knob and survey what happens on a wide variety of machines?

