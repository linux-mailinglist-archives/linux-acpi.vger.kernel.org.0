Return-Path: <linux-acpi+bounces-18796-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B6DC51079
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 08:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244C41897F72
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Nov 2025 07:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB44F2F12BE;
	Wed, 12 Nov 2025 07:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="TVT/QmRg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011030.outbound.protection.outlook.com [40.107.74.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B39F2F0C67;
	Wed, 12 Nov 2025 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934269; cv=fail; b=HVPHcS8hUGOzglLj+qyETJIpink0OAKna9W5TlSjEgD4PkydFbnpNEACjcgjqBXcjxhpONilDZX42kWmuot42FpF94DZMFX+zohzWTKXmIjQcdT/SNQYqiftWmzt39IHHYIjDo1u6T0OcR+WUt/jU3Q4dsWZzNgO893gWyrgOmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934269; c=relaxed/simple;
	bh=/57rm8URYvrw3dlTj6Z5CtoR6ssDJfN8N3mZMlCPFOY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zsyx2MeVD/945NdRBD/qt+ScehYZAifjcx8a523XEEdzM0Uv324zkxmWmpyKQJ04jFVM68lfmqmflx7iEYtEEb48vtyGRylFw44DMyGGJFyoeWixlbnIBh6Mr0J9nwwjml/wm2c/5lJwUIrU9TS2UGc4H9Nh97YF9K4japVwurM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=TVT/QmRg; arc=fail smtp.client-ip=40.107.74.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+avxG7XEW0/BGkJZerufhoEZlK4gczVMEbqZdF3DhQvGHuqyGLWCGDaSGoB4jCbX9EtZP7ar/OxKGtYdc2KQej8+QN53BQXb13uHoJZLosY+LZVK7DpZ/jekPpfbQlnatHK6PHf/8LQ3ICkH7oY+apLir6i+Z99X9Flx+ZNlvymYPjcupCo81ynOMoqDlWzZKiTsluEMEzHgggCObSeYZynkR9ZK/DYnCUS6ODe2t9EiZ5Ao8Yu7w+ZjLxpuKJddUR6/VIyDH76/M6XB8gvc6iAENuZHN0BYIDsOgebQXYJnMdGNbI4N1D8i3DqgQkjGrzzTfvauFE2nC6m7cjD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/57rm8URYvrw3dlTj6Z5CtoR6ssDJfN8N3mZMlCPFOY=;
 b=uDN4BGONaZK/sjKjlWaKbL9BG153ELPukkAhdpSd9HH7W4mhGsDdNOoJ4wPwMJmHXb3+Aoy5cCGGpLSUxXXsGEXkf1RnVpIjQWYbCTifda1mrVuWw3aVt0XdnpmYPcK7qopSOcEqU8pIhsOxbaACTXimdKdQvLPf8ulMy1baswF0k1p6UBS/kwIld4m7XeoNuYbRY4eTWhWTlsGGAS8S9QpApgytejgzgSro0iQIUMDwU0L0TZUCiNb/VkuR9dNJAsmjOnMA9Y4h0uNVnHpUQfOWE1IPfq4/lW8Q7OrWDjmYKQsbzmuN1cQyvXBw0NevBwZmtTZQF2AuSjKT9w72wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/57rm8URYvrw3dlTj6Z5CtoR6ssDJfN8N3mZMlCPFOY=;
 b=TVT/QmRgHc+5xyDIdW2+tj9SBH3j1ifquGgyU6qyuyottUfdCpPIqYF3/TkaowkGeNcKL8DvfNpxNxAQ9eHEFdbtlzT5b2XFYGv8ATXa5BGohqLi2pmMijNWA02tMh0wNKeEx+YdYi/nYcfx8RnY4NxY/D06dcW8n7VJQErBoPH1gEk85HAYWvbbaqFfMUFROF9BDv+tVhf7B29xi0gRhBFsUu+fWEkT4SjdKTio/B1qK2qkS4ZJnmIImzErJGB+cprCPW+e0kpuOQOhyhEHIyenOoYoG+neANsqUTDoKGTmqDgxcahQHS8XaDCYgD/eqe/Puw4pJo8tNvlTb82jiw==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TYCPR01MB8039.jpnprd01.prod.outlook.com (2603:1096:400:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.11; Wed, 12 Nov
 2025 07:57:45 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:57:45 +0000
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
Subject: RE: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
Thread-Topic: [PATCH 14/33] arm_mpam: Probe hardware to find the supported
 partid/pmg values
Thread-Index: AQHcT+MwKXDUpub2kEiVlLlkM+ONc7TutBUA
Date: Wed, 12 Nov 2025 07:57:45 +0000
Message-ID:
 <OSZPR01MB8798C71BC9F3E4370B8A58508BCCA@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-15-ben.horgan@arm.com>
In-Reply-To: <20251107123450.664001-15-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=053a56a2-4458-4015-ae55-2af88ad68b50;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-12T07:57:02Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TYCPR01MB8039:EE_
x-ms-office365-filtering-correlation-id: 3826ed50-2ff9-4983-7bdd-08de21c12a1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|1580799027|38070700021;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?NzlLUHB3VXUwd01Nd1lNT2h5T21NWHFvRC9ObnZYbW5LWHdIRjdqeXVW?=
 =?iso-2022-jp?B?NlY3dXZ3UnZneXpCeEozMjJ0N1lRSFRzSjA3cXhaQXZ6eGl3TkpEczR3?=
 =?iso-2022-jp?B?M2lBMkYyN3JwZzJET1Z0UUlSbjdzZmQvR09SL3p4dXpvNXR4TDBHNmZl?=
 =?iso-2022-jp?B?ei9iQkMyMTh4Rk9XRGR0OWY1Nkh6SEVieXVxTG1TYS9tbmx5aXRrc3Fi?=
 =?iso-2022-jp?B?NzFmQy9PREd5RnBrRkgxaUp3MWU5emFocTRwYVJPSEE3SEhSRURTU3I1?=
 =?iso-2022-jp?B?cjJ2d1BqaUdsbjJsUG9WSjhkd1N6akthSndVcVhGbk95eEdJaFRYTmkz?=
 =?iso-2022-jp?B?YWUzem9lakwyVndmVEJ2cDAyMFdiQ1I5WHBubURLVTBWVDA1K2tsRm9y?=
 =?iso-2022-jp?B?ZVkwMldFSTJYRmVDTmMxRHZhQyt1bVViSzAzNE5vZXp6R2c4dStwU2hQ?=
 =?iso-2022-jp?B?Z1NRa0V6RUtTc0RqbnhmUFVldlZxRk9IaWpwbjFFZ2U0VGJ1QkRWZFgz?=
 =?iso-2022-jp?B?Y3VBSGRDNHJyVjRBN0M3MU1SVG1rZ2pnTkgrQ1hoWnZiVitDWGZYV1Ny?=
 =?iso-2022-jp?B?QTFjUDBwVm9CNGt2YVFma1BySENwSUFzL3F6dXBHMUlKOFJYVno5L29o?=
 =?iso-2022-jp?B?Rzd1dnppSXh3VmVpVXBTUXlTbVlNVnRySktlNVlLVjZRSDRPSjRCU2s4?=
 =?iso-2022-jp?B?UEJ4aXErTVZrZTlwUWxoc0s5bE1MQzBQcCs3SzNocnBNS0hSNmdzaVF0?=
 =?iso-2022-jp?B?cm9TS2M5OC9nU0ZvWFhkSklxUlZVYStOdnlWY3k2ZUNqUCs3bHZoYW1F?=
 =?iso-2022-jp?B?Q1hIbDd4NDV6bEdXL2pzMU5oTkJlYXdTQzZNaklFMDFUbzE0Y3l0aEdv?=
 =?iso-2022-jp?B?dXFsaU5BcW14bDhXMW5VRklobDhwQzd1Slg4dk4yRnpZTmQ1Z28xWWJJ?=
 =?iso-2022-jp?B?QjlQS2hPWG55bmhYVGJiYzQ4YnEvaTdZVDF4bUtJZGxlUktoTDRNK2NE?=
 =?iso-2022-jp?B?c3B1SEpEeHZKQjJYdGFQeThERVpzdFcwMjIvQzE4aWVMdTdHb2hEd2h6?=
 =?iso-2022-jp?B?QzhrYjhIU29jNGp1L1R2Qi9DN3NFNE80RWg5UGxEaU9BRmIxbHNONlVk?=
 =?iso-2022-jp?B?ZG1jRU5SS0hzekJ6VkxibWRmQTF0NG9nck9qWHd3THdZZFU4RTk5WE9Z?=
 =?iso-2022-jp?B?YnZXVVBweEFJVC9xUUFSayttMVRGWGU0M2NINEpJZmNta3dva1ZLR0Jm?=
 =?iso-2022-jp?B?WGJXZUI1RG5SVk9XbDVEZ2tkQ1djUFFkN002OXpCbVJ2RkdhWnpEcXNC?=
 =?iso-2022-jp?B?RjM2MytPMDBkZjBnWXR3dnVnc29KS2x1a0JBeEpWcVUyRnJ1cU5xR2RK?=
 =?iso-2022-jp?B?YWRmZkRoYVdmWUJ3QXVKY2pZVmNaYWpHSjF3S05wTzY1anZYL2MxSjFo?=
 =?iso-2022-jp?B?b1h5NEVuVkE3Y0piN1RBQ1lDYUNsVjRhcDRhVDY1b2VvbHZwSm02ZC9B?=
 =?iso-2022-jp?B?dG9xR3J6Y29EZFdwMFpMbC9QRDZVWU9OYVlqNmVjU201L0kwZ0hRU050?=
 =?iso-2022-jp?B?blROM1pZWWhNcGVqeDdvbEpIaTNINWVlaVQvU1UvNlhMNXltMkt5RUVv?=
 =?iso-2022-jp?B?NVJCemI5R1dFRHNDcmZoMDZMWGtUZTNMbFJqZndFTmp4bEMyYXd1NWVN?=
 =?iso-2022-jp?B?M2o5TzRmRVJHZUU0aUw2a3VXU20rbXRRY2RSVHI4SjNnQzROOXZVRE9F?=
 =?iso-2022-jp?B?aFV5TzQyRzhBdVJRTENMUmdKTFIrNk1SRWk2T3dERDJtTTdWcDU1aFJ2?=
 =?iso-2022-jp?B?VUZPQkxNSXpCelh4M25JVUkvUUFrMzdXMmRiOTEvOTVYbkZXVkYvOUJ0?=
 =?iso-2022-jp?B?WkJzTE9qd3dreC9aNVFORE5CZmdSaGRvdG82NFROSEtrM3NERWNHdDly?=
 =?iso-2022-jp?B?VjNtdlhlSXk2Si9wblhKOEpNOHdOKy93RW9XV2g4K0VVOWVnN2MvVzRi?=
 =?iso-2022-jp?B?L2VGaXZFb3A2UU1zVnA4VDdoSDBLZElldFpCTWFMeC9KL2FIUFByaTcx?=
 =?iso-2022-jp?B?cVNQcitqd0RCclk2Znd6OXIrMlZmTXBRMFh6NS9xYXBCT0c5YTBCbEU1?=
 =?iso-2022-jp?B?YTYxQ1BnTU1TQmJ0RDMvZkx4ckdIVHJHcDVCam40SGZBVElXY1VJYkcr?=
 =?iso-2022-jp?B?elViZ1dibHdReUk3bi9hcHJBNUxBekpVNUZhdjM1aGZWU0ZRcUpmWWsx?=
 =?iso-2022-jp?B?ejNYQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(1580799027)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?MEowZkYwZVpkSVhKTlF3WmpVeW43MnZjekY3OWVqUzk0RldqTllsVmpY?=
 =?iso-2022-jp?B?VkhHNCtuUjFjcDNMMHVCTmxTQzJiaEo0LzZKY1ZUcUxJRUxoZjd1YTZ5?=
 =?iso-2022-jp?B?N2tSV3BkRGJST2dEc1doVFRVdTVQZ2JocFlpNmwwdGk1UjVtYkxzRW5L?=
 =?iso-2022-jp?B?QnJicnBsS1JaczdkR0NzandWVWJ1cUxqa21ad2NXVWRjNlFsSzNnT0tU?=
 =?iso-2022-jp?B?TUZyR212UUwxMEVBcjdPYndwMjNVbHdrYnZ6V0lBYmVQOERPRDJzaThT?=
 =?iso-2022-jp?B?aUZhNlpwb3psMjEvL0NKQjBNdDNORStoaFhHaXM2U0owREZ3aEVGSnJM?=
 =?iso-2022-jp?B?b1BrcktuNDJCSmlveWpVQ3AzbzlXY2tRbnFpRm1ORi9HVWhFUzJyampP?=
 =?iso-2022-jp?B?cXNFWnBodXgzYVZBaGVlM2Z2YkhrbmJ5Z1JZbUxldDhLV3l4K29LU24v?=
 =?iso-2022-jp?B?L1VwN0lUMytnL3g4ZithbkdLRW5ONUM2YW1wcVBiSG9LbEpFakI5UVUz?=
 =?iso-2022-jp?B?M1NTRkdBeGFoV2g5emZVUGNiSmtJYVZLNUNIYnkyelIyQzZ4NTFablZk?=
 =?iso-2022-jp?B?MXJRL0hER1RPeDY3UThpODV5ZHpaQld4Y3lYYjY5VnE4UytFTjJDWUQ1?=
 =?iso-2022-jp?B?OU92OGdZZEJPaVpJdXBaUkxSWjRzTFl1RFlQSnd4bHcrMkZDVFo3M3g1?=
 =?iso-2022-jp?B?RWtLWFlBUlZVeFgrLytDZ2grc2ZqZjBaelV1aTdTTXBIQXBBL1RuNitO?=
 =?iso-2022-jp?B?cGhtTjdmdlNScTZtai9QczBLMGtidTRTdS9iQU5aNi9oOWhqNy84ZUIw?=
 =?iso-2022-jp?B?U1hXQnBTVzNGMUNhVXB1emNLYXNNTmViV1NhWXZQZ1AvUmtZODJiYUY3?=
 =?iso-2022-jp?B?WnkvMzB2MlUxN0RTZnpxU2trMWVkNXFTWXFYcU0xbm5Vajk0KzI0d21q?=
 =?iso-2022-jp?B?Zk5YZTcwMFN2MTAzYTNKQkZTRk90azJLNzhvV1lXZm1oVGpGRktvSjhz?=
 =?iso-2022-jp?B?MzY3eWEvK0d2RytISTJNVjJjYmQ5S2RyaDMyYTduc1Awb1A2dEJKWjB1?=
 =?iso-2022-jp?B?cUFIbFhDK2xITGtySFFIL0xrbm9rSlhHbXl2aldWcnh0OFlIVmZ0RnY5?=
 =?iso-2022-jp?B?M21LUldLd3M5Nk1YREd0eEsrN2NLUTRBY3dUdWtYclZNenkzdXAvZUhp?=
 =?iso-2022-jp?B?amNlbHVFS3NtY2lXYzBsRXlvTC9yMG1CNFZ6UWhnajViZ24xZXlyUGt3?=
 =?iso-2022-jp?B?VWxrZ25ZbzUwK1BVMWRXeTdtSWRFdUh2TDhMSGQ3cWp0ZU1VRXU0bnEx?=
 =?iso-2022-jp?B?T0oxeENVdGJYUElLaGZCMDhFakNWcURhV0t6djluZmVsL3JhM1pLcEZW?=
 =?iso-2022-jp?B?UEJML2VDMW43RkFIcmRRRVhYaldTeEc4Y21uUURleEtXL01Rdkl3T0RD?=
 =?iso-2022-jp?B?WDU2UWtmVVQ5bUNISXppbFRnMWtRcFdLTFM3c1dCc2Z0MWloYVdDd0h5?=
 =?iso-2022-jp?B?QUR0UXhaSzNTQWN3OW5rdXA4UmphMmtma2taVUVvcm1LUCt6eEtvT0Fj?=
 =?iso-2022-jp?B?bDkzVEV6QmJ6ckhaZUNFYitocDB1Nkp5M3RIZGtnMDJMZzhtOFhXN1FN?=
 =?iso-2022-jp?B?bHBNcUNSTGlFb2c3YzF3MDhDcFNuM1FRbXZBSkJNWHlKQndOTHlkanlq?=
 =?iso-2022-jp?B?UE9PYXo4VFJkWjlOUEw3VnVmYlpDN0pCMGZscW54MS9BUk1VUk5RZ2Ft?=
 =?iso-2022-jp?B?Z2M0c1hBUWZDS3BwSC9vU2pLME11M2RCd0dYeFA3d1dvUlkwTzdUMHRn?=
 =?iso-2022-jp?B?QzFpYVF5R3V3OXVUbk43N0hkbW02RTVXMlh4Qk9ZNWZQdm16a2ZwSExi?=
 =?iso-2022-jp?B?dTgvYUxmSkJFQjM0SVlUVE1MQjFvaXNnN21aMzhEbW1yUUI1WGU0Nmxj?=
 =?iso-2022-jp?B?ZUFuTGNlYVhtQXB6ZENKaDkzSWkvNkh5aXc1UEc2ZitQRnV5cHdOQmxw?=
 =?iso-2022-jp?B?UEdqMkRuT0NSUjloNG12VFZDcTR1SjdEb29UbUM3SEdhNWx6eXczc2F6?=
 =?iso-2022-jp?B?VkJtVXgzNllMYkdqUmRjeGMzVUpiWnBuakVnbEtGczdBM0U0QU5sNzRo?=
 =?iso-2022-jp?B?TFpqZmVPRDRkNU9UZzJLenpBOTBOVW10cTBYRERKVEhpeng2bE9NajN3?=
 =?iso-2022-jp?B?YWIzUUxuYk9jQUZGdDhRWnlUMFR6QnE0SzVSVWtaK3lnam5ibzc1bWpD?=
 =?iso-2022-jp?B?WXpkY25KWWcvK1RZRkRJYlpQTTkxcVlNUkJITXdXdFVSTTMyZkp6TDVj?=
 =?iso-2022-jp?B?SmF3OENnMlBpU24xWmN4RW9LYU1PU2o3OUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3826ed50-2ff9-4983-7bdd-08de21c12a1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:57:45.1701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FRfuJE9pJH1TQMSsVovv09eoHC+Y/UkQoYNhmUabML/l/0C7H1HQaWOgdg/B+WdixWOApvn/GEZ8fYgNeNnwu8X4bUq0WnKaiLCygqMPShA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8039

> From: James Morse <james.morse@arm.com>
>=20
> CPUs can generate traffic with a range of PARTID and PMG values, but each
> MSC may also have its own maximum size for these fields.
> Before MPAM can be used, the driver needs to probe each RIS on each MSC, =
to
> find the system-wide smallest value that can be used.
> The limits from requestors (e.g. CPUs) also need taking into account.
>=20
> While doing this, RIS entries that firmware didn't describe are created u=
nder
> MPAM_CLASS_UNKNOWN.
>=20
> This adds the low level MSC write accessors.
>=20
> While we're here, implement the mpam_register_requestor() call for the ar=
ch
> code to register the CPU limits. Future callers of this will tell us abou=
t the
> SMMU and ITS.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---


Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

