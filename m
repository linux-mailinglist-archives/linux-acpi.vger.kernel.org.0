Return-Path: <linux-acpi+bounces-14951-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A2AF6077
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 19:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8A052472B
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 17:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BECD309DB2;
	Wed,  2 Jul 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSKTAy9y"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C8A30112C;
	Wed,  2 Jul 2025 17:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478884; cv=none; b=hXZ6C5WIANtkoEfMW0kNhZqDnhcnVat1brSDn939lDyGMwOvDT3F3G/IUpDo81J/xJFch7zJJzAZdcSKEKD9i4mXFK6Ufn/V00nGkyMokK8F/oHdu72Pje0qRwU3LEZs92z+AaTKLT7JiwKiE90NKJullkXZK0+aB2kRJPhXHBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478884; c=relaxed/simple;
	bh=d/677iYvCyUn7iz2EBt/cQQamtMeEP9E5Cn3Bm1Lg28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGSpQB9bskWiCsdyeUpvyMLdc40Xcj0EKtb+bi3RFK6HzvndbjnMrSAYa0L31HEwXN/GzDHjCGcjqmZQVWuv764m7pGJSXkEN8NRNbjRP5wvdTgHCoRbX3ot6gVP3dZPKt9YCpMVSBUUM/k4OEDPQCe4J/ETUHT5SSGDvF1uup4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lSKTAy9y; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751478882; x=1783014882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d/677iYvCyUn7iz2EBt/cQQamtMeEP9E5Cn3Bm1Lg28=;
  b=lSKTAy9yTKPJ6Bu4lXSL/5QkDYX3WOxBlGE/LjeUl+j4UQ/5MhGFPY7C
   ji0Fw0r7BnCNrIPVWoTfZEbRgyqmp+kyjOu6AJgUC4Jk3/rXOfdw6Cch8
   ZYn0yS2H4aj2J27VjpUIDPKfohJ7eFUEYZwXRcuGMxsToh78spXwyI5iG
   jSB5uupCax1duljaIka8BXUNPGeFsPn8T1KHdQTTlKzCYU7HzizhSStMs
   w18tU8vnM2IoNXBlNbldIAe9tU3wY3RKqNLBZLvDxwQXk2GkrNI+dP4VP
   vvIVYRQnWuBnozKgC8XBL6gP8zzv1xSNF6FotRqFCUDoxZ0Gej8W0PmqB
   g==;
X-CSE-ConnectionGUID: PWQ7AYJsQ8K04VOTiVYdrQ==
X-CSE-MsgGUID: 8/XLsVTMRDu2hGGFCq3hjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53755627"
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="53755627"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:54:41 -0700
X-CSE-ConnectionGUID: F1iDnZqjQlKi9hO1j9q4wQ==
X-CSE-MsgGUID: 0sZQrSmkSL6mT5RSG1Z26Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,282,1744095600"; 
   d="scan'208";a="159659085"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 10:54:41 -0700
Date: Wed, 2 Jul 2025 10:54:39 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Breno Leitao <leitao@debian.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>, Borislav Petkov <bp@alien8.de>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, kbusch@kernel.org, rmikey@meta.com
Subject: Re: [PATCH] acpi/ghes: add TAINT_MACHINE_CHECK on GHES panic path
Message-ID: <aGVyX0jqwTPkCVqY@agluck-desk3>
References: <20250702-add_tain-v1-1-9187b10914b9@debian.org>
 <aGVe4nv18dRHHV16@agluck-desk3>
 <aGVq6khN+QdqD5Aj@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGVq6khN+QdqD5Aj@gmail.com>

On Wed, Jul 02, 2025 at 10:22:50AM -0700, Breno Leitao wrote:
> On Wed, Jul 02, 2025 at 09:31:30AM -0700, Luck, Tony wrote:
> > On Wed, Jul 02, 2025 at 08:39:51AM -0700, Breno Leitao wrote:
> > So unless someone feels it would be better to create a new TAINT
> > flag (TAINT_FATAL_GHES? TAINT_FIRMWARE_REPORTED_FATAL_ERRROR?)
> > then this seems OK to me.
> 
> Thanks. That brings another topic. I am seeing crashes and warnings that
> are only happening after recoverable errors. I.e, there is a GHES
> recoverable error, and then machine crashes minutes later. A classical
> example is when the PCI downstream port disappear, and recovers later,
> re-enumerating everything, which is simply chaotic.
> 
> I would like to be able to correlate the crash/warning with a machine
> that had a recoverable error. At scale, this improves the kernel
> monitoring by a lot.
> 
> So, if we go toward using TAINT_FATAL_GHES, can we have two flavors?
> TAINT_FATAL_GHES_RECOVERABLE and TAINT_FATAL_GHES_FATAL?

Do you really want to TAINT for recoverable errors? If most errors
are successfully recovered, then a TAINT indication that a recovery
happened a week ago would be misleading.

Maybe better to save a timestamp for when the most recent recoverable
error occurred, then compare that against the current time in panic()
path and print warning if the recoverable error was "recent" (for
some TBD value of "recent").

-Tony

