Return-Path: <linux-acpi+bounces-12912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC758A82892
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A631898256
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11CA266B51;
	Wed,  9 Apr 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPUluxbA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A96F26658F
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 14:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209778; cv=none; b=PC/hGyyoS9qCOGferBWyc44+XcbAvF1VdoIb4BVdNFhvEfR6uz/f3TnbrdqeQDmZXvbGPwWuNm/8LCUYvoc+rleARBbKZnJ+GaJfUgL4x0OI9DgAFz3/m5KTil6TR5ZnKxoG6ZtWkRuTtaZmzmH5LD6FiZuZHwcpFjGvGX1Ys80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209778; c=relaxed/simple;
	bh=pzRBztJBd06fHjANAQkNRtWglTI2SgxNmiAYHYcYALU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c58bnLGwZdCmgiZAQ5NWdtlTyHq5UfIEzaSUoVJYqQ2xyBjbq+PBrO0amj9hsdxwMjahiYuVObhk2Erwy+BOP6zybBgNpUqGO3Q1MxPDCv1cV3e34JvBuhihPvre9psu3oTHquWhfL9+aJIcmfOQYjGrcsZG3neXfL0s0cBU2Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPUluxbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C85C4CEE3
	for <linux-acpi@vger.kernel.org>; Wed,  9 Apr 2025 14:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744209778;
	bh=pzRBztJBd06fHjANAQkNRtWglTI2SgxNmiAYHYcYALU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fPUluxbAzql2a/FU+T+RO658TRg/PT5QSnPDSQ3T9mv7V8g9Mu+JkXdgcrA6ktcRX
	 uUrylR2xP0W9TvGFntTBYjJKen2woiErG3Vtc5ALHEfQh1PP7hgS0E/LOZ4cCX4ayx
	 dibZPFIiQ8bA0z6w/Vxbej4IqsDqKEzvI2VeDEiekaw+wOVNXa2iXSpznGLcZmiuqV
	 HVFfqcxdaAODt0W25AmN56q55Zzrf8cxU7Dmr+hopoUgqwI+w7egpcq4GaBqqI6cYb
	 ac+z8BrTV+CWoGV2VsBg2M1XcB0TtD6d2AJZrdqbMV8jiO4/d/KTawTQWHOyASQAEZ
	 r8r5cC9FUxs/w==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2c873231e7bso3878422fac.3
        for <linux-acpi@vger.kernel.org>; Wed, 09 Apr 2025 07:42:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YxSzmCQNqu8tQNjIq5g8A0UbmPDssRpyMMwA32TgNVIZtUyICzw
	2F7kH+rYnhZ5PYo6yR7ph/0Bnr2bg7DfBQntAVrYay3bdMltY7JyuS/HocHKSkSUjyfrmZVTe1E
	Qdjao3gURoeX51KnmOcpMtleNm/w=
X-Google-Smtp-Source: AGHT+IHGW76vQdqen4RJLnZXCkdlxWVNR5yHOuuuCofaaZzB1aYu9yCtgrLqkvN8JHUy9O5cbXI0OqLR+jPAH0nNcWA=
X-Received: by 2002:a05:6870:164c:b0:2c2:b18c:9be9 with SMTP id
 586e51a60fabf-2d091718fdfmr1510922fac.3.1744209777637; Wed, 09 Apr 2025
 07:42:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409084738.3657079-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250409084738.3657079-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 9 Apr 2025 16:42:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jxtqFWfKeASkNUJTCMHX=HYPyQQszaGYA7qQ4WGiAUTA@mail.gmail.com>
X-Gm-Features: ATxdqUEfPdWX4go2CtYlxAhvDRHY5y40S_YSRuKUz4w6qBSrKzffnTw5R61ytwM
Message-ID: <CAJZ5v0jxtqFWfKeASkNUJTCMHX=HYPyQQszaGYA7qQ4WGiAUTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Documentation: ACPI: Use all-string data node references
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	andriy.shevchenko@linux.intel.com, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 10:47=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Document that references to data nodes shall use string-only references
> instead of a device reference and a succession of the first package
> entries of hierarchical data node references.
>
> Fixes: 9880702d123f ("ACPI: property: Support using strings in reference =
properties")
> Cc: stable@vger.kernel.org # for 6.8 and later
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  .../acpi/dsd/data-node-references.rst         | 26 +++++++++----------
>  .../firmware-guide/acpi/dsd/graph.rst         | 11 +++-----
>  .../firmware-guide/acpi/dsd/leds.rst          |  7 +----
>  3 files changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/firmware-guide/acpi/dsd/data-node-references.r=
st b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> index 8d8b53e96bcf..8d91fab37d89 100644
> --- a/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/data-node-references.rst
> @@ -12,11 +12,14 @@ ACPI in general allows referring to device objects in=
 the tree only.
>  Hierarchical data extension nodes may not be referred to directly, hence=
 this
>  document defines a scheme to implement such references.
>
> -A reference consist of the device object name followed by one or more
> -hierarchical data extension [dsd-guide] keys. Specifically, the hierarch=
ical
> -data extension node which is referred to by the key shall lie directly u=
nder
> -the parent object i.e. either the device object or another hierarchical =
data
> -extension node.
> +A reference to a _DSD hierarchical data node consist of the device objec=
t
> +reference followed by a dot (".") and the data node object name as a str=
ing. Do
> +not use non-string references as this will result in a copy of the hiera=
rchical
> +data node itself, not a reference!
> +
> +The hierarchical data extension node which is referred to shall have a
> +followable path of hierarchical data node reference under a device it re=
sides
> +[dsd-guide].

I've edited the above so it is a bit easier to follow and applied the
patch for 6.16.

>  The keys in the hierarchical data nodes shall consist of the name of the=
 node,
>  "@" character and the number of the node in hexadecimal notation (withou=
t pre-
> @@ -33,11 +36,9 @@ extension key.
>  Example
>  =3D=3D=3D=3D=3D=3D=3D
>
> -In the ASL snippet below, the "reference" _DSD property contains a
> -device object reference to DEV0 and under that device object, a
> -hierarchical data extension key "node@1" referring to the NOD1 object
> -and lastly, a hierarchical data extension key "anothernode" referring to
> -the ANOD object which is also the final target node of the reference.
> +In the ASL snippet below, the "reference" _DSD property contains a strin=
g
> +reference to a hierarchical data extension node ANOD under DEV0 under th=
e parent
> +of DEV1 device object. ANOD is also the final target node of the referen=
ce.
>  ::
>
>         Device (DEV0)
> @@ -76,10 +77,7 @@ the ANOD object which is also the final target node of=
 the reference.
>             Name (_DSD, Package () {
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
> -                   Package () {
> -                       "reference", Package () {
> -                           ^DEV0, "node@1", "anothernode"
> -                       }
> +                   Package () { "reference", "^DEV0.ANOD" }
>                     },
>                 }
>             })
> diff --git a/Documentation/firmware-guide/acpi/dsd/graph.rst b/Documentat=
ion/firmware-guide/acpi/dsd/graph.rst
> index b9dbfc73ed25..d6ae5ffa748c 100644
> --- a/Documentation/firmware-guide/acpi/dsd/graph.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/graph.rst
> @@ -66,12 +66,9 @@ of that port shall be zero. Similarly, if a port may o=
nly have a single
>  endpoint, the number of that endpoint shall be zero.
>
>  The endpoint reference uses property extension with "remote-endpoint" pr=
operty
> -name followed by a reference in the same package. Such references consis=
t of
> -the remote device reference, the first package entry of the port data ex=
tension
> -reference under the device and finally the first package entry of the en=
dpoint
> -data extension reference under the port. Individual references thus appe=
ar as::
> +name followed by a string reference in the same package. [data-node-ref]=
::
>
> -    Package() { device, "port@X", "endpoint@Y" }
> +    "device.datanode"
>
>  In the above example, "X" is the number of the port and "Y" is the numbe=
r of
>  the endpoint.
> @@ -109,7 +106,7 @@ A simple example of this is show below::
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                     Package () { "reg", 0 },
> -                   Package () { "remote-endpoint", Package() { \_SB.PCI0=
.ISP, "port@4", "endpoint@0" } },
> +                   Package () { "remote-endpoint", "\\_SB.PCI0.ISP.EP40"=
 },
>                 }
>             })
>         }
> @@ -141,7 +138,7 @@ A simple example of this is show below::
>                 ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>                 Package () {
>                     Package () { "reg", 0 },
> -                   Package () { "remote-endpoint", Package () { \_SB.PCI=
0.I2C2.CAM0, "port@0", "endpoint@0" } },
> +                   Package () { "remote-endpoint", "\\_SB.PCI0.I2C2.CAM0=
.EP00" },
>                 }
>             })
>         }
> diff --git a/Documentation/firmware-guide/acpi/dsd/leds.rst b/Documentati=
on/firmware-guide/acpi/dsd/leds.rst
> index 93db592c93c7..a97cd07d49be 100644
> --- a/Documentation/firmware-guide/acpi/dsd/leds.rst
> +++ b/Documentation/firmware-guide/acpi/dsd/leds.rst
> @@ -15,11 +15,6 @@ Referring to LEDs in Device tree is documented in [vid=
eo-interfaces], in
>  "flash-leds" property documentation. In short, LEDs are directly referre=
d to by
>  using phandles.
>
> -While Device tree allows referring to any node in the tree [devicetree],=
 in
> -ACPI references are limited to device nodes only [acpi]. For this reason=
 using
> -the same mechanism on ACPI is not possible. A mechanism to refer to non-=
device
> -ACPI nodes is documented in [data-node-ref].
> -
>  ACPI allows (as does DT) using integer arguments after the reference. A
>  combination of the LED driver device reference and an integer argument,
>  referring to the "reg" property of the relevant LED, is used to identify
> @@ -74,7 +69,7 @@ omitted. ::
>                         Package () {
>                                 Package () {
>                                         "flash-leds",
> -                                       Package () { ^LED, "led@0", ^LED,=
 "led@1" },
> +                                       Package () { "^LED.LED0", "^LED.L=
ED1" },
>                                 }
>                         }
>                 })
> --
> 2.39.5
>

