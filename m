Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3A29C563
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 19:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1824204AbgJ0SFj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 14:05:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:21461 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900934AbgJ0ORs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 10:17:48 -0400
IronPort-SDR: P0z3hv7vAGsvRzw7CV4As/6yi4VH/ll0mrGlQr8HIzOHM82eJRqvHPgXgIvTkNVqeNUwAJWHdR
 o/olHciMtwXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="168213854"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168213854"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:17:46 -0700
IronPort-SDR: Y+H1zhI8RywhndI6QwthUrOl0IZKaOA5/PN0j3rGYoDY/CWpphjVfAYVAYtQAui8cvGfGrKN/4
 PUNGGusR/1qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="350292314"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 27 Oct 2020 07:17:46 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 07:17:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 07:17:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Oct 2020 07:17:43 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.57) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 27 Oct 2020 07:17:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvsF1eVx18L3/jcgxSw841J1EP5AraWXJW42Lxgr2KQSg0BnreOXmdY7+JpyDN9K02Bt9wWCzRPsdGby3p0J0ZJytOi4zOUSP6dX1PHCFaKiLDBhbx6bKEF7n1AOVwvgI3t0EiaeRZMEIbieyFP3vlW0oINII4oIJYYQM0Cyh48rFyx/EaOnlKMENru5p8X0TXBeWcaulMNIL6xTB8Mz3r/QhBHERXM/GQ/GO4USrOT2NnO0KeuJ49bJhu8MuVLjMwNoWK8fwTLR2Cuud5/r7CnHAn+AyD0MsdaAX0/hVemlzkcIy07aswV185GyVYe73GZiLxXekGJBWMvyJQ8vOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAtmWjhW+vJ6Zb1bJwJePhhmg5OT5AdWfP6bkPBHI8k=;
 b=DJ6LnHeZimU4vXCUQINq3zhmVPY5XUPHxBClPvUXu8QeZvMomP3tHcuN5bvdqjfLpmayD10oxi+rtcbJpVPsygvqDAmH54Wi2LMOYDTdNLOXRXKJh5BQIpOdiqmZFIQYkuefSBtCuVnzj6yhH4aX8nUbnjydSXxMW6C8Xi6ScrTdovC51W5hzJq/KWV1eGFkHxIeIqPHwg0ZFT9NerHjl39AedY2uPKdOu/C9/eYhCQkDyLiZi+dF5MfqeQRQvEyHfDuYB5VRfwRGw2Jw75GCHYbNmaWh+7YkrcXmp31j2krdQSD+xYCxoRmLznNS2fbX/1VajwrDKuTgrZrKkUC6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAtmWjhW+vJ6Zb1bJwJePhhmg5OT5AdWfP6bkPBHI8k=;
 b=MjfvCoP2jiXWD8QE7/pPxqQRWg/C5InLye83zES4DX6Nvr2nSPeBqNOMAMdOEnM725qPwyeX0QliUrOV17nXMSlrS2T0UEq87XktbAKdybKc7vjVLIDw4L+x/oFNPYxqvMAh76Kn3+HR8u5e3KocKn8jYCqyY4v/6FSOdXvsxNQ=
Received: from BYAPR11MB3256.namprd11.prod.outlook.com (2603:10b6:a03:76::19)
 by BY5PR11MB4274.namprd11.prod.outlook.com (2603:10b6:a03:1c1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 14:17:09 +0000
Received: from BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::bce9:aefc:561a:ee66]) by BYAPR11MB3256.namprd11.prod.outlook.com
 ([fe80::bce9:aefc:561a:ee66%7]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 14:17:09 +0000
From:   "Moore, Robert" <robert.moore@intel.com>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Topic: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Index: AQHWqrOos9lTzcrXNkahVmnQD/7vQqmqX2aAgAEi25A=
Date:   Tue, 27 Oct 2020 14:17:09 +0000
Message-ID: <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
References: <20201025094542.3669-1-hdegoede@redhat.com>
 <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.136.194]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14f00cab-961e-491f-c5ee-08d87a82fde4
x-ms-traffictypediagnostic: BY5PR11MB4274:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4274BF3D6CA7C86389DE3D3687160@BY5PR11MB4274.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KpXi6n4C8Y/BI2vLbzIQ1Qlx7ctWivU0q6qHZBOqAX74xuF3OXqlwi72cHAe01KBKd4dAJteZtARvxV3rght0BJ+ecshV8gfT+quwXMx8AZzQk4TcQp3qdV3fMZLTdi6dq6jB0JWUNWL4PAEVq4YSAtrCuRde5Keg4CB3huqw3FhCDox6MhUHoSTj0jm1jGNd1+CDdgO5u/KZGOyJEGn8Frd3D2vmS8FzO79cUfSLL8PEOWc8x9CQAJG2JILKpO7cKmECgEwfXoUdY0xHswlPKF+s8HrOIWkXMMuLHBpcQ1S7ypahpMcuFVs48EQY7l++DUHCg5QZpyUuZikgPdkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3256.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(4326008)(2906002)(26005)(52536014)(5660300002)(83380400001)(66476007)(76116006)(9686003)(66446008)(66946007)(86362001)(66556008)(6506007)(478600001)(55016002)(71200400001)(54906003)(186003)(64756008)(53546011)(8676002)(110136005)(8936002)(33656002)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZPq7MnlJyHgrDeHfvjZ1HyippdwjAEdGRzpPM7hqgL2rDAMLlPbDvmRapFxhZAm2MgouyICwO861M8QDAWwqEzZpBQmv3AxCJBO5ssHJZj8dM5Rd4mcdWgJ6bkmopTphze+MdKKJB8ksML7sSdZjNqLI8ZFUte+ICVf887KXYhSoKj+pM1fzxpVzSa9DICbmW9Ls1++mDJpDk/uqdWwFLmGxDDMLHGUU3zJedaNmvGyPs9lLlLM1l3o+dLy0ln6bc4AG0zHwitd0p7AC0i04ffpNspcxj2XU9UdV/9dQK1O50IjLEcWjFARglRq1XQQNSLIKkEEiZSFhLgxq+YJ4HWkTzJZa8mrBxT3PXGbXybZT4n3jMFAPClz4OvkKmagJ7Soz/3A+LJvaPfT+5tGs9ypCagu/63ZxQovJiGpvabkVjr5ECZI8Yt6x0XhiwYHfRuOIzXxMFCnQs76Mv86LOuk/D5mxqpm9VAy9lWJRqFLOgObXUtTb/Sawxmmyy3u30K00OIIjd+lFg9mk6bB8A60NNxJZj3zVDc/IMrQRp/IsKTSJwWHLtb+2eFGljS6gaYCWM+FQTF1z5qb8ylYNlPhTyTp86TnDNVm1t6JMERNAPrDPyC6TCEy4SttjngVW/gia2ubXTuEgw/bEazDmaQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3256.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f00cab-961e-491f-c5ee-08d87a82fde4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 14:17:09.5521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbM7ssxoB9rG3Ea2vJ6mNoZvlL+dhUyZY2OtVIiFd7AxCb/qUvaVvx0dg7GyQD1Fde969iD9SCBgNtDbh/HmDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4274
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Looks OK to me.
Bob


-----Original Message-----
From: Kaneda, Erik <erik.kaneda@intel.com>=20
Sent: Monday, October 26, 2020 1:56 PM
To: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.=
net>; Len Brown <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org; devel@acpica.org
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO OpR=
egions



> -----Original Message-----
> From: Hans de Goede <hdegoede@redhat.com>
> Sent: Sunday, October 25, 2020 2:46 AM
> To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown=20
> <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda,=20
> Erik <erik.kaneda@intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;=20
> devel@acpica.org
> Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO=20
> OpRegions
>=20
> Before this commit acpi_ev_execute_reg_methods() had special handling=20
> to handle "orphan" (no matching OpRegion declared) _REG methods for EC=20
> nodes.
>=20
> On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for=20
> accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry=20
> Trail specific UserDefined 0x9X OpRegions.
>=20
> Having 2 different types of OpRegions leads to potential issues with=20
> checks for OpRegion availability, or in other words checks if _REG has=20
> been called for the OpRegion which the ACPI code wants to use.
>=20
> Except for the "orphan" EC handling, ACPICA core does not call _REG on=20
> an ACPI node which does not define an OpRegion matching the type being=20
> registered; and the reference design DSDT, from which most Cherry=20
> Trail DSDTs are derived, does not define GeneralPurposeIo, nor
> UserDefined(0x93)
> OpRegions for the GPO2 (UID 3) device, because no pins were assigned=20
> ACPI controlled functions in the reference design.
>=20
> Together this leads to the perfect storm, at least on the Cherry Trail=20
> based Medion Akayo E1239T. This design does use a GPO2 pin from its=20
> ACPI code and has added the Cherry Trail specific UserDefined(0x93)=20
> opregion to its GPO2 ACPI node to access this pin.
>=20
> But it uses a has _REG been called availability check for the standard=20
> GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this=20
> does work under Windows. This issue leads to the intel_vbtn driver=20
> reporting the device always being in tablet-mode at boot, even if it=20
> is in laptop mode. Which in turn causes userspace to ignore touchpad=20
> events. So iow this issues causes the touchpad to not work at boot.
>=20
> This commit fixes this by extending the "orphan" _REG method handling=20
> to also apply to GPIO address-space handlers.
>=20
> Note it seems that Windows always calls "orphan" _REG methods so me=20
> may want to consider dropping the space-id check and always do=20
> "orphan" _REG method handling.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpica/evregion.c | 54=20
> +++++++++++++++++-----------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/drivers/acpi/acpica/evregion.c=20
> b/drivers/acpi/acpica/evregion.c index 738d4b231f34..21ff341e34a4=20
> 100644
> --- a/drivers/acpi/acpica/evregion.c
> +++ b/drivers/acpi/acpica/evregion.c
> @@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
>  /* Local prototypes */
>=20
>  static void
> -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node=20
> *ec_device_node);
> +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> *device_node,
> +				  acpi_adr_space_type space_id);
>=20
>  static acpi_status
>  acpi_ev_reg_run(acpi_handle obj_handle, @@ -684,10 +685,12 @@=20
> acpi_ev_execute_reg_methods(struct
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
> - * DESCRIPTION: Execute an "orphan" _REG method that appears under=20
> the EC
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
>  	struct acpi_namespace_node *next_node; @@ -792,9 +792,9 @@=20
> acpi_ev_orphan_ec_reg_method(struct
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
>  	/* Get a handle to a _REG method immediately under the EC device */
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
>  	 * execute the _REG method with the embedded_control space_ID=20
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
