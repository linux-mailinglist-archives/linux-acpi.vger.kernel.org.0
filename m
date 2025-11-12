Return-Path: <linux-acpi+bounces-18788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DD815C50A19
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 06:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9BE4F4E06F9
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 05:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B569929A309;
	Wed, 12 Nov 2025 05:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aK5K9sV1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010034.outbound.protection.outlook.com [52.101.228.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70036E56A;
	Wed, 12 Nov 2025 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926337; cv=fail; b=KWP4T4deIhciOdERfMGA7bkCvArrSOANzNqUAdZJ1fPuOrSLkuXQrr/jbiZvivZehNTUEna10tXLYYt/Umcm56U1lD8I6c9co0E7sYvRS79WuOApkaFQr6QEdGrrtyX36LUXl2SZXWBzjOgJUmQ31qIUT8z75YQsV6QoRxlmJMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926337; c=relaxed/simple;
	bh=4UzJoqzoVlrs1zHaAr5sroTPjADnZjjk1d2yvKdWdGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XdfolIUUnCM7K3ZH8PKTcEv9wjqrnGM8hDQ/wVMXLch5Cp5E7ushAFTIEzsh6Olg11tRSQodGhdwLrccaPeB7JDqTeSdJIQ/dHsgwbGs6HOvArfCaX/6+FJ6D65oqwAxF+k+ugT/gybG9YDMZv7oa9579qCGyZrD/DQYOOk+/sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aK5K9sV1; arc=fail smtp.client-ip=52.101.228.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUXVx5UaqJiqjCzV3FG8uM6MuLpTb+gwo6OVxU8qqkFPWelgTa02qWVj7KKM3Sp0KeYkmIkJajKFK8KKNlcqPH6sEpGbxAyJr5PkHyQlcsyA3CsIUp8/rs85/rtcHLAEK1I+y2g66lSFFF4NSfNnqBtJB4wjKvF+sHZpAbzVSD6mVxS/2Hqbu3jApUxMXM012iir7oSgKCDIsRQ4VN1WvA28PtOP8kNyWbqhut/Z8ppdPHrAmdSHmhvH2NiTORnnGeSAlicvY7KHfxmQRZH8/Hc45nhUHC7zIvFydsqRZJbenHUtZyY/r8+mq1HZQl37xOMDHPitCK06oyTY1bqEBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UzJoqzoVlrs1zHaAr5sroTPjADnZjjk1d2yvKdWdGE=;
 b=PZcMXLT7+I3PI8vNJx6POlMIPN9vfaafLQS9bV9DtooHiXMTloeV0O1E/spxTWo4GoMEVxhgaCrS+55CB1LLKYd7tjM9g6YN31AfOkqP0pfBAw0FPovuPElAqP4OyQCPI60jP7usE6X6wamoc6o+0TxGoVxpVF++5FxgTevNUKsBlWD8di6UTUAKfd4ekvANSFHSul7bkSta1sI5UG4P87aBA3OhAOCfTVtZejzO43eyFI+cF94rCEhqO8YAmPJg4HQOuH+aEN0MQ4+aUHFeGLJ23t9rtBMUyd7nznuIDadIuO5LP6lnBdzrLm7l0+VromgMV/uaK+DV3awe2gt+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UzJoqzoVlrs1zHaAr5sroTPjADnZjjk1d2yvKdWdGE=;
 b=aK5K9sV1m1Ln3E1VHCzA801sgKTU3O6aEFttbad79HoCKKPBb7zVenTHoKmTjQr/lVaKgWB0PHgQhEyp6izja643VRQFx2/2kWQWAtThpkGQLxngUatzBd9wlSaKXvdYjuTp/SKfu9HtaiBVGTrjjh8oovuzwQy9kdM9sh2tJD2LrUFjn7+A0+K/9roLTAOCkJxH9odFZLTs7UNLMJC6txYqJSnx6oSSiGhN5ouCT4WD6hgQcoOCUg4gEbzMUkeU8Un/cE2LQAijLZhnZiYNGvGsiqaOzhwZc6yhB7wSI9s6iiTTCFNT3KeCwquzUqOJhAdOtVzTPrligerx7pgYlA==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by OS3PR01MB8115.jpnprd01.prod.outlook.com (2603:1096:604:171::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 05:45:32 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 05:45:32 +0000
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
Subject: RE: [PATCH 01/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
Thread-Topic: [PATCH 01/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 processor container
Thread-Index: AQHcT+MINemgyToNy0eWgnO/dL5pDLTujzkg
Date: Wed, 12 Nov 2025 05:45:32 +0000
Message-ID:
 <OSZPR01MB87980C093FACEEDDC491C2488BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-2-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-2-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=a552bc74-bbbc-4152-8641-387568162050;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T05:45:05Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|OS3PR01MB8115:EE_
x-ms-office365-filtering-correlation-id: 6e6df7e4-2879-4c58-4e9f-08de21aeb1e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?b2lXa0FyZ3hTSFRKeVR4dHhRUnhpR3ZSdE1Ldnd5RG4zenlhQ0JPMlhG?=
 =?iso-2022-jp?B?TThFd3RBTm5CUjlHdjNxUTNCUVRDenBQZFZxd0cyNXRMa3MwYWNCU3VZ?=
 =?iso-2022-jp?B?VmxlNS9JZnU2UERkazBBWlJGNzl3UkJyQWJxdm5ZN1lac2dXbXNzcEVT?=
 =?iso-2022-jp?B?Uis5elJQV25GdGdodHQ0M3FLU0RqbmVJajQ4T053ZWlodHdFU0VvYjJU?=
 =?iso-2022-jp?B?RUdxamZmUXdUSHJzbVpuN3JoLyt5YTQ2bE9MUXB1UjU5WG9JcFZUNlkr?=
 =?iso-2022-jp?B?amRDSndEUXl0OEJvWm11TEZEQUY4Ny80U0FHZzNDTlVwSWNzUEtlS1Z2?=
 =?iso-2022-jp?B?SG9aNUpSUVNYSm42blpmcXdRZnl3Nm1LUlBCYU5OZ05lbmRvQ204bHpl?=
 =?iso-2022-jp?B?SXlyZmhxWmRrTE5JWTRycEJwNytKdmJMcDRzdEJLWWErdnoxN3U4NWY3?=
 =?iso-2022-jp?B?aWxydG1vRllmaUVuNWcyd1lubUR0ZVpZc3l2TzZGcHlzKzNWdEVqblhJ?=
 =?iso-2022-jp?B?NndDT3Zlc1FDd3ZmbHFYT0ZkZStUSG94Q29ianZsOHh6TEpvWWd1RXRR?=
 =?iso-2022-jp?B?d3FYWEFubTVqdDJIaDZ2U1N4dzNOdk1uWkl0MUJhaHNpWHNJaDBLR2du?=
 =?iso-2022-jp?B?RVVia1ZQWWdUcW9YWkE5SmtUcmphSDZzSnNseGdnK3RPOVZoQ3hSY3Ex?=
 =?iso-2022-jp?B?dnVKY2ZhVVBPcld0WVh3dHNEaHdnL0tjWFp6eUltR002RDB5REhBSkNu?=
 =?iso-2022-jp?B?bDg1V3FRVkFHYjVYQ3NqVnFKZmVLbEVGdVhhandRY1dUQ29sckpyU2l6?=
 =?iso-2022-jp?B?NXRIR3ZVdGhROUl5VTdodGk1RlQzQTlRNUxlSlArNnk1a3R4MmljTkQx?=
 =?iso-2022-jp?B?STVUYllVT3lqRlZIdmduT01WajFRcW81bVVaM29FbnVLcjNOSmtkNmxy?=
 =?iso-2022-jp?B?ejdkRGlTTkYybmtTb0YxaDFzQi9UNHJXZEVtaGNoSzZ0d2luMEFvK0JH?=
 =?iso-2022-jp?B?T0M4OW1Gazl2QTZndWZLTnZxNmpkUTZTSXFZTlk4V1FaT0h1TkpaZ05i?=
 =?iso-2022-jp?B?N0hoMkdVdElJbml2aU5EcXM3RWYxTWNIU2UweGJLY0FyZHd4cGxmQlFV?=
 =?iso-2022-jp?B?dWJwVWo5c3BYNElKbW1EOUtoLy9tZnlwcFhqcjJLRTd3aG04djNNaXJo?=
 =?iso-2022-jp?B?Wmd0ZEJDZ216R2tCZE8wQkVTSkgzd0tMZnBqSXJiOWFuNW9DMERRaWNE?=
 =?iso-2022-jp?B?bmNraEVBeUlJQVBoWFRhR0tOSDc0M3hWQUlsZFJrbWZzelh6TWVQZmRM?=
 =?iso-2022-jp?B?a0YvLzgzdURZUzRabklYc3dhRnp6QlUxaEs2RkxBcFYvbng1N0xOYm1t?=
 =?iso-2022-jp?B?aVhWUkp2Uko2eThSM0g5Vm1wcjRCRktsZEZ5RjdwWEpLczhCRXJXSDV3?=
 =?iso-2022-jp?B?R2Q3bUZvYzAxL21aa0UvNUVqVDlUZ2J3K0Y4WkMvSTAxM2IxSjQyb0c4?=
 =?iso-2022-jp?B?ZEtVMjlwcmZySnAxYk9Gc3RjdUNJR1pkQXN5a2lZQ0tsaUp3R2Yxc3k0?=
 =?iso-2022-jp?B?NDIrRDlYdmt2R3dJeEUxNVgvaWQ2TWQ3cFZ4YitkVXpMQ3AxczZ5c0w2?=
 =?iso-2022-jp?B?Lzh6N0YvUFpqbXoybTVEMHB1MmcrWFA4NDNzT1FYdVB1bUIvNStja0Za?=
 =?iso-2022-jp?B?Q1h2TEN4TlkxVmpJRk5yRGVYVDhQSXRGRHVLOHN1VVJKU1pYQWJTZkpH?=
 =?iso-2022-jp?B?T2owNUdnRE4zUGloajM5czdDVUtadmp3aWNQckJ4d083Y1k0dVFMVG5s?=
 =?iso-2022-jp?B?N1RPMiszS3hLMmJCN3lONDNSazJLMGlIeGVqY1NCbTJrbEtPQmw2dVg3?=
 =?iso-2022-jp?B?OStoaW5WM3pkdnRIN0lxVFM5c2MrYjh4TUh1S1A3UWNRdDIwTHN3WHZx?=
 =?iso-2022-jp?B?eWozSysvOXVLa1k3cE4yY3duVVVGUkE4cFh3RWhodTZ2UDQxU3MwdHNC?=
 =?iso-2022-jp?B?R0ZPdmtCUGhyS1MvSCt1eFgxcFpFalVVZ3JnUksxZVQrbGtZNnNnOUFN?=
 =?iso-2022-jp?B?SFZkdFV2WTFzSzFleFZCOWNITFJSSzY4Z3pmdStOM2N1OFk0U1JhVTVq?=
 =?iso-2022-jp?B?cG5aeWlNWVFMWmgya3R4S1I1UGtTWCtOSVZJR01EK3F4WUNCNkczcGdL?=
 =?iso-2022-jp?B?dHRid1NraFR5SDM5a2Z2aSttWXJObDlodDJGaE9USXBRcGZCYWNISE9s?=
 =?iso-2022-jp?B?MlNJZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?d0x3YzRLK2pXU0ZIV01pWU5tOGNIUWxLNTZWbktjYzVHcVRaV2pZdXNy?=
 =?iso-2022-jp?B?YnhTMzVxRjh1MmN2U0ZXSkhyY3dvYmszYzNCWHJzaU1ta1JlVjArcWZN?=
 =?iso-2022-jp?B?UHFGSldXSysxaGVsTlVBRUp3NjVhY0tsMUZzV2dRSVkrcE0rdjBlcDVG?=
 =?iso-2022-jp?B?azZCMCtieXFXUHZsQzVROUVFbks2eEFpUzJwdlVHU3p1WGdSekcwM054?=
 =?iso-2022-jp?B?Vzk1am9adFNYbHg4RmJtMnh0eTNBWXFsTVJlSVlwL3BIenlkNkVseGFC?=
 =?iso-2022-jp?B?d2UzY2JXWnUyeGUvUkpNeXhtRXBuVDJXb3IxdHVjSW9Yd2NvZ1NXOW5z?=
 =?iso-2022-jp?B?cmRQcStSL3pLRyswdGIrK1JnR1l0Mm9lamc2Y2tLMWVieUQxZUY1RDNv?=
 =?iso-2022-jp?B?bkpUM0VXQjc2ajV6Y1RaclBTdmorOWgxVnBQWXRDZUYzR294dVZHRzY3?=
 =?iso-2022-jp?B?eWJEbXVVMFpUVWkwbncyRHJ5SzUrTjlOeVRWRlBuMGJNMVNoNVJ2UXJ5?=
 =?iso-2022-jp?B?NExlUERoTElBRm0yMUljNDNPeDk1ZGVyWXNMNHMvVEdOL1pKM0pnUldD?=
 =?iso-2022-jp?B?QU9mdi95bkx6L2pDa2ZabHh3N2lGRGN3Z0VhVGUwOXNwbThPa3hEMi9w?=
 =?iso-2022-jp?B?REIwbnN2Qk5OUmFWaGhlUzNwWS92NlFZbWFtZmZ0N1ZGMU85S0pJKzVx?=
 =?iso-2022-jp?B?dmdLbDJPUU5lYUhLNHpySC9iTzBtZ0dDaFNNRm1ra1ZPT0RPWS9rU1B6?=
 =?iso-2022-jp?B?a3RCMEg3cVJLemZNdWJRSjNpbCtQQWtHRGljR1owNGJjbWRUR1ZhU3ps?=
 =?iso-2022-jp?B?a2xndXJXZklsY0hKc3Rpb1pZVnNhNEZ3ZE1nQUx5KzRpV2pRemhoUXhY?=
 =?iso-2022-jp?B?Y1RmeFRFN0VXUGtBL25SZ3BhWVhxdEtRcWZNRlpzWXBWVno2SUxrOG85?=
 =?iso-2022-jp?B?ZHp4Z3hYQWlQMkJid1JhMGNHWlNKbU1aRm9ueGRLcDJyb2ZPR2pTNWpj?=
 =?iso-2022-jp?B?bUJCY2hJdXBCeEF4NnV2Y2pzMklJeEtXS2ZwWXd1Mk1oaTFwUDJHNUht?=
 =?iso-2022-jp?B?MW5FelVralNHMkNZU0o1cklvOG5Gd0JheFY5Njl0WXp5ZjVhOHE4anZ2?=
 =?iso-2022-jp?B?RUplMkpyVHZ6NExmWjN0SU1GVFpMN0NzSHNyeTlnUXQvL1F3SkMrTzI4?=
 =?iso-2022-jp?B?MlJlMlRmYVhOSDFsTkRTSi9RbSthdDFtWUU1dU1HNFBpeWtHSlY4aG91?=
 =?iso-2022-jp?B?d0c5aHlmQVI1RFpJOThaUlpRK0VCMGM5cGJBZDBtZUZzRU1lZi9Banc4?=
 =?iso-2022-jp?B?S2p3UENqaktiZUZiZnFCTnNPTU8zVzlLNFFaOWticlUwNzdVNjZINDk4?=
 =?iso-2022-jp?B?UTBUSk9zNDh0R0Q4aXRjM2VKU1g3UHlDNnFJR213M2g4Si8yaHc1SVYx?=
 =?iso-2022-jp?B?ZG5zY1VmblFZSXl4eENmSmhDUVI1N01JL3RaditpS2h0eWE3Wkp5QWJB?=
 =?iso-2022-jp?B?Y21qdXRXa2VJTlZObWs4QTg0ckwyUVJhbitwY2NzWmU3N1d4cEllWHIz?=
 =?iso-2022-jp?B?Z29pdCtnMVVlTVIyWnZ6MHZxTDhpMXQ3b1p2UEw4bnlEQnN1dWlhYWZN?=
 =?iso-2022-jp?B?N1BobG1CWGdWQnRDazc0SjRlNSt5S3dnejM1T21MNmtaVVZBQzQ4eG5i?=
 =?iso-2022-jp?B?VGp4S0s2djUrQjA5enZiUGFqWE5TL25aVmhlK0htNkhxbmIxUVFaQW5Y?=
 =?iso-2022-jp?B?bzkzNnBBajBpQXc1UWtqMUFESlBHd0pCeEpPUHBYVlRVdkh3TVdmNVB4?=
 =?iso-2022-jp?B?QTlWNUZQY2l1eExBT2k3OXJ6aWZBb3oxOG5QQm9Rb0FUYVRsMXJoWnJB?=
 =?iso-2022-jp?B?dHV1Vk5FVndNZGpZc2NwNzlRejMxN1BJS0xLV2MveDhLeTRQQmlmNXBW?=
 =?iso-2022-jp?B?Mm5Zb2Q4T2Y5ZE83WUdXc3hwTkllNFZ3WkdLNVhqeExuUXNJNlRrOVBO?=
 =?iso-2022-jp?B?RnFpZTdid3FZL010ejR6amJYcVM3Uysyb3NEem5DazBxNEI4VHUrVWNp?=
 =?iso-2022-jp?B?Vk04c2tLODN6djRHcjFBdDAxT0xQeUp4eVJremNGNXBpM1hyVVZra0Fs?=
 =?iso-2022-jp?B?ZzJ2eWJpekJNRVpUalczNEdNeEhsS0JnUGN6TW5tL1dJK0Fva3VXa3NW?=
 =?iso-2022-jp?B?V2FvMEM1L3c1MlhLVWxzZkd1eUh5K1p5OW80SVhHVFgxUzE3VHBONEZq?=
 =?iso-2022-jp?B?eE1rVEl2dGtudVRVdStuVExPeWdaRnJYalpWb2xsdzZ4M1RYbEkxT2Jm?=
 =?iso-2022-jp?B?OEtjV3lIZ0F6ck1hTWQrYXlCMWRJaEM4cHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6df7e4-2879-4c58-4e9f-08de21aeb1e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 05:45:32.5579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vwVzKZOr28+gcUSn8nUkp5qmI4AZVodWp2jkMSE748sOywpvsfXPahGPGyPi/8aIqp6OnIfrHk/bT8D/9W0TohFB6nkEybrB7UZ8nlBnmfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8115

> From: James Morse <james.morse@arm.com>
>=20
> The ACPI MPAM table uses the UID of a processor container specified in th=
e
> PPTT to indicate the subset of CPUs and cache topology that can access ea=
ch
> MPAM System Component (MSC).
>=20
> This information is not directly useful to the kernel. The equivalent cpu=
mask is
> needed instead.
>=20
> Add a helper to find the processor container by its id, then walk the pos=
sible
> CPUs to fill a cpumask with the CPUs that have this processor container a=
s a
> parent.
>=20
> CC: Dave Martin <dave.martin@arm.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

