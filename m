Return-Path: <linux-acpi+bounces-14931-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E6AF1501
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A92520C23
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945F126C396;
	Wed,  2 Jul 2025 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEQiOujZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FFE1624F7;
	Wed,  2 Jul 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751458055; cv=none; b=qGjLBbVBRz6+INWALDlN+8KCtV5vaoSMGe+KdfJPM7f4BmTWzOs7B8fLGwq/+PntTDFV0TyQ4WPRxVhIO7BQ+2Cx1Gmvw3wt1BKAIm0trIqh33CJMlbhM2kTMvSb/7WaF1mJzTGEg/6EaJaAawDAsULM25NEGHRlsbyGruhS0y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751458055; c=relaxed/simple;
	bh=IR63JrJp4EpFgC2hqcOS6ZZUnx2E8wjz2gyvdSKhXcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZKSOyKRUze+0v4VUa52xKq1Uw+HmVxlRXue/IOpw6qD/+IN/+0a0kigMKtxrKLNpryHJrEbXRjhXuxsj0ICIX0jMutNNMwed8WVCjyqZZlmBSV9kxscMUxYS9+wigLOrRVamxshhMxuq3/nUPTgsQaXi/t7IsNf4OOfdZOGK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEQiOujZ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751458054; x=1782994054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IR63JrJp4EpFgC2hqcOS6ZZUnx2E8wjz2gyvdSKhXcI=;
  b=lEQiOujZxmBIZWffJH08A2FxdI/xZIiODCyRDtC3hXyJoOlWKU7LcB0u
   dnCqPVkDYvZRjHfwrxIKlBJPbXcN4hGnh7PEro8pxc7M+fVQjbTIyHIge
   OXlf+KuUiRVAbire6x4+FKeINxdRYycHzLRqSlEokVpfnw0QghPqwcGx6
   UOTUzXTd33AqH67tSj8gSNn8OOKgyhSs5XtoRiI39lEvY1QvOxu+rYT+s
   5asHtyb/AtPKRlAhbqLOaxwSAGW+AFYxVBQHGW9v9HauETtZ/nIJExVmC
   ufKPbvt0DvcfJ5gIwnYqmMOO39jS4ajCCagevc9oZOMrQtF7uSFk4baI6
   g==;
X-CSE-ConnectionGUID: rpapoq/nQD6UFB0be2MkoA==
X-CSE-MsgGUID: L6ilbGXsQqi3PwVOThMofQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="52866031"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="52866031"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:07:06 -0700
X-CSE-ConnectionGUID: z0XQZcSdS1KNJrdm0gyElA==
X-CSE-MsgGUID: vG0JtjgiTqqFY8WX4z6jag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153512567"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:06:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWwEp-0000000BuZm-1DFY;
	Wed, 02 Jul 2025 15:06:55 +0300
Date: Wed, 2 Jul 2025 15:06:54 +0300
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
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	Atish Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v7 03/24] RISC-V: Add defines for the SBI message proxy
 extension
Message-ID: <aGUg3h_vigc6mq5a@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-4-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-4-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:24AM +0530, Anup Patel wrote:
> Add defines for the new SBI message proxy extension which is part
> of the SBI v3.0 specification.

Actually a few nit-picks.

...

> +enum sbi_ext_mpxy_fid {
> +	SBI_EXT_MPXY_GET_SHMEM_SIZE,
> +	SBI_EXT_MPXY_SET_SHMEM,
> +	SBI_EXT_MPXY_GET_CHANNEL_IDS,
> +	SBI_EXT_MPXY_READ_ATTRS,
> +	SBI_EXT_MPXY_WRITE_ATTRS,
> +	SBI_EXT_MPXY_SEND_MSG_WITH_RESP,
> +	SBI_EXT_MPXY_SEND_MSG_WITHOUT_RESP,
> +	SBI_EXT_MPXY_GET_NOTIFICATION_EVENTS

Add a trailing comma.

> +};

...

> +/* Possible values of MSG_PROT_ID attribute */
> +enum sbi_mpxy_msgproto_id {
> +	SBI_MPXY_MSGPROTO_RPMI_ID = 0x0

Add a trailing comma, and you might want to drop 0x. I don't know what else can
be here, esp. in the future, but some kind of the description of this in TRM
can shed a light on what is better pattern to use.

> +};

-- 
With Best Regards,
Andy Shevchenko



