Return-Path: <linux-acpi+bounces-1105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E0B7DCAF6
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 11:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F4BFB20DE7
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C31A700
	for <lists+linux-acpi@lfdr.de>; Tue, 31 Oct 2023 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7Swnraj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19E1118E
	for <linux-acpi@vger.kernel.org>; Tue, 31 Oct 2023 08:45:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53C4C1;
	Tue, 31 Oct 2023 01:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698741935; x=1730277935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9L4mxlspwhWbHo4tAtmrYB/SxGPjbl1D/9kB+dCYtRM=;
  b=f7SwnrajLiDYhVgVqd/Z3suhTRlZ3nIF+hJ70qUbvBnPEqYHCVn7wOMn
   4DkO3vPzr5umIpWAwQHtGp7t3X3S7sKkLBovJzUIuORsi6wa7uEnQctdN
   xUTbdPg+FmRc9RYXlfbEwMwX6wLv8TmJ4V4ft3AxRwGlgIqiSrLmo+qD8
   SgQXhYePnrBe6ZtY+71Dffk25CpBrVqMAC4VojmuU4QDnZOhuYUU7QBo9
   dVOhdp91Jqe+1Yk4EE7gwnTG1Wds613dz/O5coOAcH3suHH5QK29WiGva
   q1ewAOX79CNI/9RbilE0fVT/G+0VXSRyVASl+jFuEoO02aj2UeN1fiQma
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="419352215"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="419352215"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:45:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10879"; a="934037016"
X-IronPort-AV: E=Sophos;i="6.03,265,1694761200"; 
   d="scan'208";a="934037016"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2023 01:45:33 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 302C411F894;
	Tue, 31 Oct 2023 10:45:30 +0200 (EET)
Date: Tue, 31 Oct 2023 08:45:30 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] ACPI: scan: MIPI DiSco for Imaging support
Message-ID: <ZUC-qvk_c3SXIhHC@kekkonen.localdomain>
References: <2187487.irdbgypaU6@kreacher>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2187487.irdbgypaU6@kreacher>

Hi Rafael,

On Fri, Oct 20, 2023 at 04:33:56PM +0200, Rafael J. Wysocki wrote:
> Hi Folks,
> 
> This is a new revision of
> 
> https://lore.kernel.org/linux-acpi/13276375.uLZWGnKmhe@kreacher/
> 
> which was reported to have issues and it took time to revisit it.
> 
> > The main points from the original cover letter are still valid:
> > 
> > The general idea is the same - CSI-2 resource descriptors, introduced in
> > ACPI 6.4 and defined by
> > 
> > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-i
> > nterface-csi-2-connection-resource-descriptor
> > 
> > are found and used for creating a set of software nodes that represent the
> > CSI-2 connection graph.
> > 
> > These software nodes need to be available before any scan handlers or ACPI
> > drivers are bound to any struct acpi_device objects, so all of that is done
> > at the early stage of ACPI device enumeration, but unnecessary ACPI
> > namespace walks are avoided.
> > 
> > The CSI-2 software nodes are populated with data extracted from the CSI-2
> > resource descriptors themselves and from device properties defined by the
> > MIPI DiSco for Imaging specification (see
> > https://www.mipi.org/specifications/mipi-disco-imaging).
> > 
> > Patches [4,6/6] come from the original series directly, but the other
> > patches have been changes substantially, so I've decided to re-start patch
> > series versioning from scratch.
> 
> The v2 addresses at least 3 issues found in the v1 by code inspection:
> 
> * A port_count field incrementation was missing in acpi_mipi_scan_crs_csi2(),
>   so its value for all of the devices having CSI2 resources in _CRS was always
>   1 (and it should be equal to the number of valid CSI2 connection resources).
> 
> * Some acpi_mipi_crs_csi2_list members could be freed prematurely, so they were
>   inaccessible when extract_crs_csi2_conn_info() attempted to access them.
> 
> * A check of remote_swnodes() against NULL was missing, which could result in
>   a crash in a case when the swnodes memory could not be allocated for some
>   acpi_mipi_crs_csi2_list entries.
> 
> Apart from that, it rearranges the code somewhat to make it easier to follow
> and to avoid premature freeing of memory in it in general and the new file
> added by it is now called mipi-di.c (instead of mipi-disco-imaging.c) for
> compactness.
> 
> The series is based on current linux-next.

Thanks for the update. I've tested this and I can confirm it works, to the
extent implemented in the set. The rest can be implemented on top
(mainly replicating properties).

I'll comment on a few patches in the set.

Do you prefer to make the changes or shall I? I presume them to be fairly
minor.

-- 
Regards,

Sakari Ailus

