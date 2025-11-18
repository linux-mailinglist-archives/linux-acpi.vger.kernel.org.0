Return-Path: <linux-acpi+bounces-18991-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B7AC67895
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 06:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7784366702
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 05:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027C2D94A0;
	Tue, 18 Nov 2025 05:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="blgIk2dn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010028.outbound.protection.outlook.com [52.101.228.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9F2D8776;
	Tue, 18 Nov 2025 05:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763443157; cv=fail; b=MEL7J8tSO10i6iWs7bPAXZi0AvLKI92P3nn4q2h3OlUqrnZ+sz/HVPDQ3ROUmlaBZyJ/z3gX7FMfxxIpHuZKVUtZ1jsQQbHK0izORqNUhsPF07uLWrFgy3K8Wtke/2b66YEmEhq4JOyXRQQ/541DtRPtrHoI3xwsD3JigdONlew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763443157; c=relaxed/simple;
	bh=IAJPFWNosq8ej1vffJ3BZRtYE44xZSW9JUo1o8EU8nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=claqTPJ4bJGtNjvTjuO0jB9nLHTP1eek2zho0FaowIXdty2+Ad83iDLOqb6Azh8uSFB88mR0BcUnLFGhf77RJGRmvjMmPf7j3Nx1tB2BJzzOFL5Jheso9tIvVBcJ76tS3cS+eOQA928WZ/IHtZB+O9eUsM44l+cz+jL0YBBpRPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=blgIk2dn; arc=fail smtp.client-ip=52.101.228.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRQ2ALXxqpmFVl2HDue4FjPJQaNA13oxQZazsfS0+Q+TVJIKiMIABZeW03aqmvHHDhYrIubu1n6eurWU3xsHGDrEhIjPDIOR7i5exPyzVrBmSoVJWMKlXUxe6P1FbE70vW9xl19jd8iZjWyd/2JwyyBxX4itP76/+6AJcZsYNzSw+K2k6aUeAOL3GwRFb7t+f5OfOwdS2xQt09v+WY4q4sLNL+ucLsQyYOi0vGia2YfDMgGUiGXX1wcDHszA6VCcwBNSR0rkM2f4x77HQl/UtvJUrw+akMgiPsysg93gGDPBImVPoJEeYify7sUhuDbyQEMe1D3LnXcG+my5cbHKrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAJPFWNosq8ej1vffJ3BZRtYE44xZSW9JUo1o8EU8nU=;
 b=xOMz7NW6L4GVXsb9YztwPQDwRjJl4q78PDSI626b5VjzmJCrqzNhan4vED19k1opdw0glhYp34O6N02zSjx1UNSA+xYMy4AGoD7B7UvxGFr9NgAEsfqc0HOCk4Y3daq/PWVCXcwyt+wEg39m+xkqN13e5pJ1WtKSoW5NB46j8yLRjLVnRJYAjDot3KJb+mS7hReWJc7vweBeVKP511ymD4kG7siStYeXvc4R3BtCgN23uaN141usSi/fiSgs3tA/pD5jY92Ow6Qukx+SAGhvY8ZDYgPAM8wC386luwrYW3+nPz7Gjuc4E1XTTxR9GwhUV1shQ2OQI0Iu4tfifYqUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAJPFWNosq8ej1vffJ3BZRtYE44xZSW9JUo1o8EU8nU=;
 b=blgIk2dnNCjd9w4ZYdlTX5cpa3AMZ2YHObybEPwBhn0WF1nLBPbMrZRPKDtDobpS2CjmYqvq+dftZiwVYS4X+j152PcHPN2RogaH6gzkC+CZ7HF/mW4FTvEXnMqRhOn5bpltWcxdqSg6j/xb2lZRq9JTOm3Q5kLzeICgo2zsBPhgdk3BWs4W2tzDrXet+lRmnJvR1MGO9vmeQ6eOt0jE9Jh5GRR4mM23Cx+w1OfQvE+9USMM3vBB7GnHPv/Qv5SqRJFEaXEUFn51+e3Sf4iukBXvj+RsxFU9UqLj4MOIiPN4qH7kxX7pXfWclKWSJMd4LwmGRspKlEkTYl+BE/KUYw==
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TY3PR01MB10237.jpnprd01.prod.outlook.com (2603:1096:400:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 05:19:11 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::e366:d390:4474:8cfa%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 05:19:11 +0000
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
	<xhao@linux.alibaba.com>, Zeng Heng <zengheng4@huawei.com>
Subject: RE: [PATCH v5 10/34] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Thread-Topic: [PATCH v5 10/34] arm_mpam: Add probe/remove for mpam msc driver
 and kbuild boiler plate
Thread-Index: AQHcV+PQOopNmRyBN0WZUcWHdDwuiLT35cQQ
Date: Tue, 18 Nov 2025 05:19:11 +0000
Message-ID:
 <OSZPR01MB879880425A5188E682D9DAF28BD6A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-11-ben.horgan@arm.com>
In-Reply-To: <20251117170014.4113754-11-ben.horgan@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=60e794ac-e4a6-41c9-8584-112d0f5e1a86;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-11-18T05:18:29Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TY3PR01MB10237:EE_
x-ms-office365-filtering-correlation-id: 30015af7-36ed-4d76-371c-08de266201e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|1580799027;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?QW84TjBtNEZHb01wbHNIcCtKMkwzdzdTV0pjTEVTMCt0NmlXOFJnK1NG?=
 =?iso-2022-jp?B?TW9LRFA1c25PZ3ovU3J5RHlYcHUrN3I5cTBLVHRqVzl0aGlwSEd2QWNa?=
 =?iso-2022-jp?B?L0ROb0JzbmhxZGl1WlFybkhPNmZYV3N2bXBHOFlLcVNzU2tsSStPUUlQ?=
 =?iso-2022-jp?B?c0ptNlVEVFJ0VlArMTFiTWl5QXNhbnYvOTk4cG5CQ2JUcEtGSGF3T2dv?=
 =?iso-2022-jp?B?d0VjSlZ3eFhoUDljVVBwdUxxSzlaUGowSWROcXVQcTIzS0NiZXZVclha?=
 =?iso-2022-jp?B?eWdlSXhUQlVpQzZySkVvM0gwVHRNRTg0ODhLQWRqQ1I4MUljbXphVkFh?=
 =?iso-2022-jp?B?VWo0VXc5M3NuSWFGaTVJMWpORFBBbG1JZWJRcGJpU0R4d1hoS05KUVh6?=
 =?iso-2022-jp?B?V3Y0K0pNcjhrZ05GTEI1U1E3MEMxcGc4TmFqNkk1Ym1OeHcxWWl5OEpo?=
 =?iso-2022-jp?B?aVFkSjlMdS9JU0ZJdm0zNmVFRUhVcWcvMnFOT1BvMGR6VkJtcXF1RVdE?=
 =?iso-2022-jp?B?OTNxR2pQQjhlcHJiMUl0ckQrY1FYRFFDV1Nvd2x6M0tsSjJwWTdJSTlG?=
 =?iso-2022-jp?B?bTYzdm1XcWJkSERnL1J2VWhHV25RdXlmbWtPTzA4S1V2ZHBYR0IwU0NU?=
 =?iso-2022-jp?B?ekpLUjUreVV1MytKZ3M4NnhsVkxOOFBYbUtzbHl6R2JUa0pCT1kvR2Z0?=
 =?iso-2022-jp?B?ZURCaVU4VnlTUkhCYStNQTFUa1EwTnJJK2hqejJuVi9BaVViTXp6SVVO?=
 =?iso-2022-jp?B?UE8yMmNjTmhBK3NqektBR2k3SnJiMVlFVXBnOGFRVExZTlord1RjVkpn?=
 =?iso-2022-jp?B?Z0tLMEh2VnNCd2F5ajFmT2RGSzQyOGZaUTJLOW9TOCt0Sk1kTmQ4QlRG?=
 =?iso-2022-jp?B?S0x3NVhMN2Q5TldNYnZaUk1sM1lPNHl4THhiSHBhc1BtUTVPT1dBOFVw?=
 =?iso-2022-jp?B?ZGV2UHEyRzZQUjVTdG9PZXBjL1pzOFJpSjd6aHZsUXR6MkVjZVhMMkxG?=
 =?iso-2022-jp?B?anJWMmdpWHR2T3EvUXNLQTFBbWhsaiszK09kb2szajQ3c1R6aldLUHFt?=
 =?iso-2022-jp?B?TjlsdXVLSmlWcWlOSm9uTmlUTXpmT1NjditkRjJzbG5CRmRFb2tINVpU?=
 =?iso-2022-jp?B?K3BlT29zQTczamlTNmJNalpNc3VkbDdXVUloVDJJb1laMXdJVXNodlNT?=
 =?iso-2022-jp?B?MDhJbDRhYy9mbEpvWkxaL0hIVDhmR2pJQWxOd2tFdXJpR0dyelpJeVJ2?=
 =?iso-2022-jp?B?dS85cjFJUEdMUWZkYVZMa1pDandJTzRiOThXSFFCdjlKaENhdkpKMGpm?=
 =?iso-2022-jp?B?aFlaaVhMTXhNSE50YWtNdGdxVFo5Wk5yMWFpSHlUc0tRVkhiVWo1Q1RL?=
 =?iso-2022-jp?B?WDNSY2hndWx2YkRnL05aNk5hMFR2TUFYNkQvVUd3SnFjUFhIQ2NQY0sw?=
 =?iso-2022-jp?B?ZCtnaC9NbUcxM3lhaE03b0UzZ2E0RXJZNzR2SUl4ZHJJVlpYVTZzeFYv?=
 =?iso-2022-jp?B?Rk1sVjlkOEFucVI1bmhYYUhTS1ZRVmhVZVpnR01zUnMycDBkaUlLdkN0?=
 =?iso-2022-jp?B?LzZUREVjMUQ1cUFrdnZqaXIvK24zRFpkKzlyY0NsRGVCOEpZSW1NellF?=
 =?iso-2022-jp?B?dnVUNjBNL0VkVTEvYWV0QWhFTENVdG9UVEoxYkVwVVJZVGZpcU53ajR1?=
 =?iso-2022-jp?B?UTNBVnFPOEg1THJxQ2RwYUxuN0RnRlNLeTJ3M3M4SXppelVTa0NZYlQ2?=
 =?iso-2022-jp?B?a1g2TWM5V1g4anlvYStGMXNlUlhKdVVETUx5MFdPVm15LzNKOTZwbE1o?=
 =?iso-2022-jp?B?QXBjQWRoRG1weUNwYmt2RWVDZTFRVGkrUGQ4U0pPVXF0NVhHMWgxUXdk?=
 =?iso-2022-jp?B?SlRIZWE5WmUvbFRvS0xQSkgyZzJXbjdMS3NlWXgxV282OWVMKzVLWXE3?=
 =?iso-2022-jp?B?QXNoamdYNUZXYU9yTy9oSzBzVFV3c1E5dEZnWWxHbGpaOW5lVlRaVGdM?=
 =?iso-2022-jp?B?QzJkWDdTVjhuY1o2WWVKcFp3bnd5eThzUFZTQkVHSDBnVGRwaGxxejcw?=
 =?iso-2022-jp?B?YW13dStOekJqZGErbVlZT25Za1NLK3pvajdiS3psTkg4V1BoY3FxenFY?=
 =?iso-2022-jp?B?UmYxOG9xZGJlUnR6T2hHeHFuMkc5enRJanpjTm45M3pEN1ZFdUw5V3Zm?=
 =?iso-2022-jp?B?dllSK0J0dFZTQ1JzYm9XU2F3dGR3S2F4di9vSDU2c2NuRHZlRTl5MGJu?=
 =?iso-2022-jp?B?RjRBQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(1580799027);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?UjJuMTNxWHU3bDlRWDdpV0xQWGlYdjQvcGl6Z291anhVM3dteHdZRVRi?=
 =?iso-2022-jp?B?c25wclU2RXVuV3BRZkI1a0NxOGl4Y3dVS3RzaElxcVI5Tk41L216OGt1?=
 =?iso-2022-jp?B?V3hZbFlmUTlDc2krRXFWMEN0bUgzckJxOC81NGdwYlpwWlZ3Q3A4bFFv?=
 =?iso-2022-jp?B?WmN4cWo4cjZTME9DUncycXZKL05LdnU4WlphaTJiZlBwZW9lbVJqRFJl?=
 =?iso-2022-jp?B?NkJtVEg3OElURlFzR0gxNWhnbnNYNmZhS3UwRkJCRk9oU3p0cUhhM015?=
 =?iso-2022-jp?B?U3FnWWsvSUEwZ2hpMm5QeVk5RXlTSXF1S2h5ZnJYMk5uWlFweVdDejNZ?=
 =?iso-2022-jp?B?UTdDK3RobHB3SWVmWm1iaGhzMzVVQjJRUFMwTk5LYmNxSTFZamNRaXFh?=
 =?iso-2022-jp?B?NkNHUzRMcytwbk1SVStRQlhKK001T3lkY0dJY0ZFN3RNVXl3RUxrK08w?=
 =?iso-2022-jp?B?NE9VNmk3TEJJNUZKcUIzcUY1eGFHdklWSnI3T1RZL01DVFV1UXdEbCtP?=
 =?iso-2022-jp?B?V05wSU5kTk5FR2xwWmIvbXRLZzR4K1djREVkMllPbWgrS2twWEVFWnkx?=
 =?iso-2022-jp?B?eEN1VVVEMThuaVptWVJWK0pLd1NSZERESjcwaVgwSTNrWmhyNUZsVmM1?=
 =?iso-2022-jp?B?c1FhRVVyazR0YzdUNjNyY2cwMS8xSHFqWXkydHYzVmdvUWhmOFhhRFpE?=
 =?iso-2022-jp?B?RE5mWDZQYlJEbTk4bFhza0RUMkZETHlRSHFUNnlzSU5obDFtQUt2Nlhn?=
 =?iso-2022-jp?B?WUdtWFFNY1RudWlicGdPMDhoejJONElDeUEwWXlxeEV2OEdUMnRXUXVZ?=
 =?iso-2022-jp?B?aWI2dmN3aTYyN0lCbUlpMmpZNHJsdnFORXNDSmdwUkp3YWZITytzSHNp?=
 =?iso-2022-jp?B?aFBwZjcwSVo4TVhrYkZxdTZRYjlKV1R6Z1FwVVJSRmFKR3JQWktJbUN0?=
 =?iso-2022-jp?B?QkUwRWdJc1RVdEgvbGVrRURFRGNEdXJMajI4K1JYRWRmTlVLejNJYnd5?=
 =?iso-2022-jp?B?MmFwTktlVk9xbnRaRkdZb3ZpVnB3Z2FNaUxZZ1c4czAyMkk3MnNIZUlq?=
 =?iso-2022-jp?B?NXdOTHdxdm1SR05tRGNKQjYyM004YXBGMHZFZGNOVTlWL2VtSzNSYUNs?=
 =?iso-2022-jp?B?ZTVibnVQZGtZaW5KZ2NLSDFzRmd6NjVlNnpCa1NyQzRMV2hZOHRKUnZl?=
 =?iso-2022-jp?B?UUgwUXhVMk44NzBnYjF6cExiMDN6VE9LQkNpQVo1aDVvSEJMNmU1R1c3?=
 =?iso-2022-jp?B?MUdxcmNQdWxyNmxZTzJwOHlONzFNbVQ3U1V1L3ZoMmxJU1ZIdXpwWlFS?=
 =?iso-2022-jp?B?c2pISlpvdk5mQVJDNEsybjRRNUl0Szc2Z2hqU2ZNdFBvOEh4NUw5bXhE?=
 =?iso-2022-jp?B?TU4rZmZtQktSME4vclFxbjU5THl4bWthVDZyMEpRWmZkWm1OaXMrSXRh?=
 =?iso-2022-jp?B?NTJ5WHVyVHd0RFplak1MNG5BYlFZSVN2YWs5Unhpdlc1MS9QUlp6ZEZi?=
 =?iso-2022-jp?B?Y2xkWWQvazYxZDljVkdZREVMcHBheWx2Vk9naW9DM21RZW5sMTBuU0Iv?=
 =?iso-2022-jp?B?NWhMRndlUVFOTERDaVNzbmQ4VzM4UWQzQ3RRWHhFWG91NnQ1a0hLMkNw?=
 =?iso-2022-jp?B?RGV3MHdFVmtOWkJ2TGRCNVZtUFJJMVpHTEZINGhWWUF4YlVXZU8za3ZF?=
 =?iso-2022-jp?B?MW5uM0JaTVRINWM5RjlUNklWdzZ2SFJEdEpheVhxYU9mQkl5SXJVYWh4?=
 =?iso-2022-jp?B?MUExU3ZwbkdHMnhHZmZTdUk0eGh3Q1cwNmorc0JKYjhzSEZROEhNZ2FJ?=
 =?iso-2022-jp?B?Uzdrd25Wam16eDZ2OThWKzBiM2ZDNXhhMC9GT2tqZGh1UHlqVFltSkRC?=
 =?iso-2022-jp?B?YUt5R3JnNWQzZm5PNU9RbWREbWxWd0JxNkgxb2IxR1VoUmJyMk5nekFn?=
 =?iso-2022-jp?B?dVQ0OTA3Q3RUWWVWcmdycWNnWElLQnV3TGp6MXdoQTBhTStEcm5rNzds?=
 =?iso-2022-jp?B?bUFSSnBIN2kzRmMxeXVyRFkzTmd0U2FuaUxjUnRsbjlaTHV5VCtjSG9s?=
 =?iso-2022-jp?B?b0hoUngyaFp5Z0tWcWNVN3dmaUJ5Nkg3c2lQR1N2NDFReFMzUXJhL3JR?=
 =?iso-2022-jp?B?RzQ5Q1l0bUJ4VjVBSU9nN0hBdEprbUdtdkFzOUFEeWxVR1RxZkxRUVpq?=
 =?iso-2022-jp?B?RTJSUzZQcngrRDFod2pRMlIyclZXRGJQdkprbE8wZVFmNU5Hd21DWTRi?=
 =?iso-2022-jp?B?NGhsTFBwTlJJZVc2b2lzNmJWQXRvK3J2SitMRTQ1MWNvbjdNNUxldGZm?=
 =?iso-2022-jp?B?RmJubndxQ282TTNnOVlFdWoxUTJRODVOTHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30015af7-36ed-4d76-371c-08de266201e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 05:19:11.3163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F9k9LBfz7hPsWU5aMSFObOhB9pdG5+nky+Rpch4gYFLhlEQBzp7HtqQ0PW3go+MxyG+NQiF56Y2p1V1BZDI2YQ0RnfMDIgZyRF9YRNKyzQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10237

> From: James Morse <james.morse@arm.com>
>=20
> Probing MPAM is convoluted. MSCs that are integrated with a CPU may only =
be
> accessible from those CPUs, and they may not be online.
> Touching the hardware early is pointless as MPAM can't be used until the
> system-wide common values for num_partid and num_pmg have been
> discovered.
>=20
> Start with driver probe/remove and mapping the MSC.
>=20
> Cc: Carl Worth <carl@os.amperecomputing.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---

Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

