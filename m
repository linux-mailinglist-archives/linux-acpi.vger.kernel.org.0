Return-Path: <linux-acpi+bounces-17241-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D445B97BEA
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Sep 2025 00:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD10919C0FF0
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 22:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044E43115A0;
	Tue, 23 Sep 2025 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oBW6V6+E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14E230FC1C;
	Tue, 23 Sep 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758667133; cv=none; b=ktFvNiGGlXWSJ0c0WG+ejP8NR0DAqQbZSQE31cKrver3Oh4uWBg2V5NDr7VQ9UsWOL2wW7yfq06SsIUWYtVJr+rzRFQc2uDmD4Dyw4FHNYoQjGXKO0l1tL3XxNjXNwZZi9FqoyCs9yUU92WaZdLa9WbvI21M6WOJzLpufyxe+w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758667133; c=relaxed/simple;
	bh=3ClJm3GGCbKnrDe8xlc0T1sj5TO27qNztLWoK747IkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oe0ByCs9vvKA+e+Ks8dWhosEk2MwWek6wS2gCDP0Q1wLcTUOwyxC/gJuiW3ZAi7etRRwlXS5Iu9JS15BQB4O7Dl3MuCpWPkYvcjI3biJ4WDLHlxNRLlzJyooeMKNlGDKnma0gM3+5yNe5HOdH90sXkQ/9dllPK/srzMP3XeZepo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oBW6V6+E; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=TTWQOmGgkRlfr3lkdxz0rDPCmCvx7LmjjYcHdx7zUf0=;
	b=oBW6V6+EYRbKWu59T12hc+AVpLa7QEzPlltRgEnLXAgqo5aWHe52DicBIkfqit
	hkWKq7tMqmPIxKc8r5ZSVBl4tNBW6pmXZ/Za3YizyGEikvdwMfZmAnvgkY+PYA+u
	g6/EFJVjBJLWinDp42qxFSxj21fK2pofDUd7sNUtRK77g=
Received: from MS-CMFLBWVCLQRG.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDH2yRoIdNo2NsLDg--.8619S2;
	Wed, 24 Sep 2025 06:38:33 +0800 (CST)
From: GuangFei Luo <luogf2025@163.com>
To: rafael@kernel.org
Cc: dan.carpenter@linaro.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	luogf2025@163.com
Subject: Re:[PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on rapid events
Date: Wed, 24 Sep 2025 06:38:29 +0800
Message-ID: <20250923223831.1308685-1-luogf2025@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5944379.DvuYhMxLoT@rafael.j.wysocki>
References: <5944379.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH2yRoIdNo2NsLDg--.8619S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3JF1xKrWrGryDuryUKF1kuFg_yoW7Xr45pa
	yUCFWYkr4UJ3WUXw12qr4Yvry3Z3yFyrWjgr9rury0k34DWF1xJr15tF9rZrZxKryFka1r
	ZF4xX3W5Zw17ZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziDPEfUUUUU=
X-CM-SenderInfo: poxrwwisqskqqrwthudrp/1tbiPQ-RmWjTEazrCAAAsf

> On Tuesday, September 23, 2025 7:12:03 PM CEST Rafael J. Wysocki wrote:
> > On Tue, Sep 23, 2025 at 6:14 PM GuangFei Luo <luogf2025@163.com> wrote:
> > >
> > > The functions battery_hook_add_battery(), battery_hook_remove_battery(),
> > > and sysfs_remove_battery() already acquire locks, so their internal
> > > accesses are safe.
> > 
> > In fact, there are two locks in use, battery->sysfs_lock and
> > hook_mutex.  The latter is used for managing hooks and the former is
> > only used by sysfs_remove_battery(), so it only prevents that function
> > from racing with another instance of itself.
> > 
> > I would suggest using battery->sysfs_lock for protecting battery->bat
> > in general.
> > 
> > > acpi_battery_refresh() does check battery->bat, but its child
> > > functions (sysfs_add_battery() and sysfs_remove_battery()) already
> > > handle locking.
> > 
> > What locking?  Before the $subject patch, sysfs_add_battery() doesn't
> > do any locking at all AFAICS.
> > 
> > > In acpi_battery_notify(), battery->bat has no lock. However, the
> > > check of battery->bat is at the very end of the function. During
> > > earlier calls, battery->bat has already been protected by locks, so
> > > re-entry will not cause issues.
> > 
> > All of the battery->bat checks and the code depending on them need to
> > go under the same lock.  I'd use battery->sysfs_lock for this as
> > already mentioned above.
> 
> So my (untested) version of this fix is appended.
> 
> Note that it explicitly prevents acpi_battery_notify() from racing with
> addition/removal, PM notifications, and resume.
> 
> ---
>  drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
>  1 file changed, 23 insertions(+), 13 deletions(-)
> 
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -92,7 +92,7 @@ enum {
>  
>  struct acpi_battery {
>  	struct mutex lock;
> -	struct mutex sysfs_lock;
> +	struct mutex update_lock;
>  	struct power_supply *bat;
>  	struct power_supply_desc bat_desc;
>  	struct acpi_device *device;
> @@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
>  
>  static void sysfs_remove_battery(struct acpi_battery *battery)
>  {
> -	mutex_lock(&battery->sysfs_lock);
> -	if (!battery->bat) {
> -		mutex_unlock(&battery->sysfs_lock);
> +	if (!battery->bat)
>  		return;
> -	}
> +
>  	battery_hook_remove_battery(battery);
>  	power_supply_unregister(battery->bat);
>  	battery->bat = NULL;
> -	mutex_unlock(&battery->sysfs_lock);
>  }
>  
>  static void find_battery(const struct dmi_header *dm, void *private)
> @@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
>  
>  	if (!battery)
>  		return;
> +
> +	guard(mutex)(&battery->update_lock);
> +
>  	old = battery->bat;
>  	/*
>  	 * On Acer Aspire V5-573G notifications are sometimes triggered too
> @@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
>  }
>  
>  static int battery_notify(struct notifier_block *nb,
> -			       unsigned long mode, void *_unused)
> +			  unsigned long mode, void *_unused)
>  {
>  	struct acpi_battery *battery = container_of(nb, struct acpi_battery,
>  						    pm_nb);
> -	int result;
>  
> -	switch (mode) {
> -	case PM_POST_HIBERNATION:
> -	case PM_POST_SUSPEND:
> +	if (mode == PM_POST_SUSPEND || mode == PM_POST_HIBERNATION) {
> +		guard(mutex)(&battery->update_lock);
> +
>  		if (!acpi_battery_present(battery))
>  			return 0;
>  
>  		if (battery->bat) {
>  			acpi_battery_refresh(battery);
>  		} else {
> +			int result;
> +
>  			result = acpi_battery_get_info(battery);
>  			if (result)
>  				return result;
> @@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
>  
>  		acpi_battery_init_alarm(battery);
>  		acpi_battery_get_state(battery);
> -		break;
>  	}
>  
>  	return 0;
> @@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
>  {
>  	int retry, ret;
>  
> +	guard(mutex)(&battery->update_lock);
> +
>  	for (retry = 5; retry; retry--) {
>  		ret = acpi_battery_update(battery, false);
>  		if (!ret)
> @@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
>  	if (result)
>  		return result;
>  
> -	result = devm_mutex_init(&device->dev, &battery->sysfs_lock);
> +	result = devm_mutex_init(&device->dev, &battery->update_lock);
>  	if (result)
>  		return result;
>  
> @@ -1262,6 +1264,8 @@ fail_pm:
>  	device_init_wakeup(&device->dev, 0);
>  	unregister_pm_notifier(&battery->pm_nb);
>  fail:
> +	guard(mutex)(&battery->update_lock);
> +
>  	sysfs_remove_battery(battery);
>  
>  	return result;
> @@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
>  
>  	device_init_wakeup(&device->dev, 0);
>  	unregister_pm_notifier(&battery->pm_nb);
> +
> +	guard(mutex)(&battery->update_lock);
> +
>  	sysfs_remove_battery(battery);
>  }
>  
> @@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
>  		return -EINVAL;
>  
>  	battery->update_time = 0;
> +
> +	guard(mutex)(&battery->update_lock);
> +
>  	acpi_battery_update(battery, true);
>  	return 0;
>  }

Thanks for the detailed explanation and the updated version of the fix.

I will test your suggested changes on my platform.  
After verification, I will send a v7 based on your suggestion.


