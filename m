Return-Path: <linux-acpi+bounces-17279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4887AB9A2CD
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 16:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB714A71B9
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E553054F8;
	Wed, 24 Sep 2025 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XWsIeH5m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D783054EB;
	Wed, 24 Sep 2025 14:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723083; cv=none; b=M6LOz5bxJGBfX57dblzXNWXH7XdyIG+eBl8P0PrxGupjxUB62Wh/l8F2UyhaOlEgzITdXocvBojLoCvwxLBRVVxQGkOLiSAq0Vw3kUYdW2y2kBJkmjAaDQtx9iZ50b6hbp9oNH+2pU+wTzDbCiKFEEX95S+NQgfDQhiyoHDOJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723083; c=relaxed/simple;
	bh=SBJbzI+a5EDCmQJVqd66UPCcUKx8PMbrUQzAs3ufUz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WkmZbE9OHMSAm5XJ1b7xZL0CHIH1QzubqU9XNcfwdv/9dbUgf3EgC3cRU4gXJTfNKQiH4ACyQVgeU9ZTCKtDOLzRe236vODykodxYOQqd03m0kuDW1r0OPWsXaKeUYb41iX1jywaHAT2xBJamU9nEwERnUKUQk5KgXVyuayX/lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XWsIeH5m; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=WqpeQ5qAYFhnm6GasJioV7bqqdYfgWz6OOnhDlY+7+U=;
	b=XWsIeH5mq6Jnb2vVB5KXB7Lfm5A55xzGPNbED0L+TR5yyAm53MwbfXK5CnJOf5
	NwcYMTTosJu4YEy+ghe9nDfwpTjL5IJAMd6ZUvO0q7KH/TWIAQYVPVDAc7J+NPib
	5yVRwJLzG3MWPRLucN9oLCCyIM7IvKOLTAtmviSqgINHM=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB3u8rm+9NoN1RcDg--.14964S2;
	Wed, 24 Sep 2025 22:10:47 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: rafael@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	luogf2025@163.com
Subject: Re:[PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Wed, 24 Sep 2025 22:10:45 +0800
Message-ID: <20250924141047.1477743-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0htRTTj1QEEmhxBDxYA8oXkg_KP5YrfwyngELDY+Ns1EQ@mail.gmail.com>
References: <CAJZ5v0htRTTj1QEEmhxBDxYA8oXkg_KP5YrfwyngELDY+Ns1EQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3u8rm+9NoN1RcDg--.14964S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuFWrGF4fCF4xGr1UKFW8Crg_yoW7tr48pa
	yUCFWYkF4UJF1UXw12qr1YvryYy3yrtryUWr9rGFy0k34q9F1xJr1UtFnrurZ8Cr4IkF48
	ZF4xXa13Zr13ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zirb15UUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/1tbiPQ-SmWjT9ip7EAAAs1

> On Wed, Sep 24, 2025 at 12:38 AM GuangFei Luo <luogf2025@163.com> wrote:
> >
> > > On Tuesday, September 23, 2025 7:12:03 PM CEST Rafael J. Wysocki wrote:
> > > > On Tue, Sep 23, 2025 at 6:14 PM GuangFei Luo <luogf2025@163.com> wrote:
> > > > >
> > > > > The functions battery_hook_add_battery(), battery_hook_remove_battery(),
> > > > > and sysfs_remove_battery() already acquire locks, so their internal
> > > > > accesses are safe.
> > > >
> > > > In fact, there are two locks in use, battery->sysfs_lock and
> > > > hook_mutex.  The latter is used for managing hooks and the former is
> > > > only used by sysfs_remove_battery(), so it only prevents that function
> > > > from racing with another instance of itself.
> > > >
> > > > I would suggest using battery->sysfs_lock for protecting battery->bat
> > > > in general.
> > > >
> > > > > acpi_battery_refresh() does check battery->bat, but its child
> > > > > functions (sysfs_add_battery() and sysfs_remove_battery()) already
> > > > > handle locking.
> > > >
> > > > What locking?  Before the $subject patch, sysfs_add_battery() doesn't
> > > > do any locking at all AFAICS.
> > > >
> > > > > In acpi_battery_notify(), battery->bat has no lock. However, the
> > > > > check of battery->bat is at the very end of the function. During
> > > > > earlier calls, battery->bat has already been protected by locks, so
> > > > > re-entry will not cause issues.
> > > >
> > > > All of the battery->bat checks and the code depending on them need to
> > > > go under the same lock.  I'd use battery->sysfs_lock for this as
> > > > already mentioned above.
> > >
> > > So my (untested) version of this fix is appended.
> > >
> > > Note that it explicitly prevents acpi_battery_notify() from racing with
> > > addition/removal, PM notifications, and resume.
> > >
> > > ---
> > >  drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
> > >  1 file changed, 23 insertions(+), 13 deletions(-)
> > >
> > > --- a/drivers/acpi/battery.c
> > > +++ b/drivers/acpi/battery.c
> > > @@ -92,7 +92,7 @@ enum {
> > >
> > >  struct acpi_battery {
> > >       struct mutex lock;
> > > -     struct mutex sysfs_lock;
> > > +     struct mutex update_lock;
> > >       struct power_supply *bat;
> > >       struct power_supply_desc bat_desc;
> > >       struct acpi_device *device;
> > > @@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
> > >
> > >  static void sysfs_remove_battery(struct acpi_battery *battery)
> > >  {
> > > -     mutex_lock(&battery->sysfs_lock);
> > > -     if (!battery->bat) {
> > > -             mutex_unlock(&battery->sysfs_lock);
> > > +     if (!battery->bat)
> > >               return;
> > > -     }
> > > +
> > >       battery_hook_remove_battery(battery);
> > >       power_supply_unregister(battery->bat);
> > >       battery->bat = NULL;
> > > -     mutex_unlock(&battery->sysfs_lock);
> > >  }
> > >
> > >  static void find_battery(const struct dmi_header *dm, void *private)
> > > @@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
> > >
> > >       if (!battery)
> > >               return;
> > > +
> > > +     guard(mutex)(&battery->update_lock);
> > > +
> > >       old = battery->bat;
> > >       /*
> > >        * On Acer Aspire V5-573G notifications are sometimes triggered too
> > > @@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
> > >  }
> > >
> > >  static int battery_notify(struct notifier_block *nb,
> > > -                            unsigned long mode, void *_unused)
> > > +                       unsigned long mode, void *_unused)
> > >  {
> > >       struct acpi_battery *battery = container_of(nb, struct acpi_battery,
> > >                                                   pm_nb);
> > > -     int result;
> > >
> > > -     switch (mode) {
> > > -     case PM_POST_HIBERNATION:
> > > -     case PM_POST_SUSPEND:
> > > +     if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
> > > +             guard(mutex)(&battery->update_lock);
> > > +
> > >               if (!acpi_battery_present(battery))
> > >                       return 0;
> > >
> > >               if (battery->bat) {
> > >                       acpi_battery_refresh(battery);
> > >               } else {
> > > +                     int result;
> > > +
> > >                       result = acpi_battery_get_info(battery);
> > >                       if (result)
> > >                               return result;
> > > @@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
> > >
> > >               acpi_battery_init_alarm(battery);
> > >               acpi_battery_get_state(battery);
> > > -             break;
> > >       }
> > >
> > >       return 0;
> > > @@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
> > >  {
> > >       int retry, ret;
> > >
> > > +     guard(mutex)(&battery->update_lock);
> > > +
> > >       for (retry = 5; retry; retry--) {
> > >               ret = acpi_battery_update(battery, false);
> > >               if (!ret)
> > > @@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
> > >       if (result)
> > >               return result;
> > >
> > > -     result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
> > > +     result = devm_mutex_init(&device->dev, &battery->update_lock);
> > >       if (result)
> > >               return result;
> > >
> > > @@ -1262,6 +1264,8 @@ fail_pm:
> > >       device_init_wakeup(&device->dev, 0);
> > >       unregister_pm_notifier(&battery->pm_nb);
> > >  fail:
> > > +     guard(mutex)(&battery->update_lock);
> > > +
> > >       sysfs_remove_battery(battery);
> > >
> > >       return result;
> > > @@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
> > >
> > >       device_init_wakeup(&device->dev, 0);
> > >       unregister_pm_notifier(&battery->pm_nb);
> > > +
> > > +     guard(mutex)(&battery->update_lock);
> > > +
> > >       sysfs_remove_battery(battery);
> > >  }
> > >
> > > @@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
> > >               return -EINVAL;
> > >
> > >       battery->update_time = 0;
> > > +
> > > +     guard(mutex)(&battery->update_lock);
> > > +
> > >       acpi_battery_update(battery, true);
> > >       return 0;
> > >  }
> >
> > Thanks for the detailed explanation and the updated version of the fix.
> >
> > I will test your suggested changes on my platform.
> > After verification, I will send a v7 based on your suggestion.
> 
> Please just verify and I'll add a changelog and subject to the patch
> and submit it.
> 
> Thanks!

I have tested your updated patch on my laptop with battery hot-plug scenarios.
Everything looks normal and I did not observe any issues.

Thanks!


