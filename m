Return-Path: <linux-acpi+bounces-14256-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F766AD3350
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 12:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC19716CC70
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 10:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95828641D;
	Tue, 10 Jun 2025 10:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zAb5QAI7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6F25D8F5;
	Tue, 10 Jun 2025 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749550334; cv=none; b=G1Xguc4HLIf3J9cazSmFbktuzeuHvnPBXorgS5g561nzU2Klqi2nn5hU2/JyiiygXUtoSX2CYpH9EeJOXtMSVTSpBh5Hy266wlWSCgSieWG5UHsz6r94dUFyY+n9A5fpx9o4yDdrTMAJYZMM5zB7PP+5KMHWnaXD3o3FLS4Xx2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749550334; c=relaxed/simple;
	bh=jVUjjE3yMF53YSvxU2Mj1UYztPi7oHwNW3NrlZTr1gQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ic/wBZZsIOXA9ocGVIh/R9Jv3KjHZ9E1KjXiFXvOYlFzeZ74AMSE/zcYm3dW8QfPk/GlcwuWxrZ1xZZadb6W8s1pUPwq/UCExpMoSZ12Oa+unctc0vXQGBdRCtfmtLik/GJ16pBXmglzZt1ZABaDCO6zD+LkQMEBoMGOM8R/gtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zAb5QAI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4226CC4CEEF;
	Tue, 10 Jun 2025 10:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749550333;
	bh=jVUjjE3yMF53YSvxU2Mj1UYztPi7oHwNW3NrlZTr1gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zAb5QAI740qKd4KoRot40vHcCH2uxHDgBX5ctCniDCxFVsOOZvM72SGuoSqb1Vfxs
	 heVv2fF/oiigy0ybX/z3ysj44I3mCFqU2nfnhhQbzXlu41HP1QWnPiwx8xZzm7R+Dw
	 L4DKQCsUrwHAYDRXeys7fXxKu21oodilfX0zZgMw=
Date: Tue, 10 Jun 2025 12:12:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, rafael.j.wysocki@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Cheatham <Benjamin.Cheatham@amd.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 0/3] CXL: ACPI: faux: Fix cxl_core.ko module load
 regression
Message-ID: <2025061002-reattach-sliced-0690@gregkh>
References: <20250607033228.1475625-1-dan.j.williams@intel.com>
 <2af31ff8-eee0-4868-8f97-2a390910f9ed@intel.com>
 <CAJZ5v0j5+iB97rTqtOoFB0zpHzNOOHGOQVz51ZU--=4AcUPf-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j5+iB97rTqtOoFB0zpHzNOOHGOQVz51ZU--=4AcUPf-Q@mail.gmail.com>

On Mon, Jun 09, 2025 at 08:58:26PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 9, 2025 at 5:04 PM Dave Jiang <dave.jiang@intel.com> wrote:
> >
> >
> >
> > On 6/6/25 8:32 PM, Dan Williams wrote:
> > > git bisect flags:
> > >
> > > 6cb9441bfe8d ("ACPI: APEI: EINJ: Transition to the faux device interface")
> > >
> > > ...as the reason basic CXL unit tests are failing on latest mainline. In
> > > addition to the fix to einj-core.c, this also needs some updates to
> > > faux_device to make it behave more like platform_driver_probe(). Details
> > > in the individual patches.
> > >
> > > Dan Williams (3):
> > >   driver core: faux: Suppress bind attributes
> > >   driver core: faux: Quiet probe failures
> > >   ACPI: APEI: EINJ: Do not fail einj_init() on faux_device_create()
> > >     failure
> >
> > LGTM
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> >
> > >
> > >  drivers/acpi/apei/einj-core.c | 9 +++------
> > >  drivers/base/faux.c           | 3 ++-
> > >  2 files changed, 5 insertions(+), 7 deletions(-)
> 
> Greg, I think it's better if I route this through the ACPI tree as the
> issue being fixed was introduced through it.
> 
> Any concerns regarding this?

None from me!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

