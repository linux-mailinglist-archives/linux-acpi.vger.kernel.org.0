Return-Path: <linux-acpi+bounces-17384-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EFBBA7DAA
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 05:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95CF3A526C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Sep 2025 03:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4125327735;
	Mon, 29 Sep 2025 03:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oXLbvGPT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5FFA92E;
	Mon, 29 Sep 2025 03:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759115720; cv=none; b=DYd7vtWyVG7zbu84L7nWPdDJ94OQsnr9wy8yFS6zFG9fxhtrV9EdfWv1IfF7J7IcJtcv5+vAuHqeqpeLk8XlDwlx7bDd+YRx4OMVRY6cfuuGS4HtMwHM2aNBbaLbXSESB2THNgwmNzoKD45voyKdQk1vwi69UVhxgg1ubCHEVYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759115720; c=relaxed/simple;
	bh=yYkdYbRZgTnnDhLdDpzy0btLglQGn8i4eK9MrfIWpaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XgLVVY6KDYAqeecQghFjB45TE/YwG/vk8xx08wSO/VVzouBHBsHxxrfC/W/IhqOPYxi5NvoKha3u8Xct5pbRbyIEtM6BNvWP0EcOXOHlm5khh0aa8EGknrDK00jCo6kAx2h9m3jgby0WIqPRsYem7Pkw11HW3oAJoBcvWo60wgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oXLbvGPT; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=/dhs7ijfLTghtXAQAWqGmbDRj1oseStsFI46DR79xIE=;
	b=oXLbvGPTl/Y21WI34R0rrhNne1FlPSTfLemqQVSLS16WejO2qxF7ZZGc6joZVY
	vmR3vjdBZKgh+X+o4uJGJuW3TonO98JC3GleQwWxOD39DaMn41dN7hBVoGGgDQ/i
	dj0XAVboHLf8PDSdBVXIyCJhQ66+HT+yURSPssUZM/3HQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBHu3uV+dlorox_BQ--.46998S3;
	Mon, 29 Sep 2025 11:14:30 +0800 (CST)
Date: Mon, 29 Sep 2025 11:14:28 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Subject: Re: [PATCH v3 1/4] cpufreq: Make drivers using CPUFREQ_ETERNAL
 specify transition latency
Message-ID: <aNn5lPYQTPCZ1hPW@dragon>
References: <5069803.31r3eYUQgx@rafael.j.wysocki>
 <2264949.irdbgypaU6@rafael.j.wysocki>
 <aNiqTYZai83Yguqt@dragon>
 <CAJZ5v0j0v6m7uRc0vf2q0W=G8q5hOm5dr5txqTZ2=sScaLaPHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j0v6m7uRc0vf2q0W=G8q5hOm5dr5txqTZ2=sScaLaPHg@mail.gmail.com>
X-CM-TRANSID:Mc8vCgBHu3uV+dlorox_BQ--.46998S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU0b18UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiNRc0mWjZ+ZfB1wAA3G

On Sun, Sep 28, 2025 at 12:00:22PM +0200, Rafael J. Wysocki wrote:
> > > --- a/include/linux/cpufreq.h
> > > +++ b/include/linux/cpufreq.h
> > > @@ -32,6 +32,9 @@
> > >   */
> > >
> > >  #define CPUFREQ_ETERNAL                      (-1)
> > > +
> > > +#define CPUFREQ_DEFAULT_TANSITION_LATENCY_NS NSEC_PER_MSEC
> >
> > Typo of TANSITION, should be CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS.
> 
> Yes, thanks!
> 
> Fixed already because CIs caught it yesterday.

With it fixed:

Tested-by: Shawn Guo <shawnguo@kernel.org> # with cpufreq-dt driver

BTW, a heads-up: the patch won't apply to 6.12 stable kernel directly.

Shawn


