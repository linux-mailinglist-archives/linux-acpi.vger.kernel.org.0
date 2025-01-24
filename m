Return-Path: <linux-acpi+bounces-10817-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9F4A1BB1B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 17:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D810116200B
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jan 2025 16:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A921ADC6D;
	Fri, 24 Jan 2025 16:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JnnFYfEs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940CFBF6;
	Fri, 24 Jan 2025 16:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737923; cv=none; b=qabJWgMP5audAkKSFksCFv22PuKQRggbTJEBA75MmI+hD86eiLe4iSdvDnJ78aTc096BojsEkR0E9VABEDaSPG8OfDWbYYJ87xVPDWqcJ/gAgEDplL0AqkZwbt3oZZ3ZyifbIRYj9evFWCcUeu7ti/ax2lhIccTsQVReQD1Hypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737923; c=relaxed/simple;
	bh=C431NWRnJgCF/ijsvy6l90G1Fa79XSLuKUsmB9gNzt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aEsRUsSZjufID3tz5nN6q4TUXyAX+HjXJCCNBkKmhSv1rI0bvDJak73hukYAY1qoCOgjTo//rGauyutQGoqE3ffuhcWcj9onYHyJYvDdHGOGx1WtJMkXy+wCrHpWJEhsQL8r4jJmMFVltU7lMVGC2m7ldPe4wrYaSnf+nHyNbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JnnFYfEs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737737922; x=1769273922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=C431NWRnJgCF/ijsvy6l90G1Fa79XSLuKUsmB9gNzt8=;
  b=JnnFYfEsnV07OS4mnl4W+IxPbt6Rel58lnHrLB7/sidBeZNlnXXJ62Tb
   9PrKhbzgPtiHDbBknPAcMIVVV8dzgPrJL4S3AXWi5up37yasRMhPPoqiP
   lGkc50he38drsJZa3Hiy9WW3U0TpL3zkyorLi3jMHgQE/bj5vdmnLjsJV
   t128ptVSNdq+tzC59IYuEzqyjOe1wfZ4SM1xMZWUPoyaj0vuXf5DHPtD3
   L1FEMuAOTPzFWgn6TgUXLmzFzdHc6jL8A2tSGxArSNxvAYmxeCqBVuKp0
   9Dmw7VY3e1OmZwFCxxg+jzrKT7oMZThQsk/qunumCVQUEbpZNG5G1sb+V
   g==;
X-CSE-ConnectionGUID: GD1TJgJoQBmdwfdgCRUQQQ==
X-CSE-MsgGUID: yYlqfuC+R1yp+OvBiuahSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="60743851"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; 
   d="scan'208";a="60743851"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:58:39 -0800
X-CSE-ConnectionGUID: +WFEQ0YgTX61NvlezkUIQQ==
X-CSE-MsgGUID: byppk2EjSR6BbFRHinT9pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="107669454"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.47])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 08:58:38 -0800
Date: Fri, 24 Jan 2025 08:58:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Murad Masimov <m.masimov@mt-integration.ru>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com" <syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com>
Subject: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
Message-ID: <Z5PGvA-zoCV4rWii@aschofie-mobl2.lan>
References: <20250123163945.251-1-m.masimov@mt-integration.ru>
 <649ed1bb-0686-42f0-802f-9f1909aeed8c@intel.com>
 <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <741f409ae5be4f1f9b62d9223f026e26@mt-integration.ru>

On Fri, Jan 24, 2025 at 02:17:51PM +0000, Murad Masimov  wrote:
> 
> ________________________________________
> От: Dave Jiang <dave.jiang@intel.com>
> Отправлено: 24 января 2025 г. 2:43
> Кому: Masimov Murad; Dan Williams
> Копия: Vishal Verma; Ira Weiny; Rafael J. Wysocki; Len Brown; nvdimm@lists.linux.dev; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; lvc-project@linuxtesting.org; stable@vger.kernel.org; syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> Тема: Re: [PATCH] acpi: nfit: fix narrowing conversion in acpi_nfit_ctl
> 
> > On 1/23/25 9:39 AM, Murad Masimov wrote:
> > > Syzkaller has reported a warning in to_nfit_bus_uuid(): "only secondary
> > > bus families can be translated". This warning is emited if the argument
> > > is equal to NVDIMM_BUS_FAMILY_NFIT == 0. Function acpi_nfit_ctl() first
> > > verifies that a user-provided value call_pkg->nd_family of type u64 is
> > > not equal to 0. Then the value is converted to int, and only after that
> > > is compared to NVDIMM_BUS_FAMILY_MAX. This can lead to passing an invalid
> > > argument to acpi_nfit_ctl(), if call_pkg->nd_family is non-zero, while
> > > the lower 32 bits are zero.
> > >
> > > All checks of the input value should be applied to the original variable
> > > call_pkg->nd_family.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> > >
> > > Fixes: 6450ddbd5d8e ("ACPI: NFIT: Define runtime firmware activation commands")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: syzbot+c80d8dc0d9fa81a3cd8c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=c80d8dc0d9fa81a3cd8c
> > > Signed-off-by: Murad Masimov <m.masimov@mt-integration.ru>
> > 
> > While the change logically makes sense, the likelihood of nd_family > int_size is not ever likely. Given that NVDIMM_BUS_FAMILY_MAX is defined as 1, I don't think we care about values greater than that regardless of what is set in the upper 32bit of the u64. I'm leaning towards the fix is unnecessary.
> 
> Thank you for the review! But I believe there is a misunderstanding. The point is that the code fragment affected by this patch is intended to make sure, that family is in range between 1 and NVDIMM_BUS_FAMILY_MAX. This is necessary because call_pkg contains user-provided data. However the implementation of these validity checks is erroneous and leads to passing an invalid value. The syzkaller report proves, that this bug can be triggered by a user. Here is an example to demonstrate, what exactly happens:
 > 
> 1. Let's say call_pkg->nd_family is equal to (1ull << 32).
> 2. Expression (cmd == ND_CMD_CALL && call_pkg->nd_family) evaluates to true.
> 3. Since family is of type int, and call_pkg->nd_family is u64, assigning call_pkg->nd_family to family will lead to a narrowing conversion.
> 4. As a result, family equals to 0, which will be passed in to_nfit_bus_uuid() triggering the warning.
> 
> Moreover, family may also be a negative integer (e.g. call_pkg->nd_family == ~(0ull)). This can lead to an undefined behaviour in test_bit() and potentially out-of-bounds in to_nfit_uuid(). Thus, even if triggering a WARN is not concerning, the bug still should be fixed.


Hi Murad,

Here's some general feedback for any Fix with a Fixes tag: the commit log
needs to state the user visible impact. State what user action fails and
include the actual error message that the user will see. That makes it
possible for folks to search and discover if a patch fixes their problem.

You've done some detailed sleuthing here but it's not clear that a
user would recognize this issue if they hit it.

--Alison


snip
> 

