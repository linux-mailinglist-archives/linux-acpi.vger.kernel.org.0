Return-Path: <linux-acpi+bounces-9606-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FA59CF93F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 23:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED1791F21E34
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Nov 2024 22:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70521E284B;
	Fri, 15 Nov 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEW4pC/v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8852B1D5AC0;
	Fri, 15 Nov 2024 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707163; cv=none; b=o0psYvxB8z7v4Pj9ME6gSbtxuiqrrsjIA3RQuuFJxmQGLIRkPE2MjeIbbra2LKj3hCzP7SGAp0ZkuP2bCcQGmxmj8bHe16P/yH4F2geENMLTs8PE//4XKN1sLSGtcVFunzyuXpLeB84N03RHp9Y4y+6TeMf29sEb6UF72nKev1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707163; c=relaxed/simple;
	bh=W7TctSMlsQGJqpMfc4+zMNBob282ceVawKN1+1ktYng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUXBF7kCsZjzHZ2nCEAa1ZzovJD0b9pEmAc9L8CALt9vV0uu2ktb9w9+BZy4I00DEio3zOlFYiAv/FnozhPjiK20g4pNcYUM6AOpfmqKgAD/6k5OU0kdAuoDZ3o7iY6wPTFp0cQ227T3ePWQDaEjrzVOE+m5130c6FzfN6PTK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEW4pC/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289FAC4CED5;
	Fri, 15 Nov 2024 21:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731707163;
	bh=W7TctSMlsQGJqpMfc4+zMNBob282ceVawKN1+1ktYng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jEW4pC/v0mUlfiSH9M2CP+MuEJUjkcQZmCt1GSb69oo94A6hzuJRng3dXgBLgjiY9
	 meOfycjuW4QRTqkFD5CcugOgTN+9FA+Btr0Pl9VgsthMxNETGtZv6vB7z9cY1/9ghI
	 3EqVXbREhFfP/QXeWs47zfB883Evk4QxNnabvq0/zlTSxCRNhR44oGlrpr46oNpqao
	 dXsgUm0WQgvZDfWcUDUEBtji5qrw0VBAyUG1/VcQFVHELrP0fdX9JEaAVKI5l+HOaF
	 J+lR5JAhmxwGz+LBkwtsBral4jvQ+hLFrTjCSbM4JadwnWxSigdM3AFPH+vw1JmgpH
	 pUBlkvoJpDpSg==
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso25010545ad.2;
        Fri, 15 Nov 2024 13:46:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUXyifIJcm0GJj7/oy4SMqSqZCFaM8Zkyl04kpI+dK1SG2Buj5BJguM1S58aCJe5xGt/jmYma2R01U=@vger.kernel.org, AJvYcCWEWRXYqGXlaJnGo8frEW4TG1ZqspXVPUQRmxZ4IFLGBhE2+TrXrPKMSyR07YkljO2VNUb8mCTU/ZU8v46I@vger.kernel.org, AJvYcCWjHfDRFL1ueblggggd/fjzL6IUXiXgDbFMAYqPUkYCRemiThwbBJrtvw2XSp6bvn9k9WDG6OUP+m58@vger.kernel.org
X-Gm-Message-State: AOJu0YznOzTK8554ahLRxrtN36FamPWlfZEChj4KfWlfyhmOk99okw06
	EpIf0zXCPg6cpg1hPjUQXzSvqoY4TPsfkQIv9/wJBZoaaVMI3ItrHHHXHuRL63JY/syJu89poNl
	CiuR9zJHXCYfL51Cp6MJBjJeYMZI=
X-Google-Smtp-Source: AGHT+IHunAD5j21jXmBsA42CR4ORFmofqjxf+dvC0L0ZYDny6cpu6gG6krJBEZ7yvwDGaAnONUmhSyta3e2O9V49KpQ=
X-Received: by 2002:a17:902:d4c3:b0:20c:7661:dcbf with SMTP id
 d9443c01a7336-211d0eeaa0emr49463345ad.55.1731707162741; Fri, 15 Nov 2024
 13:46:02 -0800 (PST)
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
 <CAJZ5v0gE07+Nin5Weji20M-xOmjyWrixQU5PUnzZt=YWeH+-YA@mail.gmail.com> <CAJvTdKm+w_VZ9TQ5bw6=2G4N7CR9xn2qLYAb+p96jC66BXFFug@mail.gmail.com>
In-Reply-To: <CAJvTdKm+w_VZ9TQ5bw6=2G4N7CR9xn2qLYAb+p96jC66BXFFug@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 15 Nov 2024 22:45:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gmtRAQtdi6fdUQDfLv7sKyukb3aXwsdsdtZvSH6QFRnw@mail.gmail.com>
Message-ID: <CAJZ5v0gmtRAQtdi6fdUQDfLv7sKyukb3aXwsdsdtZvSH6QFRnw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 10:20=E2=80=AFPM Len Brown <lenb@kernel.org> wrote:
>
> Re: if short sleep then use usleep_range()
>
> I think we all agree on this.
>
> Though in the ACPI flows that brought up this topic, setting max to
> anything other than min is simply a request for bad performance.

I disagree with the "bad performance" statement.

Performance lower than the possible maximum doesn't necessarily count as "b=
ad".

> Re: if long sleeps then use msleep()
>
> ... because a jiffy based timer effectively forces coalescing, and is
> the lowest overhead.
>
> The problem with this logic is, as you mention, coalescing is a
> function of the distribution of timer expirations over time,it is not
> a function of the duration of those timers.

I just think that high precision is not necessary for long timeouts.

I also don't think that ASL programmers expect high precision in those case=
s.

