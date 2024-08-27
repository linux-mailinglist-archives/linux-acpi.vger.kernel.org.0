Return-Path: <linux-acpi+bounces-7869-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2949608AC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 13:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF73A2822F2
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016BB19F467;
	Tue, 27 Aug 2024 11:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puV1QpwR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73C315535A;
	Tue, 27 Aug 2024 11:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758152; cv=none; b=BvPzpOEgCyn4IqrydiYwDeDnhLYC72dRqPtxpWX1pETyS/2AC4jsWgY/GTbqwHkrQ8MP8nLTEzu3sFCIT8JZCh9dtEkp5qoC4qJm/w/z65MGsox0HW8V8m+Izbfb5O1USFVENlpu48ajsrn7CMUrLjrYk49SH2804z+thOIUshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758152; c=relaxed/simple;
	bh=7hG0IYA1h2hw7SvTKbJ20PPbF9uHd2tn3lDRrv/IAX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYwIteYMuQWzjfyO8rEtZY9ZsOnjWIwomnRTxzCGFmoQDHeObXHtFUGmbD6uIvZvkfFPKlK4Lx4QCqhbMzQEsuAw5g7Ry+VmQh+iwLvyl4MWRnsVg0QoxxPQXpPoaKNc+4pYJ3jDKOw/+S2YK+vGXUXrQsuWmQax8PobjSSg7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puV1QpwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B55AC58282;
	Tue, 27 Aug 2024 11:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724758152;
	bh=7hG0IYA1h2hw7SvTKbJ20PPbF9uHd2tn3lDRrv/IAX8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=puV1QpwRLkXJWyL/TTeIrYISl/Lb67ZLV10fHXiwc6YbxzTDFPzhWZOylvmTkxycm
	 5aqIC2m1iatFIFOejCAKb1qVL6UkY4giFq0PQgV1lyhDir/q7SlOX07P7V+nvdBj9N
	 ks6C1S496BpufxwVYMSMH3I35Nu50TlaC1jYFZCt5uT1S2oyEmh6rZdIdVllnCYIP7
	 UZlDRGwmId+wCvbKGX4tojGsn3s8jsQQECdNULbWhKUEiKa6Se3TUL4EXfwYqCac0E
	 0+mIsa7WSDGnpLvn8umW1pd+kDClbVKApotcoX5ojl8eFAEt1uRXDyJkuZY25PMg3/
	 tJNYU8ztVo7Iw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-27018df4ff3so4170999fac.1;
        Tue, 27 Aug 2024 04:29:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWISJIhe1Zn2yj8Xq/ntEnb+w+vmGh9j9MNxrx/bUG3bRQKQ2Mu9fRGFbboPqnJ9BLd38m1YP2ifiWv@vger.kernel.org, AJvYcCWkfdxR8idPeBkrh6Xo9k85eCVI/R27jZk0+Q06XmN7zWnHJUR8CeTh2YLD9euwyuWqq933LBGgftCSpPY0@vger.kernel.org, AJvYcCXJMnqBtZWxvb+bQgDFwnQS0GGA2xlMin+luLTzJ17atfbgo5LRym5L1YjHXbJ81sdLO+04Y64L4PY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xzVCdW+4qodctTmeZGg4APq1SdFXxhwTKzns9YsmsbLt1fGv
	39FAW1WJhHvpQecdoguFfcn7dAdtGiVk1+uXyt8Efs0zS/mCDkha94F9FtiQAK+3r62ZGqo9ZDl
	3hkFlx/IB5P/cPfAc5BtBY8O+LiA=
X-Google-Smtp-Source: AGHT+IGluB8OUXeTRU3WcYxq/C0TwAoctiKqmpfkrFvtB9qB6quMRK/TPKl3uIB6H0P84Ellf2rtm+5yWQAKmr67UFc=
X-Received: by 2002:a05:6870:8993:b0:254:994b:5e6b with SMTP id
 586e51a60fabf-273e66f290fmr14818695fac.44.1724758151783; Tue, 27 Aug 2024
 04:29:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
In-Reply-To: <2803b89021f991662b000f50e45dbaebdcca438a.1724729626.git.len.brown@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 13:29:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
Message-ID: <CAJZ5v0jcOUoN6gDDFkufu8xWF-BHXaSKnXqraHsTkq8JanJXuQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Remove msleep() bloat from acpi_os_sleep()
To: Len Brown <lenb@kernel.org>
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
	Arjan van de Ven <arjan@linux.intel.com>, Todd Brandt <todd.e.brandt@intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

First, let me add a few people who know more about timers than I do.

On Tue, Aug 27, 2024 at 5:42=E2=80=AFAM Len Brown <lenb@kernel.org> wrote:
>
> From: Len Brown <len.brown@intel.com>
>
> Optimize acpi_os_sleep(ms) using usleep_range(floor, ceiling).
> The floor of the range is the exact requested ms,
> with an additional 1ms of slack for sleeps above 20ms.
>
> This reduces  the kernel resume time of the Dell 9300
> to 1,124 ms from 2,471 ms.
>
> The ACPI AML Sleep(ms) method calls acpi_os_sleep(ms),
> which has invoked msleep(ms) since 2013.
>
> But msleep(ms) is based on jiffies, and the rounding-up
> logic to convert to jiffies on a HZ=3D250 system causes
> msleep(5) to bloat to a minimum of a 12ms delay.
> msleep(5) typically takes over 15ms!
>
> As a result, AML delay loops with small Sleep() inside
> magnify the entire loop.  A particularly painful example
> is ACPI support for powering-on ICL and TGL
> thunderbolt/pcie_ports during system resume.
>
> Regarding jiffy-based msleep() being inexpensive
> and hrtimer-based usleep_range() being expensive.
> ACPI AML timer invocations are rare, and so it
> is unlikely the hrtimer cost will be noticible,
> or even measurable.  At the same time, the msleep()
> timer duration bloat is significant enough to
> be noticed by end users.

I'm not sure why you are refusing to follow the implementation of
fsleep() and Documentation/timers/timers-howto.rst and still use
msleep() for sleep durations longer than 20 ms.

Why should usleep_range() be used for 100 ms sleeps, for instance?
This goes against the recommendation in the above document, so is
there a particular reason?

> Regarding usleep_range() timer coalescing.
> It virtually never works during ACPI flows, which
> commonly run when there are few coalescing
> opportunities. As a result, the timers almost
> always expire at the maximum end of their specified range.

I don't think that's the main point of using a nonzero range in
usleep_range().  AFAICS, this is about letting the timekeeping
subsystem know how much you care about timer precision so it can
arrange things to meet everyone's needs.

> It was tempting to use usleep_range(us, us)
> for all values of us.  But 1 ms is added to the
> range for timers over 20ms on the reasoning that
> the AML Sleep interface has a granularity of 1ms,
> most costly loops use duration under 20ms inside,
> and singular long sleeps are unlitly to notice an
> additiona 1ms, so why not allow some coalescing...

So again, why not use msleep() for sleeps longer than 20 ms?

> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D216263
> Signed-off-by: Len Brown <len.brown@intel.com>
> Suggested-by: Arjan van de Ven <arjan@linux.intel.com>
> Tested-by: Todd Brandt <todd.e.brandt@intel.com>
> ---
>  drivers/acpi/osl.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 70af3fbbebe5..c4c76f86cd7a 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -607,7 +607,13 @@ acpi_status acpi_os_remove_interrupt_handler(u32 gsi=
, acpi_osd_handler handler)
>
>  void acpi_os_sleep(u64 ms)
>  {
> -       msleep(ms);
> +       u64 us =3D ms * 1000;
> +
> +       if (us <=3D 20000)
> +               usleep_range(us, us);
> +       else
> +               usleep_range(us, us + 1000);
> +
>  }
>
>  void acpi_os_stall(u32 us)
> --

While I agree with using usleep_range() for sleeps up to 20 ms in
acpi_os_sleep(), I disagree with the patch as is.

Thanks!

