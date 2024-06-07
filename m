Return-Path: <linux-acpi+bounces-6257-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4168FFD94
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 09:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150411C21C7A
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Jun 2024 07:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C8D15A86B;
	Fri,  7 Jun 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="c9YP5LzV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262C1C2AF;
	Fri,  7 Jun 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746871; cv=fail; b=P1YBWIbUjfrXwGKxvhpTsy3xmOyjdy8ZzuSSk9qRcLpLHI21PL5Ony4gXubt4KGrmPjr6JtEx0dBaq9G4q3rIDCcJcmwZJCJ5lhJKgr3WuWoaCcIEOJL0RBSDyu50eFRtzqCZWJwjXKeJIxCxMc1x5U4yQxCrdPeKDZFdzvxCzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746871; c=relaxed/simple;
	bh=5Fr+4VL7kFNJrLhPVYvgClcqoHcHJcJetaMqc/GzX1U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M97+wcKSJ6nACC2rnNIGyHSvXt6/hEydSiRP/1yZu8ka8ms4t/3CyoQ4ODE/0zzVc7XdCgYlWZDHsstqUaVk6+QmSsz68EA9QAX67nVWakSTp8pMNDt5fDCc3N9H582SveUq5qFZ9YTGXKaG8+o8keCt//lBIui5Zou/hZoU1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=c9YP5LzV; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4575BFWH027577;
	Fri, 7 Jun 2024 00:54:01 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykuu20cjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 00:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i74QYnpqCQEVC1pjhyWz0KlsSaUCGKPI2H6aHmo9E7O9O+cwG+5zCqw+gJjsxyJCVJQFDhiS+qfnpzoMqvm+x6aKAE/bYBS9W8VE5/99dUAXEGwaTO2hnMz74duApcOcM+NA5D3QdYIjs/SJUW8eIf+QYwNIklYEGxvmrcZtNQQuv5THbfq+RMEhl0s9ldr8Tzy+Zaz8fIkWCLk7jkPoISfTCcUXHanW3GW9ZbaaecpULkpX0sRI5pFft/CInNAVMNVdKBGcxSaRtbxGn4SqWXv7dJ6MxrJbIScj1NoHXDcRciVoVEE7cKA5KDqxGBSP3bOeIG24k2j5PHh38CpueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0C/DmWR7rTgfgh/+aYh2NCJgxVw7Mh+ObYk5rAJac3o=;
 b=gnDmbk0lzBSlPrpOMRC0scCDKUfC+ucjHFsBe4Mk+WHuTgbCuekvMs7xkXLujEuEdYNkF6fgjY1ENahjQ40cAYbrmoimekoM4o4jaO+gxm+bGcqdQ5YQEw0GUv+o1gDPasWpIA3zya7gAl1wO2jTWF0gEk7ah3mvmdjd5UdET4kv1VLq2XgypFM5mzd4J2Z+lyrbmnuc82wFxJp1jjfoDJy6RlCG16biFf6926OS94sXZ0sRCadgdTVYY9rEcdoRRHwtVobf70WWUJgqBsbhgidnBycMQwmYb5ohOKTCoMLl5Hp9oiTipcqIBDmW/wWfeVAcoilQh+kc2zE64zpBlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0C/DmWR7rTgfgh/+aYh2NCJgxVw7Mh+ObYk5rAJac3o=;
 b=c9YP5LzVHqVIyh+wbC9vhTVKZJGY3R7FH+SmfByVBMMyk2u49VaCVpGcq5EdS5Zer9a4nFe6Wp1Xx/WzE7ALSnmA/wIPXBFdv+nRYOKG+v1E5l+mXngPFywf/QIRQ7UN5E9bOtoAMBRGBylTzBHDxonwlVUYkf/kYC5v9pKiPw0=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SJ0PR18MB4430.namprd18.prod.outlook.com (2603:10b6:a03:303::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 07:53:57 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 07:53:57 +0000
Message-ID: <02dba55e-39a3-4853-ac52-834cb1c0fc7f@marvell.com>
Date: Fri, 7 Jun 2024 13:23:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] irqchip/gic-v3: Enable non-coherent
 redistributors/ITSes ACPI probing
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linux.dev
References: <20240123110332.112797-1-lpieralisi@kernel.org>
 <20240606094238.757649-1-lpieralisi@kernel.org>
 <20240606094238.757649-2-lpieralisi@kernel.org>
 <f901fd06-3b6b-4444-a3da-2b75c59059d3@marvell.com>
 <ZmK5Ilk37GyJ4QEa@lpieralisi>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <ZmK5Ilk37GyJ4QEa@lpieralisi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0220.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::18) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SJ0PR18MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: d4e71c7c-0f89-4d90-e8ff-08dc86c6fbd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUtJcTZSc1VTMEJwOTZVQm5IN3ZiVGNNNlRJbjJBTXQrQlFxdWZZOG1mSWc2?=
 =?utf-8?B?aDBibUNQdTVTUU1EQk9rOEo5bGx6ejFUK3FhZG1KSElJNjBLc2t2MFY5QS81?=
 =?utf-8?B?M1VqMCtOQk0wYlVrcy81QjdLWllrRzFzNnV4Y1AwZUE5MXRlSXJLTUpJWjQx?=
 =?utf-8?B?RHZhRmk4TVRoS0FCVitabGN5emRvMnNHMDdDZDg2RUFTK0NUcklvK3p5dDdj?=
 =?utf-8?B?ajc2cTZwK24vN21oTS80WFNXM0FTY2NqdTdjbWQ4Z2U5dDh0ZVM2VzVJYkl0?=
 =?utf-8?B?WHFpVnZIeHVrNnRRdzRxa3dMUmhZT3JPa3BOTlpjUERway9TT0NrajFaOVZt?=
 =?utf-8?B?REY5ei9NSXc1WThRMVRkSHhvb0U5aVVRWmpnMVdWZFRabVo4d0hhSHN2eUNN?=
 =?utf-8?B?MWhjcXEvU1JMNGxnYzBXVklTZld6aXVCckIveW9Fc3pqYnZmVEFNM1pkdmxY?=
 =?utf-8?B?T0paNThtZ2xYM2dyUXo3QjBCV1JuS2d2NWtKeGhxd01KbHpQRGtqTzZVb0g5?=
 =?utf-8?B?RDIrMmR0ckJBYmhBbEVOTHVWbnkvTmxlR0FOOWZjakx6SUNyQVU2TkR1V3VN?=
 =?utf-8?B?KzdDRThXeGZPUGhhMmd5NERJU092YUlML2FqazZPd0tCZUxhTGJMSVhnbXVC?=
 =?utf-8?B?b0tuTjNRZVl4bHkyWGlqOVBRRGRrSllXN2F4ZFJpRzIxUGdIc2NjL3ZQbHQx?=
 =?utf-8?B?MklrSVRiVVE1Ty9JODdjcVI4TFBaak5saDQydWd1UXVKWW5CZzg4NzdRc0kx?=
 =?utf-8?B?bUNxdS8vTlNXNjZLUUNKY3IveTl5T2R5YnpTT1hQU1BldkF1K3hNaVlnTlYz?=
 =?utf-8?B?ZG1wMFZUQW1GeS9VZTVtY1FFeFdrclBDNzRRcEExaGhWbjBWQXc3cjNHbTls?=
 =?utf-8?B?dU1ORTdmNWJHREN0cm1Jd29pM3dxMFJSZFJ5eVBleUpaaHpodFB5cVlOTjVM?=
 =?utf-8?B?S2tjY25aUTBHRUVLQjU1Uk1HZHRSRDFEd0VDNENWWjduaFJ6eExtUU9DUG4x?=
 =?utf-8?B?Yi9veU9WcW9palpNT2FtdTRWR3loMDJlQytJOGI1Vjd0a1d4VjlJWGtmOVgv?=
 =?utf-8?B?bm1tSzBibEZNanZZUXEvS0xMaVdFOEsxU2hrQXpRSnhpYVh3OTBWUnRxcGVT?=
 =?utf-8?B?VURZalgxQ3NEUUpPTDlTMFlWcG1vYy9WcXFkZXNaelJwcitJK2RZaDI3RklV?=
 =?utf-8?B?aldSN3ZkVU9qb1FaTzFMRVdZZUFieWIyT1hFRUJpeTJSYW1ZTTRGNmM3WlFG?=
 =?utf-8?B?OWNSOHRTUnVyODhSbmJrcGkxaG5IV0dpNXZETmNTU1RveDJnTTh0QUV0RCtB?=
 =?utf-8?B?cHJLQm1kUlNsbXFzajM2SGpHemFuVW9uRDFYOVV1WWJ4OUhKUzhySjhsVnZY?=
 =?utf-8?B?cTNWejJlWFp0MU1NNFp4VXJDUVdvMzJvc3g3WE5kUCtaU05LMEtuQ1FoWHZz?=
 =?utf-8?B?YlN4L3ExRHhmWE9jU1hkcGpHRU5SWVFqY0l0dXkvQmtURW92ZUJEMlB1ZTc2?=
 =?utf-8?B?NnE5ZlcyekcvZHcvMzFSRlNHK3Y5bjU3WXB5bmNMMnpualVyUU1lZ0Q4NVFB?=
 =?utf-8?B?YjBMY3NUZEZXa1k3MkpISS9xME1MODluRThnRGVGdlY4U0syeFpxUDBVWnky?=
 =?utf-8?B?a1pzMVpyRllnWGZ0ZlREUnpvWmQwczJnOU1sWUkvV2tMZTFGSmIxVGtsakt5?=
 =?utf-8?Q?fvzCfScLwF+n/4fbBjFd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SVREbXpleFFtUytldmlhRUpKYytJRVdKYkVtWlk2VG91T3JxL3AzdWdWd3l6?=
 =?utf-8?B?RTFSbmdDOFRPdHYvMGpDMXVMREFwOXExVzFKYVJOWWxVS2Y5cld2MVo1bkFB?=
 =?utf-8?B?R29wTWNmYkJXUWp4cVBNdjVNVHozS1B1cllUckNvTmZPbXdndUZxeXVJVDhp?=
 =?utf-8?B?b0ZLQ3MwUHVwUGN0MXQ2VlJTTGdRSVpCRnhHR0U3dDN6dkJlU0hPTDhBNGxU?=
 =?utf-8?B?OWZvMVlkZGhsYStKUUpYNnpuM2RSaG9KVlp4ekk2RFA1SldEZE1WOGJJOW5l?=
 =?utf-8?B?SmtkMHl6OTlXanVINkp1cHZiWVViaUQyT2JhcGhyVGU2TjgzSUt4anAxanlh?=
 =?utf-8?B?ZDRtMTlxSFRhd2VNdXJBajVtT3hRSlF3RjJ5S1ZYbnNiK1gyak11ZnFyMWN3?=
 =?utf-8?B?ajlFU2w1WlNDODkySXlSNnFHZG80WkhIWjFvcFZ3dEJTcHBLdjB0Rm9EUFg4?=
 =?utf-8?B?dXBVejJXd1RQbUFIZ1ppTDVFOGdEV3ZhUE53WVJzbDJ4Y3lQc1hJTW0rUDRv?=
 =?utf-8?B?dTBjNmdtT2J0VGNYNUxqZlYrdzgva0hTTE5pS3gwZzBadWhVRUVKQW9zaXh2?=
 =?utf-8?B?Vks3MlFZZ0NPeGNJRUFFTW1vcGxzRVJkOHZURTJJR2xFeExLRmV0emNwVUZC?=
 =?utf-8?B?OE4wbXcvenZCa3drWFVsR3FheFY0T2FpbGtqd0JDdHhLbHI1NCtaQzR6bk9s?=
 =?utf-8?B?VWd5b1dKMEVkRjViY2NTaUFabXpHbzlUZVIrQndrbEtnR3AzelRNYlNkdWNH?=
 =?utf-8?B?RHBscjRPUHE0Y1RjUXpYOXhpamdZTWZUc0J0V0NTT0F3UjQ4R2Q3czlpYzM3?=
 =?utf-8?B?V0FHNmxLNnVhTUNFZFpjOFNRMWNEQm8zeFgxQW5ra0Y1ZWxWV3JOVElhaStP?=
 =?utf-8?B?dXRVdnFWa0ttOWwvbXpKMUQrNEJzQ1hpWjVWemY3NEVubFJ4K1l4Y0ZkUSth?=
 =?utf-8?B?Zk9iVVNSeGlxK2xFUnpqaDhJMS91RGFNZERLUHpkVk5MUzNRS0xPQzRVYS9P?=
 =?utf-8?B?cVkxQTZjL014c1dOQ3RsYk85Tytzd0hsR0V2UjgxTkdvOUZ5b3V0OEZlQ3N3?=
 =?utf-8?B?OGJnY3VkTEJGcWpVbmE3N0JXYkQ5akpBZW4yMXdvUXY5RDlncWIxUnFuME52?=
 =?utf-8?B?WXYwRHV6M0JqeHpZVjNWTGp1NlpJOFpFQ3BUQk5TZE1qdzVQMGhJQkJwQkh2?=
 =?utf-8?B?Y0dUemYrM3RoclhYYjBSN2VaZlJMUmhzNHNTSklJdjk3U0JJZ1BlSFlUY3Mw?=
 =?utf-8?B?S3N1Vy8vQWp4dDUrV0N2a1lCbHI4blh1MndLbk4xQzRPbHlucThxczlmNVlD?=
 =?utf-8?B?UzNSbDVHRXp4SHZmTGRTSHRaeElGaGNQOFM4d1JoLys3OGV1M2xUcVp2bWlW?=
 =?utf-8?B?dzhMMzlzdXB0eXZPSWIzcUU0VU1GLzRlR01sVm4rSGt3ZWZ2SEprMXByeURr?=
 =?utf-8?B?cHQySlVHNnZZWXFpSVpmdUNRRnNKWExsUjZYSnlGSDV2WWYwdFRVTDBiRWlK?=
 =?utf-8?B?QjhZeDdSSmwyYkRHYjEyRkFmY3dpT0dTWG0vSm11L1RSL0dIc002Q2lRRC9u?=
 =?utf-8?B?NkZNall1blNoV2dTTHNORzM5aEJZMHlnZ256MkhzS25qK1VUR1RjZ1dTZ3A3?=
 =?utf-8?B?WnNNdGl5UW1XTjNQSkk5bS9nSHJrK2lGN1I4Zmc4NEtSOXZjWE91aFNBd2Er?=
 =?utf-8?B?RThZakhYVS9YWVJZN0RpNEczSFFQTCtrUGtsaWdaaWUvekg5NVlLb2R3c09w?=
 =?utf-8?B?bFBqM1NiRFV3YkZ6bkdhQ050VlJvUFpVdFl3MWlwakhIT2t3TjBCL244YXNa?=
 =?utf-8?B?QkhEMXQvc3dzR0ZGV1A5bWptYjg2MG1ESWIrVWlGenJ3VmRHUkhsSjFZSUM3?=
 =?utf-8?B?eUNuMStWc2tUQ1NEZHhoVWUySldQOERsWDNlWmhSakxHQzZ4V2dCak9UaHVM?=
 =?utf-8?B?eDhRWjBUcFpqNDJYOGNoVkVkUUQ5bWgzZzBLcTZJMzJ2UG5vZVpSSjBnbzc5?=
 =?utf-8?B?R2dOR2tGZnRZT1dnNXVSV2ZWaTNJb2tVU2tvNXYrMEl4N2tJTjcyWmtGellz?=
 =?utf-8?B?SHVPeHp3Zks4dkVJRWFJcjlDeDQvMkhsWXgyaXF0N2lYNWpMNy9vdDJGcnpK?=
 =?utf-8?Q?Mkh+1QyffFa/8xoUGO5daT8Rz?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4e71c7c-0f89-4d90-e8ff-08dc86c6fbd0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:53:56.9241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYJ0twQc47aN4jbrBAO64YkE9i4AoAmUbI8I5cXSk6MiUQD5xeOUze3afHXfISRGlzyIHmb/VFhwaDrurlNrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4430
X-Proofpoint-ORIG-GUID: _0XePVrKMm0xtspbDNhDwZAE2k0YX9Hb
X-Proofpoint-GUID: _0XePVrKMm0xtspbDNhDwZAE2k0YX9Hb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_02,2024-06-06_02,2024-05-17_01

> On Fri, Jun 07, 2024 at 12:21:54AM +0530, Amit Singh Tomar wrote:
> 
> [...]
> 
>>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
>>> index b203cfe28550..915713c0e9b7 100644
>>> --- a/drivers/acpi/processor_core.c
>>> +++ b/drivers/acpi/processor_core.c
>>> @@ -215,6 +215,21 @@ phys_cpuid_t __init acpi_map_madt_entry(u32 acpi_id)
>>>    	return rv;
>>>    }
>>> +int __init acpi_get_madt_revision(void)
>>
>> Wondering, if we can have a generic function (acpi_get_tbl_revision) to
>> obtain the revision number for any ACPI table, not just specific to MADT?
> 
> We could - I don't think there would be users other than code in this
> patch though so I thought it would not be necessary.
> 

Right, it might not be essential now but I see that MPAM will be another 
user of it once the MPAM patches are out.

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/acpi/arm64/mpam.c?h=mpam/snapshot/v6.7-rc2#n299

Thanks
-Amit


