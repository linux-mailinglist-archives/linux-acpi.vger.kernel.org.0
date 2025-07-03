Return-Path: <linux-acpi+bounces-14975-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6CBAF7579
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 15:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9CB5633DC
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Jul 2025 13:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96242D979D;
	Thu,  3 Jul 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aREBEIjS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFCA18A6A7;
	Thu,  3 Jul 2025 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549088; cv=none; b=qYYx57DNiqpcSxc2KPCw1MqVrBc/1HFZo2eg4+qdrYj5ZN8sI/jgp2lWlnZDNqJnZnOXignx0V6q1j4YqWzPZ5l/akx7a3fEzT0TvVGETuhv9nphoWbWIkzLoAeOjXCBqyzvEPDmiI4YWLAfB3W46LvL0bKUFRsXiEYm0yCTZEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549088; c=relaxed/simple;
	bh=MMa+jF3el3GtnrW4iX2kpoHYC/QRRb5dOZUixMIAOmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDjfIJb4nULyK0Jp0HDe5E9Q3SRK34L4KA07mReSh7uRctIRB29Vny12yvgy7J31VXIvksOX1bMDtwNbk/pAp2jnh3/an+5UVhBN6DNBUZuHVJ2yuJeXpBqyhzWu8Ga7Rz5ouQz6VWjHO2yr7WZMAyBgHI7Q5t0J1TlmE3xuER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aREBEIjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37579C4CEF0;
	Thu,  3 Jul 2025 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751549088;
	bh=MMa+jF3el3GtnrW4iX2kpoHYC/QRRb5dOZUixMIAOmE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aREBEIjS2yi/Rzluj2Mno2b7cD5JzsPoT0Xld54xcVtyW8rnyg/86mlhCeJwzrWSb
	 igPKiCJeQhs4DsvQQ6ri4khjDdi6ks6oOhMEG5BvfJ4On+eHyFLRevMGT0pLz9YqAZ
	 MbbIrFMIwpigGulvjmPu3caItsCIHHMcAwQUSYSb5Fqby8avyZOiYwC7Eyu5juw47x
	 yhaATv8RNuWNXuoOvgNHPFN9XQh11DpHirNuIvnPPDcf6y4pRWoDAjR6FBc7QanbaT
	 hH03gR4ciGTVE2wUIwn5lrhAL0IkyPC22+hP6ZshxzPfMS1LR/qcaYEykFNycmQBf1
	 GB42idTxDwJgQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-60efc773b5fso4223273eaf.3;
        Thu, 03 Jul 2025 06:24:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfA5kDH9g5KM+7y5LtUWC3BBM9ITzBkjmdbphP+/1srrkxm4Jn8eqYOupphGa6T33U1jZLrc146qUEYiOi@vger.kernel.org, AJvYcCWTV0xDxwXy9veWV8RYE756xjJMlWYqF2zrZYWDYOCNrH0JzHKA6gJMHKppLRTnkTCwG6RbvXjo0gyk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3nPkaqrrxFndbv//nkzKuM/veKKscTjmZtQ6c+Mv4POmBoS2V
	3J8HGadFcLckcNfCmMcKv5QMXMRPZJ7xNC4KXb46fBxvXZ41o2ZgnCFGEVvU7OSxvrhtiiCjBDn
	7UrDG6x+DRrRCmSOkgsaoQR46ttxSVKU=
X-Google-Smtp-Source: AGHT+IGKOaYeS3uSQsqk3L/SgSbNDEzwcQYW/lvR9TwbMrEnG3OB9OGH2Dob8RRBvv9eIGtKPjYf00+J4SGWZYmFLJM=
X-Received: by 2002:a05:6820:c83:b0:60b:ad9e:2bbf with SMTP id
 006d021491bc7-61380a704f9mr1819072eaf.8.1751549087423; Thu, 03 Jul 2025
 06:24:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org> <aGVe4nv18dRHHV16@agluck-desk3>
In-Reply-To: <aGVe4nv18dRHHV16@agluck-desk3>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Jul 2025 15:24:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jx=OG5tTi5u8-sfM5SqwsV=kx_OYMSc3RVitAu+v9oHg@mail.gmail.com>
X-Gm-Features: Ac12FXwZ52lQN_EfOqCn5vgNdSbeFhPO60u_A8pDMR7_gZJCPhSGndway-Yj5_U
Message-ID: <CAJZ5v0jx=OG5tTi5u8-sfM5SqwsV=kx_OYMSc3RVitAu+v9oHg@mail.gmail.com>
Subject: Re: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
To: "Luck, Tony" <tony.luck@intel.com>, Breno Leitao <leitao@debian.org>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 6:31=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wro=
te:
>
> On Wed, Jul 02, 2025 at 08:39:51AM -0700, Breno Leitao wrote:
> > When a GHES (Generic Hardware Error Source) triggers a panic, add the
> > TAINT_MACHINE_CHECK taint flag to the kernel. This explicitly marks the
>
> While it might not strictly be a machine check that caused GHES to
> panic, it seems close enough from the available TAINT options.
>
> So unless someone feels it would be better to create a new TAINT
> flag (TAINT_FATAL_GHES? TAINT_FIRMWARE_REPORTED_FATAL_ERRROR?)
> then this seems OK to me.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.17 material, thanks!

> > kernel as tainted due to a machine check event, improving diagnostics
> > and post-mortem analysis. The taint is set with LOCKDEP_STILL_OK to
> > indicate lockdep remains valid.
> >
> > At large scale deployment, this helps to quickly determin panics that
> > are coming due to hardware failures.
> >
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  drivers/acpi/apei/ghes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index f0584ccad4519..3d44f926afe8e 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -1088,6 +1088,8 @@ static void __ghes_panic(struct ghes *ghes,
> >
> >       __ghes_print_estatus(KERN_EMERG, ghes->generic, estatus);
> >
> > +     add_taint(TAINT_MACHINE_CHECK, LOCKDEP_STILL_OK);
> > +
> >       ghes_clear_estatus(ghes, estatus, buf_paddr, fixmap_idx);
> >
> >       if (!panic_timeout)
> >
> > ---
> > base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
> > change-id: 20250702-add_tain-902925f3eb96
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
> >

