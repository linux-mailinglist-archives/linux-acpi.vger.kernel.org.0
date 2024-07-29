Return-Path: <linux-acpi+bounces-7111-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9398F93F513
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 14:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56701C21672
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Jul 2024 12:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A31474B9;
	Mon, 29 Jul 2024 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afct/Vda"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0090A1D69E
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 12:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255671; cv=none; b=Ujc/QsOQPZnzY/uKH9Q6ItRM8wxOP+mm+A45ih3qUTI/WizlefL5h3IvTxeWuFd/83ljd6twgKEBt0btnEXraBnHKM22kvrMwlfYd90VS8Nk4KKxwNzzaZQa9wFcO+KtF1MFfVAR/zfL7fBqHeu2q0capb4jfUuQf7BuXkxEZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255671; c=relaxed/simple;
	bh=xmcN7xiV63JRnpxWPpqS0T0nv+OSPPKUtjHq4rWabHQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlr7+r4CaVVSKnzpjGtt+DRS8C3obrLyiJR9NoNWZgw9hkunnxoWGrjzpTLcYGJwKyXAPZw8MelCcLOXP/Y4Arh0ac6PfMglfEYcgx4RD3iPh5Vz7J5SeBtfX+DDGw5tToEYa3sqfL3SH4LSjzuFy0OEPA23z+JDLJpjoFtKxVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afct/Vda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FD6C32786
	for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722255670;
	bh=xmcN7xiV63JRnpxWPpqS0T0nv+OSPPKUtjHq4rWabHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=afct/VdaIf/KjLGhj9lyIYiVTOaH2+PmsTV0w4+iKefogJoiapz396/l0Oveg+zfD
	 PfESMRua3ixkQdUj5ut2nwrntr/ZaiUzGQFxAdeqcThUSH1JBF1sLl1z7N88BEaboY
	 f9g9bTjJLTH1NiyTlHDbHmUaWZkC0tQF4/WZTJZeetwTen8ZBzJJ+gnsDDGj+XH9Bo
	 D3bWKdSCVAsKW6djDWcu9RDmKF2UiNeuE1ki9/6g1uQXsZ8cYWwBmtgW/fi3+YHo33
	 IrAp68lzRzqqSm5LUEAb9ev2Hkcaxr02qN6ITz8btqKT35Bzy42g9dm06sqZfoLfI3
	 W5SZsbFK0Kszg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db37444230so58589b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 29 Jul 2024 05:21:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVal10JhOF/kG39q2J88CRtAlKmAk+GP2S5rthjW0eE1NQ4W27RCstSf0MjYevfX4vawSaX1E+AMSVn@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmqyXho2JP1LF72u7ZCKGifFaWuYq0udS5up29mr/kUeTuVzx
	GHvFV+gWmRgrWkTHjaeUbpF2J8GGEskPWZR2nIRzpBTSvNHJdTEuFIcFzIiPPk+b8t9drzV55s8
	UZpWMHlmgeuGz1nmyx1a5iM37TMg=
X-Google-Smtp-Source: AGHT+IEAmOggp2rQJqqkSPOoJnuj6oMaQV5f3FZDqtkJJvmo2bicxbzPXOD99/Uk7sZySmsMRZI9W0jwjtUJNJpaY0U=
X-Received: by 2002:a05:6808:d4a:b0:3db:10c2:6008 with SMTP id
 5614622812f47-3db1214167fmr8860835b6e.5.1722255670076; Mon, 29 Jul 2024
 05:21:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com> <6dfb58d7-0b36-4414-bc01-75697077fd27@redhat.com>
In-Reply-To: <6dfb58d7-0b36-4414-bc01-75697077fd27@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 29 Jul 2024 14:20:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gs-qrywWyF7PXC7_b0zAfBz=8xoc5V83nkuWgt0RdV9A@mail.gmail.com>
Message-ID: <CAJZ5v0gs-qrywWyF7PXC7_b0zAfBz=8xoc5V83nkuWgt0RdV9A@mail.gmail.com>
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, Jul 29, 2024 at 1:29=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 7/29/24 1:15 PM, Hans de Goede wrote:
> > Hi Rafael,
> >
> > There are 2 bug reports:
> >
> > 1. Brightness up/down key-presses no longer working on LG laptop (acpi-=
video related):
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject=
.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
> >
> > 2. EC related ACPI errors and bad performance:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D2298938
> >
> > Both of which started with 6.9.7 which has the 2 commits related to "EC=
: Install
> > address space handler at the namespace root" from 6.10 backported:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/acpi?h=3Dv6.9.7&id=3D2b2b0ac1533d790690d6d28899f01a2924d54d4d
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit=
/drivers/acpi?h=3Dv6.9.7&id=3D9750135f2f326879889ed60ccd68b96572dfa6ee
> >
> > i have build a test 6.9.9 kernel with these 2 reverted and 1. is confir=
med to be fixed
> > by reverting these 2 commits. Although the user does report an IRQ stor=
m on the ACPI IRQ
> > (IRQ 9) related to thunderbolt after this.
> >
> > I have not yet got confirmation that the second bug is also resolved by=
 the commits.
>
> ... resolved by *reverting* the commits.
>
> > Either way it looks like we need to dig into this and figure out what i=
s causing
> > these EC related regressions.

Right, so I looked at the dmesg output in 2. and saw that the EC
errors were reported right after enabling the EC for the first time in
acpi_ec_dsdt_probe().

Because acpi_ec_dsdt_probe() passes true as the last argument to
acpi_ec_setup(), it will evaluate _REG everywhere at this point, but
previously it only evaluated _REG in the EC scope.

In the ECDT case, the _REG evaluation is deferred until the EC has
been found in the namespace, so maybe that's the right time to
evaluate EC opregions _REG in general.

So one thing to try may be to pass "false" to acpi_ec_setup() in
acpi_ec_dsdt_probe().

> I'm wondering if maybe this is also somewhat related to commit e2ffcda162=
90 ("ACPI: OSL:
> Allow Notify () handlers to run on all CPUs") ?
>
> I guess not though since this started in 6.9.7 and 6.9.6 is fine.
>
> I did recently submit an unrelated fix caused by e2ffcda16290:
>
> https://lore.kernel.org/platform-driver-x86/20240729110030.8016-1-hdegoed=
e@redhat.com/

None of the above look like they are processor-related, though.

Thanks!

