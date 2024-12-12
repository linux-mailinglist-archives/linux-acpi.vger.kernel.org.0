Return-Path: <linux-acpi+bounces-10121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EEF9EE612
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 13:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DFB188966E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 12:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9C8212D61;
	Thu, 12 Dec 2024 11:55:10 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABE7212D8E
	for <linux-acpi@vger.kernel.org>; Thu, 12 Dec 2024 11:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004510; cv=none; b=baz7ldAYTlDH82YMnBIfVaKku+WTDL2sSmgCSnHruDIv5XD8KTKzDdGhvlXeJjF3TUSiP641N1u/hUTrcgjj/ailtZPpkHr4xZ6DASbG3gs/vEu9LsQXrSUimhc7n74K37CUApDxFhTD9r8Qes1/iQasqtNrqxonpzcwS+NGkUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004510; c=relaxed/simple;
	bh=+sNV3cwSmjgxKWkWkMwB6RVSMZl7QcvEaxTcLfnJMjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZWA5nhwgjacO+3C9tyBlnSAwmK/KXF8//YwoPj3vL4PchPtqdTiYtPAoWRf98S2rAPZyaqZiTV42I7XRmoOrawdoW+uwXXIYufJFDzVncZqbt7/DAlFFMvahDPY1stcJE4a/I/MuLuwKJIzi7xIZOm/hFAHyVye7gQi3baXNf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwCHfqkPz1pnMEf6Cg--.28820S2;
	Thu, 12 Dec 2024 19:54:55 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwCn_HgOz1pnLRtoAA--.4841S3;
	Thu, 12 Dec 2024 19:54:55 +0800 (CST)
From: Xiong Yining <xiongyining1480@phytium.com.cn>
To: rafael@kernel.org
Cc: len@kernel.org,
	linux-acpi@vger.kernel.org,
	linx-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] acpi_driver: add CONFIG_ACPI_KERN_DEBUG config to enable KERN_DEBU
Date: Thu, 12 Dec 2024 11:54:51 +0000
Message-Id: <20241212115451.183076-1-xiongyining1480@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0gooYrx7er_gpNG_vickyh05HRt7beN_-RqnV6=h-RdVA@mail.gmail.com>
References: <CAJZ5v0gooYrx7er_gpNG_vickyh05HRt7beN_-RqnV6=h-RdVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwCn_HgOz1pnLRtoAA--.4841S3
X-CM-SenderInfo: x0lr0wp1lqx0bjrumio6sk53xlxphulrpou0/1tbiAQARBmdZ7XkF6wAGsU
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=xiongyinin
	g1480@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxJr1xWF43Ww4rZw1DAF4rGrg_yoW8Xw1fp3
	ySkFn3ArsrJa15Gw40yrWxWFW3A397KrW0kFWku3sruF45CryrAF4vgFy3AFn5Wr17WFWS
	q3ZIgr17GFyDArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

> > In the API module, there is no unified configuration switch to control de=
	bug

> You mean ACPI I suppose?

Oh~, Sorry for the typo.

> > output, and the current approach is to enable debugging by adding "define=
	DEBUG"
> > in the file, which is both cumbersome and difficult to manage. a global d=
	ebug config
> > to control the debug output of the ACPI module will be more easily and cl=
	early.

> So there is only one KERN_DEBUG printk() statement in the entire
  drivers/acpi/ directory, the rest is pr_debug() or dev_dbg() that
  shouldn't need this change.

The original intention of this patch is to manage the printing function 
of all KERN_DEBUG levels in drivers/acpi, including acpi_handle_debug(), 
pr_debug(), and dev_debg().

Why don't pr_debug() need this change?

> > diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> > index cee82b473dc5..ea198ead57d7 100644
> > --- a/drivers/acpi/Kconfig
> > +++ b/drivers/acpi/Kconfig
> > @@ -479,6 +479,12 @@ config ACPI_REDUCED_HARDWARE_ONLY
> >
> >           If you are unsure what to do, do not enable this option.
> >
> > +config ACPI_KERN_DEBUG
> > +       bool "Acpi kernel debugging"

> Please always spell ACPI in capitals.

Got it, thanks.

> > diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> > index eaa09bf52f17..d0a417e73071 100644
> > --- a/drivers/acpi/Makefile
> > +++ b/drivers/acpi/Makefile
> >  ccflags-$(CONFIG_ACPI_DEBUG)   += -DACPI_DEBUG_OUTPUT
> > +ccflags-$(CONFIG_ACPI_KERN_DEBUG)      := -DDEBUG

> Isn't this kind of confusing?

Indeed, i will change. Thanks.


