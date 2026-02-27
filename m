Return-Path: <linux-acpi+bounces-21200-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNlRDux/oWkUtgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21200-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 12:28:44 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AC31B68F4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 12:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4977230A12B4
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 11:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D593EF0B8;
	Fri, 27 Feb 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syvocs8N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332E136D4E4
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 11:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191598; cv=none; b=Ii91FLuyg8MeI5/bIpcCrHKU2j2a2GVHHGe07xpyX9g/Q/G5YA4azPRLYDr+O7vSU+oL7NykjbcbDSZARzdAnUG1xL8yKFLRGnJ/DrLXFFf90Iq1tUVy/X+LWY0TrQbV57PI2p4xj8zabeY+mO+W4qcLAgQTQ3Krg6GSrvfJsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191598; c=relaxed/simple;
	bh=ywHLikrYtcjfdT8PqqBy+3UBjFbksGYYaXgOwkUnGh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uoZ65GeXTMsDsx2dUbrdDfSsbiIlVkR7V1pwQLsBCpu/yvTxfSQSDSbR9lzKMUyWlTXUgafbb7QIVqDyIrwqgsJptx7/y6RjS1M/m/UZziY95eGIECMGlt/jp3utKyRqOAk1IApV2i32XKcH1ZmLPcxl9LwKIYsrrqo//8vS+f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syvocs8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5531C116C6
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 11:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772191597;
	bh=ywHLikrYtcjfdT8PqqBy+3UBjFbksGYYaXgOwkUnGh4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Syvocs8N2eIHV+sPwv6kae/2ejjnypN/U4dgxOnQXYctny+RAmLDrUUYeDfMqJo0m
	 rFtJ6ZkBMbU5VaUSI7zUDYCLP+0j0KSjhveSmQmfrxi7UymKVO1Tl+LkxV2RWCxLU6
	 2QUT4l48vCAh+HovVYV5YM7gsHIvoY4paEm3MCMivTOQAs4UzPU6XDhbKPc5Py1Y5j
	 I5vArGq6yHvU2r9zdybxvn3pbPynDxkzUPsY+YjpCZe+xD3TB7qx8xwIjPB9vtdNQe
	 aGJhmC9j925FoUt5FuuIgXhALocOTBuCrKqDGjWh18wfBEtoIhnMH0VvJKpmie5kU0
	 zi3zfSL5Bn2yw==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4c307db9aso1114504a34.3
        for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 03:26:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbHhXqZBazHduLWZ5yUGMAjImjLxsWWZ03MEhlnBa1b5kmC94lves6NkU9LT6afwX/hcW7094zp5YK@vger.kernel.org
X-Gm-Message-State: AOJu0YxwTOb10lMrdVlfgQi/rBdFJbKcLryFbWb/s6OID0YiyQHQauGi
	iWfCerFzntT6ccl+FIQQtffOB2a0HNz2mx3lx95i9RH+d64BHv71S3ZXbXN3OsuQvd/RiKyZhrj
	4EN9oLR7kO28ny59FTjULdvVFdK9kNRA=
X-Received: by 2002:a05:6830:3906:b0:7cf:e312:1ab4 with SMTP id
 46e09a7af769-7d591bbee09mr1303680a34.19.1772191596988; Fri, 27 Feb 2026
 03:26:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4727679.LvFx2qVVIh@rafael.j.wysocki> <10819001.nUPlyArG6x@rafael.j.wysocki>
 <202602271037341ec1378a@mail.local>
In-Reply-To: <202602271037341ec1378a@mail.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Feb 2026 12:26:25 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hfSm3zD_d20ep6FOk5hdj=fYQTGAy3YANwPgoNSQUdzw@mail.gmail.com>
X-Gm-Features: AaiRm50D7e3A5min_uNn85VEeX3L6o3XOGWLFqy5YpbRR6THk0p_iJM-ke1Pclg
Message-ID: <CAJZ5v0hfSm3zD_d20ep6FOk5hdj=fYQTGAy3YANwPgoNSQUdzw@mail.gmail.com>
Subject: Re: [PATCH v0 5/6] ACPI: TAD: Add RTC class device interface
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21200-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,bootlin.com:email,rt.tz:url]
X-Rspamd-Queue-Id: A0AC31B68F4
X-Rspamd-Action: no action

Hi,

On Fri, Feb 27, 2026 at 11:37=E2=80=AFAM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Hello,
>
> On 22/02/2026 15:18:29+0100, Rafael J. Wysocki wrote:
> > +static int acpi_tad_rtc_procfs(struct device *dev, struct seq_file *se=
q)
> > +{
> > +     struct acpi_tad_rt rt;
> > +     int ret;
> > +
> > +     ret =3D acpi_tad_get_real_time(dev, &rt);
> > +     if (ret)
> > +             return ret;
> > +
> > +     seq_printf(seq,
> > +                "Time\t\t: %u:%u:%u\n"
> > +                "Date\t\t: %u-%u-%u\n"
> > +                "Daylight\t: %s\n",
> > +                rt.hour, rt.minute, rt.second,
> > +                rt.year, rt.month, rt.day,
> > +                str_yes_no(rt.daylight =3D=3D ACPI_TAD_TIME_ISDST));
> > +
> > +     if (rt.tz =3D=3D ACPI_TAD_TZ_UNSPEC)
> > +             seq_puts(seq, "Timezone\t: unspecified\n");
> > +     else
> > +             seq_printf(seq, "Timezone\t: %d\n", rt.tz);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct rtc_class_ops acpi_tad_rtc_ops =3D {
> > +     .read_time =3D acpi_tad_rtc_read_time,
> > +     .set_time =3D acpi_tad_rtc_set_time,
> > +     .proc =3D acpi_tad_rtc_procfs,
>
> I would avoid implementing .proc, it has been deprecated for a while and
> doesn't bring much.

OK

> > +};
> > +
> > +/* Platform driver interface */
> > +
> >  static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
> >  {
> >       return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DIS=
ABLED);
> > @@ -655,10 +730,16 @@ static int acpi_tad_probe(struct platfor
> >       pm_runtime_suspend(dev);
> >
> >       ret =3D sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
> > -     if (ret)
> > +     if (ret) {
> >               acpi_tad_remove(pdev);
> > +             return ret;
> > +     }
> >
> > -     return ret;
> > +     if (caps & ACPI_TAD_RT)
> > +             devm_rtc_device_register(dev, "acpi-tad-rtc", &acpi_tad_r=
tc_ops,
> > +                                      THIS_MODULE);
> > +
>
> Please use devm_rtc_allocate_device() and devm_rtc_register_device() so
> you can set range_min and range_max. I get you don't need the rtc_device
> later so we could have a helper that takes the range and registers the
> rtc.

I'll need to use them anyway later when I add read/set_alarm to this
device (because the alarm may not be supported in which case I'll need
to set a flag to indicate that before registering the RTC device,
IIUC).

