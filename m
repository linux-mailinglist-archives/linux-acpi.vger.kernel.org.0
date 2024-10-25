Return-Path: <linux-acpi+bounces-8966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CC9B0A7E
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 19:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D28F2B226B7
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Oct 2024 17:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D8B18C039;
	Fri, 25 Oct 2024 17:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ldYiaUE5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA11515ADAB;
	Fri, 25 Oct 2024 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875823; cv=none; b=IuCDpK667YMrrjP0Be3GZ2E8AE5lseZd7oNIwl2/WyDYqZ0H3tWXwneq+GX80ZcH5MTkF/zrWHDE2EbgcorOeo2KZXy4YC+mPMdlr7NWEuMe6XOPi4cMel1jqUVi1xZqVEDLgaBL6AiaziRv7P9W8g3b22neYCg7xjzFECLpkqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875823; c=relaxed/simple;
	bh=7O4j1llDOPHIqoDS4o0gLGd11f2hoagazAXbD/XFBTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFU2mTGVJHRstpZ6hSTuSOxXUGAEWTORDenB8lB07oVSGxtLXeHuu0J6bQ0Eo08IHhm2gSfQy4eKWdKxGW69zy5H+3b8gWN79bLTYxF5fpFelCxKVCQhlX1vTmXipmiB8r3vuqYdB47sRoESAHoTQL5eqbSseLG2IdD6tqRx3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ldYiaUE5; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729875822; x=1761411822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7O4j1llDOPHIqoDS4o0gLGd11f2hoagazAXbD/XFBTs=;
  b=ldYiaUE5CuA1zaQM0p0RLzCUlVbhxm6fkg5Hp0REJnSGG/t/M9CxR8nJ
   9/4+r60KDo9ixr3WAl609iwrlYgTKzhHi72nR/0b0ppk1AdP/Dk2HNv5V
   g0nWo2ysaFOH8Q+7LOjy5b9YQIxBvZHd5Sn3TaZSYZPFXAbm2Ixq/K7p+
   Yl1PVY2x1QA0kFr6Sbv7Db2k04cESbYuYGYEZo/bC06WlTa2W3/JwxnDK
   XUjzYOc4XdbmmKqd+c0AnNvziSYbeuhaONPneMKKgQcOb78ixzYPXp2hk
   gqb5ReT3VUndsw9VHPDNDWoMB13xECyFWFehEkHRGsUYuRx9GzNt1qrg6
   g==;
X-CSE-ConnectionGUID: rWuYt4oES9S0Wi9dquKEzQ==
X-CSE-MsgGUID: rwid0iEJQ/mJkei/J6yEpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="33459985"
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="33459985"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:03:40 -0700
X-CSE-ConnectionGUID: osjEEqcURKqzBRrTrwYRoQ==
X-CSE-MsgGUID: C1Wk3zVjSFKumMpCmE1FNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,232,1725346800"; 
   d="scan'208";a="84921437"
Received: from dkukushk-mobl1.amr.corp.intel.com (HELO desk) ([10.125.145.188])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 10:03:39 -0700
Date: Fri, 25 Oct 2024 10:03:24 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Li RongQing <lirongqing@baidu.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] x86/cpu: Add CPU type to struct cpuinfo_topology
Message-ID: <20241025170324.ie4mk7vhtb2vdf3l@desk>
References: <20241023174357.34338-1-mario.limonciello@amd.com>
 <20241023174357.34338-5-mario.limonciello@amd.com>
 <20241025134727.GOZxuhb0MSVESR5juz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025134727.GOZxuhb0MSVESR5juz@fat_crate.local>

On Fri, Oct 25, 2024 at 03:47:27PM +0200, Borislav Petkov wrote:
> Except the minor touchup below, I don't have any complaints about this
> anymore.
> 
> Intel folks?

LGTM.

