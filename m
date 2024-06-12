Return-Path: <linux-acpi+bounces-6329-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D59052D8
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 14:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A3BBB22DFE
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jun 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366F5172BCF;
	Wed, 12 Jun 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X3L0As8D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9207171E74;
	Wed, 12 Jun 2024 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196454; cv=none; b=cBL+NY6SeRQ2g8Hffw4dhscJOi6VMExiHPrKvzxf2u4kCKstUwI67PSdGJZq0kaL5N2SChE4IIGHDlonfEBqWZBkQg+gt7T8baAIN1+0H067VxTTikq717PzEjEKP1YZD+0uenCipB21iY493s1d3rfx1Vqjl4+7/1ErBk/4ffg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196454; c=relaxed/simple;
	bh=RCpcnDSuYyhSuOfsyj0v8b20wpxftEkl0uwbleRYRug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhaqKecolN3kGMniU3ZLeYBucw5p6zbhTlhtghwjh4lE4bLuuV+Zz6Z9MG38qjEybqBIdz7ryvoQ7sXQaohSc23lCrYWevBYhM6iX9Lo5VT1OV7klImQiU1gmjRlUM9jlhBNXLsL7d1+FowZ5KGcyxhYatyaMdoOmKMdp9l1Urw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X3L0As8D; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718196453; x=1749732453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCpcnDSuYyhSuOfsyj0v8b20wpxftEkl0uwbleRYRug=;
  b=X3L0As8DQxoCXKfOZ7eYjxQXcIVcUMsAZ7olcRgnxsQy1drf/2m8RcDp
   5j9wdcJxZ6DHIR1o8LxYLt+dUfeH2GcDZZsXYb30JgUoSVG7S/+QHj4q/
   VeERjB7tZ3ZenEbpdOUmppxfMyLANS5IAwX/C9znoLFWc+0UfkWnnjCz6
   SKpSkgUt9xf8U/vVjWqq4neSI801/fasr4aEe3lVlsrXWx9l4D1AZCk/e
   hAfoUoNQRfq38djY1gOpsVg+wUC3Q0v9UcEESauKOCxXNis4QvDNGMVnr
   r5y72/QGuXakl1Yama+LqzajE1/YmzBFRe/wvKDteDj9GLyuvZH7Huvse
   g==;
X-CSE-ConnectionGUID: VDzQQz+SRDGhawAOSIXqPw==
X-CSE-MsgGUID: dZqZo4R6QT+SrhefZ5sdRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14829370"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="14829370"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:47:32 -0700
X-CSE-ConnectionGUID: vX5eai9VRA6LWem5iWRhDg==
X-CSE-MsgGUID: kW6Vl90bSTyr+WYelJmpYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="40477364"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 05:47:29 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 5D34811FA94;
	Wed, 12 Jun 2024 15:47:26 +0300 (EEST)
Date: Wed, 12 Jun 2024 12:47:26 +0000
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
Message-ID: <ZmmY3he9vfWVWU3I@kekkonen.localdomain>
References: <988e48090982c89ce0c906954832fdfb09a1ce34.camel@sapience.com>
 <20240528084413.2624435-1-sakari.ailus@linux.intel.com>
 <a05df025-a0be-49cd-84a9-7d7fb2eeb33e@redhat.com>
 <e9062095-b312-44df-a9e3-0b09f3ec9eff@redhat.com>
 <4b387b4d-f778-4891-9f07-df5fc0a093cd@redhat.com>
 <ZmmQLt7wB-yGQBTw@kekkonen.localdomain>
 <CAJZ5v0ii3WFQRPdfHeeW4M9kXSWDVxxxy02zThcf25mjNwqDAw@mail.gmail.com>
 <ZmmT56Cyvb2FCyav@kekkonen.localdomain>
 <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hOBggQR_=uA3VuhruQnZihVxHHovpTz4=qfcbiSunsYw@mail.gmail.com>

Hi Rafael,

On Wed, Jun 12, 2024 at 02:32:26PM +0200, Rafael J. Wysocki wrote:
> > > > > I just hit the same problem on another Dell laptop. It seems that
> > > > > all Dell laptops with IPU6 camera from the Tiger Lake, Alder Lake
> > > > > and Raptor Lake generations suffer from this problem.
> > > > >
> > > > > So instead of playing whack a mole with DMI matches we should
> > > > > simply disable ACPI MIPI DISCO support on all Dell laptops
> > > > > with those CPUs. I'm preparing a fix for this to replace
> > > > > the DMI matching now.
> > > >
> > > > DisCo for Imaging support shouldn't be dropped on these systems, and this
> > > > isn't what your patch does either. Instead the ACPI graph port nodes (as
> > > > per Linux specific definitions) are simply dropped, i.e. this isn't related
> > > > to DisCo for Imaging at all.
> > >
> > > So it looks like the changelog of that patch could be improved, right?
> >
> > Well, yes. The reason the function is in the file is that nearly all camera
> > related parsing is located there, not that it would be related to DisCo for
> > Imaging as such.
> 
> So IIUC the camera graph port nodes are created by default with the
> help of the firmware-supplied information, but if that is defective a
> quirk can be added to skip the creation of those ports in which case
> they will be created elsewhere.
> 
> Is this correct?

Yes.

-- 
Sakari Ailus

