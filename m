Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F98299844
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Oct 2020 21:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgJZU4D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Oct 2020 16:56:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:55855 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728412AbgJZU4C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 16:56:02 -0400
IronPort-SDR: 5WbohPgj7g9dS8iFiFFcSmcyX3VYU+ceeA7OAIZEZgetr/EcPN1PxqAPc/H/x0kSRHHW6eC/iu
 q33mjlF0Yo8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="155765986"
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="155765986"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 13:56:00 -0700
IronPort-SDR: kbh/nnbh86vM2veKnEgCepW+V2iddn7cP0Eqe1k0TdLjvWFYNmnBE5FhCKJr/xOHSaPYmr11Q6
 EizA77Yihmbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,421,1596524400"; 
   d="scan'208";a="322676842"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 26 Oct 2020 13:56:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 26 Oct 2020 13:55:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 26 Oct 2020 13:55:59 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 26 Oct 2020 13:55:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlDZ0Q3JMOyRgu/+PyaQtIkyqyLPqbj4SwWVBJVr9xt521CfYMRx78O4nBTZ9hqnBABuOx6QvweJwE4oRXH2VDY4GzTJloT+PpBpFvTilRwvf2fqA+Q7BMYZOlV5jh/2UVQt/fgqY1rErxlTXEBR7f3zm6kqPtNzf3Kcv0TQSC+TXTlrF+klPY5sHVWLwob9ehEEhxf0YZHPd3FokwvNEAjddjwaupJQLJpKtfO7pjvzu/2ohrYUjGkzSPWEHgASwTP6aQ7EyCWoMcmKKxZYG8a7b/ofUA/+fDmeMY2ANGLcLk7aKu1YroDoL8U73RBkS9lgfelqaAQGHOpFQNwTJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N09JSxelhda6C7ZQu2BE00s5Apu3wEy4bTx6DzTSleo=;
 b=Z0wLYwxM8ERy/z407Zz8NEARN+qlGN7UNEGlrDgycG0ySbsni4jjCU/g/ma0NOZXeW+rmOoAnpWLfJ5JsVjvGBDPvxEfLzxmlmewvByzOVI/qkQHS/CaedpFErqQiKkYp3YNVsj4a5wdu3j9BvNke+7+JNE6jKUPXJyV9bcOLEbvxaKOAABmDF4ABwpBu8Bwnz3XGKZ3yORvcF3Bh1nE00gomKGK9XqnVZejiFqlOnWAvwvyLh66vBDA2QJ+tIwL3jt4if4h8EUtWMHVHxzP1t2NCJAVu42p2Ygv8A5u5qipumUQc2U9CRU7BLyKokcJXgVxAphZgBMsJw0bnCykow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N09JSxelhda6C7ZQu2BE00s5Apu3wEy4bTx6DzTSleo=;
 b=TLZYz4WUbxpbQQcC4AACV1MBVouUwBPTKCXWqDRrkziN8NRSPowG9y4xiS8SAYZwmuxSJ9hzFeVxn0mqvb7sreVddnkVsqqvdNhGYtvSn5SPF1VjqkmQamAxcAzDALn2pf9rtYtKkJ9Ln4KNDXI2CAcJ1cpdwOK0iFEWWRrk5is=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by MWHPR1101MB2160.namprd11.prod.outlook.com (2603:10b6:301:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Mon, 26 Oct
 2020 20:55:58 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31%10]) with mapi id 15.20.3477.028; Mon, 26 Oct
 2020 20:55:58 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Topic: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Index: AQHWqrOnbaxVkidVN0K4VBzXKS8YhamqXyUg
Date:   Mon, 26 Oct 2020 20:55:57 +0000
Message-ID: <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201025094542.3669-1-hdegoede@redhat.com>
In-Reply-To: <20201025094542.3669-1-hdegoede@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.45.176.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14c5a611-f707-4752-beea-08d879f189ed
x-ms-traffictypediagnostic: MWHPR1101MB2160:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB216052FBC92E583167A244E8F0190@MWHPR1101MB2160.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QoJD3sFN9D6ImFJUnMANoVAyrsgPGQHxKhZeObO9dfj7tbY3i8Wf3hasQ8j8g6o8XMwKBEp9n00gNBh7QMORVQrvywvOOPFB39z1D/a+zXfLvjOF1tBiGJgc2cZI6IuKezc0NIBkhpSTynNerze0BqjXAgPsPsV+ZKoulzV2ISXMJbgssMMHxT/fPBxbzHDDg8cLwJGqzjZBbiRFfROHiZyzv0w1jvm3qh2U1F8V9fIu+6YesVXWFlpxTe4jmB97XuzPz1MT8he80njv89/SEjHUoE0699pQUBOhcuX/NvZfO9DMnGQ2+GQYtC7i+ymEPoX3z9ephMPojLfUGeTzPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(8676002)(9686003)(83380400001)(6506007)(7696005)(26005)(4326008)(186003)(54906003)(53546011)(6636002)(478600001)(110136005)(66946007)(316002)(33656002)(86362001)(8936002)(2906002)(71200400001)(55016002)(76116006)(64756008)(52536014)(5660300002)(66476007)(66556008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JmSI1n7wVsCK4PUpU+eagWuDtNUDKBwtd6yIvtUJd4L4Yt9Oq/+rf+BlEEHkMUCJkAQq6qees6gd11jvLHT2zofcC2SOH8/aGy5zJUPcgpTYpMMCh7AsfNQQdiAQ/Zz9gNhRrV/i4j6cpMiG0QuCxQ+dA6XuuE1MNYvoY/8l1jVV3N4hbJzC0yDH5ETzaFqjTGk92Ixl43GNwvsJpQFbpzWrzhnV53a0HmZknxWW7A6Yjq5gH9m5zA39WAsceuEfqKe3ms5R8NA3ltODOByhjgZNkx4JVNLbWbvfFGbXddFeSZvZ1QeREMTxlz54wB2QzTu7U/4Dsjh+ECFfC8JyUfK7+l6c0xdfX09kgjBO4b+U/ID5XTc0ngzOWbR6qqcoqMvKWFJZqsU+/6ecPvHHbYqSoro+jTehbrAls1Qq3tkD/qEVFchr9hIFxxE+ovdV646bju8ywJ2MXibU927nZd4mdXd+tLZsWFvO5XoJ9vOW5a/nAp1zKDk+n1s22q6qztYIcoSP6hs02tg/LstTa9p59ecNHbA7NRkYZN9Dho7z+3n3mmFhQa+Rca0Zqew//B6U4QH5iEys1cl8UiyW8MTscz4lAf+QLt3Mbhfg+XhSnkxuMFdEUJbocyKX0C+xUuFpqtzzy62gDbNxkDHkJA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c5a611-f707-4752-beea-08d879f189ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 20:55:57.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gIVRgE/BDSEMr3Iy1w9IjxP82Tcg6w0m4FaZMRGCUkcoK2JSX41mFqKK3ND7dYaJwCMGnP2XZA24T2LWavZunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2160
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Sunday, October 25, 2020 2:46 AM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
> Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> <erik.kaneda@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
> devel@acpica.org
> Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
> OpRegions
>=20
> Before this commit acpi_ev_execute_reg_methods() had special handling
> to handle "orphan" (no matching OpRegion declared) _REG methods for EC
> nodes.
>=20
> On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for
> accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry
> Trail specific UserDefined 0x9X OpRegions.
>=20
> Having 2 different types of OpRegions leads to potential issues with
> checks for OpRegion availability, or in other words checks if _REG has
> been called for the OpRegion which the ACPI code wants to use.
>=20
> Except for the "orphan" EC handling, ACPICA core does not call _REG on
> an ACPI node which does not define an OpRegion matching the type being
> registered; and the reference design DSDT, from which most Cherry Trail
> DSDTs are derived, does not define GeneralPurposeIo, nor
> UserDefined(0x93)
> OpRegions for the GPO2 (UID 3) device, because no pins were assigned ACPI
> controlled functions in the reference design.
>=20
> Together this leads to the perfect storm, at least on the Cherry Trail
> based Medion Akayo E1239T. This design does use a GPO2 pin from its ACPI
> code and has added the Cherry Trail specific UserDefined(0x93) opregion
> to its GPO2 ACPI node to access this pin.
>=20
> But it uses a has _REG been called availability check for the standard
> GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this
> does work under Windows. This issue leads to the intel_vbtn driver
> reporting the device always being in tablet-mode at boot, even if it
> is in laptop mode. Which in turn causes userspace to ignore touchpad
> events. So iow this issues causes the touchpad to not work at boot.
>=20
> This commit fixes this by extending the "orphan" _REG method handling
> to also apply to GPIO address-space handlers.
>=20
> Note it seems that Windows always calls "orphan" _REG methods so me
> may want to consider dropping the space-id check and always do
> "orphan" _REG method handling.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/evregion.c | 54 +++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregio=
n.c
> index 738d4b231f34..21ff341e34a4 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
>  /* Local prototypes */
>=20
>  static void
> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
> *ec_device_node);
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> *device_node,
> +				  acpi_adr_space_type space_id);
>=20
>  static acpi_status
>  acpi_ev_reg_run(acpi_handle obj_handle,
> @@ -684,10 +685,12 @@ acpi_ev_execute_reg_methods(struct
> acpi_namespace_node *node,
>  				     ACPI_NS_WALK_UNLOCK,
> acpi_ev_reg_run, NULL,
>  				     &info, NULL);
>=20
> -	/* Special case for EC: handle "orphan" _REG methods with no region
> */
> -
> -	if (space_id =3D=3D ACPI_ADR_SPACE_EC) {
> -		acpi_ev_orphan_ec_reg_method(node);
> +	/*
> +	 * Special case for EC and GPIO: handle "orphan" _REG methods with
> +	 * no region.
> +	 */
> +	if (space_id =3D=3D ACPI_ADR_SPACE_EC || space_id =3D=3D
> ACPI_ADR_SPACE_GPIO) {
> +		acpi_ev_execute_orphan_reg_method(node, space_id);
>  	}
>=20
>  	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
> @@ -760,31 +763,28 @@ acpi_ev_reg_run(acpi_handle obj_handle,
>=20
>=20
> /**********************************************************
> *********************
>   *
> - * FUNCTION:    acpi_ev_orphan_ec_reg_method
> + * FUNCTION:    acpi_ev_execute_orphan_reg_method
>   *
> - * PARAMETERS:  ec_device_node      - Namespace node for an EC device
> + * PARAMETERS:  device_node     - Namespace node for an ACPI device
> + *              space_id        - The address space ID
>   *
>   * RETURN:      None
>   *
> - * DESCRIPTION: Execute an "orphan" _REG method that appears under the
> EC
> + * DESCRIPTION: Execute an "orphan" _REG method that appears under an
> ACPI
>   *              device. This is a _REG method that has no corresponding =
region
> - *              within the EC device scope. The orphan _REG method appea=
rs to
> - *              have been enabled by the description of the ECDT in the =
ACPI
> - *              specification: "The availability of the region space can=
 be
> - *              detected by providing a _REG method object underneath th=
e
> - *              Embedded Controller device."
> - *
> - *              To quickly access the EC device, we use the ec_device_no=
de used
> - *              during EC handler installation. Otherwise, we would need=
 to
> - *              perform a time consuming namespace walk, executing _HID
> - *              methods to find the EC device.
> + *              within the device's scope. ACPI tables depending on thes=
e
> + *              "orphan" _REG methods have been seen for both EC and GPI=
O
> + *              Operation Regions. Presumably the Windows ACPI implement=
ation
> + *              always calls the _REG method independent of the presence=
 of
> + *              an actual Operation Region with the correct address spac=
e ID.
>   *
>   *  MUTEX:      Assumes the namespace is locked
>   *
>=20
> **********************************************************
> ********************/
>=20
>  static void
> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
> *ec_device_node)
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> *device_node,
> +				  acpi_adr_space_type space_id)
>  {
>  	acpi_handle reg_method;
>  	struct acpi_namespace_node *next_node;
> @@ -792,9 +792,9 @@ acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
>  	struct acpi_object_list args;
>  	union acpi_object objects[2];
>=20
> -	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
> +	ACPI_FUNCTION_TRACE(ev_execute_orphan_reg_method);
>=20
> -	if (!ec_device_node) {
> +	if (!device_node) {
>  		return_VOID;
>  	}
>=20
> @@ -804,7 +804,7 @@ acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
>=20
>  	/* Get a handle to a _REG method immediately under the EC device
> */
>=20
> -	status =3D acpi_get_handle(ec_device_node, METHOD_NAME__REG,
> &reg_method);
> +	status =3D acpi_get_handle(device_node, METHOD_NAME__REG,
> &reg_method);
>  	if (ACPI_FAILURE(status)) {
>  		goto exit;	/* There is no _REG method present */
>  	}
> @@ -816,23 +816,23 @@ acpi_ev_orphan_ec_reg_method(struct
> acpi_namespace_node *ec_device_node)
>  	 * with other space IDs to be present; but the code below will then
>  	 * execute the _REG method with the embedded_control space_ID
> argument.
>  	 */
> -	next_node =3D acpi_ns_get_next_node(ec_device_node, NULL);
> +	next_node =3D acpi_ns_get_next_node(device_node, NULL);
>  	while (next_node) {
>  		if ((next_node->type =3D=3D ACPI_TYPE_REGION) &&
>  		    (next_node->object) &&
> -		    (next_node->object->region.space_id =3D=3D
> ACPI_ADR_SPACE_EC)) {
> +		    (next_node->object->region.space_id =3D=3D space_id)) {
>  			goto exit;	/* Do not execute the _REG */
>  		}
>=20
> -		next_node =3D acpi_ns_get_next_node(ec_device_node,
> next_node);
> +		next_node =3D acpi_ns_get_next_node(device_node,
> next_node);
>  	}
>=20
> -	/* Evaluate the _REG(embedded_control,Connect) method */
> +	/* Evaluate the _REG(space_id, Connect) method */
>=20
>  	args.count =3D 2;
>  	args.pointer =3D objects;
>  	objects[0].type =3D ACPI_TYPE_INTEGER;
> -	objects[0].integer.value =3D ACPI_ADR_SPACE_EC;
> +	objects[0].integer.value =3D space_id;
>  	objects[1].type =3D ACPI_TYPE_INTEGER;
>  	objects[1].integer.value =3D ACPI_REG_CONNECT;
>=20
> --
> 2.28.0

This looks good to me. Bob, any thoughts?

Erik
