Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E311729C32B
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Oct 2020 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437229AbgJ0Rnt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Oct 2020 13:43:49 -0400
Received: from mga06.intel.com ([134.134.136.31]:44029 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1821439AbgJ0Rns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Oct 2020 13:43:48 -0400
IronPort-SDR: +7v5qjKv0NclKwXiMNCqVBfptFK9JwwE0r9G8Gm5JrIXflckBeTeIf5cAef+ay3c9FDy7hmweJ
 2oY37kU/zCRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="229769527"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="229769527"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:43:46 -0700
IronPort-SDR: X9BFYUh5j4dLJT6ZRWiPWmGM2ir6Tf6gSKoWNU7sr1INdjqUbBlfRcr9jd7W8S0uO2f/WAgKE9
 RjUHVcGWCOYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="303964771"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga007.fm.intel.com with ESMTP; 27 Oct 2020 10:43:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 27 Oct 2020 10:43:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 27 Oct 2020 10:43:46 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 27 Oct 2020 10:43:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhNNn0fNkaXbwPEfnysMx5RlZqabt71+Qy7yPS8wrhbbyVCltpbcl4euDCxgSvwsBKlRS6dZiuu0ngS7GD757ZpS1qxUJnwFjpZuKnDmyzltA9O7ewQmP94mnImwdwmfPbxukWsT4gIdJk5w1dmZjWA55XzTCjlKYD6T0xbCGHItJMaKkP8FgRC6X4/LWkxbhu5sCyXiz1SNao0Z5J/jVHBiEucbdAfOPQ/VRwERtbYna6Val/sSrvlhjvpZSya52uHpiRrFygrBRnVc7gtLDP091Xiu9fOdjzmIPtrG6GoRabHthx2MauX6HukqwKIpHaCFU0JIKfS/WpFtPsFVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ6XL+8huCqgmLGCUyVZwTWVN90G7SQgj/GbGtbSo1M=;
 b=htLEpWrANtHujC508XwbGKu409Bttbhq0Y83xBKlFIdh0i5mLmyQNeHZNhGTMWlSlaYGgnCRGE4fAWK+XCOiSZa/Ktsmo1sv71C3iolqFTLqxLGkJ/bCAEhHdaz13cGDZ4G0c4Up2Oyh3ma4h1Lf5pNcSbJmATaBAPt7xYhiN6fk0jL9ksRmORh+ZBeZzBp/4V2zg0Cpw0Jlsngg5TUAzKbyCBoFtMGjTrkBS+wH9EGliHESrFMMqU1o19XNzCLX2qiNCIa1FYFMPPyLND5vxk8skzIUSF2QeMNdZfjy2tQufRxGT+LqQrMy6EvvJmTt5WTXInzFu6OiNy50PUUwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZ6XL+8huCqgmLGCUyVZwTWVN90G7SQgj/GbGtbSo1M=;
 b=UJm597R6PibVjGY7HycznuVaN8ph+Kv4Zf4isp+rxLrOnPsG9A6GxmKrKFGlql2MHvmcSK6O9pWK+vKKLKZdb4tZ6rSuFTdzqBV8c+UzOZhHJgUqCRXpLEVXPrwX2XbUWAKQ73va8M7l59iRBBj1BE2C8htIfFeXuDWl1VXC3bw=
Received: from MWHPR11MB1599.namprd11.prod.outlook.com (2603:10b6:301:e::16)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:95::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 27 Oct
 2020 17:43:43 +0000
Received: from MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31]) by MWHPR11MB1599.namprd11.prod.outlook.com
 ([fe80::95ce:8aed:2361:1f31%10]) with mapi id 15.20.3477.028; Tue, 27 Oct
 2020 17:43:43 +0000
From:   "Kaneda, Erik" <erik.kaneda@intel.com>
To:     "Moore, Robert" <robert.moore@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
CC:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Topic: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
 OpRegions
Thread-Index: AQHWqrOnbaxVkidVN0K4VBzXKS8YhamqXyUggAEjKYCAADldIA==
Date:   Tue, 27 Oct 2020 17:43:43 +0000
Message-ID: <MWHPR11MB15990ABB3778816E4831FDF9F0160@MWHPR11MB1599.namprd11.prod.outlook.com>
References: <20201025094542.3669-1-hdegoede@redhat.com>
 <MWHPR11MB159947FE046515CE985CA571F0190@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32563BD4E4ABB7BEF135ABFB87160@BYAPR11MB3256.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [50.45.176.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b254809e-c596-440b-3a5a-08d87a9fd974
x-ms-traffictypediagnostic: CO1PR11MB5187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB518712425A49820EAF933114F0160@CO1PR11MB5187.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QxPyeMjWOkv6NV7KkwIhjG59MyY1MgPybBVx4yU9lMAUEfUBz7KrIOBgenoxklA0gFknAbSFgGzt912f5j5pffiMmBxzVWxYYjqlBeP4U1bqiBWbXBfV5FDszOmpM152mJI7rCzJIljnOjAr78JSMWRmIAxvkRQex0wXmim4NnZA9v+y3q4uDmkRor2GhdywqcRV7gmlyOOVaHE+k4tAHf6bgNzoH/6LbRwVsar5HMj3EGCRPffcxxRAfYvLZnWU9bWd6e56l61llGCExC1EvQhLL4cgfIHRVj+j0njm+YQ3GNX1q8DV+NpTxDKQ45OKuCO044KILBaQiKtpBUb0MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1599.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6029001)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(8936002)(186003)(2906002)(54906003)(9686003)(478600001)(316002)(7696005)(110136005)(86362001)(4326008)(52536014)(33656002)(83380400001)(5660300002)(71200400001)(26005)(8676002)(53546011)(66446008)(76116006)(6506007)(66556008)(55016002)(64756008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9GxqsN/Yi97qlPbLftPJR5DwBATsQjGUAOKeVJuxmF1eOqxT3MvJKgRcCoHS6KpvuxqY8Av3faO0n8TmEJEr5u+Tmi0KtzFmvtBDJzYyYi9xLiIdah+5TOFV9W0EPikfAYl26w3Bhkfci7uTr5tvgujAt5u2YDfSPSZjOsoghezS52ulclQWp8thNzKRIVCeruPdr4CLEII9kZaQ47/1xBAhhrSPIniaIY8eSzx99F3NQ9AJeeRV0SH4luPmJRXn9gzmvwMoAZ1tApRGQ+PGd97BhKmAOzjXv92qx9rVfrkfBSG1dcmiKo8kM6AwJUdCni2pLPKv7/zf4WSwRjaRO+Wy3ib4anUyAdHDa2Ys7fTeVDnYQEWzwt8l+e4lpp4q8c3QPkmvC9Bktfw8w/X0TbMHnSGRYwV0fJ1gVcQY6UBFbp2bQVKrh+LECIrh3KQw89CYtioIqdGrlTZiYUAInIh16N/kAq/q3OAuExqhHQ+BPVCClboNZCYXSR4PzZvVONGPYUfOcKFf/6uUeN4h4DUVa2pyOgRFGLk5kJ8lVQPzTPjDUB+iwQhDPNF2MxGm8K7vWd+Rp8lbZIDThkxIr0tbpQD+IheAa8iNFLRKiJB1mzZpEdyh196vRJsoRZ5D1kry5YwIW6Cbsgqz3861ew==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1599.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b254809e-c596-440b-3a5a-08d87a9fd974
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2020 17:43:43.8277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4vLVymb+Q4YzON++RU/2ZcRxJlSP19/w12SbVboZixtnpEUEzAwmDk5iAz8ao3zKzOnlLyVoRCPIkKLpRb42A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Moore, Robert <robert.moore@intel.com>
> Sent: Tuesday, October 27, 2020 7:17 AM
> To: Kaneda, Erik <erik.kaneda@intel.com>; Hans de Goede
> <hdegoede@redhat.com>; Rafael J . Wysocki <rjw@rjwysocki.net>; Len
> Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
> OpRegions
>=20
> Looks OK to me.

Ok, I'll make a pull request of this to ACPICA on behalf of Hans and it wil=
l be in the next ACPICA release.

Rafael, let me know if you have any issues with this.

Thanks,
Erik

> Bob
>=20
>=20
> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda@intel.com>
> Sent: Monday, October 26, 2020 1:56 PM
> To: Hans de Goede <hdegoede@redhat.com>; Rafael J . Wysocki
> <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Moore, Robert
> <robert.moore@intel.com>
> Cc: linux-acpi@vger.kernel.org; devel@acpica.org
> Subject: RE: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
> OpRegions
>=20
>=20
>=20
> > -----Original Message-----
> > From: Hans de Goede <hdegoede@redhat.com>
> > Sent: Sunday, October 25, 2020 2:46 AM
> > To: Rafael J . Wysocki <rjw@rjwysocki.net>; Len Brown
> > <lenb@kernel.org>; Moore, Robert <robert.moore@intel.com>; Kaneda,
> > Erik <erik.kaneda@intel.com>
> > Cc: Hans de Goede <hdegoede@redhat.com>; linux-acpi@vger.kernel.org;
> > devel@acpica.org
> > Subject: [PATCH] ACPICA: Also handle "orphan" _REG methods for GPIO
> > OpRegions
> >
> > Before this commit acpi_ev_execute_reg_methods() had special handling
> > to handle "orphan" (no matching OpRegion declared) _REG methods for EC
> > nodes.
> >
> > On Intel Cherry Trail devices there are 2 possible ACPI OpRegions for
> > accessing GPIOs. The standard GeneralPurposeIo OpRegion and the Cherry
> > Trail specific UserDefined 0x9X OpRegions.
> >
> > Having 2 different types of OpRegions leads to potential issues with
> > checks for OpRegion availability, or in other words checks if _REG has
> > been called for the OpRegion which the ACPI code wants to use.
> >
> > Except for the "orphan" EC handling, ACPICA core does not call _REG on
> > an ACPI node which does not define an OpRegion matching the type being
> > registered; and the reference design DSDT, from which most Cherry
> > Trail DSDTs are derived, does not define GeneralPurposeIo, nor
> > UserDefined(0x93)
> > OpRegions for the GPO2 (UID 3) device, because no pins were assigned
> > ACPI controlled functions in the reference design.
> >
> > Together this leads to the perfect storm, at least on the Cherry Trail
> > based Medion Akayo E1239T. This design does use a GPO2 pin from its
> > ACPI code and has added the Cherry Trail specific UserDefined(0x93)
> > opregion to its GPO2 ACPI node to access this pin.
> >
> > But it uses a has _REG been called availability check for the standard
> > GeneralPurposeIo OpRegion. This clearly is a bug in the DSDT, but this
> > does work under Windows. This issue leads to the intel_vbtn driver
> > reporting the device always being in tablet-mode at boot, even if it
> > is in laptop mode. Which in turn causes userspace to ignore touchpad
> > events. So iow this issues causes the touchpad to not work at boot.
> >
> > This commit fixes this by extending the "orphan" _REG method handling
> > to also apply to GPIO address-space handlers.
> >
> > Note it seems that Windows always calls "orphan" _REG methods so me
> > may want to consider dropping the space-id check and always do
> > "orphan" _REG method handling.
> >
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/acpica/evregion.c | 54
> > +++++++++++++++++-----------------
> >  1 file changed, 27 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/evregion.c
> > b/drivers/acpi/acpica/evregion.c index 738d4b231f34..21ff341e34a4
> > 100644
> > --- a/drivers/acpi/acpica/evregion.c
> > +++ b/drivers/acpi/acpica/evregion.c
> > @@ -21,7 +21,8 @@ extern u8 acpi_gbl_default_address_spaces[];
> >  /* Local prototypes */
> >
> >  static void
> > -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
> > *ec_device_node);
> > +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> > *device_node,
> > +				  acpi_adr_space_type space_id);
> >
> >  static acpi_status
> >  acpi_ev_reg_run(acpi_handle obj_handle, @@ -684,10 +685,12 @@
> > acpi_ev_execute_reg_methods(struct
> > acpi_namespace_node *node,
> >  				     ACPI_NS_WALK_UNLOCK,
> > acpi_ev_reg_run, NULL,
> >  				     &info, NULL);
> >
> > -	/* Special case for EC: handle "orphan" _REG methods with no region
> > */
> > -
> > -	if (space_id =3D=3D ACPI_ADR_SPACE_EC) {
> > -		acpi_ev_orphan_ec_reg_method(node);
> > +	/*
> > +	 * Special case for EC and GPIO: handle "orphan" _REG methods with
> > +	 * no region.
> > +	 */
> > +	if (space_id =3D=3D ACPI_ADR_SPACE_EC || space_id =3D=3D
> > ACPI_ADR_SPACE_GPIO) {
> > +		acpi_ev_execute_orphan_reg_method(node, space_id);
> >  	}
> >
> >  	ACPI_DEBUG_PRINT_RAW((ACPI_DB_NAMES,
> > @@ -760,31 +763,28 @@ acpi_ev_reg_run(acpi_handle obj_handle,
> >
> >
> >
> /**********************************************************
> > *********************
> >   *
> > - * FUNCTION:    acpi_ev_orphan_ec_reg_method
> > + * FUNCTION:    acpi_ev_execute_orphan_reg_method
> >   *
> > - * PARAMETERS:  ec_device_node      - Namespace node for an EC device
> > + * PARAMETERS:  device_node     - Namespace node for an ACPI device
> > + *              space_id        - The address space ID
> >   *
> >   * RETURN:      None
> >   *
> > - * DESCRIPTION: Execute an "orphan" _REG method that appears under
> > the EC
> > + * DESCRIPTION: Execute an "orphan" _REG method that appears under
> an
> > ACPI
> >   *              device. This is a _REG method that has no correspondin=
g region
> > - *              within the EC device scope. The orphan _REG method app=
ears to
> > - *              have been enabled by the description of the ECDT in th=
e ACPI
> > - *              specification: "The availability of the region space c=
an be
> > - *              detected by providing a _REG method object underneath =
the
> > - *              Embedded Controller device."
> > - *
> > - *              To quickly access the EC device, we use the ec_device_=
node used
> > - *              during EC handler installation. Otherwise, we would ne=
ed to
> > - *              perform a time consuming namespace walk, executing _HI=
D
> > - *              methods to find the EC device.
> > + *              within the device's scope. ACPI tables depending on th=
ese
> > + *              "orphan" _REG methods have been seen for both EC and G=
PIO
> > + *              Operation Regions. Presumably the Windows ACPI
> implementation
> > + *              always calls the _REG method independent of the presen=
ce of
> > + *              an actual Operation Region with the correct address sp=
ace ID.
> >   *
> >   *  MUTEX:      Assumes the namespace is locked
> >   *
> >
> >
> **********************************************************
> > ********************/
> >
> >  static void
> > -acpi_ev_orphan_ec_reg_method(struct acpi_namespace_node
> > *ec_device_node)
> > +acpi_ev_execute_orphan_reg_method(struct acpi_namespace_node
> > *device_node,
> > +				  acpi_adr_space_type space_id)
> >  {
> >  	acpi_handle reg_method;
> >  	struct acpi_namespace_node *next_node; @@ -792,9 +792,9 @@
> > acpi_ev_orphan_ec_reg_method(struct
> > acpi_namespace_node *ec_device_node)
> >  	struct acpi_object_list args;
> >  	union acpi_object objects[2];
> >
> > -	ACPI_FUNCTION_TRACE(ev_orphan_ec_reg_method);
> > +	ACPI_FUNCTION_TRACE(ev_execute_orphan_reg_method);
> >
> > -	if (!ec_device_node) {
> > +	if (!device_node) {
> >  		return_VOID;
> >  	}
> >
> > @@ -804,7 +804,7 @@ acpi_ev_orphan_ec_reg_method(struct
> > acpi_namespace_node *ec_device_node)
> >
> >  	/* Get a handle to a _REG method immediately under the EC device
> */
> >
> > -	status =3D acpi_get_handle(ec_device_node, METHOD_NAME__REG,
> > &reg_method);
> > +	status =3D acpi_get_handle(device_node, METHOD_NAME__REG,
> > &reg_method);
> >  	if (ACPI_FAILURE(status)) {
> >  		goto exit;	/* There is no _REG method present */
> >  	}
> > @@ -816,23 +816,23 @@ acpi_ev_orphan_ec_reg_method(struct
> > acpi_namespace_node *ec_device_node)
> >  	 * with other space IDs to be present; but the code below will then
> >  	 * execute the _REG method with the embedded_control space_ID
> > argument.
> >  	 */
> > -	next_node =3D acpi_ns_get_next_node(ec_device_node, NULL);
> > +	next_node =3D acpi_ns_get_next_node(device_node, NULL);
> >  	while (next_node) {
> >  		if ((next_node->type =3D=3D ACPI_TYPE_REGION) &&
> >  		    (next_node->object) &&
> > -		    (next_node->object->region.space_id =3D=3D
> > ACPI_ADR_SPACE_EC)) {
> > +		    (next_node->object->region.space_id =3D=3D space_id)) {
> >  			goto exit;	/* Do not execute the _REG */
> >  		}
> >
> > -		next_node =3D acpi_ns_get_next_node(ec_device_node,
> > next_node);
> > +		next_node =3D acpi_ns_get_next_node(device_node,
> > next_node);
> >  	}
> >
> > -	/* Evaluate the _REG(embedded_control,Connect) method */
> > +	/* Evaluate the _REG(space_id, Connect) method */
> >
> >  	args.count =3D 2;
> >  	args.pointer =3D objects;
> >  	objects[0].type =3D ACPI_TYPE_INTEGER;
> > -	objects[0].integer.value =3D ACPI_ADR_SPACE_EC;
> > +	objects[0].integer.value =3D space_id;
> >  	objects[1].type =3D ACPI_TYPE_INTEGER;
> >  	objects[1].integer.value =3D ACPI_REG_CONNECT;
> >
> > --
> > 2.28.0
>=20
> This looks good to me. Bob, any thoughts?
>=20
> Erik
