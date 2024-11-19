Return-Path: <linux-acpi+bounces-9659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 379879D272A
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECB31F211A6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Nov 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B321CB32A;
	Tue, 19 Nov 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFe438g+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DDD1BF24;
	Tue, 19 Nov 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732023752; cv=none; b=rmuiryKDNGc/JvMbsmP6/lp72W0U1aq1Dml8hJxpFVtmgqKHk+NeAxF1+E18jLzZMZV298H/xXP7K9Aa4OniGBAQEZIJWeoSarpY+K0Mq76KVqyOB9kpbdjXoolyy0Fqq+z6WCToFtY3Cy7qU82f1ES6vHQNcQVsWMKESxH5XK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732023752; c=relaxed/simple;
	bh=DfYYAZlq9c4USSws8yip4/Ty0nMKu6oSNFI3HckGfQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6Mcid07SaJzhgb1RM0XybEa6yRgLaNWuqFUWSY1NUHaPKAhdtXk/RxFj+KvMSkx1ehFttx2iji/XHGYKYlg87dM/z5OEuhk8YhTc03kBxAz4ol3nX0NVA21xIlVVGktYFrRHDBVvABKQ4XZuEBFeRZ/zESai0/n/RnljMKIUSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFe438g+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5143BC4AF09;
	Tue, 19 Nov 2024 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732023752;
	bh=DfYYAZlq9c4USSws8yip4/Ty0nMKu6oSNFI3HckGfQA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=JFe438g+BzqtK7cZAo1PnB8eDGBuCrawK6pp93M7yy4a+UpkIRmof938KNX7dbGwI
	 gqe5wauWtFnmi6/txlobC7//IRnSo/NH+eK3ZNfdWiInF2WHmH3HniP/p1oWsgk4sV
	 M1E1gruWp/EhrdlRb90RvvcFrgmC3tAiJXNsjoR3Hs3wYY654RSaBIJbx2Org/6tfq
	 eTS2uMHEug3hjMSz7M4/k+NMkYjbFoWUhTTzP+rH8SzRofrAczUbMLmHT0Rn1mjlVB
	 Dkgdd7lSLmnGyqU42M9noBLFpNbBc3MjsI6cj332QkjXe9LiqbiTMeHRjC/46r2qZr
	 OYs/20OLI/ncg==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-296b0d23303so520196fac.2;
        Tue, 19 Nov 2024 05:42:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVvDRYJot9FrzXzu1Zv0h6YJImGh16m/liI++UWjNlWsPX3bm2doyWKHRTnJ+rTO/G8rnyp3dDKTvkuzbEc@vger.kernel.org, AJvYcCWv/0eUKfgzaxlKPq7u4k6RP7vGl/EYXguEL9aqHhjxtFEuVaBb1PtLYgY9UWVushhigBKEKVJOIz8=@vger.kernel.org, AJvYcCXsekxNcam4HEhdqmV6PXr00QhQjGhSMblfMLXwSeKWdZOMTndMWXMZza+qRdAoWon5gj6/wn4YUSym@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95xA9FKVnk6s70yKGbN/wz3XqFLvb3R+IelmlZMHBocYNEem7
	75m6Jp23jDnH5UOEVRe3padhjIyT4ckUxlYVk2+CPu7BnZ4nWgr9n+yEZiEUtAt+N1Ac7x7v/4y
	w3r1udSQrDEim1PRD7wzU62qz97Q=
X-Google-Smtp-Source: AGHT+IFd7vhAanoxGqY0wyNTzNxI12AgCfjakp5VrOn1HQLBn/oFTmOrYXZPPQ11Ui68sntyaxWXb8ER+IZIVUc3bhM=
X-Received: by 2002:a05:6870:414f:b0:277:d17b:50b4 with SMTP id
 586e51a60fabf-2962dc918cdmr15681567fac.5.1732023751568; Tue, 19 Nov 2024
 05:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com> <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com>
In-Reply-To: <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Nov 2024 14:42:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
Message-ID: <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 3:35=E2=80=AFPM Arjan van de Ven <arjan@linux.intel=
.com> wrote:
>
> > And the argument seems to be that it is better to always use more
> > resources in a given path (ACPI sleep in this particular case) than to
> > be somewhat inaccurate which is visible in some cases.
> >
> > This would mean that hrtimers should always be used everywhere, but the=
y aren't.
>
> more or less rule of thumb is that regular timers are optimized for not f=
iring case
> (e.g. timeouts that get deleted when the actual event happens) while hrti=
mers
> are optimized for the case where the timer is expected to fire.

I've heard that, which makes me wonder why msleep() is still there.

One thing that's rarely mentioned is that programming a timer in HW
actually takes time, so if it is done too often, it hurts performance
through latency (even if this is the TSC deadline timer).

> (I'm with you on the slack argument, some amount of slack, even if it is =
only a usec or two,
> is very helpful)

Thanks!

