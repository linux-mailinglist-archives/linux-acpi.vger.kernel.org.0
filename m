Return-Path: <linux-acpi+bounces-9707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F01D9D4248
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D01E41F220C4
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 18:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E467C1BBBC1;
	Wed, 20 Nov 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tS4pPb9q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8F51A0BDC;
	Wed, 20 Nov 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128906; cv=none; b=S1E9wsjmgT0KCkIBbUU7olQvj5HN90Ite2y1CUpTE7MRtlXVne15ATMY/3zhbEiIGi3zUF6Zo6WSsaV9PGPn+Fzx2BAMhHuPyKAfVG2JImptLvcQAW7W6g7HR8e72oeqefq/rDDRANT0olBMpRhkQUyBiJ9CNyeEqrD8Qep7dgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128906; c=relaxed/simple;
	bh=7iNlVObpcindp4mU4f5rY8q81sWe5uVVk4LFqLRBvCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWtjCPUktNeuklSf77vUOP/4LS6jYN5mTSGemBDpqeBhb9MyE9//WEOi1MkbII4RkV7IvFEK1JvxxspXht5/ksUCNI0qGWda9zSCJoIa+5DtehBWZ3D1lmosylNPK5EvVf1+d5a7BxrHcpPkJ1on0F7DAoKSlzO4KenXftWLMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tS4pPb9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9CFC4CED8;
	Wed, 20 Nov 2024 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732128906;
	bh=7iNlVObpcindp4mU4f5rY8q81sWe5uVVk4LFqLRBvCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tS4pPb9qS1zHYqWlZ0+aEQoGlegmlD2l7SHUWRJ9KN3H2GNdvo5LA6osnDfhT7iXG
	 bzktOGorzXT6LqT31xzolRS9479BV4mTj2FJlKi758XTFim0+1tIgUZj/9Z1QQsjkC
	 ZaDabfnquLmHmP8W41QMFJfQGG09GVcJ9f97PHndnh+eYLXns6jyY4n1mnhxgaSo3C
	 18Bqr0qMTqXmtis8lXcxCDOL4KbGIet9mpuZNcCwrPLvIqncxweNi/N+zh4cZhVzap
	 zoLdDxw8LvWo7n38BwGMPKDUjnxdgs6wXoiCD5LvagiaE/WQD/zVBYBPeBUvGdRWlW
	 BjBIwvwCn4d1g==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3e600ae1664so67725b6e.2;
        Wed, 20 Nov 2024 10:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW+EyQdu4Dt6BVGhU2WmSiWmW5Z/qQjHwrXF5stDn4QXaBgFX6m77vizbzOlfNhLWX4oNKWl9hu11c=@vger.kernel.org, AJvYcCW93MmMjsKNGvWbS6PCXMof+cVwJdUG9p0968QD7DWYRyiPyeiPEdQmklzSVjhEci2ZYvUYThxubk7n@vger.kernel.org, AJvYcCXLuZrwJ4RPWzo1KFMLtrle9gYtBeX3hTvBpHpDMd+NjwGuAWCN0N6dcl1NfmBDEi71gjxAde+Al9I2g1OT@vger.kernel.org
X-Gm-Message-State: AOJu0YzLNFZHUf5AZcRjCdQItyb/9+KJjxj4OB30NkFCQUGTKGAIZgF7
	b2wZ/Uvp+dKGLATNWuQtojsMPubvWBhOZwLzeIIFbO2MPQaFcJXmMXQoLNF7VakwUjNyYHUmN+T
	am2SXz6/5QD23TiW7PyVA/bOYiwg=
X-Google-Smtp-Source: AGHT+IEvr6u7FvVsflV5ZrLmCrlhPJkj7ve6zXLwwAB4za8pZzBbg+m/NmobsyNgM5TmRm76lnKu0OViaXX87/EP8Jo=
X-Received: by 2002:a05:6808:3188:b0:3e7:a201:db0f with SMTP id
 5614622812f47-3e7eb738affmr3589483b6e.25.1732128905489; Wed, 20 Nov 2024
 10:55:05 -0800 (PST)
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
In-Reply-To: <CAJZ5v0h5=3LMVCa8kSoomNyF9r_7HLmpkH+YhYEO_N7H6-hAGQ@mail.gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Wed, 20 Nov 2024 13:54:54 -0500
X-Gmail-Original-Message-ID: <CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com>
Message-ID: <CAJvTdK=Q1kwWA6Wxn8Zcf0OicDEk6cHYFAvQVizgA47mXu63+g@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>, anna-maria@linutronix.de, tglx@linutronix.de, 
	peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2024 at 1:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:

> > 50 usec is likely more than enough in practice.
>
> And would you use the same slack value regardless of the sleep
> duration, or make it somehow depend on the sleep duration?

timerslack_ns is 50 usec for all user-space, no matter the duration.

This part was done right -- it doesn't depend on the sleep duration.

Coalescing depends on the pattern of wakeups over time.
That pattern doesn't necessarily depend on sleep duration,
so it is a hard sell to tie them together.


--=20
Len Brown, Intel

