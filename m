Return-Path: <linux-acpi+bounces-20583-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id l8+wL3dLc2liugAAu9opvQ
	(envelope-from <linux-acpi+bounces-20583-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 11:20:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE85743AA
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A7873006F2A
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jan 2026 10:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03DFE37416E;
	Fri, 23 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b="b2ILDSuR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9306F3002C8
	for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 10:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769163603; cv=pass; b=Tp9t9uYJ+xnFEuWW1nSDt67w2aflZ2n2llwe4sRS6/DCOhNO5RtwzbtBG3SPGEAgBWYy+vI+dg0TaRLMklVX6I8M17eraFTWC2pur5hiTDIxPphREQ+OZPCpDQ3lz5iqd6em5SLbYN3O4UHzmMEZoQlQWiZ9ts7CXEZrMfcLv0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769163603; c=relaxed/simple;
	bh=dGoB5x9VFS+4dOaBdZZ9T+GRMoADVYTmJoPFZcQ5eq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLBtbFunVBB8P840ix5Yy0okhSM5qQTVRhE2ImicfsyGsufx+ufQBwKxe9oryiAnn/qQqs4o8ifE2/oxEDytWH/FBxD+iQIVfCDVxWgkwQ3THqrlKNZvi5ZiUGSujxCInLsBh/H5J5/NTmGYdY91YgIN+T3gCuqwwCfBbgo2T3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com; spf=pass smtp.mailfrom=gooddata.com; dkim=pass (1024-bit key) header.d=gooddata.com header.i=@gooddata.com header.b=b2ILDSuR; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gooddata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gooddata.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12460a7caa2so2916748c88.1
        for <linux-acpi@vger.kernel.org>; Fri, 23 Jan 2026 02:19:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769163593; cv=none;
        d=google.com; s=arc-20240605;
        b=HxoFUwFcoos/nZX6aoUP+GkzzbZEhzxBhnaPIFYYEWAlkOFrJBuEYmn+Zi91iMlv4M
         iITrwUJKZowdHkq5JLfoDJgvkqwUQEVxeKfATXO5oMZWiUJ+wgd48IRHA2aAUAFxivDG
         iI5jUcxV88jB0chs5w4sZVSKigcKmPwpI6ZTMgA30v6/jT92qcI/qc0X9J5ZDrifPiAy
         ZRlczxkHvrEqMn6E6478lTmqAtwZA3i3/clp63+ouHmPqzTMtSu0A2LBDZs5gleliShQ
         AmEIyE/WQHiiqSd2ZHFfUE2jWesYOwf4iMVsFzvjEV1kxpq/26jFfycJgvZzsFyRSWiV
         LLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGoB5x9VFS+4dOaBdZZ9T+GRMoADVYTmJoPFZcQ5eq4=;
        fh=9QBL00aBzpFQ9b9+PzLk5MGbrkpBAj3h60USnD2hx94=;
        b=lrbTxYvn2FJus3bv0hE05l/tFZBppJ8HH1BznpF0QlBBp++6IC3HI9Q+8UbI9u5Rp2
         /o4uhVWsCnqiNABS3ixDvPA2zXFy2xr6mxyGL+tSOoOdYuOH6ZshJsAJNug6sU2XflL5
         vbl8Oh7HMycdSNG2nbxm4J03DyWyeWCbWTfnOuIh8isd1P29KjR3eNiTsrJVL9AVnIbu
         Ici1OiloVEDeMlIs1ti8U1bkVhI0Nrmphk/oS3iiZ00KIQVwzDGfseZmGw3+7kyIjsOg
         P4t9pzTQIokv1llMAueaZCfkgJTOiC2LU0o1SvaUSYpb/wdCCOteY/+t4Drs10XJ8cqe
         h71g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gooddata.com; s=google; t=1769163593; x=1769768393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGoB5x9VFS+4dOaBdZZ9T+GRMoADVYTmJoPFZcQ5eq4=;
        b=b2ILDSuRl3Qt7+s6emDtr3HjCmHvdWxOxUYlLHWsvulnzqr1q2oOCmb8TuiWwF4lG1
         8lBxNQhZlGk0g79hu/8F9tFKtRYO1DSL8yct3q64p6w2qFUqOXEcLmVRzmDRAPNMfKSM
         LpIz81KVHZUsbIUpMIlvGsPFm4D4cZu536dMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769163593; x=1769768393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGoB5x9VFS+4dOaBdZZ9T+GRMoADVYTmJoPFZcQ5eq4=;
        b=TOFQ3KLDQvka5EqMFJneHmCm41s6QfaONluivkImiOW3HH71kiYqJssixCuuXxojhb
         x3+XIPE7uHog99gg8UnInzKcdY8psvGqrMa0XHW9oUDsEsQ68kevV92j+Ttye13Qb/zM
         fIY7uvEdur42Iu52f8ek9XiMbK1wh2O7ZwBLWCeD9+AMmakjq3lZ3gv2sr6uvhLU1Cuu
         H8FYFSjr4lyU5u5B7/44nU+nygn5WOVqEtwE6mrMO9guxH1LxSMzgicTqFh68UEjYiXg
         LXg1KXP9k+vIpoB7AUKEz9/WXBd7H0wvwZ27T0JgUnByRtNEeFE5Bp/5UIPSy0N/vRBC
         ZTZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWREZYF2O4oZrKAy/GxbWIIZ9ZMnl4hGDskIWkxXEb/srK4RzYsa/50NI7SFhX9mJbgj+OZV4LYXCOF@vger.kernel.org
X-Gm-Message-State: AOJu0YxmRAxF+9ISaBwIuyJfKt14fBDobouZ6ocFtfh0Ic3stk+jAEqN
	uoFECYVD0oGjMOWduBEM42mT+yw/u3fjz+vISHJMRRhYhV1G17DGHW6iBvKDETwsm9V4WvVbdFc
	1Olb1kzuNZdFn7RQ6KHP1IU6zTcxI0xR2Goawtwq3
X-Gm-Gg: AZuq6aLIAq81V+YlX6bjKvyPESa16xKsVcgsBp9HzLMvYbwiugF67SqmjvdyPAyIxRr
	99CqDsOMNJTZDbDrx/D9uTcXdITgjQpk166I+4HkHQHE4bmQDrBg5wT8eSxvqw4boxwLjO/hQ17
	Sq5gvNX8MrUwaAzxa4jiKYRal3mb1BGtd1aDsPo0LgKJ4psQT9HSLG1YechhV+lv9zLxYmz1J0w
	X/Mx8hdgLwmpNgWjhh81FcxdJ0i05cktVCrkHgeIYGhFlLsUpNvxPpg2JnEQogpUHXAIFPD
X-Received: by 2002:a05:7022:6b8d:b0:11b:aca4:be1f with SMTP id
 a92af1059eb24-1247dbba399mr1114972c88.17.1769163593476; Fri, 23 Jan 2026
 02:19:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com>
 <CAJZ5v0jSbGtRYkjqeuYaT3LXbeZ-xk_Gc0dbCpTZPc6nBD8eCQ@mail.gmail.com>
 <e03c8b69-e667-45b8-b82c-2cd4f1c96bdf@roeck-us.net> <CAJZ5v0hvKzKTWA8jFYVDHttd+hDv1juu87vgyhf2udOGbqrQdg@mail.gmail.com>
 <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
In-Reply-To: <d7f34e0f-e258-4fef-93eb-1ef0a3123d95@roeck-us.net>
From: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>
Date: Fri, 23 Jan 2026 11:19:26 +0100
X-Gm-Features: AZwV_QhiDa_iFisfl1Vycn-TcgZOZh_Dv08_jX6jKVuFlFsGfCq5GEQALLr-n9E
Message-ID: <CAK8fFZ4izdX_HDtGN60CZ3Ta61nqkUg7ncViM=mGgxKki_5FoQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gooddata.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20583-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gooddata.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaroslav.pulchart@gooddata.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,roeck-us.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8EE85743AA
X-Rspamd-Action: no action

=C4=8Dt 22. 1. 2026 v 23:28 odes=C3=ADlatel Guenter Roeck <linux@roeck-us.n=
et> napsal:
>
> On 1/22/26 12:42, Rafael J. Wysocki wrote:
> > On Thu, Jan 22, 2026 at 8:51=E2=80=AFPM Guenter Roeck <linux@roeck-us.n=
et> wrote:
> >>
> >> On 1/22/26 10:55, Rafael J. Wysocki wrote:
> >>> On Thu, Jan 22, 2026 at 7:21=E2=80=AFPM Jaroslav Pulchart
> >>> <jaroslav.pulchart@gooddata.com> wrote:
> >>>>
> >>>> Hello,
> >>>>
> >>>> after upgrading from kernel 6.17.y to 6.18.y we started to observe a=
 regression
> >>>> in the ACPI power meter hwmon interface. Reading power*_average sysf=
s
> >>>> attributes blocks indefinitely and causes tasks to enter uninterrupt=
ible
> >>>> sleep (D state).
> >>>
> >>> The most recent change in the acpi_power_meter driver was made in
> >>> 6.15, so this is not a regression in that driver.
> >>>
> >>> Also, nothing suspicious is done in power1_average_min_show() and
> >>> power1_average_min_store() AFAICS.
> >>>
> >>
> >> I suspect a circular locking problem between the hwmon lock and the
> >> resource lock. Unfortunately I don't immediately see it.
> >>
> >> Would it be possible to test this with a kernel which has lock debuggi=
ng
> >> enabled ? I'd test it myself but I don't have a system available
> >> that supports the acpi power meter.
> >
> > One problem I found in acpi_power_meter through code inspection is
> > calling hwmon_device_unregister() under resource->lock in
> > acpi_power_meter_notify(), which may be responsible for the observed
> > symptoms, but then I'm not sure why it started to be visible after
> > 6.18.
> >
>
> I noticed that too. It is kind of broken; a driver should never do that.
> The proper solution would have been to re-evaluate sensor visibility.
> I have a patch series to add that capability to the hwmon core, but that
> is untested so I never submitted it.
>
> Anyway, I don't immediately see how that would trigger the problem.
>
> Guenter
>

Hello,

Thank you for the analysis and insights.

To add some context from our side: we observe this issue shortly after
a server reinstall or fw updates followed by a reboot, typically when
hwmon sensors are accessed for the first time (e.g. by monitoring during
early system initialization). We have not seen it trigger during normal
operation, such as a simple reboot or on long-running systems.

Given this behavior, it is possible that the issue is related to
hwmon_device_unregister() being triggered early during system
initialization, but I do not have concrete evidence at this point.

As a workaround, we will exclude the ACPI power meter from hwmon monitoring
(Grafana Alloy) until the mentioned refactoring or a fix becomes available.

Best regards,
Jaroslav

