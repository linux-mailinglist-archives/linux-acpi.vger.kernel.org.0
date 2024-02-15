Return-Path: <linux-acpi+bounces-3566-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A0856E4E
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 21:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B5A1C23709
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 20:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6E13A88F;
	Thu, 15 Feb 2024 20:08:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F3F1384B8
	for <linux-acpi@vger.kernel.org>; Thu, 15 Feb 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708027684; cv=none; b=gJzyvl6ivm4hDvLGtfNntexJclNbCsVUqN7XPW/BM+haPXWNSKtXn80a4Amuxlyk7l+aMVNibEfBKF/CySVHyMYLKPGvTM95CvSnO1nbo3SA6Tal+4Dn3/pArQ4ARgAwl5277HPW0cpIUh3oLn8kmhIIH80+YfdU0VNYFlBTDYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708027684; c=relaxed/simple;
	bh=gTIWM0K2P2AYULD5mT522vgaLYsmAogxHR2/BjFu0ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIGNBxo58btPwmEqqoYMB3UdNiBHEH4suAFD0EYC1MhuLUmOjl4IYJPYqvO/qHzMtJdqdI7kSQuUJ3Qav+TN4hBaiPat/yEcuY2sXy3FDr82VAkGr7xrZUTZ697DyUvxjxwkjz8AEFzYd/5XZJkuqM3lb7szJQpLaFBZ6jFmCuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-59584f41f1eso427040eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 15 Feb 2024 12:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708027682; x=1708632482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hUZgi+rPfBnzOb5QTkA30pRH7kDBSpF/gUuPEZHA2TU=;
        b=sqHCkGrLc4fK1m7jb3HdubplHr5n5FXKFtvbCaaAgKomlxJVHWe00W8fPqe2uM7Nna
         1INy/4PPyquzhdXt7v9XU6cgSEcNKE4Fc6g/UIOYMUGeNKHU72roRvuN/1b8O3V7UUAh
         AMCU/yMMCP9pvCX9vJke4ye63juQU3ypduIW7/eriefDYVCGSQxKJ8BqHpnNiMCARsEg
         WXlbBFnDDZqULU271eFjQewkBfOt+vZ8AlDZNf9KBj+8s6PHsw5mPSbWFiPZ8QygsZ03
         YK4PNYRXEHO9ZykXBTo1dM+HfzM1DmJ2EwPhndxmpEDnRyw+RN81rHq4jupk1JfUnBH2
         Ddxw==
X-Gm-Message-State: AOJu0Yytja6hUqLHcVjFZGgzxsEG5ScLnjGyxTZFzFkn+gb2evUw+GMK
	DVfXHPDWF5ynRSDzM0C7KCrvSKeFdWCMl/e0JjIjQ6uUqn/YJTSDVLFOn1Lf2DMpbIgSK1lEruM
	6BOSR56I98EqaZi8cJbPFzNakIDY=
X-Google-Smtp-Source: AGHT+IGA7d/ccioCmDOJijKhCzF8CZ9Prunui6vKWkX0hnTs0Ofw+Hha+9hOf/qAWbvC0BE8YzvYEF9g+o7QNCVT914=
X-Received: by 2002:a05:6820:134d:b0:59f:881f:9318 with SMTP id
 b13-20020a056820134d00b0059f881f9318mr3180727oow.0.1708027682013; Thu, 15 Feb
 2024 12:08:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213134606.383817-1-sakari.ailus@linux.intel.com> <20240213134606.383817-3-sakari.ailus@linux.intel.com>
In-Reply-To: <20240213134606.383817-3-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2024 21:07:50 +0100
Message-ID: <CAJZ5v0iGRf2OQPjWDVRHHQzYUOt--mbWqZ1Nrzsi01YE_qa-jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: property: Ignore bad graph port nodes on
 Dell XPS 9315
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 2:46=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Some systems were shipped with both Windows and Linux camera descriptions=
.
> In general, if Linux description exist, they will be used and Windows
> description ignored.
>
> In this case the Linux descriptions were buggy so use Windows definition
> instead. This patch ignores the bad graph port nodes on Dell XPS 9315 and
> there are likely other such systems, too. The corresponding information
> has been added to ipu-bridge to cover the missing bits.
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
> index 7286cf4579bc..da71eb4bf6a6 100644
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
> +       static bool dmi_tested, ignore_port;
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

Applied as 6.9 material along with the [1/2], thanks!

