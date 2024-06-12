Return-Path: <linux-acpi+bounces-6352-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF3905C70
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0E1C22837
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC3284D34;
	Wed, 12 Jun 2024 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Esckql54"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE715282F7;
	Wed, 12 Jun 2024 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222444; cv=none; b=MB5cOJl9yoQLGvPV252suU7N3wbB8Sp6cJB1TIAKmuTNZu0SA90i7kl6rlrC9fEbGUTtkH017dnpt4CewgBec//ps72PieFrAgLHqLx+G1rWX4raKl1MUBy/BXS2aXK50oK6RlFE9W0286GxXs73xM3PsbK7MTF/TfVnhebb6Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222444; c=relaxed/simple;
	bh=+sT4QFCyZ9rPywBLaXW5eAHNPeHb5HDOJYViJZEW7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVY0YZe7JYlzTzGfl8AeXyO9SV1lg86mcpq50HrR72m/8KnbNa/if3E0KIpiyusnMQeciaQvhwsKa6XJjLpFJY9g813RcugvuCOH7QZvgjTC7iaLdpXWMFaB6kEFAec5N/ahRdMkSrwy2sjVPa+zZji+IKfp2b5PMIkNq8ODOvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Esckql54; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718222443; x=1749758443;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+sT4QFCyZ9rPywBLaXW5eAHNPeHb5HDOJYViJZEW7UQ=;
  b=Esckql54iKcE7a6bmfSlwZTbggNGtHjTVKg0Y8KV1HzuNxquzWcmvHkB
   eLboeRDNmvVyC0vlRKem+cn1bhq+2Xi82ihAUZLXuGlsuz66PVapKXnl7
   xD4o4DN+8CzZN4hX+S/foOHGrOoHyd4a3XVvuzs6WWVnt0INCwnGupppw
   X0DDVdSstq7o3qgn70spDyHm9Ayp7qNwtgWsqPof+UlLh1e4DsCnubH++
   vb1sCNhlkZutbguwmj1HecVz+gyXdaVKExigzdiyu4CxQf3WkAVijRuH0
   Ratkt1jSkl+oXRq8z6bfrtX6cf00bIp63z15lQmjAGI1PF47rXYABmXaJ
   A==;
X-CSE-ConnectionGUID: xSBEnXxmQr+lnFXXU9UJyw==
X-CSE-MsgGUID: y4zI/pdjQaC+1MjjX9FF4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18866984"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18866984"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:00:42 -0700
X-CSE-ConnectionGUID: dCQxWSiqRziCRR17jYLxAA==
X-CSE-MsgGUID: rloq+TnfRmmNF4msepw6Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39762446"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:00:40 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 67CB01201CC;
	Wed, 12 Jun 2024 23:00:36 +0300 (EEST)
Date: Wed, 12 Jun 2024 20:00:36 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Genes Lists <lists@sapience.com>,
	linux-kernel@vger.kernel.org, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
	wentong.wu@intel.com, linux-media@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <Zmn-ZK_KCSLTtpOH@kekkonen.localdomain>
References: <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
 <CAJZ5v0je=Z+2LWv41OVwunujfTD7U2L9QDrNa7MoNBL+Chstnw@mail.gmail.com>
 <Zmnp8JbFj7ZoN5Vy@kekkonen.localdomain>
 <CAJZ5v0ie+OzJ5xd2g-j+pT=D20Ps__dA149XRnX8i9r4KKJ=ww@mail.gmail.com>
 <Zmnxy_8vxaNIJu_v@kekkonen.localdomain>
 <CAJZ5v0h4oF+QVk8VPb+roEjgTS1q0rG6g3STSDn9OgYz=4O6Ww@mail.gmail.com>
 <Zmn0UZ7A3gX_uMVf@kekkonen.localdomain>
 <CAJZ5v0jtGSoqH1Syy4dDpPCWQ5ghT3K=ZWFxmXo6A+kpYEPxOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jtGSoqH1Syy4dDpPCWQ5ghT3K=ZWFxmXo6A+kpYEPxOQ@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 09:32:18PM +0200, Rafael J. Wysocki wrote:
> > This is the first time I hear about a boot failure due to incorrect camera
> > description (on production systems). Could you point me to where this has
> > happened?
> 
> https://lore.kernel.org/lkml/8afe9391b96ff3e1c60e624c1b8a3b2bd5039560.camel@sapience.com/
> 
> or is it not a boot failure?  If so, apologies for misunderstanding.
> 
> Looks serious enough to me though.

This warning comes from drivers/media/pci/intel/ivsc/mei_csi.c line 681 and
it is related to IVSC (Intel Vision Sensing Controller) present on some
systems with IPU6. The driver is necessary for the camera to work in these
systems but then again not all the necessary drivers were in place before
6.10 so this can't be said to be a regression.

The warning is made less verbose by commit
cc864821c7e8b921ebbfb21b17c92f8b3ea3d7ff (on Linus's tree).

-- 
Kind regards,

Sakari Ailus

