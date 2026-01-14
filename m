Return-Path: <linux-acpi+bounces-20322-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF73D1F8F2
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B468E30042A6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 14:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5779A30DD36;
	Wed, 14 Jan 2026 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rUodNLlg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344BB25F988
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402544; cv=none; b=aGh4GSP7Q+fEttUtT5FPUDnL+J+1eLnCZFpJ1QkrF90qHYTtdBrYBeh+745SbsqQ5/YnzUUanHAS/0kqxSsPQMRMVee3+392pJfhSfwUK4TZ03L/Nj90E/ejBdw8mtwV+3llP+px+RKqAiyVPtRouxLtbdV0j4bLAEHqHTz2Of0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402544; c=relaxed/simple;
	bh=CwJ5QpqRYTDGQDdnk5uDIxXneFkxT8YB5Wd1fUL/KxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ut/Gw8UxiFsS7LTnAKpLC+IJASYqcuY+cNtW3KAe0hW9s0tJmLKLvekFbHbeU3Pi+cQD68mjbHOnDRhDzyB1aZba6W+d9Usz5XhFCsW085RdiDKkmaPII8SGr+FnfOfrA2G+96FT08FfWfXyOfxle0IurmppglbQX9ZLghAhX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rUodNLlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01F3C19422
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 14:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768402543;
	bh=CwJ5QpqRYTDGQDdnk5uDIxXneFkxT8YB5Wd1fUL/KxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rUodNLlgBllNW+7mKSSEcYIknca8RHa8wExb7eNABOoeyqAhCr9B0+YaF8WZV4T3S
	 LPKsQpUSBYOD3N5L+R7aodJv9B2udXe9SMu3rIVC5mpM7KAUyY8mVQtPfI0NLL7Lwl
	 qKhFwzYA9O4oOYsPCEY2xT7muAC8Hbz56OS/QpwjrbBL36XCbNZPHSRoLA8GZaVb/p
	 ruaAsOIdXy5PAswN0fRnsfIniS9eGHwDj/EQ4tRCVpkCmgt8rupnrJuGfXj5b7FQI+
	 lWgyopUD2wUu9DCqh/mGO7gc5IpgdHudj2EOD7N2cw3IPWAeO9nrG/mmqXmLuNkT6v
	 QvQvAAaSoE4Sw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-4040882bca9so564228fac.0
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 06:55:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8ShNgh4jq4mFXAvJbFXZqIzTsAA1ALeTzW3W2dzP8cxBQqiIhfZuedi+8uY4a1pyx//C60kCpGSJc@vger.kernel.org
X-Gm-Message-State: AOJu0YzOGrtuLJ4WE/UBVZpdHm2AyLr7/0GTEppvdoyPKniGnOh9QSND
	nAHOzWAYhM9o9knDQeyGRAeaYMyRgjalVGrgLgCq2qWosvwyD2qq/hHwCgpBkFOj6XEmFOt9OkF
	MqHbCf3A/NeMMRT6N7piwrnXTK8xq9hM=
X-Received: by 2002:a05:6870:c284:b0:3d4:3:6548 with SMTP id
 586e51a60fabf-404071d6d06mr2217052fac.45.1768402542983; Wed, 14 Jan 2026
 06:55:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus> <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus> <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com> <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
In-Reply-To: <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 15:55:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jRavdCW-+Ax-aC1_9EmOahhoFLatzQucZiKB9E6TtxOw@mail.gmail.com>
X-Gm-Features: AZwV_QjarpvkpTZR_2kmN2CWZirwih94Mnfj63I-qiBqu7-sMcug9nYeiPhDTgg
Message-ID: <CAJZ5v0jRavdCW-+Ax-aC1_9EmOahhoFLatzQucZiKB9E6TtxOw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>, 
	Jeremy Linton <jeremy.linton@arm.com>, Hanjun Guo <guohanjun@huawei.com>, 
	James Morse <james.morse@arm.com>, Joanthan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 3:28=E2=80=AFPM Feng Tang <feng.tang@linux.alibaba.=
com> wrote:
>
> On Wed, Jan 14, 2026 at 12:36:58PM +0100, Rafael J. Wysocki wrote:
> > > > Sure, that could be an option as long as CONFIG_ACPI_PPTT_ERR_DUMP =
is default
> > > > off and are enabled only when debugging and not always like in dist=
ro images.
> > > > Does that work for you ?
> > >
> > > Yes. It sounds great to me.
> > >
> > > > > We have had this in our tree for a while, and the good part is it=
 gives a
> > > > > direct overview of all the processors and caches in system, you g=
et to
> > > > > know the rough number of them from the index, and items are liste=
d side
> > > > > by side so that some minor error could be very obvious in this co=
mparing
> > > > > mode.
> > > > >
> > > >
> > > > Agreed, but all this info are available to userspace in some form a=
lready.
> > > > What does this dump give other than debugging a broken PPTT ?
> > >
> > > It is mainly for debugging issues. Though we locally has option to du=
mp it
> > > on boot unconditionally to help kernel/BIOS devleoper to have a quick
> > > overview of the PPTT table, as the table gets updated from time to ti=
me,
> > > or sometime the kernel could fail before booting to user space.
> >
> > The kernel message buffer is not a great place for dumping ACPI tables =
though.
>
> Yes.
>
> > If an invalid PPTT prevents the system from booting, print out enough
> > information to identify the cause of the failure.
>
> Good suggestion! We do have some cases that wrong or missing info
> of some ACPI table entries cause boot failure like IORT table.
>
> As for the original issue where kernel printed the error message
> " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> can we just printed out all the CPU entries of the PPTT table?

As I said, print enough information to allow the problem to be
identified.  Please avoid excessive verbosity though.

