Return-Path: <linux-acpi+bounces-17019-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D8BB59923
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B11882882
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Sep 2025 14:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3551131326B;
	Tue, 16 Sep 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SE+O7cxD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093E30C616
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 14:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031839; cv=none; b=lnal4nP5b+VKEYTlbfawIMHaSlT8cYkaNH0VgHSFW8VI+ZRTU64GTWk/QMJhaqMdFBS953k9d6o94uCm00CmoNpEEGfbiOYUsjmKjQDpGG5PTwrOoHm1sWR7cIeT9jTN0mExNl25Jyge3viFHNAbqw0euxPnXFjm6Y7h2DhvcbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031839; c=relaxed/simple;
	bh=hCIF8Ni27sWB5MOZDUMOfE/fvmsjz8qbIc6FotWXnxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bh+zNzYLooX71u7wf4D54EbIgUmN7JVdbDZxGLD341j9UHNCw5jKzSgUxMRFucgOJuVKr6skAtA8Ei6jQEWGLNHRZzz+hejM+S/YjgwOdGUCcraPEZ5Q6Lg8lSAJkMfXdGVBsVOCtwQ++/oJuixmIPYs9bKAN13nR4Gr+GdpmbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SE+O7cxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B978DC4CEF0
	for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758031838;
	bh=hCIF8Ni27sWB5MOZDUMOfE/fvmsjz8qbIc6FotWXnxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SE+O7cxDEeE9EgJkPFgOgI/3ZVRY425Cq5eCucqBzbGGcRFmHAE3biMBG9U2QVPHQ
	 W+bzj+kKc9zLGTThiyHEudH9wpuyh43AJuIvU6uwPB8WoO09jFGMEh6G8Gu7dkXOXO
	 nytb1ZVrTleXStutuvYPPNF5cyLGU/GLTwzNSSOOe3lLYtKXVr6IlkB0esLMTKOkiQ
	 /GAdFP593GtX9bu+2jtmjdJRg+l/LvRS7CAvhpvpBFBvy/6pBtEdxs/WdlBdjuPFKN
	 GsV7i28wD4lY243rvlgVC4ydBXQMmQyp4WDSvVQXNsSd8uVzXEgHt88DNZKWACQcSq
	 vpql+dAQauf+Q==
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-751415c488cso4784835a34.1
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2025 07:10:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdUvz8BvXg1Nqf8DVzgWT2UIHejMc6CYWoYefuxuUdufbzx6aqSB7DUEViW8QMhqWvs+mRCqLByBwT@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/dgeGJ+vkOjhzkLZ9TtyY7+3eOaUff2eAQGesV9GySkIoaoiQ
	ngukPzps5LbYj30otOZfYzLPNPbtcOcKTEFHcWTkxV1nWOjfyCAAQtzlPFUH316Gaxn6kkSgeY5
	B68zBBfz+dTNLFmSlc3vBRcx8IUpLBd4=
X-Google-Smtp-Source: AGHT+IHACtZwuhHIk/mW4cBWIIjEOiXq5pqvLUVG9TYbM9mtcWpVOX1u6bq2A+d/yR/MP+E8EUqyoEmmJqoh1gnEss0=
X-Received: by 2002:a05:6830:2a14:b0:758:85e2:9a00 with SMTP id
 46e09a7af769-75885e29d65mr4731228a34.17.1758031838083; Tue, 16 Sep 2025
 07:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5922318.DvuYhMxLoT@rafael.j.wysocki> <aMlvpfVbEP9JOULX@kekkonen.localdomain>
In-Reply-To: <aMlvpfVbEP9JOULX@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 16 Sep 2025 16:10:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gc0XBmL5ChzyzUs=UGjpbS7WAVpxR5dSbsje895DzLGQ@mail.gmail.com>
X-Gm-Features: AS18NWD1oFdI3bsUnLT_GN6C_O9Rpekp5SNgxCAUvIqMn1SU7Bkhgg43MYvvdc4
Message-ID: <CAJZ5v0gc0XBmL5ChzyzUs=UGjpbS7WAVpxR5dSbsje895DzLGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] ACPI: property: Two fixes, more documentation and
 a cleanup
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Tue, Sep 16, 2025 at 4:09=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Sep 15, 2025 at 08:20:03PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is an update of
> >
> > https://lore.kernel.org/linux-acpi/5046661.31r3eYUQgx@rafael.j.wysocki/
> >
> > A user report regarding "ACPI: \: Can't tag data node" error messages i=
n dmesg
> > made me look at the ACPI property code and I've found a couple of issue=
s in
> > it.
> >
> > Also, it took me some time to figure out why the code was doing what it=
 was
> > doing, so I decided to add some comments explaining it.
> >
> > Finally, there's always something that can be cleaned up in every piece=
 of
> > kernel code.
> >
> > Hence, this series.
>
> For the set:
>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Tested-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you!

