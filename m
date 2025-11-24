Return-Path: <linux-acpi+bounces-19223-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B732C82332
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A94A634B1BC
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20463242A0;
	Mon, 24 Nov 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLVBrcQz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987883233FA
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010498; cv=none; b=IlcSiJ0pw4UNfkFrTZ0NG8P+sfRuIhljPIpa/TC7VtTs4ogkYLC9M5ijosuDNKsQX30inCnpQ8m3NJXGwm3f6xAVScrcjVFG/1WqwOOUc/d6k5+NemCLtECWC4O/2QsfibJpas02z4ujm7sHgZ6Ep3cBzD6Vn//njMx7k4cVJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010498; c=relaxed/simple;
	bh=sumFJ1oLocBysOk3GVtwaNor6IvDUUevk4blcuIpd1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bwi+dqMYxeBVh05GoKpluD2PDEl/xfba/KeX8diR3fcC3wLC2sfI11W+UYE9nINZqMqqeFwNWIUYeUif8tUvyEEeys/p6DhXnJkwS+uL7aBdF9NL3p2IBMZB4utzrm1MA9yrASvm2TbeJ3VbSMRwV16ZlqlXfhKEMLEbyHWD/7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLVBrcQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40059C19424
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 18:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010498;
	bh=sumFJ1oLocBysOk3GVtwaNor6IvDUUevk4blcuIpd1s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YLVBrcQzVuyAoa4VoiILF8PBq4nxgnXFzUzAMZSkC9Kx2AGRHwa08y9Q/T2M3LeKb
	 5e7fFwa9VAuh2puinSsGL9K5TvQEl4uF+TxuC9xJEryJAVthnd4JRCn0MdujTYMGRu
	 LJM8QekWqeI72L6i6E9M8TA+zMgmORe2tSrwyqjjBOjTB9khjAgmOnxatasMo+PK7/
	 eekinqz8Dx/SWwDFIzJoyq3KYLhM3J1r1qoF4q4TJoSxc2RnEbVVXNlpk1qs6uRYGM
	 Gmu4tVxVMnwwgPnY/gnKGUateVHa2FH0NXeOm5FG8w8PwtVGNz/cdWqyPy2tH7UzFC
	 XNbeX1EXh1hrg==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6ce4f65f7so3424246a34.0
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 10:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+QPnvhiwjfnl3RLW0rPcQ33T1x6NzeuzFsSeiAi+4RjqN1HJie6Dgvi/Ztd+PEbexAiMN5ozYn0IF@vger.kernel.org
X-Gm-Message-State: AOJu0YxBomEyljiYbGA3+gih58fGQ3sOuakZrA0fbc/0uUMoZrtIq673
	deZBGPBa0lWa7Dqj3rOYC/w9FeEWWgC3btjjnmwTHDNG8oKO6m7YnmuoG2u6DObzPcrpLnQgH2W
	lVf9Mt+iqk++AglXtWscgblL1HDkqtL8=
X-Google-Smtp-Source: AGHT+IHGHVnUtJr2c1uMaKhAStrka7Ghs4Uk7LmljAS7InKcIC4oFzy+NbvtllycWAH/MycWz6COu4abDBToDJDYnWQ=
X-Received: by 2002:a05:6808:2219:b0:44f:e801:d6d6 with SMTP id
 5614622812f47-4514e5f9410mr103695b6e.6.1764010497349; Mon, 24 Nov 2025
 10:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107184438.1328717-1-usama.anjum@collabora.com> <20251107184438.1328717-5-usama.anjum@collabora.com>
In-Reply-To: <20251107184438.1328717-5-usama.anjum@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 19:54:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iucMXFkKuRxtAUyAqW11NHHGVuYnjJNbroeMgJoGY1kw@mail.gmail.com>
X-Gm-Features: AWmQ_bkKLLhFtJAdI15Z9tDKN1qk0_d1G7grayFeH9ds__gFAk7Upw4JP1dKaXg
Message-ID: <CAJZ5v0iucMXFkKuRxtAUyAqW11NHHGVuYnjJNbroeMgJoGY1kw@mail.gmail.com>
Subject: Re: [PATCH 4/4] PM: sleep: clear pm_abort_suspend at suspend
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-input@vger.kernel.org, kernel@collabora.com, superm1@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 7:45=E2=80=AFPM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Clear pm_abort_suspend counter in case a wakeup is detected during
> hibernation process. If this counter isn't reset, it'll affect the
> next hibernation cycle and next time hibernation will not happen as
> pm_abort_suspend is still positive.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  drivers/base/power/main.c | 2 ++
>  kernel/cpu.c              | 1 +
>  kernel/power/hibernate.c  | 5 ++++-
>  kernel/power/process.c    | 1 +
>  4 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 5760abb25b591..84e76f8df1e02 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1642,6 +1642,7 @@ static void device_suspend_late(struct device *dev,=
 pm_message_t state, bool asy
>                 goto Complete;
>
>         if (pm_wakeup_pending()) {
> +               pm_wakeup_clear(0);
>                 WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
> @@ -1887,6 +1888,7 @@ static void device_suspend(struct device *dev, pm_m=
essage_t state, bool async)
>
>         if (pm_wakeup_pending()) {
>                 dev->power.direct_complete =3D false;
> +               pm_wakeup_clear(0);
>                 WRITE_ONCE(async_error, -EBUSY);
>                 goto Complete;
>         }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index db9f6c539b28c..74c9f6b4947dd 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1921,6 +1921,7 @@ int freeze_secondary_cpus(int primary)
>
>                 if (pm_wakeup_pending()) {
>                         pr_info("Wakeup pending. Abort CPU freeze\n");
> +                       pm_wakeup_clear(0);
>                         error =3D -EBUSY;
>                         break;
>                 }
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e15907f28c4cd..1f6b60df45d34 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -349,8 +349,10 @@ static int create_image(int platform_mode)
>                 goto Enable_irqs;
>         }
>
> -       if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
> +       if (hibernation_test(TEST_CORE) || pm_wakeup_pending()) {
> +               pm_wakeup_clear(0);
>                 goto Power_up;
> +       }
>
>         in_suspend =3D 1;
>         save_processor_state();
> @@ -660,6 +662,7 @@ int hibernation_platform_enter(void)
>                 goto Enable_irqs;
>
>         if (pm_wakeup_pending()) {
> +               pm_wakeup_clear(0);
>                 error =3D -EAGAIN;
>                 goto Power_up;
>         }
> diff --git a/kernel/power/process.c b/kernel/power/process.c
> index dc0dfc349f22b..e935b27a04ae0 100644
> --- a/kernel/power/process.c
> +++ b/kernel/power/process.c
> @@ -67,6 +67,7 @@ static int try_to_freeze_tasks(bool user_only)
>                         break;
>
>                 if (pm_wakeup_pending()) {
> +                       pm_wakeup_clear(0);
>                         wakeup =3D true;
>                         break;
>                 }
> --

I don't think pm_wakeup_clear() needs to be called in so many places.

Any why isn't it sufficient to call it in freeze_processes()?  For
suspend, it is sufficient, so what's different about hibernation in
that respect?

