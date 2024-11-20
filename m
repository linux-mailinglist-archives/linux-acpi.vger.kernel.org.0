Return-Path: <linux-acpi+bounces-9711-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3D9D42A0
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 20:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D32C31F21DF9
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3371B3B2E;
	Wed, 20 Nov 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UUpOVj/y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3013C83D;
	Wed, 20 Nov 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131727; cv=none; b=rzl0JNv4Imk3/8qkXuPb4+PSMPNLsdSuht6hjyNHN+H0Pji4oSQJJKJWHViZfRQ8X0vy804/OPH00fR56ZWwUk6b/sTtZlPHbzEOoZGdxqSlGFxTrDChD87SkEkPg4VuQITeTtzZiUCPfdeQ5WbM0pp3XoH8W7XVl8O0VtAldIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131727; c=relaxed/simple;
	bh=yN0sDFO7YQ+zJTQvKFwhxk1ezDuCsdkQfmUNE4GkHG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4ZTh+hqbXJgMtQKneuxj1TJbD0vXL3fx+sNqEmCrBzbq6B/kBjR8zEsUm6w1STTC0+G/G9oJ/pleyqsX2UXKJuSWEK4130lVRkqvM0XsPHFbmfK4vPKs3dods85O9O4YQLpd1QojX9M3fjsIszxyMmU1vBhw98vKZ/F2ZZIVRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UUpOVj/y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D3CC4CED2;
	Wed, 20 Nov 2024 19:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732131727;
	bh=yN0sDFO7YQ+zJTQvKFwhxk1ezDuCsdkQfmUNE4GkHG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UUpOVj/yLwNwf1chXTAANr71IghKB5JEbWOTyIXyRugNj66L9O5XmVe1YfBHuUp0y
	 x3EouCLaCKT/ckT0pRepo3E8X6OTZQRUokUSbo5dxvwVUz+FirKh3KNNJ4o5sF4Wca
	 8oTF7OdO5K2cCP3CH1xlMIKShM4Pbi5yX/YYtTZjTmVi1UPucp2Bp7GPnZzwK/Xiy1
	 XfjR1JmHA+/S0yCtyDdEZI5XXELwXwb8QMFuJbaF6R6PsCO5/XiRjlZiw+Dwvu+lFF
	 rGIImglNlVUK3x8uPAuT9lfuzvvAg2//Tki7Encmwkn6pK1GVl+EXbZMNrT97bKXzo
	 OHivNlV5h0mbA==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-29685066b8dso130265fac.1;
        Wed, 20 Nov 2024 11:42:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV3PUOcCOrFI2j4mZMi2/P5v4C0+TbBJWyN6L2ohK0jfaMmecVxCfyd7/V6V5ZeohmIpudlnJB4L3I=@vger.kernel.org, AJvYcCWT629VUV3hRhDMAjQgqN7z/0PwOKrOTMA8PSJg3l0sFn6zFmmYwNnZb3+5roze7dv0qc+1PiXoH/+hDIC7@vger.kernel.org, AJvYcCX6cE6FXT6cPxwvrDnYziyOhlwJFirsjRK2EiBPDo2EZoYP65eVaFc9lb4n0/LNror/905NO6mXWFeY@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrFZMpNe6oRdIUmcA8wzmLJ/NfePeI4hUKvUcVZ7sPPTxYsuR
	ACrzZbLpCgz1JLH6E6TJKJuJ7ZXK+lnWC6cD6ql044QRm+tnDCq85FflyTwSNkfOlCH+xsTiJ2r
	rgFqh1X52Dn4YzBdWzqI5BLVxz9k=
X-Google-Smtp-Source: AGHT+IGDYWDMSigg45Kfzt6/U/rg/1cXOZtuboqOsLa+LgVcQIq+UvGZMbbNG+t2YfB+RKam834AQvV0z6VdIRN+Lig=
X-Received: by 2002:a05:6871:630f:b0:296:c236:4f3c with SMTP id
 586e51a60fabf-296d9dae044mr3625623fac.28.1732131726506; Wed, 20 Nov 2024
 11:42:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com> <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
 <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com> <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
 <e0dd2cb8-eea2-443d-bf23-4d225528d33f@linux.intel.com> <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
 <593c4be2-c21e-49fa-8bf7-a614c01c8e66@linux.intel.com>
In-Reply-To: <593c4be2-c21e-49fa-8bf7-a614c01c8e66@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Nov 2024 20:41:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h_hh8Rp2kG0xT_b5Bm5zWX6MscRo1rEx-jO-dBd7t5Aw@mail.gmail.com>
Message-ID: <CAJZ5v0h_hh8Rp2kG0xT_b5Bm5zWX6MscRo1rEx-jO-dBd7t5Aw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 8:18=E2=80=AFPM Arjan van de Ven <arjan@linux.intel=
.com> wrote:
>
> On 11/20/2024 10:49 AM, Rafael J. Wysocki wrote:
> >>> I thought about something on the order of 199 us, but now I'm thinkin=
g
> >>> that 50 us would work too.  Less than this - I'm not sure.
> >>
> >> 50 usec is likely more than enough in practice.
> >
> > And would you use the same slack value regardless of the sleep
> > duration, or make it somehow depend on the sleep duration?
>
> I don't see why you'd make it dependent on the sleep duration
> sure in theory the longer the sleep -- you could pick a fixed percentage
>
> but you're trying to amortize a theoretical timer register write, and a
> cpu wakeup. the timer write is fixed cost and not THAT expensive after
> some amount of this . the C state wake up --- sure that is more variable
> but that is super important for high occurance things (thousands to milli=
ons
> of times per hour).
> If your ACPI sleeps are high occurance on a system I suspect you have way
> bigger problems than an occasional extra wakeup

I generally think that if you are sleeping relatively long, you may as
well sacrifice some precision for avoiding system stress so to speak,
so I've been considering something like flat 50 us for sleeps between
1 and 5 ms and then 1% of the sleep duration for longer sleeps.

