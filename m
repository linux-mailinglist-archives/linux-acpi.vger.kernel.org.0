Return-Path: <linux-acpi+bounces-16414-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D07B45A91
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 16:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358DB1898407
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3391C36CDF6;
	Fri,  5 Sep 2025 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9ObyQS9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBBD350D53;
	Fri,  5 Sep 2025 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082671; cv=none; b=Yw2jqW8XzCkQptp8ibTyRWLRve+aTcuUce91aatOuX4RbUsiEc/qs6DH0rLS3J/z0HBptGvNdL0NWJjHCLrp0Zch08MaqGLpONT7VKhPUdo6UkN0PkZGVjk221HAwawEPLWVBuMey/J5pBJG4xsIZk0kYM+4A42p9atc2IX516k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082671; c=relaxed/simple;
	bh=KEXtSGwfsIC7zCVkzHW+kQIA/8TfnPK+OMpue3a6JPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPfW3kDKAfk4z20NE3V8N03QYdQqwUVZFUY5E1EENQDVdiaAw/Cb0F1R0Mjqoo8S9slGcOSCyeI8FtC+SQl2uO9Fbyor4KDw7oB2WS1f7EcGcvWJ0PtKEtAtxYawYcJZflavjHX5+xFsl/F89SMSkOllm1wIugFe+wVbdaqjhnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9ObyQS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742FAC4CEF7;
	Fri,  5 Sep 2025 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757082670;
	bh=KEXtSGwfsIC7zCVkzHW+kQIA/8TfnPK+OMpue3a6JPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a9ObyQS9oWK8NAvCBt7tZ7rv1IYerllFhwk3B10rYxR1HkvuQF9uJJHG/J/5v0/lm
	 xiDKRVqS+kdMi35Pae2g8iZkVDH/96ZY86uTuyI/gg5uloziMztZAMrJ2nmgrKcL5l
	 PIWkRLys2izx/c1lmZEXt4bYTAvEFDx2PgG17Pezg4jcVJdDqrNkY5hPd4yiX6hxZI
	 OtdMjRwIa/DRpiREJeAD2Sjqii15EEeyaVDMGIxjdJ8jixN2MZ8xFaXZ4dehs6sNZ/
	 sEJZtCQiNpMjq/7Ckt8KEf50fQ/bGK63A/kYmN6WAozGThAaYRsYY9+nXW1UGOMooi
	 5VGkzcmh9sm0g==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-61e74e59d8fso982133eaf.0;
        Fri, 05 Sep 2025 07:31:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXoIEsF8WQzrihQ9oXPiUCRVvKhJHzVb1X62dmmgynMnFq80X2kYBO6XeTAnxsfPZsv0hcsWBq1u2z@vger.kernel.org, AJvYcCXaHE+tYUXim7TFnncVE9CY3rCkgciaxfsr9Nad8VJVvLOGoZ0fcI42M0i5JZh2wnm56crNK/0N8Eun@vger.kernel.org, AJvYcCXgDRdDyYTHjYtcunZ5OguSuMM0nk4QpE2lDIfuPAP4F8lz/WW6+MzJI1N9DClZzlL1z/YFODg2GlObXyfT@vger.kernel.org
X-Gm-Message-State: AOJu0YyBY/Jtr3E/IyYZDmyCBOX78Odu2RKmi9Ie+ieacvGIeZ7gV+ig
	DOE8Wg+BV8+kEfxJeLBVWtkg1lhB8r7F2PZgnPrOOfIDYqMmMjXANB12P3j0YIUWH8CrNLnNGqO
	uX1+/2WZh7+0tATymI8QXx5p1ZgS492A=
X-Google-Smtp-Source: AGHT+IFzBHpToPbaYhsxUcuEzlY8uNwMrnGiJlCP/fOq+ZAdCYknjgDExF05rFOJh/oF194cwfAHDMurW0hJsjhLImo=
X-Received: by 2002:a05:6820:82c:b0:61f:f87a:7c7b with SMTP id
 006d021491bc7-61ff95734c9mr1990938eaf.0.1757082669722; Fri, 05 Sep 2025
 07:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904184801.47498-1-dave@stgolabs.net> <CAJZ5v0j9r6bKOXuo+o0gdhryR1ne3WY3B0o0DufEHB9y3j0Leg@mail.gmail.com>
 <20250904191540.rb2dn4frng2ruq76@offworld>
In-Reply-To: <20250904191540.rb2dn4frng2ruq76@offworld>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 5 Sep 2025 16:30:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jPDYnibLWqaEKuQD4jda7kTc1YyM2MNOoNm5Xn4_0S9A@mail.gmail.com>
X-Gm-Features: Ac12FXzoduTZjkQYGHDQ7BpxzQcF3KgJaG-8n_dpWorq4EpDxtTJFWo6wUX2__g
Message-ID: <CAJZ5v0jPDYnibLWqaEKuQD4jda7kTc1YyM2MNOoNm5Xn4_0S9A@mail.gmail.com>
Subject: Re: [PATCH] acpi, tables: Rename coherency CFMW restrictions
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, rafael.j.wysocki@intel.com, dave.jiang@intel.com, 
	dan.j.williams@intel.com, jonathan.cameron@huawei.com, 
	alejandro.lucero-palau@amd.com, ira.weiny@intel.com, 
	alison.schofield@intel.com, a.manzanares@samsung.com, 
	linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 9:15=E2=80=AFPM Davidlohr Bueso <dave@stgolabs.net> =
wrote:
>
> On Thu, 04 Sep 2025, Rafael J. Wysocki wrote:
>
> >On Thu, Sep 4, 2025 at 8:48???PM Davidlohr Bueso <dave@stgolabs.net> wro=
te:
> >>
> >> ACPICA commit 710745713ad3a2543dbfb70e84764f31f0e46bdc
> >>
> >> This has been renamed in more recent CXL specs, as
> >> type3 (memory expanders) can also use HDM-DB for
> >> device coherent memory.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> >
> >A link to the corresponding upstream commit, please?
>
> https://github.com/acpica/acpica/commit/710745713ad3a2543dbfb70e84764f31f=
0e46bdc

The only ACPICA change in this patch is the new symbol definitions in
include/acpi/actbl1.h, so this can go in via CXL as far as I'm
concerned.

Please add a Link: tag with the link above to the patch, change the
patch prefix to "cxl/acpi:" to follow the existing pattern, and you
can add

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

to it.

Thanks!

