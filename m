Return-Path: <linux-acpi+bounces-13091-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7151A91CB4
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 14:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCCF5A6E68
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Apr 2025 12:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D874817C91;
	Thu, 17 Apr 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNyvyPs2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31496136
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 12:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893972; cv=none; b=QG+VU+zyTnReOJ5P3Yk8bocSErRgx5YEOSyFgb6m6LrGH7ATESwKdUBpDoOTtfKPkg97ZBGa7nALi1eBKJr5BgIxJXd08fVnc4/qh+bvVHcrhYZDHfM90QVD6NnHq6aTKn+qinuOmZKGIsVmd63FfMUx9CMg/OPfnYJpIwow8ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893972; c=relaxed/simple;
	bh=Le3o8h76TopJzHZ3p1doaO0fg6aSHQQ6FjKbkYvbQHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=okERL1B9T793m0zeVp3e1IDk6pZYks0b7MUhXpVhJbmYncB2IvPh7fac8hlr5/26rHHlaVXqw8gkOdr0gauX8LKaFTU5bmYztWDvO8tQzT9wZxA3zs/vCCm0e5e5J4ItPp4D1zbREA0lZi4Xjgaz/rG6WwF8Qku/wlx7y/bQyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNyvyPs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46085C4CEED
	for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744893972;
	bh=Le3o8h76TopJzHZ3p1doaO0fg6aSHQQ6FjKbkYvbQHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lNyvyPs24mQQ38XPYbk9RWcGlTSmgJHqRdyLzPkkBZUnLSMqa6wzf+82QSJuZpyvf
	 Su8aQdv81pah9S5ca7E9Kuoaes8TrQX+bJyB+YZQ7EGVuW/1VRQb5cKNwHRikAe6fe
	 Hs0qcK7bjCmmoo1pJDyIKcBhtfvzf8KwhNl3OqJ59URw2qwOBfLIiy7VHEMBd0+aYR
	 gBjlaa0noLianNEwQxUpCQlPpavrovSP7DOYl6WFRRCvLDpf3HQQl/ubi7CoE+89UG
	 Y8T6y7qd2k2Dqo0KcIEtBb1ypnOx/K6Dx1DMSAFMv2Uw8E7e0I9LPK+B3mF5zBgR/L
	 TvUDYPwqj1ylg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-603ff8e90acso115024eaf.1
        for <linux-acpi@vger.kernel.org>; Thu, 17 Apr 2025 05:46:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPpLV5fDPGMc+XJK5VUdC1xkY+br4Z16w8MuPsZF8im9GXCPwHuiluxPEz4y4RrdPL7+9d2HBV48z2@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUiCogqaxd3ZCf44hKaUbHhbb3ux6EXd+APG1kNMx/utYAEje
	XkbMUmczcuPHKJaK2rJyqlV2I9J2HCDYZq+Zc8oGO8ho56RIN8X8Lu0/f+1Qutnxo8FjglpPypc
	R6M6MQi8tYnplAtQvGprIXOPkvzs=
X-Google-Smtp-Source: AGHT+IFdS13ZGpOtexUSBcPHWiN/JkX6CLmcGAIcWvcuVVznX5LugC0/adc2dFYSL9SK8+Upe+2w0mT6mfAg3bJzc7A=
X-Received: by 2002:a05:6870:ce06:b0:2c1:b58c:bef with SMTP id
 586e51a60fabf-2d4d2d63f9bmr3371765fac.38.1744893971603; Thu, 17 Apr 2025
 05:46:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417031040.514460-1-superm1@kernel.org> <CAJZ5v0iQMOY1NhpE9Hy0jD6iKQeFbdxB4ZWj5KZcsbApwZ_RhQ@mail.gmail.com>
 <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org>
In-Reply-To: <90fcc29b-be8e-44b3-b6bb-a1ef06096520@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 17 Apr 2025 14:46:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
X-Gm-Features: ATxdqUFBpAF8Lo8GIlHM8-j6C8U-U8HxiH8-MDKt_crGUCghAedKI0W0wkULfL4
Message-ID: <CAJZ5v0jRLRdcvTGELZswnNuQKQx_RuKvDAL776Qv49bP7vxKrQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPICA: Add support for printing AML arguments when
 trace point enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mario.limonciello@amd.com, robert.moore@intel.com, 
	rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 2:03=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
>
>
> On 4/17/25 06:19, Rafael J. Wysocki wrote:
> > On Thu, Apr 17, 2025 at 5:10=E2=80=AFAM Mario Limonciello <superm1@kern=
el.org> wrote:
> >>
> >> From: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> When debug level is set to `ACPI_LV_TRACE_POINT` method start and
> >> exit are emitted into the debug logs. This can be useful to understand
> >> call paths, however none of the arguments for the method calls are
> >> populated even when turning up other debug levels.
> >>
> >> This can be useful for BIOSes that contain debug strings to see those
> >> strings. When `ACPI_LV_TRACE_POINT` is set also output all of the argu=
ments
> >> for a given method call.
> >>
> >> This enables this type of debugging:
> >>
> >> ```
> >> extrace-0138 ex_trace_point        : Method Begin [0x0000000096b240c4:=
\M460] execution.
> >> extrace-0173 ex_trace_args         :  "  POST CODE: %X  ACPI TIMER: %X=
  TIME: %d.%d ms\n", b0003f53, 1a26a8b2, 0, 15e, 0, 0
> >> extrace-0138 ex_trace_point        : Method End [0x0000000096b240c4:\M=
460] execution.
> >> ```
> >>
> >> Link: https://github.com/acpica/acpica/commit/08219d91b5678ae2fae6e4f2=
08df790a4e108c1c
> >
> > The link doesn't work.
>
> Are you sure?
>
> I just tried again and it worked for me.

Yeah, it works now, I had to sign in to github.

But it is a link to a commit and I need a link to a PR.  I think it's this =
one:

https://github.com/acpica/acpica/pull/1012

