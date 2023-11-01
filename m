Return-Path: <linux-acpi+bounces-1135-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BBE7DDF78
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 11:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02F152804DD
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B038311181
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Nov 2023 10:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZrklDG7A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F48763AD
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 10:05:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5FE4
	for <linux-acpi@vger.kernel.org>; Wed,  1 Nov 2023 03:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698833108; x=1730369108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r0Bm+R7YbmS62PRoV+jlCGnDIqpMi+cJ0KKL7c2Q6e0=;
  b=ZrklDG7AjuzkG/DYvLQrOKJ78EYhMUIuKYIhXZCfZwZWna3pGqzTQOc3
   NoHABvSl51vy6exAqY06IzEK2F2juCYTIUSU3JvH41c4NKx85v3rIOTcf
   HEE1Pe7Xi2EFPyzTjBysQ2QSFP+7ekHm5ivriZdjY5kSQ+oxPZqlPeunI
   CujlrCZYd22F0e8koJu3+XWubV66rtLovTNry4DflQ/epF7oGxqOo1jAW
   XGQ7ucJGkOMOlNHN7pLWAlHWefyf/aAO5/+5irW5zUydW6Nen6OAKFiUC
   H7d4/FDNjdwBFkAQWllGqBNRW5d2IE8V1pjITJePCvGX7ngh9rr6nG+ZQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="1367657"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="1367657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="877825810"
X-IronPort-AV: E=Sophos;i="6.03,267,1694761200"; 
   d="scan'208";a="877825810"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 03:05:05 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C820F1209FB;
	Wed,  1 Nov 2023 12:05:02 +0200 (EET)
Date: Wed, 1 Nov 2023 10:05:02 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/3] Make fwnode_property_get_reference_args accept NULL
 args
Message-ID: <ZUIizkjRH1OdAOBx@kekkonen.localdomain>
References: <20231101090737.1148303-1-sakari.ailus@linux.intel.com>
 <ZUIfp43KYDvpdife@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIfp43KYDvpdife@smile.fi.intel.com>

Hi Andy,

On Wed, Nov 01, 2023 at 11:51:35AM +0200, Andy Shevchenko wrote:
> On Wed, Nov 01, 2023 at 11:07:34AM +0200, Sakari Ailus wrote:
> > Hi all,
> > 
> > The of_parse_phandle_with_args() accepts NULL args but
> > fwnode_property_get_reference_args() does not currently, in its ACPI or
> > software node implementations. Fix this.
> 
> The last sentence assumes Fixes tag(s) which I can't see.

This obviously hasn't been an issue for the existing users so backporting
it has little value. From API consistency PoV this does matter though.

I can add a Fixes: tag if you like.

-- 
Sakari Ailus

