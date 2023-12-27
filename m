Return-Path: <linux-acpi+bounces-2632-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E1A81F109
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Dec 2023 18:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B7A281DD9
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Dec 2023 17:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7F446538;
	Wed, 27 Dec 2023 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qq18Obx+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A7A4652D
	for <linux-acpi@vger.kernel.org>; Wed, 27 Dec 2023 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703698908; x=1735234908;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JzdUw66LNI3/E8KPP6kG1AquAHKaUfM8tf5yH4kyXsc=;
  b=Qq18Obx+1fe9uMDAEDHGw2gohU7rwoaLMLM8VJPRoXJxAlmguLNEds6X
   QihCpG60IvoBFlq09RMU/6u6p3jpsoblhKPn1S3a7x4uYZo6Y346JXAJq
   qslN3qRD5GywYFBuo/rWir9wqWbD/jhaN5EevRTgF+dllWEE3sOahwe+e
   5gxnixDCmBuBtEfU6PJtF6k0IaStULVu0diNcx7cCbHerOqgBJBKA9DTe
   +VHhig5rSnMdUXulNFILkKW6uaJUrxSq65me+XkErpUQ09Rz3MDPHwuS0
   CoqQk8Hc3CPrbj7sKl9NXpBq3mKj9UTZk//pryalqvsUiuHA65uM+1Cp5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="399256701"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="399256701"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:41:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="921885486"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="921885486"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:41:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rIXuZ-00000009Th4-3ft9;
	Wed, 27 Dec 2023 19:41:43 +0200
Date: Wed, 27 Dec 2023 19:41:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ken Xue <Ken.Xue@amd.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, cwhuang@linux.org.tw
Subject: Re: [PATCH V6] acpi: button: trigger wakeup key event
Message-ID: <ZYxh16_Je2-aH0ai@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 25, 2023 at 01:58:35PM +0800, Ken Xue wrote:
> Andorid can wakeup from various wakeup sources, but only several wakeup
> sources can wake up screen with right events(POWER, WAKEUP) from input
> device.
> 
> Regarding pressing acpi power button, it can resume system and
> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
> pm1a_sts, but kernel does not report any key event to user space during
> resuming by default.
> 
> So, send wakeup key event to user space during resume from power button.
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The code has been factually changed, but I'm okay with this version as well.

-- 
With Best Regards,
Andy Shevchenko


