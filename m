Return-Path: <linux-acpi+bounces-14405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8C2ADC1ED
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 07:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283273B8A2A
	for <lists+linux-acpi@lfdr.de>; Tue, 17 Jun 2025 05:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2EE21B9DE;
	Tue, 17 Jun 2025 05:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpG78emY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967093C01;
	Tue, 17 Jun 2025 05:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750139783; cv=none; b=ZiOlHND8ws+4XUhuJg+3pqllD6IbDsCxHMA54P3eyqV7Hi8JTNCdyZ1qUfjzZRCMSZzyigXvuW6amtOJR0ap4R+zTGshN6Axt6rnZ5taYs4JKD2iBAYdpgLngOBdllA1ePO6bLGlvUI/0nkWFZoxx/a+WBVaPL715iGTqJ/R/i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750139783; c=relaxed/simple;
	bh=xewPBDnE/yjPAn+yZQtmYb2YxGdO2c/xqGHXteCy85o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dysM7PGOLwPUthcJ/1bWNLluXmlhRbJD2fupUKhLJh7F61FEMe1BeU0udwhwPk2P1k59vewLk92L0FGyeyv90IzOYFoZ3EwhgVD/5RMZ0/8WFYw1/bvsHri+jRyshspxbBI0aJLgZ63o7uylJ5qKIy+9snifECadPra2L16wUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpG78emY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750139781; x=1781675781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xewPBDnE/yjPAn+yZQtmYb2YxGdO2c/xqGHXteCy85o=;
  b=IpG78emYiX5cAY/LGhC8/uJZkdZTYJXuXTblk5l7bg00CrwEkBmB0ZvE
   3BEyzK/JzQUna51Q2W0y/0y5o7piGg3dtezPRPCEWDHp10Jpm8Y2rysJJ
   aOi1yN4Uylra72z0XtsSi9K9vL+eDIVgsFq/cYqdqVmD59lbM1Pa7e9EC
   UUMn9VBQ3L38SbQQcT+mpgsB3QltMS4qq4LiJZT8f9KaeLX5ybVblMheE
   dLmfy8k6vxdY6InzaqiphWP4R6A+FeDIF4lIUaXAQOcmr2rW/5cc/lafr
   ThRTILKw4iGpm79A4ErLSXpJPcPN4i1L0pRbf90cbVLKLdl0PIgFazwJz
   Q==;
X-CSE-ConnectionGUID: 3WWl6gsYRz6mUJ1kKe5QdA==
X-CSE-MsgGUID: 04hDHwbwSkaBXXFLSJeRgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52282453"
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="52282453"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2025 22:56:21 -0700
X-CSE-ConnectionGUID: 3aNWoODoQm+WuDOajIOeAQ==
X-CSE-MsgGUID: tUaEPf/HRoCHCkkErhZhQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,242,1744095600"; 
   d="scan'208";a="148512056"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP; 16 Jun 2025 22:56:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 00FF312C; Tue, 17 Jun 2025 08:56:17 +0300 (EEST)
Date: Tue, 17 Jun 2025 08:56:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1] ACPI: PM: Set .detach in acpi_general_pm_domain
 definition
Message-ID: <20250617055617.GR2824380@black.fi.intel.com>
References: <4665476.LvFx2qVVIh@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4665476.LvFx2qVVIh@rjwysocki.net>

On Mon, Jun 16, 2025 at 08:20:28PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of setting the .detach callback pointer for acpi_general_pm_domain
> every time it is attached to a device, which is confusing, set it once
> in the definition of acpi_general_pm_domain.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

