Return-Path: <linux-acpi+bounces-17435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B3DBAA618
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 20:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD3271685EF
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27DD22ACF3;
	Mon, 29 Sep 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmLQPoLf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829912032D;
	Mon, 29 Sep 2025 18:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759171763; cv=none; b=VQXge/WEZfN52y+fcl0GR/KLxwV2EBaopf1nISwXVt30a5jbkvDRKm+w+ji4AnS9vRGQtVIPh+pmPWnhd9QJ4DF8cvF8sOypRe5fFxr5/kUJzlAwNYSt5LSVLx7GGVWgzj1cSu+415SzgsYgTZp/zWYyNTz4xo5oP+2hV8/pP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759171763; c=relaxed/simple;
	bh=CIesZg8God6+nurlZmJlDErmkC0T5rSf+vpzR1sIRAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh65tXVQhGdmU6/c+XX9HmuR+CyFVU6jIBTQ0cstAZgwTC2fqe7pFc+FS6ZUA1xXK3qKmsBs82zdqOYMqnOA6NlBdLIDy+1tEhri0ezP5z7uf1jqSEP9UlVpwayGo9PSWdTWsl3n3/6wmAQX6ytYZ1oXHb8nrjug1wk+P5+kh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmLQPoLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A7FC4CEF4;
	Mon, 29 Sep 2025 18:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759171763;
	bh=CIesZg8God6+nurlZmJlDErmkC0T5rSf+vpzR1sIRAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmLQPoLflrWPzRHpNZHaEQ6aDwxh9aYtXgubo4m46HHBDXYVQgDPIOQtOYSXLT0UW
	 J0cY7HPPczP7uGVH9bcU+tgHh7JtcdZAtZ/6LkN4Q9KJns0kjSKvioKAxNeym0F/RE
	 7Jaqb/P/p+piz8zOUQLrQ0JqLlFpk0EgPrMLapEl2mTsSX89/OCAF5ICnPviDScM8e
	 f9N+ovN/nvQY+yVV/VjHhRlzBKhjk8QSuDeMmVdSw/y/HhudxSwo2qdDx8p6luxZWn
	 r2qXWDt5vxv4e8T8xv12/e34WtpCFymnIXXgYbICoJ1r01KImMcZb8lqAn92hmslwc
	 qaKj9SwXF+fMQ==
Date: Mon, 29 Sep 2025 19:49:15 +0100
From: Conor Dooley <conor@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 07/12] dt-bindings: media: Add usb-camera-module
Message-ID: <20250929-disparate-fidgeting-65c2f7eff236@spud>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
 <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org>
 <20250926-mute-boil-e75839753526@spud>
 <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T7A0TheW4Ey8c64A"
Content-Disposition: inline
In-Reply-To: <CANiDSCuddqjeDr80xKsZZP7CXu9qB5qqYPoZujNYLcVjK0kKkg@mail.gmail.com>


--T7A0TheW4Ey8c64A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 10:30:35AM +0200, Ricardo Ribalda wrote:
> Hi Conor
>=20
> On Fri, 26 Sept 2025 at 18:55, Conor Dooley <conor@kernel.org> wrote:
> >
> > On Fri, Sep 26, 2025 at 01:11:31PM +0000, Ricardo Ribalda wrote:
> > > For fixed cameras modules the OS needs to know where they are mounted.
> > > This information is used to determine if images need to be rotated or
> > > not.
> > >
> > > ACPI has a property for this purpose, which is parsed by
> > > acpi_get_physical_device_location():
> > > https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration=
/Device_Configuration.html#pld-physical-location-of-device
> > >
> > > In DT we have similar properties for video-interface-devices called
> > > orientation and rotation:
> > > Documentation/devicetree/bindings/media/video-interface-devices.yaml
> > >
> > > Add a new schema that combines usb/usb-device.yaml and
> > > media/video-interface-devices.yaml
> > >
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > ---
> > >  .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++=
++++++++++
> > >  MAINTAINERS                                        |  1 +
> > >  2 files changed, 47 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/usb-camera-modul=
e.yaml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e=
49b72ae6584deb0c7ba
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > > @@ -0,0 +1,46 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: USB Camera Module
> > > +
> > > +maintainers:
> > > +  - Ricardo Ribalda <ribalda@chromium.org>
> > > +
> > > +description: |
> > > +  This schema allows for annotating auxiliary information for fixed =
camera
> > > +  modules. This information enables the system to determine if incom=
ing frames
> > > +  require rotation, mirroring, or other transformations. It also des=
cribes the
> > > +  module's relationship with other hardware elements, such as flash =
LEDs or
> > > +  Voice Coil Motors (VCMs).
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/usb/usb-device.yaml#
> > > +  - $ref: /schemas/media/video-interface-devices.yaml#
> > > +
> > > +properties:
> > > +  reg:
> > > +    maxItems: 1
> > > +
> >
> > What actually causes this schema to be applied? Did I miss it getting
> > included somewhere?
>=20
> I guess your question is why I have not defined the compatible field?
>=20
> I tried this change[1] with no luck:
> /usr/local/google/home/ribalda/work/linux/Documentation/devicetree/bindin=
gs/media/uvc-camera.example.dtb:
> device@1 (uvc-camera): compatible: ['uvc-camera'] does not contain
> items matching the given schema
>=20
> I think it failed, because If we add these allOfs as Rob proposed
> https://lore.kernel.org/all/20250625185608.GA2010256-robh@kernel.org/:
> ```
> allOf:
>   - $ref: /schemas/usb/usb-device.yaml#
>   - $ref: /schemas/media/video-interface-devices.yaml#
> ```
> We cannot (or I do not know how to) have a different compatible than
> the one from usb-device.yaml
>=20
>=20
> Any suggestion on how to do this properly will be highly appreciated :)

It'd work, I think, if you permitted the pattern from usb-device as a
fallback compatible. I don't know if that would work for whatever niche
you're attempting to fill here though.

Probably a Rob question ultimately.

>=20
> Thanks!
>=20
>=20
>=20
> [1]
>=20
> @@ -21,10 +21,14 @@ allOf:
>    - $ref: /schemas/media/video-interface-devices.yaml#
>=20
>  properties:
> +  compatible:
> +    const: uvc-camera
> +
>    reg:
>      maxItems: 1
>=20
>  required:
> +  - compatible
>    - reg
>=20
>  additionalProperties: true
> @@ -38,8 +42,8 @@ examples:
>          #size-cells =3D <0>;
>=20
>          device@1 {
> -            compatible =3D "usb123,4567";
> +           compatible =3D "uvc-camera";
>              reg =3D <2>;
>              orientation =3D <0>;
>              rotation =3D <90>;
>          };
>=20
> >
> > > +required:
> > > +  - reg
> > > +
> > > +additionalProperties: true
> > > +
> > > +examples:
> > > +  - |
> > > +    usb@11270000 {
> > > +        reg =3D <0x11270000 0x1000>;
> > > +        interrupts =3D <0x0 0x4e 0x0>;
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +
> > > +        device@1 {
> > > +            compatible =3D "usb123,4567";
> > > +            reg =3D <2>;
> > > +            orientation =3D <0>;
> > > +            rotation =3D <90>;
> > > +        };
> > > +    };
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff4=
88456ccd7305cc74ba7 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -26258,6 +26258,7 @@ L:    linux-media@vger.kernel.org
> > >  S:   Maintained
> > >  W:   http://www.ideasonboard.org/uvc/
> > >  T:   git git://linuxtv.org/media.git
> > > +F:   Documentation/devicetree/bindings/media/usb-camera-module.yaml
> > >  F:   Documentation/userspace-api/media/drivers/uvcvideo.rst
> > >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
> > >  F:   Documentation/userspace-api/media/v4l/metafmt-uvc.rst
> > >
> > > --
> > > 2.51.0.536.g15c5d4f767-goog
> > >
>=20
>=20
>=20
> --
> Ricardo Ribalda
>=20

--T7A0TheW4Ey8c64A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNrUqwAKCRB4tDGHoIJi
0mASAP49pwqqfaBzHe/GqEE+pCyOCKLHjQV++1zecT+/WddTgAD/dP2GQvWciVeV
ngYFC1P2vUnJOUWrondGz3NRTBBB/g0=
=ew51
-----END PGP SIGNATURE-----

--T7A0TheW4Ey8c64A--

