Return-Path: <linux-acpi+bounces-12240-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A00A6119E
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 13:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6B83B8672
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Mar 2025 12:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D21FECC1;
	Fri, 14 Mar 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOSSlmn7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FEC1CBE8C;
	Fri, 14 Mar 2025 12:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955982; cv=none; b=kIm6wroZuERzjLjJqEUeFwbIAnCw3a28mzEA56uhV7I8qkfXl6KI5uF3t4NxrTxJHhTNa9MeDrTvcVzjZRU+G+0y3bLihFdBhx9QL3l3/FRq6LtHSPoe2NEBbPISuJJyvTzjAKCdfTiuEyw8TVZv9ghCpwUh42BdOvr0w9zKNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955982; c=relaxed/simple;
	bh=BBoR7Cvr0quUh1pJlkxJOFVg6IyHFlY/4eyXtRxd0Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYuxRqa0oIpKXTrdFc0MYYIQBEktGGRJyiQVHiWYJAfeoMISGD4aWMKENNEzBcajg55D9FtMMAlcNqa+WcivlS+LXf0vhEzOuZsxvSoJBFbUb+wC0PxD1kQ94IrYBn088QZ722yAz9HFA8g534WTWjexAjZPC3S7A7mEPcYdrE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOSSlmn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA1AC4CEE3;
	Fri, 14 Mar 2025 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741955982;
	bh=BBoR7Cvr0quUh1pJlkxJOFVg6IyHFlY/4eyXtRxd0Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOSSlmn7OWF/K0NuxmYNLNLXcwhFapishtiK6ZSTfHgvm5//v7pH1ce7y8zVY0UuF
	 tR1NZRjrIAQhmFX88h2IY5L5PKzUx6IajrJ0/299XFDbjuTHSdmhO7DqtOBfudw06M
	 x3kh/iSP2H0+zI5912kOUMbF+RObwOqCuX1NHdDHIsDoorPq/uR3c2SLsdBbPS60cX
	 NS9+iw2DURwPbiZna+8fE+IgdwSt+4DeCCwJKJzSB0Ey5+WbKRNNcoGpsUOfTYBmxp
	 G+br+L4DiCfwoe7lUh2vuQVK9WyENCYU2ki6Dv8Ddg9xUqb695kgwixlm7c7d/5jlB
	 o4Ow/EtjeElVA==
Date: Fri, 14 Mar 2025 12:39:36 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Markus Elfring <elfring@users.sourceforge.net>,
	Jakob Riepler <jakob+lkml@paranoidlabs.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-usb@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v1 0/4] leds: Introduce and use
 fwnode_get_child_node_count()
Message-ID: <20250314123936.GO3890718@google.com>
References: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310150835.3139322-1-andriy.shevchenko@linux.intel.com>

On Mon, 10 Mar 2025, Andy Shevchenko wrote:

> This series was inspired during review of "Support ROHM BD79124 ADC" [1].
> The three conversion patches are the examples of the new API in use.
> 
> Since the first two examples of LEDS, in case of posotove response it may
> be routed via that tree and immutable branch/tag shared with others, e.g.,
> IIO which Matti's series is targeting and might be dependent on. The USB
> patch can be applied later separately, up to the respective maintainers.

Ah, just seen this.

I'm okay with that, but need Acks for the other patches.

-- 
Lee Jones [李琼斯]

