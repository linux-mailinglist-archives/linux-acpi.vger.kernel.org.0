Return-Path: <linux-acpi+bounces-18886-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E10FC5B08B
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 03:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7EEA4E226D
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 02:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB144224AFB;
	Fri, 14 Nov 2025 02:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="P4HaKfLw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011002.outbound.protection.outlook.com [52.101.125.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26727456;
	Fri, 14 Nov 2025 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763088744; cv=fail; b=MzwIn55yWEBHAA7+N6Y/UQ1pXQahjgy3u+GDAdmG4ad+gUl1F5Ii+Tvu6hoVD5th2zJqPq9MIQrq+9OJax0gbu8dpiNzwNJrusAEY5LFWtE8DHDf/piyKWzJLdZkdEj/gZZa+S/axf1VTxZ9biRe8+yHo9f+zWGYRhMsaWyk0zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763088744; c=relaxed/simple;
	bh=0VjXcJRK2FYDu+7Nebg4BKG3v6+CgQVf6QAtBQZZdpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TqSvcqff75wcfXF9TLlhx0HXY8kwFgzZiHB/sLZwKLKiu+7bh8E7ArquF5rP03/OV+0L5zqL7OkXmQhLIbVlyGRoRuoQlH1HPiEhhZK9buSXC23qg0vwilnarh84SWqNgFNOPlEZkSPTQUSnTU5wkQtoxq0hdhUKEJmj61zdccI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=P4HaKfLw; arc=fail smtp.client-ip=52.101.125.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIHUG+24mJJdbmT+rHFTHZ3VKVJITWhRNpxbLTmZ8OGLTS3tX+rKfghRwO+I+N2NCVwp5HUI+NCwWgapZV1Ihzrwfy/Y65aXVgVcufGJbQPcQp9iufd3xRqkTvzmTiUa+JuyVCpeIyprlpmKON+CCFq/qzV1tfqF3MIVaa3Jb620+T5aHhTBR99atqcZLsa1wZDCewJtmPshIlY1T7mYkoglswD7ss+K+5qMGuQokdDReSrNaGuOUFnZn9LecJ1AXIVpVaa9upFnv5RwFJ84Re51q9N3Mr/c5EfcalzKTxBUQEAo1UUYG+EIfJIExmYZKUpzSnW/FAmPBNL0FkfHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VjXcJRK2FYDu+7Nebg4BKG3v6+CgQVf6QAtBQZZdpQ=;
 b=QLGnOEKUj6Cf5cc8Zdzuw5xHRyv6+v/WFBeqaM+LPDh8scKfNO3RpSpTTvumPZfy41YpbGhAiUCiVZf7Xxumwtp4gJig2MYvQwp4rtHdifk7KFgwn4ZztmZptBWG6CH/Wynlf5G2TExIk201W8GC8BubyuPavuABYjMCdVLbKhijNkzm9dxgQ6BAORGdl5Ndhsy4u0Si9ap/uZkPWGGtlXVd6oUUW22pixPFckp239HWWJPy2Jd+S3K0iiJ4TIc8pp6dIVzjnmzs6DKBRwcvHpR/SE+fSBawEBqCL57cbqEqXm23BjrLPkwy2GBXkjq3mtTKpYekOgUT2BiWfu71iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VjXcJRK2FYDu+7Nebg4BKG3v6+CgQVf6QAtBQZZdpQ=;
 b=P4HaKfLwc4q3aPbmOC0ZvKjxOwsUnVprcnK+9idRdGOo+aw+LPjPqLVWjKla1Bx4rFKKWeatOXSXBKf9XJe2+k6p96jO5ei9lijpvqQgQ4lMe8mcqvsnnv6Fdn56ZvwqDCZ6uMaPFbSJhbwBozxska/oaiVPivIvavs1FTcSMeCgCQwx+WTAACKX5kGda6WGO+E4Qe+x0oaxtR48tzLg2FS+O2kEdcFZwiZPLW5T0XXBR54UNH+z7MmMLnWzLxz/5L79rXtIWFa65en6EelFETfOCf8S/3gBjWfIaOHMykC1WCLqu5S3i07tMRCIo4or89p5YMgL+OvTT6VQvdo9Dg==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYYPR01MB15048.jpnprd01.prod.outlook.com (2603:1096:405:1a3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 02:52:20 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 02:52:20 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Ben Horgan' <ben.horgan@arm.com>, "james.morse@arm.com"
	<james.morse@arm.com>
CC: "amitsinght@marvell.com" <amitsinght@marvell.com>,
	"baisheng.gao@unisoc.com" <baisheng.gao@unisoc.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "dakr@kernel.org"
	<dakr@kernel.org>, "dave.martin@arm.com" <dave.martin@arm.com>,
	"david@redhat.com" <david@redhat.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "gshan@redhat.com"
	<gshan@redhat.com>, "guohanjun@huawei.com" <guohanjun@huawei.com>,
	"jeremy.linton@arm.com" <jeremy.linton@arm.com>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"kobak@nvidia.com" <kobak@nvidia.com>, "lcherian@marvell.com"
	<lcherian@marvell.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "peternewman@google.com" <peternewman@google.com>,
	"quic_jiles@quicinc.com" <quic_jiles@quicinc.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rohit.mathew@arm.com" <rohit.mathew@arm.com>, "scott@os.amperecomputing.com"
	<scott@os.amperecomputing.com>, "sdonthineni@nvidia.com"
	<sdonthineni@nvidia.com>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"will@kernel.org" <will@kernel.org>, "xhao@linux.alibaba.com"
	<xhao@linux.alibaba.com>
Subject: RE: [PATCH 20/33] arm_mpam: Extend reset logic to allow devices to be
 reset any time
Thread-Topic: [PATCH 20/33] arm_mpam: Extend reset logic to allow devices to
 be reset any time
Thread-Index: AQHcT+NAJ7EH+81QkE+D3CcGrc9E3LTxg3QQ
Date: Fri, 14 Nov 2025 02:52:20 +0000
Message-ID:
 <OSZPR01MB87989901AD173B1BE7D853198BCAA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-21-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-21-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=f4ffa17b-093b-40bd-94c8-bdc07dc74657;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-14T02:51:45Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYYPR01MB15048:EE_
x-ms-office365-filtering-correlation-id: b05107d3-4c80-4181-747a-08de2328d48e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UEErdjhsa0tjQUZXYkdKcGhmalNuQzZXZ2JvVXZ0cFBhVm9DQlE2RjdT?=
 =?iso-2022-jp?B?Z3VyY0lvZ1JBOGpURkdUcUJndVlHT0l2VXlOUU9RTWVhT1FlMGcxSjAw?=
 =?iso-2022-jp?B?MGVwdWp2dCs0K09rMnZET3dnNXBySEJLN1oyK28wRUUzU3JzcWtmOFlP?=
 =?iso-2022-jp?B?czhtMGRpUDE1QWN4bFBVRE1UWCs4eFJKSkRlbmlodGphRlBYMEtQWUd5?=
 =?iso-2022-jp?B?a3RxVDlWUHZwODkzZUNPVXNabG1jNUJNRGlJY0l5VTZoc3NFQTIvVHFJ?=
 =?iso-2022-jp?B?SklFQVhNTzlQNkVCSno5NUlqWUNsSWRFQ0dmNzZQcWV5eGUzYXF0QmJo?=
 =?iso-2022-jp?B?c0RaT2xVaUR3RmRNME1oVEdua3lJajZFRThNMGpNdHd4UER6RHZmN0RO?=
 =?iso-2022-jp?B?K1pheEJJV3JnZzR1RWtxMmJaMU5ocGk5MWtScDU4NEVNVzdMSU1FY2w2?=
 =?iso-2022-jp?B?QzJSNk43NGt6aVNITGNRU0h1R3grTmRrS2xiMWxHVTdQYklkUVJGSGVI?=
 =?iso-2022-jp?B?cGI1VTVsWVQrQVpsL2tGS0dUOVpIR0lQSVF6bnlkZDRZWkJTYnl0em1Q?=
 =?iso-2022-jp?B?T0M2aTNHN2xiRlpOZUV6c2lJUGkwMWF5ZlZTUUpaWjZhT2IwTnBzTnl3?=
 =?iso-2022-jp?B?M05sMUx2K2NLWUFKRGdDdG4wQkNZRDc2OHVaYzhGRmt1NU9JT0N5bGRG?=
 =?iso-2022-jp?B?bTNEaGt0b3ZvMlZNVGhXUytqb283Uy9VWWxlbHJwRUtKVTBZQzhYTUFX?=
 =?iso-2022-jp?B?aXl1bzhIc0k2a3pQVk5wVkZycGZkWkw1c3M5cFJyYXRFSEJqeGtPYU1R?=
 =?iso-2022-jp?B?em0vdXpXdzBucDNYdCs1QVBGclZSU2hoeWtlTHVkR2FJek5jdTI0VXkv?=
 =?iso-2022-jp?B?OHZlalI1VHpNN0RIeVRZd1BKTlRVMDU3U2JtbTk3SFAzZ3ZnYzJ4ekJm?=
 =?iso-2022-jp?B?V1RBNS9RS0cyRUc4c3k5R0JDbzF1MHlEMW5sMUpqRktEQTB1TTUxc0Ur?=
 =?iso-2022-jp?B?VDdMTFJTdFdheW52NWZvZWNXeVM5YlVZQlBZaXA4YWp6Nm45S1RYK2JL?=
 =?iso-2022-jp?B?TlVpTVJoSmV1UHUwRHRWbUliVXRTc3pEKy9jbUExaHQrMDFkVXRqWlo4?=
 =?iso-2022-jp?B?YUtkNlU0RXFERWJxUkJsVzhubE5LM283S3kxR1craUlaL0pRVVhxNnh1?=
 =?iso-2022-jp?B?Y2N4OTcrTDRpZnI2RzBtUzBHRGd1VEQxaXFpWGFZZFF0a3B4SHFXQTNK?=
 =?iso-2022-jp?B?ZCt2ME02UDJudzViekRLcUFoRjFObEtPTHg0SDgrcERBYmNOMEFkdTZ3?=
 =?iso-2022-jp?B?TmhBNStaQWNuOUtJNEVoZm9rSXdMdmxLR2hNU1FjN1ZkN2g0cXpaYmVN?=
 =?iso-2022-jp?B?cFExSitlaWpwcS9Ba3ZxdUpnK1NZMXJZbEc2NlFTVmw4WnJYaXlnUGI1?=
 =?iso-2022-jp?B?N3FuOE0rbnl4Yk53eXM4Y0VpcTlGVXZPUVlZNllMd0QwUHd3bm9PYmdO?=
 =?iso-2022-jp?B?djgxNlNUUkNPcFA4TzBDSUhjbzkxV1BsQmxsMjFWcnA0SGJzdmM0TTNm?=
 =?iso-2022-jp?B?NFZFZ0xYY2o4dW53SzFPeGsyM0d5VXdubDZaZVVZT0pIcklsOUsxdHlJ?=
 =?iso-2022-jp?B?MmE5SW8wV3QxaTdvejJOS1M0dTZLTVJ1QnVrMXJ0REZHUi94NmhoRWhR?=
 =?iso-2022-jp?B?YTVPbldaQXJTODNJWjAyT0dEUzJsZEYrRnQ0QnlOcnp1YUtackgxSmNa?=
 =?iso-2022-jp?B?R2dqb0NIb1R1WkJseldFMGE0RFYxOFdrZHBhQVZpUEhtR0tuMWRqTG1X?=
 =?iso-2022-jp?B?SWc5NXBKcndVYmpaWVkwMERqYitDQXhGVWZBczREVkl6UmZ0WDdGbXd6?=
 =?iso-2022-jp?B?eWdxWVdWV002R1E0VEdtTERlb2ZsS0lIaWVWdExnWGNyR3FFMUEyZjRh?=
 =?iso-2022-jp?B?UzBpMDNYeHZzV0xKMXZXY0ZPQTRSVmJ5cHVZeThhYlRKSlpwWXREMGtS?=
 =?iso-2022-jp?B?M1l1aXNGS1lvT1ZoVGlGckJrdUhicHRudnAvRlJXV0t4VE1iS3dIVzlJ?=
 =?iso-2022-jp?B?YU1KRnYyZGIzSFRZV1k0ZjFZQ25maE5HSDVXWjBOdFdFUVlLVVBHUGh6?=
 =?iso-2022-jp?B?eG9PVzJhd2M0VFFIS3d3YnkwdmZHVm5wNGNJME9yVWFyMXpLdGJMSE9t?=
 =?iso-2022-jp?B?THluWlVlR096Y3Vhb1RQeW5aTm9HTXZtc1VGM3JMZTkweS9iQnZYKzdr?=
 =?iso-2022-jp?B?dWNmZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?Yk9xY1NBaitESDB1ZmtaTm1NdXJPSytEek1Ga1B6a3VmWURBd0NKbE9M?=
 =?iso-2022-jp?B?UkF4eXMyd09EQ0VObGN3VVFHRHU2ZE9ubXZ0cW1iZFlDdmVnNFViUHpr?=
 =?iso-2022-jp?B?NmNmWHlvZFNGQW5ySjZWekt0RmJ0V3Y3aWlRdFRhbWlUSG1HNGxNczhZ?=
 =?iso-2022-jp?B?Mi9mSHZuMWhKWVBjVjI4b1VWRjFiTlZmQ25CYy9YS0c1K29FdzFmaEF2?=
 =?iso-2022-jp?B?T3NBK2t5Ymc2UWJrR2Y1RGJodEVyeVpiOStEUjRKSHJhejNnNnRNRWdx?=
 =?iso-2022-jp?B?QzlYVHp4WWNRQUgxLzFTM3lvNFNCRVV3RE5qSDBUNzRKRGhvRkV1Mjdp?=
 =?iso-2022-jp?B?ZUE0L1VRMUU5SHhvOFFoT0hMUUJTM3V6WmU1U21CSEROMTNFandsWVlz?=
 =?iso-2022-jp?B?TTBEOTl6WkI0MkRsTEdSUldiNTVOQ0Q3U0VyWEZPS3h1Si9PeW9QTndD?=
 =?iso-2022-jp?B?VGtXMGF0ejlTZytmQ2UwVVJYdTNNdnRuZlJzTlAzR1pZSXUrRG5GZURj?=
 =?iso-2022-jp?B?ZXdvTXVzS0w2RUNzem5xbnQveXVkcmUrMW55YTRoYjlPcXNvb2VPbFBM?=
 =?iso-2022-jp?B?OGFZWmVYdG9QN0lqbHRIcjdiYlkxOXdxVldMZWowUlpYT2NTRk1IbTBm?=
 =?iso-2022-jp?B?b292c0x2TWNZRVlxcjNyRVVKVG1UMDJXUWJEMjRpMnl3bWMxUUJhWmt2?=
 =?iso-2022-jp?B?NzhyelRKSzBPVU9rQXlnVGs1bkR2UkJZN1BUWThZN3duSzNwamgybWNB?=
 =?iso-2022-jp?B?eDd2UkhCY1czcEMvSVJZcjlvMG44U0xlQU54RnJiM3p3R1p5NHR6Qldv?=
 =?iso-2022-jp?B?UHNMNEVGMXF2M2FwWTRZc3VIUTlWS3ZEbGdORld3OXZIRXBzeUdEZFYx?=
 =?iso-2022-jp?B?WmtoMjZFV3lkSGJTMEo5UGFMSjdjVnluUjc2TEhnL1p3MzltV3ordlR2?=
 =?iso-2022-jp?B?c3paRnBxWFBjenBKM0g4TjZhNHNQL05rZDBONTNaZ0lrVG5USjl1OEJq?=
 =?iso-2022-jp?B?TWNYR1JTTXRqYXVFaEZhcUdzNTVGSEZQUGRBK0c5OElDKy9USzZDZzds?=
 =?iso-2022-jp?B?Z2Y0WFZlTDdoL3BacU03YlphcmlqUTAzbW1zYjMzMXFCNVU3VjRFa1dm?=
 =?iso-2022-jp?B?OTdiRkcxdEd1bHBNdis4WE9hcThobVFZTVJZdnlqaHhrQU01aXNIcmsv?=
 =?iso-2022-jp?B?U1V1VXdQb05XM05HYkViamtKdTlpd01ZanFQRllXa2N1RFQ5ZE15L1lS?=
 =?iso-2022-jp?B?MVJXY2U5a1RISFZTTUk4Q1dXekNoWGNXY3lYeXhCRHFTYm05SkVIQUwz?=
 =?iso-2022-jp?B?Z3M1bDZxQ1FRMlhCdEhrZFptcGRnN0RXblFRTlphd1ZnRWtsNkhzVGpH?=
 =?iso-2022-jp?B?S0p6cGN4bXVEVlFKQWZkTFpSaGEyWElQU1VYaDNac21GTmdGSTM3eWRJ?=
 =?iso-2022-jp?B?dzYrd2JYZmJ0QXpYQXdoeXZFTVBSbWZqOWpPbS9hSXI3a0laMDVqZ1NF?=
 =?iso-2022-jp?B?bWRQMHBiZUc1eG0xLy9ObmRxckEzTnZpR3NOdXhxcWkrTEwxUVFBWkJw?=
 =?iso-2022-jp?B?TDlrdWdKUXI0dmM3SjVsQWl2cnpaZUFtN1pKLy8yWURnbFdrbWdwVzdl?=
 =?iso-2022-jp?B?dDlXWVIvdElTLzhGMmd6UHVBWlRaVzhkcEhnc0xDem9ybklmdUZkeXIz?=
 =?iso-2022-jp?B?Q1l4ZGZwMXE0S0pzS01rM3ZuUVJlbXdTa0Y2VlNCTUVvM0VySDRvM2lT?=
 =?iso-2022-jp?B?QkdlZVN5S2NoOHAwS2pVTHlmcnlQWjVBZFc4aWpYWTFiSElGeTFQd0kx?=
 =?iso-2022-jp?B?RlVDUHE3dTBCOXE5RzA3ZncrV0tZWS9lTUFsd0FoOUpmd05VSjRBaCtK?=
 =?iso-2022-jp?B?Y0p4MTlxMjdyM0lPV1lCSjdkdzQvT242bWJjQ3hZekd1NjRMWmxiNmhG?=
 =?iso-2022-jp?B?aFB2blZYS1JJY3c3OWlHZnp0OWppeUh0SWhGZk1oZnB1RGFlNWJqNERW?=
 =?iso-2022-jp?B?aThkUTBaUHgrUmVUMXpxdWZIcUlZT1g4bGc5YWpCbnNqUDNlU09SWEZB?=
 =?iso-2022-jp?B?UnhPbHJVUVI0SXJjNmI2RExCeHRjdWRLWCtjUTJ6dENjTjJyQmEyQlls?=
 =?iso-2022-jp?B?Z2pDRDE0UzZuUzI5SUpyc01mNFlqTyt4ZUxscitRbUpyNFBnSThUV0RC?=
 =?iso-2022-jp?B?MjdLUGdMM0lweXJDNDNGcHZCTVVJWHZDem9PV01FNnpFYXdZQlUwb2tw?=
 =?iso-2022-jp?B?NHhQVmh0Tzc3R0dnTlpiV2RpQ20ySk84U0NHZFN4c0NqcjhMeWRVL0di?=
 =?iso-2022-jp?B?QzdMM2dEbyt4YXdzc00wVjdaa0lORzJkYUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05107d3-4c80-4181-747a-08de2328d48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 02:52:20.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pf2eVboVLKvcJKwi0zJ5Eb841S8eEGeU2MZr5GFQltIYDlI6Vfa60JC033nM/6KvXmFWOXeSGQcCxn92UwOE3IvH5KThgTK1VUdx4+Ku7h0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB15048

> From: James Morse <james.morse@arm.com>
>=20
> cpuhp callbacks aren't the only time the MSC configuration may need to be
> reset. Resctrl has an API call to reset a class.
> If an MPAM error interrupt arrives it indicates the driver has misprogram=
med an
> MSC. The safest thing to do is reset all the MSCs and disable MPAM.
>=20
> Add a helper to reset RIS via their class. Call this from mpam_disable(),=
 which
> can be scheduled from the error interrupt handler.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

