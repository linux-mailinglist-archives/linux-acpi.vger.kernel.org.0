Return-Path: <linux-acpi+bounces-6355-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A99F0905CA3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 22:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D8662844F1
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 20:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5F6F513;
	Wed, 12 Jun 2024 20:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMk9JOmn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2841C6D;
	Wed, 12 Jun 2024 20:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223448; cv=none; b=lrP5Ov8MPR3lzC7iMHnTzUNF1SvN8DDjtGQUxE4FVbFdNW0Q9VMkdoxY8LaDOphP4E1ZFmHovVnxF8Pygfgd88fnd2ZXwwZXGDvCPJVmywrJ4UYmDdL7aYeSn+iv7h0RAGV85nNUe5astn/s5VbsAxO7Egpxp2BiRSmJIETFqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223448; c=relaxed/simple;
	bh=q7EfPL+XSV12Vu+QjEZPznN9se1uAurlKUYQE5Emi0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rv2M8effFrdEap4UiTkFpOezahmKFUU8Uw1J79Ej6rUXjVtPTRHB7zEMjjLnhcEd49demDgXXKZra12h4J6RMrkEN9WdV0m36FLs4CjFOz/2PVFYo1gg24+zpfjXLWFcfkFdJBwPx12Tmv1icspL82XDBQfyVy3XtGUjHXzHbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMk9JOmn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718223448; x=1749759448;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7EfPL+XSV12Vu+QjEZPznN9se1uAurlKUYQE5Emi0Q=;
  b=SMk9JOmnVEuXq9a4Unoy0TXvaz6fKWuOHaEABEQGXoIE7KTWBC3x98zs
   vQb1JwUpfDxfa34VVvMeFOK4o5UYJgRjjyMPkieDNMEKbtBckDz4GCF2u
   oDoHKniXQOO93b6ej8AgonCfTYI0DShzALDbuora/BUrKdtz/3/i2T4Kl
   eVuiluIKC8wV5TPcBkLYHPNhUmg0m+WslFzUKTms3XGGb8HyD7QzWgqHT
   PWFjKxBv9THZF7q4gb0oYvVk3M9Wb/xPiY2DXq5zpW3v3NE27sqcyiDBs
   VbsH8dETB7AMBL7ja9K9RAD5yvyV5FwBWYj416Zrrcx8NWcte/urF0E2Z
   g==;
X-CSE-ConnectionGUID: 9VhRU7pHTmqKet9HwJUfTA==
X-CSE-MsgGUID: gWU/rn99SP2Xu3yqpo18Xg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32496606"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32496606"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:17:27 -0700
X-CSE-ConnectionGUID: jmkzo36SRMWwI5ZCLgl0cA==
X-CSE-MsgGUID: k6MxY77ETXKB9cKuLnpNcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="77354951"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 13:17:24 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 6F23911FA94;
	Wed, 12 Jun 2024 23:17:21 +0300 (EEST)
Date: Wed, 12 Jun 2024 20:17:21 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
	laurent.pinchart@ideasonboard.com, wentong.wu@intel.com,
	linux-media@vger.kernel.org, linux-acpi@vger.kernel.org,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/1] ACPI: scan: Ignore Dell XPS 9320 camera graph port
 nodes
Message-ID: <ZmoCUZxlSHy_PclO@kekkonen.localdomain>
References: <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
 <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
 <CAJZ5v0j7HTfg1wY+B+7vhE6tBKPVHMuu_MsFHjaLK70VS_cNEw@mail.gmail.com>
 <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18cb82bb-51c6-4a52-80a4-6b1e3d95f99c@redhat.com>

Hi Hans,

On Wed, Jun 12, 2024 at 04:30:30PM +0200, Hans de Goede wrote:
> Sakari I know you have been pushing for MIPI camera descriptions under
> ACPI to move to a standardized format and I can see how that is a good
> thing, but atm it seems to mainly cause things to break and before
> the ACPI MIPI DISCO support landed in 6.8 we did not have these issues,
> since the information used by the ipu-bridge code does seem to be correct.

Support for capturing from cameras on IPU6 systems (IPU6 ISYS driver and
IPU bridge changes) was upstreamed for 6.10, with some drivers such as IVSC
(four of them) and IVSC related IPU bridge changes merged for 6.8 already.

We can't guarantee the continued functioning of downstream drivers in cases
where new upstream drivers for the same devices get merged to the kernel,
often with different APIs. You know that as well as I do.

In other words, there was no regression with respect to the upstream
kernel.

-- 
Kind regards,

Sakari Ailus

