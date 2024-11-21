Return-Path: <linux-acpi+bounces-9712-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98659D4AF2
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 11:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5898BB2299A
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 10:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8311D0DEB;
	Thu, 21 Nov 2024 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGIIl/AR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44511D0B83;
	Thu, 21 Nov 2024 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732185238; cv=none; b=l6yp4zINrVwzoPvdsoCtwTp8glpmy2F9N5JEcoEtn4h4OgW55OcsE+YE+0B66FsmWLvhsG/zJkgq2VNcHVINIuzYgcf+ODEGdf3od2E5K2mR3GO9DGODicYZwUJsCxLM0WK5FgS9mKrNej5VEKj0GgaLdhNZ/Ru9dh9HfyhWztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732185238; c=relaxed/simple;
	bh=PRsd2mYUtqJDcJ1K7x7OCmAEwgu9V/n3Pf1REKc5WGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKpVmOflw7ocVu5aWDilkKntEuVIhiRUmmnfq47A55Xgd0rA64Soq8dXHeXf+VIfxtG333KodJUwEgzIJ6hNIDRaNF3MKYq324fuvUR7+0hxkFxi796c3dGYFKD5ZVjY9K92snv1z3jNWqgXm4iwcihdq8ivWIXMqv9CQKoH4TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGIIl/AR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715A9C4CED0;
	Thu, 21 Nov 2024 10:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732185237;
	bh=PRsd2mYUtqJDcJ1K7x7OCmAEwgu9V/n3Pf1REKc5WGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XGIIl/ARoIRb2tIpMRvqTygsb1uOfavVtcesqrwb7ivSAQtOd/bETVBCV6ARWOeG5
	 cM5SdMgjTcovs79puYqRHEJz8Kp87za48LkAUefY2f1V7ZdmqJaRZYyE/hWTDfRo5U
	 fK6PWuLI5qk5H79yL4MFFXWZTCon7F3IXVYaHsGhYMBbXG3sl9PfGpb/XOX2pfwJ/y
	 fujTZY4lLRi2Ciimm4dTfs0CaDTZ7+BFAXBncFsjTpOxhefIIfWPWm4b8RTmiwtL2+
	 qn+0xa31iNPUx3omM/2XGkoCcxr8u6YH+RNF2wZHz0i3AtrK74BojlzliD0W7P0a+r
	 lRgPqUmJ4Dxqg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ee9db85af0so825711eaf.0;
        Thu, 21 Nov 2024 02:33:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUpCkPQk2+tfV2jju1fmstOM+Q+onMuAxTtcuh+mtHyF7bIUZkqwdUebSZHFuJcTQVB6EPgZKS53Db91yT/@vger.kernel.org, AJvYcCWxdjDLmLSLVrCcfPr9pYUqqI6iD6YNd8EC4MNbe++PDzxwTjdjqXAiCRCL0x1AAajpIRDsFmXFtsAv@vger.kernel.org, AJvYcCXAgncB4X7syVXHgawJ3eSaPFkGY6P0PeK3MZfBdnhqE2kbcSWauZOGtdxqO6M8yr2++hHh//v0efE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrpy/8OFF4TlE0auggAuo2O9FX3fiIhqj3MXdX0zsg/ALkDZ7
	/pOo4a7yUXR9IpcCtTrj8SnHLVHPYWMcuW00VqvNRvKydeQPk2t67tAhznlPAs1SHp1XtTM/diS
	P+vKhv4kFXo1WFaF9ELmOerlKT3k=
X-Google-Smtp-Source: AGHT+IFk2dIFB0EhKFDmZLp6hggCtgy6vkiIpWWpYvjA8ubljmfDCLOq8wB9cYLG3YGFwFXLB+38mJUUXEkxj4XJp2o=
X-Received: by 2002:a05:6830:12:b0:710:d4cd:bff3 with SMTP id
 46e09a7af769-71b037b5bf3mr1346080a34.9.1732185236812; Thu, 21 Nov 2024
 02:33:56 -0800 (PST)
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
 <593c4be2-c21e-49fa-8bf7-a614c01c8e66@linux.intel.com> <CAJZ5v0h_hh8Rp2kG0xT_b5Bm5zWX6MscRo1rEx-jO-dBd7t5Aw@mail.gmail.com>
In-Reply-To: <CAJZ5v0h_hh8Rp2kG0xT_b5Bm5zWX6MscRo1rEx-jO-dBd7t5Aw@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Thu, 21 Nov 2024 05:33:45 -0500
X-Gmail-Original-Message-ID: <CAJvTdKkYKj-PQhzQgDVGnx=oTwK5ufWNsLxOLtzDwQPGpteVfg@mail.gmail.com>
Message-ID: <CAJvTdKkYKj-PQhzQgDVGnx=oTwK5ufWNsLxOLtzDwQPGpteVfg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, anna-maria@linutronix.de, tglx@linutronix.de, 
	peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 2:42=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:

> I generally think that if you are sleeping relatively long, you may as
> well sacrifice some precision for avoiding system stress so to speak,
> so I've been considering something like flat 50 us for sleeps between
> 1 and 5 ms and then 1% of the sleep duration for longer sleeps.

What is the maximum rate of acpi_os_sleep() invocations?

Assuming the reasoning for user-space timer-slack is sound @ fixed 50 usec,
what logic supports acpi_os_sleep paying more timer slack delay than user s=
pace?

What measurements can demonstrate the benefit of this proposed additional d=
elay?

