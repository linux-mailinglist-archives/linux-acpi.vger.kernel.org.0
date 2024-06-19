Return-Path: <linux-acpi+bounces-6515-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6938090E28D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 07:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1DD284260
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 05:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C394F5EC;
	Wed, 19 Jun 2024 05:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfHc3+JD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042E4654D;
	Wed, 19 Jun 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718773696; cv=fail; b=AyMBE6ri9ZftEoz6xBLWoAN2N4men9cBGiTcswxf+P5DCjy+Sne/O7f0JQ0YncmJmKS7qkyq1jlSwuEy7CEtdf5IvJV++RPLlcMVtSZSifvPJ31BZoopg4Q/GyZ5MM2DWkF5rnbZ8nVKjLzdpyKWJezfiyGtRhP3NtUPGYWqgto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718773696; c=relaxed/simple;
	bh=ND738mDeyX2mqD25QcSAaPEFKnTLIB2UB+g4pBiklYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Afd0KBjlXHt/p2uEc/nIpCkJqRKRr18R2Zma7oyxGZSYTYCteEtF59y4yRltY9NqQGxn9SYT2+BYUIgh29MXjVAFC9o9SL68pwvrpwW8l2LoTgxqiEDrkZDy13jA8OE8VO7wxaME15AqIo2Szs1lsA5xP7tOy3Avh6EJPMzFsJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfHc3+JD; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joAzCbcfijqbDW+n6vFrFub5e9ytJr+h/OiWMy32TJ0r3kK2xTzdlhECJXHFfMHEiBSF8jeZLsjPh+oWVr+1bRZInHHc+1tBSAUghUf+u7iPaRReqi0EfeywespQf8RpjcaOp6W9WnLXAvdFZgKCppwjtc6C2YWxTjqBrPfLbzS/PNrYpk1lsFNRwwyu716nf5SNcaa0CU+ZYnCTOsNtFar5QcIDM01KFV9TDUkIV5drgIpHqyYmOqaPVgSNSt2jptXSGhcjmy+/3CKWqLv8bugV1wSv7EUUKhSFfIp8C1T85mSBzgTzgBIJx3IgTBgvGUFgK+M5TZRS6XRMHFFc3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=itQsy9KqPH9p0hJSe6rY9e3bVg7OmaDZp0CsyBmMxVE=;
 b=mupUiGU1G12aDj0ch5OVO8HtnMfwgbkz9JiyrqU6fbEXRarfklABzmqonfsAQOpudQRGrIZv8GNtCFj4rentyWWbIsQDu6ReQ475zhuEDA8284AYsUaMhXCCaDUyRljOP3m8j87AnQViO1q+IVglOWlUqAMxa4gdDN/iiJ/buvsZXJAfed12it+fSLluN55AKpT4nLt3GDktwI09svQWXN8k3cyEQum45GgqtMK6UPz9tJ4Yg2FCaLhK1SHPg082EAa5X4uqtZHm7PWf4vn2q5p73CgMn/7I+bEr1ZEKog9sKaGejgnypWXIsmf1MOgrEnH0UIlt/rMpCVBjyJPSeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=itQsy9KqPH9p0hJSe6rY9e3bVg7OmaDZp0CsyBmMxVE=;
 b=YfHc3+JDVZP6gJA9kjD8iZIe8NyuvwlJ+A25UjSM4/EMclD4hbQ/VnMn3QQpds4K6C0B+K3DmYxrtwnKfrulHqm0CbcZZa+FMDHiWXl0XfKoMfJd5BvGh4gtEHPt3wFpO+eSwnn3IpCgflL67YnoFutD04wbsNQyl8mAF9uDa5U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 05:08:11 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 05:08:11 +0000
Message-ID: <3d41167e-4116-4866-8088-efcd44474f88@amd.com>
Date: Wed, 19 Jun 2024 00:08:08 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel
 parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: rafael@kernel.org, lenb@kernel.org, mmikowski@kfocus.org,
 Perry.Yuan@amd.com
References: <b516084f-909e-4ea4-b450-3ee15c5e3527@amd.com>
 <ZnHSKiaYf2tIQo58@kf-XE> <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com>
 <ZnHXfLEwk2uRbg58@kf-XE> <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com>
 <ZnHfNbLTgY1op3Zv@kf-XE> <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com>
 <ZnHtPbszYT8afOOk@kf-XE> <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com>
 <ZnIAX9P5XSco4cZw@kf-XE> <ZnJfmUXmU_tsb9pV@kf-XE>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <ZnJfmUXmU_tsb9pV@kf-XE>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:805:de::41) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 112a3e33-8876-44a0-874a-08dc901dd114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SlVZS21PaC9ZRzdzZWlNNEkvR3lsT0xFRDRJdGoycXNMbzZmYkdLR056Ujlv?=
 =?utf-8?B?N0xqNk41ZkxvelBNbmJ2aFY2UklYOGFrZnpXSFJlbjFFdkRnTVd4Ymh4ekpr?=
 =?utf-8?B?cmdISjVHZExUMTIvaUNIbk8wSVRRUUJUK3JWSGF3VXJMOEpreWJLMHdGaEFr?=
 =?utf-8?B?SndENXo4WUhxc09oSDlSNEE4WFozZnpadm9PNXJTWlZjMFhaYkpkZFVyRGRZ?=
 =?utf-8?B?dTBFZlBjQzlpTFlGN2MydGgyamZseFArZWN2cDBISk9xU1RIckppQzVZTjdi?=
 =?utf-8?B?MzhadTdCSHk0WWlSbFZWSDA0WTM3N1Vyd0lUVktLVmtBOGxHMlYrK0RYYzNm?=
 =?utf-8?B?cjVyZ2tWaDE5MzBBTmltTFoxRitnZTFRUWJyUThMUW5wSFUyZ3BCR1JoVWQ5?=
 =?utf-8?B?clJFV2l0Sk1uekFMY2NseFFCb2R6UUJpTEJISjVZT3VrbU0vS0lpTjdYY1NP?=
 =?utf-8?B?eXQ4YnBBWXBEMVFLb080RzRBeDNWeC93dXJ2aW1BUS9xMy9uckNLZkhKcnV0?=
 =?utf-8?B?SW5XeWRFUXRUL0pMZDZxMjQvSnUxZXZFckdESjMyRDZSd0EzNVZzSmtkMkR3?=
 =?utf-8?B?T2hUNVVvWXAvUWFtR2R0VGhHNWQrYk1Wa0RCWUlURjJLd0tzRm1jQmxwckJq?=
 =?utf-8?B?OEpOS0pYdWJIZHUrWi9Ua3Q2WlAwS1k1SGc3R0Q4MTMwYWtPVE1DbjM2WWJB?=
 =?utf-8?B?K1lWZFk0dWtIME5hYXUweWk1czdJUmxuM3oreEZucHRwSGl6U0t0THhqekxN?=
 =?utf-8?B?M2NEay9CREZ5RERUTlBvUWt0ODFGQ1lGOHlQeDZRZGM0ZjA2YThlb3I5cURG?=
 =?utf-8?B?dGdQWHNIdUc2SmxlaG00ZkRqcS9pNFBySWZ0eWlldEJ6MW1oeCsvckxrSmU1?=
 =?utf-8?B?bGZIWC9ndXgvK3gzdEhpMXA4cmxXVmdsaENjYjBUWHdLTEZ6VDd1WmRWYTAw?=
 =?utf-8?B?RWcwOHNqMjdxOVpBN3VSRnFXWGRGNUNpZUMyR0dadDZ1ZG04Slp1WGhLVXZI?=
 =?utf-8?B?ZCtOVkFrQkllSDR2RUNXTDJpb3lXZkxHSldodm1TbWtNbU93VXhHM2R6SjE1?=
 =?utf-8?B?cXAxaE9QakY0T0ZiOTFNZDJ6dldjNFkzdC83WVNqNDZzcWhOTG5QVmdvS1hl?=
 =?utf-8?B?NUE1ZkRMa3E3RkVyTkhMaWwwa1BMQjduZlhROVAwWHRDTXlyRzRtVnUrTTlD?=
 =?utf-8?B?TUo1YkNLY25VT2ttSENkVFZKZDJzdC8vbmxqMyt5bVVHL0QvUFVqMkRsS2w4?=
 =?utf-8?B?bmRINzFPWXNveWEyeGtLY1c2ejVacHljNHJDUWo4TWlNUWJjV3cyclpJQmNQ?=
 =?utf-8?B?UDVUemNXUkY5UUNxWFI5R0RIdDhHcDgyTEs1b0hCS1RPN0R2dEIxR0FSSU9D?=
 =?utf-8?B?azJNallJNk96U2kxUi92eko0S2Rxa2FjcDAxQUk0OU9WSTgrVEZaU2w3SjM5?=
 =?utf-8?B?OHJzZDRYYzlaQ2VWRTd2MFJoOXp6c2pXUzdrSmk4azdESmlZcFM2UTU2STRZ?=
 =?utf-8?B?ZWhjWDdqZ1doak5yQ2FtZGp2ZWl2NTNiVGJjTWFIRTJCSkFJVFB5M2RQNnBB?=
 =?utf-8?B?VGRQeHJyZmxUSTlZenJwcU93eWY5NEUvcmdiWE9wQzZ4L3NYUHZMenVyOG5Y?=
 =?utf-8?B?RkMzWHBveFFBTGtPbExOemRQM3dDWlU0V3VmYXdXdjk1bmM4Z0g1WnQ0UXdC?=
 =?utf-8?B?T3p0aUV0UFMvcmg5eWszUlpLbHpHUWFOeVEyM2N2QWh4WGE4SVpBdkttY0Fv?=
 =?utf-8?Q?mkGOlluc/x72lDgk6C/6rwusyrEwxuO0ujquLOT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzZvUkl1Z25WMkhuNWdyUXJwalBpY1VQVlA1V2xIeWphQjdKVnFROXNwbXRK?=
 =?utf-8?B?OU1tR085V3dOb2VIUkVCR0sxSSsrNGhidzhBSnNrTEo5eTJtYzJ4OVcvWm9i?=
 =?utf-8?B?L3ZOS2tVcWI5VkVYbGxzL0I5bXpmYk13N3RIcUFRMGZkdlNCT29HQ3Z2M0dM?=
 =?utf-8?B?N0VTNVpra0VNcEoxUFF5aW5CZnYxdFFQOWRYeE0rbkFJUUd0R3ovays3SnZB?=
 =?utf-8?B?djVHb0tqeG1VaHZHMklmRng3dG5nWC9OcjFhUDREb3FKOXNwdGd3bytpTXpD?=
 =?utf-8?B?ZVRRSEF4OEE1ZjVlMVNYUHRXbS9wbHVRbGdIWURZNXpSOTdDa3hXT1RjNGFx?=
 =?utf-8?B?UWpZdlhYejNrQTk5K3J1V3VwZkhYbVF0ZnoxcU1IUnptNDRUbXdxQnhDNVo4?=
 =?utf-8?B?ZU1udHpIazkzaWJTMndibDFiRDd5RkkwNS9rU3BIcXo4OEtvYVBTU0dmby9u?=
 =?utf-8?B?aHBkMjBBWTNvSndoaFlQRUdJSDBGekNQWi9tcERXNVRqWWZSVmV6TFJWWW9H?=
 =?utf-8?B?TjB5VGxxdFMzL01RK1BpMHRUbk5Nenp1Z2g3V3VFVTVXMjRnWTlNVlFKZzBn?=
 =?utf-8?B?ZDd1c0xteWtSd0hiS01YdXp4WG9VcVF2ZEFUMk5MUU5XVU1pa2E1ekUrblRG?=
 =?utf-8?B?NDJwbEY1ZXJBVTdVN0FvUEp4MUlPNTdBZFdJOWY1QTdlQm4zanc2UURBaXNo?=
 =?utf-8?B?UTF1eVhBUTd5bWVqWWhlcHFuKzg1TlJadHhYY0I0aVUxcE4wQUtLTjlKdGR2?=
 =?utf-8?B?ZHlXRTJldFoyM016RWdma2ErRldpRkhFTlVPSjVKZDhwUDVpZllZU1ZveXZy?=
 =?utf-8?B?QnZqUlUvNC9xY1JaQWJiNGZPbEVCalVhZjJtczNPL3lndjg3YmRRTkZnUWZO?=
 =?utf-8?B?b1NxZEVIWjkwdUZZQXZmQmVlQXlrVEhxOVB3NHgyL2hUcXNQTkhSYkF5c1Zu?=
 =?utf-8?B?WmdXQkIzU0xLbGtJNzJIQm5mTmJFNTQ4ODZGVi9TbkNMa2diRlFlY2tWaDlq?=
 =?utf-8?B?V1JnOXB6YW5ZSnRrZkZobUV6ZEMrRWhLcXZNaHV6dEpIZUdFYXZXekJBZHF2?=
 =?utf-8?B?VGlOTTBUckxYeXh6N2lJcWczYVlBelJlYTBFWEJrcU9PdS9hTjBmUlBsa2Rt?=
 =?utf-8?B?QmpZZzc0U2hrOFd4dHJ1WURvemxlZlFIdTFBa0d1WmFTMXgxdkE2VWh0NjlY?=
 =?utf-8?B?SC9VRWQ4S1oxaFExbTZUWEFpNHc3bFdPTzlJekM1VlFGL0g4eW5ZOFdpdFlN?=
 =?utf-8?B?eVh5dnQ0REc3Y0M2VDBIdG5rbnBCRW8xYzhibnVsRlBocmpIQ0xUMERlODNa?=
 =?utf-8?B?UmloR3NWbkdPbXRGOVBGZ01tY1RXWVVXZ295d1dCd1ZZTE1RNjFyczdaY3I4?=
 =?utf-8?B?aUJvaitYdW9jK2p6ME1EbWtCK2daQUdxNmJhU0xCdzN4RjF0KzVFUTduSmx2?=
 =?utf-8?B?a21sNVgvcnArVmFESG5xWGd5WUU0R1FPSVl5NERGQzVFc1ZydmZOOVNuZWVR?=
 =?utf-8?B?ZVhkWmtUTEFBQlFmUFVLWkQ3b0NGaGR1U3ZJS3ZaaUNIQkh2MVhLWVNLVXZC?=
 =?utf-8?B?cTFwWWdrczRBRVhNbUJnSU9tVGE4M1AwQ3pmYVcwZFlwa1U0L0h4dFBvTmJD?=
 =?utf-8?B?TmJ6RlMyWVhBdTg2TUFVaS9YRkhiY3ZINWZMUGRJS3lMOStrc2x6aHR3dXBp?=
 =?utf-8?B?TG5qOWQ1MkRydzZucVo3dXJac3lXNEJNUHFLV2xKMm9uelM4WmQybDFWRFZj?=
 =?utf-8?B?OWNrQnYzN2g4VUhkeXYyUkpJbXQ0d0dMOTNUeTkrS1o4c0FBQ2twZkJneEM1?=
 =?utf-8?B?MEVXbFFKRW1SWFVnbEpIWnpZT2pRYy9ta1BKRTcxeFhpY2NiejJFTDlWTHJ2?=
 =?utf-8?B?djF5b0hnWVhFQ0JBS0l3K1ZxS3FsZUNWSU4yWS9YK0g2cFRzUjBEMnNlMmZl?=
 =?utf-8?B?bzhvTGpIV0ZYZVJqYnhzYkZ6MUl3OWl6dWtEZitRd2p0N2gwcWhMa3pad0hk?=
 =?utf-8?B?dUlYOEllVWYzZ0hDQ0gyLzdoRlhsZXRCb0pZQU1SQ1hQVG4vTkZSektnR0gv?=
 =?utf-8?B?dElyN0hjM21RN3ZSQ2Iza2t6R2JPbnNyOXg4blAvbHc3VWt1c1Z3dUVxL0tk?=
 =?utf-8?Q?24MNpT1bD0JRC5Vp2bqTMZ6JJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112a3e33-8876-44a0-874a-08dc901dd114
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 05:08:11.7279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cxZtVD2IRrcmF4oDk++Kw7FDB4d/KJM8WXDb3Z+LZZ+vPGg+La63WequiwUzyjL5600u0fnaHXfBUg8TUrDRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

On 6/18/2024 23:33, Aaron Rainbolt wrote:
> acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> 
> The _OSC is supposed to contain a bit indicating whether the hardware
> supports CPPC v2 or not. This bit is not always set, causing CPPC v2 to
> be considered absent. This results in severe single-core performance
> issues with the EEVDF scheduler on heterogenous-core Intel processors.

heterogeneous

> 
> To work around this, provide a new kernel parameter, "ignore_osc_cppc_bit",
> which may be used to ignore the _OSC CPPC v2 bit and act as if the bit was
> enabled. This allows CPPC to be properly detected even if not "enabled" by
> _OSC, allowing users with problematic hardware to obtain decent single-core
> performance.
> 
> Tested-by: Michael Mikowski <mmikowski@kfocus.org>
> Signed-off-by: Aaron Rainbolt <arainbolt@kfocus.org>

One minor typo above, but it LGTM.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

Up to Rafael if he wants something like this in place though.

> 
> ---
> 
> V2 -> V3: Move bit ignore to before switch.
> V1 -> V2: Rewrite to work in cpc_supported_by_cpu.
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..af2d8973ba3a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2063,6 +2063,12 @@
>                          could change it dynamically, usually by
>                          /sys/module/printk/parameters/ignore_loglevel.
> 
> +       ignore_osc_cppc_bit
> +                       Assume CPPC is present and ignore the CPPC v2 bit from
> +                       the ACPI _OSC method. This is useful for working
> +                       around buggy firmware where CPPC is supported, but
> +                       _OSC incorrectly reports it as being absent.
> +
>          ignore_rlimit_data
>                          Ignore RLIMIT_DATA setting for data mappings,
>                          print warning at first misuse.  Can be changed via
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
> index ff8f25faca3d..0ca1eac826af 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -11,8 +11,20 @@
> 
>   /* Refer to drivers/acpi/cppc_acpi.c for the description of functions */
> 
> +static bool ignore_osc_cppc_bit;
> +static int __init parse_ignore_osc_cppc_bit(char *arg)
> +{
> +       ignore_osc_cppc_bit = true;
> +       return 0;
> +}
> +early_param("ignore_osc_cppc_bit", parse_ignore_osc_cppc_bit);
> +
>   bool cpc_supported_by_cpu(void)
>   {
> +       if (ignore_osc_cppc_bit) {
> +               return true;
> +       }
> +
>          switch (boot_cpu_data.x86_vendor) {
>          case X86_VENDOR_AMD:
>          case X86_VENDOR_HYGON:


