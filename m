Return-Path: <linux-acpi+bounces-18273-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E3C13C53
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 10:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F5764E7AFD
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 09:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDDC2DA776;
	Tue, 28 Oct 2025 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbvQb/um"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF082C0294;
	Tue, 28 Oct 2025 09:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761643246; cv=none; b=u2i7oyoTpCL6v+fo0rozWCjnlAnlDuau2/xZkacsinU+yvLTE/Q9wCbxi3Qfs6lmznW9RlGc9c+0gOY9ApwpltKi7BitRlRhemDeyoiuVnTxTd//m+bCvWwWjIZ6DIYiSv1zO19l1huhVCdENNILq9quGTv8Rt27fL5msO1wNFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761643246; c=relaxed/simple;
	bh=SKHL9sv+geSvfdC16ZXGX9bi5INVTRDZqvPMpldezFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoF6wuVkzgz0yc3lA2pS1JzBOhWVUDbwMLS0hxPA4FdpKAd9spg39axmOCHez3r+f690cxr0cHfsC+OdjmcBoMDsslN01e+xOG4lZRhuaEbf/6LYMKBZF0Kf0C7ttQ7KC81ZHZirCnNamUCEOity3DgxxVU6vtyqqopd0OOhG7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbvQb/um; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761643245; x=1793179245;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKHL9sv+geSvfdC16ZXGX9bi5INVTRDZqvPMpldezFc=;
  b=ZbvQb/umtOO0JeBGmKNr3H9JWOGjKAsi10NgGon5V1BTirVNGXwhiJ4k
   wZlBvMCMd7mMMR9pJfW2VE0MFhnk8Hqp7g2bqAiovTtS24u1EAeJTg3n6
   cAo6Q5Hlz0iLkBsJ2D34T47qc/ZlNLJl7xIAGBYMZmJmnVGZgZY97VFcH
   khX1TeuX/v7ThD/N0wlGg9XMxGkcEABmxT98KJHH4EescVHWcMCvaJKqa
   Am+U1cPbs+KtTYce1Nft6hwr3n+/j9qjrGEIgPxRqdbQHsDgjffNSpGMu
   /TSdteJBUyUW6SnxFLDIQZ/eFo3GiY+74neVSqBuFjDdgnmeqsLzKot4x
   A==;
X-CSE-ConnectionGUID: llKcOKx9RFeOHm8lJeyQlg==
X-CSE-MsgGUID: /sxHajxRREWyL0i2S7Am/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66354539"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="66354539"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:20:45 -0700
X-CSE-ConnectionGUID: pklLLn3aThG7RGCwZZ2E4A==
X-CSE-MsgGUID: zb9QtwiZQzGfwXOBe74dDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="184527887"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:20:42 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vDfsd-00000003GXG-3rdH;
	Tue, 28 Oct 2025 11:20:39 +0200
Date: Tue, 28 Oct 2025 11:20:39 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: ACPI: i2c-muxes: fix I2C device references
Message-ID: <aQCK56FcZSCZdmgE@smile.fi.intel.com>
References: <20251027192628.130998-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027192628.130998-1-jonas.gorski@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 08:26:28PM +0100, Jonas Gorski wrote:
> When the device references were changed from relative to absolute in
> commit e65cb011349e ("Documentation: ACPI: Fix parent device
> references"), the MUX0 device was omitted from the paths.
> 
> So add it to fix the references.

> Fixes: e65cb011349e ("Documentation: ACPI: Fix parent device references")

Closes: https://lore.kernel.org/all/48d0fb45-096c-4caa-b51c-753c2f17f018@gmail.com/
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



