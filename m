Return-Path: <linux-acpi+bounces-20787-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MF6+HMDvfGndPQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20787-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 18:52:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15133BD7A2
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 18:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6AF9630041E5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD1D34EEF1;
	Fri, 30 Jan 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyI1d8E+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8627A92E
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795515; cv=none; b=aLH5KKPgojxnhBE4eSC8i8jUz926uAJCK0gQOwcUokPonzDx6fQRNximQoDqNKqaK5pip1NUWSKkKSIcnXcwKkKw4IbjZ7cn9CAnLg4omR4c30081a2LpWgNZmgJ8JEy376W9qSjDDTB/9L7aUB2Awmsb9cxQDQSfgV4VClqxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795515; c=relaxed/simple;
	bh=ZUjj2ukE3urm1aqGfpVYEILnfeUyD0KCTiHgu17kz50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPP71WM93zZDqpkG4PgDLOgUTRuNg1igftaXlEUWCC5lKFbRA7Nwf8ARnz8V8Q+pLQBFVw1MLvSTs7uN47rFuNE1W+XJ+9X4KY6EvDs7JRHyWMnxT5J0QQWWwGTuqZwcABEqcmVjTZLEpmcQ/Lno26kIY2XUJd1bOfgNAXNRmE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyI1d8E+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17A9BC19421
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769795515;
	bh=ZUjj2ukE3urm1aqGfpVYEILnfeUyD0KCTiHgu17kz50=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FyI1d8E+fQDFS/mAPIBMoZzLA0uoaa/WrcDIiDLUIOfZ6guGPKrxrkgIMw+/Yg6SI
	 djTbCK5mHWBuFTMZ46KvDegmVqDdZjd0o0e5mscOlDclTZxjDwgbS2KSmoZWVhcfnv
	 oXP3zaZ2P5seF0FtOflcV/Y4VO5jkLgTZ5TAXbc0bc3EVI33/g4V01iKT22Nu1xMsW
	 sQRdnRFrKe48lI3sh2GFWWQA1PBT/E22urcxeXad6U/aPb/g8I5HtLXUpC1GbqI/YT
	 k0rfWr9+oWz/NvzP+t4rA/WiNZ7RCsrM0SbMNFzHSEY/IQ8M+itZECHRsV2GtfVJ/3
	 TAFSjMmru63Dg==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-662fad2dc91so1415019eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 09:51:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBMWTBf2txA85lcCNp9dpsT/N+rDgd9ukfec9vtHifyN3KDqvsyhXI1gjV6pvVYdibYuLi3QuH4JIx@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAhURAkCdC5A0MJACfFD8f6T6h18md7z7lqgONTLvWytb1xaP
	v+jwjGtiLs+BvfKT5SMo6ZUdywkf5xq9w00NP+QeE3ftQ5cZyI3zS9XyHOmj1mp0ie0akEmcMKx
	E6fQIgJh18BBZYHIPiEoSTky8qxoRrVI=
X-Received: by 2002:a4a:ee0d:0:b0:662:f4cb:207b with SMTP id
 006d021491bc7-6630ef5f238mr1759624eaf.0.1769795514114; Fri, 30 Jan 2026
 09:51:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki> <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki> <e30972fa-62de-401a-8fc2-a48a66ca2c73@roeck-us.net>
In-Reply-To: <e30972fa-62de-401a-8fc2-a48a66ca2c73@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 18:51:42 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jxEMhQ_i3ReOE9=XSaguGYTQA44staN=hBHhjVR0_zVg@mail.gmail.com>
X-Gm-Features: AZwV_Qj-h_fBc-RmyhpKBleWfFmtMhw-60EMEnfzskqsqeBGdl7bLyOVvophy78
Message-ID: <CAJZ5v0jxEMhQ_i3ReOE9=XSaguGYTQA44staN=hBHhjVR0_zVg@mail.gmail.com>
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20787-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: 15133BD7A2
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 2:07=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi Rafael,
>
> On 1/29/26 06:18, Rafael J. Wysocki wrote:
> > ---
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to =
acpi_power_meter_notify()
> >
> > The acpi_power_meter driver's .notify() callback function,
> > acpi_power_meter_notify(), calls hwmon_device_unregister() under a lock
> > that is also acquired by callbacks in sysfs attributes of the device
> > being unregistered which is prone to deadlocks between sysfs access and
> > device removal.
> >
> > Address this by moving the hwmon device removal in
> > acpi_power_meter_notify() outside the lock in question, but notice
> > that doing it alone is not sufficient because two concurrent
> > METER_NOTIFY_CONFIG notifications may be attempting to remove the
> > same device at the same time.  To prevent that from happening, add a
> > new lock serializing the execution of the switch () statement in
> > acpi_power_meter_notify().  For simplicity, it is a static mutex
> > which should not be a problem from the performance perspective.
> >
> > The new lock also allows the hwmon_device_register_with_info()
> > in acpi_power_meter_notify() to be called outside the inner lock
> > because it prevents the other notifications handled by that function
> > from manipulating the "resource" object while the hwmon device based
> > on it is being registered.  The sending of ACPI netlink messages from
> > acpi_power_meter_notify() is serialized by the new lock too which
> > generally helps to ensure that the order of handling firmware
> > notifications is the same as the order of sending netlink messages
> > related to them.
> >
> > In addition, notice that hwmon_device_register_with_info() may fail
> > in which case resource->hwmon_dev will become an error pointer,
> > so add checks to avoid attempting to unregister the hwmon device
> > pointer to by it in that case to acpi_power_meter_notify() and
> > acpi_power_meter_remove().
> >
> > Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the deprecated =
hwmon_device_register")
> > Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >   drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
> >   1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -47,6 +47,8 @@
> >   static int cap_in_hardware;
> >   static bool force_cap_on;
> >
> > +static DEFINE_MUTEX(acpi_notify_lock);
> > +
> >   static int can_cap_in_hardware(void)
> >   {
> >       return force_cap_on || cap_in_hardware;
> > @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
> >
> >       resource =3D acpi_driver_data(device);
> >
> > +     guard(mutex)(&acpi_notify_lock);
> > +
> >       switch (event) {
> >       case METER_NOTIFY_CONFIG:
> > +             if (!IS_ERR(resource->hwmon_dev))
> > +                     hwmon_device_unregister(resource->hwmon_dev);
> > +
> >               mutex_lock(&resource->lock);
> > +
> >               free_capabilities(resource);
> >               remove_domain_devices(resource);
> > -             hwmon_device_unregister(resource->hwmon_dev);
> >               res =3D read_capabilities(resource);
> >               if (res)
> >                       dev_err_once(&device->dev, "read capabilities fai=
led.\n");
> >               res =3D read_domain_devices(resource);
> >               if (res && res !=3D -ENODEV)
> >                       dev_err_once(&device->dev, "read domain devices f=
ailed.\n");
> > +
> > +             mutex_unlock(&resource->lock);
> > +
> >               resource->hwmon_dev =3D
> >                       hwmon_device_register_with_info(&device->dev,
> >                                                       ACPI_POWER_METER_=
NAME,
> > @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
> >                                                       power_extra_group=
s);
> >               if (IS_ERR(resource->hwmon_dev))
> >                       dev_err_once(&device->dev, "register hwmon device=
 failed.\n");
> > -             mutex_unlock(&resource->lock);
> > +
> >               break;
> >       case METER_NOTIFY_TRIP:
> >               sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME)=
;
> > @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
> >               return;
> >
> >       resource =3D acpi_driver_data(device);
> > -     hwmon_device_unregister(resource->hwmon_dev);
> > +     if (!IS_ERR(resource->hwmon_dev))
> > +             hwmon_device_unregister(resource->hwmon_dev);
>
> Gemini says that this is still racy:
>
> Description: Race condition between remove and notify. acpi_power_meter_r=
emove()
> unregisters the hwmon device and frees the resource structure without acq=
uiring
> acpi_notify_lock. If acpi_power_meter_notify() is running concurrently (e=
.g.
> waiting on the lock), remove() can free the resource while notify() still=
 holds
> a pointer to it. When notify() acquires the lock, it will access the free=
d
> resource (Use-After-Free).

This cannot happen because remove runs after unregistering the notify
handler by the ACPI core and that causes all events to drain.  See
acpi_device_remove() and acpi_device_remove_notify_handler().

Moreover, acpi_os_wait_events_complete() is effectively a full memory
barrier because of the two consecutive flush_workqueue() calls in it
that each acquire and release a mutex.

> Additionally, both functions may attempt to unregister the same hwmon dev=
ice
> concurrently (Double Unregister) because remove() reads resource->hwmon_d=
ev
> without protection. acpi_power_meter_remove() must acquire acpi_notify_lo=
ck
> and clear device->driver_data, and acpi_power_meter_notify() must re-vali=
date
> the resource pointer after acquiring the lock.

Well, this also cannot happen AFAICS as per the above.

> Maybe I am missing something, but I think it has a point. it is not a new
> problem, but still ...

I don't think that there is a problem.

Thanks, Rafael

