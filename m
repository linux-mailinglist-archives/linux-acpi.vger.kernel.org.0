Return-Path: <linux-acpi+bounces-6529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F330990F540
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 19:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7981B283375
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 17:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A86153578;
	Wed, 19 Jun 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Le+a4d6X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E191E87B;
	Wed, 19 Jun 2024 17:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818688; cv=none; b=AwLhtB5tvjwcu0PTYIuG3EUggCIzUJGWvLHnxKKWWYWDpC4zvNqRxJZ5hbZmEyPXN27ULXcl9eZ/zJ6/OLS0mr4Uy/gLQ34KcVa7XLs/U4+iCyGD6N/BPzhYgUc09PMjm1F7EmrftgwDrVj3dEykru5WdNvc8OzoYCP9zLTJ1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818688; c=relaxed/simple;
	bh=iz/AlobMihennDLjDBSOB3b35KqGkqN9E21I5uCLbNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhXySxd3Lrgf6Z6idAs54gwiTRRDgVzUoUb9bpQxAKpnriF1rBYNuzm9DoIFtaUJTI7LWA4swvVt7OwGwYOBC2KgKFtLvkqUfEhmN+kLqB2V/uE4vvP8tV9Awh5IlHiHy+87KBXCYdR63nZ50/mDUwW+CA2S7UKCf734fNxXRe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Le+a4d6X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629A8C4AF07;
	Wed, 19 Jun 2024 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818687;
	bh=iz/AlobMihennDLjDBSOB3b35KqGkqN9E21I5uCLbNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Le+a4d6XOT2mw/pNmzI6yNAQ565QV+A65DXkf9rKFrLZ6vKcA7iZK5EnICkKjaAeA
	 Vez5fLEgf+XaLYbMDuzRyZV9+BBJZNYtDyCfQtp2Bna6e7D5j63lRxMDHV82iYeqS5
	 h0CBKc056VcnmxFwWlAX5wejUmvny84OMpRmZiVboNX1YfFihovBWZGrgqICuwoQ4I
	 /7tLlUJTLeUY/OVO1U5OZ3Cpv20D2QUPQekwZZOETV72RACKBiCbZ/tFEurr4jjj3z
	 S4TZYwFXFIvkYJ/47uZcBzq7xi4LtxmOW7pEcvE0Pfk+joOTUjhQhfXzixqUWSxFmC
	 zHsi1RixFavsg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-250495bcd4fso11727fac.1;
        Wed, 19 Jun 2024 10:38:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/bgdyiLLVkS80c7cTWfmSPTgcr5q/l0FynLfJUxnq7+4tJNdmsK0rBksPNd/Q3IN3ImvfRjxu+q75YoIKamodqAF10DhPbPR9cvUp5khCEKm/aFn3qT5NZVXM0wL38HndMEGcv6dX+A==
X-Gm-Message-State: AOJu0YylucEMycTn02bUf4Gfn+WvHR6/poYpP5g+vY/l5PEZw2D8sFSe
	WxsksjkaTrDShY+BkcOZUk7z9QDXn/MBOsFNk0AM57fMY2GRQzQ8oaD0ky1DG2bC00VUeRI1ggq
	9IBT+l/Y5MyJENICEneCiI7gEEZA=
X-Google-Smtp-Source: AGHT+IG0du3j5OyoqixERvV/INjfz12gnUdz/oMKsTF6nME6C7Tb5XoO+0l4Fy63xxjb61+Jmf1ZsmRQbzsC+dYQiqA=
X-Received: by 2002:a05:6870:d154:b0:254:ecbd:1815 with SMTP id
 586e51a60fabf-25c94e406ecmr3336486fac.5.1718818686669; Wed, 19 Jun 2024
 10:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7790c74-2bec-4a24-b6e5-223c4e1ed372@amd.com> <ZnHXfLEwk2uRbg58@kf-XE>
 <b4d65232-b69e-419d-9b15-d0ca64b78b26@amd.com> <ZnHfNbLTgY1op3Zv@kf-XE>
 <fb8c965a-5f1c-4975-8e7d-6f6a0eb4d02f@amd.com> <ZnHtPbszYT8afOOk@kf-XE>
 <c6bda238-166e-4de6-b0c7-4bddfb8ef6f4@amd.com> <ZnIAX9P5XSco4cZw@kf-XE>
 <ZnJfmUXmU_tsb9pV@kf-XE> <CAJZ5v0gOBH7OKF3KXwxYfWkGkC45rzDguR4VmSnoZDKpm+KPSg@mail.gmail.com>
 <ZnMWnkR64Q-iq-4L@kf-XE>
In-Reply-To: <ZnMWnkR64Q-iq-4L@kf-XE>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 19 Jun 2024 19:37:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hAR4ai5KjdF5vDtKOr_2Cngi9WCAi=g_JD_SXenuok1Q@mail.gmail.com>
Message-ID: <CAJZ5v0hAR4ai5KjdF5vDtKOr_2Cngi9WCAi=g_JD_SXenuok1Q@mail.gmail.com>
Subject: Re: [PATCH V3] acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
To: Aaron Rainbolt <arainbolt@kfocus.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, 
	mmikowski@kfocus.org, Perry.Yuan@amd.com, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:34=E2=80=AFPM Aaron Rainbolt <arainbolt@kfocus.or=
g> wrote:
>
> On Wed, Jun 19, 2024 at 07:09:35PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jun 19, 2024 at 6:33=E2=80=AFAM Aaron Rainbolt <arainbolt@kfocu=
s.org> wrote:
> > >
> > > acpi: Allow ignoring _OSC CPPC v2 bit via kernel parameter
> > >
> > > The _OSC is supposed to contain a bit indicating whether the hardware
> > > supports CPPC v2 or not. This bit is not always set, causing CPPC v2 =
to
> > > be considered absent. This results in severe single-core performance
> > > issues with the EEVDF scheduler on heterogenous-core Intel processors=
.
> >
> > While some things can be affected by this, I don't immediately see a
> > connection between CPPC v2, Intel hybrid processors and EEVDF.
> >
> > In particular, why would EEVDF alone be affected?
> >
> > Care to explain this?
>
> From what I understand, the EEVDF scheduler requires ITMT (which in turn
> requires CPPC v2) in order to determine which cores are performance cores
> and which cores are efficiency cores. When CPPC v2 is missing, ITMT is
> also missing, and the scheduler no longer can figure out which cores are
> which. Thus on a system with many efficiency cores and a few performance
> cores, there's a pretty decent chance the scheduler will put an intensive
> single-threaded load on an efficiency core rather than on a performance
> core, which has obvious performance implications since efficiency cores
> are slower than performance cores by design.

So the above information should go into the changelog of your patch.

> A good example of someone else hitting this issue can be seen here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D218195 This issue was broug=
ht
> onto the LKML here:
> https://lore.kernel.org/lkml/a106fb4733d0a3f0d6d5792705cdb5cee13731f8.cam=
el@linux.intel.com/T/
> Srinivas would have more info here, but I do not have his email so I can'=
t
> CC him on this.

OK, CCed.

Now, please check the patch I've just posted in this thread:

https://lore.kernel.org/linux-acpi/12457165.O9o76ZdvQC@rjwysocki.net/

