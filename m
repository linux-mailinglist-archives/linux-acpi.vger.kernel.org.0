Return-Path: <linux-acpi+bounces-19982-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00016CF94E2
	for <lists+linux-acpi@lfdr.de>; Tue, 06 Jan 2026 17:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D466130591D5
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Jan 2026 16:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05ED312814;
	Tue,  6 Jan 2026 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D06gqExQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB04240604;
	Tue,  6 Jan 2026 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767716173; cv=none; b=Z3umuEuhds06w23bO5r7bXrU2/UGigAZecnB/tb8jGHV6vyWJCjnOHqmpMj/nCbn8LE9xClxIncCPXPaGx4az+EOS9wvODqIFU9I+4lwna4yFm7WkKhFAY93Dwzwr+N1proFtMQ2zsn9zNz6jjdm8Tgb3f9dBN//90N9EL/LLBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767716173; c=relaxed/simple;
	bh=Z0QjrHFbMkyFsyzc+ne/+38ttRP0A3tqy3+Wcra240U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=avsJ1EOZzeBcGZClMB8UlhHohZPVYDrmy2hyZnGa3Ad/DnFboAbYe+GsCRbFScBUHQ3atCPahiwiVzz0h0BOD1VWuRwXe/ASK4IOaD4cGP7lJPo51/SB7ffcgZqRaxCLyNzF9vNeoFHQgZLEsnDu1Vw1kvC615BlXitVqH5R1ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D06gqExQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UNknVUrLhX4MeaSJQPbfBseCaxyMRZibBisPpTTIQZw=; b=D06gqExQHsr6Uq5rutmZdiGluE
	Lm0wWVFtggxrswCbgElA9FXr9dmZC9r/9295RVlxkzkWnTbwwZ0rxrLd4FM/iZM6hC/LVPyFxXkWD
	TgOZgrzjwiszmxS2nM+P2NxCs5gk+REYszbiYFvgRZq3tj3wx7Ujc2/yqzdDWHAnzy2TMaXx/GNDn
	1itDEUWODhkLSdHZYOngtEfGvF4G3KzL+ZCU7rC3Or2J3OriVcPYixXLAiPrjkJVwy+df/NbIkwYx
	8RP5eDC84Hki49ZHNlswxArjiWvx89y+DIk0n9AE/11ILqofxHy6cCsSiSTN5dOa7ypQD0CNeHaf7
	CKiJHSFQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd9j8-0000000DTHn-2XYz;
	Tue, 06 Jan 2026 16:16:10 +0000
Message-ID: <c53839e5-2120-4ed5-a679-1b4566fea017@infradead.org>
Date: Tue, 6 Jan 2026 08:16:09 -0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Armin Wolf <w_armin@gmx.de>,
 Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <2396510.ElGaqSPkdT@rafael.j.wysocki>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2396510.ElGaqSPkdT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/6/26 4:27 AM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> v1 -> v2:
>    * Fixed a typo in the changelog (Andy).
>    * Addressed two review comments from Randy ("is questionable either" ->
>      "is also questionable" and "eg." -> "e.g.").
>    * Added R-bys from Andy and Armin.
> 
> ---
> 
> Although this patch can be applied independently, it actually depends on
> some ACPI changes in linux-next and on
> 
> https://lore.kernel.org/linux-acpi/12824456.O9o76ZdvQC@rafael.j.wysocki/
> 
> so it is better to handle it along with that material.
> 
> ---
>  Documentation/driver-api/acpi/acpi-drivers.rst |   80 +++++++++++++++++++++++++
>  Documentation/driver-api/acpi/index.rst        |    1 
>  2 files changed, 81 insertions(+)

-- 
~Randy

