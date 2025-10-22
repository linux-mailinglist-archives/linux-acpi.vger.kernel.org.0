Return-Path: <linux-acpi+bounces-18073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA73BFADFC
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 10:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E37566974
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 08:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691F6302767;
	Wed, 22 Oct 2025 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjjLcyQW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731B301009;
	Wed, 22 Oct 2025 08:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761121484; cv=none; b=L2Qp5TF0VYk+U1jxu5CY+WeLRgyOOgwLcNzNFkSa5jcsBjDFhOYU53GA/Zqy8FIH0cPXE31wCBv743IAkBtY7Kx33PhZIW0uTR7Och7UloSnsjGQh2Aifw4j21gLSUsW8vBHWnbSD2MJxqV1yd+n4Rc28fqqEi9TamiWr2KXZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761121484; c=relaxed/simple;
	bh=0MA+pvW9JpdyKb2w7RB/0iFUtNCC+s+C0k3q4FUgWqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE1QSp5l8G6VT1VCaJxGbE0vE26l7lRvejfz/hJ/C4IX0Zk5cAx5luPGHwlBMgrGoKX/TN0+rIY/Aae3UtUKCDRbKy/dZMrc2MNbeb86WLesUazUKrSfZcVOjgwnzzoLoR2qvBiyyGygzziIfvkKvekWspWK34rNua1i0ifZ0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjjLcyQW; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761121482; x=1792657482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0MA+pvW9JpdyKb2w7RB/0iFUtNCC+s+C0k3q4FUgWqc=;
  b=IjjLcyQWXTSIi9a2dlzc3znuCDMLdtbprX7buSopIHtVyTmvRrxAD/x6
   howpOCfBwsAeTGugJ09usKF6zjvKMIKrf/l143u9VXQ9xnha+xDKXQ7I6
   WjTOgs62u8u1qR6QFMupipZvYRpVJnGZwWHTmDWOQSCQfacqiyBw27Uzm
   N8vYpQhmGpHvC04RzMGDvKyiYD5MELL4LomPM+iYpQcfQMkscMmtk3Vvk
   GYhf1QM1cZqH5kD8oYiB1JnOJ7v5sQe5+YBVWoXyWt6qvtkN7uVhzyjhv
   hLwYJYWs9iNxMiC5KfmtqjBYDXewcckaYXPrQIOci7NinqpfyRhOfLhvs
   g==;
X-CSE-ConnectionGUID: 5tJxio1DSqOGK5bwJHW92w==
X-CSE-MsgGUID: UQe0f+rVS+uUy6yD4o5moQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66903138"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66903138"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:24:41 -0700
X-CSE-ConnectionGUID: 7BMp7UBUR6qfRmC9wyB+uw==
X-CSE-MsgGUID: I1XokCh4RpihsAS6kJBSSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="183021001"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.245.244.28])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 01:24:38 -0700
Received: from kekkonen.localdomain (localhost [IPv6:::1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 71E3411F87B;
	Wed, 22 Oct 2025 11:24:35 +0300 (EEST)
Date: Wed, 22 Oct 2025 11:24:35 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
Subject: Re: [PATCH 1/9] software node: read the reference args via the
 fwnode API
Message-ID: <aPiUwzpunM2FGXhX@kekkonen.localdomain>
References: <20251006-reset-gpios-swnodes-v1-0-6d3325b9af42@linaro.org>
 <20251006-reset-gpios-swnodes-v1-1-6d3325b9af42@linaro.org>
 <aO1bkraNrvHeTQxE@smile.fi.intel.com>
 <CAMRc=Mc0E33JTettxsCEPf+K5FZ4-JOUX6tF1xq2QGr2gD0vLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc0E33JTettxsCEPf+K5FZ4-JOUX6tF1xq2QGr2gD0vLw@mail.gmail.com>

Hi Bartosz,

On Wed, Oct 22, 2025 at 09:51:44AM +0200, Bartosz Golaszewski wrote:
> On Sat, Oct 18, 2025 at 7:35 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Oct 06, 2025 at 03:00:16PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Once we allow software nodes to reference all kinds of firmware nodes,
> > > the refnode here will no longer necessarily be a software node so read
> > > its proprties going through its fwnode implementation.
> >
> > This needs a comment in the code.
> >
> 
> Honestly after a second glance, I disagree. Literally a few lines before we do:
> 
> refnode = software_node_fwnode(ref->node);
> 
> We know very well what refnode is here and why we should use fwnode
> API. If anything, the previous use of direct property routines was
> unusual. A comment would be redundant as the code is self-describing,
> what do you even want me to write there?

Given that the only way the three implementations of fwnode have interacted
in the past has been via the secondary pointer (for software nodes) and
that this will continue to be an exception, I'd also add a comment. E.g.

	/* ref->node may be non-software node fwnode */

-- 
Kind regards,

Sakari Ailus

