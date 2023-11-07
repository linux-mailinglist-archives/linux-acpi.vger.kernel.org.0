Return-Path: <linux-acpi+bounces-1337-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78D37E49DA
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 21:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34935B20E68
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 20:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BE735884
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Nov 2023 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29236AF2
	for <linux-acpi@vger.kernel.org>; Tue,  7 Nov 2023 20:06:41 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D84D128;
	Tue,  7 Nov 2023 12:06:41 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6d3099818c0so1055720a34.1;
        Tue, 07 Nov 2023 12:06:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699387600; x=1699992400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZw5tqmxq7VgnYfY6zL2IsaNDalLmKPoaBBV7NkvLCM=;
        b=JxLsHBMRJlenu6+LIYnn63SKU6V+ONtnHcQfQJOinUM83Is2NB7Ltcmk5h6QHH7iDA
         E4AInXiUlltepbMMoGajXWC3sBJRe5XxULKleZnlgdMV7I9DAMf1FCi4Wxa4WgsCMtUB
         1TVwXVSqECw5J4TigwykZUOafTL3WPYFBuotqLOK/nnNvmAtxnUofIzs5etZG/X29UBY
         VCMuTAD+kWZ/rbtWbBuvUR1wU2NmECSayMY7WnJiu+zjZqDcX99qKWR5ExTAirTf/B4X
         KjvAkwr4aS5qmdVlvUn84TGCJMeckhdLWMotR3lWXD7FygcgWEUUCwkmfar4KJrWC5VW
         PHkQ==
X-Gm-Message-State: AOJu0YyuhEurB5pwSuHqrg1Ec34vb1ZCKoxXloRSAyspHXxjRvK0/+Ub
	QAJ5sWYJe0bLlO/XN+Jdqnugz1M3BVZFfH+IwNPAWKiD
X-Google-Smtp-Source: AGHT+IG723ltJ7FYoddM4b61QT2grhVaN+CNQgLOdxY2AZIeolK3Np3Yjeba3Ln5G0oKERTLHpMLls0cSFiHHf8u+N0=
X-Received: by 2002:a4a:3454:0:b0:583:ec88:e0 with SMTP id n20-20020a4a3454000000b00583ec8800e0mr204761oof.0.1699387600642;
 Tue, 07 Nov 2023 12:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4542595.LvFx2qVVIh@kreacher> <1987710.usQuhbGJ8B@kreacher> <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
In-Reply-To: <ZUlfuWB9z1tlOGG7@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Nov 2023 21:06:29 +0100
Message-ID: <CAJZ5v0hYDNaL3ydry12UWj6wLyTEfMSA0VGcZdQo00h+wexpNg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] ACPI: scan: Extract MIPI DisCo for Imaging data
 into swnodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Nov 6, 2023 at 11:33=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 06, 2023 at 05:27:26PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH] ACPI: scan: Extract MIPI DisCo for Imaging data into s=
wnodes
> >
> > Add information extracted from the MIPI DisCo for Imaging device
> > properties to software nodes created during the CSI-2 connection graph
> > discovery.
> >
> > Link: https://www.mipi.org/specifications/mipi-disco-imaging
> > Co-developed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > v2 -> v3:
> >    * Change the name of the new file to mipi-disco-img.c
> >    * "DiSco" -> "DisCo" in multiple places
> >    * Fix the link in the Link: tag
> >    * Change the number of data lanes limit and add a comment regarding =
it
> >    * Use ACPI_DEVICE_CSI2_DATA_LANES directly in several places instead
> >      of array sizes equal to it
>
> Thanks for the update. I've tested the set, so you can add:
>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> with the following diff fixing mipi-img-lane-polarities parsing:
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index 3123180d9b54..92b45e792a07 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -530,7 +530,12 @@ static void init_csi2_port(struct acpi_device *adev,
>         }
>
>         ret =3D fwnode_property_count_u8(port_fwnode, "mipi-img-lane-pola=
rities");
> -       if (ret * BITS_PER_TYPE(u8) >=3D num_lanes + 1) {
> +       if (ret < 0) {
> +               acpi_handle_debug(handle, "Lane polarity bytes missing\n"=
);
> +       } else if (ret * BITS_PER_TYPE(u8) < num_lanes + 1) {
> +               acpi_handle_info(handle, "Too few lane polarity bytes (%l=
u vs. %d)\n",
> +                                ret * BITS_PER_TYPE(u8), num_lanes + 1);
> +       } else {
>                 unsigned long mask =3D 0;
>                 int byte_count =3D ret;
>                 unsigned int i;
> @@ -543,15 +548,15 @@ static void init_csi2_port(struct acpi_device *adev=
,
>                  */
>                 BUILD_BUG_ON(BITS_PER_TYPE(unsigned long) <=3D ACPI_DEVIC=
E_CSI2_DATA_LANES);
>
> -               if (byte_count > ACPI_DEVICE_CSI2_DATA_LANES) {
> +               if (byte_count > sizeof(mask)) {
>                         acpi_handle_info(handle, "Too many lane polaritie=
s: %d\n",
>                                          byte_count);
> -                       byte_count =3D ACPI_DEVICE_CSI2_DATA_LANES;
> +                       byte_count =3D sizeof(mask);
>                 }
>                 fwnode_property_read_u8_array(port_fwnode, "mipi-img-lane=
-polarities",
>                                               val, byte_count);
>
> -               for (i =3D 0; BITS_PER_TYPE(u8) * i <=3D num_lanes; i++)
> +               for (i =3D 0; i < byte_count; i++)
>                         mask |=3D (unsigned long)val[i] << BITS_PER_TYPE(=
u8) * i;
>
>                 for (i =3D 0; i <=3D num_lanes; i++)
> @@ -561,8 +566,6 @@ static void init_csi2_port(struct acpi_device *adev,
>                                 PROPERTY_ENTRY_U32_ARRAY_LEN("lane-polari=
ties",
>                                                              port->lane_p=
olarities,
>                                                              num_lanes + =
1);
> -       } else {
> -               acpi_handle_info(handle, "Lane polarity bytes missing\n")=
;
>         }
>
>         swnodes->nodes[ACPI_DEVICE_SWNODE_EP(port_index)] =3D
>
> --

Thanks for testing and the fix!

I have folded it into the original patch and sent an update.

Also I have updated the git branch by replacing the original commit
with the updated one and I've added the Tested-by: tag to the commits
in it.

Thank you!

