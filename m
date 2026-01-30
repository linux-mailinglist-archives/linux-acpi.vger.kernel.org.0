Return-Path: <linux-acpi+bounces-20788-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C5cEXzwfGndPQIAu9opvQ
	(envelope-from <linux-acpi+bounces-20788-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 18:55:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60D8BD872
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 18:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB32300616F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Jan 2026 17:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10D0366567;
	Fri, 30 Jan 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH4mk2+2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB1C366554
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795649; cv=none; b=uz34I3dO8f8wbp7UJqJEUNAUHGQNV87LmTR3AN/UicDvwBRMs4b1NJBHjLz98YwOTfKw5mtmaSnuBQevvxzXzQudDz4ZCkNi2/0rY9+4/+LGgGu8I9BqC9JtquyFaanbh2u7G4VYUJapYQ7je1rH8qxl5ZjYxkdPDfr9o5/Kfxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795649; c=relaxed/simple;
	bh=1auzb7T8j9SSTrLpTRdY/MvT2ARnsfl0AkdCEovdj0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0lBdhZXobFRBC3riTR4simFRyjT2wHxpDq4h5E4XCzQDlxhbtp8Fawz0WRkBElPQKYafcHoAWp/P5VPXHxbQYt/AlvAkCtUDsjxRZQ16pAeOzB6CNchx1rdrD9KCv2H3+lTKnRKWs+fRnDQOlV78WSmfbkDDmW24JehW4cHNGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH4mk2+2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50829C16AAE
	for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769795649;
	bh=1auzb7T8j9SSTrLpTRdY/MvT2ARnsfl0AkdCEovdj0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GH4mk2+2wj8B1StDZJuz62vcbLesHkMWE2sAFtZEnM20qNIY/o1w2CYDBov2rwO89
	 jErT/z+N6ZkrNjjD7j+5eFbsT9K2MbCkFuoYCBGFeLvYbWuxQ0LOGEj8whC0mmFOyI
	 6tRdUeJmXITnQ+4Ey8HUFHFCiF7j9muz7xW2r+B1gMy7zR3fmPzRPR+ufbpQerX6Lj
	 Q5laL6oPVqxQjqJeNgZqy9ZFjxAqfUR0Pj4+aRifCw6h5b+O/PRpmS1eD01gT6yMZG
	 J3Qya5uFfoQnbIXNmcdI72Gm34xmidmEIGEDP3mD3wcUyrwRNPuN5XtrwwK/vsziGU
	 qlOFM8fa7DJAQ==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662f5c5507cso1359141eaf.3
        for <linux-acpi@vger.kernel.org>; Fri, 30 Jan 2026 09:54:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXe7+jKjRDKysHXZhTyo9HqxyflwU5b41maOmgjc4xY6zoWBSpvHI7WGUuTdLDTvcF7D+jnzT5jvufY@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkgfbKpX7uqQy8b4colms7S4k/2hWK4nLMsMu64TJ3T2mGOvw
	9QxIo1qO+8G4kSnrCxAKYBpeY6hkSYVpPfbRQ9gF+21B/+9auGHEjKJKxL6uinRDC/1PxaLi3x1
	QuJPgDVE4K0ay3k4amqu5MyWfAneFU0U=
X-Received: by 2002:a05:6820:2217:b0:662:f74d:69f5 with SMTP id
 006d021491bc7-6630f05100emr1899292eaf.31.1769795648343; Fri, 30 Jan 2026
 09:54:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki> <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki> <b81b86c8-7780-4b11-8830-09ab9c7dd679@huawei.com>
 <a980cd48-6dd1-4e90-a872-821ffe799281@roeck-us.net> <b1e5f8dc-4093-4f03-946c-e455612a0c73@huawei.com>
In-Reply-To: <b1e5f8dc-4093-4f03-946c-e455612a0c73@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Jan 2026 18:53:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvSdm+FpaO8=RhfvE8SOQTTGwhmBhw9WJ6QLXkmahuww@mail.gmail.com>
X-Gm-Features: AZwV_Qhss8y6nv5jWa9QYJTwLJzVieeIPpIVhZ3vvMy-lAhL-kYC5_O2rWUIzwY
Message-ID: <CAJZ5v0gvSdm+FpaO8=RhfvE8SOQTTGwhmBhw9WJ6QLXkmahuww@mail.gmail.com>
Subject: Re: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related to acpi_power_meter_notify()
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: Guenter Roeck <linux@roeck-us.net>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20788-lists,linux-acpi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,huawei.com:email,roeck-us.net:email,gooddata.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: D60D8BD872
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 9:40=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 1/30/2026 1:07 PM, Guenter Roeck wrote:
> > On 1/29/26 17:47, lihuisong (C) wrote:
> >>
> >> On 1/29/2026 10:18 PM, Rafael J. Wysocki wrote:
> >>> On Wednesday, January 28, 2026 10:52:15 PM CET Guenter Roeck wrote:
> >>>> On Wed, Jan 28, 2026 at 08:52:49PM +0100, Rafael J. Wysocki wrote:
> >>>>> On Wednesday, January 28, 2026 7:45:32 PM CET Rafael J. Wysocki
> >>>>> wrote:
> >>>>>> On Wed, Jan 28, 2026 at 7:18=E2=80=AFPM Guenter Roeck
> >>>>>> <linux@roeck-us.net> wrote:
> >>>>>>> Hi all,
> >>>>>>>
> >>>>>>> On Thu, Jan 22, 2026 at 07:55:35PM +0100, Rafael J. Wysocki wrote=
:
> >>>>>>>> On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> >>>>>>>> <jaroslav.pulchart@gooddata.com> wrote:
> >>>>>>>>> Hello,
> >>>>>>>>>
> >>>>>>>>> after upgrading from kernel 6.17.y to 6.18.y we started to
> >>>>>>>>> observe a regression
> >>>>>>>>> in the ACPI power meter hwmon interface. Reading
> >>>>>>>>> power*_average sysfs
> >>>>>>>>> attributes blocks indefinitely and causes tasks to enter
> >>>>>>>>> uninterruptible
> >>>>>>>>> sleep (D state).
> >>>>>>>> The most recent change in the acpi_power_meter driver was made i=
n
> >>>>>>>> 6.15, so this is not a regression in that driver.
> >>>>>>>>
> >>>>>>>> Also, nothing suspicious is done in power1_average_min_show() an=
d
> >>>>>>>> power1_average_min_store() AFAICS.
> >>>>>>>>
> >>>>>>> I decided to ask AI (Gemini 3, more specifically) for an
> >>>>>>> analysis of the
> >>>>>>> problem, using Chris Mason's prompts for guidance. Result is belo=
w.
> >>>>>> So it agrees with me in the analysis part.
> >>>>>>
> >>>> Yes.
> >>>>
> >>>>>>> The suggested fix may be a feasible workaround. Let me know what
> >>>>>>> you think.
> >>>>>> Well, I'm afraid it won't work if two METER_NOTIFY_CONFIG
> >>>>>> notifications compete with each other because they may try to
> >>>>>> unregister the hwmon device at the same time.
> >>>>>>
> >>>> Good point.
> >>>>
> >>>>>> I would just add a separate lock for the notifier (a static one
> >>>>>> should
> >>>>>> suffice) and make changes to "resource" only under resource->lock.
> >>>>>>
> >>>>>> Let me cut a prototype patch for this.
> >>>>>>
> >>>>> Something like the below (untested).
> >>>>>
> >>>>> Note that it also fixes the driver removal which is tangentially
> >>>>> related to the
> >>>>> problem at hand.
> >>>> I can't test it either, but I ran it through Gemini and it tells me:
> >>>>
> >>>>    Fixes: tag missing (y) [Fixes: 16746ce8adfe ("hwmon:
> >>>> (acpi_power_meter) Replace the deprecated hwmon_device_register")]
> >>>>
> >>>>    The commit addresses a deadlock regression introduced by the
> >>>> conversion to
> >>>>    hwmon_device_register_with_info.
> >>>>
> >>>>    CHANGE-1: New static mutex `acpi_notify_lock` introduces global
> >>>> serialization.
> >>>>    This prevents concurrent notification handling for multiple
> >>>> power meter devices.
> >>>>    While likely a minor impact given the nature of the device, it
> >>>> technically reduces parallelism compared to the per-device locking
> >>>> used previously.
> >>>>
> >>>> Just for fun I tried again, this time using a model which is more
> >>>> prone to
> >>>> false positives. It pretty much provided the same result in more
> >>>> detail.
> >>>> It is a bit more verbose, so I attached it below. I also asked it
> >>>> to verify,
> >>>> using the backtrace, if the patch is complete, and to suggest a patc=
h
> >>>> description. The result is also attached below.
> >>>>
> >>>> I think this is good enough for a formal patch. WDYT ?
> >>> With all due respect to the AI, I think that it has missed a couple
> >>> of things,
> >>> so below it the patch with my version of the changelog.
> >>>
> >>> Also, it really wants to be two patches IMV, one adding the
> >>> IS_ERR(resource->hwmon_dev) checks before hwmon device
> >>> unregistration and
> >>> another one fixing the deadlock in question on top of it. Please let
> >>> me know
> >>> if you want me to split this one.
> >>>
> >>> Jaroslav, it would be nice to get some feedback on it from you as
> >>> you seem to
> >>> be the only person here who can test it.
> >>>
> >>> ---
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> Subject: [PATCH v1] hwmon: (acpi_power_meter) Fix deadlocks related
> >>> to acpi_power_meter_notify()
> >>>
> >>> The acpi_power_meter driver's .notify() callback function,
> >>> acpi_power_meter_notify(), calls hwmon_device_unregister() under a lo=
ck
> >>> that is also acquired by callbacks in sysfs attributes of the device
> >>> being unregistered which is prone to deadlocks between sysfs access a=
nd
> >>> device removal.
> >>>
> >>> Address this by moving the hwmon device removal in
> >>> acpi_power_meter_notify() outside the lock in question, but notice
> >>> that doing it alone is not sufficient because two concurrent
> >>> METER_NOTIFY_CONFIG notifications may be attempting to remove the
> >>> same device at the same time.  To prevent that from happening, add a
> >>> new lock serializing the execution of the switch () statement in
> >>> acpi_power_meter_notify().  For simplicity, it is a static mutex
> >>> which should not be a problem from the performance perspective.
> >>>
> >>> The new lock also allows the hwmon_device_register_with_info()
> >>> in acpi_power_meter_notify() to be called outside the inner lock
> >>> because it prevents the other notifications handled by that function
> >>> from manipulating the "resource" object while the hwmon device based
> >>> on it is being registered.  The sending of ACPI netlink messages from
> >>> acpi_power_meter_notify() is serialized by the new lock too which
> >>> generally helps to ensure that the order of handling firmware
> >>> notifications is the same as the order of sending netlink messages
> >>> related to them.
> >>>
> >>> In addition, notice that hwmon_device_register_with_info() may fail
> >>> in which case resource->hwmon_dev will become an error pointer,
> >>> so add checks to avoid attempting to unregister the hwmon device
> >>> pointer to by it in that case to acpi_power_meter_notify() and
> >>> acpi_power_meter_remove().
> >>>
> >>> Fixes: 16746ce8adfe ("hwmon: (acpi_power_meter) Replace the
> >>> deprecated hwmon_device_register")
> >>> Reported-by: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
> >>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>> ---
> >>>   drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
> >>>   1 file changed, 14 insertions(+), 3 deletions(-)
> >>>
> >>> --- a/drivers/hwmon/acpi_power_meter.c
> >>> +++ b/drivers/hwmon/acpi_power_meter.c
> >>> @@ -47,6 +47,8 @@
> >>>   static int cap_in_hardware;
> >>>   static bool force_cap_on;
> >>> +static DEFINE_MUTEX(acpi_notify_lock);
> >>> +
> >>>   static int can_cap_in_hardware(void)
> >>>   {
> >>>       return force_cap_on || cap_in_hardware;
> >>> @@ -823,18 +825,26 @@ static void acpi_power_meter_notify(stru
> >>>       resource =3D acpi_driver_data(device);
> >>> +    guard(mutex)(&acpi_notify_lock);
> >>> +
> >>>       switch (event) {
> >>>       case METER_NOTIFY_CONFIG:
> >>> +        if (!IS_ERR(resource->hwmon_dev))
> >>> +            hwmon_device_unregister(resource->hwmon_dev);
> >>> +
> >>>           mutex_lock(&resource->lock);
> >>> +
> >>>           free_capabilities(resource);
> >>>           remove_domain_devices(resource);
> >>> -        hwmon_device_unregister(resource->hwmon_dev);
> >>>           res =3D read_capabilities(resource);
> >>>           if (res)
> >>>               dev_err_once(&device->dev, "read capabilities
> >>> failed.\n");
> >>>           res =3D read_domain_devices(resource);
> >>>           if (res && res !=3D -ENODEV)
> >>>               dev_err_once(&device->dev, "read domain devices
> >>> failed.\n");
> >>> +
> >>> +        mutex_unlock(&resource->lock);
> >>> +
> >>>           resource->hwmon_dev =3D
> >>> hwmon_device_register_with_info(&device->dev,
> >>>                               ACPI_POWER_METER_NAME,
> >>> @@ -843,7 +853,7 @@ static void acpi_power_meter_notify(stru
> >>>                               power_extra_groups);
> >>>           if (IS_ERR(resource->hwmon_dev))
> >>>               dev_err_once(&device->dev, "register hwmon device
> >>> failed.\n");
> >>> -        mutex_unlock(&resource->lock);
> >>> +
> >>>           break;
> >>>       case METER_NOTIFY_TRIP:
> >>>           sysfs_notify(&device->dev.kobj, NULL, POWER_AVERAGE_NAME);
> >>> @@ -953,7 +963,8 @@ static void acpi_power_meter_remove(stru
> >>>           return;
> >>>       resource =3D acpi_driver_data(device);
> >>> -    hwmon_device_unregister(resource->hwmon_dev);
> >>> +    if (!IS_ERR(resource->hwmon_dev))
> >>> +        hwmon_device_unregister(resource->hwmon_dev);
> >> !IS_ERR(resource->hwmon_dev) may be not enough. There might be UAF in
> >> concurrent case.
> >> How about do it like:
> >> if (!IS_ERR_OR_NULL(resource->hwmon_dev)) {
> >
> > Not sure what you mean with 'concurrent' case. There is a potential
> > race with the
> Apologize for your confusion. What I mean is as mentioned in your other
> mail.
> > notification code, as mentioned in my other mail. Question is if the
> > acpi subsystem
> > disables notification calls before the remove function is called, and
> > guarantees
> > that no notifications are pending. If so, I don't think there is a
> > problem.
> > Also, resource->hwmon_dev should never be NULL.
> >
> All right,
> the resource is already released and this notify should not be entered
> again if remove() is called first.
>
> But the .remove() of acpi_power_meter driver must clear the
> 'driver_data' in acpi_device.
> In this way, even if ACPI subsystem doesn't disable notification,

But the ACPI subsystem does disable the notification, so what's the problem=
?

> the notify also doesn't perform any action after calling .remove().

