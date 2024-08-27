Return-Path: <linux-acpi+bounces-7858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D8F960224
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DAABB21441
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DA214D70B;
	Tue, 27 Aug 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bPZK33JU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CA510A3E;
	Tue, 27 Aug 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741221; cv=fail; b=MyxwUM/VHHKiHPE5IOqmHDU+wT1gpEgWN6Y2sOt5/06cP1zulmkb7NwlUr+pVHAXMO/DvYpzXHB1xzw+sEtntkkeQuUUIdoQ2+4QcV1Bpp/oPfthocYzHjOw5taKQvjTh5lG0wqlDsvDffoIZv0P0qbSOAyh4ZJQDEy4RexaBOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741221; c=relaxed/simple;
	bh=/DAtk8b+i94r9R6MziufFXvMNK0NazYEBgH9s+cJdrU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrCfhm7sNjhIGdu+P0TRhSa3BUrcizDTFeXCltUbu9OL8pkf16fp0Dc0QO9QuIV5g7/5Lq7n10VDFZwkZOEgjGMCWAR7gEVHc+qvpNY+JtVAq0T01xzW9pLevPUPbgSZj9WgDPNt5va/DgsD1MA6eShvgoO+3QeABfAHYeh/L48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bPZK33JU; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZHtmBQ1+JbXAWR00lLOdmehfKDC3RDWyNIh8IWr6LSqBCKR1abmMOFn8gI+P0mDBsk5tRvVLYaxLz65OjujQxAY8Ii6VQYxxM/DgztkFm6W9IBf4hjFlvILmE4deNAezqbKH9dMJPX7A1Q6uOhWMmOxOvWKo9RmpFwnxKMUoNDqkF2UxRHRw7UeZKIWyj12xEsEjfc5T96Tb+HTxuFc4R6IfIfTKNhJIk9kiwMnkTrYCbymV0pX+Wlp7lFCg+YwF077ujinMtQL49k7nqi5lN9mcf9o1rQETRq7G1I07LNFWW5AY5b+i7PRrQInDIaYKX8Sv5EXr/kysMFZzHx8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ev+R1dF0AemkS/bccHJv1snOIMAMN0uhFOPhgLbW9No=;
 b=a0w+qEbGxryjJgR5gL0Io3J8Dn7xPS49OjOHcDwUZhwDHJ8sIpr7ztgLksS9wkLRr/BcEbE/3A4J4BWVcMuKR+czj45schG0QM9mZbx5NYoae9z0J1hy5t1OVYp0NzpxGnO0R5oPoe8wppZE8/0kLkDn4isdWk6LlbWewfZlGRvArR8Bu1P/nGF33FJ7sDVd4ZksBzv7ZA93QzjVnpH4lnx8qDcJ4trs7lcoR26Kf7R9H3J/33WTXwaZnLyhvL+FtBSnvstZcY7B1/fiYVJw0DeuaHh7ngzd3akldoABXVgRKhST2D2Q2cyrjtZ8ptv7QhdZFCFwx6t7Q6PZp0H7YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ev+R1dF0AemkS/bccHJv1snOIMAMN0uhFOPhgLbW9No=;
 b=bPZK33JUKwnZU2pXM/2ngggD5pi/+Zg3EN0qjsqfY9jTeS0OJ14TWsLBeE4U/YYvThTboyT4MAGzJ/zgGvN4XE29oPBN3dVvhLZazkJ4LAXczk9DwoV6KKimf97Z+vTK2TT1CdYLzon0tEW/NT7uA/90Vnp+u1KlbhJ3VQjsxp0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:46:57 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:46:56 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT
 AND 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 4/8] x86/amd: Move amd_get_highest_perf() out of
 amd-pstate
Thread-Topic: [PATCH 4/8] x86/amd: Move amd_get_highest_perf() out of
 amd-pstate
Thread-Index: AQHa9/0HlGV+eZL5WkyWWR5JYnjGnLI6p4hg
Date: Tue, 27 Aug 2024 06:46:56 +0000
Message-ID:
 <CYYPR12MB8655A7CB43CC2A719FE269049C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-5-superm1@kernel.org>
In-Reply-To: <20240826211358.2694603-5-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=ae47d6ca-0757-4839-b1ea-e2e889e72129;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:38:40Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|IA0PR12MB8930:EE_
x-ms-office365-filtering-correlation-id: c96dcc22-2242-4570-e888-08dcc6640b54
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x8mNReRHiv3cDcI9VQiaQh3bY98OPmkVxT2dv49PNmIsbR7ToTFe9slVGWaZ?=
 =?us-ascii?Q?abZBnfezRfbNmX8dQNSDeAgQswM4uIsphw3tf6BaVuYggAYtzdUBlW5OzxCU?=
 =?us-ascii?Q?Nt0moCqjLaLqW6jccbdg0kDy5Is/5HmuDopPrQk5upDq4NcrJQ91MIZZWGpF?=
 =?us-ascii?Q?7d2i4kiON+wulH0uZQUX/mlzWvnVb4iF4mSRFXD4gADiqzsJ7d78HvmxohFg?=
 =?us-ascii?Q?+I5GprqAhGn1ooFCtDJl6XS74WrV91qsP6RUFMCDSdrN7K0T8qKFo9xvdFaS?=
 =?us-ascii?Q?GLsrNiunGM0GAp0LAjGXdCcMbMdre2BwxopRHRQ6BZjwFWSStXZ5j5XyTEut?=
 =?us-ascii?Q?3ayQwsc/lGFf4xVxcJhWYj5MZIq52/RYHwszA7OyEYsadpmLdBvYzSjy1nhE?=
 =?us-ascii?Q?5DEURjoeg8raewtRkk02HEW8Vi8rmIoQJcwUPzXmrXEL5jMY91TCSAof0mQR?=
 =?us-ascii?Q?wpS/Ri/Cu401XPpkWa7i2ojB0bJwv71k4Mtbjnmo1W/sx8+lIGFJvAx/Z6BS?=
 =?us-ascii?Q?PT6YRlaxZlEcWEs3A4NSk+X0sfBi7fKwVDbCiXFp87u3EqfCBlKVO5P30pgF?=
 =?us-ascii?Q?3zSqJlER8TJ6QYOREiqq8u7ZPviRdyRdH1aUJMZ/sMPHPONw0MhH+txuQiXv?=
 =?us-ascii?Q?slsZkNDjvks7H2uoQ/7JoTNlrRmVTfax5mn/jzhFijxTrcmNtr2ewZrZVgdH?=
 =?us-ascii?Q?LkktmP6z/YYZ77s/6B42RdKmViGTR2m3PPo9dFE0Pdf3LyO5HBz0Y9JyjUNB?=
 =?us-ascii?Q?Tc9ohJEwXm/o5UoToOw3cBqK4PYdeNYHRX5C7hQbRYnEPFjRtm+8yzLdC6vs?=
 =?us-ascii?Q?ZopfdFztxfnOEd7CpS5RlPAbDbP1GZoMaGpDBQeW0ySQWSELCuvW/aY/kToN?=
 =?us-ascii?Q?hatn7qFyGuUz5c48e1PKSIegybYCQIW8Swg0BVtfdJkmCWP7HXtdrqw0y7lU?=
 =?us-ascii?Q?9bR1BYbkcG0w2N60Y4dh2tBAKnv8gF91zjvhtEXJ56w6aCu7MhcCQvTMY+zM?=
 =?us-ascii?Q?rtQapcYYBqncvhnbl6168HkXi99bSuF6K9rQfLUgIzWxGvoAGK6OKNi8EvmF?=
 =?us-ascii?Q?Ejca/oZF8maIrHve16Z4TwVkxxG/YnzV02g17u5losmv4xP60R4QG8ZdUpMP?=
 =?us-ascii?Q?m1U9X2nv8ErojfCCRAG9CBTWBCN29hMWPZ6P3m3DvLkPS2N6Vi4w2F5lq1dl?=
 =?us-ascii?Q?PtHErZXEROo3xJVBclHCCR1nri/ynYFb4ki/dZiYPuAt5NZ0vFQlzELSxpWJ?=
 =?us-ascii?Q?2xb3nHRGfjVzObaUzEsEiKysJrNWHi0jMW4fgd7HHUfYdg4Ay7ySj78wiI8E?=
 =?us-ascii?Q?Fs6YBc8DtHgt8RMlKfLot7la45TNmkSpdnlLI0BBgzaX7FaT73BID/zq1JHU?=
 =?us-ascii?Q?MVgtXwW5a6Rb93al7LvJk8Eh4ZNldcnIcp+IpV8ao1j7R/YpKw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QCkA9+60kK1hMJ3sROlvlxdFmsisoJC/LV5d2PrQkj8CixDtYyvedN6ociDL?=
 =?us-ascii?Q?9qV1OXUhXUwoMDiXbEWyJuCaYnyRWE22YSeI0KFAj9zzmPxmI44meszm3EfO?=
 =?us-ascii?Q?jxvXErnBv8xCuJ+f6CENL7OCNABhBJzxjs3w2D2zypH0blvQTZ6LdNhr9ecn?=
 =?us-ascii?Q?WQE89Vcul745StPHQzRr7f98nVcxwtWIcxMcatdQ1trGrs5/26Zbwd9lLzhG?=
 =?us-ascii?Q?Yi2BIGAQHnfebInNSfGt2AsJlhp9YbKDIqrskW8RhxcSNOsL0V5HPZ3Klulk?=
 =?us-ascii?Q?v+RMRnOVv6QHr9zZyVRfNOBLkF51NDslPerL8+p4ip7GdAMGi544L2bsnhAk?=
 =?us-ascii?Q?JC6JUsd1hGD4suKPhZ0ISGmsU1heKnYHsYrf4G0lF27gPZOvmYnscKb+inXr?=
 =?us-ascii?Q?fwr7+x/Udcf/cCs1+F7P1vVMcxtM7Jp34ISLst5Z4hdGTub4/wKx3eog5w+7?=
 =?us-ascii?Q?tt9drBi48sSuT/hrVe8d8njgCfvdu+WJ4qxvFs3pQ3Nw2M9sSeF6SizbaxSe?=
 =?us-ascii?Q?ltzIUTAUcAS12oU0yelbGv+IX36edlK1joWe4A+9XLrcwxvo0Ur6B+dcXqIO?=
 =?us-ascii?Q?Urt4sukmISAq7SOPFDvQ6r89xU711uHJwMJkN4YorfsgTJJCa8RABTxNkS4I?=
 =?us-ascii?Q?xrk+DRJ3QJIevwDCCqrzXPUIOvzW+zSUgBJvO6EaF6scAVhi4WX6S4b7Muam?=
 =?us-ascii?Q?WAIP/GJqVGasjaP8WdP9R1oNVbh36eatF4MqgLMRX+1M/0jx36k+ojDDscOU?=
 =?us-ascii?Q?ghwyGMW8ExzrCrcfAB7XGKnzPM4MXxn/CAntfo6eXKXSYytjKVfy4V5L1aEE?=
 =?us-ascii?Q?Zxq3btBq1NG0OG0IwRrqVKq7psD+1bO6jhQlzWkDxhMaWrEioZI+z5PX6/tn?=
 =?us-ascii?Q?NpH2qI0Q6b/ZQ9Uyl79We2VcTB63puHxxee6Amdri1yUNOGr/HU0PbZ4U1xk?=
 =?us-ascii?Q?aqkT4MLZpkYh+yOQ6GixEP+ev2eBamu/g6lmZHyuzJyEVsDB2p01eo3iArak?=
 =?us-ascii?Q?VL0lL47wOXMf6J20r3xgNIxR9VFPAllINSdGZ/EYAt5qlyKMUXR3Ubk1v72y?=
 =?us-ascii?Q?Ev//nNMXttE9nsSs7+j6uBUqLONVP/eH45sL3ZzdjkgnvP6KMQJv3GFUKDW4?=
 =?us-ascii?Q?2Mp/rz5t7YDdEqPk9/JqgWQZiKCN63d9PEA7aRSTjFdThZ6Fgmnx7HminfVC?=
 =?us-ascii?Q?1nVbARGnVW/mXY8MVR+2gXRnIabUi0610ICAl8YUkA/OMqOshqNemWlHeeGK?=
 =?us-ascii?Q?/SBTeKX3QMEUR/DPpRphfQi6A7TKeZ1Uv/yRG1JjzhKvNiTL7bT7JHgvLFVr?=
 =?us-ascii?Q?lzZ6062w0hnIdzsFMEeIsYlIHZmBSIq+4iPOTmsGYy/ANW8c8AJjLw/br+O1?=
 =?us-ascii?Q?uIpkOGTX2amLfpp655MTNnDR1o09099Ek/LYi0/k0YkEFl+937NmioX7dV0c?=
 =?us-ascii?Q?+qJAyrYKkyTQ8VaRTBVbZIBqMCJXyQuubEMPc6vukKKw3RthnBPb/0hZRuN0?=
 =?us-ascii?Q?dUmKYjh76/+2TjaBit3rVymP+jg3cDdCY026pt139pSmugTMWPZ0vK2PVLmn?=
 =?us-ascii?Q?AyECoCtYen45MHaPcRg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c96dcc22-2242-4570-e888-08dcc6640b54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:46:56.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rJGIewgQ4KMzwZJfZIroba7MiCY+V+SNFULJHxeX5eO7m4jCN6bEj/VU/5AB/Zi465F5MrfzPup1nS6X8hsRnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930

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
> Subject: [PATCH 4/8] x86/amd: Move amd_get_highest_perf() out of amd-
> pstate
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> amd_get_highest_perf() is a helper used to get the highest perf value on =
AMD
> systems.  It's used in amd-pstate as part of preferred core handling, but
> applicable for acpi-cpufreq as well.
>
> Move it out to cppc handling code.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c  | 30 ++++++++++++++++++++++++++++++
> drivers/cpufreq/amd-pstate.c | 34 ++--------------------------------
>  include/acpi/cppc_acpi.h     |  2 ++
>  3 files changed, 34 insertions(+), 32 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c in=
dex
> e94507110ca24..5a6c01a1b0d95 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -119,6 +119,36 @@ void init_freq_invariance_cppc(void)
>       mutex_unlock(&freq_invariance_lock);
>  }
>
> +/*
> + * Get the highest performance register value.
> + * @cpu: CPU from which to get highest performance.
> + * @highest_perf: Return address for highest performance value.
> + *
> + * Return: 0 for success, negative error code otherwise.
> + */
> +int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf) {
> +     u64 val;
> +     int ret;
> +
> +     if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> +             ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
> +             if (ret)
> +                     goto out;
> +
> +             val =3D AMD_CPPC_HIGHEST_PERF(val);
> +     } else {
> +             ret =3D cppc_get_highest_perf(cpu, &val);
> +             if (ret)
> +                     goto out;
> +     }
> +
> +     WRITE_ONCE(*highest_perf, (u32)val);
> +out:
> +     return ret;
> +}
> +EXPORT_SYMBOL_GPL(amd_get_highest_perf);
> +
>  /**
>   * amd_get_boost_ratio_numerator: Get the numerator to use for boost rat=
io
> calculation
>   * @cpu: CPU to get numerator for.
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index 89bda7a2bb8d1..f470b5700db58 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -803,36 +803,6 @@ static void
> amd_pstste_sched_prefcore_workfn(struct work_struct *work)  }  static
> DECLARE_WORK(sched_prefcore_work,
> amd_pstste_sched_prefcore_workfn);
>
> -/*
> - * Get the highest performance register value.
> - * @cpu: CPU from which to get highest performance.
> - * @highest_perf: Return address.
> - *
> - * Return: 0 for success, -EIO otherwise.
> - */
> -static int amd_pstate_get_highest_perf(int cpu, u32 *highest_perf) -{
> -     int ret;
> -
> -     if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
> -             u64 cap1;
> -
> -             ret =3D rdmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1,
> &cap1);
> -             if (ret)
> -                     return ret;
> -             WRITE_ONCE(*highest_perf,
> AMD_CPPC_HIGHEST_PERF(cap1));
> -     } else {
> -             u64 cppc_highest_perf;
> -
> -             ret =3D cppc_get_highest_perf(cpu, &cppc_highest_perf);
> -             if (ret)
> -                     return ret;
> -             WRITE_ONCE(*highest_perf, cppc_highest_perf);
> -     }
> -
> -     return (ret);
> -}
> -
>  #define CPPC_MAX_PERF        U8_MAX
>
>  static void amd_pstate_init_prefcore(struct amd_cpudata *cpudata) @@ -
> 840,7 +810,7 @@ static void amd_pstate_init_prefcore(struct amd_cpudata
> *cpudata)
>       int ret, prio;
>       u32 highest_perf;
>
> -     ret =3D amd_pstate_get_highest_perf(cpudata->cpu, &highest_perf);
> +     ret =3D amd_get_highest_perf(cpudata->cpu, &highest_perf);
>       if (ret)
>               return;
>
> @@ -879,7 +849,7 @@ static void amd_pstate_update_limits(unsigned int
> cpu)
>       if ((!amd_pstate_prefcore) || (!cpudata->hw_prefcore))
>               goto free_cpufreq_put;
>
> -     ret =3D amd_pstate_get_highest_perf(cpu, &cur_high);
> +     ret =3D amd_get_highest_perf(cpu, &cur_high);
>       if (ret)
>               goto free_cpufreq_put;
>
> diff --git a/include/acpi/cppc_acpi.h b/include/acpi/cppc_acpi.h index
> f25a881cd46dd..2246ce0630362 100644
> --- a/include/acpi/cppc_acpi.h
> +++ b/include/acpi/cppc_acpi.h
> @@ -137,8 +137,10 @@ struct cppc_cpudata {  };
>
>  #ifdef CONFIG_CPU_SUP_AMD
> +extern int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf);
>  extern int amd_get_boost_ratio_numerator(unsigned int cpu, u64
> *numerator);  #else /* !CONFIG_CPU_SUP_AMD */
> +static inline int amd_get_highest_perf(unsigned int cpu, u32
> +*highest_perf) { return -ENODEV; }
>  static inline int amd_get_boost_ratio_numerator(unsigned int cpu, u64
> *numerator) { return -ENODEV; }  #endif /* !CONFIG_CPU_SUP_AMD */
>
> --
> 2.43.0
>

LGTM, thank you.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.

