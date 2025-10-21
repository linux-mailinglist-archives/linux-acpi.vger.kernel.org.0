Return-Path: <linux-acpi+bounces-18060-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90741BF8520
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 514334E86E6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F6E271A7C;
	Tue, 21 Oct 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpgDklN4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D1B270EC1
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761076302; cv=none; b=Wgb6PqjMp0tlK0fQHAPLtQMwJQ0IH4+nxRqYFDchyXqUDBfi1rwbaIl8mh8S3F+LF9iePLbJ61fvu13byZ452kkfAgaTlJyHQ51wKPg/vQuYcpxM7x2DSK1UVDlAMlOmeHzC9BHDKT20FIMzyNi53nUV5/JLExYwxr69hQnzJ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761076302; c=relaxed/simple;
	bh=XLbf5oEiWlO8N+c1wGOVgveqQMnq/C9ab1fUP4VxgFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMo43ZgNRxn3XonT8Zhsdx7ow+mjjTwVxJ+1urS2VSiV93YEW643pX3IZGWBczyjXkgx6FylvuVnQnU9ixRbyqcsgNuh+r+iQtY2M0JMNXG5QPfNWjuO5+ba4Kctw6VlGF2PsfmNiNzTN0LuXUsKq+KjFhUn1hO4utnW/rfa6Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpgDklN4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1BAC4AF09
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761076302;
	bh=XLbf5oEiWlO8N+c1wGOVgveqQMnq/C9ab1fUP4VxgFg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jpgDklN49emVSnhPZ+Izio/0U7Ups3RgflxYFT5VizB6hghoZe0PQm5RcbR51Ax58
	 S6xVnuQ6lZmTz2PK6AoOmr6FfDmfV7UFGKDyNm9/zWBHrPQDlanAPsIIE93p6A1aBD
	 XycsXCF/3x9sL+EnhiI+BAoNNtxa27WvZxh7AbuLm8sRj+clXemLhVRwbwsg6gbF5y
	 yqzBDpQALiVBzxpp2v1ZAC4Z3eQIf4+0wZQarPHQBZjIImNJgBk6xKtrZpRYZ03QhY
	 1p228nESaq0uYmVRYsipv75Ui5jadO7SK5TBbAAOgxZARR6t/CiJy44UybalzKrhay
	 Q78SBOtY3A/iw==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-443a2689160so2669771b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 12:51:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXhuEvN5Ww2CXsXyjX8UyJl8hDa7Lj/FEEpzvQc+62Q5z6QByjgoig8aeY3IA1WFvEvMYoa6NmpeyWs@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqw/k8FdJ5HS+s9d6UKDRLdT+0ubOODjUUkBs+0XQxeBxOxPPP
	ecUle8R3+ljCS5gS87vcYE0oYK4vKHtW6w5E2GarjRlVhAXf2yeZAGP2Eg79hk8ouvlqXgdZfY/
	99YhSesRzpOW58wmcprzuSQ8R7A9OFOY=
X-Google-Smtp-Source: AGHT+IG6C4hA4WZmIVeKxGy3AcdX1xs9xC6ashyPDuresMtEN5HmQB9W8T6cJCjHatKDYXeV7MMWg/9Odma/kTsnB0c=
X-Received: by 2002:a05:6808:319b:b0:441:d41e:6589 with SMTP id
 5614622812f47-443a2dd4927mr7483910b6e.8.1761076301553; Tue, 21 Oct 2025
 12:51:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-8-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-8-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:51:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4F5fPwhKup768EUdgWfUHXATiK0zuNwK2fJyC2fqy2A@mail.gmail.com>
X-Gm-Features: AS18NWCF5Fuv-Zx_i_QGi42XDYDWF4BzdeAzdS10zFH1NjzASMTnE_QOFwcpHWQ
Message-ID: <CAJZ5v0j4F5fPwhKup768EUdgWfUHXATiK0zuNwK2fJyC2fqy2A@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] ACPI: processor: idle: Remove died codes about the
 verification of cstate count
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> The acpi_processor_setup_cstates and acpi_processor_setup_cpuidle_cx will
> be called after successfully obtaining the power information. These setup
> functions have their own main role, but also verify the validity of cstat=
e
> count.
>
> Actually, the acpi_processor_get_power_info_cst() will return failure
> if the cstate count is zero and acpi_processor_get_power_info() will retu=
rn
> failure.
>
> So the verification of cstate count in these functions are died code.

It is useless overhead rather because the conditions checked cannot be true=
.

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 92b231f5d514..2d672afc7498 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -732,8 +732,8 @@ static int __cpuidle acpi_idle_enter_s2idle(struct cp=
uidle_device *dev,
>         return 0;
>  }
>
> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> -                                          struct cpuidle_device *dev)
> +static void acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> +                                           struct cpuidle_device *dev)
>  {
>         int i, count =3D ACPI_IDLE_STATE_START;
>         struct acpi_processor_cx *cx;
> @@ -753,14 +753,9 @@ static int acpi_processor_setup_cpuidle_cx(struct ac=
pi_processor *pr,
>                 if (count =3D=3D CPUIDLE_STATE_MAX)
>                         break;
>         }
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
> -static int acpi_processor_setup_cstates(struct acpi_processor *pr)
> +static void acpi_processor_setup_cstates(struct acpi_processor *pr)
>  {
>         int i, count;
>         struct acpi_processor_cx *cx;
> @@ -822,11 +817,6 @@ static int acpi_processor_setup_cstates(struct acpi_=
processor *pr)
>         }
>
>         drv->state_count =3D count;
> -
> -       if (!count)
> -               return -EINVAL;
> -
> -       return 0;
>  }
>
>  static inline void acpi_processor_cstate_first_run_checks(void)
> @@ -1246,7 +1236,8 @@ static int acpi_processor_setup_cpuidle_states(stru=
ct acpi_processor *pr)
>         if (pr->flags.has_lpi)
>                 return acpi_processor_setup_lpi_states(pr);
>
> -       return acpi_processor_setup_cstates(pr);
> +       acpi_processor_setup_cstates(pr);
> +       return 0;
>  }
>
>  /**
> @@ -1266,7 +1257,8 @@ static int acpi_processor_setup_cpuidle_dev(struct =
acpi_processor *pr,
>         if (pr->flags.has_lpi)
>                 return 0;
>
> -       return acpi_processor_setup_cpuidle_cx(pr, dev);
> +       acpi_processor_setup_cpuidle_cx(pr, dev);
> +       return 0;
>  }
>
>  static int acpi_processor_get_power_info(struct acpi_processor *pr)
> --
> 2.33.0
>

