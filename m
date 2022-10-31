Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1958614028
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Oct 2022 22:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiJaVwA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Oct 2022 17:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaVv7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 31 Oct 2022 17:51:59 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AB610FD3;
        Mon, 31 Oct 2022 14:51:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYtex55BK2ubrlHEnqxrlI4/DqUTjVZbSC7IMhhrYMSOW1nq0xdJDNqpilz3bUcBTqZKmF5zQDS8auhjrfvT9t33UQKZXvRpHDm6fsc3ZFS5NKKEIXwYg5AXojJFOXRtE8Nd0XPSxTDG2gTnLf5hjekWJJDQIhCiWDOfdUkIqIiZUzjsWrlzRM5YDS+j4rANhDbxKkZNsgw5T+cSwOSA217swYRmykvagQEidxHFuMMwQlWXRfrqZD9R/15h5NI03n00Chh9PqSIRbRCyp7hls0Y4cIVpV/tsablDbGQd5xb0Luk1XyvTX/Lh/naaDDlfWZkaytFc8+ACNCqCtp0OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ureep4TDDdDF3PoSot1pX5qFfCMiVzXhgATOm823Tg=;
 b=U3YS3j3VtCaDpUMuV3KBVQmy9hyXXkZ8HL4MxG8JMeYoY0689RGZHjIe4HA/dmrlxw1GxIkD9H5Cw7a9hqOidC23nIVfd3hJDbiAzVZ0gH7N1nhXKZVY/Mn0qoMdqZ4WR3r/jx6Vg9GXUZDDm1mKvpQne847Pgc4udKerwfqQ6pBN0dh14xQwvs7jDxDWUITmidpfvtufY/naO7c0dfwUXxM4Xg6A6WiqrffyVgoqXtnUK6rCQohvEKhX1PJHV0W7tfRyWJc/ivEwvC1dFrQxu67tjA64RnUQoTODwElfJfVsP3gQq4dZOunzxEW63Mjc9sjKD9BRIez0anISOJtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ureep4TDDdDF3PoSot1pX5qFfCMiVzXhgATOm823Tg=;
 b=Cyql5TBEiVftXtNggrYOuM7Dm+3ny9JvjDCGgVbO10yRRRsebXFCVD8klvuz5JshdtUKEaptsFwnWCMqkPjodcYGhB0Jw1uDwFMKh9TGxkx8hyV3fUKgy1HHReH/xKGtiwLbLS6zCl8aqGNsQk61XntLGqCGaz2CQEuRrDVEjJo=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7666.namprd12.prod.outlook.com (2603:10b6:610:152::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 21:51:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f8c0:db03:2d30:792c%3]) with mapi id 15.20.5769.016; Mon, 31 Oct 2022
 21:51:56 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Dadap <ddadap@nvidia.com>
CC:     Len Brown <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Thread-Topic: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell G15
 5515
Thread-Index: AQHY7W+EsPpR43M85k6TtXj7ov7Zla4pCrLA
Date:   Mon, 31 Oct 2022 21:51:55 +0000
Message-ID: <MN0PR12MB6101C2BD5FAEC45B51B61667E2379@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20221031212556.401618-1-hdegoede@redhat.com>
In-Reply-To: <20221031212556.401618-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-10-31T21:50:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9b4e9d76-feca-4b61-9844-b9bdaa58c298;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-10-31T21:51:54Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 44ba9e2c-b95d-44ca-b7c5-7c8747207292
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6101:EE_|CH3PR12MB7666:EE_
x-ms-office365-filtering-correlation-id: 29393747-97a7-473c-a312-08dabb8a210a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EASheHFBk8nB52XTR8jUsX/wiwGur7q2nqMgyPERqfwprRIFdP97m4y5F6k+bLuCrtfJFhVaQnLIzyXN7zWr6bibqs1ynPXTsPoNOk90UtAvps1kq62Xexw/WKg7s3sOPnvWtrbhu9y1x2+TzZPGjjL4zVhipgHcDu0wjMyvYrZaiXt2W825I7+U/k4T6ieuthYw9V+oCQRi0yTGN+XKL9SJ8geI4Cccp8YvW0HujFvdf+54eCmAMT9d5VrC5hdABGbuW7JJY6rgFb04Kr0tIKBkqHpFhw+PF0Ro710IUQs6uFoDWgVWuYEDc+83BGLdLfoSMzBR0WQgl90t7uvWE1gUDCpiDPNuRXmUWYN6U1GQmrVfCRI304NJIPwtMvSuW6WqEin7gFQ4q3gbJo5kpJedeS2KYU5cJz4ZCi2D23vYwvyTOIamQQx2l7q4M/jR6E9sCacm0JpWTk+a8CFdnT2oc5b6yK60w8lev4Jd26po8I1GhqvU2KVcXNmWWfzhM0UUOfeuqPByrqIgzx+qMU+rZs2oAQHY6apPM6dvmDdRn1UxEFJnG8TK9obZZ1aAY1x2PYd+YcyFxJDr9MbbrQN3TX2Gf2eN9wINHR54l629Y4sKfvXsUMdCWGHTEtWo5K7evrR7bk5MFuhkWZu4FKSGopeqNqsGgGvrLXLqGSWpd9N0ie12XBcOPQw982XizRCmLzDIqr9F6UAav/gnwBe6OprL5IFVrgRy7IdcmCrFsI8j0REq2738m/yiG6wWBj4i1IQ0CLMLi4UgEGoXYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199015)(9686003)(6506007)(55016003)(7696005)(478600001)(186003)(53546011)(2906002)(83380400001)(110136005)(76116006)(316002)(66446008)(54906003)(52536014)(66556008)(5660300002)(4326008)(8936002)(41300700001)(66946007)(64756008)(66476007)(8676002)(71200400001)(86362001)(38100700002)(122000001)(33656002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YTCoYZLt2HuQtaDkxnr5B/FsA4RTRABZoiDaWsD6uyvlXvtFe0MdgLF1u1a3?=
 =?us-ascii?Q?/onr5evqbjIoPi8F1o7sGK/QI/yICFQTIowhQfSJiwwcurU8KXvwMxIMWX1x?=
 =?us-ascii?Q?yhoBdR5UVXi34ZDwd/Extr3Ni/BNaxYY854HzGwJLvSpswR4oUL8yq+SLqNT?=
 =?us-ascii?Q?74eVBtTXXb/rWfgO7VHf8ZgVL6G5vONteOAGsOw+3vYlreLoqZOkLvMxomMt?=
 =?us-ascii?Q?IBagih4oGtUF+7cKGcvgOfAfcWuGkIQxz8AX7ovMP2LWlk0XjheBX2zd6mKA?=
 =?us-ascii?Q?PhIgg7g+Adriq0UBaWxv7iXydYAdw4vacGL7pfa8vQZW3/dE2V3qOu3noXC5?=
 =?us-ascii?Q?UKsMR/ZriS7eZVt80KchfVdwnekUy2dBZrGzOPEea7+3iAwthSUiyjtAJnce?=
 =?us-ascii?Q?5vLypyJEMLBBmP8VLQuw2AiIZspbrepKE/wwOYzGembHXnlTP7ev8kCsk4cr?=
 =?us-ascii?Q?C9oI/Fh7lqzr/Nh27VDWj/9gos6aBDctiiG3UGuSwW1ReHYwENsG3iSwACqY?=
 =?us-ascii?Q?y8RCydc9TPWgXMxHBiICV2tHAQ2FeJKcGV5HGi94kJsFdpYH8H9L0b4lAINw?=
 =?us-ascii?Q?L8BQVhu7TqS8JhDXRzsBKf8yYfmWvZWuYTj4enjoEZouMLBfmQO0CZs/QQCc?=
 =?us-ascii?Q?93Yr/XrXQQ4T73Z1kOapF4W180Us1ak9N2zXwy/z4dij74PLGjgWhzwy89an?=
 =?us-ascii?Q?A0KPqrc36RXjEBnBoZCDCNAMteCqpPXGA+cxkNWA9dekBpvmE4gRCxDDGkM4?=
 =?us-ascii?Q?+rF7L5QExz/jg6jtm2jsYisVVeIJPtS6ronaHclESrCbAm28CXmGB7JPdoRd?=
 =?us-ascii?Q?tZZBZkPw7dsKw1zmODKQVNDKE/BU8iH2BnVhUuRhuGAfIQeet3v1U033FYf4?=
 =?us-ascii?Q?zuLm6adlOUmPrte6ud1foNxoOvm9peAQOaMTrxoCXjvYllSMyHBEQupjafet?=
 =?us-ascii?Q?YQJEVuEk+aq7EuIodu9lkbfNzmoKjUTYkQsYPzA7mdMXWqhXS2/4XfP1ocS1?=
 =?us-ascii?Q?07cpexPcrXQFHAlvPnNjw3Flqa20agwCHMZr9/sZErqVF5kz7DJG2EEc5DFv?=
 =?us-ascii?Q?ZBtbu0+7zQQOxJr6hJ0sLSG0gfUrgyHxa7LYtP1Z3Wz5DoU4sFhh4EWwlqli?=
 =?us-ascii?Q?8L52MPtQsYDn7ZAJnZ3w36ZBNR0Kb+XslTnQjIJQpjkOzmsVHQV2KQFvu4hV?=
 =?us-ascii?Q?RhB669VwYHGf6xKej48qu03hsYdXWX7G0+4j86hsUuIfb/q5ygvXVJHql+qC?=
 =?us-ascii?Q?shQnWAvoKjkCpam/afKGdot7To1KkPFi8LPSQdTTGDKukBT3yRCeCfDmW46G?=
 =?us-ascii?Q?+MPZKYF12ZcU8LDJQ4FLA7wg78qh9a3tvgtkc0rApOam3jep9NDBFymG+q+i?=
 =?us-ascii?Q?m/MaizBys41cDkUqOFCmHobXtvAtZ1jw16NbVALsOTKj/CPmr7c1bZl+OBjq?=
 =?us-ascii?Q?TRnApgDtxBh018kP9vYHeGdU7prYI2KpuyBM9ojltsdn6WGsBAO23JJU3V4/?=
 =?us-ascii?Q?Vvl+RFmXkuDzXOscprnNkJOrdyYpEcR+iMgk98D9DU4rUJwTol7+hMcpeRos?=
 =?us-ascii?Q?Si1t2ijVE8f69CJfRjy0JVC8DHMve8QVASkJ77jeEKK/gAQ2aUe2BH0alq7n?=
 =?us-ascii?Q?kwew/igFXDXM4mZ5AgsE7i4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29393747-97a7-473c-a312-08dabb8a210a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 21:51:55.9947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oMsUp224rxDKhfID2KNtAoQGC8HHoT5lki2NCiPV2DPXBBUVnyOvtuabdAmHgqyNreyqJe5M5O3OgUnIZQCVjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7666
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
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Monday, October 31, 2022 16:26
> To: Rafael J . Wysocki <rafael@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>; Len Brown
> <lenb@kernel.org>; linux-acpi@vger.kernel.org; platform-driver-
> x86@vger.kernel.org; Daniel Dadap <ddadap@nvidia.com>
> Subject: [PATCH] ACPI: video: Add backlight=3Dnative DMI quirk for Dell G=
15
> 5515
>=20
> The Dell G15 5515 has the WMI interface (and WMI call returns) expected
> by the nvidia-wmi-ec-backlight interface. But the backlight class device
> registered by the nvidia-wmi-ec-backlight driver does not actually work.
>=20

Is there a way to detect this from nvidia-wmi-ec-backlight?  I would think =
it's
cleaner to have that driver return -ENODEV so you end up with just the "wor=
king"
amdgpu_bl0.

> The amdgpu_bl0 native GPU backlight class device does actually work,
> add a backlight=3Dnative DMI quirk for this.
>=20
> Cc: Daniel Dadap <ddadap@nvidia.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 841f6213b4de..88acc09773bb 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -645,6 +645,16 @@ static const struct dmi_system_id
> video_detect_dmi_table[] =3D {
>  		},
>  	},
>=20
> +	/* Models which have nvidia-ec-wmi support, but should not use it.
> */
> +	{
> +	 .callback =3D video_detect_force_native,
> +	 /* Dell G15 5515 */
> +	 .matches =3D {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "Dell G15 5515"),
> +		},
> +	},
> +
>  	/*
>  	 * Desktops which falsely report a backlight and which our heuristics
>  	 * for this do not catch.
> --
> 2.37.3
