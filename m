Return-Path: <linux-acpi+bounces-15405-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14734B14C13
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 12:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F63A6666
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jul 2025 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D9288CAA;
	Tue, 29 Jul 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUkLZ7to"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353122A4F6;
	Tue, 29 Jul 2025 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753784433; cv=none; b=ZGzT4B89UidICJqKVfz1Si4CnPGurnGJGPWSvJZzBha4vcfdNj8MF112p+ZDU6cIoUZdJZNhAg+THBMlIG4O/BFoJRJLS2tg8SVRUsJo2eYWgyC/pYj9mukXCFWeDXjDEYsqY7tGXa255+kcoPfsO5kINAcm0El91jv/I4XAH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753784433; c=relaxed/simple;
	bh=u9g9xTirDI5BoZdPd2gtcPkZvUCKI6czZ27irfE2iIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gPJIe4rvyC6OURzuYEVCma4SkuXkfOkLo9fzanAw/AYsRggibDgqnXgjnjeLiY/dvJSD2+kZPO9t/i31IzjvncjyEaanEk3d9+CkFlVC4VcliEb17GTzKH/4YJzyDVVCKJgzKKYPZxq8M4N2mzrs8z+NcbiR/in2Qe6zfTOU2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUkLZ7to; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753784432; x=1785320432;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=u9g9xTirDI5BoZdPd2gtcPkZvUCKI6czZ27irfE2iIU=;
  b=jUkLZ7tod++eejFpCBX8XAq7mLB7vzjdPp5As0m4g10hYBPTXJtOs4m8
   ejLbU/lpoMUuviHSGHdbBVHvnAjYtZnsP7CpVQ52DNs8z28E275LSUaqj
   hePjVpydGj5czpQE0LaKnZqmXmoK01F/kEjVSf/SIahfHrdrtOBdOZazJ
   sY4PqoutAqiE+kkPYzfUy8g5YNPFCdmeiWjYQlmFZEZU11gCsdrNXP2ly
   opDTp8JuIKOSMmzCnBNhkp4Mcs1cIABwnF8tVmXbyl7QUJoMGwkUYWFru
   NPgwDhHreXJ4R52v7IVZBl4Dcp29hvOOL6G6Zi8B3ue3Mxyl0loyQB56D
   A==;
X-CSE-ConnectionGUID: srZ+d427RUq6vljLFUFnpA==
X-CSE-MsgGUID: QftFsCXjTLiYT0rWQ++chQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59872759"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="59872759"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 03:20:31 -0700
X-CSE-ConnectionGUID: RXJlBpLLQlWpDWW8k/7zRw==
X-CSE-MsgGUID: b62qSJQPQKun17BHcYAXTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; 
   d="scan'208";a="163006701"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.22])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2025 03:20:27 -0700
From: Jani Nikula <jani.nikula@intel.com>
To: Andy Mindful <andy.mindful@gmail.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, linux-pm@vger.kernel.org
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, rafael@kernel.org,
 ville.syrjala@linux.intel.com, tglx@linutronix.de
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend
 in 6.8+ on ThinkPad X1 Carbon Gen 10
In-Reply-To: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
Date: Tue, 29 Jul 2025 13:20:25 +0300
Message-ID: <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 29 Jul 2025, Andy Mindful <andy.mindful@gmail.com> wrote:
> Please let me know if any further information or testing is required.

Likely the quickest way to find the root cause is to bisect the issue.


BR,
Jani.

-- 
Jani Nikula, Intel

