Return-Path: <linux-acpi+bounces-5755-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 717908C299C
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112B21F21B1D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC621CF83;
	Fri, 10 May 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P40Vv7Vv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C005A1C6B5;
	Fri, 10 May 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363817; cv=none; b=ByGiUgu7C0ERFAigKCQZONTvZ/bMtEXYEH3NHmvloLmMQaUXC8nod82AFwDFKEmqProY/Np8ggk8ITuPJ7hrP7r7HCoiWR+dkF56XktPI2ZTQSInR3DvNoXFfhFXjpG0kNDjOgsYrBNGr+QPa1OLnS7Q0xSpEEj8nnMQtkZqa1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363817; c=relaxed/simple;
	bh=+w26PJ5CXkIE4/kJJPQ3AYbBbLiTeT3yUcR/oQxpC9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YcGvHJ1bF/1tpVGDl7Vc1pXrMyFw2gxYNvzDiQo1OjC3b+vEAuCo6vdZYZRQkNroDWY3thMcc434e+74l/g7cHeZx7eNR3a+Z0gt7LVbdUQa6Ry53Bp8zbfanX61r55rj9pPbW7+OCtCEhMmG/B4J5uYaqOgmH5YkgXkQGHFNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P40Vv7Vv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A618C2BD10;
	Fri, 10 May 2024 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715363817;
	bh=+w26PJ5CXkIE4/kJJPQ3AYbBbLiTeT3yUcR/oQxpC9c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P40Vv7VvkLNd9o/K6Sh7PCcHuY81Hb37G7ba1jWhx6Lz29N2iazNI/TpP3KMtNKfO
	 vyb/fDZuwTOwANJ7aDToRR2UU7tEXOqMzyHyLxx95sa8ezniPORiXJGJ2gQSDh5VDh
	 E1ver/zGMghn+dqzblyIm8JFmXe07DJupA0mU79gAgsRnTFoIWyKPOn04pRuaEch0b
	 ug7biGJRGM+hdtdZZdFVYPFaEpHKsJ9eQjjZCX0sXzgkq8KjcovUnlfugOynnxvNAO
	 OhIuVxYAKO8//ADT0n2slKeoO9zOly8QkYjaZdDsWgv0G+UgAk8FnKUDz9909mZSXt
	 XevxNScn6rDwg==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f035fb2b03so529356a34.3;
        Fri, 10 May 2024 10:56:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXb1h9WQnhWRc0tJtbuTsz58fEjCzFKCGWChRMBYf1XXWkO55SomV37oCkQA5CIveKU9uDLP7122uA3Bi9sgy637t/XNi1um8zpJip3XvfxK5Ptx4vb7HL8spkzN+x/QbjevOwA3E0EfA==
X-Gm-Message-State: AOJu0YxFyE98qpAYPqQjRPU08awP+QByTbvqBklWc5VAiNorgCZlxX1a
	SDt6k7v7WKqADsdAVICRNpUQNhcZMA6icL5oKN2a64dbkXhNThn1SbH/yaMgOR8EIkGSulAtR9+
	KEo/Z7/csDx3l+Rqbb9ZZIxjE66g=
X-Google-Smtp-Source: AGHT+IEWJo7hDTOwQ65hwRfCHYAJTW5TmP4Rbew4jLpG6t8WcF/FHXd/Q8cY6FktXSj0sXYbLv29O6Y1SM7fxRR2NSU=
X-Received: by 2002:a05:6808:f03:b0:3c8:2af6:1125 with SMTP id
 5614622812f47-3c997036e42mr3775699b6e.1.1715363816590; Fri, 10 May 2024
 10:56:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de> <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
In-Reply-To: <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 10 May 2024 19:56:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jY2wu4Hjea-MPgVaVYkuqLoEF0-dOJw_kkjShHyBoMww@mail.gmail.com>
Message-ID: <CAJZ5v0jY2wu4Hjea-MPgVaVYkuqLoEF0-dOJw_kkjShHyBoMww@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 6:52=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>
> > On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
> >>
> >>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>
> >>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Lenov=
o
> >>> IdeaPad Pro 5 due to a missing address space handler for the EC addre=
ss
> >>> space:
> >>>
> >>>    ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [Embed=
dedControl] (20230628/evregion-130)
> >>>
> >>> This happens because the EC driver only registers the EC address spac=
e
> >>> handler for operation regions defined in the EC device scope of the
> >>> ACPI namespace while the operation region being accessed by the _DSM
> >>> in question is located beyond that scope.
> >>>
> >>> To address this, modify the ACPI EC driver to install the EC address
> >>> space handler at the root of the ACPI namespace.
> >>>
> >>> Note that this change is consistent with some examples in the ACPI
> >>> specification in which EC operation regions located outside the EC
> >>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5),
> >>> so the current behavior of the EC driver is arguably questionable.
> >> Hi,
> >>
> >> the patch itself looks good to me, but i wonder what happens if multip=
le
> >> ACPI EC devices are present. How would we handle such a situation?
> > I'm wondering if this is a theoretical question or do you have any
> > existing or planned systems in mind?
> >
> > ec_read(), ec_write() and ec_transaction() use only the first EC that
> > has been found anyway.
>
> Its a theoretical question, i do not know of any systems which have more =
than
> one ACPI EC device.
>
> This patch would prevent any ACPI ECs other than the first one from probi=
ng,
> since they would fail to register their address space handler.
> I am just curious if/how we want to handle such situations.

I'm not worried until I see a system where that is a problem.

That said, it can be addressed by adding a first_ec check around the
address space handler registration/unregistration.

