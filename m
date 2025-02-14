Return-Path: <linux-acpi+bounces-11201-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CCAA366D1
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 21:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C54E16FBBF
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Feb 2025 20:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4403F19258B;
	Fri, 14 Feb 2025 20:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC5l64CT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186AE19066D;
	Fri, 14 Feb 2025 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739564526; cv=none; b=bY5omDHr2nBzFxUq48hhjOtmOzubjH0Ua7rWDFFbvEurQryl/CG9iXBAEp3n+USr5Q+W5bFwq4BerJhaltcgk6AR+9Umtt/z9LU17yL18gYjKTagvWfs+eL+o6gmB16l3vGSVRaqQvnsHtEQXnA2S2sVT5bofdcNyNDKs8Oldt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739564526; c=relaxed/simple;
	bh=1V7cvRrDBCKZmbki793VHS9b7cxIjb5kzH35XSGmoKE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbhURlnJg74njOodw94VlKvCY4+rDRNFvAPAZ8anhRdCUcgLOis7YLM6SwIBQ+Sa0WVnJGyEfvlLpD45dS3/WQyNof0o2cJkn8LtL2Kywu+goUMSxlZDE3KHXxMm6xaDB3gicjdLl6BE8/UD5qZQaytEVvgX5rAca7+uVOAGo30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC5l64CT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D260C4CEDD;
	Fri, 14 Feb 2025 20:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739564525;
	bh=1V7cvRrDBCKZmbki793VHS9b7cxIjb5kzH35XSGmoKE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iC5l64CTZfThIfw/CwrCgbFpAmq9Yiy1WQNL5Ohn7RMKMspHh0J5Gjiq9Yww5nCOE
	 aO+nNM4DDTIYsKhkUK05DYidqJnhTYfwdEek/DrDIFCCP3PQ/JyZqnfTrzEquoeN9L
	 Jqghd6pJQuwbbA7UoW3zJX6Ayiu68Xk6fWXMmLPyJucpab8mibGE3yFM8vJmRt9sGY
	 U+bsmTgX4n4u6tWP/guXwjJc6MkS+bs9JtG2OBPbUEVMVOXuXKJMMdD6MII8H6ug2x
	 Xr3hBX7NvT+HqHIhKGdCqo/JjSs2ulxxY2RVR7+EsBwRxMrFzHxRgsSzIQExvEc+00
	 M7XHxEHUudYFQ==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2b8e2606a58so1251574fac.0;
        Fri, 14 Feb 2025 12:22:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXhqn410eXqT5LZ8GHZ7e3D7kup/mHKKlRCCJWtVoJlbfpaUJlPAZDAmqTvv2qHCQx/nQ5KCNlNgdw@vger.kernel.org, AJvYcCWPRhohgCGZAFOze3mlmyShefVLCgI7AUcCyKZUuMSVE1+e4uYtOR29CyYKqRL/ssg8tv/SpwVgfxbzaI5f@vger.kernel.org
X-Gm-Message-State: AOJu0YyplpVX4chxNPfD3Kkhrb87bONDqD8+yqTGB/0vfuprLaGR3EGQ
	O7GcJEo6/ROAWvibYn2tW/5NFTsE5bA9CbHwHEFueHSX6EKfp9OzpWtD3zJYQjU1e/kccmBgPad
	zWATczGhHvDgy5RqsByxqML1srkY=
X-Google-Smtp-Source: AGHT+IFe9EtaS2cXc9jG5FB+Lqd7giY07d/UZzAhghPMmRW2fZwZ6dsjKfEoIMGicCXyuv5tFHithfFjoLDJF5O1JXI=
X-Received: by 2002:a05:6870:3d93:b0:2b3:55b3:e38 with SMTP id
 586e51a60fabf-2bc99b4b057mr290385fac.21.1739564524845; Fri, 14 Feb 2025
 12:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250125100711.70977-1-josh@joshuagrisham.com>
 <77eb01a6-2905-4776-96ce-eb936c04956b@gmx.de> <CAMF+KeZrdkfwoab4zvBYJMuYaScCDFPbvijo9o6d-9CS96238g@mail.gmail.com>
 <0053b236-79cc-496d-936b-5f8b12b39f10@gmx.de>
In-Reply-To: <0053b236-79cc-496d-936b-5f8b12b39f10@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Feb 2025 21:21:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hMpyANvOgGS8fbWWEZKw+ND-7uwYYfGsHesWLkoPd6FA@mail.gmail.com>
X-Gm-Features: AWEUYZlqT3QzvCztNNjU-FHFVVo7W9x2uLfMsql19O2I-Xb8v2ZX7kkIZAmgrCY
Message-ID: <CAJZ5v0hMpyANvOgGS8fbWWEZKw+ND-7uwYYfGsHesWLkoPd6FA@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: fan: Add fan speed reporting for fans with only _FST
To: Armin Wolf <W_Armin@gmx.de>
Cc: Joshua Grisham <josh@joshuagrisham.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 5:47=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 06.02.25 um 08:37 schrieb Joshua Grisham:
>
> > Den tors 6 feb. 2025 kl 06:05 skrev Armin Wolf <W_Armin@gmx.de>:
> >> Am 25.01.25 um 11:07 schrieb Joshua Grisham:
> >>
> >>> Add support for ACPI fans with _FST to report their speed even if the=
y do
> >>> not support fan control.
> >>>
> >>> As suggested by Armin Wolf [1] and per the Windows Thermal Management
> >>> Design Guide [2], Samsung Galaxy Book series devices (and possibly ma=
ny
> >>> more devices where the Windows guide was strictly followed) only impl=
ement
> >>> the _FST method and do not support ACPI-based fan control.
> >>>
> >>> Currently, these fans are not supported by the kernel driver but this=
 patch
> >>> will make some very small adjustments to allow them to be supported.
> >>>
> >>> This patch is tested and working for me on a Samsung Galaxy Book2 Pro=
 whose
> >>> DSDT (and several other Samsung Galaxy Book series notebooks which
> >>> currently have the same issue) can be found at [3].
> >> Any updates on this patch? For me it seems ready for mainline.
> >>
> >> Thanks,
> >> Armin Wolf
> >>
> > Hi Armin, thanks for checking in on this!
> >
> > For me I have no further updates that I planned or intended to send.
> > If it looks good to Rafael or anyone else who wants or needs to review
> > then I would be glad to see it applied.
> >
> > If needed then I can re-send with Armin's Reviewed-by tag inline in
> > the commit message but otherwise everything is as I would have wished
> > it to be, for what that is worth :)
> >
> > Thanks again!
> >
> > Best regards,
> > Joshua
>
> I was hoping to get Rafaels attention so that he can give your patch a cl=
oser look.

I'm a bit busy with other things ATM, but I'm planning to get to this
next week (and to a bunch of other pending patches for that matter).

Thanks!

