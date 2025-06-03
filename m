Return-Path: <linux-acpi+bounces-14086-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6A7ACC7D5
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3A8188E403
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Jun 2025 13:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C912040B6;
	Tue,  3 Jun 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="fQMpuw6X"
X-Original-To: linux-acpi@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DAD22DFE8;
	Tue,  3 Jun 2025 13:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748957437; cv=none; b=SCdxn3P1x9waWZTr0hHn3XrsS/e7S+taUChQ6d+geCqoEOEJmw4b16xVgLd52VSgzrrSROZFrdhNu03n+lRz6uV1LJ36kala6x1pavvdczr+xfJLbWW7Ys27NFtGZiY6OQWt+4g0fYLG/xGFTxdgTkYkZ+Tq3iiliRvTAfjxhto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748957437; c=relaxed/simple;
	bh=zaTj2WCKus6LN9iIeEFHBmFy6LVdhen7pT5KRKRjqMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ngBh738oTV3zVyHltRG6FiFnMG25fOd1nfRUowWPSH/8bAn8yfIiz7wYy29Zm//e28YKmeGA4ID2rhMuA+a2BsW9iSVB4w+ckepLRMnW2x5yEi9lSLDVbbRhRYePlwXjkDv7Cf44dxmJ2Z3JEfTPuUq/LIOIYgD+3BM7l/PAGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=fQMpuw6X; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1748957431;
	bh=zaTj2WCKus6LN9iIeEFHBmFy6LVdhen7pT5KRKRjqMs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fQMpuw6XNphUS70DvQkaqmrG+GE+TdjaV6FYMJeMCefz1fCXagpoYJgH1kOTUcqap
	 TlNACzQbyxEu6oQ0yDzPx8gZhwuehoWVmH9j77SjQtfKEJiS9qmB+jodS0BzoehEBE
	 HvU812nautR//a/zDERv25AoQhwqrK42f0c8V2Sg=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 0280265F62;
	Tue,  3 Jun 2025 09:30:27 -0400 (EDT)
Message-ID: <4c2f44c4115eae6b68846da1ec85c5f47ea66122.camel@xry111.site>
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: introduce
 numa_add_reserved_memblk
From: Xi Ruoyao <xry111@xry111.site>
To: Guenter Roeck <linux@roeck-us.net>, Yuquan Wang
	 <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com, rppt@kernel.org, 
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org, 
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com, 
	haibo1.xu@intel.com, david@redhat.com, chenhuacai@kernel.org, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, chenbaozi@phytium.com.cn,
 	loongarch@lists.linux.dev
Date: Tue, 03 Jun 2025 21:30:25 +0800
In-Reply-To: <06a0abfd-5508-4fb5-8a96-a13cf3d8aca7@roeck-us.net>
References: <20250508022719.3941335-1-wangyuquan1236@phytium.com.cn>
	 <06a0abfd-5508-4fb5-8a96-a13cf3d8aca7@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-03 at 06:06 -0700, Guenter Roeck wrote:
> Hi,
>=20
> On Thu, May 08, 2025 at 10:27:19AM +0800, Yuquan Wang wrote:
> > acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> > with the expectation that numa_cleanup_meminfo moves them to
> > numa_reserved_meminfo. There is no need for that indirection when it
> > is
> > known in advance that these unpopulated ranges are meant for
> > numa_reserved_meminfo in support of future hotplug / CXL
> > provisioning.
> >=20
> > Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> > ranges directly.
> >=20
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
>=20
> Just on case this has not been reported yet:
>=20
> Building loongarch:defconfig ... failed
> --------------
> Error log:
> drivers/acpi/numa/srat.c: In function 'acpi_parse_cfmws':
> drivers/acpi/numa/srat.c:467:13: error: implicit declaration of
> function 'numa_add_reserved_memblk'=20

The fix is queued at
https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.g=
it/commit/?h=3Dloongarch-next&id=3Da24f2fb70cb62180486ad4d74f809ff35ddd1cf9


--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

