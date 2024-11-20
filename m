Return-Path: <linux-acpi+bounces-9702-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6449D41C8
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50142822EC
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 18:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B572155751;
	Wed, 20 Nov 2024 18:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huIfTlKw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F41512FF69;
	Wed, 20 Nov 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732125799; cv=none; b=GBC+pYTfGquwybd6jw0gbnXq157cLqtGIrnNLZ4GhwiLjK/4jJdxC0RiW3MgKMSCA58tBXWCBoTmpkg2Oq7nT6GeXjUHYQ89l+Etk7kGInRcFqGNFdViDS2OIklCTdDxlBsKTuvSYkW1AuibBc1L0WgnapREwgCRoSTK1zyuXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732125799; c=relaxed/simple;
	bh=rzqUGLhcDtUBPWWurVqZkm82fgTNMmFXQSNKh6JB40U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gg4XfhV2o2OnXqGl9B1fvIiWMyDVmn/dU20gg6yD7qOJxo91TG2lAfrwjdGwucliL6kIqFnRaSZfjfjnVBG1U2qELhsrR7wkGfBp/1jBu/VEyp0ITbduuyTVw5m4llilNRWsG/LrgtZgGFNt4jlysCVEO0xllkn2TG4NcZ2IBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huIfTlKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA28CC4CED6;
	Wed, 20 Nov 2024 18:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732125797;
	bh=rzqUGLhcDtUBPWWurVqZkm82fgTNMmFXQSNKh6JB40U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=huIfTlKwxKm63fcRIUyCBYIhH6Ss7rW+9SNyoufSBZXaL9ZcivmjnK2wm/FZ3yPyt
	 6fh8JAwWeG6bEkH7F2ISOZGqx/w/hsPUBK86fl8MYEYV+IBL8TUeZF1hLCnVTY51a8
	 makaL3AOvV2CELT+QmBNw8yz7UHoa9mofEM5obDIxiTp1gcy9IxO8ChAu1JD5EJwav
	 Pgw4zULOv/Fa8Jtn54O/OCp1rc78dV9fnqO04A6nz1nUbmSO8XB3T4dxcb4M6ntETw
	 ZoSxsTTwf1ot6aUGF7m5sBABY/wKLh6KiTl957jZzl3ZsMVt+xlMfN8RlBHxPGURmO
	 +tZKqtxB0Wu2w==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2967fb53621so549199fac.0;
        Wed, 20 Nov 2024 10:03:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/EL+Lq19/K7aUJTDrmY4ns4n6B26pvOWPs48IS+g5BwF7XPh3d3GDFUTUPUQEbN0XlTeDAm0y4Iw=@vger.kernel.org, AJvYcCU3ZyAStI3leKtHUAsDfH638BHXCxSgzjQk01HvtZP7IaQOOxVDqNgBm/jY/Vpc45PIaOVQ2HgwvG3k@vger.kernel.org, AJvYcCUirt/pV82AoFlreZVSUvSWYAcdZlSBT5f9URCk/x22dYGPq+naeTBGePm7CJOxcaZ0b1l/vOHldl7wj6j1@vger.kernel.org
X-Gm-Message-State: AOJu0YyOl8rzfnzcFMeHva5EqfzIib+zXgpFeEP3KKb6vQLMBWC/SDDg
	7DtnowZBnQQNeZWPm2d6xdg030XVvoShq5x1eHzdFzJ0qHbVwnUv7rQAKY5oEcz07/Sd8u8IooB
	SpKOJPexh/dk2lixb6lZG3YxMCuQ=
X-Google-Smtp-Source: AGHT+IHcX669aCzN/JNnDflvVmyMv8Rqi33QgvCio5Bu72gppGBfwL7Ob4Gv+EeU+JKo8QF/Moc+/C7Kv7QJKJ1YiBM=
X-Received: by 2002:a05:6870:e387:b0:296:da1:88de with SMTP id
 586e51a60fabf-296fcd4bd7dmr246543fac.10.1732125797080; Wed, 20 Nov 2024
 10:03:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7db7e804c453629c116d508558eaf46477a2d73.1731708405.git.len.brown@intel.com>
 <CAJZ5v0iC3mX7Yh_ETTw4FY3xUbZeAUgS0Nc9_88fnT1q5EGWyA@mail.gmail.com>
 <90818e23-0bdb-40ad-b2f9-5117c7d8045e@linux.intel.com> <CAJZ5v0gxNEQx5Q+KXs-AMn=bt7GD=jU-TseMHUc5mHp0tKSBtA@mail.gmail.com>
 <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com>
In-Reply-To: <0147ea1a-3595-47ae-a9d5-5625b267b7a8@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 20 Nov 2024 19:03:06 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
Message-ID: <CAJZ5v0itnn3T4bwiAO3eAoKH4mLFYswcNWBx6JCrK1GFDEy7vg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Replace msleep() with usleep_range() in acpi_os_sleep().
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, anna-maria@linutronix.de, 
	tglx@linutronix.de, peterz@infradead.org, frederic@kernel.org, corbet@lwn.net, 
	akpm@linux-foundation.org, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Len Brown <len.brown@intel.com>, Todd Brandt <todd.e.brandt@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 4:08=E2=80=AFPM Arjan van de Ven <arjan@linux.intel=
.com> wrote:
>
> On 11/19/2024 5:42 AM, Rafael J. Wysocki wrote:
> > On Mon, Nov 18, 2024 at 3:35=E2=80=AFPM Arjan van de Ven <arjan@linux.i=
ntel.com> wrote:
> >>
> >>> And the argument seems to be that it is better to always use more
> >>> resources in a given path (ACPI sleep in this particular case) than t=
o
> >>> be somewhat inaccurate which is visible in some cases.
> >>>
> >>> This would mean that hrtimers should always be used everywhere, but t=
hey aren't.
> >>
> >> more or less rule of thumb is that regular timers are optimized for no=
t firing case
> >> (e.g. timeouts that get deleted when the actual event happens) while h=
rtimers
> >> are optimized for the case where the timer is expected to fire.
> >
> > I've heard that, which makes me wonder why msleep() is still there.
> >
> > One thing that's rarely mentioned is that programming a timer in HW
> > actually takes time, so if it is done too often, it hurts performance
> > through latency (even if this is the TSC deadline timer).
>
> yup and this is why you want to group events together "somewhat", and whi=
ch is why
> we have slack, to allow that to happen

So what do you think would be the minimum slack to use in this case?

I thought about something on the order of 199 us, but now I'm thinking
that 50 us would work too.  Less than this - I'm not sure.

