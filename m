Return-Path: <linux-acpi+bounces-6022-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD3F8D1518
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 09:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49189B21477
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 07:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70EE71742;
	Tue, 28 May 2024 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HWU6ak5M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D856F079;
	Tue, 28 May 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880448; cv=none; b=lZfLjWcKQtHCU+FCA9ZJ9sSMYRvSQ4DvFPaA20ogKV2Y5aYNmlakNjY3IvZ9wEQjgutlKiZlfc2U+dEztfavoeIju65hVqvZdzYC7doLTOpKHpzAEzWPf6ZJcX7aHUpwR7HEz1IIBSa7kbd17Qdkv3D3KSrBk05bI46QG6HjAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880448; c=relaxed/simple;
	bh=uXnw1Reh+RubFehMoQd6YMz/eVpo/IMoKe/bXh4qbiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ5ktDLMMPwdjpz6ti832IYNGxcp3I/xMSavISVdNZ/G6++2yUAjGVmO286r0lJUOkpAxeeETrvuUBbyr7vamuzWgTizc+wZnp8WPV6animtQrN+GqCXaPE6DCs3nHKCDjGzyIiXh8+zYP6s2I9r+TWkUca+StJ+XNCbf/louOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HWU6ak5M; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d6tOT+HWzQToxHA6SyoYYxfzcDytwtm4xNkrIUfEhcE=; b=HWU6ak5MLnxlYxmThdu5OnG2hw
	oA38kiAL6h3tHyzZJ0u6es9cIVY7WZx+qxO51C94l+6aUfUoSZTSxjTIkZFxeFQJ5hjat6cwCLTRa
	8In49hKIo4JUguTzqIKceUipdz2VTfYJr0vy+Gfb9mMZgILtf/wvwcdUfifHzWQNkTmfcTRQa/a8J
	nGixMGPIA3Ww0zohYP/o3CfaxyxRorpOX3ZjmZfGQZYbD5NdDStlEt0RrEB4ZsNubF7tmC3oqdNLO
	xPonJNorpjPnT1QMTCVo/dNObb3T4MEoTz56jUMiM8qV6UU1ECDccT70UmEWfSx7T43uDT/sMODHQ
	w9+QPKwQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBr22-0000000HI4I-3fMt;
	Tue, 28 May 2024 07:14:02 +0000
Date: Tue, 28 May 2024 00:14:02 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
Message-ID: <ZlWEOnkPhpyTgnKG@infradead.org>
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
 <ZlVkgf_XCZcZd388@infradead.org>
 <CAHp75VftLmV5T9xRnirOMXbJoyvm2eUiG4bDeB6p6hY6jExFQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VftLmV5T9xRnirOMXbJoyvm2eUiG4bDeB6p6hY6jExFQQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 28, 2024 at 10:12:31AM +0300, Andy Shevchenko wrote:
> > NAK.  Please move dev_is_pnp out of line and export it (as
> > EXPORT_SYMBOL_GPL), please.  bus types should be private unless we have
> > really good reasons for them not to be private.
> 
> FWIW, it's not private, it's just not exported to the modules. Are you
> suggesting to hide the bus type completely to make it static? If so,
> this is out of scope of this fix.

Not exporting it is the most important bit.  Making it private would
be even better of course.


