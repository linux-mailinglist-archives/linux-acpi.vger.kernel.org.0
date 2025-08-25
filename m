Return-Path: <linux-acpi+bounces-16018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95043B344B9
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 16:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55CA83A2902
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 14:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7B2F3C31;
	Mon, 25 Aug 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ta7ChnMV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FE31C5486;
	Mon, 25 Aug 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133829; cv=none; b=RO8yBHE8nqz08g783vZZgTSAB11l2r9G8uh+G0ubD0Lm+AGD+mYp4aSeObbB2ZGWBTvGSa16y19x9A+YeUvfunHPJJyyvqj3r8rOB/4HBtymRJE4N9dEhh8QO6pEsMGhjG+AAWf0lBdWP8iINNiKcE2naL4GFgzSJ3LC8wWWA+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133829; c=relaxed/simple;
	bh=tY8TXkykPrjBK4IPNJfIRkS0VjGKW1olRODNSwXcnco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oM34WFzFW/SfThn7Zy5jQiiibHjEgyT+FX90bVLlu2IdaP5vKJTDN8vrdyLpEusb8Sf/pqaStGoEWBFX0tKHRwwJfkVGqt1VyPfBDH6/KGtwNWkTYgK1LgfIWrtgu6jQsLA7BYcrvUq0p4CbmJZpyqAhDrq8xF4Er0lZJUiEJyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ta7ChnMV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444E0C4CEF4;
	Mon, 25 Aug 2025 14:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133829;
	bh=tY8TXkykPrjBK4IPNJfIRkS0VjGKW1olRODNSwXcnco=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ta7ChnMVSjsdsqH7svpUwMqf7Pz5wC7PWeFoTZzKavZS2xbjzQyp+UTJDXFzpXXQs
	 enU+XtKfgP7BzZU+uL5nta0tC9AsEP3VIdcBob652VbdrAJCO3ydlqZKmC9nIuOBW5
	 iX1IbPNSlLfcr0KX/xwaLVS2rAQpGBKI3mMntXrP6e3EqwvjHFw9B87V7pyPeOIaUp
	 /CPVrJh/scKAfP3KoT36KeVrUzlMxrqLsxxp4jnW2Ez+TlM5Cr0UXx/dj6ooDxTped
	 UD96LskbnhHGy+zsjYiPrJOdrVCWZvrrGBk28A/cxWseJICEqdz20I29v+bnblv08r
	 1QQTXLA5MrUmw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-30ccebab736so3257666fac.3;
        Mon, 25 Aug 2025 07:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCzSBvn90b+3Mojc2eqUWkTkiwKTGAO73s/kZEkGj8hdJGEx0juBkDtNvFoBQA2dnZ51orQFCu6oo=@vger.kernel.org, AJvYcCXJbAAXtwjOQGXM/9mT+RB0k+pjZB+oEjzCZKpWIbNfUTuwzRGeljMoIwTutwVYrk4lBeLYWL1ahP+d7yyR@vger.kernel.org, AJvYcCXvyOXWCaqipUrdhvf7xdnVhjhQlcSPCzDyeMxxTmuj1t+Z0mIejJqknHY7TJEWSqFtjYW1WJWjY4QE@vger.kernel.org
X-Gm-Message-State: AOJu0YzVD42XYr9B1tasY9QB1xOEketMcpmG/90WaQqYGpynvdpFOs0c
	GOfN+nmJWZt82bUi66MLnekeu4txJKFOBsFU587RF8OFe5vT8mRDsFUPX/jlVehaZRcnQaP50Ma
	a8duq7JJiaVvxgoUKMGGv6E2i+b0PsCI=
X-Google-Smtp-Source: AGHT+IGvB9xOXfVR+M1XersCBlaasX/VvIr6WHKDsJ/Iv2XSPDAmudlo3CsScfqb2fgCasliY1ryQqv1MwvyEHm+eU8=
X-Received: by 2002:a05:6870:88a0:b0:30b:6dc6:d5ef with SMTP id
 586e51a60fabf-314dcd5d1c0mr5366796fac.32.1756133828619; Mon, 25 Aug 2025
 07:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814072934.1016694-1-tianyaxiong@kylinos.cn> <20250814073156.1022939-1-tianyaxiong@kylinos.cn>
In-Reply-To: <20250814073156.1022939-1-tianyaxiong@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 16:56:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hGj3=GxnLkj0adm+ENSk7YbzNZRPiBTgm_bKZsH3OYDw@mail.gmail.com>
X-Gm-Features: Ac12FXzRjYE2csZ_OCSOdpP4wrPZ-eVam9nKg0GHm5mnlFEOke9NQBhN0m6QdEI
Message-ID: <CAJZ5v0hGj3=GxnLkj0adm+ENSk7YbzNZRPiBTgm_bKZsH3OYDw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: processor: idle: Replace single idle driver
 with per-CPU model for better hybrid CPU support
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, lenb@kernel.org, 
	robert.moore@intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Shaobo Huang <huangshaobo2075@phytium.com.cn>, 
	Yinfeng Wang <wangyinfeng@phytium.com.cn>, Xu Wang <wangxu@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:32=E2=80=AFAM Yaxiong Tian <tianyaxiong@kylinos.c=
n> wrote:
>
> Current implementations of hybrid architectures (e.g., ARM64 big.LITTLE
> and Intel Alder Lake) feature CPU cores with different exit latencies.

This is not true for Intel platforms, all of the CPUs in there have
the same set of C-states.

> Using a single driver to describe_LPI states for all core types is
> therefore suboptimal. This is further supported by ACPI specification
> 8.4.4.1 which states: "In a processor hierarchy, each node has its
> own _LPI low-power states specific to that node."
>
> To address these limitations, we replace the monolithic idle driver

It cannot be replaced or you potentially open a Pandora's box of
regressions on old systems in the field.

> with a per-CPU model. This approach enables accurate idle state represent=
ation
> for each core type

The per-CPU model can be used instead of the "monolithic idle driver"
only if the platform is actually known to be hybrid.

> Tested-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
> Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
> Signed-off-by: Shaobo Huang <huangshaobo2075@phytium.com.cn>
> Signed-off-by: Yinfeng Wang <wangyinfeng@phytium.com.cn>
> Signed-off-by: Xu Wang<wangxu@phytium.com.cn>

What do all of the above S-o-b mean?  Are these people involved in the
development of the code?  In that case Co-developed-by is also needed.

Thanks!

