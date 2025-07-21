Return-Path: <linux-acpi+bounces-15258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534CB0C617
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 16:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BA75435D0
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4522DAFBD;
	Mon, 21 Jul 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCwKqd29"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5766C2877F4;
	Mon, 21 Jul 2025 14:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753107648; cv=none; b=D6tIZKpE9iNYlWdcvKhFVchqN6ST/ZzcI92P1K6B9Fe83v6TxSHrCQo2E4xwso/HOQ1cPmFDPGzXwpdE+rS0dCvMYqQ/pHwzkkMJzhxLokLehnoIa5xYqJ8N0htXIrx7JPXJU/qirWEEMzC3dZOThQfrUSLr6NZ88DrGamIsZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753107648; c=relaxed/simple;
	bh=C9pPx1ziRMwXsfwlpnkCBu2lnLsBx0/XWNqv2vC+pkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uN3m/t2zlJI9GFlZ+5i2kCTjlFwKPTft8+FXn64gtVIAdlnm+Tz3YEv/kenVWqxQWB/Q5mZzDlw+Ry/vdzu6751vCHPuoY7gOqmY8P/nYo6T133zqNvJp+8TVRkI4CM2Zjdw4zj0XKVIcao7bNuNf61sDuuMrpOpKU0Z98aH8JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCwKqd29; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B72AC4CEF7;
	Mon, 21 Jul 2025 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753107648;
	bh=C9pPx1ziRMwXsfwlpnkCBu2lnLsBx0/XWNqv2vC+pkM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=eCwKqd29IDqmMKeQ8NwZXjesd3Ym17z4tH3BsqyxOtZBPpQz5iEAH769+VIR1UuEK
	 i9deLmcS0cNn0T+e1YaYOMYOoyJ579Ze4f9yF4i29E0oj6144PzZ8iPfK/cqxhrUM+
	 6W9Gbs0mjN3BS3YV8timdgGMrzcqus+uw8AU1s+fzyNvFYhjA8GS+qddlAJYZC/T8I
	 7dWiGFAW4CrD0gW3GrLwGOLes4ObNVJXjZDATuTqkVm+WrYQMlJwcikpvKURUwLCv+
	 +lUW7yk2rRis3aQpeNapTCswSP1IPPpbHdKrnhmZN8gI5Z+Jbvz386DCNwhSYKlvRK
	 T20bKcZtJ5eAQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61390809a36so1429202eaf.1;
        Mon, 21 Jul 2025 07:20:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK+Aj4qhn6AmSPQdpqyyPAM0zE8ISzKWEQ25pG1XSEgoh05Vip0K5UfFxZxOs+ZpE0ZdM2KDmtxkG8@vger.kernel.org, AJvYcCVEifq7tFCVdhml48c/27c3Wqrgq7kGKsX6OvhkzzeBADZGvv9H208tF7YPuURRQRhTGvggDU4hKqwsKZc4@vger.kernel.org
X-Gm-Message-State: AOJu0YwWf36VS6cGFWzgXMifPpuIAe4cyKj2LWEYVzF6nNS+m2uDu74e
	48RRRAqsv7NUcYP+WAbGDH9GfvhT5f2ZvTtGd/t9SNhTZMuLKS/VeEgNX7stMMVWYJpwJ1lWEMS
	3RySbpl5kHkuXR5oTxLhdgb1oWYconKo=
X-Google-Smtp-Source: AGHT+IFJ3kDdM5H+GRuOgNJJBwjIOxESOp1AjwLoWvDHUkQ5KKAYOCJXvOdKVA/Db2Lun62V4eTjhDIhzSHQN2Ps0DE=
X-Received: by 2002:a05:6820:6689:b0:615:e0be:75df with SMTP id
 006d021491bc7-615e0be7626mr1790796eaf.3.1753107647178; Mon, 21 Jul 2025
 07:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <999bc59ab1cb18764c5b85afb75da9625365ce1a.1752959347.git.mail@maciej.szmigiero.name>
In-Reply-To: <999bc59ab1cb18764c5b85afb75da9625365ce1a.1752959347.git.mail@maciej.szmigiero.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 16:20:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKgKzsdGq6scU7fozFgerhPLEMJi93RHV7f=iRc1VY8Q@mail.gmail.com>
X-Gm-Features: Ac12FXztYK4pFzYYmyF2NyGePQz9Aqoeg3arWmeIFM5KfmzCW98r5A8A7nUH9rw
Message-ID: <CAJZ5v0jKgKzsdGq6scU7fozFgerhPLEMJi93RHV7f=iRc1VY8Q@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power
 resource quirk
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2025 at 11:26=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> This laptop (and possibly similar models too) has power resource called
> "GP12.PXP_" for its Intel XMM7360 WWAN modem.
>
> For this power resource to turn ON power for the modem it needs certain
> internal flag called "ONEN" to be set:
>
> Method (_ON, 0, NotSerialized) // _ON_: Power On
> {
>         If (^^^LPCB.EC0.ECRG)
>         {
>                 If ((ONEN =3D=3D Zero))
>                 {
>                         Return (Zero)
>                 }
> (..)
>         }
> }
>
> This flag only gets set from this power resource "_OFF" method, while the
> actual modem power gets turned off during suspend by "GP12.PTS" method
> called from the global "_PTS" (Prepare To Sleep) method.
>
> In fact, this power resource "_OFF" method implementation just sets the
> aforementioned flag:
>
> Method (_OFF, 0, NotSerialized) // _OFF: Power Off
> {
>         OFEN =3D Zero
>         ONEN =3D One
> }
>
> Upon hibernation finish we try to set this power resource back ON since i=
ts
> "_STA" method returns 0 and the resource is still considered in use as it
> is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
> and its parent PCIe port ACPI device (GP12).
> But the "_ON" method won't do anything since that "ONEN" flag is not set.

ONEN is not set when the image kernel gets control, which is not
unexpected (the _OFF method of this power resource has not been
evaluated yet), but I wonder why the power resource is off at that
point.

_PTS is only evaluated while preparing to hibernate or suspend the
system, so the restore kernel (the one started to load the image and
jump to the target kernel stored in the image) does not evaluate it
and the power resource is off nevertheless.

I gather that during regular initialization it gets turned on somehow?

> Overall, this means the modem is dead after hibernation finish until the
> laptop is rebooted since the modem power has been cut by "_PTS" and its P=
CI
> configuration was lost and not able to be restored.

Well, I'm not sure about this.

_PTS is evaluated during hibernation, but the BIOS gets control next.
It reinitializes the platform (presumably not completely) and starts
the boot loader which loads the restore kernel, which carries out a
regular kernel initialization of the platform including the
acpi_scan_init(), and that should turn the power resource in question
on.  It doesn't do it and I wonder why.

Something seems to be missing in that path.

Anyway, it looks like it might suffice to add an initialization quirk
for this power resource to evaluate _OFF and _ON for it to start with,
in acpi_add_power_resource().

> The easiest way to workaround this issue is to call this power resource
> "_OFF" method before calling the "_ON" method to make sure the "ONEN"
> flag gets properly set.
>
> This makes the modem alive once again after hibernation finish - with
> properly restored PCI configuration space.
>
> Since this platform does *not* support S3 the fact that
> acpi_resume_power_resources() is also called during resume from S3 is
> not a problem there.
>
> Do the DMI based quirk matching and quirk flag initialization just
> once - in acpi_power_resources_init() function similar to existing
> acpi_*_init() functions.
>
> This way the whole resume path overhead of this change on other systems
> amounts to hp_eb_gp12pxp_quirk flag comparison.
>
> Opportunistically convert the single already existing DMI match-based
> quirk in this ACPI power resource handler ("leave unused power
> resources on" quirk) to the same one-time initialization in
> acpi_power_resources_init() function instead of re-running that DMI
> match each time acpi_turn_off_unused_power_resources() gets called.
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> ---
>
> This Intel WWAN modem in general has *a lot* of issues with
> suspend/resume on various laptop platforms (not only HP).
>
> More patches are needed for these, hopefully they can be mainlined
> too so suspend/resume work out of the box for users (that's
> important functionality on a laptop).
>
> See the following ModemManager issue containing patches also for
> Thinkpad T14 G1 and Dell Precision 3561:
> https://gitlab.freedesktop.org/mobile-broadband/ModemManager/-/issues/992
>
>
> Changes from v1:
> * Move hp_eb_gp12pxp_quirk flag initialization via DMI match to
>   new acpi_power_resources_init() function for reduced resume path
>   overhead.
>
> * Move also the existing DMI match-based quirk for leaving unused power
>   resources ON to acpi_power_resources_init() function for consistency.
>
> * Update patch description about acpi_resume_power_resources() being
>   called also from S3 resume not being an issue on this platform.
>
>  drivers/acpi/internal.h |  1 +
>  drivers/acpi/power.c    | 86 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/acpi/scan.c     |  1 +
>  3 files changed, 87 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index e2781864fdce..63354972ab0b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -140,6 +140,7 @@ int __acpi_device_uevent_modalias(const struct acpi_d=
evice *adev,
>  /* ---------------------------------------------------------------------=
-----
>                                    Power Resource
>     ---------------------------------------------------------------------=
----- */
> +void acpi_power_resources_init(void);
>  void acpi_power_resources_list_free(struct list_head *list);
>  int acpi_extract_power_resources(union acpi_object *package, unsigned in=
t start,
>                                  struct list_head *list);
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index b7243d7563b1..944c17b471d5 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -23,6 +23,7 @@
>
>  #define pr_fmt(fmt) "ACPI: PM: " fmt
>
> +#include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -63,6 +64,9 @@ struct acpi_power_resource_entry {
>         struct acpi_power_resource *resource;
>  };
>
> +static bool hp_eb_gp12pxp_quirk;
> +static bool leave_unused_power_resources_on_quirk;

This name is a bit too long IMV.  unused_power_resources_quirk would suffic=
e.

> +
>  static LIST_HEAD(acpi_power_resource_list);
>  static DEFINE_MUTEX(power_resource_list_lock);
>
> @@ -992,6 +996,18 @@ struct acpi_device *acpi_add_power_resource(acpi_han=
dle handle)
>  }
>
>  #ifdef CONFIG_ACPI_SLEEP
> +static bool resource_is_gp12pxp(acpi_handle handle)
> +{
> +       const char *path;
> +       bool ret;
> +
> +       path =3D acpi_handle_path(handle);
> +       ret =3D path && strcmp(path, "\\_SB_.PCI0.GP12.PXP_") =3D=3D 0;
> +       kfree(path);

Having to do this on every resume for every power resource on this
platform seems a bit overkill to me.

Besides, if you add a new function for it, you might as well put
everything including the final delay to it and call it instead of
__acpi_power_on() for the quirky power resource.

That would be much cleaner code IMV.

> +
> +       return ret;
> +}
> +
>  void acpi_resume_power_resources(void)
>  {
>         struct acpi_power_resource *resource;
> @@ -1013,8 +1029,34 @@ void acpi_resume_power_resources(void)
>
>                 if (state =3D=3D ACPI_POWER_RESOURCE_STATE_OFF
>                     && resource->ref_count) {
> +                       bool eb_gp12pxp =3D hp_eb_gp12pxp_quirk &&
> +                               resource_is_gp12pxp(resource->device.hand=
le);
> +
> +                       if (eb_gp12pxp) {
> +                               acpi_handle_notice(resource->device.handl=
e,
> +                                                  "HP EB quirk - turning=
 OFF before ON\n");
> +                               __acpi_power_off(resource);
> +                       }
> +
>                         acpi_handle_debug(resource->device.handle, "Turni=
ng ON\n");
>                         __acpi_power_on(resource);
> +
> +                       if (eb_gp12pxp) {
> +                               /*
> +                                * Use the same delay as DSDT uses in mod=
em _RST
> +                                * method.
> +                                *
> +                                * Otherwise we get "Unable to change pow=
er
> +                                * state from unknown to D0, device
> +                                * inaccessible" error for the modem PCI =
device
> +                                * after thaw.
> +                                *
> +                                * This power resource is normally being =
enabled
> +                                * only during thaw (once) so this wait i=
s not
> +                                * a performance issue.
> +                                */
> +                               msleep(200);
> +                       }
>                 }
>
>                 mutex_unlock(&resource->resource_lock);
> @@ -1024,6 +1066,41 @@ void acpi_resume_power_resources(void)
>  }
>  #endif
>
> +static const struct dmi_system_id dmi_hp_elitebook_gp12pxp_quirk[] =3D {
> +/*
> + * This laptop (and possibly similar models too) has power resource call=
ed
> + * "GP12.PXP_" for its WWAN modem.
> + *
> + * For this power resource to turn ON power for the modem it needs certa=
in
> + * internal flag called "ONEN" to be set.
> + * This flag only gets set from this power resource "_OFF" method, while=
 the
> + * actual modem power gets turned off during suspend by "GP12.PTS" metho=
d
> + * called from the global "_PTS" (Prepare To Sleep) method.
> + * On the other hand, this power resource "_OFF" method implementation j=
ust
> + * sets the aforementioned flag without actually doing anything else (it
> + * doesn't contain any code to actually turn off power).
> + *
> + * The above means that when upon hibernation finish we try to set this
> + * power resource back ON since its "_STA" method returns 0 (while the r=
esource
> + * is still considered in use) its "_ON" method won't do anything since
> + * that "ONEN" flag is not set.
> + * Overall, this means the modem is dead until laptop is rebooted since =
its
> + * power has been cut by "_PTS" and its PCI configuration was lost and n=
ot able
> + * to be restored.
> + *
> + * The easiest way to workaround the issue is to call this power resourc=
e
> + * "_OFF" method before calling the "_ON" method to make sure the "ONEN"
> + * flag gets properly set.
> + */
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 855 G7 =
Notebook PC"),
> +               },
> +       },
> +       {}
> +};
> +
>  static const struct dmi_system_id dmi_leave_unused_power_resources_on[] =
=3D {
>         {
>                 /*
> @@ -1046,7 +1123,7 @@ void acpi_turn_off_unused_power_resources(void)
>  {
>         struct acpi_power_resource *resource;
>
> -       if (dmi_check_system(dmi_leave_unused_power_resources_on))
> +       if (leave_unused_power_resources_on_quirk)

I'd prefer this change to go into a separate preparatory patch, along
with the addition of acpi_power_resources_init().

>                 return;
>
>         mutex_lock(&power_resource_list_lock);
> @@ -1065,3 +1142,10 @@ void acpi_turn_off_unused_power_resources(void)
>
>         mutex_unlock(&power_resource_list_lock);
>  }
> +
> +void __init acpi_power_resources_init(void)
> +{
> +       hp_eb_gp12pxp_quirk =3D dmi_check_system(dmi_hp_elitebook_gp12pxp=
_quirk);
> +       leave_unused_power_resources_on_quirk =3D
> +               dmi_check_system(dmi_leave_unused_power_resources_on);
> +}
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..bb74e7834435 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -2702,6 +2702,7 @@ void __init acpi_scan_init(void)
>         acpi_memory_hotplug_init();
>         acpi_watchdog_init();
>         acpi_pnp_init();
> +       acpi_power_resources_init();
>         acpi_int340x_thermal_init();
>         acpi_init_lpit();

I'm not yet convinced about adding a quirk to
acpi_resume_power_resources().  I'd very much prefer to add one to the
initialization part.

