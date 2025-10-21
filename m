Return-Path: <linux-acpi+bounces-18020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A993BF574B
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 11:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3FD44E63AB
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 09:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B20F32AAD8;
	Tue, 21 Oct 2025 09:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mwF57hQm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40A329C54;
	Tue, 21 Oct 2025 09:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038096; cv=none; b=W73c7+SnzWGcl/KyiRLaeHFhlet5+BqgkvRR5bgvmMUYbKW8AKLYYlkUbJONfk+5EPwWtYefYxyKotLByE+J2i40ivhqJy/1tIXUgREYXS/UKs85+jc/JTbp4m5dlJWMbqzEnHqLCGp5jb9qHYYcJ9rWCb8OdaEtYF6HHyfvk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038096; c=relaxed/simple;
	bh=Z1EAVRmm1zWRSSXZ/FnLfdHnM+fOGTu9pgJDmGR/nOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNEcbheGEXWLXvcq+TLUcyFkavvj8UTdUR56T1O5qk8Nypa1JSrqbvPEtU/4tuUTSeg/oeuNm5dbpI3pxTtrN+7KtwzQgQdtIrJ+DjDEx6KVanBz2fHamv5lD/Fc9LyjKqRN2odxRKxEBkccz7TpH0XaUjncg7LiDhcB27NLexg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mwF57hQm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761038094; x=1792574094;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z1EAVRmm1zWRSSXZ/FnLfdHnM+fOGTu9pgJDmGR/nOQ=;
  b=mwF57hQmYf99m5ghWPNzxvj38SHuvFFUO1D9kpYSLpoItIIVFhBOfZvy
   aG6MtXvIaehBHLUkJSyPCXib0gfkpaleXaxTz4kCED8LKdm8SyJycpNhK
   TZQYQWWhnmf/O0zHtDjcZ24IHjLtu2vtj3bjcA6GhC4cm9gwacC/dX13k
   NNrUy+mNyeZ5HhsdnQ4IlP1P84rCrwRUTzS8f7PU3BJVi5b1/lCeFmOxf
   DyeuyZMyKDTmarJuyqRP7S6bSLk5JkYOkitx2BK/A0usLcSPN81BL4BWF
   abyZr0pXPdEmoJpXeaQILxXIi7oSLPXTk5ycrKmiohQIRtYLIT4RaZQGh
   w==;
X-CSE-ConnectionGUID: C2M9Ylj8Q9qewIyf6vb0ww==
X-CSE-MsgGUID: fXLZR3JPRiiLdzDjY5tlwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62191843"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="62191843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:14:53 -0700
X-CSE-ConnectionGUID: 7M128sEuRKGcXzraMAIOQg==
X-CSE-MsgGUID: LO1fxTUsShirqkUyPQgLxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="187576325"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.148])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 02:14:50 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vB8S7-00000001ThI-1BGW;
	Tue, 21 Oct 2025 12:14:47 +0300
Date: Tue, 21 Oct 2025 12:14:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/9] software node: allow referencing firmware nodes
Message-ID: <aPdPB_usMzyA7rxv@smile.fi.intel.com>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-3-6d3325b9af42@linaro.org>
 <aO1dBgPZfDJTsPfE@smile.fi.intel.com>
 <CAMRc=MfOoHn+mLRpQBEsC3g5sM=VZBgVffsm68CAXJBHffPxdA@mail.gmail.com>
 <aPYJeqFY_9YV9AQn@ashevche-desk.local>
 <CAMRc=McBTgnQXkPoOUYC=PDDwFXuVqfMFuiwZTW7ODb6owJbeg@mail.gmail.com>
 <aPcuHpYCM22NZ7S_@kekkonen.localdomain>
 <CAMRc=Me0YyBK5DtyJO4ZZvfvnhdtJx92_ktQA_eVhqFEkh=Bqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me0YyBK5DtyJO4ZZvfvnhdtJx92_ktQA_eVhqFEkh=Bqg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 02:06:36AM -0700, Bartosz Golaszewski wrote:
> On Tue, 21 Oct 2025 08:54:22 +0200, Sakari Ailus
> <sakari.ailus@linux.intel.com> said:
> > On Mon, Oct 20, 2025 at 01:26:59PM +0200, Bartosz Golaszewski wrote:
> >> On Mon, Oct 20, 2025 at 12:05 PM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:

...

> >> > > > Can't we always have an fwnode reference?
> >> > >
> >> > > Unfortunately no. A const struct software_node is not yet a full
> >> > > fwnode, it's just a template that becomes an actual firmware node when
> >> > > it's registered with the swnode framework. However in order to allow
> >> > > creating a graph of software nodes before we register them, we need a
> >> > > way to reference those templates and then look them up internally in
> >> > > swnode code.
> >> >
> >> > Strange that you need this way. The IPU3 bridge driver (that creates a graph of
> >> > fwnodes at run-time for being consumed by the respective parts of v4l2
> >> > framework) IIRC has no such issue. Why your case is different?
> >>
> >> From what I can tell the ipu-bridge driver only references software
> >> nodes (as struct software_node) from other software nodes. I need to
> >> reference ANY implementation of firmware node from a software node.
> >
> > Yes, the IPU bridge only references software nodes.
> >
> > I might use two distinct pointers instead of an union and an integer field
> > that tells which type is the right one. I don't expect more such cases
> > here; it's either a software node or an fwnode handle (ACPI or OF node).
> 
> Like:
> 
> struct software_node_ref_args {
> 	const struct software_node *swnode;
> 	struct fwnode_handle *fwnode;
> 	unsigned int nargs;
> 	u64 args[NR_FWNODE_REFERENCE_ARGS];
> };
> 
> And then if swnode is NULL then assume fwnode must not be?
> 
> I'm not sure if it's necessarily better but I don't have a strong opinion on
> this either.

At least it is slightly closer to what I ideally want to have (but not in this
design seems), so +1 to Sakari's proposal.

-- 
With Best Regards,
Andy Shevchenko



