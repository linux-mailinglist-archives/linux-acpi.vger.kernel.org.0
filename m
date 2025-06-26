Return-Path: <linux-acpi+bounces-14730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97405AEA5CA
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00F63A8CE0
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C2B2ED860;
	Thu, 26 Jun 2025 18:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTVF5Ghi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C8D1DF739;
	Thu, 26 Jun 2025 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963891; cv=none; b=V/Tt98HS8sZ5oYkdpeBhGO+DTlnVmwAOwfXGzf3QXOODo5Hzs4wFJhZFOCy7jI2iEhSmhiTk4YKX5E34QVb2XDrzp4M28mApPn2t86MvvuSvvAi7OvRco0r05QllwvyM10ZwMiQ1VrQ951E4cT6BvR/Lt4SjC0oHUknMM1aR/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963891; c=relaxed/simple;
	bh=ixoT5NhitpjrfHSfNpilzNmz4RhiS3Yw0wiOXcYMDto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XERx4jtKrUM+0pgA9lfiP/dB0ZBrSN8gFROB3V5MXQCkvGfPLbKhYn1Y8sb9hDyEF/5JyE1YXnHhbSZDFQcWUHaJcwVYUjjcG67phxSf7QZ8QcGVlE6Gv/dF3c7BniLzy3iXGIiiSGWICbWpkVefgXCdC1DhQ6cGLWFlEV/U5Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTVF5Ghi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97DEDC4CEF2;
	Thu, 26 Jun 2025 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963890;
	bh=ixoT5NhitpjrfHSfNpilzNmz4RhiS3Yw0wiOXcYMDto=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FTVF5Ghi28mUJhqXMhoYuu0zAdJcwQZltSnnhpgbMz4fG2vJ1exLUEeDYzz1dvIX+
	 A3PFuNZFSW5lhYSbS0mRPRXaV72hYuDOCsuPtv0R73pYpI0yqNdpywsWMN7ElfFxnJ
	 9lzZMdoa+e6G3W8cM06rrV5BplTh5dDJy28YAFwHae/KxoCy5t3jhfDznERBapJ5mB
	 9VgRWvZWERKV+vsgnn/oPvVXghp72pCCGdVLIlJFpXYb3o3qg8ep6GSB9sf3dTDyL1
	 DLEr8CTwqo4AOSULuVDPDouxYUhbkWTmIpsI3AfD+u/mL24oNx5pPifAaj8xbDojfi
	 wLhTQepUdWNvA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-605f7d3215cso600019eaf.0;
        Thu, 26 Jun 2025 11:51:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5Xn6B52vncSCUdpV4/DsNqsNVHsHumt+zK6DYBuTWt/okK1jyANDJSj9+tp8nm98jti2UdJjwL6pE2A==@vger.kernel.org, AJvYcCVWfPUeiJArWkZmrXVCcPdYiFoVctU0N+8tiXHYpNS/JfDx7xc8KKAims5jUwGP6EeRIVR+hu4KqVWQ3lNUnsk=@vger.kernel.org, AJvYcCVj58zD4xgA9ItJ2bznVwrZpVBz2wsieIRWVQWfJEsjokiJItFKEdrBNspuvCvJ+mqa1QNG0ErWFGqxbIKs@vger.kernel.org
X-Gm-Message-State: AOJu0YzXhXvRMREtiN2K01btTX4OEfXBUkZS8xzt8DAB7Tru0VGn7ZLS
	8tmTBhL4i4LYdyOO3iiD2tBxsUlQ/0SOeC1zz+WpXbBgl7XtHEapGrfvDNzLyL4Ea+d/o28dr20
	1GIk2gecy1Hpb8K+FXgPTeX7hwyaLPgo=
X-Google-Smtp-Source: AGHT+IFLkCK23NDeaImDzLQmphj3auL9rRtu+gaPEvhFec/QlInT+DjVA/QuM6Bss0uBshVyFJ22fXR1mN0lxXwPZTU=
X-Received: by 2002:a05:6820:2d07:b0:610:f58e:6bc2 with SMTP id
 006d021491bc7-611b912ea45mr271926eaf.8.1750963889921; Thu, 26 Jun 2025
 11:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624201032.522168-1-colin.i.king@gmail.com> <685b142c66165_2bbf0029417@iweiny-mobl.notmuch>
In-Reply-To: <685b142c66165_2bbf0029417@iweiny-mobl.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:51:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jF+n0s12FVvqWVAAaUJxFq6q7wkd0Fs2TfTwC+jixeTw@mail.gmail.com>
X-Gm-Features: Ac12FXxON0lPqaVyeqlf-J1jdta1uM1Xanby4dJcawyXr2bgMOvm2uXjayfMqLs
Message-ID: <CAJZ5v0jF+n0s12FVvqWVAAaUJxFq6q7wkd0Fs2TfTwC+jixeTw@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix less than zero comparison on
 a size_t variable
To: Ira Weiny <ira.weiny@intel.com>, Colin Ian King <colin.i.king@gmail.com>
Cc: Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	Zaid Alali <zaidal@os.amperecomputing.com>, linux-acpi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:09=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wr=
ote:
>
> Colin Ian King wrote:
> > The check for c < 0 is always false because variable c is a size_t whic=
h
> > is not a signed type. Fix this by making c a ssize_t.
> >
> > Fixes: 90711f7bdf76 ("ACPI: APEI: EINJ: Create debugfs files to enter d=
evice id and syndrome")
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied, thanks!

