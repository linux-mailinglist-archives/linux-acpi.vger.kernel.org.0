Return-Path: <linux-acpi+bounces-9710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7919D428A
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558231F2379F
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED619C543;
	Wed, 20 Nov 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH/O9Un5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D72824A0;
	Wed, 20 Nov 2024 19:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732130865; cv=none; b=UiXB3JdMGgujlvOFtm3mv4jDLOyAXeptposXQ/A+MomnqlYVwKkumeSPe+faE/ZkxiOyRDBtjRrrFDtKY/wFkIfdiw4EM79e7z+jmKQQeDyUKl/YThvol0gqHsem3nbBjivR4OLFj71PRNEJkNsD5cE11BkvsxHTeB1H0OSD3Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732130865; c=relaxed/simple;
	bh=m9eVvBuAF1LQIlyeSWNL9oUJUXPUGqnSB+UORRlx3gY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LD5WKu0jUKGbfE3O77SOljiy8YwXrzu43FmAnJky0BbUYUnJbY7MnFvYjNQZbrwqlXz1lmXbQNcacDMX/Sqqtf4bJ4QOuuQsRE6vD4lqJY5RiANfX9DG2/B16dkVg4jd44Gqyh8u3ORvCEFhEvIkMMkV2MG1D01YzO1UI3G6z9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH/O9Un5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A095C4CED0;
	Wed, 20 Nov 2024 19:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732130865;
	bh=m9eVvBuAF1LQIlyeSWNL9oUJUXPUGqnSB+UORRlx3gY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PH/O9Un5uCPqDdOaE40gIrdUmtDi90i+G2al5i29rZVlNiJls+aB573+CvLeVJytH
	 PqAb2zPpMXgPVip93JmRZ33XYYLc9+q9/Np4aPdtS2Qe3x+OOM1/j0va5c/l+TKWzb
	 6g/WtdVOfdHL0Li6TEjFt/bw9rf+pvvkc2PqR1ObWgo7fzuBc3+sIgOosLsYjCU+Ze
	 rBJ2t8A/mojKaOO8tukaNyRRE+7czjtjz2m9jTNY7vdbcvIgx/KO9q8JdLBzb/NQrK
	 wp2yvXGfa0A2oINflRvIZsW5Xi/MBUnc/euRMZjcIDDGDPlogs37JcmWn8HyAossc9
	 x+8kNRJ5anzHA==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27d0e994ae3so100344fac.3;
        Wed, 20 Nov 2024 11:27:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUN5Jl5DRT1Rh0uYx+71gAuXOjn4Qvt8FCZmd5e/vLrx3xd3UawlkstlfwN7K20I61uryaO/daakriG@vger.kernel.org, AJvYcCWJYxXWaOyxphrCNc8Kbtc2wbzlFdS0MaBPiQLr9HeFrMZSwckz3EXUZn4zu2p2AW1AAgkOP7WolRUA8AQm@vger.kernel.org, AJvYcCXVXdTVwNKZJfxRSrcyhuqUTNPa2IBsTj8/nl2ewsClGj+30nlTqQDzt/PwY9iMSKiZMXJ7g076LXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+moAeUPzCjj4kB4QdJ/aFTn5hA+H7L8tZmBK4q7JDjWBDIl7S
	zTyOov4UqRx4Lw75Z/8xJX6eCpiVn7kuoFsvLMY7btyRurvhDQoKr2Wr0xLmo0zx4T4NZez4aGK
	hSX0EUc5w0SnNudHne+50hOdZQsc=
X-Google-Smtp-Source: AGHT+IH8aoIsQWcUpF/CbVUaABzlQMYS8qfpsmANgVvgqAlcKRj/IUjgJXoDAU0mN/Cq0Z3qyURaJL553CpRqgNs7hY=
X-Received: by 2002:a05:6870:b4a1:b0:296:e2da:60c6 with SMTP id
 586e51a60fabf-296e2da7b5cmr3121531fac.40.1732130864531; Wed, 20 Nov 2024
 11:27:44 -0800 (PST)
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
 <CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com>
In-Reply-To: <CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Nov 2024 20:27:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0is4gRauBZUVBHvSzDUXFz-6+B1TW+E_w6C4_DbQN-BfA@mail.gmail.com>
Message-ID: <CAJZ5v0is4gRauBZUVBHvSzDUXFz-6+B1TW+E_w6C4_DbQN-BfA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 7:55=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> On Wed, Nov 20, 2024 at 1:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
>
> > > 50 usec is likely more than enough in practice.
> >
> > And would you use the same slack value regardless of the sleep
> > duration, or make it somehow depend on the sleep duration?
>
> timerslack_ns is 50 usec for all user-space, no matter the duration.
>
> This part was done right -- it doesn't depend on the sleep duration.
>
> Coalescing depends on the pattern of wakeups over time.

So say there are two tasks that each sleep for 5 ms every 10 ms and
that the first one starts its first sleep 70 us before the other one.

That is, the first one always calles usleep_range(5000, 5000 + delta)
70 us before the other one.

If delta is 50 us, their timers will never coalesce, but if delta is
100 us, they'll always do.

Generally speaking, longer delta values make coalescing more likely.

> That pattern doesn't necessarily depend on sleep duration,
> so it is a hard sell to tie them together.

But it can be argued that delta can be somewhat larger (increasing the
likelihood of timer coalescing) for longer sleeps because they
generally don't need high precision.

