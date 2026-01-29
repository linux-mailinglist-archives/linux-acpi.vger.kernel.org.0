Return-Path: <linux-acpi+bounces-20767-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HWfMVxse2mMEgIAu9opvQ
	(envelope-from <linux-acpi+bounces-20767-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:19:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71561B0D87
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1EA303715F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jan 2026 14:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5CE2309B9;
	Thu, 29 Jan 2026 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ia7CCo3O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD03770B;
	Thu, 29 Jan 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769696297; cv=none; b=RHohaU4vFoqueTuqtpuY+9VzOTHr5qK1ndOkhc9uz5rBjzh6M43+UxHgmbGmiklhDVSTKmwJwE7m8+7u1RqdtatIdLbnCed6LOp/yDsltxUUOuJtxTbds8XKTOuz5XxPyLq0cGGwHJ4i2rK4TKMHnXGjGEUIrUrAlayv65PgEK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769696297; c=relaxed/simple;
	bh=6o70TQiXd/uUsmAM33d6htQTNykph/Iq07haWmLQRug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ed7f0MXFXRnFT6tC5NgNhC5cQUHDrnE1wV3US8Mtgh6/N2X+knbtSdINotwNT1BdepgTnpgmI70HMjecbaXjxsUgvKBs4tEav+szp8hX4IDvX4UJNnHRsfGpyz6H7KKP+Z9iyTE88B7OgLxRoPydy6Uls7l34dxoAx2imcEpzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ia7CCo3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652BAC4CEF7;
	Thu, 29 Jan 2026 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769696296;
	bh=6o70TQiXd/uUsmAM33d6htQTNykph/Iq07haWmLQRug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ia7CCo3OyDPByOOLLKLJ8Jx7jRHsmzxs6Brgrd/XCs04rij1+rU/0cMPpZEEeaxmx
	 CmNXj5GWHvvGtBuoX32lhqXb+Vzl1c2lO5l3dPYznNdWyoTo0rUtv01Oo0HV8n/HZ+
	 7YscgrOgG9ateGmuvXsfqzS0Md/48FkFJD3Om42wJzw5vg5zNzC0ahpTMBAVtsdo/v
	 UCwD/ckhoAZslROS2wILWkSPsg2vosMp9DWhROuKZ4Rl64lCKl0W5l5pwMwRn8yAuc
	 +8/SBrK7NiAz3zcDlwHV8zAo465leA/sFmiUv9dAS1/y4gymnvJ1Nqa+ZbSWQbyU/e
	 dDZiZbLQOXpbg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Subject:
 [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to
 acpi_power_meter_notify()
Date: Thu, 29 Jan 2026 15:18:11 +0100
Message-ID: <6252535.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
References:
 <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki>
 <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20767-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 71561B0D87
X-Rspamd-Action: no action

On Wednesday, January 28, 2026 10:52:15 PM CET Guenter Roeck wrote:
> On Wed, Jan 28, 2026 at 08:52:49PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki wrote:
> > > On Wed, Jan 28, 2026 at 7:18=E2=80=AFPM Guenter Roeck <linux@roeck-us=
=2Enet> wrote:
> > > >
> > > > Hi all,
> > > >
> > > > On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
> > > > > On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> > > > > <jaroslav.pulchart@gooddata.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > after upgrading from kernel 6.17.y to 6.18.y we started to obse=
rve a regression
> > > > > > in the ACPI power meter hwmon interface. Reading power*_average=
 sysfs
> > > > > > attributes blocks indefinitely and causes tasks to enter uninte=
rruptible
> > > > > > sleep (D state).
> > > > >
> > > > > The most recent change in the acpi_power_meter driver was made in
> > > > > 6.15, so this is not a regression in that driver.
> > > > >
> > > > > Also, nothing suspicious is done in power1_average_min_show() and
> > > > > power1_average_min_store() AFAICS.
> > > > >
> > > >
> > > > I decided to ask AI (Gemini 3, more specifically) for an analysis o=
f the
> > > > problem, using Chris Mason's prompts for guidance. Result is below.
> > >=20
> > > So it agrees with me in the analysis part.
> > >=20
> Yes.
>=20
> > > > The suggested fix may be a feasible workaround. Let me know what yo=
u think.
> > >=20
> > > Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
> > > notifications compete with each other because they may try to
> > > unregister the hwmon device at the same time.
> > >=20
> Good point.
>=20
> > > I would just add a separate lock for the notifier (a static one should
> > > suffice) and make changes to "resource" only under resource->lock.
> > >=20
> > > Let me cut a prototype patch for this.
> > >=20
> >=20
> > Something like the below (untested).
> >=20
> > Note that it also fixes the driver removal which is tangentially relate=
d to the
> > problem at hand.
>=20
> I can't test it either, but I ran it through Gemini and it tells me:
>=20
>   Fixes: tag missing (y) [Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter)=
 Replace the deprecated hwmon_device_register")]
>=20
>   The commit addresses a deadlock regression introduced by the conversion=
 to
>   hwmon_device_register_with_info.
>=20
>   CHANGE-1: New static mutex `acpi_notify_lock` introduces global seriali=
zation.
>   This prevents concurrent notification handling for multiple power meter=
 devices.
>   While likely a minor impact given the nature of the device, it technica=
lly reduces parallelism compared to the per-device locking used previously.
>=20
> Just for fun I tried again, this time using a model which is more prone to
> false positives. It pretty much provided the same result in more detail.
> It is a bit more verbose, so I attached it below. I also asked it to veri=
fy,
> using the backtrace, if the patch is complete, and to suggest a patch
> description. The result is also attached below.
>=20
> I think this is good enough for a formal patch. WDYT ?

With all due respect to the AI, I think that it has missed a couple of thin=
gs,
so below it the patch with my version of the changelog.

Also, it really wants to be two patches IMV, one adding the
IS_ERR(resource->hwmon_dev) checks before hwmon device unregistration and
another one fixing the deadlock in question on top of it.  Please let me kn=
ow
if you want me to split this one.

Jaroslav, it would be nice to get some feedback on it from you as you seem =
to
be the only person here who can test it.

=2D--
=46rom: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi=
_power_meter_notify()

The acpi_power_meter driver's .notify() callback function,
acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
that is also acquired by callbacks in sysfs attributes of the device
being unregistered which is prone to deadlocks between sysfs access and
device removal.

Address this by moving the hwmon device removal in
acpi_power_meter_notify() outside the lock in question, but notice
that doing it alone is not sufficient because two concurrent
METER_NOTIFY_CONFIG notifications may be attempting to remove the
same device at the same time.  To prevent that from happening, add a
new lock serializing the execution of the switch () statement in
acpi_power_meter_notify().  For simplicity, it is a static mutex
which should not be a problem from the performance perspective.

The new lock also allows the hwmon_device_register_with_info()
in acpi_power_meter_notify() to be called outside the inner lock
because it prevents the other notifications handled by that function
from manipulating the "resource" object while the hwmon device based
on it is being registered.  The sending of ACPI netlink messages from
acpi_power_meter_notify() is serialized by the new lock too which
generally helps to ensure that the order of handling firmware
notifications is the same as the order of sending netlink messages
related to them.

In addition, notice that hwmon_device_register_with_info() may fail
in which case resource->hwmon_dev will become an error pointer,
so add checks to avoid attempting to unregister the hwmon device
pointer to by it in that case to acpi_power_meter_notify() and
acpi_power_meter_remove().

=46ixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated hw=
mon_device_register")
Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
=2D--
 drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

=2D-- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -47,6 +47,8 @@
 static int cap_in_hardware;
 static bool force_cap_on;
=20
+static DEFINE_MUTEX(acpi_notify_lock);
+
 static int can_cap_in_hardware(void)
 {
 	return force_cap_on || cap_in_hardware;
@@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
=20
 	resource =3D acpi_driver_data(device);
=20
+	guard(mutex)(&acpi_notify_lock);
+
 	switch (event) {
 	case METER_NOTIFY_CONFIG:
+		if (!IS_ERR(resource->hwmon_dev))
+			hwmon_device_unregister(resource->hwmon_dev);
+
 		mutex_lock(&resource->lock);
+
 		free_capabilities(resource);
 		remove_domain_devices(resource);
=2D		hwmon_device_unregister(resource->hwmon_dev);
 		res =3D read_capabilities(resource);
 		if (res)
 			dev_err_once(&device->dev, "read capabilities failed.\n");
 		res =3D read_domain_devices(resource);
 		if (res && res !=3D -ENODEV)
 			dev_err_once(&device->dev, "read domain devices failed.\n");
+
+		mutex_unlock(&resource->lock);
+
 		resource->hwmon_dev =3D
 			hwmon_device_register_with_info(&device->dev,
 							ACPI_POWER_METER_NAME,
@@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
 							power_extra_groups);
 		if (IS_ERR(resource->hwmon_dev))
 			dev_err_once(&device->dev, "register hwmon device failed.\n");
=2D		mutex_unlock(&resource->lock);
+
 		break;
 	case METER_NOTIFY_TRIP:
 		sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
@@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
 		return;
=20
 	resource =3D acpi_driver_data(device);
=2D	hwmon_device_unregister(resource->hwmon_dev);
+	if (!IS_ERR(resource->hwmon_dev))
+		hwmon_device_unregister(resource->hwmon_dev);
=20
 	remove_domain_devices(resource);
 	free_capabilities(resource);




