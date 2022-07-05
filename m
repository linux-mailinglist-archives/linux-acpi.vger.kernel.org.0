Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26FE567636
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jul 2022 20:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiGESLC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jul 2022 14:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiGESLB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jul 2022 14:11:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592721C120
        for <linux-acpi@vger.kernel.org>; Tue,  5 Jul 2022 11:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdcDCuo5jmoahdfnH2XgC4Mmh15fXc51v1pgomSM+dF/VcvjpYC0E2sYpne48VEWIG5lZ1kcCsMAYW4UhI6EzAk6GRek06gevu+tMxYUAStZ54jnKlwPK41hnhNc9UwukdInbQNGibFqvN4B+LpJNJtGdvC0R/GJhNQJ5rJFKxoTrdz21yOSwInsIfss5IHeYvF6qXm8av7ignT3ww9p4pxMlqrMrsTHSwNEyvSqWXJSKWl6B9+RaxpmkaOALPMnOHCP+hGMkONxm9vzDp1Sd5Wu0ohvWL40ORzfF5o7nHHLWuf2YDHHfknlitRToSzQz46gyDlZThtchex+3PltDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWjw+Ov6GkWLrv6xpCubuoAuGFpyWYKe5cNXpO95SX8=;
 b=DlNH26ZMV0tkqHLPikWHXJs+Hp4b0dRijtPqGX3pKCJgIg0hx2LZr2j4h3W7LT05iWyVeEDiQ5OlrJtUvSyDyreeKpBdt7II1qNV3RN2pR9vEPKfRVSFHBB/juLf0top51YobGwLEJcy/0OEVWteFxF8OKEpTI93zpF282W/qFd8qXLiD62JF+maew7LTRZ+BuuqVppexvW2o5uP/iZ04wZLkHAP1kXmYd5sH6NpMp/wudvON+dkHD9Hby+rk3IdlaUb5e78dCiU5bIHozddo3OT7JjdKHhnwKFaATbZkP4DKAZQNnI43NchS82cFZM8/Fcqo0vb3fildELDZL0b0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWjw+Ov6GkWLrv6xpCubuoAuGFpyWYKe5cNXpO95SX8=;
 b=rkmmJpg3d1WYdFgbmms589HyzW8acjMxfI2j7Jt/eb26Xzd3OXEl7eGQCTJzyU7PMGPyOwibRyYNiUo2OBt3MwuCHdbU+1Bn5ZTfYvz1URr7zKQcVBpymgWezM7zm0B1JCVtl8JbpAepxBe90L+WMC9R5y6ojanGXKw01uRhDcQ=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM5PR12MB2408.namprd12.prod.outlook.com (2603:10b6:4:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 18:10:55 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::1143:10a5:987a:7598%5]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 18:10:55 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "nakato@nakato.io" <nakato@nakato.io>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: RE: [PATCH] ACPI: PM: s2idle: Add support for upcoming AMD uPEP HID
 AMDI008
Thread-Topic: [PATCH] ACPI: PM: s2idle: Add support for upcoming AMD uPEP HID
 AMDI008
Thread-Index: AQHYj1lXVaezcIA/0E21ndKtYWZs3K1wFkug
Date:   Tue, 5 Jul 2022 18:10:55 +0000
Message-ID: <MN0PR12MB6101A62066E69552B893BA7BE2819@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220704035017.54513-1-Shyam-sundar.S-k@amd.com>
In-Reply-To: <20220704035017.54513-1-Shyam-sundar.S-k@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-07-05T18:10:25Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d5f91f6b-94cc-4ce8-9293-42cc5e7c9a29;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-07-05T18:10:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 2af5f8f4-7407-4d85-af19-6704840b7ff0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f36e8ce-307d-45a0-37ee-08da5eb1b483
x-ms-traffictypediagnostic: DM5PR12MB2408:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WpRI6W7sKbp+47dL7ae2hGzMA+0v6ShgUZVJd6iTcN3BrNVKYjX8j1z4hdxHcGd8UCVdj+vZpMG9Ay7uFNM5jPdGtoTfT01DpWKykVkjOOqTlBBbxVQr0FRDSfSjfYfBYUgTmwEIc2bCVXb3T4C7TjLAqzSDCkFNk8PIjyLORtOmhtrV3+6ioVsRGIjI2nKHDC4Iboli6+O7tUkpWkXi7e8UcH6kxLmTllRpUGAh2l72GNFeempaDKBt2bbklHsVcbYKUcI/oSGl9ysNiblvIi0tH2DBjczGEzRtscXxFGSsZRZC/xxz2Bu1it3X4hBHCiRF2howNFuzD33wM9dbZdJZBHPXnwWmOUQOyMJhUFUUA77qiZyOLpTLhAJqyrgs4pRvLW+gDYwvuyPSnp2DmgEiHKi/5NwIaY0+m1k9a7nwjYWaCgGHOf8XXSBTB2fWJqCcVlTtFGySsfV6khkqrLXiqExZMVdxOLwcLeA9ct1LP+rEEwGLmzoliOZlTDM/xSn/xF3YX4987hW4Gdt+6nwDpeWuk2OFQ9RLiBwFII7TosSEKoH44jvuSRZquXXy8IIHEddIFGW8MmogwVQQP+/V8tkjgzlBL8k2rw55x6XFsfJfnOqS0piBiiLfZnti4nUz8fh+hYRLNqSrrxK6pztJHtavD3E9uxz81lpeORvj9o9bbtPdD8hdh+FMUY16d6FjW43ZnF8xAeGsl+0ym0OqYTHCetIzHSKw+QOFG7KpRcFlZ6dAUKdwo8/GJpjAPftlXUj7PbLtlNtc2KJGqIHD47LxRJ5d08tgMYO+beQO9V7uP7cM6Lzp67xM3S17
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(8936002)(186003)(5660300002)(71200400001)(52536014)(86362001)(55016003)(83380400001)(478600001)(26005)(110136005)(316002)(2906002)(9686003)(122000001)(8676002)(53546011)(76116006)(66446008)(66556008)(66946007)(66476007)(64756008)(4326008)(33656002)(38100700002)(45080400002)(38070700005)(6506007)(7696005)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sa7lDzdlnmY6+cK3ndwc6lxEXbWLqJb+7F0fmaARg8It68w42Jd2kgmHf+P/?=
 =?us-ascii?Q?mrTXjOlyT+EnLO/UhVGDAcXL01yufOUbhKbG1NUIl4i1IYRiPg0jNxLOa2Lh?=
 =?us-ascii?Q?pdt2sjdIYtUp2FT5qR6HCbzxkYcTBXfvuJ2yrvAZ+iYv2LB9ooD6Dp46XWDb?=
 =?us-ascii?Q?DZC8R38GrB4FeMcOh4RGgq4Wn0rfhcuSqRwj5Xu6gWffS4SU/vMRCzOu9oCe?=
 =?us-ascii?Q?DLnhik8uu0cSBOybGeFcv5B8J3teKOvoPBIISuK/ORoVi+hk9tbnHXnKEmV0?=
 =?us-ascii?Q?pai11Atq6OFHbFfQP7bOWBSjYRWpXxJKTVWSDuCESnUJwXfK/ZvH07StbL4y?=
 =?us-ascii?Q?qArbtzqU71VXbQm1JRRfCH/061uo3KGBCtZhivrNgWuvPKOcA1SuhDap8G62?=
 =?us-ascii?Q?Tv0umQ9VSbNBRWon4uhikeGwBj3lEPDG6qiXt7yzZ6ddD7cpvnZ248l5vGaJ?=
 =?us-ascii?Q?WJzFv/UTm69Ken7Fj6l6jPc2ejtrq65z479mlxNZ0PzGkoujCQ1ZnEuKfS56?=
 =?us-ascii?Q?yLIQpx6gMCF2JJ3xhCu1tEWiUCKoEeXw+UXzoNi/flkGPslsnDCaocJXWfne?=
 =?us-ascii?Q?QJKbFK/JYqsgT2guNoso1zVFXBS/49DLL8fyZMVqeyq4a9HIbCIFNNTPPGb+?=
 =?us-ascii?Q?uHqYwcdmK7RyeDdf+5CEXAEYI3gIfTqt0Us7J5UGGKLofkm9Yy4ZU3Awd7fn?=
 =?us-ascii?Q?szf/0dHFAjPvJVn8YWI9lrL0fWRoIixwP4IsR6G2HTe3V9U/Doc4131r2LzB?=
 =?us-ascii?Q?p10cOOhXocEmdbqsQ25KiL1KjNX1CRauBxwno7CvWK9A4HXSfg8pf9Q5CxNh?=
 =?us-ascii?Q?TJQipk8LXAcyApbIWoDLYxLMh//kheXcE8Tw1txOkgjJLi0SH0hAYSZQTbse?=
 =?us-ascii?Q?fbv7bJHCyty0hiuxIBZWaykumrL6tiPKerAXZZGFxPoMx8KbnuexBgvsCSrW?=
 =?us-ascii?Q?k0fFWXM0yA2kv3eA1E4EadVPv4hk3AbwXOK9snpnsbmPIwdZueohdgrbgo+T?=
 =?us-ascii?Q?EcFJjQ7kmNEBsmkbY03WE2enO3ZaYJUXX9kP/vAz69TuecuTD3YpAaSL//Ns?=
 =?us-ascii?Q?hZ9m51euPv7FRpi4rulUBiutAKxx9duFXmSWR2V/Ip4qVkL4jNK6Wyaw3mlc?=
 =?us-ascii?Q?4UFm+tOEN2L9u8owCOs6sQDJf4CaphKF4h2BTZESfUEQFoekdSuz0xgmZv1a?=
 =?us-ascii?Q?TuagBrPJHL9bgc9bVVC98VEb+3CZ8LDcNqrDb3XsX91H/b52e4lCltIPh8dk?=
 =?us-ascii?Q?LAxsWMSrIUPd0DyKLcpkwJbs+vklndh/oSmF7/vTNNZe7C8EjB3/6XpILSl6?=
 =?us-ascii?Q?paAnPYuedCUwalTsaGrIiOdw5VKAYYnlsr1vjOl7x6md7D0Re4ph4WSPi8RU?=
 =?us-ascii?Q?vRCd4MvhkVcLP2OFS7KDlku92bbKOanh8oe3In5gZlGGdcbVeI4zGp2nkNPi?=
 =?us-ascii?Q?ozx6jyM65KEEG9uscBDhWzYNmcEjnx9tkvdW26I9k4b1EAyhNX2PC3xjZwqE?=
 =?us-ascii?Q?e9Khd921qSBcHxV6S5WFZRlHifplydw0jNSrWmSh407JGir2fntVXrBItMX6?=
 =?us-ascii?Q?QCpy+euXZ+3sp59acZQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f36e8ce-307d-45a0-37ee-08da5eb1b483
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 18:10:55.6598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zdfwMyppI8+WmD42KcBS+DaRq+HneSQxj3gKCm4ytpSkCHZDiiBF2HEp4STkqDbv2q/Wkpa6Ec7Tqe3K8GVDjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2408
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

[Public]

> -----Original Message-----
> From: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> Sent: Sunday, July 3, 2022 22:50
> To: rafael@kernel.org; lenb@kernel.org; Limonciello, Mario
> <Mario.Limonciello@amd.com>; hdegoede@redhat.com;
> nakato@nakato.io; mika.westerberg@linux.intel.com
> Cc: linux-acpi@vger.kernel.org; S-k, Shyam-sundar <Shyam-sundar.S-
> k@amd.com>
> Subject: [PATCH] ACPI: PM: s2idle: Add support for upcoming AMD uPEP HID
> AMDI008
>=20
> New version of uPEP will have a separate ACPI id, add that
> to the support list.
>=20
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>  drivers/acpi/x86/s2idle.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 2963229062f8..392f75157f34 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -397,7 +397,9 @@ static int lps0_device_attach(struct acpi_device
> *adev,
>  			lps0_dsm_func_mask =3D (lps0_dsm_func_mask << 1)
> | 0x1;
>  			acpi_handle_debug(adev->handle, "_DSM UUID %s:
> Adjusted function mask: 0x%x\n",
>  					  ACPI_LPS0_DSM_UUID_AMD,
> lps0_dsm_func_mask);
> -		} else if (lps0_dsm_func_mask_microsoft > 0 && !strcmp(hid,
> "AMDI0007")) {
> +		} else if (lps0_dsm_func_mask_microsoft > 0 &&
> +				(!strcmp(hid, "AMDI0007") ||
> +				 !strcmp(hid, "AMDI0008"))) {
>  			lps0_dsm_func_mask_microsoft =3D -EINVAL;
>  			acpi_handle_debug(adev->handle, "_DSM Using
> AMD method\n");
>  		}
> --
> 2.25.1
