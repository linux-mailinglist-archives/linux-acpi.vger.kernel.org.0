Return-Path: <linux-acpi+bounces-12559-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2083FA766B3
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720893ABC25
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED1211A05;
	Mon, 31 Mar 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIrJHclu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A471E5B60
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743427159; cv=none; b=Xy3P9d4CA4X1sGAznHR6/iyay2zfsJDUk9qt8CQEvQDI6f73EH3dJPxC82mjSpVWF/UM1X9/o0CFB7KUDRl5mVD0oeEy0rF++8IlBiwdSQ2DP/e6x2FOeHLSfbKaELlRf0ptb2MXKX/bknYW6BW4EPOSLXu1hAfvNfDkI/pn73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743427159; c=relaxed/simple;
	bh=0l/LjABG+p9IrbkD4zyVk9c2xB5Ou3S8O2Zek8rbDFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQeY8DlIIJRtaTmf8eaiVhnfOBP8bK14+kMkB/jL/ZDWI1ucek14IbLPQh3V7Tet1TYbvjYT5cgbj5x1G19tAtVuyyhDtiqBID65vjvZvDNUVOSJVfU5UrFLfSP2GzjMzkpplpwp2KLNPi0d6P/2RyEl2z7NiM76DsdyZXkzMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIrJHclu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2376BC4CEE4
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743427159;
	bh=0l/LjABG+p9IrbkD4zyVk9c2xB5Ou3S8O2Zek8rbDFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aIrJHcluDowE1uAoLNhjYRsE+TRHx8Idcwi84m0mZvFJmy2divgLcG7GEwil48Cwc
	 695zsHsBWrOdhrxe7zDjgZQoSri4DwrqllO4+7ezNnRFqUcTRsKs3iGhR4ceTUtBnh
	 KTw+5YR3gMQASUnS+gbz/mm1tEZLO92BUp+ye9/jcr07FfMK/VYxQZsmiQ/8ngGTTD
	 C2UI5XX+hDFIJNHypRjJWUB/OW5AhsYEF2mow2qv5DKYw81rgP85cqkqpTxTPx0ww9
	 RJV5/1/jNANS1tAVGgPAamOmqi4pxQ7rFJXcvNBTbUgEAWV65EPLCEpplqebVycGew
	 MeVNEtVYKXUXA==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c14138668so983707a34.2
        for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 06:19:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqP0uFGZyhRnW69lM+Hyxwfyp2dNSGwcOS/roKwdnDtdDBX+91
	xuukR9Vpuw7npwKxsoGSRMOMR9vDqC08EjgofdphmaAWeVjlvcV5tHdg5dYFZDbiKNSahsoIZoW
	VOeu3R6G4vllFHgATz9iZxI2ILLY=
X-Google-Smtp-Source: AGHT+IGGE0HDd8TJSUsyLhN6y7IapfB81ihU4QZfdqpzHborWvQdwfHZ1iIqK5G4AV3ynO0m00QzSEt5EkQrOCt9K8A=
X-Received: by 2002:a05:6870:f10c:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2cbcf4ef188mr4670424fac.10.1743427158436; Mon, 31 Mar 2025
 06:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 15:19:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
X-Gm-Features: AQ5f1JocuEoGGnw1Y-oAFxC8t-wnAUFbQ8eMxTlFBO5u4oLhSu0_-aRp32cEq6A
Message-ID: <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 2:18=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Restore parsing of ACPI data node references consisting of a device node
> reference followed by one or more child data node names.
>
> Fixes: 9880702d123f ("ACPI: property: Support using strings in reference =
properties")
> Cc: stable@vger.kernel.org # for 6.8 and later
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Rafael,
>
> It seems that support for REF STR... references got accidentally removed
> when pure STR reference were added. The former are documented in
> Documentation/firmware-guide/acpi/dsd/graph.rst .

It would be good to provide an ASL example that is not parsed as
expected before the change and will be parsed correctly after it.

Admittedly, I can't quite recall the history leading to the above
commit, but this paragraphs is present in its changelog:

"Also remove the mechanism allowing data nodes to be referenced
 indirectly, with the help of an object reference pointing to the
 "ancestor" device and a path relative to it (this mechanism is not
 expected to be in use in any production platform firmware in the field)."

so the change in question appears to be intentional rather than accidental.

>  drivers/acpi/property.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 436019d96027..4e3202a0b305 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -807,10 +807,27 @@ acpi_fwnode_get_named_child_node(const struct fwnod=
e_handle *fwnode,
>  static int acpi_get_ref_args(struct fwnode_reference_args *args,
>                              struct fwnode_handle *ref_fwnode,
>                              const union acpi_object **element,
> -                            const union acpi_object *end, size_t num_arg=
s)
> +                            const union acpi_object *end, size_t num_arg=
s,
> +                            bool follow_strings)
>  {
>         u32 nargs =3D 0, i;
>
> +       /*
> +        * Parse REF STR... references by following named child nodes bel=
ow the
> +        * device node pointed by REF.
> +        */
> +       if (follow_strings) {
> +               for (; (*element) < end && (*element)->type =3D=3D ACPI_T=
YPE_STRING;
> +                    (*element)++) {
> +                       const char *child_name =3D (*element)->string.poi=
nter;
> +
> +                       ref_fwnode =3D acpi_fwnode_get_named_child_node(r=
ef_fwnode,
> +                                                                     chi=
ld_name);
> +                       if (!ref_fwnode)
> +                               return -EINVAL;
> +               }
> +       }
> +
>         /*
>          * Assume the following integer elements are all args. Stop count=
ing on
>          * the first reference (possibly represented as a string) or end =
of the
> @@ -999,7 +1016,7 @@ int __acpi_node_get_property_reference(const struct =
fwnode_handle *fwnode,
>
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 acpi_fwnode_handle(device=
),
> -                                               &element, end, num_args);
> +                                               &element, end, num_args, =
true);
>                         if (ret < 0)
>                                 return ret;
>
> @@ -1017,7 +1034,7 @@ int __acpi_node_get_property_reference(const struct=
 fwnode_handle *fwnode,
>
>                         ret =3D acpi_get_ref_args(idx =3D=3D index ? args=
 : NULL,
>                                                 ref_fwnode, &element, end=
,
> -                                               num_args);
> +                                               num_args, false);
>                         if (ret < 0)
>                                 return ret;
>
> --
> 2.39.5
>
>

