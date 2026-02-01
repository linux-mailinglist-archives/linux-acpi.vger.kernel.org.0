Return-Path: <linux-acpi+bounces-20798-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I4rCxA8f2lcmAIAu9opvQ
	(envelope-from <linux-acpi+bounces-20798-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 12:42:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C4EC5CE7
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Feb 2026 12:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2821304B03B
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Feb 2026 11:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C64E32D0EF;
	Sun,  1 Feb 2026 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BR8EL3uF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288CC32B997
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769946046; cv=none; b=ZLOm+2d7xwkRje9oAC7a9Wcm0ytAcuNCTxUD/ra+EyOAMrsy7Ko2BeLthvDPzGPwRtlZXGo3Dwdc722x7YC3SA38Wbe+E31D8FHuNFTQ2KNvtS+P08guxjySkQy3X6Ylp9Plv7+980OcLyP0AWJVFvVkDzVMkefCmVpJp9ao8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769946046; c=relaxed/simple;
	bh=X7d+pL2lizoInntJAYHY+lwKrg+eG690PPgws7MJqCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=THpC+jrNlM4Yu8KO7f5lQUGYHfqjeU31SFvBUyWYVK6c3lHGM/fPwyoWOxajV8MuJtCfdArx7ZNCSZLdZLzdXs6Lo38CwfE+jNurHD8mPEPKrdlOgjXI48uSOSgRtv1asdbHuZgyanqWCKc14ytqwTJQH+1DdQ5ikfArXMKmbck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BR8EL3uF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2994C2BCB1
	for <linux-acpi@vger.kernel.org>; Sun,  1 Feb 2026 11:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769946045;
	bh=X7d+pL2lizoInntJAYHY+lwKrg+eG690PPgws7MJqCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BR8EL3uFRP2VA6S0bHrjlBqtUEgUycaD7b1Or17dTh18G5HxklFkseqvZ57oEVx/C
	 4URGF4QL7BF6ch2XO2222H9TURkYhNPYtydy9u+VF8IxWYyYTBiiulUsss10JlVoYf
	 o/pIO3fOgApwewHYiasnQaN30E5zQxB4jXnx4ZjK7YXMWiSUkU/ng7io5QA2ai9sc2
	 oM7Y4rtUggR4h6Idg41bPjW6Rf/l1DQhyTFRNs4eBgJGkbO7WuD+hr9h1TB18naHCw
	 P06dCB1gH5Gt3oaB48nuLwdgglAElVqI3yarVZ+I3pD20+anwn7Gg987WKm+CdxTUx
	 xAdayFrGQ63bA==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfd9b898cdso2308297a34.2
        for <linux-acpi@vger.kernel.org>; Sun, 01 Feb 2026 03:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5Nnk53o1/YaF0BDCRSqJ6QYBsb2RJ2S4bz6ulVmSWF8V5iQghoBdwJaV4ZFFTqXAL9V9/oxzE7sJ6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5kn/FzEQvo2w9Yu2D/eIu/adSKgEPimIlvcbwp6MVR3ZlWK4
	xh9Gd3gKgsmIE4JBfKmCn9l1cR/dNU97w6JjTWYkH7Ezc760Ph1AxayPWvvCPNZLUiOgZHO5lLo
	hF13968nJMfBUewDtar4pfWOEq5NRwko=
X-Received: by 2002:a05:6820:1793:b0:657:717a:8c8 with SMTP id
 006d021491bc7-6630f008f69mr3812159eaf.3.1769946044825; Sun, 01 Feb 2026
 03:40:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <12855313.O9o76ZdvQC@rafael.j.wysocki> <d45d7b8a-97dd-4db8-a785-56df128983a4@roeck-us.net>
 <6252535.lOV4Wx5bFT@rafael.j.wysocki> <30300396-25b0-4d56-b8dd-c65d221c80bb@roeck-us.net>
In-Reply-To: <30300396-25b0-4d56-b8dd-c65d221c80bb@roeck-us.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Feb 2026 12:40:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gLs3YU8vj6uojYo=3c8kKLWeo5Ej2PUO+=BcWPjg0g=Q@mail.gmail.com>
X-Gm-Features: AZwV_Qg1pnvi-gkv78OEWCB9ccxp_AKmbAg3JYhMNeTbWJWjrAQN47JVpLzNzTQ
Message-ID: <CAJZ5v0gLs3YU8vj6uojYo=3c8kKLWeo5Ej2PUO+=BcWPjg0g=Q@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20798-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,roeck-us.net:email,gooddata.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C7C4EC5CE7
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 4:29=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> Hi all,
>
> On Thu, Jan 29, 2026 at 03:18:11PM +0100, Rafael J. Wysocki wrote:
>
> I decided to apply the patch below as-is. While we don't have confirmatio=
n
> that it fixes the immediate problem, it is a starting point and won't mak=
e
> the situation worse. A complete fix which does not require re-registering
> the hardware monitoring device will require more work and will not be
> suitable for LTS backports.

Sounds good to me, thank you!

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
> >  drivers/hwmon/acpi_power_meter.c |   17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > --- a/drivers/hwmon/acpi_power_meter.c
> > +++ b/drivers/hwmon/acpi_power_meter.c
> > @@ -47,6 +47,8 @@
> >  static int cap_in_hardware;
> >  static bool force_cap_on;
> >
> > +static DEFINE_MUTEX(acpi_notify_lock);
> > +
> >  static int can_cap_in_hardware(void)
> >  {
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
> >
> >       remove_domain_devices(resource);
> >       free_capabilities(resource);

