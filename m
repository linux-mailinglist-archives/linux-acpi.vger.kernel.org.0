Return-Path: <linux-acpi+bounces-20721-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N9cMBhpemmB5gEAu9opvQ
	(envelope-from <linux-acpi+bounces-20721-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:52:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3B8A84D8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 20:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37773037E40
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065DA37419C;
	Wed, 28 Jan 2026 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvUmlFC9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D04371066;
	Wed, 28 Jan 2026 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769629973; cv=none; b=JGYu0cVDuWaSU5EPf7e7tOjrw9A7JI8+2yrW4emke4uyg4mIkYEtBo7yO9cFew5OkGkz30OqI0JwPjQKf7N0KlcIxGmXj2XlFyJGM4ALIHvJB9wGEQ8F+7b+R6F9gwhgziXXT/fc3SL03R73Cdk3SmEn8bNIm2/RdMiAo2DB8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769629973; c=relaxed/simple;
	bh=lCcSLlb6ZckCsGezMdHszpWQULVZmyUZ9IE+jaQUhQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAwz85ZshZf9F7NHMU58OuwGFyiIfH2m/PMeYj+lZkjydoZweW+a17370bmm7qqmQ0cM8zgRy1jLDm7q8G9U5nGWea9R0+XFVj3L7iWy4Noa/9Yd5Ho5+nw+Hyw+8vBw/5Rl4MgHDGOtXTT1cjOkQmf7pNE49Z4apYkWNJGlG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvUmlFC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DE1C4CEF7;
	Wed, 28 Jan 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769629973;
	bh=lCcSLlb6ZckCsGezMdHszpWQULVZmyUZ9IE+jaQUhQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvUmlFC9aark20y07pUH2oDU8MSjK56T9pR7TmtH9dkPw1yCfPLw/a6y3qgN0VVc4
	 Gbr2YiXJvXY2KFKEMGpZO5IVwiGRt4tx6bLRVrfs6N3LgvS/0FHWRzTJl7HIct0v17
	 8y+Mnt8sv1CpH5021KmfOMLhTbsNG64h/Fvn4YR8x0DEdhIpu7pj93VO2Aw1agakuK
	 JMlZ64MASKcZWA8F9+bq8673UMccpTzSnJBMxhe5kmt7A7ZIOIrRrnxyxZUasLHCgn
	 vA82E9+8tD+BFJ6VE9VSlhTIyri9LlnQ778L0PkRojAeuDDIXL+PCF6G775f82W3r6
	 C2WE2rIQ6BHWw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
 Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Cc: linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>,
 Zdenek Pesek <zdenek.pesek@gooddata.com>,
 Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs,
 mutex deadlock in hwmon_attr_show since v6.18.y
Date: Wed, 28 Jan 2026 20:52:49 +0100
Message-ID: <12855313.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To:
 <CAJZ5v0iGe7LSiQuotFSC68ZoZMrdaJVCMcEWtdzKbG59rrRcMQ@mail.gmail.com>
References:
 <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
 <CAJZ5v0iGe7LSiQuotFSC68ZoZMrdaJVCMcEWtdzKbG59rrRcMQ@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-20721-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gooddata.com:email]
X-Rspamd-Queue-Id: 6F3B8A84D8
X-Rspamd-Action: no action

On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki wrote:
> On Wed, Jan 28, 2026 at 7:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net=
> wrote:
> >
> > Hi all,
> >
> > On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> > > <jaroslav.pulchart@gooddata.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > after upgrading from kernel 6.17.y to 6.18.y we started to observe =
a regression
> > > > in the ACPI power meter hwmon interface. Reading power*_average sys=
fs
> > > > attributes blocks indefinitely and causes tasks to enter uninterrup=
tible
> > > > sleep (D state).
> > >
> > > The most recent change in the acpi_power_meter driver was made in
> > > 6.15, so this is not a regression in that driver.
> > >
> > > Also, nothing suspicious is done in power1_average_min_show() and
> > > power1_average_min_store() AFAICS.
> > >
> >
> > I decided to ask AI (Gemini 3, more specifically) for an analysis of the
> > problem, using Chris Mason's prompts for guidance. Result is below.
>=20
> So it agrees with me in the analysis part.
>=20
> > The suggested fix may be a feasible workaround. Let me know what you th=
ink.
>=20
> Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
> notifications compete with each other because they may try to
> unregister the hwmon device at the same time.
>=20
> I would just add a separate lock for the notifier (a static one should
> suffice) and make changes to "resource" only under resource->lock.
>=20
> Let me cut a prototype patch for this.
>=20

Something like the below (untested).

Note that it also fixes the driver removal which is tangentially related to=
 the
problem at hand.

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




