Return-Path: <linux-acpi+bounces-13576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F3AADF6E
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 14:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2135F17BACC
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8C9280010;
	Wed,  7 May 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4TXk1uG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732020AF9C
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621760; cv=none; b=CcoigOY21rmLL7tFc7e2fpCMhCFGM5ZMfJBVdppLNq1+JAznPRMaIk1aHywAJ9UqYQkK/JVYRcQ/y5lsQbmrMNGZ1Gke70MA+g4CcBJ0XodtIFGnz9nZYz6iXt10+Bzg/xDZiJ5X+0ozLEj9y7SUaC8Kd4XvEL8ujCWC41pgJTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621760; c=relaxed/simple;
	bh=Dq0SzA9lVU302a/wXCJ7k99/aLFlI+7RvRMxRXZrwGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcS9B7cEKEvvEgaeRCYQs15lkrv5buv6IpkadYD4PpJfAId8FCeyfA0TLBLRVwTJ2ccL2VTXFrKO+614pRWYwbAFxB2OxNZRiTYx+VDn+6va81hXKINIV9wUYsrmlrANiyAiVNTAbP6aLrWhVvTE6mmkY5hdvJCzl/zM2U4aQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4TXk1uG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BDAC4CEEB
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 12:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746621760;
	bh=Dq0SzA9lVU302a/wXCJ7k99/aLFlI+7RvRMxRXZrwGw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=g4TXk1uGv+wj9Ytbayfu3YUWegHPILOthOv32vYHyXUkRAuAYmJhr2dt5pQmHafkh
	 8cRz0hxgMqtMAs665VMaWMFcjzI/CHxgH8Mhznc6qVIEEV+P7IDGb8tcFCTkM5e6XV
	 yRvuHshHFxixXLgxFDNy6wGQxSoM0xQT2lHWDXWXY92eQPtlrm3mtmbsSOgcOvw4gW
	 evw+ZQDgDRMTKkgT7k0GOKxV6UGJuVa73WXdSArzxfjtHaikL+kUbzQUwcAl5K/j5Q
	 cyikreWViE7SALqdH/xSK9sIVL9YT+rWJSze6eFOaHmpB6V8Vz4tVcWc2Rl+jXBwHA
	 4JCxR56V6BLeQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-604f0d27c24so2882285eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 05:42:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvmcsOmmMcGW8zrVrz8m1V9hPNXagu6D+Nw07AQPXXDEFsmtbvhYH6fvxYKH1bp7ARoCILQoNSLiGN@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHFDwvqVO9ksQWwaiOmNOjAr0fHD6xhcyxrOWb/mzmJ74nem7
	L67y0K4NhXISlPKhKOw1yWnA13RikHn6ObdWtvnL2eyf9/dgDn4kqSt8Axo/SWX8jL7mnUh0xdG
	NZoQ8YPMr3Ba05RN00dyda6T+DVw=
X-Google-Smtp-Source: AGHT+IGy63QDn+eQmHJOvBSQpUUBb7ee84bCuWCHljk8pakt05nNlKsN9QYADn2Klk1m05trCakHhOhOa4VRpECGUuc=
X-Received: by 2002:a05:6871:340e:b0:2d4:e29d:529a with SMTP id
 586e51a60fabf-2db5bd7668fmr1987497fac.5.1746621759239; Wed, 07 May 2025
 05:42:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507042954.43674-1-pmarheine@chromium.org>
In-Reply-To: <20250507042954.43674-1-pmarheine@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 14:42:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0y0+a5O5skm79AONjkCi9zgD7yewHAs-WrCXT=Z8vCg@mail.gmail.com>
X-Gm-Features: ATxdqUEIO1z94DY3RenFthCwp6fIBAp5cEVxn6iS_lLwV1yiTLrWdKYlmdTMJ94
Message-ID: <CAJZ5v0i0y0+a5O5skm79AONjkCi9zgD7yewHAs-WrCXT=Z8vCg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: negate current when discharging
To: Peter Marheine <pmarheine@chromium.org>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 6:32=E2=80=AFAM Peter Marheine <pmarheine@chromium.o=
rg> wrote:
>
> The ACPI specification requires that battery rate is always positive,
> but the kernel ABI for POWER_SUPPLY_PROP_CURRENT_NOW
> (Documentation/ABI/testing/sysfs-class-power) specifies that it should
> be negative when a battery is discharging. When reporting CURRENT_NOW,
> massage the value to match the documented ABI.
>
> This only changes the sign of `current_now` and not `power_now` because
> documentation doesn't describe any particular meaning for `power_now` so
> leaving `power_now` unchanged is less likely to confuse userspace
> unnecessarily, whereas becoming consistent with the documented ABI is
> worth potentially confusing clients that read `current_now`.
>
> Signed-off-by: Peter Marheine <pmarheine@chromium.org>
> ---
>  drivers/acpi/battery.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8a..0ef03142fd 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -242,6 +242,18 @@ static int acpi_battery_get_property(struct power_su=
pply *psy,
>                         val->intval =3D battery->voltage_now * 1000;
>                 break;
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
> +               if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
> +                       ret =3D -ENODEV;
> +               else if ((battery->state & ACPI_BATTERY_STATE_DISCHARGING=
) &&
> +                        acpi_battery_handle_discharging(battery)
> +                               =3D=3D POWER_SUPPLY_STATUS_DISCHARGING)
> +                       /* ACPI specifies battery rate should always be
> +                        * positive, but this prop is negative when disch=
arging.
> +                        */
> +                       val->intval =3D battery->rate_now * -1000;
> +               else
> +                       val->intval =3D battery->rate_now * 1000;
> +               break;
>         case POWER_SUPPLY_PROP_POWER_NOW:
>                 if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
>                         ret =3D -ENODEV;
> --

What about this instead (modulo GMail-induced whitespace breakage):

---
 drivers/acpi/battery.c |   18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -243,10 +243,22 @@
         break;
     case POWER_SUPPLY_PROP_CURRENT_NOW:
     case POWER_SUPPLY_PROP_POWER_NOW:
-        if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
+        if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN) {
             ret =3D -ENODEV;
-        else
-            val->intval =3D battery->rate_now * 1000;
+            break;
+        }
+
+        val->intval =3D battery->rate_now * 1000;
+        /*
+         * When discharging, the current should be reported as a
+         * negative number as per the power supply class interface
+         * definition.
+         */
+        if (psp =3D=3D POWER_SUPPLY_PROP_CURRENT_NOW &&
+            (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
+            acpi_battery_handle_discharging(battery) =3D=3D
POWER_SUPPLY_STATUS_DISCHARGING)
+            val->intval =3D -val->intval;
+
         break;
     case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
     case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:

