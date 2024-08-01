Return-Path: <linux-acpi+bounces-7202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CCB94492A
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 12:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2838A1F22C72
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Aug 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A3F183CB6;
	Thu,  1 Aug 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG4o7IqR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A086C156F3A;
	Thu,  1 Aug 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507275; cv=none; b=m6YBCgpl804JUhbHjqVuwFFyE32rlMoxyga0ZL64qPQDNv9AdLy7RimUYwYtRMPfMuuoPfm5rDn3ZI2GRRzsVm72aTFvgWKthaddVblVz4WOnMksDFnQmyUoRCPt2WjRkJi1pkLJFBvvw7L17fVPLZoOBNXyNk3Gamw8jsteFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507275; c=relaxed/simple;
	bh=uVKhVRkoIrz2goRuoc79nnIsvQWUydD4PmjTmszYkxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ED69SwR8UV9sS39vn+V3ZX3zyx9gLLvLeEJhV4jME15tVNLRKgRyVh1FGPp+yqVfJCzZ4XtVlu641xPoBdt9CueVtNkg9L3N3A6TiGAgVlIJCIqhqPHyVs8aQgGZh8tKhpIEyCAXUjqUy+0VR3iBP86St/PlfPTB7Ho97tDQ06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG4o7IqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2558EC4AF11;
	Thu,  1 Aug 2024 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722507275;
	bh=uVKhVRkoIrz2goRuoc79nnIsvQWUydD4PmjTmszYkxk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jG4o7IqRwmlwgprvom0DqaBjrhKzMWdRRRgu6cIHgs2SvXbDPFttIPfHTXA2sBP7Q
	 iLf/RE14vKd0X1d4wM8qrm6Qd4jt1ZsqZ1dSgcBKL8nA997APWcYCfigvzeYpSfU07
	 Ie65INfHPMFLXoQ7Pm/yzT6bl1K2DG/25roG4ofkWHqwgEpEAfK4Y70LTJeLrGQ0YK
	 4PNpw40PBzw5dQF7SNYRZr/FerAkpJkeWh5zU2gtFBZe2RvGU+xXR3Ig7YcWXl9KYH
	 jTQj+liH6RBi9eHuQYeIwBBFxxPrljtHTX8CWS8z9AbsP28z8q/wRRl4YVJj/d7kk+
	 GmFj5iPTcPM4g==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70936124421so381626a34.0;
        Thu, 01 Aug 2024 03:14:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsdoWnZlCJc/fj3Tbv9XaDm6OJEDzqr7WJNH41wkwcq2eMpC29q22bBRo5lfyHehoJ5bf7A5veWNGwMTMdPLg/GItsl3Nvx4Pg3IpCXFoMBj8Eqn15B2b5U4bA3Z0pOkJmB4WjfMhqLmleU4hS5Axl85rHsxiaVfsfxYXtfa8asC73xGmnEv0Z6t8lR8WCqKpK38NJYLFD2eyVeRRA2aEOjegtdrIK6g==
X-Gm-Message-State: AOJu0Yw4m+8/kn/g/mPzciL2aAhBiVsaaec5pFYef+i10jjX5vW4CQR3
	rvjNw/wjNov3AdkF43rauGZn/rB1nXW2q4ZfSUiuGfssqqABhKWf4bzwZVmtZ29MVp6j+kU/F9Z
	KVz0XjiPAITVWrWg8pP4US3dkmoI=
X-Google-Smtp-Source: AGHT+IEU2Ehnp4WZeT8s3RNeZ8eylqxVapnWYUNwQvI230a4Ru6GtFI/HLZyuyUTuqNLHqazPuPaPKzET8b4pWUrXTs=
X-Received: by 2002:a05:6871:3387:b0:25e:14d9:da27 with SMTP id
 586e51a60fabf-26879d67454mr1170788fac.0.1722507274373; Thu, 01 Aug 2024
 03:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1922131.tdWV9SEqCh@rjwysocki.net> <2242500.C4sosBPzcN@rjwysocki.net>
 <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com>
In-Reply-To: <a0c639d1-4f21-47f1-bb66-92f185e828a9@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 1 Aug 2024 12:14:23 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
Message-ID: <CAJZ5v0jDQLJWGCj73DXQe3+k+Zaq9Z71LJbFSvRjcuE85+J+mQ@mail.gmail.com>
Subject: Re: [PATCH v1 12/17] platform/x86: acerhdf: Use the .should_bind()
 thermal zone callback
To: =?UTF-8?Q?Peter_K=C3=A4stle?= <xypiie@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Lukasz Luba <lukasz.luba@arm.com>, 
	Zhang Rui <rui.zhang@intel.com>, Peter Kaestle <peter@piie.net>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Wed, Jul 31, 2024 at 10:50=E2=80=AFPM Peter K=C3=A4stle <xypiie@gmail.co=
m> wrote:
>
> Hi Rafael,
>
> On 30.07.24 20:33, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Make the acerhdf driver use the .should_bind() thermal zone
> > callback to provide the thermal core with the information on whether or
> > not to bind the given cooling device to the given trip point in the
> > given thermal zone.  If it returns 'true', the thermal core will bind
> > the cooling device to the trip and the corresponding unbinding will be
> > taken care of automatically by the core on the removal of the involved
> > thermal zone or cooling device.
> >
> > The previously existing acerhdf_bind() function bound cooling devices
> > to thermal trip point 0 only, so the new callback needs to return 'true=
'
> > for trip point 0.  However, it is straightforward to observe that trip
> > point 0 is an active trip point and the only other trip point in the
> > driver's thermal zone is a critical one, so it is sufficient to return
> > 'true' from that callback if the type of the given trip point is
> > THERMAL_TRIP_ACTIVE.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Thanks for including me on the review.
> I'm working on it, but unfortunately the refactoring of the thermal layer
> around gov_bang_bang.c earlier this year broke acerhdf.

Well, sorry about that.

> This needs some debugging and refactoring.  I think I can finish it on
> upcoming weekend.

Thank you!

I'll be offline next week, so I'll go back to this material in two
weeks or so anyway.

