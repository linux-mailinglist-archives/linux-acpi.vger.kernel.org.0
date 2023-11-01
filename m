Return-Path: <linux-acpi+bounces-1145-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7337DE6C0
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 21:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD54BB20DAB
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215041945A
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 20:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4oaGbXL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357541B272
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 20:29:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96894C1
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698870537; x=1730406537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=DAtvdBkLN4xQmksoekQmAiDFHRQo0qpepPPevbvG+kE=;
  b=Q4oaGbXLknlB/ohWAJgVBxtIZiu8dwLnnak8HeEAwHgedpbbv2n2OzM6
   7TGxiNYCqgMvh0VMPxH9ZhepO7B3C1IDEUGxWLASXdDyYIlHMl6gfS329
   3wehqxvhToSgVaYmL7QNQIf+l4RtZYb9thmHXN2urIb5cLVUm9ujsPrTN
   rZLd+GzV5hmJ5I210irwJH+0G9Qsg7Dyb8ZZQATOxZAa2GMZhvyvQxFUD
   C2hQ4OpU0cYrZdssBy0/r4dVFP9I4ZKY9mU8g5SJ1c0vtwXVPIVjhigzt
   1LSeGCG57N7HJ4QDe/dl0WYhFT+9/gfem9JbBwYwPQrxdZOBFchsA651i
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="368783376"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="368783376"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 13:28:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="1008221261"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="1008221261"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 13:28:55 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 182A111F929;
	Wed,  1 Nov 2023 22:28:53 +0200 (EET)
Date: Wed, 1 Nov 2023 20:28:53 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL
 args
Message-ID: <ZUK1BY8Riz1ay9Ju@kekkonen.localdomain>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <ZUIfp43KYDvpdife@smile.fi.intel.com>
 <ZUIkOov2eykf0n1v@kekkonen.localdomain>
 <CAJZ5v0jDZTet5+hbCGq+Dd9SDvJ+kiepjHU-yuq+zb5_uWcwHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jDZTet5+hbCGq+Dd9SDvJ+kiepjHU-yuq+zb5_uWcwHQ@mail.gmail.com>

Hi Rafael,

On Wed, Nov 01, 2023 at 07:01:24PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 1, 2023 at 11:11 AM Sakari Ailus
> <sakari.ailus@linux.intel.com> wrote:
> >
> > On Wed, Nov 01, 2023 at 11:51:35AM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> > > > Hi all,
> > > >
> > > > The of_parse_phandle_with_args() accepts NULL args but
> > > > fwnode_property_get_reference_args() does not currently, in its ACPI or
> > > > software node implementations. Fix this.
> > >
> > > The last sentence assumes Fixes tag(s) which I can't see.
> >
> > Oops. I realised this is actually changing code added in DisCo for Imaging
> > patches. It'd be better to address this before those.
> 
> So how exactly does this affect those patches?

Not much --- the patch adding string reference support will move the
affected lines, hence the conflict. It's fairly trivial to resolve though.
I'll send v2.

-- 
Regards,

Sakari Ailus

