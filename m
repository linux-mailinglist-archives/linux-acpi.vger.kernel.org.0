Return-Path: <linux-acpi+bounces-14933-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E15AF15B5
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D65A3ABA5E
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F925F79A;
	Wed,  2 Jul 2025 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lHyKwge7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BCB1DA4E;
	Wed,  2 Jul 2025 12:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751459543; cv=none; b=Ps/gx+XYZeZ6P10QnqQK4lChz6oZ+HLxylYb/WiClECJ3chKywjGM9fWrNz77y96D1oG1VdzowDr2OwVN4XFxalve8QVu4+umIFhs9SZNSF1GF3iWkhbOoLSftKpPFZnLEzN3q8DuLanWN9Zp/Fm6sjsnHfvY+dC/SwVkpwrniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751459543; c=relaxed/simple;
	bh=PfZ54BR/DQeTkZbbJMQYs5PKz2moe77bxCc/RiZ+xB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oWimnnkeuTcDmpBnx7uJlQUounscpFL1h4/1mzgjd0YTbwz+MnkDygF5IyREs/xjlyGwwaMSlb/NC5BhVlWwKP+aArYXttllCLGgnjWwX+B8OrJci36wsOjbUYpvolYhRqSSp09yxYCmDzF33k865BeQ5z7WxG9cOiMLiMZOhKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lHyKwge7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751459542; x=1782995542;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PfZ54BR/DQeTkZbbJMQYs5PKz2moe77bxCc/RiZ+xB0=;
  b=lHyKwge784i79aDH2xwJOSKES+CwvHUWa0VNPz1btI9vGucIgJoo0h48
   p89n8o6tdqX/QHgrH+9RsmVsQzvGvwfKGb6y0VsjBFL8JSwtZscfhIg6A
   rrL4MN+LzaMd3ItWx794PDxQySqFIPQi71F1TmBUuGAQ0eKHYOWMMKSlg
   e8iQSUxC7BxfiNOwunmnISlfa+L0dvbWfeOo8PR3Cx9LDTglI9l+xuoQq
   zUKHBj1TIONlpj4FADVJXsgZ1WCkQ2eXYYUm31CTW57DAM8PB2N0BDlct
   QqcG6SCG3OmAz1nD0W3KGnpNDBniUw95yXQNjLLUTCY7MTqnkJkNidbza
   A==;
X-CSE-ConnectionGUID: cRiIuYT+SBmC56hYsQpRzw==
X-CSE-MsgGUID: z5umHr+3S9KxHFD6dwZo/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="65207575"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="65207575"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:32:21 -0700
X-CSE-ConnectionGUID: la87R4sVRIqU5y8Oay7TYw==
X-CSE-MsgGUID: Al/ue6ziSIGLMd4nKgkYYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="158629264"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:32:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWwdF-0000000BuxV-4C67;
	Wed, 02 Jul 2025 15:32:10 +0300
Date: Wed, 2 Jul 2025 15:32:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/24] mailbox: Allow controller specific mapping
 using fwnode
Message-ID: <aGUmyeUMgBPVlxPh@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-6-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:26AM +0530, Anup Patel wrote:
> Introduce optional fw_node() callback which allows a mailbox controller
> driver to provide controller specific mapping using fwnode.
> 
> The Linux OF framework already implements fwnode operations for the
> Linux DD framework so the fw_xlate() callback works fine with device
> tree as well.

Looks okay to me, FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



