Return-Path: <linux-acpi+bounces-7548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF1995030B
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 12:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FAA1F23811
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Aug 2024 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED91F19D893;
	Tue, 13 Aug 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERQWLlNT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979A19D09F
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546420; cv=none; b=HG9KlASMfzywyiykb2BncuIHOXLqstN7WKivJyRJ2aKlc8dz4bg4qeBb14wgDqIFbTLZl0c36RaEn6nWFh4r315gWLbqzhezg16tYkysNePsr3/63Q/bysIwdj/CUc+EenU8JftGLLPMXT1mFxSB4AmKZ3CBBBElVHzt0jgWKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546420; c=relaxed/simple;
	bh=Sd5UE6jmpwak4zN4SKCFR4z/6+InNXSXRU+Hu7btuaQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+35dCouOzUthBgVw+OhpUWhReXouUVgXHjuWtaHNi8IKCKMaqRnJBE6WNfeD4JlTUC/JllXqkeJtucLjaFzsMRIwdP1Zzv3bdddFGZqOzcwq8378uVz9Yfvj2VZAIgQ90b4Z2chYhDG/BfDqwDO9tC8HEKOXupg24TUCY1usUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERQWLlNT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF46C4AF0B
	for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 10:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546420;
	bh=Sd5UE6jmpwak4zN4SKCFR4z/6+InNXSXRU+Hu7btuaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ERQWLlNT2/aSZYcUONX7/T7EGGx/tL+X6FgEnjbNU2Je2CAR1XWNNa3ILojZjVQ/E
	 hLUIU7rlGDepJam+PnzDZpiSZZuHJJzPqYS1Xmsv8EzzpClhrEJ1HVxFHLqk0M49vY
	 BNPl56ZvHxZXYczpyl6hced1vVfCK/3888biQUpMhrVGvb8pY5h0swPO3yEmTwm0mX
	 ExIrcNxpJ/RmBy19QXwwhPt2bsrtLPWVmuTU2LM/YUEC0d5GiNRm8Ucx6ptlpjNc3b
	 UAy3d8MB51Y+4N6NOvyn69XODPVHI/ls3eu9nUZcLWOPKhKq+qGZdg+D8RZybYagJT
	 p3SFbkngHEp1g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5d5bb451631so346133eaf.2
        for <linux-acpi@vger.kernel.org>; Tue, 13 Aug 2024 03:53:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWY16W4AV0fHikX0icg2Ihm/hfgf7NVuzKbrybYnE58JVVHHhd+fFk7yoL+TbFeRw70z6dwKE64IUB5tCkl7OHx/lMen8XV+xyVHA==
X-Gm-Message-State: AOJu0YypUpWyosqtJcdVVEYNmkhHh/2/FAmO8dyUcQVEh+qJUV6KPOd5
	Zg34f2oOYS9Jxz0dSrL/IneMpmlvCi6r+xTXoRHLpsIZPQfdzZiP0rDJcYPXru5XnwjssA82Uw5
	Xvk55iPr+E1jkC4gTjie/nfRGdCY=
X-Google-Smtp-Source: AGHT+IEOwsjAH9Bx1eR1LOgClsEgfostNDfC6DZlQ3J6T4jPmQbqmPJ000wjYQd1D5TCwGu8Mw8aPacjiov0zNCeKp0=
X-Received: by 2002:a05:6871:60f:b0:260:edbc:d7fc with SMTP id
 586e51a60fabf-26fd19e0a14mr1069000fac.4.1723546419555; Tue, 13 Aug 2024
 03:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com> <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com> <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <a0f54ea3-5830-4420-b4e7-73ea8c146bcd@redhat.com> <d7ea226a-24b1-42e9-80d7-039729d93d34@redhat.com>
 <CAJZ5v0ivbV0h+gmpL+LCUfdDmExjJ1G60jQTzf76iWy6aT0e-Q@mail.gmail.com> <0e6faf83-d8aa-48aa-a49a-ec28b0d56e8e@redhat.com>
In-Reply-To: <0e6faf83-d8aa-48aa-a49a-ec28b0d56e8e@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 13 Aug 2024 12:53:28 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h=x3BvtHDoTZoXhcWJS-2G9KmuLMi3MqoRHG4jQuTGCw@mail.gmail.com>
Message-ID: <CAJZ5v0h=x3BvtHDoTZoXhcWJS-2G9KmuLMi3MqoRHG4jQuTGCw@mail.gmail.com>
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Tue, Aug 13, 2024 at 12:45=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi Rafael,
>
> On 8/13/24 12:40 PM, Rafael J. Wysocki wrote:
> > Hi,
> >
> > On Tue, Aug 13, 2024 at 10:46=E2=80=AFAM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi,
> >>
> >
> > [cut]
> >
> >>
> >> The reporter of 2302253 has reported that the patches from:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/lo=
g/?h=3Dacpi-ec-fixes
> >>
> >> resolve the issue; and as mentioned before the reporter of 2298938
> >> is not responsive atm. So I believe that with it confirmed that this
> >> at least fixes the issues on the LG Gram laptops (1) these patches are
> >> ready to be merged now.
> >
> > Thanks for the information!
> >
> > I'll go ahead and put them into linux-next.
>
> Great. Question is the intention for these to go to Linus
> in the 6.12 cycle, or do you just want to let them bake
> a bit in linux-next and then plan to send them as a fix
> for the 6.11 cycle ?
>
> The reason I'm asking is because the patches these replace
> cause a regression on some laptops models starting with 6.9.7
> and also all 6.10.y kernels (and if you wait till 6.12,
> also all 6.11.y) kernels.
>
> So although this is a somewhat bigger change my personal
> preference would be for these to get send out as fixes
> and backported to kernels >=3D 6.9 (1).

Yes, that's my plan.

> 1) Just like how the patches they replace end up getting
> backported to 6.9.7
>
>
>
> >
> >> 1) And based on dmesg with a regressed kernel likely / hopefully also
> >> the issue from RH bugzilla 2298938.
> >>
> >
>

