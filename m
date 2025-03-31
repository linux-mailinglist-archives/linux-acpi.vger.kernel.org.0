Return-Path: <linux-acpi+bounces-12565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B5A76AF8
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 17:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAC916C477
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EF21A45F;
	Mon, 31 Mar 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smQiHig/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52018219A86
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 15:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435363; cv=none; b=mc2vzoBFaenebWqkOPaAIM5taNMziw1gQywErVIrZnYRPovKEB40n25RX3XIf2jIWdvj+3bY8ZriAC7wEqLwpC7Gw4I/X42BHd35PjGlGhAdX6omfQJHDtjkpoVOg/Y1BENMS4FeeAzDf8ry62EWW990Y46D1Y7MFyc+cO9lUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435363; c=relaxed/simple;
	bh=ikfX125BpzT4M/C6i6FPiR7L18XoA/okkaJp+4sDuP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3Xnvi9sVWL0GonyUy6TUkgvriPtMlOy7tazAJjh0xqraH5PNcj2rCOfDZ3/181kYJ6dCAw7QyU04SYjCHtd1zXusOhPL/hiYlKfJv5uNfY0SaLXaYQc7y8rCrmZgbOLv+1qNoiKyJXmkyygZjopUB6JDn2UnoeKZczp47zFPlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smQiHig/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B41C4CEE9
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435362;
	bh=ikfX125BpzT4M/C6i6FPiR7L18XoA/okkaJp+4sDuP8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=smQiHig/gcKKgY+4DRyxitI7U+lVB/Uik1QAkOsaQQJeiN+rJhQtz99p1r7wQ+fRh
	 lb8fRxo/I6XLIb0XOUwMfwyTFxfc7k7RB6Ok9BKyg6kr/OyX1/vmXALfqVi9WgktQF
	 Rxf0kDS1wCPtt96eZvPoxEa8QTNuz/rxgI1vW4xwGq6ID7WM7gYxTXrxZV5zJxqVYQ
	 5pQ2f9nM1cNVBiA6u6ZrblWhwuy+5kj5JU3o1Y/p3cgxIRtpoob9gwBvt81U9WgRNy
	 +yF799cEhHPbABk83JnB7vfElAVzkZjDd65VQnGoJeK+3jn/XNycSzxZIHLEEwaBb9
	 Tb6nHofqYh2+g==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-601ff283d70so1370228eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 08:36:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPm1HXguVmlZ1Oe5bYCenoGPuB45i0VlHRN/UKU9I9FZ/ErsnRgDNkRXs2FmzKhIe1HAKtwetnin6B@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmMZM5Z6hQflYWgLRdXxGXtnqa/946vKfU8oCohDXWHMiw9RO
	qOsXOIkrJl+X/DP6zrK6qnOFIb63F0p0f6BQIT9AuFMPCetobIKiEVXus5FOu7vLt14fXwIUlIN
	dMSyhLBg6jubG0mXKzCY3isozVfY=
X-Google-Smtp-Source: AGHT+IFjh9XLO8DcMseNcdQdw/yjy1P7wSkBVOrwoU1S2DTKrtcNOAmIj3/vKvyA/xnrn3YbfW7TZOTxn6iwHjYhV/g=
X-Received: by 2002:a05:6870:9e45:b0:29e:2bbd:51ba with SMTP id
 586e51a60fabf-2cbcf515fcamr5791675fac.9.1743435362154; Mon, 31 Mar 2025
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com>
 <Z-qaOXTRS7z_He62@kekkonen.localdomain> <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
 <Z-qwRpddAZ9Upi6r@kekkonen.localdomain>
In-Reply-To: <Z-qwRpddAZ9Upi6r@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 17:35:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i=h1AQm5LVDj4m6X+oEh=3AQ=jMAMr+p6=K13AP73C9w@mail.gmail.com>
X-Gm-Features: AQ5f1JoOzlJ4MP71yLcCG7Ga9MW28gqZj5M89-rD0vPyTvhtrh2nl82U2-W4YMw
Message-ID: <CAJZ5v0i=h1AQm5LVDj4m6X+oEh=3AQ=jMAMr+p6=K13AP73C9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Mar 31, 2025 at 5:10=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Mar 31, 2025 at 05:00:52PM +0200, Rafael J. Wysocki wrote:
> > Hi Sakari,
> >
> > On Mon, Mar 31, 2025 at 3:35=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Mar 31, 2025 at 2:18=E2=80=AFPM Sakari Ailus
> > > > <sakari.ailus@linux.intel.com> wrote:
> > > > >
> > > > > Restore parsing of ACPI data node references consisting of a devi=
ce node
> > > > > reference followed by one or more child data node names.
> > > > >
> > > > > Fixes: 9880702d123f ("ACPI: property: Support using strings in re=
ference properties")
> > > > > Cc: stable@vger.kernel.org # for 6.8 and later
> > > > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > > > ---
> > > > > Hi Rafael,
> > > > >
> > > > > It seems that support for REF STR... references got accidentally =
removed
> > > > > when pure STR reference were added. The former are documented in
> > > > > Documentation/firmware-guide/acpi/dsd/graph.rst .
> > > >
> > > > It would be good to provide an ASL example that is not parsed as
> > > > expected before the change and will be parsed correctly after it.
> > > >
> > > > Admittedly, I can't quite recall the history leading to the above
> > > > commit, but this paragraphs is present in its changelog:
> > > >
> > > > "Also remove the mechanism allowing data nodes to be referenced
> > > >  indirectly, with the help of an object reference pointing to the
> > > >  "ancestor" device and a path relative to it (this mechanism is not
> > > >  expected to be in use in any production platform firmware in the f=
ield)."
> > > >
> > > > so the change in question appears to be intentional rather than acc=
idental.
> > >
> > > Right. This still continues to be documented in
> > > Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previo=
us
> > > e-mail. A sample ASL snippet is can also be found in the same file. I=
 only
> > > noticed this when I tried to use such references.
> > >
> > > The other option indeed is to change the documentation and hope no-on=
e
> > > depends on it.
> >
> > I thought that this was the original plan.
>
> I wasn't aware of the plan. But given that no-one has complained yet,
> there's a fair chance no-one will. I can post patches to switch to
> string-only references.

I think that it should be sufficient to update the documentation so it
does not describe the indirect mechanism mentioned in the changelog of
commit 9880702d123f, shouldn't it?

