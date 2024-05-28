Return-Path: <linux-acpi+bounces-6018-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DAE8D138D
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 06:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581AE2844F8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 04:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96C918E25;
	Tue, 28 May 2024 04:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gerK5qzG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B022E3E4;
	Tue, 28 May 2024 04:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872329; cv=none; b=TFs6OCLsH7HJRvYLAVsXw1MnQ+S4pVUVBuATgI8ZahvCN9M33A/WaQUVIt1cp/5P5trxxkkwvmTcFVkCP665T+WDM4sI3/50f1QmmAm78OgJdn0h7r9J4bQjyuzId6JlCypZv7VTOlKue6StEei3Jnks4pkX/Z3lg/3Vj1Ny+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872329; c=relaxed/simple;
	bh=g0uWxA+EkDETOMqnxZO4N0OwEvIr+CGYIgrEz1i8aXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3Uhn4ttUg0a1SI6MSyRcBdLtuuYZ/5W/KDT/MAyh2gBpy6CHABke0coBUWXhbav7DiVrmCuQGoOU9RWVES/DpcRoi82YtwmyPLy9jtWHYfb9sFmUbvTBh0VhyrlXxCOPB8tWE2ZdV1+5MrCU9eu/LAf3zdPDaIWO7+a3rhbR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gerK5qzG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Eh5BAtJ3uEQ80dBJPdgaOaWuguQEYjkhQgomdxcXdM=; b=gerK5qzGlIisOHL3YinkLjQ6gz
	vfWFJjnGex+0etkJ/TSdhaFdCcjXtoVck/vFB4ZNWN1VcWMgXRA41IL2WPHEMrVD3EwMIFd5YoCQ9
	MZSg6ffkRJl/GzRoc7NckJFaSiYd44hGCF87c1XMMPkoIwyaubQMim1CAIfMiB12ayf3Aqzh2liVV
	Xqvu0zJCR91r3ljypYGIVQmHBSmu4JAQnnZkYRh+w2EJquf3JfGVhXAf/cmOZJAFm4V4FCgmBPbo1
	JW8k3U9IXDju6DgZjZ0WCANqWtQ+JUy2L9n39xMgcZGOt+ztoaEN59iGzsvtVzB+2Ke40UxoTErrc
	rrSI9yiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBov3-0000000H3qd-1GlO;
	Tue, 28 May 2024 04:58:41 +0000
Date: Mon, 27 May 2024 21:58:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Guanbing Huang <albanhuang@outlook.com>,
	Guanbing Huang <albanhuang@tencent.com>,
	Woody Suwalski <terraluna977@gmail.com>
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
Message-ID: <ZlVkgf_XCZcZd388@infradead.org>
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, May 27, 2024 at 11:24:24PM +0300, Andy Shevchenko wrote:
> Since we have dev_is_pnp() macro that utilises the address of pnp_bus_type
> variable, the users, which can be compiled as modules, will be failed to
> build. Export the variable to the modules to prevent build breakage.

NAK.  Please move dev_is_pnp out of line and export it (as
EXPORT_SYMBOL_GPL), please.  bus types should be private unless we have
really good reasons for them not to be private.


