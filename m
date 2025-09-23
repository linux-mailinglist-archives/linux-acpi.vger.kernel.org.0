Return-Path: <linux-acpi+bounces-17239-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C17B974D7
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 21:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1151B3AD171
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Sep 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89870302CB2;
	Tue, 23 Sep 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5UK470U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E029246BC5;
	Tue, 23 Sep 2025 19:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758654641; cv=none; b=e4grtHhjcQ0NNHspxvZZWyEKO456zdjLme6iWDYLQ3uufouhd0CDGvfjj5T6V8M5hJDYOeGb2SFw7hX22s/Dh7c1qfkLZWku6tj+X4y7H9zb8DTfRXQOwow8dv7wlQjX3l4W52JPPeVuPl3tL+VXSDEOXCEudN4UfWSLgbLzWh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758654641; c=relaxed/simple;
	bh=xaLfIgwTjhN50Ju8AcGh5N3H/X4GjoAKx9lDoUByqYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tC7jLB92yYZyHGnrGeAduP95DAA8fNq5dwlB4iXDEtaFDChwaGsywAQsQaZsMBZrjp+JedHcQHc6lIcF8qWJacy5hyh8OfMIc6UVK2bHUuEdginRbGxJ+X0fETIXKEhm5WpGuZO+G6kft5W08Dw1tvMukPuZiLqPlm3HlkmO734=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5UK470U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA36C4CEF5;
	Tue, 23 Sep 2025 19:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758654641;
	bh=xaLfIgwTjhN50Ju8AcGh5N3H/X4GjoAKx9lDoUByqYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l5UK470UnYm0oH0HoryY9V/BOQM0mocw2y7bEBgCWesAWouSIn3yog54D1NQjxcyd
	 jncnIynHWi5iLzlhCbI2gzMESAyuxylaXlIT7vX8GYM3IB5BMJBtpRUqMszt21+Qy6
	 /X5tZqW6rYMlvNLCkQlliF68oy7wRg1IACPWqUjMxHWoVlKuo0y30cqd1oc41tSHBq
	 Z7Nw4IrtwdqBWJQfCuo4Q8FBIvSmk9Y4Phkn/yza3YfrD9FxUam+31aH248jRF8+A6
	 pukNUytr5Z28BVGHcWq73tzvepx3kL+ukDyy5OdWyniMX5lnhEKoeJVqaOo9c0M564
	 Ac5ZjZDDFyuTQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: GuangFei Luo <luogf2025@163.com>
Cc: dan.carpenter@linaro.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject:
 Re: [PATCH v6] ACPI: battery: prevent sysfs_add_battery re-entry on rapid
 events
Date: Tue, 23 Sep 2025 21:10:37 +0200
Message-ID: <5944379.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
References:
 <CAJZ5v0guEkbMuMjS=aQRQdiiyUG_hxgu0imBX0kgho2womB0Hw@mail.gmail.com>
 <20250923161354.1307251-1-luogf2025@163.com>
 <CAJZ5v0j2UH31wJKsAE0Ppek9sSiGFbePZymzbuaLVNfKHXjK4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Tuesday, September 23, 2025 7:12:03 PM CEST Rafael J. Wysocki wrote:
> On Tue, Sep 23, 2025 at 6:14=E2=80=AFPM GuangFei Luo <luogf2025@163.com> =
wrote:
> >
> > The functions battery_hook_add_battery(), battery_hook_remove_battery(),
> > and sysfs_remove_battery() already acquire locks, so their internal
> > accesses are safe.
>=20
> In fact, there are two locks in use, battery->sysfs_lock and
> hook_mutex.  The latter is used for managing hooks and the former is
> only used by sysfs_remove_battery(), so it only prevents that function
> from racing with another instance of itself.
>=20
> I would suggest using battery->sysfs_lock for protecting battery->bat
> in general.
>=20
> > acpi_battery_refresh() does check battery->bat, but its child
> > functions (sysfs_add_battery() and sysfs_remove_battery()) already
> > handle locking.
>=20
> What locking?  Before the $subject patch, sysfs_add_battery() doesn't
> do any locking at all AFAICS.
>=20
> > In acpi_battery_notify(), battery->bat has no lock. However, the
> > check of battery->bat is at the very end of the function. During
> > earlier calls, battery->bat has already been protected by locks, so
> > re-entry will not cause issues.
>=20
> All of the battery->bat checks and the code depending on them need to
> go under the same lock.  I'd use battery->sysfs_lock for this as
> already mentioned above.

So my (untested) version of this fix is appended.

Note that it explicitly prevents acpi_battery_notify() from racing with
addition/removal, PM notifications, and resume.

=2D--
 drivers/acpi/battery.c |   36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -92,7 +92,7 @@ enum {
=20
 struct acpi_battery {
 	struct mutex lock;
=2D	struct mutex sysfs_lock;
+	struct mutex update_lock;
 	struct power_supply *bat;
 	struct power_supply_desc bat_desc;
 	struct acpi_device *device;
@@ -904,15 +904,12 @@ static int sysfs_add_battery(struct acpi
=20
 static void sysfs_remove_battery(struct acpi_battery *battery)
 {
=2D	mutex_lock(&battery->sysfs_lock);
=2D	if (!battery->bat) {
=2D		mutex_unlock(&battery->sysfs_lock);
+	if (!battery->bat)
 		return;
=2D	}
+
 	battery_hook_remove_battery(battery);
 	power_supply_unregister(battery->bat);
 	battery->bat =3D NULL;
=2D	mutex_unlock(&battery->sysfs_lock);
 }
=20
 static void find_battery(const struct dmi_header *dm, void *private)
@@ -1072,6 +1069,9 @@ static void acpi_battery_notify(acpi_han
=20
 	if (!battery)
 		return;
+
+	guard(mutex)(&battery->update_lock);
+
 	old =3D battery->bat;
 	/*
 	 * On Acer Aspire V5-573G notifications are sometimes triggered too
@@ -1094,21 +1094,22 @@ static void acpi_battery_notify(acpi_han
 }
=20
 static int battery_notify(struct notifier_block *nb,
=2D			       unsigned long mode, void *_unused)
+			  unsigned long mode, void *_unused)
 {
 	struct acpi_battery *battery =3D container_of(nb, struct acpi_battery,
 						    pm_nb);
=2D	int result;
=20
=2D	switch (mode) {
=2D	case PM_POST_HIBERNATION:
=2D	case PM_POST_SUSPEND:
+	if (mode =3D=3D PM_POST_SUSPEND || mode =3D=3D PM_POST_HIBERNATION) {
+		guard(mutex)(&battery->update_lock);
+
 		if (!acpi_battery_present(battery))
 			return 0;
=20
 		if (battery->bat) {
 			acpi_battery_refresh(battery);
 		} else {
+			int result;
+
 			result =3D acpi_battery_get_info(battery);
 			if (result)
 				return result;
@@ -1120,7 +1121,6 @@ static int battery_notify(struct notifie
=20
 		acpi_battery_init_alarm(battery);
 		acpi_battery_get_state(battery);
=2D		break;
 	}
=20
 	return 0;
@@ -1198,6 +1198,8 @@ static int acpi_battery_update_retry(str
 {
 	int retry, ret;
=20
+	guard(mutex)(&battery->update_lock);
+
 	for (retry =3D 5; retry; retry--) {
 		ret =3D acpi_battery_update(battery, false);
 		if (!ret)
@@ -1230,7 +1232,7 @@ static int acpi_battery_add(struct acpi_
 	if (result)
 		return result;
=20
=2D	result =3D devm_mutex_init(&device->dev, &battery->sysfs_lock);
+	result =3D devm_mutex_init(&device->dev, &battery->update_lock);
 	if (result)
 		return result;
=20
@@ -1262,6 +1264,8 @@ fail_pm:
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
 fail:
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
=20
 	return result;
@@ -1281,6 +1285,9 @@ static void acpi_battery_remove(struct a
=20
 	device_init_wakeup(&device->dev, 0);
 	unregister_pm_notifier(&battery->pm_nb);
+
+	guard(mutex)(&battery->update_lock);
+
 	sysfs_remove_battery(battery);
 }
=20
@@ -1297,6 +1304,9 @@ static int acpi_battery_resume(struct de
 		return -EINVAL;
=20
 	battery->update_time =3D 0;
+
+	guard(mutex)(&battery->update_lock);
+
 	acpi_battery_update(battery, true);
 	return 0;
 }




