Return-Path: <linux-acpi+bounces-3425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF60C851CE5
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 19:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7446A2828FC
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 18:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2D3EA69;
	Mon, 12 Feb 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HY6Eee5p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7182B45958
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763024; cv=none; b=hReuoPcv3KIctSRG487UibG993pjgdEuB52S3MeaPr7N7WPp/xqsTwth29opXRrNBev+RQ3XLWS3SgLdqLMcPG7KUE/NApOpAdgojCFgMeZCqhydZkQ5gyY4OtRwDFJPMf52GqZG7LppETUwcGuof9y+Onm+A1mby7LKuc7YeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763024; c=relaxed/simple;
	bh=XFI7cim6GhCpVatFogkN3NywIuXjo4gVDqZQCc+v6aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7ejVflkG5eTHTZC2KQ7MMpBn3OH7ZuWtzZ7o5LCJI+i2yXisdyHK0NI10FHuQCZsfoWD2xa6CuzZQXvbUw7oKTYw6FK2UBQHeDiinYnmwV7dQoNJC0S1C2v9mv6GgiKSLjt+CT+h3ban7dsGRy+X4U+1XQHQ8VQtxaTaAtG3Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HY6Eee5p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707763023; x=1739299023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFI7cim6GhCpVatFogkN3NywIuXjo4gVDqZQCc+v6aw=;
  b=HY6Eee5pRteCt4KYOiYmzEARqUomQMrC9kCnTPhs5tOl2Ci79oM/p2q5
   wdK94Bl9YLfMjD6RVV20KrZ+UXYQRvlfMOXdy0rNx92VFy3HqgfO/KMwV
   bDDkvosMGwKLwwSXuCKzBB3+JD/2xn4cDCNsguEwhhOVc1XyqYjf045jU
   CDgX7g8Q+NFvY67Ek5+5Whh26PHG9yD7KhIU1lKIWsNCvdBOGUSQYdmiF
   EmzXFT23r7H5NqWEci1xRYtltxb4tjYYSOY5mU5J4APhzg6BZkxo1qnGr
   rRd73C+pgbihRNikWYBhDe24QOkaAXv1q0mbDiZBKPW9w4aSWdeBH+vRl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="19165680"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="19165680"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 10:37:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935138217"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="935138217"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 10:37:01 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 0C1A911F9DB;
	Mon, 12 Feb 2024 20:36:59 +0200 (EET)
Date: Mon, 12 Feb 2024 18:36:59 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: property: Ignore bad data nodes
Message-ID: <ZcplS6p4CfvmF6uX@kekkonen.localdomain>
References: <20240212100032.346422-1-sakari.ailus@linux.intel.com>
 <20240212100032.346422-3-sakari.ailus@linux.intel.com>
 <CAJZ5v0jOZJDJ=zqY09gYM7SrN0AB+SzdoGpF3i4F2YQiTtd8Og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jOZJDJ=zqY09gYM7SrN0AB+SzdoGpF3i4F2YQiTtd8Og@mail.gmail.com>

Hi Rafael,

Thanks for the review.

On Mon, Feb 12, 2024 at 02:53:12PM +0100, Rafael J. Wysocki wrote:
> There is a bit too little information in the subject, it may as well
> be the same as the series title.
> 

...

> > +       static bool dmi_tested = false, ignore_port;
> 
> It is not necessary to initialize static variables to false.

I'll address these in v2.

-- 
Sakari Ailus

