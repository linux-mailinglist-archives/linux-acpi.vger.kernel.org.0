Return-Path: <linux-acpi+bounces-19377-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1F3C9ADF6
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 10:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ED8A346C57
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 09:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983912F99BC;
	Tue,  2 Dec 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="lYsZzoXM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D321321770B
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667973; cv=none; b=flZsnMFCayVYseJoTFNdWtWqIiB2fGKIC0N2mdAOvoKRW1hGQl7v2uwWo24F8CB/DhKCVOHFy8vIoObLnlJr/RejPacXFUj4VyEJExrDKa8IrPtozl/OXBcBs6z2lCGPe7ucn/28ZH4QwuVxhEvCOfGx8QXB0Fp5N+JiTu6RUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667973; c=relaxed/simple;
	bh=10taCUw/7s3xf9zH03ORq4A2KT9BtVgfVAfftbFw2oY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7ypMekfgUIkocgE4VcoxKC78oqc4pC7tRL9aOxVjfgHTXUBsZd/BaLAJtRI4C/m6Sf6C3Nu6oBHAFXbdPBMQM9qdg1q76WItFpU0lMr5AoDg7bPpgsMvD7FG09Cx9b8SefEsAaNNe+g93dlQ2kh+PtJvM+1h+4OFpW73Uz6Yo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=lYsZzoXM; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 3F22CBDA99
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 11:32:42 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 46DF1BDC25
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 11:32:40 +0200 (EET)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 87D6A201DB1
	for <linux-acpi@vger.kernel.org>; Tue,  2 Dec 2025 11:32:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1764667959;
	bh=uRxt55wqLPK/iVrwOAKPAycQy5iyYtN4ziDppSZbUyI=;
	h=Received:From:Subject:To;
	b=lYsZzoXM7UQnPLS7NPeayLfBgt6eSEnUnoO0ZxMT4NmV8dKJwDE5q9Hkur60lq661
	 f46/4577KpN+VgoK15xlZXgrTciKvZLT0TVVyv93Hp8gXvzxUbUiDi0tXZj32H0c8q
	 x9KAoVhwKQP2m6/rq18hSLPBS8X3a+NvE4YbpXKxbb0FzDhUurpAl4Z2I5GP510SwZ
	 +Qik7bNy/oiVXkAA+rErnUWnHVrEMIzcsL7n/bOMB5zwbDXl13pG3BqC3R1ywdOfZZ
	 n3FDJ1wi04iD56jgVnUjk4VhH+JabDBx6WLdtTUagwC9sRwBdBNNtRJvEuC8V3kPAR
	 FbG1tfDKXTBig==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-37902f130e1so49696391fa.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 02 Dec 2025 01:32:39 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVvm2RBeBo2oherU5+1kngjrSgHhdcSUL5dcgudZkLB8KfUOrxqyGzm6s6uDOx2LXz9oKxiQgXmuj@vger.kernel.org
X-Gm-Message-State: AOJu0YzBpnQI8AbS6eh+fY+p1vHk/6qRie8a/kXLuYscNGexYNku+cM9
	1TJMvL3GBn8m+MdxbHFjNxj9i173gHJKUMA9X+nalPl58lq+st3aKAm0SbIdcmzf9FlIEdjsGsD
	joGNjq7U6g4sjRQBxcTVqj4+fLhFffp8=
X-Google-Smtp-Source: 
 AGHT+IHp11HJkJDKP3M5QJVB6wclKdzgqzyvTWj2cRJyt6hjLucC1JlJd1Dg/2LmhG7ZvcFJ3Sp29JT3K434D3magt8=
X-Received: by 2002:a2e:b04c:0:b0:37a:47a4:d5cc with SMTP id
 38308e7fff4ca-37cd9259d86mr91871461fa.36.1764667958861; Tue, 02 Dec 2025
 01:32:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
In-Reply-To: <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 2 Dec 2025 10:32:27 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
X-Gm-Features: AWmQ_bl5juS6HD9R_4K8z58bl9WrUkLzxvOEeIVg_NvioX4R4987268hcHAa000
Message-ID: 
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mario Limonciello <superm1@kernel.org>,
	Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
	Richard Hughes <richard@hughsie.com>, William Jon McCann <mccann@jhu.edu>,
	"Jaap A . Haitsma" <jaap@haitsma.org>, Benjamin Canou <bookeldor@gmail.com>,
	Bastien Nocera <hadess@hadess.net>, systemd-devel@lists.freedesktop.org,
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176466795981.176780.16977210359831424743@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 2 Dec 2025 at 05:36, Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> Add `/sys/power/lps0_screen_off` interface to allow userspace to control
> Display OFF/ON DSM notifications at runtime. Writing "1" to this file
> triggers the OFF notification, and "0" triggers the ON notification.
>
> Userspace should write "1" after turning off all physical and remote
> displays. It should write "0" before turning on any of displays.
>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  Documentation/ABI/testing/sysfs-power |  13 +++
>  drivers/acpi/x86/s2idle.c             | 149 +++++++++++++++++++++++---
>  2 files changed, 145 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
> index d38da077905a..af7c81ae517c 100644
> --- a/Documentation/ABI/testing/sysfs-power
> +++ b/Documentation/ABI/testing/sysfs-power
> @@ -470,3 +470,16 @@ Description:
>
>                  Minimum value: 1
>                  Default value: 3
> +
> +What:          /sys/power/lps0_screen_off

Hi,
thanks for having a second stab at this. My initial series for this
was kind of complicated, I would need to rewrite it anyway [1].

I will second Mario on the integer values. The main.c file provides
the capabilities used in other power sysfs values and an ABI for doing
string options.

For me, I have a bit of a problem with the ABI. I kind of prefer the
one in [1]. There are three sleep states in Modern Standby: Screen
Off, Sleep, and LPS0/DRIPS (and a fake resume one I added). The only
one the kernel is suspended in is LPS0.

So the ABI should ideally be able to cover all three, even if at first
you only do screen off. This means the name kind of becomes a problem.
lps0_screen_off implies lps0 (is not the state, is also an ACPI x86
specific term) and is limited to screen_off (cannot add sleep).

I used /sys/power/standby in my series, which I think was fine because
you'd be able to add hooks to it for general drivers in the future.
This way, it would not be limited to ACPI devices and the name implies
that.

Two other notes. At this point we tested pretty much devices from all
manufacturers with my series. These notifications are used to control,
for sleep: thermal envelope, fan, power button light, for screen off:
keyboard backlight, device RGB, for lenovo power light as well. Yes,
DRI should be cc'd, but no-one has used these notifications to do GPU
specific stuff yet. You can call this ABI with a screen on just fine
on all known devices.

Handheld manufacturers typically tie their controllers to them as
well, as xinput does not implement the new suspend features in Windows
and blocks restricted modern standby, so they have to be turned off
beforehand. The exception to that is the Xbox Ally devices. This is
because with the Ally X, Asus switched to the Xbox GIP protocol which
does support these suspend features but still kept powering off the
controller. For the Xbox Allies, they went a step further and no
longer power off the controller.

Another difference between those two states and LPS0/DRIPS, is that
the LPS0/DRIPS specification binds the state to the power state of
certain onboard devices specified by ACPI (ie when the GPU, XYZ
components suspend, you enter this state). With Screen Off/Sleep,
there is no such requirement. For Screen Off, the general idea of a
screen is used, but sleep is completely arbitrary and in Windows is
defined by which software inhibitors lapse. This makes more sense
because even for LPS0/DRIPS in Windows, the way it enters it is
programmatic now as well (after all software inhibitors lapse). To
that end, there are three types of inhibitions in Windows, one for
screen on (such as video), screen off (such as compiling a kernel,
writing a CD), and sleep (periodic system processes; email
notifications; low CPU%).

Antheas

[1] https://lore.kernel.org/all/20241121172239.119590-1-lkml@antheas.dev/

> +Date:          November 2025
> +Contact:       Dmitrii Osipenko <dmitry.osipenko@collabora.com>
> +Description:
> +               This file is available if the ACPI/OSPM system supports
> +               Display Off/On DSM notifications. It controls state of the
> +               notification.
> +
> +               Writing a "1" to this file invokes Display Off Notification.
> +               Writing a "0" to this file invokes Display On Notification.
> +
> +               Notifications are only triggered on state transitions.
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236f61..d5cb5e22431d 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -18,7 +18,10 @@
>  #include <linux/acpi.h>
>  #include <linux/device.h>
>  #include <linux/dmi.h>
> +#include <linux/kobject.h>
> +#include <linux/mutex.h>
>  #include <linux/suspend.h>
> +#include <linux/sysfs.h>
>
>  #include "../sleep.h"
>
> @@ -61,6 +64,11 @@ static guid_t lps0_dsm_guid_microsoft;
>  static int lps0_dsm_func_mask_microsoft;
>  static int lps0_dsm_state;
>
> +static DEFINE_MUTEX(lps0_dsm_screen_off_lock);
> +static bool lps0_dsm_screen_state_off;
> +static bool lps0_screen_off_suspended;
> +static bool lps0_screen_off_sysfs_inhibit;
> +
>  /* Device constraint entry structure */
>  struct lpi_device_info {
>         char *name;
> @@ -513,6 +521,76 @@ static struct acpi_scan_handler lps0_handler = {
>         .attach = lps0_device_attach,
>  };
>
> +static bool lps0_has_screen_off_dsm(void)
> +{
> +       int id = acpi_s2idle_vendor_amd() ?
> +                ACPI_LPS0_SCREEN_ON_AMD : ACPI_LPS0_SCREEN_OFF;
> +
> +       if (lps0_dsm_func_mask_microsoft > 0 &&
> +           (lps0_dsm_func_mask & BIT(ACPI_LPS0_SCREEN_OFF)))
> +               return true;
> +
> +       if (lps0_dsm_func_mask > 0 && (lps0_dsm_func_mask & BIT(id)))
> +               return true;
> +
> +       return false;
> +}
> +
> +static void lps0_dsm_screen_off(void)
> +{
> +       if (lps0_dsm_screen_state_off)
> +               return;
> +
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_SCREEN_OFF_AMD :
> +                                       ACPI_LPS0_SCREEN_OFF,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +       if (lps0_dsm_func_mask_microsoft > 0)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +                                       lps0_dsm_func_mask_microsoft,
> +                                       lps0_dsm_guid_microsoft);
> +
> +       lps0_dsm_screen_state_off = true;
> +}
> +
> +static void lps0_dsm_screen_on(void)
> +{
> +       if (!lps0_dsm_screen_state_off)
> +               return;
> +
> +       if (lps0_dsm_func_mask_microsoft > 0)
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +                                       lps0_dsm_func_mask_microsoft,
> +                                       lps0_dsm_guid_microsoft);
> +
> +       if (lps0_dsm_func_mask > 0)
> +               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> +                                       ACPI_LPS0_SCREEN_ON_AMD :
> +                                       ACPI_LPS0_SCREEN_ON,
> +                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +
> +       lps0_dsm_screen_state_off = false;
> +}
> +
> +static void lps0_dsm_screen_off_set(int sysfs_off, int suspended)
> +{
> +       mutex_lock(&lps0_dsm_screen_off_lock);
> +
> +       if (sysfs_off > -1)
> +               lps0_screen_off_sysfs_inhibit = sysfs_off;
> +       if (suspended > -1)
> +               lps0_screen_off_suspended = suspended;
> +
> +       if (lps0_screen_off_suspended || lps0_screen_off_sysfs_inhibit)
> +               lps0_dsm_screen_off();
> +       else
> +               lps0_dsm_screen_on();
> +
> +       mutex_unlock(&lps0_dsm_screen_off_lock);
> +}
> +
>  static int acpi_s2idle_begin_lps0(void)
>  {
>         if (pm_debug_messages_on && !lpi_constraints_table) {
> @@ -543,15 +621,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
>                 lpi_check_constraints();
>
>         /* Screen off */
> -       if (lps0_dsm_func_mask > 0)
> -               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -                                       ACPI_LPS0_SCREEN_OFF_AMD :
> -                                       ACPI_LPS0_SCREEN_OFF,
> -                                       lps0_dsm_func_mask, lps0_dsm_guid);
> -
> -       if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +       lps0_dsm_screen_off_set(-1, true);
>
>         /* LPS0 entry */
>         if (lps0_dsm_func_mask > 0 && acpi_s2idle_vendor_amd())
> @@ -618,14 +688,7 @@ static void acpi_s2idle_restore_early_lps0(void)
>         }
>
>         /* Screen on */
> -       if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> -                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> -       if (lps0_dsm_func_mask > 0)
> -               acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -                                       ACPI_LPS0_SCREEN_ON_AMD :
> -                                       ACPI_LPS0_SCREEN_ON,
> -                                       lps0_dsm_func_mask, lps0_dsm_guid);
> +       lps0_dsm_screen_off_set(-1, false);
>  }
>
>  static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
> @@ -673,4 +736,56 @@ void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg)
>  }
>  EXPORT_SYMBOL_GPL(acpi_unregister_lps0_dev);
>
> +static ssize_t lps0_screen_off_store(struct kobject *kobj,
> +                                    struct kobj_attribute *attr,
> +                                    const char *buf, size_t count)
> +{
> +       unsigned long val;
> +
> +       if (kstrtoul(buf, 10, &val))
> +               return -EINVAL;
> +
> +       if (val > 1)
> +               return -EINVAL;
> +
> +       lps0_dsm_screen_off_set(val, -1);
> +
> +       return count;
> +}
> +
> +static ssize_t lps0_screen_off_show(struct kobject *kobj,
> +                                   struct kobj_attribute *attr,
> +                                   char *buf)
> +{
> +       return sprintf(buf, "%d\n", lps0_screen_off_sysfs_inhibit);
> +}
> +
> +static struct kobj_attribute lps0_screen_off_attr =
> +       __ATTR(lps0_screen_off, 0644,
> +              lps0_screen_off_show, lps0_screen_off_store);
> +
> +static struct attribute *lps0_screen_off_attrs[] = {
> +       &lps0_screen_off_attr.attr,
> +       NULL,
> +};
> +
> +static struct attribute_group lps0_screen_off_attr_group = {
> +       .attrs = lps0_screen_off_attrs,
> +};
> +
> +static int lps0_dsm_screen_off_init(void)
> +{
> +       int ret;
> +
> +       if (!lps0_has_screen_off_dsm())
> +               return 0;
> +
> +       ret = sysfs_create_group(power_kobj, &lps0_screen_off_attr_group);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +late_initcall(lps0_dsm_screen_off_init);
> +
>  #endif /* CONFIG_SUSPEND */
> --
> 2.51.1
>
>


