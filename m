Return-Path: <linux-acpi+bounces-11261-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704DDA3A4A4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 18:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666F03A15FE
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 17:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2079270EAF;
	Tue, 18 Feb 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ioq8YrjI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F726B975;
	Tue, 18 Feb 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739901010; cv=none; b=dzBKNiVNvQydEU+T64vSCrZa3TMJd84VeXVmsF04BVHPqTh5OfK8ZOnKbdm44yri3QhSwzSmEuc0HXDml4GHT+RvUX/I+l6/bpemBKhrcTOS6DKDR13bgY7A+sX6Y6hi9blduueEeyD1qlyW8LBcLWngjG+AxXQMq4mZD2lPybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739901010; c=relaxed/simple;
	bh=AQJgbLTM9GE86vqu3nbXsn1v7pYdVKXExyDRP3tmbVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=froIq1A+eeDwLqmRN7ByZzZ5lWB8Ed6E0v+sDkGs0p3OJ+jR+V8BxygveiPI/grVNyIDtwm+whMhCiC68BoHwU4WsXJR/ZT+roYSInXtaKR+22j2g+oLPWfNP1Nged1GUQsf1Mwl+X/yWHYlMQrYtchzG+tt/jcVEKMJYXZX3Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ioq8YrjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF21C4CEE4;
	Tue, 18 Feb 2025 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739901010;
	bh=AQJgbLTM9GE86vqu3nbXsn1v7pYdVKXExyDRP3tmbVM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ioq8YrjIfqgAJz/uMz6B9alsjoghIuQovDJU1iaOUnxeGYWilJMbmz0iFGEtCsQNN
	 t6YbgwKsT48MxKTi3mMRE2qhLGzBBLoQqFfBtL7uXYHfYHfzReb65be5iB84WO7JXo
	 j5aRrUjLjwR4s5aOn5OIvmwMbMJmHv1PIY8bIZt0FMQ4AAKW296CdxH/PcwRSjrJzJ
	 esf38TTEsrOGqUCDtZBCyk2kMdHXDx4nFrDCi0zqqCDn9u6U/DCdxFyeaDZhHxgzdO
	 xfkeEczIVMDzCIvAKfK0mmeW30Ej2GtGB2v1kql9felGXKU9KiGVwi9g8FOIi0NxJE
	 u1cdXIAzoy4gg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcd811d939so17973eaf.0;
        Tue, 18 Feb 2025 09:50:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIBVIEMbZIfZSOjKMAgaWtdiM39GwOgKIa8OA8aqlShrDMkZZ2mt9ci2DbN07axb/kRahMbkuopokT@vger.kernel.org, AJvYcCXs5vQ8l1nSoyVtY3HVg1MzgDBQy8WeZitljnApK6oKVspaMLcNe5Mz7qe5gbXZtKEoV2qy8UyUwgkf9HXI@vger.kernel.org
X-Gm-Message-State: AOJu0YzSjyWgIC06YJ+jVSJQysATAA0O2OU9QazYM8C57fj0IBHY9w/2
	KXzSVZJkOF0XXb2n6vfSk1FA7GcOIDOp4qcdZlPDnCF5Z3auHOpr3dvXs1XrEijELetI1L/PLhA
	6eLVp4flM9IyqsVhja7j2dI/hTQM=
X-Google-Smtp-Source: AGHT+IGWkdQHENgxMdq8bsrYIRTUXC/QNWSPzj+8/gqLfnKR8uXjsFnmFZ7Dp6HGiv5FUfvHeVnJuN+dYtn7cPBDRts=
X-Received: by 2002:a05:6808:338a:b0:3f4:b6f:4845 with SMTP id
 5614622812f47-3f40eef9ebcmr686932b6e.4.1739901009225; Tue, 18 Feb 2025
 09:50:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209220835.78434-2-thorsten.blum@linux.dev>
In-Reply-To: <20250209220835.78434-2-thorsten.blum@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 18:49:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iauPQ6HA_-FoUWxGeBC5097c_-+XxAEAAcws3NFZQOrA@mail.gmail.com>
X-Gm-Features: AWEUYZlIT7ZlRObIeZiuekAX6n1TTO6xFBFazJQelF0GSDHsgG20MA2w3osh9WA
Message-ID: <CAJZ5v0iauPQ6HA_-FoUWxGeBC5097c_-+XxAEAAcws3NFZQOrA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: power: Use str_on_off() helper function
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 9, 2025 at 11:08=E2=80=AFPM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Remove hard-coded strings by using the str_on_off() helper function.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/acpi/power.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 25174c24d3d7..b7243d7563b1 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -29,6 +29,7 @@
>  #include <linux/init.h>
>  #include <linux/types.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/sysfs.h>
>  #include <linux/acpi.h>
> @@ -197,7 +198,7 @@ static int __get_state(acpi_handle handle, u8 *state)
>         cur_state =3D sta & ACPI_POWER_RESOURCE_STATE_ON;
>
>         acpi_handle_debug(handle, "Power resource is %s\n",
> -                         cur_state ? "on" : "off");
> +                         str_on_off(cur_state));
>
>         *state =3D cur_state;
>         return 0;
> @@ -240,7 +241,7 @@ static int acpi_power_get_list_state(struct list_head=
 *list, u8 *state)
>                         break;
>         }
>
> -       pr_debug("Power resource list is %s\n", cur_state ? "on" : "off")=
;
> +       pr_debug("Power resource list is %s\n", str_on_off(cur_state));
>
>         *state =3D cur_state;
>         return 0;
> --

Applied as 6.15 material with edits in the changelog, thanks!

