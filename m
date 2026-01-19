Return-Path: <linux-acpi+bounces-20436-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD8D3BBCB
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 00:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6142C3006450
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Jan 2026 23:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3EB2DB7AF;
	Mon, 19 Jan 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h982XfzT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD272DA749
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768865702; cv=none; b=O1fexAV9Nvfh/gm3c0MvhLaqxWZ9PxczSEShbWWhhadILtGtpLqF4Vt82P1yGdh6CewpnQbIeXo2XP7c+s8b9a4Ai+kZ/7XBC9TTlkVASz1RYuPyyUN48iovC3XEK2i5r8mbEpRb0U2Nia9YCmjRvmoh4y+1BxhHvI6FrD93vhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768865702; c=relaxed/simple;
	bh=gR9/QYJQjjKsbCFpYQ+xMqbj8iLMYrwvWjutKwUvars=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/M3KPtBGua2eWUUktal/6qpZZt3hyVjdXRljsOkaELOCw+gHDXpxdkxE876iAssjdZGgzaQMxdaS33jyLDJdGSHpIKFlNm2OmUJsCImf4CinkaN5fywE1GrjC9Ll2JDgXZNCcxACbdObE5Z2cGmzPwuFNmJA5cwo4/FLrCl/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h982XfzT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FA9C19424
	for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 23:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768865702;
	bh=gR9/QYJQjjKsbCFpYQ+xMqbj8iLMYrwvWjutKwUvars=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h982XfzT/b7eo+isxIcTd3HMKkfZ5zAq98bpp/NUkSiR5ZJAx6pLaN/99ZiqD5XgL
	 htMg9Y0Cm9rYdiCNuuWSJ8rxDZ1qnfGokarrr+F/b6NyNR3IVFdFgskGYksbtw1zVJ
	 x5HZSI5Bpa1DCqD6dei9YAkxxKpko6wYoXn7v4rS6U4DmRoUuftilBWOLhz6afwbde
	 6IDk7P9YyuXrsS7ejvALPWhtmWpf3c4AIzb/U/oLmMGaXLEojwOT5kRLi6S0hhw11G
	 BPtPM+YgNGZsOropMkD1sENdwPMtedcHPbW+66rkLusVrgONNlSWwF9NwAKzqUtLF9
	 G8L+bAK38KU0g==
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-649389b1cc5so615379d50.1
        for <linux-acpi@vger.kernel.org>; Mon, 19 Jan 2026 15:35:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgV0zq6RtgBvS8f3F26/h5avhnLxrflloxhUkQ1/+zdGdgZW5O/nHuiBv66KoOyi34MK2KQyCHHtYt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oSUV2JZOagkCqqxO4Xiv7AVW7DUE0uMJx3dHtXGXyHwIe1bv
	Xs9R7VPbs5k1KR6VuwpWJ5p6YtKssUJy+9VDskEa8UP7+NeJtl2/lqcOwr1/A9O/8l5oYh10eja
	AfvxqaYHDJTNJTpWSRhDJNt4EUGEuJns=
X-Received: by 2002:a05:690e:b46:b0:63f:b4ee:7915 with SMTP id
 956f58d0204a3-6491648aad3mr10161094d50.11.1768865701579; Mon, 19 Jan 2026
 15:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aWgAfsycBDc0mlFv@smile.fi.intel.com> <16e32f1c-8419-44cf-9da8-4c0cae6165e7@redhat.com>
 <aWjpQhGyHXXjsx2b@smile.fi.intel.com> <6debcd61-c60e-4436-8e31-c3210528b755@redhat.com>
 <aW5mn9pXYOU-3djd@smile.fi.intel.com> <a7b9b269-94a2-436d-b51a-cc2ffc98ea69@lunn.ch>
 <aW5umnz8RdQiIzoi@smile.fi.intel.com> <97cd04f6-827b-41b6-aab6-b5850c443dbe@redhat.com>
 <aW6JNDr0ZoBjHMeS@smile.fi.intel.com> <00bc45f8-8847-4f64-b140-790a2567e6bc@redhat.com>
 <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
In-Reply-To: <aW6UBBvFHP_gEg-V@smile.fi.intel.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 20 Jan 2026 00:34:50 +0100
X-Gmail-Original-Message-ID: <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
X-Gm-Features: AZwV_QiDKAjPlxAL0Sfq5kmwsvfKjpmM0H-jB3mZP7ddgK1IsuLGHqzp7kdNQtE
Message-ID: <CAD++jLkD3QX4CgEaDsS=4yMzc632Hk3DjYrSangoEbCrcV9JBg@mail.gmail.com>
Subject: Re: [Question] Best practice for ACPI representation of DPLL/Ethernet
 dependencies (SyncE)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 9:28=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

(...)
> > > > Based on [1] example this clock relationship can be represented by =
_DSD.
> > > > Is it correct?
> > >
> > > I didn't really get, is this a clock provider-consumer relations or p=
in
> > > connections? If this is a pin connections, why there is no pin mux dr=
iver
> > > for it?
> >
> > In fact this should be dpll provider-consumer schema. Consumer (e.g.
> > net device, phy...) uses (consumes) DPLL service (frequency
> > synchronization, ...) and DPLL device provides such service.
> >
> > Note that the pin in this context is DPLL pin not pin related to pinctr=
l
> > or so...
>
> Right, so these are pins with special functions, which are not GPIO like.
> But pin mux is not only about GPIO, that's the nice part of it.
>
> +Cc: Linus for his view on this issue.

In theory a pin controller can be instantiated in any random driver that
controls a few pins of its own to the outside world, just like we have a fe=
w
few-pin GPIO chips here and there such as for USB serial adapters.

In practice nobody does this, they have some driver-local way of handling
pins and mux them around for their special use case.

Graphic cards or audio would be an example. Much custom muxing
happening there I think.

I have no strong opinion on the subject, it's up to the driver author I thi=
nk.

ACPI aspects I can't talk about because I don't understand them...

Hope this helps!

Yours,
Linus Walleij

