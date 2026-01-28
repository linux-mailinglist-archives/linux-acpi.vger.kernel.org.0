Return-Path: <linux-acpi+bounces-20720-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNPbJ11Zemm35QEAu9opvQ
	(envelope-from <linux-acpi+bounces-20720-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 19:45:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439AAA7DE6
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 19:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4740B3005589
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jan 2026 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D8A37107B;
	Wed, 28 Jan 2026 18:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIbD7v0H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B369F330B31
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625944; cv=none; b=YG8ocG+c8uDGtct3eapU8CisVJLKICvNC4ttRqR3MjLUHICgn+6JlxzokMFYJszrgrWEs/l4Xa8hLvvSBFVWNOqvACkiUbVIfEj942IHGeb2D+dUojZxdNDrW6s6HfGnU7fXHj/A0wvygsR5R1ooUhzJMXh/l5SJuyPIapSNGMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625944; c=relaxed/simple;
	bh=5aMaAZIqEsHgnKMsrzr00VKMLg79C37URcIz5ElGvnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEk9CjNBEesHBBi/MlSAFcngPEWVM/Mr2Y0HfiujlBq5mIC5M+tJfnMeJPwOfW0Wwl5GP/EWLSVsnlVv2tFv1284oPYaAvBgUe5ehJsUf73YRBsiPGsgMyMNrqGngvRV4I05yOXFufKcTxBjBjlKDyBKCky8Ur2BsL+k+MxYYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIbD7v0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E4B4C2BCB0
	for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769625944;
	bh=5aMaAZIqEsHgnKMsrzr00VKMLg79C37URcIz5ElGvnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pIbD7v0HdVmX0L9OFtX24mr95+UTtYHIC4e7XJZQiCbKmyll+vzlRoR8tl/iD1fez
	 RpgYzSsAXujVTVIRHleQ6RbmXuLQDaO+4SWex8bLvsESPR8VJoYSg4XzUQJLm8RXbS
	 zkpBoICg94NHBROAxAtsppj+7KeCr1Hreg2n14DRv72kQoKKpycjwgzQyAvdPtQgEU
	 iTIyUFsyNqWUhckd7S7IAKp6R/FHfQs7GEqLJjLjnlsHuqXmtWp9s3dC2DYaVMcQwL
	 Nl+yLD0aBZxQdWQSGfWrzXon2Z/UI6usYXCd67DfgzcEgsKtu2YOPg4GNV2uAWbXHh
	 iPKRnGWVYQerg==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d1916d1e24so75201a34.3
        for <linux-acpi@vger.kernel.org>; Wed, 28 Jan 2026 10:45:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVrlIvEExh1Yt43v4fjydqE+nWzvOvH+6K+U8dhjd36ajG5LUoHM5m26+ttF2PefiMCDJM63SRtH3zm@vger.kernel.org
X-Gm-Message-State: AOJu0YxhNrxAGSOglqUagrLUD3uUyuMzzPLc7lSse6ZhB4D7/5PzlPXu
	B88SbX2crz3Pjsc1i2KGCSL1zpJISUguRlOam4KZWK8AkJ/quIDjAQeueByWMw4Hub0YNaBISTs
	iD7sXr48ySmv0Tw3oghLR+xsghbBndwQ=
X-Received: by 2002:a05:6820:60f:b0:662:efca:dbc8 with SMTP id
 006d021491bc7-662f20ca0e7mr3501386eaf.47.1769625943351; Wed, 28 Jan 2026
 10:45:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com> <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
In-Reply-To: <1d969bd7-4969-455d-9600-e4be14a78217@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 28 Jan 2026 19:45:32 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iGe7LSiQuotFSC68ZoZMrdaJVCMcEWtdzKbG59rrRcMQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgo6DSHesS8GsrAMaaODSy5O_0X6UPnbBf_EK4UVroP1ZyeWiCD9Nz-QY4
Message-ID: <CAJZ5v0iGe7LSiQuotFSC68ZoZMrdaJVCMcEWtdzKbG59rrRcMQ@mail.gmail.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	Igor Raits <igor@gooddata.com>, Daniel Secik <daniel.secik@gooddata.com>, 
	Zdenek Pesek <zdenek.pesek@gooddata.com>, Jiri Jurica <jiri.jurica@gooddata.com>, 
	Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20720-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[roeck-us.net:email,gooddata.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 439AAA7DE6
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 7:18=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi all,
>
> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> > <jaroslav.pulchart@gooddata.com> wrote:
> > >
> > > Hello,
> > >
> > > after upgrading from kernel 6.17.y to 6.18.y we started to observe a =
regression
> > > in the ACPI power meter hwmon interface. Reading power*_average sysfs
> > > attributes blocks indefinitely and causes tasks to enter uninterrupti=
ble
> > > sleep (D state).
> >
> > The most recent change in the acpi_power_meter driver was made in
> > 6.15, so this is not a regression in that driver.
> >
> > Also, nothing suspicious is done in power1_average_min_show() and
> > power1_average_min_store() AFAICS.
> >
>
> I decided to ask AI (Gemini 3, more specifically) for an analysis of the
> problem, using Chris Mason's prompts for guidance. Result is below.

So it agrees with me in the analysis part.

> The suggested fix may be a feasible workaround. Let me know what you thin=
k.

Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
notifications compete with each other because they may try to
unregister the hwmon device at the same time.

I would just add a separate lock for the notifier (a static one should
suffice) and make changes to "resource" only under resource->lock.

Let me cut a prototype patch for this.

> ---
> Summary of crash or warning
> Deadlock in acpi_power_meter driver between sysfs read and ACPI notify.
>
> Kernel version if available
> 6.18.6-1.gdc.el9.x86_64
>
> Cleaned up copy of oops or stack trace
> [  740.721209] Call Trace:
> [  741.467334]  power_meter_read+0x1ea/0x2c0 [acpi_power_meter]
> [  741.475320]  hwmon_attr_show+0x5e/0x130
> [  741.481343]  dev_attr_show+0x19/0x60
> [  741.487325]  sysfs_kf_seq_show+0xbf/0x140
> [  741.494315]  seq_read_iter+0x112/0x510
> [  741.503544]  vfs_read+0x215/0x340
>
> [  740.286380] INFO: task alloy:5901 blocked for more than 122 seconds.
> [  740.326290] Call Trace:
> [  740.336311]  __schedule+0x2b5/0x690
> [  740.341312]  schedule+0x23/0x80
> [  740.354335]  __mutex_lock.constprop.0+0x3c9/0xa00
> [  740.360318]  hwmon_attr_show+0x36/0x130
>
> Explanation of the problem
> The acpi_power_meter driver exhibits a deadlock when acpi_power_meter_not=
ify
> is called with METER_NOTIFY_CONFIG while a userspace process is concurren=
tly
> reading a sysfs attribute (e.g., power1_average).
>
> The deadlock occurs because acpi_power_meter_notify acquires resource->lo=
ck
> and then calls hwmon_device_unregister. The hwmon_device_unregister funct=
ion
> (via device_unregister and kernfs_remove) waits for all active sysfs call=
backs
> to complete. However, the active sysfs callback (power_meter_read) tries =
to
> acquire resource->lock which is already held by acpi_power_meter_notify.
>
> Sequence of events:
> 1. Userspace reads power1_average.
> 2. hwmon_attr_show is called. It calls power_meter_read.
> 3. power_meter_read attempts to acquire resource->lock.
> 4. Concurrently, ACPI triggers acpi_power_meter_notify with METER_NOTIFY_=
CONFIG.
> 5. acpi_power_meter_notify acquires resource->lock.
> 6. acpi_power_meter_notify calls hwmon_device_unregister.
> 7. hwmon_device_unregister waits for the active hwmon_attr_show (and thus
>    power_meter_read) to return.
> 8. power_meter_read is blocked waiting for resource->lock.
> 9. acpi_power_meter_notify is blocked waiting for power_meter_read to fin=
ish.
>
> This results in a deadlock and hung tasks. Other tasks trying to read sys=
fs
> attributes also hang waiting for the hwmon core lock (hwdev->lock) which =
is
> held by the blocked reader.
>
> Functions, snippets and call traces of code related to the problem
>
> drivers/hwmon/acpi_power_meter.c:
>
> static void acpi_power_meter_notify(struct acpi_device *device, u32 event=
)
> {
>         struct acpi_power_meter_resource *resource;
>         int res;
>
>         if (!device || !acpi_driver_data(device))
>                 return;
>
>         resource =3D acpi_driver_data(device);
>
>         switch (event) {
>         case METER_NOTIFY_CONFIG:
>                 mutex_lock(&resource->lock);
>                 free_capabilities(resource);
>                 remove_domain_devices(resource);
>                 hwmon_device_unregister(resource->hwmon_dev); /* DEADLOCK=
 HERE */
>                 res =3D read_capabilities(resource);
>                 /* ... */
>                 mutex_unlock(&resource->lock);
>                 break;
>         /* ... */
> }
>
> static int power_meter_read(struct device *dev, enum hwmon_sensor_types t=
ype,
>                             u32 attr, int channel, long *val)
> {
>         struct acpi_power_meter_resource *res =3D dev_get_drvdata(dev);
>         int ret =3D 0;
>
>         if (type !=3D hwmon_power)
>                 return -EINVAL;
>
>         guard(mutex)(&res->lock); /* BLOCKED HERE */
>
>         switch (attr) {
>         case hwmon_power_average:
>                 ret =3D update_meter(res);
>                 /* ... */
>         }
>         return 0;
> }
>
> Suggested Fix
> Move hwmon_device_unregister out of the critical section protected by
> resource->lock. It should be called before acquiring the lock to modify
> the resource structure.
>
> drivers/hwmon/acpi_power_meter.c:
>
>         case METER_NOTIFY_CONFIG:
> -               mutex_lock(&resource->lock);
> -               free_capabilities(resource);
> -               remove_domain_devices(resource);
> -               hwmon_device_unregister(resource->hwmon_dev);
> +               if (resource->hwmon_dev) {
> +                       hwmon_device_unregister(resource->hwmon_dev);
> +                       resource->hwmon_dev =3D NULL;
> +               }
> +
> +               mutex_lock(&resource->lock);
> +               free_capabilities(resource);
> +               remove_domain_devices(resource);
>                 res =3D read_capabilities(resource);

