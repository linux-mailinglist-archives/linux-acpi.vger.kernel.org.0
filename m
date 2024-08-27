Return-Path: <linux-acpi+bounces-7856-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CDC9601C1
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD51C22D4D
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 06:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E4E149C7A;
	Tue, 27 Aug 2024 06:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HMUpKqiO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8961482E6;
	Tue, 27 Aug 2024 06:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740164; cv=fail; b=KnHb3U02LRWE24CbacnjsstW01syRhDXbyPkdjlqcr1l6xQM4Mr8L8dmiH7O5doCfYP250QelMfn6ZHQHNBAR5tg0hO4zVTt+zTCOf3M0eABC2Lxq21SQQkyf0A8kPQs+XGzN+LGu08D/YkFqWxHqvcGV7P1d6bjhLFmadbk0BI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740164; c=relaxed/simple;
	bh=WItSRT20Mi2GAVYZ7dcFFvHeFdvCZLuirAUy4SP9i2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YwuI/gQKoqC8FTzX6370UV0CQ5eUqQ2BiQthDN1ulXvU/4VI4tAZolu+eLe3PSLsDl31W/BEgnMwzr6ibo3HGa/AfL5XsOrIcs78/djvfLlKZ+/43dGleT+bn01BAm1yK7863qmvYKKrPhH5GSbWwGWcdnY6I0zBEgjBT5yiczw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HMUpKqiO; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JC3QIs/h4qW2l+2IogfnaNAXWCNkhXjfOEOicEbGbEn1hVwW0lMndbFFpGdI24gOC/pm9bDRxba0bxPeNvS6qstaf2lElEPw/RojTlERX1V3yTNL1FI70xy6rVTr3ObJ60IUKD2QgFfgrI9IKtRHM/Wg2M9vnkCeutrazwYOwyodJoe6cjTLFdS+la37vX5AFXqfntX+LZJmWQ9Rbz4OnTe6yc/hQR3jTgugeq/KDTy3MSqjROsGZRDZhneIsJAxd6CeB+snKGibTpITEoZuwHlK/m8IdxEbtHUU1+e/XxU4/n4tG9n0eJI4Wml/5Hvs4n8ezVKW/7LEGoWC7rQ0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jutqPppDTK2N0CIn9NX/VcMpxOovWEp8gAuxoM+J8BE=;
 b=cnlHe/bEA1K9/01e/hVzmtyHc76d3otXwVQHCcRgF5v/DyvPxAclfXCOJXXQFFwh9eaTAESa2iH3Ot+JlI3wPqt6eOoNFQz9uVZrjjuJz3taJo1hG45/NjDDkOgIixukbT8QIaz78xqidCkMJxTM+3yNlS+Vp4WyEB5X+tSanTRo1loX/2cENdq19qTWE1ZUYV48pL5Oqf2vx7UThOvRfbYBCdSU4erhj2dP1isZ2kGYiQmKlQa/RDtIHRuS7MIbbEupB/PS41NUGLboYL5y1fMlVxu+Oblm5VO6vY0zqHvX1wedrYBbvs3GtK8Bl1ZMGDzuHkguQdIdyKBwEMkXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jutqPppDTK2N0CIn9NX/VcMpxOovWEp8gAuxoM+J8BE=;
 b=HMUpKqiOajkdehRAY8xjFACmHtHBeaZeKKjM0IixbWMc4Ccof5IhXJ/giLjdZEjFlvW9dKgLJ/s0Koa+791M+ljJKk9rUYX1Ewv0y2Wu9zLML247Wp0mMV94GioEd/HslrX0oYQaHF2jYWUVNnemdGkeVkEztdFWUoxOt41b6TQ=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 06:29:19 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:29:19 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT
 AND 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to
 cppc.c
Thread-Topic: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to
 cppc.c
Thread-Index: AQHa9/zsEf+g0+H19U6yFtwJGcW/qLI6pHnQ
Date: Tue, 27 Aug 2024 06:29:19 +0000
Message-ID:
 <CYYPR12MB8655396ADBB331E00D74C6BA9C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-2-superm1@kernel.org>
In-Reply-To: <20240826211358.2694603-2-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6e8ca469-4364-4f75-b807-bd3d737230c5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:27:44Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|CH3PR12MB8187:EE_
x-ms-office365-filtering-correlation-id: 8524d856-3c0c-436c-d790-08dcc661952a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?PKQ5WSBkIdmx3DRCxLZMHAb1ykW7x1eKFTrdppIJNUT7S+rCDWJCme1gWjHb?=
 =?us-ascii?Q?ddX451arF+xYm32/dyFDZOfyD4mXqMK+7VRVqxU8QT3p3KxdEIwXs1YOlX29?=
 =?us-ascii?Q?Jy6n05Go5VW6uULLztDCGqumWxb7u+GWII5cMiLj5SKy92k0ObjQ935VYCve?=
 =?us-ascii?Q?R8b6oTxHtzfgk6YUoqFjhFtK24kDQ6fvI/K3xiO5CQEUMTgvQHhvNNJ5Fvdt?=
 =?us-ascii?Q?CkyEJrMBGl28E/jKD+AW4rajXdlOdrx6Jx5dDybFV97SYjDx7yZfU718LOUt?=
 =?us-ascii?Q?5/4GtFX57DetLdvbCK+kaxF1MCchMG3/8hCgqCjeSJeeb5wnshJdHuLhJaad?=
 =?us-ascii?Q?W3k2EGiMQXSRyCq8G+82DdBP1+CRaGm2FF541797HFs2u78Tn7upNv5YhS+A?=
 =?us-ascii?Q?rS9SFYaoSON1YanOCpsrDlIQaHnl6Lt7TA8v/UEDzAY79op7AaFYpoa2ldsp?=
 =?us-ascii?Q?rVjz+MhA2p3pfqa1OowPP7OVZ+qcmqRsLuHEt/JLu3Zh7n/oD0DvjnfKZTIc?=
 =?us-ascii?Q?ldSDPlBaTnWfwLww+lcrDlY8cWOnWV+voRZXKQdplKbl0o1hOjP9Ub+728nl?=
 =?us-ascii?Q?SdY6/58J1J3UulY4MuWQMrBcagW5yNmKUxSDy7K+F2Nmupop+BRlOZg5Mwlv?=
 =?us-ascii?Q?4zKtcFqjB/Hswvg3OjRMGsRvRhfcIGzzJDK/uXvMG3XV6cChHLMsZ5TeJ2pJ?=
 =?us-ascii?Q?pTGOhidUrUV5IOPuL+4GUBxVxKFV05IBbymmg/XwzqlN02gjE0hqy752QvVb?=
 =?us-ascii?Q?ZzaUsdObPVfNQyyF5n0btDKRPsECEUYFlYT/8P9eW9UhnnjADCMibMRVuczE?=
 =?us-ascii?Q?oEynFlYFhfQgB6FuIHp1/TnUjFWR2ANVSAk9/YIh+UwRRykkhn4mbBUkdj/6?=
 =?us-ascii?Q?UiSPKFTS8LPXnB4/GR37fNQw9PsXT8w9mLpvyQhIgx725cQi6OPzTEldZVbR?=
 =?us-ascii?Q?cmDk1IZCwQ9hxORaXqkPxCnmEldKqz4zIPb9IO0po2fUUAscjNd+dVWm/rcA?=
 =?us-ascii?Q?k+ArNsX5iYxdW1lPOAl7Y4yRaocbq8/82WuzcWBt1VHiHlxbJFGL4T3J3HdW?=
 =?us-ascii?Q?4KkJIljIoLqYf/bSdwKiWzSRUeGiA0kWIHshJRbOQzrL4GIlzaOttYvmVAlz?=
 =?us-ascii?Q?MoDS1zk7Y9ceYAPGPrVYPSuyA+cw/OgqstDbnjQQr4OtUGl2boNeThvlurKR?=
 =?us-ascii?Q?02+Fb1qdjJG8yzQyOqkFa4yjuByX8NLewm5KwwzicZmzRcoq5e00ZkqFKwVI?=
 =?us-ascii?Q?DNQdJnewA7qG/TQJ8gkXDc1nMk7F4nCACupL5K1P0CsAeDGed3aNh3nCy4WX?=
 =?us-ascii?Q?Pm/shVoYm7m7ajYit6wIL6Ot655rHOQ7LoAI0ZE+xCzSK7773mw+HC/oRbJX?=
 =?us-ascii?Q?WConOmUXBHm9Nbp7OPOucJOcCDCnzwtADBgdNkRGyMlCODUh7A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8keX0hhY2zuxs8QMMS/roDUMTuP+TNrh96AXCx7Z35aMMKwIgZNqvtJpJT1m?=
 =?us-ascii?Q?vzL94SMJYa/Cte/uWijfzoGZLB15g+zBiOKjvORMXnor08+yRKNXhO6V3/yt?=
 =?us-ascii?Q?cJ8ArFlQEVpIG937e2F7s+bIN0qja6fpP1oFOmaUHsXrWIGP35n8T1Kh1p6Q?=
 =?us-ascii?Q?ZJcZNLDbnqceAP62ZOgguVNJh+5GR9nUXAtInZAdbN2fti0uPr20PBBmQXet?=
 =?us-ascii?Q?+fNpCqb7tJqEy3dunPs8Xw1OaWN39DFHKI9SS85gV/qOlRoIN4fly5rqH3uS?=
 =?us-ascii?Q?6NQOVDUXMadJUgBBu3ALqC6PvHIarIjQW0LTZPz8luSKeLjxPztrh/7o1Fmv?=
 =?us-ascii?Q?KoMxIk/RevmTigA5hAFaYUYOknWAX7pUzGCCUgg8HJUC3RPVDnQXHwDKg/qt?=
 =?us-ascii?Q?jpuuLxOcodSf4PSTX8TkndBeJfkQ/5CwpA4YXYjR31e1dtPDhEnwUKo0QBdD?=
 =?us-ascii?Q?hrLpos7qvUcWoJRVy0DHNNUtT93mbaP5pLvwwxrQvLQJOi+fzJW4aV/sPQZp?=
 =?us-ascii?Q?vmiIsKnILoUHvPQ7Iv39CQA8BsGX51K5423a908UGcs2sMyKGKol+5aWizeE?=
 =?us-ascii?Q?rLHwZT4eMbmNEsbIZdZrSD23yTqcabqkPIb30DFlxrEdWUwEpuU8tssThcPS?=
 =?us-ascii?Q?X+NoPZ36KKQrN/8V0aKiwMLb3B6vr8afqf0MghhQh31gF+6Cxu0+H2lDZCH2?=
 =?us-ascii?Q?unuV1QvqlwkWtH/669zcyRJHBcIksZF3+rVMRxkcYeW4okMPfQpHhAeFxyO+?=
 =?us-ascii?Q?pp3X5T7RSvevUPYLQM34mn3WfhEt/jqaatStRqZiBV1F+hmejKJZpiqnfWSh?=
 =?us-ascii?Q?L5FAD+wf00Xaxiqmhd2AKgIBx2l3xCT6N0j0SkybAGVDoRv2NUCRWiFlK+wi?=
 =?us-ascii?Q?6rJ1BTQSlBilHSmk4K5iRqOk/MS7heDd1TNBJ74ktBzIPqJ7D6WN/1/C8Em1?=
 =?us-ascii?Q?fYZrpR9gISu8UJf6H3tQn8mv9ycqo5ezlQZT/IBGyByUbw2Nmnn17GJoBpev?=
 =?us-ascii?Q?iVGmReleU8in+NacXv4UQYDDZ6HJVdhcUq6+/mU57UHeyq74fAD1IO/ffDW/?=
 =?us-ascii?Q?EAbyZM58DzwU80HYY0Nb/6W4fprnhbbyFdtvVYTdV88He8pqbXVYkZUzZJVD?=
 =?us-ascii?Q?wxx8U/cmYKNLjf64WM8k/tlYzvT8+lFdqnCkzD3Kx9NZiOQizWMkkyqHW7v2?=
 =?us-ascii?Q?7ST+1oXlhi0Wlr/9D/oX0dCC6ubdth60EvHnItoAya/V7MTqsqDJ3PzeUQMa?=
 =?us-ascii?Q?uXyzYCpnjGtqGpQaXP+56f0aX4QZxGU6uM9+jloGfDmwy6gyok/O10Zt5gZR?=
 =?us-ascii?Q?RhFM371XnKAMaurLxDhdCIx3YzDAN8BH4eYLi5iTZwBgMsI1Y7kE0To/VlAp?=
 =?us-ascii?Q?vTeUvyfD9u9lrWTzxOoTYQTR4lgYxP/ez7Rt7Uhw9IMnik02GEyrBE+CsVFX?=
 =?us-ascii?Q?6yekpqQdC3rNHNFnztLqF4pIzABkNVbvlQcynp1fO7/Zk2xUdRlVtn6dwK/E?=
 =?us-ascii?Q?c01Bc4j5+DTnZPlFGtsv4blfuX/OU7g5igGDoZoVluj9SXmaHdOTV+0ZSWkq?=
 =?us-ascii?Q?W+PBlOzIk+KurA+/dXo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8655.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8524d856-3c0c-436c-d790-08dcc661952a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:29:19.6369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JFgzLjR4Xgko/i/zuAcQzbQIFAX7WzYtBjRaVA0Fe0TKZNnTfa5yjFddtOAKjOrQOcQHi85aJKigVc6QyeQT1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Mario Limonciello <superm1@kernel.org>
> Sent: Tuesday, August 27, 2024 5:14 AM
> To: Borislav Petkov <bp@alien8.de>; Shenoy, Gautham Ranjal
> <gautham.shenoy@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Cc: maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT) <x86@kernel.org>;
> Rafael J . Wysocki <rafael@kernel.org>; open list:X86 ARCHITECTURE (32-BI=
T
> AND 64-BIT) <linux-kernel@vger.kernel.org>; open list:ACPI <linux-
> acpi@vger.kernel.org>; open list:CPU FREQUENCY SCALING FRAMEWORK
> <linux-pm@vger.kernel.org>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH 1/8] x86/amd: Move amd_get_highest_perf() from amd.c to
> cppc.c
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> To prepare to let amd_get_highest_perf() detect preferred cores it will r=
equire
> CPPC functions. Move amd_get_highest_perf() to cppc.c to prepare for
> 'preferred core detection' rework.
>
> No functional changes intended.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 16 ++++++++++++++++
>  arch/x86/kernel/cpu/amd.c   | 16 ----------------
>  2 files changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c in=
dex
> ff8f25faca3dd..7ec8f2ce859c8 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -116,3 +116,19 @@ void init_freq_invariance_cppc(void)
>       init_done =3D true;
>       mutex_unlock(&freq_invariance_lock);
>  }
> +
> +u32 amd_get_highest_perf(void)
> +{
> +     struct cpuinfo_x86 *c =3D &boot_cpu_data;
> +
> +     if (c->x86 =3D=3D 0x17 && ((c->x86_model >=3D 0x30 && c->x86_model =
<
> 0x40) ||
> +                            (c->x86_model >=3D 0x70 && c->x86_model <
> 0x80)))
> +             return 166;
> +
> +     if (c->x86 =3D=3D 0x19 && ((c->x86_model >=3D 0x20 && c->x86_model =
<
> 0x30) ||
> +                            (c->x86_model >=3D 0x40 && c->x86_model <
> 0x70)))
> +             return 166;
> +
> +     return 255;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c index
> 1e0fe5f8ab84e..015971adadfc7 100644
> --- a/arch/x86/kernel/cpu/amd.c
> +++ b/arch/x86/kernel/cpu/amd.c
> @@ -1190,22 +1190,6 @@ unsigned long amd_get_dr_addr_mask(unsigned
> int dr)  }  EXPORT_SYMBOL_GPL(amd_get_dr_addr_mask);
>
> -u32 amd_get_highest_perf(void)
> -{
> -     struct cpuinfo_x86 *c =3D &boot_cpu_data;
> -
> -     if (c->x86 =3D=3D 0x17 && ((c->x86_model >=3D 0x30 && c->x86_model =
<
> 0x40) ||
> -                            (c->x86_model >=3D 0x70 && c->x86_model <
> 0x80)))
> -             return 166;
> -
> -     if (c->x86 =3D=3D 0x19 && ((c->x86_model >=3D 0x20 && c->x86_model =
<
> 0x30) ||
> -                            (c->x86_model >=3D 0x40 && c->x86_model <
> 0x70)))
> -             return 166;
> -
> -     return 255;
> -}
> -EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> -
>  static void zenbleed_check_cpu(void *unused)  {
>       struct cpuinfo_x86 *c =3D &cpu_data(smp_processor_id());
> --
> 2.43.0
>

LGTM, thanks!

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


