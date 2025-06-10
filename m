Return-Path: <linux-acpi+bounces-14275-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C36AD40BB
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 19:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C223A869D
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 17:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E582459C0;
	Tue, 10 Jun 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSj0B1X1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D738B23D2AD;
	Tue, 10 Jun 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576307; cv=none; b=XkAjJc0ZiF/0YS4J6HPiyALxetzo+zvpM0qDDRbQI2aWB3vz5suXlyMIeSlHNozjnKsS4OHep0JsqQsyyb9Ndm21uWzrnUJ1Oz7CrqaTS0huSvCAjP/OM6gLnF/2xzaHKCz7eEMSL+6F+3QNB1gWNY8WtsIdVlw7XKC9zzK9A9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576307; c=relaxed/simple;
	bh=MPcuZKzljMNfFsP9ma+RyN5f+qoJiv1ddnZJsLMq3/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6s+IpJ3W7BtVQA0qoFSZP0cBIsm3bvWOjpd17XRkapbgZuWfUTVSj1fVv8WIDM9K9w2GtVRdtGrNjCHbdqpoLdVVEK+gixHxgC37QybWPGEqHUSM3j6ew6YxffPO4kaOpJRHPFR8SNrJS4QTkF6Pr7p5kcI3SMmp1MmpQggu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSj0B1X1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6166BC4CEF3;
	Tue, 10 Jun 2025 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749576306;
	bh=MPcuZKzljMNfFsP9ma+RyN5f+qoJiv1ddnZJsLMq3/M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qSj0B1X18+pz0K9vxzzIMRgU/A562wSsLoipmcb8t489Z4inREJijBXI6CGiYDkim
	 LUb6NHoGJWOQNXuopz7ZvzA/h5W8Eokfg42ZajHeTMhE7r1Dn6CbwVDMDp4FsH+0kM
	 pkfiqUsAfZwdSvnuHEX+2IYLg1pVYoI0aiodOCEHalaI+7Pth+XLFKau2XAWfyjGs9
	 mF0pGG4uOig0oWBIFKzZXnnlzkJcxgvnBaOLlyfG7Jl1oqK4Fy2LbEQSUeRFC758v8
	 KJQA7eCf98x+6dQuxuBtWYHhHT0Nsz7pNg93TqNRW1s05dZg3saJTlJCbEtAxtU3e6
	 CMpKsOdw9gOaQ==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2ea35edc691so882283fac.2;
        Tue, 10 Jun 2025 10:25:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4qxVqwA9IT58vMtBYPRaXSeTVNX6IP0gpxxsycoCjc0oxUKB7NRPq0M2mJPsuuFTjshdslMXjyYYf@vger.kernel.org, AJvYcCVHMM6UkSQq98IUnlEXa7mKcGeWZEmSpw5/rn4sN4DOgY6m2ofvUxvr+QlMZvbRyBxPn/G8gQDtYxPp@vger.kernel.org, AJvYcCX5mpZHWqwNOTpt6ev0uu7nLC/eYIjOgYC1NvYID0QSJdB3VqxICVxxmV0QD4OX1qWtgC4NWfz5UCXDTWzI@vger.kernel.org
X-Gm-Message-State: AOJu0YxpLDOwHBiQ50hVrjXG8hOAEXwqtb30sIIecg/JiRl501xjypP2
	J+BdaV1TJ7+lXYCRdmk454WCKycMLT6H5S4EqcUxrQStc4LcCzlwJ2a2PnXYZhqqzcxbw9H2rbI
	wvMjqRh7gDB1FdHLUmJgvuSaRLa1hon0=
X-Google-Smtp-Source: AGHT+IHSuyQ9u9GSWvfwXykMxjQyvNW1fWmfc6i/jo8EQS81NsO/yigsct9fE6Bcuxt2/rbX1bE0dKnNyrxmUrdbGyw=
X-Received: by 2002:a05:6870:868c:b0:2d5:2955:aa6a with SMTP id
 586e51a60fabf-2ea96a5767amr113820fac.7.1749576305678; Tue, 10 Jun 2025
 10:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
 <2af31ff8-eee0-4868-8f97-2a390910f9ed@intel.com> <CAJZ5v0j5+iB97rTqtOoFB0zpHzNOOHGOQVz51ZU--=4AcUPf-Q@mail.gmail.com>
 <2025061002-reattach-sliced-0690@gregkh>
In-Reply-To: <2025061002-reattach-sliced-0690@gregkh>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Jun 2025 19:24:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ho01XSq9vQi+rMqo41iMbKruH6nLNwxX25KeVbVU7mew@mail.gmail.com>
X-Gm-Features: AX0GCFvvBnCVHG0ASa5OArw3N9QcTiq2HKoQdsqKdjrgJDoIPjc5ljtXQAwFAgk
Message-ID: <CAJZ5v0ho01XSq9vQi+rMqo41iMbKruH6nLNwxX25KeVbVU7mew@mail.gmail.com>
Subject: Re: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load regression
To: Greg KH <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dave Jiang <dave.jiang@intel.com>, rafael.j.wysocki@intel.com, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ben Cheatham <Benjamin.Cheatham@amd.com>, 
	Danilo Krummrich <dakr@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 10, 2025 at 12:12=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jun 09, 2025 at 08:58:26PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Jun 9, 2025 at 5:04=E2=80=AFPM Dave Jiang <dave.jiang@intel.com=
> wrote:
> > >
> > >
> > >
> > > On 6/6/25 8:32 PM, Dan Williams wrote:
> > > > git bisect flags:
> > > >
> > > > 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device inte=
rface")
> > > >
> > > > ...as the reason basic CXL unit tests are failing on latest mainlin=
e. In
> > > > addition to the fix to einj-core.c, this also needs some updates to
> > > > faux_device to make it behave more like platform_driver_probe(). De=
tails
> > > > in the individual patches.
> > > >
> > > > Dan Williams (3):
> > > >   driver core: faux: Suppress bind attributes
> > > >   driver core: faux: Quiet probe failures
> > > >   ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create()
> > > >     failure
> > >
> > > LGTM
> > > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > >
> > > >
> > > >  drivers/acpi/apei/einj-core.c | 9 +++------
> > > >  drivers/base/faux.c           | 3 ++-
> > > >  2 files changed, 5 insertions(+), 7 deletions(-)
> >
> > Greg, I think it's better if I route this through the ACPI tree as the
> > issue being fixed was introduced through it.
> >
> > Any concerns regarding this?
>
> None from me!
>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

So applied as 6.16-rc material.

Thank you!

