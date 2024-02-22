Return-Path: <linux-acpi+bounces-3877-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5D860349
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 20:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30A09B31E0B
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 19:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9701C548FD;
	Thu, 22 Feb 2024 19:34:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062EC548E6
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708630498; cv=none; b=sY0f2YL8celYBdQ5Rnps5Atg8YwtoUcT8Edz5ioTeFxH9JI9EQh50j9euP0MqC64w61OyMdq2xlhgxRYCjWqASbuvzu5aR8EAMlkV2lco1GmsqyD7b0AxOzV+5f6XnIGLyjuoDH7BfWYgfW2gN3H0OZTFrTN9Hkt0o/DnCqklMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708630498; c=relaxed/simple;
	bh=GIUPpOX6sWw7yIdM/OGEErmL8k21/n+H9qssV0Wrmm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/Rh9N1eHs1YumSxC7YZV9gvgOX/2r4eSrCst6OpZQqh6i9WxgtUJVkzCshGGD4hHJUMXjRHNHcts0VxNjs5n2ij/+BnfU2FYL3IsSmIHyC+rL+d57OUxUoIK5b5hhGoNHRDg365g/ZKBE3Sk+waTZUSWXeLonqUjt1yaQDp6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e45f7c63f4so293901a34.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 11:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708630496; x=1709235296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWMB93Yce+qvbP3XGZ4gkn9Tf1QMCG9ANHfkLhDRC8A=;
        b=I5JocjzrSAbDtLk9xdzAnV2yH3He/5+bBOolECbMvy58CwtX5M6LEEAaO39EvRZLxE
         1us3lJMA5Rsalx077tkqn/gRZZmE0PaWXIb9UXGPtJ++yNU85Etxk9RRrIPX++vXHUGo
         KwQQC5btE5qnZSrKqXr5+6ioM0KT07x3km1BF53S1fp53RTLd/R+EOaNoRgyjALXGCn+
         EMbaZVyvz0iuYOYnWCV00n4Rtsh1lXrlFPAMDrB0x23SNFsVi0nzwlWuWUP6lcME/86U
         kDz7bveaB2h6KxoVuG/Dz4UauutyvRkPJkR/ricp+11mlUYwioB3a5ulLaTM+tiRpgNR
         8klA==
X-Gm-Message-State: AOJu0YzdbqbpkM8T2bBOsT8ViRRL5DhrXBJqgkeckG/LmcU7t04LHglo
	zVT6UyA3mS0IyIogXnZnYz4qYJ55AGuFqp/sn1LXmMMWPmzWHZ/9YOvRZfKK2ubdL8b/OshR8TO
	IKwDDyiMkzk7uBo2351LnY5lQZjTr3YTy
X-Google-Smtp-Source: AGHT+IHQThqkaojGtInB8FGkFJQufMjaQ7bQNlq5hiQHvKF+PDnQIYfef0lsGEVNu7kkjwwLdBQT5IaynElmFGkXh5w=
X-Received: by 2002:a4a:c3cb:0:b0:5a0:3d13:a45a with SMTP id
 e11-20020a4ac3cb000000b005a03d13a45amr708319ooq.0.1708630496186; Thu, 22 Feb
 2024 11:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222141321.616794-1-sakari.ailus@linux.intel.com>
In-Reply-To: <20240222141321.616794-1-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 20:34:45 +0100
Message-ID: <CAJZ5v0jOtP1hJCyg4cosy+dEvxHiU0GeZwSTNMzqLGw-hzQs-g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Polish ignoring bad data nodes
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 3:13=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Clean up ignoring data nodes in mipi-disco-img.c: use { } initialiser, fi=
x
> a kernel-doc warning and use isdigit().
>
> Fixes: 6018731b04ca ("ACPI: property: Ignore bad graph port nodes on Dell=
 XPS 9315")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
> Hi Rafael,
>
> Feel free to squash this to the original patch.
>
>  drivers/acpi/mipi-disco-img.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.=
c
> index da71eb4bf6a6..d05413a0672a 100644
> --- a/drivers/acpi/mipi-disco-img.c
> +++ b/drivers/acpi/mipi-disco-img.c
> @@ -732,7 +732,7 @@ static const struct dmi_system_id dmi_ignore_port_nod=
es[] =3D {
>                         DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
>                 },
>         },
> -       { 0 }
> +       { }
>  };
>
>  static const char *strnext(const char *s1, const char *s2)
> @@ -749,7 +749,7 @@ static const char *strnext(const char *s1, const char=
 *s2)
>   * acpi_graph_ignore_port - Tell whether a port node should be ignored
>   * @handle: The ACPI handle of the node (which may be a port node)
>   *
> - * Returns true if a port node should be ignored and the data to that sh=
ould
> + * Return: true if a port node should be ignored and the data to that sh=
ould
>   * come from other sources instead (Windows ACPI definitions and
>   * ipu-bridge). This is currently used to ignore bad port nodes related =
to IPU6
>   * ("IPU?") and camera sensor devices ("LNK?") in certain Dell systems w=
ith
> @@ -778,12 +778,12 @@ bool acpi_graph_ignore_port(acpi_handle handle)
>         if (!path)
>                 goto out_free;
>
> -       if (!(path[0] >=3D '0' && path[0] <=3D '9' && path[1] =3D=3D '.')=
)
> +       if (!(isdigit(path[0]) && path[1] =3D=3D '.'))
>                 goto out_free;
>
>         /* Check if the node has a "PRT" prefix. */
>         path =3D strnext(path, "PRT");
> -       if (path && path[0] >=3D '0' && path[0] <=3D '9' && !path[1]) {
> +       if (path && isdigit(path[0]) && !path[1]) {
>                 acpi_handle_debug(handle, "ignoring data node\n");
>
>                 kfree(orig_path);
> --

Applied, thanks!

