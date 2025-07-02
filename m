Return-Path: <linux-acpi+bounces-14953-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A323AF60BE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 20:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31E04E5C3A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 18:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1195130E820;
	Wed,  2 Jul 2025 18:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B51d1mwc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABBF303DFD;
	Wed,  2 Jul 2025 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751479457; cv=none; b=Vg7X11ySHnIBF/eRHRwN19AEQ5BBksuZ56YKT2DmYfdE15hipvJ5LmBpEw5DQqlp3Txt70i/vFHrgchLslk4PlLwX+gSk6Ht52JfiDqnmo/cZ11OTwatUL9FYLRs1FEHUQeFma1Ag8QSXVNqm+fP7GG2CE0o+yvQplB9oEWSa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751479457; c=relaxed/simple;
	bh=rB7kDTHQ/uishKmXwIwf+woKkI5vPemOVne+kvr5XMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSqxE5zJ/jO8UBfypelknwnTtsa7doEKMQ1RvnViq8CIixsk/iGodqby/BwanSltq7UeJhx9F3KacvPouvphAe2SzQKcIK4yQ5szeSWvPITQwcX9BwoYUsvbcgTAe7zShjJqqvTQA37ZysMYn0WdAi+zYcW8l8b8TGfgFNMxUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B51d1mwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7848C4CEE7;
	Wed,  2 Jul 2025 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751479456;
	bh=rB7kDTHQ/uishKmXwIwf+woKkI5vPemOVne+kvr5XMw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B51d1mwcN1fRUwVhtU0Jp4Jmc/LOF7u9soJ+unACltt7krszWojbDQX3hqYEuOxMk
	 4+050x4ZZaBrQ2cOlxJsLd+BnvGv0eBYf5BDnNGpmuHRqZIuBSLK5GfrzJw/iXFTZC
	 BcA1sZC1Z76T19jPZjh194FNepYTNZrrGggebwG9n8adY3gAq3NFY64CA1cEt1qh1J
	 8miVTNiLHS85CzbIy3Yv+mnMyF8UNM2jzKboRjHobK83Y7j5ClNL4ZJ/4vp8A4xvHV
	 WCETJcmCvvJYesIcvgT6nIY2ctiRTIKfIFnFDI7DhaTGz8OSe8Y7n7PtSilnbwJbD1
	 XSn0OWtgIBDQQ==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-60f24b478e3so2308904eaf.3;
        Wed, 02 Jul 2025 11:04:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1Z0j7UDHsObjmjQDRC2cZn82nQdvbZ1xusYi+W5RHgrU9OFT/lPDBtIKvobM3qU3Sf8dX24Wrm1Xj@vger.kernel.org, AJvYcCVVFuwb1s958jBjYDPQuveo5IRk61G+cIyV6Ga6dYjc2zJsxxkWa8GmKRDs3w2SPjfAtCiTuaxfI1xv0GJX@vger.kernel.org
X-Gm-Message-State: AOJu0YzbIFdmeSMQ4gnc1aIJDQP6QsTHR9+4W9E0FZkgSKcI6YQTo0RT
	jXLKov+vsw656pwIU2Zr7ogkZFoz33CpToTnU9VNM0NePoug6UGxy1r9mW+FNjN5UdlbwGdZ15b
	whegaSCiRevxykrEM3sXMT/nLZBBWbXY=
X-Google-Smtp-Source: AGHT+IEns6wOYy4KSm5xHGLBBW4O7MP8WE+AxP1Ldh9mvi+EG8ZwJYGZjnClAScUQLVNPqJRq+Ykwfex8U8yV8fedMo=
X-Received: by 2002:a05:6820:210a:b0:611:b00b:baa with SMTP id
 006d021491bc7-612010c1c74mr2670255eaf.3.1751479456022; Wed, 02 Jul 2025
 11:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624142134.11317-1-listout@listout.xyz>
In-Reply-To: <20250624142134.11317-1-listout@listout.xyz>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:04:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gHpaAs9DtP7z1NoBPVEF0FQjBXEyRWoUTWhRCLF80Ajw@mail.gmail.com>
X-Gm-Features: Ac12FXxFn50hgoqYdCib2K_DvxZ-UZ8NCXtwyD3sCmb4Dj-M25Ntwt7i2bn5g_M
Message-ID: <CAJZ5v0gHpaAs9DtP7z1NoBPVEF0FQjBXEyRWoUTWhRCLF80Ajw@mail.gmail.com>
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated strcpy() with sysfs_emit
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	lv.zheng@intel.com, kees@kernel.org, rui.zhang@intel.com, len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 4:21=E2=80=AFPM Brahmajit Das <listout@listout.xyz>=
 wrote:
>
> strcpy() is deprecated; use sysfs_emit() instead. No functional changes
> intended.

It may be deprecated, but is it used incorrectly in this particular case?

> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---
>  drivers/acpi/sysfs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> index a48ebbf768f9..7ce90998ab97 100644
> --- a/drivers/acpi/sysfs.c
> +++ b/drivers/acpi/sysfs.c
> @@ -181,10 +181,9 @@ static int param_set_trace_method_name(const char *v=
al,
>
>         /* This is a hack.  We can't kmalloc in early boot. */
>         if (is_abs_path)
> -               strcpy(trace_method_name, val);
> +               sysfs_emit(trace_method_name, "%s", val);
>         else {
> -               trace_method_name[0] =3D '\\';
> -               strcpy(trace_method_name+1, val);
> +               sysfs_emit(trace_method_name, "\%s", val);
>         }

The code does strlen() checks before this, I don't think that the
change is an improvement.

>
>         /* Restore the original tracer state */
> --

