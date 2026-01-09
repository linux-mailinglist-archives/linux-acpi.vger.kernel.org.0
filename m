Return-Path: <linux-acpi+bounces-20123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F6FD0C49F
	for <lists+linux-acpi@lfdr.de>; Fri, 09 Jan 2026 22:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D02D730230D8
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Jan 2026 21:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883E933C519;
	Fri,  9 Jan 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZKa8v7vU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6366F26E6E1
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767993784; cv=none; b=I+jlb1jjhcj/C6rVMm8/8uJ7v2SpIVtTaAlsqn3GpTch6/DkL+Rm6rZXxcDI98D2CJ45gY8j99og+h9iEYQA6If24iFAGlhCy61CQaphJKZyCHrJzjwxdqE3eYYFKP+VOECJedJzM64jJ+S7kn2Vg9ejfCVbsPM9h7yTGiGHjKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767993784; c=relaxed/simple;
	bh=PFga1JS4ZK5Pvyrb763/1AIWjyT/mgxuKEie5G9YDV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/IjlofCyfkRg7Ihhthcp1CWdJPwKe6lJWJRx5zo+MugvZ0HX36g3gaogzH4nKzmxeFvMqYudWL/L/C+WYU3pkuQqvxNZLDkUGpdmAL9xi/Rr6og+CDHlCSuCmafKqQW0KD2qGL1qY4jWLKE6Y10surOXPpUwuEHBz9S6h0THzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZKa8v7vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3DA1C2BCAF
	for <linux-acpi@vger.kernel.org>; Fri,  9 Jan 2026 21:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767993784;
	bh=PFga1JS4ZK5Pvyrb763/1AIWjyT/mgxuKEie5G9YDV0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZKa8v7vUIE8UGdq0lCng5QGe5ubjFT2OhV4SJmcnOGpRP93QccJucrjj8rsKEeCXu
	 TJ4CDQnLADHL5RCct2au+fKRGgV54UUtWCoVmNYM7wcYN3o/tHNT2QAzK+8RBmzfZn
	 u3W8UQcvgBTmpHCL4HeZspMvKPaZDni7S95CDX/uNSqwTIT8jUvOoBzWxaI5fVOJ0i
	 WnqONsZv4qklVF4K3Rfuaa7KiEDtkkvx7gRN5aVY5c5OCAykeIZJo7VpzfnTWUZUu0
	 +QUXDs00KTypeuFUq/XP4z556jjlXGppbmLu4OkHP6y03wB/9GJGDgQHxU2T+L2OOW
	 gj4FQsQUPFDVw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-3f0d1a39cabso3239686fac.3
        for <linux-acpi@vger.kernel.org>; Fri, 09 Jan 2026 13:23:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWC5ZJhUlGw8j/v4bn9jE9J9xORyEqyZVPf6IEGP669mZ3oHkczE0eT5MyTOgEi1lwYIf6ENpaEWei5@vger.kernel.org
X-Gm-Message-State: AOJu0YzFtOoDhECRzBJ5iLoJa6gzdLby5JW4qe2H1pi25QjDpf5OPHqS
	9UhxMxVuxhRwc7IN5+cvM2WWnvnu86sKKZ6GcqXBIuuSUQg0Do3o52Fn4NdYbPznnjiEeruY8DI
	/vnCgo2o7nfi8gri5g63PrqzuTp6Dopw=
X-Google-Smtp-Source: AGHT+IHZSyPS1Z7QIB6IBzx9d6xJmqb5DslCNdNCg+PN+U8bq49/2JHY/9gYG+1CEA5vfJpwk1krttPfFG5aS9nSWAc=
X-Received: by 2002:a05:6871:e2:b0:3f5:45fa:d9b1 with SMTP id
 586e51a60fabf-3ffc0b73049mr6512088fac.45.1767993783052; Fri, 09 Jan 2026
 13:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260104120405.51555-1-xueshuai@linux.alibaba.com>
 <20260104120405.51555-3-xueshuai@linux.alibaba.com> <CAErzpmvQqv6S-XkTf46bzTRQuv3h1LGXFixX-D_bCho-bD+upg@mail.gmail.com>
 <e0ba4b97-7294-443c-a958-6436623d2e96@linux.alibaba.com>
In-Reply-To: <e0ba4b97-7294-443c-a958-6436623d2e96@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 Jan 2026 22:22:51 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jgfXDf4kxpQ7v8xapZw+S8Qc7gmt3txCKN7zptHs1biA@mail.gmail.com>
X-Gm-Features: AQt7F2oo3zqNhqEXf9s-BOnBaYaKbChfQwN03C34xQjpHCPv-8aMLHM5lCe8fqg
Message-ID: <CAJZ5v0jgfXDf4kxpQ7v8xapZw+S8Qc7gmt3txCKN7zptHs1biA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ACPI: APEI: GHES: Extract helper functions for
 error status handling
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Donglin Peng <dolinux.peng@gmail.com>, tony.luck@intel.com, guohanjun@huawei.com, 
	mchehab@kernel.org, yazen.ghannam@amd.com, dave.jiang@intel.com, 
	Smita.KoralahalliChannabasappa@amd.com, leitao@debian.org, 
	pengdonglin@xiaomi.com, baolin.wang@linux.alibaba.com, 
	benjamin.cheatham@amd.com, bp@alien8.de, dan.j.williams@intel.com, 
	james.morse@arm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rafael@kernel.org, zhuo.song@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 6:42=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.co=
m> wrote:
>
>
>
> On 1/5/26 1:12 PM, Donglin Peng wrote:
> > On Sun, Jan 4, 2026 at 8:05=E2=80=AFPM Shuai Xue <xueshuai@linux.alibab=
a.com> wrote:
> >>
> >> Refactors the GHES driver by extracting common functionality into
> >> reusable helper functions:
> >>
> >> 1. ghes_has_active_errors() - Checks if any error sources in a given l=
ist
> >>     have active errors
> >> 2. ghes_map_error_status() - Maps error status address to virtual addr=
ess
> >> 3. ghes_unmap_error_status() - Unmaps error status virtual address
> >>
> >> These helpers eliminate code duplication in the NMI path and prepare f=
or
> >> similar usage in the SEA path in a subsequent patch.
> >>
> >> No functional change intended.
> >>
> >> Tested-by: Tony Luck <tony.luck@intel.com>
> >> Reviewed-by: Tony Luck <tony.luck@intel.com>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >> ---
> >>   drivers/acpi/apei/ghes.c | 93 +++++++++++++++++++++++++++++++-------=
--
> >>   1 file changed, 72 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> >> index 0e97d50b0240..7600063fe263 100644
> >> --- a/drivers/acpi/apei/ghes.c
> >> +++ b/drivers/acpi/apei/ghes.c
> >> @@ -1406,6 +1406,75 @@ static int ghes_in_nmi_spool_from_list(struct l=
ist_head *rcu_list,
> >>          return ret;
> >>   }
> >>
> >> +/**
> >> + * ghes_has_active_errors - Check if there are active errors in error=
 sources
> >> + * @ghes_list: List of GHES entries to check for active errors
> >> + *
> >> + * This function iterates through all GHES entries in the given list =
and
> >> + * checks if any of them has active error status by reading the error
> >> + * status register.
> >> + *
> >> + * Return: true if at least one source has active error, false otherw=
ise.
> >> + */
> >> +static bool __maybe_unused ghes_has_active_errors(struct list_head *g=
hes_list)
> >> +{
> >> +       bool active_error =3D false;
> >> +       struct ghes *ghes;
> >> +
> >> +       rcu_read_lock();
> >
> > Nit: Use `guard(rcu)()` instead of explicit
> > `rcu_read_lock()`/`rcu_read_unlock()`.
> >
> > Thanks,
> > Donglin
> >
>
> Hi, Donglin,
>
> Good point. Will fix in next version.

If you do so, you may also get rid of the active_error local variable.

