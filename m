Return-Path: <linux-acpi+bounces-7876-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B8D960F90
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 944BF1C20C4B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03A1C7B82;
	Tue, 27 Aug 2024 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GpuWg140"
X-Original-To: linux-acpi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE331E487;
	Tue, 27 Aug 2024 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724770768; cv=fail; b=SLzxfv3ej++gZbE19GAzXp1W0U3slJcwhCeYLicoImZ8JJArbF0Nnx8EuFH0us3fPNEOo/LIs1JcGR2DhxrCVPEz2EwuLHkvIXCTErb3A/dNA944R9aLcZ5bECfudWpD2nznk+l5ioAjPrR04DuO3LBkfGUWm+QtDLfa1C88Ek4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724770768; c=relaxed/simple;
	bh=Bft9i+I74jA7+ciXtbmRBrc23Xvq8qP47FwhiCuoE8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QjHD/IoH2RZXp5UfbB1rReHYpm0Cgaa3p3nen4eaJuGBidd25iJbqpUc3LoeepnLlFdfS438x1APR5d3OAl63fvqpaulWcXAtBKs7cPoyqbnHFoGqbbmLGQkt3XODxVgZvQQswXfvDYD3wcEfUByZfojLFnsLHfpdod6WnnxbgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GpuWg140; arc=fail smtp.client-ip=40.107.93.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TK5/SlHHTj1jAwde/zVmjT5HoYOm8rbFGadSpCzt/jNTuRJN7kqODmFnBm/tvbzyA9TEzhVfKY3GOFXOks4tOvUWPQ0XaMtFh6YAZ9PP5ed7Z2fNIYSN9p8vKeCvBA/cbUsiAMJHlshtXn4OKVYdivgTnqlDOYw3VMUiaCecWyQ/cESrg7ZnyQ4m+UO5iXE8yk1NLRI8lvhT/MVM80QzWi+Qk7A3CZvNNOKwyxA9IufZgbyJoeH8tZslGwr23J/O7DZsvI8CMUZs7i0Xuy4N5DrrublTXHwerBDvT/DtEETLtkvYlhpEHGPiXy5Awxjx8k9q0fDyUrzZFtCdhdK3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adv9YwmDO0wpQBdj1mbs0GLC37UH1DW4pFxpOVXbEIg=;
 b=XLYaPGJwQSgWe6DCQLUVHCpiN7mL52dbXtn3PAKtpovWaRO7M6Atq09r66eDOJLwNxQD/IroA4+nBD6jaDhFnbsmE0SetBg/xjX7VnhpC37v9QCHNZhcyetpYHSGvjp9fx146mluNAmkEpQndIb0erYbsE0e0gkzbbcOhgfdZRWB/pFWIs9FJbC84WkVPnRZIS8p6zumzy/lbeeCAn4QqhIL57WZA+TBRj/KKnFtzMneAcUr/EWuAJgsa5PhT84l+wXDBWgvo33vlC8HoPsCeUlv3pVwoT41Jx7alZUFaURO0e/KGCbJ5itgyPoQgDZC3CaKMcLVRqwk7HT2SuBGTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adv9YwmDO0wpQBdj1mbs0GLC37UH1DW4pFxpOVXbEIg=;
 b=GpuWg140qN0qn3d0qO8sX/IzPziqN/c4eQYA3ehPj3hwuU+DkyEBzO0PHefcqRCLhRhhBNw7DZO0Wl1QcReL7hVG1Hx/qB4Ma8WX/knUmwcm9jbZeotR56Se35cGU/Rc0APZh7tVlVKHLKZ8g/xIRBFQXgrysQ4VMzwUCiXeYFlYMiAaNQ8DEfzDHz1q8i+MBe80pasBaIsyoZKy5psCFGz/NgmuRVwX2eOV2OLFhaYsi6YMvkkCddtaujkDGjPHrqPZH9MJOQKvfhkIvinmI15C5GE3MqEwI39/UOYdFTo83X591MITYcTpvlpi4Jq1yQpNRavjnosCYGeKZ8vm1Q==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by IA1PR12MB7616.namprd12.prod.outlook.com (2603:10b6:208:427::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 14:59:23 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%4]) with mapi id 15.20.7875.019; Tue, 27 Aug 2024
 14:59:23 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
CC: David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful shutdown
Thread-Topic: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful
 shutdown
Thread-Index: AQHavAVnSip1teEVHEWRQznyc68BkbIfuw5wgBvwPhA=
Date: Tue, 27 Aug 2024 14:59:22 +0000
Message-ID:
 <CH3PR12MB7738609DDDF1A9FDD5338362D7942@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20240611134327.30975-1-asmaa@nvidia.com>
 <CH3PR12MB7738B275AEBE6B167CFFA308D7BA2@CH3PR12MB7738.namprd12.prod.outlook.com>
In-Reply-To:
 <CH3PR12MB7738B275AEBE6B167CFFA308D7BA2@CH3PR12MB7738.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|IA1PR12MB7616:EE_
x-ms-office365-filtering-correlation-id: 57cd33e1-19d8-48f9-089d-08dcc6a8d62a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?8p22h1k+euAxAnI2jxvjgi0FrebynGmcok24bXw1nmV+5yIR0IkZCsuQ1H6e?=
 =?us-ascii?Q?eEkGbujhGpEOgGRH99gseBdci7hlaJN4s2MPpT4OGuP9GbOLTR3TS+0g9SLB?=
 =?us-ascii?Q?RCERkgsddYsALUEXKaAFKGw7ecOQUSTivhRuIPD12ZIRKendjvnuMBP/jdA3?=
 =?us-ascii?Q?1UpSv7tHjccOLHde88KZ39SNYQUEMr3sFd/Mz4Wd5zMY38yz0DRbYZaxagtE?=
 =?us-ascii?Q?jQE9yTobg36MihOc1mKgGr4JjmZtgWe9vGGt/LP/UXaT23FOx6L6mMiYT4F5?=
 =?us-ascii?Q?i/rHGpXmx/Bqxx8zb9XOQxvjWl+UtAb0BAN2eJ4oWSxk1phCPmMzuMwV8hfX?=
 =?us-ascii?Q?O5ldNEH3cRNLANEJh77dScVDVeJZBH7tcDAd2XW7JP+nZgibV0XSGMsrmc5m?=
 =?us-ascii?Q?ZTihisZvBnq8ehetvauQZXNrRovw0vWwB9YpFfR7QvZNUkl+i32c0IdosMs0?=
 =?us-ascii?Q?LOlRd5qmSJ70KsWwW86CfLgoG0xttYnnOyh82sILESjL4Fj+c0CXI81XJOrq?=
 =?us-ascii?Q?Pdz5L62YZrEihvhK3n0NutBOMi+K6uMB/c4jHVJBBXAJKBdSwydrHy0bQPf2?=
 =?us-ascii?Q?xYqxefvpzr8sE5nC+1mCwUOV7fhJ6D7RUlx2YdLmBpZ5b5qyXwKJTCOXjr9c?=
 =?us-ascii?Q?o8G+t8qslCeeNB1vn4Pj/7wrnHhp6bdQ6ypcmKu15MNrwfrPass+9/XICarc?=
 =?us-ascii?Q?WVGe6OePRJEb/uERjuJaaWreuLs3Hau1EgRZ3d7wJ+IP61TTMM29R4K2i1Mf?=
 =?us-ascii?Q?Af9XSJPrOgITsJAPib0Bhf+r+X/yjb/SyeIKTYdTwk0ohDBBz0nbN8S59dlK?=
 =?us-ascii?Q?a7Nlq5EkUQGiqttbn+AIEEdKxxr3JjY+9UWa5NP0sHLwL27Emabuc7dk3052?=
 =?us-ascii?Q?w+lsiGqK97yy0UGbLoUam86tf38WA4xkmS8fm1xiAtPUe+t68N8nFGrzJ1EU?=
 =?us-ascii?Q?IEvGIY+Ay/b+RTc92G7Lzta5PgJ4K6agaQ0qLLU4qaglcHntYtZV+9416+rB?=
 =?us-ascii?Q?ai6JejMcuHu6PD3SM6JacLeQR0B0CFE5bHgLUrSPJDav9yuQ7DpbmAiorspX?=
 =?us-ascii?Q?dZr8Q1akb2iYtL/XLCCKwTW0KazKOT5XrlSWVR4jlMADfufdLa9SQFlm1gA2?=
 =?us-ascii?Q?7xzwgXo9AKXA0VW/hTZqF7IBDROQMkZM0yLQ9uNW2osJIlgiu3dVXyH/No99?=
 =?us-ascii?Q?kRHed+QsWS9A0KtJDf2/SbGnBLkUsc1rvB0MMr5wepAUmDnp4KqjVIOFucyu?=
 =?us-ascii?Q?EJdpE+NKUQtG0xpGDvBkd99F3M7pyikBebEvFLO/cqLXP1LeV4VkvESpbvNC?=
 =?us-ascii?Q?Xji3WqQVX9ODyjwOUXt6sqZLB+P/SN+pTHa71Vv6FWpI01Hcm6VYRYWmFWHR?=
 =?us-ascii?Q?w/gihqxGSPNbppFFyobpQ3B0TPnVlLBf8iAFV6yhv/3mzcuU3w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PhbcS0EglfAtfD8qpYmBejVR4cJK5A+gx3JADMsu5Fk33d7Bn9wAm5UXHpog?=
 =?us-ascii?Q?mebAQYhVl8VJp0vptgSHbRIQnpB/K0n7B8DFSVtF/gWiq9unH/co36tKA0H6?=
 =?us-ascii?Q?VrrZGkvbZ7wgQGVT3gDn5TUPKR/peUh9QkgR6HroBpAQEtRl84SqH19rhpR0?=
 =?us-ascii?Q?oP5gs3PSMD0l7wWrcsoIf+mnDbn0fR+2zA7gkCxl9k8rC7vZLSSQtkKyV7/Y?=
 =?us-ascii?Q?VDKFqEU8AgMKxjUxEeb3dwVPVAkv7mkWy++Ouvi779/jM11ymLVigJufUDfz?=
 =?us-ascii?Q?p+JhpOiTSU6nUDN9Kfw5OuKXyZy2i6OsTFvdiSnHQHNr9T1nyIN5Gv53nsN+?=
 =?us-ascii?Q?HcqswRkookt+XJoxft76Mhky1rdMBbVW8eimTDHipNJV5xcARWwdGBrUTlDj?=
 =?us-ascii?Q?/fi3FxrwzMxw7SpaO9ZczXDgV+DqxoByasmaXz2Q9hz47S7bkUMZLkOfTVbt?=
 =?us-ascii?Q?LFpdhUtskH11ZRwn+9plmGVoyB0vn4XWT7N5DGDZq/P0ddZATW6eC1SAqnXt?=
 =?us-ascii?Q?EJAOJch59TAMJQvsOwjCo0W6hBTMVaJEdL4lMKvawH030YenYC3Pt8kj7CbD?=
 =?us-ascii?Q?+UNFWcrNeI6ByJ5XeoagNbGVweiR4IRdfw/8fcbetcYZOxMGfrbke93x1O8q?=
 =?us-ascii?Q?R5quujXqc1bqDZWp9nP5SVGbTZm2B6mvfRN2m4E3GbQ2apkLgHfBZyRkwr1z?=
 =?us-ascii?Q?VfF+zEhgAj2c7DLspduy8SwgWD1R4kIroXEKY0KjeQKZo7lOUxguJioTVzD1?=
 =?us-ascii?Q?Qp4uQX+H1vqPo2y8S2sIgw8CneTnP0pMPOfZyGo+auCuxV1Nx3B3Va+lGlwp?=
 =?us-ascii?Q?e9vq6Sm+xyJiqLwNbhqnzE8XRy9rhPct7ak/2tGGHDDkQAjGPB9OPB8dI5tV?=
 =?us-ascii?Q?BCeGkrf3gaXXACjh7A7ceSxpWqC0wu1a6Z5hQwLtG6jXPcQEc3WAlgN7wcO+?=
 =?us-ascii?Q?cxFgmct1yEog0jV12es89qkC9HSZ5yKmP8rAGlbRuOB0l/pO4ZbKVZQTBJeE?=
 =?us-ascii?Q?VmHE/qC+AAwarmnbGj1c28rXMFpeuBS32n7LYq3gMLnTiUcixUuWQlroiAe+?=
 =?us-ascii?Q?roqzhgXo8oirqJjKB/hxlpOnEchWi2K4WyByChOlKEBFEZOfeb9x5AVenKhs?=
 =?us-ascii?Q?2qp+IrJ67nuUAaK2dtFZ+uISkfV0FpNoyKfKI6dAvsFOYkgYZN3tvfDrECTT?=
 =?us-ascii?Q?Gh7n2SbdLIQJanMuJDSpzsLsIKrBTRCr9rZAV8qPG1mD/7H3upW7BazXZ5aP?=
 =?us-ascii?Q?R3BBprpWDSOXHYcrPHhSPHYDpOtLdCiZvWBHIKXXiV94YTu9fG8chzuF0380?=
 =?us-ascii?Q?elyogOOi6rCVSQK17nLSO/LU/hdzzHtpf9+ky8vAtA1OW83PP4Fsi7T/KDq/?=
 =?us-ascii?Q?J5JPvOtEI2ek/SmZ3QLz8PMeNkoNBSiDoIBsQHIRbWoOeQR8NfgoM98JEREK?=
 =?us-ascii?Q?x7VJnk3dordjaM11Pv98YY4lbWGBb2R0465wMy169uJsSEPqKAMzH6ZFlRyq?=
 =?us-ascii?Q?jUSiq3sRJb/1JGr4ISgzg6+eLHKNJkTfHUKWV7AwMPXJXC5+i0msICE8aV8V?=
 =?us-ascii?Q?KrOVphfCdORyCDxg/n1B/S9JeqS4qYa95R5gxaleFTMvL+1cVpZg/HrA3bXl?=
 =?us-ascii?Q?WCNJdQ4wIMSUbBxJlXNSynI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57cd33e1-19d8-48f9-089d-08dcc6a8d62a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 14:59:22.9085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bhXdLBP3fKz/WbN9BybIY1+axuEHdU5IWn0NA3dx+X4u8Yu8leZIktTUHrTgz5it8LrBhVPAn/TfWdbexaiUOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7616

Hello,

Kind reminder.

Thank you.
Asmaa

> -----Original Message-----
> From: Asmaa Mnebhi <asmaa@nvidia.com>
> Sent: Friday, August 9, 2024 4:21 PM
> To: sebastian.reichel@collabora.com; linux-pm@vger.kernel.org; linux-
> acpi@vger.kernel.org
> Cc: David Thompson <davthompson@nvidia.com>
> Subject: RE: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful
> shutdown
>=20
> Hi Sebastian,
>=20
> Did you get a chance to review this second patch?
>=20
> Thank you!
> Asmaa
>=20
> > -----Original Message-----
> > From: Asmaa Mnebhi <asmaa@nvidia.com>
> > Sent: Tuesday, June 11, 2024 9:43 AM
> > To: sebastian.reichel@collabora.com; linux-pm@vger.kernel.org; linux-
> > acpi@vger.kernel.org
> > Cc: Asmaa Mnebhi <asmaa@nvidia.com>; David Thompson
> > <davthompson@nvidia.com>
> > Subject: [PATCH v2 1/1] power: reset: pwr-mlxbf: support graceful
> > shutdown
> >
> > The OCP board used a BlueField's GPIO pin for entering low power mode.
> > That board was not commercialized and has been dropped from
> production
> > so all its code is unused.
> > The new hardware requirement is to trigger a graceful shutdown when
> > that GPIO pin is toggled. So replace the unused low power mode with a
> > graceful shutdown.
> >
> > Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
> > Reviewed-by: David Thompson <davthompson@nvidia.com>
> > ---
> >  drivers/power/reset/pwr-mlxbf.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/power/reset/pwr-mlxbf.c
> > b/drivers/power/reset/pwr- mlxbf.c index 1775b318d0ef..4f1cd1c0018c
> > 100644
> > --- a/drivers/power/reset/pwr-mlxbf.c
> > +++ b/drivers/power/reset/pwr-mlxbf.c
> > @@ -18,7 +18,6 @@
> >
> >  struct pwr_mlxbf {
> >  	struct work_struct reboot_work;
> > -	struct work_struct shutdown_work;
> >  	const char *hid;
> >  };
> >
> > @@ -27,22 +26,17 @@ static void pwr_mlxbf_reboot_work(struct
> > work_struct *work)
> >  	acpi_bus_generate_netlink_event("button/reboot.*", "Reboot
> Button",
> > 0x80, 1);  }
> >
> > -static void pwr_mlxbf_shutdown_work(struct work_struct *work) -{
> > -	acpi_bus_generate_netlink_event("button/power.*", "Power
> > Button", 0x80, 1);
> > -}
> > -
> >  static irqreturn_t pwr_mlxbf_irq(int irq, void *ptr)  {
> >  	const char *rst_pwr_hid =3D "MLNXBF24";
> > -	const char *low_pwr_hid =3D "MLNXBF29";
> > +	const char *shutdown_hid =3D "MLNXBF29";
> >  	struct pwr_mlxbf *priv =3D ptr;
> >
> >  	if (!strncmp(priv->hid, rst_pwr_hid, 8))
> >  		schedule_work(&priv->reboot_work);
> >
> > -	if (!strncmp(priv->hid, low_pwr_hid, 8))
> > -		schedule_work(&priv->shutdown_work);
> > +	if (!strncmp(priv->hid, shutdown_hid, 8))
> > +		orderly_poweroff(true);
> >
> >  	return IRQ_HANDLED;
> >  }
> > @@ -70,10 +64,6 @@ static int pwr_mlxbf_probe(struct platform_device
> > *pdev)
> >  	if (irq < 0)
> >  		return dev_err_probe(dev, irq, "Error getting %s irq.\n", priv-
> > >hid);
> >
> > -	err =3D devm_work_autocancel(dev, &priv->shutdown_work,
> > pwr_mlxbf_shutdown_work);
> > -	if (err)
> > -		return err;
> > -
> >  	err =3D devm_work_autocancel(dev, &priv->reboot_work,
> > pwr_mlxbf_reboot_work);
> >  	if (err)
> >  		return err;
> > --
> > 2.30.1


