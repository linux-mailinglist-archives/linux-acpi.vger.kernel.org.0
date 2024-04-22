Return-Path: <linux-acpi+bounces-5228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6C8AC5CB
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5E41F22174
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Apr 2024 07:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD485029C;
	Mon, 22 Apr 2024 07:43:12 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359FF50279
	for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771792; cv=none; b=r3D1WmE11w+kbMNYp8dUmBo2xp3qzRuGjEb0L84sd6kKGTVeDE3rwstxJHnhDOhw58UPuN7IyGNHKP3Nia9qOw/6pJMIgA5m/4J4ccK2XTKrLwtMl75riX0CXivCVbqj/SJ7KDCXPLjw34mfcwZx+Vhw7evg5zmRie3CNjichDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771792; c=relaxed/simple;
	bh=ew5dSgQMfS9IwbBwrIa9E4pKL0iPTREwTY8/gbHfluY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9oW0k/Y9TYCcVlQKxlXq6UiDfQZ2VBQAQ8k7t148ys497KU11KPEhR68oF59k8y4qyCYf+fEysgd1JZHKkd8U5JJ9QrMiJMQuI4MAJx0JxUxEvc+U9phot+yfKn9e2xiz5HeaJKYWMfuwHyd1n3+FGtw6KK2nZPfk3Ulsr+ntU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-208.elisa-laajakaista.fi [88.113.25.208])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id f64f7c0a-007b-11ef-a9de-005056bdf889;
	Mon, 22 Apr 2024 10:43:09 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Apr 2024 10:43:08 +0300
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Vidya Sagar <vidyas@nvidia.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>,
	Manikanta Maddireddy <mmaddireddy@nvidia.com>,
	Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7-incomplete 3/3] PCI: Unify ACPI and DT 'preserve
 config' support
Message-ID: <ZiYVDEt-c57rAIl7@surfacebook.localdomain>
References: <20240418174043.3750240-1-vidyas@nvidia.com>
 <20240421190914.374399-1-helgaas@kernel.org>
 <20240421190914.374399-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240421190914.374399-4-helgaas@kernel.org>

Sun, Apr 21, 2024 at 02:09:14PM -0500, Bjorn Helgaas kirjoitti:

...

> +	if (host_bridge->dev.parent && host_bridge->dev.parent->of_node)
> +		return of_pci_preserve_config(host_bridge->dev.parent->of_node);

If you need fwnode or of_node from struct device, please avoid direct
dereference, we have

dev_fwnode()
of_fwnode_handle()
dev_of_node()

-- 
With Best Regards,
Andy Shevchenko



