Return-Path: <linux-acpi+bounces-20656-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CLsMYmoeGl9rwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20656-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:59:05 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDC593EDD
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 12:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A197302414C
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A734D34B195;
	Tue, 27 Jan 2026 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="XhmXJ3ke"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C2346766
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515141; cv=pass; b=j7oE/m9ZTkiGsbj5EQeXE9J7SxUpuKY+CRoISv0ZlBQAXTsNkLbfQsjfc+QkD2bNc9KBOC8ZoHi7yVgX+rQTFsTGWyAEESbvLKcnOqz/gilbMVSrSKjFTFAjNfedWgGk0BzOaOb5H1KzRMHNih0sz18pPO6C8UrZNvfeQL1OVP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515141; c=relaxed/simple;
	bh=pJ5yKhLQjq6Hec7gqI4eoL2dW5bjgRDHBF0GBjBJBPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nBjYjj+0MX5SH1i6/pdq2Mrx0Rh/Ch1IJHhnrLBZCqlV04Q02IYb7VQT4tqiQJ1xNc6L6mYv2troAR7IoHPAJq8jf2XJHFMWdQhbVUEycgKonTFLR4aahfRXr1b0iE0cVaeXPHJmD66CjlVgtkr/y/orcvWUuKzYzTCx9WbkkIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=XhmXJ3ke; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1249b9f5703so1745965c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 03:58:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769515139; cv=none;
        d=google.com; s=arc-20240605;
        b=NNMe6AM+0w2+mXIU6EhDloa3V7EbC45S06Ht7uXnxxsx9nvR+9gkEBx3fPITJM3j93
         SS6s5T3+z0RQvPABBwTzv9/4ve8lDdV8p66wITSFDiPIUxovWCbh7J4Dn+Z8I1QpkoQQ
         nOIS7qJzu7p8MskiZ0q2YiisnszFGRyHgeoJ7HsMN4gXJw0kEF/BGv2CP9amMAeZqojH
         +7IB7TA1J/rfT7Oj4XtHs7cNeviMUcg/MOLVpyoHFvcve0pDc9bXD3ocMPHHMASlZ3mN
         tGqrqwtY+0OfIwiBIeMo8rUxj+1rFnAaOiJUauFWXUn134U9ywXrU6Z4XBa/R29578Zl
         rAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pJ5yKhLQjq6Hec7gqI4eoL2dW5bjgRDHBF0GBjBJBPE=;
        fh=m4IcP4Jh+CT7aOdIpPSjHj2qB5zmjl+E0vVz9nwDF2c=;
        b=kXN7SxBVN+Eb9cP265iuk+FDXD0u9GUQve2SGEs/CNf2TRShCOUJANQGdDT7lrX4hT
         7ztWZgY9GlJ8ISMtMxRJ8imQGAnLDQ/3njkSRCeDWoLqXcPqwFGLS9QVLKrzErxvXyvw
         OpQuFcTX7k7l1zy+yaSlA9R60ElamjQjmIFFl3DqHxAb5hYkMd7O4Bzk/ftRIewf3+fa
         VyX1LEVByetSUhdcrkPz+gbi//zJsf2NqtpI852hwdnkvu3ptYr7ctyrGU4YbejSAkeY
         etAfmbkViit7DRZq0usci+Z8uCq5iKQwhhmUzYQV4upGyQDyhY+VvXqMJd3ZW9+yCa62
         u64A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1769515139; x=1770119939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJ5yKhLQjq6Hec7gqI4eoL2dW5bjgRDHBF0GBjBJBPE=;
        b=XhmXJ3kenREsetRojvxDKRdyhBih/sDW5S4f3MqikAEWnUuwgmVLF/NF4IpquUaBeZ
         sbfItyZKWb6JmQ9L0XHx3C3Vpoci9rgtdkz802OkVSyMQmkYpB0BSi7Z1nrspJ/gofFe
         Do/J2HHWdanar16CsjuB5JsKNt62eklqzolDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515139; x=1770119939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pJ5yKhLQjq6Hec7gqI4eoL2dW5bjgRDHBF0GBjBJBPE=;
        b=CYhmCVghdSI0I4HHe2vvkR0q72Xfoo1+YloqwY+9ibfq93lhFwaXMy08PZyACiWpfQ
         GxVco3pLPshM8Bd6e1lwIsiXznqMvhBOne8jMPbdNFC23iD8j02EYiCsD+uwAsjVoGzW
         nHkviKh5zprkh12bzZhrOHAcQj/VWmbs8VSqvJHUeV3TiBvOspJ2tX+5+IEKGX+WvFH3
         wbU6ARG7950r8VlWBrO4EMQmVvbZxJxxlpZBBASH63j7F07E8mKKjRC5A9Hpr0L/C+Rn
         N3w4jklDHnS9zYA3Waub9ThOBTOvbFvOt0nKjwi2y0mW4ohTM8cI08U8NJ33pya6AaiC
         99eg==
X-Forwarded-Encrypted: i=1; AJvYcCVQUxmtq21ZDcuFvt2tk/pEfsrQwDarlFjFO7U9Jt+cehoQIaowmpY12hMgV6ViYTaeTa8V50NUtBWM@vger.kernel.org
X-Gm-Message-State: AOJu0YyJopAiCkaSeHjnTBUybCuTAl+6iJHB9ybwn1v1icxy3nX+xWZh
	4SnbcjtYWNwVvqLiRnKzdaJ7p2vmeGJYMubzb2Uy9NRtlsNHuP1McSWCbOM1BE1nJO2qa+sRKuB
	Boqc386ipjlXz8IhuNUh1pyutplDNlQ/QQMc/QbyP
X-Gm-Gg: AZuq6aIU1TG/y8oOJN3LYqQ6Ll9YbyCrJFGvUF61uJQXujThfLm33FSsg3l0WY87P7G
	MZsxel1uKW2t0NIAbj9TVrTqX5/hpTiFzWm6kOfCAYROMyebPztrwuLaB6ilHKdehvLQWYroVu6
	dq0jQotHBtecX2Qrh1aJKS5djkFqvokkmUGRh76UWES0I/LQ5Tpfnst3UDFLaZe3RgwnKo/64Hb
	Nb3LQ8hDQjeNqze3J6qnADr/gCc1vK1xmZF/qkHUHPK8ZvijE+rPHIdIdd+Xj5oZMLxIvBO
X-Received: by 2002:a05:7022:238a:b0:11a:c387:1357 with SMTP id
 a92af1059eb24-124a0070565mr732107c88.16.1769515139201; Tue, 27 Jan 2026
 03:58:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net> <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net> <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
 <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
In-Reply-To: <a7334568-13ce-4600-8650-607273e67976@roeck-us.net>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Tue, 27 Jan 2026 12:58:32 +0100
X-Gm-Features: AZwV_QhBnmJOMJut2whouy0QDOOsNPtnN22UBBfIWJLE3JGNiRb7KMpEqqpo1do
Message-ID: <CAK8fFZ6gKs7s2rJ=f7bt24f+_cY-jGU33TvX3UP=U58uK-1KaQ@mail.gmail.com>
Subject: Re: acpi_power_meter: power*_average sysfs read hangs, mutex deadlock
 in hwmon_attr_show since v6.18.y
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, Igor Raits <igor@gooddata.com>, 
	Daniel Secik <daniel.secik@gooddata.com>, Zdenek Pesek <zdenek.pesek@gooddata.com>, 
	Jiri Jurica <jiri.jurica@gooddata.com>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gooddata.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20656-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gooddata.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,gooddata.com:email,gooddata.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1DDC593EDD
X-Rspamd-Action: no action

>
> Hi,
>
> On 1/23/26 02:19, Jaroslav Pulchart wrote:
> > =C4=8Dt 22. 1. 2026 v 23:28 odes=C3=ADlatel Guenter Roeck <linux@roeck-=
us.net> napsal:
> >>
> >> On 1/22/26 12:42, Rafael J. Wysocki wrote:
> >>> On Thu, Jan 22, 2026 at 8:51=E2=80=AFPM Guenter Roeck <linux@roeck-us=
.net> wrote:
> >>>>
> >>>> On 1/22/26 10:55, Rafael J. Wysocki wrote:
> >>>>> On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> >>>>> <jaroslav.pulchart@gooddata.com> wrote:
> >>>>>>
> >>>>>> Hello,
> >>>>>>
> >>>>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe=
 a regression
> >>>>>> in the ACPI power meter hwmon interface. Reading power*_average sy=
sfs
> >>>>>> attributes blocks indefinitely and causes tasks to enter uninterru=
ptible
> >>>>>> sleep (D state).
> >>>>>
> >>>>> The most recent change in the acpi_power_meter driver was made in
> >>>>> 6.15, so this is not a regression in that driver.
> >>>>>
> >>>>> Also, nothing suspicious is done in power1_average_min_show() and
> >>>>> power1_average_min_store() AFAICS.
> >>>>>
> >>>>
> >>>> I suspect a circular locking problem between the hwmon lock and the
> >>>> resource lock. Unfortunately I don't immediately see it.
> >>>>
> >>>> Would it be possible to test this with a kernel which has lock debug=
ging
> >>>> enabled ? I'd test it myself but I don't have a system available
> >>>> that supports the acpi power meter.
> >>>
> >>> One problem I found in acpi_power_meter through code inspection is
> >>> calling hwmon_device_unregister() under resource->lock in
> >>> acpi_power_meter_notify(), which may be responsible for the observed
> >>> symptoms, but then I'm not sure why it started to be visible after
> >>> 6.18.
> >>>
> >>
> >> I noticed that too. It is kind of broken; a driver should never do tha=
t.
> >> The proper solution would have been to re-evaluate sensor visibility.
> >> I have a patch series to add that capability to the hwmon core, but th=
at
> >> is untested so I never submitted it.
> >>
> >> Anyway, I don't immediately see how that would trigger the problem.
> >>
> >> Guenter
> >>
> >
> > Hello,
> >
> > Thank you for the analysis and insights.
> >
> > To add some context from our side: we observe this issue shortly after
> > a server reinstall or fw updates followed by a reboot, typically when
> > hwmon sensors are accessed for the first time (e.g. by monitoring durin=
g
> > early system initialization). We have not seen it trigger during normal
> > operation, such as a simple reboot or on long-running systems.
> >
> > Given this behavior, it is possible that the issue is related to
> > hwmon_device_unregister() being triggered early during system
> > initialization, but I do not have concrete evidence at this point.
> >
> > As a workaround, we will exclude the ACPI power meter from hwmon monito=
ring
> > (Grafana Alloy) until the mentioned refactoring or a fix becomes availa=
ble.
> >
>
> Would it be possible for you to test the patch series I just sent out ?

I suppose these 5 patches from
https://lore.kernel.org/lkml/20260123182208.2229670-1-linux@roeck-us.net/
 ?
I will try them and let you know.

>
> Thanks,
> Guenter
>

