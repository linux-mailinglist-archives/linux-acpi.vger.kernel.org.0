Return-Path: <linux-acpi+bounces-19222-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE62C82273
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 439B54E5BC0
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Nov 2025 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856AA2D24BF;
	Mon, 24 Nov 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tr+P/AkV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BEB2BE053
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764010235; cv=none; b=U2WdakJnK+LkHIs8K/B14bbuT2XG7urqDZA7QScn3y4hGJGZ/S3ldorq/rshWag35vocyZvxxrXIZ9XXYxR7ewwkLZIW7sgUtL7acuKh+bf2681+JEntv7NRjKSptB91uNCyACRccvJQsxUPSUO6yCF6Fp2yDLWKb6t1PvwENjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764010235; c=relaxed/simple;
	bh=fHUfV3jb2dMNpLvji9C/yJUPLHn968yTbKuAQl37l3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hwUgZZOsbqz6XTFWClRhqJdsD0DkcL+Q1JB4M9+tIPVS6Iqt1LvaSqOvc6t3DoZzAb40XgC1OzSA80PKKfuNfqPqmHlDXVRCRI5F+Xx/BsLqlzulk8JTxz4YG+JlCEtezbK55IMeTy21e12MDiTm+UDNL8QsXXSJSnYlyfrR5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tr+P/AkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193C6C19424
	for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 18:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764010235;
	bh=fHUfV3jb2dMNpLvji9C/yJUPLHn968yTbKuAQl37l3o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tr+P/AkVO2pGoQLKwGXUI4lH6OSiyBc0QY0B4LmZ+UkMiyvu9qRHTR6gopFKUs2EM
	 nB8vY67OkT9w0SXWDcAPB8VWq40F2SE9rRuCJQ0qu0v8rWOLbDJxUC8bHe6Agktg1V
	 9oRVu/FPhC5onPGufOOUx4WfFuMLqcePHNysPav+ibU//6a5+7McE4FdD/Qom0DAYL
	 kz2n5fojfM0o2aONXVTQAf9za3MGF6PvSO5lRuoXGZjCPtTikNGzMDCTSmMG2Yu+pW
	 aQvHdRqDijVmRYcFjsamYDdM63FD8VswMgAKVikUPfnomsk41QnaB7reuK4vJzzc5J
	 1cH/27/gARIrQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-657534478a0so1714074eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 24 Nov 2025 10:50:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWhfAl+h4aDiIxMZnWPKujP9hUDOnfIO/sBGYBcQKap7Xoy9hZJAORFnad8/XitRX7mbERY1I7KVceK@vger.kernel.org
X-Gm-Message-State: AOJu0YyNKFU8fdPBj8Y064nXW2jeveeNu2w/8unsFwKBrrn3TZA/adhg
	MgI/YL73UnazeY+BRQH5NeLMrf9KHiqhY0zDjXOT91e/Q2YQKdHXGHj0kunXluMc4HGBiq6RAHH
	epWDwu3cUgTgAE9IPvbkLH/tMlgJstvA=
X-Google-Smtp-Source: AGHT+IGczO53OMf81+KZm97XbapuBhOvddt2IsgDMQf4zKkx/mC1/RGitlCviPWTfXRVw3oWX1kZEn5SBsylzd4+kss=
X-Received: by 2002:a05:6808:2219:b0:450:b947:1da7 with SMTP id
 5614622812f47-4514e7f43f0mr77863b6e.36.1764010234383; Mon, 24 Nov 2025
 10:50:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107184438.1328717-1-usama.anjum@collabora.com> <20251107184438.1328717-4-usama.anjum@collabora.com>
In-Reply-To: <20251107184438.1328717-4-usama.anjum@collabora.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 24 Nov 2025 19:50:22 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gtGjE-rSwM4Kom4cDEhp3eSOkLCmbLwrt_9u9a7VP6zQ@mail.gmail.com>
X-Gm-Features: AWmQ_bnfk4DHB660ArOUxqnfissV07uZSrmDGTsW2Bf6x19HC0M5-fBpV9VsPWw
Message-ID: <CAJZ5v0gtGjE-rSwM4Kom4cDEhp3eSOkLCmbLwrt_9u9a7VP6zQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] Input: Ignore the KEY_POWER events if hibernation is
 in progress
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
> Input (Serio) drivers call input_handle_event(). Although the serio
> drivers have duplicate events, they have separate code path and call
> input_handle_event(). Ignore the KEY_POWER such that this event isn't
> sent to the userspace if hibernation is in progress.

Your change affects suspend too.

Also, what's the goal you want to achieve?

> Abort the hibernation by calling pm_wakeup_dev_event(). In case of serio,
> doesn't have wakeup source registered, this call doesn't do anything.
> But there may be other input drivers which will require this.
>
> Without this, the event is sent to the userspace and it suspends the
> device after hibernation cancellation.

I think that's because user space handles it this way, isn't it?

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since RFC:
> - Use pm_sleep_transition_in_progress()
> - Update description
> ---
>  drivers/input/input.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index a500e1e276c21..7939bd9e47668 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -26,6 +26,7 @@
>  #include <linux/kstrtox.h>
>  #include <linux/mutex.h>
>  #include <linux/rcupdate.h>
> +#include <linux/suspend.h>
>  #include "input-compat.h"
>  #include "input-core-private.h"
>  #include "input-poller.h"
> @@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
>
>         lockdep_assert_held(&dev->event_lock);
>
> +       if (code =3D=3D KEY_POWER && pm_sleep_transition_in_progress()) {
> +               pm_wakeup_dev_event(&dev->dev, 0, true);
> +               return;
> +       }
> +
>         disposition =3D input_get_disposition(dev, type, code, &value);
>         if (disposition !=3D INPUT_IGNORE_EVENT) {
>                 if (type !=3D EV_SYN)
> --

