Return-Path: <linux-acpi+bounces-16146-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEECAB3A424
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 17:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E7685B10
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Aug 2025 15:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53B221F2D;
	Thu, 28 Aug 2025 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iVcxqWuh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073921CC59;
	Thu, 28 Aug 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756394459; cv=fail; b=W0Yj3GdxqzGio1IEQPMaCpBWBGSwv3x/A0MDy5HtxVAzK3EvmgkDrwC/6Qn5GxzzCK9ueKz/StSENjvykqw9rbLyDfs2a19ZYXZLmG2PcoapLSNaYAdb+fn5eATCzvxfd+bIOOR7RrZDTSHPf1XIPM887LRcUpFwTuclmYL8ZIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756394459; c=relaxed/simple;
	bh=LHHu7d+4jr4/Q+ywK43SQf4guEwzOIhu6sobgQDFcwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MvCB8IqTD2VlFvusipCnFzz8KdroSU4HF+32zuE8eEf0ODjJLx9IFGgg1FxxcH56BGSLFyFZEUDS1/X0a5yMw8zOnVNXRulHWvu/zpBPAiO+7imWsKeMkq9Mll8TxwMgefPCKCah8GV+2t5wRp79T/leotzBIHZuCZBuAK0KN3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iVcxqWuh; arc=fail smtp.client-ip=40.107.212.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LS3k5HeqNwcRiWJdSjmuYiFvRPt1rZevX0XZEXpq+8DCV980td0M8QIzGbqXbsGs+vOlFtjOeVipeIDMhRnGj3fe3eg/IXIv+mwyLKD3uZJXOO9b3aL7nLcfOjYb0jzFqaaT2OodvTuZaZx9mqE2rQlPBakrKDtkiNKPK4JrHfTadQF/RxEuNharuI75whLuLjrCERxDDa1gFbKtSKrTnJ6HZ2wz6QRUrxUBQXPL4UVdXg347+120jwzuWW2tJxEIZ8H+L0QKhfLc2736dYzYF/NWhsXGR31SdhYmTxZCydngLh+7izrxfuYUPGkCIjKXwP2VohV5np0P+d1uBkplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHHu7d+4jr4/Q+ywK43SQf4guEwzOIhu6sobgQDFcwM=;
 b=UnzxPlanK3Ps6xg3r8hVVCMHs4GVozPtZru2/gqcixcE8/mRzCvCeF/1J870HMkRw3l9eiiXdpRCfXhLwvL6X0vZuxHcCJAsfPv1lSikkpf10jQIn0f+atbTcFa0wJIKXEsiAIFtxG+IvhojyY1iNTYtNJyO+bBhD7xDC2+NjftGBp0iJhqwbq4LRNqzgjGqr/drt3vepumPHR+EuMHNwlRTy/USS1x4xI6JFy8ALKPWPIFHfbVP6pJS6m3sBIDRy+PErs3Fuzsw7httlQRET5gJg7Vj1esHp4xYEKIFlSzZXlEWkHHpILWxmmCRH9HTfdjd+VYGDTGrAHTA+rKIEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHHu7d+4jr4/Q+ywK43SQf4guEwzOIhu6sobgQDFcwM=;
 b=iVcxqWuh6J9StzaYBVb3XDOunnd4lgu5tofAfsYVrVKNmnClW0bxES426VuSWZtGqYr+5YfaylM/H4nuegeqbtLSRAzH8DSYhRfQXJh7G7CdMMjHDEb1OgbKP/uxaRPnu4COCtD68kz7JNkQDWSzyVZsQTYfvR9jInmFFPLOn20=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Thu, 28 Aug
 2025 15:20:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%7]) with mapi id 15.20.9052.017; Thu, 28 Aug 2025
 15:20:51 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Antheas Kapenekakis
	<lkml@antheas.dev>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mika
 Westerberg <westeri@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Linus Walleij
	<linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Thread-Topic: [PATCH v1] gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-05
Thread-Index: AQHcF3yOZVJ3POi+6kyJzazLUKM95bR3hTYAgACqfAA=
Date: Thu, 28 Aug 2025 15:20:51 +0000
Message-ID: <429fdac8-44dd-4cb1-83b8-f0941dcdd388@amd.com>
References: <20250827175842.3697418-1-lkml@antheas.dev>
 <20250828051038.GT476609@black.igk.intel.com>
In-Reply-To: <20250828051038.GT476609@black.igk.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|SA1PR12MB7271:EE_
x-ms-office365-filtering-correlation-id: 7359ccfd-7f48-4a67-d4e9-08dde6467932
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmFZVkg1SE5WdEZpZ0xOdlpUeURGNDE5Njg0NVViMFhkeU9rbllLRFhDQWdx?=
 =?utf-8?B?V0FYVmlCUFVncFJwUkdHb0IyeXQxS3FaUkQyVEtwUzJ5OFBkTkRuamU5b29v?=
 =?utf-8?B?T0grR2RVNU9Rc09Bc01CWVYrYk5Uc2F5cXREckFsZ29wdmkyZDg5amhZRmJT?=
 =?utf-8?B?SXFsbzEyNXZPcWRiN1JZVVV6M2tSYXlvSkVRblNlSFR3enVVNFYydmgyNGtV?=
 =?utf-8?B?MzcwSFpqVjU3Y1lvM1NLcHljWkV3ckZxN2duOTVXcEpNWElXOFpZeHJqenUy?=
 =?utf-8?B?OXlsUnJQV0orQ1BtZTlZODhGU1VzeGtSMVJ5eWQrWnpyZURqTVFyUXVqRTEr?=
 =?utf-8?B?cHlRbkVYNm5wRFdKY1lXQ1pQMFhhSjczdEdIaDhOdlNZOUFXT2NHbUNmYXRH?=
 =?utf-8?B?Y21TRGQyRUJnZWxxVWxOQmNjSHg4LzRISUFpRkhEM0IxcEJONkE3cm5TMG9a?=
 =?utf-8?B?aUhLRTRUMEF3ZkFZc0kyNzR1VmhRZDNsblpZV0JqbHlVVTdLY3JkTlRDUUhl?=
 =?utf-8?B?OEh0eTJ0NFVubGRmNWhjWnVRbTF0Y0NkWExVMjltV014U3dIRlBhTTZUMi9a?=
 =?utf-8?B?TlgzY05GaDFZaFpRY2tRZ1hBbkswWGZWRnZiV3FjTFY2R01EL3RLNFdNWEhC?=
 =?utf-8?B?bjdDZW1hU2s3WUlLQzc4Tm1BdWEvb3pQMG9yQUVxb1IwQkZzalB5ZUJqUURa?=
 =?utf-8?B?RkNoMmRXZlZkelVZNVdGcTBpR1Fsa0VTUTFNenRQTmV5cFpnbm5URlVwZnpv?=
 =?utf-8?B?eXI4cFJ2Rjdkd3QxRkYxcW9KelRoOVpHVklqem42dGltL2VkVFhRSm1oaytt?=
 =?utf-8?B?ZHgrNXBFWUFVSjdHeGg2c3pYYXpKd09rQWh6Y0gzejNHc3hkMFJHUEFPOUdr?=
 =?utf-8?B?NXN4dzhHZTZRSk8rZWVJdmNrYmtBMU5EeXNFaGJ0NFY4djRNRHd2VG5zTXBP?=
 =?utf-8?B?dmRUT0dybGQzK2RTT3Y2djczV2o0WlB4VkkrOUhtSXQ2bVFPUHVVempsSnBO?=
 =?utf-8?B?Qk44cnR5aHlpU3pnVWhZajNMS0VYbzFXOVY5RlU4VTRnT3N0Q1YxcnZPUWpT?=
 =?utf-8?B?SGY0NWRnVmRIN1BRVzdLT2x1MlRvOGt1ZVVPTXpZTGZsM2s2MlIxQ3I4L1ZJ?=
 =?utf-8?B?c05CcXpBRktOSVZnUFBTWEViSWJGRmNLa2Q2Nnh0UnBiblBoUyttdE1LZ2lN?=
 =?utf-8?B?NFl1YVEwUVRYZ3FIc0JhZzl0cWFPSnplZXJGZUhWYzl1RG5pN3Q1U2hOeERh?=
 =?utf-8?B?d2lZNGNna2Q1bmNDZU5xbTE0L1l5b2hFNWI0cjJHcDNJRlMwQUhDMWxJNTMz?=
 =?utf-8?B?amp4QnRwR1FlUlBxalNqY2ZBSWxOMHYzWkZMVWVUNHU1eXhyOUNham9SVVN1?=
 =?utf-8?B?ZlgxUU1Ob3p0d1dCNWphOEdpaU1vUElnb0JiSXJQSTdUNW5xQnlUSFkvZ2Fw?=
 =?utf-8?B?ZmhiZ05GMjBqNGc3Tm1IYkpZMVQzamJOK0p0KzMvL2JZNWZUUjdQNitDU2RK?=
 =?utf-8?B?ajFpanU4a3dlMnVvYUdDRmlVdExpWXBLbU9yeVBqcnNaWTc2Nk1oR2FuazZV?=
 =?utf-8?B?ZzA2QTNYUEc0Tmt3dmQ3ek5obHIxeGxWR0g1YURIQmdKVG1FeEJiVGtaMlM4?=
 =?utf-8?B?YlpUc1doL3lybHdrWmxVdmRLNVowTzVneldSckJETEdkSmxRd3E3RkVmUllh?=
 =?utf-8?B?cXVZWlkyU2lvM3FkK1NzMXZINzJpdjZXS3V1c2QyV2xOdzFUbGFVbXlha0E3?=
 =?utf-8?B?WWVwa2RwclowTWVSN2M3alVVT3dIcXVzbFR0ZkM4enBSU2FOdW9QSUZiT2po?=
 =?utf-8?B?N2NEZFRqSnJBYU9oZ1J1TU00cFBCQitrYTJtQldXdXN6NVV6aFFzNHFSYSt1?=
 =?utf-8?B?R2Y5dEVDbDViRFprN2o4a0RpNzM4dnVQUmdEbDBoajZKZkxxUkl0VjJDbkpG?=
 =?utf-8?B?aW5wWWh6L0U5U0lhVnpTWG5Va1RneElGa2duaWZPb3h5dm5nTFhQV2pPSVF1?=
 =?utf-8?B?cEc4OFZXclRnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K3ZmQWtXK3l2QXZNQVlNbWE1NklUMTl3d1dFNzV1UWlqNjNOd1NNMWZxN0ps?=
 =?utf-8?B?M2VkYXJPaGJrREVESTFXOVcvdzhyN2EyQ0NMTXU5VTN6dllsUG5JY3FDNyt3?=
 =?utf-8?B?VXV2ZW50MEliOUxsLzlYVXliY0dQcHRZRmxlQjhYZEx1TGFuajQ3akIyMHNj?=
 =?utf-8?B?VUp4bEVrNTYxSlJIaGwxaUpnTnpJWFZTNGozSHFNWUk4bXk4aDFKUUc4NlhK?=
 =?utf-8?B?czF2WjhaWnlqcy9VR2V0Z2loaGZFOUQ1ZXowcFJTdGM1YmNCL2FzbXRkT1VO?=
 =?utf-8?B?RkZVcldWSUtJdVo5K2l6Y25rdTBnYzFNUS9ZK21TakN4SmpxL3NDbUg3eis5?=
 =?utf-8?B?M3I4c01kL05CU25MZ0pqTE8yOXIxNWNuRFIyazhlQTMxTkZ0TWM2R0hwaG1R?=
 =?utf-8?B?cURmWnZWSkQrY2pydHpQN0VQbEJvUVBMdlROaDFEK2lhd1ZDSHp4OXd5S1JY?=
 =?utf-8?B?a25HZnNmdDcrREVYMC9jMUFieGJyNE9WUzZvc2g5eWsyRG0wSFdTenFVK2Ew?=
 =?utf-8?B?elBpRlpVdjQzWjlWNk85TnZ0UjlBZmxRdFF5Nm1aNUtlQ0RBY0dhbnpIM0FQ?=
 =?utf-8?B?WWErNUsyMU9VS2w2YUlpOTU1cUU5cHluZFhocVpPdDNGN2ZXVENwU21yNXFU?=
 =?utf-8?B?ZzZ3V1haMi9DaEdwU2F4eng4ZDNsRFljRm1qSnFQRG1xMnNEZmdqNUh5WEwy?=
 =?utf-8?B?M3l3Q0hqWmcvRWNXTXE2Uk9KSFRhbWx3SHZ6QUxNSHJIZFFzRUdkYVFTVktu?=
 =?utf-8?B?eklzeFdBRHhxSldsSm9XSW1RbmFnbndsNTNKd3RPMi8zVlp2SnVPOWtOaERK?=
 =?utf-8?B?MnZ5aDRNZE1ibmdVOENZdHBUQmc4NFpsTjNOYzVFd3BxazhLQWRIYzViNFhs?=
 =?utf-8?B?cFJ2cnczaHA4T0ZiUU1vdXNaWE1IQ2dPdmlVRTd6UWtEaUphek9YbjZxajY3?=
 =?utf-8?B?SjVnZkp0OEN5NURkUE5uVDc4cFJRTTEvbDlISnE4RGc5ajl0dzhhNjVTOEl4?=
 =?utf-8?B?Nzd5ZzJpTHVGK1A0UlZqNmRQMDVTSUxlQlNOL0p1NEtpSnFXRE9vUlhZVzFB?=
 =?utf-8?B?bi8zYzArdXFtUUQ3R1Y3RlI3M3Q2eWQySHM1d2psQkVXWHl3LzZEOWVsb2xX?=
 =?utf-8?B?U2xISGFRdVprYVpHL3pncStNUkFmbG9BOTB0T3NqREV1TVhkVnQyMndnM3Bk?=
 =?utf-8?B?TGsyeGszZ0ZObW5BcVpyUjNLTDlZNzYvU05FVlU1VlN6aWFqWFpSRFBvTGRy?=
 =?utf-8?B?TzR6aEtPMzJjSWRjNjc1dW5tbzgycWtTd2pzT1hOT2ZRUndoL29sQ01VMnlt?=
 =?utf-8?B?YkZqc0p0WFJxYVBwYnY4dUxJdjNzdWNkb1cxK3l5K0ROQlhhVUdhQXhHU2x6?=
 =?utf-8?B?VlVKZG9lZThIWWI4bm1xNTRVNXlJaXppSnZRRzhvRGQrd0ZxTEg2MGpMZExP?=
 =?utf-8?B?N3JHY1A1ckMyNHNZeXpoaWVoZG9uRlU4V1o5K3E4cjJMWHJicUpxMWFtT3Zx?=
 =?utf-8?B?VW84VmFia2pudlR0RjFmazVJS3dJL0VqY1NZbDJKdlE3Ym51Q0phZ2hkNDVZ?=
 =?utf-8?B?UUk0WG5xaU1uNHF2bXBTZk9Heng4K09JVDhZeTRFRTdmT3kwaUJ6UjlwUDZn?=
 =?utf-8?B?aUxxQ0FGRWhUemVSQW9nUzF6dVdQcEtJaVlYa0QzdjIxRklsL1o4TmRWbFdj?=
 =?utf-8?B?VWtjaG0vSCtyVEtMUEhxaDhyZnF4N3ZRUU1BbkkyS0hxWjVxVmg2cXZaM2xU?=
 =?utf-8?B?TU8vYmRjeHRiWmtiemFiMzBmZ3Eya2hHd0MvVktJNzlMVncwdHArSzRPN3E4?=
 =?utf-8?B?dEdYVVRCd3ZPSnhLcW1CMjRLbzNHazZrL0NlRHZ6NlNmUDB2aERwdWJEZUNM?=
 =?utf-8?B?RFZGRmJjR1lObklTbVVzTnM4cFMrM2EvQy91UmVyUC9DOEJuY3VRNldhK2h5?=
 =?utf-8?B?ZUhJbGpYYmNyYXpEYXFVeDA2NVpzeGR0WXZINFpDZklxVkZZQU9NakpNclFI?=
 =?utf-8?B?QUVCektVc2NVMHJaNUx2NUZudlB1YU5JeTRsekdOcmF2Vzg5dHdpS3dPd29Z?=
 =?utf-8?B?ZitjQmM4V25aOGRtZnlmZWoreXJjcXkyUzZLMnJ4VGtYaTJZclNQZnRhNm1x?=
 =?utf-8?Q?Xn6I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC296EE39560AE4592A2B90990BED0BC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7359ccfd-7f48-4a67-d4e9-08dde6467932
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 15:20:51.1395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tU9hPieVa7YyBrhcTLi/GOyskxZ5aoI6Amurh7vNb3OGzOoMIoHcqcKLCIs2PCgRfBM4LwCwVsz++hPpMg1qYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271

T24gOC8yOC8yNSAxMjoxMCBBTSwgTWlrYSBXZXN0ZXJiZXJnIHdyb3RlOg0KPiBPbiBXZWQsIEF1
ZyAyNywgMjAyNSBhdCAwNzo1ODo0MlBNICswMjAwLCBBbnRoZWFzIEthcGVuZWtha2lzIHdyb3Rl
Og0KPj4gU2FtZSBpc3N1ZSBhcyBHMTYxOS0wNCBpbiBjb21taXQgODA1Yzc0ZWFjOGNiICgiZ3Bp
b2xpYjogYWNwaTogSWdub3JlDQo+PiB0b3VjaHBhZCB3YWtldXAgb24gR1BEIEcxNjE5LTA0Iiks
IFN0cml4IFBvaW50IGxpbmV1cCB1c2VzIDA1Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEFudGhl
YXMgS2FwZW5la2FraXMgPGxrbWxAYW50aGVhcy5kZXY+DQo+IA0KPiBSZXZpZXdlZC1ieTogTWlr
YSBXZXN0ZXJiZXJnIDx3ZXN0ZXJpQGtlcm5lbC5vcmc+DQoNClJldmlld2VkLWJ5OiBNYXJpbyBM
aW1vbmNpZWxsbyA8bWFyaW8ubGltb25jaWVsbG9AYW1kLmNvbT4NCg0KSG93ZXZlciBhcyB0aGlz
IGlzIHRoZSBzZWNvbmQgeWVhciBpbiBhIHJvdyB3aXRoIHRoaXMgZXhhY3Qgc2FtZSBpc3N1ZSBJ
IA0Kd291bGQgYWxzbyBhc2sgaWYgeW91IGNhbiBwbGVhc2UgY29udGFjdCB0aGUgbWFudWZhY3R1
cmVyIHRvIGZpeCBpdCBpbiANCnRoZSBCSU9TIGZvciBmdXR1cmUgbW9kZWxzIHNvIHdlIGNhbiBo
b3BlZnVsbHkgc3RvcCBhY2N1bXVsYXRpbmcgcXVpcmtzLg0K

