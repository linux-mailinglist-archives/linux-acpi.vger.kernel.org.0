Return-Path: <linux-acpi+bounces-13005-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CBA879CB
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 10:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAE3B03DD
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 08:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703F3259CBD;
	Mon, 14 Apr 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BP9bhlj0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE831A83E8;
	Mon, 14 Apr 2025 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744618112; cv=none; b=I+Q3lBpkvbxqLkC2YBpTFAmjv1UjwfCvznTulERpV9fDv1/rK+g4/6RvdyTG/KmA+s0W7aDHWNKtJmZxLrZMvPa0cz9qFDmR1AM4nGidJlNALeg0pLl/RMpeLsL6GIsEENPhDIKIU/QEI1qvJH9P9iHAGQMNYLobryUc6eCGZvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744618112; c=relaxed/simple;
	bh=V0f4/PL/gQn+uD5jBY8BYhb0Ecl81rZSW7t2zre7NoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcM7CA8Sh9Ie8fXKUYcop9zRs0t2XV4nkAE4bEdH4ZPdesAFR54lDV1R9l0FpUc4es+I1oAM7GCt+gOmjO3j1L1e814DPDDP1XP51AbV/p5HKz+eHB8rgKelQg7hifxNcA+uzQcQ4JTRkNcuRNUZFhliJqBPRHdGFvldkkDFG0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BP9bhlj0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744618111; x=1776154111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V0f4/PL/gQn+uD5jBY8BYhb0Ecl81rZSW7t2zre7NoU=;
  b=BP9bhlj0UqELDspBK37we8jmkQLcTS5d831Is6B6hsp8E4eJVTyr7F0W
   GEhWD08cAB/+jEkAl4IVOiEfHE2yaF49Qvj4EMli5SQPTaFwxmHTa30uk
   nPB0qxZNf7agkPEAV5mVT0NDZduNPH0zLZ2+GNoHsubZ2WkXwaMuAiSW2
   q9FKL8qqdzdBOOsPtJrUNzM9T7W4lb8PaOTeJ95EPLjy3wbObAI2zTm8Z
   /SUR0auQ6InM1j2rCKp+wI/Eqya1akEZH/4Wop493eR1jRCX7IU5fMULF
   t0NmTUWi38cYjw77eEvh5Ox8wlMLPhews8Lumj+AFcTzeuArK7Syg5M3a
   A==;
X-CSE-ConnectionGUID: 06wRxlpFQHqoSMsHTg9lBg==
X-CSE-MsgGUID: CCCNiHpDTPqrAIlfu/xV3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11402"; a="56735515"
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="56735515"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:08:30 -0700
X-CSE-ConnectionGUID: kiVG0bCgQGOAhCa+zr5/5g==
X-CSE-MsgGUID: V5TaUfkHQQacnCNnFGBmNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,211,1739865600"; 
   d="scan'208";a="134721295"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 01:08:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4Erg-0000000CAli-2CIm;
	Mon, 14 Apr 2025 11:08:24 +0300
Date: Mon, 14 Apr 2025 11:08:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH 2/2] software node: Correct a OOB check in
 software_node_get_reference_args()
Message-ID: <Z_zCeHu9MKgLG0jN@smile.fi.intel.com>
References: <20250410-fix_swnode-v1-0-081c95cf7cf9@quicinc.com>
 <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410-fix_swnode-v1-2-081c95cf7cf9@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 10, 2025 at 09:12:12PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> software_node_get_reference_args() wants to get @index-th element, so
> the property value requires at least '(index + 1) * sizeof(*ref)' bytes.
> 
> Correct the check to avoid OOB access.

Any real traceback?

-- 
With Best Regards,
Andy Shevchenko



