Return-Path: <linux-acpi+bounces-8868-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD7A9A6377
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 12:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA1282124
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Oct 2024 10:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720461E8843;
	Mon, 21 Oct 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mg3/2crV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D9539FD6
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506778; cv=none; b=pPhyp2zAA/Q7Us6KMTdVHflBzxZWR7fWyBYLJFjGIFYAh/IQsyk1tIdRUIOyl+clUHph+VOr9oPodspuSU31a5SiIPi3yBwPEUhrYQvBvp172BauH419ZtKfjd07NCbMPW3aG7/oNu6IEm8ij8hgBvkPhv0s3uT098sQpGD68h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506778; c=relaxed/simple;
	bh=AKOcCQBlyzOxI+Cpf9dEjBfxHMvSlhj+Dcp/fOGwOec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSSKCxGrDW2CCDOuJ2JjrM5civPXI65HgWPvg0wQukWz61eUANFS40g8snLXcF/DEH30qbx/f1Le9eudw+lu0+3mUORnEGsF0qf7rnLVbrpwuyhsW2l77hIllQWlPJ9brJMqOklswKg2+o5QFhunxqApdxBvsRgE5ZJImlIoDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mg3/2crV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06EDCC4CEC3
	for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 10:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729506778;
	bh=AKOcCQBlyzOxI+Cpf9dEjBfxHMvSlhj+Dcp/fOGwOec=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mg3/2crVg4QKe9dJwsEnRwVfIzQF8dP3LvZBdK9VU4xN7X1D9brvHuGxDCp/cufvq
	 Hv564Gj/NgG0PqEA6VbdFkaF3ZncgWW2rs439MyPqCsCuZS3Y+yXP4yTVYbJbBECoB
	 176QM84iO789g5jnGsXNT7d2A6N2scy2uLDdQ8h16bSrcn4Ya6avBvwGBAZ/IsT9e+
	 qR55D7AumH95djYUEadVJcjqc41ZM56unScqALq2lSCrYFgvXVVym2zcOyZqQWlZGu
	 ZsR9CWrfiF58YiGxMvoW+ysSC25Eo+Oo860AaqYwXIV4c8AQGoGlilBvxH2HYEUPN8
	 0ZSPuCGle9mSQ==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2891055c448so1476286fac.0
        for <linux-acpi@vger.kernel.org>; Mon, 21 Oct 2024 03:32:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAa4nuQau4BQLiTDQvK3aWgTHn6zGoq0Xa7bv0Bh7MMKsVatlzI7+HNBcvhAseCVG6RAr6tRebZVeg@vger.kernel.org
X-Gm-Message-State: AOJu0YxCUBRF+/5tnl39qM3KwVYEuJm0p+jEDEdqieEb+i0Uhj/w6nB0
	UHJ5E/fOS2I/0dl/st+5V96CFMAA3JaYLsamxqRbSIq5txVnLCOlOX7fCmfAGexgV/NvkwYcJYL
	N86kz82ZOq641GON2K4ELaYBf34g=
X-Google-Smtp-Source: AGHT+IFWjbZukgnLF9TGldtCJ2I/i4qju3X9DKVm9Qix7vSY43rJ4GwTWtNU44cl/Ke3lVFZQ/p+ZYaW/vFg4PvcIGI=
X-Received: by 2002:a05:6870:440e:b0:277:f51d:3ed3 with SMTP id
 586e51a60fabf-2892c2def2emr8571121fac.16.1729506777283; Mon, 21 Oct 2024
 03:32:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003213759.3038862-1-superm1@kernel.org> <20241003213759.3038862-2-superm1@kernel.org>
 <20241018182440.GDZxKn6FkYji_9Xhau@fat_crate.local> <6271aaed-fb4c-4101-82a2-e18aba05b4d4@kernel.org>
 <20241019101042.GCZxOFooaiQPq-Q-2p@fat_crate.local>
In-Reply-To: <20241019101042.GCZxOFooaiQPq-Q-2p@fat_crate.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Oct 2024 12:32:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hw-yxaqfOO4mdnFt8cVci1iVthYBAyH4nx__RJvYBJKQ@mail.gmail.com>
Message-ID: <CAJZ5v0hw-yxaqfOO4mdnFt8cVci1iVthYBAyH4nx__RJvYBJKQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/cpufeatures: Add feature bits for AMD
 heterogeneous processor
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <superm1@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org, 
	linux-acpi@vger.kernel.org, Perry Yuan <perry.yuan@amd.com>, gautham.shenoy@amd.com, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 19, 2024 at 12:11=E2=80=AFPM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Fri, Oct 18, 2024 at 01:31:51PM -0500, Mario Limonciello wrote:
> > 2) Rafael can drop this and the follow on and I'll resubmit with your
> > feedback and we can bring through tip
> >
> > 3) I can amend with the fixes we take through linux-pm/linux-next to av=
oid
> > the acrobatics of 1 or 2.
>
> Since I don't see any conflicts with tip yet and you have other stuff whi=
ch is
> cross-tree, I could review the tip bits and then Rafael can pick them all=
 up
> and route them through the pm tree.
>
> Alternatively, I can route the tip bits through the tip tree and I can gi=
ve
> Rafael an immutable tip branch he can merge and then rebase the remaining=
 pm
> changes ontop.
>
> Rafael?

I'd prefer the former.

