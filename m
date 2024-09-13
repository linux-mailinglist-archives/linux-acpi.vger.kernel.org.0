Return-Path: <linux-acpi+bounces-8279-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9883D977E5E
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 13:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4551F2782D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 11:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160181D6C4D;
	Fri, 13 Sep 2024 11:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1F2BcUZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C9187849;
	Fri, 13 Sep 2024 11:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226222; cv=none; b=ruILOaGhmDxqeh1WG+PAV4J5s6qd0Aiw5/TeLybNvDPpMPkL+VSZuk3Kj7NJUm7qv/F/ArtdgKbfxVout6tdd6T5z7FDUPpyMSYHTTSVjI8f0kSUlTeP23QWjEN0QIHI1tUxY7IwYjn30+TZhcPMFjdq5EWRJZj1AdRYS5iGreg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226222; c=relaxed/simple;
	bh=a6tY+mabemuCCnIb81MOFt4TNk7E2HSftu4W8h9pJYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQRokFqsH/gJEkvpfIC8xJUsDUJ+z2Cicf1OCFqoEFKrYAJkRJZCfbEA9CE0TEEuCaNTQWA3Fre9EfHfL37fpXIxO84Fpn3s63fm8RyPd/aMGJMoAmGUPABvKrQYZfYuhLW7Zd+Ta4clUrmQTbCWV8yi5mvJrTv+OVb6MB8hgCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1F2BcUZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726226220; x=1757762220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=a6tY+mabemuCCnIb81MOFt4TNk7E2HSftu4W8h9pJYI=;
  b=J1F2BcUZKJF2ElLPYdvc+MBy1TU7njDbRhiIHSpTRq47J8bsTkYbcjQU
   xkEZlG08mbzFmP6TI1mqVBkvOXPC+R58VsuxiuAiD/uPrEu4Qhmq056Wq
   u60FiTFKqZZPHJ2/lUDuDTxba7XQqyXQBabMLdemXbK1K+/yS8YTqPsC7
   zbBN26DSnTgWy+bn7XicncUqwQymhK65SZCLlimsMPfEbEoTHnt43WPkQ
   Xi3BBcM3e3klPyji30K3ItMUkit55IZiumoE+zRrGv1kkIJP7muijueyi
   TfIXhczrINPHpcReNHQghCHWS95PpmcesynbdyND6lmQGdT5TpHcOyoQI
   g==;
X-CSE-ConnectionGUID: mKF31263QJSTEOXvAPF1bg==
X-CSE-MsgGUID: P/13Tfd0TxujX0KjSqmW9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35707339"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="35707339"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:16:59 -0700
X-CSE-ConnectionGUID: flF4DfJ4SWq3qG5RM3QdbQ==
X-CSE-MsgGUID: gr36VhiBRECtxXOdc/UhnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="98713555"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 04:16:57 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id C799211F9D4;
	Fri, 13 Sep 2024 14:16:54 +0300 (EEST)
Date: Fri, 13 Sep 2024 11:16:54 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] software node: Simplify swnode_register() a bit
Message-ID: <ZuQfJifD_ZClXGpf@kekkonen.localdomain>
References: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>

On Fri, Sep 13, 2024 at 02:05:23PM +0300, Andy Shevchenko wrote:
> By introducing two temporary variables simplify swnode_register() a bit.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

