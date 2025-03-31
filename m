Return-Path: <linux-acpi+bounces-12563-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BC3A76AB8
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 17:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AE31882E03
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DE8219A80;
	Mon, 31 Mar 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MLnGXAip"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2E2147E6
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433264; cv=none; b=dpWL/IUs1ZIcYp+feNpJtDQELyI+MBe7a8GutD6AWOjJw/Cl06SysaU2Utuo2p0cndGybwx0v52cE+vaq1XdraMWVxHXDOBZRyUnObkc+7F+4GKRKaeqC79vTILKEtMicusMIGeZ1PkHpHK1KHKI4JT2y/21oJD8E8TyhIZLFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433264; c=relaxed/simple;
	bh=nf0PPTSPlA35pdFIe3oEH+O1qPU+3Rk8Mnd2glNzOgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VCNnckYq2+04TN/BYKrC7gvrAqYoUss/inhTM+YXD47yBa1ZhrcDa1awSTfkeedrrbo/gK+aEOiFHEbRCuC/WlOqVfLgd4oIYjoemec50HsNFyfM/9dB7yYZErxgdB5FC8ZUFEg1Peq//bdLP3DAZe+sCk3XPitAAjIek1wM2tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLnGXAip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CABC4CEEB
	for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 15:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743433264;
	bh=nf0PPTSPlA35pdFIe3oEH+O1qPU+3Rk8Mnd2glNzOgQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MLnGXAipC8F/DAe5xcmtL+7o+G5XUkTyakgoR8OYL3pa9Sahpm+G2fQRE+Z7jxXts
	 aoNz+ODjjLcQ1anwO6M5OuFa1PJEdBYywJo2Ov8qYEIcv30sDqr/j2iSkm1mPKNKtt
	 q1sZwdOoRBEtxJQHj2jgP0EMcvxwu6reQ4b3iJiwWE8Byf4P/StBDB2fJIrHmLsR6H
	 y82TsfXxWYq4LnNPh1HLNSt5YADrs9QydvCAGvzstSzoqUBhWcB8pGSAeWSoB/ja7r
	 ncw5MFhzYpQXXrAJ8NYSqSkbq+PV0eC3ui9Uays7aI+ysEI/mwfML86+8gwAh4tju4
	 p06r+P4O053ow==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c769da02b0so2811601fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 31 Mar 2025 08:01:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlDc9nrl9kX++rMixFkWCgLNlollZBaeunZF5yp6A4kDOyDqswPv26GC5xblQDNwkHG6ibUUW1hLRy@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGLV2POHl1iqDirl4gTKnMq5XQ30tKooKhYDoitxeqq41ycGL
	C6iQHmZk57OCNz3kBN34qQ9c0t3SPfwIAFk3eZLoT/FqgVj0MKFNqUuZyBrFkZyeAUZosayvLa7
	0QC0sTx5pcTbmSQwKWd0HNBna+YY=
X-Google-Smtp-Source: AGHT+IEQ8oSMvzCI9xa1wj+m9lUaCMsXY2wdtPGQTkqxpiLEs9vdZy5v/Z+p9CRxlFf7HAZzYj962orKZl9XF7rTgEs=
X-Received: by 2002:a05:6871:9185:b0:29e:27bd:69ef with SMTP id
 586e51a60fabf-2cbcf6c812emr6064712fac.30.1743433263532; Mon, 31 Mar 2025
 08:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331121836.2495903-1-sakari.ailus@linux.intel.com>
 <CAJZ5v0jGCaJLTka57nB6mx4VDxZJUBVBbGV=7HdKKpf+7jCvjw@mail.gmail.com> <Z-qaOXTRS7z_He62@kekkonen.localdomain>
In-Reply-To: <Z-qaOXTRS7z_He62@kekkonen.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 17:00:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
X-Gm-Features: AQ5f1JpcleE86v1amHw2mwBSlVGFHJFbHr-cr91s1tWl7YjqhGGhKBOQytFhhBc
Message-ID: <CAJZ5v0gaDSAS6rgKxtOVgz+kSYVNvG2--o9kR40BKt5Z6Barog@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: property: Fix REF STR... reference parsing
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sakari,

On Mon, Mar 31, 2025 at 3:35=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Mar 31, 2025 at 03:19:07PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Mar 31, 2025 at 2:18=E2=80=AFPM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > Restore parsing of ACPI data node references consisting of a device n=
ode
> > > reference followed by one or more child data node names.
> > >
> > > Fixes: 9880702d123f ("ACPI: property: Support using strings in refere=
nce properties")
> > > Cc: stable@vger.kernel.org # for 6.8 and later
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > > Hi Rafael,
> > >
> > > It seems that support for REF STR... references got accidentally remo=
ved
> > > when pure STR reference were added. The former are documented in
> > > Documentation/firmware-guide/acpi/dsd/graph.rst .
> >
> > It would be good to provide an ASL example that is not parsed as
> > expected before the change and will be parsed correctly after it.
> >
> > Admittedly, I can't quite recall the history leading to the above
> > commit, but this paragraphs is present in its changelog:
> >
> > "Also remove the mechanism allowing data nodes to be referenced
> >  indirectly, with the help of an object reference pointing to the
> >  "ancestor" device and a path relative to it (this mechanism is not
> >  expected to be in use in any production platform firmware in the field=
)."
> >
> > so the change in question appears to be intentional rather than acciden=
tal.
>
> Right. This still continues to be documented in
> Documentation/firmware-guide/acpi/dsd/graph.rst as noted in my previous
> e-mail. A sample ASL snippet is can also be found in the same file. I onl=
y
> noticed this when I tried to use such references.
>
> The other option indeed is to change the documentation and hope no-one
> depends on it.

I thought that this was the original plan.

