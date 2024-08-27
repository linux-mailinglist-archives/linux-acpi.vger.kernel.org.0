Return-Path: <linux-acpi+bounces-7857-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 550CA960206
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 08:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6B21F21D80
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 06:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B911552ED;
	Tue, 27 Aug 2024 06:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JBCSysqG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E326B15359A;
	Tue, 27 Aug 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740673; cv=fail; b=fUeGUGl4/Y5rMzSJDOmbIite+pSpCz8Lsdr1iFQCFuXJcgznSS+b5DJxWXYjiTwwZIEyHR5DZYUFj1fJlJFPAlr1Utju+Eaqk7N/p6OovouQanxVMOm+ICekOV+ln/vYxy1A2+WcVxa1B9simNbgfO9RHs+1V6O7Pg0cNkz6k14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740673; c=relaxed/simple;
	bh=XQibsjRneIuvGUGe/w2g40LEXVoBw6p+3qsODF82vZU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lI9O3OZRxsb4OGruDXs7CX0AkJNEDMeTCFSBOti24iu2myUAFrlarDL1jQJ0D528SsRk1un0z+UL7s9tL4TvcU9HG9/aYngBw7e43dttRLAEw3kXt0BhBxFvWqHXS2wabhjb7bSEivzXtnxqKgvtes7nBZcMgz7DHvPNV2mz4Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JBCSysqG; arc=fail smtp.client-ip=40.107.96.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dshWuv/cYGBt25Yss2krCugqem+ebduTT0nkxYNXZ7ym2lwKChcq5eQwgTVgfUFVHdnPKTUtCm7LbiHVpvb5oFu/6OZWo/Vc6RDj99AfI+mBm+ITtIhtCAR8mZ6ieH+pFId+t5RwJNlfLnIJmirYJFAjMcWWrlB5fjrqNSIc8XuY14Wuc/qUaCXPoi9S+feWgG9W1m0wXGP4daVD/AvsJJQ5wtKCrXIeITtHIhyzVSMpk3fxbgM3+NaQbn50EJm3I5YRZWlnOEuibPqY/sfZ+mK0HosuqSpCBtuhZGtLbx3F3LN/KDFSDGq43A3VunYJ+emlRQvtQO1LE7KaGnld1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXujd8BpW+rD+9wvJ4Zeb3irCQ1XQkKfhE9CljXl44M=;
 b=ukUk/3fNLArOGwx4ri1QFI3Pn0yAZc9ybH9cIJfW/S6avrOk76sAaC0Av/rMxKzlJ1zxukP1vjDBkpAgzWEHDCVQr6mCkk0pewsxlH732TiFnvlPX7R2Y+fSDkU/rYk6WA3kdTtM2xrR0ewGdDg6I9Eb7+7Ifin6K4oaYhQ8Ewoe+bvctd7Qec+r4Ya+EuaCdbuSMNPnjXNq9jXyb+dIqqvAHfL1YnnNgCNTEK3xrtXsSRBMoarXiBZlwz5gr8p2QWCN8glYMxr7THKHXDAFbTtOWhPvqg/xOB2iuCvXAHt+yJRacBUNmJyo02XGTDN+dHO51TqUoos/mMT/+HFUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXujd8BpW+rD+9wvJ4Zeb3irCQ1XQkKfhE9CljXl44M=;
 b=JBCSysqGvafO7VKXrhFeLd4sFS25TyT2qH2HuWx1WU+GBT3cVAwXd6dqcGjbB8D0rcRJgANzJwJNmBKMkkt7qAydVhEcskWRz4EBZvlF6cSubsc0WSJMxGOYmsqczxUeqEpm+nTS4LyuE4pIvAXsDIXFw7FnZ4qjyrMGpm+lPM0=
Received: from CYYPR12MB8655.namprd12.prod.outlook.com (2603:10b6:930:c4::19)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 06:37:49 +0000
Received: from CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf]) by CYYPR12MB8655.namprd12.prod.outlook.com
 ([fe80::7fa2:65b3:1c73:cdbf%7]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:37:49 +0000
From: "Yuan, Perry" <Perry.Yuan@amd.com>
To: Mario Limonciello <superm1@kernel.org>, Borislav Petkov <bp@alien8.de>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
CC: "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>, "open list:X86 ARCHITECTURE (32-BIT
 AND 64-BIT)" <linux-kernel@vger.kernel.org>, "open list:ACPI"
	<linux-acpi@vger.kernel.org>, "open list:CPU FREQUENCY SCALING FRAMEWORK"
	<linux-pm@vger.kernel.org>, "Limonciello, Mario" <Mario.Limonciello@amd.com>
Subject: RE: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn
Thread-Topic: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in
 amd_set_max_freq_ratio() to warn
Thread-Index: AQHa9/z/Qfcob6glA0mCuEdiDKpLsbI6pnew
Date: Tue, 27 Aug 2024 06:37:49 +0000
Message-ID:
 <CYYPR12MB865571DC6614FD7FDDF637699C942@CYYPR12MB8655.namprd12.prod.outlook.com>
References: <20240826211358.2694603-1-superm1@kernel.org>
 <20240826211358.2694603-4-superm1@kernel.org>
In-Reply-To: <20240826211358.2694603-4-superm1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=303f985c-2ff3-4e1d-b362-59ee29d3fa57;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-27T06:34:51Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR12MB8655:EE_|SJ2PR12MB7867:EE_
x-ms-office365-filtering-correlation-id: 665db48e-5f5c-47b4-2322-08dcc662c4e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?W366A2BFr1dlGB/FgNtY9CuqtZ2N/pzKisF6l5GmR4iwqeqwDZFos3Pu/jQv?=
 =?us-ascii?Q?69tfEPsicL25EY5wYUY5pg/ymW+CRV6aGeecryQanEm51Y9h9u34KMHCCOC8?=
 =?us-ascii?Q?XcIeCWn63WDtPz150Se0LG0tyylSet0YNhKZPtSsacJi30Wrd0NPDR/Zlj7U?=
 =?us-ascii?Q?yPPkdfpaVmB6MChP14TD6QpKE9NjsDzEO/ePp1Z12y+jFQAdiCRv5hKDgvbQ?=
 =?us-ascii?Q?ZfgpwI7J3xg1szqOzJBiCNhORVsN1ldaSNPgmpukxWeX2K2V0A5w2KKN+foK?=
 =?us-ascii?Q?QOl7Of6rz6DCYQulutNaN1B9n65vVVnH6o9ySNMF3cHan8xT1NzAVEI0Lgv1?=
 =?us-ascii?Q?TEnatEfL8Oq6NMONO7rSKb/T0gLjOK+VVWsP4HzLrzzFand2NWoM40te7/Lo?=
 =?us-ascii?Q?QBICcSQHSfNGIHta4PJRx18TPzqjALvx5WBo6VRz+GOsfhoocve/D+9IYygY?=
 =?us-ascii?Q?cozrbILSWuhFkWFaIJxOFR+P42Zpk9N4DOwBKdAiWWj9bGV5UD6RMKO5dT87?=
 =?us-ascii?Q?CH8EE//iltPZV3j5YXWyz5hr/ZonCLkoBvqYu4Rl1UTJ3mVtXe13v+raVm9p?=
 =?us-ascii?Q?teuFLF/xuAo95HVU6e0Kow9PkdF2LstPsJ+R/SiV+BA35DxyuNGmMbhRdBxl?=
 =?us-ascii?Q?5d+H9PxXoAfcoz8OBzFoPWJLHI1DojLcTCwIu+iRtXeyRQratvp2uGm5afwW?=
 =?us-ascii?Q?nADwFK3sKkLqr4WaArvYNA2Yv0UAnx/DFN7CM0XcgfCWWaCxr9o781x93PXT?=
 =?us-ascii?Q?UWPdPYE/koDh0Pv07QIxA2uIIq+zkff4ZqLSXi1iJMFFG30qvYueJyTXLLDO?=
 =?us-ascii?Q?1QrVGOVItrD5vwicn6bSssx9yAcQEr3chWSlYX5KHfol0iWBqXFT0RfMo35v?=
 =?us-ascii?Q?hrgcF0iB9uZ04W9+03I8NXQzwQMJdi3M35+Tc4iw0sVfxj8Bjmi7et8pP780?=
 =?us-ascii?Q?YDXfW0d9uiAuOvhowDX7J3jMDPsQvvzMRIicNOSyl8pTlKwjJXt6SXCGu2Na?=
 =?us-ascii?Q?b5Ev8d1qXE9fNEm47uCCUSkEZvj2CH7KzLphrd4wKrbfg3K8CwIQCdmsxFd0?=
 =?us-ascii?Q?t+/rymDbIzyUNkkWuCU7FHuRPMUPQ23/4q6FQbVBduQj+93MrZv4+Q/OhjEr?=
 =?us-ascii?Q?qZvmYogxYi8kpyGrKOgQmmfGh8bXlcDVDPFH2kCFUgzLkkskp8rFFqc7N2z+?=
 =?us-ascii?Q?KWJYodbLu0uTjyzlgKW3gRGkBSVjCJQ6rkdh5jUZBM1tlSKVzlun/qTiSIHu?=
 =?us-ascii?Q?t76JxbsPK5RUPOXbyAUnogu7plPcxYLv1JrCgVNXJBHY5U2Vbx1Rq0XLzToy?=
 =?us-ascii?Q?aRcThS79tUrJkEw8n6IgANOWFZivCJpbX3vy40nq7FP5054BlAHS3FtDTCyO?=
 =?us-ascii?Q?fCBqKpFJtpSxvCEexmJ1UllvtfLGbUOFCbA1BoGoAye5b+ECgw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8655.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0+kza24M1w6bq6UZhQwIIh01092tieSuhyYgnjv7YFUWr+4J93hKhEGJsiay?=
 =?us-ascii?Q?biMUZMM45s8lFYif0T2c12bQkYv1HiUX3KeeDRjXMsHfvD05IXLTRVIg1x8/?=
 =?us-ascii?Q?TsK4hnp1H85HP324DDyLg7jX2xF0UgrRH2wz9TEgyIqt2DmyGwkNzGZUsk9f?=
 =?us-ascii?Q?SGoYEYsNl/EzyNN6XtmYVpSRV6k6nN6jydcivyxLSZrIyTSuRRQdJKuwpMZt?=
 =?us-ascii?Q?e8ynKokMM4GLYZ+UuhmSYj3yHlthnOak/MvAer5myZ9mgbGFw5ACdHbFMrhW?=
 =?us-ascii?Q?yhL3iMlFzzoNp/OVQnL111aerb5r4f/RPPZ4B3J/pHwAjl+/9rgmp3cTo/3D?=
 =?us-ascii?Q?eY8KhTj6EBWnyUnvGq4H9Ickgu/JwP9IzQRd+8voodPyGiVwNlYpnXZJRR+k?=
 =?us-ascii?Q?5ZZAcSDocyRYa9Vd/2RLK1ZrR8aQ1wjQRhE9/0ensoaJmViXf75Z5mAIRzAx?=
 =?us-ascii?Q?8ZjcI40RaU4UKvU3QMduNdU2PsmRaWu9zSraT4dvW18UcoWpeF/OXJEQFh4s?=
 =?us-ascii?Q?mvXnWn1/kJIFCTubdtLP18QIJ4raN0IN6ejwVn7khCP1V9hnA/kyRpwmXQ+Y?=
 =?us-ascii?Q?Pbs3MRh3mtfujYXACsGhNA1t5dhP/laFpQ+JCyQ7LVBi/mZXksh8ZdUoPhhO?=
 =?us-ascii?Q?/1t+6paH2UVbhzQnLEHTLP4VYD+FXsmMR0vbEaGFI91WQ6jlIPoIYlj46CG8?=
 =?us-ascii?Q?jjqt2mXPbNg1MO0ezayFKf+YwviIjG9aBcZwbsX7WFGDTV0LekKETIpTaQYA?=
 =?us-ascii?Q?KXu0rSarsiozO6DdRjNJWgswVoIIfPGR+6PS/4ci+flJNTI1VDJ/5hfEfw04?=
 =?us-ascii?Q?FN/mjkduf4St2HyzoViyWRk9UyDrBdLGW85lhM4qtrRSgaIqbXZQxP1iqLuN?=
 =?us-ascii?Q?u8my2JsEbTT+lFqjQ2M3Rprr0Fi0JQfUxORM0/VqC14OQ3c2TuZxZlDMkcBR?=
 =?us-ascii?Q?+16voG+1UZyF64WdzlRROE8FrFuPIyttdxgKGE/CiTFvyGvk9zUs6xQdiE0H?=
 =?us-ascii?Q?bP2IPY90JBVgDFpS93J61FU+HoilRh4zAwjmwOMrh51GMaWTCsj0kXoE/NP9?=
 =?us-ascii?Q?0q7WccGBv3HImQoxF1FKkRqB6LE/S2NQ3oWcpXPg+FXtZipbuwGqNuvzxo3U?=
 =?us-ascii?Q?CHNEGQxmuDxR6OVdeL00FXTPR5izuXiBdKT8etyVZDbzt8krZfNgzwtxnCNr?=
 =?us-ascii?Q?ywWUCFCA6FNPLszqE9jc+qxtYXLvq3yUCZZ65rjGcWVMAzAJKG7gk/KBLuhY?=
 =?us-ascii?Q?LBFMuTwdNp0N5T6zqQOvB6C+zbRpAJFwyKjYg3bMTjJGUuMgXzf9lMro4D+3?=
 =?us-ascii?Q?nVS/5pk6kuFtxLrI95BI5Sv7AMBLd5Qjcpn7TgY3OtpIw+xttwpHk69Gxcxk?=
 =?us-ascii?Q?LL6ssr4bMMXc/GDY+/4IJMcwFkFMeJrHmmdHYqgmzuKebZ+W7UyTcwfDPXlu?=
 =?us-ascii?Q?afAnSHFdk1pHjlsJlEuM2EgUkfDpnEY+C/YzXnEDwpu8CExOOIezkcZ46tL4?=
 =?us-ascii?Q?aQHPzQdI6tpKfjhL0TxXfD5iXuONzsC+VEVlbhT5F+/3qtaX5VZ0iBbRLzid?=
 =?us-ascii?Q?QWWVHqrqX1IC/w+wRKo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 665db48e-5f5c-47b4-2322-08dcc662c4e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 06:37:49.1481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j25T6nP5Zv36KP+I9Ud4OSreaMcrpPKTV84dxwlS6N1O7RSUG0YYFVBZp2RCrpV1rXlq6We17E+ZfURRGGWNuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

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
> <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: [PATCH 3/8] ACPI: CPPC: Adjust debug messages in
> amd_set_max_freq_ratio() to warn
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> If the boost ratio isn't calculated properly for the system for any reaso=
n this
> can cause other problems that are non-obvious.
>
> Raise all messages to warn instead.
>
> Suggested-by: Perry Yuan <Perry.Yuan@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/acpi/cppc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c in=
dex
> 1d631ac5ec328..e94507110ca24 100644
> --- a/arch/x86/kernel/acpi/cppc.c
> +++ b/arch/x86/kernel/acpi/cppc.c
> @@ -75,17 +75,17 @@ static void amd_set_max_freq_ratio(void)
>
>       rc =3D cppc_get_perf_caps(0, &perf_caps);
>       if (rc) {
> -             pr_debug("Could not retrieve perf counters (%d)\n", rc);
> +             pr_warn("Could not retrieve perf counters (%d)\n", rc);
>               return;
>       }
>
>       rc =3D amd_get_boost_ratio_numerator(0, &highest_perf);
>       if (rc)
> -             pr_debug("Could not retrieve highest performance\n");
> +             pr_warn("Could not retrieve highest performance\n");
>       nominal_perf =3D perf_caps.nominal_perf;
>
>       if (!nominal_perf) {
> -             pr_debug("Could not retrieve nominal performance\n");
> +             pr_warn("Could not retrieve nominal performance\n");
>               return;
>       }
>
> @@ -93,7 +93,7 @@ static void amd_set_max_freq_ratio(void)
>       /* midpoint between max_boost and max_P */
>       perf_ratio =3D (perf_ratio + SCHED_CAPACITY_SCALE) >> 1;
>       if (!perf_ratio) {
> -             pr_debug("Non-zero highest/nominal perf values led to a 0
> ratio\n");
> +             pr_warn("Non-zero highest/nominal perf values led to a 0
> ratio\n");
>               return;
>       }
>
> --
> 2.43.0
>

LGTM, it is good to show the warning message once there are some perf value=
s are invalid.
That will help to debug the issue from customer report log.

Reviewed-by: Perry Yuan <perry.yuan@amd.com>


Best Regards.

Perry.

