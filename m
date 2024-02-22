Return-Path: <linux-acpi+bounces-3839-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B7885F557
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C31C22EB9
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D0939852;
	Thu, 22 Feb 2024 10:11:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969BC3717C
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596671; cv=none; b=fy4be+VdZ34OT5N1i7GkGFH7vcZwlmwHxwrbj+UiUiEZqIrRxGdoO+4RVUHR2jYYQ9knWYda2FLNK7zTbB1qvK1Om+EqmRBP30kSsF88CrMyVBxKsLt2Kv7Lgge3J3Eo7CpBwqAPwcd1BHLPy+lMdsb1uQLcuANOZVMVsVkwWWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596671; c=relaxed/simple;
	bh=tfpYU9dulFCpl7YmPUTkukBpRQAkMnTNPIxsRFJjnuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4spzpaIBgT4D4ng1ndO6ZDys/jBblKNqGHiRHsGW8Cix/uXOnmOBazWQ6966ONvA8+ACQoTXWFURPGWBc3VnHZFrdPpT3UNG0SVoG7bwRl6GgDeRxXEsCEDrKxoO0Bfb2CnEFHX+pVBh82cV++kbTERGeDlms7Ai4tqH8hcJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3be110bbff9so2218609b6e.1
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708596668; x=1709201468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tfpYU9dulFCpl7YmPUTkukBpRQAkMnTNPIxsRFJjnuw=;
        b=Nkrr171kogQ7yHukLmp7k6x7ht+yds2n0Cred8PhCtHvFXx+q5csfsmqonF6U3ipUF
         Ir9aNiiN4IHHo2PGTqPu39foW6GZ8iFSaTMxnxct25XUenD5EAzKdMifDIAQKKOuWwCt
         xV+CQsuonjISyFiZYkztHxPjFMccjZPfDL4GggkNKhA9TEiI+QfD+uzNKqZXYxSlP1CS
         FCJy5yehg4WrCGl8eqITuKNE4LmDSo2m1LVq6ZdL1wPtkeKuMlTjFz9wG/oq9aqkM52w
         cBKAGzErX8YmeJ7wnEtxBq29NQFN/WMPgjJbun6Luo4bYRLXNq+kASAXKdktkAgHyNSJ
         bSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvn9O95QJk7GlSdFg7gVKbBLEO/yAw/Fz8/1I2LOrBj7N09Zscamo+p8e90HKa2qo26BScYRkbfTTSvmgSMt8VNDJQ+8vhsFNAGw==
X-Gm-Message-State: AOJu0YwVclC+gv/zZq5eEsVMhXpfZQInkLcIPDOa5XDNOIoYOjouIY3P
	p32wCE5anh77INcAK0G5q57LlvzP26KMnijCP/iolJlg+q9mCHCMU0YGarHm3t7TdyIz0SVOYTh
	GTo0FM/ZdQaQeGdgZWWb+W6C4xbg=
X-Google-Smtp-Source: AGHT+IEN7CiL41QfCi4a1JblhUxK556EsnwbjLgoVhB2OiIq8E3LcawHKdokZKWjsztONe7MNecl3QmTvvXYxRWcQ6s=
X-Received: by 2002:a05:6820:b0c:b0:599:e8ff:66d9 with SMTP id
 df12-20020a0568200b0c00b00599e8ff66d9mr1887632oob.1.1708596668399; Thu, 22
 Feb 2024 02:11:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240218151533.5720-1-hdegoede@redhat.com>
In-Reply-To: <20240218151533.5720-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2024 11:10:56 +0100
Message-ID: <CAJZ5v0hgqBC6rpHr8pQFG7eMA7v0OO8dSM3rpEi9J=d2J2SeEg@mail.gmail.com>
Subject: Re: [RFC 0/2] ACPI: Adding new acpi_driver type drivers ?
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Sun, Feb 18, 2024 at 4:15=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Rafael,
>
> I recently learned that some Dell AIOs (1) use a backlight controller boa=
rd
> connected to an UART. Canonical even submitted a driver for this in 2017:
> https://lkml.org/lkml/2017/10/26/78
>
> This UART has a DELL0501 HID with CID set to PNP0501 so that the UART is
> still handled by 8250_pnp.c. Unfortunately there is no separate ACPI devi=
ce
> with an UartSerialBusV2() resource to model the backlight-controller.
>
> The RFC patch 2/2 in this series uses acpi_quirk_skip_serdev_enumeration(=
)
> to still create a serdev for this for a backlight driver to bind to
> instead of creating a /dev/ttyS0.
>
> Like other cases where the UartSerialBusV2() resource is missing or broke=
n
> this will only create the serdev-controller device and the serdev-device
> itself will need to be instantiated by the consumer (the backlight driver=
).
>
> Unlike existing other cases which use DMI modaliases to load on a specifi=
c
> board to work around brokeness of that board's specific ACPI tables, the
> intend here is to have a single driver for all Dell AIOs using the DELL05=
01
> HID for their UART, without needing to maintain a list of DMI matches.
>
> This means that the dell-uart-backlight driver will need something to bin=
d
> to. The original driver from 2017 used an acpi_driver for this matching o=
n
> and binding to the DELL0501 acpi_device.
>
> AFAIK you are trying to get rid of having drivers bind directly to
> acpi_device-s so I assume that you don't want me to introduce a new one.
> So to get a device to bind to without introducing a new acpi_driver
> patch 2/2 if this series creates a platform_device for this.
>
> The creation of this platform_device is why this is marked as RFC,
> if you are ok with this solution I guess you can merge this series
> already as is.

OK

> With the caveat that the matching dell-uart-backlight
> driver is still under development (its progressing nicely and the
> serdev-device instantation + binding a serdev driver to it already
> works).
>
> If you have a different idea how to handle this I'm certainly open
> to suggestions.

I agree with the approach, thanks!

