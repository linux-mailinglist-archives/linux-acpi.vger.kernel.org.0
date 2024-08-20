Return-Path: <linux-acpi+bounces-7718-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C85AC958A1F
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 16:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729A21F216FB
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 14:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4FA190063;
	Tue, 20 Aug 2024 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1aJM0H/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338BE8F48;
	Tue, 20 Aug 2024 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165387; cv=none; b=H5gTKVScNEpHF9X5APCrRCTsIophg0nbXxN3tNw2OVQZr+RTkl1htLu+OaGu5S+KRZtm9cTTwSA5D/baWUxq+8jVfuwibD3ro5bLrW+OVp0BozmdMNJwEgpimGhgcHiakWe+t8ghg6CDRkq0vrBiMlJTO8/752XfI0RRa7qjRaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165387; c=relaxed/simple;
	bh=qw/VEcxqQoM2pDnSP3JcQLIhSICMUM5FGT0h9VOAXxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po8VLqZ+ljYzCkj0+5qM0Kkpuaax6jSTVZx7VnCfdq8Gijl574XD6okp0ufI2SRbrfOuzib0P0Cs2xvNkIbqa9yVsC/X3GbWkUwY1HufLKvbn5pkuolZEWgwJbBEZTyG8SSeuURAXAzz9IaIJuXKIcT5DHt8AqhCmZKrF+ywS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1aJM0H/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15D1C4AF0F;
	Tue, 20 Aug 2024 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724165386;
	bh=qw/VEcxqQoM2pDnSP3JcQLIhSICMUM5FGT0h9VOAXxM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i1aJM0H/fSWupgC4LGQeqSDwrCiY/BQsHFj6YkriQnyksvFEl3oMtwHz0iMvCHul9
	 AH3Nxt+6UW4XewpmY2pGw1UoqRujGdfA4v5jCMu+WrMvLgCrwtr02wSgU6Xa6bdNTf
	 vu7WzGD7wChwCqmZwZsh36zisOewsOiba2piWAv6oLQUtHUeeNDGccoif4sF3CFFUW
	 ff0Pce9xYf9I4fyMdmart/tir+HJocVzb96ls6qHBOmSD/rtO3hHKjM3EJU0n/SZpH
	 FeLmmJzdsfg/fKF32Ebn9Bquh95bCkp/q+gocNd26OAWGCL2Gj86dNuz1Kt3qcBqFV
	 Q/am38P6xrxxw==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d5bcccb372so713310eaf.3;
        Tue, 20 Aug 2024 07:49:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV1N1LHLkL18BoewffQyCIHOU5b3wEQE+4NveiVe61rFxsDZGeN2Gli2ff0lCFkjw1CX4bL96hbs3XL@vger.kernel.org, AJvYcCV5h/E/vlEEbu2bfaD0PhvcVNLVjo0ZRhE/b6tUdVA+2ZYY0F2RZvh2j7Rx4nOYMwburF1FEgF3A6o7+xKm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1khp7iRy/vbbF4kG/c/QvpYvoylm5GqzzqVtCZdu50I9BH+4Y
	gV/fd+tf3FIeybh3fvWw3mTOoX1SfoIAaU8qBwJsk3LlAfLDDZkGiwG7IxbGcvY9TZWdRGFtv1q
	cJmih6vMn0bRLpI1x6pxU+napHS8=
X-Google-Smtp-Source: AGHT+IGy2wBSezc9HPxiTT41EngIzAclBa/MhtCJTWWZ2xuKGJ97wqhtM+7EtEqYq+0/FwTMZs4fqV3AhjBRUVTKaxI=
X-Received: by 2002:a4a:ba09:0:b0:5cd:8f2:5c8d with SMTP id
 006d021491bc7-5da980087a5mr8507628eaf.2.1724165386100; Tue, 20 Aug 2024
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812144018.360847-1-Shyam-sundar.S-k@amd.com> <ZrpFU6wFyQDykSlO@smile.fi.intel.com>
In-Reply-To: <ZrpFU6wFyQDykSlO@smile.fi.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Aug 2024 16:49:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0guWb4fK0DB1t2MMGvYXBrVoq52Fo_ZgzEqyF_OndqsLQ@mail.gmail.com>
Message-ID: <CAJZ5v0guWb4fK0DB1t2MMGvYXBrVoq52Fo_ZgzEqyF_OndqsLQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: APD: Add AMDI0015 as platform device
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Shyam Sundar S K <shyam-sundar.s-k@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sanket Goswami <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:24=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 12, 2024 at 08:10:18PM +0530, Shyam Sundar S K wrote:
> > Add AMDI0015 to the ACPI APD support list to ensure correct clock setti=
ngs
> > for the I3C device on the latest AMD platforms.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> from the ACPI ID perspective.

I've replaced the v1 that has been applied for some time already with
this one, but please note that it still is not entirely clean.

Namely, if there are two S-o-b targs on a patch, 2 cases are possible:

(1) The person sending it is not its author and merely sends someone
else's work adding an S-o-b to document a "supply chain link".  In
this case, the From: header should point to the original author (it
can be added right before the changelog) and its value should match
the other S-o-b tag exactly.

(2) The person sending it is one of its authors.  In this case, a
Co-developed-by tag should be added to point to the other author and
its value should match the other S-o-b tag exactly.

I've assumed (2) and added "Co-developed-by: Sanket Goswami
<Sanket.Goswami@amd.com>" to the commit, but that's not something I
should be doing.

Thanks!

