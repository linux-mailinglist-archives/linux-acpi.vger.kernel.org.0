Return-Path: <linux-acpi+bounces-11263-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6448A3A4E7
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F99E168552
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61546270EC0;
	Tue, 18 Feb 2025 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbJCtyT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D7A26FDB7;
	Tue, 18 Feb 2025 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901885; cv=none; b=tYkNZ7Hxp97VJZbHjphKfszSb1zp3q+nIhM0vy/tmhjR39N5no+glz0EgS+OuKRgHPql95F1qTDhkH+6M7uUYGJNgb1FH5zFPoWXe9gMQ/HEf6ru3lnZC4K3ZvL52Ir6dWI28Z/dMxzLIbZsUWxdsiwUcPFz/dK3o/b4VYPVH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901885; c=relaxed/simple;
	bh=K1MQgtQMpAYOKptLlvAi8++cnfRAKCe3hfbb1sB6G/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpUfgYBSQb8EdO80cwOHc0eipusvCdax8xGGhL9fpBmpce6zP2FfZXueJgUAo40So01MGdFwB6tjpb3FeYJLJHvHzPzfstlNafd3ChR2dnS7Sw2n+wwE0rFLqyOXZI+ktLgPxrywEtvZg4OwEJOz+Bm13YXazif154h3C7ji1Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbJCtyT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A642EC4CEE8;
	Tue, 18 Feb 2025 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901883;
	bh=K1MQgtQMpAYOKptLlvAi8++cnfRAKCe3hfbb1sB6G/o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sbbJCtyTPzPc1wAb0IKtxW4rYOfUMNfnCgLtkihQbbVVrl7gBotnz/JoB78mfMMzU
	 ZAETI2iJR8ir5rljSwVgTurZXCfoQ9bp46CdXgSPTRAx/Q8lsnnFpGOcWI9V7/1/9b
	 5v15Q9P4tU4gRBIIo4o2fSxrw2Qf0Or7oIMFHYk3kr0SsD24Bi/+hk26t6+134Vgd8
	 4bNI1yS5SH5yk/PqDl3g7SS39VYNGRV96owwLfKuMtl7X4psJTXa+POPkV1zhwCXgK
	 teVr0pKlUcJNF99/lnLWLFNzLvRUKzdYL2aLXjJ0OgqwIGhcpcSj4xbGqbiayx2UCo
	 091jx0v2ATV4g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5fc69795ecbso2833013eaf.1;
        Tue, 18 Feb 2025 10:04:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUULLxf3sWZhCicmt92iG2gIDuy+R+aEXlm3ErLTHRFZwoLCGlGM3GccR0q/U6AOT6nieJ/BXYeBQdhsAeYUViGgDywcw==@vger.kernel.org, AJvYcCV/YTHDhAaJkaHh1nUZ/I0qV0rzXefYnx0d9a/4gxVo6MpvHw+qniv8VCPl6++Jw2v0r5v/8t1ckddz@vger.kernel.org, AJvYcCVMoDcx/fpYikixSQVMIjrV2C0hBVGl2N+nVkkQGM4WmoFZkHOfhW+0iDzcFsjZZG0/FtRTCWvvnPhSOHTI@vger.kernel.org
X-Gm-Message-State: AOJu0YyegoYwQ653TI9AgUXN2u/0vZyBKqp0mNwnbZ+QZweuqGF8Yc1T
	B4R4c8Zf7KDfvQuCwhBvypMOavWqdc4m3lmX5PujdUbmsrhbM+quVxlVPJa1bJuX2RqUHPqSwGj
	FmBeET7+7mW+/3vRb3q4ZDVVViFo=
X-Google-Smtp-Source: AGHT+IEBd/lGYlmKz5IXPZRcAwCG/IQG41R5xdPwkp1MAQpKXaru0Z1ZlEhvqLP4dIAk+b2rEWmAmE1R/PBN/D71JJg=
X-Received: by 2002:a05:6808:2188:b0:3f4:b6f:c49 with SMTP id
 5614622812f47-3f40b6f0e2emr1754189b6e.15.1739901882996; Tue, 18 Feb 2025
 10:04:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212190308.21209-1-kuurtb@gmail.com>
In-Reply-To: <20250212190308.21209-1-kuurtb@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 19:04:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iPGihaxsC02cgqzHqXJ+TfbPp0fJBWyWwPDC_wdEqtZA@mail.gmail.com>
X-Gm-Features: AWEUYZmOsYPysd-LRwcUv6jOiLJG6xUnyJGOt3SJxECO4_0hWY41yXZ98KQydRE
Message-ID: <CAJZ5v0iPGihaxsC02cgqzHqXJ+TfbPp0fJBWyWwPDC_wdEqtZA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: platform_profile: Improve platform_profile_unregister
To: Kurt Borja <kuurtb@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, platform-driver-x86@vger.kernel.org, 
	Mark Pearson <mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 8:03=E2=80=AFPM Kurt Borja <kuurtb@gmail.com> wrote=
:
>
> Drivers usually call this method on error/exit paths and do not check
> for it's return value, which is always 0 anyway, so make it void. This
> is safe to do as currently all drivers use
> devm_platform_profile_register().
>
> While at it improve the style and make the function safer by checking
> for IS_ERR_OR_NULL before dereferencing the device pointer.
>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
> Hi all,
>
> I made a little modification that I forgot in the last version.
>
> Rafael, please tell me if you prefer different commits for this. Also
> should we WARN_ON(IS_ERR_OR_NULL)?
>
> Based on the acpi branch of the linux-pm tree.
>
> ~ Kurt
>
> Changes in v2:
>   - Get reference to pprof after checking for IS_ERR_OR_NULL(dev)
>   - CC Mark Pearson (sorry!)
>
>  drivers/acpi/platform_profile.c  | 19 +++++++++----------
>  include/linux/platform_profile.h |  2 +-
>  2 files changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index fc92e43d0fe9..ed9c0cc9ea9c 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -569,24 +569,23 @@ EXPORT_SYMBOL_GPL(platform_profile_register);
>  /**
>   * platform_profile_remove - Unregisters a platform profile class device
>   * @dev: Class device
> - *
> - * Return: 0
>   */
> -int platform_profile_remove(struct device *dev)
> +void platform_profile_remove(struct device *dev)
>  {
> -       struct platform_profile_handler *pprof =3D to_pprof_handler(dev);
> -       int id;
> +       struct platform_profile_handler *pprof;
> +
> +       if (IS_ERR_OR_NULL(dev))
> +               return;
> +
> +       pprof =3D to_pprof_handler(dev);
> +
>         guard(mutex)(&profile_lock);
>
> -       id =3D pprof->minor;
> +       ida_free(&platform_profile_ida, pprof->minor);
>         device_unregister(&pprof->dev);
> -       ida_free(&platform_profile_ida, id);
>
>         sysfs_notify(acpi_kobj, NULL, "platform_profile");
> -
>         sysfs_update_group(acpi_kobj, &platform_profile_group);
> -
> -       return 0;
>  }
>  EXPORT_SYMBOL_GPL(platform_profile_remove);
>
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index 8ab5b0e8eb2c..d5499eca9e1d 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -47,7 +47,7 @@ struct platform_profile_ops {
>  struct device *platform_profile_register(struct device *dev, const char =
*name,
>                                          void *drvdata,
>                                          const struct platform_profile_op=
s *ops);
> -int platform_profile_remove(struct device *dev);
> +void platform_profile_remove(struct device *dev);
>  struct device *devm_platform_profile_register(struct device *dev, const =
char *name,
>                                               void *drvdata,
>                                               const struct platform_profi=
le_ops *ops);
>
> base-commit: 3e3e377dd1f300bbdd230533686ce9c9f4f8a90d
> --

Applied as 6.15 material with minor edits in the changelog, thanks!

