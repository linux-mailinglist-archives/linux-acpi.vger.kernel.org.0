Return-Path: <linux-acpi+bounces-5861-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6F98C7463
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 12:09:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15FB4B24681
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2024 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB24143885;
	Thu, 16 May 2024 10:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8Sfsz2i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15375143754;
	Thu, 16 May 2024 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715854157; cv=none; b=R6MDBadY9ZpcyCkALOoookezeVc4Oqhmx0YhKPFCTqnsrW/4v3sSsBYVrvc4p07zonvYstLdOHsJ6CK+SwWerBS+a6JQnSFcFEnj2Ltvd7yhJTBUOMCuGFPwpwHc2N0NV+I9uxQlEI/rV0XoJYbxgW7zu7jfZpgoxPA9saT0SeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715854157; c=relaxed/simple;
	bh=F3slW8z/pG6jXGw2Nj66+rGuDpnvI8DlslsaiUUIUqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f8d2nBYTeKKwuvpGHyGE977/F0gP9Hz/KUs6FHDboVTfi+n5pxZvCAZ8w4EeIX4z4RgCkTlm7FdbVIS0cQqmOHX9Vd4Xrb7rJcIBt19v1pb9r6M791B6dlA7BCZBb1DMAzGg4Si5CgusAmR+6YxHGYRs5CRVuG7IQ4cDVx+8/XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8Sfsz2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5A7C4AF0A;
	Thu, 16 May 2024 10:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715854156;
	bh=F3slW8z/pG6jXGw2Nj66+rGuDpnvI8DlslsaiUUIUqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Q8Sfsz2iYbXDPx2R+fGgQk/+AusJBcYPcrvEHLkMgHbWUXyKKzNHdfI+kS7qpp/u5
	 /IK3MsA2GTohcksDV9eGLmHJwUWUZ1DAA8Cw7FCKQIl4+vOA3HaBxsdn7O/ZmtDU3p
	 6t0YrdFpcAjESfaGmY1SHQ1WEGnBlnnn2QQXlT697pn/QRpeZn9LDmJgBLCzUWhbN8
	 IgnqsJE85stF+gbph7siYZTstzl7a43YHw+J/YlkLPSFk3UzezZzgo6kaHMYKWgZC3
	 ZcmEVYFpj+/4zANNCohbsDeII+Vq0nCBX627a/xjaeYc/Cxs4uMg4W/xV5RzCqAtzY
	 J87zLWi7KJ75Q==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c99682a7cfso2195b6e.2;
        Thu, 16 May 2024 03:09:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVnCZAL9A0kC4vMA1av0Q198mGh9j4OJQODtf24kg7bqfWJN8hKxkDE4zVsNAe/osKjLrmzBv4jEjDOYP4JOkwhENA1q4inEWj0C+pyacx+Cq540dcOtYSxSKay3Y1mQqO4yO0nj1jOXA==
X-Gm-Message-State: AOJu0YwUHmhYQNp7U6GgG4pZlZVFmPzLH3vTQ954UCvMAY3nsS81zNBr
	24g47tukwGuL/XsZbdI4CaV/oLK59fhNSVaVaFO4u57/eauep3IwjsBaj+kTys0giy+5XmQURt4
	3DjR5oK+ldaiHbKleLj63g7yjgQ4=
X-Google-Smtp-Source: AGHT+IHruOoabur5gc7PsQr1i3keJcLfUy3nS6jhBV1muFUchmQW5j7szKL2lb7hjI6a/JCA321moEBxskcKZhyST/g=
X-Received: by 2002:a05:6870:96a5:b0:22e:6e96:ed41 with SMTP id
 586e51a60fabf-24172a337f1mr23246965fac.2.1715854155779; Thu, 16 May 2024
 03:09:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12437901.O9o76ZdvQC@kreacher> <5161bd95-d51e-49cc-bcbd-523fbb747e4b@redhat.com>
 <CAJZ5v0gf-oLcjT8dxnpjAyVfpUep5ST2mHDJy2dySBGCJwjMxg@mail.gmail.com> <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
In-Reply-To: <b53b4fe4-e3b7-4939-a8ea-9eb55f0bece6@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 16 May 2024 12:09:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i+ejMyj0j7RvVY7+g6eU8bQ9QLG=08fm78i9Ui1fEiVA@mail.gmail.com>
Message-ID: <CAJZ5v0i+ejMyj0j7RvVY7+g6eU8bQ9QLG=08fm78i9Ui1fEiVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ACPI: EC: Install EC address space handler at the
 namespace root
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <w_armin@gmx.de>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 16, 2024 at 11:50=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 5/16/24 10:37 AM, Rafael J. Wysocki wrote:
> > On Thu, May 16, 2024 at 10:35=E2=80=AFAM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>
> >> Hi,
> >>
> >> On 5/15/24 9:39 PM, Rafael J. Wysocki wrote:
> >>> Hi Everyone,
> >>>
> >>> This is an update of
> >>>
> >>> https://lore.kernel.org/linux-acpi/5787281.DvuYhMxLoT@kreacher/
> >>>
> >>> which was a follow up for the discussion in:
> >>>
> >>> https://lore.kernel.org/linux-acpi/CAJZ5v0hiXdv08PRcop7oSYqgr_g5rwzRT=
j7HgdNCCGjXeV44zA@mail.gmail.com/T/#t
> >>>
> >>> Patch [1/2] has been updated to avoid possible issues related to
> >>> systems with defective platform firmware and patch [2/2] is a resend
> >>> with a couple of tags added.
> >>
> >> Thanks, the series looks good to me:
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >>
> >> for the series.
> >>
> >> I assume you are going to send this in as a fix for 6.10 ?
> >
> > Yes, I am.
> >
> >> In that case feel free to merge both patches through the
> >> linux-pm tree.
> >
> > Thank you!
>
> Hmm, I just realized that this:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x8=
6.git/commit/?h=3Dfor-next&id=3Dc663b26972eae7d2a614f584c92a266fe9a2d44c
>
> Is part of the main pdx86 pull-request for 6.10 which I'm going to
> send to Linus in the next 10 minutes or so. So that is going to
> conflict with your 2/2.
>
> Options:
>
> a) You only send 1/2 upstream as a fix and I'll then send a rebased
> 2/2 upstream as part of the first pdx86 pull-request.
>
> b) You merge the git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/plat=
form-drivers-x86.git
> platform-drivers-x86-v6.10-1 tag (which is the tag for the pull-request
> I'm about to send to Linus) and rebase on top of that before sending
> a pull-request for both to Linus.

I would rather wait for Linus to merge your PR and merge my changes on
top of his merge.

