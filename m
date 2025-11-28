Return-Path: <linux-acpi+bounces-19348-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E51CC919C9
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 11:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44483AAC7B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Nov 2025 10:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856F730BBB7;
	Fri, 28 Nov 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lhJzTbd1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98F73054DE;
	Fri, 28 Nov 2025 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764325540; cv=none; b=mNMoQX1o31oyaUM+Fh+zv3fRnHi5+JgZjYpvmcXnKA8uYbtxEQC2AhVPfdFrxqb1RsEAY+JjmssZ8phyGfZbA99Rf+ufvZVx76XkiZyogjiEHAlAUqGIrR5FIO3qNwKtIorWNwRqX58A/ZXCANMW2VHLVRqvrwbN2TJ0cPciTK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764325540; c=relaxed/simple;
	bh=7sNXAdFi7e0tMMIPcMQTugE/7XoIHlIAej6AcuAWiUo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0gAjB1fzfKUePZoEJ8X1U7Fko0Tx1mwEprvEKp9d+n3BWhOz5LAGIA2mK9lcUoJ7Q8NEp6Ooo607mTe/gjLw7yI/O0XL4mNagN4c3yEqIiTv9w/gODf/hYYHnwN3BZnp9nVWB5cYycfTpmeEkBgMVFMOf3XH48PI3do9PGVBWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lhJzTbd1; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764325539; x=1795861539;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=7sNXAdFi7e0tMMIPcMQTugE/7XoIHlIAej6AcuAWiUo=;
  b=lhJzTbd1XDLawB6MMjLVes9gFw7t49dYxqVT7GJ1ynrpy7K2o3iDjbSO
   wx0yzZhVW6pyIhCEm+YNSuHT373E7j5qB3P98+EX96TSLV10IESAj4d/K
   eCe0153S5MneetvqyRNy908FVwPVN0ViJqAXVTZXL/dfBqkTnbUcyvgU8
   rwhb8T4CnwwJF7CJhhEkyTzLlUli/Ama8bkZc0L9FTQ9B1vhBtnU9En/D
   9SJsgwMQMB5K3SrwadYncupp4yybu2GY64AwhMzVwJ9qDM2fQJlXrsYUL
   RhXMK5yCCWk6r0pASDe30jRIXsVdF3GDX702K8Ex7EJyCa79Dy2qfAyQQ
   g==;
X-CSE-ConnectionGUID: eyAxiD5XQmyQXOhE7hDxFQ==
X-CSE-MsgGUID: 0kwrAcbMTkujLSzRla+GUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66256012"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66256012"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 02:25:38 -0800
X-CSE-ConnectionGUID: LKRch/U+R669rJyIL8audA==
X-CSE-MsgGUID: cuR14EILQO6BPFsBFLJeQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="197905566"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.229])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 02:25:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, 
 Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-acpi@vger.kernel.org
In-Reply-To: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
References: <20251127151605.1018026-1-derekjohn.clark@gmail.com>
Subject: Re: [PATCH v4 0/3] Add max-power platform profile
Message-Id: <176432552705.7427.17097332694143494725.b4-ty@linux.intel.com>
Date: Fri, 28 Nov 2025 12:25:27 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Thu, 27 Nov 2025 07:16:02 -0800, Derek J. Clark wrote:

> This series adds a new "max-power" platform profile mode and uses it for
> the lenovo-wmi-gamezone driver. It also adds the Lenovo Legion Go 2 to
> the extreme mode quirks table.
> 
> On some Lenovo Legion devices there is a thermal mode called extreme
> that corresponds to setting ppt/spl vlaues to the maximum achievable by
> the cooling solution. This correlates strongly with an overall power draw
> that exceeds the DC power draw capability of the internal battery. This
> mode being mapped to performance when extreme mode is detected as
> supported, with the actual performance mode being set to
> balanced-performance, has led to some misinformation being promulgated
> that performance is always a bad setting in Linux for these devices.
> There is also some confusion that the mode labeled performance in
> userspace, which corresponds to a red LED in Windows, shows as purple
> when set using the hardware extreme mode.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/3] acpi: platform_profile - Add max-power profile option
      commit: 5aefbf5b68794870ccec126cd68bbfd1ee09283a
[2/3] platform/x86: lenovo-wmi-gamezone Use max-power rather than balanced-performance
      commit: 8d0aef2b3a17e5ed3afc8c9a2e71f22ac41a799f
[3/3] platform/x86: wmi-gamezone: Add Legion Go 2 Quirks
      commit: 55715d7ad5e772d621c3201da3895f250591bce8

--
 i.


