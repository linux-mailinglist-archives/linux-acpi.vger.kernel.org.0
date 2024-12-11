Return-Path: <linux-acpi+bounces-10086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64299EC75B
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 09:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E95C188C028
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Dec 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5251C5F35;
	Wed, 11 Dec 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHmhAAJz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E4E2451EB;
	Wed, 11 Dec 2024 08:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905919; cv=none; b=CQGAPN97/XgRvSWi3KmcU2eJf6tDhzb+rTdpmqC5Z7oWrxyFs0tsn81dLN/cEP93d1eHrluhKfdoONqtk+nTI6zi4ngTsN7KOnR6q/riSgJIa7BHk0opez6NH6X4L2QtYXiiK2S2sqCEfHsnRsr0iqQJu5niQTYM6B4gC65g1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905919; c=relaxed/simple;
	bh=wYfGk39UOWCkSKleOFWnwE5xreKXyOntKThxjVcTuyM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnt/Etzg3Lk3cf7/JPw0YKkJYdt+AUNWjVnGryaZBQj9wF0BFEV4uIgZ31xT9qKN9iO0aVbmguPw3C7Lp/yZmej4QySwJkls259JuzSotwPdL6tvMQj6w+QzAnGqPHtPs+0/1lYyOMlg1w5/RIyQvzPEjlJuhdZ4zezJuvqCcpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHmhAAJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34DCC4CEDE;
	Wed, 11 Dec 2024 08:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733905918;
	bh=wYfGk39UOWCkSKleOFWnwE5xreKXyOntKThxjVcTuyM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lHmhAAJzzDgkUyuL4TPPoz4BjOPT2r9CW3d3p0Y6AhnNDnTvA9Qs1z8Js9/hNiSQM
	 Nwpwr8PeZr0M7i6giWLgCVr7HAw0vDZPstOSfmSB6DgUbcviS918w0NY8zzAuSLPM+
	 wBeYWrjcg2QOAynBnLzuVI581GJWIWBkSeVZDdTCVdugCbhi4IC8kK1PVF9yxGweFR
	 whQ95yPbxYPDSTec72uQM1N2DYA3InqdMulap4PvQjF7KWARLEXOnapxEXCevzV4K6
	 uVlzD3rhYrhBmxamiTeOO9Wpx64Vv3r8zBrMRKCdGJTnnqp7eJ2cOj2q9odOwrlOxo
	 jfhf67/eJqKvw==
Date: Wed, 11 Dec 2024 09:31:53 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
 <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 1/7] media: ipu-bridge: Fix warning when !ACPI
Message-ID: <20241211093153.7acd91c4@foz.lan>
In-Reply-To: <CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
References: <20241210-fix-ipu-v3-0-00e409c84a6c@chromium.org>
	<20241210-fix-ipu-v3-1-00e409c84a6c@chromium.org>
	<Z1isvGLLwr7jmW5k@kekkonen.localdomain>
	<CANiDSCtFQBNjJoLF1VKR_M4zNHQWwWATu3p=-QQS-d3fY+9KUA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 10 Dec 2024 22:27:32 +0100
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> On Tue, 10 Dec 2024 at 22:04, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Ricardo,
> >
> > On Tue, Dec 10, 2024 at 07:55:58PM +0000, Ricardo Ribalda wrote:  
> > > One of the quirks that we introduced to build with !ACPI && COMPILE_TEST
> > > throws the following smatch warning:
> > > drivers/media/pci/intel/ipu-bridge.c:752 ipu_bridge_ivsc_is_ready() warn: iterator 'i' not incremented
> > >
> > > Fix it by replacing the condition.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>  
> >
> > I've picked this to my tree and I'll take the last one, too, once the rest
> > reaches the media tree.  
> 
> Thanks!
> 
> If you do not mind, I will keep sending 1/7 when I send v3, to make
> sure it is tested by the CI. I will mark it as duplicate in patchwork.

Patches should not be designed to make CI happy, but to ensure that we
have a nice history at Kernel's log. Patch 1/7 shall be merged with
7/7, as you're just artificially breaking it into without a good
reason, making CI happy, but reviewers and maintainers unhappy :-)


Thanks,
Mauro

