Return-Path: <linux-acpi+bounces-13664-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56906AB1D43
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 21:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA0543AB4DE
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582A025D1F0;
	Fri,  9 May 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr8WBHF/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3058521CC60;
	Fri,  9 May 2025 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818770; cv=none; b=gofAGLY4FX1TQajg/5HIIw1FWNOC7PCc/UeHYB5uT/+IoVrMtGb0jP6QV9hjL7AjIFeWZqYT3QUpYZYckJ4gvckS/ufA3DpI+z4PkDCYoq6okEO/S36HG56sK11Nm/OyPXd4qEW4Ooyce33oeE0PKSUPa6ITfb1lnz9LARP+60o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818770; c=relaxed/simple;
	bh=KX5wDv025P3mKqHFA4TQwWOmuFq2r9EE0CNJ7idXzJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ac585jX50mPJDykBcVOUcofOhkwC4jSBus/ppDwDnK1i99mv7sXYv8n8ed5m/xEpFj/A7NltNmV+QD2y16gW8Fwy8QWhqUtnnxdCoEPiktgN3NznY3aoDcbUGErqU4bUdsEqax9BMOhlsEDsItdnFjxiqVFCSsAnk5h3l9kHR8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr8WBHF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D27C4CEEE;
	Fri,  9 May 2025 19:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746818770;
	bh=KX5wDv025P3mKqHFA4TQwWOmuFq2r9EE0CNJ7idXzJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xr8WBHF/As8nQMEvL8FaQrG2ELOdaZhH6DDcTkuOQLzv33IjcDnrAhhZsw1ybmXKs
	 am+6romLsSY6fCFrD36JV02epI5VtEaGjKNuEM6ZY7K8KfVF323TJXcjULBPnwbNiZ
	 9fvot9g/9IFOW48/XRjkIXj9XIglO0frK6X3WqfdfDR1wy4Ugdkwedp9Fl9mgYHUOs
	 UfNNQX/8nrK3hcu7HIn+A8+6myAg1ZiTTQ3WHHuIXgT0Nl3uPAS4gLvKMyPHBxJLB6
	 Z2xJ6RrqZDMOIw+lim974APvwNisG2s1rAELeNj3anfeE+c5Q5EGQCFRe/LyBFHUZs
	 rAiWFoWj4ODFA==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3feb3f54339so2435580b6e.1;
        Fri, 09 May 2025 12:26:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVLF65SOJwQ5qqzZ+fYXyGhA5PbkHfOyaQhc3K2PhV650PtCGeYxbseaCfQtY+j3036Dy0N3xIXgUGFbwOo@vger.kernel.org, AJvYcCVyhVh5MXsQDG7G/AwvoKJqY9KHxClSwyrkJgWf45zzgntBnCABo1aNoUhrVsmSo0zfOr6czcYvd29I@vger.kernel.org
X-Gm-Message-State: AOJu0YwInILbOZTLxTH3KNNjc2lzUDcrKsWJgZ8pv4h22G2Wue1PLXlJ
	20kM1QOJZ5j1LmrMY1prNHBkAOeAngPbNbQXvrw0VQCakKzRpXBN1nTS2DVwu6oP2/W2fY82pfE
	R0TFMt6OaADnVKsWIi7QUgGGfaUg=
X-Google-Smtp-Source: AGHT+IE8GmkxlxVpNu70SxPUR8JfgrMMof4cUdqC8atc5kXLt5jTxXJF796doymX5wIonc+sU/pvkvYOVBUg3NqQh7A=
X-Received: by 2002:a05:6871:6a2:b0:2d4:edac:d9a9 with SMTP id
 586e51a60fabf-2dba42a3b8bmr3120008fac.10.1746818759173; Fri, 09 May 2025
 12:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-5-zaidal@os.amperecomputing.com> <CAJZ5v0j-84MDP10YEL48GTPWy1SqHWAA_Dbq+X-k3PFi9brZPw@mail.gmail.com>
 <aBzwpS6t3V4zwrxn@zaid-VirtualBox>
In-Reply-To: <aBzwpS6t3V4zwrxn@zaid-VirtualBox>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 21:25:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g9qbKWHgL5gmSQN3vAbj3DUZH0LSdxtY2O5JXscbsGFg@mail.gmail.com>
X-Gm-Features: ATxdqUHdAxHQrEBtvpSUAWFQbifenSse2G705J-U4DlXfrsupwkHQXQctlVxRWs
Message-ID: <CAJZ5v0g9qbKWHgL5gmSQN3vAbj3DUZH0LSdxtY2O5JXscbsGFg@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] ACPI: APEI: EINJ: Remove redundant calls to einj_get_available_error_type
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, james.morse@arm.com, 
	tony.luck@intel.com, bp@alien8.de, robert.moore@intel.com, 
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com, Benjamin.Cheatham@amd.com, 
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com, 
	u.kleine-koenig@pengutronix.de, john.allen@amd.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 7:58=E2=80=AFPM Zaid Alali <zaidal@os.amperecomputin=
g.com> wrote:
>
> On Wed, May 07, 2025 at 01:34:35PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 6, 2025 at 11:38=E2=80=AFPM Zaid Alali
> > <zaidal@os.amperecomputing.com> wrote:
> > >
> > > A single call to einj_get_available_error_type in init function is
> > > sufficient to save the return value in a global variable to be used
> > > later in various places in the code. This commit does not introduce
> > > any functional changes, but only removing unnecessary redundant
> > > function calls.
> > >
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> >
> > Does this patch depend on patches [1-3/7]?  If not, I can pick it up
> > as an optimization.
> Hi Rafael,
>
> No, this patch is does not depend on 1-3 patches. You can pick it up!

Now applied as 6.16 material, thanks!

