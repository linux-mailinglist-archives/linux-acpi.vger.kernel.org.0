Return-Path: <linux-acpi+bounces-13657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFFDAB1C36
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 20:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57147A2505C
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 18:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1464E23C50E;
	Fri,  9 May 2025 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kl0A4xnI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C5239E94;
	Fri,  9 May 2025 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746815009; cv=none; b=bVyn5DsiTUD6EuTPyLdxMJgzhVaMP1w6DVpXKFpt1YJ3+n/DF5/jo5ckDgccR/ffl39QcjWyNNktWs6HtTD+k357+nwRAapzqOOVGfE+4E02xSeZCEFKqdr/un5r12xHApZbs4u+J4o+fvZhtWFzjPBzTjowTOwm8TT7Qmgr3Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746815009; c=relaxed/simple;
	bh=/MFu6ju8moPP/xWkCRsJNMnmmlKNJlj4iAhRAzpEzYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n4y20mATtZRyK0alHGWm35Wj2KiOMpwqixFhnvesGnP5Yu8ajcRmr5vtr0x/rYJFuuvqjJMeuPIadXsC1z58/etzd6oallKDOBSy6lxfaOoAgZK5cXhMYTDDYQTsh6+TdX5hwZ7zSOiW3ZLJsHtNI+gNUsvWdsruX4OOkK/3pS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kl0A4xnI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4CFC4CEE4;
	Fri,  9 May 2025 18:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746815008;
	bh=/MFu6ju8moPP/xWkCRsJNMnmmlKNJlj4iAhRAzpEzYM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kl0A4xnIhTAmPrcAQu7chaagolhFbeTMBstYbZCmJgYYEus2zHWpAeofahOGEfzfe
	 ZxgSw/QiOAxo4hwtAADWZo4c8uX+7pohD7S8OpPRmQUKxxP2yb+052pGOfY7Dzv8h4
	 h7BlgTMdJ6j5gGdYbDNHcEi5B/aVv+AecSqXBDV18Kxuz1+uEMoZJGxft3wk7NTgRh
	 a6RzBHQxuWKcAYZnANwgWq5rOslZ/wNXcXoFvqt0XaoWQnIowCXF94IQzn8htQ/Zgy
	 qA/oCILs+th6ZD3AR6vmlbVxfk8cWbHBCXiC+qCRZLgq5dEvxiXlfxcWWK1g/cLHB3
	 RqK7aMlZXidGA==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fa6c54cdb2so2032168b6e.3;
        Fri, 09 May 2025 11:23:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlZ68QUoxlg4V4KJGZp7lOh78zfZZcyF/0OjGhfGnE0sNayqk40QoSyo3sAB/1g6jDfxltcWGOfSLg2WDl@vger.kernel.org, AJvYcCXYMnIbrwzQ05fbjN1sFdW3wdIPFAC0E2uN/B+VnsoKLKZa924iIBvUZ7mDLN9Lg8aijDtkEwxqhSkg@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7EqBaTE1nF6kNzRZcUcVesHpTTGH+wTMIb0aDnYJ2pW+bKdq
	3hA4cbnd+UN2U/eJhvlb/RBc4PjNfecajI5hyVwMzJ+FmaP41cw2cBqyLlgXlTGPlxGQ8INUcx1
	5p7OID3IoBUlLL/i57iMaPXWCwyE=
X-Google-Smtp-Source: AGHT+IHHdSrHhC9nZurJ5jir64Cw6L/KQ2nrtB1q2eiU1L/CnnXB3W76wWMYpiPXvV0joiB98chVWF/EyLbX3QrkPOk=
X-Received: by 2002:a05:6808:148d:b0:3f8:e55c:16ea with SMTP id
 5614622812f47-4037fe6ddb8mr2990526b6e.24.1746815007589; Fri, 09 May 2025
 11:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422091056.972734-1-zhangzihuan@kylinos.cn>
In-Reply-To: <20250422091056.972734-1-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:23:16 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com>
X-Gm-Features: ATxdqUEfYrNyyO0430S5KkW1Ta0YPA3rWiCxp9pZX9Eb9Q1TFcFGnpbAhUn2NuQ
Message-ID: <CAJZ5v0guh4MGJpaCoh3Guc8BL_37=KHWW10wvK+iD6jZLvZWwg@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: battery: Reduce unnecessary calls to acpi_battery_update()
To: zhangzihuan <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 11:11=E2=80=AFAM zhangzihuan <zhangzihuan@kylinos.c=
n> wrote:
>
> When entering the acpi_mattery_notify function, no matter what the event
> is, acpi_mattery_update will definitely be called.

I think you mean acpi_battery_update().

> Use the acpi_listen command to listen, sometimes the log looks like this:
>
> battery xxx:00 00000081 00000001
> battery xxx:00 00000000 00000001
> battery xxx:00 00000080 00000001
>
> Firmware manufacturers will customize some events like 0x0, so
> non-matching events will be ignored.

I don't quite get what you are trying to achieve here.

> Signed-off-by: zhangzihuan <zhangzihuan@kylinos.cn>
> ---
>  drivers/acpi/battery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8af5..9446c57b77e7 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -1083,7 +1083,8 @@ static void acpi_battery_notify(acpi_handle handle,=
 u32 event, void *data)
>                 msleep(battery_notification_delay_ms);
>         if (event =3D=3D ACPI_BATTERY_NOTIFY_INFO)
>                 acpi_battery_refresh(battery);
> -       acpi_battery_update(battery, false);
> +       if (event =3D=3D ACPI_BATTERY_NOTIFY_STATUS)
> +               acpi_battery_update(battery, false);

So only call acpi_battery_update() for ACPI_BATTERY_NOTIFY_STATUS.

Why do you think this is the only case in which acpi_battery_update()
needs to be called?

>         acpi_bus_generate_netlink_event(device->pnp.device_class,
>                                         dev_name(&device->dev), event,
>                                         acpi_battery_present(battery));
> --

