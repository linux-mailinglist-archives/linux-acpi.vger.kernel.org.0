Return-Path: <linux-acpi+bounces-19014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D783C69042
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 12:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C3365881
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 11:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF834CFC1;
	Tue, 18 Nov 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P7UxnSHR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9E930F938;
	Tue, 18 Nov 2025 11:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464378; cv=none; b=cGBNezo/BTt3t9BTJeffJ36lqLygimGCMKM+695RNaODNXMMrDNmvmNRtwO6+Qvj2w4ZBZdWGXL8K5DDc7h1pYQpnYofoKGGH79iWmOc1rKOmxLemG5AD2isyiScdk0R/cyiAzmyjGb42B2jqaL73Xx/rpy/g19fCuu0Uo1pwaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464378; c=relaxed/simple;
	bh=38NX44smhgHjsxl1g3basjeODtOlJS+8UZ1jFJsq6jI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ladcjHRy8CU+MBZ0foBsNL78laAdr9J9kj+BQ/prXx7/V6oJ3dhxaIHXU/SkSIvFjWko1LIH+GJw2cU0q/KHD2i2EOtLCA8m6TtTZR51gK2lk7idXfXpBEL+vn/8By/Vwr4Ab1dkY24xMt93fVFCNlCajADAXLCZ+rGnMnQ7L5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P7UxnSHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57637C2BCAF;
	Tue, 18 Nov 2025 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763464377;
	bh=38NX44smhgHjsxl1g3basjeODtOlJS+8UZ1jFJsq6jI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7UxnSHRUXReh7cILxDvqD5xZM1KO/bPMu/rMgtRHscUZBK3Y1GnGaerGvcpDord4
	 GrQaf8SYcFLff2fHMaUpkx5FSUAlGJYsgSM5AVl/d+maIxik2g5qu/GXrxAH0o2Ke/
	 f5ICP8hg21u+EM+uJgqw8B8sVu5JUSSYQ3kS+bII=
Date: Tue, 18 Nov 2025 06:12:47 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 0/8] reset: rework reset-gpios handling
Message-ID: <2025111841-badland-prevalent-5f79@gregkh>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
 <e0e81310332cfdc075bf13f66d7be712b42964ed.camel@pengutronix.de>
 <CAMRc=Mfcir56ZizXgZZpt4nQY234PA9jx3CQ24YCVQJFBQ7msA@mail.gmail.com>
 <7aa5a0ce599f86cc29e5075aa4e35155dfcd013e.camel@pengutronix.de>
 <CAMRc=Me3mOaFpn=xwpDwBzLWjOqS0Gx4rV0E=v_aEg6s_uJyvw@mail.gmail.com>
 <CAMRc=Men0Dc3rokguW-ghsViyMmJzLgvJZtx9ACur5h7U4z_7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Men0Dc3rokguW-ghsViyMmJzLgvJZtx9ACur5h7U4z_7w@mail.gmail.com>

On Thu, Nov 13, 2025 at 01:39:47PM +0100, Bartosz Golaszewski wrote:
> On Thu, Nov 13, 2025 at 1:16 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Thu, 13 Nov 2025 11:30:39 +0100, Philipp Zabel <p.zabel@pengutronix.de> said:
> > > On Mo, 2025-11-10 at 17:57 +0100, Bartosz Golaszewski wrote:
> > >> On Mon, Nov 10, 2025 at 10:02 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > >> >
> > >> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:
> > >> > > NOTE: I've picked up commit e5d527be7e69 ("gpio: swnode: don't use the
> > >> > > swnode's name as the key for GPIO lookup") into my fixes branch and will
> > >> > > send it upstream by the end of this week. It will be part of v6.18-rc5
> > >> > > which tag will need to be the base for the future immutable branch
> > >> > > created by Philipp.
> > >> > >
> > >> > > Software node maintainers: if this versions is good to go, can you leave
> > >> > > your Acks under patches 1-3 and allow Philipp to take it through the
> > >> > > reset tree, provided he creates an immutable branch you can pull from
> > >> > > for v6.19?
> > >> >
> > >> > Now that -rc5 is out, could I get an Ack to create an immutable branch
> > >> > with this series on top of v6.18-rc5 (and merge it into reset/next)?
> > >> >
> > >>
> > >> Hi Philipp,
> > >>
> > >> I assume the Reviewed-by tags by Andy and Sakari under patches 1-3
> > >> make them good enough to go in?
> > >
> > > I assumed I also need an Acked-by by Greg or Rafael.
> > >
> >
> > From MAINTAINERS:
> >
> > SOFTWARE NODES AND DEVICE PROPERTIES
> > R:      Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > R:      Daniel Scally <djrscally@gmail.com>
> > R:      Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > R:      Sakari Ailus <sakari.ailus@linux.intel.com>
> >
> > Looks like neither Greg nor Rafael are mentioned.
> >
> 
> Ah but also:
> 
> DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
> M:      Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> M:      "Rafael J. Wysocki" <rafael@kernel.org>
> M:      Danilo Krummrich <dakr@kernel.org>
> 
> So depending how we look at it. Greg, Rafael, Danilo: can you leave an Ack here?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

