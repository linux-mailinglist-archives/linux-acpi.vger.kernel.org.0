Return-Path: <linux-acpi+bounces-9628-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B822A9D0DC3
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 11:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CF3B2821F1
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 10:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837381922F2;
	Mon, 18 Nov 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJTMPvG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56965149E0E;
	Mon, 18 Nov 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731924487; cv=none; b=gvbYVbsWcSzjtJqECTYLZBOnCgT9ulBpZcwPuX8ffbSWMl10kPsdR2zwwzcQBHqMhunOJOxDVV8xHpSFLVitRF27qqepW/8CfDU+mMlRcLSwCneoAinu8KuItUpGwn1nAXCbuFUMPStEMlFODXW+uirhgW++iDbL58aeaKZKTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731924487; c=relaxed/simple;
	bh=lxh0gMMp9eGAgGhRMnuFyMkB0OFqF6nvxw+gL9xR83I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4I3pMMqMV8H1ts/eFSrT/vhyq1vF6hmcsRwAc0qbk2cOTsfVUh4fQkjZUiKfstqt1XIdF8Op/l5rMG1grZr4HbZ3onxtj/b8v21x5tqNT4QALZ3Ai6JLQoGk3/F16yLWuHF97Imacm78wqFtgKGwhQN211abN+EICxa6a2zqrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJTMPvG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D9DC4CECC;
	Mon, 18 Nov 2024 10:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731924486;
	bh=lxh0gMMp9eGAgGhRMnuFyMkB0OFqF6nvxw+gL9xR83I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vJTMPvG2Jr/Qt1Jl+m7KdLdFjz3CwKt6a+9BfThNPAPS4hYpBPpsKtqhoaZn7cYbt
	 Y2yR3COBYUhZ/7iyw4Xmd6Iu1VDKNv/BHyLEnV5sz4i1V4zo6VD/JkAaDMd4iPkc66
	 LlrPHS8q6CLbFWpiXoOoUB2H7oNwdMTpoSzqcRoNrpUpJewMvHpenDhe5LRcwN0DmW
	 DyR+is8/eUBwXEml6JwSAIbDa6kNvt/ZJgS7a1R8I2SgE79UHpUDmnYjcgjgeRMPyp
	 1CVgi/A4Za+I7UU+C8V7k9l0VBt9xBqG617Q8f1o6X09Qv7f1IaAeNQIQdlD5CjVaK
	 C49Du0fbQKgoQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e60d3adecbso912469b6e.2;
        Mon, 18 Nov 2024 02:08:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUhPsdB+kuzTNb4k7P2px2AxlnARKNfxJ2n3XfuR14a/Iy8r0xICcoroDp0jX5ruaZPUtojR8y7zXY=@vger.kernel.org, AJvYcCUyHkzlCICsaMqohnvp2MD1jc6BQ/SSVgA4AizhfF1TfUabpyV+ZP68KMEdbVCqGDov1bGlfH1EFsNi@vger.kernel.org, AJvYcCXeAajuEMLq1toXiiXWKbmTxVoxZkulbIrYg0GoCKvSLTrlifUskKz6jla18fnpolj9F7gqlb2KEsm9Q5OO@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNBmjo9UlnjDd2nwWms0nsIWWuGoz2gzzVYUtTk3zXc3BpFSM
	ivl/G9oZJ4PrwpIo4QsE0NOYbFcMKvJcVUk/tlR0nrQA3oXpvYBDVzJFAKVSd5v0eq1joknF4Gi
	7hXYqK++bLPX9eUnMYfiQuP2YPSQ=
X-Google-Smtp-Source: AGHT+IFxZkoTn6Npfb/jiXNak79sProbz3bDPP5Z1MLqEVyrzD84TNhh1EJIvv5murV5tXAfRdtUHkiY94kGO/q5xLg=
X-Received: by 2002:a05:6808:1404:b0:3e7:5af4:f8e7 with SMTP id
 5614622812f47-3e7bc7a908amr9718034b6e.1.1731924486130; Mon, 18 Nov 2024
 02:08:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
 <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
 <CAJvTdKkucaRVDZm6EVeUxwyrQexyuYd7ECUBSkpP0nC9PwzspA@mail.gmail.com>
 <CAJZ5v0jvYitb7DLyLkqTRv0TT=6yBHDvEvb8tJLzAOVKa3hqnQ@mail.gmail.com>
 <CAJZ5v0gxVqrASiuJq=UX9jyZsG=XvriFn2=7CPmG6-1sKbmPEQ@mail.gmail.com>
 <CAJvTdK=-ETniiwzwLYH14+TeU0kA49gvTnqyRxH7-Hc6tzTBUw@mail.gmail.com>
 <CAJvTdKmpfs_nh4J0R8T=1P9WaAJ-nJ+mKj=rT3tqMpmvpUTisA@mail.gmail.com>
 <87frqoig98.fsf@somnus> <CAJZ5v0gTfhTQ4AMZ+ukuJZEG=RRo-wbPsf7NPbWA0snDeA5ivQ@mail.gmail.com>
 <878qwf9w84.fsf@somnus> <CAJvTdKmbwtrUmCAJxXb7UVJuVAyMLec2AF--AHbiy+YNhOg5-Q@mail.gmail.com>
 <CAJZ5v0gE07+Nin5Weji20M-xOmjyWrixQU5PUnzZt=YWeH+-YA@mail.gmail.com>
 <CAJvTdKm+w_VZ9TQ5bw6=2G4N7CR9xn2qLYAb+p96jC66BXFFug@mail.gmail.com>
 <CAJZ5v0gmtRAQtdi6fdUQDfLv7sKyukb3aXwsdsdtZvSH6QFRnw@mail.gmail.com> <CAJvTdKmHGJZ8kkoNc2CefW_j5oa-SB4eCqghF-tuab39XyqNUA@mail.gmail.com>
In-Reply-To: <CAJvTdKmHGJZ8kkoNc2CefW_j5oa-SB4eCqghF-tuab39XyqNUA@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 18 Nov 2024 11:07:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ht7qZ_Da63c=RNvRovD=HYtT9A8S+-ng7qiKm3McdwEQ@mail.gmail.com>
Message-ID: <CAJZ5v0ht7qZ_Da63c=RNvRovD=HYtT9A8S+-ng7qiKm3McdwEQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 11:05=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> > Performance lower than the possible maximum doesn't necessarily count a=
s "bad".
>
> System resume slower than 1 second will fail multiple product acceptance =
tests.
>
> That isn't good, it is bad :-)
>
> > > Re: if long sleeps then use msleep()
> > >
> > > ... because a jiffy based timer effectively forces coalescing, and is
> > > the lowest overhead.
> > >
> > > The problem with this logic is, as you mention, coalescing is a
> > > function of the distribution of timer expirations over time,it is not
> > > a function of the duration of those timers.
> >
> > I just think that high precision is not necessary for long timeouts.
> >
> > I also don't think that ASL programmers expect high precision in those =
cases.
>
> Precision isn't the question.
> The benefit of additional delay is the question.
>
> ie. if an ASL programmer asks for Sleep(100), they expect it to take
> no less than 100ms.
>
> msleep(100) takes 106ms -- effectively always.

For HZ=3D250.

> usleep-range(100,100) takes 100ms, effectively always.
>
> Is the additional 6ms delay really worth the saved overhead of using
> jiffies rather than a timer for an ACPI flow?

Or the other way around, is the better timer precision worth the
additional overhead?

AFAICS, the reason why you are pushing so hard for this is
suspend/resume delays due to loops of many iterations that sleep for a
short time in every iteration.

I'm kind of having a hard time with accepting the argument that the
kernel needs to be made to use more resources always in the ACPI path
to address just this one case.

