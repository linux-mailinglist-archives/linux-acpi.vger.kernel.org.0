Return-Path: <linux-acpi+bounces-14925-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CA2AF13E4
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 13:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F0F4A1FFE
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF730263F38;
	Wed,  2 Jul 2025 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM1XnPg3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45630246781;
	Wed,  2 Jul 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455865; cv=none; b=KW+LDgJq6k8mHZ5gM1XWvO21RQRrtOB2mp4+GRPxynYVpisp3edgCUKG4B4dLFtS55Nrx5EmxswV+0bvv3c/8HV1NggAcHX9KnSEx5Cn/5apm+zhonRV4g6mHZGlhJZHpge8snEN4Bk/pHfvzVVMRG/2Q4pLX/ZZhd67HIiK/oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455865; c=relaxed/simple;
	bh=BQCMzYb6py2zdb+YdFBHZxoeQM3A3WG6DoBX46UnyrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jB83k2jrCBSLBljYsnChVGjdjVWwSgSv5bevq1EXmiAiZSl/IDT2Y2vhFVB9kTn2QYYEpi/CS8kwRTymya0li2/qb/kjTe/v8iD9mg1PzUruczv0KoOYfMeGtZ+vECOfER4LvyHX81HR4TjMbyXYMCwXWaYP0SCYW0BbRhf+03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM1XnPg3; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751455865; x=1782991865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BQCMzYb6py2zdb+YdFBHZxoeQM3A3WG6DoBX46UnyrI=;
  b=NM1XnPg3myCeU+pXEhN9Tek1tPhAYdzp5DgAFBRLWV1cx/FpOyD6TCLP
   rRipg3oUn14ZMclOzjiJX7Q8LsucCkhXpE4SkLi5uOsAszhnpcFe4nVCc
   k4ThFFhpTKguj8C7nU72ziU5IPzQn8Lz1SxzSo2oOsoARKBo9Cc37v2UV
   N8cyBN84ApPIAME/n6tKoG1x0aO6c21I1pRxoZnSAJpZM75Xjr1bkkd3F
   PJhsb/XMntCS9mmude1JcsJLvlSqtTFEHaH4U+CtO0qon9/bApYZ2y8LE
   TZUfccFU9rX3LMiEEz3S3O1+GLVg05mYcLKAazOeUmIDY1PzdCfvzP/CW
   Q==;
X-CSE-ConnectionGUID: Z6kCnSQ5Sf2PMssCiFudbw==
X-CSE-MsgGUID: ap5u5udrS4uFiIQuNtFKGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="79186476"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="79186476"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:31:04 -0700
X-CSE-ConnectionGUID: GgPq3gDpQmWwNZsum2/JhQ==
X-CSE-MsgGUID: ITHP5AsvTvGxhlUG+acF+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153456263"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:30:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWvfw-0000000Bu4U-04v5;
	Wed, 02 Jul 2025 14:30:52 +0300
Date: Wed, 2 Jul 2025 14:30:51 +0300
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
Subject: Re: [PATCH v7 06/24] byteorder: Add memcpy_to_le32() and
 memcpy_from_le32()
Message-ID: <aGUYa6PWYFy4TyLg@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-7-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-7-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:27AM +0530, Anup Patel wrote:
> Add common memcpy APIs for copying u32 array to/from __le32 array.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



