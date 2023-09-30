Return-Path: <linux-acpi+bounces-304-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30557B3FF5
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 12:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9A056281E90
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 10:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833C4BA3A
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Sep 2023 10:30:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3023AA;
	Sat, 30 Sep 2023 09:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27E9C433C7;
	Sat, 30 Sep 2023 09:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1696066728;
	bh=IvpiOG/bGE3T67kaLiqC3a217xhno8NefOjxFtDtAkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WaJVTLBeni9ABYwJGH6p5NdtU/RU11lfOkq4o8gQbfieAj6Xnu0oPttIzCz/pyfLD
	 zfTdBg1nNBQgV/qTj+JiGRQfkYtvcqEH6wKhSQRy3qHNAswsL8/wJRZIiqy/KwH3qN
	 XJnhdlMtd5WJtvr9+PF0pxAhe4SXcD3e669r7MFw=
Date: Sat, 30 Sep 2023 11:38:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>, llvm@lists.linux.dev,
	alsa-devel@alsa-project.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Replace custom implementation of
 COUNT_ARGS()
Message-ID: <2023093029-balmy-shrewdly-3e3d@gregkh>
References: <20230920153819.2069869-1-andriy.shevchenko@linux.intel.com>
 <CAKwvOd=7vk2HKOpgVrRd2RtKSF9tXPqbVmN+5teLTNoBy4BWVg@mail.gmail.com>
 <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdkbcUh+tmsNcT4nCzFY37WbAUdjHJ62qNe=p8SetaQNTQ@mail.gmail.com>

On Fri, Sep 29, 2023 at 09:10:11AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 20, 2023 at 9:50 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Sep 20, 2023 at 8:38 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > Replace custom and non-portable implementation of COUNT_ARGS().
> > >
> > > Fixes: e64b674bc9d7 ("software node: implement reference properties")
> > > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Closes: https://lore.kernel.org/r/ZQoILN6QCjzosCOs@google.com
> >
> > Thanks for the patch!
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/1935
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Of course Linux would have a macro for this!  I should have known.
> > Trying to wrap my head around it. Awesome
> 
> (resending as text/plain)
> 
> Can someone pick this up for linux-next?
> 
> CI for linux-next has been red for days over this.

Will do, give me a chance to catch up...

greg k-h

