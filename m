Return-Path: <linux-acpi+bounces-8924-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767E9AB95E
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Oct 2024 00:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 862871C20F88
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Oct 2024 22:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03291CCEF6;
	Tue, 22 Oct 2024 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNdlgIka"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0D1CCEE7;
	Tue, 22 Oct 2024 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635123; cv=none; b=ut6qfNHnptnAEv3u9vnPn9xgVYJHxwEpgxaYBLRjDZgxgQuMYVQZfIyoLvWm7h6c9SXbG0IC3CoqF8/F22txsttYFohBNB+yUMs9j4MnLJc3lovl0h9rO5aiZ80OjVVRk1KR1QfAkdGNLfEZVuQ/49Q8fTVzAy3Nk8ykFnRXDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635123; c=relaxed/simple;
	bh=b1JW7krYn2Ty31n1Gs1Qbwt8owJ6tKib/gKh2vvGJXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7FU4w8isLFoM6pn/BQW3waEfruoaX5sFNntRsq4x5fNcYnd5u+VnngMPoI7Dq5dFaT6CvvbnlgRwzHHryaaMtwwOBeTtxrp3eAWrKaMuVMfi2+upWf9L9BgJii9j7xDWrtLGoMhnPDLa3AQiahviJ1xs949V3x4q64bAaJ/5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNdlgIka; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729635122; x=1761171122;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b1JW7krYn2Ty31n1Gs1Qbwt8owJ6tKib/gKh2vvGJXY=;
  b=UNdlgIkabe5UBCj49vf+WK29JoxOuUd/6l6qCT/I45g+bfsV5ApoH3IX
   oAPnrU2Pf1sBCbCGiMXq6DGYqUOeHcQnPZBZl+cfCeIZq1Xxi0imlxjPv
   4IpeUoWgRamqQMNVcXBNm7kgZ13hRBwDqDexCqEA0cEKchPP/crNT69H7
   Wc/v5oMSdnejR7gu3EdyaRxrnlsfMD1LscpJAQZUysKfSRXjeZz1axkrZ
   ftSCNyZms8PyUKRNVfUMa2ELltvVfY6mWivfofZlqbELqqU/hDioXKR87
   bOH/sxdJXGOKjFOxy7/ncnLKIyqc+tABngN0SD32kpGdXnY8riSbWoAo/
   w==;
X-CSE-ConnectionGUID: dpVJCJ2GQOaljuvmeA4hOw==
X-CSE-MsgGUID: AEURPN9DSlSVlahngw5MHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29094887"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="29094887"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:12:02 -0700
X-CSE-ConnectionGUID: xpWT1d/ETRuCXmG7gf4Tbw==
X-CSE-MsgGUID: WBt8aHDPQU+QqFkalHrbnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="80192808"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 15:12:01 -0700
Date: Tue, 22 Oct 2024 15:11:59 -0700
From: Tony Luck <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, Benjamin.Cheatham@amd.com,
	Avadhut.Naik@amd.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
	ira.weiny@intel.com, dave.jiang@intel.com,
	sthanneeru.opensrc@micron.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 5/8] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <ZxgjLwEXKSGnQBE-@agluck-desk3.sc.intel.com>
References: <20241022213429.1561784-1-zaidal@os.amperecomputing.com>
 <20241022213429.1561784-6-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022213429.1561784-6-zaidal@os.amperecomputing.com>

On Tue, Oct 22, 2024 at 02:34:26PM -0700, Zaid Alali wrote:
> Add einjv2 extension struct and EINJv2 error types to prepare
> the driver for EINJv2 support. ACPI specifications(1) enables
> EINJv2 by extending set_error_type_with_address strcut.

s/strcut/struct/

-Tony

