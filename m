Return-Path: <linux-acpi+bounces-6025-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5AA8D1771
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 11:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4867DB23A78
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 09:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8D816A398;
	Tue, 28 May 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZPrCAB8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DC8169AC3;
	Tue, 28 May 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716889369; cv=none; b=pxAX38MwgG1vkCQB4Sa/xLvZMgfy2JD8XITFha1JiNyi8M4KyYu6hPY6JDcdZ28pLkP+K/U1l1phHjT7XHFjVH46QC6lOX6wfaXawjksXDPx+6zeqB6gAj2g4uBZQD5kKCOK/IgfBFxz/+j7DZprTi0ckqS9VpWPRSPQjhsKaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716889369; c=relaxed/simple;
	bh=UfrUJRalN+JaGQvgCby9CCp8D+8wPcMEPVXbXjcaw80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNdxnYWoLxOcei25k1ybXox4yLGdFauDyTPc9HGtj2mI8dy4+Fur4yL7LsU/faMf9boEJ24oGkpk9vkQQYTz050hqsNNuFa3WQBCEReJP+fg37xI57O2ICGWFdkBy93td5pQugGr43RlZ+jmOZ0AFKoeYVACrSX3CDw/mEJQhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZPrCAB8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1704EC32782;
	Tue, 28 May 2024 09:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716889369;
	bh=UfrUJRalN+JaGQvgCby9CCp8D+8wPcMEPVXbXjcaw80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mZPrCAB8rwfqX4hWOHBg2tn++8h//L9a7xXm/e10VmN5moXr0TPRti3yxqU/2AwmP
	 6SMmzKuSk+Ouoqf/Sy1+TB+Mn8k65HkKm05meoWuJv4DkkYLK9pZ2IEtFPH+hg+bph
	 gy/xjakhUgdm/u941YOEvnpexuRwhcn4kmbbyQfgwC8yYtpGnsqsdI+4wsLuOxH100
	 CRqGQg0zImD3OaHN0+leMQ2RHM+aNpKYUJ10wymxJdqfuz6oyPq+ovVsF4b2DcTiwr
	 TysycplcJ7pC5VILIO0W1zl2De2VZpjztudpKumPAJqDpUuFFJoJ+qDOVi+RmAToQP
	 4EK1Q/lB1Aw1g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b2e8d73bfcso76706eaf.1;
        Tue, 28 May 2024 02:42:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEM6KTiIO6qLMrqHSLZasBjfZ8TTgMBpyraS1G0Krl+dPOayO29Tgm9e+3wqUNVPkPGNHVQqymI7+HseFFhTuRhL8ifh3aVX41KnTUNT6o6tB53bNxYL9nTIaOtnWlOijFqdS5xB6tbQ==
X-Gm-Message-State: AOJu0YxaGCHC0DVTGR+UeAu5aLOHj/860yYNDUNnYDhA8tJ9TqX92ooh
	JvMt8Xh7v7u3ldt5QnNbm0KhYX42K3LLHkfhN7//xX9+wuLD9hm4y7MUNIgwbLfJ/QHys/Gk3zs
	KaBLsFGfDfgmDnjOAPV6sbAJtQF4=
X-Google-Smtp-Source: AGHT+IHScf/e/h5yrs0MCreiIIj2/v8nyVYmRkV0idFLCUnsAHi3hysArgPR9VGhqstXneHzgo1UBaqEkeIfAtgjCzA=
X-Received: by 2002:a05:6820:2e02:b0:5aa:3e4f:f01e with SMTP id
 006d021491bc7-5b961b691eemr11367417eaf.1.1716889368402; Tue, 28 May 2024
 02:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 11:42:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i8N-SuKyzm1o601G-G9Jis4uciu3gxO-08GN-X-z0LUA@mail.gmail.com>
Message-ID: <CAJZ5v0i8N-SuKyzm1o601G-G9Jis4uciu3gxO-08GN-X-z0LUA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Guanbing Huang <albanhuang@outlook.com>, 
	Guanbing Huang <albanhuang@tencent.com>, Woody Suwalski <terraluna977@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 10:24=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Since we have dev_is_pnp() macro that utilises the address of pnp_bus_typ=
e
> variable, the users, which can be compiled as modules, will be failed to
> build. Export the variable to the modules to prevent build breakage.
>
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Closes: https://lore.kernel.org/r/cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gm=
ail.com
> Fixes: 2a49b45cd0e7 ("PNP: Add dev_is_pnp() macro")
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/pnp/driver.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index 0a5d0d8befa8..1394d17bd6f7 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -265,6 +265,7 @@ const struct bus_type pnp_bus_type =3D {
>         .pm      =3D &pnp_bus_dev_pm_ops,
>         .dev_groups =3D pnp_dev_groups,
>  };
> +EXPORT_SYMBOL(pnp_bus_type);

Why not EXPORT_SYMBOL_GPL()?

>  int pnp_register_driver(struct pnp_driver *drv)
>  {
> --
> 2.45.1
>
>

