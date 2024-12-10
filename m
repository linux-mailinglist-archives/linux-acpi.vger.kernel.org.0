Return-Path: <linux-acpi+bounces-10027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB939EB843
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 18:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE4C3188399F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Dec 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667D186336;
	Tue, 10 Dec 2024 17:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qa5hg5/g"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F75623ED68;
	Tue, 10 Dec 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851820; cv=none; b=SGMY9krn5Fj97eXU+b7MXrlhGH+fCs2q0KNAir6aP5ZUBlBK6jB0R0teKHvoBGaOojXGUtbjfwBKDBwzShBQzooTdFNrvo/RhDIs7WS3+dHUC6uSHz2edOouE5K8+eSa/a2jC71WzkzL1lzpDa8LTUbJ7lnvbX8V1lwd7DCWj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851820; c=relaxed/simple;
	bh=JIbhvMKKCNsFNVHATvxBxVjKBlYLJhzisEw7hU3DyL4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=g1JJLVk9QS7o5pXAAA15Angr720QFk94kmd+usFthr0tWalBoIhdaOLpBIImhrsKKQCtjrBWJt5rMGxSU1Pw0CNEBcJkbfTs3fGKXWV1SfnImL0sNi7oU6PL+SriZlthh2j0jbj7JlKsBiayH28BGgZHS1zmOFe+faBTyO8Sm/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qa5hg5/g; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733851819; x=1765387819;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JIbhvMKKCNsFNVHATvxBxVjKBlYLJhzisEw7hU3DyL4=;
  b=Qa5hg5/gw1whcq0pBYXrnLXcGO4OIcnNFBZHJH0z38+Ogp8m+pKR9Xbz
   i1kUYFCS0st2AKVE7LlJhnvgHRwNqYVhpqJOnM9ya7FBEzA2IrHWrmh2N
   1ZDYKHASewHU1mGBIw9nan7yiexnY6ygnQmbrDqFh6/UNDHR0R5K8AqOA
   LSeBEMvg5sRxHXpxDmODDyE9o7OADERswxIJPuLnFV4GBPcbSspAQFazE
   ojBhNx2xFEc9yIJvxJbielL1v/hfR98e9tDvD9aGcZbTCgA2xFE7L7SlU
   GaB45nufLiNaleFdKEeZQqVXoVwDptVKEro4mqYn1GgQHUv9Bqp3ZQqxt
   A==;
X-CSE-ConnectionGUID: mxM9ASF1Twe/RZ0pYgdJIw==
X-CSE-MsgGUID: vxTV8bqUS/COqAaB40uwHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="51735481"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="51735481"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:30:18 -0800
X-CSE-ConnectionGUID: GDjwszKgQeqWE1KGKuDc5Q==
X-CSE-MsgGUID: Cb5B1ylERs62Jld5dPeyNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="132868383"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 09:30:12 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Dec 2024 19:30:09 +0200 (EET)
To: Mario Limonciello <mario.limonciello@amd.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>
cc: Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>, 
    Maximilian Luz <luzmaximilian@gmail.com>, Lee Chun-Yi <jlee@suse.com>, 
    Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>, 
    Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
    Alexis Belmonte <alexbelm48@gmail.com>, 
    =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
    Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>, 
    open list <linux-kernel@vger.kernel.org>, 
    "open list:ACPI" <linux-acpi@vger.kernel.org>, 
    "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>, 
    "open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>, 
    Mark Pearson <mpearson-lenovo@squebb.ca>, 
    Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: Re: [PATCH v10 00/22] Add support for binding ACPI platform profile
 to multiple drivers
In-Reply-To: <20241206031918.1537-1-mario.limonciello@amd.com>
Message-ID: <a34c7648-02cb-76e9-53f4-e54003c98ecb@linux.intel.com>
References: <20241206031918.1537-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Rafael,

This series seems ready and Mario has requested it to be merged through 
platform drivers tree despite majority of changes touching 
drivers/acpi/platform_profile.c because its API relates to many pdx86 
drivers.

Is that fine with you?

On Thu, 5 Dec 2024, Mario Limonciello wrote:

> Currently there are a number of ASUS products on the market that happen to
> have ACPI objects for amd-pmf to bind to as well as an ACPI platform
> profile provided by asus-wmi.
> 
> The ACPI platform profile support created by amd-pmf on these ASUS
> products is "Function 9" which is specifically for "BIOS or EC
> notification" of power slider position. This feature is actively used
> by some designs such as Framework 13 and Framework 16.
> 
> On these ASUS designs we keep on quirking more and more of them to turn
> off this notification so that asus-wmi can bind.
> 
> This however isn't how Windows works.  "Multiple" things are notified for
> the power slider position. This series adjusts Linux to behave similarly.
> 
> Multiple drivers can now register an ACPI platform profile and will react
> to set requests.
> 
> To avoid chaos, only positions that are common to both drivers are
> accepted when the legacy /sys/firmware/acpi/platform_profile interface
> is used.
> 
> This series also adds a new concept of a "custom" profile.  This allows
> userspace to discover that there are multiple driver handlers that are
> configured differently.
> 
> This series also allows dropping all of the PMF quirks from amd-pmf.
> 
> NOTE: Although this series changes code in acpi platform profile, I think
>       it is better to go through the platform-x86 tree as more drivers can
>       be introduced during the kernel cycle and should make the changes to
>       support class interface when merging.
> 
> v10:
>  * Whitespace changes
>  * Documentation update for custom in a single driver
> 
> Mario Limonciello (22):
>   ACPI: platform-profile: Add a name member to handlers
>   platform/x86/dell: dell-pc: Create platform device
>   ACPI: platform_profile: Add device pointer into platform profile
>     handler
>   ACPI: platform_profile: Add platform handler argument to
>     platform_profile_remove()
>   ACPI: platform_profile: Pass the profile handler into
>     platform_profile_notify()
>   ACPI: platform_profile: Move sanity check out of the mutex
>   ACPI: platform_profile: Move matching string for new profile out of
>     mutex
>   ACPI: platform_profile: Use guard(mutex) for register/unregister
>   ACPI: platform_profile: Use `scoped_cond_guard`
>   ACPI: platform_profile: Create class for ACPI platform profile
>   ACPI: platform_profile: Add name attribute to class interface
>   ACPI: platform_profile: Add choices attribute for class interface
>   ACPI: platform_profile: Add profile attribute for class interface
>   ACPI: platform_profile: Notify change events on register and
>     unregister
>   ACPI: platform_profile: Only show profiles common for all handlers
>   ACPI: platform_profile: Add concept of a "custom" profile
>   ACPI: platform_profile: Make sure all profile handlers agree on
>     profile
>   ACPI: platform_profile: Check all profile handler to calculate next
>   ACPI: platform_profile: Notify class device from
>     platform_profile_notify()
>   ACPI: platform_profile: Allow multiple handlers
>   platform/x86/amd: pmf: Drop all quirks
>   Documentation: Add documentation about class interface for platform
>     profiles
> 
>  .../ABI/testing/sysfs-platform_profile        |   5 +
>  .../userspace-api/sysfs-platform_profile.rst  |  38 ++
>  drivers/acpi/platform_profile.c               | 534 ++++++++++++++----
>  .../surface/surface_platform_profile.c        |   8 +-
>  drivers/platform/x86/acer-wmi.c               |  12 +-
>  drivers/platform/x86/amd/pmf/Makefile         |   2 +-
>  drivers/platform/x86/amd/pmf/core.c           |   1 -
>  drivers/platform/x86/amd/pmf/pmf-quirks.c     |  66 ---
>  drivers/platform/x86/amd/pmf/pmf.h            |   3 -
>  drivers/platform/x86/amd/pmf/sps.c            |   4 +-
>  drivers/platform/x86/asus-wmi.c               |   8 +-
>  drivers/platform/x86/dell/alienware-wmi.c     |   8 +-
>  drivers/platform/x86/dell/dell-pc.c           |  38 +-
>  drivers/platform/x86/hp/hp-wmi.c              |   8 +-
>  drivers/platform/x86/ideapad-laptop.c         |   6 +-
>  .../platform/x86/inspur_platform_profile.c    |   7 +-
>  drivers/platform/x86/thinkpad_acpi.c          |  16 +-
>  include/linux/platform_profile.h              |   9 +-
>  18 files changed, 559 insertions(+), 214 deletions(-)
>  delete mode 100644 drivers/platform/x86/amd/pmf/pmf-quirks.c

-- 
 i.


