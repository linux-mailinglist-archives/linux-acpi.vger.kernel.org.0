Return-Path: <linux-acpi+bounces-10033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEF39EB939
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EBBD2842A2
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DF81B5ED1;
	Tue, 10 Dec 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZNM41Ei"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD31A01B0;
	Tue, 10 Dec 2024 18:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733854952; cv=none; b=cPmnaLz6l8d4pGT+Up7dkhV23NcYw3tvXSlw23x01OzYnXQXGtxe1mXE55vQkctGfDr8qpWxAURsmMQySdfD0KPNFcAVHQLOVDiMCj/cY3QQH0xzh1jqvM7fWSIkL8yK2DrISS79Wnh93iQvAtBkNpyBSlbCpzOHcQS3nlevVt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733854952; c=relaxed/simple;
	bh=KJuDRLnfyA/pBRaEV+y3cEarwDisp3b9kpQ6c41LOts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IHEi5gvigckvQ5YBkdkyIBUL/dad5PwB0X6TnVnFW/pl/dzVAj43l8lRKe/J7c04M80824N40FNiNP1o0eePQGA9QXlxHmo7jfG0iZfxsCtre088K+njXNPUemwzox+xja8hcn4zfCEvfNyfehCK1nd7aJbdfSPZWfwZhlmU+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZNM41Ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9163FC4CEDD;
	Tue, 10 Dec 2024 18:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733854952;
	bh=KJuDRLnfyA/pBRaEV+y3cEarwDisp3b9kpQ6c41LOts=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sZNM41EiaVswXTpc44XsBCwf007pJJGehMeQ4JYnn98QNkI7OVwt1dwnClnkqsj1V
	 pvbG8j3B107urZZeIgZqr9wcVU8JQOaS7XLLVjIkHEhRPTbyHQAC3A9CJ9O6KCZsDF
	 ikCV8PzktRw03/n1k+KOTZXZjDpk03cgOU0sFkxwjaPcLcIxOOghwqLDzRgwosqtj4
	 L4kmL/+taOBFDhn4XDnSFd+A5zuzj9ZT8ScuXhXhnPufgmQ/G9Hgukx9NHu1y98TFE
	 ZyLOIVwUnAegFgLnqkB8wyNLNdAmDKfxxk3EUWonkPGsdkDzRHUZwpCyHGcAmNecql
	 TSnkR28ub5rIw==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5ee645cf763so2592117eaf.2;
        Tue, 10 Dec 2024 10:22:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV4H8w+NufxfOJ/rByRuHHJkwSp9wcabveSqOuEuJVp90yEAvXWf2IKzGJy4BVhF9qK0/WqbNKqPMSD@vger.kernel.org, AJvYcCWlrorlO5apNMglWKIAW2cc27NWb93IAid3PvJZPXYCzBWb6PU1fXSKqBlEgjvITHjV4ewawpJs3VIUvkLn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9tSBQEFh06wCA5l0ivsazUzWKexSsYu4XJCZJh2ydCYKCgpXf
	crwLaTUhluEh7+NNjHRGuKXQ7CtTcikeIFU57gX+grHOwCaFOoHnUrYFDAh3N7sIU2VqzcbyAY2
	zfShQRziUb3s2W98QfEJ9rfCBirg=
X-Google-Smtp-Source: AGHT+IEGAhTiJSFFOJoZwv9XwbVki7dy+WJHiqDVr8m1hv00B9JfJL10oma3JMzWPGuZrnZ+k9U2xMvevQeZ+mixl/o=
X-Received: by 2002:a4a:e909:0:b0:5f2:af6a:e4c0 with SMTP id
 006d021491bc7-5f2af6af6b8mr6837431eaf.1.1733854951876; Tue, 10 Dec 2024
 10:22:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122082954.658356-1-d-tatianin@yandex-team.ru>
In-Reply-To: <20241122082954.658356-1-d-tatianin@yandex-team.ru>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:22:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hfhsy6rvYQ87n68VZ7tySTe3GNaJAQ5n2mJtwYLHUEbw@mail.gmail.com>
Message-ID: <CAJZ5v0hfhsy6rvYQ87n68VZ7tySTe3GNaJAQ5n2mJtwYLHUEbw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: events/evxfregn: don't release the ContextMutex
 that was never acquired
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, 
	Hans de Goede <hdegoede@redhat.com>, Erik Kaneda <erik.kaneda@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 9:30=E2=80=AFAM Daniil Tatianin
<d-tatianin@yandex-team.ru> wrote:
>
> This bug was first introduced in c27f3d011b08, where the author of the
> patch probably meant to do DeleteMutex instead of ReleaseMutex. The
> mutex leak was noticed later on and fixed in e4dfe108371, but the bogus
> MutexRelease line was never removed, so do it now.
>
> Link: https://github.com/acpica/acpica/pull/982
> Fixes: c27f3d011b08 ("Fix race in GenericSerialBus (I2C) and GPIO OpRegio=
n parameter handling")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  drivers/acpi/acpica/evxfregn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfreg=
n.c
> index 95f78383bbdb..bff2d099f469 100644
> --- a/drivers/acpi/acpica/evxfregn.c
> +++ b/drivers/acpi/acpica/evxfregn.c
> @@ -232,8 +232,6 @@ acpi_remove_address_space_handler(acpi_handle device,
>
>                         /* Now we can delete the handler object */
>
> -                       acpi_os_release_mutex(handler_obj->address_space.
> -                                             context_mutex);
>                         acpi_ut_remove_reference(handler_obj);
>                         goto unlock_and_exit;
>                 }
> --

Applied as 6.13-rc material, thanks!

