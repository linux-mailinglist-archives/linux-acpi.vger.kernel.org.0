Return-Path: <linux-acpi+bounces-11500-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F238EA46BEB
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 21:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8473916F051
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 20:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EED2755EE;
	Wed, 26 Feb 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEE76be7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D62755E3;
	Wed, 26 Feb 2025 20:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740600246; cv=none; b=bL1hg46uO72ChM+WVF4Xw19N4I2tNNlM/Ulj/ncPhKHJJWIQsYclm8r6rKWvjycfizDTjpun1REio0uX7p0h3N80xfjetQRbmdLfCHbQt3L2lhrnn1+xicCUzC6GVKT+J+qoQDDwCc0l0g1kxlwKH2a0MDwjUFwn8gHcIHZseIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740600246; c=relaxed/simple;
	bh=TEzuRaG/DddpK/PHwUH8U2dSWp8EgG9o2fX0TJTsrYY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzxXcsv+YYK9/m7KdS1R0QgQn2SN4aE8E+oqlBkWmVUFnklRUgA9Ru+4bLOIMrd9dExsdJkii65wgqdCeozWf1bEocd/C4Q5gHANxO1mRp04lsNuJuV/0ewjc4pUrnM6+XbJZmOgykALt+5ilvjZsZ9WXTTLzY2yWAiYwHAdxHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEE76be7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23ED8C4CEED;
	Wed, 26 Feb 2025 20:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740600246;
	bh=TEzuRaG/DddpK/PHwUH8U2dSWp8EgG9o2fX0TJTsrYY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aEE76be78Tibfhj5ci/hKGs4cr160aeVv3GfxjB3V4BkxnosKIN1erpbvc6gFnzCK
	 4AUWH6W98DJSGyBkg1OJArSerHeLcb1Un99mpbwmbNbtr53Yorw0mbGsir9HT4nDSD
	 DnB/PISnpoxUXmfUvyCorTMSaiWMnI8OVJyoy/BRImcoqCSniCerKuFo2AStEhgja8
	 yd1M2lbNkJTb9JqPDe17dL6cZfIsPe1Q5ETUo32r+Y3G/p3mHivtSR7RFC+YbFsnO9
	 jIettVdwiuXE24i/0yIR7hHbi8av+j9rvsI/a6qiRCC+5utkpEgEJVsAy7IL9fhMlT
	 YQKeYbMoXbQEA==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2b2b6019a74so127229fac.0;
        Wed, 26 Feb 2025 12:04:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVqtUtB4XyKbx+uVJW3iglfWVr1MvUq91AQfd2l5jECot5b7cerLtyVC4Xum+CKxfA1nWhJhMoujUP7@vger.kernel.org, AJvYcCWVkULl5Wf2SN7STHh2IVJGia9WsYX1UfXrY/1WLb8cjYyw9rSfTdqisBX1oKH+gO+Q5fI1cnClXWhl1a2O@vger.kernel.org, AJvYcCWl6ve5uyKf91HClauzQ5XHTz9DqPVk82Y+fxggZ/ae/6IkuPyPmpgy7ZKZ+fP6GTCNES90af7NwNhpEXPWLZQKHlNTwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyNTCJo17af/lVRq/6ESYDU/iGPHfcp8+gG77hJfKBr1/gZn18p
	cNpdR4NizgbfxacByo5p3mAkuK6n9Uc304j6Uwp1ZejsmTVq6CHSoBLrXbCDbaK8hUkr5Vu/YOn
	1a86ZEycZ/NAZwQWiP6jiS7cWKY8=
X-Google-Smtp-Source: AGHT+IEY2rezCj+Pbf56cexfs6JUuar/OFfeZ7bjGQQUMHfNj2PeunEsDNmFvFqnpJMAQZke7m6gTetAPmzawe0BW6w=
X-Received: by 2002:a05:6870:4e08:b0:296:9c08:51a3 with SMTP id
 586e51a60fabf-2c13083d874mr2859275fac.39.1740600245330; Wed, 26 Feb 2025
 12:04:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224195059.10185-1-lkml@antheas.dev> <1c0c988b-8fe6-4857-9556-6ac6880b76ff@app.fastmail.com>
 <633bbd2d5469db5595f66c9eb6ea3172ab7c56b7.camel@ljones.dev>
 <CAGwozwGmDHMRbURuCvWsk8VTJEf-eFXTh+mamB1sKaHX5DO8WA@mail.gmail.com>
 <9fa91732-3085-4e79-9a8f-b38263ee7d08@gmx.de> <CAGwozwHZCLaVD8iRgRxvQNqw3v+T9J+omMF+JoNe1r=+S1-OsA@mail.gmail.com>
 <CAGwozwEEbsLOJROm7rW-240Zoqh3K_JOtZE_NL8AnLy1eChR6A@mail.gmail.com>
 <CAJZ5v0jpSN_Tq6D3OrRj5KDuXwqVuzcwyNXwEuL90fr=juH48g@mail.gmail.com> <CAGwozwHAKbR4y9cW8H0nmESS7yv6RrXtgcZyEdz1Wy2e8tAdqQ@mail.gmail.com>
In-Reply-To: <CAGwozwHAKbR4y9cW8H0nmESS7yv6RrXtgcZyEdz1Wy2e8tAdqQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 26 Feb 2025 21:03:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ihavOHCzfqMc7nd7HUaxYta7-vBBTo6WoJ3gDduZ6iRA@mail.gmail.com>
X-Gm-Features: AQ5f1JqeNmjFzwNh05J_-uJo8wYCv8v7712qge6zXzFr_hwhPrTT_JCTCea2b8I
Message-ID: <CAJZ5v0ihavOHCzfqMc7nd7HUaxYta7-vBBTo6WoJ3gDduZ6iRA@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: platform_profile: fix legacy sysfs with
 multiple handlers
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>, Luke Jones <luke@ljones.dev>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Limonciello, Mario" <mario.limonciello@amd.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	linux-kernel@vger.kernel.org, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	me@kylegospodneti.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Top-posting not welcome.

On Wed, Feb 26, 2025 at 8:52=E2=80=AFPM Antheas Kapenekakis <lkml@antheas.d=
ev> wrote:
> >
> > What about adding "quiet" as a "hidden choice" to amd-pmf such that it
> > would allow the test_bit(*bit, handler->choices) check in
> > _store_class_profile() to pass, but it would not cause this "choice"
> > to become visible in the new I/F (or when amd-pmf becomes the only
> > platform-profile driver) and it would be aliased to "low-power"
> > internally?
>
> This is what this patch series essentially does. It makes amd-pmf
> accept all choices but only show its own in its own handler and when
> it is the only option

No, it does more than this.  For instance, it is not necessary to do
anything about PLATFORM_PROFILE_BALANCED_PERFORMANCE in it.

The structure of it is questionable either.  It really should be two
patches, one modifying the ACPI platform-profile driver and the other
changing amd-pmf on top of this.

Moreover, I'm not entirely convinced that the "secondary" driver
concept is needed to address the problem at hand.

