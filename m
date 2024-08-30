Return-Path: <linux-acpi+bounces-8010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 757C696637F
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 15:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A861C214F3
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 13:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2701AF4F8;
	Fri, 30 Aug 2024 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKWlfmLq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCA415852C;
	Fri, 30 Aug 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725026230; cv=none; b=fPvpSbaBvYZgep/Dr4WLwn9fNxdpn3WAgxG6ux7IvBtSR0PTI9803DlHEFSXRR7mcinsXxfdYUNBEkFC/ofCULEdjopy/3zrzWVSc6Ef8h3NM4QYlqpCR7YOnbmFVlJSiy7L/q6NSZskcAnlqlHR/AxOXVA4CD8MavUK9q5nfBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725026230; c=relaxed/simple;
	bh=PUtTNLbt6A2sNCbjzHkOLHcI/puW7x5xKfmRvOTpgso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxINPjPGLT4I9C1D9C2zYecxvBazxryoaYZZ1vMYL4U1MasLLzf1FkMsLG5pPBao3cIPqiHJcyPZjr+SVhwnWKPA5+z+tEmFkGbRE/wB+/UPqkeT/lWzxkkXVxcq4Pzxt0uZ85h9N4/839FG2uogS4kBVwACw2zkvryg0JEJbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKWlfmLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CBCC4CEC5;
	Fri, 30 Aug 2024 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725026229;
	bh=PUtTNLbt6A2sNCbjzHkOLHcI/puW7x5xKfmRvOTpgso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sKWlfmLqZNMT4KeOaoblI7EzuUpx7SpaeCfGCVJiEV9D/O96U5vcES0Qw0U3ZawTc
	 nLXs9G/RUCzEKK5cKN469V7pT2NpG6C8/C7oT4FUFVcf9jdQFjyZoRr+j2qE9T3NmX
	 gY7erPfv2Clj7IcuQSV+xcc9JLFN2JpVRP2SZ+th3zilEGBr4s0M1HwTVsbmayg+vD
	 N4EbQzm3EMKg7ERHM4EjhwsrmZpNCitZHqxjRzWjrzHY2pBuw6amhEwfdJ+ADRMwNc
	 pTugsPmjgKXmLfMdUSVNgVMc8pokrB/FCxXPKsaqOnWpH7MH3SLzlc436NOm7PnOKd
	 4l18usHE4niPQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5d5c7f24372so1107942eaf.0;
        Fri, 30 Aug 2024 06:57:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVb9VpFe2O+0uzIJa3U/UF5ljnwWLPWhfUQcpcv1MIMLVxqmSHmfIzsjA3upFOy60o2XWnbM/TSKYE=@vger.kernel.org, AJvYcCXI9ld2hLr0gUi3+rxUNvvZjE/3NaCGNF5WN3O+ILrTfCEANQwNZeB4ixxo/xXjPt6udRT9emtTsk5CVSiV@vger.kernel.org, AJvYcCXoyrBAHt/1HwrmboHKxNb8FAO8oWKyv7cFDRygVscYhpRGwM12A9N3wv8S9P4LXNoHjW/gIl78WpNo@vger.kernel.org
X-Gm-Message-State: AOJu0YwO1+EScUlC9rXyYwQ1GfdEJifvK1X0pTDyi3HHsanXmetN6fmx
	vuXKHTA/YNYQ3XsnVZWfVL1izmLdy4HwsBnpm4m5SiEfkmpEUCZ4vnJHa10oj/ltXn3P6ADkEFS
	j1w/0nGYuG6BPYq38FcALrcG4o1k=
X-Google-Smtp-Source: AGHT+IEJSjNl67ew/kPaMpct4NgygqQiWkyvtbM7YadAynGTKeolN8FmwqNdGcIY5gfAP4/ZbIo37K3xsytT3gP5a9s=
X-Received: by 2002:a05:6820:2707:b0:5d5:d7fc:955c with SMTP id
 006d021491bc7-5dfacf88d18mr2406264eaf.5.1725026228895; Fri, 30 Aug 2024
 06:57:08 -0700 (PDT)
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
In-Reply-To: <CAJvTdKmbwtrUmCAJxXb7UVJuVAyMLec2AF--AHbiy+YNhOg5-Q@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 30 Aug 2024 15:56:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gE07+Nin5Weji20M-xOmjyWrixQU5PUnzZt=YWeH+-YA@mail.gmail.com>
Message-ID: <CAJZ5v0gE07+Nin5Weji20M-xOmjyWrixQU5PUnzZt=YWeH+-YA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 7:55=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> On Thu, Aug 29, 2024 at 11:37=E2=80=AFAM Anna-Maria Behnsen
> <anna-maria@linutronix.de> wrote:
>
> > I created a patch for fsleep() - only complie tested - which should mak=
e
> > sure that the slack is maximum 25%. What do you think about it? Might i=
t
> > be helpful?
>
> If the purpose of using msleep instead of usleep_range is to lower
> the cost of the timer sub-system....
>
> then I'm not sure that choosing to do an msleep instead of a usleep_range
> based on the timer duration makes any sense.
>
> The lighter overhead of the msleep is something that is more important
> when there are more timers.  More timers is not the same as longer timers=
.

My understanding is that when a new timer is added, it is not actually
known how many timers there are overall in use in the system, so it is
generally better to use a more lightweight variant in case there are
many of them.

However, the more lightweight variant is not suitable for short sleep
durations because it adds bloat of 2 jiffies (after the recent change
from Anna-Maria), so the idea is to start using msleep() at the point
when the bloat added by it starts to be comparable to the delta
between the usleep_range() arguments (used for short sleeps).

Now, because it is not known exactly what timer precision is required,
some assumptions need to be made and IMV it is reasonable to assume
that the actual sleep duration is expected to be somewhat greater than
requested, but it is also not expected to be much greater than
requested, so using a fraction of the requested sleep time as the
usleep_range() makes sense to me.

Of course, you can argue that in the ACPI case there are those
high-count loops and so more exact sleep durations are better, but
realistically this is mostly about system suspend/resume times and the
difference is not something that cannot be tolerated in that case IMV.
Also it would be better to avoid running those high-count loops in the
first place.

Overall, if my understanding is correct, I generally agree with
Anna-Maria's approach.

