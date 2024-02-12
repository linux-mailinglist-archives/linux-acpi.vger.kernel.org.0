Return-Path: <linux-acpi+bounces-3418-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54342851663
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 15:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE191F2194E
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1415A3BB51;
	Mon, 12 Feb 2024 13:53:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15C47F69
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746006; cv=none; b=FzdeBTNQS8S7C0SJQoUdvdc2EM7W8rhoPOt1ofYjfrGMOXs9+QQ/Z+TwmgM/7Co/UiMLW935KcUgWRVWdSfgIAKrm+9da0secLeK6FemY9n7jiOSRkKphdbBe7BqFrAuw3KvbDbApSMqP3aVTcLjEcfvV9uDwH8dg26Nxc4hfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746006; c=relaxed/simple;
	bh=a0fIs43l0kNac1ql+AO8GJZjA9xTDR1eG+x80h9YCY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxSNl+cX7IDdJIrDOKiu3esBat6JKBYSYTqbZVoy92unV8dR1+qr/JPKCKTNCWNtC1YmUZpCvx/rA393b/0PfLs7lRSx6Puq0z2UzzdiGDlFPgRJqrAE3AldQ6/7pTnKtxXAbaD0+mlkCJ95f2AQWy/KqFZTV68QPm+NQGnWw8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-59584f41f1eso1352533eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 05:53:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746003; x=1708350803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=87pfZFtXBQk1+BXXsCkTtOkBkN0+Y6V6U8LvaBJu1xY=;
        b=ZhnrHEPFH/5/VFCrDTbCknLcdv0AZ5U6tB9XXxaohMCTv4usvUzaQhdu43d5xoRKsk
         w260KUlunUkFGeahoot02h8RduS2fjPzqsQXrr3VIe9o/Kc5YEH31mGPaI8yGWhtqiLk
         OuLjXlp6DIJf/ROkAIYybXCRF44DL8Ulj21kOeKb1ixSmQfwBMynLlb2lRpsKag4dF2B
         OqcJb3KSPIsdgDp1GA/TdLff2pKADaux0R21/JcL9hmwR3C9qdNIztQs20dTC5A3U39h
         i38N5y3hufY/w0O3pNE0+jJVCiQT0h1EuANVH0JF+sTXrdjlWRMVf2U6n58dXxPzCEIo
         69TA==
X-Gm-Message-State: AOJu0YwmbyWoJxilg6AgPPMzhXvJpHQigXJt1JHN60n1AJHINsXqiA0s
	JVQydnWvA5gqWAlKx6TBX1PUjtzSjXQ/7Saymn2vz7j0e5i/3ytdLQwEjMrhnh/AjG6QdHlvPOL
	M46hP5ud31g4jw3GGWlo3x1SFOfr9yndl
X-Google-Smtp-Source: AGHT+IHbQGmHmP0EUHEza1uSwwEA2ML2Y2RA8251Qe60/CWn633INB/awud48+27Fgn3GyxsEUWVzCvhpqioHHbNqjo=
X-Received: by 2002:a05:6820:2b12:b0:59a:bf5:a0da with SMTP id
 dt18-20020a0568202b1200b0059a0bf5a0damr4790742oob.0.1707746003449; Mon, 12
 Feb 2024 05:53:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212100032.346422-1-sakari.ailus@linux.intel.com> <20240212100032.346422-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20240212100032.346422-3-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:53:12 +0100
Message-ID: <CAJZ5v0jOZJDJ=zqY09gYM7SrN0AB+SzdoGpF3i4F2YQiTtd8Og@mail.gmail.com>
Subject: Re: [PATCH 2/2] ACPI: property: Ignore bad data nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There is a bit too little information in the subject, it may as well
be the same as the series title.

On Mon, Feb 12, 2024 at 11:08=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Some systems were shipped with both Windows and Linux camera descriptions=
.
> In general, if Linux description exist, they will be used and Windows
> description ignored.
>
> In this case the Linux descriptions were buggy so use Windows definition
> instead. The corresponding information has been added to ipu-bridge to
> cover the missing bits.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/acpi/internal.h       |  1 +
>  drivers/acpi/mipi-disco-img.c | 71 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/property.c       |  3 ++
>  3 files changed, 75 insertions(+)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 6588525c45ef..e0145df519bd 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -301,5 +301,6 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
>  void acpi_mipi_scan_crs_csi2(void);
>  void acpi_mipi_init_crs_csi2_swnodes(void);
>  void acpi_mipi_crs_csi2_cleanup(void);
> +bool acpi_graph_ignore_port(acpi_handle handle);
>
>  #endif /* _ACPI_INTERNAL_H_ */
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index 7286cf4579bc..2b806112a05a 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -19,6 +19,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/dmi.h>
>  #include <linux/limits.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
> @@ -723,3 +724,73 @@ void acpi_mipi_crs_csi2_cleanup(void)
>         list_for_each_entry_safe(csi2, csi2_tmp, &acpi_mipi_crs_csi2_list=
, entry)
>                 acpi_mipi_del_crs_csi2(csi2);
>  }
> +
> +static const struct dmi_system_id dmi_ignore_port_nodes[] =3D {
> +       {
> +               .matches =3D {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> +               },
> +       },
> +       { 0 }
> +};
> +
> +static const char *strnext(const char *s1, const char *s2)
> +{
> +       s1 =3D strstr(s1, s2);
> +
> +       if (!s1)
> +               return NULL;
> +
> +       return s1 + strlen(s2);
> +}
> +
> +/**
> + * acpi_graph_ignore_port - Tell whether a port node should be ignored
> + * @handle: The ACPI handle of the node (which may be a port node)
> + *
> + * Returns true if a port node should be ignored and the data to that sh=
ould
> + * come from other sources instead (Windows ACPI definitions and
> + * ipu-bridge). This is currently used to ignore bad port nodes related =
to IPU6
> + * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems w=
ith
> + * Intel VSC.
> + */
> +bool acpi_graph_ignore_port(acpi_handle handle)
> +{
> +       const char *path =3D NULL, *orig_path;
> +       static bool dmi_tested =3D false, ignore_port;

It is not necessary to initialize static variables to false.

> +
> +       if (!dmi_tested) {
> +               ignore_port =3D dmi_first_match(dmi_ignore_port_nodes);
> +               dmi_tested =3D true;
> +       }
> +
> +       if (!ignore_port)
> +               return false;
> +
> +       /* Check if the device is either "IPU" or "LNK" (sensor). */
> +       orig_path =3D acpi_handle_path(handle);
> +       if (!orig_path)
> +               return false;
> +       path =3D strnext(orig_path, "IPU");
> +       if (!path)
> +               path =3D strnext(orig_path, "LNK");
> +       if (!path)
> +               goto out_free;
> +
> +       if (!(path[0] >=3D '0' && path[0] <=3D '9' && path[1] =3D=3D '.')=
)
> +               goto out_free;
> +
> +       /* Check if the node has a "PRT" prefix. */
> +       path =3D strnext(path, "PRT");
> +       if (path && path[0] >=3D '0' && path[0] <=3D '9' && !path[1]) {
> +               acpi_handle_debug(handle, "ignoring data node\n");
> +
> +               kfree(orig_path);
> +               return true;
> +       }
> +
> +out_free:
> +       kfree(orig_path);
> +       return false;
> +}
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index a6ead5204046..2b73580c9f36 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -80,6 +80,9 @@ static bool acpi_nondev_subnode_extract(union acpi_obje=
ct *desc,
>         struct acpi_data_node *dn;
>         bool result;
>
> +       if (acpi_graph_ignore_port(handle))
> +               return false;
> +
>         dn =3D kzalloc(sizeof(*dn), GFP_KERNEL);
>         if (!dn)
>                 return false;
> --
> 2.39.2
>

