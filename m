Return-Path: <linux-acpi+bounces-6590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5AC913917
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2024 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390F5281C03
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Jun 2024 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64051364A0;
	Sun, 23 Jun 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5mCzG/i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4894D6E5ED;
	Sun, 23 Jun 2024 08:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719132863; cv=none; b=WvpYg8hgRU/+YEVio17vCMMwf3iSNUuRFjWOOeyg81rMLNgbFnRoryRmVC7QxeQMDPVooUjLyKedsG4tkwymKNRGn0t6NORNxmqjZiR7J9ldNf+4GiHwJB/g8hubMrFEpmENoYd8DR23Q+KFcRWMdK9gtGcFCBuJFJNlhPH3pvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719132863; c=relaxed/simple;
	bh=NK+GSlkQYz6auxu2HnNKbWueXrURc2LeDnNadxDvjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkMmGwCP/TxPa8I3ueQWoGIlXm1VBffik40yCPPHyJd1YicEoMiYo5l7HVd8b13XShptkir4orXgUoyc9jF5MmiYez/vw+mSNXraMzHR8EvBDMiEKDMRdBA5+3dOPAydzuAk4qXOqvShZxQM2xa55LRLpEsIOZDUCwNGt0tgGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5mCzG/i; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719132861; x=1750668861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NK+GSlkQYz6auxu2HnNKbWueXrURc2LeDnNadxDvjFo=;
  b=B5mCzG/isdOhEs6iJX/sQ4DxqtQGKbz/YRprVYjQFOjlTffzTd8UxDow
   nD9VlbmaKKLxkbvvKJIkBYH9JGhn13uL96KQvJXV+fxP7g5uBvWLtcF00
   NM01eRbOq3iTu7MPfFBOMlfetzzZg7YT71pq1k7BUcwZ9cmAWVGcUCeni
   uAiZmCTVPbZBGzpFoy0H+qqh0kCBlWamNd9UE4p5dvufZ48HAS0RuiEh+
   85tC5wRop8bZLwNCkzp8DQwgvn8OIE6tXlKNACP7guIg+1bfWkYNu/KDz
   X0+iMagYtfLmBzldUNAVzm7QvuWWKUV4Jh3QBWqxs4NELYFTh0Ri3k0vZ
   g==;
X-CSE-ConnectionGUID: JANSssXNR/i1ILvkjnYDLg==
X-CSE-MsgGUID: kZPgHcNHTmiy+tNpGlDszw==
X-IronPort-AV: E=McAfee;i="6700,10204,11111"; a="26707221"
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="26707221"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 01:54:21 -0700
X-CSE-ConnectionGUID: /yL1qXlkTaKXiBTvwO9Tsw==
X-CSE-MsgGUID: KW9gJ6q7QDSLGlx5Eu8bEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,259,1712646000"; 
   d="scan'208";a="43123308"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 01:54:19 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 058F711FA94;
	Sun, 23 Jun 2024 11:54:17 +0300 (EEST)
Date: Sun, 23 Jun 2024 08:54:16 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ACPI: scan: Ignore camera graph port nodes on all
 Dell Tiger, Alder and Raptor Lake models
Message-ID: <ZnfiuExIpLh-Nw-S@kekkonen.localdomain>
References: <20240612104220.22219-1-hdegoede@redhat.com>
 <CAJZ5v0iZPs9gdaeCG+c-FAuEeoHDTbyR2TsmFLC837fy+TQrvQ@mail.gmail.com>
 <ZnCYwPFyIM1HYkt3@kekkonen.localdomain>
 <CAJZ5v0hg-EMzgce5FH10uQqY1d37sGW3dyyZ-P8Uizg2i8+MOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hg-EMzgce5FH10uQqY1d37sGW3dyyZ-P8Uizg2i8+MOA@mail.gmail.com>

Hi Rafael,

On Tue, Jun 18, 2024 at 02:49:25PM +0200, Rafael J. Wysocki wrote:
> Hi Sakari,
> 
> On Mon, Jun 17, 2024 at 10:12 PM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > Hi Rafael,
> >
> > On Mon, Jun 17, 2024 at 09:41:57PM +0200, Rafael J. Wysocki wrote:
> > > On Wed, Jun 12, 2024 at 12:42 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > > >
> > > > It seems that all Dell laptops with IPU6 camera or the Tiger Lake,
> > > > Alder Lake and Raptor Lake generations have broken ACPI MIPI DISCO
> > > > information.
> > > >
> > > > Instead of adding a lot of DMI quirks for this, check for these CPU
> > > > generations and disable ACPI MIPI DISCO support on all Dell laptops
> > > > with these CPU generations.
> > > >
> > > > Fixes: bd721b934323 ("ACPI: scan: Extract CSI-2 connection graph from _CRS")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > > > ---
> > > >  drivers/acpi/internal.h       |  4 ++++
> > > >  drivers/acpi/mipi-disco-img.c | 28 +++++++++++++++++++---------
> > > >  2 files changed, 23 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> > > > index 2a0e9fc7b74c..601b670356e5 100644
> > > > --- a/drivers/acpi/internal.h
> > > > +++ b/drivers/acpi/internal.h
> > > > @@ -302,6 +302,10 @@ void acpi_mipi_check_crs_csi2(acpi_handle handle);
> > > >  void acpi_mipi_scan_crs_csi2(void);
> > > >  void acpi_mipi_init_crs_csi2_swnodes(void);
> > > >  void acpi_mipi_crs_csi2_cleanup(void);
> > > > +#ifdef CONFIG_X86
> > > >  bool acpi_graph_ignore_port(acpi_handle handle);
> > > > +#else
> > > > +static inline bool acpi_graph_ignore_port(acpi_handle handle) { return false; }
> > > > +#endif
> > > >
> > > >  #endif /* _ACPI_INTERNAL_H_ */
> > > > diff --git a/drivers/acpi/mipi-disco-img.c b/drivers/acpi/mipi-disco-img.c
> > > > index d05413a0672a..0ab13751f0db 100644
> > > > --- a/drivers/acpi/mipi-disco-img.c
> > > > +++ b/drivers/acpi/mipi-disco-img.c
> > > > @@ -725,14 +725,20 @@ void acpi_mipi_crs_csi2_cleanup(void)
> > > >                 acpi_mipi_del_crs_csi2(csi2);
> > > >  }
> > > >
> > > > -static const struct dmi_system_id dmi_ignore_port_nodes[] = {
> > > > -       {
> > > > -               .matches = {
> > > > -                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> > > > -                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "XPS 9315"),
> > > > -               },
> > > > -       },
> > > > -       { }
> > > > +#ifdef CONFIG_X86
> > > > +#include <asm/cpu_device_id.h>
> > > > +#include <asm/intel-family.h>
> > > > +
> > > > +/* CPU matches for Dell generations with broken ACPI MIPI DISCO info */
> > > > +static const struct x86_cpu_id dell_broken_mipi_disco_cpu_gens[] = {
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P, NULL),
> > > > +       X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S, NULL),
> > > > +       {}
> > > >  };
> > > >
> > > >  static const char *strnext(const char *s1, const char *s2)
> > > > @@ -761,7 +767,10 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> > > >         static bool dmi_tested, ignore_port;
> > > >
> > > >         if (!dmi_tested) {
> > > > -               ignore_port = dmi_first_match(dmi_ignore_port_nodes);
> > > > +               if (dmi_name_in_vendors("Dell Inc.") &&
> > > > +                   x86_match_cpu(dell_broken_mipi_disco_cpu_gens))
> > > > +                       ignore_port = true;
> > > > +
> > > >                 dmi_tested = true;
> > > >         }
> > > >
> > > > @@ -794,3 +803,4 @@ bool acpi_graph_ignore_port(acpi_handle handle)
> > > >         kfree(orig_path);
> > > >         return false;
> > > >  }
> > > > +#endif
> > > > --
> > >
> > > Applied as 6.10-rc material, along with the [2/2], with the following changelog:
> > >
> > > "Dell laptops with IPU6 camera (the Tiger Lake, Alder Lake and Raptor
> > > Lake generations) have broken ACPI MIPI DISCO information (this results
> > > from an OEM attempt to make Linux work by supplying it with custom data
> > > in the ACPI tables which has never been supported in the mainline).
> >
> > I was expecting to see v2 with fixed changelog from Hans.
> 
> Hans asked me offline to take care of this.

Ok.

> 
> > These issues with these (full list unknown) Dell laptops have nothing to do
> > with DisCo for Imaging, not the spec nor the implementation. Instead the
> > DSDT partially aligns with Documentation/firmware-guide/acpi/dsd/graph.rst
> > but lacks e.g. IVSC from the graph as well as ACPI power resources for
> > devices related to camera. IOW it's always been unusable.
> 
> The code related to DisCo for Imaging ends up using them and failing,
> though, IIUC.
> 
> So what should I change in the paragraph quoted above?

How about this:

Many Dell laptops, possibly all of them with IPU6 camera (the Tiger Lake,
Alder Lake and Raptor Lake generations) have Linux ACPI graph describing
camera connections only partially while the rest of what would be required
for the cameras to function in these systems is simply missing in DSDT.

> 
> > >
> > > Instead of adding a lot of DMI quirks for this, check for Dell platforms
> > > based on the processor generations in question and drop the ACPI graph
> > > port nodes, likely to be created with the help of invalid data, on all
> > > of them."
> 
> Am I guessing correctly that the remaining part of it is fine?

Seems good to me.

-- 
Kind regards,

Sakari Ailus

