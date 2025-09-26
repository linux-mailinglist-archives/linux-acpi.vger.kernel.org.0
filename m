Return-Path: <linux-acpi+bounces-17361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22450BA4B79
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 18:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34423BD9E0
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Sep 2025 16:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0F23081A6;
	Fri, 26 Sep 2025 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNv6s0I1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B917C1D86DC;
	Fri, 26 Sep 2025 16:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905739; cv=none; b=hu2SRGCwICcxu7lk9j1P2J8/lx5m2b8koqF/kt8W2NTxkm3pkRJhaLoulxegUtuiy+yCNCeb63pmUhj+iTGxfHFqA1vrKDHT4HddZnArR6i63gj9Vvu0UkxnlMCJ6j4nmjPWX94VVzFGcgqwoIoSXjUKHalDq5uEfLTJn7vCAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905739; c=relaxed/simple;
	bh=pI9degLf/+q59D0fv8fpQNooxIH3uWVgpJc8N6uXbW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Po7lprEah+KxXlbgw9nM1mXcz8PMPfo+4us3M7B2cY9YKS/asZsZBkZa1qz/RbMJ3nemydxOLLmhTlIlh8qfNS9g+KFUlgdaMzn8/mPd2V4nmjMrO3vrTYSb7jAC9rhisO6O1kxa/gMulD5CkglEZvUsT2G25dChWxYGztrWbnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNv6s0I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC4FC4CEF4;
	Fri, 26 Sep 2025 16:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758905739;
	bh=pI9degLf/+q59D0fv8fpQNooxIH3uWVgpJc8N6uXbW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CNv6s0I15gC3nUFJYvTIXlSI1AxJD9q0u/28WFjydG4s3aEbNDQM3K3dEAdRr8Qla
	 PGTHbo6NItVKL1HdEqHUpcH0AX5RTvpjlQupbL2ZqDH1NiMdE+fh2d+9FSmAl0ZZmb
	 AHX7OKP3LK0R3zxOZBgNVoeso3oOI93r0/q/4mjd+wZK/74VLJHj4oYA/VOhmzqrqC
	 cDUbjat38PeRVT0f5K/x+DemPmO3DWfckHjIFMoZvG9LsOYPlXb8pb2ez9so2nc+B0
	 PYoPqFpKOQddrXrRA8wlElbjRTHoCZ4MS/Pzh7EfSjgZQyG4VkyQTHRp+RRLhdg45t
	 iB4QM4Gva7RMQ==
Date: Fri, 26 Sep 2025 17:55:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Hans de Goede <hansg@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
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
Message-ID: <20250926-mute-boil-e75839753526@spud>
References: <20250926-uvc-orientation-v3-0-6dc2fa5b4220@chromium.org>
 <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dvlxf+F9Nk0RUTPP"
Content-Disposition: inline
In-Reply-To: <20250926-uvc-orientation-v3-7-6dc2fa5b4220@chromium.org>


--dvlxf+F9Nk0RUTPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2025 at 01:11:31PM +0000, Ricardo Ribalda wrote:
> For fixed cameras modules the OS needs to know where they are mounted.
> This information is used to determine if images need to be rotated or
> not.
>=20
> ACPI has a property for this purpose, which is parsed by
> acpi_get_physical_device_location():
> https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Dev=
ice_Configuration.html#pld-physical-location-of-device
>=20
> In DT we have similar properties for video-interface-devices called
> orientation and rotation:
> Documentation/devicetree/bindings/media/video-interface-devices.yaml
>=20
> Add a new schema that combines usb/usb-device.yaml and
> media/video-interface-devices.yaml
>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  .../bindings/media/usb-camera-module.yaml          | 46 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 47 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/media/usb-camera-module.ya=
ml b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..e4ad6f557b9151751522e49b7=
2ae6584deb0c7ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/usb-camera-module.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/usb-camera-module.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: USB Camera Module
> +
> +maintainers:
> +  - Ricardo Ribalda <ribalda@chromium.org>
> +
> +description: |
> +  This schema allows for annotating auxiliary information for fixed came=
ra
> +  modules. This information enables the system to determine if incoming =
frames
> +  require rotation, mirroring, or other transformations. It also describ=
es the
> +  module's relationship with other hardware elements, such as flash LEDs=
 or
> +  Voice Coil Motors (VCMs).
> +
> +allOf:
> +  - $ref: /schemas/usb/usb-device.yaml#
> +  - $ref: /schemas/media/video-interface-devices.yaml#
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +

What actually causes this schema to be applied? Did I miss it getting
included somewhere?

> +required:
> +  - reg
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    usb@11270000 {
> +        reg =3D <0x11270000 0x1000>;
> +        interrupts =3D <0x0 0x4e 0x0>;
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        device@1 {
> +            compatible =3D "usb123,4567";
> +            reg =3D <2>;
> +            orientation =3D <0>;
> +            rotation =3D <90>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ee8cb2db483f6a5e96b62b6f2edd05b1427b69f5..1503502a3aed2625e8ff48845=
6ccd7305cc74ba7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26258,6 +26258,7 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  W:	http://www.ideasonboard.org/uvc/
>  T:	git git://linuxtv.org/media.git
> +F:	Documentation/devicetree/bindings/media/usb-camera-module.yaml
>  F:	Documentation/userspace-api/media/drivers/uvcvideo.rst
>  F:	Documentation/userspace-api/media/v4l/metafmt-uvc-msxu-1-5.rst
>  F:	Documentation/userspace-api/media/v4l/metafmt-uvc.rst
>=20
> --=20
> 2.51.0.536.g15c5d4f767-goog
>=20

--dvlxf+F9Nk0RUTPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaNbFhAAKCRB4tDGHoIJi
0qhdAP49nO2mKsosLHwnekS7EGEufeFAyOly/K0/a5m74rcMVwEAvbMFbwdFzaSM
DgN8a+gmLLJ+4P89rQ8cIJR4oV+IpwI=
=/Hob
-----END PGP SIGNATURE-----

--dvlxf+F9Nk0RUTPP--

