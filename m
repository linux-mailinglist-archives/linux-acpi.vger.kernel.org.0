Return-Path: <linux-acpi+bounces-1052-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F647D91B0
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 10:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C625F1C20947
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332AA15AD5
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Oct 2023 08:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJ5GpzVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22451401C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Oct 2023 08:19:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE021A5;
	Fri, 27 Oct 2023 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698394740; x=1729930740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fKhuSuimjMHe0ZYKyeN0w2PtHHlDdq7wGbuhciWCKI0=;
  b=YJ5GpzVY6bOewGFALcxopy0Kf/dR7J5iYBIQ+TW26gUStvDB+SllWi/9
   zWiOUkR1pI0JQIYx40174/hDXLSjpiIkPDzZf99jQ6/hAnbovVqsmCa6n
   fWqQ5bz9rfRam/5zFxwmiQDTOJVSQpPikIFRBXvPh3pbfOIZ6I5m5pD+X
   WnFHz//tH4Skd0BIeFnIM+WN4Mm9NYjKZpZnzqHItGZYrLQPyZn8igmmi
   jXGPFUqL8edMu0shm6eY/aJH3XSGYmNO+TsgNEFebXSlVdLohowj6+qfD
   EC71W3aSFvw9/NTTnCd9t5gHhy2vSbV0PbAVZXJef9NgbKB/tHQFaJ/Ut
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="552430"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="552430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 01:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="736023268"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="736023268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2023 01:18:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id D215A22B; Fri, 27 Oct 2023 11:18:55 +0300 (EEST)
Date: Fri, 27 Oct 2023 11:18:55 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com,
	andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mallikarjunappa.sangannavar@intel.com,
	bala.senthil@intel.com
Subject: Re: [PATCH v2] ACPI: LPSS: use acpi_dev_uid_match() for matching _UID
Message-ID: <20231027081855.GK3208943@black.fi.intel.com>
References: <20231026083335.12551-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231026083335.12551-1-raag.jadav@intel.com>

On Thu, Oct 26, 2023 at 02:03:35PM +0530, Raag Jadav wrote:
> Now that we have a standard ACPI helper, we can use acpi_dev_uid_match()
> for matching _UID as per the original logic before commit 2a036e489eb1
> ("ACPI: LPSS: Refactor _UID handling to use acpi_dev_uid_to_integer()"),
> instead of treating it as an integer.
> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

The change still looks good to me, however I wonder if we could maybe
improve acpi_dev_uid_match() to support both data types possible for
_UID? This of course is separate patch (unless there are objections).

There is the _Generic() thing and I think that can be used to make

  acpi_dev_uid_match()

which takes either u64 (or maybe even unsigned int) or const char * and
based on that picks the correct implementation. Not sure if that's
possible, did not check but it would allow us to use one function
everywhere instead of acpi_dev_uid_to_integer() and
acpi_dev_uid_match().

