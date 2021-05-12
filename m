Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF037EF88
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbhELXNR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 19:13:17 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:16819
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1442890AbhELWOX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 18:14:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTSRKSXdv5pr4ngJvbdiW6n9DC0HtgRFvVUT2BlbVOJJJ3Dr21qlRtFHlH3A0L0ko5z+5zW+7RgwIJWn42HG2ZLy5L9ZaX9QHPL8fmaw+Tpbnr3c//Qgmy8DR+D9UIomZuDBmZmTUInYZ2C01J3Cgjp3Kk+a+K9N8Er0B6+zD/wqUduYLtRrO4WtpMlaQsbGwXHcaM/BX8Xw441bpa5cG/zb8xgzv+O4JrJfXxxHwf7DwDhWKGDrCn0qnwE/tQJ5UTRFD1fwdyKdjh2neIXQJS5EPWgEFJtL6Be+XR5GTZZafFc7YnUrGtEjDo5xqF59E+8FFNUk+5njSWsp77doWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJdgDA5e9IKwZDmK08JVX2i0G9k1z0U0tAXRgh9LW/E=;
 b=aOrCGzpUVHLCo3gJ8yU3wbgZBXJZZBlj8p31+qr+a3PWsfGnEa7XfKIYvUlbRm8c0BeQU86edUkq/zydSTqw5+xrBAnfBiIaYQ3Ed4xc3Qo2EvOIjxqT4k86WOt5ihSHyw4cKq1B+nK64pNGKLI9Kq3CEBf2/bN0m6bcDcHYgAZL7BKqYPCzpTSFXnwnzM5sc920NHxX4i/0wDYzMlJ2n2CLqurMNC8z6PwYjnKJU/OVaIjCr8gVQh5forlKVPFZhpH78zSqJQ6H6GZ0dEUFNM/B7OvTJIC2W/+RDYLbIrICL8bkyygXTu4P45qtg3t2I2UvZ+b0EKnBwJuOcDKhEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJdgDA5e9IKwZDmK08JVX2i0G9k1z0U0tAXRgh9LW/E=;
 b=PaOi7Yz6J3RstyEXd0jL+mezZZypjtS4wavQG21WaEJ411QuP8zWvTXIWpONDwy2aCTHpx185uD8OQOmViyOx8X42PtRxum27K28JfllynWA/2v3x5vOzorEKetmureLwPAP8uddZlDTcFoHGH/upK33lerag5ACI7iTHNec2zM=
Received: from BYAPR12MB2693.namprd12.prod.outlook.com (2603:10b6:a03:6a::33)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 22:13:07 +0000
Received: from BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6]) by BYAPR12MB2693.namprd12.prod.outlook.com
 ([fe80::c0c3:7247:a767:f5b6%3]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 22:13:07 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC:     "Liang, Prike" <Prike.Liang@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Topic: [PATCH v2] ACPI / idle: override c-state latency when not in
 conformance with s0ix
Thread-Index: AQHXR0s0Cf3VoqTo/kuzqviXtCTQtKrgaF3w
Date:   Wed, 12 May 2021 22:13:07 +0000
Message-ID: <BYAPR12MB2693AA9FE8FF2DC8E48560FDE2529@BYAPR12MB2693.namprd12.prod.outlook.com>
References: <20210512162347.23550-1-mario.limonciello@amd.com>
In-Reply-To: <20210512162347.23550-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Enabled=true;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SetDate=2021-05-12T22:11:02Z;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Method=Privileged;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_Name=Non-Business;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ActionId=5ea310a1-bbc6-4163-9c66-8081d6c59bd1;
 MSIP_Label_f2ed062d-8486-4f50-a4f1-3cce0dd00d64_ContentBits=0
authentication-results: rjwysocki.net; dkim=none (message not signed)
 header.d=none;rjwysocki.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2600:1700:70:f700:5f0:f9af:d99c:b88f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a947d8c5-cc94-4369-3d20-08d915931f23
x-ms-traffictypediagnostic: BY5PR12MB4321:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB432147D5F1986DB4B1CC3E2BE2529@BY5PR12MB4321.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 41UoSriS/wyc4YiKNeJWV8bdRdVlJ9jRGPA2y+uldMg3sZYl6cThRY+slEOnZ49YsbGDgpvd7xGkKWuOAccUVb53EVHCuUtGM6V67aUHRB2XPRFYhDwFa3QrSn3EZEtxNklWFPJRxxSyVBn5vrH02fFX0oV9S529rswm+EQUUxwcwtT1IVtNDQT9NWMOgeOyfTAOkOPQiMhbdQ7tAcxA4c1rv5f931NELjQxtLQdE2UqUhh11IuF5lGe85dYcvk/MPr5S5z0ljVVpv5r5DGHMX0bT0KqwKWoogUa2lCSje8KwXYJR8h31jIS5Kfx/ZR7Rrm3/nx5yLtPO2x1ODAsOLNbeONwIyPhvmy09IRBgqHE8wWNGwbI3bY+46YcGsxlrNCoYEIAvqLrKVKCwikdkN5jOauiPTY9sEGkmhBJv9Rwkhqol16ORSOagEGndsAV6QD1QOVCwfTLCWXduyPmPTGQ/CzsAXYoz+JkLNCq+6/WMdXeArkALmC2SrOKZsCwmhovSEYUxXgY9BGq+jRHBBS47/s8NhpHeq0eT/DMfpLwdeTTnz4o3rdLAmr0JjE86WP959u27D9qH1LDeGMTEkCRLJkXryBeq7BG7PpExsbrVAB6MQKghcm4F053UTnRoZlcgO7c6phnk+/Xg7u6LEeh2fKnw9K/5XoWCqpjnzG4PbesNL49N4UvfvBbN+1Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(2906002)(66476007)(4326008)(64756008)(66446008)(66556008)(66946007)(5660300002)(478600001)(53546011)(6506007)(7696005)(966005)(86362001)(52536014)(38100700002)(54906003)(55016002)(8936002)(76116006)(8676002)(71200400001)(110136005)(186003)(9686003)(316002)(83380400001)(122000001)(33656002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A/TQjEDnqFaxtuUpecBvP+pWOcpTH55k6zrLZmxMpt0l/nVzOZhjDdOs+oea?=
 =?us-ascii?Q?SrNeeoaadIqIWVe0SfSQBp6ejkrH5/50jMhOj9FjqXvkFEVwtRyoP24cm2/P?=
 =?us-ascii?Q?npFEHVtNbBlEQdApEYTv3BvzwduAJwP0GDW5zg1RyCOpwMdhq8s8piQSfuyW?=
 =?us-ascii?Q?5VsXXY6sKvqddnA3uR0DPQAZ/jiaSiNWfNIpQReShzquGg/QUjM2vxh1RpUW?=
 =?us-ascii?Q?qWzqU/Nm+69zMd1VT6H1ufbIOGh8Xn7CXXPO5wka3GlSkHFYxR6vZwVqfL7s?=
 =?us-ascii?Q?6z8lw1J4kFUblKw8a5jIPFp3hf8sG5zB55A8lxVizElf61nus1MgfAisqRA9?=
 =?us-ascii?Q?7A3LNWhl9BZ7UxuFk4ptIybK3Oa8XBeoUk12tA2K5TMKotsiOXCTedaWkpFp?=
 =?us-ascii?Q?So/XKWvQIVNMU2n2nKr3k2OHiZIjIwwJ4K/pRoeBQGqK4K7KnfyIwRLiJ/hb?=
 =?us-ascii?Q?A54UcEBaJ3aNH0FftlOf2t7zkpk6uaJhVxl2zx48ogX/eDGUjXShlO/vpHg1?=
 =?us-ascii?Q?zv7cxnYKWK3WqiHCYOAfCLFpoQdDo/NBZrYF+eKbDV2osZrEvwmpY2HZQima?=
 =?us-ascii?Q?bD6BRd2Ym/vNDSEhhDSub20K8t9rQJ7QXkHeJv9suYTFRHGB2WWnV3o2Qqqe?=
 =?us-ascii?Q?Wibeexx2rGh/1oG+jMQu9aTgmvYUsgzMf9DCiCYZ7QitRITARib1GAe0G+mg?=
 =?us-ascii?Q?T4LDjdzFnMUjhtwbVrEnBQiUTRT3AGYIN9G1IAU4Cj4n9kwbeBx5AX+cYOst?=
 =?us-ascii?Q?mLJCOzaEnkp3iJ7t09aon+yk9gOHCHACbbfI32TqZW4DVtfl971B3f41o8gW?=
 =?us-ascii?Q?9U+9mUvDJ81477QUWxAVsyujbYejWg8fMRNJBC+/swHEaFXxoxr/1jqUbWFz?=
 =?us-ascii?Q?YkaAExOIFXvuuZ1EGWbvWMWalaKy8Jku34upGTr4kOlYZemn6ptDeB6ipyQp?=
 =?us-ascii?Q?kxOEXWE0hQUgYLZc0T+h5NZZVXvyRdcTc7ARlHvIdG8himsjNgCgyYrYyuwN?=
 =?us-ascii?Q?GC/LsqMJ55gEdW7xyzEcvt+gM7nFPfC6DYN4aFqblfQ8ir+jPxWx+PC0OaM/?=
 =?us-ascii?Q?JV356Siy16Ojg+s93AEZ3ci4ktv42I07alB6anQxZDtrkmSoOKDwi7w/AwIV?=
 =?us-ascii?Q?Mff04gFajEtboWWp5vDwqL4F/SmmKwx1CYTWYTPqXUN1kLqPIY2478qOkdjj?=
 =?us-ascii?Q?f5VFTij4Uivydb2S8fWd6YS7BDWiXC1SJn/RXdN3PRFDDUQQ8587OIH12I5P?=
 =?us-ascii?Q?rRPsXCapk2j7lDAfsQNx2ABeTW3ROqNHAXx2U2yaRYDZaPZXDpDdtd/Tn13Y?=
 =?us-ascii?Q?QaolelvT70sG+7MPtMRk97iUA5kdz/RV+r2iMHNBDjQaLKMQ5dZj8E2Nq5gK?=
 =?us-ascii?Q?aVzQaZaTCZn9l1cEJM3XYEiRXrAe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a947d8c5-cc94-4369-3d20-08d915931f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 22:13:07.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 29Q4+ELAn6hRrLuzQfhphT3zwzyUoUa/9eKnFhU3qUs0xjcpTRrMWLEXMgRLBeKcYfITdiiPd40POQYxMuzv1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Wednesday, May 12, 2021 11:24
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> linux-acpi@vger.kernel.org
> Cc: Limonciello, Mario <Mario.Limonciello@amd.com>; Liang, Prike
> <Prike.Liang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH v2] ACPI / idle: override c-state latency when not in
> conformance with s0ix
>=20
> Generally the C-state latency is provided by the _CST method or FADT but
> some OEM platforms using AMD Picasso, Renoir, Van Gogh, and Cezanne set
> the C2 latency greater than C3's which causes the C2 state to be skipped.
> That will block the core entering PC6, which prevents s0ix working
> properly on Linux systems.
>=20
> In other operating systems the latency values are not validated and this
> does not cause problems by skipping states.
>=20
> To avoid this issue happening on Linux, detect when latencies are not an
> arithmetic progression and sort them.
>=20
> Link: https://gitlab.freedesktop.org/agd5f/linux/-
> /commit/026d186e4592c1ee9c1cb44295912d0294508725
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/1230#note_712174
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/processor_idle.c | 40 +++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 4e2d76b8b697..c1f52c5ceef2 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
>  #include <linux/sched.h>       /* need_resched() */
> +#include <linux/sort.h>
>  #include <linux/tick.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpu.h>
> @@ -388,10 +389,37 @@ static void acpi_processor_power_verify_c3(struct
> acpi_processor *pr,
>  	return;
>  }
>=20
> +static int acpi_cst_latency_cmp(const void *a, const void *b)
> +{
> +	const struct acpi_processor_cx *x =3D a, *y =3D b;
> +
> +	if (!(x->valid && y->valid))
> +		return 0;
> +	if (x->latency > y->latency)
> +		return 1;
> +	if (x->latency < y->latency)
> +		return -1;
> +	return 0;
> +}
> +static void acpi_cst_latency_swap(void *a, void *b, int n)
> +{
> +	struct acpi_processor_cx *x =3D a, *y =3D b;
> +	u32 tmp;
> +
> +	if (!(x->valid && y->valid))
> +		return;
> +	tmp =3D x->latency;
> +	x->latency =3D y->latency;
> +	y->latency =3D tmp;
> +}
> +
>  static int acpi_processor_power_verify(struct acpi_processor *pr)
>  {
>  	unsigned int i;
>  	unsigned int working =3D 0;
> +	unsigned int last_latency =3D 0;
> +	unsigned int last_type =3D 0;
> +	bool buggy_latency =3D false;
>=20
>  	pr->power.timer_broadcast_on_state =3D INT_MAX;
>=20
> @@ -415,12 +443,24 @@ static int acpi_processor_power_verify(struct
> acpi_processor *pr)
>  		}
>  		if (!cx->valid)
>  			continue;
> +		if (cx->type >=3D last_type && cx->latency > last_latency)
> +			buggy_latency =3D true;

My apologies, I noticed while testing this on a different machine /without/
the problem that notice was also emitted and realized I made a logic error.
It should be:

cx->latency < last_latency.

I'll resubmit it.

> +		last_latency =3D cx->latency;
> +		last_type =3D cx->type;
>=20
>  		lapic_timer_check_state(i, pr, cx);
>  		tsc_check_state(cx->type);
>  		working++;
>  	}
>=20
> +	if (buggy_latency) {
> +		pr_notice("FW issue: working around C-state latencies out of
> order\n");
> +		sort(&pr->power.states[1], max_cstate,
> +		     sizeof(struct acpi_processor_cx),
> +		     acpi_cst_latency_cmp,
> +		     acpi_cst_latency_swap);
> +	}
> +
>  	lapic_timer_propagate_broadcast(pr);
>=20
>  	return (working);
> --
> 2.25.1

