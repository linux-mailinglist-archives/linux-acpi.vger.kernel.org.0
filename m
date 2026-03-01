Return-Path: <linux-acpi+bounces-21285-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XK9rCVg6pGlJawUAu9opvQ
	(envelope-from <linux-acpi+bounces-21285-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:08:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8F1CFC1E
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FE14300D45A
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 13:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889393242B3;
	Sun,  1 Mar 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fE2CeKLf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653A72517AC
	for <linux-acpi@vger.kernel.org>; Sun,  1 Mar 2026 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772370517; cv=none; b=DLPWwNyrte3R1Ni/cGp9QT1uP6TjhdxaWHChWcNjaoQVodZuZn0fRnk+WB2a629wAAtUTNVwGlVtWUveGUG7eTxknK9ohuvxAFniaNGMJRY3Tp+Po4oRgX/HRLAD9oDvYJ+A+lAsj3WvRTZU0Qi9IqPmdgG39xBD82SPlA7TGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772370517; c=relaxed/simple;
	bh=BpmbXH4qYlEnLSdaHrN56B/2bF+uEc8ONGwaCG5rAwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJmSB6ESFzm9ExVlQY1S7UaID388ABDXDFPuyAcVe0ty4a79GoY6Xzgxovi7cQl7gjy4lWw3vl8xRFW5Q6xCWC2MRj46R/XdigjLPiRWcZwx4qVvljp1uiwXg7yYCBEfp6zCV0+h2xE+cV4itk/xI8yM58re9eWn2fY+VWFqGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fE2CeKLf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5D2C2BCB5
	for <linux-acpi@vger.kernel.org>; Sun,  1 Mar 2026 13:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772370517;
	bh=BpmbXH4qYlEnLSdaHrN56B/2bF+uEc8ONGwaCG5rAwE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fE2CeKLfYK4zxDAZKHxzQ00vZWIX4YNk1++Fq6Sv2Y+Q+iOGoscIO4CdwjJqGFcIZ
	 kYYM+dkBaK3XOLMAG42kmbqjf/YwfUQ2VhZ+ZCV913yJ4p0a1se+5ixpQQZrzl6uc/
	 MXTRja7Sre+H3ClQbiDLbj3yhjn47jmj2ebTR+9k6QUMp9ev/j4SuXtKfkDvbPkhf7
	 6xpF5R7SbEKaytGAAIliAZDVxz7FzBJtew0JxkQQPZuRVbXiqiMuVoG+dsO57f44Tj
	 XVHPPa96vuyMTeX+6qipHVCsNS66F2kMgeFrRT9ThpNbvjVrwkt2I0jNEMo+DVu3vK
	 lQzRFSP3iilTw==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-46394090d2fso1287160b6e.3
        for <linux-acpi@vger.kernel.org>; Sun, 01 Mar 2026 05:08:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRt4ammJCb04iOglq9P85ituFoQGluMZ1WGCBlopD9a5f66eBqzThPl57l+N4YdY7u592UmniKwfZF@vger.kernel.org
X-Gm-Message-State: AOJu0YwbKfpNeg8wgrP430t2GwRdq3fvHeFQNU7yTMkL+BJ1aRg8PwUA
	f5Nb0M8PQImAR9onKJTCXEaCqUFlWzmVNcneteQxXyJeOkCfFHDFi7yIIV+gV4sjiX339z3yR7K
	oSPnpX+KR1ECaqbvwp9K5ovAeO1fOvsA=
X-Received: by 2002:a05:6808:4f23:b0:45e:a592:5903 with SMTP id
 5614622812f47-464beea8a3amr4677465b6e.32.1772370516163; Sun, 01 Mar 2026
 05:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5971620.DvuYhMxLoT@rafael.j.wysocki> <2402539.ElGaqSPkdT@rafael.j.wysocki>
 <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
In-Reply-To: <c9697592-c70b-4ef8-864f-213b5ea4782d@linux.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 1 Mar 2026 14:08:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j7PdCG3oi8tKHkdQ7SvfL0r6DL7J-iKrr2aoDRufnBbQ@mail.gmail.com>
X-Gm-Features: AaiRm53APnLbCnYkEj8OOyuCyqwJIj-wOFzzdkFbpRIt_92bXALORXGiiWUdTYY
Message-ID: <CAJZ5v0j7PdCG3oi8tKHkdQ7SvfL0r6DL7J-iKrr2aoDRufnBbQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver to
 a platform one
To: Denis Benato <denis.benato@linux.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	=?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,vger.kernel.org,gmail.com,ljones.dev];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-21285-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 8CA8F1CFC1E
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 6:02=E2=80=AFPM Denis Benato <denis.benato@linux.de=
v> wrote:
>
>
> On 2/28/26 16:11, Rafael J. Wysocki wrote:
> > From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> >
> > In all cases in which a struct acpi_driver is used for binding a driver
> > to an ACPI device object, a corresponding platform device is created by
> > the ACPI core and that device is regarded as a proper representation of
> > underlying hardware.  Accordingly, a struct platform_driver should be
> > used by driver code to bind to that device.  There are multiple reasons
> > why drivers should not bind directly to ACPI device objects [1].
> >
> > Overall, it is better to bind drivers to platform devices than to their
> > ACPI companions, so convert the Asus laptop ACPI driver to a platform
> > one.
> >
> > While this is not expected to alter functionality, it changes sysfs
> > layout and so it will be visible to user space.
>
> Alright I will take a look if asus-linux software is affected and act acc=
ordingly.
> How much time do I have?

It really depends on Ilpo, but there's no rush as far as I'm concerned.

> Thanks.
> > Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ =
[1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>

Thanks for all of the reviews!

> > ---
> >  drivers/platform/x86/asus-laptop.c | 35 +++++++++++++++---------------
> >  1 file changed, 18 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/=
asus-laptop.c
> > index c927665dfa96..dbbb6292cd11 100644
> > --- a/drivers/platform/x86/asus-laptop.c
> > +++ b/drivers/platform/x86/asus-laptop.c
> > @@ -1824,8 +1824,9 @@ static void asus_dmi_check(void)
> >
> >  static bool asus_device_present;
> >
> > -static int asus_acpi_add(struct acpi_device *device)
> > +static int asus_acpi_probe(struct platform_device *pdev)
> >  {
> > +     struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
> >       struct asus_laptop *asus;
> >       int result;
> >
> > @@ -1837,7 +1838,6 @@ static int asus_acpi_add(struct acpi_device *devi=
ce)
> >       asus->handle =3D device->handle;
> >       strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
> >       strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
> > -     device->driver_data =3D asus;
> >       asus->device =3D device;
> >
> >       asus_dmi_check();
> > @@ -1846,6 +1846,8 @@ static int asus_acpi_add(struct acpi_device *devi=
ce)
> >       if (result)
> >               goto fail_platform;
> >
> > +     platform_set_drvdata(pdev, asus);
> > +
> >       /*
> >        * Need platform type detection first, then the platform
> >        * device.  It is used as a parent for the sub-devices below.
> > @@ -1907,11 +1909,12 @@ static int asus_acpi_add(struct acpi_device *de=
vice)
> >       return result;
> >  }
> >
> > -static void asus_acpi_remove(struct acpi_device *device)
> > +static void asus_acpi_remove(struct platform_device *pdev)
> >  {
> > -     struct asus_laptop *asus =3D acpi_driver_data(device);
> > +     struct asus_laptop *asus =3D platform_get_drvdata(pdev);
> >
> > -     acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_a=
cpi_notify);
> > +     acpi_dev_remove_notify_handler(asus->device, ACPI_DEVICE_NOTIFY,
> > +                                    asus_acpi_notify);
> >       asus_backlight_exit(asus);
> >       asus_rfkill_exit(asus);
> >       asus_led_exit(asus);
> > @@ -1930,15 +1933,13 @@ static const struct acpi_device_id asus_device_=
ids[] =3D {
> >  };
> >  MODULE_DEVICE_TABLE(acpi, asus_device_ids);
> >
> > -static struct acpi_driver asus_acpi_driver =3D {
> > -     .name =3D ASUS_LAPTOP_NAME,
> > -     .class =3D ASUS_LAPTOP_CLASS,
> > -     .ids =3D asus_device_ids,
> > -     .flags =3D ACPI_DRIVER_ALL_NOTIFY_EVENTS,
> > -     .ops =3D {
> > -             .add =3D asus_acpi_add,
> > -             .remove =3D asus_acpi_remove,
> > -             },
> > +static struct platform_driver asus_acpi_driver =3D {
> > +     .probe =3D asus_acpi_probe,
> > +     .remove =3D asus_acpi_remove,
> > +     .driver =3D {
> > +             .name =3D ASUS_LAPTOP_NAME,
> > +             .acpi_match_table =3D asus_device_ids,
> > +     },
> >  };
> >
> >  static int __init asus_laptop_init(void)
> > @@ -1949,7 +1950,7 @@ static int __init asus_laptop_init(void)
> >       if (result < 0)
> >               return result;
> >
> > -     result =3D acpi_bus_register_driver(&asus_acpi_driver);
> > +     result =3D platform_driver_register(&asus_acpi_driver);
> >       if (result < 0)
> >               goto fail_acpi_driver;
> >       if (!asus_device_present) {
> > @@ -1959,7 +1960,7 @@ static int __init asus_laptop_init(void)
> >       return 0;
> >
> >  fail_no_device:
> > -     acpi_bus_unregister_driver(&asus_acpi_driver);
> > +     platform_driver_unregister(&asus_acpi_driver);
> >  fail_acpi_driver:
> >       platform_driver_unregister(&platform_driver);
> >       return result;
> > @@ -1967,7 +1968,7 @@ static int __init asus_laptop_init(void)
> >
> >  static void __exit asus_laptop_exit(void)
> >  {
> > -     acpi_bus_unregister_driver(&asus_acpi_driver);
> > +     platform_driver_unregister(&asus_acpi_driver);
> >       platform_driver_unregister(&platform_driver);
> >  }
> >

