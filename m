Return-Path: <linux-acpi+bounces-10038-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716D39EB9A6
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 19:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892D518879D9
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59F2214206;
	Tue, 10 Dec 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3/EmaGw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D7823ED41;
	Tue, 10 Dec 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856736; cv=none; b=QKNghQBJfZaYBIGJEEibqLqHhqPkgqYFHfaqDiPa6GD6omGe8dD6HR+H2BJj3G18DcqPIHaTVLCl1udn3cxb3jUqV7pVm67D66VChKk1Skr9+Uz8+oum6itvuwaSp+gPIHEBH7zQQR8+FndE/M4Ryjwx5uZMERNtMN2ucWoTCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856736; c=relaxed/simple;
	bh=K1bCEcql+Dy5pT5rqacU6v95YfdNRaf/sZWArH2Gqpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKGKQJZQYTZFRjyr8zV0klSYlkupH+Rw5pUol3x26phLJYtenNENgPc/FeYPOdDEbsU2eyDSC0gZi+QGHollrq36ODvKK+YfeXFrzw03H7DGb9jV0XPK1/K2cGs/8mN77/1JpV09pkGC70DpmNt5BMkY60hWBfTthynJVHGhWFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3/EmaGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E28C4CEE6;
	Tue, 10 Dec 2024 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733856736;
	bh=K1bCEcql+Dy5pT5rqacU6v95YfdNRaf/sZWArH2Gqpw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O3/EmaGwKZDvY78qriEolcalnxoWnZ47pF1lY1Rd+7cVtNX9Sc5tG6ZZIiq4FJ+/z
	 T2UfGfjNNTEDL09gk1+7w3LrfTnaBWYA3ShgrX+/KxtFn5ccrxyDnF2wJkXjW9nfaq
	 /+NfHzO2xMG/ufhezJW0PhIAnhdtoIGkaUPz3vfpoXvuGWHZeFCvFcpTrP47Bh/jV6
	 tJ0ma6MG7a3a+CebUGInZQRizdmNk+1W5QFnmoQb0/srllt87g/mw3ZURR8IS7eyRU
	 Frac+iYvvxbYwDJflV6lq7O94Mqzfqg4Omdwt4LqRpEfKIlDI0GsrkGrw85osXPPHB
	 KpXsfyIlq2zzg==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5f2abc195f3so1222454eaf.0;
        Tue, 10 Dec 2024 10:52:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUYb/mjjEG6UFVXCT97gHZ+C7EBpLjHE/IvGXlXHI9YkjCfbMNehlOlDZguxHXBHFDn6/gtHRlGKHp1jbLK@vger.kernel.org, AJvYcCV0qyDx93J/sl+H94aOhg6gmxgOQ9aqxmrAJ6E64ehjb0/aSGgjOO475iDJ/WOt4MVgPjqjLo+3/GQ=@vger.kernel.org, AJvYcCVgh+Ec7rL31N8/u+J/YI3CwxhFutK3KszZtq0RpHN5emg8NRwlM3nc5Iduhjgup54i6nULGpMTs37q@vger.kernel.org
X-Gm-Message-State: AOJu0YyKo+7eNES+S7sbugxp6M02p4xMCwxeBTj0728bUwLndxf6RvX3
	xRy4Ud8OV93YWxmKe0wZc/f+ZpRso6QKSs6aPI57nqIUeWwtHMkmEIIPWre6N9ZTG8Wk07dd8ZU
	PnA+cDx5vOyTtNxEOyXl9kAqyzeM=
X-Google-Smtp-Source: AGHT+IEUVq2DG7knefuD9zoEnH3gP/20KGjUt5uUH68TvgFSufuWrRzLP6Ehja97D/mMTCDN6rSUF1q/wpb/iUTcTrI=
X-Received: by 2002:a05:6820:1896:b0:5f2:af90:e90 with SMTP id
 006d021491bc7-5f2da0c2491mr32734eaf.3.1733856735696; Tue, 10 Dec 2024
 10:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205-power-supply-extensions-v5-0-f0f996db4347@weissschuh.net>
 <20241205-power-supply-extensions-v5-1-f0f996db4347@weissschuh.net> <esivcfgbfewjcnvc3uhsdvxbu5dmh3r5z2hjjagzvfrxxsioav@cx2du3oznvhi>
In-Reply-To: <esivcfgbfewjcnvc3uhsdvxbu5dmh3r5z2hjjagzvfrxxsioav@cx2du3oznvhi>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Dec 2024 19:52:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iSVyfyBS=MtAW-0q8keJa9W=ztZDgPgZiNLNxFUcr6QQ@mail.gmail.com>
Message-ID: <CAJZ5v0iSVyfyBS=MtAW-0q8keJa9W=ztZDgPgZiNLNxFUcr6QQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI: battery: Rename extensions to hook in messages
To: Sebastian Reichel <sebastian.reichel@collabora.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Armin Wolf <W_Armin@gmx.de>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 1:40=E2=80=AFAM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Thu, Dec 05, 2024 at 09:46:35PM +0100, Thomas Wei=C3=9Fschuh wrote:
> > This functionality is called "hook" everywhere in the code.
> > For consistency call it the same in the log messages.
> >
> > The power supply subsystem is about to get its own extension
> > functionality. While the two are closely related and will be used
> > together, the current wording leaves room for misinterpretation.
> >
> > Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> >
> > ---
> > This patch can also be applied independently through the ACPI tree.
> > ---
>
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied as 6.14 material, thanks!


> >  drivers/acpi/battery.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> > index 3d5342f8d7b3ae4e259131f9c7b7144a6206cfdb..6760330a8af55d51c82a044=
7623c2040ffdaab10 100644
> > --- a/drivers/acpi/battery.c
> > +++ b/drivers/acpi/battery.c
> > @@ -717,7 +717,7 @@ static void battery_hook_unregister_unlocked(struct=
 acpi_battery_hook *hook)
> >       }
> >       list_del_init(&hook->list);
> >
> > -     pr_info("extension unregistered: %s\n", hook->name);
> > +     pr_info("hook unregistered: %s\n", hook->name);
> >  }
> >
> >  void battery_hook_unregister(struct acpi_battery_hook *hook)
> > @@ -751,18 +751,18 @@ void battery_hook_register(struct acpi_battery_ho=
ok *hook)
> >               if (hook->add_battery(battery->bat, hook)) {
> >                       /*
> >                        * If a add-battery returns non-zero,
> > -                      * the registration of the extension has failed,
> > +                      * the registration of the hook has failed,
> >                        * and we will not add it to the list of loaded
> >                        * hooks.
> >                        */
> > -                     pr_err("extension failed to load: %s", hook->name=
);
> > +                     pr_err("hook failed to load: %s", hook->name);
> >                       battery_hook_unregister_unlocked(hook);
> >                       goto end;
> >               }
> >
> >               power_supply_changed(battery->bat);
> >       }
> > -     pr_info("new extension: %s\n", hook->name);
> > +     pr_info("new hook: %s\n", hook->name);
> >  end:
> >       mutex_unlock(&hook_mutex);
> >  }
> > @@ -805,10 +805,10 @@ static void battery_hook_add_battery(struct acpi_=
battery *battery)
> >       list_for_each_entry_safe(hook_node, tmp, &battery_hook_list, list=
) {
> >               if (hook_node->add_battery(battery->bat, hook_node)) {
> >                       /*
> > -                      * The notification of the extensions has failed,=
 to
> > -                      * prevent further errors we will unload the exte=
nsion.
> > +                      * The notification of the hook has failed, to
> > +                      * prevent further errors we will unload the hook=
.
> >                        */
> > -                     pr_err("error in extension, unloading: %s",
> > +                     pr_err("error in hook, unloading: %s",
> >                                       hook_node->name);
> >                       battery_hook_unregister_unlocked(hook_node);
> >               }
> >
> > --
> > 2.47.1
> >

