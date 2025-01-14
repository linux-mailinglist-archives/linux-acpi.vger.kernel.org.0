Return-Path: <linux-acpi+bounces-10633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0200A10D83
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA3ED161626
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DDE1D47BB;
	Tue, 14 Jan 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHTdB8K7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31F723245A
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875311; cv=none; b=Y3Eu92KJgi31qAi6WT92BSWaDxPeT4tLH73VWGYCgNW457HZh2nNzZTTShivfM6EzF9QLor/6MIvad1EjWY5/H8zyFf55AD511XPsaLjswsTfR9vMHQyGcxVYprXRBn+JWXrWVNmTfWdcWCkLiPx57tKZVxKLv3NJ1JSt3WGwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875311; c=relaxed/simple;
	bh=XhskgGi1rH/3Nmw4+tnf2ZsudrWO18EGbuzHZfE0r5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZQ+vhKG4SrxqONjk1+gyBaIeg5GZBe9g/wF9qNSGBf7WMAtf1pmDlQ4hMPux4EnBp4pgAiTCs6mS2AShg3xPup0NTJsLMNf3zyi1c768HZcZ44e27HACvwzkce72ITPMzMUlHOQ/rAGbamzu1zOnM3QZ7X+LJxDKmivhlkXwPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHTdB8K7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B944C4CEDD
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 17:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875311;
	bh=XhskgGi1rH/3Nmw4+tnf2ZsudrWO18EGbuzHZfE0r5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kHTdB8K7esNT6Ey49LkefvB1Oq6Yx8CfNvSOLmyvQOiIe0ZR2asXt2E9vUypNN5+5
	 WCxuidNimW3evazAjkut5+TxTqq+C1NhUrbO6AXGsGn2IIRyHPQSpr0ge+8g9FyL98
	 OnVUDyMSHcHX42ai3NeRjnkO6zlnhV6GN4j16CzEg+RRaMUcR6OmMmXIMlvR8sVbbk
	 rFrAu+DQUTeXvCwi7k/sbku5gLQwYm9+GM6Uh+dO2pOKjagAxRsWTQtU03arbxTf69
	 acCRb7M8Up0WvVAUDhJ+W5+zGCvgN27VPvR8vS6XHe5K26sD99omctFCmWsWRPWhls
	 HNieJUMmaaxaQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3eb7edfa42dso2649833b6e.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jan 2025 09:21:51 -0800 (PST)
X-Gm-Message-State: AOJu0YxH6r+6h67rMwwG05vDP8gkXR2bcZMH/lzmZCU0xn5r3H4nPXyQ
	wZzuwN/yTs88K08MWQuA6WU4tIZK/BbnBXotkReRccD3l+v4VUhcOJr4uMxm9vRlW2XKKWQPnqf
	pF27Jm/PMhtwXlHH6L/cNq0611v0=
X-Google-Smtp-Source: AGHT+IHlt133ttNAmxsRJT6ZKJ5o5a1IwJbesiZ+61kfdXZvHIqS7jBn61lbCT1x5lPvV7UeuUy7U+tvvOVhkQvCQFQ=
X-Received: by 2002:a05:6808:1c0e:b0:3eb:651a:6cec with SMTP id
 5614622812f47-3ef2eda1c33mr18892974b6e.31.1736875310576; Tue, 14 Jan 2025
 09:21:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <43d1d35b-d875-4e05-b0ff-a9bfde5ef34a@i2labs.ca> <23b9ca13-9899-4ab4-a0dd-a47da3f34120@i2labs.ca>
In-Reply-To: <23b9ca13-9899-4ab4-a0dd-a47da3f34120@i2labs.ca>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:21:39 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itm5MWQLJdmmgosBWj9XLVF0FFU7_M16xCr3yBckQbJg@mail.gmail.com>
X-Gm-Features: AbW1kvbcIjp7P_JbVDcx4ktq-yPTK8B2XPdubUnoBC3Noq_RGaVpkLOrdSYVIJM
Message-ID: <CAJZ5v0itm5MWQLJdmmgosBWj9XLVF0FFU7_M16xCr3yBckQbJg@mail.gmail.com>
Subject: Re: [PATCH] acpi: Emit udev 'update' event after battery add hooks
To: Nolan Woods <nolan@i2labs.ca>
Cc: linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 1:55=E2=80=AFPM Nolan Woods <nolan@i2labs.ca> wrote=
:
>
> Correction: the event action string is 'change' and not 'update' (not
> sure where
> I got that from..).
>
> Also, despite my IDEs repeated insistence the kobj member type is not a
> pointer. Here is my updated patch, I would still like some input on the
> items in my original message before finalizing the patch.

It would help if you sent the current version of the patch afresh,
with a proper changelog.

> ---
>   drivers/acpi/battery.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 3d5342f8d7b3..abe861946eb6 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -899,6 +899,7 @@ static int sysfs_add_battery(struct acpi_battery
> *battery)
>           return result;
>       }
>       battery_hook_add_battery(battery);
> +    kobject_uevent(&battery->bat->dev.kobj, KOBJ_CHANGE);
>       return 0;
>   }
>   --
>
> On 12/27/24 8:35 PM, Nolan Woods wrote:
> > A 'add' uevent is emitted after adding respective /sys/class/
> > power_supply/BAT* devices via battery.c:sysfs_add_battery(...) ->
> > power_supply_core.c:power_supply_register(...) ->
> > core.c:device_add(...). Additional drivers (asus-wmi for example) can
> > register hooks that are called after the sysfs attributes are added by
> > power_supply_register. These hooks are normally used to add additional
> > attributes to sysfs. These additional attributes are not available at
> > the time that the 'add' uevent is emitted. udev rules are not able to
> > interact with them as the hooks are called after the 'add' uevent is
> > resolved. An additional 'update' uevent is needed to allow udev rules t=
o
> > trigger once all hooks have been processed.
> >
> > Signed-off-by: Nolan Woods <nolan@i2labs.ca>
> > ---
> >  drivers/acpi/battery.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 3d5342f8d7b3..abe861946eb6 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -899,6 +899,7 @@ static int sysfs_add_battery(struct acpi_battery
> > *battery)
> >          return result;
> >      }
> >      battery_hook_add_battery(battery);
> > +    kobject_uevent(battery->bat->dev->kobj, KOBJ_CHANGE);
> >      return 0;
> >  }
> >  --
> >
> >
> > This is my first contribution to this repo. Please let me know if
> > there are any formatting issues of this submission.
> >
> > I am looking for feedback on if kobject_uevent() should be called as
> > described in this patch or if it should be at the end of the
> > definition of battery_hook_add_battery.
> >
> > Also, does it make sense that the "update" (KOBJ_CHANGE) event is sent
> > after the battery hooks make arbitrary changes? or is "update"
> > strictly for hardware/device initiated changes and I need to find a
> > different mechanism to trigger user space logic after the battery hooks=
?
> >
> > An example udev rule that only works with this patch:
> > ACTION=3D=3D"update", KERNEL=3D=3D"BAT0", RUN+=3D"/bin/chmod 666
> > /sys/class/power_supply/BAT0/charge_control_end_threshold"
> >
> > The following does not work as
> > /sys/class/power_supply/BAT0/charge_control_end_threshold does not
> > exist when the event is resolved:
> > ACTION=3D=3D"add", KERNEL=3D=3D"BAT0", RUN+=3D"/bin/chmod 666
> > /sys/class/power_supply/BAT0/charge_control_end_threshold"
> >
> > charge_control_end_threshold is created at asus-wmi.c:1446.
> >
> > Thank you for your time.
>

