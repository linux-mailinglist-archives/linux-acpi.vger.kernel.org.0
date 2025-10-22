Return-Path: <linux-acpi+bounces-18127-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F44BFE232
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 22:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB5DD4EDE27
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB62F9DB1;
	Wed, 22 Oct 2025 20:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APPwvYzV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582242F9C23
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 20:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164250; cv=none; b=VvURp/AlTP70nASXtTZRiECYBseNn5tP/+1IEsKmxenayvMph9jj4sIg/6k28QavWq0rZ5EVStlCMYHxqLkuX+4RE1RFLMUmC5uMxQEvAh75mZkphMATcnN6oP7Ux1q5Z4BMt55f7wE6cfGMlQUeM7a4lvZMlqLiRJ429H9AYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164250; c=relaxed/simple;
	bh=JGMbXTZdrtIxOb4jaBk69OdjiE1euFv+M7ETeX5T0g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIdEVR2W87/aSXH8+O+1Ld13elaiyDoHdIQcjd8a2B8mUIDvkU4NECwYysWwLJsDHRA7jLe7RmsMm6SCKsEK8zcj0L1LYm9GwNbczqJ43T3cio/IVp06QVg2S7G8yksAuModvsbu3g9Ye0pu17iX1juqwY6VtfWD2iu1JuiESXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APPwvYzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5090AC4CEE7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761164249;
	bh=JGMbXTZdrtIxOb4jaBk69OdjiE1euFv+M7ETeX5T0g0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=APPwvYzVKDjVmdvn2uKo4m+S7cSnxOpscuzHomvITvMbGREmV9vWWDvHH7tR2bnQo
	 N7aUvpbTgdj7beUhvujKZ16/qdABvc6L5/HLA01XC2XW5i0AuA6UXp3fhXJ9DOkG0v
	 XJqd+dQ6gPdrXsUrwo30fA/SIQsUQIn/9tP6Txs7B4slEiEo3HpqlPdUZyFtQ73SnZ
	 501Vky0yJkPCtaikrKjxzPbvSMhK2ckpZ0W9tlBCxEecn6sW3Od6LYBlFyxbtKxxQF
	 IS9/Eb4iYfHBQ9f4Rfz3fBqiZIwkwlFyUHDrR7BxV89hhlNjm4QLrkQwa7DdtCWZ8W
	 5YzBu0bvngVJg==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-442003b80d0so4293b6e.1
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 13:17:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVWBxXb1KuNTE/a30vCvoiY1RXz6JWnNjG8EsilSvophCly5d7zcRty2AYB+T/HC3h0sOxudsc4aGIk@vger.kernel.org
X-Gm-Message-State: AOJu0YzymuZzB42yD/xqNNF+vKIBFvsidCpQStr5ge6VqYtLWIMt0ZgQ
	0Fu5LaOMpQfmY7HpEFjhMA41ky8OBZPW/WcqjitFhwVv7gJUIJo29IzoGBJKf/+hUr20MetwU0U
	MV57JL4j+L4knsjAt6q7vVGM/CuLx4rw=
X-Google-Smtp-Source: AGHT+IH+CNkVthHlovh/E8dHwiFqzD17c0+wpBTUJF/HRI2S6F0jYBrCtYhuLx+6NI87pOACS8nCibAdN+28ltbBvUU=
X-Received: by 2002:a05:6808:2117:b0:40b:a4ca:f7cb with SMTP id
 5614622812f47-44964379933mr2114946b6e.15.1761164248601; Wed, 22 Oct 2025
 13:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007102237.1015610-1-kaushlendra.kumar@intel.com>
 <CAJZ5v0jr4yNxGD8Zhcotqy+6acmh5MeNwVQWYzaWSxKMsP0fzg@mail.gmail.com> <aPk3URcrjx_KjkJ7@agluck-desk3>
In-Reply-To: <aPk3URcrjx_KjkJ7@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 22:17:17 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6_d6mGMWVY_49t-y0D+sO-e6N5w7-WejPYHLb8QjnKQ@mail.gmail.com>
X-Gm-Features: AS18NWBeCuXJx62D5Evht34Wj8uGbeZj7yL7NGAhAna4KaPliYC1DF7bj3PXY9A
Message-ID: <CAJZ5v0j6_d6mGMWVY_49t-y0D+sO-e6N5w7-WejPYHLb8QjnKQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: mrrm: Fix memory leaks and improve error handling
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Kaushlendra Kumar <kaushlendra.kumar@intel.com>, lenb@kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 9:58=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> On Wed, Oct 22, 2025 at 09:31:29PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 7, 2025 at 12:24=E2=80=AFPM Kaushlendra Kumar
> > <kaushlendra.kumar@intel.com> wrote:
> > >
> > > Add proper error handling and resource cleanup to prevent memory leak=
s
> > > in add_boot_memory_ranges(). The function now checks for NULL return
> > > from kobject_create_and_add(), frees allocated names after use, and
> > > implements a cleanup path that removes previously created sysfs group=
s
> > > and kobjects on failure.
> > >
> > > This prevents resource leaks when kobject creation or sysfs group
> > > creation fails during boot memory range initialization.
> > >
> > > Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> > > ---
> > >  drivers/acpi/acpi_mrrm.c | 33 +++++++++++++++++++++++++++++----
> > >  1 file changed, 29 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> > > index 47ea3ccc2142..6ec42eb48783 100644
> > > --- a/drivers/acpi/acpi_mrrm.c
> > > +++ b/drivers/acpi/acpi_mrrm.c
> > > @@ -152,23 +152,48 @@ static __init int add_boot_memory_ranges(void)
> > >         struct kobject *pkobj, *kobj;
> > >         int ret =3D -EINVAL;
> > >         char *name;
> > > +       int i;
> > >
> > >         pkobj =3D kobject_create_and_add("memory_ranges", acpi_kobj);
> > > +       if (!pkobj)
> > > +               return -ENOMEM;
> > >
> > > -       for (int i =3D 0; i < mrrm_mem_entry_num; i++) {
> >
> > Yes, i should be declared in the preamble.
> >
> > > +       for (i =3D 0; i < mrrm_mem_entry_num; i++) {
> > >                 name =3D kasprintf(GFP_KERNEL, "range%d", i);
> > >                 if (!name) {
> > >                         ret =3D -ENOMEM;
> > > -                       break;
> > > +                       goto cleanup;
> > >                 }
> > >
> > >                 kobj =3D kobject_create_and_add(name, pkobj);
> > > +               kfree(name);
> >
> > OK, this fixes a memory leak.
>
> I didn't realize that kobject_create_and_add() made its own copy of
> the "name" parameter.  Maybe the code should avoid the alloc/free by
> making "name" a local variable?
>
>         char name[16] =3D "rangeXXXXXXXXXX";
>
>         sprintf(&name[5], "%d", i);

That'd work.

> > > +               if (!kobj) {
> > > +                       ret =3D -ENOMEM;
> > > +                       goto cleanup;
> >
> > Why terminate this?  Why not continue?
>
> Terminating here (and below) will go to Kaushlendra's cleanup
> code to remove all the ranges. Maybe this is better than having
> some random subset of files appear (based on which allocations
> succeeded/failed)?

Well, I guess it can be argued both ways and either one is fine with
me.  If that's what you prefer, let it be done, but the changelog
needs a bit of work because the cleanup is done in error cases.

> > > +               }
> > >
> > >                 ret =3D sysfs_create_groups(kobj, memory_range_groups=
);
> > > -               if (ret)
> > > -                       return ret;
> >
> > Well, this returns already, but I'm not sure why.  Tony, wouldn't it
> > be better to continue?
> >
> > > +               if (ret) {
> > > +                       kobject_put(kobj);
> > > +                       goto cleanup;
> >
> > I would do a "continue" instead.
> >
> > > +               }
> > >         }
> > >
> > > +       return 0;
> > > +
> > > +cleanup:
> > > +       for (int j =3D 0; j < i; j++) {
> > > +               char cleanup_name[32];
> > > +               struct kobject *cleanup_kobj;
> > > +
> > > +               snprintf(cleanup_name, sizeof(cleanup_name), "range%d=
", j);
> > > +               cleanup_kobj =3D kobject_get(pkobj);
> > > +               if (cleanup_kobj) {
> > > +                       sysfs_remove_groups(cleanup_kobj, memory_rang=
e_groups);
> > > +                       kobject_put(cleanup_kobj);
> > > +               }
> > > +       }
> > > +       kobject_put(pkobj);
> > >         return ret;
> > >  }
> > >
> > > --
>
> -Tony

