Return-Path: <linux-acpi+bounces-10594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55F7A107E4
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 14:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096621888382
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 13:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67141C4617;
	Tue, 14 Jan 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GRl2cYRH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74947232454;
	Tue, 14 Jan 2025 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861667; cv=none; b=hP1jIaNJWON8pd33EDaRL/WMKMwM63F4QYAK7wlZ55kZ3lCu+BI7qkA0o+CLg9NJ2Csuu0UbO4hJbIMJowau5mayJbWa/jm+cEpG7Vu5pi8hbCrpUKn/TLPUfpiWQhpGTvULvydfdxvwONXXnXjqZKunz87Jh2VJCOZ7XbtTo4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861667; c=relaxed/simple;
	bh=J5V9fZ2Qn+yCZ+qs8e/IvcPf6BGL44QEH3wliGkvwAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjZV0PM0xH1sjH+85yM96gaYFIJCdSi3YK4xW8zy5OQ1zcZZR82Q7aEE7cPOKa519OvlNs+XaXtN0cCcRMxXYrE6VMNazH5IJL+jzQ7lvxmUSeeh4Wq0DO8Wqls7C3RJY17jRDpjHBSZ4jXQRpsH+kcQzxqi4Oaf8cLexqkpR+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GRl2cYRH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F5CC4CEDD;
	Tue, 14 Jan 2025 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736861666;
	bh=J5V9fZ2Qn+yCZ+qs8e/IvcPf6BGL44QEH3wliGkvwAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GRl2cYRHszpAQCYwklwQWghidu33Woek/67fgBwdEbZ7PvJCDNNLpFQuoQeP6Tmh9
	 3WSJVN/6nvIwpfsF+0zQ+PAUKFcKd3Pf/5lGJcACHvTR5zg7b5MDeZYOqNkS8y6gC3
	 /RD7JK9mOx4WQkG048rM0FIoZJi1FpaHSwcPU4Z6v/l0eJSlp3C86ytgzkUQqNO9kh
	 j1PxYN3EOo6VgKjqnrw+qhC5x1SX6H5tnA6P6gyOKYI51qqh3IHQaPEUQdCIBDlxJK
	 rt//Cx+vxhKfxwoDN/XBU12PPMRYmtkr2gVnJBE3g1iNPzlfFfKWFZA94JLGA7B/yE
	 QF7pEiQhF6w9g==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3eb7edfa42dso2532889b6e.2;
        Tue, 14 Jan 2025 05:34:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGVzICKSfST/HITSpjM2RY6WkMJP274A9JuAN4zxOViNEi7N8Qd3/0ojVbfENoaLRnqiBpXprRWNhR@vger.kernel.org, AJvYcCWc9kdOIM85Z38jAUs1KK3gZU30fj7TBdP/hwextKS7UXoSCvAlWbQcggIQh/gIs+0MHn6PROI8tYIwIj09@vger.kernel.org
X-Gm-Message-State: AOJu0YzG4k5VfbvmYvYxFLVQ6zWB5lX2PlnApCvUVVVW9WZ5yjr7BciK
	O9o64Gc0g3xVhVdBRSZnj3qctVGlq047rWd3tOYVM+UcrgHzkBfeOmJxSKMYsKW6S7j+J85xBVw
	gBI+qp1c5UrJ9p2/1JSgqfX17nCE=
X-Google-Smtp-Source: AGHT+IGx6Hf8a5h39KKCDRvaV1ItYLUly0PY8AYW4exBkC+KwFfviVgphC9IC6aCX68K8TONq0Z8uQ4IDmk4y/hqrMc=
X-Received: by 2002:a05:6808:3989:b0:3ea:f791:3caf with SMTP id
 5614622812f47-3ef2ec56f60mr17665917b6e.17.1736861666104; Tue, 14 Jan 2025
 05:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224140131.30362-2-kuurtb@gmail.com> <20241224140131.30362-4-kuurtb@gmail.com>
In-Reply-To: <20241224140131.30362-4-kuurtb@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 14:34:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jRkDx1E+mW0dhD2f9Ow8GxeT-8AvYjcZOvoYC2+J07jg@mail.gmail.com>
X-Gm-Features: AbW1kvYdtcq_txu_kXtUGuhgkQp3-hQvhgWjXDbHDY_xCoM880TXBOD5LVwlwDc
Message-ID: <CAJZ5v0jRkDx1E+mW0dhD2f9Ow8GxeT-8AvYjcZOvoYC2+J07jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ACPI: platform_profile: Add devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>
Cc: platform-driver-x86@vger.kernel.org, W_Armin@gmx.de, hdegoede@redhat.com, 
	ilpo.jarvinen@linux.intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
	mpearson-lenovo@squebb.ca, rafael@kernel.org, soyer@irl.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2024 at 3:02=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote=
:
>
> Platform profile's lifetime is usually tied to a device's lifetime,
> therefore add a device managed version of platform_profile_register().
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

This is fine by me, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

and I think that it would be better to route it via platform/x86 along
with the second patch.

> ---
>  drivers/acpi/platform_profile.c  | 29 +++++++++++++++++++++++++++++
>  include/linux/platform_profile.h |  1 +
>  2 files changed, 30 insertions(+)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index 75a1415190ac..4c4200a0b1a6 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -519,6 +519,35 @@ int platform_profile_remove(struct platform_profile_=
handler *pprof)
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> +static void devm_platform_profile_release(struct device *dev, void *res)
> +{
> +       struct platform_profile_handler **pprof =3D res;
> +
> +       platform_profile_remove(*pprof);
> +}
> +
> +int devm_platform_profile_register(struct platform_profile_handler *ppro=
f)
> +{
> +       struct platform_profile_handler **dr;
> +       int ret;
> +
> +       dr =3D devres_alloc(devm_platform_profile_release, sizeof(*dr), G=
FP_KERNEL);
> +       if (!dr)
> +               return -ENOMEM;
> +
> +       ret =3D platform_profile_register(pprof);
> +       if (ret) {
> +               devres_free(dr);
> +               return ret;
> +       }
> +
> +       *dr =3D pprof;
> +       devres_add(pprof->dev, dr);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_platform_profile_register);
> +
>  static int __init platform_profile_init(void)
>  {
>         int err;
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index 0682bb4c57e5..f1cd4b65e351 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -41,6 +41,7 @@ struct platform_profile_handler {
>
>  int platform_profile_register(struct platform_profile_handler *pprof);
>  int platform_profile_remove(struct platform_profile_handler *pprof);
> +int devm_platform_profile_register(struct platform_profile_handler *ppro=
f);
>  int platform_profile_cycle(void);
>  void platform_profile_notify(struct platform_profile_handler *pprof);
>
> --
> 2.47.1
>

