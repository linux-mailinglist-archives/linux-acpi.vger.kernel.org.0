Return-Path: <linux-acpi+bounces-6471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A1790BBC8
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 22:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 819441F21CD2
	for <lists+linux-acpi@lfdr.de>; Mon, 17 Jun 2024 20:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2311186287;
	Mon, 17 Jun 2024 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jGRLRmbf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FEE17F397;
	Mon, 17 Jun 2024 20:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718655174; cv=none; b=YieziRl0josdxJ6PBtec2EiQgGQpj8V6DopuHgFNc3boEXy6J43YgbX+SNrhN7E1x84+ojFieLOLCy5zSxboiml1lmrUqBrI2IDpYEmg3JS4K53o2P6ZdM9xVBB5MSdq0GEty09Ljfs7T2+DW4DMOi0tSyTJ4yv3MAKXwElGT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718655174; c=relaxed/simple;
	bh=lL8RVn4mILVVScNvJ20jo/RXWLPGT4iUlg/eS7EpBRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrpCTMAzuP/zqSCCzCPqs7iRidLxkQJyC0VqNVaSE2B7pE7SAYq9QK1+b02TB33I5kEsS3WvWCenKWedWADfAeGuT7LdlH0HAUQXeClxfjqTni7Q8VRqnjbS+bxQXV0VW19dP+9OhWd5bKq1IwaOHYvRbMqlJAukWAh3A2UH5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jGRLRmbf; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718655173; x=1750191173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lL8RVn4mILVVScNvJ20jo/RXWLPGT4iUlg/eS7EpBRg=;
  b=jGRLRmbfejzNP2d2Nj+KxQKopIJPhh4Oy5KXa5uCU2GKxYwSGg7waACX
   zO2yrIiy+N5ZSI4gmTmxrYbdhTEoqL2dnmQDnw7CgW5SBJKqUZ3AeHhrJ
   d4EwhOVdh7VEZGJzlui4P2VlCoHsd7NUlMyt+9M/iLLWEYrLqBMYokJ07
   dLvNjVvMqh0plj/q9oQZ6oum+DFBZRLXUYG/909m1bFbGPMBdjEfMYbe+
   cnPmErvS+ygk9rQzOzjyKO8/akZlbzlp/++FNc598XQLaqxji95aO+veD
   g2+Ib2zyeyn7AcinbC0YJAhWUn5042CzVgX0rbz2EukcaHL95q8DI9lvW
   g==;
X-CSE-ConnectionGUID: lUhDPKW7Syyzg/Zyuie/CQ==
X-CSE-MsgGUID: 2If7r6+YSXKz47JlBGjmmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26185461"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="26185461"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 13:12:52 -0700
X-CSE-ConnectionGUID: nDFMYQbuR3OH0npfgz10zw==
X-CSE-MsgGUID: m6DjMrmgQN+vSOeo6AQdtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41167238"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 13:12:51 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 367F411F9DB;
	Mon, 17 Jun 2024 23:12:48 +0300 (EEST)
Date: Mon, 17 Jun 2024 20:12:48 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
Message-ID: <ZnCYwPFyIM1HYkt3@kekkonen.localdomain>
References: <20240612104220.22219-1-hdegoede@redhat.com>
 <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>

Hi Rafael,

On Mon, Jun 17, 2024 at 09:41:57PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 12, 2024 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
> > Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> > information.
> >
> > Instead of adding a lot of DMI quirks for this, check for these CPU
> > generations and disable ACPI MIPI DISCO support on all Dell laptops
> > with these CPU generations.
> >
> > Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CRS")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  drivers/acpi/internal.h       |  4 ++++
> >  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
> >  2 files changed, 23 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > index 2a0e9fc7b74c..601b670356e5 100644
> > --- a/drivers/acpi/internal.h
> > +++ b/drivers/acpi/internal.h
> > @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
> >  void acpi_mipi_scan_crs_csi2(void);
> >  void acpi_mipi_init_crs_csi2_swnodes(void);
> >  void acpi_mipi_crs_csi2_cleanup(void);
> > +#ifdef CONFIG_X86
> >  bool acpi_graph_ignore_port(acpi_handle handle);
> > +#else
> > +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return false; }
> > +#endif
> >
> >  #endif /* _ACPI_INTERNAL_H_ */
> > diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> > index d05413a0672a..0ab13751f0db 100644
> > --- a/drivers/acpi/mipi-disco-img.c
> > +++ b/drivers/acpi/mipi-disco-img.c
> > @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
> >                 acpi_mipi_del_crs_csi2(csi2);
> >  }
> >
> > -static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> > -       {
> > -               .matches = {
> > -                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > -                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> > -               },
> > -       },
> > -       { }
> > +#ifdef CONFIG_X86
> > +#include <asm/cpu_device_id.h>
> > +#include <asm/intel-family.h>
> > +
> > +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
> > +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
> > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> > +       {}
> >  };
> >
> >  static const char *strnext(const char *s1, const char *s2)
> > @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> >         static bool dmi_tested, ignore_port;
> >
> >         if (!dmi_tested) {
> > -               ignore_port = dmi_first_match(dmi_ignore_port_nodes);
> > +               if (dmi_name_in_vendors("Dell Inc.") &&
> > +                   x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
> > +                       ignore_port = true;
> > +
> >                 dmi_tested = true;
> >         }
> >
> > @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> >         kfree(orig_path);
> >         return false;
> >  }
> > +#endif
> > --
> 
> Applied as 6.10-rc material, along with the [2/2], with the following changelog:
> 
> "Dell laptops with IPU6 camera (the Tiger Lake, Alder Lake and Raptor
> Lake generations) have broken ACPI MIPI DISCO information (this results
> from an OEM attempt to make Linux work by supplying it with custom data
> in the ACPI tables which has never been supported in the mainline).

I was expecting to see v2 with fixed changelog from Hans.

These issues with these (full list unknown) Dell laptops have nothing to do
with DisCo for Imaging, not the spec nor the implementation. Instead the
DSDT partially aligns with Documentation/firmware-guide/acpi/dsd/graph.rst
but lacks e.g. IVSC from the graph as well as ACPI power resources for
devices related to camera. IOW it's always been unusable.

> 
> Instead of adding a lot of DMI quirks for this, check for Dell platforms
> based on the processor generations in question and drop the ACPI graph
> port nodes, likely to be created with the help of invalid data, on all
> of them."

-- 
Kind regards,

Sakari Ailus

