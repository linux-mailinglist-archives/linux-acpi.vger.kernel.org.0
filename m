Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBC364E1AE
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Dec 2022 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiLOTUh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Dec 2022 14:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiLOTUg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Dec 2022 14:20:36 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAFA4D5D6
        for <linux-acpi@vger.kernel.org>; Thu, 15 Dec 2022 11:20:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNv2nxPvw81LyZDf3eD69N6vT52zQhppxuErnTtOV/PFycezIycVgBDgu/BRViTsapxvTkaNv+4XzF1Xo1lrtbYVikwU4O0XaR07vrYCoDAfSEeMXGXSoZHZxDEocxdEuG67I7RrLoNd76S12L1dHLGaIuEnmSrwdMsSOf0XWzdoiwEdJx2KWMnMxGI6bGPrW//pYILeM1lYSlB80kXDUfizol78gRwW3FOvvrIv3+Kdr/5LPSGKfMKKVEbDdwmZywx9e5FTo0boz6WKg+LjpGwEI8r2uvBGKIiW8vVZZt4hEPlvRVVHh9nNY9/qxfevee+BNdr2Ki8xrSXnVXSp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICvKOJu0dDevNVMYBpThUgAJlT7YxvkCBtb5sv8peA0=;
 b=hFWA0BS/hbu/OECCELMjcGzzPyU+zPB0EJJ3ZZjbAlP9CLTcg1zzc4CUkJuihgOC4mfOf0JLW8QzGbVyDpUd8UuAfCIZ6lmKPQ76LTy3+XnLPuVL5JMFu1fRy3gS810JIPgzp5BpHcJUkhBEfL741y7jELQ2nOfVh4hLsmz/BwqiHEPvNhKEvvBpu5szKrOTuIAAIMXyIm9hg0QFuh6zqeo9gqDqTvbaPqUjBEnHQQpsCgohKPRveKk+aC6mldS6psZ0rbcxUNw7vgAHZCgZB7sapUo2WhDK5EPzPTEaK0JJidfjdMZYCubOZiV9Dny5fXsmiFfqC1PUPojq/aRIsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICvKOJu0dDevNVMYBpThUgAJlT7YxvkCBtb5sv8peA0=;
 b=UmiMYKtuJ0+acACv9WgvxEb1RrMMvMkiXPv3Hd8vDROUVFAneJ915ZaALA+euSfyOMgt/mf7oCAUulYHgNN8uuVWF2iibuRAGGOUdYsyy38RgYszKVEKAGXuJ0LAzcChuHul/u/U1hEfddUbX/rRE/w21fjq4YaMx0Hd2Qa5C3Q=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7676.namprd12.prod.outlook.com (2603:10b6:208:432::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 19:20:31 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ff3c:2d37:75f3:442a%4]) with mapi id 15.20.5880.019; Thu, 15 Dec 2022
 19:20:30 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Daniel Dadap <ddadap@nvidia.com>
Subject: RE: [PATCH v3 0/3] Adjust ACPI video detection fallback path
Thread-Topic: [PATCH v3 0/3] Adjust ACPI video detection fallback path
Thread-Index: AQHZCyQP+qdcODd6TUGTAuHMnqQfMq5vXaGQ
Date:   Thu, 15 Dec 2022 19:20:30 +0000
Message-ID: <MN0PR12MB61014F8D6D5B04B90997480DE2E19@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221208164207.13518-1-mario.limonciello@amd.com>
In-Reply-To: <20221208164207.13518-1-mario.limonciello@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-12-15T19:18:07Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=94bf7e13-3f69-4914-bb49-f494aceff07a;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-12-15T19:20:29Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 15461c5a-86b9-470c-af22-c107b8621d87
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|IA0PR12MB7676:EE_
x-ms-office365-filtering-correlation-id: 769f1552-00c5-4cce-ccc5-08daded16e7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dl7VyFGHrYdax47dkWQqNvPA87c/tlaYO1wYwWuV+YGgd36oD+3RXYnCJVggo+0YVXyTJbu2m19vxpOSQ7R0OWXS5MM0vRXSAjVa36M9ngfnjYRZcTp4ul3Huh73GKiOejP1v7TaHVSbTeviOjUK9xUsW/KO4ZBwYzl1wY39jZiODUJzOHq5WEnPK7vG1mIqOoyHgkgs4axWlvNs8r14/YQtJKJWAOVi/+Qpv6M+oYWJj7nixajcW4arTm8U2QaT4p+R+e5GjA3UZtAcSO/1kkVEvZPEYCk7/PZe3lzbwHon9+MRlpZbggbcn7OcL8b7Gb3dFrMC84Qs6CBiuIHTZvuyUPqA6Fw7J/YuHMSdzq/tcS2JvOkDnCzfVo/I99P/bjRHmsGUZzFEZCdHEfaMivI8liDSNRnDE6O+Xw0aor5UZ3uBAkCmAIa//l/bdjFVQw6GibRgWGdfSXkLBm78bgWf5D9TMfSdteZFFoS/wLaOfQTjdOa6zsMawkWyRJAYZX04y5PlJuITjSE9DtSRzRm7XGwrPV6tjN+M70736UVwlocmKDTLOe4EGYkpJmCH1E/wNBiB+o51bXnkV8Up0T6F52SmSDDOmx6k8q1znko5b8hNMjpB6LAPuPLwovoSvi6VrSpaSNWgARZxk0lP0t4wceMHcB4ELqCeZmXEcA7AfxEcQiFMZ8DLBt44KgO53QA8xS5URr0l7VpsnpuRrUjvgmPeuZj+16YlrQD8IoY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(451199015)(41300700001)(2906002)(52536014)(8936002)(83380400001)(9686003)(26005)(5660300002)(4326008)(186003)(122000001)(53546011)(38100700002)(6506007)(7696005)(38070700005)(66556008)(66946007)(66476007)(64756008)(66446008)(76116006)(8676002)(54906003)(316002)(110136005)(86362001)(33656002)(478600001)(71200400001)(55016003)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F4PFKjO/QWV8iX6YYXjOs/plIfIr9YAAfdpB5zxG6pE1ibd/CXxd2PFyayyc?=
 =?us-ascii?Q?ZxIR4NbSpjLMJ4sRdR21xlHf2YYwmhO64sAjCoFyDZTLRErxefBtT/1NRBL3?=
 =?us-ascii?Q?WX+I1NdaZgIohPCqqR0fb13lgXVPANU7e4eANSJoHopG4RdlDTtCrP7LHFTu?=
 =?us-ascii?Q?58AJLuwHoZYcnXb68GghwiIvZrxWfHB+4xgjOwD8hHn7v1ob288InTtrb/pH?=
 =?us-ascii?Q?7PfACNkch1DPi57Mt5PtUfG7hbwfAaIM109cBQtHeLpgtp/GAWcpgXdNEp1w?=
 =?us-ascii?Q?eoGe1ZYo4ndiECKTdHAKJ2D0E0FObFB7mWsMk/3Ujm5DiFY88N36lCGDcyXc?=
 =?us-ascii?Q?IX5MmPpp1rGIINNqmvyieZEmXl/P5s7bkWw0Rp4ggt0J0a84VcKLuC2V7P8Y?=
 =?us-ascii?Q?yG5rLPDszHT+hCasSmUayqK1Vwb4o5M0WS0H57djf1Anz7zkOOvW7qyO8B61?=
 =?us-ascii?Q?9Z/tDVXJVJizsOLg52qBclMJRPrReo63ocqFL2ABMBxNABUGV4SVL4v/ik8H?=
 =?us-ascii?Q?nqrmgSYcBQiRrkpEj7FC4nlsNkzBPxIbjDTBpoT65tWWWDir9vqzMdfQldTR?=
 =?us-ascii?Q?xqz4KhOQxza4IyB2x5nlupPW97mv7qMnWFbD0UboAnqlzSgJeae6PtG3GCl6?=
 =?us-ascii?Q?xjd8UsyCM34ShBquyFzdJKxuO6t35+Q1GG28QXd9Iogq4cNvhduGHo64ChGf?=
 =?us-ascii?Q?DaRWjVF/r6+CfXuiAO2X9609UKrrc4Zz/V/u4vFPzeHBVORryJBjlw0eRl0D?=
 =?us-ascii?Q?lqUXCFhCtZjvqXyj8EJsLqKiw/SSzn6uykndwD5BsG2L3tBvwDzOer9uWowl?=
 =?us-ascii?Q?4Xtkk+9oZ/uB0g/1qBM0htSbBNilsM2FJgvi4JFopX/iAMQ7bnYYbK660O1h?=
 =?us-ascii?Q?J7HcnZ3xP92tvtIEyhBQWxRhkQRS1ZnM746HQOzeapFqKXrW5NpX1EXf5AyR?=
 =?us-ascii?Q?fbxX4GSVDpiD6Yu1pXEG9lCb3xcmzww7LR3FTMqv4F5XXz3ca5qYZ22rQd40?=
 =?us-ascii?Q?+VWnp2QuxFE+Hik0pgh0A3+XjKe/9dtmIfwV4zTuGlzC0jJ0w9ixmGnQRzI1?=
 =?us-ascii?Q?3mXBdC+CXN/PfKvIu8I2um33svoGFUr4iDJ/jiOtP9JTN36YaZNYA3Jl4D7P?=
 =?us-ascii?Q?KLMotbN1z95W0Cmnyvxps+ZkNJ+fmwnlSp0tJsMQJzk7vwLrWE5iCbSR/YTE?=
 =?us-ascii?Q?KZqNzzo/tObIPXT05fIES+f6g173n4MFocuAg2Z3c63ytCCmLZT5sJ3fH2Ow?=
 =?us-ascii?Q?4zLiNhnm7aZuAy+qTigd+dugrrZXu1P3jcuSbYFcSYRfM7Gtu6HUJoZGwr76?=
 =?us-ascii?Q?Q0cg9K6mkJ2D90bPu5HXGZH5KByjoYV6r9aihOQAfl61aI4u94gB0adhbxfM?=
 =?us-ascii?Q?LVhCa8yCXTLcpQ15OUrLpnY0tK+ikQ8Mf/KJZmFPiXkQ/UJ6EALz7zv4Aes+?=
 =?us-ascii?Q?nsR8ennxZQw9HQKeyMMncDYyqFSTq6/KNWASfxGBQlzSO6v1UY+Pa1g8uH1Y?=
 =?us-ascii?Q?ojncTPoWh3ipbd4qzOXWerRmh34QuTE4AARdx7Mz5vAqHDqEquClCjtqRvoK?=
 =?us-ascii?Q?IYC9RtXmC3ZCJWe1zhc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 769f1552-00c5-4cce-ccc5-08daded16e7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2022 19:20:30.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1y70D+hPUR51/ZPg9xtISbdZjJJbrRaFN7ZDk+VSzzqbUapmCc4D1eNfJKBQ5hP3HwtwP2HYZCrr3g48FvPGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7676
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Thursday, December 8, 2022 10:42
> To: Rafael J . Wysocki <rafael@kernel.org>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Hans de Goede
> <hdegoede@redhat.com>
> Cc: amd-gfx@lists.freedesktop.org; linux-acpi@vger.kernel.org; Daniel
> Dadap <ddadap@nvidia.com>; Limonciello, Mario
> <Mario.Limonciello@amd.com>
> Subject: [PATCH v3 0/3] Adjust ACPI video detection fallback path
>=20
> In kernel 6.1 the backlight registration code was overhauled so that
> at most one backlight device got registered. As part of this change
> there was code added to still allow making an acpi_video0 device if the
> BIOS contained backlight control methods but no native or vendor drivers
> registered.
>=20
> Even after the overhaul this fallback logic is failing on the BIOS from
> a number of motherboard manufacturers supporting Ryzen APUs.
> What happens is the amdgpu driver finishes registration and as expected
> doesn't create a backlight control device since no eDP panels are connect=
ed
> to a desktop.
>=20
> Then 8 seconds later the ACPI video detection code creates an
> acpi_video0 device that is non-operational. GNOME then creates a
> backlight slider.
>=20
> To avoid this situation from happening make two sets of changes:
>=20
> Prevent desktop problems w/ fallback logic
> ------------------------------------------
> 1) Add support for the video detect code to let native drivers cancel the
> fallback logic if they didn't find a panel.
>=20
> This is done this way so that if another driver decides that the ACPI
> mechanism is still needed it can instead directly call the registration
> function.
>=20
> 2) Add code to amdgpu to notify the ACPI video detection code that no pan=
el
> was detected on an APU.
>=20
> Disable fallback logic by default
> ---------------------------------
> This fallback logic was introduced to prevent regressions in the backligh=
t
> overhaul.  As it has been deemed unnecessary by Hans explicitly disable t=
he
> timeout.  If this turns out to be mistake and this part is reverted, the
> other patches for preventing desktop problems will avoid regressions on
> desktops.
>=20
> Mario Limonciello (3):
>   ACPI: video: Allow GPU drivers to report no panels
>   drm/amd/display: Report to ACPI video if no panels were found
>   ACPI: video: Don't enable fallback path for creating ACPI backlight by
>     default
>=20
>  drivers/acpi/acpi_video.c                       | 17 ++++++++++++-----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  4 ++++
>  include/acpi/video.h                            |  2 ++
>  3 files changed, 18 insertions(+), 5 deletions(-)
>=20
> --
> 2.34.1

FYI, besides me, this series also tested successfully by one of the
reporters to the Red Hat bugzilla.

https://bugzilla.redhat.com/show_bug.cgi?id=3D1783786#c8
