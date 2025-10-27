Return-Path: <linux-acpi+bounces-18255-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF54C111B0
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 20:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11D619A057D
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6036232E153;
	Mon, 27 Oct 2025 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt4pkuuJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC63032D440
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 19:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761593302; cv=none; b=lB5l0OAdDpM2xKQbUIFmV0Yzdbe3SpvarP6c3np7oyRd4VS0hTt7l4HLbPz5E1jj295g/mVCYPgGwVG6bkvybSNKceRJzgoCwso4akM1QzZMTEXB40WC1vM4qwoyij0bfBueAONjcbg16A7fWTP7w/jUCFqjirNb4jhz6EXEW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761593302; c=relaxed/simple;
	bh=0zokk46IuBQfBCLgJ/hc94IOFwbRz7RJTWX+ORw8YeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQM1/fiMaxrCj56/3sIun/TPyorBC1JgiFAdxYMbDjLgkjwyyxJkMG9mIrP2IIuYmUPz0Qsjw3KnAkZq5EPwEX3mV+IuFdDqakHYaVPqEO8QDHkEwbiNPGMVNrtv3Y8afi5GmMHUuBsGwhTIoUaf5/NqlZbRZ7UjJQ2WarPOMJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lt4pkuuJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63e0c6f0adfso5202598d50.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 12:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761593300; x=1762198100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zokk46IuBQfBCLgJ/hc94IOFwbRz7RJTWX+ORw8YeI=;
        b=Lt4pkuuJXn+tfsAxM9Nj1DmEv/fSIHvh0PuZBNRuOTk+NPM7etOR95Q+CG6jheRrZq
         4Er6x+ngh114uRnEB+Ah2PW/h5TmxcRaXl7yCp98NSAR3YOC7+0NmvsR9h1tfIO+BJfh
         yj0nraDuSWrPN34D3TvqLJMUnfV5z72q0HYeHkAdGKk3cnqDHI/lxNwBKKYnD2hQjejm
         jKGcHrPZR8a3PNfF2wTOEKMRReDWFlLoJ1xZTyavkdhMxf4hV/aTNkDaVpHvf11O7C2B
         8NaoDbhgEMwvKpgxXbcXuyVFfjXEbR6dqAFWRouupH4CvdBc43ybtu8myXNNBTa8pTtk
         isVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761593300; x=1762198100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zokk46IuBQfBCLgJ/hc94IOFwbRz7RJTWX+ORw8YeI=;
        b=d6rMQQqVe+tpZCpWpSL3wPYY9ArL8u0WiR8vyZHQZKI3SHoXLKQbJEyr+hOMkpoQFP
         4pIR9t1perpGgtMoWY0cZ18ReWY/uq9vb6hCAisu1j8a5Rvajcrph3wBSeDTL4ocbP9s
         c73rjxWLuVzl6spvDPBq+S47kjJxRnVSxbwW5XsSh/7corl53f2jh1rPtS8322A3KpA/
         H84F+ymmLr15N5IF5MWWgN6uNpRMtoBulQ/XwM2Mb+qFhgL0uGsGz6Gqk+uu7lOHLpxN
         4kBWKBzspupyFQ4qpM6E51iUZvUOXj9zoJV5vFos5NG0JaFRTw27CpU/8WEOp4F7WyCM
         uSxg==
X-Gm-Message-State: AOJu0YzP9KNbgJeiw5cF0SmNDL5HIeoHtRCeTRR3A3d7Dugl43qZCVHp
	3X3pgSayhxrevnsf2YhDCd7jJalqvpl7OZ1wpx+sRCwAVT67bEp646O4QoCR7PvBHgcF74HWLke
	To24R5oOpo2REHf7cKSXM47+pN6UPUT2MZ65y
X-Gm-Gg: ASbGnctr8j/2WfJAHflF0yLOym5NcRen+xZhUHRA9wV6uM2awLahJIuw5NjfLtLks4X
	K36x2y37Vn8RvU5MY2Rk4PLePJwoBySuyJ4HcWWhDt6hUQK1XSSzXCvv1DYTmP3BkzMEfZICttb
	hmGyOg6gv8y/zrY43tMoJknIvlaeA3TzC7M/E5JpzKT8e2u5S0WCZvYEA4F/35ceyd9qwrBIEE4
	gCfzl3jCndWyKudYeFnAijrJvVxSrTrMrrBwR56r++z239llVPnWku+H2Fe2vD2yq2UaXUAk/Xk
	wlc=
X-Google-Smtp-Source: AGHT+IFIjpjJUAV92kqO7/LHZaeTXb+Wrj+OQ5pS6qkST97uoEHRihH1RZ7A105f/WU4mQAGRWDIg0HGvV5UEGZStI8=
X-Received: by 2002:a53:d146:0:b0:63e:1e21:7aef with SMTP id
 956f58d0204a3-63f6ba91dfdmr864331d50.55.1761593299757; Mon, 27 Oct 2025
 12:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com>
 <aPPthnO3bKFhTN3A@ashevche-desk.local> <CAOiHx=npyRdxvN7EywuXTvOMPYQ2FE_T7eVVJtZzh3Di05hxJQ@mail.gmail.com>
 <aPp7GwK4Rb9XZMO6@smile.fi.intel.com>
In-Reply-To: <aPp7GwK4Rb9XZMO6@smile.fi.intel.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Mon, 27 Oct 2025 20:28:08 +0100
X-Gm-Features: AWmQ_bkFd-5uYhsQBqot2p7yUK4rOCRsT1J5_T3JpyiC-PkIZ__nmbTO7rEncGI
Message-ID: <CAOiHx=m01_q_VYvUWYbe9Dtu1C0FqAoiNe5UFVJLy=68fJ7-Wg@mail.gmail.com>
Subject: Re: i2c-mux ACPI parent device references in example
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 8:59=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Oct 21, 2025 at 09:31:54AM +0200, Jonas Gorski wrote:
> > On Sat, Oct 18, 2025 at 9:42=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Oct 08, 2025 at 11:14:37AM +0200, Jonas Gorski wrote:
>
> ...
>
> > > > E.g. should it be "\\_SB.SMB1.MUX0.CH00" instead of "\\_SB.SMB1.CH0=
0"?
> > > >
> > > > FWIW, the references were changed from relative to absolute in e65c=
b011349e
> > > > ("Documentation: ACPI: Fix parent device references").
> > >
> > > Oh, seems to me like a miss from my side. Thanks for a good catch!
> > > Can you send a formal fix patch?
> >
> > Was my plan until my internet connection went down yesterday. Will
> > send it out once it's back.
>
> Is it okay now? Or did I miss the patch?

Getting it fixed took longer than expected, then other things took priority=
.

Patch should be now in your inbox (I hope I got the terminology right).

Best regards,
Jonas

