Return-Path: <linux-acpi+bounces-5462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C550D8B5C07
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81D95288829
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Apr 2024 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7AA80058;
	Mon, 29 Apr 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BMTywdxk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34707641B
	for <linux-acpi@vger.kernel.org>; Mon, 29 Apr 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402506; cv=none; b=DbCgsE+rUSBFkteBK+zWHHkR2kIYa9napK6iSlIUsUUXYe9/fZe6xxJ2ifbbzQj+vCS03XGeVYyt4W4DAxRO7R1SZ0Hv2ush77s+ykSc785RW9sMgDLmznmuKkIcpuykIYAAAVxM5+nNq/nQ5OUJ/kj80jXm9Jk96/Ya1Ctaghw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402506; c=relaxed/simple;
	bh=kqm+00gRhIZ9cVdk70Z9zqJQD734+HFtG+ZaAfUB1VU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9S0Kh0l2dO1aQXdNjVRjEiC9j/5dyAAy2OXvxEqQ8hIzYszPdNMUP1glxpC4nynaFtpnKb9EN4pUVni0Vl0U0T5veUiUXT+R6OgSGe8qiZUiKoTA7rRgqflTb7s8M9U6/xox9xK/WJadio1nxWBle7ehuYFvfwYGQvHA+MJ69A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BMTywdxk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714402505; x=1745938505;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kqm+00gRhIZ9cVdk70Z9zqJQD734+HFtG+ZaAfUB1VU=;
  b=BMTywdxkinwSZdCrhOqohZ+eqqeWYPUO9J2WLSeuWKMIBHiCqu/9Uawr
   ffi18wGrKkzSnXJY6s24hOnhHFim5ruZBBa2E59+cwCUTUt/KZlqzIkU5
   hgJweKHufLm3TBfVw+lo0eUDhRoUvlvoArC3IadmAn1q+B8OLcALDUsV5
   pZbVWe+zNGTyp43vX7hmkw9chYjye7L2d8egkbgmDt/RMX3gl2dr+akai
   yLPSNmvaAgr+9vkJuU1tRr2fkz84n8B6HOi0Cwca+5cL768eYEGazkoO5
   Oh/nICgzL0t/+6locPMDSCCJxaLgMnDohSwl0vr8ZlS0IVtJiH8p8u46E
   w==;
X-CSE-ConnectionGUID: OJNnKEtSS8Cv/FlYi//IPw==
X-CSE-MsgGUID: 2+JTTcvBTbiGGZoFXSAXUg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="9942189"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="9942189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 07:55:02 -0700
X-CSE-ConnectionGUID: 5gDVzCaeR2mUbXFibuggww==
X-CSE-MsgGUID: vfLK2+tHTFerbMo9dHQMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26123964"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmviesa007.fm.intel.com with SMTP; 29 Apr 2024 07:55:00 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 29 Apr 2024 17:54:58 +0300
Date: Mon, 29 Apr 2024 17:54:58 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Missing default handler for the EmbeddedControl OpRegion
Message-ID: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There's a bug that is caused by an EmbeddedControl OpRegion which is
declared inside the scope of a specific USB Type-C device (PNP0CA0):
https://bugzilla.kernel.org/show_bug.cgi?id=218789

It looks like that's not the only case where that OpRegion ID is used
outside of the EC device scope. There is at least one driver in Linux
Kernel (drivers/platform/x86/wmi.c) that already has a custom handler
for the EmbeddedControl OpRegion, and based on a quick search, the
problem "Region EmbeddedControl (ID=3) has no handler" has happened
with some other devices too.


Br,

-- 
heikki

