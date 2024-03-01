Return-Path: <linux-acpi+bounces-4057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7B986E374
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 15:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D1C283840
	for <lists+linux-acpi@lfdr.de>; Fri,  1 Mar 2024 14:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2140523DE;
	Fri,  1 Mar 2024 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b="FgdYKQCT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1513D7A
	for <linux-acpi@vger.kernel.org>; Fri,  1 Mar 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303920; cv=none; b=CHXJ73p8Vu+aAr3DTzIpYXlr5g7AjOns8W2gc7op8h/gJAGzl0ZxjetavpV2zLDexxHD44HiINe2a0yS8ZlxvTDhMxB+GUUwMvSchNk078d1d4+IBNLu+QBR1223EEiXioXQILpYyFQV98Y4dk6T6OEUS/wf5x4LvD2AwsSO2To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303920; c=relaxed/simple;
	bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfzyjJUw0AAUMogq0gaitkVW2shk0dMkFnFqu+gqZl4qHybIHe/QDt5kytwmMQcVEtApyg6V2jzxeBiMYsqyR8/bxWRqrlqHHe6rtNV/1PiGoL/QzQiBSE1YJ/HltOL9JIiJPvNQEgZnxlVENQga9Az3dBIDsuxVz4BBMvGc3fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in; spf=none smtp.mailfrom=cpp.in; dkim=pass (2048-bit key) header.d=cpp-in.20230601.gappssmtp.com header.i=@cpp-in.20230601.gappssmtp.com header.b=FgdYKQCT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cpp.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cpp.in
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso2275494276.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Mar 2024 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cpp-in.20230601.gappssmtp.com; s=20230601; t=1709303916; x=1709908716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
        b=FgdYKQCTzqV9dugGsW32xp1RoofX5SBFdF7WHFRnvnN22EcXmbXJfvZljRSLQ21PZ0
         rU43AMUSP43Yc3d1ZPglddTjh2wFX6Q/ipEYgK+jKTyUeJrdjK3GKqsxLFmSr/VA5Ovp
         BP9x8g3TyuzaVmpGQpRE0J86ftPdeqUDEaRIIbZQ6dZe68hhAuVXOa14NQa8zYNKbmuM
         o/qERMLTa7fvaRSB7TYFQaSVIvHOy2YFXag3B2UEDN21SvvS8QFjqO+kQh9c6OczFlRw
         Pb+TOVroKkmMptV14ieD7ey7CyVWd+TyPzm6typuYuiFKyaZJ1n2toE3C8/3U9AA+Unx
         yiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303916; x=1709908716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8ZIZZz6tfUgmhlnktpOJJ59LN5Nn7PzRITeojROZ6Q=;
        b=T04rOHj+WcNqKhtf7+DXxsf/0znxqmJ2nsfDg9CqYIoekcpkG/w5unphcAPEWBQsgf
         447hFVm1CE8mv+at6WxnFSLIwc5qoSzSw1NZQsz5AFt41JU99sJq2XwZ2HXoL4bkbMin
         bE9MdUGgp+jxEWGCpEtdTHtO3Ty1ZQPaMzKeLCRl9Dvvd6dfoNe8vcU09qtYWrl66AFD
         UEy4jz8++jKst0CGxvPRTxEm4STnN2qF3KS6ZLQIfeYwGGB+Nm2j3INDKFHUmrbE7Y/5
         3k3ECQyZyJfw+vj3LwPGFjlK60W/8WWLXFkFUdLmPC5T+FNZntRfItD2caDVy49wi4G0
         fzBA==
X-Forwarded-Encrypted: i=1; AJvYcCXE8p7pNT5yLfvomf7lN4hbhfkyQyJjOMNAdNbQRWaPRL380vW4YTsdP6tEgOO9OoEijxJRm6KSrX+1891qSicj08dWiCMN2DS4Ww==
X-Gm-Message-State: AOJu0YxaQlCkagaZUt8OsbFwqagAmcO8osgsnC8jKSFZG3RIuZLZZmUu
	BBngPI1fVTx6gXdH5NiWf+plv40f8OOeKpvaSghZc5so9ho14fiSmo1pfM8mtZDVPfs3eXMXhcU
	kIxbtXGxAuCHejpl0/m4gGVJEq3vfeZpMmJnF75CK3Y9J65FRUA==
X-Google-Smtp-Source: AGHT+IHkN6xOaUN9UECoQU+IRfaE0jc2wZukCIWfahyaN+qV06BLatN1ep7jb0o1NiV96VIBQsfEYuvljkgvuv2eZHE=
X-Received: by 2002:a25:ac68:0:b0:dca:e4fd:b6d5 with SMTP id
 r40-20020a25ac68000000b00dcae4fdb6d5mr1607076ybd.27.1709303916369; Fri, 01
 Mar 2024 06:38:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABYkuAg3rcXT=0-=7EMX8NW3-mU0zYRvp+rOo5nq_7SHdb=cxA@mail.gmail.com>
 <20240216120211.GR8454@black.fi.intel.com> <CABYkuAhLYcLQp8PiBm-aTDC-AAV2NWVzN-79XLVcYvAfGtVhcQ@mail.gmail.com>
 <20240216144610.GS8454@black.fi.intel.com> <20240301074209.GM8454@black.fi.intel.com>
In-Reply-To: <20240301074209.GM8454@black.fi.intel.com>
From: aigilea <i@cpp.in>
Date: Fri, 1 Mar 2024 17:38:00 +0300
Message-ID: <CABYkuAi_vCc-kN_DSW0kPGACQKo+7B9GBckFiUsqGqTts7xXuQ@mail.gmail.com>
Subject: Re: Kernel panic in ACPICA on HP Spectre X360 (Meteor Lake 155H) laptop
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

Renaming the IC03 variable to the closest unused IC08 in the DSDT
overlay indeed fixes the crash.

Renaming/removing the device (as it looks like its only purpose is to
trigger Windows update to install some HP software) might be a cleaner
way but I'm not sure how to do this with overlays as this device is
declared in one of SSDT tables under the widely used _SB_.PC00.

For me personally this is good enough, but I'm not sure if it's a good
solution for a general case.

HP's attitude is unfortunate to say the least as the bug is so clear
and the fix is so simple. We've only bought a trial batch of ten
units, we'll return the ones that are still packed and go with some
other vendor from now on.

Thank you!




On Fri, Mar 1, 2024 at 10:42=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi again,
>
> On Fri, Feb 16, 2024 at 04:46:10PM +0200, Mika Westerberg wrote:
> > Hi,
> >
> > On Fri, Feb 16, 2024 at 05:36:21PM +0300, aigilea wrote:
> > > Hi.
> > >
> > > Booting with "modprobe.blacklist=3Dintel_lpss_pci" on the kernel comm=
and
> > > line indeed works around this panic.
> > > I will try to find out what hardware depends on this driver.
> > >
> > > Two years ago there was a similar issue with broken soundwire devices
> > > configuration in dsdt on tiger lake iteration of this laptop, it is
> > > not fixed by HP to this day.
> > > SOF guys in Intel ended up making a quirk for that case.
> > > So if the quirk (or some additional checks in parser?) path is not
> > > suitable for this issue I guess the most "proper" fix might be acpi
> > > overlay?
> >
> > I understood HP did this fix to their BIOS but it might take some time
> > to get the confirmation and the BIOS version (working on this).
>
> Unfortunately it turns out that HP only applied this fix for their Omen
> Transcent system and apparently there is not going to be updates on any
> other system that has this issue if it is not shipping with Linux :(
>
> So we probably need to figure out an alternative. The root cause is that
> the HP BIOS accidentally a device and a variable with the same name IC03
> and that gets resolved to the device instead of the variable in the
> _PS3() method where it calls Add(IC03, 1, 1).
>
> This was fixed by renaming the device into something else but I'm not
> entirely sure how this could be fixed in the kernel side or ACPICA.

