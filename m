Return-Path: <linux-acpi+bounces-11780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CEDA4E187
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 15:45:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F184C17C57A
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Mar 2025 14:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010B425F99B;
	Tue,  4 Mar 2025 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEG5bcQt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AC123A984;
	Tue,  4 Mar 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099016; cv=none; b=rST0xFIKAUcrDaNaEo147ryoShsZ44qUX1Pxk3KwkezPmLQZ9rldkHToD5hqXq9h9cKDTrEp7kX1f0XH8oJRyeOLXjRJSxWNIBIU8rkZtv1l3QFm4t0L3XSm78B+8DpmJXwPCBXifQQEjVD07qo95zm0wImL5x8n7W00YgmY45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099016; c=relaxed/simple;
	bh=S9RI25LeVbdzb3grStFlN1Ll83nxiCyKF0yBtRal+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOJ4+H1tNFCj6OAAljGthaLuePmzIqqjXAgpLFXvWtfYwpkUJeTsvZI0m1mUOShn6MYFBDsoqg/1PUH6O0eW5tg+zoGVMNesRNZNGMYFxBZv3yUIdBUcPYEgJxpCVwMtLUxRDG7WfJtftTMESEIIfU5J6tuVW7qUubCpMHKz/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEG5bcQt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741099016; x=1772635016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S9RI25LeVbdzb3grStFlN1Ll83nxiCyKF0yBtRal+/Q=;
  b=HEG5bcQtQhy7VXON3aqNtllRKpSkkCXclv+PnyB/1cg2WKt5t8AbHwh/
   THXrLFjW6rSHifqwORbo/E8EXKM2xC3mHjaDKUqEKC3gR9P809NIhQUa3
   6vb/XlU6emFhjXr0UKwmuHbp/2YvS6GrN0gM3l+nVj6QgbHHc7bWXaVEn
   uSUk7ncku3tI0J9srGK7Eoop1h+o3hWm+yHe09uJD7SrzIwsA3w2EduX1
   cyxKcENpJ6VaARu1m6NKevbR04MuxZaKtI6p/GSDirnSjfaZOe+iHmjzr
   Oh54Xp41DjmQhDjkIbnic7Byv1BE4tlKW0kWGiFGhZT8xZvJ6ZOMbCyUe
   g==;
X-CSE-ConnectionGUID: 4circfcySwuXVD7n1ONMNQ==
X-CSE-MsgGUID: mCsYHzT/Q/+TcYBTR/jBIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41266561"
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="41266561"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 06:36:54 -0800
X-CSE-ConnectionGUID: 8dOswMEQQOKjvNe/oky10w==
X-CSE-MsgGUID: 3HrryG1PTQK0JJm6ODxfRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,220,1736841600"; 
   d="scan'208";a="118116207"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa009.jf.intel.com with ESMTP; 04 Mar 2025 06:36:51 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BB40227D; Tue, 04 Mar 2025 16:36:48 +0200 (EET)
Date: Tue, 4 Mar 2025 16:36:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib-acpi: Drop unneeded ERR_CAST() in
 __acpi_find_gpio()
Message-ID: <20250304143648.GN3713119@black.fi.intel.com>
References: <20250304143119.1816463-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304143119.1816463-1-andriy.shevchenko@linux.intel.com>

On Tue, Mar 04, 2025 at 04:31:19PM +0200, Andy Shevchenko wrote:
> The checked type by PTR_ERR() is the same as returned by __acpi_find_gpio().
> Hence there is no need to cast, drop it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <westeri@kernel.org>

