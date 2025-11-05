Return-Path: <linux-acpi+bounces-18568-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B7C386B8
	for <lists+linux-acpi@lfdr.de>; Thu, 06 Nov 2025 00:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077DA188A967
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6192DC342;
	Wed,  5 Nov 2025 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6MJC6Y4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE52F3C09;
	Wed,  5 Nov 2025 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762386740; cv=none; b=auyqTv9F9uRXemvVy/M/PCe2g27s4KKVjpbhpzgg4XPMawEBmCCeei5dtEKftFo3KLf958DzJow2uDFL/uzI09prz51soKWR2r8/vN4p2vqJAzTl+qa3T1hAeZfNbfcKT6sPdiWkfPihPQQlblU/ewZnDsS19s9O8Onq8H0ZJMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762386740; c=relaxed/simple;
	bh=hIljisa638g6xyVcM1p/mFIdEgertpFFTKONiBC2cSc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dIOGL9gbMk9bofgQkU+QgZhV/m8RXqNWnIiP/DssyNf+nYClS9qZtPBFOYHJyI6LUNVTeUVNVRzswCLQTol0gr254IqOVNDuKOK2cVjgLh6iDSdeGekBe8kPgZyFkVI3TT1p6VwXYat9v8GwPnJU/nU2nyHEizSzfGNNCestGd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6MJC6Y4; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762386739; x=1793922739;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hIljisa638g6xyVcM1p/mFIdEgertpFFTKONiBC2cSc=;
  b=J6MJC6Y4aV2bT5A0Nb8dzHNQ9aDYm8t5gIsEQSvbcGxfd5eW/lFYLWll
   vQPJbyyOUOQ+EnQbiUlyDNNk01+7FCg0duypqYd/MeMqtbXBzPlqy+w/b
   kcNV+QE9unHXc8LckshuUwhZzk/6M4yYsftDYJHUMoHwYxihVjxH0HxpO
   TRzz0NnUH7+JUfTySBN7Fd8o1L8O7XRW+mS0O/2LggvHY1t+5nxvTktQm
   Mz0pNUfQEFPIfJ8qmHXLdNZGNfcJPJp2OotJwJdKph4Q2vF/83E5VqIpu
   pHNsxdNzO1ZsNFgXzFVijqIUu3bEINHHjWf2jRsi8G+RXoGOs+44MRKeK
   Q==;
X-CSE-ConnectionGUID: 6Fh47LYcTyytWaIjsc+q2Q==
X-CSE-MsgGUID: msCZ7NMWQS28B9HGS6hJng==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64614522"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="64614522"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:52:19 -0800
X-CSE-ConnectionGUID: Nonr+CCkTBy1/kifDUcSuw==
X-CSE-MsgGUID: Za4OL8ZyTM2IMD/juXl+cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="scan'208";a="187302156"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.20]) ([10.125.111.20])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 15:52:18 -0800
Message-ID: <5063d9b0-2819-4f39-9946-6dd54ca9c81f@intel.com>
Date: Wed, 5 Nov 2025 16:52:16 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] acpi/hmat: hmat_register_target() refactor to
 address lockdep warning
From: Dave Jiang <dave.jiang@intel.com>
To: nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 rafael@kernel.org, Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20251105234851.81589-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251105234851.81589-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/5/25 4:48 PM, Dave Jiang wrote:
> This series has changes that refactor the hmat_register_target() function
> to clean up a lockdep warning.
> 
> Dave Jiang (2):
>   acpi/hmat: Return when generic target is updated
>   acpi/hmat: Fix lockdep warning for hmem_register_resource()
> 
>  drivers/acpi/numa/hmat.c | 47 ++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

Ignore please. See v4 resend series. 


