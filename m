Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE9383CBD
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhEQSzh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 14:55:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:31005 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234049AbhEQSzg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 17 May 2021 14:55:36 -0400
IronPort-SDR: 6T7Ya2Ls2D7AgttbvUUEvn0eieX5rqbYN0d2FUwq5AwsnAfql1UPn1mj8qHTAoZzrPoPlTdfkr
 oE4UxBRVpuvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="200592408"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="200592408"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 11:54:18 -0700
IronPort-SDR: raqvL6daLN9OwYNkcOH9KRiMwPBP8ZYFK7h4DJzHAnEpy5hMd95FYnxzuLlsA/bdSbE4nScnMR
 JtVPLtoQGRbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="404474424"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 17 May 2021 11:54:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 11:54:17 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 17 May 2021 11:54:17 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 17 May 2021 11:54:17 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 17 May 2021 11:54:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSk0lgAbzP1DwKYE7Gs6iAsU6Fc2l7UuPwcyuU9+sVpYqr49tGROgICYNE4gbBXHbpChTqb5f2HjeGqVUW0iyDBazSDkNJLnlTkoth5fIdQXestZxRssCblM7GBqiGqXJDycziG+dUabCupcnkvSJMATMBkdRDM3IA4AKY8WXq9tjozNLqY6dgZyVIwd57uY2cVyUqOeOAFwX4F73th5MowylEUcYOJd1/wiUnwN+kKCCHdz3pIfKZVYQsBhOxFFPn9RWOX5Cl34EGTi8JBk5l9EnBp53HFO+fcMpKqkTdunB+q+o0TZqHRWQhD/nwPneOmjskEEXxUbe6n76slFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGnGFvPqPg0DOGWkr6jE1HtDUDSl9XVHgRtnMdePLX0=;
 b=OBSRoyiQNKqQ8X6DzOUJVr+43fyyweblPpD3hYFCPeQywlokBktAdEq6+PTb5GP/uzg1LXynvW1WURfpN20yOOLUeCIr8jinOIG0h6EXLNWUJIGSUUYaL7JYbAdXOmbQtsZVAzYOrqaamPPfoS7lEoiY1r5+8CCBr4ZEye/f2ghNoCfuluycKkyjgZu4pPBdR4AeM99heCo+UcqjVUqvt15hbF5YbKW5Row1phJhgHE6sw596nJ7vevn33JbjvZwA2hZeA8arpqMGhWgPF0yPDOunNzxVkaTiFLFiNt8XnphOcqgV36c3XA2tJVz7oWD5qaz34N5gYEInKzRhGb9ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGnGFvPqPg0DOGWkr6jE1HtDUDSl9XVHgRtnMdePLX0=;
 b=r7w2DK4F0Kb9/n0G8PiMbi00nxNU2p8AnKXnVme7Aspwpqxa60ZwsTYe3BMGBV6phxglcqXVpj5SmhzhpMu+mkTwY/pGcDND86Vf7woCW4JHxnwuzmcLuSl0PfdrudgwGe/4ywmc21uNk3BELz4JsFEo0wVR0RpA4RIldxvoO1E=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MW3PR11MB4666.namprd11.prod.outlook.com (2603:10b6:303:56::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Mon, 17 May
 2021 18:54:12 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::48df:6af5:afe:ea7e%7]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 18:54:12 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     chenxiang <chenxiang66@hisilicon.com>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "hoan@os.amperecomputing.com" <hoan@os.amperecomputing.com>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: RE: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
Thread-Topic: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
Thread-Index: AQHXRt/M5Z1FQ9rUF0yt6Z/2QYLiFaroDZVw
Date:   Mon, 17 May 2021 18:54:12 +0000
Message-ID: <MWHPR11MB159982431E024C6212960C0CF02D9@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <1620790207-128605-1-git-send-email-chenxiang66@hisilicon.com>
In-Reply-To: <1620790207-128605-1-git-send-email-chenxiang66@hisilicon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [47.7.17.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f6197f-0a43-4897-e622-08d919652937
x-ms-traffictypediagnostic: MW3PR11MB4666:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4666FC9F95DCA4E9032ED34EF02D9@MW3PR11MB4666.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xGPXY40/0UK58dbwrkV6uoxoT3BWykI4bstQ803ZbhRPm74kFLFJaNVsAejF8iZInUi+OMD7ntrzJ1WOhYlZvJl6rHST6+Yi+ffLE8TQ/vLQxM1lTBHaeosado8c3QCyXUBwK3SplW6q3+kPuNta9+G35TeykASNsW3ihfs3spvk2E8lruKtIN2WJu5ci9FqUip7ZrWcWlZ9XvwjTM/R2ZTfgQkrlT9DZ2JhdQ7vHOl/jQHNtNw54/SMLiJJMlReTBa2yn7S5uTcFhWQIAw88K++ei6tXOQCWlUOP48dQIq0eMm3eKTyeUj95sCwQ810Ee+WglYLlE0B330texkA96pUHwODHPMzaalYl+aDSfM02f4fIFbpsfsNSQSx/U3euVENkq429XGxXjf4SuqcS3AUbb0RbGeJpEVkpS+ZnZG4F4GDLdoDnVxGGHcsxibUF/OazWQ5N9UL6lR5r5ZJuDAUPc9U8U74hfK+BYqZiAk4lxtUMZJerJ98BD3zsJbadhwHhlmN93181WX35u4CMvklLyVajDHAETF87IqOpmPAGhwadTlqYTBAErSCh6GE5nf2gxgXQfeCWY1iWVLrgEszQ1n17AnRKFNpmsH7kuk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(376002)(346002)(366004)(478600001)(54906003)(110136005)(33656002)(9686003)(8676002)(55016002)(52536014)(4326008)(86362001)(122000001)(5660300002)(186003)(66476007)(83380400001)(64756008)(38100700002)(8936002)(71200400001)(316002)(6506007)(26005)(53546011)(76116006)(66446008)(66946007)(7696005)(2906002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pvRVDRRMxcgxGC8Egn9yYkNB1akjAYogsdK5+pw1IEvPPuv4v2qBIdq0PMMQ?=
 =?us-ascii?Q?c8k80I6DYpGcrSdsOOa7CvpOMQjTtXhP6bn/A+b9YnoDOqb4GqOUant72GWX?=
 =?us-ascii?Q?sGc2vJOhb4qnZpiUaUnLv6goOsNqEvf/hUWE000uFcTLi3J0aXjtsgEMGNKQ?=
 =?us-ascii?Q?4BkVGAHgsaXNyVhSWRo+GQlACGzLIeG4qqmxnvSye8/lllqeOy4ikHxS9rRE?=
 =?us-ascii?Q?5bqJ4FCM3jfDT2gZUTwfIZ2VyVxebwuaCYgvp05h7VvhcZ2bf/ortaU+ZmWt?=
 =?us-ascii?Q?9Fe5pFYg7B129adIVCg7mc1e08pVTUP34zxnFFjoq6EsPWuAxUzoy/Zm9yZR?=
 =?us-ascii?Q?b1jcKu+V2zmHQKpfvp7vbg7z6/vpeTB7dP3u05HWae/Znz4C59YVOAILbRkm?=
 =?us-ascii?Q?ZAirYCBuTfB5q0HV/vOHJ5Ghlre/lvP0RM+TsEuVQ8sok+tZeKwUoEKgRS4E?=
 =?us-ascii?Q?pUKvRnGy1M11BfSAeCxM2IXN6aGg9eUuzlxJb+GroLco+AGewbUwCP48m1GI?=
 =?us-ascii?Q?IgfJcENm7gvTb+7/F+Y+zGcgzYS1xQfavBTG0pSf/TP7NHP/B9Hsq09DuH6n?=
 =?us-ascii?Q?3kp44xRow3auR3MB7tEuslx1wKCfR8AR9+PevYLWrwVmfbEsh3q4YhCNIBZ5?=
 =?us-ascii?Q?fnOh/+S9YKaO2Rxk7MOGJ3wnssRE1JPKpCJsdiKrYaScHDqT5FSIe3doY9Jd?=
 =?us-ascii?Q?wcEy2q/9dNzxa1iCWLNEhPVjBLEWThiW0X+79DoAaaJMJlo+90KAUVrUK6fy?=
 =?us-ascii?Q?OxzL6czh0jsQ1opm2aJ8IdWFUi1Up1R0/2WT8Yy6UllT/UJbwybXIhLQYNRM?=
 =?us-ascii?Q?sYJcaRrlrofZgC1mPIGeDsy86YmY5keb6JWaqVrxg0PbALTI61QqUkzpPo2A?=
 =?us-ascii?Q?gVIMcghkA1CoHs7TM5sGxGN8LTG0mSJGOBnT4u/spi6IBfoa1RBZowbkP0U5?=
 =?us-ascii?Q?5PJcdoIMj42HLEk85QeCENI4j5E9jS8/niF9B4MktWmwrouv/GqlyV7adp19?=
 =?us-ascii?Q?TKaZqiPXVq4U9qyAI/bcWfDTb0g/igWLt40I48GTj8jaDCDgCkYuEMfL8eA/?=
 =?us-ascii?Q?ON3jlTYCeAiGSnGXqI4s0LtsAiuW8sb5goIF0yzvXjqZYD5N/EKnpvkCfmbN?=
 =?us-ascii?Q?RpqlQ6E88r35PohhDl+nxhQQJF7tlmOlgvVj4JC6AxuBa9JIjWIu4MN4tKNw?=
 =?us-ascii?Q?bxhkslqyRtEKDIAXCXVs4WcYjiXZ/R65o9GOADd+Zw8Fn14igwM5hgvishnz?=
 =?us-ascii?Q?V8hjD2/hVagupPljTzDV3lAylkzrH1e9qL0rYPwkwHUsFGBZ+AGWP9TRfYLl?=
 =?us-ascii?Q?KjU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f6197f-0a43-4897-e622-08d919652937
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 18:54:12.2296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/WCrXVSyAfOhlV1yMiHTwZjHcVG0wESgDFQioUF9cPUEmKGvtmtKkpDQY8L7sL7lkQ8fu3f4pmf7Zrewpacnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4666
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: chenxiang <chenxiang66@hisilicon.com>
> Sent: Tuesday, May 11, 2021 8:30 PM
> To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>;
> hoan@os.amperecomputing.com; fancer.lancer@gmail.com
> Cc: linux-acpi@vger.kernel.org; linux-gpio@vger.kernel.org;
> linuxarm@huawei.com; Xiang Chen <chenxiang66@hisilicon.com>
> Subject: [PATCH] ACPICA: fix a memleak issue related to ACPI/GPIO
>=20
> From: Xiang Chen <chenxiang66@hisilicon.com>
>=20
> There is a memleak reported as follows:
>=20
> unreferenced object 0xffff00208ff85a00 (size 128):
>   comm "swapper/0", pid 1, jiffies 4294892588 (age 887.572s)
>   hex dump (first 32 bytes):
>     00 00 00 00 02 00 00 00 08 5a f8 8f 20 00 ff ff  .........Z.. ...
>     08 5a f8 8f 20 00 ff ff 00 00 00 00 00 00 00 00  .Z.. ...........
> backtrace:
>     [<00000000bc25bad8>] slab_post_alloc_hook+0x80/0x2e0
>     [<000000008d547074>] kmem_cache_alloc+0x194/0x2c0
>     [<00000000b08da9ad>] acpi_os_create_semaphore+0x3c/0x78
>     [<0000000024816c0a>] acpi_ev_install_space_handler+0x214/0x274
>     [<00000000d93a5ac2>] acpi_install_address_space_handler+0x64/0xb0
>     [<0000000098c37a45>] acpi_gpiochip_add+0x130/0x348
>     [<00000000c1cf4b42>] gpiochip_add_data_with_key+0x79c/0xdd0
>     [<000000005ce539e9>] devm_gpiochip_add_data_with_key+0x30/0x90
>     [<00000000a3038b8d>] dwapb_gpio_probe+0x3e4/0x7e8
>     [<0000000047a03eba>] platform_probe+0x68/0xe0
>     [<00000000dc15c501>] really_probe+0x17c/0x4a0
>     [<00000000aa1f123d>] driver_probe_device+0x68/0xd0
>     [<00000000d97646e0>] device_driver_attach+0x74/0x80
>     [<0000000073d5b3e5>] __driver_attach+0x8c/0xe0
>     [<00000000ff60d118>] bus_for_each_dev+0x7c/0xd8
>     [<00000000b018393d>] driver_attach+0x24/0x30
>=20
> It requires to delete the handler object in function
> acpi_remove_address_space_handler() but it just up the sem with function
> acpi_os_release_mutex(), so use acpi_os_delete_mutex() instead of
> acpi_os_release_mutex() in function
> acpi_remove_address_space_handler().
>=20
> Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
> ---
>  drivers/acpi/acpica/evxfregn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfreg=
n.c
> index b1ff0a8..4db0bec 100644
> --- a/drivers/acpi/acpica/evxfregn.c
> +++ b/drivers/acpi/acpica/evxfregn.c
> @@ -201,7 +201,7 @@ acpi_remove_address_space_handler(acpi_handle
> device,
>=20
>  			/* Now we can delete the handler object */
>=20

Hi Xiang,
=20
> -			acpi_os_release_mutex(handler_obj-
> >address_space.
> +			acpi_os_delete_mutex(handler_obj->address_space.
>  					      context_mutex);

Thanks for this suggestion! Instead of acpi_os_delete_mutex, could you try =
using acpi_ut_remove_reference instead?
I believe this will is a safer option. Please test this and see if it fixes=
 the memory leak.

Thanks,
Erik

>  			acpi_ut_remove_reference(handler_obj);
>  			goto unlock_and_exit;
> --
> 2.8.1

